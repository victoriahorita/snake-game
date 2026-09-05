local Sounds = {}

-- Carrega os sons de cada ação
function Sounds.load()
    Sounds.eatSound = love.audio.newSource("assets/sounds/eat.wav", "static")
    Sounds.gameOverSound = love.audio.newSource("assets/sounds/gameOverSound.wav", "static")
    Sounds.menuSelectSound = love.audio.newSource("assets/sounds/menuSelect.wav", "static")
    Sounds.bgMusic = love.audio.newSource("assets/sounds/backgroundMusic.mp3", "stream")

    Sounds.bgMusic:setLooping(true)
    love.audio.play(Sounds.bgMusic)
end

-- Som de comer
function Sounds.playEat()
    love.audio.play(Sounds.eatSound)
end

-- Som de game over
function Sounds.playGameOver()
    Sounds.stopMusic() 
    love.audio.play(Sounds.gameOverSound)
end

-- Som de selecionar o botão
function Sounds.playMenuSelect()
    love.audio.play(Sounds.menuSelectSound)
end

-- Parar a música de fundo
function Sounds.stopMusic()
    Sounds.bgMusic:stop()
end

-- Iniciar a música
function Sounds.startMusic()
    if not Sounds.bgMusic:isPlaying() then 
        love.audio.play(Sounds.bgMusic)
    end
end

return Sounds
