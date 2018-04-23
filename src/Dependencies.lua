
--libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'


--utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'
--game states
require 'src/states/BaseState'
require 'src/states/game/StartState'
--entity states

--general
require 'src/Tile'
require 'src/TileMap'


gSounds = {}

gTextures = {}

gFrames = {}


gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}