player = Ents(156, 248)
player.type = "rebelds"
player.name = "marcus"

function player:update(dt)
    self:move(dt)
end

function player:draw()
    self:drawSprite()
end

function player:drawSprite()
    
    if self.sp then
        local anim = self.sp.sprites[self.sp.curSprite]
        love.graphics.draw(
            gImages[anim.texture], 
            gQuads[anim.texture][anim.curFrame], 
            math.clamp(0, self.x, SCREEN_W), math.clamp(0, self.y, SCREEN_H)
        )

    else
        local x, y = math.clamp(0, self.x, (SCREEN_W / SCALE) - self.w), math.clamp(0, self.y, (SCREEN_H / SCALE) - self.h)
        love.graphics.rectangle(
            "fill", 
            x, y, 
            self.w, self.h
        )

    end

end

function player:move(dt)
    local mx, my = rs.toGame(love.mouse.getPosition())
    local mw, mh = self.w * SCALE, self.h * SCALE

    self.x = (mx - mw / 2) / SCALE
    self.y = (my - mh / 2) / SCALE

end

return player