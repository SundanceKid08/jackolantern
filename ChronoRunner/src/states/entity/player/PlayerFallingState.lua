

PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(player, gravity)
    self.player = player
    self.gravity = gravity
    self.animation = Animation {
        frames = {3},
        interval = 1
    }
    self.player.currentAnimation = self.animation
end

function PlayerFallingState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy + self.gravity
    self.player.y = self.player.y + (self.player.dy * dt)

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.player.map:getCollisionTile(self.player.x, self.player.y + self.player.height + 1)
    local tileBottomRight = self.player.map:getCollisionTile(self.player.x + self.player.width, self.player.y + self.player.height + 1)
    local tileTopLeft = self.player.map:getCollisionTile(self.player.x, self.player.y)
    local tileTopRight = self.player.map:getCollisionTile(self.player.x + self.player.width, self.player.y)

    -- if we get a collision beneath us, go into either walking or idle
    if tileBottomLeft and tileBottomRight  then
        self.player.dy = 0
        gSounds['grunt']:play()
        -- set the player to be walking or idle on landing depending on input
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('walking')
        else
            self.player:changeState('idle')
        end
        
        self.player.y = tileBottomLeft.y - self.player.height or tileBottomRight.y - self.player.height
    
    -- go back to start if we fall below the map boundary
    elseif self.player.y > VIRTUAL_HEIGHT then
        gStateMachine:change('start')
  
    end
end