Units = {}

function Units:Load()
	Units.igUnits = {}
	Units.units = 
	{
		["Greu"] = 
			{
				img = Image["Greu"],
				hp = 1000,
				dmg = 75,
				spd = .25,
				isFly = false,
				targetFly = false,
				targetGround = true,
			},
	}
end

function Units:Add(typeUnit, x, y, scale)
	if not self.units[typeUnit] then return error("Units:Add() : #1 argument is wrong !")
	table.insert(self.igUnits, {unit = self.units[typeUnit], x = x, y = y, scale = scale})
end

function Units:Update(dt)
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		v.x = v.x + v.unit.spd * v.scale
	end
end

function Units:Draw()
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		love.graphics.draw(v.unit.img, v.x, v.y)
	end
end

Units:Load()
