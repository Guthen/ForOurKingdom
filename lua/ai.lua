AI = {}

function AI:Load()
	
	self.isPlaying = false
	self.useUnit = true
	
	self.LVLUnits = 
	{
		[1] = 
			{
				["Little"] = { "Goblance", "goblattack", },
				["Fly"] = { "Bat", "rockpose" },
				["Attack"] = { "roco", "slapher", },
				["Spell"] = { "Bouble de feu", },
				["Combo"] = 
					{
						{
							"roco",
							"slapher",
						},
						{
							"rockpose",
							"Bat",
							"goblattack",
						},
					}
			},
		[2] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[3] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[4] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[5] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[6] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[7] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[8] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[9] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[10] = 
			{
				["Little"] = { "Tinks", },
				["Fly"] = { "Ninou", "rockpose" },
				["Attack"] = { "Arognite", },
				["Spell"] = { "Bouble de feu" },
				["Combo"] = 
					{
						{
							"Tinks",
						},
						{
						
							"Ninou",
							"Bouble de feu",
						},
					}
			},
		[11] = 
			{
				["Little"] = { "Elementaire de Feu", "Bloby", },
				["Fly"] = { "Dragon", "Elementaire de Vent" },
				["Attack"] = { "Devoggs", "Demonplante", },
				["Spell"] = { "Trou noir","Ascensorreur" },
				["Combo"] = 
					{
						{
							"Trou noir",
							"Devoggs",
						},
						{
							"Dragon",
							"Demonplante",
							"Ascensorreur",
						},
					},
				useGold = false,
			},
	}
	self.LVL = 1
	self.units = {}
	self.curUnit = ""

	self.curCombo = -1 -- -1 = no combo
	self.goldToCombo = -1 -- -1 = no combo cost
	
	self:LoadUnits()
	
end	

function AI:GetCurLVLVar()
	return self.LVLUnits[self.LVL]
end

function AI:LoadUnits( lvl )
	if lvl then self.LVL = lvl end
	
	self.units = self.LVLUnits[ self.LVL ]
	self.curUnit = self.units["Little"][1]
	
end

function AI:GetCurUnit( trg )
	local unit = ""
	if not trg.info.canBeTarget then
		unit = ""
	elseif trg.info.isFly then 
		unit = self.units[ "Fly" ][ math.random( #self.units["Fly"] ) ]
	elseif not trg.info.isFly then
		if trg.info.hp <= 250 then
			unit = self.units[ "Little" ][ math.random( #self.units["Little"] ) ]
		elseif trg.info.hp <= 200 then
			unit = self.units[ "Attack" ][ math.random( #self.units["Attack"] ) ]
		else
			unit = self.units[ "Spell" ][ math.random( #self.units["Spell"] ) ]
		end
	end
	
	self.curUnit = unit
end

function AI:Update( dt )
	if not self.isPlaying or Players.P2.isDestroyed then return end

	local enemyUnit = false
	--  > Defense <  --
	for y, yv in pairs( Units.yUnits ) do
	
		for x, u in pairs( yv ) do
	
			local isEnemy = u.scale ~= Players.P2.scale
			local can = self.useUnit and Players.P2.gold > 0
			if isEnemy then

				enemyUnit = true
				if can then			
					self:GetCurUnit( u )
					
					--print( "AI: Attempted to spawn : "..self.curUnit )
					
					if string.len( self.curUnit ) > 1 and Players.P2.gold - u.info.cost > 0 then 
						local _x = Units.units[ self.curUnit ] and Units.units[ self.curUnit ].spawnAtCursor and Players.P2.x*Game.ImageSize or 17*Game.ImageSize
						Units:Add( self.curUnit, _x, (y-1)*Game.ImageSize, Players.P2.scale )
						
						self.useUnit = false
						TimerAdd( .35, false, function() self.useUnit = true end )
						
						Players.P2.gold = Players.P2.gold - u.info.cost
						
						print( "AI: Spawn "..self.curUnit )
						print( "AI: Gold = "..Players.P2.gold )
					end
				end
			
			end
			
		end
	
	end

	--  > Attack <  --
	if not enemyUnit then
		
		if self.curCombo <= -1 then -- no combo, so let's get one
			
			self.curCombo = math.random( #self.units[ "Combo" ] ) -- get one combo
			
			local gold = self:GetCurLVLVar().useGold or self:GetCurLVLVar().useGold == nil and 0 or 5
			for k, v in pairs( self.units[ "Combo" ][ self.curCombo ] ) do -- get how many coins it should cost (€)
				if not Units.units[v] then error( v .. " is not a valid unit !", 2 ) end
				if self:GetCurLVLVar().useGold == true or self:GetCurLVLVar().useGold == nil then gold = gold + Units.units[ v ].cost end -- add gold per unit
			end
			self.goldToCombo = gold

		elseif Players.P2.gold >= self.goldToCombo then -- we have enough gold, so let's spawn our troups

			local _x = Units.units[ self.curUnit ] and Units.units[ self.curUnit ].spawnAtCursor and Players.P2.x*Game.ImageSize or 17*Game.ImageSize
			local _y = math.random( 1, 10 )*Game.ImageSize -- get a random 'y' position
			for k, v in pairs( self.units[ "Combo" ][ self.curCombo ] ) do -- spawn each troups
				
				--print( k, v )
				TimerAdd( .5*k, false, function()
					Units:Add( v, _x, _y, Players.P2.scale ) -- spawn 'v' unit
				end )

			end

			Players.P2.gold = Players.P2.gold - self.goldToCombo -- lost the gold

			self.curCombo = -1 -- let's reset the combo values
			self.goldToCombo = -1

		end

	end
end