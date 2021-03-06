﻿return
{
	desc = "",
	img = Image["Dragon"], -- son nom d'image (sans l'extension)
	rarety = 2, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "Dragon", -- son nom dans le jeu
	hp = 500, -- ses points de vie
	dmg = 250, -- ses points de dégats infligés
	spd = 2, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 1.3, -- en combien de secondes attaque t'il
	cost = 20, -- combien l'unité coûte
	lvl = 4,
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	animSpd = .3, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
	soundOnAttack = "dragon_attack",
}