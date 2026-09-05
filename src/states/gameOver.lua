local Fonts = require("src.systems.fonts")
local Button = require("src.ui.button")

local Gameover = {}

-- Elementos da tela
local imgFundo, imgPainelPontos
local painelPontos = {}
local tituloY = 0
local botaoReiniciar = {}
local botaoSair = {}

-- Carrega os elementos iniciais
function Gameover.load()
    imgFundo = love.graphics.newImage("assets/images/gameover1.png")
    imgPainelPontos = love.graphics.newImage("assets/images/gameoverPontuação.png")

    -- Dimensões e ajuste de escala para o tamanho dos botões
    local screenW, screenH = love.graphics.getDimensions()
    local escala = 3

    -- Painel de pontos
    painelPontos.w = imgPainelPontos:getWidth() * escala
    painelPontos.h = imgPainelPontos:getHeight() * escala
    painelPontos.x = (screenW - painelPontos.w) / 2
    
    local margens = { tituloPainel=60, painelBotoes=50, entreBotoes=20 }
    tituloY = screenH * 0.18
    painelPontos.y = tituloY + Fonts.title:getHeight() + margens.tituloPainel
    
    -- Botão de reiniciar
    botaoReiniciar.texto = "JOGAR NOVAMENTE"
    botaoReiniciar.img = love.graphics.newImage("assets/images/gameoverBotãoJogarDnv.png")
    botaoReiniciar.escala = escala
    botaoReiniciar.fonte = Fonts.button -- ALTERADO: Usa a fonte do módulo Fonts
    botaoReiniciar.w = botaoReiniciar.img:getWidth() * escala
    botaoReiniciar.h = botaoReiniciar.img:getHeight() * escala
    botaoReiniciar.x = (screenW - botaoReiniciar.w) / 2
    botaoReiniciar.y = painelPontos.y + painelPontos.h + margens.painelBotoes
    
    -- Botão de sair
    botaoSair.texto = "SAIR"
    botaoSair.img = love.graphics.newImage("assets/images/gameoverBotãoSair.png")
    botaoSair.escala = escala
    botaoSair.fonte = Fonts.button 
    botaoSair.w = botaoSair.img:getWidth() * escala
    botaoSair.h = botaoSair.img:getHeight() * escala
    botaoSair.x = (screenW - botaoSair.w) / 2
    botaoSair.y = botaoReiniciar.y + botaoReiniciar.h + margens.entreBotoes
end

-- Desenha a tela de game over
function Gameover.draw(game)
    local screenW = love.graphics.getWidth()
    
    -- Desenha as imagens do fundo
    love.graphics.draw(imgFundo, 0, 0, 0, screenW / imgFundo:getWidth(), love.graphics.getHeight() / imgFundo:getHeight())
    love.graphics.draw(imgPainelPontos, painelPontos.x, painelPontos.y, 0, 3, 3)

    -- Cor e fontes para cada botão
    love.graphics.setColor(0.15, 0.15, 0.15)
    love.graphics.setFont(Fonts.title)
    love.graphics.printf("GAME OVER", 0, tituloY, screenW, "center")

    love.graphics.setFont(Fonts.painelTitle)
    love.graphics.printf("PONTUAÇÃO FINAL", painelPontos.x, painelPontos.y + (painelPontos.h * 0.2), painelPontos.w, "center")
    
    love.graphics.setFont(Fonts.painelNumber)
    love.graphics.printf(game.score, painelPontos.x, painelPontos.y + (painelPontos.h * 0.5), painelPontos.w, "center")
    
    -- Desenha os botões
    Button.draw(botaoReiniciar)
    Button.draw(botaoSair)

end

-- Veirifica o click do mouse
function Gameover.mousepressed(mx, my, game)
    if Button.isInside(mx, my, botaoReiniciar) then
        game.start()
    elseif Button.isInside(mx, my, botaoSair) then
        love.event.quit()
    end
end

return Gameover