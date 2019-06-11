return
{
	desc = "Canniplante est une plante cannibale, elle ne se nourrit que d'êtres vivants qui ont osés lui marcher dessus.",
	img = Image["Canniplante"], -- son nom d'image (sans l'extension)
	name = "Canniplante", -- son nom dans le jeu
	rarety = 1, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 850, -- ses points de vie
	dmg = 375, -- ses points de dégats infligés
	spd = 2.80, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .45, -- en combien de secondes attaque t'il
	cost = 20, -- combien l'unité coûte
	lvl = 5,
	isFly = false, -- s'il vole 
	targetFly = false, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
}
