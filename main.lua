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
                for _, f in pairs(love.filesystem.getDirectoryItems(folder.."/"..v)) do
                   if string.find(f, ".lua") then
                       local n = string.gsub(f, ".lua", "")
                      if _table then 
                         _table[n] = require(folder.."/"..v.."/"..n) 
                      else
                         require(folder.."/"..v.."/"..n)
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
	Game.MenuState = 0
    Game.Title = "ForOurKingdom"

    Game.PlayersHealth = 10000
    Game.GoldLimit = 75
    Game.GoldSecond = 4
    Game.UnitsLimit = 7

    Game.ShowFPS = true

    love.window.setMode(Game.Width, Game.Height)
    love.window.setTitle(Game.Title)

    love.graphics.setDefaultFilter("nearest")

    Libs = {}

    love.graphics.setFont(love.graphics.newFont("fonts/blacc.TTF"))

    math.randomseed( os.time() )

    RequireFolder("lua")
    RequireFolder("libs", Libs)
	
	Menu:Create()
end

function love.update(dt)
    if Game.MenuState == 0 then
    	Players:Update( dt )
		Units:Update( dt )
	
    	UpdateAnims( dt )
    else
    	Menu:Update( dt )
    end

	TimerUpdate( dt )
    UI:Update( dt )
    Libs.shack:update( dt )
end

function love.draw()
	love.graphics.setColor( 1, 1, 1 )
	Libs.shack:apply()

	if Game.MenuState == 0 then
		Map:Draw()

		Units:Draw()
		
		DrawFX()

		Players:Draw()
	else
		Menu:Draw()
	end
	
	UI:Draw()	
	--Image:Draw()

	love.graphics.setColor( .3, .8, .5 )
	if Game.ShowFPS then love.graphics.print( "FPS: "..tostring( love.timer.getFPS() ), 10, 10 ) end
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
			Menu:Create()
		end
	else
		Menu:Key(k)
	end
end

function love.mousepressed(x, y, but)
	UI:OnClick(x, y, but)
end

function love.wheelmoved(x, y)

end
