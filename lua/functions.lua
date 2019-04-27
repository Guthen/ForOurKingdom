--[[-------------------------------------------------------------------------
	TIMERS
---------------------------------------------------------------------------]]
local timers = {}

function TimerAdd(s, loop, func)
	local timer = {s = s, startS = s, func = func, loop = loop}
	table.insert(timers, timer)
	print("TimerAdd() : New Timer with "..s.." seconds with id : "..#timers)
	return timer
end

function TimerDestroy(timer)
	if not timer or type(timer) ~= "table" then return error("TimerDestroy() : #1 argument must be a table !", 2) end
	for k, v in pairs(timers) do
		if timer == v then
			table.remove(timers, k)
			print("TimerDestroy() : Destroy Timer with id : "..k.." !")
		end
	end
end

function TimerUpdate(dt)
	if #timers == 0 then return end
	for k, v in pairs(timers) do
		if v.s <= 0 then
			local f = v.func()
			if v.loop then
				v.s = v.startS
			end
			if not v.loop or f == true then
				TimerDestroy(v)
			end
		else
			v.s = v.s - dt
		end
	end
end

--[[-------------------------------------------------------------------------
	COLLISION
---------------------------------------------------------------------------]]

function IsCollideX(ax, bx, aw, bw, isDist)
	if not IsPositive(aw) and isDist then
		aw = -aw
		ax = ax - aw
	elseif IsPositive(aw) and isDist then
		aw = aw + Game.ImageSize
	end
	return ax < bx + bw and 
		   bx < ax + aw
end

function IsCollide(ax, ay, bx, by, aw, ah, bw, bh)
	if not ax or not ay or not bx or not by or not aw or not ah or not bw or not bh then return end
	return ax < bx + bw and 
		   bx < ax + aw and
		   ay < by + bh and
		   by < ay + ah
end

--[[-------------------------------------------------------------------------
	VALUE
---------------------------------------------------------------------------]]

function RemoveValueFromTable(_table, _value)
	if not _table or not _value or not type(_table) == "table" then return error("RemoveValueFromTable() : #1 or #2 argument is wrong !", 2) end
	for k,v in pairs(_table) do
		if v == _value then
			table.remove(_table, k)
		end
	end
end

function PrintTable(_table)
	if not _table or not type(_table) == "table" then return end
	for k, v in pairs(_table) do
		print(k,v)
	end
end

function table.HasValue(_table, _value)
	if not _table or not type(_table) == "table" then return end
	for _, v in pairs( _table ) do
		if v == _value then return true end
	end
	return false
end

function IsPositive(n)
	return n > 0
end

function GetPositive(n)
	return n < 0 and -n or n
end

function Clamp(n, min, max)
	if not type(n) == "number" then return end
	return n > max and max or n < min and min or n
end

--[[-------------------------------------------------------------------------
	GAME CONTROL
---------------------------------------------------------------------------]]

function Reset()
	timers = {}
	FX = {}
	UI.CanClick = true
	Units:Load()
	Players:Load()

	for _,v in pairs(Sound) do
		if type(v) == "userdata" and v:isPlaying() then v:stop() end
	end
end

function DestroyBase( ply )
	if not ply.info.type == "Player" then return end
	local minX, minY, maxX, maxY
	if ply == Players.P1 then
		minX = 0
		maxX = 4
		minY = 0
		maxY = #Map.Maps[Map.CurrentMap]
	else
		minX = 18
		maxX = #Map.Maps[Map.CurrentMap][1]
		minY = 0
		maxY = #Map.Maps[Map.CurrentMap]
	end
	TimerAdd( .1, true, function()
		NewFX( Image["fx_dust_explosion"], math.random( minX, maxX )*Game.ImageSize, math.random( minY, maxY )*Game.ImageSize, .5, .125 )
	end)
end