extends Control

## PAINEL DE STATUS E MELHORIAS
## Refletir o estado atual do jogo na tela.

@onready var energy_label = $EnergyLabel
@onready var wave_label = $WaveLabel

func _ready() -> void:
	# Conectar sinais para UI reativa
	Events.energy_changed.connect(_on_energy_changed)
	Events.wave_changed.connect(_on_wave_changed)
	
	# Forçar a primeira atualização visual lendo diretamente do GameManager
	_on_energy_changed(GameManager.current_energy)

## Atualiza o texto do componente visual responsável pela energia.
func _on_energy_changed(new_amount: int) -> void:
	pass

## Atualiza o texto do componente visual responsável pelo número da rodada.
func _on_wave_changed(new_wave: int) -> void:
	pass
