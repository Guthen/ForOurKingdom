Image = {}

function Image:Load()
    if love.filesystem.getInfo("images") then
        for _,v in pairs(love.filesystem.getDirectoryItems("images")) do
            if not string.find(v, ".png") then return end 
            self[string.gsub(v, ".png", "")] = love.graphics.newImage("images/"..v)
        end
    end
end

Image;Load()
