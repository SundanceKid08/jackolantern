

StartState = Class{__includes = BaseState}

function StartState:init()
    self.level = LevelMaker.createMap('start')
    self.tilemap = self.level.tileMap

    self.player = Player({
        x = 96, y = 200,
        width = 16, height = 20,
        texture = 'player',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerRunState(self.player) end,
            ['falling'] = function() return PlayerRunState(self.player) end
        },
        map = self.tilemap,
        level = self.level
    })

    self.player:changeState('idle')
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
      
    end

    self.player:update(dt)
end

function StartState:render()

    love.graphics.draw(gTextures['background'], 0, 0)
    
    self.tilemap:render()
    self.player:render()

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('ChronoRunner', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('ChronoRunner', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter', 1, VIRTUAL_HEIGHT / 2 + 17, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
end