return
{
	img = Image["Stickman"], -- son nom d'image (sans l'extension)
	name = "Stickman", -- son nom dans le jeu
	hp = 75, -- ses points de vie
	dmg = 50, -- ses points de dégats infligés
	spd = 0.5, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 3, -- en combien de secondes attaque t'il
	cost = 10 , -- combien l'unité coûte
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	animSpd = .06, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
}
