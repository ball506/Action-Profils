local A												= Action
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
L.OPENER											= {
	enUS = " -- Opener -- ",
}
L.DEFENSIVE											= {
	enUS = " -- Deffensives -- ",
}
L.OPENER_SPELL									= {
	enUS = "Buffs Ability",
}	
L.OPENER_SPELL_TT									= {
	enUS = "Buffs Ability used in Opener rotation.",
}	
L.OPENER_SPELL_DISTANCE						= {
	enUS = "Buffs Ability Distance",
}	
L.OPENER_SPELL_DISTANCE_TT									= {
	enUS = "Distance from target to use buffs ability in Opener rotation.",
}
L.OPENER_PROWL_DISTANCE						= { 
	enUS = A.GetSpellInfo(5215) .. " Target Distance",
}
L.OPENER_PROWL_DISTANCE_TT									= {
	enUS = A.GetSpellInfo(5215) .. " if target is at this distance or less.",
}
L.TIGERS_FURY_SYNC				= {
	enUS = A.GetSpellInfo(5217) .. " sync with " .. A.GetSpellInfo(155672)
}
L.TIGERS_FURY_SYNC_TT			= {
	enUS = "Use " .. A.GetSpellInfo(5217) .. " only with " .. A.GetSpellInfo(155672) .. " buffs." 
}

L.REGROWTH_OFFENSIVE 			= {
	enUS = A.GetSpellInfo(8936) .. " Offensive"
}
L.REGROWTH_OFFENSIVE_TT			= {
	enUS = "Only use " .. A.GetSpellInfo(8936) .. " offensive when " .. A.GetSpellInfo(155672) .. " talent selected." 
}
L.REGROWTH_DEFENSIVE 			= {
	enUS = A.GetSpellInfo(8936) .. " (%)"
}
L.SURVIVAL_INSTINCTS 			= {
	enUS = A.GetSpellInfo(61336) .. " (%)"
}
L.THORNS_SELF			= {
	enUS = A.GetSpellInfo(236696) .. " PvP (%)"
}
L.ABYSSAL_POT			= {
	enUS = "Abyssal Healing Potion (%)"
}
L.BARKSKIN 			= {
	enUS = A.GetSpellInfo(22812) .. " (%)"
}
L.SWIFTMEND 			= {
	enUS = A.GetSpellInfo(18562) .. " (%)"
}
L.MULTIDOT				= {
	enUS = "Auto Multi DoT",
}	
L.MULTIDOT_TT				= {
	enUS = "Auto swap target for apply Moonfire / Sunfire.",
}	
L.MULTIDOT_DISTANCE			= {
	enUS = "Multi DoT Search Distance",
}	
L.MULTIDOT_DISTANCE_TT		= {
	enUS = "Max Ranged for check if enemy have DoT.",
}	

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]     = true
A.Data.ProfileUI                                     = {    
    DateTime = "v1 (21.11.2019)",
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
					L 		= L.OPENER, 
                },
            },
			{ -- [3]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = A.GetSpellInfo(106951), 	value = "Berserk" },
						{ text = A.GetSpellInfo(5217), 		value = "TigersFury" },                        
                    },
                    MULT = true,
                    DB = "OpenerSpells",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                    }, 
                    L 		= L.OPENER_SPELL,
                    TT		= L.OPENER_SPELL_TT,	 
                    M		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 5, 
					MAX 	= 20,							
					DB 		= "OpenerSpellsDistance",
					DBV 	= 12,
					ONLYOFF = true,
					L 		= L.OPENER_SPELL_DISTANCE,
					TT		= L.OPENER_SPELL_DISTANCE_TT,
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 20, 
					MAX 	= 50,							
					DB 		= "ProwlDistance",
					DBV 	= 35,
					ONLYOFF = true,
					L 		= L.OPENER_PROWL_DISTANCE,
					TT		= L.OPENER_PROWL_DISTANCE_TT,
					M 		= {},
                },				
            },
			{ -- [4]
                {
                    E 		= "Header",
					L 		= L.DAMAGE, 
                },
            },
			{ -- [5]
				{
					E 		= "Checkbox", 
					DB 		= "TigersFurySync",
					DBV 	= true,
					L 		= L.TIGERS_FURY_SYNC,
					TT		= L.TIGERS_FURY_SYNC_TT,
					M 		= {},
				},
				{
					E 		= "Checkbox", 
					DB 		= "RegrowthOffensive",
					DBV 	= true,
					L 		= L.REGROWTH_OFFENSIVE,
					TT		= L.REGROWTH_OFFENSIVE_TT,
					M 		= {},
				},
			},
			{ -- [6]
                {
                    E 		= "Header",
					L 		= L.DEFENSIVE, 
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
					L 		= L.REGROWTH_DEFENSIVE,
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "SurvivalInstincts",
					DBV 	= 100,
					ONOFF 	= true,
					L 		= L.SURVIVAL_INSTINCTS,
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
					L 		= L.THORNS_SELF,
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "AbyssalPot",
					DBV 	= 100,
					ONOFF 	= true,
					L 		= L.ABYSSAL_POT,
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
			{ -- [4]
                {
                    E 		= "Header",
					L 		= L.DAMAGE, 
                },
            },
			{
				{
					E 		= "Checkbox", 
					DB 		= "MultiDot",
					DBV 	= true,
					L 		= L.MULTIDOT,
					TT		= L.MULTIDOT_TT,
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 15, 
					MAX 	= 40,							
					DB 		= "MultiDotDistance",
					DBV 	= 25,
					ONLYOFF = true,
					L 		= L.MULTIDOT_DISTANCE,
					TT		= L.MULTIDOT_DISTANCE_TT,
					M 		= {},
                },
			},
			{ -- [6]
                {
                    E 		= "Header",
					L 		= L.DEFENSIVE, 
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
					L 		= L.BARKSKIN,
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "SwiftmendSelf",
					DBV 	= 50,
					ONOFF 	= true,
					L 		= L.SWIFTMEND,
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
					L 		= L.ABYSSAL_POT,
					M 		= {},
                },	
			}
		}
	}
}