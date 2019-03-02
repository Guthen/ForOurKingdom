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

function FadeOut(snd, s)
	if not type(snd) == "Source" then return print("FadeOut() : #1 argument must be a source value.") end 
	snd:stop(s)
end

Sound:Load()
