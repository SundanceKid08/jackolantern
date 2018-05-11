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
    for t, tile in pairs(self.tiles) do
        tile:update(dt)
    end
        
end

function TileMap:getCollisionTile(x, y)
    for t, tile in pairs(self.tiles) do
        if tile.x < x and tile.x + TILE_SIZE > x then
            if tile.y < y and tile.y  + TILE_SIZE > y then
                return tile
            end
        end
    end
    return nil
end

function TileMap:render()
    for k, v in pairs(self.tiles) do
        if not v.zapped then
            v:render()
        end
    end
end