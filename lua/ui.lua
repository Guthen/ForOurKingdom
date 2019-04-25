UI = {}
UI.Objects = {}

--	> Create <  --

function UI:CreateButton(x, y, w, h, center)
	local but = 
	{
		type = "Button",
		id = #self.Objects,
		img = nil,
		x = x or 0,
		y = y or 0,
		w = w or 1,
		h = h or 1,
		doClick = print("UI: No function"),
		removeOnClick = false,
	}
	function but:Remove()
		table.remove( UI.Objects, id )
	end
	table.insert( self.Objects, but )
	return but
end

function UI:CreateImage(x, y, w, h, img)
	local _img = 
	{
		type = "Image",
		id = #self.Objects,
		img = img,
		x = x or 0,
		y = y or 0,
		w = w or 1,
		h = h or 1,
	}
	function _img:Remove()
		table.remove( UI.Objects, id )
	end
	table.insert( self.Objects, _img )
	return _img
end

-- > Object <  --

function UI:ResetObject(id)
	for k, v in pairs( self.Objects ) do
		if v.type == id then table.remove( self.Objects, k ) end
	end
end

--	> Essential <  --

function UI:Update(dt)
	for _, v in pairs( self.Objects ) do
		if v.type == "Button" then
			--if v.img then v.w = v.img:getWidth() v.h = v.img:getHeight() end
		end
	end
end

function UI:OnClick(x, y, clk)
	if clk == 1 then
		for _, v in pairs( self.Objects ) do
			if IsCollide( v.x, v.y, x, y, v.w, v.h, 1, 1 ) then
				v.doClick( v )
				if v.removeOnClick then v:Remove() end
			end
		end
	end
end

function UI:Draw()
	for _, v in pairs( self.Objects ) do
		if v.img then
			print( v.w )
			love.graphics.draw( v.img, v.x, v.y, 0, v.w, v.h )
		else
			love.graphics.rectangle( "fill", v.x, v.y, v.w, v.h )
		end
	end
end
