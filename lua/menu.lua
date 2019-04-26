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
	UI:ResetObject()
	self.MapX = 0

	Game.MenuState = 1
	
	local icon = UI:CreateImage( self.defX-175, self.defY-150, 1.2, 1.2, Image[ "fok" ] )

	local pvp = UI:CreateButton( self.defX-125, self.defY-37.5, 1, 1 )
		  pvp.removeOnClick = true
		  pvp.img = Image[ "but_pvp" ]
		  pvp.doClick = function( self )
				Game.MenuState = 0
				Reset()
				Map:RandomCurMap()		
				UI:ResetObject()
		  end

	local pve = UI:CreateButton( self.defX-125, self.defY-37.5+90, 1, 1 )
		  pve.removeOnClick = true
		  pve.img = Image[ "but_pve" ]
		  pve.doClick = function( self )
				Game.MenuState = 0
				Reset()
				Map:RandomCurMap()		
				UI:ResetObject()
		  end

	local inv = UI:CreateButton( self.defX-125, self.defY-37.5+180, 1, 1 )
		  inv.removeOnClick = false
		  inv.img = Image[ "but_inv" ]
		  inv.doClick = function( self )
				Game.MenuState = -1	
				Menu:CreatePlayerInventory()
		  end
	

	local quit = UI:CreateButton( self.defX-125, self.defY-37.5+270, 1, 1 )
		  quit.removeOnClick = true
		  quit.img = Image[ "but_quit" ]
		  quit.doClick = function( self )
				love.event.quit()
		  end

end

function Menu:CreatePlayerInventory()
	UI:ResetObject()

	local ply1 = UI:CreateButton( self.defX-125, self.defY-37.5, 1, 1 )
		  ply1.removeOnClick = false
		  ply1.img = Image[ "but_p1" ]
		  ply1.doClick = function( self )
		  	   	Menu:CreateInventory( Players.P1 )
		  end

	local ply2 = UI:CreateButton( self.defX-125, self.defY-37.5+90, 1, 1 )
		  ply2.removeOnClick = false
		  ply2.img = Image[ "but_p2" ]
		  ply2.doClick = function( self )
		  	   	Menu:CreateInventory( Players.P2 )
		  end

	local back = UI:CreateButton( self.defX*.1, self.defY*3.3, 1, 1 )
		  back.removeOnClick = false
		  back.img = Image[ "but_back" ]
		  back.doClick = function( self )
		  	   	Menu:Create()
		  end

end

function Menu:CreateInventory( ply )
	UI:ResetObject()

	local back = UI:CreateButton( self.defX*.1, self.defY*3.3, 1, 1 )
		  back.removeOnClick = false
		  back.img = Image[ "but_back" ]
		  back.doClick = function( self )
		  	   	Menu:CreatePlayerInventory()
		  end

	local _x, _y = 0, 0
	for k, v in pairs( Units.units ) do

		local slot = UI:CreateImage( self.defX*.35+72*_x-2, self.defY*.5+72*_y-2, 1, 1, Image[ "slot" ] )
			  slot.color = ply.color

		local unit = UI:CreateButton( self.defX*.35+72*_x, self.defY*.5+72*_y, 2, 2 )
			  unit.img = v.img
			  unit.quad = love.graphics.newQuad( 0, 0, 32, 32, v.img:getWidth(), v.img:getHeight() )
			  unit.doClick = function()

			  end

		_x = _x + 1
		if _x > 10 then _y = _y + 1 _x = 0 end

	end

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
