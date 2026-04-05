class_name AlienSniper extends AlienBase

@export var bullet_scene: PackedScene

func _ready() -> void:
	super._ready()
	type = 4
	attack_cooldown = 5.0

func attack() -> void:
	var inimigo = get_tree().get_first_node_in_group("Enemy")
	if inimigo and bullet_scene:
		var bullet = bullet_scene.instantiate() as Bullet
		# Calcula automaticamente o seno e cosseno para o alvo
		bullet.direction = self.global_position.direction_to(inimigo.global_position)
		bullet.is_enemy_bullet = false
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = self.global_position
