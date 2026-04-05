class_name Bullet extends Area2D

var speed: float = 300.0
var damage: int = 10
var direction: Vector2 = Vector2.DOWN
var piercing: bool = false # Define se a bala transpassa

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	self.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

## Para colisões com os Aliens
func _on_area_entered(area: Area2D) -> void:
	var pai = area.get_parent()
	if pai != null and pai.has_method("take_damage"):
		pai.take_damage(damage)
		
		# Só destrói a bala se não for perfurante
		if not piercing:
			queue_free()

## Para colisões com a Nave Inimiga
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		
		if not piercing:
			queue_free()
