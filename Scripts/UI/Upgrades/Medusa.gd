class_name UpgradeMedusa extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 10
	one_time_use = true
	upgrade_id = "medusa"
	upgrade_num = 9
	label.text = "Medusa\nCusto: %d\nFunção: O alien atirará mais dois projéteis." % [energy_cost]

func apply_effect(target: AlienBase) -> void:
	target.has_multishot = true
	target.act_upgrades[upgrade_num-1] += 1
	popup_text = "Agora o alien possui tiro triplo!"
	print("[DEBUG] Medusa aplicado! Alien tipo ", target.type, " agora atira triplo.")
