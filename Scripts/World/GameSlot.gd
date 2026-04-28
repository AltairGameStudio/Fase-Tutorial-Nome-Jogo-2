class_name game_slot extends Control

@onready var popup_panel: Panel
@onready var popup_label: Label

var on_focus : bool
var timer : int = 0
var occupied : bool = false
var was_checked_this_frame: bool = false
var alien_1 = preload("res://Scenes/Entities/Aliens/AlienAtirador.tscn")
var alien_2 = preload("res://Scenes/Entities/Aliens/AlienColetor.tscn")
var alien_3 = preload("res://Scenes/Entities/Aliens/AlienEscudo.tscn")
var alien_4 = preload("res://Scenes/Entities/Aliens/AlienSniper.tscn")
var alien_5 = preload("res://Scenes/Entities/Aliens/Alien_5.tscn")

func _ready() -> void:
	popup_panel = get_tree().current_scene.find_child("Panel")
	popup_label = get_tree().current_scene.find_child("Panel").get_child(0)
	popup_panel.visible = false
	pass

func _process(delta: float) -> void:
	if get_viewport().gui_is_dragging():
		if not Rect2(Vector2(), size).has_point(get_local_mouse_position()):
			self.get_parent().modulate = Color(1,1,1)
	pass

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	was_checked_this_frame = true
	if not is_instance_valid(data):
		was_checked_this_frame = false
		return false

	if data is AlienBase and not occupied:
		self.get_parent().modulate = Color(1,0,0,1)
		return true
	elif data is UpgradeBase and occupied:
		var alien = _get_alien()
		if alien:
			if data.one_time_use and alien.applied_upgrades.has(data.upgrade_id):
				was_checked_this_frame = false
				return false
			self.get_parent().modulate = Color(1,0,0,1)
			return true
	was_checked_this_frame = false
	return false

func _drop_data(at_position: Vector2, incoming_data: Variant) -> void:
	self.get_parent().modulate = Color(1,1,1)
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
		if alien and alien.can_receive_upgrade(incoming_data.upgrade_num):
			if GameManager.spend_energy(incoming_data.energy_cost):
				incoming_data.apply_effect(alien)
				alien.applied_upgrades.append(incoming_data.upgrade_id)
				show_notification(get_global_mouse_position(), incoming_data.popup_text)
			else:
				print("[DEBUG] Energia insuficiente.")
		else:
			print("[DEBUG] Alien não encontrado para Upgrade ou não pode receber este upgrade.")
		incoming_data.queue_free()

func _on_alien_removed() -> void:
	occupied = false

## Função auxiliar para pegar o alien atual no slot
func _get_alien() -> AlienBase:
	for child in get_children():
		if child is AlienBase:
			return child
	return null

func show_notification(pos: Vector2, txt: String):
	popup_panel.global_position = pos
	popup_panel.visible = true
	popup_label.text = txt
	await get_tree().create_timer(1.0).timeout
	popup_panel.visible = false

func _mouse_exited():
	self.get_parent().modulate = Color(1,1,1,1)
