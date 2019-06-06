return 
{
	fx = Image[ "fx_fire" ],
	lifeTime = 10,
	animSpd = .25,
	effect = function( u )
		TimerRepeat( 1, 10, function()
			u.info.hp = u.info.hp - 25
		end )
	end
}