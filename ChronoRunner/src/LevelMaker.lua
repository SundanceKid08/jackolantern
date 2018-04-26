
LevelMaker = Class{}


function LevelMaker.createMap(mapname)


    activemap = map[mapname]  -- find map data to be rendered (in Maps.lua)
    tileMap = {}
    entities = {}
    objects = {}

    for r, row in pairs(activemap) do -- r represents y-axis position on screen, row is data for element position within row
        for e, element in pairs(row) do -- element is any object in a given rowhow to 
            elementType = string.sub(element,1,1)
            column = string.sub(element,2)
            if elementType == 't' then
                table.insert(tileMap,Tile(column, r, math.random(1,9)))
            elseif elementType == 'l' then
                table.insert(tileMap,Ladder(column,r,20))
            end
        end
    end

    tiles = TileMap(16,16,tileMap)
    

    return GameLevel(entities, objects, tiles)

end