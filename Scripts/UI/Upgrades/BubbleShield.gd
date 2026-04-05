class_name UpgradeBubbleShield extends UpgradeBase

func _init() -> void:
	energy_cost = 8
	one_time_use = false
	upgrade_id = "shield"

func apply_effect(target: AlienBase) -> void:
	target.is_invulnerable = true
	var timer = Timer.new()
	timer.wait_time = 4.0
	timer.one_shot = true
	timer.timeout.connect(func(): 
		if is_instance_valid(target): target.is_invulnerable = false
		timer.queue_free()
		print("[DEBUG] BubbleShield expirou no alien tipo ", target.type)
	)
	target.add_child(timer)
	timer.start()
	print("[DEBUG] BubbleShield aplicado! Alien tipo ", target.type, " invulnerável por 4s.")
