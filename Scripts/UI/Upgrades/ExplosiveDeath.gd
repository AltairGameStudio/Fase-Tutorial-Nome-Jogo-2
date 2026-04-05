class_name UpgradeExplosiveDeath extends UpgradeBase

func _init() -> void:
	energy_cost = 4
	one_time_use = true
	upgrade_id = "martyr"

func apply_effect(target: AlienBase) -> void:
	target.has_explosive_death = true
	print("[DEBUG] ExplosiveDeath aplicado! Alien tipo ", target.type, " explodirá ao morrer.")
