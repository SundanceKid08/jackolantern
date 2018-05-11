     


PlayerClimbState = Class{__includes = BaseState}

function PlayerClimbState:init(player)
    self.player = player
    self.animation = Animation {
        frames = {1, 2, 3, 4},
        interval = 0.1
    }
    self.climbSpeed = 6
    self.player.currentAnimation = self.animation
end

function PlayerClimbState:update(dt)
    self.player.currentAnimation:update(dt)

        local tileBottomLeft = self.player.map:getCollisionTile(self.player.x + 1, self.player.y + self.player.height - 1)
        local tileBottomRight = self.player.map:getCollisionTile(self.player.x + self.player.width - 1, self.player.y + self.player.height - 1)
        local tileTopLeft = self.player.map:getCollisionTile(self.player.x , self.player.y + 8)
        local tileTopRight = self.player.map:getCollisionTile(self.player.x + self.player.width, self.player.y + 8)
        
        -- check to see whether there are any tiles beneath us
        if not tileBottomLeft and not tileBottomRight then
            self.player.dy = 0
            self.player:changeState('falling')
        elseif love.keyboard.isDown('left') then
            self.player:changeState('walking')
        elseif love.keyboard.isDown('right') then
            self.player:changeState('walking')
        end
        
        
        if tileTopLeft and love.keyboard.isDown('up') then
            if tileTopLeft.id == TILE_ID_LADDER or tileTopLeft.id == TILE_ID_EXIT_LADDER and self.player.level.exitable then
                self.player.y = self.player.y - PLAYER_WALK_SPEED * dt
                self.player:checkUpCollisions(dt)
            end
        elseif tileTopRight and love.keyboard.isDown('up') then
            if tileTopRight.id == TILE_ID_LADDER or tileTopRight.id == TILE_ID_EXIT_LADDER and self.player.level.exitable then
                self.player.y = self.player.y - PLAYER_WALK_SPEED * dt
                self.player:checkUpCollisions(dt)
            end
        elseif tileBottomRight and love.keyboard.isDown('up') then
            if tileBottomRight.id == TILE_ID_LADDER or tileBottomRight.id == TILE_ID_EXIT_LADDER and self.player.level.exitable then
                self.player.y = self.player.y - PLAYER_WALK_SPEED * dt
                self.player:checkUpCollisions(dt)
            end
        elseif tileBottomLeft and love.keyboard.isDown('up') then
            if tileBottomLeft.id == TILE_ID_LADDER or tileBottomLeft.id == TILE_ID_EXIT_LADDER and self.player.level.exitable then
                self.player.y = self.player.y - PLAYER_WALK_SPEED * dt
                self.player:checkUpCollisions(dt)
            end
        elseif tileTopRight and love.keyboard.isDown('down') then
            if tileTopRight.id == TILE_ID_LADDER or tileTopRight.id == TILE_ID_EXIT_LADDER and self.player.level.exitable then
                self.player.y = self.player.y + PLAYER_WALK_SPEED * dt
                self.player:checkDownCollisions(dt)
            end
        elseif tileTopLeft and love.keyboard.isDown('down') then
            if tileTopLeft.id == TILE_ID_LADDER or tileTopLeft.id == TILE_ID_EXIT_LADDER and self.player.level.exitable then
                self.player.y = self.player.y + PLAYER_WALK_SPEED * dt
                self.player:checkDownCollisions(dt)
            end
        elseif tileBottomLeft and love.keyboard.isDown('down') then
         if tileBottomLeft.id == TILE_ID_LADDER or tileBottomLeft.id == TILE_ID_EXIT_LADDER and self.player.level.exitable then
                self.player.y = self.player.y + PLAYER_WALK_SPEED * dt
                self.player:checkDownCollisions(dt)
            end
        elseif tileBottomRight and love.keyboard.isDown('down') then
            if tileBottomRight.id == TILE_ID_LADDER or tileBottomRight.id == TILE_ID_EXIT_LADDER and self.player.level.exitable then
                self.player.y = self.player.y + PLAYER_WALK_SPEED * dt
                self.player:checkDownCollisions(dt)
            end
        elseif not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
            self.player:changeState('idle')
        end
end

