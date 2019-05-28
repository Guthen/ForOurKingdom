return 
{
	fx = "fx_heal",
	lifeTime = 5,
	animSpd = .05,
	effect = function( u )
		TimerAdd( 1, 5, function() 
			u.info.hp = u.info.hp + 50		
		end )
	end
}