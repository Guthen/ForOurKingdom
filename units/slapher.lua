return
{
	img = Image["Slapher"], -- son nom d'image (sans l'extension)
	name = "Slapher", -- son nom dans le jeu
	hp = 50, -- ses points de vie
	dmg = 15, -- ses points de dégats infligés
	spd = 1, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .25, -- en combien de secondes attaque t'il
	cost = 5, -- combien l'unité coûte
	isFly = false, -- s'il vole 
	targetFly = false, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
}