return
{
	desc = "Une Arognite est une aranéide mixtée avec une plante mortelle. Son venin acidigue se transmet dans le corps de l'ennemi et le consumme, petit-à-petit.",
	img = Image["Arognite"], -- son nom d'image (sans l'extension)
	rarety = 1, -- 0 : commun | 1 : rare | 2 : épique | 3 : mythique
	name = "Arognite", -- son nom dans le jeu
	hp = 350, -- ses points de vie
	dmg = 75, -- ses points de dégats infligés
	spd = 1., -- sa vitesse (1 = normal, inférieur à 1 = lent, supérieur à 1 = rapide)
	attackRate = 0.25, -- en combien de secondes attaque t'il
	cost = 12, -- combien l'unité coûte
	lvl = 2,
	isFly = false, -- s'il vole 
	targetFly = false, -- s'il peut attaquer les unités volantes
	targetGround = true, -- s'il peut attaquer les unités terrestres
	followTarget = true, -- s'il peut suivre sa cible
	attackBase = true, -- s'il peut attaquer la base (optionnel)
	canBeTarget = true, -- s'il peut être pris pour cible (optionnel)
	dieToFirstKill = false, -- s'il meurt à son premier "kill"
	fx = "fx_acid_fall",
	fxOnDead = true,
	lvl = 2,
	animSpd = .07, -- temps en secondes avant de changer de passer à la prochaine image si vous avez une animation (optionnel)
	onEnemyAttack = function( u, trg )
		local rdm = math.random( 1, 3 )
		if rdm == 1 then
			Effect:ApplyTo( "eff_poison", trg )
		end
	end,
}

-- Unit by Guthen (Image, Animation & Script) --