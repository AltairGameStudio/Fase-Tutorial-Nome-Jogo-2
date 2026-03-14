extends Node

## CENTRAL DE EVENTOS
## Uso: 
## 1. Para emitir um evento: Events.alien_purchased.emit(cena_do_alien)
## 2. Para escutar um evento: Evets.alien_purchased.connect(_sua_funcao)

signal alien_purchased(alien_scene: PackedScene)
signal energy_changed(new_amount: int)
