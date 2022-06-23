Textbox = {}
Textbox.letterSpeed = 15
Textbox.y = SCREEN_H / 2
local scale = 3

function Textbox:add(text, data)
    self.dialogues = text or {}
    self.data = data or {}
    self.dialogueI = 1
    self.textI = 1

    stateManager:push(self)
end

function Textbox:update(dt)    
    if self.dialogues and self.dialogues[self.dialogueI] then
        local str = self.dialogues[self.dialogueI]
        local len = str:len()

        WORLD_IS_PAUSED = true

        if self.data and self.data.isVisible ~= nil then
            self.isVisible = self.data.isVisible
        else
            self.isVisible = true
        end

        if self.textI < len then
            self.textI = self.textI + self.letterSpeed * dt
        end

    else
        self:destroyBox()
        
    end

end

function Textbox:draw()
    if self.dialogues and self.dialogues[self.dialogueI] then
        local str = self.dialogues[self.dialogueI]
        local len = str:len()
        local scale = 2

        -- setColor(BLACK[1], BLACK[2], BLACK[3], 0.8)

        love.graphics.rectangle(
            "fill", 
            0, 0, SCREEN_W, SCREEN_H
        )

        love.graphics.setColor(1, 1, 1)

        -- self:drawBox()
        -- self:drawData()

        love.graphics.print(
            str:usub(1, self.textI), 
           8 * scale, self.y - ((2 * scale) / 2) + 24, 
           nil, scale, scale
        )

    end

end

function Textbox:keypressed(key, scancode, isrepeat)
    if self.dialogues and self.dialogues[self.dialogueI] then
        local str = self.dialogues[self.dialogueI]
        local len = str:len()

        if key == "z" and self.textI >= 2 then
            if self.textI < len then
                self.textI = len
            else
                self.dialogueI = self.dialogueI + 1
                self.textI = 1
            end

        end

    end

end

function Textbox:destroyBox()
    WORLD_IS_PAUSED = false
    stateManager:pop()
end

function Textbox:drawBox()
    if not self.isVisible then
        return    
    end

    local draw = love.graphics.draw
    local size = 8 * scale

    setColor(unpack(LIGHT_GREEN))
    love.graphics.rectangle(
        "fill", 
        size, self.y + size, 
        size * 18, size * 7
    )
    love.graphics.setColor(1, 1, 1)

    -- top left
    draw(
        gImages["textbox"], 
        gQuads["textbox"][0], 
        0, self.y, nil, scale, scale
    )

    -- bottom left
    draw(
        gImages["textbox"], 
        gQuads["textbox"][6], 
        0, self.y + (SCREEN_H / 2) - (size), nil, scale, scale
    )

    -- top right
    draw(
        gImages["textbox"], 
        gQuads["textbox"][2], 
        SCREEN_W - size, self.y, nil, scale, scale
    )

    -- bottom right
    draw(
        gImages["textbox"], 
        gQuads["textbox"][8], 
        SCREEN_W - size, self.y + (size * 8), nil, scale, scale
    )

    -- top
    for i = 0, 17 do
        draw(
            gImages["textbox"], 
            gQuads["textbox"][1], 
            size * i + size, self.y, nil, 
            scale, scale
        )

    end
    
    -- bottom
    for i = 0, 17 do
        draw(
            gImages["textbox"], 
            gQuads["textbox"][7], 
            (size) * i + (size), self.y + (SCREEN_H/ 2) - (size), nil, 
            scale, scale
        )

    end
    
    -- left
    for i = 0, 6 do
        draw(
            gImages["textbox"], 
            gQuads["textbox"][3], 
            0, (size) * i + self.y + size, nil, 
            scale, scale
        )
    end
    
    -- right
    for i = 0, 6 do
        draw(
            gImages["textbox"], 
            gQuads["textbox"][5], 
            SCREEN_W - size, (size) * i + self.y + (size), nil, 
            scale, scale
        )
    end

end

function Textbox:drawData()
    local draw = love.graphics.draw
    local size = 8 * scale

    if self.data then
        if self.data.img then
            if self.data.img.texture and 
            self.data.img.quads then
                self:drawBoxBackToImageData()

                draw(
                    gImages[self.data.img.texture], 
                    gQuads[self.data.img.texture][self.data.img.quads], 
                    (144 - (8 * (size / 1.5))), (144 - (8 * (size / 1.5)) / 1.5), nil, 
                    size / 1.5, size / 1.5
                )

            end

        end

        if self.data.name then
            self:drawBoxBackToNameData()
            scale = 2
            local w = font:getWidth(self.data.name) * scale
            local boxW = w + (48 * 3)
            local x

            if self.data.img == nil then
                x = ((boxW - w) / 2) - (18 + 25)
            else
                x = ((boxW - w) / 2) + 120
            end

            printb(
                self.data.name, 
                x, (size * 7) - 14, nil, 
                scale, scale, scale, 2
            )
            scale = 3
            
        end

    end

end

function  Textbox:drawBoxBackToImageData()
    local draw = love.graphics.draw
    local size = 8 * scale

    draw(
        gImages["img_data"], 
        4, 50, nil, 
        scale, scale
    )

end

function Textbox:drawBoxBackToNameData()
    local draw = love.graphics.draw
    local size = 8 * scale
    local w
    local x

    if self.data then
        w = font:getWidth(self.data.name) * 2
    end

    if self.data.img == nil then
        x = 4
    else
        x = (size * 7)
    end

    draw(
        gImages["name_data"], 
        gQuads["name_data"][0], 
        x, (size * 6) + 2, 
        nil, scale * 2, scale * 2
    )

    draw(
        gImages["name_data"], 
        gQuads["name_data"][1], 
        x + size, (size * 6) + 2, 
        nil, (w / scale) / 2.5, scale * 2
    )

    draw(
        gImages["name_data"], 
        gQuads["name_data"][2], 
        x + w, (size * 6) + 2, 
        nil, scale * 2, scale * 2
    )

end

return Textbox