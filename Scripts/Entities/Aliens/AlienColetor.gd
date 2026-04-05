class_name AlienColetor extends AlienBase

func _ready() -> void:
	type = 2
	attack_cooldown = 5.0
	damage = 1
	super._ready()

func attack() -> void:
	GameManager.add_energy(self.damage)

func _process(delta: float) -> void:
	super._process(delta)
