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
	if not type(a) == "number" or not type(b) == "number" then return end
	if not IsPositive(aw) and isDist then
		aw = -aw
		ax = ax - aw
	elseif IsPositive(aw) and isDist then
		aw = aw + Game.ImageSize
	end
	return ax < bx + bw and 
		   bx < ax + aw
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

function IsPositive(n)
	return n > 0
end

function GetPositive(n)
	if n < 0 then
		return -n
	end 
	return n
end

function Clamp(n, min, max)
	if not type(n) == "number" then return end
	if n > max then
		n = max
	elseif n < min then
		n = min
	end
	return n
end

--[[-------------------------------------------------------------------------
	GAME CONTROL
---------------------------------------------------------------------------]]

function Reset()
	timers = {}
	Units:Load()
	Players:Load()
end