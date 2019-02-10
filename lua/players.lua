Players = {}

function Players:StartCoin(s)
	TimerAdd(s, true, function()
		self.P1.gold = self.P1.gold + 1
		self.P2.gold = self.P2.gold + 1
	end)
end

function Players:Load()
    self.img = Image["cursor"]

    self.P1 = {}
    self.P1.x = 4
    self.P1.y = 0
    self.P1.units = {"Greu", "Goblex", "Rockpose", "Grea", "Norber"}
    self.P1.curUnit = 1
    self.P1.color = {r = .1, g = .1, b = .75}
    self.P1.gold = 5
	self.P1.scale = 1
    
    self.P2 = {}
    self.P2.x = 35
    self.P2.y = 0
    self.P2.units = {"Greu", "Goblex", "Rockpose", "Grea", "Norber"}
    self.P2.curUnit = 1
    self.P2.color = {r = .75, g = .1, b = .1}
    self.P2.gold = 5
	self.P2.scale = -1

    love.graphics.setFont(love.graphics.newFont("fonts/blacc.TTF"))
	
	self:StartCoin(1)
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
    -- DÉPLACEMENT
    if k == 'z' and self.P1.y > 0 then
        self.P1.y = self.P1.y - 1
    end
    if k == 's' and self.P1.y < 21 then
        self.P1.y = self.P1.y + 1
    end
    if k == 'q' and self.P1.x > 0 then
        self.P1.x = self.P1.x - 1
    end
    if k == 'd' and self.P1.x < 39 then
        self.P1.x = self.P1.x + 1
    end

    -- DEPLOIEMENT ET CHANGEMENT D'UNITÉS
	if k == 'f' and Units.units[self.P1.units[self.P1.curUnit]].cost <= self.P1.gold then
		Units:Add(self.P1.units[self.P1.curUnit], 3*Game.ImageSize, self.P1.y*Game.ImageSize, self.P1.scale)
		self.P1.gold = self.P1.gold - Units.units[self.P1.units[self.P1.curUnit]].cost
	end
    if k == 'e' then
        self.P1.curUnit = self.P1.curUnit + 1
        if self.P1.curUnit > #self.P1.units then self.P1.curUnit = 1 end
    end
    if k == 'a' then
        self.P1.curUnit = self.P1.curUnit - 1
        if self.P1.curUnit <= 0 then self.P1.curUnit = #self.P1.units end
    end

    -- CHEAT
    if k == 'g' then
        self.P1.gold = self.P1.gold + 100
        self.P2.gold = self.P2.gold + 100
    end
end

function Players:LeftClick()
    print(self.P2.units[self.P2.curUnit], self.P2.curUnit)
	if Units.units[self.P2.units[self.P2.curUnit]].cost <= self.P2.gold then
		Units:Add(self.P2.units[self.P2.curUnit], 36*Game.ImageSize, self.P2.y*Game.ImageSize, self.P2.scale)
		self.P2.gold = self.P2.gold - Units.units[self.P2.units[self.P2.curUnit]].cost
	end
end

function Players:WheelMoved(x, y)
    self.P2.curUnit = self.P2.curUnit + y
    if self.P2.curUnit <= 0 then self.P2.curUnit = #self.P2.units end
    if self.P2.curUnit > #self.P2.units then self.P2.curUnit = 1 end
end

Players:Load()