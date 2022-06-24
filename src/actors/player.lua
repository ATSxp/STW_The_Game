player = Ents(156, 248)
player.type = "rebelds"
player.name = "marcus"

player.bullets = {}
player.maxTimeToShoot = 0.1
player.timeToShoot = player.maxTimeToShoot

function player:update(dt)
    self:move(dt)
    self:updateBullet(dt)

    self.timeToShoot = self.timeToShoot - dt

    if love.mouse.isDown(1) and self.timeToShoot <= 0 then
        self:shoot()
        self.timeToShoot = self.maxTimeToShoot
    end

end

function player:draw()
    self:drawSprite()
    self:drawBullet()
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

function player:createBullet(x, y, dx, dy)
    local b = Bullet(x, y, dx, dy)

    return b
end

function player:shoot()
    local speed = - 300

    local bullet = self:createBullet(
        self.x + self.w / 2, self.y, 0, speed
    )

    table.insert(self.bullets, bullet)

end

function player:updateBullet(dt)
    for i, v in ipairs(self.bullets)do
        v:update(dt)
    end

    for i = #self.bullets, 1, - 1 do
        if self.bullets[i].collided then
            table.remove(self.bullets, i)    
        end

    end

end

function player:drawBullet()
    for i, v in ipairs(self.bullets)do
        v:draw()
    end

end

return player