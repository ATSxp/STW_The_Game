local function img(path)
    return love.graphics.newImage("assets/"..path)
end

Images = {
    ["textbox"] = img("utils/textbox.png"), 
}

Quads = {}