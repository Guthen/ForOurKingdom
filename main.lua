function RequireFolder(folder, _table)
    if love.filesystem.getDirectoryItems(folder) then 
        for _, v in pairs(love.filesystem.getDirectoryItems(folder)) do
            if string.find(v, ".lua") then
            local n = string.gsub(v, ".lua", "")
               if _table then 
                   _table[n] = require(folder.."/"..n) 
               else
                   require(folder.."/"..n)
               end
            else
                for _, f in pairs(love.filesystem.getDirectoryItems(folder.."/"..v) do
                   if string.find(f, ".lua") then
                       local n = string.gsub(f, ".lua", "")
                      if _table then 
                         _table[n] = require(folder.."/"..n) 
                      else
                         require(folder.."/"..n)
                      end
                   end
               end
            end
        end
    end
end

function love.load()
    io.stdout:setvbuf("no")

    Game = {}
    Game.Width = 1280
    Game.Height = 704
    Game.ImageSize = 64
	Game.MenuState = 1
    Game.Title = "For Our Kingdom"

    Game.PlayersHealth = 10000
    Game.GoldLimit = 50
    Game.GoldSecond = 3

    love.window.setMode(Game.Width, Game.Height)
    love.window.setTitle(Game.Title)

    love.graphics.setDefaultFilter("nearest")

    RequireFolder("lua")
    RequireFolder("libs")
end

function love.update(dt)
    Players:Update( dt )
	Units:Update( dt )
	
	TimerUpdate( dt )
    UpdateAnims( dt )
end

function love.draw()
	if Game.MenuState == 0 then
		Map:Draw()

		Units:Draw()
		
		DrawFX()

		Players:Draw()
	else
		Menu:Draw()
	end
	
	--Image:Draw()
end

function love.keypressed(k)
	if Game.MenuState == 0 then
		Players:Key(k)
		if k == "kp0" then
			Reset()
			Map.CurrentMap = "arena_01"
		elseif k == "kp1" then
			Reset()
			Map.CurrentMap = "arena_02"
		elseif k == "kp2" then
			Reset()
			Map.CurrentMap = "arena_03"
		end
		
		if k == "escape" then
			Reset()
			Game.MenuState = 1
		end
	else
		Menu:Key(k)
	end
end

function love.mousepressed(x, y, but)
	if Game.MenuState == 0 then
		if but == 1 then
			Players:LeftClick()
		end
	end
end

function love.wheelmoved(x, y)
	if Game.MenuState == 0 then
		Players:WheelMoved(x, y)
	end
end