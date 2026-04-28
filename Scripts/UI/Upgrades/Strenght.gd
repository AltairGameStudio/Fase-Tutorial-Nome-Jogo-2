class_name UpgradeStrength extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 6
	one_time_use = false
	upgrade_id = "strength"
	upgrade_num = 6
	label.text = "Força\nCusto: %d\nFunção: Aumenta o dano do alien com base no seu dano original." % [energy_cost]

func apply_effect(target: AlienBase) -> void:
	target.damage += target.original_damage
	target.act_upgrades[upgrade_num-1] += 1
	popup_text = "Adicionado %d de dano ao alien!" % [target.original_damage]
	print("[DEBUG] Strength aplicado! Novo dano: ", target.damage)
