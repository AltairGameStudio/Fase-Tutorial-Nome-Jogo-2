class_name EnemyShip
extends CharacterBody2D
var Placeholder = 1

## NAVE INIMIGA
@export var max_health: int = 100
@export var movement_speed: float = 150.0
@export var tiro_cooldown: float = 0.5
var current_health: int

var podeatirar= true

# valor placeholder
@export var bullet_damage = 10
@export var bullet_speed = 50

func _ready() -> void:
	current_health = max_health

## Lógica de movimentação lateral automática
func _physics_process(delta: float) -> void:
	#vai pro canto e volta pro outro
	if position.x>110: movement_speed= -2
	if position.x<0: movement_speed= 2
	position.x += movement_speed+delta

## Processa o dano recebido pelos ataques dos aliens
func take_damage(_bullet) -> void:
	current_health = current_health - bullet_damage

@export var bullet_scene = preload("res://Scenes/Entities/talvezissodetectecolisao.tscn")

func _process(_delta): 
	#cooldown de tiro
	if podeatirar:
		shoot()
		podeatirar = false
		await get_tree().create_timer(tiro_cooldown + randf() * 2).timeout 
		podeatirar = true

func shoot():
	#fazer tiro spawnar
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.position = position + Vector2(25, 10)
