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
				["Spell"] = { "Boule de feu", },
			},
	}
	self.LVL = 1
	self.units = {}
	self.curUnit = ""
	
	self:LoadUnits()
	
end	

function AI:LoadUnits()
	
	self.units = self.LVLUnits[ self.LVL ]
	self.curUnit = self.units["Little"][1]
	
end

function AI:GetCurUnit( trg )
	local unit = ""
	if trg.info.isFly then 
		unit = self.units[ "Fly" ][ math.random( #self.units["Fly"] ) ]
	elseif not trg.info.isFly then
		if trg.info.hp <= 250 then
			unit = self.units[ "Little" ][ math.random( #self.units["Little"] ) ]
		else
			unit = self.units[ "Attack" ][ math.random( #self.units["Attack"] ) ]
		end
	elseif not tr.ginfo.canBeTarget then
		unit = ""
	else
		unit = self.units[ "Spell" ][ math.random( #self.units["Spell"] ) ]
	end
	
	self.curUnit = unit
end

function AI:Update( dt )
	if not self.isPlaying or Players.P2.isDestroyed then return end

	for y, yv in pairs( Units.yUnits ) do
	
		for x, u in pairs( yv ) do
	
			local can = self.useUnit and u.scale ~= Players.P2.scale and Players.P2.gold > 0
			if can then
			
				self:GetCurUnit( u )
				
				print( "AI: Attempted to spawn : "..self.curUnit )
				
				if string.len( self.curUnit ) > 1 and Players.P2.gold - u.info.cost > 0 then 
					local _x = Units.units[ self.curUnit ] and Units.units[ self.curUnit ].spawnAtCursor and Players.P2.x*Game.ImageSize or 17*Game.ImageSize
					Units:Add( self.curUnit, _x, (y-1)*Game.ImageSize, Players.P2.scale )
					
					self.useUnit = false
					TimerAdd( .05, false, function() self.useUnit = true end )
					
					Players.P2.gold = Players.P2.gold - u.info.cost
					
					print( "AI: Spawn "..self.curUnit )
				end
			
			end
			
		end
	
	end
end