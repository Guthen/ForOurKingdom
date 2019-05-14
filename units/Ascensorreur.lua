return
{
	desc = "",
	img = Image["Ascensorreur"], -- son nom d'image (sans l'extension)
	deadImg = Image["Ascensorreur_dead"], -- son image à la mort de celui-ci (fonctionne seulement si dieToFirstKill = true)
	rarety = 3, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "Ascensorreur", -- son nom dans le jeu
	hp = 10000, -- ses points de vie
	dmg = 10000, -- ses points de dégats infligés
	spd = 1.4, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 0, -- en combien de secondes attaque t'il
	cost = 30, -- combien l'unité coûte
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = false, -- s'il peut suivre sa cible
	attackBase = false, -- s'il peut attaquer la base (optionnel)
	canBeTarget = false, -- s'il peut être pris pour cible (optionnel)
	dieToFirstKill = true, -- s'il meurt à son premier "kill"
	fxOnDead = false,
	animSpd = .07, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
	onSpawn = function() -- fonction exécuté à l'appariton de l'unité
		Sound:Play("elevator_spawn_Jay_You", 0.5, true)
	end,
	onDestroyed = function() -- fonction exécuté à la mort de l'unité
		Sound:Stop("elevator_spawn_Jay_You", 0, false)
		snd:stop()
	end,
}

-- Unit by Guthen (Image, Animation & Script) --
-- Sound : 'elevator_spawn_Jay_You.wav' was made by Jay_You and modified by Guthen, available here : https://freesound.org/people/Jay_You/sounds/460432/ --