Players = {}

function Players:StartCoin(s, g)
	self.coinTimer = TimerAdd(s, true, function()
		self.P1.gold = Clamp(self.P1.gold + g, 0, Game.GoldLimit)
		self.P2.gold = Clamp(self.P2.gold + g, 0, Game.GoldLimit)
	end)
end

function Players:Load()
    self.img = Image["cursor"]

    self.P1 = {}
    self.P1.info = 
    {
        type = "Player",
        hp = Game.PlayersHealth,
    }
    self.P1.x = 4
    self.P1.y = 0
    self.P1.units = {"Stickman" , "Rainbow_Stickman" , "Ascensorreur", "Trou noir", "greu", "Demonplante", "Canniplante", "grus", "grea", "goblex", "goblattack", "rockpose", "roco", "slapher", "norber"}
    self.P1.curUnit = 1
    self.P1.color = {r = .1, g = .1, b = .75}
    self.P1.gold = 1
	self.P1.scale = 1
    self.P1.isDestroyed = false
    function self.P1:Destroy()
        self.isDestroyed = true
        DestroyBase( Players.P1 )
    end
    
    self.P2 = {}
    self.P2.info = 
    {
        type = "Player",
        hp = Game.PlayersHealth,
    }
    self.P2.x = 18
    self.P2.y = 0
    self.P2.units = {"Stickman" , "Rainbow_Stickman", "Ascensorreur", "Trou noir", "Demonplante", "greu", "Canniplante", "grus", "grea", "goblex", "goblattack", "rockpose", "roco", "slapher", "norber"}
    self.P2.curUnit = 1
    self.P2.color = {r = .75, g = .1, b = .1}
    self.P2.gold = 1
	self.P2.scale = -1
    self.P2.isDestroyed = false
    function self.P2:Destroy()
        self.isDestroyed = true
        DestroyBase( Players.P2 )
    end
	
	self:StartCoin(1, Game.GoldSecond)
end

function Players:Update(dt)
    --[[-------------------------------------------------------------------------
        PLAYER 1 CONTROL
    ---------------------------------------------------------------------------]]


    --[[-------------------------------------------------------------------------
        PLAYER 2 CONTROL
    ---------------------------------------------------------------------------]]
    --self.P2.x = math.floor(love.mouse.getX()/Game.ImageSize)
    --self.P2.y = math.floor(love.mouse.getY()/Game.ImageSize)
end

function Players:Draw()
	if not self.img then return end
    --[[-------------------------------------------------------------------------
        PLAYER 1 DRAW
    ---------------------------------------------------------------------------]]
    -- cursor
    love.graphics.setColor(self.P1.color.r, self.P1.color.g, self.P1.color.b)
    love.graphics.draw(self.img, self.P1.x*Game.ImageSize, self.P1.y*Game.ImageSize, 0, Game.ImageSize/self.img:getWidth(), Game.ImageSize/self.img:getHeight())

    love.graphics.setColor(1, 1, 1)

    -- gold
    love.graphics.draw(Image["gold"], 6, Game.Height-Image["gold"]:getHeight()*4-6, 0, 4, 4)
    love.graphics.printf(self.P1.gold, 6+Image["gold"]:getWidth()*4+8, Game.Height-Image["gold"]:getHeight()*4-6+5, 200, "left", 0, 4, 4)
    
    -- hp
    if self.P1.info.hp <= Game.PlayersHealth/5 then
        love.graphics.setColor(1, .1, .1)
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.printf(self.P1.info.hp, 6+Image["gold"]:getWidth()*4+8, Game.Height-Image["gold"]:getHeight()*4-6+5-50, 200, "left", 0, 4, 4)
    love.graphics.setColor(1, 1, 1)

    -- units
    local lastUnit
    if self.P1.units[self.P1.curUnit-1] then
        lastUnit = self.P1.units[self.P1.curUnit-1]
    else
        lastUnit = self.P1.units[#self.P1.units]
    end
    local curUnit = self.P1.units[self.P1.curUnit]
    local nextUnit
    if self.P1.units[self.P1.curUnit+1] then
        nextUnit = self.P1.units[self.P1.curUnit+1]
    else
        nextUnit = self.P1.units[1]
    end

    love.graphics.setColor(1, 1, 1, .5)

    if Units.units[lastUnit].anim then
        love.graphics.draw(Units.units[lastUnit].img, Units.units[lastUnit].anim.quads[Units.units[lastUnit].anim.quad], 6, Game.Height-205, 0, 2, 2)
    else
        love.graphics.draw(Units.units[lastUnit].img, 6, Game.Height-205, 0, 2, 2)
    end

    if Units.units[nextUnit].anim then
        love.graphics.draw(Units.units[nextUnit].img, Units.units[nextUnit].anim.quads[Units.units[nextUnit].anim.quad], 6+48, Game.Height-205, 0, 2, 2)
    else
        love.graphics.draw(Units.units[nextUnit].img, 6+48, Game.Height-205, 0, 2, 2)
    end

    love.graphics.setColor(1, 1, 1, 1)
    if Units.units[curUnit].anim then
        love.graphics.draw(Units.units[curUnit].img, Units.units[curUnit].anim.quads[Units.units[curUnit].anim.quad], 6+24, Game.Height-200, 0, 2, 2)
    else
        love.graphics.draw(Units.units[curUnit].img, 6+24, Game.Height-200, 0, 2, 2)
    end
    love.graphics.printf(Units.units[curUnit].cost, 6+25+5, Game.Height-230, 25, "center", 0, 2, 2)
    --[[-------------------------------------------------------------------------
        PLAYER 2 DRAW
    ---------------------------------------------------------------------------]]
    -- cursor
    love.graphics.setColor(self.P2.color.r, self.P2.color.g, self.P2.color.b)
    love.graphics.draw(self.img, self.P2.x*Game.ImageSize, self.P2.y*Game.ImageSize, 0, Game.ImageSize/self.img:getWidth(), Game.ImageSize/self.img:getHeight())

    love.graphics.setColor(1, 1, 1)

    -- gold
    love.graphics.draw(Image["gold"], Game.Width-Image["gold"]:getWidth()*4-6-Image["gold"]:getWidth()*4, Game.Height-Image["gold"]:getHeight()*4-6, 0, 4, 4)
    love.graphics.printf(self.P2.gold, Game.Width-Image["gold"]:getWidth()*4+8, Game.Height-Image["gold"]:getHeight()*4-6+5, 200, "left", 0, 4, 4)

    -- hp
    if self.P2.info.hp <= Game.PlayersHealth/5 then
        love.graphics.setColor(1, .1, .1)
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.printf(self.P2.info.hp, Game.Width-Image["gold"]:getWidth()*4+8-100, Game.Height-Image["gold"]:getHeight()*4-6+5-50, 200, "left", 0, 4, 4)
    love.graphics.setColor(1, 1, 1)

    -- units
    local lastUnit
    if self.P2.units[self.P2.curUnit-1] then
        lastUnit = self.P2.units[self.P2.curUnit-1]
    else
        lastUnit = self.P2.units[#self.P2.units]
    end
    local curUnit = self.P2.units[self.P2.curUnit]
    local nextUnit
    if self.P2.units[self.P2.curUnit+1] then
        nextUnit = self.P2.units[self.P2.curUnit+1]
    else
        nextUnit = self.P2.units[1]
    end

    love.graphics.setColor(1, 1, 1, .5)

    if Units.units[lastUnit].anim then
        love.graphics.draw(Units.units[lastUnit].img, Units.units[lastUnit].anim.quads[Units.units[lastUnit].anim.quad], Game.Width-6, Game.Height-205, 0, 2, 2, 32, 0)
    else
        love.graphics.draw(Units.units[lastUnit].img, Game.Width-6, Game.Height-205, 0, 2, 2, 32, 0)
    end

    if Units.units[nextUnit].anim then
        love.graphics.draw(Units.units[nextUnit].img, Units.units[nextUnit].anim.quads[Units.units[nextUnit].anim.quad], Game.Width-6-48, Game.Height-205, 0, 2, 2, 32, 0)
    else
        love.graphics.draw(Units.units[nextUnit].img, Game.Width-6-48, Game.Height-205, 0, 2, 2, 32, 0)
    end

    love.graphics.setColor(1, 1, 1, 1)

    if Units.units[curUnit].anim then
        love.graphics.draw(Units.units[curUnit].img, Units.units[curUnit].anim.quads[Units.units[curUnit].anim.quad], Game.Width-6-24, Game.Height-200, 0, 2, 2, 32, 0)
    else
        love.graphics.draw(Units.units[curUnit].img, Game.Width-6-24, Game.Height-200, 0, 2, 2, 32, 0)
    end
    love.graphics.printf(Units.units[curUnit].cost, Game.Width-6-56-25, Game.Height-230, 25, "center", 0, 2, 2)
end

function Players:Key(k)
    --[[-------------------------------------------------------------------------
        PLAYER 1 CONTROL
    ---------------------------------------------------------------------------]]
    -- DÉPLACEMENT
    if not self.P1.isDestroyed then
        if k == 'z' and self.P1.y > 0 then
            self.P1.y = self.P1.y - 1
        end
        if k == 's' and self.P1.y < 10 then
            self.P1.y = self.P1.y + 1
        end
        if k == 'q' and self.P1.x > 0 then
            self.P1.x = self.P1.x - 1
        end
        if k == 'd' and self.P1.x < 19 then
            self.P1.x = self.P1.x + 1
        end

        -- DEPLOIEMENT ET CHANGEMENT D'UNITÉS
    	if k == 'f' and Units.units[self.P1.units[self.P1.curUnit]].cost <= self.P1.gold then
    		Units:Add(self.P1.units[self.P1.curUnit], 2*Game.ImageSize, self.P1.y*Game.ImageSize, self.P1.scale)
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
    end

    --[[-------------------------------------------------------------------------
        PLAYER 2 CONTROL
    ---------------------------------------------------------------------------]]
    -- DÉPLACEMENT
    if not self.P2.isDestroyed then
        if k == 'up' and self.P2.y > 0 then
            self.P2.y = self.P2.y - 1
        end
        if k == 'down' and self.P2.y < 10 then
            self.P2.y = self.P2.y + 1
        end
        if k == 'left' and self.P2.x > 0 then
            self.P2.x = self.P2.x - 1
        end
        if k == 'right' and self.P2.x < 19 then
            self.P2.x = self.P2.x + 1
        end

        -- DEPLOIEMENT ET CHANGEMENT D'UNITÉS
    	if k == 'return' and Units.units[self.P2.units[self.P2.curUnit]].cost <= self.P2.gold then
    		Units:Add(self.P2.units[self.P2.curUnit], 17*Game.ImageSize, self.P2.y*Game.ImageSize, self.P2.scale)
    		self.P2.gold = self.P2.gold - Units.units[self.P2.units[self.P2.curUnit]].cost
    	end
        if k == '^' then
            self.P2.curUnit = self.P2.curUnit + 1
            if self.P2.curUnit > #self.P2.units then self.P2.curUnit = 1 end
        end
        if k == '$' then
            self.P2.curUnit = self.P2.curUnit - 1
            if self.P2.curUnit <= 0 then self.P2.curUnit = #self.P2.units end
        end
    end

    -- CHEAT
    if k == 'g' then
        self.P1.gold = self.P1.gold + 100
        self.P2.gold = self.P2.gold + 100
    end
end

Players:Load()