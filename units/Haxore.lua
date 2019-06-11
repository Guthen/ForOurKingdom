return
{
	desc = "Haxore est un androïde d'une galaxie lointaine. Il a été envoyé dans notre monde afin de l'examiner, cependant il n'a pas été programmé pour rentrer chez lui et est donc resté sur Terre.",
	img = Image["Haxore"], -- son nom d'image (sans l'extension)
	name = "Haxore", -- son nom dans le jeu
	rarety = 1, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	lvl = 4,
	hp = 450, -- ses points de vie
	dmg = 150, -- ses points de dégats infligés
	spd = 1.1, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = .5, -- en combien de secondes attaque t'il
	cost = 15, -- combien l'unité coûte
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	animSpd = .1, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
}

--	Unit by Guthen (image & script)