local timers = {}

function TimerAdd(s, loop, func)
	table.insert(timers, {s = s, startS = s, func = func, loop = loop})
	print("TimerAdd() : New Timer with "..s.." seconds with id : "..#timers)
	return #timers
end

function TimerDestroy(id)
	if not id or type(id) ~= "number" then return error("TimerDestroy() : #1 argument must be a number !", 2) end
	table.remove(timers, id)
	print("TimerDestroy() : Destroy Timer with id : "..id.." !")
end

function TimerUpdate(dt)
	if #timers == 0 then return end
	for k, v in pairs(timers) do
		if v.s <= 0 then
			v.func()
			if v.loop then
				v.s = v.startS
			else
				table.remove(timers, k)
			end
		else
			v.s = v.s - dt
		end
	end
end

function IsCollideX(a, b)
	if not type(a) == "table" or not type(b) == "table" then return end
	return a.x < b.x + b.w and 
		   b.x < a.x + a.w
end

function TakeDamage(ply, trg)
	if not type(ply) == "table" or not type(trg) == "table" then return error("TakeDamage() : #1 or #2 argument(s) are not table.", 2) end
	if not ply.info.dmg or not trg.info.hp then return error("TakeDamage() : The table(s) don't have damage/health info.", 2) end
	trg.info.hp = trg.info.hp - ply.info.dmg
end