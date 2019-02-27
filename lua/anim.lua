Anims = {}

function NewAnim( img, w, h, t )
	if not img or (img:getWidth() == w and img:getHeight() == h) then return end
	local a = {}
	a.quads = {}
	a.quad = 1
	a.t = t or .1
	a.curT = 0

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
			else
				v.quad = v.quad + 1
			end
			--print(v.quad)
		end
	end
end