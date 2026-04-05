class_name UpgradeStrength extends UpgradeBase

func _init() -> void:
	energy_cost = 6
	one_time_use = false
	upgrade_id = "strength"

func apply_effect(target: AlienBase) -> void:
	target.damage += target.original_damage
	print("[DEBUG] Strength aplicado! Novo dano: ", target.damage)
