Units = {}

function Units:Load()
	Units.igUnits = {}
	Units.units = 
	{
		["Greu"] = 
			{
				img = Image["Greu"],
				hp = 1500,
				dmg = 55,
				spd = .40,
				cost = 22,
				isFly = false,
				targetFly = false,
				targetGround = true,
			},
		["Norber"] = 
			{
				img = Image["Norber"],
				hp = 2000,
				dmg = 70,
				spd = .25,
				cost = 30,
				isFly = false,
				targetFly = false,
				targetGround = true,
			},
	}
end

function Units:Add(typeUnit, x, y, scale)
	if not self.units[typeUnit] then return error("Units:Add() : #1 argument is wrong !") end
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
