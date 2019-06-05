Effect = {}

function Effect:Load()
	self.effects = {}
	self.fx = {}
	for _, v in pairs(love.filesystem.getDirectoryItems("effects")) do
		if string.find(v, ".lua") then
			local n = string.gsub(v, ".lua", "")
			local eff = require("effects/"..n)
			self.effects[n] = eff
		end
	end
end

function Effect:ApplyTo( eff, u )
	if not eff or not self.effects[eff] then return end
	if not u then return end
   if u.effect then return end
	
	u.effect = self.effects[eff]
	u.effect.effect( u )
	
	local fx = NewFX( u.effect.fx, u.x, u.y, u.effect.lifeTime, u.effect.animSpd )
   local t = {fx = fx, u = u}
TimerAdd( u.effect.lifeTime, false, function() 
    u.effect = nil
    RemoveValueFromTable( self.fx, t )
   end )
	table.insert( self.fx, t )
end

function Effect:Update()
	for _, v in pairs( self.fx ) do
		if v.fx then
			v.fx.x = v.u.x
			v.fx.y = v.u.y
		end
	end
end

Effect:Load()