Map = {}

function Map:Load()
	self.Maps = {}

	self.CurrentMap = "arena_02"

	self.MapImages = 
	{
		--  > Plaine <  --
		[1] = {img = Image["grass"]},
		[2] = {img = Image["concrete_grass_left"]},
		[3] = {img = Image["concrete_grass_right"]},
		[4] = {img = Image["concrete"]},
		--  > Aqua <  --
		[5] = {img = Image["terrain_aquatique1"]},
		[6] = {img = Image["terrain_aquatique 2"]},
		[7] = {img = Image["terrain_aquatique 3"]},
		[8] = {img = Image["terrain_aquatique 4"]},
		--  > Neige <  --
		[9] = {img = Image["snow"]},
		[10] = {img = Image["bad_snow"]},
		[11] = {img = Image["bad_snow_snow_left"]},
		[12] = {img = Image["bad_snow_snow_right"]},
		--  > Démon <  --
		[100] = {img = Image["terrain_demon 1"]},
		[101] = {img = Image["terrain_demon 2"]},
		[102] = {img = Image["terrain_demon 3"]},
		[103] = {img = Image["terrain_demon 4"]},
		-- > Nuage < -- 
		[13] = {img = Image["terrain_nuage2"]},
		[14] = {img = Image["terrain_nuage 2"]},
		[15] = {img = Image["terrain_nuage 3"]},
		[16] = {img = Image["terrain_nuage 4"]},
		-- > jungle < --
		[20] = {img = Image["terrain_jungle 10"]},
		[17] = {img = Image["terrain_jungle 2"]},
		[18] = {img = Image["terrain_jungle 3"]},
		[19] = {img = Image["terrain_jungle 4"]},
		[21] = {img = Image["terrain_jungle 5"]},
		[22] = {img = Image["terrain_jungle 6"]},
		[23] = {img = Image["terrain_jungle 7"]},
		[24] = {img = Image["terrain_jungle 8"]},
		[25] = {img = Image["terrain_jungle 9"]},
		[26] = {img = Image["terrain_jungle 11"]},
		[27] = {img = Image["Tour_d'archer"]},
		[28] = {img = Image["tour_demon"]},
		[29] = {img = Image["Tour_aquatique"]},
	}

	for k,v in pairs(self.MapImages) do
		local s = v.img:getHeight() == 32 and 32 or 16
		v.anim = NewAnim( v.img, s, s, k/2.5 )
	end

	Map:LoadMaps()

	self.MapsID = {}
	for k, _ in pairs(Map.Maps) do
		table.insert( self.MapsID, k )
	end
end

function Map:LoadMaps()
	for _, v in pairs(love.filesystem.getDirectoryItems("maps")) do
		if string.find(v, ".lua") then
			local n = string.gsub(v, ".lua", "")
			self.Maps[n] = require("maps/"..n)
		end
	end
end

function Map:RandomCurMap()
	self.CurrentMap = self.MapsID[ math.random( #self.MapsID ) ]
end

function Map:Draw()
	if not self.Maps[self.CurrentMap] then return end
	love.graphics.setColor(1, 1, 1)
	for ky, vy in pairs(self.Maps[self.CurrentMap]) do
		if type(vy) == "table" then
			for kx, vx in pairs(vy) do
				if vx > 0 and self.MapImages[vx] then
					if not self.MapImages[vx].anim then
						love.graphics.draw(self.MapImages[vx].img, (kx-1)*Game.ImageSize, (ky-1)*Game.ImageSize, 0, Game.ImageSize/self.MapImages[vx].img:getWidth(), Game.ImageSize/self.MapImages[vx].img:getHeight())
					else
						love.graphics.draw(self.MapImages[vx].img, self.MapImages[vx].anim.quads[self.MapImages[vx].anim.quad], (kx-1)*Game.ImageSize, (ky-1)*Game.ImageSize, 0, Game.ImageSize/self.MapImages[vx].img:getWidth()*Game.ImageSize/self.MapImages[vx].img:getWidth(), Game.ImageSize/self.MapImages[vx].img:getHeight())
					end
				end
			end		
		end
	end
end

Map:Load()