
function RequireFolder(folder, _table, noScripts)
    if love.filesystem.getDirectoryItems(folder) then 
        for _, v in pairs(love.filesystem.getDirectoryItems(folder)) do
            if string.find(v, ".lua") then
            	if not noScripts or not noScripts[v] then 
	            	local n = string.gsub(v, ".lua", "")
	               	if _table then 
	                   	_table[n] = require(folder.."/"..n) 
	               	else
	                   	require(folder.."/"..n)
	               	end
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
    --io.stdout:setvbuf("no")

    Game = {}
    Game.Width = love.graphics.getWidth()
    Game.Height = love.graphics.getHeight()
    Game.ImageSize = 64
	Game.MenuState = 0

    Game.PlayersHealth = 10000
    Game.GoldLimit = 75
    Game.GoldSecond = 4
    Game.UnitsLimit = 7

    Game.ShowFPS = false

	--[[if not love.graphics.getWidth() == Game.Width or not love.graphics.getHeight() == Game.Height then
		love.window.setMode( Game.Width, Game.Height )
		print( ("Change window size to : %d/%d"):format( Game.Width, Game.Height ) )
	end
	if not love.window.getTitle() == Game.Title then
		love.window.setTitle( Game.Title )
		print( ("Change window title to : %s"):format( Game.Title ) )
	end--]]

    love.graphics.setDefaultFilter( "nearest" )

    Libs = {}

    love.graphics.setFont( love.graphics.newFont("fonts/blacc.TTF", 14) )

    math.randomseed( os.time() )

    require( "lua/functions" )
    require( "lua/image" )

    RequireFolder("lua", nil, 
    	{ -- don't load them
    		["functions.lua"] = true, 
    		["image.lua"] = true,
    	})
    RequireFolder("libs", Libs)
	
	--love.window.setIcon( love.image.newImageData( "images/ui/logo.png" ) ) -- set game icon

	LoadPreferences()

	Menu:Create()

	--print( ( "Save directory located: %s" ):format( love.filesystem.getSaveDirectory() ) )
end

function love.update(dt)
    if Game.MenuState == 0 then
    	Players:Update( dt )
		Units:Update( dt )
		AI:Update( dt )
		Effect:Update()
	
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
	  	if Map.CurrentMap == "arena_04" then
			love.graphics.setColor( 0, 0, 0 )
		else
			love.graphics.setColor( 1, 1, 1 )
		end
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
			Map:SetCurMap( "arena_01" )
		elseif k == "kp1" then
			Reset()
			Map:SetCurMap( "arena_02" )
		elseif k == "kp2" then
			Reset()
			Map:SetCurMap( "arena_03" )
		elseif k == "kp3" then
			Reset()
			Map:SetCurMap( "arena_04" )
		elseif k == "kp4" then
		    Reset()
		    Map:SetCurMap( "arena_05" )
      	elseif k == "kp5" then
      		Reset()
      		Map:SetCurMap( "arena_06" )
    	end
		
		if k == "escape" then
			Reset()
			Menu:Create()
		end
	else
		Menu:Key(k)
		UI:Key(k)
	end
end

function love.mousepressed(x, y, but)
	UI:OnClick(x, y, but)
end

function love.mousereleased( x, y, but )
	UI:OnReleaseClick(x, y, but)
end

function love.wheelmoved(x, y)

end

function love.quit()
	SavePreferences()
end