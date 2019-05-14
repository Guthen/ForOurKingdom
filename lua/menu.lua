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
	table.insert( self.Maps, self.Maps[0] )
	self.MapLimit = #self.Maps*Game.Width
	self.MapX = 0
	self.MapY = 0
	self.MapSpd = 75
end

function Menu:Create()
	UI:ResetObject()
	self.MapX = 0

	Game.MenuState = 1
	
	local title = UI:CreateText( self.defX-90, self.defY-100, 2.5, 2.5, Game.Title )
	local P1control = UI:CreateImage( self.defX*.02, self.defY*2.4, 2, 2, Image[ "P1control" ] )
	local P2control = UI:CreateImage( self.defX*1.6, self.defY*2.4, 2, 2, Image[ "P2control" ] )

	local pvp = UI:CreateButton( self.defX-125, self.defY-37.5, 1, 1 )
		  pvp.removeOnClick = true
		  pvp.img = Image[ "but_pvp" ]
		  pvp.doClick = function( self )
				Game.MenuState = 0
				Reset()
				Map:RandomCurMap()		
				UI:ResetObject()
		  end

	-- l'icône est ici pour être vu au premier-plan
	local icon = UI:CreateImage( self.defX-130, self.defY-70, 3, 3, Image[ "devoggs" ] )
		  icon.isCenter = true
		  icon.onDraw = function( self ) 
				self.ang = math.sin( love.timer.getTime() ) * .2
		  end 

	local pve = UI:CreateButton( self.defX-125, self.defY-37.5+90, 1, 1 )
		  pve.removeOnClick = true
		  pve.img = Image[ "but_pve" ]
		  pve.doClick = function( self )
				Game.MenuState = 0
				Reset()
				AI.isPlaying = true
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

	--  > Check Box <  --

	local fps = UI:CreateCheckBox( Game.Width-100, 10, 1, 1 )
	 	  fps.text = "Show FPS"
	 	  fps.activated = Game.ShowFPS
		  fps.doClick = function( self )
		  		Game.ShowFPS = self.activated
		  end

	--  > Social Network <  --

	local discord = UI:CreateButton( self.defX+4, self.defY-32*-14, 1, 1 )
		  discord.img = Image[ "discord" ]
		  discord.doClick = function( self )
				love.system.openURL( "https://discord.gg/KmTNjvn" )
		  end

	local github = UI:CreateButton( self.defX-68, self.defY-32*-14, 1, 1 )
		  github.img = Image[ "github" ]
		  github.doClick = function( self )
				love.system.openURL( "https://github.com/Guthen/ForOurKingdom" )
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
	if not ply then return end
	UI:ResetObject()

	local back = UI:CreateButton( self.defX*.1, self.defY*3.3, 1, 1 )
		  back.removeOnClick = false
		  back.img = Image[ "but_back" ]
		  back.doClick = function( self )
		  	   	Menu:CreatePlayerInventory()
		  end
 
	
		  

	local Buts = {}
		  Buts.units = {}
		  Buts.inv = {}
		  Buts.void = {}

	local _id = 1

	local _x, _y = 0, 0
	-- show deck slot
	for i = 0, 6 do
		local slot = UI:CreateImage( self.defX*.58+76*i-2, self.defY*.5-2, 1, 1, Image[ "slot" ] )
			  slot.color = ply.color
	end
	-- show deck units
	for k, v in pairs( ply.units ) do

		Buts.units[_id] = UI:CreateButton( self.defX*.58+76*_x, self.defY*.5+76*_y, 2, 2 )
		Buts.units[_id].img = Units.units[v].img
		Buts.units[_id].quad = love.graphics.newQuad( 0, 0, 32, 32, Units.units[v].img:getWidth(), Units.units[v].img:getHeight() )
		Buts.units[_id].isUnit = true
		Buts.units[_id].doClick = function( self )
			if not self.draw then return end
			RemoveValueFromTable( ply.units, v )
			self.draw = false
			table.insert( Buts.void, k )
		end

		_x = _x + 1
		_id = _id + 1

	end

	local _offX, _offY = 0, 100
	_x, _y = 0, 0
	-- show every units
	for k, v in pairs( Units.units ) do

		local slot = UI:CreateImage( self.defX*.35+76*_x-2+_offX, self.defY*.5+76*_y-2+_offY, 1, 1, Image[ "slot" ] )
			  slot.color = Units.Rarety[Units.units[k].rarety or 0].color

		Buts.inv[_id] = UI:CreateButton( self.defX*.35+76*_x+_offX, self.defY*.5+76*_y+_offY, 2, 2 )
		if v.img then
			Buts.inv[_id].img = v.img
			Buts.inv[_id].quad = love.graphics.newQuad( 0, 0, 32, 32, v.img:getWidth(), v.img:getHeight() )
		end
		Buts.inv[_id].isUnit = true
		Buts.inv[_id].doClick = function()
			if #ply.units >= 7 or table.HasValue(ply.units, k) or not Buts.units[ Buts.void[1] ] then return end
			table.insert( ply.units, k )

			Buts.units[ Buts.void[1] ].draw = true
			if v.img then
				Buts.units[ Buts.void[1] ].img = v.img
				Buts.units[ Buts.void[1] ].quad = love.graphics.newQuad( 0, 0, 32, 32, v.img:getWidth(), v.img:getHeight() )
			end

			table.remove( Buts.void, 1 )
		end

		_id = _id + 1

		_x = _x + 1
		if _x > 10 then _y = _y + 1 _x = 0 end

	end

	-- text entry
	local userName = UI:CreateTextEntry( self.defX-75, self.defY-22.5+350, 150, 45 )
		  userName.onEnter = function( self )
		  		print( userName:GetText() ) -- print le texte écrit
		  end
		  
	local save = UI:CreateButton( self.defX+80, self.defY-22.5+350, 1.98, 1.98 )
		  save.img = Image["save"]

	local info = UI:CreateImage( self.defX+144, self.defY-22.5+194, 13.4, 10.4 )
		  info.img = Image["black"]

	local info = UI:CreateImage( self.defX+150, self.defY-22.5+200, 13, 10 )
		  info.img = Image["blanc"]
		  info.onDraw = function()
     	  		love.graphics.setColor(.1, .1, .1)
				end
				UI:CreateText(self.defX+155, self.defY-22.5+220, 1.98, 1.98, "Name: Ascensorreur")
				UI:CreateText(self.defX+155, self.defY-22.5+250, 1.98, 1.98, "Heal: 10000")
				UI:CreateText(self.defX+155, self.defY-22.5+280, 1.98, 1.98, "Domage: 10000")
				UI:CreateText(self.defX+155, self.defY-22.5+310, 1.98, 1.98, "Speed: 1.4")
				UI:CreateText(self.defX+155, self.defY-22.5+340, 1.98, 1.98, "Bio: ")
				love.graphics.setColor(0, 0, 0)
end


function Menu:Key(k)
end

function Menu:Update(dt)
	if math.floor(self.MapX) >= self.MapLimit-5 and math.floor(self.MapX) <= self.MapLimit+5 then self.MapX = 0 end
	self.MapX = self.MapX + self.MapSpd * dt
	self.MapY = 60 + math.cos( love.timer.getTime() ) * 25 -- fait une vague dans le menu ~~~~~~~~
end

function Menu:Draw() 
	for kMap,vMap in pairs(self.Maps) do

		for ky,vy in pairs(vMap) do
			for kx,vx in pairs(vy) do
				if vx > 0 and Map.MapImages[vx] then
					if not Map.MapImages[vx].anim then
						love.graphics.draw(Map.MapImages[vx].img, ((kx-1)*Game.ImageSize+(#vy*Game.ImageSize*kMap-#vy)-self.MapX)*1.2, ((ky-1)*Game.ImageSize-self.MapY)*1.2, 0, Game.ImageSize/Map.MapImages[vx].img:getWidth()*1.2, Game.ImageSize/Map.MapImages[vx].img:getHeight()*1.2)
					else
						love.graphics.draw(Map.MapImages[vx].img, Map.MapImages[vx].anim.quads[Map.MapImages[vx].anim.quad], ((kx-1)*Game.ImageSize+(#vy*Game.ImageSize*kMap-#vy)-self.MapX)*1.2, ((ky-1)*Game.ImageSize-self.MapY)*1.2, 0, Game.ImageSize/Map.MapImages[vx].img:getWidth()*Game.ImageSize/Map.MapImages[vx].img:getWidth()*1.2, Game.ImageSize/Map.MapImages[vx].img:getHeight()*1.2)
					end
				end
			end
		end

	end
end 

Menu:Load()
