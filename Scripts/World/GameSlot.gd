class_name game_slot extends Control

var on_focus : bool
var timer : int = 0
var occupied : bool = false
var alien_1 = preload("res://Scenes/Entities/Aliens/AlienAtirador.tscn")
var alien_2 = preload("res://Scenes/Entities/Aliens/AlienColetor.tscn")
var alien_3 = preload("res://Scenes/Entities/Aliens/AlienEscudo.tscn")
var alien_4 = preload("res://Scenes/Entities/Aliens/AlienSniper.tscn")
var alien_5 = preload("res://Scenes/Entities/Aliens/Alien_5.tscn")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if not is_instance_valid(data):
		return false
		
	if data is AlienBase and not occupied:
		return true
	elif data is UpgradeBase and occupied:
		var alien = _get_alien()
		if alien:
			if data.one_time_use and alien.applied_upgrades.has(data.upgrade_id):
				return false
			return true
	return false

func _drop_data(at_position: Vector2, incoming_data: Variant) -> void:	
	if incoming_data is AlienBase:
		if GameManager.spend_energy(incoming_data.energy_cost):
			var new: Variant
			match incoming_data.type:
				1: new = alien_1.instantiate()
				2: new = alien_2.instantiate()
				3: new = alien_3.instantiate()
				4: new = alien_4.instantiate()
				5: new = alien_5.instantiate()
			
			new.on_store = false
			occupied = true
			self.add_child(new)
			new.global_position = self.global_position + self.size/2
			
			new.tree_exited.connect(_on_alien_removed)
	elif incoming_data is UpgradeBase:
		var alien = _get_alien()
		if alien and GameManager.spend_energy(incoming_data.energy_cost):
			incoming_data.apply_effect(alien)
			alien.applied_upgrades.append(incoming_data.upgrade_id)
			incoming_data.queue_free()
		else:
			print("[DEBUG] Energia insuficiente ou Alien não encontrado para Upgrade.")

func _on_alien_removed() -> void:
	occupied = false

## Função auxiliar para pegar o alien atual no slot
func _get_alien() -> AlienBase:
	for child in get_children():
		if child is AlienBase:
			return child
	return null
