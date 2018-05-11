

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.score = 0
    
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
end

function Player:checkLeftCollisions(dt)
    -- check for left two tiles collision
    local tileTopLeft = self.map:getCollisionTile(self.x, self.y + 1)
    local tileBottomLeft = self.map:getCollisionTile(self.x, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if tileTopLeft and tileTopLeft:collidable() then
        self.x = tileTopLeft.x + TILE_SIZE + 1
        return true
    elseif tileBottomLeft and tileBottomLeft:collidable() then
        self.x = tileBottomLeft.x + TILE_SIZE + 1
        return true
    end
    return false
end

function Player:checkRightCollisions(dt)
    -- check for right two tiles collision
    local tileTopRight = self.map:getCollisionTile(self.x + self.width, self.y + 1)
    local tileBottomRight = self.map:getCollisionTile(self.x + self.width, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    
    if tileTopRight and tileTopRight:collidable() then
        self.x = tileTopRight.x - TILE_SIZE - 1
        return true
    elseif tileBottomRight and tileBottomRight:collidable() then
        self.x = tileBottomRight.x - TILE_SIZE - 1
        return true
    end
    return false
end

function Player:checkDownCollisions(dt)
    -- check for right two tiles collision
    local tileBottomLeft = self.map:getCollisionTile(self.x, self.y + self.height)
    local tileBottomRight = self.map:getCollisionTile(self.x + self.width, self.y + self.height)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    
    if tileBottomLeft and tileBottomLeft:collidable() then
        self.y = tileBottomLeft.y - TILE_SIZE - 1
        return true
    elseif tileBottomRight and tileBottomRight:collidable() then
        self.y = tileBottomRight.y - TILE_SIZE - 1
        return true
    end
    return false
end

function Player:checkUpCollisions(dt)
    -- check for right two tiles collision
    local tileTopLeft = self.map:getCollisionTile(self.x, self.y)
    local tileTopRight = self.map:getCollisionTile(self.x + self.width, self.y)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if (tileTopLeft and tileTopRight) and (tileTopRight:collidable() or tileTopLeft:collidable()) then
        self.y = (tileTopRight.y - 1) + TILE_SIZE 
    else 
        self.y = self.y - 1
        local collidedObjects = self:checkObjectCollisions()
        self.y = self.y + 1
    end
end

function Player:checkEntityCollisions()
    for e, entity in pairs(self.level.entities) do
        if entity:collides(self) then
            return true
        end
    end
    return false
end

function Player:checkObjectCollisions()
    local collidedObjects = {}

    for k, object in pairs(self.level.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            elseif object.consumable then
             object.onConsume(self)
                table.remove(self.level.objects, k)
            end
        end
    end

    return collidedObjects
end
