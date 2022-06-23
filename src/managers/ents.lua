function Ents(x, y)
    local s = {}
    s.type = "empire"
    s.name = ""

    s.x = x or 0
    s.y = y or 0
    s.w = 8
    s.h = 8

    s.die = false
    s.atk = false

    s.sp = nil

    function s:update(dt)
        if self.sp then
            self.sp:update(dt)
        end
        
    end

    function s:draw()
        if self.sp then
            self:draw(self)
        else
            love.graphics.rectangle(
                "fill", 
                self.x, self.y, self.w, self.h
            )

        end

    end

    return s
end

function updateEnts(dt)
    for i, v in ipairs(ENTS)do
        v:update(dt)
    end

end

function drawEnts()
    for i, v in ipairs(ENTS)do
        v:draw()
    end

end