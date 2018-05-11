     


CultistClimbState = Class{__includes = BaseState}

function CultistClimbState:init(player,cultist)
    self.player = player
    self.cultist = cultist
    self.animation = Animation {
        frames = {1, 2, 3, 4,5},
        interval = 0.1
    }
    self.climbSpeed = 6
    self.cultist.currentAnimation = self.animation
end

function CultistClimbState:update(dt)
    self.cultist.currentAnimation:update(dt)

        local tileBottomLeft = self.cultist.map:getCollisionTile(self.cultist.x + 1, self.cultist.y + self.cultist.height - 1)
        local tileBottomRight = self.cultist.map:getCollisionTile(self.cultist.x + self.cultist.width - 1, self.cultist.y + self.cultist.height - 1)
        local tileTopLeft = self.cultist.map:getCollisionTile(self.cultist.x , self.cultist.y + 8)
        local tileTopRight = self.cultist.map:getCollisionTile(self.cultist.x + self.cultist.width, self.cultist.y + 8)
        
        -- check to see whether there are any tiles beneath us
        if not tileBottomLeft and not tileBottomRight then
            self.cultist.dy = 0
            self.cultist:changeState('falling')
        elseif love.keyboard.isDown('left') then
            self.cultist:changeState('walking')
        elseif love.keyboard.isDown('right') then
            self.cultist:changeState('walking')
        end
        
        
        if tileTopLeft and love.keyboard.isDown('up') then
            if tileTopLeft.id == TILE_ID_LADDER or tileTopLeft.id == TILE_ID_EXIT_LADDER and self.cultist.level.exitable then
                self.cultist.y = self.cultist.y - CULTIST_MOVE_SPEED * dt
                self.cultist:checkUpCollisions(dt)
            end
        elseif tileTopRight and love.keyboard.isDown('up') then
            if tileTopRight.id == TILE_ID_LADDER or tileTopRight.id == TILE_ID_EXIT_LADDER and self.cultist.level.exitable then
                self.cultist.y = self.cultist.y - CULTIST_MOVE_SPEED * dt
                self.cultist:checkUpCollisions(dt)
            end
        elseif tileBottomRight and love.keyboard.isDown('up') then
            if tileBottomRight.id == TILE_ID_LADDER or tileBottomRight.id == TILE_ID_EXIT_LADDER and self.cultist.level.exitable then
                self.cultist.y = self.cultist.y - CULTIST_MOVE_SPEED * dt
                self.cultist:checkUpCollisions(dt)
            end
        elseif tileBottomLeft and love.keyboard.isDown('up') then
            if tileBottomLeft.id == TILE_ID_LADDER or tileBottomLeft.id == TILE_ID_EXIT_LADDER and self.cultist.level.exitable then
                self.cultist.y = self.cultist.y - CULTIST_MOVE_SPEED * dt
                self.cultist:checkUpCollisions(dt)
            end
        elseif tileTopRight and love.keyboard.isDown('down') then
            if tileTopRight.id == TILE_ID_LADDER or tileTopRight.id == TILE_ID_EXIT_LADDER and self.cultist.level.exitable then
                self.cultist.y = self.cultist.y + CULTIST_MOVE_SPEED * dt
                self.cultist:checkDownCollisions(dt)
            end
        elseif tileTopLeft and love.keyboard.isDown('down') then
            if tileTopLeft.id == TILE_ID_LADDER or tileTopLeft.id == TILE_ID_EXIT_LADDER and self.cultist.level.exitable then
                self.cultist.y = self.cultist.y + CULTIST_MOVE_SPEED * dt
                self.cultist:checkDownCollisions(dt)
            end
        elseif tileBottomLeft and love.keyboard.isDown('down') then
         if tileBottomLeft.id == TILE_ID_LADDER or tileBottomLeft.id == TILE_ID_EXIT_LADDER and self.cultist.level.exitable then
                self.cultist.y = self.cultist.y + CULTIST_MOVE_SPEED * dt
                self.cultist:checkDownCollisions(dt)
            end
        elseif tileBottomRight and love.keyboard.isDown('down') then
            if tileBottomRight.id == TILE_ID_LADDER or tileBottomRight.id == TILE_ID_EXIT_LADDER and self.cultist.level.exitable then
                self.cultist.y = self.cultist.y + CULTIST_MOVE_SPEED * dt
                self.cultist:checkDownCollisions(dt)
            end
        elseif not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
            self.cultist:changeState('idle')
        end
end


function CultistTrappedState:processAI(dt)


end