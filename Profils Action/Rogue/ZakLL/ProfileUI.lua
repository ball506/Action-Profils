local TMW											= TMW 
local CNDT											= TMW.CNDT
local Env											= CNDT.Env

local A												= Action
local GetToggle										= A.GetToggle
local InterruptIsValid								= A.InterruptIsValid

local UnitCooldown									= A.UnitCooldown
local Unit											= A.Unit 
local Player										= A.Player 
local Pet											= A.Pet
local LoC											= A.LossOfControl
local MultiUnits									= A.MultiUnits
local EnemyTeam										= A.EnemyTeam
local FriendlyTeam									= A.FriendlyTeam
local TeamCache										= A.TeamCache
local InstanceInfo									= A.InstanceInfo

local select, setmetatable							= select, setmetatable

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]     = true
A.Data.ProfileUI                                     = {    
    DateTime = "v5 (10.02.2020)",
    [2] = {        
		[ACTION_CONST_ROGUE_ASSASSINATION] = {
            { -- [1]                            
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        ANY = "Use @mouseover", 
                    }, 
                    TT = { 
                        ANY = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        ANY = "Use AoE",  
                    }, 
                    TT = { 
                        ANY = "Enable multiunits actions", 
                    }, 
                    M = {},
                },                    
            }, 
            { -- [2]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Poisons -- ",
                    },
                },
            }, 
            { -- [3]     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "OFF", value = "OFF" },
                        { text = A.GetSpellInfo(2823), value = "DeadlyPoison" },
                        { text = A.GetSpellInfo(8679), value = "WoundPoison" },
                    },
                    DB = "PvPPoison",
                    DBV = "WoundPoison",
                    L = { 
                        ANY = "PvP Poison",
                    }, 
                    TT = { 
                        ANY = "Select the poison the rotation should always maintain.",  
                    }, 
                    M = {},
                },
				{
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "OFF", value = "OFF" },
                        { text = A.GetSpellInfo(2823), value = "DeadlyPoison" },
                        { text = A.GetSpellInfo(8679), value = "WoundPoison" },
                    },
                    DB = "PvEPoison",
                    DBV = "DeadlyPoison",
                    L = { 
                        ANY = "PvE Poison",
                    }, 
                    TT = { 
                        ANY = "Select the poison the rotation should always maintain.",  
                    }, 
                    M = {},
                },
            }, 
			{ -- [2]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Opener -- ",
                    },
                },
            },
			{
				{
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "OFF", value = "OFF" },
                        { text = "AUTO", value = "AUTO" },
                        { text = A.GetSpellInfo(6770), value = "Sap" },
						{ text = A.GetSpellInfo(1833), value = "CheapShot" },
						{ text = A.GetSpellInfo(703), value = "Garrote" },
                    },
                    DB = "OpenerPvP",
                    DBV = "AUTO",
                    L = { 
                        ANY = "PvP Ability",
                    }, 
                    TT = { 
                        ANY = "AUTO: Automatically selects, depending on the rotation mode\nother settings from the 'Actions' tab, types of group and your target",
                    }, 
                    M = {},
                },
				{
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "OFF", value = "OFF" },
                        { text = "AUTO", value = "AUTO" },
                        { text = A.GetSpellInfo(6770), value = "Sap" },
						{ text = A.GetSpellInfo(1833), value = "CheapShot" },
						{ text = A.GetSpellInfo(703), value = "Garrote" },
                    },
                    DB = "OpenerPvE",
                    DBV = "AUTO",
                    L = { 
                        ANY = "PvE Ability",
                    }, 
                    TT = { 
                        ANY = "AUTO: Automatically selects, depending on the rotation mode\nother settings from the 'Actions' tab, types of group and your target",
                    }, 
                    M = {},
                },
            },
			{
				RowOptions = { margin = { top = 10 } },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
					MAX 	= 100,							
					DB 		= "OpenerAtEnergyPvP",
					DBV 	= -1,
					ONLYOFF = true,
                    L = { 
                        ANY = "PvP Required energy limit\nvalue >= ",
                    }, 
					TT = { 
                        ANY = "Will wait for a certain value of energy before opening",
                    },
                    M = {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
					MAX 	= 100,							
					DB 		= "OpenerAtEnergyPvE",
					DBV 	= -1,
					ONLYOFF = true,
                    L = { 
                        ANY = "PvE Required energy limit\nvalue >= ",
                    }, 
					TT = { 
                        ANY = "Will wait for a certain value of energy before opening",
                    },
                    M = {},
                },
			},
			{
				RowOptions = { margin = { top = -10 } },
				{
                    E 		= "Checkbox", 
					DB 		= "OpenerWaitToBeDonePvP",
					DBV 	= false,
                    L = { 
						ANY = "PvP Wait to be done",
                    }, 
                    M = {},
                },
				{
                    E 		= "Checkbox", 
					DB 		= "OpenerWaitToBeDonePvE",
					DBV 	= false,
                    L = { 
						ANY = "PvE Wait to be done",
                    }, 
                    M = {},
                },
			},
			{ -- [2]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Offensive -- ",
                    },
                },
            },
			{
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
					MAX 	= 120,							
					DB 		= "BurstEnergyPvP",
					DBV 	= 90,
					ONLYOFF = true,
                    L = { 
                        ANY = "Burst Energy PvP",
                    }, 
					TT = { 
                        ANY = "Will wait for a certain value of energy before bursting",
                    },
                    M = {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
					MAX 	= 120,							
					DB 		= "BurstEnergyPvE",
					DBV 	= 90,
					ONLYOFF = true,
                    L = { 
                        ANY = "Burst Energy PvE",
                    }, 
					TT = { 
                        ANY = "Will wait for a certain value of energy before bursting",
                    },
                    M = {},
                },			
			},
			{
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
					MAX 	= 170,							
					DB 		= "BurstEnergyVigorPvP",
					DBV 	= 125,
					ONLYOFF = true,
                    L = { 
                        ANY = "Burst Energy PvP (Vigor)",
                    }, 
					TT = { 
                        ANY = "Will wait for a certain value of energy before bursting",
                    },
                    M = {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
					MAX 	= 170,							
					DB 		= "BurstEnergyVigorPvE",
					DBV 	= 125,
					ONLYOFF = true,
                    L = { 
                        ANY = "Burst Energy PvE (Vigor)",
                    }, 
					TT = { 
                        ANY = "Will wait for a certain value of energy before bursting",
                    },
                    M = {},
                },
			},
			{
				{
                    E 		= "Slider", 													
					MIN 	= 1, 
					MAX 	= 100,							
					DB 		= "BurstTargetHealthPvP",
					DBV 	= 60,
					ONLYOFF = true,
                    L = { 
                        ANY = "Burst Target Health PvP",
                    }, 
                    M = {},
                },
				{
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Full (100%)", value = "100" },
                        { text = "Half (50%)", value = "49" },
						{ text = "Quarter (25%)", value = "0" },
                    },
                    DB = "BurstStunDR",
                    DBV = "49",
                    L = { 
                        ANY = "Burst Stun DR",
                    }, 
                    TT = { 
                        ANY = "Min. DR to apply stun and burst target.",
                    }, 
                    M = {},
                },
			},
			{
				{
                    E 		= "Slider", 													
					MIN 	= 25, 
					MAX 	= 120,							
					DB 		= "KidneyEnergyPvP",
					DBV 	= 25,
					ONLYOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(408) .. " Energy PvP",
                    }, 
                    M = {},
                },
				
				{
                    E 		= "Slider", 													
					MIN 	= 1, 
					MAX 	= 5,							
					DB 		= "KidneyCPPvP",
					DBV 	= 5,
					ONLYOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(408) .. " CPs",
                    }, 
                    M = {},
                },
			},
			{
				RowOptions = { margin = { top = -10 } },
				{
                    E 		= "Checkbox", 
					DB 		= "KidneyBeforeBurstPvP",
					DBV 	= false,
                    L = { 
						ANY = A.GetSpellInfo(408) .. " Before Burst PvP",
                    }, 
                    M = {},
                },
				{
                    E 		= "Checkbox", 
					DB 		= "TripleCheapShotPvP",
					DBV 	= true,
                    L = { 
						ANY = "Triple " .. A.GetSpellInfo(1833),
                    }, 
                    M = {},
                },
			},
			{
				RowOptions = { margin = { top = -10 } },
				{
                    E 		= "Checkbox", 
					DB 		= "CloakOffensive",
					DBV 	= true,
                    L = { 
						ANY = A.GetSpellInfo(31224) .. " Offensive PvP",
                    }, 
                    M = {},
                },
				{
                    E 		= "Checkbox", 
					DB 		= "CloakBindshot",
					DBV 	= true,
                    L = { 
						ANY = A.GetSpellInfo(31224) .. " in Binding Shot",
                    }, 
                    M = {},
                },
			},
			{
				RowOptions = { margin = { top = -10 } },
				{
                    E 		= "Checkbox", 
					DB 		= "BlindVanish",
					DBV 	= true,
                    L = { 
						ANY = A.GetSpellInfo(2094) .. " in Enemy Vanish",
                    }, 
                    M = {},
                },
				{
                    E 		= "Checkbox", 
					DB 		= "VanishDPS",
					DBV 	= false,
                    L = { 
						ANY = A.GetSpellInfo(1856) .. " Offensive.",
                    }, 
                    M = {},
                },
			},
			{
				{
                    E		= "Checkbox", 
                    DB		= "holdAoE",
                    DBV		= true,
                    L		= { 
                        ANY	= "BoTE/Iris to AoE",
                    }, 
                    TT		= { 
                        ANY	= "Enable to hold Blood of the Enemy and Focus Iris to use in multiunits and boss.",
                    }, 
                    M		= {},
                },
				{
                    E		= "Slider",                                                     
                    MIN		= 2, 
                    MAX		= 10,                            
                    DB		= "holdAoENum",
                    DBV		= 3,
                    ONOFF	= false,
                    L		= { 
                        ANY = "Min. Units to BoTE/Iris AoE Logic.",
                    }, 
                    M 		= {},
                },	
			},
			{
				RowOptions = { margin = { top = -10 } },
				{
                    E		= "Checkbox", 
					DB		= "ForceKidney",
					DBV		= false,
					L		= { 
                        ANY	= "Set Queue " .. A.GetSpellInfo(408),
                    }, 
                    TT		= { 
                        ANY	= "When enable, will get CP and use Kidney Shot, create a macro for enable to force use Kidney Shot in target.",
                    }, 
					M		= {},
                },
				{
                    E		= "Checkbox", 
					DB		= "ForceKidneyF",
					DBV		= false,
					L		= { 
                        ANY	= "Set Queue Focus " .. A.GetSpellInfo(408),
                    }, 
                    TT		= { 
                        ANY	= "When enable, will get CP and use Kidney Shot, create a macro for enable to force use Kidney Shot in Focus. (Use Shiv Pixel)",
                    }, 
					M		= {},
                },
			},
			{ -- [2]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Multi DoTs -- ",
                    },
                },
            },
			{
				RowOptions = { margin = { top = -10 } },
				{
                    E		= "Checkbox", 
					DB		= "MultiDots",
					DBV		= false,
					L		= { 
                        ANY	= "Auto Multi DoTs ",
                    }, 
                    TT		= { 
                        ANY	= "Use auto target for Apply Garrote / Rupture.",
                    }, 
					M		= {},
                },
				{
                    E		= "Checkbox", 
					DB		= "MultiDotsBurst",
					DBV		= false,
					L		= { 
                        ANY	= "Multi DoTs in Burst",
                    }, 
                    TT		= { 
                        ANY	= "Use auto target when Vendetta/Toxic Blade up.",
                    }, 
					M		= {},
                },
			},
			{
				{
                    E 		= "Slider", 													
					MIN 	= 1, 
                    MAX 	= 30,  						
					DB 		= "MultiDotsRange",
					DBV 	= 10,
					ONLYOFF = true,
					L 		= { 
                        ANY	= "Multi DoTs Search Range "
                    },
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 1, 
                    MAX 	= 30,  						
					DB 		= "MultiDotsTTD",
					DBV 	= 10,
					ONLYOFF = true,
					L 		= { 
                        ANY	= "Multi DoTs Search Time To Die > "
                    },
					M 		= {},
                },
			},
			{
				{
                    E 		= "Slider", 													
					MIN 	= 1, 
                    MAX 	= 10,  						
					DB 		= "MultiDotsMaxRupture",
					DBV 	= 4,
					ONLYOFF = true,
					L 		= { 
                        ANY	= "Multi DoTs Max Targets W/ Rupture"
                    },
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 1, 
                    MAX 	= 10,  						
					DB 		= "MultiDotsCrimsonFinisher",
					DBV 	= 5,
					ONLYOFF = true,
					L 		= { 
                        ANY	= "Crimson as a Finisher Targets >="
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
					DB 		= "CrimsonVialDef",
					DBV 	= 40,
					ONOFF 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(185311) .. " (%)"
                    },
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "FeintDef",
					DBV 	= 100,
					ONOFF 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(1966) .. " (%)"
                    },
					M 		= {},
                },
			},
			{ -- [2]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Miscellaneous -- ",
                    },
                },
            },
			{
				RowOptions = { margin = { top = -10 } },
                {
                    E = "Checkbox", 
                    DB = "StealthOOC",
                    DBV = true,
                    L = { 
                        enUS = "Stealth Reminder (OOC)", 
                        ruRU = "Стелс-напоминание (OOC)", 
                        frFR = "Rappel du camouflage (OOC)",
                    }, 
                    TT = { 
                        enUS = "Show Stealth Reminder when out of combat.", 
                        ruRU = "Показать скрытное напоминание, когда вне боя.", 
                        frFR = "Afficher un rappel pour activer le camouflage hors combat.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AutoSAP",
                    DBV = true,
                    L = { 
                        enUS = "Auto Sap", 
                        ruRU = "Auto Sap", 
                        frFR = "Auto Sap",
                    }, 
                    TT = { 
                        enUS = "Auto Sap when out of combat.", 
                        ruRU = "Auto Sap when out of combat.", 
                        frFR = "Auto Sap when out of combat.", 
                    }, 
                    M = {},
                },
			},
			{
				RowOptions = { margin = { top = -10 } },
                {
                    E = "Checkbox", 
                    DB = "UseSprint",
                    DBV = true,
                    L = { 
                        enUS = "Auto" .. A.GetSpellInfo(2983), 
                        ruRU = "Авто" .. A.GetSpellInfo(2983), 
                        frFR = "Auto" .. A.GetSpellInfo(2983), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(2983), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(2983), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(2983), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "SprintTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(2983) .. " if moving for",
                        ruRU = A.GetSpellInfo(2983) .. " если переехать",
                        frFR = A.GetSpellInfo(2983) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(2983) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(2983) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(2983) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },	
			},
        },
		[ACTION_CONST_ROGUE_OUTLAW] = { 
			{ -- [1]                            
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        ANY = "Use @mouseover", 
                    }, 
                    TT = { 
                        ANY = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        ANY = "Use AoE",  
                    }, 
                    TT = { 
                        ANY = "Enable multiunits actions", 
                    }, 
                    M = {},
                },                    
            }, 
			{ -- [2]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Opener -- ",
                    },
                },
            },
			{
				{
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "OFF", value = "OFF" },
                        { text = "AUTO", value = "AUTO" },
                        { text = A.GetSpellInfo(6770), value = "Sap" },
						{ text = A.GetSpellInfo(1833), value = "CheapShot" },
						{ text = A.GetSpellInfo(8676), value = "Ambush" },
                    },
                    DB = "OpenerPvP",
                    DBV = "AUTO",
                    L = { 
                        ANY = "PvP Ability",
                    }, 
                    TT = { 
                        ANY = "AUTO: Automatically selects, depending on the rotation mode\nother settings from the 'Actions' tab, types of group and your target",
                    }, 
                    M = {},
                },
				{
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "OFF", value = "OFF" },
                        { text = "AUTO", value = "AUTO" },
                        { text = A.GetSpellInfo(6770), value = "Sap" },
						{ text = A.GetSpellInfo(1833), value = "CheapShot" },
						{ text = A.GetSpellInfo(8676), value = "Ambush" },
                    },
                    DB = "OpenerPvE",
                    DBV = "AUTO",
                    L = { 
                        ANY = "PvE Ability",
                    }, 
                    TT = { 
                        ANY = "AUTO: Automatically selects, depending on the rotation mode\nother settings from the 'Actions' tab, types of group and your target",
                    }, 
                    M = {},
                },
            },
			{ -- [2]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Offensive -- ",
                    },
                },
            },
			{
				{
                    E		= "Checkbox", 
                    DB		= "holdAoE",
                    DBV		= false,
                    L		= { 
                        ANY	= "BoTE/Iris to AoE",
                    }, 
                    TT		= { 
                        ANY	= "Enable to hold Blood of the Enemy and Focus Iris to use in multiunits and boss.",
                    }, 
                    M		= {},
                },
				{
                    E		= "Slider",                                                     
                    MIN		= 2, 
                    MAX		= 10,                            
                    DB		= "holdAoENum",
                    DBV		= 3,
                    ONOFF	= false,
                    L		= { 
                        ANY = "Min. Units to BoTE/Iris AoE Logic.",
                    }, 
                    M 		= {},
                },	
			},
			{
				{
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "BladeFlurryTargets",
                    DBV = 3, 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(13877) .. " Targets",
                    }, 
                    TT = { 
                        ANY = "How many targets should we have in range before using " .. A.GetSpellInfo(13877),
                    },
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "BladeFlurryRange",
                    DBV = 20, 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(13877) .. " Range",
                    }, 
                    TT = { 
                        ANY = "Define the range within you want to detect multiple enemies " .. A.GetSpellInfo(13877),
                    },
                    M = {},
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
					DB 		= "CrimsonVialDef",
					DBV 	= 40,
					ONOFF 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(185311) .. " (%)"
                    },
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= -1, 
                    MAX 	= 100,  						
					DB 		= "FeintDef",
					DBV 	= 100,
					ONOFF 	= true,
					L 		= { 
                        ANY	= A.GetSpellInfo(1966) .. " (%)"
                    },
					M 		= {},
                },
			},
			{ -- [2]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Miscellaneous -- ",
                    },
                },
            },
			{
				RowOptions = { margin = { top = -10 } },
                {
                    E = "Checkbox", 
                    DB = "StealthOOC",
                    DBV = true,
                    L = { 
                        enUS = "Stealth Reminder (OOC)", 
                        ruRU = "Стелс-напоминание (OOC)", 
                        frFR = "Rappel du camouflage (OOC)",
                    }, 
                    TT = { 
                        enUS = "Show Stealth Reminder when out of combat.", 
                        ruRU = "Показать скрытное напоминание, когда вне боя.", 
                        frFR = "Afficher un rappel pour activer le camouflage hors combat.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AutoSAP",
                    DBV = true,
                    L = { 
                        enUS = "Auto Sap", 
                        ruRU = "Auto Sap", 
                        frFR = "Auto Sap",
                    }, 
                    TT = { 
                        enUS = "Auto Sap when out of combat.", 
                        ruRU = "Auto Sap when out of combat.", 
                        frFR = "Auto Sap when out of combat.", 
                    }, 
                    M = {},
                },
			},
			{
				RowOptions = { margin = { top = -10 } },
                {
                    E = "Checkbox", 
                    DB = "UseSprint",
                    DBV = true,
                    L = { 
                        enUS = "Auto" .. A.GetSpellInfo(2983), 
                        ruRU = "Авто" .. A.GetSpellInfo(2983), 
                        frFR = "Auto" .. A.GetSpellInfo(2983), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(2983), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(2983), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(2983), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "SprintTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(2983) .. " if moving for",
                        ruRU = A.GetSpellInfo(2983) .. " если переехать",
                        frFR = A.GetSpellInfo(2983) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(2983) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(2983) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(2983) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },	
			},
		},
    },
	
	[7] = {
		[ACTION_CONST_ROGUE_ASSASSINATION] = { 
            ["kick"] = { Enabled = true, Key = "Kick", LUAVER = 6, LUA = [[
                local A = Action[ACTION_CONST_ROGUE_ASSASSINATION]
                return     A.Kick:IsReadyM(thisunit) and                         
                        A.Kick:AbsentImun(thisunit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and 
                        Unit(thisunit):IsCastingRemains() > 0 
            ]] },
        },
    },
}

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].Kick and A[A.PlayerSpec].Kick:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Kick:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp")  then 
        return false 
    end 
end 

-- setfenv will make working it way faster as lua condition for TMW frames 
--Env.GrappleWeaponIsReady = A.GrappleWeaponIsReady
Env.Main_CastBars				= A.Main_CastBars
Env.Second_CastBars				= A.Second_CastBars

