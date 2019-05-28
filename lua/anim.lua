Anims = {}
FX = {}

--[[-------------------------------------------------------------------------
	ANIMS
---------------------------------------------------------------------------]]

function NewAnim( img, w, h, t, func)
	if not img or (img:getWidth() == w and img:getHeight() == h) then return end
	local a = {}
	a.quads = {}
	a.quad = 1
	a.t = t or .1
	a.curT = 0
	a.func = func

	for y = 0, img:getHeight()-h, h do
		for x = 0, img:getWidth()-w, w do
			table.insert( a.quads, love.graphics.newQuad( x, y, w, h, img:getDimensions() ) )
		end
	end

	table.insert(Anims, a)
	return a
end

function UpdateAnims( dt )
	for k, v in pairs(Anims) do
		v.curT = v.curT - dt
		if v.curT <= 0 then
			v.curT = v.t
			if v.quad + 1 > #v.quads then
				v.quad = 1
				if v.func then
					if v.func() == true then
						table.remove(Anims, k)
					end
				end
			else
				v.quad = v.quad + 1
			end
		end
	end
end

--[[-------------------------------------------------------------------------
	FX
---------------------------------------------------------------------------]]

function NewFX( img, x, y, s, animSpd )
	if not img then return print( "FX: Failed because wrong image !" ) end
	local fx = 
	{
		img = img,
		x = x,
		y = y,
		anim = NewAnim( img, img:getHeight(), img:getHeight(), animSpd )
	}

	if s == 0 then s = animSpd * img:getWidth()/32 - .1 end -- set the auto-remove when finished if s == 0 (-.1 for debug)

	TimerAdd( s, false, function()
		RemoveValueFromTable( FX, fx )
	end)

	FX[#FX+1] = fx
	return fx
end

function DrawFX()
	for _,v in pairs(FX) do
		if v.anim then
			love.graphics.draw( v.img, v.anim.quads[v.anim.quad], v.x, v.y, 0, 2, 2 )
		end
	end
end