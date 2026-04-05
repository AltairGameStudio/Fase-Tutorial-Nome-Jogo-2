extends Node

enum GamePhase { PLACEMENT, COMBAT }

## GERENCIADOR DE ESTADO DA PARTIDA
var current_energy: int = 10
var current_wave: int = 1
var current_phase: GamePhase = GamePhase.PLACEMENT
var combat_time: float = 0.0

signal phase_changed(new_phase: GamePhase)
signal time_changed(time_in_seconds: int)
signal wave_changed(wave: int)

func _process(delta: float) -> void:
	# Contagem de tempo apenas durante o combate
	if current_phase == GamePhase.COMBAT:
		var previous_time_int = int(combat_time)
		combat_time += delta
		var current_time_int = int(combat_time)
		
		if current_time_int > previous_time_int:
			time_changed.emit(current_time_int)

func spend_energy(amount: int) -> bool:
	if current_energy >= amount:
		current_energy -= amount
		Events.energy_changed.emit(current_energy)
		return true
	return false

func add_energy(amount: int) -> void:
	current_energy += amount
	Events.energy_changed.emit(current_energy)

func start_combat_phase() -> void:
	if current_phase == GamePhase.PLACEMENT:
		combat_time = 0.0
		current_phase = GamePhase.COMBAT
		spawn_wave(current_wave)
		phase_changed.emit(current_phase)

func end_combat_phase() -> void:
	if current_phase == GamePhase.COMBAT:
		current_phase = GamePhase.PLACEMENT
		current_wave += 1
		wave_changed.emit(current_wave) # Atualiza a UI de rodada
		phase_changed.emit(current_phase)
		
# Mantém as fases fixas iniciais
var wave_data = {
	1: ["res://Scenes/Entities/Enemies/EnemyShipBasic.tscn"],
	2: ["res://Scenes/Entities/Enemies/EnemyShipFast.tscn", 
		"res://Scenes/Entities/Enemies/EnemyShipFast.tscn"],
	3: ["res://Scenes/Entities/Enemies/EnemyShipTank.tscn"]
}

# Define o pool de naves e seus custos (strength)
var enemy_pool = [
	{"path": "res://Scenes/Entities/Enemies/EnemyShipBasic.tscn", "strength": 3},
	{"path": "res://Scenes/Entities/Enemies/EnemyShipFast.tscn", "strength": 2},
	{"path": "res://Scenes/Entities/Enemies/EnemyShipTank.tscn", "strength": 5}
]

func spawn_wave(wave_num: int) -> void:
	var enemies: Array = []
	
	# Decide se usa as fases predefinidas ou a geração aleatória
	if wave_num <= 3:
		if wave_data.has(wave_num):
			enemies = wave_data[wave_num]
	else:
		enemies = _generate_random_wave(wave_num)
		
	var offset_x = 40
	
	# Instancia as naves da lista final
	for i in range(enemies.size()):
		var path = enemies[i]
		var scene = load(path)
		if scene:
			var enemy = scene.instantiate()
			get_tree().current_scene.add_child(enemy)
			
			var start_x = 0 - (i * offset_x)
			enemy.global_position = Vector2(start_x, 160)
		else:
			printerr("ERRO: O Godot não encontrou a cena no caminho: ", path)

## Função auxiliar para gerar naves procedurais baseadas no orçamento
func _generate_random_wave(wave_num: int) -> Array:
	var generated_enemies: Array = []
	var max_strength: int = wave_num * 2
	var current_strength: int = max_strength
	
	# Continua sorteando até o orçamento acabar ou ficar negativo
	while current_strength > 0:
		# pick_random() escolhe um elemento aleatório do array automaticamente
		var random_enemy = enemy_pool.pick_random() 
		
		generated_enemies.append(random_enemy["path"])
		current_strength -= random_enemy["strength"]
		
	return generated_enemies

func check_enemy_count():
	await get_tree().process_frame
	if get_tree().get_nodes_in_group("Enemy").size() == 0:
		end_combat_phase()
