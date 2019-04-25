Menu = {}

function Menu:Load()
	self.defX = Game.Width/2
	self.defY = Game.Height/2/2

	self.Maps = {}
	local i = 0
	for _, v in pairs(Map.Maps) do
		self.Maps[i] = v
		i = i + 1
	end
	self.MapX = 0
	self.MapSpd = 50
end

function Menu:Create()
	Game.MenuState = 1
	
	local pvp = UI:CreateButton( self.defX-125, self.defY-37.5, 1, 1, true )
		  pvp.removeOnClick = true
		  pvp.img = Image[ "but_pvp" ]
		  pvp.doClick = function( self )
				Game.MenuState = 0
				Reset()
				Map:RandomCurMap()		
				UI:ResetObject("Button")
		  end

	local pve = UI:CreateButton( self.defX-125, self.defY-37.5+90, 1, 1, true )
		  pve.removeOnClick = true
		  pve.img = Image[ "but_pve" ]
		  pve.doClick = function( self )
				Game.MenuState = 0
				Reset()
				Map:RandomCurMap()		
				UI:ResetObject("Button")
		  end

	local quit = UI:CreateButton( self.defX-125, self.defY-37.5+180, 1, 1, true )
		  quit.removeOnClick = true
		  quit.img = Image[ "but_quit" ]
		  quit.doClick = function( self )
				love.event.quit()
		  end

	local icon = UI:CreateImage( self.defX-175, self.defY-150, 1.2, 1.2, Image[ "fok" ] )
end

function Menu:Key(k)
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
end 

Menu:Load()