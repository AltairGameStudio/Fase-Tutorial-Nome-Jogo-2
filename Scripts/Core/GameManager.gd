extends Node

## Gerenciador global de recursos e estado da partida.
## Motivo: Como um Autoload (Singleton), este script estará sempre ativo. 
## Qualquer outro script poderá acessá-lo globalmente (ex: GameManager.current_energy) 
## sem precisar de referências complexas na árvore de nós.

var current_energy: int = 10
var current_wave: int = 1
