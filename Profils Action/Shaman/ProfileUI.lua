--------------------------------
-- Taste TMW Action ProfileUI --
--------------------------------
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
local TR                                            = Action.TasteRotation
local select, setmetatable							= select, setmetatable

A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()] = true
A.Data.ProfileUI = {    
    DateTime = "v4.2.2 (21.07.2020)",
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
            { -- [7] Spell Status Frame
                {
                    E = "Header",
                    L = {
                        ANY = " -- Spell Status Frame -- ",
                    },
                },
            },	
			{
                {
                    E         = "Button",
                    H         = 35,
                    OnClick = function(self, button, down)     
                        if button == "LeftButton" then 
							TR.ToggleStatusFrame() 
                        else                
                            Action.CraftMacro("Status Frame", [[/run Action.TasteRotation.ToggleStatusFrame()]], 1, true, true)   
                        end 
                    end, 
                    L = { 
                        ANY = "Status Frame\nMacro Creator",
                    }, 
                    TT = { 
                        enUS = "Click this button to create the special status frame macro.\nStatus Frame is a new windows that allow user to track blocked spells during fight. So you don't have to check your chat anymore.", 
                        ruRU = "Нажмите эту кнопку, чтобы создать специальный макрос статуса.\nStatus Frame - это новые окна, которые позволяют пользователю отслеживать заблокированные заклинания во время боя. Так что вам больше не нужно проверять свой чат.",  
                        frFR = "Cliquez sur ce bouton pour créer la macro de cadre d'état spécial.\nLe cadre d'état est une nouvelle fenêtre qui permet à l'utilisateur de suivre les sorts bloqués pendant le combat. Vous n'avez donc plus besoin de vérifier votre chat.", 
                    },                           
                },
                {
                    E = "Checkbox", 
                    DB = "ChangelogOnStartup",
                    DBV = true,
                    L = { 
                        enUS = "Changelog On Startup", 
                        ruRU = "Журнал изменений при запуске", 
                        frFR = "Journal des modifications au démarrage",
                    }, 
                    TT = { 
                        enUS = "Will show latest changelog of the current rotation when you enter in game.\nDisable this option to block the popup when you enter the game.", 
                        ruRU = "При входе в игру будет отображаться последний список изменений текущего вращения.\nОтключить эту опцию, чтобы заблокировать всплывающее окно при входе в игру.", 
                        frFR = "Affiche le dernier journal des modifications de la rotation actuelle lorsque vous entrez dans le jeu.\nDésactivez cette option pour bloquer la fenêtre contextuelle lorsque vous entrez dans le jeu..", 
                    }, 
                    M = {},
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
                    DBV = 8, -- Set healthpercentage @30% life. 
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
                    E = "Checkbox", 
                    DB = "TrinketOnlyBurst",
                    DBV = true,
                    L = { 
                        enUS = "Trinkets\nBurst only", 
                        ruRU = "Trinkets\nBurst only", 
                        frFR = "Trinkets\nBurst only", 
                    }, 
                    TT = { 
                        enUS = "Enable this to option to trinkets with Burst usage ONLY.", 
                        ruRU = "Enable this to option to trinkets with Burst usage ONLY.", 
                        frFR = "Enable this to option to trinkets with Burst usage ONLY.",  
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
            { -- [7] Spell Status Frame
                {
                    E = "Header",
                    L = {
                        ANY = " -- Spell Status Frame -- ",
                    },
                },
            },	
			{
                {
                    E         = "Button",
                    H         = 35,
                    OnClick = function(self, button, down)     
                        if button == "LeftButton" then 
							TR.ToggleStatusFrame() 
                        else                
                            Action.CraftMacro("Status Frame", [[/run Action.TasteRotation.ToggleStatusFrame()]], 1, true, true)   
                        end 
                    end, 
                    L = { 
                        ANY = "Status Frame\nMacro Creator",
                    }, 
                    TT = { 
                        enUS = "Click this button to create the special status frame macro.\nStatus Frame is a new windows that allow user to track blocked spells during fight. So you don't have to check your chat anymore.", 
                        ruRU = "Нажмите эту кнопку, чтобы создать специальный макрос статуса.\nStatus Frame - это новые окна, которые позволяют пользователю отслеживать заблокированные заклинания во время боя. Так что вам больше не нужно проверять свой чат.",  
                        frFR = "Cliquez sur ce bouton pour créer la macro de cadre d'état spécial.\nLe cadre d'état est une nouvelle fenêtre qui permet à l'utilisateur de suivre les sorts bloqués pendant le combat. Vous n'avez donc plus besoin de vérifier votre chat.", 
                    },                           
                },
                {
                    E = "Checkbox", 
                    DB = "ChangelogOnStartup",
                    DBV = true,
                    L = { 
                        enUS = "Changelog On Startup", 
                        ruRU = "Журнал изменений при запуске", 
                        frFR = "Journal des modifications au démarrage",
                    }, 
                    TT = { 
                        enUS = "Will show latest changelog of the current rotation when you enter in game.\nDisable this option to block the popup when you enter the game.", 
                        ruRU = "При входе в игру будет отображаться последний список изменений текущего вращения.\nОтключить эту опцию, чтобы заблокировать всплывающее окно при входе в игру.", 
                        frFR = "Affiche le dernier journal des modifications de la rotation actuelle lorsque vous entrez dans le jeu.\nDésactivez cette option pour bloquer la fenêtre contextuelle lorsque vous entrez dans le jeu..", 
                    }, 
                    M = {},
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
            LayoutOptions = { gutter = 5, padding = { left = 10, right = 10 } },	
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },
            { -- [1]                             
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@mouseover", 
                        ruRU = "Использовать\n@mouseover", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "targettarget",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@targettarget", 
                        ruRU = "Использовать\n@targettarget", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions\nfor enemy @targettarget units", 
                        ruRU = "Разблокирует использование\nдействий для вражеских @targettarget юнитов", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use\nAoE", 
                        ruRU = "Использовать\nAoE", 
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                    }, 
                    M = {},
                },  
                {
                    E = "Checkbox", 
                    DB = "UseRotationPassive",
                    DBV = true,
                    L = { 
					    enUS = "Use\nPassive\nRotation",
                        ruRU = "Включить\nПассивную\nРотацию" 
	                },
                    M = {},
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
   	        { -- [7] 
                {
                    E = "Checkbox", 
                    DB = "ManaManagement",
                    DBV = true,
                    L = { 
                        enUS = "Boss Fight\nManaSave\n(PvE)", 
                        ruRU = "Бой с Боссом\nУправление Маной\n(PvE)",
                    }, 
                    TT = { 
                        enUS = "Enable to keep small mana save tricks during boss fight\nMana will keep going to save phase if Boss HP >= our Mana", 
                        ruRU = "Включает сохранение малого количества маны с помощью некоторых манипуляций в течении боя против Босса\nМана будет переходить в фазу сохранения если ХП Босса >= нашей Маны", 
                    }, 
                    M = {},
                }, 			
      	        {
         	        E = "Checkbox", 
         	        DB = "ManaPotion",
         	        DBV = true,
         	        L = { 
					    enUS = "Use\nMana Potion",
                        ruRU = "Использовать\nЗелье Маны",
					},
        	        M = {},
       	        },
      	        {
         	        E = "Checkbox", 
         	        DB = "StopCastOverHeal",
         	        DBV = true,
         	        L = { 
					    enUS = "Stop Cast\noverhealing",
                        ruRU = "Stop Cast\noverhealing",
					},
          	        TT = { 
					    enUS = "Enable this option to automatically stop the current cast to avoid overhealing.",
                        ruRU = "Enable this option to automatically stop the current cast to avoid overhealing.",
					},
        	        M = {},
       	        },	 	
            },
            {			
        	    {	    
           	        E = "Checkbox", 
           	        DB = "StartByPreCast",
           	        DBV = true,
           	        L = { 
					    enUS = "Begin Combat\nBy PreCast",
                        ruRU = "Начинать Бой\nЗаранее произнося", 
	                },
           	        TT = { 
					    enUS = "Will start rotation on enemy by available longer\ncasting spell depended on your spec",
                        ruRU = "Будет начинать ротация на противнике с доступной\nдлинной произносящейся способности в зависимости от спека",
					},
           	        M = {},
        	    },
      	        {
         	        E = "Checkbox", 
         	        DB = "SpellKick",
         	        DBV = true,
         	        L = { 
					    enUS = "Spell Kick",
                        ruRU = "Spell Kick",
					},
          	        TT = { 
					    enUS = "Enable this option to automatically use your kicking spells.",
                        ruRU = "Enable this option to automatically use your kicking spells.",
					},
        	        M = {},
       	        },
   	        },
		    	
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Racials -- ",
                    },
                },
            },	
			{
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RacialBurstHealing",                    
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["RACIAL"] .. "\n(Healing HP %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RacialBurstDamaging",                    
                    DBV = 100,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["RACIAL"] .. "\n(Damaging HP %)",                        
                    },                     
                    M = {},
                },
			},
            { -- Trinkets
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },	
            {     			
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Always", value = "Always" },
                        { text = "Burst Synchronized", value = "BurstSync" },                    
                    },
                    DB = "TrinketBurstSyncUP",
                    DBV = "Always",
                    L = { 
					    enUS = "Damager: How to use trinkets",
                        ruRU = "Урон: Как использовать аксессуары", 
					},
                    TT = { 
					    enUS = "Always: On cooldown\nBurst Synchronized: By Burst Mode in 'General' tab",
                        ruRU = "Always: По доступности\nBurst Synchronized: От Режима Бурстов во вкладке 'Общее'", 
					}, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "TrinketMana",
                    DBV = 85,
                    ONLYOFF = false,
                    L = { 
					    enUS = "Trinket: Mana(%)",
                        ruRU = "Trinket: Mana(%)",
	                },
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "TrinketBurstHealing",
                    DBV = 75,
                    ONLYOFF = false,
                    L = { 
					    enUS = "Healer: Target Health (%)",
                        ruRU = "Лекарь: Здоровье Цели (%)", 
	                },
                    M = {},
                },		
		    },
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Essences -- ",
                    },
                },
            },	
			{
			RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "LucidDreamManaPercent",                    
                    DBV = 85,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(299374) .. "\nMana %",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "LifeBindersInvocationUnits",                    
                    DBV = 5,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(299944) .. "\nunits number",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LifeBindersInvocationHP",                    
                    DBV = 85,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(299944) .. "\n(%)",                        
                    },                     
                    M = {},
                },
			},
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Mythic + -- ",
                    },
                },
            },	
			{
      	        {
         	        E = "Checkbox", 
         	        DB = "MythicPlusLogic",
         	        DBV = true,
         	        L = { 
					    enUS = "Smart Mythic+",
                        ruRU = "Smart Mythic+",
					},
          	        TT = { 
					    enUS = "Enable this option to activate critical healing logic depending of the current dungeon.\nExample:Fulminating Zap in Junkyard",
                        ruRU = "Enable this option to activate critical healing logic depending of the current dungeon.\nExample:Fulminating Zap in Junkyard",
					},
        	        M = {},
       	        },	
      	        {
         	        E = "Checkbox", 
         	        DB = "GrievousWoundsLogic",
         	        DBV = true,
         	        L = { 
					    enUS = "Grievous Wounds\nlogic",
                        ruRU = "Grievous Wounds\nlogic",
					},
          	        TT = { 
					    enUS = "Enable this option to activate critical healing logic for friendly units that got Grievous Wounds debuff.",
                        ruRU = "Enable this option to activate critical healing logic for friendly units that got Grievous Wounds debuff.",
					},
        	        M = {},
       	        },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 5,                            
                    DB = "GrievousWoundsMinStacks",                    
                    DBV = 2,
                    ONOFF = false,
                    L = { 
                        ANY = "Grievous Wounds\nmin stacks",                        
                    },   
          	        TT = { 
					    enUS = "How many stacks of Grievous Wounds should be up on friendly unit before force targetting on this unit.\nExample: 2 means friendly unit will be urgently targetted if he got 2 stacks.", 
                        ruRU = "How many stacks of Grievous Wounds should be up on friendly unit before force targetting on this unit.\nExample: 2 means friendly unit will be urgently targetted if he got 2 stacks.", 
					},					
                    M = {},
                },				
      	        {
         	        E = "Checkbox", 
         	        DB = "StopCastQuake",
         	        DBV = true,
         	        L = { 
					    enUS = "Stop Cast\nquaking",
                        ruRU = "Stop Cast\nquaking",
					},
          	        TT = { 
					    enUS = "Enable this option to automatically stop your current cast before Quake.",
                        ruRU = "Enable this option to automatically stop your current cast before Quake.",
					},
        	        M = {},
       	        },	
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 3,                            
                    DB = "StopCastQuakeSec",                    
                    DBV = 1,
					Precision = 1,
                    ONOFF = false,
                    L = { 
                        ANY = "Stop Cast\nquaking seconds",                      
                    },
          	        TT = { 
					    enUS = "Define the value you want to stop your cast before next Quake hit.\nValue is in seconds.\nExample: 1 means you will stop cast at 1sec remaining on Quaking.",            
                        ruRU = "Define the value you want to stop your cast before next Quake hit.\nValue is in seconds.\nExample: 1 means you will stop cast at 1sec remaining on Quaking.",            
					},					
                    M = {},
                },
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Utilities -- ",
                    },
                },
            },
			{
                {
                    E = "Checkbox", 
                    DB = "UseGhostWolf",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(2645), 
                        ruRU = "Авто " .. A.GetSpellInfo(2645), 
                        frFR = "Auto " .. A.GetSpellInfo(2645), 
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
                        enUS = A.GetSpellInfo(2645) .. " if moving for",
                        ruRU = A.GetSpellInfo(2645) .. " если переехать",
                        frFR = A.GetSpellInfo(2645) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(2645) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(2645) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(2645) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
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
                    DB = "AbyssalHealingPotionHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(301308) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- HealingTideTotem
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(108280) .. " -- ",
                    },
                }, 
            },
			{
			    RowOptions = { margin = { top = -10 } },
                {
                    E = "Header",
                    L = {
                        ANY = " -- Raid -- ",
                    },
                },
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dungeon -- ",
                    },
                },
			},
            -- HealingTideTotem
            { -- [3] 
              	RowOptions = { margin = { top = 10 } },		
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "HealingTideTotemRaidUnits",
                    DBV = 5,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(108280) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "HealingTideTotemPartyUnits",
                    DBV = 3,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(108280) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
			},
			{
			    RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HealingTideTotemRaidHP",
                    DBV = 65,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(108280) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "HealingTideTotemPartyHP",
                    DBV = 60,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(108280) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },			    
            },							
            { -- EarthShield
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(974) .. " -- ",
                    },
                }, 
            },
			{
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Auto", value = "Auto" },    
                        { text = "Tanking Units", value = "Tanking Units" },                    
                        { text = "Mostly Inc. Damage", value = "Mostly Inc. Damage" },
                    },
                    DB = "EarthShieldWorkMode",
                    DBV = "Tanking Units",
                    L = { 
                        ANY = A.GetSpellInfo(974) .. "\nWork Mode",
                    }, 
                    TT = { 
                        enUS = "These conditions will be skiped if unit will dying in emergency (critical) situation", 
                        ruRU = "Эти условия будут пропущены если юнит будет умирать в чрезвычайной (критической) ситуациии", 
                    },                    
                    M = {},
                },
            },	
            { -- ChainHeal
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(1064) .. " -- ",
                    },
                }, 
            },
			{
			    RowOptions = { margin = { top = -10 } },
                {
                    E = "Header",
                    L = {
                        ANY = " -- Raid -- ",
                    },
                },
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dungeon -- ",
                    },
                },
			},
            -- ChainHeal
            { -- [3] 
              	RowOptions = { margin = { top = 10 } },		
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "ChainHealRaidUnits",
                    DBV = 4,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(1064) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "ChainHealPartyUnits",
                    DBV = 3,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(1064) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
			},
			{
			    RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ChainHealRaidHP",
                    DBV = 92,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(1064) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "ChainHealPartyHP",
                    DBV = 80,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(1064) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },			    
            },	
            { -- HealingStreamTotem
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(5394) .. " -- ",
                    },
                }, 
            },			
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "HealingStreamTotemHP",
                    DBV = 55,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(5394) .. "\n(%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 5,                            
                    DB = "HealingStreamTotemUnits",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(5394) .. "\nunits",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "HealingStreamTotemRefresh",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(5394) .. "\nrefresh(sec)",
                    }, 
                    M = {},
                },
			},
            { -- HealingRain
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(73920) .. " -- ",
                    },
                }, 
            },			
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "HealingRainRefresh",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(73920) .. "\nrefresh(sec)",
                    }, 
                    M = {},
                },
			},
            { -- SpiritWalkersGrace
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(79206) .. " -- ",
                    },
                }, 
            },			
            {
      	        {
         	        E = "Checkbox", 
         	        DB = "UseSpiritWalkersGrace",
         	        DBV = true,
         	        L = { 
					    enUS = "Auto\n" .. A.GetSpellInfo(79206),
                        ruRU = "Auto\n" .. A.GetSpellInfo(79206),
					},
          	        TT = { 
					    enUS = "Enable this option to automatically use " .. A.GetSpellInfo(79206),
                        ruRU = "Enable this option to automatically use " .. A.GetSpellInfo(79206),
					},
        	        M = {},
       	        },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "SpiritWalkersGraceTime",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(79206) .. "\nif moving for",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "SpiritWalkersCatch",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(79206) .. "\nonly if rooted",
                    }, 
                    M = {},
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
                        enUS = "Enable/Disable relative party passive rotation", 
                        ruRU = "Включить/Выключить относительно группы пассивную ротацию", 
                    }, 
                    M = {},
                },  
      	        {
         	        E = "Checkbox", 
         	        DB = "Dispel",
         	        DBV = true,
         	        L = { 
					    enUS = "Auto\n" .. A.GetSpellInfo(528),
                        ruRU = "Auto\n" .. A.GetSpellInfo(528),
					},
          	        TT = { 
					    enUS = "Enable this option to automatically use " .. A.GetSpellInfo(528),
                        ruRU = "Enable this option to automatically use " .. A.GetSpellInfo(528),
					},
        	        M = {},
       	        },
      	        {
         	        E = "Checkbox", 
         	        DB = "Purje",
         	        DBV = true,
         	        L = { 
					    enUS = "Auto\n" .. A.GetSpellInfo(527),
                        ruRU = "Auto\n" .. A.GetSpellInfo(527),
					},
          	        TT = { 
					    enUS = "Enable this option to automatically use " .. A.GetSpellInfo(527),
                        ruRU = "Enable this option to automatically use " .. A.GetSpellInfo(527),
					},
        	        M = {},
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


