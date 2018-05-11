

CultistFallingState = Class{__includes = BaseState}

function CultistFallingState:init(player, gravity, cultist)
    self.player= player
    self.cultist = cultist
    self.gravity = gravity
    self.animation = Animation {
        frames = {3},
        interval = 1
    }
    self.cultist.currentAnimation = self.animation
end

function CultistFallingState:update(dt)
    self.cultist.currentAnimation:update(dt)
    self.cultist.dy = self.cultist.dy + self.gravity
    self.cultist.y = self.cultist.y + (self.cultist.dy * dt)

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.cultist.map:getCollisionTile(self.cultist.x, self.cultist.y + self.cultist.height + 1)
    local tileBottomRight = self.cultist.map:getCollisionTile(self.cultist.x + self.cultist.width, self.cultist.y + self.cultist.height + 1)
    local tileTopLeft = self.cultist.map:getCollisionTile(self.cultist.x, self.cultist.y)
    local tileTopRight = self.cultist.map:getCollisionTile(self.cultist.x + self.cultist.width, self.cultist.y)

    -- if we get a collision beneath us, go into either walking or idle
    if tileBottomLeft and tileBottomRight or tileBottomLeft and tileTopRight or tileBottomRight and tileTopLeft then
            self.cultist.dy = 0
            self.cultist.y = tileBottomLeft.y - self.cultist.height or tileBottomRight.y - self.cultist.height
            self.cultist:changeState('moving')
    end
   
        
       
    


end


function CultistFallingState:processAI(dt)


end