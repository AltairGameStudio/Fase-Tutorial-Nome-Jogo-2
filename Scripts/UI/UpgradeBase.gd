class_name UpgradeBase extends Control

var on_focus: bool = false
var dragging: bool = false
var energy_cost : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and on_focus:
		if event.is_pressed():
			if !dragging:
				get_parent().add_child(self.duplicate())
				dragging = true
				force_drag(self, self)
		if event.is_released():
			if dragging:
				queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position()
	pass

func _mouse_entered() -> void:
	on_focus = true

func _mouse_exited() -> void:
	if dragging:
		return
	on_focus = false
