return 
{
	fx = Image[ "fx_acid_fall" ],
	lifeTime = 3,
	animSpd = .1,
	effect = function( u )
		TimerRepeat( 1, 3, function()
			u.info.hp = u.info.hp - 50
		end )
	end
}