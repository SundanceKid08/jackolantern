
--libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'


--utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'
require 'src/LevelMaker'

--game states
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

--entity states
require 'src/states/entity/player/PlayerRunState'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerFallingState'
require 'src/states/entity/player/PlayerClimbState'
require 'src/states/entity/enemy/CultistMovingState'
require 'src/states/entity/enemy/CultistTrappedState'
require 'src/states/entity/enemy/CultistFallingState'
require 'src/states/entity/enemy/CultistClimbState'
--general
require 'src/Tile'
require 'src/TileMap'
require 'src/Maps'

require 'src/Animation'
require 'src/Entity'
require 'src/Player'
require 'src/GameObject'
require 'src/GameLevel'


gSounds = {
    ['music'] = love.audio.newSource('sounds/windsofstories.mp3'),
    ['pickup'] = love.audio.newSource('sounds/key_pickup.mp3'),
    ['dig'] = love.audio.newSource('sounds/impactsplat07.mp3'),
    ['grunt'] = love.audio.newSource('sounds/cut_grunt2.wav')
}

gTextures = {
    ['blocks'] = love.graphics.newImage('graphics/levelblocks.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['player'] = love.graphics.newImage('graphics/runsheet.png'),
    ['coins'] = love.graphics.newImage('graphics/coins_animation_0.png'),
    ['cultist'] = love.graphics.newImage('graphics/cultist.png'),
    ['ladder'] = love.graphics.newImage('graphics/rope_ladder.png')
}

gFrames = {
    ['blocks'] = GenerateQuads(gTextures['blocks'], TILE_SIZE, TILE_SIZE),
    ['player'] = GenerateQuads(gTextures['player'], 16, 16),
    ['coins'] = GenerateQuads(gTextures['coins'], 16, 16),
    ['cultist'] = GenerateQuads(gTextures['cultist'], 16, 16),
    ['ladder'] = GenerateQuads(gTextures['ladder'], 16, 16)
}


gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}