return 
{
	fx = Image[ "fx_slow" ],
	lifeTime = 2.5,
	animSpd = .1,
	effect = function( u )
		local spd = u.info.spd
		if not spd or not type( spd ) == "number" then return end
		u.info.spd = Clamp( spd - .5, .1, spd )
		TimerAdd( 5, false, function() u.info.spd = u.info.dSpd end )
	end
}