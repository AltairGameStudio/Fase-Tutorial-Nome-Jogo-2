class_name UpgradeRegen extends UpgradeBase

func _init() -> void:
	energy_cost = 8
	one_time_use = true
	upgrade_id = "regen"

func apply_effect(target: AlienBase) -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(func(): 
		if is_instance_valid(target) and target.current_health < target.max_health:
			target.current_health += 5
			# Impede que a vida ultrapasse o máximo original
			if target.current_health > target.max_health:
				target.current_health = target.max_health
	)
	target.add_child(timer)
	print("[DEBUG] Nanobots aplicados! Regenerando 5 HP/s.")
