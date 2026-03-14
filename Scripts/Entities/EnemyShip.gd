class_name EnemyShip
extends CharacterBody2D

## Representa a nave inimiga localizada na parte inferior da tela.
## Motivo: Herda de CharacterBody2D pois precisará de física e colisões para receber dano dos aliens e se movimentar lateralmente.

@export var max_health: int = 100
@export var movement_speed: float = 150.0

var current_health: int

func _ready() -> void:
	current_health = max_health
