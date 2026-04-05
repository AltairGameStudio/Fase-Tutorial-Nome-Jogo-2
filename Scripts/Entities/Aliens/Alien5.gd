class_name AlienEscudo extends AlienBase

func _ready() -> void:
	super._ready()
	type = 3
	max_health = 500 # Vida maior
	current_health = max_health

func attack() -> void:
	pass # Não faz nada, apenas absorve dano
