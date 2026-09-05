local Sounds = require("src.systems.Sounds")
local Fonts = require("src.systems.fonts")
local Button = require("src.ui.button")

local Menu = {}

-- Elementos do menu
local fundoMenu
local botaoIniciar = {}
local botaoSair = {}

-- Carrega os elementos iniciais
function Menu.load()
    fundoMenu = love.graphics.newImage("assets/images/menu1.png")
    
    -- Dimensões e ajuste de escala para o tamanho dos botões
    local screenW, screenH = love.graphics.getDimensions()
    local escala = 4

    -- Botão de iniciar
    botaoIniciar.texto = "INICIAR JOGO"
    botaoIniciar.img = love.graphics.newImage("assets/images/menuBotãoIniciarJogo.png")
    botaoIniciar.escala = escala
    botaoIniciar.fonte = Fonts.button
    botaoIniciar.w = botaoIniciar.img:getWidth() * escala
    botaoIniciar.h = botaoIniciar.img:getHeight() * escala
    botaoIniciar.x = (screenW - botaoIniciar.w) / 2
    botaoIniciar.y = screenH * 0.55 - 50
    
    -- Botão de sair
    botaoSair.texto = "SAIR"
    botaoSair.img = love.graphics.newImage("assets/images/menuBotãoSair.png")
    botaoSair.escala = escala
    botaoSair.fonte = Fonts.button
    botaoSair.w = botaoSair.img:getWidth() * escala
    botaoSair.h = botaoSair.img:getHeight() * escala
    botaoSair.x = (screenW - botaoSair.w) / 2
    botaoSair.y = botaoIniciar.y + botaoIniciar.h + 40
end

-- Desenha a tela de menu
function Menu.draw()
    local screenW, screenH = love.graphics.getDimensions()
    love.graphics.draw(fundoMenu, 0, 0, 0, screenW / fundoMenu:getWidth(), screenH / fundoMenu:getHeight())

    -- Cor e fontes para os botões
    love.graphics.setColor(0.15, 0.15, 0.15)
    love.graphics.setFont(Fonts.menuTitle)
    love.graphics.printf("SNAKE GAME", 0, screenH * 0.25, screenW, "center")
    
    -- Desenha os botões 
    Button.draw(botaoIniciar)
    Button.draw(botaoSair)
end

-- Verifica aonde foi o click
function Menu.mousepressed(mx, my, game)
    if Button.isInside(mx, my, botaoIniciar) then
        Sounds.playMenuSelect()
        game.start()
    elseif Button.isInside(mx, my, botaoSair) then
        Sounds.playMenuSelect()
        love.event.quit()
    end
end

return Menu