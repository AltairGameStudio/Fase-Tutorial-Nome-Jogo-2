extends EnemyBase

@export var bullet_scene = preload("res://Scenes/Entities/BulletEnemy.tscn")
@export var shoot_cooldown: float = 6.0

func _ready() -> void:
	super._ready()
	max_health = 400 # mais vida
	current_health = max_health
	movement_speed = 10.0 # mais lenta
	bullet_damage = 100 # Dano alto
	add_to_group("Enemies")


func _process(_delta: float) -> void:
	if GameManager.current_phase != GameManager.GamePhase.COMBAT: 
		return
		
	if can_shoot:
		shoot()
		can_shoot = false
		await get_tree().create_timer(shoot_cooldown + randf() * 2.0).timeout
		can_shoot = true

func shoot() -> void:
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.damage = self.bullet_damage
		bullet.piercing = true
		bullet.direction = Vector2.UP
		get_parent().add_child(bullet)
		bullet.global_position = self.global_position
