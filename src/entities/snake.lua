local Snake = {}

-- Variáveis para os sprites
local headSprites = {}
local bodySprites = {}
local cornerSprites = {}
local tailSprites = {}
local fundo = nil 
local larguraTela, alturaTela 

-- Variáveis para animação da cabeça
local tempoTroca = 0
local intervaloTroca = 0.5
local frameAtual = 1
local mostrarPrimeiro = true

-- Variáveis da cobra 
Snake.body = {}
Snake.direction = 'right'
Snake.timer = 0
Snake.moveInterval = 0.2 
Snake.segment_size = 33
Snake.dieFlag = false
Snake.eatFlag = false

-- Carrega as imagens da cobra
function Snake.load()
    -- Imagens da cabeça
    headSprites.right = love.graphics.newImage("assets/images/head1D.png")
    headSprites.left = love.graphics.newImage("assets/images/head1E.png")
    headSprites.up = love.graphics.newImage("assets/images/head1C.png")
    headSprites.down = love.graphics.newImage("assets/images/head1B.png")

    headSprites.right2 = love.graphics.newImage("assets/images/head2D.png")
    headSprites.left2  = love.graphics.newImage("assets/images/head2E.png")
    headSprites.up2    = love.graphics.newImage("assets/images/head2C.png")
    headSprites.down2  = love.graphics.newImage("assets/images/head2B.png")

    headSprites.right3 = love.graphics.newImage("assets/images/head3D.png")
    headSprites.left3  = love.graphics.newImage("assets/images/head3E.png")
    headSprites.up3    = love.graphics.newImage("assets/images/head3C.png")
    headSprites.down3  = love.graphics.newImage("assets/images/head3B.png")

    -- Imagens do corpo reto
    bodySprites.horizontal = love.graphics.newImage("assets/images/corpoE-D.png")
    bodySprites.vertical = love.graphics.newImage("assets/images/corpoC-B.png")

    -- Imagens dos cantos
    cornerSprites.up_right = love.graphics.newImage("assets/images/corpoC-D.png")
    cornerSprites.right_down = love.graphics.newImage("assets/images/corpoB-D.png")
    cornerSprites.down_left = love.graphics.newImage("assets/images/corpoB-E.png")
    cornerSprites.left_up = love.graphics.newImage("assets/images/corpoC-E.png")

    -- Imagens da cauda
    tailSprites.right = love.graphics.newImage("assets/images/raboD.png")
    tailSprites.left = love.graphics.newImage("assets/images/raboE.png")
    tailSprites.up = love.graphics.newImage("assets/images/rabocima.png")
    tailSprites.down = love.graphics.newImage("assets/images/rabobaixo.png")

    larguraTela, alturaTela = love.graphics.getDimensions()
end

-- Inicializa a cobra baseado nas cordenadas X e Y
function Snake.init(startX, startY)
    Snake.body = {
        {x = startX, y = startY},
        {x = startX - Snake.segment_size, y = startY}, 
        {x = startX - (2 * Snake.segment_size), y = startY} 
    }
    Snake.direction = 'right'
    Snake.timer = 0
    Snake.dieFlag = false
    Snake.eatFlag = false
end

-- Função auxiliar para atualizar a direção, apenas se for uma direção válida
-- Impede que a cobra vire 180 graus e colida no próprio corpo
function Snake.updateDirection(key)
    if key == 'left' and Snake.direction ~= "right" then Snake.direction = "left" 
    elseif key == 'right' and Snake.direction ~= "left" then Snake.direction = "right" 
    elseif key == 'up' and Snake.direction ~= "down" then Snake.direction = "up" 
    elseif key == 'down' and Snake.direction ~= "up" then Snake.direction = "down" 
    end 
end 

-- Movimentação
function Snake.Move(dt)
    Snake.timer = Snake.timer + dt
    if Snake.timer >= Snake.moveInterval then
        local head = Snake.body[1]

         -- Começa com a posição atual da cabeça
        local newHead = {x = head.x, y = head.y}

        -- Calcula a nova posição da cabeça com base na direção atual
        if Snake.direction == 'right' then newHead.x = newHead.x + Snake.segment_size
        elseif Snake.direction == 'left' then newHead.x = newHead.x - Snake.segment_size
        elseif Snake.direction == 'up' then newHead.y = newHead.y - Snake.segment_size
        elseif Snake.direction == 'down' then newHead.y = newHead.y + Snake.segment_size 
        end

        -- Insere a nova cabeça no início da tabela
        table.insert(Snake.body, 1, newHead)
        -- Remove o último segmento para simular o movimento 
        table.remove(Snake.body)
        Snake.timer = 0
    end

    -- Lógica para a animação
    tempoTroca = tempoTroca + dt
    if tempoTroca >= intervaloTroca then
        frameAtual = frameAtual + 1
        if frameAtual > 3 then frameAtual = 1 end
        tempoTroca = 0
    end
end

-- Função auxiliar para verificar a colisão entre dois retângulos
function checkRectCollision(r1, r2)
    return r1.x < r2.x + r2.w and
           r1.x + r1.w > r2.x and
           r1.y < r2.y + r2.h and
           r1.y + r1.h > r2.y
end

--  Verifica as colisões da cobra
function Snake.colide()
    local head = Snake.body[1]

    -- Colisão com as bordas da tela
    if head.x < 0 or (head.x + Snake.segment_size) > larguraTela or
       head.y < 0 or (head.y + Snake.segment_size) > alturaTela then
        Snake.dieFlag = true
    end

    -- Colisão com o próprio corpo
    local head_rect = {x = head.x, y = head.y, w = Snake.segment_size, h = Snake.segment_size}

    -- Começa a verificar a partir do 2º segmento, não pode colidir consigo mesma
    for i = 2, #Snake.body do
        local current_segment = Snake.body[i]
        local body_rect = {x = current_segment.x, y = current_segment.y, w = Snake.segment_size, h = Snake.segment_size}

        -- Verifica a colisão entre o retângulo da cabeça e o retângulo do segmento do corpo
        if checkRectCollision(head_rect, body_rect) then
            Snake.dieFlag = true
            break
        end
    end
end

-- Verifica se a cobra comeu a fruta
function Snake.eat(fruit_pos, fruit_width, fruit_height)
    local head = Snake.body[1]
    local head_rect = {x = head.x, y = head.y, w = Snake.segment_size, h = Snake.segment_size}
    local fruit_rect = {x = fruit_pos.x, y = fruit_pos.y, w = fruit_width, h = fruit_height}

    -- Verifica se o retângulo da cabeça colide com o retângulo da fruta
    if checkRectCollision(head_rect, fruit_rect) then
        Snake.eatFlag = true
    end
end

-- Crescimento da cobra
function Snake.grow()
    -- Adiciona um novo segmento mesma posição do último segmento atual
    local lastSegment = Snake.body[#Snake.body]
    local newSegment = {x = lastSegment.x, y = lastSegment.y}
    table.insert(Snake.body, newSegment)
end

-- Função auxiliar para determinar a direção de 'from' para 'to'
local function getDirectionBetweenPoints(fromX, fromY, toX, toY)
    if fromX < toX then return "right"
    elseif fromX > toX then return "left"
    elseif fromY < toY then return "down"
    elseif fromY > toY then return "up"
    end
    return nil
end

-- Desenhar a cobra
function Snake.draw()  
    love.graphics.setColor(1, 1, 1) 

    -- Lógica pra intercalar as cabeças
    local head = Snake.body[1]
    local dir = Snake.direction
    local headImage = headSprites[dir .. frameAtual]

    if not headImage then
        headImage = headSprites[dir] 
    end


    love.graphics.draw(headImage, head.x, head.y)

    -- Desenhar o Corpo e a Cauda 
    for i = 2, #Snake.body do
        local current_segment = Snake.body[i]
        local prev_segment = Snake.body[i-1] 
        local next_segment = nil
        if i < #Snake.body then 
            next_segment = Snake.body[i+1] 
        end
        local image_to_draw = nil
        
        -- Determina a direção de entrada no segmento atual, de onde ele veio
        local entry_dir = getDirectionBetweenPoints(prev_segment.x, prev_segment.y, current_segment.x, current_segment.y)

        if i == #Snake.body then
            -- Cauda
            local tail_dir_facing
            if entry_dir == "right" then tail_dir_facing = "left"
            elseif entry_dir == "left" then tail_dir_facing = "right"
            elseif entry_dir == "up" then tail_dir_facing = "down"
            elseif entry_dir == "down" then tail_dir_facing = "up"
            end
            image_to_draw = tailSprites[tail_dir_facing]
            
        else
            -- Segmento do Corpo Normal, reto ou canto
            local exit_dir = getDirectionBetweenPoints(current_segment.x, current_segment.y, next_segment.x, next_segment.y)

            if entry_dir == exit_dir then
                -- Segmento reto
                if entry_dir == "left" or entry_dir == "right" then
                    image_to_draw = bodySprites.horizontal
                else
                    image_to_draw = bodySprites.vertical
                end
            else
                -- Segmento de Canto
                if (entry_dir == "up" and exit_dir == "right") or (entry_dir == "left" and exit_dir == "down") then
                    image_to_draw = cornerSprites.up_right
                elseif (entry_dir == "right" and exit_dir == "down") or (entry_dir == "up" and exit_dir == "left") then
                    image_to_draw = cornerSprites.right_down
                elseif (entry_dir == "down" and exit_dir == "left") or (entry_dir == "right" and exit_dir == "up") then
                    image_to_draw = cornerSprites.down_left
                elseif (entry_dir == "left" and exit_dir == "up") or (entry_dir == "down" and exit_dir == "right") then
                    image_to_draw = cornerSprites.left_up
                end
            end
        end

        -- Desenha o sprite determinado para o segmento
        if image_to_draw then
            love.graphics.draw(image_to_draw, current_segment.x, current_segment.y)
        end
    end
end

-- Funções auxiliares de flag
function Snake.getDieFlag()
    return Snake.dieFlag
end

function Snake.resetDieFlag()
    dieFlag = false
end

function Snake.getEatFlag()
    return Snake.eatFlag
end

function Snake.resetEatFlag()
    Snake.eatFlag = false
end

return Snake