--------------------
-- Taste TMW Action ProfileUI

local TMW = TMW 
local CNDT = TMW.CNDT 
local Env = CNDT.Env
local A = Action
A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()] = true
A.Data.ProfileUI = {      
    DateTime = "v2.1.7 (08.02.2020)",
    -- Class settings
    [2] = {
        -- Unholy	
        [ACTION_CONST_DEATHKNIGHT_UNHOLY] = {          
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
            { -- [2] 2nd Row 
                {
                    E = "Checkbox", 
                    DB = "SoloMode",
                    DBV = false,
                    L = { 
                        enUS = "Enable Solo Mode", 
                        ruRU = "Включить Solo Mode",  
                        frFR = "Activez le mode solo", 
                    }, 
                    TT = { 
                        enUS = "Activate Solo Mode. Useful for low level chars or during leveling phase", 
                        ruRU = "Activate Solo Mode. Useful for low level chars or during leveling phase", 
                        frFR = "Activate Solo Mode. Useful for low level chars or during leveling phase", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "DisableAotD",
                    DBV = true,
                    L = { 
                        enUS = "Disable AotD checks", 
                        ruRU = "Disable AotD checks",  
                        frFR = "Disable AotD checks", 
                    }, 
                    TT = { 
                        enUS = "Enable this to option to remove ability checks against Army of the Dead. This can help smooth out the rotation if not using Army on cooldown.", 
                        ruRU = "Enable this to option to remove ability checks against Army of the Dead. This can help smooth out the rotation if not using Army on cooldown.", 
                        frFR = "Enable this to option to remove ability checks against Army of the Dead. This can help smooth out the rotation if not using Army on cooldown.", 
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
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "UseDeathStrikeHP",
                    DBV = 60, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(49998) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "IceboundFortitudeHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48792) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DeathPactHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48743) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AntiMagicShellHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48707) .. " (%)",
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
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
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
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseWraithWalk",
                    DBV = true,
                    L = { 
                        enUS = "Auto" .. A.GetSpellInfo(212552), 
                        ruRU = "Авто" .. A.GetSpellInfo(212552), 
                        frFR = "Auto" .. A.GetSpellInfo(212552), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(212552), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(212552), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(212552), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "WraithWalkTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true, 
                    L = { 
                        enUS = A.GetSpellInfo(212552) .. " if moving for",
                        ruRU = A.GetSpellInfo(212552) .. " если переехать",
                        frFR = A.GetSpellInfo(212552) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(212552) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(212552) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(212552) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },			
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseDeathsAdvance",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(48265), 
                        ruRU = "Авто " .. A.GetSpellInfo(48265), 
                        frFR = "Auto " .. A.GetSpellInfo(48265), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(48265), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(48265), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(48265), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "DeathsAdvanceTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(48265) .. " if moving for",
                        ruRU = A.GetSpellInfo(48265) .. " если переехать",
                        frFR = A.GetSpellInfo(48265) .. " si vous bougez pendant",
                    },					
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(48265) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(48265) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(48265) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },			
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseDeathGrip",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(49576), 
                        ruRU = "Авто " .. A.GetSpellInfo(49576), 
                        frFR = "Auto " .. A.GetSpellInfo(49576), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(49576) .. " if enemy try to move out.", 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(49576) .. " если враг попытается выйти.", 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(49576) .. " si l'ennemi essaie de partir.",  
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "DeathGripInterrupt",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(49576) .. " interrupt", 
                        ruRU = A.GetSpellInfo(49576) .. " прерывание", 
                        frFR = A.GetSpellInfo(49576) .. " interrupt", 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(49576) .. " as interrupt.", 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(49576) .. " как прерывание.", 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(49576) .. " comme interrupt.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseChainsofIce",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(45524), 
                        ruRU = "Авто " .. A.GetSpellInfo(45524), 
                        frFR = "Auto " .. A.GetSpellInfo(45524), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(45524), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(45524), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(45524), 
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
                    DB = "ImprisonPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(217832),
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
                    DB = "ImprisonPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(217832) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
		-- Frost
        [ACTION_CONST_DEATHKNIGHT_FROST] = {          
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
            { -- [2] 2nd Row 
                {
                    E = "Checkbox", 
                    DB = "SoloMode",
                    DBV = false,
                    L = { 
                        enUS = "Enable Solo Mode", 
                        ruRU = "Включить Solo Mode",  
                        frFR = "Activez le mode solo", 
                    },
                    TT = { 
                        enUS = "Activate Solo Mode and priorize survivability over the rest.\nUseful for low level chars or during leveling phase", 
                        ruRU = "Активируйте Solo Mode и установите приоритет выживаемости над остальными.\nПолезно для персонажей низкого уровня или во время фазы прокачки.", 
                        frFR = "Activez le mode solo et priorisez la survie par rapport au reste.\nUtile pour les caractères de bas niveau ou pendant la phase de leveling.", 
                    }, 
                    M = {},
                },                	
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(152279) .. " -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "BoSPoolTime",
                    DBV = 5, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(152279) .. " pool time", 
                        ruRU = A.GetSpellInfo(152279) .. " время бассейна", 
                        frFR = A.GetSpellInfo(152279) .. " temps de pool", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "BoSMinPower",
                    DBV = 60, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(152279) .. " pool power", 
                        ruRU = A.GetSpellInfo(152279) .. " время мощность", 
                        frFR = A.GetSpellInfo(152279) .. " pool puissance", 
                    }, 
                    M = {},
                },				
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "BoSEnemies",
                    DBV = 2, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(152279) .. " enemies", 
                        ruRU = A.GetSpellInfo(152279) .. " враги", 
                        frFR = A.GetSpellInfo(152279) .. " enemies", 
                    }, 
                    M = {},
                },				
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 15,                            
                    DB = "BoSEnemiesRange",
                    DBV = 8, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(152279) .. " enemies range check", 
                        ruRU = A.GetSpellInfo(152279) .. " enemies range check", 
                        frFR = A.GetSpellInfo(152279) .. " enemies range check", 
                    }, 
                    M = {},
                },				
            },
			-- Lucid Dream
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(299374) .. " -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "LucidDreamPower",
                    DBV = 60, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(299374) .. " Runic Power", 
                        ruRU = A.GetSpellInfo(299374) .. " Runic Power", 
                        frFR = A.GetSpellInfo(299374) .. " Puissance Runique", 
                    }, 
                    M = {},
                },
			},
			{
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "LucidDreamUseAfter",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = "Use " .. A.GetSpellInfo(299374) .. " X seconds after BoS", 
                        ruRU = "Use " .. A.GetSpellInfo(299374) .. " X seconds after BoS", 
                        frFR = "Use " .. A.GetSpellInfo(299374) .. " X seconds after BoS",
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
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "UseDeathStrikeHP",
                    DBV = 60, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(49998) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "IceboundFortitudeHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48792) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DeathPactHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48743) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AntiMagicShellHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48707) .. " (%)",
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
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
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
                        ANY = " -- Utilities -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseWraithWalk",
                    DBV = true,
                    L = { 
                        enUS = "Auto" .. A.GetSpellInfo(212552), 
                        ruRU = "Авто" .. A.GetSpellInfo(212552), 
                        frFR = "Auto" .. A.GetSpellInfo(212552), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(212552), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(212552), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(212552), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "WraithWalkTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true, 
                    L = { 
                        enUS = A.GetSpellInfo(212552) .. " if moving for",
                        ruRU = A.GetSpellInfo(212552) .. " если переехать",
                        frFR = A.GetSpellInfo(212552) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(212552) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(212552) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(212552) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },			
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseDeathsAdvance",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(48265), 
                        ruRU = "Авто " .. A.GetSpellInfo(48265), 
                        frFR = "Auto " .. A.GetSpellInfo(48265), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(48265), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(48265), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(48265), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "DeathsAdvanceTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(48265) .. " if moving for",
                        ruRU = A.GetSpellInfo(48265) .. " если переехать",
                        frFR = A.GetSpellInfo(48265) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(48265) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(48265) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(48265) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },			
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseDeathGrip",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(49576), 
                        ruRU = "Авто " .. A.GetSpellInfo(49576), 
                        frFR = "Auto " .. A.GetSpellInfo(49576), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(49576) .. " if enemy try to move out.", 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(49576) .. " если враг попытается выйти.", 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(49576) .. " si l'ennemi essaie de partir.",  
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "DeathGripInterrupt",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(49576) .. " interrupt", 
                        ruRU = A.GetSpellInfo(49576) .. " прерывание", 
                        frFR = A.GetSpellInfo(49576) .. " interrupt", 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(49576) .. " as interrupt.", 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(49576) .. " как прерывание.", 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(49576) .. " comme interrupt.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseChainsofIce",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(45524), 
                        ruRU = "Авто " .. A.GetSpellInfo(45524), 
                        frFR = "Auto " .. A.GetSpellInfo(45524), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(45524), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(45524), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(45524), 
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
                    DB = "ImprisonPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(217832),
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
                    DB = "ImprisonPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(217832) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
		-- Blood
        [ACTION_CONST_DEATHKNIGHT_BLOOD] = {          
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
            { -- [2] 2nd Row 
                {
                    E = "Checkbox", 
                    DB = "ConsumptionSuggested",
                    DBV = true,
                    L = { 
                        enUS = "Suggested: Consumption", 
                        ruRU = "Suggested: Consumption", 
                        frFR = "Suggested: Consumption",
                    }, 
                    TT = { 
                        enUS = "Suggest (Left Top icon) Consumption if Consumption is not enabled.", 
                        ruRU = "Suggest (Left Top icon) Consumption if Consumption is not enabled.", 
                        frFR = "Suggest (Left Top icon) Consumption if Consumption is not enabled.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "Consumption",
                    DBV = true,
                    L = { 
                        enUS = "Force Use: Consumption", 
                        ruRU = "Force Use: Consumption", 
                        frFR = "Force Use: Consumption",
                    }, 
                    TT = { 
                        enUS = "Enable use of Consumption if not enabled.", 
                        ruRU = "Enable use of Consumption if not enabled.", 
                        frFR = "Enable use of Consumption if not enabled.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "PoolDuringBlooddrinker",
                    DBV = true,
                    L = { 
                        enUS = "Pool: Blooddrinker", 
                        ruRU = "Pool: Blooddrinker", 
                        frFR = "Pool: Blooddrinker",
                    }, 
                    TT = { 
                        enUS = "Display the 'Pool' icon whenever you're channeling Blooddrinker as long as you shouldn't interrupt it (supports Quaking).", 
                        ruRU = "Display the 'Pool' icon whenever you're channeling Blooddrinker as long as you shouldn't interrupt it (supports Quaking).", 
                        frFR = "Display the 'Pool' icon whenever you're channeling Blooddrinker as long as you shouldn't interrupt it (supports Quaking).",
                    }, 
                    M = {},
                },				
            },
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [2] 2nd Row 
                {
                    E = "Checkbox", 
                    DB = "ArcaneTorrent",
                    DBV = true,
                    L = { 
                        enUS = "Force Use: ArcaneTorrent", 
                        ruRU = "Force Use: ArcaneTorrent", 
                        frFR = "Force Use: ArcaneTorrent", 
                    }, 
                    TT = { 
                        enUS = "Enable use of ArcaneTorrent if not enabled.", 
                        ruRU = "Enable use of ArcaneTorrent if not enabled.", 
                        frFR = "Enable use of ArcaneTorrent if not enabled.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "DancingRuneWeapon",
                    DBV = true,
                    L = { 
                        enUS = "Force Use: DancingRuneWeapon", 
                        ruRU = "Force Use: DancingRuneWeapon", 
                        frFR = "Force Use: DancingRuneWeapon",
                    }, 
                    TT = { 
                        enUS = "Enable use of DancingRuneWeapon if not enabled.", 
                        ruRU = "Enable use of DancingRuneWeapon if not enabled.", 
                        frFR = "Enable use of DancingRuneWeapon if not enabled.", 
                    }, 
                    M = {},
                }, 				
            },
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
                },
            },			
            {
    			{
                    E = "Checkbox", 
                    DB = "AutoTaunt",
                    DBV = true,
                    L = { 
                        enUS = "Automatic Taunt", 
                        ruRU = "Автоматическая Насмешка", 
                        frFR = "Raillerie automatique",
                    }, 
                    TT = { 
                        enUS = "If activated, will use automatically use Growl whenever available.", 
                        ruRU = "Если активирован, будет автоматически использовать Growl при любой возможности.",  
                        frFR = "S'il est activé, utilisera automatiquement Growl dès qu'il sera disponible.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ThreatDamagerLimit",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = "Only 'Damager'\nThreat limit(agro,>= %)",
						ruRU = "Только 'Урон'\nЛимит угрозы(агро,>= %)", 
						frFR = "Seulement 'DPS'\nLimite de menace(аggrо,>= %)", 
					}, 
                    TT = { 
                        enUS = "OFF - No limit\nIf the percentage of the threat (agro) is greater than\nor equal to the specified one, then the\n'safe' rotation will be performed. As far as possible, the\nabilities causing too many threats will be stopped until the\nthreat level (agro) is normalized", 
                        ruRU = "OFF - Нет лимита\nЕсли процент угрозы (агро) больше или равен указанному,\nто будет выполняться 'безопасная' ротация\nПо мере возможности перестанут использоваться способности\nвызывающие слишком много угрозы пока\nуровень угрозы (агро) не нормализуется",  
                        frFR = "OFF - Aucune limite\nSi le pourcentage de la menace (agro) est supérieur ou égal à celui spécifié, alors la rotation\n'safe' sera effectuée. Dans la mesure du possible, les \nabilités causant trop de menaces seront arrêtées jusqu'à ce que le\n niveau de menace (agro) soit normalisé",
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
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DeathStrikeHP",
                    DBV = 80, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(49998) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "IceboundFortitudeHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48792) .. " (%)",
                    }, 
                    M = {},
                },

            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DancingRuneWeaponHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(49028) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AntiMagicShellHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48707) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DeathPactHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48743) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "VampiricBloodHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(49028) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [4] 4th Row

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
            { -- [4] 4th Row

                {
                    E = "LayoutSpace",                                                                         
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
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseWraithWalk",
                    DBV = true,
                    L = { 
                        enUS = "Auto" .. A.GetSpellInfo(212552), 
                        ruRU = "Авто" .. A.GetSpellInfo(212552), 
                        frFR = "Auto" .. A.GetSpellInfo(212552), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(212552), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(212552), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(212552), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "WraithWalkTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(212552) .. " if moving for",
                        ruRU = A.GetSpellInfo(212552) .. " если переехать",
                        frFR = A.GetSpellInfo(212552) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(212552) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(212552) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(212552) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },			
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseDeathsAdvance",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(48265), 
                        ruRU = "Авто " .. A.GetSpellInfo(48265), 
                        frFR = "Auto " .. A.GetSpellInfo(48265), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(48265), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(48265), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(48265), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "DeathsAdvanceTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(48265) .. " if moving for",
                        ruRU = A.GetSpellInfo(48265) .. " если переехать",
                        frFR = A.GetSpellInfo(48265) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(48265) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(48265) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(48265) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },			
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseDeathGrip",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(49576), 
                        ruRU = "Авто " .. A.GetSpellInfo(49576), 
                        frFR = "Auto " .. A.GetSpellInfo(49576), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(49576) .. " if enemy try to move out.", 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(49576) .. " если враг попытается выйти.", 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(49576) .. " si l'ennemi essaie de partir.",  
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "DeathGripInterrupt",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(49576) .. " interrupt", 
                        ruRU = A.GetSpellInfo(49576) .. " прерывание", 
                        frFR = A.GetSpellInfo(49576) .. " interrupt", 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(49576) .. " as interrupt.", 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(49576) .. " как прерывание.", 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(49576) .. " comme interrupt.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseChainsofIce",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(45524), 
                        ruRU = "Авто " .. A.GetSpellInfo(45524), 
                        frFR = "Auto " .. A.GetSpellInfo(45524), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(45524), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(45524), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(45524), 
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
                    DB = "AsphyxiatePvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(221562),
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
                    DB = "AsphyxiatePvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(221562) .. " units",
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
        [ACTION_CONST_DEATHKNIGHT_UNHOLY] = { 
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
        [ACTION_CONST_DEATHKNIGHT_FROST] = {  
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
        [ACTION_CONST_DEATHKNIGHT_BLOOD] = {  
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


