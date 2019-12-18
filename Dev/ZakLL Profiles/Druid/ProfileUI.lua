local A												= Action
local L 											= {}

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]     = true
A.Data.ProfileUI                                     = {    
    DateTime = "v2 (18.12.2019)",
    [2] = {        
        [ACTION_CONST_DRUID_FERAL] = {             
            { -- [1]                            
                {
					E 		= "Checkbox", 
					DB 		= "mouseover",
					DBV 	= true,
					L 		= { 
                        ANY	= "Use\n@mouseover", 
                    }, 
                    TT 		= { 
                        ANY = "Will unlock use actions for @mouseover units\nExample: Pummel, Charge,  Intercept, Disarm",
					}, 
					M 		= {},
                },
                {
					E 		= "Checkbox", 
					DB 		= "AoE",
					DBV 	= true,
					L 		= { 
                        ANY	= "Use AoE",
                    }, 
                    TT 		= { 
                        ANY = "Enable multiunits actions",
					}, 
					M 		= {},
                },			
            },
			{ -- [2]
                {
                    E 		= "Header",
					L		= { 
                        ANY = " -- Opener -- ",
                    },
                },
            },
			{ -- [3]
                {
                    E 		= "Dropdown",                                                         
                    OT 		= {
						{ text = A.GetSpellInfo(106951),	value = "Berserk" },
						{ text = A.GetSpellInfo(5217),		value = "TigersFury" },                        
                    },
                    MULT 	= true,
                    DB 		= "OpenerSpells",
                    DBV 	= {
                        [1] = true, 
                        [2] = true,
                    }, 
                    L 		= { 
                        ANY	= "Buffs Ability",
                    }, 
                    TT 		= { 
                        ANY = "Buffs Ability used in Opener rotation.",
					}, 
                    M		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 5, 
					MAX 	= 20,							
					DB 		= "OpenerSpellsDistance",
					DBV 	= 12,
					ONLYOFF = true,
					L 		= { 
                        ANY	= "Buffs Ability Distance",
                    }, 
                    TT 		= { 
                        ANY = "Distance from target to use buffs ability in Opener rotation.",
					},
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 20, 
					MAX 	= 50,							
					DB 		= "ProwlDistance",
					DBV 	= 35,
					ONLYOFF = true,
					L 		= { 
                        ANY	= A.GetSpellInfo(5215) .. " Target Distance",
                    }, 
                    TT 		= { 
                        ANY = A.GetSpellInfo(5215) .. " if target is at this distance or less.",
                    }, 
					M 		= {},
                },				
            },
			{ -- [4]
                {
                    E		= "Header",
					L		= { 
                        ANY = " -- Damage Options -- ",
                    },
                },
            },
			{ -- [5]
				{
					E 		= "Checkbox", 
					DB 		= "TigersFurySync",
					DBV 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(5217) .. " sync with " .. A.GetSpellInfo(155672),
                    }, 
                    TT 		= { 
                        ANY = "Use " .. A.GetSpellInfo(5217) .. " only with " .. A.GetSpellInfo(155672) .. " buffs.",
                    }, 
					M 		= {},
				},
				{
					E		= "Checkbox", 
					DB		= "RegrowthOffensive",
					DBV		= true,
					L		= { 
                        ANY	= A.GetSpellInfo(8936) .. " Offensive",
                    }, 
                    TT		= { 
                        ANY	= "Only use " .. A.GetSpellInfo(8936) .. " offensive when " .. A.GetSpellInfo(155672) .. " talent selected.",
                    }, 
					M		= {},
				},
			},
			{
				{
                    E		= "Checkbox", 
                    DB		= "holdAoE",
                    DBV		= false,
                    L		= { 
                        ANY	= "Hold BoTE to AoE",
                    }, 
                    TT		= { 
                        ANY	= "Enable to hold Blood of the Enemy to use only in multiunits.",
                    }, 
                    M		= {},
                },
				{
                    E		= "Slider",                                                     
                    MIN		= 2, 
                    MAX		= 10,                            
                    DB		= "holdAoENum",
                    DBV		= 2,
                    ONOFF	= false,
                    L		= { 
                        ANY = "Min. Units to Hold AoE Logic.",
                    }, 
                    M 		= {},
                },	
			},
			{ -- [6]
                {
                    E 		= "Header",
					L		= { 
                        ANY = " -- Deffensives -- ",
                    },
                },
            },
			{ -- [7]
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "RegrowthDefensive",
					DBV 	= 100,
					ONOFF 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(8936) .. " (%)"
                    },
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "SurvivalInstincts",
					DBV 	= 100,
					ONOFF 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(61336) .. " (%)"
                    },
					M 		= {},
                },				
            },
			{ -- [8]
				{
                    E 		= "Slider", 													
					MIN 	= 0, 
                    MAX 	= 100,  						
					DB 		= "ThornsPvP",
					DBV 	= 75,
					ONLYON = true,
					L 		= { 
                        ANY	= A.GetSpellInfo(236696) .. " PvP (%)"
                    },
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "AbyssalPot",
					DBV 	= 100,
					ONOFF 	= true,
					L 		= { 
                        ANY	= "Abyssal Healing Potion (%)"
                    },
					M 		= {},
                },				
            },
		},
		[ACTION_CONST_DRUID_BALANCE] = {             
            { -- [1]                            
				{
					E 		= "Checkbox", 
					DB 		= "mouseover",
					DBV 	= true,
					L 		= { 
                        ANY	= "Use\n@mouseover", 
                    }, 
                    TT 		= { 
                        ANY = "Will unlock use actions for @mouseover units\nExample: Pummel, Charge,  Intercept, Disarm",
					}, 
					M 		= {},
                },
                {
					E 		= "Checkbox", 
					DB 		= "AoE",
					DBV 	= true,
					L 		= { 
                        ANY	= "Use AoE",
                    }, 
                    TT 		= { 
                        ANY = "Enable multiunits actions",
					}, 
					M 		= {},
                },			
            },
			{ -- [4]
                {
                    E		= "Header",
					L		= { 
                        ANY = " -- Damage Options -- ",
                    },
                },
            },
			{
				{
					E 		= "Checkbox", 
					DB 		= "MultiDot",
					DBV 	= true,
					L 		= { 
                        ANY	= "Auto Multi DoT",
                    }, 
                    TT 		= { 
                        ANY = "Auto swap target for apply Sunfire / Moonfire.",
                    }, 
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 15, 
					MAX 	= 40,							
					DB 		= "MultiDotDistance",
					DBV 	= 25,
					ONLYOFF = true,
					L 		= { 
                        ANY	= "Multi DoT Search Distance",
                    }, 
                    TT 		= { 
                        ANY = "Max Ranged for check if enemy have DoT.",
                    }, 
					M 		= {},
                },
			},
			{ -- [6]
                {
                    E 		= "Header",
					L		= { 
                        ANY = " -- Deffensives -- ",
                    },
                },
            },
			{
				{
                    E 		= "Slider", 													
					MIN 	= -1,
                    MAX 	= 100,  						
					DB 		= "BarkskinSelf",
					DBV 	= 35,
					ONOFF 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(22812) .. " (%)"
                    },
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "SwiftmendSelf",
					DBV 	= 50,
					ONOFF 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(18562) .. " (%)"
                    },
					M 		= {},
                },
			},
			{
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "AbyssalPot",
					DBV 	= 20,
					ONOFF 	= true,
					L 		= { 
                        ANY	= "Abyssal Healing Potion (%)"
                    },
					M 		= {},
                },	
			}
		}
	}
}