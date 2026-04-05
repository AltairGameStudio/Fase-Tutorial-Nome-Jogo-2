class_name UpgradeLifePotion extends UpgradeBase

func _init() -> void:
	energy_cost = 3
	one_time_use = false
	upgrade_id = "potion"

func apply_effect(target: AlienBase) -> void:
	target.current_health = target.max_health
	print("[DEBUG] LifePotion aplicado! Vida restaurada para: ", target.current_health)
