extends Node

## GERENCIADOR DE ESTADO DA PARTIDA
var current_energy: int = 10
var current_wave: int = 1

## Deduz o custo da energia e emite o sinal correspondente se houver saldo.
## Retorna 'true' se a transação for bem sucedida.
func spend_energy(amount: int) -> bool:
	if current_energy >= amount:
		current_energy -= amount
		Events.energy_changed.emit(current_energy)
		
		return true
	return false
