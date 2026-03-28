class_name game_slot extends Control

var on_focus : bool
var timer : int = 0
var occupied : bool = false
var alien_1 = preload("res://Scenes/Entities/Alien_1.tscn")
var alien_2 = preload("res://Scenes/Entities/Alien_2.tscn")
var alien_3 = preload("res://Scenes/Entities/Alien_3.tscn")
var alien_4 = preload("res://Scenes/Entities/Alien_4.tscn")
var alien_5 = preload("res://Scenes/Entities/Alien_5.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Verifies if the dragged data can be dropped at the slot
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is AlienBase and not occupied:
		return true
	elif data is UpgradeBase and occupied:
		return true
	return false

# Handles the data drop if _can_drop_data returns true
func _drop_data(at_position: Vector2, incoming_data: Variant) -> void:	
	if incoming_data is AlienBase:
		var new: Variant
		match incoming_data.type:
			1:
				new = alien_1.instantiate()
			2:
				new = alien_2.instantiate()
			3:
				new = alien_3.instantiate()
			4:
				new = alien_4.instantiate()
			5:
				new = alien_5.instantiate()
		new.on_store = false
		occupied = true
		self.add_child(new)
		new.global_position = self.global_position + self.size/2
	else:
		pass
