     


PlayerRunState = Class{__includes = BaseState}

function PlayerRunState:init(player)
    self.player = player
    self.animation = Animation {
        frames = {1, 2, 3, 4},
        interval = 0.1
    }
    self.player.currentAnimation = self.animation
end

function PlayerRunState:update(dt)
    self.player.currentAnimation:update(dt)
   
               -- check to see whether there are any tiles beneath us
        if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') 
                and not love.keyboard.isDown('up') and not love.keyboard.isDown('down') then

            self.player:changeState('idle')

        else
            local tileBottomLeft = self.player.map:getCollisionTile(self.player.x + 1, self.player.y + self.player.height + 1)
            local tileBottomRight = self.player.map:getCollisionTile(self.player.x + self.player.width - 1, self.player.y + self.player.height + 1)
            local tileTopLeft = self.player.map:getCollisionTile(self.player.x, self.player.y)
            local tileTopRight = self.player.map:getCollisionTile(self.player.x + self.player.width, self.player.y)
            local zapTileLeft = self.player.map:getCollisionTile(self.player.x - TILE_SIZE - 1, self.player.y + self.player.height + 1)
            local zapTileRight = self.player.map:getCollisionTile(self.player.x + (TILE_SIZE * 2) + 1, self.player.y + self.player.height + 1)

            self.player.y = self.player.y + 1       --move player down one

            local collidedObjects = self.player:checkObjectCollisions()  -- check for object collision (objects are typically coins)

            self.player.y = self.player.y - 1       --move player back up

            if zapTileLeft and self.player.direction == 'left' and love.keyboard.isDown('space') and self.player.hasZapped == false then
                gSounds['dig']:play()
                self:zapTile(zapTileLeft)
                self.player.hasZapped = true
            elseif zapTileRight and self.player.direction == 'right' and love.keyboard.isDown('space')  and self.player.hasZapped == false then
                self:zapTile(zapTileRight)
                self.player.hasZapped = true
                gSounds['dig']:play()
            end

            if not tileBottomLeft and not tileBottomRight then
                self.player.dy = 0
                self.player:changeState('falling')
            elseif not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
                self.player:changeState('idle')
            elseif love.keyboard.isDown('left') then
                self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
                self.player.direction = 'left'
                self.player:checkLeftCollisions(dt)
            elseif love.keyboard.isDown('right') then
                self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
                self.player.direction = 'right'
                self.player:checkRightCollisions(dt)
            end
      

            if tileTopLeft and love.keyboard.isDown('up') then
                if tileTopLeft.id == TILE_ID_LADDER or tileTopLeft.id == TILE_ID_EXIT_LADDER then
                    self.player:changeState('climb')
                end
            elseif tileTopRight and love.keyboard.isDown('up') then
                if tileTopRight.id == TILE_ID_LADDER or tileTopRight.id == TILE_ID_EXIT_LADDER then
                    self.player:changeState('climb')
                end
            elseif tileBottomRight and love.keyboard.isDown('up') then
                if tileBottomRight.id == TILE_ID_LADDER or tileBottomRight.id == TILE_ID_EXIT_LADDER then
                    self.player:changeState('climb')
                end
            elseif tileBottomLeft and love.keyboard.isDown('up') then
                if tileBottomLeft.id == TILE_ID_LADDER or tileBottomLeft.id == TILE_ID_EXIT_LADDER then
                    self.player:changeState('climb')
                end
            elseif tileTopRight and love.keyboard.isDown('down') then
                if tileTopRight.id == TILE_ID_LADDER or tileTopRight.id == TILE_ID_EXIT_LADDER then
                    self.player:changeState('climb')
                end
            elseif tileTopLeft and love.keyboard.isDown('down') then
                if tileTopLeft.id == TILE_ID_LADDER or tileTopLeft.id == TILE_ID_EXIT_LADDER then
                    self.player:changeState('climb')
                end
            elseif tileBottomLeft and love.keyboard.isDown('down') then
            if tileBottomLeft.id == TILE_ID_LADDER or tileBottomLeft.id == TILE_ID_EXIT_LADDER then
                self.player:changeState('climb')
                end
            elseif tileBottomRight and love.keyboard.isDown('down') then
                if tileBottomRight.id == TILE_ID_LADDER or tileBottomRight.id == TILE_ID_EXIT_LADDER then
                    self.player:changeState('climb')
                end
            end
        end
end

function PlayerRunState:zapTile(zappedTile)
    zappedTile.zapped = true
end