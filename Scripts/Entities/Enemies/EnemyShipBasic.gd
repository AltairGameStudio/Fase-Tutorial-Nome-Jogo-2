extends EnemyBase

@export var bullet_scene = preload("res://Scenes/Entities/BulletEnemy.tscn")
@export var shoot_cooldown: float = 2.0

func _ready() -> void:
	add_to_group("Enemies")

func _process(_delta: float) -> void:
	if GameManager.current_phase != GameManager.GamePhase.COMBAT: 
		return
	
	if can_shoot:
		shoot()
		can_shoot = false
		await get_tree().create_timer(shoot_cooldown + randf() * 1.5).timeout
		can_shoot = true

func shoot() -> void:
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.damage = self.bullet_damage
		bullet.direction = Vector2.UP
		get_parent().add_child(bullet)
		bullet.global_position = self.global_position
