return
{
	desc = "Ahh l'espace.. Si grand.. Si mysterieux.. Si puissant et destructeur.",
	img = Image["Trou noir"], -- son nom d'image (sans l'extension)
	name = "Trou Noir", -- son nom dans le jeu
	rarety = 3, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 10000, -- ses points de vie
	dmg = 500, -- ses points de dégats infligés
	spd = 1.2, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 0, -- en combien de secondes attaque t'il
	cost = 45, -- combien l'unité coûte
	lvl = 10,
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = false, -- s'il peut suivre sa cible
	attackBase = false, -- s'il peut attaquer la base (optionnel)
	canBeTarget = false, -- s'il peut être pris pour cible (optionnel)
	animSpd = .06, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
}
