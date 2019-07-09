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
	self.MapSpd = 100
end

function Menu:Create( resetX )
	Sound:Play( "Menu Music", 1, true )

	UI:ResetObject()
	if resetX then self.MapX = 0 end

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
	local icon = UI:CreateImage( self.defX-140, self.defY-80, 3, 3, Image[ "Devoggs" ] )
		  icon.ox = 16
		  icon.oy = 16
		  icon.quad = love.graphics.newQuad( 0, 0, 32, 32, Image["Devoggs"]:getWidth(), Image["Devoggs"]:getHeight() )
		  icon.onDraw = function( self ) 
				self.ang = math.sin( love.timer.getTime() ) * .2
		  end 

	local pve = UI:CreateButton( self.defX-125, self.defY-37.5+90, 1, 1 )
		  pve.removeOnClick = true
		  pve.img = Image[ "but_pve" ]
		  pve.doClick = function( self )
				Menu:CreatePVESelection()
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

function Menu:CreatePVESelection()
	UI:ResetObject()

	local x, y = 1, 0
	for i = 1, 11 do
		
		local level = UI:CreateButton( self.defX*.05 + x * 128, self.defY*.9 + y * 128, 1.4, 1.4 )
		      level.img = Image[ "number_" .. tostring( i ) ]
		      level.doClick = function( )
					if Players.P1.PVElvl < i then return end
			      	Game.MenuState = 0
					Reset()
					AI.isPlaying = true
					AI:LoadUnits( i )
					Map:RandomCurMap()		
					UI:ResetObject()
		  	  end
			  if Players.P1.PVElvl < i then level.color = { r = .3, g = .3, b = .3 } end
		  	  level.lvl = i
		  	  level.onDraw = function()
					if level.lvl == 11 then 
		  	  			love.graphics.setColor( math.random(), math.random(), math.random() )
		  	  		end
		  	  end

		x = x + 1
		if i % 8 == 0 then y = y + 1 x = 1 end

	end

	local text = UI:CreateText( self.defX-125, self.defY-100, 3, 3, "Level Selection Menu" )

	local back = UI:CreateButton( self.defX*.1, self.defY*3.3, 1, 1 )
		  back.removeOnClick = false
		  back.img = Image[ "but_back" ]
		  back.doClick = function( self )
		  	   	Menu:Create()
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

    local unit = Units.units["greu"]

    local infoBackground, infoOutline
    local infoName
    local infoHP
    local infoDmg
    local infoCost
    local infoDesc
	local infoLVL

	local back = UI:CreateButton( self.defX*.1, self.defY*3.3, 1, 1 )
		  back.removeOnClick = false
		  back.img = Image[ "but_back" ]
		  back.doClick = function( self )
		  	   	Menu:CreatePlayerInventory()
		  end	  

	local Buts = {}
		  Buts.units = {}
		  Buts.inv = {}

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
		Buts.units[_id].img = Units.units[v] and Units.units[v].img or Image["Devoggs"]
		Buts.units[_id].quad = love.graphics.newQuad( 0, 0, 32, 32, Buts.units[_id].img:getWidth(), Buts.units[_id].img:getHeight() )
		Buts.units[_id].isUnit = true
		Buts.units[_id].doClick = function( self )
			if not self.draw then return end
			RemoveValueFromTable( ply.units, v )
			self.draw = false

			Menu:CreateInventory( ply ) -- reload
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
		
		local secret, unknow
		if v.secret then
			secret = UI:CreateImage( self.defX*.35+76*_x-2+_offX, self.defY*.5+76*_y-2+_offY, 2, 2, Image[ "secret" ] )
			Buts.inv[_id].color = { r = .2, g = .2, b = .2 }
		elseif ( v.lvl or 10 ) > ply.lvl then
			unknow = UI:CreateImage( self.defX*.35+76*_x-2+_offX, self.defY*.5+76*_y-2+_offY, 2, 2, Image[ "unknow" ] )
			Buts.inv[_id].color = { r = .5, g = .5, b = .5 }
		end
		
		Buts.inv[_id].doClick = function()
			if #ply.units >= 7 or table.HasValue( ply.units, k ) then return end
			if secret or unknow then return end
			table.insert( ply.units, k )

			Menu:CreateInventory( ply ) -- reload
		end
		Buts.inv[_id].doRightClick = function()
			local show = secret or unknow
			
			infoOutline = UI:CreateImage( self.defX+144, self.defY-22.5+194, 13.4, 10.4 )
				infoOutline.deleteOnRightClickRelease = true
				infoOutline.img = Image["black"]

			infoBackground = UI:CreateImage( self.defX+150, self.defY-22.5+200, 13, 10 )
				infoBackground.deleteOnRightClickRelease = true
				infoBackground.img = Image["blanc"]
				infoBackground.onDraw = function()
		     	  	love.graphics.setColor(.1, .1, .1)
				end

			infoLVL = UI:CreateText(self.defX+485, self.defY-22.5+210, 1.98, 1.98, "")
				infoLVL.deleteOnRightClickRelease = true
			infoName = UI:CreateText(self.defX+155, self.defY-22.5+210, 1.98, 1.98, "")
				infoName.deleteOnRightClickRelease = true
			infoHP = UI:CreateText(self.defX+155, self.defY-22.5+240, 1.98, 1.98, "")
				infoHP.deleteOnRightClickRelease = true
			infoDmg = UI:CreateText(self.defX+155, self.defY-22.5+270, 1.98, 1.98, "")
				infoDmg.deleteOnRightClickRelease = true
			infoCost = UI:CreateText(self.defX+155, self.defY-22.5+300, 1.98, 1.98, "")
				infoCost.deleteOnRightClickRelease = true
			infoDesc = UI:CreateText(self.defX+155, self.defY-22.5+330, 1.98, 1.98, "")
				infoDesc.deleteOnRightClickRelease = true
			infoDesc.limit = 210

			unit = Units.units[k]
			infoName.text = "Name: "..(not show and unit.name or "?")
			infoHP.text = "Health: "..(not show and unit.hp or "?")
			infoDmg.text = "Damage: "..(not show and unit.dmg or "?")
			infoCost.text = "Cost: "..(not show and unit.cost or "?")
			infoDesc.text = "Description: "..(not show and unit.desc or "?")
			infoLVL.text = "Level: ".. unit.lvl
		end

		_id = _id + 1

		_x = _x + 1
		if _x > 10 then _y = _y + 1 _x = 0 end

	end
	
	--	user info
	local userName = UI:CreateText(25, 20, 1.98, 1.98, "Name: "..ply.name)

	UI:CreateImage( 25, 50, 2, 3, Image[ "Contoure barrre xp" ] )
	UI:CreateImage( 25, 50, 2, 3, Image[ "Barre xp " ] )
	local xpBar = UI:CreateImage( 25, 50, (ply.xp/ply.nxp or 0)*2, 3, Image[ "Barre xp " ] )
		xpBar.color = { r = .1, g = .7, b = .1 }
	
	local lvl = UI:CreateText(35, 60, 1.98, 1.98, "LVL: "..ply.lvl)	
		lvl.color = { r = 0, g = 0, b = 0 }
	local xp = UI:CreateText(130, 60, 1.98, 1.98, string.format( "XP: %s (%s)", ply.xp, tostring( math.floor( ply.xp/ply.nxp*100 ) .. "%" ) ))
		xp.color = { r = 0, g = 0, b = 0 }
	
	-- text entry
	local userNameTE = UI:CreateTextEntry( self.defX-75, self.defY-22.5+350, 150, 45 )
		  userNameTE.onEnter = function( self )
		  		print( userNameTE:GetText() ) -- print le texte écrit
		  end
		  
	local save = UI:CreateButton( self.defX+80, self.defY-22.5+350, 3, 3 )
		  save.img = Image["save"]
		  save.doClick = function()
				Players:SavePlayer( ply, userNameTE:GetText() )
		  end
		  
	local _load = UI:CreateButton( self.defX+80, self.defY-22.5+296, 3, 3 )
		  _load.img = Image["load"]
		  _load.doClick = function()
				Players:LoadPlayer( ply, userNameTE:GetText() )
				Menu:CreateInventory( ply )
		  end	  
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
			
			if type( vy ) == "table" then
				for kx,vx in pairs(vy) do
					if vx > 0 and Map.MapImages[vx] then
						if not Map.MapImages[vx].anim then
							love.graphics.draw(Map.MapImages[vx].img, ((kx-1)*Game.ImageSize+(#vy*Game.ImageSize*kMap-#vy)-self.MapX)*1.2, ((ky-1)*Game.ImageSize-self.MapY)*1.2, 0, Game.ImageSize/Map.MapImages[vx].img:getWidth()*1.2, Game.ImageSize/Map.MapImages[vx].img:getHeight()*1.2)
						else
							love.graphics.draw(Map.MapImages[vx].img, Map.MapImages[vx].anim.quads[Map.MapImages[vx].anim.quad], ((kx-1)*Game.ImageSize+(#vy*Game.ImageSize*kMap-#vy)-self.MapX)*1.2, ((ky-1)*Game.ImageSize-self.MapY)*1.2, 0, Game.ImageSize/Map.MapImages[vx].img:getHeight()*1.2, Game.ImageSize/Map.MapImages[vx].img:getHeight()*1.2)
						end
					end
				end
			end

		end

	end
end 

Menu:Load()
