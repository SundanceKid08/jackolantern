

CultistTrappedState = Class{__includes = BaseState}

function CultistTrappedState:init(player, cultist)
    self.tilemap = tilemap
    self.player = player
    self.cultist = cultist
    self.animation = Animation {
        frames = {1},
        interval = 0.5
    }
    self.cultist.currentAnimation = self.animation
    self.escapeTimer = 0
    self.movingDirection = math.random(2) == 1 and 'left' or 'right'
    self.cultist.direction = self.movingDirection
    self.movingDuration = math.random(5)
    self.movingTimer = 0
    self.trapped = false
end

function CultistTrappedState:update(dt)
    self.cultist.currentAnimation:update(dt)
    self.escapeTimer = self.escapeTimer + dt
    

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.cultist.map:getCollisionTile(self.cultist.x + 5, self.cultist.y + self.cultist.height + 1)
    local tileBottomRight = self.cultist.map:getCollisionTile(self.cultist.x + self.cultist.width - 5, self.cultist.y + self.cultist.height + 1)


    if tileBottomLeft and tileBottomRight and not self.trapped then
        if tileBottomLeft.zapped and tileBottomRight.zapped then
            self.trapped = true
            self.player.dy = 0
            self.cultist.y = self.cultist.y + TILE_SIZE + 1
            self.cultist.x = tileBottomLeft.x
        end
    elseif self.trapped and self.escapeTimer > 3 then
        self.cultist.y = self.cultist.y - TILE_SIZE - 1
        if self.player.x > self.cultist.x then
            self.cultist.x = self.cultist.x + TILE_SIZE
        else 
            self.cultist.x = self.cultist.x - TILE_SIZE
        end
        self.escapeTimer = 0
        self.cultist:changeState('moving')
    end
end

function CultistTrappedState:processAI(dt)


end