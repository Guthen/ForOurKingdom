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
	
	local e = self.effects[eff]
	local fx = NewFX( e.fx, u.x, u.y, e.lifeTime, e.animSpd )
	e.effect( u )
	table.insert( self.fx, {fx = fx, u = u} )
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