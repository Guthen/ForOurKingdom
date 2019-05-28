return 
{
	fx = Image[ "fx_speed" ],
	lifeTime = 2.5,
	animSpd = .1,
	effect = function( u )
		local spd = u.info.spd
		u.info.spd = spd + .5
		TimerAdd( 5, false, function() u.info.spd = spd end )
	end
}