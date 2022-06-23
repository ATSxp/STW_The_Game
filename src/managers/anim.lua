Anim = {}
function Anim:new(name, texture, frames, duration, loop)
    local s = {}
    s.name = name
    s.texture = texture
    s.frames = frames or {}
    s.duration = duration or 0.5
    s.loop = loop or false
    s.curFrame = frames[1]
    s.indx = 0
    s.tick = 0
    s.ended = false

    function s:update(dt)
        if self.tick >= self.duration and #self.frames > 0 then
            self.tick = 0

            if self.loop then
                self.indx = (self.indx + 1) % #self.frames
                self.curFrame = self.frames[self.indx + 1]
                self.ended = false
            else
                self.indx = self.indx < #self.frames and self.indx + 1 or #self.frames
                self.curFrame = self.frames[self.indx]

                if self.indx == #self.frames then
                    self.ended = true
                end

            end

            
        end
        
        self.tick = self.tick + dt
        
    end

    function s:reset()
        self.indx = 0
        self.ended = false
    end
    return s
end
return Anim