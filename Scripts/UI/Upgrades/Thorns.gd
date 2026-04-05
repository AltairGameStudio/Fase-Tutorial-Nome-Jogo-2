class_name UpgradeThorns extends UpgradeBase

func _init() -> void:
	energy_cost = 7
	one_time_use = true
	upgrade_id = "thorns"

func apply_effect(target: AlienBase) -> void:
	target.has_thorns = true
	print("[DEBUG] Thorns aplicado! Alien tipo ", target.type, " agora reflete dano.")
