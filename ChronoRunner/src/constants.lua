

--actual window size

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

TILE_SIZE = 16

-- player walking speed
PLAYER_WALK_SPEED = 100
CULTIST_MOVE_SPEED = 20

-- player jumping velocity
PLAYER_JUMP_VELOCITY = -150

--
-- tile IDs
--
TILE_ID_EMPTY = 5
TILE_ID_GROUND = 3
TILE_ID_LADDER = 6
TILE_ID_EXIT_LADDER = 7

-- table of tiles that should trigger a collision
COLLIDABLE_TILES = {
    TILE_ID_GROUND
}

CLIMABLE_TILES = {
    TILE_ID_LADDER
}
