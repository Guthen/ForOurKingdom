return 
{
	fx = Image[ "fx_heal" ],
	lifeTime = 5,
	animSpd = .2,
	effect = function( u )
		TimerRepeat( 1, 5, function() 
			if not u then return true end
			u.info.hp = u.info.hp + 50		
		end )
	end
}