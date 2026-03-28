extends Node2D

var bullet_velocity= Vector2.ZERO
@export var bullet_speed=3

# Called when the node enters the scene tree for the first time.
func _ready():
	#velocidade do tiro
	bullet_velocity = Vector2.UP*bullet_speed
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += bullet_velocity*delta 
	
	#quando sai da tela desaparece
	if position.distance_to(Vector2.ZERO) > 640:
		queue_free()
