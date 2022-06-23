function Init()
    utf8 = require("utf8")
    rs = require("libs/resolution_solution")
    timer = require("libs/hump/timer")

    local w, h = love.window.getMode()
    SCREEN_W = w
    SCREEN_H = h

    love.graphics.setDefaultFilter("nearest", "nearest", 0)

    rs.setGame(SCREEN_W, SCREEN_H)
    
    require("src/utils/requires")
end