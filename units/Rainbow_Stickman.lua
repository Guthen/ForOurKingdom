return
{
	img = Image["Rainbow Stickman"], -- son nom d'image (sans l'extension)
	name = "Rainbow Stikman", -- son nom dans le jeu
	hp = 5000, -- ses points de vie
	dmg = 1000, -- ses points de dégats infligés
	spd = 1.5, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 2, -- en combien de secondes attaque t'il
	cost = 45, -- combien l'unité coûte
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