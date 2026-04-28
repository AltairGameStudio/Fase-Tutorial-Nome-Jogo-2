class_name UpgradeExplosiveDeath extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 4
	one_time_use = true
	upgrade_id = "martyr"
	upgrade_num = 8
	label.text = "Morte explosiva\nCusto: %d\nFunção: O alien explodirá ao morrer." % [energy_cost]

func apply_effect(target: AlienBase) -> void:
	target.has_explosive_death = true
	target.act_upgrades[upgrade_num-1] += 1
	print("[DEBUG] ExplosiveDeath aplicado! Alien tipo ", target.type, " explodirá ao morrer.")
	popup_text = "O alien agora é uma bomba!"
