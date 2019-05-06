return
{
	img = Image["Bloby"], -- son nom d'image (sans l'extension)
	name = "Bloby", -- son nom dans le jeu
	hp = 3000, -- ses points de vie
	dmg = 150, -- ses points de dégats infligés
	spd = 1.5, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .40, -- en combien de secondes attaque t'il
	cost = 45, -- combien l'unité coûte
	isFly = false, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	range = 5
}
