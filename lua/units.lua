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
		info = 
		{
			img = self.units[typeUnit].img,
			name = self.units[typeUnit].name,
			hp = self.units[typeUnit].hp,
			dmg = self.units[typeUnit].dmg,
			spd = self.units[typeUnit].spd,
			attackRate = self.units[typeUnit].attackRate,
			cost = self.units[typeUnit].cost,
			isFly = self.units[typeUnit].isFly,
			targetFly = self.units[typeUnit].targetFly,
			targetGround = self.units[typeUnit].targetGround,
			followTarget = self.units[typeUnit].followTarget,
		},
		x = x, y = y, 
		w = Game.ImageSize, 
		h = Game.ImageSize, 
		scale = scale, 
		canMove = true,
		attack = false,
		hasTimerAttack = false,
	}
	function u:Destroy()
		if self.hasTimerAttack then
			TimerDestroy(self.timer)
		end
		print(self.info.name .. " has been destroyed !")
		RemoveValueFromTable(Units.igUnits, self)
		RemoveValueFromTable(Units.yUnits[self.y/32+1], self)
	end
	function u:StartMove()
		self.canMove = true
	end
	function u:StopMove()
		self.canMove = false
	end
	function u:CreateTimerAttack()
		self.hasTimerAttack = true
		self.timer = TimerAdd(self.info.attackRate, true, function()
			if self.target then
				self.target.info.hp = self.target.info.hp - self.info.dmg
				if self.target.info.hp <= 0 then
					local tType = self.target.info.type
					self.target:Destroy()
					if tType ~= "Player" then
						self.target = nil
						self.attack = false
						self.hasTimerAttack = false
						self:StartMove()
					end
					TimerDestroy(self.timer)
				end
				if self.info.hp <= 0 then
					self:Destroy()
					TimerDestroy(self.timer)
				end
			end
		end)
	end
	table.insert(self.igUnits, u)
	table.insert(self.yUnits[y/32+1], u)
end

function Units:Update(dt)
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		if v.canMove then
			v.x = v.x + v.info.spd * v.scale -- move
		elseif v.attack and v.info.followTarget and v.target and not v.target.info.followTarget and v.target.canMove then -- follow enemy
			if v.target.x < v.x then
				v.x = v.x - v.info.spd
			elseif v.target.x > v.x then
				v.x = v.x + v.info.spd
			end
		end
		for _, e in pairs(self.yUnits[v.y/32+1]) do -- attack
			if e.scale ~= v.scale and not v.target then 
				if (v.info.targetGround and not e.info.isFly) or (v.info.targetFly and e.info.isFly) then
					if IsCollideX(v, e) then
						v:StopMove()
						v.target = e
						v.attack = true
						print(v.info.name .. " has " .. e.info.name .. " as target !")

						if e and not v.hasTimerAttack then -- timer for attack
							v:CreateTimerAttack()
						end

					elseif not v.target then -- go away
						v.attack = false
						v:StartMove()
					end
				end
			end
		end
		if v.x >= 35*32 and v.scale == 1 then 
			v.attack = true 
			v.target = Players.P2 
			v:StopMove() 
			if not v.hasTimerAttack then v:CreateTimerAttack() end
		end -- stop to base 2
		if v.x <= 4*32 and v.scale == -1 then 
			v.attack = true 
			v.target = Players.P1 
			v:StopMove()  
			if not v.hasTimerAttack then v:CreateTimerAttack() end
		end -- stop to base 1
	end
end

function Units:Draw()
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		local P1 = Players.P1
		local P2 = Players.P2
		if v.scale == P1.scale then
			love.graphics.setColor(P1.color.r, P1.color.g, P1.color.b)
		elseif v.scale == P2.scale then
			love.graphics.setColor(P2.color.r, P2.color.g, P2.color.b)
		end
		love.graphics.printf(v.info.name.." ["..v.info.hp.."hp]", v.x-86, v.y-16, 200, "center")
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(v.info.img, v.x, v.y)
	end
end

Units:Load()
