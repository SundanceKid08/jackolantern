--[[
    GD50
    Super Mario Bros. Remake

    -- TileMap Class --
]]

TileMap = Class{}

function TileMap:init(width, height, tiles)
    self.width = width
    self.height = height
    self.tiles = tiles
end

--[[
    If our tiles were animated, this is potentially where we could iterate over all of them
    and update either per-tile or per-map animations for appropriately flagged tiles!
]]
function TileMap:update(dt)

end

--[[
    Returns the x, y of a tile given an x, y of coordinates in the world space.
]]
function TileMap:pointToTile(x, y)
    if x < 0 or x > self.width * TILE_SIZE or y < 0 or y > self.height * TILE_SIZE then
        return nil
    end
    
    return self.tiles[math.floor(y / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end

function TileMap:render()
    for k, v in pairs(self.tiles) do
        v:render()
    end
end