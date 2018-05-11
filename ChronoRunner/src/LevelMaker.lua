
LevelMaker = Class{}


function LevelMaker.createMap(mapname, player)


    activemap = maps[mapname]  -- find map data to be rendered (in Maps.lua)
    tileMap = {}
    entities = {}
    objects = {}
    local completeMap

    for r, row in pairs(activemap) do -- r represents y-axis position on screen, row is data for element position within row
        for e, element in pairs(row) do -- element is any object in a given rowhow to 
            elementType = string.sub(element,1,1)
            column = tonumber(string.sub(element,2))
            if elementType == 't' then
                table.insert(tileMap,Tile( (column-1) * TILE_SIZE, (r-1) * TILE_SIZE, math.random(1,9),TILE_ID_GROUND, player))
            elseif elementType == 'l' then
                table.insert(tileMap,Tile( (column-1) * TILE_SIZE, (r-1) * TILE_SIZE, 5, TILE_ID_LADDER, player))
            elseif elementType == 'e' then
                table.insert(tileMap,Tile( (column-1) * TILE_SIZE, (r-1) * TILE_SIZE, 5, TILE_ID_EXIT_LADDER, player))
            elseif elementType == 'o' then
                table.insert(objects,GameObject{
                    x = (column-1) * TILE_SIZE, 
                    y = (r - 1) * TILE_SIZE,
                    width = 16, 
                    height = 16,
                    texture = 'coins',
                    consumable = true,
                    onConsume = function(player, object)
                        gSounds['pickup']:play()
                    end
                })
            end
        end
    end
    completeMap = TileMap(TILE_SIZE, TILE_SIZE, tileMap)
    
    return GameLevel(entities, objects, TileMap(TILE_SIZE, TILE_SIZE, tileMap))

end