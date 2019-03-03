Sound = {}

function Sound:Load()
    if love.filesystem.getInfo("sounds") then
     for _,v in pairs(love.filesystem.getDirectoryItems("sounds")) do
			for _, d in pairs(love.filesystem.getDirectoryItems("sounds/"..v)) do
				if not string.find(d, ".wav") then return end 
				self[string.gsub(d, ".wav", "")] = love.audio.newSource("sounds/"..v.."/"..d, "stream")				
			end
     	end
    end
end

Sound:Load()
