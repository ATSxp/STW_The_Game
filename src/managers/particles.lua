particles = {}

function particles:add(part)
    table.insert(PARTS, part)
end

function particles:update(dt)
    for i, v in ipairs(PARTS)do
        v.t = v.t and v.t + dt or 0
        v.typeAxis = v.typeAxis or "random"
        v.x = v.typeAxis == "random" and v.x + math.random(- 100, 100) * dt or v.x
        v.y = v.typeAxis == "random" and v.y + math.random(- 100, 100) * dt or v.y
        v.x = v.x + (v.dx or 0) * dt
        v.y = v.y + (v.dy or 0) * dt
        v.mode = v.mode or "circle"
        v.alphaMode = v.alphaMode or false
        v.alpha = v.alpha or 1

        if v.t > (v.max or 1)then
            if v.alphaMode then
                v.alpha = v.alpha - dt

                if v.alpha <= 0 then
                    table.remove(PARTS, i)
                end

            else
                table.remove(PARTS, i)
            end

        end

    end

end

function particles:draw()
    for i, v in ipairs(PARTS)do
        v.colors = v.colors or 0
        v.colorBorder = v.colorBorder or 0
        
        local cor = getColor(v.colors)
        setColor(cor[1], cor[2], cor[3], v.alpha)

        if v.mode == "text" then            
            printb(
                v.text or "nil", 
                v.x, v.y, v.r or 0, 
                v.scale or 1, v.scale or 1, 
                v.scale or 1, v.colors, 
                v.colorBorder, v.alpha
            )
            
        elseif v.mode == "circle" then
            love.graphics.circle(
                "fill", 
                v.x, v.y, v.r or 1
            )
            
        elseif v.mode == "rectangle" then
            love.graphics.rectangle(
                "fill", 
                v.x, v.y, v.w or 1, v.h or 1
            )

        elseif v.mode == "circle_line" then
            love.graphics.circle(
                "line", 
                v.x, v.y, v.r or 1
            )
            
        elseif v.mode == "rectangle_line" then
            love.graphics.rectangle(
                "line", 
                v.x, v.y, v.w or 1, v.h or 1
            )

        elseif v.mode == "circle_borded" then
            setColor(unpack(getColor(v.colorBorder)))
            love.graphics.circle(
                "line", 
                v.x, v.y, v.r + 0.1 or 1
            )

            setColor(unpack(getColor(v.colors)))
            love.graphics.circle(
                "fill", 
                v.x, v.y, v.r or 1
            )


        elseif v.mode == "sprite" then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(
                Images[v.sp or nil], 
                v.x , v.y, v.r or nil, 
                v.sx or 1, v.sy or 1
            )

        end

        love.graphics.setColor(1, 1, 1)
    end

end
return particles