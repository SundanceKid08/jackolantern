
PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.levelNumber = 1   --current level the player is on
    
    self.playerX = 0       --player starting x position
    self.playerY = 0       --player starting y position

    --search Maps data structure for players x,y position in level
    for r, row in pairs(maps[self.levelNumber]) do
        for e, element in pairs(row) do
            elementType = string.sub(element,1,1)
            column = tonumber(string.sub(element,2))
            if elementType == 'p' then
                self.playerX = (column - 1) * TILE_SIZE
                self.playerY = (r - 1) * TILE_SIZE
            end
        end
    end

    self.player = Player({
        x = self.playerX, y = self.playerY,
        width = 16, height = 16,
        texture = 'player',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerRunState(self.player) end,
            ['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end,
            ['climb'] = function() return PlayerClimbState(self.player) end
        }
    })
    self.level = LevelMaker.createMap(self.levelNumber , self.player)
    self.tilemap = self.level.tileMap
    self.objects = self.level.objects
    self.gravityOn = true
    self.gravityAmount = 2
    self.player.map = self.tilemap
    self.player.level = self.level
    self.level.entities = self:spawnEnemies(self.levelNumber)
    self.player:changeState('falling')
end

function PlayState:nextLevel(levelNumber)
    self.levelNumber = self.levelNumber + 1
    self.playerX = 0
    self.playerY = 0

    for r, row in pairs(maps[self.levelNumber]) do
        for e, element in pairs(row) do
            elementType = string.sub(element,1,1)
            column = tonumber(string.sub(element,2))
            if elementType == 'p' then
                self.playerX = (column - 1) * TILE_SIZE
                self.playerY = (r - 1) * TILE_SIZE
            end
        end
    end

    
    self.player = Player({
        x = self.playerX, y = self.playerY,
        width = 16, height = 16,
        texture = 'player',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerRunState(self.player) end,
            ['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end,
            ['climb'] = function() return PlayerClimbState(self.player) end
        }
    })
    self.level = LevelMaker.createMap(self.levelNumber , self.player)
    self.tilemap = self.level.tileMap
    self.objects = self.level.objects
    self.gravityOn = true
    self.gravityAmount = 2
    self.player.map = self.tilemap
    self.player.level = self.level
    self.level.entities = self:spawnEnemies(self.levelNumber)
    self.player:changeState('falling')
end

function PlayState:restart(levelNumber)
    self.levelNumber = levelNumber
    self.playerX = 0
    self.playerY = 0

    for r, row in pairs(maps[self.levelNumber]) do
        for e, element in pairs(row) do
            elementType = string.sub(element,1,1)
            column = tonumber(string.sub(element,2))
            if elementType == 'p' then
                self.playerX = (column - 1) * TILE_SIZE
                self.playerY = (r - 1) * TILE_SIZE
            end
        end
    end

    
    self.player = Player({
        x = self.playerX, y = self.playerY,
        width = 16, height = 16,
        texture = 'player',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerRunState(self.player) end,
            ['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end,
            ['climb'] = function() return PlayerClimbState(self.player) end
        }
    })
    self.level = LevelMaker.createMap(self.levelNumber , self.player)
    self.tilemap = self.level.tileMap
    self.objects = self.level.objects
    self.gravityOn = true
    self.gravityAmount = 2
    self.player.map = self.tilemap
    self.player.level = self.level
    self.level.entities = self:spawnEnemies(self.levelNumber)
    self.player:changeState('falling')
end

function PlayState:update(dt)
    Timer.update(dt)
    self.level:clear()
    self.level:update(dt)
    self.player:update(dt)

    if self.player.y < 0 then
        self:nextLevel(self.levelNumber)
    end

    if #self.level.objects < 1 then
        self.level.exitable = true
    end

    if self.player:checkEntityCollisions() then
        self:restart(self.levelNumber)
    end
end

function PlayState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    
    self.level:render()
    self.player:render()
    

    -- love.graphics.setFont(gFonts['medium'])
    -- love.graphics.setColor(255, 255, 255, 255)
    -- love.graphics.printf("x" .. self.player.x .. ", y" .. self.player.y, 1, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')

    -- love.graphics.setColor(255,0,0,255)
    -- love.graphics.rectangle('line',self.player.x, self.player.y, self.player.width, self.player.height)



    local tileBottomLeft = self.player.map:getCollisionTile(self.player.x, self.player.y + self.player.height + 1)
    local tileBottomRight = self.player.map:getCollisionTile(self.player.x + self.player.width, self.player.y + self.player.height + 1)
    local tileTopLeft = self.player.map:getCollisionTile(self.player.x , self.player.y + 8)
    local tileTopRight = self.player.map:getCollisionTile(self.player.x + self.player.width, self.player.y + 8)
    local zapTileLeft = self.player.map:getCollisionTile(self.player.x - TILE_SIZE - 1, self.player.y + self.player.height + 1)
    local zapTileRight = self.player.map:getCollisionTile(self.player.x + (TILE_SIZE * 2) + 1, self.player.y + self.player.height + 1)

    love.graphics.setColor(255,255,0,255)

    -- if tileBottomLeft then
    --     love.graphics.rectangle('line', tileBottomLeft.x, tileBottomLeft.y, TILE_SIZE, TILE_SIZE)
    --     love.graphics.printf("Lt" .. tileBottomLeft.x .. "," .. tileBottomLeft.y, 1, VIRTUAL_HEIGHT - 240, VIRTUAL_WIDTH/4 , 'center')
    -- end

    -- if tileBottomRight then
    --     love.graphics.rectangle('line', tileBottomRight.x, tileBottomRight.y, TILE_SIZE, TILE_SIZE)
    --     love.graphics.printf("Rt" .. tileBottomRight.x .. "," .. tileBottomRight.y, 1, VIRTUAL_HEIGHT - 260, VIRTUAL_WIDTH/4, 'center')
    -- end

    -- if tileTopLeft then
    --     love.graphics.rectangle('line', tileTopLeft.x, tileTopLeft.y, TILE_SIZE, TILE_SIZE)
    -- end

    -- if tileTopRight then
    --     love.graphics.rectangle('line', tileTopRight.x, tileTopRight.y, TILE_SIZE, TILE_SIZE)
    -- end

    -- if zapTileRight then
    --     love.graphics.rectangle('line', zapTileRight.x, zapTileRight.y, TILE_SIZE, TILE_SIZE)
    -- end

    -- if zapTileLeft then
    --     love.graphics.rectangle('line', zapTileLeft.x, zapTileLeft.y, TILE_SIZE, TILE_SIZE)
    -- end
end

function PlayState:spawnEnemies(mapname)
    activemap = maps[mapname]
    entities = {}

    for r, row in pairs(activemap) do
        for e, element in pairs(row) do
            elementType = string.sub(element,1,1)
            column = tonumber(string.sub(element,2))
            if elementType == 'c' then
                local cultist
                cultist = Entity {
                    texture = 'cultist',
                    x = (column-1) * TILE_SIZE,
                    y = (r-1) * TILE_SIZE,
                    width = 8,
                    height = 16,
                    map = self.tilemap,
                    stateMachine = StateMachine {
                        ['moving'] = function() return CultistMovingState(self.tilemap, self.player, cultist) end,
                        ['trapped'] = function() return CultistTrappedState(self.player, cultist) end,
                        ['falling'] = function() return CultistFallingState(self.player, self.gravityAmount, cultist) end,
                        ['climb'] = function() return CultistClimbState(self.player, cultist) end
                    }
                }
                cultist:changeState('falling')
            
            table.insert(entities, cultist)
            end 
        end
    end
    return entities
end


