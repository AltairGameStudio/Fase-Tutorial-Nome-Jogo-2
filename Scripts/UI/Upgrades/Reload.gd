class_name UpgradeReload extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 6
	one_time_use = true
	upgrade_id = "reload"
	upgrade_num = 5
	var new_reload = 0.8
	label.text = "Recarga\nCusto: %d\nFunção: Diminui o cooldown dos tiros do alien em %.1f %%." % [energy_cost, (1-new_reload)*10]

func apply_effect(target: AlienBase) -> void:
	if "attack_cooldown" in target:
		target.attack_cooldown *= self.new_reload
		target.act_upgrades[upgrade_num-1] += 1
		popup_text = "Novo tempo de recarga: %.3fs" % [target.attack_cooldown]
		print("[DEBUG] Reload aplicado! Novo cooldown: ", target.attack_cooldown)
	else:
		print("[DEBUG] Falha: Alien alvo não possui attack_cooldown.")
