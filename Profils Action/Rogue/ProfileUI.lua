--------------------
-- Taste TMW Action ProfileUI

local TMW                                             = TMW
local A                                             = Action
local UnitCooldown                                    = A.UnitCooldown
local Unit                                            = A.Unit 
local Player                                        = A.Player 
local Pet                                             = A.Pet
local LoC                                             = A.LossOfControl
local MultiUnits                                    = A.MultiUnits
local EnemyTeam                                        = A.EnemyTeam
local FriendlyTeam                                    = A.FriendlyTeam
local TeamCache                                        = A.TeamCache
local InstanceInfo                                    = A.InstanceInfo
local select                                        = select


A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()] = true
A.Data.ProfileUI = {    
    DateTime = "v2.0.7 (23.12.2019)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_ROGUE_OUTLAW] = {  
        LayoutOptions = { gutter = 4, padding = { left = 5, right = 5 } },		
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
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "StealthOOC",
                    DBV = true,
                    L = { 
                        enUS = "Stealth Reminder (OOC)", 
                        ruRU = "Stealth Reminder (OOC)", 
                        frFR = "Stealth Reminder (OOC)",
                    }, 
                    TT = { 
                        enUS = "Show Stealth Reminder when out of combat.", 
                        ruRU = "Show Stealth Reminder when out of combat.", 
                        frFR = "Show Stealth Reminder when out of combat.",
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "UseDPSVanish",
                    DBV = false,
                    L = { 
                        enUS = "Use Vanish for DPS", 
                        ruRU = "Use Vanish for DPS", 
                        frFR = "Use Vanish for DPS",
                    }, 
                    TT = { 
                        enUS = "Suggest Vanish -> Ambush for DPS.Disable to save Vanish for utility purposes.", 
                        ruRU = "Suggest Vanish -> Ambush for DPS.Disable to save Vanish for utility purposes.", 
                        frFR = "Suggest Vanish -> Ambush for DPS.Disable to save Vanish for utility purposes.",
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "SoloMode",
                    DBV = false,
                    L = { 
                        enUS = "Enable Solo Mode", 
                        ruRU = "Enable Solo Mode",  
                        frFR = "Enable Solo Mode", 
                    }, 
                    TT = { 
                        enUS = "Activate Solo Mode and priorize survivability over the rest.\nUseful for low level chars or during leveling phase", 
                        ruRU = "Активируйте Solo Mode и установите приоритет выживаемости над остальными.\nПолезно для персонажей низкого уровня или во время фазы прокачки.", 
                        frFR = "Activez le mode solo et priorisez la survie par rapport au reste.\nUtile pour les caractères de bas niveau ou pendant la phase de leveling.", 
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
                        ANY = " -- AoE Settings -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "BladeFlurryTargets",
                    DBV = 3, -- Set healthpercentage @70% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(13877) .. " targets",
                    }, 
                    TT = { 
                        enUS = "How many targets should we have in range before using " .. A.GetSpellInfo(13877), 
                        ruRU = "Сколько целей мы должны иметь в радиусе действия перед использованием " .. A.GetSpellInfo(13877),
                        frFR = "Combien de cibles devons-nous avoir à portée avant d'utiliser " .. A.GetSpellInfo(13877),
                    },
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "BladeFlurryRange",
                    DBV = 20, -- Set healthpercentage @70% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(13877) .. " range",
                    }, 
                    TT = { 
                        enUS = "Define the range within you want to detect multiple enemies " .. A.GetSpellInfo(13877), 
                        ruRU = "Определите диапазон, в котором вы хотите обнаружить несколько врагов " .. A.GetSpellInfo(13877),
                        frFR = "Définissez la portée à l'intérieur de laquelle vous souhaitez détecter plusieurs ennemis " .. A.GetSpellInfo(13877),
                    },
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "BotEAoEBurst",
                    DBV = false,
                    L = { 
                        enUS = "Use " .. A.GetSpellInfo(298277) .. " in AoE", 
                        ruRU = "использование " .. A.GetSpellInfo(298277) .. " в AoE", 
                        frFR = "Utiliser " .. A.GetSpellInfo(298277) .. " en AoE", 
                    }, 
                    TT = { 
                        enUS = "Use " .. A.GetSpellInfo(298277) .. " to get maximum burst in AoE situations." , 
                        ruRU = "использование " .. A.GetSpellInfo(298277) .. " чтобы получить максимальный взрыв в AoE ситуациях." ,
                        frFR = "Utiliser " .. A.GetSpellInfo(298277) .. " pour obtenir un burst maximal dans les situations AoE." ,
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
            { -- [3] 3rd Row 
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
                        ANY = A.GetSpellInfo(2983) .. " if moving for",
                    }, 
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(2983) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(2983) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(2983) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
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
                    DB = "RiposteHP",
                    DBV = 30, -- Set healthpercentage @70% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(5277) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "CrimsonVialHP",
                    DBV = 40, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(185311) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FeintHP",
                    DBV = 30, -- Set healthpercentage @70% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(1966) .. " (%)",
                    }, 
                    M = {},
                },
            },
			{
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "VanishDefensive",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(1856) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "CloakofShadowHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(31224) .. " (%)",
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
                        ANY = " -- Roll the Bones -- ",
                    },
                },
            },
            { -- [4] 4th Row
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "RolltheBonesLeechHP",
                    DBV = 30, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(193316) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "SIMC", value = "SIMC" },
						{ text = "MYTHICPLUS", value = "MYTHICPLUS" },
						{ text = "AOESTRAT", value = "AOESTRAT" },
                        { text = "1BUFF", value = "1BUFF" },                    
                        { text = "BROADSIDE", value = "BROADSIDE" },
                        { text = "BURIEDTREASURE", value = "BURIEDTREASURE" },
						{ text = "GRANDMELEE", value = "GRANDMELEE" },
						{ text = "SKULLANDCROSS", value = "SKULLANDCROSS" },
						{ text = "RUTHLESSPRECISION", value = "RUTHLESSPRECISION" },
						{ text = "TRUEBEARING", value = "TRUEBEARING" },							
                    },
                    DB = "RolltheBonesLogic",
                    DBV = "SIMC",
                    L = { 
                        enUS = "Roll the Bones Logic", 
                        ruRU = "Бросок костей Логика", 
                        frFR = "Logique pour les Jet d’osselets",
                    }, 
                    TT = { 
                        enUS = "Define the Roll the Bones logic to follow.\n(SimC highly recommended!)", 
                        ruRU = "Определите логику Бросок костей, которой нужно следовать. \ N (SimC настоятельно рекомендуется!)", 
                        frFR = "Définissez la logique à suivre pour les Jet d’osselets.(SimC fortement recommandé!)",
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
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] Blind     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Only Heal", value = "Heal" },
                        { text = "Only PvP", value = "PvP" },
                        { text = "BOTH", value = "BOTH" },
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "BlindPvP",
                    DBV = "BOTH",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(2094),
                    }, 
                    TT = { 
                        enUS = "@arena1-3 interrupt PvP list from 'Interrupts' tab by Blind\nMore custom config you can find in group by open /tmw", 
                    }, 
                    M = {},
                },
            },
            { -- [10] Dismantle
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "DisarmPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(207777),
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
                    DB = "DisarmPvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(207777) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_ROGUE_SUBTLETY] = {       
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
                {
                    E = "Checkbox", 
                    DB = "OffGCDasOffGCD",
                    DBV = true,
                    L = { 
                        enUS = "Use spells OffGCD", 
                        ruRU = "Используйте заклинания OffGCD", 
                        frFR = "Utiliser les spells OffGCD",
                    }, 
                    TT = { 
                        enUS = "Will force certains spells to be used as off GCD", 
                        ruRU = "Вынудит определенные заклинания использоваться как вне GCD", 
                        frFR = "Forcera certains spells à être utilisés sur le GCD",
                    }, 
                    M = {},
                }, 
                
            },  
            { -- [2] 2nd Row
               {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Always", value = "Always" },
                        { text = "On Bosses", value = "On Bosses" },                    
                        { text = "On Bosses not in Dungeons", value = "On Bosses not in Dungeons" },
                    },
                    DB = "BurnShadowDance",
                    DBV = "On Bosses not in Dungeons",
                    L = { 
                        ANY = "Burn Shadow Dance before Death.",
                    }, 
                    TT = { 
                        enUS = "Use remaining Shadow Dance charges when the target is about to die.", 
                        ruRU = "Use remaining Shadow Dance charges when the target is about to die.", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Never", value = "Never" },
                        { text = "On Bosses", value = "On Bosses" },                    
                        { text = "Always", value = "Always" },
                    },
                    DB = "UsePriorityRotation",
                    DBV = "Never",
                    L = { 
                        ANY = "Use Priority Rotation",
                    }, 
                    TT = { 
                        enUS = "Select when to show rotation for maximum priority damage (at the cost of overall AoE damage.)", 
                        ruRU = "Select when to show rotation for maximum priority damage (at the cost of overall AoE damage.)", 
                    }, 
                    M = {},
                },				
            },
			{
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 5,  
                    Precision = 0.25, 	-- accuracy of slider move (default 2)					
                    DB = "EviscerateDMGOffset",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Eviscerate DMG Offset",
                    },
                    TT = { 
                        enUS = "Set the Eviscerate DMG Offset.", 
                        ruRU = "Set the Eviscerate DMG Offset.", 
                    }, 					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 3,         
                    Precision = 0.1, 	-- accuracy of slider move (default 2)					
                    DB = "ShDEcoCharge",
                    DBV = 2.55, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "ShD Eco Charge",
                    }, 
                    TT = { 
                        enUS = "Set the Shadow Dance Eco Charge threshold.", 
                        ruRU = "Set the Shadow Dance Eco Charge threshold.", 
                    }, 
                    M = {},
                },			
			},
			{
                {
                    E = "Checkbox", 
                    DB = "STMfDAsDPSCD",
                    DBV = false,
                    L = { 
                        enUS = "ST Marked for Death as DPS CD", 
                        ruRU = "ST Marked for Death as DPS CD", 
                        frFR = "ST Marked for Death as DPS CD",
                    }, 
                    TT = { 
                        enUS = "Enable if you want to put Single Target Marked for Death shown as Off GCD (top icons) instead of Suggested.", 
                        ruRU = "Enable if you want to put Single Target Marked for Death shown as Off GCD (top icons) instead of Suggested.", 
                        frFR = "Enable if you want to put Single Target Marked for Death shown as Off GCD (top icons) instead of Suggested.",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "Vanish",
                    DBV = true,
                    L = { 
                        enUS = "Stealth Combo - Vanish", 
                        ruRU = "Stealth Combo - Vanish", 
                        frFR = "Stealth Combo - Vanish",
                    }, 
                    TT = { 
                        enUS = "Allow suggesting Vanish stealth ability combos (recommended)", 
                        ruRU = "Allow suggesting Vanish stealth ability combos (recommended)", 
                        frFR = "Allow suggesting Vanish stealth ability combos (recommended)",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "Shadowmeld",
                    DBV = true,
                    L = { 
                        enUS = "Stealth Combo - Shadowmeld", 
                        ruRU = "Stealth Combo - Shadowmeld", 
                        frFR = "Stealth Combo - Shadowmeld",
                    }, 
                    TT = { 
                        enUS = "Allow suggesting Shadowmeld stealth ability combos (recommended)", 
                        ruRU = "Allow suggesting Shadowmeld stealth ability combos (recommended)", 
                        frFR = "Allow suggesting Shadowmeld stealth ability combos (recommended)",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "ShadowDance",
                    DBV = true,
                    L = { 
                        enUS = "Stealth Combo - Shadow Dance", 
                        ruRU = "Stealth Combo - Shadow Dance", 
                        frFR = "Stealth Combo - Shadow Dance",
                    }, 
                    TT = { 
                        enUS = "Allow suggesting Shadow Dance stealth ability combos (recommended)", 
                        ruRU = "Allow suggesting Shadow Dance stealth ability combos (recommended)", 
                        frFR = "Allow suggesting Shadow Dance stealth ability combos (recommended)",
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
                    E = "Checkbox", 
                    DB = "StealthOOC",
                    DBV = true,
                    L = { 
                        enUS = "Stealth Reminder (OOC)", 
                        ruRU = "Stealth Reminder (OOC)", 
                        frFR = "Stealth Reminder (OOC)",
                    }, 
                    TT = { 
                        enUS = "Show Stealth Reminder when out of combat.", 
                        ruRU = "Show Stealth Reminder when out of combat.", 
                        frFR = "Show Stealth Reminder when out of combat.",
                    }, 
                    M = {},
                }, 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "CrimsonVialHP",
                    DBV = 40, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(185311) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FeintHP",
                    DBV = 30, -- Set healthpercentage @70% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(1966) .. " (%)",
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
            { -- [5] Blind     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Only Heal", value = "Heal" },
                        { text = "Only PvP", value = "PvP" },
                        { text = "BOTH", value = "BOTH" },
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "BlindPvP",
                    DBV = "BOTH",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(2094),
                    }, 
                    TT = { 
                        enUS = "@arena1-3 interrupt PvP list from 'Interrupts' tab by Blind\nMore custom config you can find in group by open /tmw", 
                    }, 
                    M = {},
                },
            },
            { -- [10] Dismantle
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "DisarmPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(207777),
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
                    DB = "DisarmPvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(207777) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_ROGUE_ASSASSINATION ] = {
			LayoutOptions = { gutter = 4, padding = { left = 5, right = 5 } },		
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
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Rotation -- ",
                    },
                },
            },			
            { -- [2] 2nd Row
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
                        ANY = A.GetSpellInfo(2983) .. " if moving for",
                    }, 
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(2983) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(2983) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(2983) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
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
                    DB = "VanishBurst",
                    DBV = true,
                    L = { 
                        enUS = "Vanish burst", 
                        ruRU = "Vanish burst",  
                        frFR = "Vanish burst", 
                    }, 
                    TT = { 
                        enUS = "Suggest Vanish during fight to increase dps. \nBe careful : if you need Vanish later in the fight you can either block it and disable this option.", 
                        ruRU = "Suggest Vanish during fight to increase dps. \nBe careful : if you need Vanish later in the fight you can either block it and disable this option.", 
                        frFR = "Suggest Vanish during fight to increase dps. \nBe careful : if you need Vanish later in the fight you can either block it and disable this option.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "IWSubterfuge",
                    DBV = true,
                    L = { 
                        enUS = "Iron Wire combo", 
                        ruRU = "Iron Wire combo", 
                        frFR = "Iron Wire combo", 
                    }, 
                    TT = { 
                        enUS = "Will use garrote on the maximum targets available around you if Iron Wire and Subterfuge talents are learned.\nVery useful in high mythic+ key to set a 15% damage debuff on 3+ targets for 8sec. ", 
                        ruRU = "Will use garrote on the maximum targets available around you if Iron Wire and Subterfuge talents are learned.\nVery useful in high mythic+ key to set a 15% damage debuff on 3+ targets for 8sec. ",
                        frFR = "Will use garrote on the maximum targets available around you if Iron Wire and Subterfuge talents are learned.\nVery useful in high mythic+ key to set a 15% damage debuff on 3+ targets for 8sec. ",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "StealthOOC",
                    DBV = true,
                    L = { 
                        enUS = "Stealth Reminder (OOC)", 
                        ruRU = "Stealth Reminder (OOC)", 
                        frFR = "Stealth Reminder (OOC)",
                    }, 
                    TT = { 
                        enUS = "Show Stealth Reminder when out of combat.", 
                        ruRU = "Show Stealth Reminder when out of combat.", 
                        frFR = "Show Stealth Reminder when out of combat.",
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
                        ANY = " -- Dots & Finishers -- ",
                    },
                },
            },
            {   
			    {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Deadly Poison", value = "Deadly Poison" },
                        { text = "Wound Poison", value = "Wound Poison" },                    
                        { text = "Auto", value = "Auto" },
                    },
                    DB = "PoisonToUse",
                    DBV = "Auto",
                    L = { 
                        ANY = "Poisons",
                    }, 
                    TT = { 
                        enUS = "Select the poison the rotation should always maintain.\nIf Auto then it will auto adapt : Deadly Poison in PvE and Wound Poison in PvP.", 
                        ruRU = "Select the poison the rotation should always maintain.\nIf Auto then it will auto adapt : Deadly Poison in PvE and Wound Poison in PvP.", 
                    }, 
                    M = {},
                },
            },				
			{
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 5, 
                    Precision = 1,					
                    DB = "EnvenomDMGOffset",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Envenom DMG Offset",
                    },
                    TT = { 
                        enUS = "Used to check if Rupture is worth to be casted since it's a finisher.\nConsider this as the expected damage calculation of Rupture on every mobs around.\n(Default value : 3).",
                        ruRU = "Used to check if Rupture is worth to be casted since it's a finisher.\nConsider this as the expected damage calculation of Rupture on every mobs around.\n(Default value : 3).",
                        frFR = "Used to check if Rupture is worth to be casted since it's a finisher.\nConsider this as the expected damage calculation of Rupture on every mobs around.\n(Default value : 3).",
					},					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 5,  
                    Precision = 1,					
                    DB = "MutilateDMGOffset",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Mutilate DMG Offset",
                    },
                    TT = { 
                        enUS = "Used to check if Mutilate is worth to be casted since it's a finisher.\nConsider this as the expected damage calculation of Mutilate on every mobs around.\n(Default value : 3).", 
                        ruRU = "Used to check if Mutilate is worth to be casted since it's a finisher.\nConsider this as the expected damage calculation of Mutilate on every mobs around.\n(Default value : 3).",
                        frFR = "Used to check if Mutilate is worth to be casted since it's a finisher.\nConsider this as the expected damage calculation of Mutilate on every mobs around.\n(Default value : 3).", 
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
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 55, 
                    Precision = 1,					
                    DB = "PoisonRefresh",
                    DBV = 15, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "OOC Poison Refresh",
                    },
                    TT = { 
                        enUS = "Set the timer for the Poison Refresh (OOC). (Default 15).", 
                        ruRU = "Set the timer for the Poison Refresh (OOC). (Default 15).", 
                        frFR = "Set the timer for the Poison Refresh (OOC). (Default 15).",
					},					
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 55,             
                    Precision = 1,					
                    DB = "PoisonRefreshCombat",
                    DBV = 3, -- Set healthpercentage @70% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Combat Poison Refresh",
                    },
                    TT = { 
                        enUS = "Set the timer for the Poison Refresh (In Combat). (Default 3).", 
                        ruRU = "Set the timer for the Poison Refresh (In Combat). (Default 3).", 
                        frFR = "Set the timer for the Poison Refresh (In Combat). (Default 3).",
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
					MAX 	= 5,							
					DB 		= "MultiDotDistance",
					DBV 	= 5,
					ONLYOFF = true,
					L 		= { 
                        ANY = "Multidots Range",
                    }, 
					TT		= { 
                        enUS = "Choose the range where you want to automatically multidots units.", 
                        ruRU = "Choose the range where you want to automatically multidots units.", 
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
                        ANY = "Multidots where",
                    }, 
                    TT = { 
                        enUS = "Choose where you want to automatically multidots units.", 
                        ruRU = "Выберите, где вы хотите автоматически многоточечные единицы.", 
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
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "EvadeHP",
                    DBV = 30, -- Set healthpercentage @70% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(5277) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "CrimsonVialHP",
                    DBV = 40, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(185311) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FeintHP",
                    DBV = 30, -- Set healthpercentage @70% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(1966) .. " (%)",
                    }, 
                    M = {},
                },
            },
			{
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "VanishDefensive",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(1856) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "CloakofShadowHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(31224) .. " (%)",
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
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "SmokeBombFinishComco",
                    DBV = false,
                    L = { 
                        enUS = "Use Smoke Bomb Offensively", 
                        ruRU = "Use Smoke Bomb Offensively",  
                        frFR = "Use Smoke Bomb Offensively", 
                    }, 
                    TT = { 
                        enUS = "Allow to use Smoke Bomb when enemy is low health and his healer CC or not in range.", 
                        ruRU = "Allow to use Smoke Bomb when enemy is low health and his healer CC or not in range.", 
                        frFR = "Allow to use Smoke Bomb when enemy is low health and his healer CC or not in range.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "ShadowVanish",
                    DBV = false,
                    L = { 
                        enUS = "Use Cloak of Shadow Defensively", 
                        ruRU = "Use Cloak of Shadow Defensively",  
                        frFR = "Use Cloak of Shadow Defensively", 
                    }, 
                    TT = { 
                        enUS = "Allow to use Cloak of Shadow with Vanish in case of emergency.", 
                        ruRU = "Allow to use Cloak of Shadow with Vanish in case of emergency.", 
                        frFR = "Allow to use Cloak of Shadow with Vanish in case of emergency.",  
                    }, 
                    M = {},
                },				
            },
            { -- [5] Blind     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Only Heal", value = "Heal" },
                        { text = "Only PvP", value = "PvP" },
                        { text = "BOTH", value = "BOTH" },
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "BlindPvP",
                    DBV = "BOTH",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(2094),
                    }, 
                    TT = { 
                        enUS = "@arena1-3 interrupt PvP list from 'Interrupts' tab by Blind\nMore custom config you can find in group by open /tmw", 
                    }, 
                    M = {},
                },
            },
            { -- [10] Dismantle
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "DisarmPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(207777),
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
                    DB = "DisarmPvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(207777) .. " units",
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
        [ACTION_CONST_ROGUE_OUTLAW] = { 
            -- MSG Action Pet Dispell
            ["stun"] = { Enabled = true, Key = "KidneyShot", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return  (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 20)
                        )                                                             
            ]] },
            ["disarm"] = { Enabled = true, Key = "Dismantle", LUAVER = 5, LUA = [[
                return     DisarmIsReady(thisunit, true)
            ]] },
            ["kick"] = { Enabled = true, Key = "Kick", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return     A.Kick:IsReadyM(thisunit) and                         
                        A.Kick:AbsentImun(thisunit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and 
                        Unit(thisunit):IsCastingRemains() > 0 and 
            ]] },
        },
        [ACTION_CONST_ROGUE_ASSASSINATION] = { 
            -- MSG Action Pet Dispell
            ["stun"] = { Enabled = true, Key = "KidneyShot", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return  (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 20)
                        )                                                             
            ]] },
            ["disarm"] = { Enabled = true, Key = "Dismantle", LUAVER = 5, LUA = [[
                return     DisarmIsReady(thisunit, true)
            ]] },
            ["kick"] = { Enabled = true, Key = "Kick", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return     A.Kick:IsReadyM(thisunit) and                         
                        A.Kick:AbsentImun(thisunit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and 
                        Unit(thisunit):IsCastingRemains() > 0 and 
            ]] },
        },
        [ACTION_CONST_ROGUE_SUBTLETY] = { 
            -- MSG Action Pet Dispell
            ["stun"] = { Enabled = true, Key = "KidneyShot", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return  (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 20)
                        )                                                             
            ]] },
            ["disarm"] = { Enabled = true, Key = "Dismantle", LUAVER = 5, LUA = [[
                return     DisarmIsReady(thisunit, true)
            ]] },
            ["kick"] = { Enabled = true, Key = "Kick", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_WARRIOR_ARMS]
                return     A.Kick:IsReadyM(thisunit) and                         
                        A.Kick:AbsentImun(thisunit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and 
                        Unit(thisunit):IsCastingRemains() > 0 and 
            ]] },
        },
    },
}

-----------------------------------------
--                   PvP  
-----------------------------------------

function A.DisarmIsReady(unit, isMsg, skipShouldStop)
    if A[A.PlayerSpec].Dismantle then 
        local unitID = A.GetToggle(2, "DisarmPvPunits")
        return     (
            (unit == "arena1" and unitID[1]) or 
            (unit == "arena2" and unitID[2]) or
            (unit == "arena3" and unitID[3]) or
            (not unit:match("arena") and unitID[4]) 
        ) and 
        A.IsInPvP and
        Unit(unit):IsEnemy() and  
        (
            (
                not isMsg and 
                A.GetToggle(2, "DisarmPvP") ~= "OFF" and 
                A[A.PlayerSpec].Dismantle:IsReady(unit, nil, nil, skipShouldStop) and 
                Unit(unit):IsMelee() and 
                (
                    A.GetToggle(2, "DisarmPvP") == "ON COOLDOWN" or 
                    Unit(unit):HasBuffs("DamageBuffs") > 3 
                )
            ) or 
            (
                isMsg and 
                A[A.PlayerSpec].Dismantle:IsReadyM(unit)                     
            )
        ) and 
        Unit(unit):IsPlayer() and                     
        A[A.PlayerSpec].Dismantle:AbsentImun(unit, {"CCTotalImun", "DamagePhysImun", "TotalImun"}, true) and 
        Unit(unit):IsControlAble("disarm", 0) and 
        Unit(unit):HasDeBuffs("Disarmed") == 0
    end 
end

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
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
    
    local Toggle = A.GetToggle(2, "BlindPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Blind and A[A.PlayerSpec].Blind:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Blind:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("disorient", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 
