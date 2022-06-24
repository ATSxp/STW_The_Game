stateManager = {}
stateManager.states = {}
stateManager.curState = ""
stateManager.overLayer = {}

function stateManager:add(name, obj)
    self.states[name] = obj
end

function stateManager:active(name)
    self.curState = name
    if self.states[self.curState].onActive then
        self.states[self.curState]:onActive()
    end
    logConsole("Estado trocado para: "..self.curState)
end

function stateManager:pop()
    table.remove(self.overLayer, 1)

    -- if #self.overLayer > 1 then
    --     if self.states[1].onActive then
    --         self.states[1]:onActive()
    --     end
        
    -- end

end

function stateManager:push(obj)
    table.insert(self.overLayer, 1, obj)

    if obj.onActive then
        obj:onActive()

    end

end

function stateManager:update(dt)
    rs.update(dt)
    timer.update(dt)

    if self.states[self.curState].update then
        self.states[self.curState]:update(dt)
    end

    for i, v in ipairs(self.overLayer)do
        if v.update then
            v:update(dt)
        end
    end

end

function stateManager:draw()
    rs.start()

    if self.states[self.curState].draw then
        self.states[self.curState]:draw()
    end

    for i, v in ipairs(self.overLayer)do
        if v.draw then
            v:draw()
        end
    end

    rs.stop()
end

function stateManager:keypressed(key, scancode, isrepeat)
    if self.states[self.curState].keypressed then
        self.states[self.curState]:keypressed(key, scancode, isrepeat)
    end

    for i, v in ipairs(self.overLayer)do
        if v.keypressed then
            v:keypressed(key, scancode, isrepeat)
        end

    end

end

function stateManager:keyreleased(key, scancode)
    if self.states[self.curState].keyreleased then
        self.states[self.curState]:keyreleased(key, scancode)
    end

    for i, v in ipairs(self.overLayer)do
        if v.keyreleased then
            v:keyreleased(key, scancode)
        end
        
    end

end

function stateManager:mousepressed(x, y, button, istouch, presses)
    if self.states[self.curState].mousepressed then
        self.states[self.curState]:mousepressed(x, y, button, istouch, presses)
    end

    for i, v in ipairs(self.overLayer)do
        if v.mousepressed then
            v:mousepressed(x, y, button, istouch, presses)
        end

    end
    
end
return stateManager