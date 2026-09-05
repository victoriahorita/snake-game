# Snake Game
Jogo 2D inspirado no clássico Snake, desenvolvido em `Lua` utilizando o framework `LÖVE`.

>O projeto foi desenvolvido em grupo na disciplina de Linguagens de Programação, com o objetivo de criar uma aplicação interativa utilizando uma linguagem que ainda não conhecíamos. O desenvolvimento envolveu o aprendizado de Lua e do framework LÖVE, além da construção da lógica e organização da aplicação.

**Conceitos utilizados:** `Organização modular` `Gerenciamento de estados` `Lógica de jogos` `Manipulação de eventos`
`Gerenciamento de recursos` `Interface gráfica` `Manipulação de áudio`

## Funcionalidades
``Movimentação da cobra`` ``Sistema de coleta de frutas`` `` Contagem de pontuação`` `` Menu inicial`` `` Tela de Game Over``
`` Efeitos sonoros`` `` Música de fundo`` `` Interface gráfica com botões`` `` Gerenciamento dos estados do jogo``

## Minha contribuição
Durante o desenvolvimento, atuei principalmente na **organização e estruturação do projeto**, além da implementação e validação de funcionalidades.

* Definição da arquitetura e estrutura inicial do projeto
* Organização e divisão das atividades entre os integrantes
* Desenvolvimento da lógica da cobra e das frutas
* Realização de testes iniciais da lógica do jogo
* Testes e validação das sprites
* Reorganização e padronização da estrutura do projeto
* Correção de bugs
* Melhorias na legibilidade e organização do código
* Ajustes finais para preparação do projeto para apresentação

## Estrutura do projeto
O projeto foi estruturado de forma modular, separando as principais responsabilidades:

- ``entities``: elementos principais do jogo, como cobra e fruta;
- ``states``: diferentes estados da aplicação, como menu e Game Over;
- ``systems``: gerenciamento de recursos, como fontes e sons;
- ``ui``: componentes da interface;
- ``assets``: recursos utilizados pelo jogo.

A organização teve como objetivo facilitar a manutenção, melhorar a legibilidade e permitir que as funcionalidades fossem desenvolvidas de forma independente.

## Como executar
### Pré-requisitos

* [Lua](https://www.lua.org/) instalado
* [LÖVE](https://love2d.org/) instalado

### Executando o projeto
1. Clone o repositório:

```bash
git clone https://github.com/victoriahorita/snake-game
cd snake-game
```

2. Execute o projeto utilizando o LÖVE:

```bash
love .
```

O jogo será iniciado em uma nova janela.

> **Observação:** os arquivos `main.lua` e `conf.lua` estão na raiz do projeto, enquanto os recursos utilizados pelo jogo estão organizados nas pastas `assets/` e `src/`.