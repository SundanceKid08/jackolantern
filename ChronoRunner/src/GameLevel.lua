

GameLevel = Class{}

function GameLevel:init(entities, objects,tilemap)
    self.tileMap = tilemap
    self.entities = entities
    self.objects = objects
    self.exitable = false
end

function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end
end

function GameLevel:update(dt)
    self.tileMap:update(dt)
    
    for o, objects in pairs(objects) do
        objects:update(dt)
    end

    for e, entity in pairs(entities) do
        entity:processAI(dt)
        entity:update(dt)
    end
end

function GameLevel:render()
    for t, tile in pairs(self.tileMap.tiles) do
        if self.exitable and not tile.zapped then 
            tile:render()
        elseif tile.id == TILE_ID_GROUND and not tile.zapped or tile.id == TILE_ID_LADDER then
            tile:render()
        end
    end
    
    for o, objects in pairs(objects) do
        objects:render()
    end

    for e, entity in pairs(entities) do
        entity:render()
    end

end