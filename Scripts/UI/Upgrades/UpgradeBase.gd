class_name UpgradeBase
extends Control

## LABELS
@onready var panel_container: PanelContainer
@onready var label: RichTextLabel
@onready var popup_text: String

@export var energy_cost: int
@export var one_time_use: bool = false
@export var upgrade_id: String = "base_upgrade"

var on_focus: bool = false
var dragging: bool = false
var upgrade_num: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel_container = $Area2D/PanelContainer
	label = $Area2D/PanelContainer/MarginContainer/Label
	panel_container.visible = false
	label.text = ""
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
	if (not dragging):
		panel_container.visible = true
	else:
		panel_container.visible = false

func _mouse_exited() -> void:
	if dragging:
		return
	on_focus = false
	if (not dragging):
		panel_container.visible = false

func apply_effect(target: AlienBase) -> void:
	pass
