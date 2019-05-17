return
{
	desc = "Devoggs est un dieu destructeur,\nrare sont les survivants de ses attaques. \nIl est décrit comme un géant sans tête,\n on raconte qu'il cherche sa tête perdue lors \n d'un de ses combats.",
	img = Image["Devoggs"], -- son nom d'image (sans l'extension)
	name = "Devoggs", -- son nom dans le jeu
	rarety = 3, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 10000, -- ses points de vie
	dmg = 500, -- ses points de dégats infligés
	spd = 1.5, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 0, -- en combien de secondes attaque t'il
	cost = 50, -- combien l'unité coûte
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	animSpd = .06, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
}
