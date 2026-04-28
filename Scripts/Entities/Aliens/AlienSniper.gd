class_name AlienSniper extends AlienBase

@export var bullet_scene : PackedScene

func _ready() -> void:
	type = 4
	attack_cooldown = 5.0
	damage = 50
	bullet_scene = load("res://Scenes/Entities/BulletAlien.tscn")
	super._ready()
	label.text = "Alien sniper\nCusto: 2\nHabilidade: Atira no inimigo\nVida: %d\nDano: %d\nCooldown: %ds" % [max_health, damage, attack_cooldown]

func _process(delta: float) -> void:
	super._process(delta)
	var inimigo = get_tree().get_first_node_in_group("Enemies")
	if (inimigo and not on_store):
		var pos = self.global_position
		var angle = pos.direction_to(Vector2.DOWN + pos).angle_to(pos.direction_to(inimigo.global_position))
		self.rotation = angle
	else:
		self.rotation = 0

func attack() -> void:
	var inimigo = get_tree().get_first_node_in_group("Enemies")
	if (inimigo and bullet_scene):
		var bullet = bullet_scene.instantiate() as Bullet
		bullet.damage = self.damage
		# Calcula automaticamente o seno e cosseno para o alvo
		bullet.direction = self.global_position.direction_to(inimigo.global_position)
		#bullet.is_enemy_bullet = false
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = self.global_position
		if has_multishot:
			var l_bullet = bullet.duplicate()
			l_bullet.direction = bullet.direction.rotated(deg_to_rad(-10.0))
			get_tree().current_scene.add_child(l_bullet)
			l_bullet.global_position = self.global_position
			var r_bullet = bullet.duplicate()
			r_bullet.direction += bullet.direction.rotated(deg_to_rad(10.0))
			get_tree().current_scene.add_child(r_bullet)
			r_bullet.global_position = self.global_position
