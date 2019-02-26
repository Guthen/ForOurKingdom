return
{
	img = Image["Canniplante"], -- son nom d'image (sans l'extension)
	name = "Canniplante", -- son nom dans le jeu
	hp = 200, -- ses points de vie
	dmg = 100, -- ses points de dégats infligés
	spd = 2.80, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .45, -- en combien de secondes attaque t'il
	cost = 15, -- combien l'unité coûte
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
}
