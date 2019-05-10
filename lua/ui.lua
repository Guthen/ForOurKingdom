UI = {}
UI.Objects = {}
UI.CanClick = true
UI.TEUpper = false

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
		w = w or 100,
		h = h or 25,
		sx = w or 1,
		sy = h or 1,
		doClick = function() print("UI: No function") end,
		removeOnClick = false,
		draw = true,
		isUnit = false,
		useCooldown = true,
		color = {r = 1, g = 1, b = 1, a = 1},
	}
	function _but:Remove()
		RemoveValueFromTable( UI.Objects, self )
	end
	self.Objects[_but.id] = _but
	return _but
end

function UI:CreateText(x, y, w, h, txt)
	local _t = 
	{
		type = "Text",
		id = #self.Objects+1,
		onlyText = true,
		x = x or 0,
		y = y or 0,
		tx = w or 1,
		ty = h or 1,
		text = txt or "Some text",
		draw = true,
		color = {r = 1, g = 1, b = 1, a = 1},
	}
	function _t:Remove()
		RemoveValueFromTable( UI.Objects, self )
	end
	function _t:GetText()
		return self.text
	end
	self.Objects[_t.id] = _t
	return _t
end

function UI:CreateTextEntry(x, y, w, h)
	local _te = 
	{
		type = "TextEntry",
		id = #self.Objects+1,
		img = nil,
		quad = nil,
		x = x or 0,
		y = y or 0,
		w = w or 100,
		h = h or 25,
		sx = 2,
		sy = 2,
		doClick = function() end,
		removeOnClick = false,
		canWrite = false,
		onEnter = function() print( "UI: No Function" ) end,
		text = "",
		draw = true,
		useCooldown = true,
		color = {r = 1, g = 1, b = 1, a = 1},
	}
	_te.doClick = function() _te.canWrite = true end
	function _te:Remove()
		RemoveValueFromTable( UI.Objects, self )
	end
	function _te:GetText()
		return self.text
	end
	self.Objects[_te.id] = _te
	return _te
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
		draw = true,
		color = {r = 1, g = 1, b = 1, a = 1},
	}
	function _img:Remove()
		RemoveValueFromTable( UI.Objects, self )
	end
	self.Objects[_img.id] = _img
	return _img
end

function UI:CreateCheckBox(x, y, sx, sy)
	local _cb = 
	{
		type = "CheckBox",
		id = #self.Objects+1,
		img = img,
		x = x or 0,
		y = y or 0,
		sx = sx or 1,
		sy = sy or 1,
		w = 32*sx, 
		h = 32*sy,
		draw = true,
		doClick = function()
			print( "UI: Check Box clicked :", self.activated)
		end,
		text = "I'am a CheckBox",
		activated = false,
		color = {r = 1, g = 1, b = 1, a = 1},
	}
	function _cb:Remove()
		RemoveValueFromTable( UI.Objects, self )
	end
	self.Objects[_cb.id] = _cb
	return _cb
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
			if v.img then 
				v.w = v.isUnit and 32*v.sx or v.img:getWidth()*v.sx 
				v.h = v.isUnit and 32*v.sy or v.img:getHeight()*v.sy 
			end
			if v.onUpdate then v.onUpdate( v ) end
		end
	end
end

function UI:OnClick(x, y, clk)
	if clk == 1 then
		for _, v in pairs( self.Objects ) do
			if v.doClick then
				if self.CanClick then
					if IsCollide( v.x, v.y, x, y, v.w, v.h, 1, 1 ) then
						if v.type == "CheckBox" then v.activated = not v.activated end
						v.doClick( v )
						if v.removeOnClick then v:Remove() end
						UI.CanClick = false
						TimerAdd( .2, false, function() self.CanClick = true end )
					elseif v.type == "TextEntry" then -- si pas collision, on enlève la possibilité d'écrire 
						v.canWrite = false
					end
				end
			end
		end
	end
end

function UI:Key( k )
	for _, v in pairs( self.Objects ) do
		if v.type == "TextEntry" then
			if k == "return" then
				v.canWrite = false
				v.onEnter( v )
			else
				if k == "space" then k = " " end
				if string.find( k, "shift" ) then UI.TEUpper = true 
				elseif string.find( k, "backspace" ) then v.text = string.RemoveLastChar( v.text ) 
				else
					if UI.TEUpper then k = k:upper() UI.TEUpper = false end
					v.text = v.text .. k
				end
			end
		end
	end
end

function UI:Draw()
	for _, v in pairs( self.Objects ) do
		if v.draw then
			love.graphics.setColor( v.color.r or 1, v.color.g or 1, v.color.b or 1, v.color.a or .5 )
			if v.onDraw then v.onDraw( v ) end
			if v.img then
				local ox = v.isCenter and v.img:getWidth()/2 or 0
				local oy = v.isCenter and v.img:getHeight()/2 or 0
				if v.quad then
					love.graphics.draw( v.img, v.quad, v.x, v.y, v.ang or 0, v.sx, v.sy, ox, oy )
				else
					love.graphics.draw( v.img, v.x, v.y, v.ang or 0, v.sx, v.sy, ox, oy )
				end
			elseif not v.onlyText then
				if v.type == "CheckBox" then 
					if v.activated then love.graphics.setColor( .1, .7, .2 )
					else love.graphics.setColor( .7, .1, .2 ) end
				end
				love.graphics.rectangle( "fill", v.x or 0, v.y or 0, v.w or 100, v.h or 25 )
			end
			if v.type == "Text" then
				love.graphics.setColor( v.color.r, v.color.g, v.color.b )
				love.graphics.printf( v.text, v.x, v.y, v.limit or 500, v.align or "left", v.ang or 0, v.tx or 1, v.ty or 1 )
			elseif v.text then
				if v.type == "CheckBox" then love.graphics.setColor( 1, 1, 1 ) else
				love.graphics.setColor( 0, 0, 0 ) end
				local x = v.type == "CheckBox" and v.x+v.w+5 or v.x+5
				local y = v.y+8
				love.graphics.printf( v.text, x, y, v.limit or 500, v.align or "left", v.ang or 0, v.sx, v.sy )
			end
		end
	end
end
