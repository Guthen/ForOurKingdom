return
{
	desc = "D'ou vien-t-il, qui est-il personnes \n le sais. La seul don nous sommes sur a son \n  sujet est qu'il a une haine pour 90% des êtres \n vivants",
	img = Image["Stickman"], -- son nom d'image (sans l'extension)
	name = "Stickman", -- son nom dans le jeu
	rarety = 1, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 600, -- ses points de vie
	dmg = 275, -- ses points de dégats infligés
	spd = 1.25, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .75, -- en combien de secondes attaque t'il
	cost = 15 , -- combien l'unité coûte
	lvl = 4,
	isFly = false, -- s'il vole 
	targetFly = false, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = false, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	animSpd = .06, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
}
