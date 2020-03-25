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
    DateTime = "v4.0.2 (25.03.2020)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_MAGE_FIRE] = {  
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
                    DB = "BlazingBarrier",
                    DBV = 99, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(235313) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "IceBlock",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(45438) .. " (%)",
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
                    DB = "PolymorphPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(118),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
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
                    DB = "PolymorphPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(118) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_MAGE_ARCANE] = {  
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
            { -- [2] 2nd Row
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "ManaSaveToBurn",
                    DBV = 25, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Percent Mana to use Burn rotation",
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
                    DB = "PrismaticBarrier",
                    DBV = 99, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(235450) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "IceBlock",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(45438) .. " (%)",
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
                    DB = "PolymorphPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(118),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
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
                    DB = "PolymorphPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(118) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_MAGE_FROST] = {  
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
            { -- [2] 2nd Row
				-- Splash Data
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "USE COMBAT LOGS", value = "USE COMBAT LOGS" }, 
                        { text = "USE SPLASH DATA", value = "USE SPLASH DATA" },                   
                        { text = "USE NAMEPLATES", value = "USE NAMEPLATES" },
                    },
                    DB = "AoeDetectionMode",
                    DBV = "USE COMBAT LOGS",
                    L = { 
                        ANY = "AoE Detection Mode",
                    }, 
                    TT = { 
                        enUS = "Select the AoE Detection mode you feel better with\nUSE COMBAT LOGS - Will count AoE enemies you are in combat with using combat logs.\nUSE SPLASH DATA - Only count AoE enemies that are already hit by AoE abilities.\nUSE NAMEPLATES - Will count AoE enemies using visible nameplates.\nDefault: USE COMBAT LOGS", 
                        ruRU = "Select the AoE Detection mode you feel better with\nUSE COMBAT LOGS - Will count AoE enemies you are in combat with using combat logs.\nUSE SPLASH DATA - Only count AoE enemies that are already hit by AoE abilities.\nUSE NAMEPLATES - Will count AoE enemies using visible nameplates.\nDefault: USE COMBAT LOGS", 
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
                    DB = "IceBarrier",
                    DBV = 99, -- Set healthpercentage @99% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(11426) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "IceBlock",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(45438) .. " (%)",
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
                    DB = "PolymorphPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(118),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
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
                    DB = "PolymorphPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(118) .. " units",
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
        [ACTION_CONST_MAGE_FIRE] = { 
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
        [ACTION_CONST_MAGE_ARCANE] = { 
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
        [ACTION_CONST_MAGE_FROST] = { 
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
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].Counterspell and A[A.PlayerSpec].Counterspell:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Counterspell:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "PolymorphPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Polymorph and A[A.PlayerSpec].Polymorph:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Polymorph:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 


