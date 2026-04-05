extends TextureButton

func _ready() -> void:
	self.pressed.connect(_on_pressed)
	GameManager.phase_changed.connect(_on_phase_changed)

func _on_pressed() -> void:
	GameManager.start_combat_phase()

func _on_phase_changed(new_phase: GameManager.GamePhase) -> void:
	self.disabled = (new_phase == GameManager.GamePhase.COMBAT)
