class_name UpgradeNewHeart extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 5
	one_time_use = false
	upgrade_id = "heart"
	upgrade_num = 3
	label.text = "Novo coração\nCusto: %d\nFunção: Aumenta a vida máxima do alien." % [energy_cost]

func apply_effect(target: AlienBase) -> void:
	target.max_health += target.original_max_health
	target.current_health += target.original_max_health
	target.act_upgrades[upgrade_num-1] += 1
	popup_text = "Vida máxima atual: %d" % [target.max_health]
	print("[DEBUG] NewHeart aplicado! Nova vida máxima: ", target.max_health)
