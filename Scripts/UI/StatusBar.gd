extends HBoxContainer

@onready var energy_label: Label = $EnergyLabel
@onready var round_label: Label = $RoundLabel
@onready var time_label: Label = $TimeLabel

func _ready() -> void:
	# Inicializa os textos com os valores atuais do GameManager
	energy_label.text = "Energy:" + str(GameManager.current_energy)
	round_label.text = "Round:" + str(GameManager.current_wave)
	time_label.text = "Time:0s"
	
	# Conecta os sinais do GameManager para atualizar a UI dinamicamente
	Events.energy_changed.connect(_on_energy_changed)
	GameManager.wave_changed.connect(_on_wave_changed)
	GameManager.time_changed.connect(_on_time_changed)

func _on_energy_changed(new_amount: int) -> void:
	energy_label.text = "Energy:" + str(new_amount)

func _on_wave_changed(new_wave: int) -> void:
	round_label.text = "Round:" + str(new_wave)

func _on_time_changed(seconds: int) -> void:
	time_label.text = "Time:" + str(seconds) + "s"
