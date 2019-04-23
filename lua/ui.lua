UI = {}
UI.Objects = {}

--	> Create <  --

function UI:CreateButton(x, y, w, h, center)
	local but = 
	{
		type = "Button",
		x = center and (x or 0)-(w or 100)/2 or x or 0,
		y = center and (y or 0)-(h or 25)/2 or y or 0,
		w = w or 100,
		h = h or 25,
		doClick = print("UI: No function")
	}
	function but:Remove()
		self = nil
	end
	table.insert( self.Objects, but )
	return but
end

--	> Essential <  --

function UI:Update(dt)
	for _, v in pairs( self.Objects ) do
		if v.type == "Button" then
			
		end
	end
end

function UI:OnClick(x, y, clk)
	if clk == 1 then
		for _, v in pairs( self.Objects ) do
			if IsCollide( v.x, v.y, x, y, v.w, v.h, 1, 1 ) then
				v.doClick()
			end
		end
	end
end

function UI:Draw()
	for _, v in pairs( self.Objects ) do
		love.graphics.rectangle( "fill", v.x, v.y, v.w, v.h )
	end
end
