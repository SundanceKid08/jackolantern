

GameLevel = Class{}

function GameLevel:init(entities, objects,tilemap)
    self.tileMap = tilemap
    self.entities = entities
    self.objects = objects
end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    --for k, object in pairs(self.objects) do
    --    object:update(dt)
    --end

    --for k, entity in pairs(self.entities) do
    --    entity:update(dt)
    --end
end

function GameLevel:render()
    self.tileMap:render()

    --for k, object in pairs(self.objects) do
    --    object:render()
    --end

    --for k, entity in pairs(self.entities) do
    --    entity:render()
    --end
end