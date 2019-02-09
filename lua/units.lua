Units = {}

function Units:Load()
	self.igUnits = {}
	self.yUnits = {}
	for i = 1, Game.Height/Game.ImageSize do
		table.insert(self.yUnits, {})
		print(i, self.yUnits[i])
	end
	self.units = 
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
	local u = {unit = self.units[typeUnit], x = x, y = y, w = Game.ImageSize, h = Game.ImageSize, scale = scale, canMove = true}
	table.insert(self.igUnits, u)
	table.insert(self.yUnits[y/32], u)
end

function Units:Update(dt)
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		if v.canMove then
			v.x = v.x + v.unit.spd * v.scale -- move
		end
		for _, e in pairs(self.yUnits[math.floor(v.y/32)]) do
			if e.scale ~= v.scale then 
				if IsCollide(v, e) then
					v.canMove = false
					e.canMove = false
				else
					v.canMove = true
					e.canMove = true
				end
			end
		end
	end
end

function Units:Draw()
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		love.graphics.draw(v.unit.img, v.x, v.y)
	end
end

Units:Load()
