return
{
	desc = "",
	img = Image["Elementaire de Vent"], -- son nom d'image (sans l'extension)
	rarety = 2, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "Elementaire de Vent", -- son nom dans le jeu
	hp = 2000, -- ses points de vie
	dmg = 500, -- ses points de dégats infligés
	spd = 1., -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 1, -- en combien de secondes attaque t'il
	cost = 25, -- combien l'unité coûte
	lvl = 6,
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = false, -- s'il peut être pris pour cible (optionnel)
	dieToFirstKill = false, -- s'il meurt à son premier "kill"
	fxOnDead = false,
	animSpd = .07, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
}
