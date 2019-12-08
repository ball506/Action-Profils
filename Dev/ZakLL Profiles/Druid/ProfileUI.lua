local A												= Action
local RG 											= A[A.PlayerClass]
local L 											= {}

L.MOUSEOVER 										= {
	enUS = "Use\n@mouseover", 
	ruRU = "Использовать\n@mouseover",
}
L.MOUSEOVER_TT 										= {
	enUS = "Will unlock use actions for @mouseover units\nExample: Pummel, Charge,  Intercept, Disarm",
}
L.AOE 										= {
	enUS = "Use AoE", 
}
L.AOE_TT 										= {
	enUS = "Enable multiunits actions",
}
L.CANCELBOP 										= {
	enUS = "Cancelaura Blessing of Protection",
}
L.CANCELBOP_TT 										= {
	enUS = "Automatically removes the buff effect Blessing of Protection on you if your health more than 50% and in combat",
}
L.DAMAGE											= {
	enUS = " -- Damage Options -- ",
}
	
A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]     = true
A.Data.ProfileUI                                     = {    
    DateTime = "v6 (17.09.2019)",
    [2] = {        
        [ACTION_CONST_DRUID_FERAL] = {             
            { -- [1]                            
                {
					E 		= "Checkbox", 
					DB 		= "mouseover",
					DBV 	= true,
					L 		= L.MOUSEOVER,
					TT 		= L.MOUSEOVER_TT, 
					M 		= {},
                },
                {
					E 		= "Checkbox", 
					DB 		= "AoE",
					DBV 	= true,
					L 		= L.AOE,
					TT		= L.AOE_TT,
					M 		= {},
                },
				{
					E 		= "Checkbox", 
					DB 		= "CancelauraBOP",
					DBV 	= true,
					L 		= L.CANCELBOP,
					TT		= L.CANCELBOP_TT,
					M 		= {},
				},				
            },
			{ -- [2]
                {
                    E 		= "Header",
					L 		= L.DAMAGE, 
                },
            }, 
		}
	}
}