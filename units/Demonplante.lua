﻿return
{
	desc = "Quand une plante se met à dévorer des humains, elle se transforme en plante démoniaque qui devore toutes vies présentes.",
	img = Image["Demonplante"], -- son nom d'image (sans l'extension)
	name = "Demonplante", -- son nom dans le jeu
	rarety = 3, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 3000, -- ses points de vie
	dmg = 300, -- ses points de dégats infligés
	spd = 2.80, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .45, -- en combien de secondes attaque t'il
	cost = 35, -- combien l'unité coûte
	lvl = 5,
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
}
