return
{
	desc = "L'unité Goblance de la \n Grande Armée Goblin est l'unité qui s'occupe \n de jeter sur les ennemis leurs lances.",
	name = "Goblance",
	img = Image["Goblance_anim(marche)"],
	rarety = 0, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 25,
	dmg = 15,
	spd = 1.75,
	attackRate = .5,
	cost = 5,
	isFly = false,
	targetFly = true,
	targetGround = true,
	followTarget = false,
	range = 2,
	soundOnSpawn = "goblin_spawn",
	soundOnDead = "goblin_hurt1",
	onEnemyAttack = function( u, trg )
		Effect:ApplyTo( "eff_speed", trg )
	end,
}