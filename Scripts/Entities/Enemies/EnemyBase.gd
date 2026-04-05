class_name EnemyBase extends CharacterBody2D

@export var max_health: int = 20
@export var movement_speed: float = 25.0
@export var bullet_damage: int = 10
@export var ship_width = 16
@export var initial_shoot_delay: float = 2.0 # NOVO: Tempo de espera antes do 1º tiro

var can_shoot: bool
var current_health: int

func _ready() -> void:
	add_to_group("Enemy")
	current_health = max_health
	
	if GameManager.current_phase == GameManager.GamePhase.COMBAT:
		_start_initial_cooldown()
	else:
		GameManager.phase_changed.connect(_on_phase_changed)

func _on_phase_changed(new_phase: GameManager.GamePhase) -> void:
	if new_phase == GameManager.GamePhase.COMBAT:
		_start_initial_cooldown()

func _start_initial_cooldown() -> void:
	await get_tree().create_timer(initial_shoot_delay + randf()).timeout
	can_shoot = true

func _physics_process(delta: float) -> void:
	if GameManager.current_phase != GameManager.GamePhase.COMBAT: return

	if has_node("Sprite2D"):
		ship_width = $Sprite2D.get_rect().size.x * scale.x

	var limit_min = 4
	var limit_max = 156 - ship_width
	
	if position.x > limit_max:
		movement_speed = -abs(movement_speed)
	elif position.x < limit_min:
		movement_speed = abs(movement_speed)
		
	position.x += movement_speed * delta

func take_damage(amount: int) -> void:
	current_health -= amount
	flash_damage()
	if current_health <= 0: die()

func die() -> void:
	# Notifica o GameManager antes de sumir
	GameManager.check_enemy_count()
	queue_free()


# Aviso visual de dano
var hit_flash_time := 0.1
var is_flashing := false

func flash_damage() -> void:
	if is_flashing:
		return
	
	is_flashing = true
	modulate = Color(1, 0, 0)
	
	await get_tree().create_timer(hit_flash_time).timeout
	
	modulate = Color(1, 1, 1) 
	is_flashing = false
