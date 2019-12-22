--------------------
-- Taste&ZakLL TMW Action ProfileUI

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
    DateTime = "v2.0.5 (22.12.2019)",
    -- Class settings
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
			},
		},	
        [ACTION_CONST_DRUID_GUARDIAN] = {
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
                        ANY = " -- Rotation Settings -- ",
                    },
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
                        ruRU = "Automatic Taunt", 
                        frFR = "Automatic Taunt",
                    }, 
                    TT = { 
                        enUS = "If activated, will use automatically use Growl whenever available.", 
                        ruRU = "If activated, will use automatically use Growl whenever available.",  
                        frFR = "If activated, will use automatically use Growl whenever available.", 
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
					}, 
                    TT = { 
                        enUS = "OFF - No limit\nIf the percentage of the threat (agro) is greater than\nor equal to the specified one, then the\n'safe' rotation will be performed. As far as possible, the\nabilities causing too many threats will be stopped until the\nthreat level (agro) is normalized", 
                        ruRU = "OFF - Нет лимита\nЕсли процент угрозы (агро) больше или равен указанному,\nто будет выполняться 'безопасная' ротация\nПо мере возможности перестанут использоваться способности\nвызывающие слишком много угрозы пока\nуровень угрозы (агро) не нормализуется",  
                        frFR = "OFF - No limit\nIf the percentage of the threat (agro) is greater than\nor equal to the specified one, then the\n'safe' rotation will be performed. As far as possible, the\nabilities causing too many threats will be stopped until the\nthreat level (agro) is normalized",
					},    
                    M = {},
                },				
    			{
                    E = "Checkbox", 
                    DB = "OffensiveRage",
                    DBV = true,
                    L = { 
                        enUS = "Offensive Rage use", 
                        ruRU = "Offensive Rage use",
                        frFR = "Offensive Rage use",
                    }, 
                    TT = { 
                        enUS = "If activated, will priorize dps over survivability.", 
                        ruRU = "If activated, will priorize dps over survivability.",  
                        frFR = "If activated, will priorize dps over survivability.",  
                    }, 
                    M = {},
                },
			}, 
            { -- [2] 2nd Row 
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
                {
                    E = "Checkbox", 
                    DB = "UseStampedingRoar",
                    DBV = true,
                    L = { 
                        enUS = "Auto" .. A.GetSpellInfo(77761), 
                        ruRU = "Авто" .. A.GetSpellInfo(77761), 
                        frFR = "Auto" .. A.GetSpellInfo(77761), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(77761), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(77761), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(77761), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "StampedingRoarTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(77761) .. " if moving for",
                    }, 
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(77761) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(77761) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(77761) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
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
                    DB = "BarkskinHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(22812) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "LunarBeamHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(204066) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FrenziedRegenerationHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(22842) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "SurvivalInstinctsHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(61336) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "IronfurHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(192081) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "BristlingFurRage",
                    DBV = 70, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(155835) .. " Rage",
                    }, 
                    TT = { 
                        enUS = "Minimum rage required before using Bristling Fur", 
                        ruRU = "Minimum rage required before using Bristling Fur", 
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
                    DB = "FearPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(5782),
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
                    DB = "FearPvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(5782) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_DRUID_RESTORATION] = { 
            LayoutOptions = { gutter = 4, padding = { left = 5, right = 5 } },
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
                    DB = "ManaManagement",
                    DBV = false,
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
            }, 
            { -- [2]
                {
                    E = "Header",
                    L = {
                        enUS = " -- Self Defensives -- ",
                        ruRU = " -- Своя Оборона -- ",
                    },
                },
            }, 
            { -- [3]     
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 85,                            
                    DB = "Barkskin",
                    DBV = 85,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(22812) .. " (%)",
                    }, 
                    M = {},
                },
                {                    
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "Stoneform",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(20594) .. " (%)",                        
                    }, 
                    M = {},
                },
            }, 
            { -- [4]    
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "Ironbark",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(102342) .. " (%)",                        
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "BearForm",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(5487) .. " (%)",
                    }, 
                    M = {},
                },
            }, 
            { -- [5]    
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DiffuseMagic",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(122783) .. " (%)",                        
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ManaPotion",
                    DBV = 20,
                    ONLYOFF = true,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["POTION"] .. " (Mana %)",
                    }, 
                    M = {},
                },
            }, 
            { -- [6]
                {
                    E = "Header",
                    L = {
                        ANY = " -- HealingEngine -- ",
                    },
                },
            },
            { -- [7]
                {
                    E = "Checkbox", 
                    DB = "HealingEngineAutoHot",
                    DBV = true,
                    L = { 
                        enUS = "HealingEngine: Auto hot", 
                        ruRU = "HealingEngine: Авто хоты", 
                    }, 
                    TT = { 
                        enUS = "HealingEngine will suggest in higher priority to\nselect member which hasn't applied 'Rejuvenation'", 
                        ruRU = "HealingEngine will suggest in higher priority to\nselect member which hasn't applied 'Rejuvenation'", 
                    }, 
                    M = {},                
                },
            }, 
            { -- [8]
                {
                    E = "Header",
                    L = {
                        enUS = " -- Rotation -- ",
                        ruRU = " -- Ротация -- ",
                    },
                },
            }, 
            { -- [10]
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "SwiftmendHP",
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(18562) .. " (%)",                        
                    }, 
                    TT = { 
                        enUS = "Offset Health Percent on which start casting 'Swiftmend'", 
                        ruRU = "Значение Процента Здоровья на котором начинать произносить 'Swiftmend'", 
                    },
                    M = {},
                },            
            },
            { -- [11] 
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LifebloomHP",
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(33763) .. " (%)",                        
                    }, 
                    TT = { 
                        enUS = "Offset Health Percent on which start casting 'Lifebloom'", 
                        ruRU = "Значение Процента Здоровья на котором начинать произносить 'Lifebloom'", 
                    },
                    M = {},
                }, 			
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Always", value = "Always" },
                        { text = "Auto", value = "Auto" },    
                        { text = "Tanking Units", value = "Tanking Units" },                    
                        { text = "Mostly Inc. Damage ", value = "Mostly Inc. Damage" },
                        { text = "HPS < Inc. Damage ", value = "HPS < Inc. Damage" },
                    },
                    DB = "LifebloomWorkMode",
                    DBV = "Auto",
                    L = { 
                        ANY = A.GetSpellInfo(33763) .. " Work Mode",
                    }, 
                    TT = { 
                        enUS = "These conditions will be skiped if unit will dying in emergency (critical) situation", 
                        ruRU = "Эти условия будут пропущены если юнит будет умирать в чрезвычайной (критической) ситуациии", 
                    },                    
                    M = {},
                },
            }, 
            { -- [12]    
                RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "Tranquility",
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(740) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 41,                            
                    DB = "TranquilityUnits",
                    DBV = 41,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(740) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
            }, 
            { -- [13]    
                RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "Flourish",                    
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(197721) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 41,                            
                    DB = "FlourishUnits",
                    DBV = 41,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(197721) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
            }, 
            { -- [14]    
                RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "WildGrowth",                    
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(48438) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "WildGrowthUnits",
                    DBV = 7,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(48438) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
            }, 
            { -- [15]    
                RowOptions = { margin = { top = 10 } },
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
            { -- [16]    
                RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketBurstHealing",                    
                    DBV = 50,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["TRINKET"] .. "\n(Healing HP %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketBurstDamaging",                    
                    DBV = 95,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["TRINKET"] .. "\n(Damaging HP %)",                        
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
            { -- [17]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            }, 
            { -- [18]
                {
                    E = "Checkbox", 
                    DB = "MouseButtonsCheck",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(145205) .. "\nCheck Mouse Buttons", 
                        ruRU = A.GetSpellInfo(145205) .. "\nПроверять Кнопки Мышки", 
                    }, 
                    TT = { 
                        enUS = "Prevents use if the camera is currently spinning with the mouse button held down", 
                        ruRU = "Предотвращает использование если камера в текущий момент крутится с помощью зажатой кнопки мыши", 
                    }, 
                    M = {},
                },
            }, 
            { -- [19]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "CyclonePvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(33786),
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
                    DB = "CyclonePvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(33786) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
            { -- [19]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "MightyBashPvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(5211),
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
                    DB = "MightyBashPvPunits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(5211) .. " units",
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
        [ACTION_CONST_DRUID_FERAL] = { 
            ["stun"] = { Enabled = true, Key = "LegSweep", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.LegSweep:IsReadyM(thisunit, true) and 
                        (
                            not IsInPvP and 
                            MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1                            
                        ) or 
                        (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))
                        )                                                     
            ]] },
            ["disarm"] = { Enabled = true, Key = "GrappleWeapon", LUAVER = 5, LUA = [[
                return     GrappleWeaponIsReady(thisunit, true)
            ]] },
            ["freedom"] = { Enabled = true, Key = "TigersLust", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.TigersLust:IsReadyM(thisunit) and 
                        A.TigersLust:AbsentImun(thisunit) and 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0
            ]] },
            ["dispel"] = { Enabled = true, Key = "Detox", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.Detox:IsReadyM(thisunit) and 
                        A.Detox:AbsentImun(thisunit) and 
                        AuraIsValid(thisunit, "UseDispel", "Dispel") and                                                 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0
            ]] },
        },
        [ACTION_CONST_DRUID_GUARDIAN] = { 
            ["stun"] = { Enabled = true, Key = "LegSweep", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.LegSweep:IsReadyM(thisunit, true) and 
                        (
                            not IsInPvP and 
                            MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1                            
                        ) or 
                        (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))
                        )                                                     
            ]] },
            ["disarm"] = { Enabled = true, Key = "GrappleWeapon", LUAVER = 5, LUA = [[
                return     GrappleWeaponIsReady(thisunit, true)
            ]] },
            ["freedom"] = { Enabled = true, Key = "TigersLust", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.TigersLust:IsReadyM(thisunit) and 
                        A.TigersLust:AbsentImun(thisunit) and 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0
            ]] },
            ["dispel"] = { Enabled = true, Key = "Detox", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.Detox:IsReadyM(thisunit) and 
                        A.Detox:AbsentImun(thisunit) and 
                        AuraIsValid(thisunit, "UseDispel", "Dispel") and                                                 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0
            ]] },
        },
        [ACTION_CONST_DRUID_BALANCE] = { 
            ["stun"] = { Enabled = true, Key = "LegSweep", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.LegSweep:IsReadyM(thisunit, true) and 
                        (
                            not IsInPvP and 
                            MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1                            
                        ) or 
                        (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))
                        )                                                     
            ]] },
            ["disarm"] = { Enabled = true, Key = "GrappleWeapon", LUAVER = 5, LUA = [[
                return     GrappleWeaponIsReady(thisunit, true)
            ]] },
            ["freedom"] = { Enabled = true, Key = "TigersLust", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.TigersLust:IsReadyM(thisunit) and 
                        A.TigersLust:AbsentImun(thisunit) and 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0
            ]] },
            ["dispel"] = { Enabled = true, Key = "Detox", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.Detox:IsReadyM(thisunit) and 
                        A.Detox:AbsentImun(thisunit) and 
                        AuraIsValid(thisunit, "UseDispel", "Dispel") and                                                 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0
            ]] },
        },
        [ACTION_CONST_DRUID_RESTORATION] = {    
            ["stun"] = { Enabled = true, Key = "LegSweep", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.LegSweep:IsReadyM(thisunit, true) and 
                        (
                            not IsInPvP and 
                            MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1                            
                        ) or 
                        (
                            IsInPvP and 
                            EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))
                        )                                                     
            ]] },
            ["disarm"] = { Enabled = true, Key = "GrappleWeapon", LUAVER = 5, LUA = [[
                return     GrappleWeaponIsReady(thisunit, true)
            ]] },
            ["freedom"] = { Enabled = true, Key = "TigersLust", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.TigersLust:IsReadyM(thisunit) and 
                        A.TigersLust:AbsentImun(thisunit) and 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0
            ]] },
            ["dispel"] = { Enabled = true, Key = "Detox", LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_MISTWEAVER]
                return     A.Detox:IsReadyM(thisunit) and 
                        A.Detox:AbsentImun(thisunit) and 
                        AuraIsValid(thisunit, "UseDispel", "Dispel") and                                                 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0
            ]] },
        },
    },
}

-----------------------------------------
--                   PvP  
-----------------------------------------
function A.MightyBashIsReady(unit, isMsg, skipShouldStop)
    if A[A.PlayerSpec].MightyBash then 
        local unitID = A.GetToggle(2, "MightyBashPvPunits")
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
                A.GetToggle(2, "MightyBashPvP") ~= "OFF" and 
                A[A.PlayerSpec].MightyBash:IsReady(unit, nil, nil, skipShouldStop) and 
                Unit(unit):IsMelee() and 
                (
                    A.GetToggle(2, "MightyBashPvP") == "ON COOLDOWN" or 
                    Unit(unit):HasBuffs("DamageBuffs") > 3 
                )
            ) or 
            (
                isMsg and 
                A[A.PlayerSpec].MightyBash:IsReadyM(unit)                     
            )
        ) and 
        Unit(unit):IsPlayer() and                     
        A[A.PlayerSpec].MightyBash:AbsentImun(unit, {"CCTotalImun", "DamagePhysImun", "TotalImun"}, true) and 
        Unit(unit):IsControlAble("stun", 0) and 
        Unit(unit):HasDeBuffs("Stunned") == 0
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
    
    local Toggle = A.GetToggle(2, "CyclonePvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Cyclone and A[A.PlayerSpec].Cyclone:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Cyclone:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("disorient", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end
    local Toggle2 = A.GetToggle(2, "MightyBashPvP")    
    if Toggle2 and Toggle2 ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Cyclone and A[A.PlayerSpec].Cyclone:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Cyclone:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("disorient", 0) then 
        if Toggle2 == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle2, true))         
        end 
    end 
	
end 


