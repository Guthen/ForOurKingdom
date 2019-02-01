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
    Game = {}
    Game.Width = 1280
    Game.Height = 720
    Game.Title = "ForOurKingdom"

    love.window.setMode(Game.Width, Game.Height)
    love.window.setTitle(Game.Title)
    RequireFolder("lua")
end

function love.update(dt)

end

function love.draw()

end
