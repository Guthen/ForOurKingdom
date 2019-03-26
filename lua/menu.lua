Menu = {}

function Menu:Load()
	self.defX = Game.Width/2
	self.defY = Game.Height/2/2
	self.cursor = 
	{
		x = Game.Width/2-178.5, 
		y = Game.Height/2/2-12.5,
		id = 0,
	}
	
	self.firstMenu = 
	{
		[0] = 
		{
			img = Image["but_pvp"],
			func = function() 
				Game.MenuState = 0 
			end 
		},
		[1] = 
		{
			img = Image["but_pve"],
			func = function() 
				Game.MenuState = 0 
			end 
		},
	} 
end

function Menu:Key(k)
	if k == "down" then
		self.cursor.id = self.cursor.id == #self.firstMenu and 0 or self.cursor.id + 1
	elseif k == "up" then
		self.cursor.id = self.cursor.id == 0 and #self.firstMenu or self.cursor.id - 1
	elseif k == "return" then
		self.firstMenu[self.cursor.id].func()
		Reset()
	end
end

function Menu:Draw() 
	for k, v in pairs(self.firstMenu) do
		love.graphics.draw( v.img, self.defX, self.defY+90*k, 0, 1, 1, v.img:getWidth()/2, v.img:getHeight()/2 )
	end
	love.graphics.rectangle( "fill", self.cursor.x, self.cursor.y+self.cursor.id*90, 25, 25 )
end 

Menu:Load()