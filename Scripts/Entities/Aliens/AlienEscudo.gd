class_name Alien3 extends AlienBase

func _ready() -> void:
	type = 3
	max_health = 500
	super._ready()

func _process(delta: float) -> void:
	super._process(delta)
