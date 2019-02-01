Players = {}

function Players:Load()
    self.P1 = {}
    self.P1.x = 4
    self.P1.y = 0
    self.P1.units = {1, 2, 3, 4, 5, 6, 7, 8}
    self.P1.curUnit = 1
    
    self.P2 = {}
    self.P2.x = 36
    self.P2.y = 0
    self.P2.units = {1, 2, 3, 4, 5, 6, 7, 8}
    self.P2.curUnit = 1
end

function Players:Update(dt)

end

function Players:Draw()
    love.graphics.draw(self.P1.img, self.P1.x*32, self.P1.y*32)
    love.graphics.draw(self.P2.img, self.P2.x*32, self.P2.y*32)
end

function Players:Key()

end

