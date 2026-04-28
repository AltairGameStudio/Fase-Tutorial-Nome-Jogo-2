class_name AlienBase
extends Control

## LABEL
#@export_multiline var text : String
@onready var panel_container = $Area2D/PanelContainer
@onready var label = $Area2D/PanelContainer/MarginContainer/Label

## CLASSE BASE PARA ALIENÍGENAS
@export var max_health: int = 10
@export var energy_cost: int = 2
@export var damage: int = 1
@export var attack_cooldown: float = 1.0
var current_health: int
var type: int = 0
var dragging: bool = false
var on_store: bool = true
var on_focus: bool = false
var attack_timer: float = 0.0

# Para Upgrades
var original_max_health: int
var original_damage: int
var is_invulnerable: bool = false
var has_multishot: bool = false
var has_thorns: bool = false
var has_explosive_death: bool = false
var applied_upgrades: Array[String] = []
var act_upgrades: Array[int] = [0,0,0,0,0,0,0,0,0]

func _ready() -> void:
	current_health = max_health
	original_max_health = max_health
	original_damage = damage
	panel_container.visible = false
	label.text = ""

func take_damage(amount: int) -> void:
	if is_invulnerable or on_store:
		return
	
	current_health -= amount
	flash_damage()
	
	# Lógica do Thorns
	if has_thorns:
		var enemies = get_tree().get_nodes_in_group("Enemy")
		for enemy in enemies:
			if is_instance_valid(enemy) and abs(enemy.global_position.x - self.global_position.x) < 20:
				enemy.take_damage(int(amount * 0.5))
				break 

	if current_health <= 0:
		die()

func attack() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and on_focus:
		if event.is_pressed():
			
			if !dragging:
				get_parent().add_child(self.duplicate())
				dragging = true
				force_drag(self, self)
		if event.is_released():
			if dragging:
				queue_free()

func die() -> void:
	if has_explosive_death:
		var enemies = get_tree().get_nodes_in_group("Enemy")
		for enemy in enemies:
			if is_instance_valid(enemy) and self.global_position.distance_to(enemy.global_position) < 50:
				enemy.take_damage(30)
	queue_free()

func _process(delta: float) -> void:
	if on_store:
		if dragging:
			global_position = get_global_mouse_position()
	elif GameManager.current_phase == GameManager.GamePhase.COMBAT:
		attack_timer += delta
		if attack_timer >= attack_cooldown:
			attack()
			attack_timer = 0.0

func _mouse_entered() -> void:
	if on_store:
		on_focus = true
	if (not dragging):
		panel_container.visible = true
	else:
		panel_container.visible = false

func _mouse_exited() -> void:
	if dragging:
		return
	on_focus = false
	if (not dragging):
		panel_container.visible = false

# Aviso visual de dano
var hit_flash_time := 0.1
var is_flashing := false

func flash_damage() -> void:
	if is_flashing:
		return
	
	is_flashing = true
	modulate = Color(1, 0, 0)
	
	await get_tree().create_timer(hit_flash_time).timeout
	
	modulate = Color(1, 1, 1) 
	is_flashing = false

func can_receive_upgrade(upgrade_num: int) -> bool:
	if (upgrade_num == 1):
		if (current_health != max_health): 
			return true
		else:
			print("[DEBUG] VIDA DO ALIEN ESTÁ NO MÁXIMO.")
	elif (upgrade_num == 2):
		if (not self.is_invulnerable): 
			return true
		else:
			print("[DEBUG] ALIEN JÁ ESTÁ IVULNERÁVEL.")
	elif (upgrade_num in [5, 6, 9]):
		if (type in [1,4]):
			if (upgrade_num == 9 and act_upgrades[upgrade_num-1] == 1):
				return false
			return true
		else:
			print("[DEBUG] ALIEN NÃO ACEITA ESTE UPGRADE.")
	elif (upgrade_num in [7, 8]):
		if ((act_upgrades[upgrade_num-1] == 0)):
			return true
		else:
			print("[DEBUG] ALIEN JÁ POSSUÍ ESTE UPGRADE.")
	elif (upgrade_num in [3, 4, 10]): 
		return true
	return false
