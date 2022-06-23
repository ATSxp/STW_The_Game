Game = {}

function Game:onActive()
    
end

function Game:update(dt)
    if WORLD_IS_PAUSED then
        return
    else
        updateEnts(dt)
        player:update(dt)
    end

end

function Game:draw()
    love.graphics.push()
    love.graphics.scale(SCALE)

    drawEnts()
    player:draw()

    love.graphics.pop()

end

function Game:keypressed(key, scancode, isrepeat)
    
end

return s