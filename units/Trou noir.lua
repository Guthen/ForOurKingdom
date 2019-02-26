return
{
	img = Image["Trou noir"], -- son nom d'image (sans l'extension)
	name = "Trou noir", -- son nom dans le jeu
	hp = 10000, -- ses points de vie
	dmg = 10000, -- ses points de dégats infligés
	spd = 0.80, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .25, -- en combien de secondes attaque t'il
	cost = 50, -- combien l'unité coûte
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = false, -- s'il peut suivre sa cible
}
