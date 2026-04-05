class_name UpgradeNewHeart extends UpgradeBase

func _init() -> void:
	energy_cost = 5
	one_time_use = false
	upgrade_id = "heart"

func apply_effect(target: AlienBase) -> void:
	target.max_health += target.original_max_health
	target.current_health += target.original_max_health
	print("[DEBUG] NewHeart aplicado! Nova vida máxima: ", target.max_health)
