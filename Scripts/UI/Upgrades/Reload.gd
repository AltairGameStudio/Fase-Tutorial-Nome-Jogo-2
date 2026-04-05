class_name UpgradeReload extends UpgradeBase

func _init() -> void:
	energy_cost = 6
	one_time_use = true
	upgrade_id = "reload"

func apply_effect(target: AlienBase) -> void:
	if "attack_cooldown" in target:
		target.attack_cooldown *= 0.8
		print("[DEBUG] Reload aplicado! Novo cooldown: ", target.attack_cooldown)
	else:
		print("[DEBUG] Falha: Alien alvo não possui attack_cooldown.")
