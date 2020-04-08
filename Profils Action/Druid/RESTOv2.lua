-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW 
local HealingEngine                             = Action.HealingEngine
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")
local Action									= Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell								= Action.FrameHasSpell
local Azerite									= LibStub("AzeriteTraits")
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local wipe                                      = wipe 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local TMW                                       = TMW
local _G, setmetatable                          = _G, setmetatable
local select, unpack, table, pairs              = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_DRUID_RESTORATION] = {
    -- Racial
    ArcaneTorrent                             = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                                 = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                                 = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                             = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                                = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                               = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                               = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                                  = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                                  = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                                  = Action.Create({ Type = "Spell", ID = 255654     }),    
    GiftofNaaru                               = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                                = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                                 = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                               = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                         = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                              = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                        = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Roots   
    EntanglingRoots                           = Action.Create({ Type = "Spell", ID = 339    }),
    MassEntanglement                          = Action.Create({ Type = "Spell", ID = 102359, isTalent = true   }), 
    -- Disorient
	Cyclone                                   = Action.Create({ Type = "Spell", ID = 33786, isTalent = true   }), -- PvP Talent
	-- Stun
	MightyBash                                = Action.Create({ Type = "Spell", ID = 5211, isTalent = true   }),
	-- Knockbacks
	Typhoon                                   = Action.Create({ Type = "Spell", ID = 132469, isTalent = true   }),
    -- Hots
    Lifebloom                                 = Action.Create({ Type = "Spell", ID = 33763     }),
	Rejuvenation                              = Action.Create({ Type = "Spell", ID = 774     }),
	RejuvenationGermimation                   = Action.Create({ Type = "Spell", ID = 155777    }),
    WildGrowth                                = Action.Create({ Type = "Spell", ID = 48438     }),
	CenarionWard                              = Action.Create({ Type = "Spell", ID = 102351, isTalent = true     }),
	-- Direct Heals
	Regrowth                                  = Action.Create({ Type = "Spell", ID = 8936     }),
	Swiftmend                                 = Action.Create({ Type = "Spell", ID = 18562     }),
    -- Self Defensives
    Barkskin                                  = Action.Create({ Type = "Spell", ID = 22812     }),
	-- Cooldowns
	Ironbark                                  = Action.Create({ Type = "Spell", ID = 102342     }),
	Tranquility                               = Action.Create({ Type = "Spell", ID = 740     }),
    Innervate                                 = Action.Create({ Type = "Spell", ID = 29166     }),
    -- Shapeshift
    TravelForm                                = Action.Create({ Type = "Spell", ID = 783     }), 
    BearForm                                  = Action.Create({ Type = "Spell", ID = 5487     }), 
    CatForm                                   = Action.Create({ Type = "Spell", ID = 768     }), 
    AquaticForm                               = Action.Create({ Type = "Spell", ID = 276012     }), 	
    -- Utilities
	UrsolVortex                               = Action.Create({ Type = "Spell", ID = 102793     }),
    NaturesCure                               = Action.Create({ Type = "Spell", ID = 88423     }),  
	Dash                                      = Action.Create({ Type = "Spell", ID = 1850     }), 
	Rebirth                                   = Action.Create({ Type = "Spell", ID = 20484     }),  -- Combat Rez
	Revive                                    = Action.Create({ Type = "Spell", ID = 50769     }), 
	Hibernate                                 = Action.Create({ Type = "Spell", ID = 2637     }), 
	Soothe                                    = Action.Create({ Type = "Spell", ID = 50769     }), 
	Prowl                                     = Action.Create({ Type = "Spell", ID = 2908     }), 
	Revitalize                                = Action.Create({ Type = "Spell", ID = 212040     }), 
    -- Healing Spells       
    Efflorescence                             = Action.Create({ Type = "Spell", ID = 145205     }),
	Renewal                                   = Action.Create({ Type = "Spell", ID = 108238, isTalent = true     }),
	-- Talents
	SouloftheForest                           = Action.Create({ Type = "Spell", ID = 102351, isTalent = true, Hidden = true     }),
	IncarnationTreeofLife                     = Action.Create({ Type = "Spell", ID = 33891, isTalent = true     }),
	IncarnationTreeofLifeBuff                 = Action.Create({ Type = "Spell", ID = 117679, Hidden = true     }),
	Flourish                                  = Action.Create({ Type = "Spell", ID = 197721, isTalent = true     }),
	Photosynthesis                            = Action.Create({ Type = "Spell", ID = 274902, isTalent = true, Hidden = true     }),
	Germination                               = Action.Create({ Type = "Spell", ID = 155675, isTalent = true, Hidden = true     }),
	GuardianAffinity                          = Action.Create({ Type = "Spell", ID = 197491, isTalent = true, Hidden = true     }),
	FeralAffinity                             = Action.Create({ Type = "Spell", ID = 197490, isTalent = true, Hidden = true     }),
	BalanceAffinity                           = Action.Create({ Type = "Spell", ID = 197632, isTalent = true, Hidden = true     }),	
	InnerPeace                                = Action.Create({ Type = "Spell", ID = 197073, isTalent = true, Hidden = true     }),
	Stonebark                                 = Action.Create({ Type = "Spell", ID = 197061, isTalent = true, Hidden = true     }),
	Prosperity                                = Action.Create({ Type = "Spell", ID = 200383, isTalent = true, Hidden = true     }),
	Abundance 	                              = Action.Create({ Type = "Spell", ID = 207383, isTalent = true, Hidden = true     }),
	SpringBlossoms                            = Action.Create({ Type = "Spell", ID = 207385, isTalent = true, Hidden = true     }),
	Cultivation                               = Action.Create({ Type = "Spell", ID = 200390, isTalent = true, Hidden = true     }),
    -- PvP Talents
	Disentanglement                           = Action.Create({ Type = "Spell", ID = 233673, isTalent = true, Hidden = true     }),
	EntanglingBark                            = Action.Create({ Type = "Spell", ID = 247543, isTalent = true, Hidden = true     }),
	EarlySpring                               = Action.Create({ Type = "Spell", ID = 203624, isTalent = true, Hidden = true     }),
	Nourish                                   = Action.Create({ Type = "Spell", ID = 289022, isTalent = true     }),
	Overgrowth                                = Action.Create({ Type = "Spell", ID = 203651, isTalent = true     }),
	Thorns                                    = Action.Create({ Type = "Spell", ID = 305497, isTalent = true     }),
	DeepRoots                                 = Action.Create({ Type = "Spell", ID = 233755, isTalent = true, Hidden = true     }),		
    MarkoftheWild                             = Action.Create({ Type = "Spell", ID = 289318, isTalent = true     }),
	FocusedGrowth                             = Action.Create({ Type = "Spell", ID = 203553, isTalent = true, Hidden = true     }),
	MasterShapeshifter                        = Action.Create({ Type = "Spell", ID = 289237, isTalent = true     }),
	-- Azerites
    AutumnLeaves                              = Action.Create({ Type = "Spell", ID = 274432, Hidden = true     }),
	EarlyHarvest                              = Action.Create({ Type = "Spell", ID = 287251, Hidden = true     }),
	GroveTending                              = Action.Create({ Type = "Spell", ID = 279778, Hidden = true     }),
	LivelySpirit                              = Action.Create({ Type = "Spell", ID = 279642, Hidden = true     }),
	RampantGrowth                             = Action.Create({ Type = "Spell", ID = 278515, Hidden = true     }),
	WakingDream                               = Action.Create({ Type = "Spell", ID = 278513, Hidden = true     }),
	-- Offensives Spells
    Moonfire                                  = Action.Create({ Type = "Spell", ID = 164812     }),
	Sunfire                                   = Action.Create({ Type = "Spell", ID = 93402     }),
	SolarWrath                                = Action.Create({ Type = "Spell", ID = 5176     }),
	Mutilate                                  = Action.Create({ Type = "Spell", ID = 33917     }),
	-- Offensives abilities with Affinity
	-- Boomkin
	Starsurge                                 = Action.Create({ Type = "Spell", ID = 5176     }),
	LunarStrike                               = Action.Create({ Type = "Spell", ID = 194153     }),
	MoonkinForm                               = Action.Create({ Type = "Spell", ID = 24858     }),
	-- Guardian
	FrenziedRegeneration                      = Action.Create({ Type = "Spell", ID = 22842     }),
	Ironfur                                   = Action.Create({ Type = "Spell", ID = 192081     }),
	Thrash                                    = Action.Create({ Type = "Spell", ID = 106832     }),
	-- Feral
	Shred                                     = Action.Create({ Type = "Spell", ID = 5221     }),
	Rip                                       = Action.Create({ Type = "Spell", ID = 1079     }),
	FerociousBite                             = Action.Create({ Type = "Spell", ID = 22568     }),
	Rake                                      = Action.Create({ Type = "Spell", ID = 1822     }),
	RakeDebuff                                = Action.Create({ Type = "Spell", ID = 155722	,    Hidden = true }),
	Swipe                                     = Action.Create({ Type = "Spell", ID = 106785 }),
    -- Movememnt    

    -- Items
    PotionofReconstitution                    = Action.Create({ Type = "Potion", ID = 168502     }),     
    CoastalManaPotion                         = Action.Create({ Type = "Potion", ID = 152495     }), 
    -- Hidden 
	ClearCasting                              = Action.Create({ Type = "Spell", ID = 16870,    Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep  
    TigerTailSweep                            = Action.Create({ Type = "Spell", ID = 264348,     isTalent = true, Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep    
    RisingMist                                = Action.Create({ Type = "Spell", ID = 274909,     isTalent = true, Hidden = true }), -- 7/3 Talent "Fistweaving Rotation by damage healing"
    SpiritoftheCrane                          = Action.Create({ Type = "Spell", ID = 210802,     isTalent = true, Hidden = true }), -- 3/2 Talent "Mana regen by BlackoutKick"
    Innervate                                 = Action.Create({ Type = "Spell", ID = 29166,     Hidden = true }), -- Buff condition for Mana Tea and Mana Saving
    TeachingsoftheMonastery                   = Action.Create({ Type = "Spell", ID = 202090,     Hidden = true }), -- Buff condition for Blackout Kick
}

Action:CreateEssencesFor(ACTION_CONST_DRUID_RESTORATION)
local A = setmetatable(Action[ACTION_CONST_DRUID_RESTORATION], { __index = Action })

local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local player = "player"

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function stopDamageCheck(unit)
    -- Spotter
    if NoSpotterDPS and select(6, Unit(unit):InfoGUID()) == 135263 then
        return true
    end
		
    if Unit(unit):IsCastingRemains(302415) > 0 then
        -- emmisary teleporting home
        return true
    end

    if Unit(unit):HasBuffs(263246, true) > 0 then
        -- shields on first boss in temple
        return true
    end
	
    if Unit(unit):HasBuffs(260189, true) > 0 then
        -- shields on last boss in MOTHERLODE
        return true
    end
	
    if Unit(unit):HasBuffs(261264, true) > 0 or Unit(unit):HasBuffs(261265, true) > 0 or Unit(unit):HasBuffs(261266, true) > 0 then
        -- shields on witches in wm
        return true
    end

    if select(6, Unit(unit):InfoGUID()) == 155432 then
        --emmisaries to punt, dealt with seperately
        return true
    end
    return false --catchall
end

local fishfeast = 0

local StunsBlackList = {
    -- Atal'Dazar
    [87318] = "Dazar'ai Colossus",
    [122984] = "Dazar'ai Colossus",
    [128455] = "T'lonja",
    [129553] = "Dinomancer Kish'o",
    [129552] = "Monzumi",
    -- Freehold
    [129602] = "Irontide Enforcer",
    [130400] = "Irontide Crusher",
    -- King's Rest
    [133935] = "Animated Guardian",
    [134174] = "Shadow-Borne Witch Doctor",
    [134158] = "Shadow-Borne Champion",
    [137474] = "King Timalji",
    [137478] = "Queen Wasi",
    [137486] = "Queen Patlaa",
    [137487] = "Skeletal Hunting Raptor",
    [134251] = "Seneschal M'bara",
    [134331] = "King Rahu'ai",
    [137484] = "King A'akul",
    [134739] = "Purification Construct",
    [137969] = "Interment Construct",
    [135231] = "Spectral Brute",
    [138489] = "Shadow of Zul",
    -- Shrine of the Storm
    [134144] = "Living Current",
    [136214] = "Windspeaker Heldis",
    [134150] = "Runecarver Sorn",
    [136249] = "Guardian Elemental",
    [134417] = "Deepsea Ritualist",
    [136353] = "Colossal Tentacle",
    [136295] = "Sunken Denizen",
    [136297] = "Forgotten Denizen",
    -- Siege of Boralus
    [129369] = "Irontide Raider",
    [129373] = "Dockhound Packmaster",
    [128969] = "Ashvane Commander",
    [138255] = "Ashvane Spotter",
    [138465] = "Ashvane Cannoneer",
    [135245] = "Bilge Rat Demolisher",
    -- Temple of Sethraliss
    [134991] = "Sandfury Stonefist",
    [139422] = "Scaled Krolusk Tamer",
    [136076] = "Agitated Nimbus",
    [134691] = "Static-charged Dervish",
    [139110] = "Spark Channeler",
    [136250] = "Hoodoo Hexer",
    [139946] = "Heart Guardian",
    -- MOTHERLODE!!
    [130485] = "Mechanized Peacekeeper",
    [136139] = "Mechanized Peacekeeper",
    [136643] = "Azerite Extractor",
    [134012] = "Taskmaster Askari",
    [133430] = "Venture Co. Mastermind",
    [133463] = "Venture Co. War Machine",
    [133436] = "Venture Co. Skyscorcher",
    [133482] = "Crawler Mine",
    -- Underrot
    [131436] = "Chosen Blood Matron",
    [133912] = "Bloodsworn Defiler",
    [138281] = "Faceless Corruptor",
    -- Tol Dagor
    [130025] = "Irontide Thug",
    -- Waycrest Manor
    [131677] = "Heartsbane Runeweaver",
    [135329] = "Matron Bryndle",
    [131812] = "Heartsbane Soulcharmer",
    [131670] = "Heartsbane Vinetwister",
    [135365] = "Matron Alma",
}

local precast_spell_list = {
    --spell_id	, precast_time	,	spell_name
    { 214652, 5, 'Acidic Fragments' },
    { 205862, 5, 'Slam' },
    { 259832, 1.5, 'Massive Glaive - Stormbound Conqueror (Warport Wastari, Zuldazar, for testing purpose only)' },
    { 218774, 5, 'Summon Plasma Spheres' },
    { 206949, 5, 'Frigid Nova' },
    { 206517, 5, 'Fel Nova' },
    { 207720, 5, 'Witness the Void' },
    { 206219, 5, 'Liquid Hellfire' },
    { 211439, 5, 'Will of the Demon Within' },
    { 209270, 5, 'Eye of Guldan' },
    { 227071, 5, 'Flame Crash' },
    { 233279, 5, 'Shattering Star' },
    { 233441, 5, 'Bone Saw' },
    { 235230, 5, 'Fel Squall' },
    { 231854, 5, 'Unchecked Rage' },
    { 232174, 5, 'Frosty Discharge' },
    { 230139, 5, 'Hydra Shot' },
    { 233264, 5, 'Embrace of the Eclipse' },
    { 236542, 5, 'Sundering Doom' },
    { 236544, 5, 'Doomed Sundering' },
    { 235059, 5, 'Rupturing Singularity' },
    { 288693, 3, 'Tormented Soul - Grave Bolt (Reaping affix)' },
    { 262347, 5, 'Static Pulse' },
    { 302420, 5, 'Queen\'s Decree: Hide' },
    { 260333, 7, 'Tantrum - Underrot 2nd boss' },
    { 255577, 5, 'Transfusion' }, -- https://www.wowhead.com/spell=255577/transfusion
    { 259732, 5, 'Festering Harvest' }, --https://www.wowhead.com/spell=259732/festering-harvest
    { 285388, 5, 'Vent Jets' }, --https://www.wowhead.com/spell=285388/vent-jets
    { 291626, 3, 'Cutting Beam' }, --https://www.wowhead.com/spell=291626/cutting-beam
    { 300207, 3, 'shock-coil' }, -- https://www.wowhead.com/spell=300207/shock-coil
    { 297261, 5, 'rumble' }, -- https://www.wowhead.com/spell=297261/rumble
    { 262347, 5, 'pulse' }, --https://www.wowhead.com/spell=262347/static-pulse
}
--end of dbm list
local debuff_list = {

    --junkyard
    { spellID = 298669, stacks = 0, secs = 1 }, -- Taze
    -- Uldir
    { spellID = 262313, stacks = 0, secs = 5 }, -- Malodorous Miasma
    { spellID = 262314, stacks = 0, secs = 3 }, -- Putrid Paroxysm
    { spellID = 264382, stacks = 0, secs = 1 }, -- Eye Beam
    { spellID = 264210, stacks = 0, secs = 5 }, -- Jagged Mandible
    { spellID = 265360, stacks = 0, secs = 5 }, -- Roiling Deceit
    { spellID = 265129, stacks = 0, secs = 5 }, -- Omega Vector
    { spellID = 266948, stacks = 0, secs = 5 }, -- Plague Bomb
    { spellID = 274358, stacks = 0, secs = 5 }, -- Rupturing Blood
    { spellID = 274019, stacks = 0, secs = 1 }, -- Mind Flay
    { spellID = 272018, stacks = 0, secs = 1 }, -- Absorbed in Darkness
    { spellID = 273359, stacks = 0, secs = 5 }, -- Shadow Barrage
    -- Freehold
    { spellID = 257437, stacks = 0, secs = 5 }, -- Poisoning Strike
    { spellID = 267523, stacks = 0, secs = 5 }, -- Cutting Surge
    { spellID = 256363, stacks = 0, secs = 5 }, -- Ripper Punch
    -- Shrine of the Storm
    { spellID = 264526, stacks = 0, secs = 5 }, -- Grasp from the Depths
    { spellID = 264166, stacks = 0, secs = 1 }, -- Undertow
    { spellID = 268214, stacks = 0, secs = 1 }, -- Carve Flesh
    { spellID = 276297, stacks = 0, secs = 5 }, -- Void Seed
    { spellID = 268322, stacks = 0, secs = 5 }, -- Touch of the Drowned
    -- Siege of Boralus
    { spellID = 256897, stacks = 0, secs = 5 }, -- Clamping Jaws
    { spellID = 273470, stacks = 0, secs = 3 }, -- Gut Shot
    { spellID = 275014, stacks = 0, secs = 5 }, -- Putrid Waters
    -- Tol Dagor
    { spellID = 258058, stacks = 0, secs = 1 }, -- Squeeze
    { spellID = 260016, stacks = 0, secs = 3 }, -- Itchy Bite
    { spellID = 260067, stacks = 0, secs = 5 }, -- Vicious Mauling
    { spellID = 258864, stacks = 0, secs = 5 }, -- Suppression Fire
    { spellID = 258917, stacks = 0, secs = 3 }, -- Righteous Flames
    { spellID = 256198, stacks = 0, secs = 5 }, -- Azerite Rounds: Incendiary
    { spellID = 256105, stacks = 0, secs = 1 }, -- Explosive Burst
    -- Waycrest Manor
    { spellID = 266035, stacks = 0, secs = 1 }, -- Bone Splinter
    { spellID = 260703, stacks = 0, secs = 1 }, -- Unstable Runic Mark
    { spellID = 260741, stacks = 0, secs = 1 }, -- Jagged Nettles
    { spellID = 264050, stacks = 0, secs = 3 }, -- Infected Thorn
    { spellID = 264556, stacks = 0, secs = 2 }, -- Tearing Strike
    { spellID = 264150, stacks = 0, secs = 1 }, -- Shatter
    { spellID = 265761, stacks = 0, secs = 1 }, -- Thorned Barrage
    { spellID = 263905, stacks = 0, secs = 1 }, -- Marking Cleave
    { spellID = 264153, stacks = 0, secs = 3 }, -- Spit
    { spellID = 278456, stacks = 0, secs = 3 }, -- Infest
    { spellID = 271178, stacks = 0, secs = 3 }, -- Ravaging Leap
    { spellID = 265880, stacks = 0, secs = 1 }, -- Dread Mark
    { spellID = 265882, stacks = 0, secs = 1 }, -- Lingering Dread
    { spellID = 264378, stacks = 0, secs = 5 }, -- Fragment Soul
    { spellID = 261438, stacks = 0, secs = 1 }, -- Wasting Strike
    { spellID = 261440, stacks = 0, secs = 1 }, -- Virulent Pathogen
    { spellID = 268202, stacks = 0, secs = 1 }, -- Death Lens
    -- Atal'Dazar
    { spellID = 253562, stacks = 0, secs = 3 }, -- Wildfire
    { spellID = 254959, stacks = 0, secs = 2 }, -- Soulburn
    { spellID = 255558, stacks = 0, secs = 5 }, -- Tainted Blood
    { spellID = 255814, stacks = 0, secs = 5 }, -- Rending Maul
    { spellID = 250372, stacks = 0, secs = 5 }, -- Lingering Nausea
    { spellID = 250096, stacks = 0, secs = 1 }, -- Wracking Pain
    { spellID = 256577, stacks = 0, secs = 5 }, -- Soulfeast
    -- King's Rest
    { spellID = 269932, stacks = 0, secs = 3 }, -- Gust Slash
    { spellID = 265773, stacks = 0, secs = 4 }, -- Spit Gold
    { spellID = 270084, stacks = 0, secs = 3 }, -- Axe Barrage
    { spellID = 270865, stacks = 0, secs = 3 }, -- Hidden Blade
    { spellID = 270289, stacks = 0, secs = 3 }, -- Purification Beam
    { spellID = 271564, stacks = 0, secs = 3 }, -- Embalming
    { spellID = 267618, stacks = 0, secs = 3 }, -- Drain Fluids
    { spellID = 270487, stacks = 0, secs = 3 }, -- Severing Blade
    { spellID = 270507, stacks = 0, secs = 5 }, -- Poison Barrage
    { spellID = 266231, stacks = 0, secs = 3 }, -- Severing Axe
    { spellID = 267273, stacks = 0, secs = 3 }, -- Poison Nova
    { spellID = 268419, stacks = 0, secs = 3 }, -- Gale Slash
    -- MOTHERLODE!!
    { spellID = 269298, stacks = 0, secs = 1 }, -- Widowmaker
    { spellID = 262347, stacks = 0, secs = 1 }, -- Static Pulse
    { spellID = 263074, stacks = 0, secs = 3 }, -- Festering Bite
    { spellID = 262270, stacks = 0, secs = 1 }, -- Caustic Compound
    { spellID = 262794, stacks = 0, secs = 1 }, -- Energy Lash
    { spellID = 259853, stacks = 0, secs = 3 }, -- Chemical Burn
    { spellID = 269092, stacks = 0, secs = 1 }, -- Artillery Barrage
    { spellID = 262348, stacks = 0, secs = 1 }, -- Mine Blast
    { spellID = 260838, stacks = 0, secs = 1 }, -- Homing Missile
    -- Temple of Sethraliss
    { spellID = 263371, stacks = 0, secs = 1 }, -- Conduction
    { spellID = 272657, stacks = 0, secs = 3 }, -- Noxious Breath
    { spellID = 267027, stacks = 0, secs = 1 }, -- Cytotoxin
    { spellID = 272699, stacks = 0, secs = 3 }, -- Venomous Spit
    { spellID = 268013, stacks = 0, secs = 5 }, -- Flame Shock
    -- Underrot
    { spellID = 265019, stacks = 0, secs = 1 }, -- Savage Cleave
    { spellID = 265568, stacks = 0, secs = 1 }, -- Dark Omen
    { spellID = 260685, stacks = 0, secs = 5 }, -- Taint of G'huun
    { spellID = 278961, stacks = 0, secs = 5 }, -- Decaying Mind
    { spellID = 260455, stacks = 0, secs = 1 }, -- Serrated Fangs
    { spellID = 273226, stacks = 0, secs = 1 }, -- Decaying Spores
    { spellID = 269301, stacks = 0, secs = 5 }, -- Putrid Blood
    -- all
    { spellID = 302421, stacks = 0, secs = 5 }, -- Queen's Decree
}
local pre_hot_list = {   --snipe list
    --Battle of Dazar'alor
    [283572] = { targeted = true }, --"Sacred Blade"
    [284578] = { targeted = true }, --"Penance"
    [286988] = { targeted = true }, --Divine Burst"
    [282036] = { targeted = true }, --"Fireball"
    [282182] = { targeted = false }, --"Buster Cannon"
    --Uldir
    [279669] = { targeted = false }, --"Bacterial Outbreak"
    [279660] = { targeted = false }, --"Endemic Virus"
    [274262] = { targeted = false }, --"Explosive Corruption"
    --Reaping
    [288693] = { targeted = true }, --"Grave Bolt",
    --Atal'Dazar
    [250096] = { targeted = true }, --"Wracking Pain"
    [253562] = { targeted = true }, --"Wildfire"
    [252781] = { targeted = true }, --"Unstable Hex"
    [252923] = { targeted = true }, --"Venom Blast"
    [253239] = { targeted = true }, -- Dazarai Juggernaut - Merciless Assault },
    [256846] = { targeted = true }, --'Dinomancer Kisho - Deadeye Aim'},
    [257407] = { targeted = true }, -- Rezan - Pursuit},
    --Kings Rest
    [267618] = { targeted = true }, --"Drain Fluids"
    [267308] = { targeted = true }, --"Lighting Bolt"
    [270493] = { targeted = true }, --"Spectral Bolt"
    [269973] = { targeted = true }, --"Deathly Chill"
    [270923] = { targeted = true }, --"Shadow Bolt"
    [272388] = { targeted = true }, --"Shadow Barrage"
    [266231] = { targeted = true }, -- Kula the Butcher - Severing Axe},
    [270507] = { targeted = true }, --  Spectral Beastmaster - Poison Barrage},
    [265773] = { targeted = true }, -- The Golden Serpent - Spit Gold},
    [270506] = { targeted = true }, -- Spectral Beastmaster - Deadeye Shot},
    [265773] = { targeted = true }, -- https://www.wowhead.com/spell=270487/severing-blade
    [268586] = { targeted = true }, -- https://www.wowhead.com/spell=268586/blade-combo
    --Free Hold
    [259092] = { targeted = true }, --"Lightning Bolt"
    [281420] = { targeted = true }, --"Water Bolt"
    [257267] = { targeted = false }, --"Swiftwind Saber"
    [257739] = { targeted = true }, -- Blacktooth Scrapper - Blind Rage},
    [258338] = { targeted = true }, -- Captain Raoul - Blackout Barrel},
    [256979] = { targeted = true }, -- Captain Eudora - Powder Shot},
    --Siege of Boralus
    [272588] = { targeted = true }, --"Rotting Wounds"
    [272827] = { targeted = false }, --"Viscous Slobber"
    [272581] = { targeted = true }, -- "Water Spray"
    [257883] = { targeted = false }, -- "Break Water"
    [257063] = { targeted = true }, --"Brackish Bolt"
    [272571] = { targeted = true }, --"Choking Waters"
    [257641] = { targeted = true }, -- Kul Tiran Marksman - Molten Slug},
    [272874] = { targeted = true }, -- Ashvane Commander - Trample},
    [272581] = { targeted = true }, -- Bilge Rat Tempest - Water Spray},
    [272528] = { targeted = true }, -- Ashvane Sniper - Shoot},
    [272542] = { targeted = true }, -- Ashvane Sniper - Ricochet},
    -- Temple of Sethraliss
    [263775] = { targeted = true }, --"Gust"
    [268061] = { targeted = true }, --"Chain Lightning"
    [272820] = { targeted = true }, --"Shock"
    [263365] = { targeted = true }, --"https://www.wowhead.com/spell=263365/a-peal-of-thunder"
    [268013] = { targeted = true }, --"Flame Shock"
    [274642] = { targeted = true }, --"Lava Burst"
    [268703] = { targeted = true }, --"Lightning Bolt"
    [272699] = { targeted = true }, --"Venomous Spit"
    [268703] = { targeted = true }, -- Charged Dust Devil - Lightning Bolt},
    [272670] = { targeted = true }, -- Sandswept Marksman - Shoot},
    [267278] = { targeted = true }, -- Static-charged Dervish - Electrocute},
    [272820] = { targeted = true }, -- Spark Channeler - Shock},
    [274642] = { targeted = true }, -- Hoodoo Hexer - Lava Burst},
    [268061] = { targeted = true }, -- Plague Doctor - Chain Lightning},
    --Shrine of the Storm
    [265001] = { targeted = true }, --"Sea Blast"
    [268347] = { targeted = true }, --"Void Bolt"
    [267969] = { targeted = true }, --"Water Blast"
    [268233] = { targeted = true }, --"Electrifying Shock"
    [268315] = { targeted = true }, --"Lash"
    [268177] = { targeted = true }, --"Windblast"
    [268273] = { targeted = true }, --"Deep Smash"
    [268317] = { targeted = true }, --"Rip Mind"
    [265001] = { targeted = true }, --"Sea Blast"
    [274703] = { targeted = true }, --"Void Bolt"
    [268214] = { targeted = true }, --"Carve Flesh"
    [264166] = { targeted = true }, -- Aqusirr - Undertow},
    [268214] = { targeted = true }, -- Runecarver Sorn - Carve Flesh},
    --Motherlode
    [259856] = { targeted = true }, --"Chemical Burn"
    [260318] = { targeted = true }, --"Alpha Cannon"
    [262794] = { targeted = true }, --"Energy Lash"
    [263202] = { targeted = true }, --"Rock Lance"
    [262268] = { targeted = true }, --"Caustic Compound"
    [263262] = { targeted = true }, --"Shale Spit"
    [263628] = { targeted = true }, --"Charged Claw"
    [268185] = { targeted = true }, -- Refreshment Vendor, Iced Spritzer},
    [258674] = { targeted = true }, -- Off-Duty Laborer - Throw Wrench},
    [276304] = { targeted = true }, -- Rowdy Reveler - Penny For Your Thoughts},
    [263209] = { targeted = true }, -- Mine Rat - Throw Rock},
    [263202] = { targeted = true }, -- Venture Co. Earthshaper - Rock Lance},
    [262794] = { targeted = true }, -- Venture Co. Mastermind - Energy Lash},
    [260669] = { targeted = true }, -- Rixxa Fluxflame - Propellant Blast},
    [271456] = { targeted = true }, -- https://www.wowhead.com/spell=271456/drill-smash},
    --Underrot
    [260879] = { targeted = true }, --"Blood Bolt"
    [265084] = { targeted = true }, --"Blood Bolt"
    [259732] = { targeted = false }, --"Festering Harvest"
    [266209] = { targeted = false }, --"Wicked Frenzy"
    [265376] = { targeted = true }, -- Fanatical Headhunter - Barbed Spear},
    [265625] = { targeted = true }, -- Befouled Spirit - Dark Omen},
    --Tol Dagor
    [257777] = { targeted = true }, --"Crippling Shiv"
    [258150] = { targeted = true }, --"Salt Blast"
    [258869] = { targeted = true }, --"Blaze"
    [256039] = { targeted = true }, -- Overseer Korgus - Deadeye},
    [185857] = { targeted = true }, -- Ashvane Spotter - Shoot},

    --work shop_
    [294195] = { targeted = true }, --https://www.wowhead.com/spell=294195/arcing-zap
    [293827] = { targeted = true }, --https://www.wowhead.com/spell=293827/giga-wallop
    [292264] = { targeted = true }, -- https://www.wowhead.com/spell=292264/giga-zap
    --junk yard
    [300650] = { targeted = true }, --https://www.wowhead.com/spell=300650/suffocating-smog
    [299438] = { targeted = true }, --https://www.wowhead.com/spell=299438/sledgehammer
    [300188] = { targeted = true }, -- https://www.wowhead.com/spell=300188/scrap-cannon#used-by-npc
    [302682] = { targeted = true }, --https://www.wowhead.com/spell=302682/mega-taze

    --Waycrest Manor
    [260701] = { targeted = true }, --"Bramble Bolt"
    [260700] = { targeted = true }, --"Ruinous Bolt"
    [260699] = { targeted = true }, --"Soul Bolt"
    [261438] = { targeted = true }, --"Wasting Strike"
    [266225] = { targeted = true }, --Darkened Lightning"
    [273653] = { targeted = true }, --"Shadow Claw"
    [265881] = { targeted = true }, --"Decaying Touch"
    [264153] = { targeted = true }, --"Spit"
    [278444] = { targeted = true }, --"Infest"
    [167385] = { targeted = true }, --"Infest"
    [263891] = { targeted = true }, -- Heartsbane Vinetwister - Grasping Thorns},
    [264510] = { targeted = true }, -- Crazed Marksman - Shoot},
    [260699] = { targeted = true }, -- Coven Diviner - Soul Bolt},
    [260551] = { targeted = true }, -- Soulbound Goliath - Soul Thorns},
    [260741] = { targeted = true }, -- Heartsbane Triad - Jagged Nettles},
    [268202] = { targeted = true } -- Gorak Tul - Death Lens},
}
local CC_CreatureTypeList = { "Beast", "Dragonkin" }
local StunsBlackList = {
    -- Atal'Dazar
    [87318] = "Dazar'ai Colossus",
    [122984] = "Dazar'ai Colossus",
    [128455] = "T'lonja",
    [129553] = "Dinomancer Kish'o",
    [129552] = "Monzumi",
    -- Freehold
    [129602] = "Irontide Enforcer",
    [130400] = "Irontide Crusher",
    -- King's Rest
    [133935] = "Animated Guardian",
    [134174] = "Shadow-Borne Witch Doctor",
    [134158] = "Shadow-Borne Champion",
    [137474] = "King Timalji",
    [137478] = "Queen Wasi",
    [137486] = "Queen Patlaa",
    [137487] = "Skeletal Hunting Raptor",
    [134251] = "Seneschal M'bara",
    [134331] = "King Rahu'ai",
    [137484] = "King A'akul",
    [134739] = "Purification Construct",
    [137969] = "Interment Construct",
    [135231] = "Spectral Brute",
    [138489] = "Shadow of Zul",
    -- Shrine of the Storm
    [134144] = "Living Current",
    [136214] = "Windspeaker Heldis",
    [134150] = "Runecarver Sorn",
    [136249] = "Guardian Elemental",
    [134417] = "Deepsea Ritualist",
    [136353] = "Colossal Tentacle",
    [136295] = "Sunken Denizen",
    [136297] = "Forgotten Denizen",
    -- Siege of Boralus
    [129369] = "Irontide Raider",
    [129373] = "Dockhound Packmaster",
    [128969] = "Ashvane Commander",
    [138255] = "Ashvane Spotter",
    [138465] = "Ashvane Cannoneer",
    [135245] = "Bilge Rat Demolisher",
    -- Temple of Sethraliss
    [134991] = "Sandfury Stonefist",
    [139422] = "Scaled Krolusk Tamer",
    [136076] = "Agitated Nimbus",
    [134691] = "Static-charged Dervish",
    [139110] = "Spark Channeler",
    [136250] = "Hoodoo Hexer",
    [139946] = "Heart Guardian",
    -- MOTHERLODE!!
    [130485] = "Mechanized Peacekeeper",
    [136139] = "Mechanized Peacekeeper",
    [136643] = "Azerite Extractor",
    [134012] = "Taskmaster Askari",
    [133430] = "Venture Co. Mastermind",
    [133463] = "Venture Co. War Machine",
    [133436] = "Venture Co. Skyscorcher",
    [133482] = "Crawler Mine",
    -- Underrot
    [131436] = "Chosen Blood Matron",
    [133912] = "Bloodsworn Defiler",
    [138281] = "Faceless Corruptor",
    -- Tol Dagor
    [130025] = "Irontide Thug",
    -- Waycrest Manor
    [131677] = "Heartsbane Runeweaver",
    [135329] = "Matron Bryndle",
    [131812] = "Heartsbane Soulcharmer",
    [131670] = "Heartsbane Vinetwister",
    [135365] = "Matron Alma",
}

local function BossEncounterCase()
    local burst = false
    local crit_count = 0
	
    --Bursting
    if isChecked("Bursting") and inInstance and #tanks > 0 then
        local ourtank = tanks[1].unit
        local Burststack = getDebuffStacks(ourtank, 240443)
        if Burststack >= getOptionValue("Bursting") then
            burst = true
        else
            burst = false
        end
    end
	
    if burst == false then
        for i = 1, #br.friend do
            if UnitInRange(br.friend[i].unit) and br.friend[i].hp <= getValue("Critical HP") then
                crit_count = crit_count + 1
            end
            if crit_count >= getOptionValue("Bursting") then
                burst = true
            end
        end
    end

    --cw on ourself to survive bursting
    if burst == true and cast.able.cenarionWard() and (getDebuffStacks("player", 240443) > 1 or php <= getValue("Critical HP") or getDebuffStacks("player", 240559) > 2) then
        if cast.able.cenarionWard() then
            if cast.cenarionWard("player") then
                br.addonDebug("[BURST]: CW on self")
                return true
            end
        end
    end

    if cast.able.cenarionWard() and php <= getValue("Critical HP") or getDebuffStacks("player", 240559) > 2 then
        if cast.able.cenarionWard() then
            if cast.cenarionWard("player") then
                br.addonDebug("[BURST]: CW on self")
                return true
            end
        end
    end

    if mode.HEALS == 1 then
        --critical
        if isChecked("Critical HP") and lowest.hp <= getOptionValue("Critical HP") then
            if cast.able.cenarionWard() then
                if cast.cenarionWard(lowest.hp) then
                    br.addonDebug("[CRIT]CWard on: " .. UnitName(lowest.unit))
                    return true
                end
            end
            if cast.able.swiftmend() then
                if cast.swiftmend(lowest.unit) then
                    br.addonDebug("[CRIT]Swiftmend on: " .. UnitName(lowest.unit))
                    return true
                end
            end
            if talent.germination and not buff.rejuvenationGermination.exists(lowest.unit) then
                if cast.rejuvenation(lowest.unit) then
                    br.addonDebug("[CRIT]Germination on: " .. UnitName(lowest.unit))
                    return true
                end
            elseif not talent.germination and not buff.rejuvenation.exists(lowest.unit) then
                if cast.rejuvenation(lowest.unit) then
                    br.addonDebug("[CRIT]Rejuvenation on: " .. UnitName(lowest.unit))
                    return true
                end
            end
            if cast.able.regrowth() then
                if cast.regrowth(lowest.unit) then
                    br.addonDebug("[CRIT]Regrowth on: " .. UnitName(lowest.unit))
                    return true
                end
            end
        end
	end
	
    -- aggressive dots
    if isChecked("Aggressive Dots") and mode.DPS == 1 and lowest.hp > getValue("DPS Min % health") and not noDamageCheck("target") and burst == false then
        thisUnit = "target"
        if isChecked("Safe Dots") and not noDamageCheck(thisUnit) and
            (
			    (inInstance and #tanks > 0 and getDistance(thisUnit, tanks[1].unit) <= 10)
                or 
				(inInstance and #tanks == 0)
                or 
				(inRaid and #tanks > 1 and (getDistance(thisUnit, tanks[1].unit) <= 10 or (getDistance(thisUnit, tanks[2].unit) <= 10)))
                or 
				solo
                or 
				(inInstance and #tanks > 0 and getDistance(tanks[1].unit) >= 90)
                --need to add, or if tank is dead
            ) 
			or (not isChecked("Safe Dots") or #tanks == 0) 
			then
                if not debuff.sunfire.exists("target") then
                    if cast.sunfire("target", "aoe", 1, sunfire_radius) then
                        br.addonDebug("Aggressive  Sunfire - target")
                        return true
                    end
                end
                if not debuff.moonfire.exists("target") then
                    if cast.moonfire("target") then
                        br.addonDebug("Aggressive Moonfire - target")
                        return true
                    end
                end
            end
        end

        -- DOT damage to teammates cast Rejuvenation
        if mode.HEALS == 1 then
            if isChecked("Smart Hot") then
                local spellTarget = nil
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    local _, _, _, _, endCast, _, _, _, spellcastID = UnitCastingInfo(thisUnit)
                    spellTarget = select(3, UnitCastID(thisUnit))
                    if spellTarget ~= nil and endCast and pre_hot_list[spellcastID] and ((endCast / 1000) - GetTime()) < 1 then
                        if cast.cenarionWard(spellTarget) then
                            br.addonDebug("[Snipe]CW on: " .. UnitName(spellTarget))
                            return true
                        end
                        if talent.germination and not buff.rejuvenationGermination.exists(spellTarget) then
                            if cast.rejuvenation(spellTarget) then
                                br.addonDebug("[Snipe]Germination on: " .. UnitName(spellTarget))
                                return true
                            end
                        elseif not talent.germination and not buff.rejuvenation.exists(spellTarget) then
                            if cast.rejuvenation(spellTarget) then
                                br.addonDebug("[Snipe]Rejuvenation on: " .. UnitName(spellTarget))
                                return true
                            end
                        end
                        if isSelected("Use Bark w/Smart Hot") and getHP(spellTarget) > getValue("Use Bark w/Smart Hot") then
                            if cast.ironbark(spellTarget) then
                                br.addonDebug("[Snipe]Bark on: " .. UnitName(spellTarget))
                                return true
                            end
                        end
                    end
                end
                for i = 1, #br.friend do
                    if UnitInRange(br.friend[i].unit) then
                        for k, v in pairs(debuff_list) do
                            if getDebuffRemain(br.friend[i].unit, v.spellID) > v.secs and getDebuffStacks(br.friend[i].unit, v.spellID) >= v.stacks and not buff.rejuvenation.exists(br.friend[i].unit) then
                                if talent.germination and not buff.rejuvenationGermination.exists(br.friend[i].unit) then
                                    if cast.rejuvenation(br.friend[i].unit) then
                                        br.addonDebug("[DEBUFF]Germination on: " .. UnitName(br.friend[i].unit))
                                        return true
                                    end
                                elseif not buff.rejuvenation.exists(br.friend[i].unit) then
                                    if cast.rejuvenation(br.friend[i].unit) then
                                        br.addonDebug("[DEBUFF]Rejuv on: " .. UnitName(br.friend[i].unit))
                                        return true
                                    end
                                end
                                return true
                            end
                        end
                    end
                end -- cw snipe


                for i = 1, #precast_spell_list do
                    local boss_spell_id = precast_spell_list[i][1]
                    local precast_time = precast_spell_list[i][2]
                    local spell_name = precast_spell_list[i][3]
                    local time_remain = br.DBM:getPulltimer(nil, boss_spell_id)

                    -- Innervate
                    if (time_remain < precast_time + 2 and time_remain < precast_time + 4) then
                        if cast.able.innervate and not buff.innervate.exists("player") then
                            if cast.innervate() then
                                br.addonDebug("[PRE-HOT] Innervate - pre-pre-hot")
                                return true
                            end
                        end
                    end

                    -- wildGrowth
                    if time_remain < precast_time - 2 then
                        if cast.able.wildGrowth then
                            if cast.wildGrowth("player") then
                                br.addonDebug("[PRE-HOT] Wildgrowth")
                                return true
                            end
                        end
                    end

                    if time_remain < precast_time then
                        for j = 1, #br.friend do
                            if UnitInRange(br.friend[j].unit) then
                                if not buff.rejuvenation.exists(br.friend[j].unit) then
                                    if cast.rejuvenation(br.friend[j].unit) then
                                        br.addonDebug("[PRE-HOT]Rejuv on: " .. UnitName(br.friend[j].unit) .. " because: " .. spell_name)
                                        return true
                                    end
                                end
                            end
                        end
                    end
                end
                local Casting = {
                    --spell_id	, spell_name
                    { 196587, 'Soul Burst' }, --Amalgam of Souls
                    { 211464, 'Fel Detonation' }, --Advisor Melandrus
                    { 237276, 'Pulverizing Cudgel' }, --Thrashbite the Scornful
                    { 193611, 'Focused Lightning' }, --Lady Hatecoil
                    { 192305, 'Eye of the Storm' }, --Hyrja
                    { 239132, 'Rupture Realities' }, --Fallen Avatar
                }
                for i = 1, #Casting do
                    local spell_id = Casting[i][1]
                    local spell_name = Casting[i][2]
                    for j = 1, #br.friend do
                        if UnitInRange(br.friend[j].unit) then
                            if UnitCastingInfo("boss1") == GetSpellInfo(spell_id) and not buff.rejuvenation.exists(br.friend[j].unit) then
                                if cast.rejuvenation(br.friend[j].unit) then
                                    br.addonDebug("[DBM PRE-HOT]Rejuv on: " .. UnitName(br.friend[j].unit) .. " because: " .. spell_name)
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end

        if isChecked("Freehold - pig") then
            bossHelper()
        end

        local heal_target = "none"
        using_lifebloom = false
        local seth_routine

        -- Temple of Sethraliss
        if lowest.hp > getOptionValue("Critical HP") then
            for i = 1, GetObjectCountBR() do
                if GetObjectID(GetObjectWithIndex(i)) == 133392 and getHP(GetObjectWithIndex(i)) < 100 and getBuffRemain(GetObjectWithIndex(i), 274148) == 0 then
                    heal_target = GetObjectWithIndex(i)
                    seth_routine = true
                end
            end
        end

        -- Waycrest Manor
        if inInstance and inCombat and select(8, GetInstanceInfo()) == 1862 then
            for i = 1, #br.friend do
                if getDebuffRemain(br.friend[i].unit, 260741) ~= 0 --Jagged Nettles
                        and br.friend[i].hp < 95 then
                    heal_target = br.friend[i].unit
                end
            end
        end

        --Kings Rest
        if inInstance and inCombat and select(8, GetInstanceInfo()) == 1762 then
            for i = 1, #br.friend do
                if getDebuffRemain(br.friend[i].unit, 267626) ~= 0 -- Dessication
                        or getDebuffRemain(br.friend[i].unit, 267618) ~= 0 -- Drain Fluids
                        or getDebuffRemain(br.friend[i].unit, 266231) ~= 0 -- Severing axe from axe lady in council
                        or getDebuffRemain(br.friend[i].unit, 272388) ~= 0 -- shadow barrage
                        or getDebuffRemain(br.friend[i].unit, 265773) > 1 -- spit-gold
                        or (getDebuffRemain(br.friend[i].unit, 270487) ~= 0 and getDebuffStacks(br.friend[i].unit, 270487) > 1) -- severing-blade
                        and br.friend[i].hp < 95 then
                    heal_target = br.friend[i].unit
                end
            end
        end

        -- Sacrifical Pits/ Devour
        if inInstance and inCombat and select(8, GetInstanceInfo()) == 1763 then
            for i = 1, #br.friend do
                if (getDebuffRemain(br.friend[i].unit, 255421) or getDebuffRemain(br.friend[i].unit, 255434)) ~= 0 and br.friend[i].hp <= 90 then
                    heal_target = br.friend[i].unit
                end
            end
        end

        -- 272388(zul), 266231(severing axe), 268586(blade combo)
        if select(8, GetInstanceInfo()) == 1762 then
            for i = 1, #br.friend do
                if (getDebuffRemain(br.friend[i].unit, 266231)
                        or getDebuffRemain(br.friend[i].unit, 272388)) ~= 0
                        and br.friend[i].hp <= 90 then
                    heal_target = br.friend[i].unit
                    return true
                end
            end
        end

        if heal_target ~= "none" then

            if not seth_routine then
                if cast.able.ironbark() then
                    if cast.ironbark(heal_target) then
                        br.addonDebug("[BOSS]Bark on: " .. UnitName(heal_target))
                        return true
                    end
                end
                if cast.able.cenarionWard() then
                    if cast.cenarionWard(heal_target) then
                        br.addonDebug("[BOSS]CWard on: " .. UnitName(heal_target))
                        return true
                    end
                end
            end
            if cast.able.lifebloom() and buff.lifebloom.remains(heal_target) < 2 then
                if cast.lifebloom(heal_target) then
                    using_lifebloom = true
                    br.addonDebug("[BOSS]Bloom on: " .. UnitName(heal_target))
                    return true
                end
            end
            if talent.germination and not buff.rejuvenationGermination.exists(heal_target) then
                if cast.rejuvenation(heal_target) then
                    br.addonDebug("[BOSS]Germination on: " .. UnitName(heal_target))
                    return true
                end
            elseif not talent.germination and not buff.rejuvenation.exists(heal_target) then
                if cast.rejuvenation(heal_target) then
                    br.addonDebug("[CRIT]Rejuvenation on: " .. UnitName(heal_target))
                    return true
                end
            end
            if cast.able.swiftmend() and getHP(heal_target) < 80 then
                if cast.swiftmend(heal_target) then
                    br.addonDebug("[BOSS]Swiftmend on: " .. UnitName(heal_target))
                    return true
                end
            end
            if cast.able.regrowth() then
                if cast.regrowth(heal_target) then
                    br.addonDebug("[BOSS]Regrowth on: " .. UnitName(heal_target))
                    return true
                end
            end
        end
    end
end












