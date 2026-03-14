# Projeto Fase Tutorial: Space Invaders Invertido

## Estrutura de Diretórios
A organização das pastas segue as convenções recomendadas pela documentação oficial do Godot para escalabilidade, separando os arquivos por tipo e escopo:

* **/Assets**: Arquivos e mídias externas.
  * `/Audio`: Efeitos sonoros e músicas.
  * `/Fonts`: Tipografias da interface.
  * `/Sprites`: Imagens e texturas 2D.
* **/Scenes**: Cenas estruturais do Godot (`.tscn`).
  * `/Core`: Cenas fundamentais (ex: MainLevel).
  * `/Entities`: Unidades do jogo (Aliens, Nave Inimiga).
  * `/UI`: Elementos de interface (Menus, HUD, Loja).
  * `/World`: Estruturas do mapa (Grid, Cenário).
* **/Scripts**: Códigos-fonte (`.gd`).
  * Mesma subdivisão da pasta Scenes para facilitar a localização cruzada.

## Arquitetura e Padrões de Projeto
Para facilitar o trabalho em equipe, o projeto utiliza os seguintes padrões:

1. **State Management (Singletons/Autoloads):**
   * O script `GameManager.gd` opera como um nó global para gerenciar dados que devem persistir ou ser acessados frequentemente (Fase atual, Energia, Rodada).

2. **Event-Driven Architecture (Observer Pattern):**
   * O script `Events.gd` atua como uma central de emissão e escuta de sinais. 
   * *Regra de ouro:* Sistemas distintos não devem referenciar uns aos outros diretamente. Por exemplo, a Interface (UI) não altera o Mapa (World). A UI emite um sinal no `Events`, e o Mapa escuta esse sinal para reagir de acordo.