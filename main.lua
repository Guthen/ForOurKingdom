function RequireFolder(folder)
    if love.filesystem.getDirectoryItems(folder) then 
        for k, v in pairs(love.filesystem.getDirectoryItems(folder)) do
            if string.find(v, ".lua") then
            local n = string.gsub(v, ".lua", "")
            require(folder.."/"..n)
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
    Game.Title = "For Our Kingdom"

    Game.PlayersHealth = 10000
    Game.GoldLimit = 50
    Game.GoldSecond = 3

    love.window.setMode(Game.Width, Game.Height)
    love.window.setTitle(Game.Title)

    love.graphics.setDefaultFilter("nearest")

    RequireFolder("lua")
end

function love.update(dt)
    Players:Update( dt )
	Units:Update( dt )
	
	TimerUpdate( dt )
    UpdateAnims( dt )
end

function love.draw()
    Map:Draw()

	Units:Draw()
	
    DrawFX()

    Players:Draw()
	
	--Image:Draw()
end

function love.keypressed(k)
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
end

function love.mousepressed(x, y, but)
	if but == 1 then
		Players:LeftClick()
	end
end

function love.wheelmoved(x, y)
    Players:WheelMoved(x, y)
end