Map = {}

function Map:Load()
	self.Maps = {}

	self.CurrentMap = "arena_02"

	self.MapImages = 
	{
		[1] = Image["grass"],
		[2] = Image["concrete_grass_left"],
		[3] = Image["concrete_grass_right"],
		[4] = Image["concrete"],
		[5] = Image["terrain_aquatique1"],
		[6] = Image["terrain_aquatique 2"],
		[7] = Image["terrain_aquatique 3"],
		[8] = Image["terrain_aquatique 4"],
	}

	Map:LoadMaps()
end

function Map:LoadMaps()
	for _, v in pairs(love.filesystem.getDirectoryItems("maps")) do
		if string.find(v, ".lua") then
			local n = string.gsub(v, ".lua", "")
			self.Maps[n] = require("maps/"..n)
		end
	end
end

function Map:Draw()
	if not self.Maps[self.CurrentMap] then return end
	love.graphics.setColor(1, 1, 1)
	for ky, vy in pairs(self.Maps[self.CurrentMap]) do
		if type(vy) == "table" then
			for kx, vx in pairs(vy) do
				if vx > 0 and self.MapImages[vx] then
					love.graphics.draw(self.MapImages[vx], (kx-1)*Game.ImageSize, (ky-1)*Game.ImageSize, 0, Game.ImageSize/self.MapImages[vx]:getWidth(), Game.ImageSize/self.MapImages[vx]:getHeight())
				end
			end		
		end
	end
end

Map:Load()