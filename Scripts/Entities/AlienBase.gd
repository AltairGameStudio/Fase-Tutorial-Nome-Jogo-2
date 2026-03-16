class_name AlienBase
extends Node2D

## CLASSE BASE PARA ALIENÍGENAS
@export var max_health: int = 10
@export var energy_cost: int = 2
@export var damage: int = 1

var current_health: int

func _ready() -> void:
	current_health = max_health

## Subtrai o dano recebido da vida atual
func take_damage(amount: int) -> void:
	pass

## Executa a lógica de ataque (ex: instanciar um projétil ou aplicar dano direto)
func attack() -> void:
	pass
