return
{
	desc = "",
	img = Image["Bloby"], -- son nom d'image (sans l'extension)
	name = "Bloby", -- son nom dans le jeu
	rarety = 2, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 2500, -- ses points de vie
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
