UI = {}
UI.Objects = {}

--	> Create <  --

function UI:CreateButton(x, y, w, h)
	local _but = 
	{
		type = "Button",
		id = #self.Objects+1,
		img = nil,
		quad = nil,
		x = x or 0,
		y = y or 0,
		w = w or 1,
		h = h or 1,
		sx = w or 1,
		sy = h or 1,
		doClick = function() print("UI: No function") end,
		removeOnClick = false,
		color = {r = 1, g = 1, b = 1, a = 1},
	}
	function _but:Remove()
		RemoveValueFromTable( UI.Objects, self )
	end
	self.Objects[_but.id] = _but
	return _but
end

function UI:CreateImage(x, y, sx, sy, img)
	local _img = 
	{
		type = "Image",
		id = #self.Objects+1,
		img = img,
		x = x or 0,
		y = y or 0,
		sx = sx or 1,
		sy = sy or 1,
		color = {r = 1, g = 1, b = 1, a = 1},
	}
	function _img:Remove()
		RemoveValueFromTable( UI.Objects, self )
	end
	self.Objects[_img.id] = _img
	return _img
end

-- > Object <  --

function UI:ResetObject(id) 
	if id then
		for k, v in pairs( self.Objects ) do
			if id and v.type == id then table.remove( self.Objects, k ) end
		end
		return
	end
	self.Objects = {}
end

--	> Essential <  --

function UI:Update(dt)
	for _, v in pairs( self.Objects ) do
		if v.type == "Button" then
			if v.img then v.w = v.img:getWidth()*v.sx v.h = v.img:getHeight()*v.sy end
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
		love.graphics.setColor( v.color.r or 1, v.color.g or 1, v.color.b or 1, v.color.a or .5 )
		if v.img then
			if v.quad then
				love.graphics.draw( v.img, v.quad, v.x, v.y, 0, v.sx, v.sy )
			else
				love.graphics.draw( v.img, v.x, v.y, 0, v.sx, v.sy )
			end
		else
			love.graphics.rectangle( "fill", v.x or 0, v.y or 0, v.w or 100, v.h or 25 )
		end
	end
end
