local Button = {}

-- Verifica se o click foi dentro do botão
function Button.isInside(mx, my, botao)
    return mx > botao.x and mx < botao.x + botao.w and
           my > botao.y and my < botao.y + botao.h
end

-- Desenhar um botão com imagem, escala e texto
function Button.draw(botao)
    -- Calcula o centro do botão na tela para posicionamento
    local centerX = botao.x + (botao.w / 2)
    local centerY = botao.y + (botao.h / 2)

    -- Calcula a origem da imagem original para escalar a partir do centro
    local originX = botao.img:getWidth() / 2
    local originY = botao.img:getHeight() / 2
    
    -- Desenha a imagem do botão
    love.graphics.setColor(1, 1, 1)  
    love.graphics.draw(botao.img, centerX, centerY, 0, botao.escala, botao.escala, originX, originY)

    -- Desenha o texto do botão
    love.graphics.setColor(0.15, 0.15, 0.15)
    love.graphics.setFont(botao.fonte)
    love.graphics.printf(botao.texto, botao.x, centerY - (botao.fonte:getHeight() / 2), botao.w, "center")
    
end

return Button