class_name AlienBase
extends Control

## CLASSE BASE PARA ALIENÍGENAS
@export var max_health: int = 10
@export var energy_cost: int = 2
@export var damage: int = 1
var current_health: int
var type: int = 0
var dragging: bool = false
var on_store: bool = true
var on_focus: bool = false

func _ready() -> void:
	current_health = max_health

## Subtrai o dano recebido da vida atual
func take_damage(amount: int) -> void:
	pass

## Executa a lógica de ataque (ex: instanciar um projétil ou aplicar dano direto)
func attack() -> void:
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

func _process(delta: float) -> void:
	if on_store:
		if dragging:
			global_position = get_global_mouse_position()
	else:
		attack()
	pass

func _mouse_entered() -> void:
	if on_store:
		on_focus = true

func _mouse_exited() -> void:
	if dragging:
		return
	on_focus = false
