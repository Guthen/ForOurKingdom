return 
{
	fx = Image[ "fx_speed" ],
	lifeTime = 2.5,
	animSpd = .1,
	effect = function( u )
		local spd = u.info.spd
		u.info.spd = Clamp( spd + .5, u.info.dSpd, u.info.dSpd + .5 )
		TimerAdd( 5, false, function() u.info.spd = u.info.dSpd end )
	end
}