Units = {}

function Units:Load()
	self.igUnits = {}
	self.yUnits = {}
	for i = 1, Game.Height/Game.ImageSize do
		table.insert(self.yUnits, {})
	end
	self:LoadUnits()
end

function Units:LoadUnits()
	self.units = {}
	for _, v in pairs(love.filesystem.getDirectoryItems("units")) do
		if string.find(v, ".lua") then
			local n = string.gsub(v, ".lua", "")
			self.units[n] = require("units/"..n)
			self.units[n].anim = NewAnim( self.units[n].img, 32, 32, self.units[n].animSpd )
		end
	end
end

function Units:Add(typeUnit, x, y, scale)
	if not self.units[typeUnit] then return print("Units:Add() : #1 argument is wrong !") end
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
			attackBase = self.units[typeUnit].attackBase,
			canBeTarget = self.units[typeUnit].canBeTarget,
			animSpd = self.units[typeUnit].animSpd,
			range = self.units[typeUnit].range,
		},
		x = x, y = y, 
		w = Game.ImageSize, 
		h = Game.ImageSize, 
		scale = scale, 
		canMove = true,
		attack = false,
		hasTimerAttack = false,
		anim = NewAnim( self.units[typeUnit].img, 32, 32, self.units[typeUnit].animSpd ),
		colx = (self.units[typeUnit].range or 0)*Game.ImageSize*scale,
	}
	if u.info.attackBase == nil then u.info.attackBase = true end
	if u.info.canBeTarget == nil then u.info.canBeTarget = true end
	if u.info.range == nil then u.info.range = 0 end
	if u.colx == 0 then u.colx = Game.ImageSize end
	print(u.colx)
	function u:Destroy()
		if self.hasTimerAttack then
			TimerDestroy(self.timer)
		end
		print(self.info.name .. " has been destroyed !")
		RemoveValueFromTable(Units.igUnits, self)
		RemoveValueFromTable(Units.yUnits[self.y/Game.ImageSize+1], self)
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
	table.insert(self.yUnits[y/Game.ImageSize+1], u)
end

function Units:Update(dt)
	if #self.igUnits == 0 then return end
	for k, v in pairs(self.igUnits) do
		if v.canMove then
			v.x = v.x + v.info.spd * v.scale -- move
		elseif v.attack and v.info.followTarget and v.target and not v.target.info.followTarget and v.target.canMove then -- follow enemy
			if not IsCollideX(v.x, v.target.x, v.w, v.target.w) and v.target.x < v.x then
				v.x = v.x - v.info.spd
			elseif not IsCollideX(v.x, v.target.x, v.w, v.target.w) and v.target.x > v.x then
				v.x = v.x + v.info.spd
			end
		end
		for _, e in pairs(self.yUnits[v.y/Game.ImageSize+1]) do -- attack
			if e.info.canBeTarget and e.scale ~= v.scale and not v.target then 
				if (v.info.targetGround and not e.info.isFly) or (v.info.targetFly and e.info.isFly) then
					if IsCollideX(v.x, e.x, v.colx, e.w) then
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
		if v.info.attackBase then
			if v.x >= 16*Game.ImageSize and v.scale == 1 then 
				v.attack = true 
				v.target = Players.P2 
				v:StopMove() 
				if not v.hasTimerAttack then v:CreateTimerAttack() end
			end -- stop to base 2
			if v.x <= 3*Game.ImageSize and v.scale == -1 then 
				v.attack = true 
				v.target = Players.P1 
				v:StopMove()  
				if not v.hasTimerAttack then v:CreateTimerAttack() end
			end -- stop to base 1
		else
			if v.x < -1*Game.ImageSize or v.x > 20*Game.ImageSize then
				v:Destroy()
			end
		end
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
		love.graphics.printf(v.info.name.." ["..v.info.hp.."hp]", v.x-70, v.y-16, 200, "center")

		local offX = 0
		if v.scale == P2.scale then offX = 32 end

		love.graphics.setColor(1, 1, 1)

		if v.anim then
			love.graphics.draw(v.info.img, v.anim.quads[v.anim.quad], v.x, v.y, 0, v.scale*Game.ImageSize/32, Game.ImageSize/32, offX)
		else
			love.graphics.draw(v.info.img, v.x, v.y, 0, v.scale*Game.ImageSize/v.info.img:getHeight(), Game.ImageSize/v.info.img:getWidth(), offX)
		end

		if v.info.range > 0 then
			love.graphics.rectangle("line", v.x, v.y, v.info.range*Game.ImageSize*v.scale, 64)
		end

	end
end

Units:Load()
