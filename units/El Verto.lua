return
{
	desc = "",
	img = Image["El Verto"], -- son nom d'image (sans l'extension)
	rarety = 0, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "El Verto", -- son nom dans le jeu
	hp = 250, -- ses points de vie
	dmg = 75, -- ses points de dégats infligés
	spd = .85, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 1, -- en combien de secondes attaque t'il
	cost = 10, -- combien l'unité coûte
	isFly = false, -- s'il vole 
	targetFly = false, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	lvl = 2,
	animSpd = .1, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)

}
 
-- By Dolphi Lerhit