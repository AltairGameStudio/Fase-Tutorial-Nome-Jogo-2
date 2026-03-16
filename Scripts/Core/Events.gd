extends Node

## CENTRAL DE EVENTOS
## Uso: 
## 1. Emitir: Events.alien_purchased.emit(cena_do_alien)
## 2. Escutar: Events.alien_purchased.connect(_sua_funcao)

signal alien_purchased(alien_scene: PackedScene)
signal energy_changed(new_amount: int)
signal wave_changed(new_wave: int)
