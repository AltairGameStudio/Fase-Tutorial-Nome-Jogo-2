class_name AlienAtirador extends AlienBase

@export var bullet_scene = preload("res://Scenes/Entities/BulletAlien.tscn")

func _ready() -> void:
	type = 1
	attack_cooldown = 1.5
	damage = 10
	super._ready()
	label.text = "Alien atirador\nCusto: 2\nHabilidade: Atira para frente\nVida: %d\nDano: %d\nCooldown: %ds" % [max_health, damage, attack_cooldown]

func attack() -> void:
	if bullet_scene:
		_spawn_bullet(0.0) # Tiro central
		
		if has_multishot:
			_spawn_bullet(deg_to_rad(-10.0)) # Tiro inclinado para a esquerda
			_spawn_bullet(deg_to_rad(10.0))  # Tiro inclinado para a direita

func _spawn_bullet(angle_offset: float) -> void:
	var bullet = bullet_scene.instantiate() as Bullet
	bullet.damage = self.damage
	
	# Vector2.UP rotacionado pelo offset do ângulo
	bullet.direction = Vector2.DOWN.rotated(angle_offset)
	
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = self.global_position
