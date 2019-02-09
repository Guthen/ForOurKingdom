Image = {}

function Image:Load()
    if love.filesystem.getInfo("images") then
        for _,v in pairs(love.filesystem.getDirectoryItems("images")) do
			for _, d in pairs(love.filesystem.getDirectoryItems("images/"..v)) do
				if not string.find(d, ".png") then return end 
				self[string.gsub(d, ".png", "")] = love.graphics.newImage("images/"..v.."/"..d)
				self.d = d
			end
        end
    end
end

function Image:Draw()
	--love.graphics.print("d = " .. (self.d or ""), 2, 2)
end

Image:Load()