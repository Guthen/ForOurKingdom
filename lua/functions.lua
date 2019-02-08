local timers = {}

function TimerAdd(s, loop, func)
	table.insert(timers, {s = s, startS = s, func = func, loop = loop})
end

function TimerUpdate(dt)
	if #timers == 0 then return end
	for k, v in pairs(timers) do
		if v.s <= 0 then
			v.func()
		else
			v.s = v.s - dt
			if v.loop then
				v.s = v.startS
			else
				table.remove(timers, k)
			end
		end
	end
end