return
{
	desc = "Le Bouble de Feu est un sort créé par les plus incompétants Sorciers de Feu. Il servirait à brûler les autres créatures.",
	img = Image["Boule de feu"], -- son nom d'image (sans l'extension)
	deadImg = Image["Boule de feu attack"], -- son image à la mort de celui-ci (fonctionne seulement si dieToFirstKill = true)
	rarety = 1, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "Bouble de Feu", -- son nom dans le jeu
	lvl = 1,
	fx = "fx_fire_explosion",
	hp = 10, -- ses points de vie
	dmg = 1000, -- ses points de dégats infligés
	spd = 8, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 0, -- en combien de secondes attaque t'il
	cost = 15, -- combien l'unité coûte
	lvl = 1,
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = false, -- s'il peut suivre sa cible
	attackBase = false, -- s'il peut attaquer la base (optionnel)
	canBeTarget = false, -- s'il peut être pris pour cible (optionnel)
	dieToFirstKill = true, -- s'il meurt à son premier "kill"
	animSpd = 0.35, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
	onSpawn = function() -- fonction exécuté à l'appariton de l'unité
		Sound:Play("fireball", 0.5, true)
	end,
	onDestroyed = function() -- fonction exécuté à la mort de l'unité
		Sound:Stop("fireball")
	end,
}