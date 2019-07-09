return
{
	desc = "",
	img = Image["Jochy"], -- son nom d'image (sans l'extension)
	rarety = 1, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "Jochy", -- son nom dans le jeu
	hp = 2000, -- ses points de vie
	dmg = 350, -- ses points de dégats infligés
	spd = 1.2, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 0, -- en combien de secondes attaque t'il
	cost = 15, -- combien l'unité coûte
	isFly = false, -- s'il vole 
	targetFly = false, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	lvl = 3,
}