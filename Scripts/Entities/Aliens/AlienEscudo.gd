class_name Alien3 extends AlienBase

func _ready() -> void:
	type = 3
	max_health = 500
	super._ready()
	label.text = "Alien atirador\nCusto: 2\nHabilidade: Nenhuma\nVida: %d" % [max_health]

func _process(delta: float) -> void:
	super._process(delta)
