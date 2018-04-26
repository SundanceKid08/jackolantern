--[[
  Chrono Runner Tile Class
]]

Ladder = Class{}

function Ladder:init(x, y, tileset)
    self.x = x
    self.y = y

    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.id = id
    self.tileset = tileset
end

--[[
    Checks to see whether this ID is whitelisted as collidable in a global constants table.
]]
function Ladder:collidable(target)
    for k, v in pairs(COLLIDABLE_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Ladder:render()
    love.graphics.draw(gTextures['blocks'], gFrames['blocks'][self.tileset],
        (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end