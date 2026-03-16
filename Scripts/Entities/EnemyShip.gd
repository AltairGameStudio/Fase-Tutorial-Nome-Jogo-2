class_name EnemyShip
extends CharacterBody2D

## NAVE INIMIGA
@export var max_health: int = 100
@export var movement_speed: float = 150.0

var current_health: int

func _ready() -> void:
	current_health = max_health

## Lógica de movimentação lateral automática
func _physics_process(delta: float) -> void:
	pass

## Processa o dano recebido pelos ataques dos aliens
func take_damage(amount: int) -> void:
	pass
