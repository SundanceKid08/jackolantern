
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

--general
require 'src/Tile'
require 'src/TileMap'
require 'src/Maps'
require 'src/Ladder'
require 'src/Animation'
require 'src/Entity'
require 'src/Player'
require 'src/GameObject'
require 'src/GameLevel'


gSounds = {
    ['music'] = love.audio.newSource('sounds/windsofstories.mp3')
}

gTextures = {
    ['blocks'] = love.graphics.newImage('graphics/levelblocks.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['player'] = love.graphics.newImage('graphics/playerrun.png')
}

gFrames = {
    ['blocks'] = GenerateQuads(gTextures['blocks'], TILE_SIZE, TILE_SIZE),
    ['player'] = GenerateQuads(gTextures['player'], 32, 32)
}


gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}