-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_ROGUE_ASSASSINATION] = {
    -- Racial
    ArcaneTorrent                        = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                            = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                            = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                        = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                           = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                          = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                          = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                             = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                             = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                             = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                          = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                           = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                            = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                    = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                         = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                   = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    PetKick                              = Action.Create({ Type = "Spell", ID = 47482, Color = "RED", Desc = "RED" }),  
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647     }),
    -- Generics Spells
    Envenom                                = Action.Create({ Type = "Spell", ID = 32645     }),
    FanofKnives                            = Action.Create({ Type = "Spell", ID = 51723     }),
    Garrote                                = Action.Create({ Type = "Spell", ID = 703     }),
    KidneyShot                             = Action.Create({ Type = "Spell", ID = 408     }),
    Mutilate                               = Action.Create({ Type = "Spell", ID = 1329     }),
    PoisonedKnife                          = Action.Create({ Type = "Spell", ID = 185565     }),
    Rupture                                = Action.Create({ Type = "Spell", ID = 1943     }),
    Stealth                                = Action.Create({ Type = "Spell", ID = 1784     }),
    Stealth2                               = Action.Create({ Type = "Spell", ID = 115191     }), -- w/ Subterfuge Talent
    Vanish                                 = Action.Create({ Type = "Spell", ID = 1856     }),
    Vendetta                               = Action.Create({ Type = "Spell", ID = 79140     }),
    -- Talents
    Blindside                              = Action.Create({ Type = "Spell", ID = 111240     }),
    CrimsonTempest                         = Action.Create({ Type = "Spell", ID = 121411     }),
    DeeperStratagem                        = Action.Create({ Type = "Spell", ID = 193531     }),
    Exsanguinate                           = Action.Create({ Type = "Spell", ID = 200806     }),
    InternalBleeding                       = Action.Create({ Type = "Spell", ID = 154953     }),
    MarkedForDeath                         = Action.Create({ Type = "Spell", ID = 137619     }),
    MasterAssassin                         = Action.Create({ Type = "Spell", ID = 255989     }),
    Nightstalker                           = Action.Create({ Type = "Spell", ID = 14062     }),
    Subterfuge                             = Action.Create({ Type = "Spell", ID = 108208     }),
    ToxicBlade                             = Action.Create({ Type = "Spell", ID = 245388     }),
    VenomRush                              = Action.Create({ Type = "Spell", ID = 152152     }),
	Dismantle                              = Action.Create({ Type = "Spell", ID = 207777     }), -- PvP Talent
    -- Azerite Traits
    DoubleDose                             = Action.Create({ Type = "Spell", ID = 273007     }),
    EchoingBlades                          = Action.Create({ Type = "Spell", ID = 287649     }),
    ShroudedSuffocation                    = Action.Create({ Type = "Spell", ID = 278666     }),
    ScentOfBlood                           = Action.Create({ Type = "Spell", ID = 277679     }),
    RecklessForceCounter                   = Action.Create({ Type = "Spell", ID = 302917     }),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368     }),
    -- Defensive
    CrimsonVial                            = Action.Create({ Type = "Spell", ID = 185311     }),
    Feint                                  = Action.Create({ Type = "Spell", ID = 1966     }),
	CloakofShadow                          = Action.Create({ Type = "Spell", ID = 31224     }),
	Evade                                  = Action.Create({ Type = "Spell", ID = 5277     }),
    -- Utilities
    KidneyShot                             = Action.Create({ Type = "Spell", ID = 408       }),
    Gouge                                  = Action.Create({ Type = "Spell", ID = 1776       }),
    Blind                                  = Action.Create({ Type = "Spell", ID = 2094     }),
    Kick                                   = Action.Create({ Type = "Spell", ID = 1766     }),
    Sprint                                 = Action.Create({ Type = "Spell", ID = 2983       }),
    CheapShot                              = Action.Create({ Type = "Spell", ID = 1833       }),
	ShadowStep                             = Action.Create({ Type = "Spell", ID = 36554       }),
	TricksoftheTrade                       = Action.Create({ Type = "Spell", ID = 57934       }),
	-- PvP
	Sap                                    = Action.Create({ Type = "Spell", ID = 6770       }),
	Shiv                                   = Action.Create({ Type = "Spell", ID = 248744       }),
	SmokeBomb                              = Action.Create({ Type = "Spell", ID = 212182       }),
	DFA                                    = Action.Create({ Type = "Spell", ID = 269513       }),
	Neuro                                  = Action.Create({ Type = "Spell", ID = 206328       }),    
	-- Poisons
    CripplingPoison                        = Action.Create({ Type = "Spell", ID = 3408     }),
    DeadlyPoison                           = Action.Create({ Type = "Spell", ID = 2823     }),
    WoundPoison                            = Action.Create({ Type = "Spell", ID = 8679     }),
    -- Misc
    TheDreadlordsDeceit                    = Action.Create({ Type = "Spell", ID = 208693     }),
    IronWire                               = Action.Create({ Type = "Spell", ID = 196861, Hidden = true     }),	
    --PoolEnergy                             = Action.Create({ Type = "Spell", ID = 9999000010   }),
    PoolResource                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	
    -- Buffs
    VigorTrinketBuff                       = Action.Create({ Type = "Spell", ID = 287916, Hidden = true     }),
    LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295137, Hidden = true     }),
    HiddenBladesBuff                       = Action.Create({ Type = "Spell", ID = 270070, Hidden = true     }),
    BlindsideBuff                          = Action.Create({ Type = "Spell", ID = 121153 , Hidden = true     }),
    VanishBuff                             = Action.Create({ Type = "Spell", ID = 11327 , Hidden = true     }),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932 , Hidden = true     }),
	SubterfugeBuff                         = Action.Create({ Type = "Spell", ID = 115192 , Hidden = true     }),
    -- Debuffs 
	GarroteDebuff                          = Action.Create({ Type = "Spell", ID = 703, Hidden = true     }),
    RuptureDebuff                          = Action.Create({ Type = "Spell", ID = 1943, Hidden = true     }),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    WoundPoisonDebuff                      = Action.Create({ Type = "Spell", ID = 8680, Hidden = true     }),
    DeadlyPoisonDebuff                     = Action.Create({ Type = "Spell", ID = 2818 , Hidden = true     }),
    BloodoftheEnemyDebuff                  = Action.Create({ Type = "Spell", ID = 297108 , Hidden = true     }),
    ToxicBladeDebuff                       = Action.Create({ Type = "Spell", ID = 245389, Hidden = true     }),
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionofAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }),
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	AbyssalHealingPotion    			   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }),	   
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
	LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleinSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleinSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleinSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_ROGUE_ASSASSINATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_ASSASSINATION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarVendettaSubterfugeCondition = false
local VarVendettaNightstalkerCondition = false
local VarVendettaFontCondition = false
local VarSingleUnit = false
local VarSsVanishCondition = false
local VarEnergyRegenCombined = 0
local VarUseFiller = false
local VarSkipCycleGarrote = false
local VarSkipCycleRupture = false
local VarSkipRupture = false
-- Lua
local mathmin = math.min;
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local player = "player"

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarVendettaSubterfugeCondition = false
  VarVendettaNightstalkerCondition = false
  VarVendettaFontCondition = false
  VarSingleUnit = false
  VarSsVanishCondition = false
  VarEnergyRegenCombined = 0
  VarUseFiller = false
  VarSkipCycleGarrote = false
  VarSkipCycleRupture = false
  VarSkipRupture = false
end)

------------------------------------
--- RegisterDamage simc reference
------------------------------------
-- Register the spell damage formula.
--[[function A:RegisterDamage(Function)
  self.DamageFormula = Function
end

-- Get the spell damage formula if it exists.
function A:Damage()
  return self.DamageFormula and self.DamageFormula() or 0
end

-- attack_power
function A.Player:AttackPower()
    return UnitAttackPower("player")
end]]--

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

---------------------------------------------------
-------------- ASSASSINATION PREAPL ---------------
---------------------------------------------------
local BleedTickTime, ExsanguinatedBleedTickTime = 2 / Player:SpellHaste(), 1 / Player:SpellHaste();
local Stealth;
local ComboPoints, ComboPointsDeficit, Energy_Regen_Combined, PoisonedBleeds;
local PriorityRotation;

---------------------------------------------------
---------- ASSASSINATION SPECIFICS ----------------
---------------------------------------------------

-- Rupture TickTime 
-- [1943] = {2000, false}
local function RuptureTickTime()
    local BaseTickTime = 2
    local Hasted = false
    if Hasted then
        return BaseTickTime * Player:SpellHaste() 
	end
    return BaseTickTime
end

-- Garrote TickTime 
-- [703] = {2000, false}
local function GarroteTickTime()
    local BaseTickTime = 2
    local Hasted = false
    if Hasted then
        return BaseTickTime * Player:SpellHaste() 
	end
    return BaseTickTime
end

-- Master Assassin Remains Check
local MasterAssassinBuff, NominalDuration = 256735, 3;
local function MasterAssassinRemains()
    if Unit("player"):HasBuffs(MasterAssassinBuff, true) < 0 then
        return A.GetCurrentGCD() + NominalDuration;
    else
        return Unit("player"):HasBuffs(MasterAssassinBuff, true);
    end
end

-- Poisoned
function Poisoned (unit)
    return (Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) or Unit(unit):HasDeBuffs(A.WoundPoisonDebuff.ID, true)) and true or false;
end

-- Bleeds
function Bleeds (unit)
    return (Unit(unit):HasDeBuffs(A.Garrote.ID, true) > 0 and 1 or 0) + (Unit(unit):HasDeBuffs(A.Rupture.ID, true) > 0 and 1 or 0)
    + (Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) > 0 and 1 or 0) + (Unit(unit):HasDeBuffs(A.InternalBleeding.ID, true) > 0 and 1 or 0);
end
  
-- Poisoned + Bleeds  
local PoisonedBleedsCount = 0;
function PoisonedBleeds ()
    PoisonedBleedsCount = 0;
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Garrote.ID) -- Garrote count
 	local AppliedInternalBleeding = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.InternalBleeding.ID) -- InternalBleeding count
 	local AppliedRupture = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Rupture.ID) -- Rupture count
	
	PoisonedBleedsCount = AppliedGarrote + AppliedInternalBleeding + AppliedRupture
	
	if Unit("target"):IsDummy() then
	    PoisonedBleedsCount = 1 * MultiUnits:GetByRange(10)
	end
	
    return PoisonedBleedsCount;
end
	
---------------------------------------------------
------- SIMC CUSTOM FUNCTION / EXPRESSION ---------
---------------------------------------------------

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Player:ComboPoints(), CPMaxSpend());
end

local function NighstalkerMultiplier ()
    return A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5 or 1;
end
local function SubterfugeGarroteMultiplier ()
    return A.Subterfuge:IsSpellLearned() and Player:IsStealthed() and 2 or 1;
end

A.RegisterPMultiplier( -- Garrote dot and action
	A.Garrote.ID,    -- Garrote action
	A.GarroteDebuff.ID,  -- GarroteDebuff dot
		{function ()
				return (A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5) or (A.Subterfuge:IsSpellLearned() and Player:IsStealthed() and 2) or 1
		end}
)

A.RegisterPMultiplier( -- Rupture dot and action
	A.Rupture.ID,    -- Rupture action
	A.RuptureDebuff.ID,  -- RuptureDebuff dot
		{function ()
				return A.Nightstalker:IsSpellLearned() and Player:IsStealthed() and 1.5 or 1
		end}

)

	
--[[
-- Spells Damage
A.Envenom:RegisterDamage(
-- Envenom DMG Formula:
--    AP * CP * Env_APCoef * Aura_M * ToxicB_M * DS_M * Mastery_M * Versa_M
function ()
    return
        -- Attack Power
        Player:AttackPower() *
        -- Combo Points
        CPSpend() *
        -- Envenom AP Coef
        0.16 *
        -- Aura Multiplier (SpellID: 137037)
        1.27 *
        -- Toxic Blade Multiplier
        (A.ToxicBlade:IsSpellLearned() and 1.3 or 1) *
        -- Deeper Stratagem Multiplier
        (A.DeeperStratagem:IsSpellLearned() and 1.05 or 1) *
        -- Mastery Finisher Multiplier
        (1 + Player:MasteryPct()/100) *
        -- Versatility Damage Multiplier
        (1 + Player:VersatilityDmgPct()/100);
    end
);
A.Mutilate:RegisterDamage(
    function ()
        return
            -- Attack Power (MH Factor + OH Factor)
            Player:AttackPower() *
            -- Mutilate Coefficient
            0.35 *
            -- Aura Multiplier (SpellID: 137037)
            1.27 *
            -- Versatility Damage Multiplier
            (1 + Player:VersatilityDmgPct()/100);
    end
);
]]--
-- Stealth
function Stealth(Stealth, Setting)
    if Action.GetToggle(2, "StealthOOC") and Stealth:IsReady("player") and not Player:IsStealthed() then
        return Stealth:Show(icon)
    end
    return false;
end

---------------------------------------------------
------------------- DEFENSIVES --------------------
---------------------------------------------------

-- Crimson Vial
function CrimsonVial(CrimsonVial)
    if A.CrimsonVial:IsReady(unit) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "CrimsonVialHP") then
        return A.CrimsonVial:Show(icon)
    end
    return false;
end

-- Feint
function Feint(Feint)
    if A.Feint:IsReady(unit) and not Unit("player"):HasBuffs(A.Feint.ID, true) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "FeintHP") then
        return A.Feint:Show(icon)
    end
end

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
		
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 

    -- Emergency Evade
    local Evade = Action.GetToggle(2, "EvadeHP")
    if     Evade >= 0 and A.Evade:IsReady("player") and 
    (
        (   -- Auto 
            Evade >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Evade < 100 and 
            Unit("player"):HealthPercent() <= Evade
        )
    ) 
    then 
        return A.Evade
    end  
		
    -- Emergency Feint
        local Feint = Action.GetToggle(2, "FeintHP")
        if     Feint >= 0 and A.Feint:IsReady("player") and 
        (
            (   -- Auto 
                Feint >= 100 and 
                (
                    -- HP lose per sec >= 20
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            Unit("player"):UseDeff() or 
                            (
                                Unit("player", 5):HasFlags() and 
                                Unit("player"):GetRealTimeDMG() > 0 and 
                                Unit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                Unit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Feint < 100 and 
                Unit("player"):HealthPercent() <= Feint
            )
        ) 
        then 
            return A.Feint
        end  		

        -- Emergency CrimsonVial
        local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
        if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
        (
            (   -- Auto 
                CrimsonVial >= 100 and 
                (
                    -- HP lose per sec >= 20
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            Unit("player"):UseDeff() or 
                            (
                                Unit("player", 5):HasFlags() and 
                                Unit("player"):GetRealTimeDMG() > 0 and 
                                Unit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                Unit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CrimsonVial < 100 and 
                Unit("player"):HealthPercent() <= CrimsonVial
            )
        ) 
        then 
            return A.CrimsonVial
        end  		

        -- Emergency Cloak of Shadow
        local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
        if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
        (
            (   -- Auto 
                CloakofShadow >= 100 and 
                (
                    -- HP lose per sec >= 20
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            Unit("player"):UseDeff() or 
                            (
                                Unit("player", 5):HasFlags() and 
                                Unit("player"):GetRealTimeDMG() > 0 and 
                                Unit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                Unit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CloakofShadow < 100 and 
                Unit("player"):HealthPercent() <= CloakofShadow
            )
        ) 
        then 
            return A.CloakofShadow
        end 
		
        -- Emergency Vanish
        local Vanish = Action.GetToggle(2, "VanishDefensive")
        if     Vanish >= 0 and A.Vanish:IsReady("player") and 
        (
            (   -- Auto 
                Vanish >= 100 and 
                (
                    -- HP lose per sec >= 20
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            Unit("player"):UseDeff() or 
                            (
                                Unit("player", 5):HasFlags() and 
                                Unit("player"):GetRealTimeDMG() > 0 and 
                                Unit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                Unit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Vanish < 100 and 
                Unit("player"):HealthPercent() <= Vanish
            )
        ) 
    then 
        return A.Vanish
    end  
	
		    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function RefreshPoisons()
    local choice = Action.GetToggle(2, "PoisonToUse")
	-- Crippling Poison
	if A.CripplingPoison:IsReady("player") and (Unit("player"):HasBuffs(A.CripplingPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.CripplingPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.CripplingPoison:Info() and not Unit("player"):IsCasting() then
	    return A.CripplingPoison
	end	
	-- Wound Poison
	if choice == "Wound Poison" then 
	    if A.WoundPoison:IsReady("player") and (Unit("player"):HasBuffs(A.WoundPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.WoundPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.WoundPoison:Info() and not Unit("player"):IsCasting() then 
		    return A.WoundPoison
        end
	-- Deadly Poison
	elseif choice == "Deadly Poison" then
	    if A.DeadlyPoison:IsReady("player") and (Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.DeadlyPoison:Info() and not Unit("player"):IsCasting() then 
		    return A.DeadlyPoison
        end
	elseif choice == "Auto" then
	    -- Auto
	    if Action.IsInPvP and A.WoundPoison:IsReady("player") and (Unit("player"):HasBuffs(A.WoundPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.WoundPoison.ID, true) == 0) and A.LastPlayerCastName ~= A.WoundPoison:Info() and not Unit("player"):IsCasting() then 		
	        return A.WoundPoison
		else
		    if A.DeadlyPoison:IsReady("player") and (Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) <= 10 or Unit("player"):HasBuffs(A.DeadlyPoison.ID, true) == 0) and not Action.IsInPvP and A.LastPlayerCastName ~= A.DeadlyPoison:Info() and not Unit("player"):IsCasting() then
		        return A.DeadlyPoison
		    end
	    end
	else
	    return
	end	
end
RefreshPoisons = A.MakeFunctionCachedDynamic(RefreshPoisons)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        -- Notification					
        Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
		return A.Kick
    end 
    
	if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification					
        Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
		return A.Gouge              
    end          
	
	if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification					
        Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
		return A.CheapShot              
    end
    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        -- Notification					
        Action.SendNotification("QuakingPalm on : " .. UnitName(unit), A.QuakingPalm.ID)
		return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        -- Notification					
        Action.SendNotification("Haymaker on : " .. UnitName(unit), A.Haymaker.ID)
		return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        -- Notification					
        Action.SendNotification("WarStomp on : " .. UnitName(unit), A.WarStomp.ID)
		return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        -- Notification					
        Action.SendNotification("BullRush on : " .. UnitName(unit), A.BullRush.ID)
		return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)



-------------------------------
---- CUSTOM ROGUE FCT ---------
-------------------------------
-- TODO: Register/Unregister Events on SpecChange
Action.BleedTable = {
    Assassination = {
      Garrote = {},
      Rupture = {}
    },
    --Subtlety = {
    --  Nightblade = {},
    --}
}

local BleedGUID

--- Exsanguinated Handler
-- Exsanguinate Expression
local BleedDuration, BleedExpires;
local function Exsanguinated (Unit, SpellName)
    BleedGUID = Unit:GUID()
    if BleedGUID then
        if SpellName == "Garrote" then
            if Action.BleedTable.Assassination.Garrote[BleedGUID] then
                return Action.BleedTable.Assassination.Garrote[BleedGUID][3];
            end
        elseif SpellName == "Rupture" then
            if Action.BleedTable.Assassination.Rupture[BleedGUID] then
                return Action.BleedTable.Assassination.Rupture[BleedGUID][3];
            end
        end
    end
    return false
end

-- Exsanguinate OnCast Listener
Action:RegisterForSelfCombatEvent(function (...)
    DestGUID, _, _, _, SpellID = select(8, ...)

    -- Exsanguinate
    if SpellID == 200806 then
        for Key, _ in pairs(Action.BleedTable.Assassination) do
            for Key2, _ in pairs(Action.BleedTable.Assassination[Key]) do
                if Key2 == DestGUID then
                    -- Change the Exsanguinate info to true
                    Action.BleedTable.Assassination[Key][Key2][3] = true
                end
            end
        end
    end
end
, "SPELL_CAST_SUCCESS"
);

-- Bleed infos
local function GetBleedInfos (GUID, SpellID)
    -- Core API is not used since we don't want cached informations
    for i = 1, 40 do
        local auraInfo = {UnitAura(GUID, i, "HARMFUL|PLAYER")}
        if auraInfo[10] == SpellID then
            return auraInfo[5]
        end
    end
    return nil
end

-- Bleed OnApply/OnRefresh Listener
Action:RegisterForSelfCombatEvent(
    function (...)
        DestGUID, _, _, _, SpellID = select(8, ...)

        --- Record the Bleed Target and its Infos
        -- Garrote
        if SpellID == 703 then
            BleedDuration, BleedExpires = GetBleedInfos(DestGUID, SpellID);
            Action.BleedTable.Assassination.Garrote[DestGUID] = {BleedDuration, BleedExpires, false}
        -- Rupture
        elseif SpellID == 1943 then
            BleedDuration, BleedExpires = GetBleedInfos(DestGUID, SpellID);
            Action.BleedTable.Assassination.Rupture[DestGUID] = {BleedDuration, BleedExpires, false}
        end
    end
    , "SPELL_AURA_APPLIED"
    , "SPELL_AURA_REFRESH"
);

-- Bleed OnRemove Listener
Action:RegisterForSelfCombatEvent(function (...)
        DestGUID, _, _, _, SpellID = select(8, ...)

        -- Removes the Unit from Garrote Table
        if SpellID == 703 then
            if Action.BleedTable.Assassination.Garrote[DestGUID] then
                Action.BleedTable.Assassination.Garrote[DestGUID] = nil
            end
        -- Removes the Unit from Rupture Table
        elseif SpellID == 1943 then
            if Action.BleedTable.Assassination.Rupture[DestGUID] then
                Action.BleedTable.Assassination.Rupture[DestGUID] = nil
            end
        end
    end
    , "SPELL_AURA_REMOVED"
);

-- Bleed OnUnitDeath Listener
Action:RegisterForCombatEvent(function (...)
    DestGUID = select(8, ...)

    -- Removes the Unit from Garrote Table
    if Action.BleedTable.Assassination.Garrote[DestGUID] then
        Action.BleedTable.Assassination.Garrote[DestGUID] = nil
    end
    -- Removes the Unit from Rupture Table
    if Action.BleedTable.Assassination.Rupture[DestGUID] then
        Action.BleedTable.Assassination.Rupture[DestGUID] = nil
    end
end
, "UNIT_DIED"
, "UNIT_DESTROYED"
);


	

-- Fake SSBuffed (wonky without Subterfuge but why would you, eh?)
local function SSBuffed()
    return A.ShroudedSuffocation:GetAzeriteRank() > 0
end

-- non_SSBuffed_targets
local function NonSSBuffedTargets()
    local count = 0;
    
	local MissingGarrote = MultiUnits:GetByRangeMissedDoTs(10, 5, A.Garrote.ID)   
	
	count = MissingGarrote
	
    return count;
end

-- SSBuffed_targets_above_pandemic
local function SSBuffedTargetsAbovePandemic()
    local count = 0;
    local GarroteToRefresh = MultiUnits:GetByRangeDoTsToRefresh(10, 5, A.Garrote.ID, 5.4)
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(10, 5, A.Garrote.ID) -- Garrote count

    count = AppliedGarrote - GarroteToRefresh

    return count;
end

-- Multidot Handler UI --
local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if IsInGroup() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if A.IsInPvP then 
    		return true
		else
		    return false
		end		
    elseif choice == "Everywhere" then 
        return true
    else
		return false
    end
	--print(choice)
end


local function EvaluateTargetIfFilterMarkedForDeath31(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath36(unit)
  return (MultiUnits:GetByRange(40) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() * 1.5 or Player:ComboPointsDeficit() >= CPMaxSpend())
end


local function EvaluateCycleFanofKnives270(unit)
    return (Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) == 0) and (VarUseFiller and MultiUnits:GetByRange(10) >= 3)
end

local function EvaluateCycleMutilate291(unit)
    return (Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) == 0) and (VarUseFiller and MultiUnits:GetByRange(10) == 2)
end

local function EvaluateCycleGarrote408(unit)
  return not bool(VarSkipCycleGarrote) and Unit(unit) ~= self.target and (not A.Subterfuge:IsSpellLearned() or not (A.Vanish:GetCooldown() == 0 and A.Vendetta:GetCooldown() <= 4)) and Player:ComboPointsDeficit() >= 1 + 3 * num((A.ShroudedSuffocation:GetAzeriteRank() > 0 and A.Vanish:GetCooldown() == 0)) and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= 5.4 and (A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= GarroteTickTime and MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not Exsanguinated(Unit(unit), "Garrote") or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= GarroteTickTime * 2 and MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and not SSBuffed and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 0) > 12 and (MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and A.ShroudedSuffocation:GetAzeriteRank() > 0)
end

local function EvaluateCycleRupture555(unit)
  return not VarSkipCycleRupture and not VarSkipRupture and Unit(unit) ~= self.target and Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) < 5.2 and (A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= RuptureTickTime and MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= RuptureTickTime * 2 and MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4
end

local function EvaluateTargetIfFilterGarrote709(unit)
  return Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)
end

local function EvaluateTargetIfGarrote744(unit)
  return A.Subterfuge:IsSpellLearned() and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 12 or A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 2
end


local function EvaluateTargetIfFilterGarrote762(unit)
  return Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)
end

local function EvaluateTargetIfGarrote793(unit)
  return A.Subterfuge:IsSpellLearned() and A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit(unit):TimeToDie() > Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 18 or not SSBuffed)
end


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit("player"):CombatTime() > 0
    local combatTime = Unit("player"):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local RuptureTickTime = RuptureTickTime()
	local GarroteTickTime = GarroteTickTime()
	local MasterAssassinRemains = MasterAssassinRemains()
	local SSBuffedTargetsAbovePandemic = SSBuffedTargetsAbovePandemic()
	local NonSSBuffedTargets = NonSSBuffedTargets()
	local SSBuffed = SSBuffed()
	-- Spell ID Changes check
    local Stealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth; -- w/ or w/o Subterfuge Talent
	local RuptureThreshold = (4 + Player:ComboPoints() * 4) * 0.3;
    --local RuptureDMGThreshold = A.Envenom:Damage() * Action.GetToggle(2, "EnvenomDMGOffset"); -- Used to check if Rupture is worth to be casted since it's a finisher.
    --local GarroteDMGThreshold = A.Mutilate:Damage() * Action.GetToggle(2, "MutilateDMGOffset"); -- Used as TTD Not Valid fallback since it's a generator.
	-- Multidots var
	local MultiDotDistance = A.GetToggle(2, "MultiDotDistance")
	local MissingRupture = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.RuptureDebuff.ID) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
	local MissingGarrote = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.GarroteDebuff.ID) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
	local MissingCrimsonTempest = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.CrimsonTempest.ID)
	local ActivesRupture = MultiUnits:GetByRangeAppliedDoTs(MultiDotDistance, 5, A.RuptureDebuff.ID) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
	local ActivesGarrote = MultiUnits:GetByRangeAppliedDoTs(MultiDotDistance, 5, A.GarroteDebuff.ID) 
    local CanMultidot = HandleMultidots()	
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	
	-- FocusedAzeriteBeam protection channel
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit("player"):IsCastingRemains()
		-- @return:
		-- [1] Currect Casting Left Time (seconds) (@number)
		-- [2] Current Casting Left Time (percent) (@number)
		-- [3] spellID (@number)
		-- [4] spellName (@string)
		-- [5] notInterruptable (@boolean, false is able to be interrupted)
		-- [6] isChannel (@boolean)
	if percentLeft > 0.01 and spellName == A.FocusedAzeriteBeam:Info() then 
	    CanCast = false
	else
	    CanCast = true
	end	
	
	if not CanCast then
	    return A.PoolResource:Show(icon)
	end

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)


		-- Out of combat / Precombat
        if not inCombat then			    			
		
		    -- Sap out of combat
		    if A.Sap:IsReady(unit) and Player:IsStealthed() and Unit(unit):CombatTime() == 0 then
		        if Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0 and Unit(unit):IsControlAble("incapacitate", 75) then 
			        -- Notification					
                    Action.SendNotification("Out of combat Sap on : " .. UnitName(unit), A.Sap.ID)
			        return A.Sap:Show(icon)
			    else 
			        if Unit(unit):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unit):HasDeBuffs(A.Sap.ID, true) <= 1 and Unit(unit):IsControlAble("incapacitate", 25) then
    			        -- Notification					
                        Action.SendNotification("Refreshing Sap on : " .. UnitName(unit), A.Sap.ID)
			            return A.Sap:Show(icon)
				    end
			    end
		    end	

            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") 
			and (Pull > 0 and Pull <= 2 or not A.GetToggle(1, "DBM"))
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>15
            if A.MarkedForDeath:IsReady(unit) 
			and (Pull > 0 and Pull <= 5 or not A.GetToggle(1, "DBM"))
			then
                return A.MarkedForDeath:Show(icon)
            end

            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady("player") and A.BurstIsON(unit) 
			then
                return A.AzsharasFontofPower:Show(icon)
            end	

		    -- Garrote opener
		    if A.Garrote:IsReady(unit) and Unit("player"):HasDeBuffs(A.Garrote.ID, true) == 0 and 
			(Pull > 0 and Pull <= 5 or not A.GetToggle(1, "DBM")) 
			and
			    (
				    (Unit(unit):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unit):GetDR("incapacitate") < 50 ) 
					or
					Unit(unit):HasDeBuffs(A.Sap.ID, true) == 0
				)
			and
		        (
		           Player:IsStealthed() 
			       or 
			       Unit("player"):HasBuffs(A.VanishBuff.ID, true) > 0 
			       or 
			       A.LastPlayerCastName == A.Vanish:Info()
		        ) 
		    then		    
			    return A.Garrote:Show(icon)			
		    end				
        end
		
        --Essences
        local function Essences(unit)
            -- concentrated_flame,if=energy.time_to_max>1&!debuff.vendetta.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyTimeToMaxPredicted() > 1 and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- blood_of_the_enemy,if=debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up&combo_points.deficit<=1|debuff.vendetta.remains<=10)|target.time_to_die<=10
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and A.BurstIsON(unit)  and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 and (not A.ToxicBlade:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 and Player:ComboPointsDeficit() <= 1 or Unit(unit):HasDeBuffs(A.Vendetta.ID, true) <= 10) or Unit(unit):TimeToDie() <= 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- guardian_of_azeroth,if=cooldown.vendetta.remains<3|debuff.vendetta.up|target.time_to_die<30
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and A.BurstIsON(unit)  and Action.GetToggle(1, "HeartOfAzeroth") and (A.Vendetta:GetCooldown() < 3 or Unit(unit):HasDeBuffs(A.Vendetta.ID, true) or Unit(unit):TimeToDie() < 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- guardian_of_azeroth,if=floor((target.time_to_die-30)%cooldown)>floor((target.time_to_die-30-cooldown.vendetta.remains)%cooldown)
			
            -- focused_azerite_beam,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60&energy<70
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRange(10) >= 2) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRange(10) >= 2) then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleinSpace:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=energy<50&!cooldown.vendetta.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyPredicted() < 50 and not A.Vendetta:GetCooldown() == 0) then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
            if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or Unit(unit):TimeToDieX(20) > 30) then
                return A.ReapingFlames:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- use_item,name=azsharas_font_of_power,if=!stealthed.all&master_assassin_remains=0&(cooldown.vendetta.remains<?cooldown.toxic_blade.remains)<10+10*equipped.ashvanes_razor_coral&!debuff.vendetta.up&!debuff.toxic_blade.up
            if A.AzsharasFontofPower:IsReady(player) and (not Player:IsStealthed() and MasterAssassinRemains == 0 and num((A.Vendetta:GetCooldown() < A.ToxicBlade:GetCooldown())) < 10 + 10 * num(A.AshvanesRazorCoral:IsExists()) and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) == 0) then
                return A.AzsharasFontofPower:Show(icon)
            end
            -- call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
            if Essences(unit) and (not Player:IsStealthed() and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 0 and MasterAssassinRemains == 0) then
                return true
            end
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit*1.5|combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if (MultiUnits:GetByRange(40) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() * 1.5 or Player:ComboPointsDeficit() >= CPMaxSpend()) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and Player:ComboPointsDeficit() >= CPMaxSpend() then
                return A.MarkedForDeath:Show(icon)
            end
            -- variable,name=vendetta_subterfuge_condition,value=!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1&(spell_targets.fan_of_knives<6|!cooldown.vanish.up)
            if (true) then
                VarVendettaSubterfugeCondition = not A.Subterfuge:IsSpellLearned() or A.ShroudedSuffocation:GetAzeriteRank() == 0 or A.PMultiplier(unit, A.GarroteDebuff.ID) > 1 and (MultiUnits:GetByRange(10) < 6 or not A.Vanish:GetCooldown() == 0)
            end
            -- variable,name=vendetta_nightstalker_condition,value=!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled
            if (true) then
                VarVendettaNightstalkerCondition = not A.Nightstalker:IsSpellLearned() or not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() < 5 - 2 * num(A.DeeperStratagem:IsSpellLearned())
            end
            -- variable,name=variable,name=vendetta_font_condition,value=!equipped.azsharas_font_of_power|azerite.shrouded_suffocation.enabled|debuff.razor_coral_debuff.down|trinket.ashvanes_razor_coral.cooldown.remains<10&(cooldown.toxic_blade.remains<1|debuff.toxic_blade.up)
            if (true) then
                VarVendettaFontCondition = not A.AzsharasFontofPower:IsExists() or A.ShroudedSuffocation:GetAzeriteRank() > 0 or Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 or A.AshvanesRazorCoral:GetCooldown() < 10 and (A.ToxicBlade:GetCooldown() < 1 or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0)
            end
            -- vendetta,if=!stealthed.rogue&dot.rupture.ticking&!debuff.vendetta.up&variable.vendetta_subterfuge_condition&variable.vendetta_nightstalker_condition&variable.vendetta_font_condition
            if A.Vendetta:IsReady(unit) and (not Player:IsStealthed() and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and VarVendettaSubterfugeCondition and VarVendettaNightstalkerCondition and VarVendettaFontCondition) then
                return A.Vendetta:Show(icon)
            end
            -- vanish,if=talent.exsanguinate.enabled&(talent.nightstalker.enabled|talent.subterfuge.enabled&variable.single_target)&combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1&(!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier<=1)
            if A.Vanish:IsReady("player") and (A.Exsanguinate:IsSpellLearned() and (A.Nightstalker:IsSpellLearned() or A.Subterfuge:IsSpellLearned() and VarSingleUnit) and Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1 and (not A.Subterfuge:IsSpellLearned() or A.ShroudedSuffocation:GetAzeriteRank() == 0 or A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1)) then
                return A.Vanish:Show(icon)
            end
            -- vanish,if=talent.nightstalker.enabled&!talent.exsanguinate.enabled&combo_points>=cp_max_spend&debuff.vendetta.up
            if A.Vanish:IsReady("player") and (A.Nightstalker:IsSpellLearned() and not A.Exsanguinate:IsSpellLearned() and Player:ComboPoints() >= CPMaxSpend() and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
                return A.Vanish:Show(icon)
            end
            -- variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_SSBuffed_targets>=1|spell_targets.fan_of_knives=3)&(SSBuffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
            if (true) then
                VarSsVanishCondition = num(A.ShroudedSuffocation:GetAzeriteRank() > 0 and (non_SSBuffed_targets >= 1 or MultiUnits:GetByRange(10) == 3) and (SSBuffed_targets_above_pandemic == 0 or MultiUnits:GetByRange(10) >= 6))
            end
            -- pool_resource,for_next=1,extra_amount=45
            -- vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&dot.garrote.refreshable)&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
            if A.Vanish:IsReady("player") and (A.Subterfuge:IsSpellLearned() and not Player:IsStealthed() and A.Garrote:GetCooldown() == 0 and (VarSsVanishCondition or A.ShroudedSuffocation:GetAzeriteRank() == 0 and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= 5.4) and Player:ComboPointsDeficit() >= num(((1 + 2 * A.ShroudedSuffocation:GetAzeriteRank()) * MultiUnits:GetByRange(10)) > 4)) then
                if A.Vanish:IsReady("player") and Player:EnergyPredicted() >= 45 then
                    return A.Vanish:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- vanish,if=talent.master_assassin.enabled&!stealthed.all&master_assassin_remains<=0&!dot.rupture.refreshable&dot.garrote.remains>3&debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up)&(!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up)
            if A.Vanish:IsReady("player") and (A.MasterAssassin:IsSpellLearned() and not Player:IsStealthed() and MasterAssassinRemains <= 0 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4.3 and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 3 and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) and (not A.ToxicBlade:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0) and (not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true) > 0)) then
                return A.Vanish:Show(icon)
            end
            -- shadowmeld,if=!stealthed.all&azerite.shrouded_suffocation.enabled&dot.garrote.refreshable&dot.garrote.pmultiplier<=1&combo_points.deficit>=1
            if A.Shadowmeld:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not Player:IsStealthed() and A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= 5.4 and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 and Player:ComboPointsDeficit() >= 1) then
                return A.Shadowmeld:Show(icon)
            end
            -- exsanguinate,if=dot.rupture.remains>4+4*cp_max_spend&!dot.garrote.refreshable
            if A.Exsanguinate:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4 + 4 * CPMaxSpend() and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 5.4) then
                return A.Exsanguinate:Show(icon)
            end
            -- toxic_blade,if=dot.rupture.ticking&(!equipped.azsharas_font_of_power|cooldown.vendetta.remains>10)
            if A.ToxicBlade:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 0 and (not A.AzsharasFontofPower:IsExists() or A.Vendetta:GetCooldown() > 10)) then
                return A.ToxicBlade:Show(icon)
            end
            -- potion,if=buff.bloodlust.react|debuff.vendetta.up
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism() or Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
                return A.PotionofUnbridledFury:Show(icon)
            end
            -- blood_fury,if=debuff.vendetta.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=debuff.vendetta.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=debuff.vendetta.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=debuff.vendetta.up
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
                return A.AncestralCall:Show(icon)
            end
            -- use_item,name=galecallers_boon,if=cooldown.vendetta.remains>45
            if A.GalecallersBoon:IsReady(unit) and (A.Vendetta:GetCooldown() > 45) then
                return A.GalecallersBoon:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.vendetta.remains>10-4*equipped.azsharas_font_of_power|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 or Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 10 - 4 * num(A.AzsharasFontofPower:IsExists()) or Unit(unit):TimeToDie() < 20) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=master_assassin_remains=0&!debuff.vendetta.up&!debuff.toxic_blade.up&buff.memory_of_lucid_dreams.down&energy<80&dot.rupture.remains>4
            if A.CyclotronicBlast:IsReady(unit) and (MasterAssassinRemains == 0 and Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 and Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) == 0 and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) == 0 and Player:EnergyPredicted() < 80 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4) then
               return A.CyclotronicBlast:Show(icon)
            end
            -- use_item,name=lurkers_insidious_gift,if=debuff.vendetta.up
            if A.LurkersInsidiousGift:IsReady(unit) and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
               return A.LurkersInsidiousGift:Show(icon)
            end
            -- use_item,name=lustrous_golden_plumage,if=debuff.vendetta.up
            if A.LustrousGoldenPlumage:IsReady(unit) and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
                return A.LustrousGoldenPlumage:Show(icon)
            end
            -- use_item,effect_name=gladiators_medallion,if=debuff.vendetta.up
          --  if A.GladiatorsMedallion:IsReady(unit) and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
          --      return A.GladiatorsMedallion:Show(icon)
          --  end
            -- use_item,effect_name=gladiators_badge,if=debuff.vendetta.up
          --  if A.GladiatorsBadge:IsReady(unit) and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0) then
          --      return A.GladiatorsBadge:Show(icon)
          --  end
            -- use_items
        end
        
        --Direct
        local function Direct(unit)
            -- envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target)&(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)
            if A.Envenom:IsReadyByPassCastGCDP("player", true, true, nil) and 
			(
			    Player:ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and 
				(
				    Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 
					or
					Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 
					or 
					Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined 
					or 
					not VarSingleUnit				
				) 
				and (not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() > 2)
			) 
			then
                return A.Envenom:Show(icon)
            end
			
            -- variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target
            if (true) then
                VarUseFiller = Player:ComboPointsDeficit() > 1 or Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not VarSingleUnit
            end
			
            -- fan_of_knives,if=variable.use_filler&azerite.echoing_blades.enabled&spell_targets.fan_of_knives>=2
            if A.FanofKnives:IsReady(unit) and A.GetToggle(2, "AoE") and (VarUseFiller and A.EchoingBlades:GetAzeriteRank() > 0 and MultiUnits:GetByRange(10) >= 2) then
                return A.FanofKnives:Show(icon)
            end
			
            -- fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|(!priority_rotation&spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue))
			
            -- fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3
            if A.FanofKnives:IsReady(unit) and A.GetToggle(2, "AoE") then
                if Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) == 0 and (VarUseFiller and MultiUnits:GetByRange(10) >= 3) then
                    return A.FanofKnives:Show(icon) 
                end
            end
			
            -- blindside,if=variable.use_filler&(buff.blindside.up|!talent.venom_rush.enabled&!azerite.double_dose.enabled)
            if A.Blindside:IsReady(unit) and (VarUseFiller and (Unit("player"):HasBuffs(A.BlindsideBuff.ID, true) > 0 or not A.VenomRush:IsSpellLearned() and A.DoubleDose:GetAzeriteRank() == 0)) then
                return A.Blindside:Show(icon)
            end
			
            -- mutilate,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives=2
            if A.Mutilate:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) == 0 and VarUseFiller and MultiUnits:GetByRange(10) == 2 then
                    return A.Mutilate:Show(icon) 
                end
            end
			
            -- mutilate,if=variable.use_filler
            if A.Mutilate:IsReady(unit) and VarUseFiller then
                return A.Mutilate:Show(icon)
            end
        end
        
        --Dot
        local function Dot(unit)
            -- variable,name=skip_cycle_garrote,value=priority_rotation&spell_targets.fan_of_knives>3&(dot.garrote.remains<cooldown.garrote.duration|poisoned_bleeds>5)
            if (true) then
                VarSkipCycleGarrote = MultiUnits:GetByRange(10) > 3 and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 2 or PoisonedBleeds() > 5)
            end
			
            -- variable,name=skip_cycle_rupture,value=priority_rotation&spell_targets.fan_of_knives>3&(debuff.toxic_blade.up|(poisoned_bleeds>5&!azerite.scent_of_blood.enabled))
            if (true) then
                VarSkipCycleRupture = MultiUnits:GetByRange(10) > 3 and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 or (PoisonedBleeds() > 5 and A.ScentofBlood:GetAzeriteRank() == 0))
            end
			
            -- variable,name=skip_rupture,value=debuff.vendetta.up&(debuff.toxic_blade.up|master_assassin_remains>0)&dot.rupture.remains>2
            if (true) then
                VarSkipRupture = Unit(unit):HasDeBuffs(A.Vendetta.ID, true) > 0 and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 or MasterAssassinRemains > 0) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 2
            end
	
	    	-- Auto Multidot
	    	if Unit(unit):TimeToDie() > 10  
		       and Action.GetToggle(2, "AoE") and Action.GetToggle(2, "AutoDot") and not A.IsInPvP and CanMultidot
		       and (
        	    	   MissingRupture >= 1 and ActivesRupture <= 4 and Unit(unit):HasDeBuffs(A.Rupture.ID, true) > 0 and Unit(unit):HasDeBuffs(A.Garrote.ID, true) > 0 
		               or
				       A.Subterfuge:IsSpellLearned() and A.IronWire:IsSpellLearned() and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) > 0 and A.GetToggle(2, "IWSubterfuge")
				       and MissingGarrote >= 1 and Unit(unit):HasDeBuffs(A.Garrote.ID, true) > 0
			        ) 
		       and (Unit(unit):HasDeBuffs(A.Vendetta.ID, true) == 0 ) and MultiUnits:GetByRange(5) > 1 and MultiUnits:GetByRange(5) < 6
		    then
		       return A:Show(icon, ACTION_CONST_AUTOTARGET)
		    end
	
            -- rupture,if=talent.exsanguinate.enabled&((combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1)|(!ticking&(time>10|combo_points>=2)))
            if A.Rupture:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and ((Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1) or (Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) == 0 and (Unit("player"):CombatTime() > 10 or Player:ComboPoints() >= 2)))) then
                return A.Rupture:Show(icon)
            end
			
            -- pool_resource,for_next=1
            -- garrote,if=(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!SSBuffed&(target.time_to_die-remains)>4&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) and 
			(
			    (
				    not A.Subterfuge:IsSpellLearned() 
					or 
					not (A.Vanish:GetCooldown() == 0 and A.Vendetta:GetCooldown() <= 4)
				) 
				and Player:ComboPointsDeficit() >= 1 + 3 * num((A.ShroudedSuffocation:GetAzeriteRank() > 0 and A.Vanish:GetCooldown() == 0)) 
				and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= 5.4 and 
				(
				    A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 
					or 
					Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= GarroteTickTime 
					and 
					MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()
				) 
				and 
				    (
					    not Exsanguinated(Unit(unit), "Garrote") 
						or
						Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= GarroteTickTime * 2 
						and 
						MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()
					) 
				and not SSBuffed and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true)) > 4 
				and (MasterAssassinRemains == 0 or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) == 0 and A.ShroudedSuffocation:GetAzeriteRank() > 0)
			)
			then
                if A.Garrote:IsReady(unit) and Player:EnergyPredicted() >= A.Garrote:GetSpellPowerCostCache() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
			
            -- pool_resource,for_next=1
            -- garrote,cycle_targets=1,if=!variable.skip_cycle_garrote&target!=self.target&(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!SSBuffed&(target.time_to_die-remains)>12&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
           -- if A.Garrote:IsReady(unit) then
           --     if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateCycleGarrote408) then
           --         return A.Garrote:Show(icon) 
           --     end
           -- end
		   
            -- crimson_tempest,if=spell_targets>=2&remains<2+(spell_targets>=5)&combo_points>=4
            if A.CrimsonTempest:IsReady("player") and 
			(
			    MultiUnits:GetByRange(10) >= 2 and Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) < 3 and Player:ComboPoints() >= 4
			)
			then
                return A.CrimsonTempest:Show(icon)
            end
			
            -- rupture,if=!variable.skip_rupture&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
            if A.Rupture:IsReady(unit) and 
			(
			    not VarSkipRupture and Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) < 5.2 and 
				(
				    A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 
					or 
					Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= RuptureTickTime and MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()
				) 
				and 
				(
				    not Exsanguinated(Unit(unit), "Rupture") 
					or 
					Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= RuptureTickTime * 2 and MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()
				)
				and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4
			)
			then
                return A.Rupture:Show(icon)
            end
			
            -- rupture,cycle_targets=1,if=!variable.skip_cycle_rupture&!variable.skip_rupture&target!=self.target&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
           -- if A.Rupture:IsReady(unit) then
           --     if not VarSkipCycleRupture and not VarSkipRupture and Unit(unit) ~= self.target and Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) < 5.2 and (A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= RuptureTickTime and MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= RuptureTickTime * 2 and MultiUnits:GetByRange(10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4 then
          --          return A.Rupture:Show(icon) 
           --     end
           -- end
        end
                
        --Stealthed
        local function Stealthed(unit)
            -- rupture,if=combo_points>=4&(talent.nightstalker.enabled|talent.subterfuge.enabled&(talent.exsanguinate.enabled&cooldown.exsanguinate.remains<=2|!ticking)&variable.single_target)&target.time_to_die-remains>6
            if A.Rupture:IsReady(unit) and (Player:ComboPoints() >= 4 and (A.Nightstalker:IsSpellLearned() or A.Subterfuge:IsSpellLearned() and (A.Exsanguinate:IsSpellLearned() and A.Exsanguinate:GetCooldown() <= 2 or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) == 0) and VarSingleUnit) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 6) then
                return A.Rupture:Show(icon)
            end
			
            -- pool_resource,for_next=1
            -- garrote,if=azerite.shrouded_suffocation.enabled&buff.subterfuge.up&buff.subterfuge.remains<1.3&!SSBuffed
            if A.Garrote:IsReady(unit) and (A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.SubterfugeBuff.ID, true) < 1.3 and not SSBuffed) then
                if A.Garrote:IsReady(unit) and Player:EnergyPredicted() >= A.Garrote:GetSpellPowerCostCache() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
			
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&(remains<12|pmultiplier<=1)&target.time_to_die-remains>2
            if A.Garrote:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 0 and A.Subterfuge:IsSpellLearned() and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 12 or A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 2 then 
                    return A.Garrote:Show(icon) 
                end
            end
			
            -- rupture,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&!dot.rupture.ticking&variable.single_target
            if A.Rupture:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) == 0 and VarSingleUnit) then
                return A.Rupture:Show(icon)
            end
			
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&target.time_to_die>remains&(remains<18|!SSBuffed)
            if A.Garrote:IsReady(unit) then
                if Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 0 and A.Subterfuge:IsSpellLearned() and A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit(unit):TimeToDie() > Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and (Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) < 18 or not SSBuffed) then 
                    return A.Garrote:Show(icon) 
                end
            end
			
            -- pool_resource,for_next=1
            -- garrote,if=talent.subterfuge.enabled&talent.exsanguinate.enabled&cooldown.exsanguinate.remains<1&prev_gcd.1.rupture&dot.rupture.remains>5+4*cp_max_spend
            if A.Garrote:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.Exsanguinate:IsSpellLearned() and A.Exsanguinate:GetCooldown() < 1 and Unit("player"):GetSpellLastCast(A.Rupture) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 5 + 4 * CPMaxSpend()) then
                if A.Garrote:IsReady(unit) and Player:EnergyPredicted() >= A.Garrote:GetSpellPowerCostCache() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
			
        end
        
        
        -- call precombat
        if not inCombat and Precombat(unit) and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
            -- stealth
            if A.Stealth:IsReady(unit) then
                return A.Stealth:Show(icon)
            end
			
            -- variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*7%(2*spell_haste)
            if (true) then
                VarEnergyRegenCombined = Player:EnergyRegen() + PoisonedBleeds() * 7 / (2 * Player:SpellHaste())
            end
			
            -- variable,name=single_target,value=spell_targets.fan_of_knives<2
            if (true) then
                VarSingleUnit = MultiUnits:GetByRange(6) < 2
            end

	        -- Sprint if out of range 
            if A.Sprint:IsReady("player") and isMovingFor > A.GetToggle(2, "SprintTime") and A.GetToggle(2, "UseSprint") then
                return A.Sprint:Show(icon)
            end
			
            -- call_action_list,name=stealthed,if=stealthed.rogue
            if Stealthed(unit) and Player:IsStealthed() then
                return true
            end
			
            -- call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)
            if Cds(unit) and (not A.MasterAssassin:IsSpellLearned() or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 0) then
                return true
            end

		    -- Kidney Shot on enemies with burst damage buff or if our friend healer is cc
            if A.IsInPvP and A.KidneyShot:IsReady(unit) and CanCast and inMelee and Player:ComboPoints() >= 4 and Unit(unit):IsControlAble("stun", 25) and Unit(unit):HasBuffs("DamageBuffs") > 0 then
   		    	-- Notification					
                Action.SendNotification("Defensive Kidney Shot on : " .. UnitName(unit), A.KidneyShot.ID)
		    	return A.KidneyShot:Show(icon)
            end	
       
	       -- 'Full' Kidney Shot
		    if A.IsInPvP and A.KidneyShot:IsReady(unit) and CanCast and Unit(unit):HealthPercent() <= 70 and Player:ComboPoints() >= 4 and A.KidneyShot:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("stun", 0) then 
                return A.KidneyShot:Show(icon)              
            end
				
		    -- Neuro
		    if A.IsInPvP and A.Neuro:IsSpellLearned() and CanCast and A.Neuro:IsReady(unit) and inMelee and Unit(unit):HealthPercent() <= 75 and not Player:IsStealthed() then
		    	return A.Neuro:Show(icon)
		    end
		
		    -- Shiv
		    if A.IsInPvP and A.Shiv:IsSpellLearned() and CanCast and A.Shiv:IsReady(unit) and inMelee and Unit(unit):HealthPercent() <= 50 and Action.AbsentImun(unit, "DamagePhysImun", true) and A.Shiv:IsReady(unit) and not Unit(unit):InCC()  then
		    	return A.Shiv:Show(icon)
   		    end
		
            -- Death From Above
		    if A.IsInPvP and A.DFA:IsSpellLearned() and CanCast and A.DFA:IsReady(unit) and Unit(unit):HealthPercent() <= 70 and Player:ComboPoints() >= 5 and Unit(unit):GetRange() <= 15 and Action.AbsentImun("target", "DamagePhysImun", true) then
		    	return A.DFA:Show(icon)
   	        end		

		    -- Mouseover KidneyShot on enemy trying to leave with less than 30% HP
            if unit ~= "mouseover" and CanCast and Player:ComboPoints() >= 4 and Unit(unit):HealthPercent() <= 30 and  Unit(unit):GetRange() <= 5 and (A.IsInPvP or (not Unit(unit):IsBoss() and Unit(unit):IsMovingOut())) and A.KidneyShot:IsReady(unit) and A.KidneyShot:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"}, true) and Unit(unit):GetMaxSpeed() >= 100 and Unit(unit):HasDeBuffs("Slowed") == 0 and not Unit(unit):IsTotem() then 
                return A.KidneyShot:Show(icon)
            end	
			
            -- call_action_list,name=dot
            if Dot(unit) then
                return true
            end
			
            -- call_action_list,name=direct
            if Direct(unit) then
                return true
            end
			
            -- arcane_torrent,if=energy.deficit>=15+variable.energy_regen_combined
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:EnergyDeficitPredicted() >= 15 + VarEnergyRegenCombined) then
                return A.ArcaneTorrent:Show(icon)
            end
			
            -- arcane_pulse
            if A.ArcanePulse:AutoRacial(unit) and Action.GetToggle(1, "Racial") then
                return A.ArcanePulse:Show(icon)
            end
			
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) then
                return A.BagofTricks:Show(icon)
            end
			
        end
    end

    -- End on EnemyRotation()

	-- RefreshPoisons
    local RefreshPoisons = RefreshPoisons()
    if RefreshPoisons then 
        -- Notification					
        Action.SendNotification("Auto refreshing poisons", A.CripplingPoison.ID)
        return RefreshPoisons:Show(icon)
    end 
		    
    -- Stealth out of combat
	local CurrentStealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth -- w/ or w/o Subterfuge Talent		
    if not inCombat and Unit("player"):HasBuffs(A.VanishBuff.ID, true) == 0 and Action.GetToggle(2, "StealthOOC") and not Unit("player"):HasFlags() and CurrentStealth:IsReady("player") and Unit("player"):HasBuffs(CurrentStealth.ID, true) == 0 then
        -- Notification					
        Action.SendNotification("Auto Stealthing", A.Stealth.ID)
        return CurrentStealth:Show(icon)
    end    

    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 

    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 

    end
end
-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
--[[local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end]]--

