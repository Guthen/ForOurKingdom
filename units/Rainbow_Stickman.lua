return
{
	desc = "D'où vient-il ? Qui est-il ? Personne ne le sait. La seule chose dont nous sommes sûr à son sujet, c'est qu'il a une profonde haine envers les êtres vivants. Mais il est multicouleur, encore plus de questions que de réponses.",
	img = Image["Rainbow Stickman"], -- son nom d'image (sans l'extension)
	name = "Rainbow Stikman", -- son nom dans le jeu
	rarety = 3, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 3500, -- ses points de vie
	dmg = 1000, -- ses points de dégats infligés
	spd = .7, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 2, -- en combien de secondes attaque t'il
	cost = 35, -- combien l'unité coûte
	lvl = 4,
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	animSpd = .06, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
	beforeDraw = function()
		love.graphics.setColor( math.random(), math.random(), math.random() )
	end
}
