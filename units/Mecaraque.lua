return
{
	desc = "",
	img = Image["Mecaraque"], -- son nom d'image (sans l'extension)
	rarety = 1, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "Mecaraque", -- son nom dans le jeu
	hp = 4000, -- ses points de vie
	dmg = 1700, -- ses points de dégats infligés
	spd = 2, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 1, -- en combien de secondes attaque t'il
	cost = 20, -- combien l'unité coûte
	isFly = false, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	lvl = 5,
}