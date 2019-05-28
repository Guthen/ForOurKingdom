--[[-------------------------------------------------------------------------
	TIMERS
---------------------------------------------------------------------------]]
local timers = {}

function TimerAdd(s, loop, func)
	local timer = {s = s, startS = s, func = func, loop = loop}
	table.insert(timers, timer)
	print("TimerAdd() : New Timer with "..s.." seconds")
	return timer
end

function TimerRepeat(s, times, func)
	times = times <= 0 and 0 or times
	local timer = {s = s, startS = s, func = func, times = times, isRepeat = true}
	table.insert(timers, timer)
	print("TimerRepeat() : New Timer with "..s.." seconds")
	return timer
end

function TimerDestroy(timer)
	if not timer or type(timer) ~= "table" then return error("TimerDestroy() : #1 argument must be a table !", 2) end
	for k, v in pairs(timers) do
		if timer == v then
			table.remove(timers, k)
			print("TimerDestroy() : Destroy Timer !")
			break
		end
	end
end

function TimerUpdate(dt)
	if #timers == 0 then return end
	for _, v in pairs(timers) do
		if v.s <= 0 then
			local f = v.func()
			if not v.isRepeat then
				if v.loop then
					v.s = v.startS
				end
				if not v.loop or f == true then
					TimerDestroy(v)
				end
			else
				if v.times-1 > 1 then
					v.times = v.times - 1
				end
				if v.times == 1 or f == true then
					TimerDestroy( v )
				end
				v.s = v.startS
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
			break
		end
	end
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

function Lerp(t, a, b) 
	return (1 - t) * a + t * b
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
	
	AI:Load()

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

--[[-------------------------------------------------------------------------
	SAVE
---------------------------------------------------------------------------]]

function SavePreferences()
	love.filesystem.write( "preferences.sav", table.show( Game, "SavedGame" ) )
end

function LoadPreferences()
	local saved = love.filesystem.read( "preferences.sav" ) 
	if not saved then return end
	
	local func = loadstring( saved )
	func()
	Game = SavedGame
end

--[[-------------------------------------------------------------------------
	OTHERS
---------------------------------------------------------------------------]]

function PrintTable(_table)
	if not _table or not type(_table) == "table" then return end
	for k, v in pairs(_table) do
		print(k,v)
	end
end

function string.RemoveLastChar( _txt )
	return type(_txt) == "string" and _txt:sub(1, -2)
end

function table.HasValue(_table, _value)
	if not _table or not type(_table) == "table" then return end
	for _, v in pairs( _table ) do
		if v == _value then return true end
	end
	return false
end

function table.copy( t )
	local _t = {}
	for k, v in pairs( t ) do
		_t[k] = v
	end
	return _t
end

-- not made by us, get it from : http://lua-users.org/wiki/TableSerialization
function table.show(t, name, indent)
   local cart     -- a container
   local autoref  -- for self references

   --[[ counts the number of elements in a table
   local function tablecount(t)
      local n = 0
      for _, _ in pairs(t) do n = n+1 end
      return n
   end
   ]]
   -- (RiciLake) returns true if the table is empty
   local function isemptytable(t) return next(t) == nil end

   local function basicSerialize (o)
      local so = tostring(o)
      if type(o) == "function" then
         local info = debug.getinfo(o, "S")
         -- info.name is nil because o is not a calling level
         if info.what == "C" then
            return string.format("%q", so .. ", C function")
         else 
            -- the information is defined through lines
            return string.format("%q", so .. ", defined in (" ..
                info.linedefined .. "-" .. info.lastlinedefined ..
                ")" .. info.source)
         end
      elseif type(o) == "number" or type(o) == "boolean" then
         return so
      else
         return string.format("%q", so)
      end
   end

   local function addtocart (value, name, indent, saved, field)
      indent = indent or ""
      saved = saved or {}
      field = field or name

      cart = cart .. indent .. field

      if type(value) ~= "table" then
         cart = cart .. " = " .. basicSerialize(value) .. ",\n"
      else
         if saved[value] then
            cart = cart .. " = {}; -- " .. saved[value] 
                        .. " (self reference)\n"
            autoref = autoref ..  name .. " = " .. saved[value] .. ",\n"
         else
            saved[value] = name
            --if tablecount(value) == 0 then
            if isemptytable(value) then
               cart = cart .. " = {};\n"
            else
               cart = cart .. " = {\n"
               for k, v in pairs(value) do
                  k = basicSerialize(k)
                  local fname = string.format("%s[%s]", name, k)
                  field = string.format("[%s]", k)
                  -- three spaces between levels
                  addtocart(v, fname, indent .. "   ", saved, field)
               end
               cart = cart .. indent .. "};\n"
            end
         end
      end
   end

   name = name or "__unnamed__"
   if type(t) ~= "table" then
      return name .. " = " .. basicSerialize(t)
   end
   cart, autoref = "", ""
   addtocart(t, name, indent)
   return cart .. autoref
end