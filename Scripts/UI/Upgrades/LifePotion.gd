class_name UpgradeLifePotion extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 3
	one_time_use = false
	upgrade_id = "potion"
	upgrade_num = 1
	label.text = "Poção de vida\nCusto: %d\nFunção: Recupera a vida do alien ao máximo." % [energy_cost]

func apply_effect(target: AlienBase) -> void:
	target.current_health = target.max_health
	target.act_upgrades[upgrade_num-1] += 1
	popup_text = "Vida restaurada!"
	print("[DEBUG] LifePotion aplicado! Vida restaurada para: ", target.current_health)
