class_name AlienBase
extends Node2D

## Classe base para todos os alienígenas do jogo.
## Motivo: Concentrar os atributos que todo alien compartilha evita repetição de código.
## Vocês devem herdar desta classe para criar aliens específicos (ex: AlienAtirador).

@export var max_health: int = 10
@export var energy_cost: int = 2
@export var damage: int = 1

var current_health: int

func _ready() -> void:
	current_health = max_health
