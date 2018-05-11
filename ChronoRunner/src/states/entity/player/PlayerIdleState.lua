

PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player
    self.animation = Animation {
        frames = {1},
        interval = 0.1
    }
    self.player.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
    self.player.currentAnimation:update(dt)

    -- idle if we're not pressing anything at all
    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') and not love.keyboard.isDown('up') and not love.keyboard.isDown('down') then
        local zapTileLeft = self.player.map:getCollisionTile(self.player.x - TILE_SIZE - 1, self.player.y + self.player.height + 1)
        local zapTileRight = self.player.map:getCollisionTile(self.player.x + (TILE_SIZE * 2) + 1, self.player.y + self.player.height + 1)

        if love.keyboard.isDown('space') then
            if zapTileLeft and self.player.direction == 'left' and love.keyboard.isDown('space') and self.player.hasZapped == false then
                self:zapTile(zapTileLeft)
                gSounds['dig']:play()
                self.player.hasZapped = true
            elseif zapTileRight and self.player.direction == 'right' and love.keyboard.isDown('space')  and self.player.hasZapped == false then
                self:zapTile(zapTileRight)
                gSounds['dig']:play()
                self.player.hasZapped = true
            end
        end
        self.player:changeState('idle')

    else
        local tileBottomLeft = self.player.map:getCollisionTile(self.player.x - 1, self.player.y + self.player.height + 1)
        local tileBottomRight = self.player.map:getCollisionTile(self.player.x + self.player.width + 1, self.player.y + self.player.height + 1)
        local tileTopLeft = self.player.map:getCollisionTile(self.player.x  - 1 , self.player.y + 1)
        local tileTopRight = self.player.map:getCollisionTile(self.player.x + self.player.width  + 1, self.player.y + 1)
        
        
        local collidedObjects = self.player:checkObjectCollisions()  -- check for object collision (objects are typically coins)

        
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
            if tileTopLeft.id == TILE_ID_LADDER then
                self.player:changeState('climb')
            end
        elseif tileTopRight and love.keyboard.isDown('up') then
            if tileTopRight.id == TILE_ID_LADDER then
                self.player:changeState('climb')
            end
        elseif tileBottomRight and love.keyboard.isDown('up') then
            if tileBottomRight.id == TILE_ID_LADDER then
                self.player:changeState('climb')
            end
        elseif tileBottomLeft and love.keyboard.isDown('up') then
            if tileBottomLeft.id == TILE_ID_LADDER then
                self.player:changeState('climb')
            end
        elseif tileTopRight and love.keyboard.isDown('down') then
            if tileTopRight.id == TILE_ID_LADDER then
                self.player:changeState('climb')
            end
        elseif tileTopLeft and love.keyboard.isDown('down') then
            if tileTopLeft.id == TILE_ID_LADDER then
                self.player:changeState('climb')
            end
        elseif tileBottomLeft and love.keyboard.isDown('down') then
         if tileBottomLeft.id == TILE_ID_LADDER then
            self.player:changeState('climb')
            end
        elseif tileBottomRight and love.keyboard.isDown('down') then
            if tileBottomRight.id == TILE_ID_LADDER then
                self.player:changeState('climb')
            end
        end
    end

 

    -- check if we've collided with any entities and die if so
    --for k, entity in pairs(self.player.level.entities) do
    --    if entity:collides(self.player) then
     --       gSounds['death']:play()
     ---       gStateMachine:change('start')
    --    end
    --end

end

function PlayerIdleState:zapTile(zappedTile)
    zappedTile.zapped = true
end