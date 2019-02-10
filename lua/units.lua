Units = {}

function Units:Load()
	self.igUnits = {}
	self.yUnits = {}
	for i = 1, Game.Height/Game.ImageSize do
		table.insert(self.yUnits, {})
	end
	self.units = 
	{
		["Greu"] = 
			{
				img = Image["Greu"],
				name = "Greu",
				hp = 1500,
				dmg = 105,
				spd = .65,
				attackRate = 1.5,
				cost = 12,
				isFly = false,
				targetFly = false,
				targetGround = true,
				followTarget = false,
			},
		["Grea"] = 
			{
				img = Image["Grea"],
				name = "Grea",
				hp = 1200,
				dmg = 125,
				spd = .60,
				attackRate = 1.25,
				cost = 15,
				isFly = false,
				targetFly = false,
				targetGround = true,
				followTarget = false,
			},
		["Norber"] = 
			{
				img = Image["Norber"],
				name = "Norber",
				hp = 2000,
				dmg = 200,
				spd = .40,
				attackRate = 2,
				cost = 19,
				isFly = false,
				targetFly = false,
				targetGround = true,
				followTarget = false,
			},
		["Rockpose"] = 
			{
				img = Image["Rockpose"],
				name = "Rockpose",
				hp = 140,
				dmg = 35,
				spd = 1,
				attackRate = .5,
				cost = 5,
				isFly = true,
				targetFly = true,
				targetGround = true,
				followTarget = true,
			},
		["Goblex"] = 
			{
				img = Image["Goblex"],
				name = "Goblex",
				hp = 100,
				dmg = 45,
				spd = 2,
				attackRate = .75,
				cost = 10,
				isFly = true,
				targetFly = true,
				targetGround = true,
				followTarget = true,
			},
	}
end

function Units:Add(typeUnit, x, y, scale)
	if not self.units[typeUnit] then return error("Units:Add() : #1 argument is wrong !") end
	local u = 
	{
		info = self.units[typeUnit],
		x = x, y = y, 
		w = Game.ImageSize, 
		h = Game.ImageSize, 
		scale = scale, 
		canMove = true,
		attack = false,
		target = {},
		hasTimerAttack = false,
		yId = #self.yUnits+1,
		id = #self.igUnits+1,
	}
	table.insert(self.igUnits, u)
	table.insert(self.yUnits[y/32+1], u)
end

function Units:Destroy(e)
	table.remove(self.igUnits, e.id)
	table.remove(self.yUnits, e.yId)
end

function Units:Update(dt)
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		if v.canMove and not v.attack then
			v.x = v.x + v.info.spd * v.scale -- move
		elseif v.attack and v.info.followTarget then
			if v.target.x < v.x then
				v.x = v.x - v.info.spd
			elseif v.target.x > v.x then
				v.x = v.x + v.info.spd
			end
		end
		for _, e in pairs(self.yUnits[v.y/32+1]) do -- collide
			if e.scale ~= v.scale then 
				if (v.info.targetGround and not e.info.isFly) or (v.info.targetFly and e.info.isFly) then
					if IsCollideX(v, e) and not v.attack then
						--print(v.info.name, v.info.targetGround and not e.info.isFly, v.info.targetFly and e.info.isFly)
						v.attack = true

						v.target = e

						v.canMove = false

						if not v.hasTimerAttack then
							v.hasTimerAttack = true
							v.tId = TimerAdd(v.info.attackRate, true, function()
								if e.info.hp <= 0 then
									v.attack = false
									v.canMove = true
									v.target = nil
									v.hasTimerAttack = false
									self:Destroy(e)
									TimerDestroy(v.tId)
									print(e.info.name.." has been killed by "..v.info.name)
								else
									print(v.info.name.." has attacked "..e.info.name.." ("..e.info.hp..">"..e.info.hp-v.info.dmg..").")
									e.info.hp = e.info.hp - v.info.dmg
								end
							end)
						end
					else
						v.attack = false

						v.canMove = true
					end
				end
			end
		end
		if v.x >= 35*32 and v.scale == 1 then v.attack = true v.target = Players.P2 v.canMove = false end -- stop to base 2
		if v.x <= 4*32 and v.scale == -1 then v.attack = true v.target = Players.P1 v.canMove = false end -- stop to base 1
	end
end

function Units:Draw()
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		love.graphics.draw(v.info.img, v.x, v.y)
	end
end

Units:Load()
