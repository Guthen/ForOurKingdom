AI = {}

function AI:Load()
	
	AI.isPlaying = false
	
	AI.typeUnits = 
	{
		["Tank"] = { "Norber", "Greu", "Devoggs" }
		["Attack"] = { "Grea", "Stickman" }
	}
	
	AI.units = {}
	AI:LoadUnits()
	
end	

function AI:LoadUnits()
	
	
	
end