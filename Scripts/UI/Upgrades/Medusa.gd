class_name UpgradeMedusa extends UpgradeBase

func _init() -> void:
	energy_cost = 10
	one_time_use = true
	upgrade_id = "medusa"

func apply_effect(target: AlienBase) -> void:
	target.has_multishot = true
	print("[DEBUG] Medusa aplicado! Alien tipo ", target.type, " agora atira triplo.")
