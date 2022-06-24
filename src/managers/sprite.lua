Sprite = {}
function Sprite:new(anim)
    local s = {}
    s.sprites = {}
    s.curSprite = anim.name
    s.f = 0

    function s:add(anim)
        self.sprites[anim.name] = anim
    end
    s:add(anim)

    function s:set(name)
        self.curSprite = name
    end

    function s:reset()
        self.sprites[self.curSprite]:reset()
    end

    function s:update(dt)
        self.sprites[self.curSprite]:update(dt)
    end

    function s:draw(e)
        local anim = self.sprites[self.curSprite]
    
        love.graphics.draw(
            gImages[anim.texture], 
            gQuads[anim.texture][anim.curFrame], 
            e.x, e.y
        )
    end
    
    return s
end
return Sprite