﻿return
{
	desc = "Attention à ne pas faire trop de bruit, une avalanche pourrait s'abattre sur vous !",
	img = Image["snowslide"], -- son nom d'image (sans l'extension)
	name = "Avalanche", -- son nom dans le jeu
	rarety = 3, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	hp = 10000, -- ses points de vie
	dmg = 500, -- ses points de dégats infligés
	spd = 1.2, -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 0, -- en combien de secondes attaque t'il
	cost = 25, -- combien l'unité coûte
	lvl = 5,
	isFly = true, -- s'il vole 
	targetFly = true, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = false, -- s'il peut suivre sa cible
	attackBase = false, -- s'il peut attaquer la base (optionnel)
	canBeTarget = false, -- s'il peut être pris pour cible (optionnel)
	spawnAtCursor = false, -- s'il spawn à l'emplacement du curseur
	animSpd = .15, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
	onEnemyKilled = function( self )
		if not self.kills then self.kills = 0 end
		self.kills = self.kills + 1
		
		if self.kills > 3 then
			self:Destroy()
		end	
	end,
}
