require("src/utils/init")
function love.load()
   Init()
end

function love.update(dt)
    stateManager:update(dt)
end

function love.draw()
    stateManager:draw()
end

function love.keypressed(key, scancode, isrepeat)
    stateManager:keypressed(key, scancode, isrepeat)
end