local Fruit = {} 

-- Variáveis da fruta
local pos = {x = 0, y = 0} 
local apple1, apple2 
local larguraApple, alturaApple


-- Variáveis para animação e posição
local currentApple = 1 
local animationTimer = 0.4
local timer = 0
local newX, newY
local validPosition = false

-- Inicialização
function Fruit.init()
    apple1 = love.graphics.newImage("assets/images/apple.png") 
    apple2 = love.graphics.newImage("assets/images/apple2.png") 
    pos = {x = 0, y = 0} 
end

-- Gera uma nova posição para a fruta na tela
function Fruit.spawn(screenWidth, screenHeight, snake_body, segmentSize)

    -- Calcula quantas colunas e linhas cabem na tela
    local gridW = math.floor(screenWidth / segmentSize)
    local gridH = math.floor(screenHeight / segmentSize)

    repeat
        -- Gera uma cordenada X e Y aleátoria na grade
        local randGridX = math.random(0, gridW - 1)
        local randGridY = math.random(0, gridH - 1)

        -- Converte as coordenadas da grade de volta para coordenadas da tela
        newX = randGridX * segmentSize
        newY = randGridY * segmentSize
        validPosition = true

        -- Verifica se a nova posição colide com algum segento da cobra 
        for i, segment in ipairs(snake_body) do
            if newX == segment.x and newY == segment.y then
                validPosition = false
                break
            end
        end
    until validPosition

    pos.x = newX
    pos.y = newY
end

-- Animação da fruta
function Fruit.update(dt) 
    timer = timer + dt
    if timer >= animationTimer then
        currentApple = 3 - currentApple 
        timer = 0
    end
end

-- Desenha a fruta
function Fruit.draw()
    if currentApple == 1 then
        love.graphics.draw(apple1, pos.x, pos.y)
    else
        love.graphics.draw(apple2, pos.x, pos.y)
    end
end 

-- Funções auxiliares, retornam a posição e dimensões da fruta
function Fruit.getPosition()
    return pos
end

function Fruit.getDimensions()
    return apple1:getWidth(), apple1:getHeight()
end

return Fruit 

