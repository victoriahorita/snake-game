-- Módulos e dependências
local Snake = require("src.entities.snake")
local Fruit = require("src.entities.fruit")
local Fonts = require("src.systems.fonts")
local Sounds = require("src.systems.Sounds")
local Menu = require("src.states.menu")
local Gameover = require("src.states.gameOver")

-- Variáveis globais
local larguraTela, alturaTela 
local Game = {state = "menu", score = 0}

-- Carrega os recusos
function love.load()
    larguraTela, alturaTela = love.graphics.getDimensions()
    fundo = love.graphics.newImage("assets/images/background.png")
    Fonts.load()
    Menu.load()
    Snake.load()
    Fruit.init()
    Sounds.load()
    Gameover.load()
end

-- Iniciar jogo
function Game.start()
    Game.score = 0
    Game.state = "jogando"

    local startX = larguraTela / 4
    local startY = alturaTela / 2

    Snake.init(startX, startY)
    Fruit.spawn(larguraTela, alturaTela, Snake.body, Snake.segment_size)
    
    Snake.resetDieFlag()
    Sounds.startMusic()
end

-- Função que roda a cada frame para atualizar o lógica do jogo
function love.update(dt)
    if Game.state == "jogando" then
        Fruit.update(dt)
        Snake.Move(dt)
        Snake.colide()

        if Snake.getDieFlag() then
           Game.state = "gameover"
           Sounds.playGameOver()
        end

        local fruit_pos = Fruit.getPosition()
        local fruit_width, fruit_height = Fruit.getDimensions()

        Snake.eat(fruit_pos, fruit_width, fruit_height)
        if Snake.getEatFlag() then
            Snake.grow()
            Game.score = Game.score + 1
            Fruit.spawn(larguraTela, alturaTela, Snake.body, Snake.segment_size)
            Snake.resetEatFlag()
            Sounds.playEat()
        end
    end
end

--- Função que roda a cada quadro para desenhar tudo na tela
function love.draw()
    if Game.state == "jogando" then
        if fundo then
            love.graphics.draw(fundo, 0, 0, 0, larguraTela / fundo:getWidth(), alturaTela / fundo:getHeight())
        end
    end
    
    love.graphics.setColor(1, 1, 1)  
    if Game.state == "menu" then
        Menu.draw()
    elseif Game.state == "jogando" then
        Snake.draw()
        Fruit.draw()
        love.graphics.print("Pontuação: "..Game.score, 10, 10)
    elseif Game.state == "gameover" then
        Gameover.draw(Game)
    end
end

-- Funções para verificar a entrada do usuário
function love.mousepressed(mx, my, button)
    if button ~= 1 then return end
    if Game.state == "menu" then
        Menu.mousepressed(mx, my, Game)
    elseif Game.state == "gameover" then
        Gameover.mousepressed(mx, my, Game)
    end
end

function love.keypressed(key)
    if Game.state == "jogando" then
        Snake.updateDirection(key)
    end
end
