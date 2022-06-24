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

    if key == "escape" then
        love.event.quit()
    end

end

function love.keyreleased(key, scancode)
    stateManager:keyreleased(key, scancode)
end

function love.mousepressed(x, y, button, istouch, presses)
    love.mouse.setPosition(x, y)
    local mx, my = rs.toGame(love.mouse.getPosition())
    
    stateManager:mousepressed(mx, my, button, istouch, presses)
end