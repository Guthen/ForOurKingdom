return 
{
	fx = Image[ "fx_acid_fall" ],
	lifeTime = 2.5,
	animSpd = .1,
	effect = function( u )
		TimerRepeat( 1, 5, function()
			u.info.hp = u.info.hp - 50
		end )
	end
}