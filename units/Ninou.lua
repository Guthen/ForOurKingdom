return
{
	desc = "La plus mignionne de toutes les \n créatures naissant d’un bébé dragon.",
	img = Image["Ninou"], -- son nom d'image (sans l'extension)
	name = "Ninou", -- son nom dans le jeu
	rarety = 0, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 100, -- ses points de vie
	dmg = 50, -- ses points de dégats infligés
	spd = 1, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .75, -- en combien de secondes attaque t'il
	cost = 10, -- combien l'unité coûte
	isFly = false, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	dieToFirstKill = false, -- s'il meurt à son premier "kill"
	fxOnDead = false,
	animSpd = .2, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
}

