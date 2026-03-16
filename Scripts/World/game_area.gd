extends Control

## GERENCIADOR DA ÁREA DE JOGO E GRID
## Controla o mapa principal, receber interações do mouse e alocar entidades no grid.
@onready var tilemap_layer = $TileMapLayer

func _ready() -> void:
	pass

## Verifica se o item arrastado pode ser solto nas coordenadas atuais.
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	# 1. Converter at_position para coordenada do tilemap.
	# 2. Verificar se a célula correspondente está vazia.
	return false

## Executa a ação ao soltar o item arrastado em um local válido.
func _drop_data(at_position: Vector2, data: Variant) -> void:
	# 1. Obter a cena do alien através do parâmetro 'data'.
	# 2. Chamar GameManager.spend_energy().
	# 3. Instanciar a cena na posição correta do grid.
	pass
