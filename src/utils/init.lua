function Init()
    utf8 = require("utf8")
    rs = require("libs/resolution_solution")
    timer = require("libs/hump/timer")

    SCALE = 4

    SCREEN_W = 320
    SCREEN_H = 480

    ENTS = {}
    PARTS = {}

    WORLD_IS_PAUSED = false

    love.graphics.setDefaultFilter("nearest", "nearest", 0)

    rs.setGame(SCREEN_W, SCREEN_H)
    
    require("src/utils/requires")

end