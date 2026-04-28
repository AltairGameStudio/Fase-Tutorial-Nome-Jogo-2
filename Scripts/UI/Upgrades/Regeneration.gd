class_name UpgradeRegen extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 8
	one_time_use = true
	upgrade_id = "regen"
	upgrade_num = 4
	var regen_val = 5
	label.text = "Regeneração\nCusto: %d\nFunção: Regenera %d de vida por segundo." % [energy_cost, regen_val]

func apply_effect(target: AlienBase) -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(func(): 
		if is_instance_valid(target) and target.current_health < target.max_health:
			target.current_health += self.regen_val
			# Impede que a vida ultrapasse o máximo original
			if target.current_health > target.max_health:
				target.current_health = target.max_health
	)
	target.add_child(timer)
	target.act_upgrades[upgrade_num-1] += 1
	popup_text = "Alien regenerando %d HP/s!" % [self.regen_val * target.act_upgrades[upgrade_num]]
	print("[DEBUG] Nanobots aplicados! Regenerando + 5 HP/s.")
