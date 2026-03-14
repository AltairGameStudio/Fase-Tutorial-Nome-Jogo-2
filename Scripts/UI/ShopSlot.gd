class_name ShopSlot
extends Button

## Componente de interface responsável por um item comprável na loja.
## Motivo: Ao exportar 'alien_scene', você pode criar vários botões no editor do Godot 
## e simplesmente arrastar a cena de diferentes aliens para o Inspetor de Propriedades, 
## sem precisar reescrever o código do botão.

@export var alien_scene: PackedScene
@export var alien_cost: int = 2
