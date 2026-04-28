class_name UpgradeThorns extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 7
	one_time_use = true
	upgrade_id = "thorns"
	upgrade_num = 7
	label.text = "Espinhos\nCusto: %d\nFunção: O alien agora refletirá dano." % [energy_cost]

func apply_effect(target: AlienBase) -> void:
	target.has_thorns = true
	target.act_upgrades[upgrade_num-1] += 1
	popup_text = "Espinhos aplicado!"
	print("[DEBUG] Thorns aplicado! Alien tipo ", target.type, " agora reflete dano.")
