Players = {}

function Players:Load()
    self.img = Image["cursor"]

    self.P1 = {}
    self.P1.x = 4
    self.P1.y = 0
    self.P1.units = {1, 2, 3, 4, 5, 6, 7, 8}
    self.P1.curUnit = 1
    self.P1.color = {r = .1, g = .1, b = .75}
    self.P1.gold = 5
	self.P1.scale = 1
    
    self.P2 = {}
    self.P2.x = 35
    self.P2.y = 0
    self.P2.units = {1, 2, 3, 4, 5, 6, 7, 8}
    self.P2.curUnit = 1
    self.P2.color = {r = .75, g = .1, b = .1}
    self.P2.gold = 5
	self.P2.scale = -1

    love.graphics.setFont(love.graphics.newFont("fonts/blacc.TTF"))
end

function Players:Update(dt)
    --[[-------------------------------------------------------------------------
        PLAYER 1 CONTROL
    ---------------------------------------------------------------------------]]


    --[[-------------------------------------------------------------------------
        PLAYER 2 CONTROL
    ---------------------------------------------------------------------------]]
    self.P2.x = math.floor(love.mouse.getX()/Game.ImageSize)
    self.P2.y = math.floor(love.mouse.getY()/Game.ImageSize)
end

function Players:Draw()
	if not self.img then return end
    --[[-------------------------------------------------------------------------
        PLAYER 1 DRAW
    ---------------------------------------------------------------------------]]
    love.graphics.setColor(self.P1.color.r, self.P1.color.g, self.P1.color.b)
    love.graphics.draw(self.img, self.P1.x*32, self.P1.y*32, 0, Game.ImageSize/self.img:getWidth(), Game.ImageSize/self.img:getHeight())

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Image["gold"], 6, Game.Height-Image["gold"]:getHeight()*4-6, 0, 4, 4)
    love.graphics.printf(self.P1.gold, 6+Image["gold"]:getWidth()*4+8, Game.Height-Image["gold"]:getHeight()*4-6+5, 200, "left", 0, 4, 4)
    --[[-------------------------------------------------------------------------
        PLAYER 2 DRAW
    ---------------------------------------------------------------------------]]
    love.graphics.setColor(self.P2.color.r, self.P2.color.g, self.P2.color.b)
    love.graphics.draw(self.img, self.P2.x*32, math.floor(self.P2.y)*32, 0, Game.ImageSize/self.img:getWidth(), Game.ImageSize/self.img:getHeight())

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Image["gold"], Game.Width-Image["gold"]:getWidth()*4-6-Image["gold"]:getWidth()*4, Game.Height-Image["gold"]:getHeight()*4-6, 0, 4, 4)
    love.graphics.printf(self.P2.gold, Game.Width-Image["gold"]:getWidth()*4+8, Game.Height-Image["gold"]:getHeight()*4-6+5, 200, "left", 0, 4, 4)
end

function Players:Key(k)
    --[[-------------------------------------------------------------------------
        PLAYER 1 CONTROL
    ---------------------------------------------------------------------------]]
    if k == 'z' and self.P1.y > 0 then
        self.P1.y = self.P1.y - 1
    end
    if k == 's' and self.P1.y < 22 then
        self.P1.y = self.P1.y + 1
    end
    if k == 'q' and self.P1.x > 0 then
        self.P1.x = self.P1.x - 1
    end
    if k == 'd' and self.P1.x < 39 then
        self.P1.x = self.P1.x + 1
    end
	if k == 'e' then
		Units:Add("Greu", 3, self.P1.y, self.P1.scale)
	end

Players:Load()