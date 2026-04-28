extends EnemyBase

@export var bullet_scene = preload("res://Scenes/Entities/BulletEnemy.tscn")
var is_bursting: bool = false

func _ready() -> void:
	super._ready()
	max_health = 40
	current_health = max_health
	movement_speed = 80.0 
	add_to_group("Enemies")


func _process(_delta: float) -> void:
	await get_tree().create_timer(initial_shoot_delay + randf()).timeout
	if GameManager.current_phase == GameManager.GamePhase.COMBAT:
		if not is_bursting:
			is_bursting = true
			_handle_burst_fire()

func _handle_burst_fire() -> void:
	movement_speed = 0

	for i in range(5):
		shoot()
		await get_tree().create_timer(0.2).timeout
	
	# Volta a se mover
	movement_speed = 80.0
	await get_tree().create_timer(4.5 + randf() * 1.0).timeout
	
	is_bursting = false

func shoot() -> void:
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.damage = self.bullet_damage
		bullet.direction = Vector2.UP 
		get_parent().add_child(bullet)
		bullet.global_position = self.global_position
