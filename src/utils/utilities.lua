function logConsole(str)
    print("================================================================================"..string.upper(tostring(str)).."\n")
end

function logError(str)
    error("\n===========================================\n"..str.."\n===========================================")
end

function loadQuads(img, spriteW, spriteH)
    local img = img
    local w, h
    local spriteSheet = {}
    local spriteCounter = 0

    if img then
        w = img:getWidth() / spriteW
        h = img:getHeight() / spriteH
    else
        logError("Você esqueceu de adicionar uma imagem no 1# da função loadQuads")
    end

    for y = 0, h - 1 do
        for x = 0, w - 1 do
            spriteSheet[spriteCounter] = love.graphics.newQuad(
                x * spriteW, y * spriteH, 
                spriteW, spriteH,
                img:getDimensions()
            )

            spriteCounter = spriteCounter + 1
        end
    end

    return spriteSheet
end

function setColor(r, g, b, a)
    love.graphics.setColor(r / 255, g / 255, b / 255, a)
end

function setBackgroundColor(r, g, b, a)
    love.graphics.setBackgroundColor(r / 255, g / 255, b / 255, a)
end

-- by: pgimeno | Thank you =)
local utf8offset=utf8.offset
local string_sub = string.sub
local select = select
string.ulen = utf8.len
function string.usub(s, start_in_chars, ...)
  local start_in_bytes = utf8offset(s, start_in_chars)
  if start_in_bytes == nil then
    start_in_bytes = #s + 1
    if start_in_chars < 0 then
      start_in_bytes = -start_in_bytes
    end
  end

  if select('#', ...) == 0 then -- no second arg
    return string_sub(s, start_in_bytes)
  end

  local end_in_chars = ...
  if end_in_chars == -1 then -- -1 doesn't go well with the +1 needed later
    return string_sub(s, start_in_bytes)
  end

  local end_in_bytes = utf8offset(s, end_in_chars + 1)
  if end_in_bytes == nil then
    end_in_bytes = #s + 1
    if end_in_chars < 0 then
      end_in_bytes = -end_in_bytes
    end
  end
  return string_sub(s, start_in_bytes, end_in_bytes - 1)
end

function newRectangleHitBox(x, y, w, h)
    return {
        mode = "rectangle", 
        x = x or 0, 
        y = y or 0, 
        w = w or 8, 
        h = h or 8
    }
end

function newCircleHitBox(x, y, r)
    return {
        mode = "circle", 
        x = x or 0, 
        y = y or 0, 
        r = r or 5
    }
end

function Dist(ax, ay, ar, bx, by, br)
	local dx = bx - ax
	local dy = by - ay
	local dist = math.sqrt(dx * dx + dy * dy)
	return dist < (ar + br)
end

function AABB(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 + w1 >= x2 and
    x2 + w2 >= x1 and
    y1 + h1 >= y2 and
    y2 + h2 >= y1
end

-- By https://2dengine.com | Thank you =)
function circleVsBox(cx, cy, cr, x, y, hw, hh)
    local dx = math.abs(x - cx)
    local dy = math.abs(y - cy)
    dx = math.max(dx - hw, 0)
    dy = math.max(dy - hh, 0)
    return dx*dx + dy*dy <= cr*cr
end