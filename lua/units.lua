﻿Units = {}
Units.Rarety = 
{
	[0] = 
	{
		name = "Commun",
		color = 
			{ 
				r = .5,
				g = .5,
				b = .5,
			}
	},
	[1] = 
	{
		name = "Rare",
		color = 
			{ 
				r = .27,
				g = .61,
				b = 1,
			}
	},
	[2] = 
	{
		name = "Épique",
		color = 
			{ 
				r = .95,
				g = .27,
				b = 1,
			}
	},
	[3] = 
	{
		name = "Mythique",
		color = 
			{ 
				r = 1,
				g = .61,
				b = .27,
			}
	}
}
Units.LVLUnits = {}
for i = 1, 10 do Units.LVLUnits[i] = {} end -- create 10 levels

local TowerTargets = 0

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
			local u = require("units/"..n)
			self.units[n] = u
			self.units[n].anim = NewAnim( self.units[n].img, 32, 32, self.units[n].animSpd, self.units[n].animActive )
			
			table.insert( self.LVLUnits[ Clamp( u.lvl or 1, 1, 10 ) ], n ) -- add in lvl units table
		end
	end
end

function Units:Add(typeUnit, x, y, scale)
	if not self.units[typeUnit] then return print("Units:Add() : #1 argument is wrong !") end
	local unit = self.units[typeUnit]
	local u = 
	{
		x = x, 
		y = y, 
		w = Game.ImageSize, 
		h = Game.ImageSize, 
		scale = scale, 
		canMove = true,
		attack = false,
		hasTimerAttack = false,
		anim = NewAnim( unit.img, 32, 32, unit.animSpd ),
		colx = (unit.range or 0)*Game.ImageSize*scale,
		canChangeToDeadImg = true,
	}
	function u:getInfo()
		self.info =
		{
			img = unit.img,
			name = unit.name,
			hp = unit.hp,
			dmg = unit.dmg,
			dSpd = unit.spd,
			spd = unit.spd,
			attackRate = unit.attackRate,
			cost = unit.cost,
			isFly = unit.isFly,
			targetFly = unit.targetFly,
			targetGround = unit.targetGround,
			followTarget = unit.followTarget,
			attackBase = unit.attackBase,
			canBeTarget = unit.canBeTarget,
			animSpd = unit.animSpd,
			animActive = unit.animActive,
			range = unit.range,
			onSpawn = unit.onSpawn,
			onDestroyed = unit.onDestroyed,
			onEnemyKilled = unit.onEnemyKilled,
			onEnemyAttack = unit.onEnemyAttack,
			dieToFirstKill = unit.dieToFirstKill,
			beforeDraw = unit.beforeDraw,
			spawnAtCursor = unit.spawnAtCursor,
			fxOnDead = unit.fxOnDead or true,
			fx = unit.fx,
			lvl = unit.lvl,
			soundOnSpawn = unit.soundOnSpawn,
			soundOnDead = unit.soundOnDead,
			soundOnAttack = unit.soundOnAttack,
		}
	end
	u:getInfo()
	
	if u.info.attackBase == nil then u.info.attackBase = true end
	if u.info.fxOnDead == nil then u.info.fxOnDead = true end
	if u.info.canBeTarget == nil then u.info.canBeTarget = true end
	if u.info.range == nil then u.info.range = 0 end
	if u.colx == 0 then u.colx = Game.ImageSize end
	--print(u.colx)
	function u:Destroy()
		if self.hasTimerAttack then
			TimerDestroy(self.timer)
		end
		if self.info.fxOnDead == true then
			NewFX( Image[self.info.fx or "fx_dust_explosion"], self.x, self.y, 0, .125 )
		end
		--print( self.info.name .. " has been destroyed !" )

		if self.info.onDestroyed then
			self.info.onDestroyed()
			self:getInfo()
		end

		if self.anim then
			RemoveValueFromTable(Anims, self.anim)
		end

		if u.info.soundOnDead then Sound:Play( u.info.soundOnDead, .2, false ) end

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
		if self.info.deadImg == self.info.img then return end
		self.hasTimerAttack = true
		self.timer = TimerAdd(self.info.attackRate, true, function()
			if Players.P1.isDestroyed or Players.P2.isDestroyed then return TimerDestroy( self.timer ) end -- if game is finished, don't attack
			if self.target then
				if self.info.soundOnAttack then Sound:Play( self.info.soundOnAttack, .2, false ) end
				if self.info.onEnemyAttack then self.info.onEnemyAttack(self, self.target) end
				self.target.info.hp = self.target.info.hp - self.info.dmg
				if self.target.info.hp <= 0 then
					local tType = self.target.info.type
					self.target:Destroy()
					if tType ~= "Player" then
						self.target = nil
						self.attack = false
						self.hasTimerAttack = false
						self:StartMove()
						if self.info.onEnemyKilled then
							self.info.onEnemyKilled( self )
							self:getInfo()
						end
						if self.info.dieToFirstKill then
							if self.info.deadImg and self.canChangeToDeadImg then
								self.canChangeToDeadImg = false
								self.info.img = self.info.deadImg
								self.anim = NewAnim( self.info.img, 32, 32, self.info.animSpd, function() self:Destroy() return true end)
								self.info.spd = 0 
							elseif self.canChangeToDeadImg then
								self:Destroy()
							end
						end
						Libs.shack:shake(Libs.shack:getShake()+self.info.dmg/5)
					else
						Libs.shack:shake(Libs.shack:getShake()+self.info.dmg/2)
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

	if u.info.onSpawn then
		u.info.onSpawn()
		u:getInfo()
	end

	if u.info.soundOnSpawn then Sound:Play( u.info.soundOnSpawn, .2, false ) end

	u.info.Destroy = u.Destroy

	table.insert(self.igUnits, u)
	table.insert(self.yUnits[y/Game.ImageSize+1], u)
end

function Units:Update(dt)
	if #self.igUnits == 0 then return end
	if Players.P1.isDestroyed or Players.P2.isDestroyed then return end -- if game is finished, don't attack
	for k, v in pairs(self.igUnits) do
		if v.canMove then
			v.x = v.x + (v.info.spd or .1) * v.scale -- move
			--if v.info.spdY then v.y = v.y + v.info.spdY * v.scale end
		elseif v.attack and v.info.followTarget and v.target and not v.target.info.followTarget and v.target.canMove then -- follow enemy
			if not IsCollideX(v.x, v.target.x, v.w, v.target.w) and v.target.x < v.x then
				v.x = v.x - v.info.spd
			elseif not IsCollideX(v.x, v.target.x, v.w, v.target.w) and v.target.x > v.x then
				v.x = v.x + v.info.spd
			end
		end
		--  > Tower Attack <  --
		if v.x >= 13*Game.ImageSize and v.scale == 1 then -- si atteint 3 case avant la base
			if not v.isTargetByTower and TowerTargets < 3 then
				v.isTargetByTower = true
				TowerTargets = TowerTargets + 1
				TimerAdd(1, false, function() 
					v.info.hp = v.info.hp - 45
					v.isTargetByTower = false
					if v.info.hp <= 0 then v:Destroy() end
					
					TowerTargets = TowerTargets - 1
				end )
			end
		elseif v.x <= 3*Game.ImageSize and v.scale == -1 then
			if not v.isTargetByTower and TowerTargets < 3 then
				v.isTargetByTower = true
				TowerTargets = TowerTargets + 1
				TimerAdd(1, false, function() 
					v.info.hp = v.info.hp - 45
					v.isTargetByTower = false
					if v.info.hp <= 0 then v:Destroy() end
					
					TowerTargets = TowerTargets - 1
				end )
			end
		end
		for _, e in pairs(self.yUnits[v.y/Game.ImageSize+1]) do -- attack
			if e.info.canBeTarget and e.scale ~= v.scale and not v.target then 
				if (v.info.targetGround and not e.info.isFly) or (v.info.targetFly and e.info.isFly) then
					if IsCollideX(v.x, e.x, v.colx, e.w, (v.info.range or 0) > 0) then
						v:StopMove()
						v.target = e
						v.attack = true
						--print(v.info.name .. " has " .. e.info.name .. " as target !")

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
			local offX = v.info.range and v.info.range*Game.ImageSize*-v.scale or 0
			if v.x >= 16*Game.ImageSize + offX and v.scale == 1 then 
				v.attack = true 
				v.target = Players.P2 
				v:StopMove() 
				if not v.hasTimerAttack then v:CreateTimerAttack() end
			end -- stop to base 2
			if v.x <= 3*Game.ImageSize + offX and v.scale == -1 then 
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
		local hp = " ["..v.info.hp.."hp]"
		if v.info.hp >= 5000 then hp = "" end
		love.graphics.printf(v.info.name..hp, v.x-70, v.y-16, 200, "center")

		local offX = 0
		if v.scale == P2.scale then offX = 32 end

		love.graphics.setColor(1, 1, 1)
		
		if v.info.beforeDraw then v.info.beforeDraw() end

		if v.anim then
			love.graphics.draw(v.info.img, v.anim.quads[v.anim.quad], v.x, v.y, 0, v.scale*Game.ImageSize/32, Game.ImageSize/32, offX)
		else
			love.graphics.draw(v.info.img, v.x, v.y, 0, v.scale*Game.ImageSize/v.info.img:getHeight(), Game.ImageSize/v.info.img:getWidth(), offX)
		end

	end
end

Units:Load()
