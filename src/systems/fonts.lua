local Fonts = {}

-- Carrega as diferentes fontes para cada parte
function Fonts.load()
    Fonts.title = love.graphics.newFont("assets/fonts/arcadegame.ttf", 52)
    Fonts.menuTitle = love.graphics.newFont("assets/fonts/arcadegame.ttf", 50)
    Fonts.button = love.graphics.newFont("assets/fonts/arcadegame.ttf", 20)
    Fonts.painelTitle = love.graphics.newFont("assets/fonts/arcadegame.ttf", 22)
    Fonts.painelNumber = love.graphics.newFont("assets/fonts/arcadegame.ttf", 40)
end

return Fonts