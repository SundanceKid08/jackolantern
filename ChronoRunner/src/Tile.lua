--[[ 
  Chrono Runner Tile Class
]]

Tile = Class{}

function Tile:init(x, y, tileset,id, player)
    self.x = x - 1
    self.y = y - 1
    self.player = player
    self.zapped = false
    self.reTileTimer = 0
    self.id = id
    

    if self.id == TILE_ID_GROUND then
        self.width = TILE_SIZE
        self.height = TILE_SIZE
        self.texture = 'blocks'
    elseif self.id == TILE_ID_LADDER or self.id == TILE_ID_EXIT_LADDER then
        self.width = TILE_SIZE + 2
        self.height = TILE_SIZE + 2
        self.texture = 'ladder'
    end
    self.tileset = tileset
end

function Tile:update(dt)
    self.reTileTimer = self.reTileTimer + dt

    if self.reTileTimer > 10 then
        self.zapped = false
        self.reTileTimer = 0
        self.player.hasZapped = false
    end
end

--[[
    Checks to see whether this ID is whitelisted as collidable in a global constants table.
]]
function Tile:collidable(target)
    for k, v in pairs(COLLIDABLE_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:climable(target)
    for k, v in pairs(CLIMABLE_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end


function Tile:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.tileset],
        (self.x), (self.y))
end