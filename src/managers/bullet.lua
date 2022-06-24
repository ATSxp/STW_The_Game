function Bullet(x, y, dx, dy)
    local s = {}
    s.name = "bullet"
    s.sp = nil

    s.x = x or 0
    s.y = y or 0
    s.dx = dx or 0
    s.dy = dy or 0
    s.rad = 3
    s.r = 0

    s.dmg = 1

    s.collided = false
    s.hit = nil

    function s:update(dt)
        if self.sp then
            self.sp:update(dt)
        end

        if self.collided then
            return
        end

        self.dx = dx
        self.dy = dy
        
        self.box = newCircleHitBox(self.x, self.y, self.rad)

        if self.hit then
            self:collide()
        end

        if self.y < - 16 or self.y > (SCREEN_H / SCALE) + 16 then
            self:collide()
        end
        
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
    end

    function s:draw()
        if self.sp then
            self:drawSprite()
        else
            local x = math.clamp(self.rad, self.x, (SCREEN_W / SCALE) - self.rad)
            love.graphics.circle(
                "fill", 
                x, self.y, 
                self.rad
            )

        end

        -- self:drawHitBox()
    end

    function s:drawHitBox()
        if debug.isOn then
            if self.box then
                love.graphics.setColor(0, 0, 1)

                if self.box.mode == "circle" then
                    love.graphics.circle(
                        "line", 
                        self.box.x, self.box.y, self.box.r
                    )
                    
                elseif self.box.mode == "rectangle" then
                    local x, y

                    if self.collider then
                        x, y = self.box.x - self.w / 2, self.box.y - self.h / 2
                    else
                        x, y = self.box.x, self.box.y
                    end

                    love.graphics.rectangle(
                        "line", 
                        x, y, 
                        self.box.w, self.box.h
                    )

                end

                love.graphics.setColor(1, 1, 1)

            end

        end

    end

    function s:drawSprite()
        local anim = self.sp.sprites[self.sp.curSprite]

        love.graphics.draw(
            gImages[anim.texture], 
            gQuads[anim.texture][anim.curFrame], 
            self.x - 8 / 2, self.y - 8 / 2, self.r
        )
    end

    function s:collide()
        if not self.collided then
            for i = 0, 3 do
                local rnd = math.random(0, 1)
                particles:add{
                    x = self.x, y = self.y, 
                    r = 1, dy = 50, max = 0.2, 
                    colors = rnd
                }
                
            end
            
            self.collided = true
        end

    end

    return s
end