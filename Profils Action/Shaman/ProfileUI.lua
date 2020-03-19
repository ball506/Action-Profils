--------------------
-- Taste TMW Action ProfileUI

local TMW = TMW 
local CNDT = TMW.CNDT 
local Env = CNDT.Env
local A = Action
A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()] = true
A.Data.ProfileUI = {    
    DateTime = "v4.0.5 (19.03.2020)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_SHAMAN_ENCHANCEMENT] = {
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },		
            { -- [1] 1st Row
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
					    Custom = "/run Action.AoEToggleMode()",
						-- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
						Value = value or nil, 
						-- Very Very Optional, no idea why it will be need however.. 
						TabN = '@number' or nil,								
						Print = '@string' or nil,
					},
                },                 
            },  
            { -- [4] 4th Row
                {
                    E = "Checkbox", 
                    DB = "EnableFS",
                    DBV = true,
                    L = { 
                        enUS = "Show Feral Spirit in rotation", 
                        ruRU = "Show Feral Spirit in rotation", 
                        frFR = "Show Feral Spirit in rotation",
                    }, 
                    TT = { 
                        enUS = "Uncheck this if you don't want to see Feral Spirit in the rotation.", 
                        ruRU = "Uncheck this if you don't want to see Feral Spirit in the rotation.", 
                        frFR = "Uncheck this if you don't want to see Feral Spirit in the rotation.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseSyncCooldowns",
                    DBV = false,
                    L = { 
                        enUS = "Cooldowns Synchronisation", 
                        ruRU = "Cooldowns Synchronisation",
                        frFR = "Cooldowns Synchronisation",
                    }, 
                    TT = { 
                        enUS = "Uncheck this if you don't want to synchronize all your cooldowns.\nIf disabled, will use each cooldowns as soon as they are ready !", 
                        ruRU = "Uncheck this if you don't want to synchronize all your cooldowns.\nIf disabled, will use each cooldowns as soon as they are ready !", 
                        frFR = "Uncheck this if you don't want to synchronize all your cooldowns.\nIf disabled, will use each cooldowns as soon as they are ready !", 
                    }, 
                    M = {},
                },
            },			
            -- Buff refreshs
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Buffs Refresh -- ",
                    },
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "FlametongueRefresh",
					Precision = 1,
                    DBV = 4.5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(193796) .. " refresh",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(193796) .. " refresh value in seconds.", 
                        ruRU = A.GetSpellInfo(193796) .. " refresh value in seconds.",
                        frFR = A.GetSpellInfo(193796) .. " refresh value in seconds.",
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "FrostbrandRefresh",
					Precision = 1,
                    DBV = 4.8, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(196834) .. " refresh",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(196834) .. " refresh value in seconds.", 
                        ruRU = A.GetSpellInfo(196834) .. " refresh value in seconds.",
                        frFR = A.GetSpellInfo(196834) .. " refresh value in seconds.",
                    }, 					
                    M = {},
                },
			},
            -- Feral lunge
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(196884) .." -- ",
                    },
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "FeralLungeHP",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(196884) .. "\ntarget HP",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(196884) .. " on low HP target depending of the value you set.", 
                        ruRU = A.GetSpellInfo(196884) .. " on low HP target depending of the value you set.", 
                        frFR = A.GetSpellInfo(196884) .. " on low HP target depending of the value you set.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 30,                            
                    DB = "FeralLungeRange",
                    DBV = 20, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(196884) .. "\nrange",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(196884) .. " if target range is equal or greater than this value.", 
                        ruRU = A.GetSpellInfo(196884) .. " if target range is equal or greater than this value.", 
                        frFR = A.GetSpellInfo(196884) .. " if target range is equal or greater than this value.", 
                    }, 					
                    M = {},
                },
			},	
            { -- [7]  CrashLightning
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(187874) .. " -- ",
                    },
                },
            },
            { -- [3] 3rd Row 				
		
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 10,                            
                    DB = "CrashLightningAreaTTD",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(187874) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for all units around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.", 
                        ruRU = "Set the minimum Time To Die for all units around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.", 
                        frFR = "Set the minimum Time To Die for all units around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.",  
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 10,                            
                    DB = "CrashLightningRange",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(187874) .. " range",
                    },
                    TT = { 
                        enUS = "Set the maximum range to search for enemies around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.", 
                        ruRU = "Set the maximum range to search for enemies around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.", 
                        frFR = "Set the maximum range to search for enemies around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "CrashLightningUnits",
                    DBV = 2, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(187874) .. " units",
                    },
                    TT = { 
                        enUS = "Set the minimum number of units around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.", 
                        ruRU = "Set the minimum number of units around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.",
                        frFR = "Set the minimum number of units around before using " .. A.GetSpellInfo(187874) .. " \nDoes not apply to Boss.",
                    }, 					
                    M = {},
                }, 				
            },
            -- Counterstrike Totem
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(204331) .." -- ",
                    },
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 30,                            
                    DB = "CounterStrikeTotemTTD",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(204331) .. "\nTTD",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(204331) .. " if player is gonna die in the next X seconds.", 
                        ruRU = A.GetSpellInfo(204331) .. " if player is gonna die in the next X seconds.",  
                        frFR = A.GetSpellInfo(204331) .. " if player is gonna die in the next X seconds.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "CounterStrikeTotemHPlosepersec",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(204331) .. "\n%HP loose per sec",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(204331) .. " if player is taking damage and HP lost per seconds >= value.", 
                        ruRU = A.GetSpellInfo(204331) .. " if player is taking damage and HP lost per seconds >= value.", 
                        frFR = A.GetSpellInfo(204331) .. " if player is taking damage and HP lost per seconds >= value.", 
                    }, 					
                    M = {},
                },
			},
            -- Skyfury Totem
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(204330) .." -- ",
                    },
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "SkyfuryTotemHP",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(204330) .. "\ntarget HP",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(204330) .. " on low HP target depending of the value you set.", 
                        ruRU = A.GetSpellInfo(204330) .. " on low HP target depending of the value you set.", 
                        frFR = A.GetSpellInfo(204330) .. " on low HP target depending of the value you set.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 30,                            
                    DB = "SkyfuryTotemTTD",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(204330) .. "\nTTD",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(204330) .. " if target time to die is inferior to this value.", 
                        ruRU = A.GetSpellInfo(204330) .. " if target time to die is inferior to this value.", 
                        frFR = A.GetSpellInfo(204330) .. " if target time to die is inferior to this value.", 
                    }, 					
                    M = {},
                },
			},				
            -- Totem Mastery
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(262395) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UseTotemMastery",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(262395), 
                        ruRU = "Авто " .. A.GetSpellInfo(262395), 
                        frFR = "Auto " .. A.GetSpellInfo(262395), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(262395) .. " if talent learned.", 
                        ruRU = "Automatically use " .. A.GetSpellInfo(262395) .. " if talent learned.",  
                        frFR = "Automatically use " .. A.GetSpellInfo(262395) .. " if talent learned.",   
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "TotemMasteryRefresh",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(262395) .. " refresh",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(262395) .. " refresh value in seconds.", 
                        ruRU = A.GetSpellInfo(262395) .. " refresh value in seconds.",
                        frFR = A.GetSpellInfo(262395) .. " refresh value in seconds.",
                    }, 					
                    M = {},
                },
			},
            { -- [7]  Azerite Beam settings
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(295258) .. " -- ",
                    },
                },
            },
            { -- [3] 3rd Row 				
		
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 50,                            
                    DB = "FocusedAzeriteBeamTTD",
                    DBV = 10, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(295258) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(295258) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(295258) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(295258) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "FocusedAzeriteBeamUnits",
                    DBV = 3, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(295258) .. " units",
                    },
                    TT = { 
                        enUS = "Set the minimum number of units around before using " .. A.GetSpellInfo(295258) .. " \nDoes not apply to Boss.", 
                        ruRU = "Set the minimum number of units around before using " .. A.GetSpellInfo(295258) .. " \nDoes not apply to Boss.",
                        frFR = "Set the minimum number of units around before using " .. A.GetSpellInfo(295258) .. " \nDoes not apply to Boss.",
                    }, 					
                    M = {},
                }, 				
            },
            { -- [7] UnbridledFury 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(300714) .. " -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryAuto",
                    DBV = false,
                    L = { 
                        enUS = "Burst Potion", 
                        ruRU = "Burst Potion",
                        frFR = "Burst Potion",
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots depending of the settings of this section", 
                        ruRU = "If activated, will auto re pots depending of the settings of this section", 
                        frFR = "If activated, will auto re pots depending of the settings of this section", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryWithExecute",
                    DBV = false,
                    L = { 
                        enUS = "Sync execute phase", 
                        ruRU = "Sync execute phase",
                        frFR = "Sync execute phase",   
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        ruRU = "If activated, will auto re pots as soon as Execute phase is detected.", 
                        frFR = "If activated, will auto re pots as soon as Execute phase is detected.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,      					
                    DB = "UnbridledFuryTTD",
                    DBV = 40, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(300714) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the minimum Time To Die for a unit before using " .. A.GetSpellInfo(300714) .. " \nDoes not apply to Boss.", 
                        ruRU = "Установите минимальное время смерти для отряда перед использованием " .. A.GetSpellInfo(300714) .. " \nНе применимо к боссу.", 
                        frFR = "Définissez le temps minimum pour mourir pour une unité avant d'utiliser " .. A.GetSpellInfo(300714) .. " \nNe s'applique pas aux boss.", 
                    }, 					
                    M = {},
                },				
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryWithBloodlust",
                    DBV = false,
                    L = { 
                        enUS = "Sync Bloodlust", 
                        ruRU = "Sync Bloodlust", 
                        frFR = "Sync Bloodlust",  
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots as soon as Bloodlust is detected.", 
                        ruRU = "If activated, will auto re pots as soon as Bloodlust is detected.",
                        frFR = "If activated, will auto re pots as soon as Bloodlust is detected.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UnbridledFuryWithSecondAscendance",
                    DBV = false,
                    L = { 
                        enUS = "Sync Ascendance", 
                        ruRU = "Sync Ascendance", 
                        frFR = "Sync Ascendance",  
                    }, 
                    TT = { 
                        enUS = "If activated, will auto re pots as soon as Ascendance is detected.\nOnly work if Ascendance talent is learned.", 
                        ruRU = "If activated, will auto re pots as soon as Ascendance is detected.\nOnly work if Ascendance talent is learned.", 
                        frFR = "If activated, will auto re pots as soon as Ascendance is detected.\nOnly work if Ascendance talent is learned.", 
                    }, 
                    M = {},
                }, 				
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,      					
                    DB = "UnbridledFuryHP",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(300714) .. " HP",
                    },
                    TT = { 
                        enUS = "Set the minimum health percent for a unit before using " .. A.GetSpellInfo(300714) .. ".", 
                        ruRU = "Set the minimum health percent for a unit before using " .. A.GetSpellInfo(300714) .. ".",  
                        frFR = "Set the minimum health percent for a unit before using " .. A.GetSpellInfo(300714) .. ".", 
                    }, 					
                    M = {},
                },
			},	
            -- EarthElemental
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(198103) .." -- ",
                    },
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "EarthElementalUnits",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(198103) .. " units",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(198103) .. " if at least X units around and player is in trouble.\nThis settings is linked to Earth Elemental range.",  
                        ruRU = A.GetSpellInfo(198103) .. " if at least X units around and player is in trouble.\nThis settings is linked to Earth Elemental range.", 
                        frFR = A.GetSpellInfo(198103) .. " if at least X units around and player is in trouble.\nThis settings is linked to Earth Elemental range.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 30,                            
                    DB = "EarthElementalRange",
                    DBV = 8, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(198103) .. " range",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(198103) .. " depending of current number of enemies in range value.\nThis settings is linked to Earth Elemental units.", 
                        ruRU = A.GetSpellInfo(198103) .. " depending of current number of enemies in range value.\nThis settings is linked to Earth Elemental units.", 
                        frFR = A.GetSpellInfo(198103) .. " depending of current number of enemies in range value.\nThis settings is linked to Earth Elemental units.",  
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "EarthElementalHP",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(198103) .. "\n %HP lost per sec",
                    },
                    TT = { 
                        enUS = A.GetSpellInfo(198103) .. " if player is taking damage and HP lost per seconds >= value.", 
                        ruRU = A.GetSpellInfo(198103) .. " if player is taking damage and HP lost per seconds >= value.", 
                        frFR = A.GetSpellInfo(198103) .. " if player is taking damage and HP lost per seconds >= value.", 
                    }, 					
                    M = {},
                },
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "TrinketsAoE",
                    DBV = true,
                    L = { 
                        enUS = "Trinkets\nAoE only", 
                        ruRU = "Trinkets\nAoE only",  
                        frFR = "Trinkets\nAoE only",  
                    }, 
                    TT = { 
                        enUS = "Enable this to option to trinkets for AoE usage ONLY.", 
                        ruRU = "Enable this to option to trinkets for AoE usage ONLY.", 
                        frFR = "Enable this to option to trinkets for AoE usage ONLY.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 30,                            
                    DB = "TrinketsMinTTD",
                    DBV = 10, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min TTD",
                    },
                    TT = { 
                        enUS = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        ruRU = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        frFR = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                    },					
                    M = {},
                },
			},
			{
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 10,                            
                    DB = "TrinketsMinUnits",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min Units",
                    },
                    TT = { 
                        enUS = "Minimum number of units in range to activate Trinkets.", 
                        ruRU = "Minimum number of units in range to activate Trinkets.", 
                        frFR = "Minimum number of units in range to activate Trinkets.",  
                    },					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "TrinketsUnitsRange",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Max AoE range",
                    },
                    TT = { 
                        enUS = "Maximum range for units detection to automatically activate trinkets.", 
                        ruRU = "Maximum range for units detection to automatically activate trinkets.", 
                        frFR = "Maximum range for units detection to automatically activate trinkets.",  
                    },					
                    M = {},
                },
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Interrupts Settings -- ",
                    },
                },
            },
            { -- [3] 3rd Row 					
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "MinInterrupt",
                    DBV = 25, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min interrupt %",
                    },
                    TT = { 
                        enUS = "Set the minimum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.", 
                        ruRU = "Set the minimum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.", 
                        frFR = "Set the minimum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.",  
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "MaxInterrupt",
                    DBV = 70, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Max interrupt %",
                    },
                    TT = { 
                        enUS = "Set the maximum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.",  
                        ruRU = "Set the maximum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.", 
                        frFR = "Set the maximum value for interrupting or ccing spells.\nTotal interrupt value will be a rand between the minimum and the maximum.", 
                    }, 					
                    M = {},
                },
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dummy DPS Test -- ",
                    },
                },
            },
            { -- [3] 3rd Row 					
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 10,                            
                    DB = "DummyTime",
                    DBV = 5, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "DPS Testing Time",
                    },
                    TT = { 
                        enUS = "Set the desired time for test in minutes.\nWill show a notification icon when time is expired.\nMin: 1 / Max: 10.", 
                        ruRU = "Установите желаемое время для теста в минутах.\nПо истечении времени будет отображаться значок уведомления.\nMin: 1 / Max: 10.",  
                        frFR = "Définissez la durée souhaitée pour le test en minutes.\nAffiche une icône de notification lorsque le temps est écoulé.\nMin: 1 / Max: 10.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 15,                            
                    DB = "DummyStopDelay",
                    DBV = 10, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Stop Delay",
                    },
                    TT = { 
                        enUS = "After the dummy test is concluded, how much time should we stop the rotation. (In seconds)\nThis value is mainly used as a protection when you are out of combat to avoid auto attack.\nDefault value : 10 seconds.", 
                        ruRU = "После того, как фиктивный тест закончен, сколько времени мы должны остановить вращение. (В секундах)\nЭто значение в основном используется в качестве защиты, когда вы находитесь вне боя, чтобы избежать автоматической атаки.\nЗначение по умолчанию: 10 секунд.", 
                        frFR = "Une fois le test fictif terminé, combien de temps devons-nous arrêter la rotation. (En secondes)\nCette valeur est principalement utilisée comme protection lorsque vous êtes hors de combat pour éviter l'attaque automatique.\nValeur par défaut: 10 secondes.", 
                    }, 					
                    M = {},
                },
			},			
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [6]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Party -- ",
                    },
                },
            }, 
            { -- [7]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@party1", value = 1 },
                        { text = "@party2", value = 2 },
                    },
                    MULT = true,
                    DB = "PartyUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                    }, 
                    L = { 
                        ANY = "Party Units",
                    }, 
                    TT = { 
                        enUS = "Enable/Disable relative party passive rotation\nExample : Pet Dispell over party members.", 
                        ruRU = "Включить/Выключить относительно группы пассивную ротацию\nExample : Pet Dispell over party members.", 
						frFR = "Active/Désactive la rotation spécifique aux alliés pour les personnes dans le groupe.\nExemple : Dispell automatique sur les membres du groupe.",
                    }, 
                    M = {},
                },            
            }, 			
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },			
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",
                        frFR = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        frFR = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                    }, 					
                    M = {},
                },				
            },	
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Miscellaneous -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UseGhostWolf",
                    DBV = true,
                    L = { 
                        enUS = "Auto" .. A.GetSpellInfo(2645), 
                        ruRU = "Авто" .. A.GetSpellInfo(2645), 
                        frFR = "Auto" .. A.GetSpellInfo(2645), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(2645), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(2645), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(2645), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "GhostWolfTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(2645) .. " if moving for",
                    }, 
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(2645) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(2645) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(2645) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },
			},
			{
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "FeralLungeHP",
                    DBV = 60, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(196884) .. " enemy HP",
                    }, 
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(196884) .. " is talented and ready, will use it if enemy try to move out and got HP value <= this setting.", 
                        ruRU = "Если " .. A.GetSpellInfo(196884) .. " талантлив и готов, будет использовать его, если враг попытается выйти и получить значение HP <= этот параметр.", 
                        frFR = "Si " .. A.GetSpellInfo(196884) .. " est appris et prêt, l'utilisera si l'ennemi essaie de s'enfuir et a une valeur HP <= ce paramètre.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseCapacitorTotem",
                    DBV = true,
                    L = { 
                        enUS = "Use Capacitor Totem", 
                        ruRU = "Use Capacitor Totem", 
                        frFR = "Use Capacitor Totem", 
                    }, 
                    TT = { 
                        enUS = "Will force use of Capacitor Totem if Wind Shear is not ready.", 
                        ruRU = "Will force use of Capacitor Totem if Wind Shear is not ready.",
                        frFR = "Will force use of Capacitor Totem if Wind Shear is not ready.",
                    }, 
                    M = {},
                },
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },			
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AstralShiftHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(108271) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "EarthShieldHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(974) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HealingSurgeHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(8004) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AbyssalHealingPotionHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(301308) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "HexPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(51514),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                        frFR = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Seulement si le joueur de mêlée a des buffs de dégâts\nON COOLDOWN - les moyens seront toujours utilisés sur les joueurs de mêlée\nOFF - Coupé de la rotation mais autorisant toujours le travail dans la file d'attente et Systèmes MSG\nSi vous souhaitez l'éteindre complètement, vous devez définir SetBlocker dans l'onglet 'Actions'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "HexPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(51514) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_SHAMAN_ELEMENTAL] = {
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },		
            { -- [1] 1st Row
		
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
					    Custom = "/run Action.AoEToggleMode()",
						-- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
						Value = value or nil, 
						-- Very Very Optional, no idea why it will be need however.. 
						TabN = '@number' or nil,								
						Print = '@string' or nil,
					},
                },                 
            },  
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Burst Only", value = 1 },
                        { text = "Aoe Only", value = 2 },
                        { text = "Everytime", value = 3 },
                    },
                    MULT = true,
                    DB = "StormkeeperMode",
                    DBV = {
                        [1] = true, 
                        [2] = false,
                        [3] = false,
                    }, 
                    L = { 
                        ANY = A.GetSpellInfo(191634) .. " settings",
                    }, 
                    TT = { 
                        enUS = "Customize your Stormkeeper options. Multiple checks possible.", 
                        ruRU = "Customize your Stormkeeper options. Multiple checks possible.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FlameShockTTD",
                    DBV = 100, 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(188389) .. " min TTD",
                    }, 
	                TT = { 
                        enUS = "Customize minimum target health percent to use Flame Shock", 
                        ruRU = "Customize minimum target health percent to use Flame Shock", 
					}, 
                    M = {},
                },
            },

            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] Multidots settings
                {
                    E = "Header",
                    L = {
                        ANY = " -- Multidots settings -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "AutoDot",
                    DBV = true,
                    L = { 
                        enUS = "Enable auto Multidots", 
                        ruRU = "Использовать auto Multidots", 
                        frFR = "Activer le Multidots auto", 
                    }, 
                    TT = { 
                        enUS = "Automatically multidots units.\nMake sure to stay front of the enemies nameplate you want the bot to target.\nMake sure you correctly keybinded the TargetEnemy key in both game and GG.",
                        ruRU = "Автоматически многоточечные юниты.\nУбедитесь, что вы находитесь перед именной табличкой врагов, на которую должен нацелиться бот. \nУбедитесь, что вы правильно связали клавишу TargetEnemy в игре и в GG.",
                        frFR = "Multidot automatique des unités.\nAssurez-vous de rester en face du nameplate de l'ennemi que le bot doit cibler. \nAssurez-vous que la touche TargetEnemy a été correctement indexée dans le jeu et dans GG.",
                    }, 
                    M = {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 1, 
					MAX 	= 40,							
					DB 		= "MultiDotDistance",
					DBV 	= 25,
					ONLYOFF = true,
					L 		= { 
                        enUS = "Multidots Range", 
                        ruRU = "Сфера Multidots", 
                        frFR = "Portée du Multidots", 
                    }, 
					TT		= { 
                        enUS = "Choose the range where you want to automatically multidots units.", 
                        ruRU = "Выберите диапазон, в котором вы хотите автоматически многоточечные единицы.", 
						frFR = "Choisissez la portée dans laquelle vous souhaitez multidoter automatiquement les unités.", 
                    },
					M 		= {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "In Raid", value = "In Raid" },
                        { text = "In Dungeon", value = "In Dungeon" },
						{ text = "In PvP", value = "In PvP" },
                        { text = "Everywhere", value = "Everywhere" },
                    },
                    MULT = false,
                    DB = "AutoDotSelection",
                    DBV = "In Raid", 
                    L = { 
                        enUS = "Multidots where", 
                        ruRU = "Multidots где", 
                        frFR = "Multidots où", 
                    }, 
                    TT = { 
                        enUS = "Choose where you want to automatically multidots units.", 
                        ruRU = "Выберите, где вы хотите автоматически многоточечные единицы.", 
						frFR = "Choisissez l'endroit où vous souhaitez multidoter automatiquement les unités.",
                    }, 
                    M = {},
                },				
			},
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },			
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",
                        frFR = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        frFR = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                    }, 					
                    M = {},
                },				
            },	
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Miscellaneous -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "ForceAoE",
                    DBV = true,
                    L = { 
                        enUS = "Force AoE opener", 
                        ruRU = "Force AoE opener", 
                        frFR = "Force AoE opener", 
                    }, 
                    TT = { 
                        enUS = "If activated, opener will use Chain Lightning instead of Lava Burst.\nUsefull if you got issue with AoE detection on opener.", 
                        ruRU = "If activated, opener will use Chain Lightning instead of Lava Burst.\nUsefull if you got issue with AoE detection on opener.",
                        frFR = "If activated, opener will use Chain Lightning instead of Lava Burst.\nUsefull if you got issue with AoE detection on opener.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseGhostWolf",
                    DBV = true,
                    L = { 
                        enUS = "Use Ghost Wolf", 
                        ruRU = "Use Ghost Wolf", 
                        frFR = "Use Ghost Wolf",
                    }, 
                    TT = { 
                        enUS = "Automatically use Ghost Wolf if out of range and in combat.", 
                        ruRU = "Automatically use Ghost Wolf if out of range and in combat.", 
                        frFR = "Automatically use Ghost Wolf if out of range and in combat.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseCapacitorTotem",
                    DBV = true,
                    L = { 
                        enUS = "Use Capacitor Totem", 
                        ruRU = "Use Capacitor Totem", 
                        frFR = "Use Capacitor Totem", 
                    }, 
                    TT = { 
                        enUS = "Will force use of Capacitor Totem if Wind Shear is not ready.", 
                        ruRU = "Will force use of Capacitor Totem if Wind Shear is not ready.",
                        frFR = "Will force use of Capacitor Totem if Wind Shear is not ready.",
                    }, 
                    M = {},
                },
			},

            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },			
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AstralShiftHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(108271) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "EarthShieldHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(974) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HealingSurgeHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(8004) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AbyssalHealingPotionHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(301308) .. " (%)",
                    }, 
                    M = {},
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UseEarthElemental",
                    DBV = true,
                    L = { 
                        enUS = "Defensive Earth Elemental", 
                        ruRU = "Defensive Earth Elemental", 
                        frFR = "Defensive Earth Elemental", 
                    }, 
                    TT = { 
                        enUS = "Will use Earth Elemental defensively depending on your settings.", 
                        ruRU = "Will use Earth Elemental defensively depending on your settings.", 
                        frFR = "Will use Earth Elemental defensively depending on your settings.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "EarthElementalHP",
                    DBV = 40, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Health",
                    },
                    TT = { 
                        enUS = "Current player health percentage to use Earth Elemental.", 
                        ruRU = "Current player health percentage to use Earth Elemental.", 
                        frFR = "Current player health percentage to use Earth Elemental.",
                    },					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 15,                            
                    DB = "EarthElementalEnemies",
                    DBV = 3, 
                    ONOFF = true,
                    L = { 
                        ANY = "Enemies",
                    }, 
                    TT = { 
                        enUS = "Number of enemies around to use Earth Elemental.", 
                        ruRU = "Number of enemies around to use Earth Elemental.", 
                        frFR = "Number of enemies around to use Earth Elemental.",
                    },
                    M = {},
                },
			},
            { -- [4] 4th Row
                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Ancestral Guidance -- ",
                    },
                },
            },
			{
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "In Raid", value = "In Raid" },
                        { text = "In Dungeon", value = "In Dungeon" },
						{ text = "In PvP", value = "In PvP" },
                        { text = "Everywhere", value = "Everywhere" },
                    },
                    MULT = false,
                    DB = "AncestralGuidanceSelection",
                    DBV = "In Dungeon", 
                    L = { 
                        ANY = "Ancestral Guidance usage",
                    }, 
                    TT = { 
                        enUS = "Choose where you want to automatically Ancestral Guidance units.", 
                        ruRU = "Choose where you want to automatically Ancestral Guidance units.",
                    }, 
                    M = {},
                },	
			},	
			{
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AncestralGuidanceHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Defensive Logic",
                    },
                    TT = { 
                        enUS = "Auto : Will dynamically take in account your current group size, current group damage and healing per second to determine when to use assist healing.\nNOT Auto : the value set with slider will be the current percent damage per second on your group.", 
                        ruRU = "Auto : Will dynamically take in account your current group size, current group damage and healing per second to determine when to use assist healing.\nNOT Auto : the value set with slider will be the current percent damage per second on your group.", 
                        frFR = "Auto : Will dynamically take in account your current group size, current group damage and healing per second to determine when to use assist healing.\nNOT Auto : the value set with slider will be the current percent damage per second on your group.", 
                    },					
                    M = {},
                },
			},

            { -- [4] 4th Row
                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "HexPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(51514),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                        frFR = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Seulement si le joueur de mêlée a des buffs de dégâts\nON COOLDOWN - les moyens seront toujours utilisés sur les joueurs de mêlée\nOFF - Coupé de la rotation mais autorisant toujours le travail dans la file d'attente et Systèmes MSG\nSi vous souhaitez l'éteindre complètement, vous devez définir SetBlocker dans l'onglet 'Actions'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "HexPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(51514) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_SHAMAN_RESTORATION] = {
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },		
            { -- [1] 1st Row
		
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
					    Custom = "/run Action.AoEToggleMode()",
						-- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
						Value = value or nil, 
						-- Very Very Optional, no idea why it will be need however.. 
						TabN = '@number' or nil,								
						Print = '@string' or nil,
					},
                },                 
            },  
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "On", value = 1 },
                        { text = "Off", value = 2 },
                    },
                    MULT = false,
                    DB = "HealingRModes",
                    DBV = {
                        [1] = true, 
                        [2] = false,
                    }, 
                    L = { 
                        ANY = A.GetSpellInfo(73920) .. " modes",
                    }, 
                    TT = { 
                        enUS = "Customize your " .. A.GetSpellInfo(73920) .. " options.", 
                        ruRU = "Customize your " .. A.GetSpellInfo(73920) .. " options.", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "On", value = 1 },
                        { text = "Off", value = 2 },
                    },
                    MULT = false,
                    DB = "GhostWolfModes",
                    DBV = {
                        [1] = true, 
                        [2] = false,
                    }, 
                    L = { 
                        ANY = A.GetSpellInfo(2645) .. " modes",
                    }, 
                    TT = { 
                        enUS = "Customize your " .. A.GetSpellInfo(2645) .. " options.", 
                        ruRU = "Customize your " .. A.GetSpellInfo(2645) .. " options.", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "On", value = 1 },
                        { text = "Off", value = 2 },
                    },
                    MULT = false,
                    DB = "DPSModes",
                    DBV = {
                        [1] = true, 
                        [2] = false,
                    }, 
                    L = { 
                        ANY = " DPS modes",
                    }, 
                    TT = { 
                        enUS = "Enable or Disable damage rotation.", 
                        ruRU = "Enable or Disable damage rotation.",
                    }, 
                    M = {},
                },
            },

            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },			
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",
                        frFR = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        frFR = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                    }, 					
                    M = {},
                },				
            },	

            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Healing Engine -- ",
                    },
                },
            },
			{
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HealingRain",
                    DBV = 80, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Healing Rain",
                    }, 
                    TT = { 
                        enUS = "Health Percent to Cast At",
                        ruRU = "Health Percent to Cast At",
                        frFR = "Health Percent to Cast At",
                    },	
                    M = {},
                },
				-- Healing Rain
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 40,                            
                    DB = "HealingRainTargets",
                    DBV = 2, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Healing Rain Targets",
                    }, 
                    TT = { 
                        enUS = "Minimum Healing Rain Targets",
                        ruRU = "Minimum Healing Rain Targets",
                        frFR = "Minimum Healing Rain Targets",
                    },	
                    M = {},
                },		
                {
                    E = "Checkbox", 
                    DB = "HealingRainonMelee",
                    DBV = true,
                    L = { 
                        enUS = "Healing Rain on Melee", 
                        ruRU = "Healing Rain on Melee", 
                        frFR = "Healing Rain on Melee",  
                    }, 
                    TT = { 
                        enUS = "Cast on Melee only", 
                        ruRU = "Cast on Melee only",
                        frFR = "Cast on Melee only",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "HealingRainonCD",
                    DBV = true,
                    L = { 
                        enUS = "Healing Rain on CD", 
                        ruRU = "Healing Rain on CD", 
                        frFR = "Healing Rain on CD", 
                    }, 
                    TT = { 
                        enUS = "Requires Healing Rain on Melee to be checked to work", 
                        ruRU = "Requires Healing Rain on Melee to be checked to work", 
                        frFR = "Requires Healing Rain on Melee to be checked to work", 
                    }, 
                    M = {},
                },

				
		    },

            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Miscellaneous -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "OOCHealing",
                    DBV = true,
                    L = { 
                        enUS = "OOC Healing", 
                        ruRU = "OOC Healing", 
                        frFR = "OOC Healing", 
                    }, 
                    TT = { 
                        enUS = "|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFout of combat healing|cffFFBB00.", 
                        ruRU = "|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFout of combat healing|cffFFBB00.",
                        frFR = "|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFout of combat healing|cffFFBB00.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AutoGhostWolf",
                    DBV = true,
                    L = { 
                        enUS = "Auto Ghost Wolf", 
                        ruRU = "Auto Ghost Wolf", 
                        frFR = "Auto Ghost Wolf", 
                    }, 
                    TT = { 
                        enUS = "|cff0070deCheck this to automatically control GW transformation based on toggle bar setting.", 
                        ruRU = "|cff0070deCheck this to automatically control GW transformation based on toggle bar setting.",
                        frFR = "|cff0070deCheck this to automatically control GW transformation based on toggle bar setting.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseCapacitorTotem",
                    DBV = true,
                    L = { 
                        enUS = "Use Capacitor Totem", 
                        ruRU = "Use Capacitor Totem", 
                        frFR = "Use Capacitor Totem", 
                    }, 
                    TT = { 
                        enUS = "Will force use of Capacitor Totem if Wind Shear is not ready.", 
                        ruRU = "Will force use of Capacitor Totem if Wind Shear is not ready.",
                        frFR = "Will force use of Capacitor Totem if Wind Shear is not ready.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "WaterWalking",
                    DBV = true,
                    L = { 
                        enUS = "Water Walking", 
                        ruRU = "Water Walking", 
                        frFR = "Water Walking", 
                    }, 
                    TT = { 
                        enUS = "Will force use of Water Walking if ready.", 
                        ruRU = "Will force use of Water Walking if ready.", 
                        frFR = "Will force use of Water Walking if ready.", 
                    }, 
                    M = {},
                },
			},
			{
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "Bursting",
                    DBV = 2, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Bursting",
                    }, 
                    TT = { 
                        enUS = "|cffFFFFFFWhen Bursting stacks are above this amount, CDs/AoE Healing will be triggered.",
                        ruRU = "|cffFFFFFFWhen Bursting stacks are above this amount, CDs/AoE Healing will be triggered.",
                        frFR = "|cffFFFFFFWhen Bursting stacks are above this amount, CDs/AoE Healing will be triggered.",
                    },	
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DPSThreshold",
                    DBV = 50, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "DPSThreshold",
                    }, 
                    TT = { 
                        enUS = "|cffFFFFFFMinimum Health to stop DPS. Default: 50",  
                        ruRU = "|cffFFFFFFMinimum Health to stop DPS. Default: 50", 
                        frFR = "|cffFFFFFFMinimum Health to stop DPS. Default: 50", 
                    },	
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "CriticalHP",
                    DBV = 30, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Critical HP",
                    }, 
                    TT = { 
                        enUS = "|cffFFFFFFWill stop casting a DPS Spell if party member drops below value. Default: 30", 
                        ruRU = "|cffFFFFFFWill stop casting a DPS Spell if party member drops below value. Default: 30",  
                        frFR = "|cffFFFFFFWill stop casting a DPS Spell if party member drops below value. Default: 30", 
                    },	
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ManaPot",
                    DBV = 30, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Mana Pot",
                    }, 
                    TT = { 
                        enUS = "|cffFFFFFFWill use mana pot if mana below this value. Default: 30", 
                        ruRU = "|cffFFFFFFWill use mana pot if mana below this value. Default: 30",  
                        frFR = "|cffFFFFFFWill use mana pot if mana below this value. Default: 30", 
                    },	
                    M = {},
                },
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },			
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AstralShiftHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(108271) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "EarthShieldHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(974) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "HealingSurgeHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(8004) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AbyssalHealingPotionHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(301308) .. " (%)",
                    }, 
                    M = {},
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UseEarthElemental",
                    DBV = true,
                    L = { 
                        enUS = "Defensive Earth Elemental", 
                        ruRU = "Defensive Earth Elemental", 
                        frFR = "Defensive Earth Elemental", 
                    }, 
                    TT = { 
                        enUS = "Will use Earth Elemental defensively depending on your settings.", 
                        ruRU = "Will use Earth Elemental defensively depending on your settings.", 
                        frFR = "Will use Earth Elemental defensively depending on your settings.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "EarthElementalHP",
                    DBV = 40, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Health",
                    },
                    TT = { 
                        enUS = "Current player health percentage to use Earth Elemental.", 
                        ruRU = "Current player health percentage to use Earth Elemental.", 
                        frFR = "Current player health percentage to use Earth Elemental.",
                    },					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 15,                            
                    DB = "EarthElementalEnemies",
                    DBV = 3, 
                    ONOFF = true,
                    L = { 
                        ANY = "Enemies",
                    }, 
                    TT = { 
                        enUS = "Number of enemies around to use Earth Elemental.", 
                        ruRU = "Number of enemies around to use Earth Elemental.", 
                        frFR = "Number of enemies around to use Earth Elemental.",
                    },
                    M = {},
                },
			},
            { -- [4] 4th Row
                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Ancestral Guidance -- ",
                    },
                },
            },
			{
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "In Raid", value = "In Raid" },
                        { text = "In Dungeon", value = "In Dungeon" },
						{ text = "In PvP", value = "In PvP" },
                        { text = "Everywhere", value = "Everywhere" },
                    },
                    MULT = false,
                    DB = "AncestralGuidanceSelection",
                    DBV = "In Dungeon", 
                    L = { 
                        ANY = "Ancestral Guidance usage",
                    }, 
                    TT = { 
                        enUS = "Choose where you want to automatically Ancestral Guidance units.", 
                        ruRU = "Choose where you want to automatically Ancestral Guidance units.",
                    }, 
                    M = {},
                },	
			},	
			{
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AncestralGuidanceHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Defensive Logic",
                    },
                    TT = { 
                        enUS = "Auto : Will dynamically take in account your current group size, current group damage and healing per second to determine when to use assist healing.\nNOT Auto : the value set with slider will be the current percent damage per second on your group.", 
                        ruRU = "Auto : Will dynamically take in account your current group size, current group damage and healing per second to determine when to use assist healing.\nNOT Auto : the value set with slider will be the current percent damage per second on your group.", 
                        frFR = "Auto : Will dynamically take in account your current group size, current group damage and healing per second to determine when to use assist healing.\nNOT Auto : the value set with slider will be the current percent damage per second on your group.", 
                    },					
                    M = {},
                },
			},

            { -- [4] 4th Row
                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "HexPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(51514),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                        frFR = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Seulement si le joueur de mêlée a des buffs de dégâts\nON COOLDOWN - les moyens seront toujours utilisés sur les joueurs de mêlée\nOFF - Coupé de la rotation mais autorisant toujours le travail dans la file d'attente et Systèmes MSG\nSi vous souhaitez l'éteindre complètement, vous devez définir SetBlocker dans l'onglet 'Actions'", 
                    },  
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "HexPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(51514) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
    },
    -- MSG Actions UI
    [7] = {
        [ACTION_CONST_SHAMAN_ENCHANCEMENT] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
        [ACTION_CONST_SHAMAN_RESTORATION] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
        [ACTION_CONST_SHAMAN_ELEMENTAL] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
    },
}


-----------------------------------------
--                   PvP  
-----------------------------------------

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].SpearHandStrike and A[A.PlayerSpec].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerSpec].SpearHandStrike:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "ParalysisPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 


