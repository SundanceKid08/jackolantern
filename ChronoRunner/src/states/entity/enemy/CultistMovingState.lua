CultistMovingState = Class{__includes = BaseState}

function CultistMovingState:init(tilemap, player, cultist)
    self.tilemap = tilemap
    self.player = player
    self.cultist = cultist
    self.playerLastX = 0
    self.playerLastY = 0
    self.animation = Animation {
        frames = {1,2,3,4,5,6,7,8},
        interval = 0.5
    }
    self.cultist.currentAnimation = self.animation
    self.seenPlayer = false
    self.movingDirection = math.random(2) == 1 and 'left' or 'right'
    self.cultist.direction = self.movingDirection
    self.movingDuration = math.random(5)
    self.movingTimer = 0
end

function CultistMovingState:update(dt)
    self.movingTimer = self.movingTimer + dt
    self.cultist.currentAnimation:update(dt)

    local tileBottomLeft = self.cultist.map:getCollisionTile(self.cultist.x, self.cultist.y + self.cultist.height + 1)
    local tileBottomRight = self.cultist.map:getCollisionTile(self.cultist.x + self.cultist.width, self.cultist.y + self.cultist.height + 1)
    local tileBottomLeft = self.cultist.map:getCollisionTile(self.cultist.x + 1, self.cultist.y + self.cultist.height + 1)
    local tileTopLeft = self.cultist.map:getCollisionTile(self.cultist.x, self.cultist.y)

    if tileBottomLeft and tileBottomRight and tileBottomLeft.zapped and tileBottomRight.zapped then
        self.cultist:changeState('trapped')
    elseif not tileBottomLeft and not tileBottomRight then
        self.cultist:changeState('falling')
    end
end

function CultistMovingState:processAI(dt)
    local search = self.player.x
    if self.player.x < self.cultist.x and self.player.y >= self.cultist.y then
        self.cultist.x = self.cultist.x - CULTIST_MOVE_SPEED* dt
        self.cultist.direction = 'left'
        self.playerLastX = self.player.x
        self.seenPlayer = true
    elseif self.player.x > self.cultist.x and self.player.y >= self.cultist.y  then
        self.cultist.x = self.cultist.x + CULTIST_MOVE_SPEED * dt
        self.cultist.direction = 'right'
        self.playerLastX = self.player.x
        self.seenPlayer = true
    elseif self.playerLastX < self.cultist.x and self.seenPlayer then
        self.cultist.x = self.cultist.x - CULTIST_MOVE_SPEED * dt
        self.cultist.direction = 'left'
    elseif self.playerLastX > self.cultist.x and self.seenPlayer then
        self.cultist.x = self.cultist.x + CULTIST_MOVE_SPEED * dt
        self.cultist.direction = 'right'
        -- local tileTopRight = self.cultist.map:getCollisionTile(self.cultist.x + search, self.cultist.y)
        -- local tileBottomRight = self.cultist.map:getCollisionTile(self.cultist.x + search, self.cultist.y + self.cultist.height - 1)
    elseif self.playerLastX > self.cultist.x - 1 and self.playerLastX < self.cultist + 1 then
        self.cultist:changeState('climb')
    end
end