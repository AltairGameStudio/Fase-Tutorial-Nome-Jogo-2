class_name KillAlien extends UpgradeBase

func _ready() -> void:
	super._ready()
	energy_cost = 0
	one_time_use = true
	upgrade_id = "kill"
	upgrade_num = 10
	label.text = "Matar alien\nCusto: %d\nFunção: remove o alien e retorna a energia gasta proporcional a vida atual do alien." % [energy_cost]
	
func apply_effect(target: AlienBase) -> void:
	var return_energy = int(target.energy_cost * target.current_health/target.max_health)
	print("[DEBUG] Alien morto! Alien tipo ", target.type, " agora não existe mais.")
	print("[DEBUG] Energia recuperada: ", return_energy)
	GameManager.add_energy(return_energy)
	popup_text = "Alien removido e %d de energia recuperada" % [return_energy]
	target.die()
