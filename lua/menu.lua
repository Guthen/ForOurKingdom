Menu = {}

function Menu:Load()
	self.defX = Game.Width/2
	self.defY = Game.Height/2/2
	self.cursor = 
	{
		x = Game.Width/2-178.5, 
		y = Game.Height/2/2-12.5,
		id = 0,
	}
	
	self.firstMenu = 
	{
		[0] = 
		{
			img = Image["but_pvp"],
			func = function() 
				Game.MenuState = 0 
			end 
		},
		[1] = 
		{
			img = Image["but_pve"],
			func = function() 
				Game.MenuState = 0 
			end 
		},
	} 
	self.Maps = {}
	local i = 0
	for _, v in pairs(Map.Maps) do
		self.Maps[i] = v
		i = i + 1
	end
	self.MapX = 0
	self.MapSpd = 50
end

function Menu:Key(k)
	if k == "down" or k == "s" then
		self.cursor.id = self.cursor.id == #self.firstMenu and 0 or self.cursor.id + 1
	elseif k == "up" or k == "z" then
		self.cursor.id = self.cursor.id == 0 and #self.firstMenu or self.cursor.id - 1
	elseif k == "return" then
		self.firstMenu[self.cursor.id].func()
		Reset()
		Map:RandomCurMap()
	end
end

function Menu:Update(dt)
	self.MapX = self.MapX + self.MapSpd * dt
end

function Menu:Draw() 
	for kMap,vMap in pairs(self.Maps) do

		for ky,vy in pairs(vMap) do
			for kx,vx in pairs(vy) do
				if vx > 0 and Map.MapImages[vx] then
					if not Map.MapImages[vx].anim then
						love.graphics.draw(Map.MapImages[vx].img, (kx-1)*Game.ImageSize+(#vy*Game.ImageSize*kMap-#vy)-self.MapX, (ky-1)*Game.ImageSize, 0, Game.ImageSize/Map.MapImages[vx].img:getWidth(), Game.ImageSize/Map.MapImages[vx].img:getHeight())
					else
						love.graphics.draw(Map.MapImages[vx].img, Map.MapImages[vx].anim.quads[Map.MapImages[vx].anim.quad], (kx-1)*Game.ImageSize+(#vy*Game.ImageSize*kMap-#vy)-self.MapX, (ky-1)*Game.ImageSize, 0, Game.ImageSize/Map.MapImages[vx].img:getWidth()*Game.ImageSize/Map.MapImages[vx].img:getWidth(), Game.ImageSize/Map.MapImages[vx].img:getHeight())
					end
				end
			end
		end

	end
	for k, v in pairs(self.firstMenu) do
		love.graphics.draw( v.img, self.defX, self.defY+90*k, 0, 1, 1, v.img:getWidth()/2, v.img:getHeight()/2 )
	end
	love.graphics.rectangle( "fill", self.cursor.x, self.cursor.y+self.cursor.id*90, 25, 25 )
end 

Menu:Load()