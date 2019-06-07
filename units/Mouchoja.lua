return
{
	desc = "",
	img = Image["Mouchoja"], -- son nom d'image (sans l'extension)
	deadImg = Image["Ascensorreur_dead"], -- son image à la mort de celui-ci (fonctionne seulement si dieToFirstKill = true)
	rarety = 2, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "Mouchoja", -- son nom dans le jeu
	hp = 175, -- ses points de vie
	dmg = 175, -- ses points de dégats infligés
	spd = 2., -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 1, -- en combien de secondes attaque t'il
	cost = 10, -- combien l'unité coûte
	lvl = 2,
	isFly = false, -- s'il vole 
	targetFly = false, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	lvl = 2,
	animSpd = .07, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
}