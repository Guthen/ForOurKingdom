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

function Sound:Play(son, vol, loop)
		local snd = Sound[son]
		snd:setVolume(vol)
		snd:setLooping(loop)
		snd:play()
	end


function Sound:Stop(son)
		local snd = Sound[son]
		snd:setLooping(loop)
		snd:stop()
	end


Sound:Load()
