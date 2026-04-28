class_name UpgradeBubbleShield extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 8
	one_time_use = false
	upgrade_id = "shield"
	upgrade_num = 2
	var shield_time = 4.0
	label.text = "Escudo de bolha\nCusto: %d\nFunção: Dá ao alien um escudo de %.2f." % [energy_cost, shield_time]

func apply_effect(target: AlienBase) -> void:
	var timer = Timer.new()
	timer.wait_time = self.shield_time
	timer.one_shot = true
	timer.timeout.connect(func(): 
		if is_instance_valid(target): target.is_invulnerable = false
		timer.queue_free()
		target.act_upgrades[upgrade_num-1] -= 1
		print("[DEBUG] BubbleShield expirou no alien tipo ", target.type)
	)
	target.is_invulnerable = true
	target.add_child(timer)
	timer.start()
	target.act_upgrades[upgrade_num] += 1
	popup_text = "Alien protegido por %.1fs" % [self.shield_time]
	print("[DEBUG] BubbleShield aplicado! Alien tipo ", target.type, " invulnerável por 4s.")
