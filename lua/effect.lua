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
	e.effect( u )
	table.insert( self.fx, {fx = NewFX( e.img, u.x, u.y, e.lifeTime, e.animSpd ), x = u.x, y = u.y} )
end

function Effect:Update()
	for _, v in pairs( self.fx ) do
		v.fx.x = v.x
		v.fx.y = v.y
	end
end

Effect:Load()