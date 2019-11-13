--- ====================== ACTION HEADER ============================ ---
local Action                                 = Action
local TeamCache                              = Action.TeamCache
local EnemyTeam                              = Action.EnemyTeam
local FriendlyTeam                           = Action.FriendlyTeam
--local HealingEngine                        = Action.HealingEngine
local LoC                                    = Action.LossOfControl
local Player                                 = Action.Player
local MultiUnits                             = Action.MultiUnits
local UnitCooldown                           = Action.UnitCooldown
local Unit                                   = Action.Unit
local Pet                                    = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local setmetatable                           = setmetatable

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARLOCK_AFFLICTION] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    SummonPet                              = Action.Create({ Type = "Spell", ID = 691 }),
    GrimoireofSacrificeBuff                = Action.Create({ Type = "Spell", ID = 196099 }),
    GrimoireofSacrifice                    = Action.Create({ Type = "Spell", ID = 108503 }),
    SeedofCorruptionDebuff                 = Action.Create({ Type = "Spell", ID = 27243 }),
    SeedofCorruption                       = Action.Create({ Type = "Spell", ID = 27243 }),
    HauntDebuff                            = Action.Create({ Type = "Spell", ID = 48181 }),
    Haunt                                  = Action.Create({ Type = "Spell", ID = 48181 }),
    ShadowBolt                             = Action.Create({ Type = "Spell", ID = 232670 }),
    DarkSoulMisery                         = Action.Create({ Type = "Spell", ID = 113860 }),
    SummonDarkglare                        = Action.Create({ Type = "Spell", ID = 205180 }),
    DarkSoul                               = Action.Create({ Type = "Spell", ID = 113860 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    SiphonLife                             = Action.Create({ Type = "Spell", ID = 63106 }),
    SiphonLifeDebuff                       = Action.Create({ Type = "Spell", ID = 63106 }),
    AgonyDebuff                            = Action.Create({ Type = "Spell", ID = 980 }),
    CorruptionDebuff                       = Action.Create({ Type = "Spell", ID = 146739 }),
    Agony                                  = Action.Create({ Type = "Spell", ID = 980 }),
    Corruption                             = Action.Create({ Type = "Spell", ID = 172 }),
    CreepingDeath                          = Action.Create({ Type = "Spell", ID = 264000 }),
    WritheInAgony                          = Action.Create({ Type = "Spell", ID = 196102 }),
    PandemicInvocation                     = Action.Create({ Type = "Spell", ID = 289364 }),
    UnstableAffliction                     = Action.Create({ Type = "Spell", ID = 30108 }),
    UnstableAfflictionDebuff               = Action.Create({ Type = "Spell", ID = 30108 }),
    Deathbolt                              = Action.Create({ Type = "Spell", ID = 264106 }),
    NightfallBuff                          = Action.Create({ Type = "Spell", ID = 264571 }),
    AbsoluteCorruption                     = Action.Create({ Type = "Spell", ID = 196103 }),
    DrainLife                              = Action.Create({ Type = "Spell", ID = 234153 }),
    InevitableDemiseBuff                   = Action.Create({ Type = "Spell", ID = 273525 }),
    PhantomSingularity                     = Action.Create({ Type = "Spell", ID = 205179 }),
    VileTaint                              = Action.Create({ Type = "Spell", ID = 278350 }),
    DrainSoul                              = Action.Create({ Type = "Spell", ID = 198590 }),
    ShadowEmbraceDebuff                    = Action.Create({ Type = "Spell", ID = 32390 }),
    ShadowEmbrace                          = Action.Create({ Type = "Spell", ID = 32388 }),
    CascadingCalamity                      = Action.Create({ Type = "Spell", ID = 275372 }),
    CascadingCalamityBuff                  = Action.Create({ Type = "Spell", ID = 275378 }),
    SowtheSeeds                            = Action.Create({ Type = "Spell", ID = 196226 }),
    ActiveUasBuff                          = Action.Create({ Type = "Spell", ID = 233490 }),
    PhantomSingularityDebuff               = Action.Create({ Type = "Spell", ID = 205179 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 })
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
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
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
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARLOCK_AFFLICTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_AFFLICTION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarMaintainSe = 0;
local VarUseSeed = 0;
local VarPadding = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarMaintainSe = 0
  VarUseSeed = 0
  VarPadding = 0
end)



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

-- Used for VisionofPerfectionMinor check
local function DetermineEssenceRanks()
    A.VisionofPerfectionMinor = A.VisionofPerfectionMinor2:IsSpellLearned() and A.VisionofPerfectionMinor2 or A.VisionofPerfectionMinor
    A.VisionofPerfectionMinor = A.VisionofPerfectionMinor3:IsSpellLearned() and A.VisionofPerfectionMinor3 or A.VisionofPerfectionMinor
end
DetermineEssenceRanks = A.MakeFunctionCachedStatic(DetermineEssenceRanks)

-- Pet Handler UI --
local function HandlePetChoice()
    local choice = Action.GetToggle(2, "PetChoice")
    local currentspell = "Spell(688)"
    
    if choice == "IMP" then
        --print("IMP")
        currentspell = "Spell(688)"    
    elseif choice == "VOIDWALKER" then
        --print("VOIDWALKER")
        currentspell = "Spell(697)"
    elseif choice == "FELHUNTER" then 
        --print("FELHUNTER")    
        currentspell = "Spell(691)"
    elseif choice == "SUCCUBUS" then 
        --print("SUCCUBUS")    
        currentspell = "Spell(712)"
    else
        print("No Pet Data")
    end
    return choice
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
		if Player:InDungeon() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if Player:InPvP() then 
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

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

Action.Enum.SpellDuration = {
    -- SiphonLife  
    [63106] = {15000, 19500},
    -- Agony
    [980] = {18000, 23400},
    --Corruption
    [146739] = {14000, 18200},
    -- Darkglare
    [205180] = {20000, 26000},

}

-- Base Duration of a dot/hot/channel...
local SpellDuration = Action.Enum.SpellDuration
function A:BaseDuration()
    local Duration = SpellDuration[self.SpellID]
    if not Duration or Duration == 0 then 
	    return 0 
	end
    local BaseDuration = Duration[1]
    return BaseDuration / 1000
end

-- Pandemic Threshold
function A:PandemicThreshold()
    local BaseDuration = self:BaseDuration()
    if not BaseDuration or BaseDuration == 0 then 
	    return 0 
    end
    return BaseDuration * 0.3
end

local UnstableAfflictionDebuffs = {
  [1] = 233490,
  [2] = 233496,
  [3] = 233497,
  [4] = 233498,
  [5] = 233499
};

local function ActiveUAs(unit)
  local UACount = 0
  for i = 1, #UnstableAfflictionDebuffs do
    if Unit(unit):HasDeBuffsStacks(UnstableAfflictionDebuffs[i], true, true) > 0 then 
	    UACount = UACount + 1 
	end
  end
  return UACount
end

local function Contagion(unit)
    local MaximumDuration = 0
    for i = 1, #UnstableAfflictionDebuffs do
        local UARemains = Unit(unit):HasDeBuffs(UnstableAfflictionDebuffs[i], true, true)
        if UARemains > MaximumDuration then
            MaximumDuration = UARemains
        end
    end
    return MaximumDuration
end

-- Agony TickTime 
local function AgonyTickTime()
    local BaseTickTime = 2
    local Hasted = true
    if Hasted then
        return BaseTickTime * Player:SpellHaste() 
	end
    return BaseTickTime
end

-- "time.to.shard"
local function TimeToShard()
    local ActiveAgony = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.AgonyDebuff.ID)
    if ActiveAgony == 0 then
        return 10000 
    end
    return 1 / (0.16 / math.sqrt(ActiveAgony) * (ActiveAgony == 1 and 1.15 or 1) * ActiveAgony / AgonyTickTime())
end




local function EvaluateTargetIfFilterAgony140(unit)
  return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony181(unit)
  return A.CreepingDeath:IsSpellLearned() and A.AgonyDebuff.ID, true:ActiveDot < 6 and Unit(unit):TimeToDie() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < 5 or not bool(A.PandemicInvocation:GetAzeriteRank()) and Unit(unit):HasDeBuffsRefreshable(A.AgonyDebuff.ID, true)))
end


local function EvaluateTargetIfFilterAgony187(unit)
  return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony228(unit)
  return not A.CreepingDeath:IsSpellLearned() and A.AgonyDebuff.ID, true:ActiveDot < 8 and Unit(unit):TimeToDie() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < 5 or not bool(A.PandemicInvocation:GetAzeriteRank()) and Unit(unit):HasDeBuffsRefreshable(A.AgonyDebuff.ID, true)))
end


local function EvaluateTargetIfFilterSiphonLife234(unit)
  return Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true)
end

local function EvaluateTargetIfSiphonLife273(unit)
  return (A.SiphonLifeDebuff.ID, true:ActiveDot < 8 - num(A.CreepingDeath:IsSpellLearned()) - MultiUnits:GetByRangeInCombat(5, 5, 10)) and Unit(unit):TimeToDie() > 10 and Unit(unit):HasDeBuffsRefreshable(A.SiphonLifeDebuff.ID, true) and (not bool(Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true)) and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 or A.SummonDarkglare:GetCooldown() > Player:SoulShardsP * A.UnstableAffliction:GetSpellCastTime())
end


local function EvaluateCycleCorruption280(unit)
  return MultiUnits:GetByRangeInCombat(5, 5, 10) < 3 + raid_event.invulnerable.up + num(A.WritheInAgony:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and Unit(unit):HasDeBuffsRefreshable(A.CorruptionDebuff.ID, true)) and Unit(unit):TimeToDie() > 10
end

local function EvaluateCycleDrainSoul447(unit)
  return Unit(unit):TimeToDie() <= A.GetGCD()
end

local function EvaluateTargetIfFilterDrainSoul453(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul466(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and not bool(Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true))
end


local function EvaluateTargetIfFilterDrainSoul472(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul483(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe)
end


local function EvaluateCycleShadowBolt492(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and not bool(Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)) and not A.ShadowBolt:IsSpellInFlight()
end

local function EvaluateTargetIfFilterShadowBolt508(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfShadowBolt519(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe)
end


local function EvaluateCycleUnstableAffliction606(unit)
  return not bool(VarUseSeed) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() > time_to_shard or Player:SoulShardsP > 1) and (not A.VileTaint:IsSpellLearned() or Player:SoulShardsP > 1) and contagion <= A.UnstableAffliction:GetSpellCastTime() + VarPadding and (not bool(A.CascadingCalamity:GetAzeriteRank()) or Unit("player"):HasBuffs(A.CascadingCalamityBuff.ID, true) > time_to_shard)
end

local function EvaluateCycleDrainSoul677(unit)
  return Unit(unit):TimeToDie() <= A.GetGCD() and Player:SoulShardsP < 5
end

local function EvaluateTargetIfFilterAgony707(unit)
  return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony724(unit)
  return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() + A.ShadowBolt:GetSpellCastTime() and Unit(unit):TimeToDie() > 8
end


local function EvaluateCycleUnstableAffliction731(unit)
    return not bool(contagion) and Unit(unit):TimeToDie() <= 8
end

local function EvaluateTargetIfFilterDrainSoul737(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul752(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and bool(Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) <= A.GetGCD() * 2
end


local function EvaluateTargetIfFilterShadowBolt758(unit)
  return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfShadowBolt785(unit)
  return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and bool(Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) <= A.ShadowBolt:GetSpellCastTime() * 2 + A.ShadowBolt:TravelTime() and not A.ShadowBolt:IsSpellInFlight()
end


local function EvaluateTargetIfFilterPhantomSingularity791(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfPhantomSingularity794(unit)
  return Unit("player"):CombatTime() > 35 and Unit(unit):TimeToDie() > 16 * Unit("player"):SpellHaste
end


local function EvaluateTargetIfFilterVileTaint800(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfVileTaint803(unit)
  return Unit("player"):CombatTime() > 15 and Unit(unit):TimeToDie() >= 10
end


local function EvaluateTargetIfFilterUnstableAffliction809(unit)
  return min:contagion
end

local function EvaluateTargetIfUnstableAffliction814(unit)
  return not bool(VarUseSeed) and Player:SoulShardsP == 5
end

      local CanMultidot = HandleMultidots()
      local unit = "player"
      local time_to_shard = TimeToShard()
      local PredictSpells = A.GetToggle(2, "PredictSpells")
      DetermineEssenceRanks()
              --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- summon_pet
            if A.SummonPet:IsReady(unit) then
                return A.SummonPet:Show(icon)
            end
            -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
            if A.GrimoireofSacrifice:IsReady(unit) and Unit("player"):HasBuffsDown(A.GrimoireofSacrificeBuff.ID, true) and (A.GrimoireofSacrifice:IsSpellLearned()) then
                return A.GrimoireofSacrifice:Show(icon)
            end
            -- snapshot_stats
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- seed_of_corruption,if=spell_targets.seed_of_corruption_aoe>=3
            if A.SeedofCorruption:IsReady(unit) and Unit("player"):HasDebuffsDown(A.SeedofCorruptionDebuff.ID, true) and (MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3) then
                return A.SeedofCorruption:Show(icon)
            end
            -- haunt
            if A.Haunt:IsReady(unit) and Unit("player"):HasDebuffsDown(A.HauntDebuff.ID, true) then
                return A.Haunt:Show(icon)
            end
            -- shadow_bolt,if=!talent.haunt.enabled&spell_targets.seed_of_corruption_aoe<3
            if A.ShadowBolt:IsReady(unit) and (not A.Haunt:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) < 3) then
                return A.ShadowBolt:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- potion,if=(talent.dark_soul_misery.enabled&cooldown.summon_darkglare.up&cooldown.dark_soul.up)|cooldown.summon_darkglare.up|target.time_to_die<30
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and ((A.DarkSoulMisery:IsSpellLearned() and A.SummonDarkglare:GetCooldown() == 0 and A.DarkSoul:GetCooldown() == 0) or A.SummonDarkglare:GetCooldown() == 0 or Unit(unit):TimeToDie() < 30) then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- use_items,if=!cooldown.summon_darkglare.up,if=cooldown.summon_darkglare.remains>70|time_to_die<20|((buff.active_uas.stack=5|soul_shard=0)&(!talent.phantom_singularity.enabled|cooldown.phantom_singularity.remains)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=gcd|!cooldown.deathbolt.remains)&!cooldown.summon_darkglare.remains)
            -- fireblood,if=!cooldown.summon_darkglare.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.SummonDarkglare:GetCooldown() == 0) then
                return A.Fireblood:Show(icon)
            end
            -- blood_fury,if=!cooldown.summon_darkglare.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.SummonDarkglare:GetCooldown() == 0) then
                return A.BloodFury:Show(icon)
            end
        end
        
        --DbRefresh
        local function DbRefresh(unit)
            -- siphon_life,line_cd=15,if=(dot.siphon_life.remains%dot.siphon_life.duration)<=(dot.agony.remains%dot.agony.duration)&(dot.siphon_life.remains%dot.siphon_life.duration)<=(dot.corruption.remains%dot.corruption.duration)&dot.siphon_life.remains<dot.siphon_life.duration*1.3
            if A.SiphonLife:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) / A.SiphonLifeDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) / A.AgonyDebuff.ID, true:BaseDuration()) and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) / A.SiphonLifeDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) / A.CorruptionDebuff.ID, true:BaseDuration()) and Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) < A.SiphonLifeDebuff.ID, true:BaseDuration() * 1.3) then
                return A.SiphonLife:Show(icon)
            end
            -- agony,line_cd=15,if=(dot.agony.remains%dot.agony.duration)<=(dot.corruption.remains%dot.corruption.duration)&(dot.agony.remains%dot.agony.duration)<=(dot.siphon_life.remains%dot.siphon_life.duration)&dot.agony.remains<dot.agony.duration*1.3
            if A.Agony:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) / A.AgonyDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) / A.CorruptionDebuff.ID, true:BaseDuration()) and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) / A.AgonyDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) / A.SiphonLifeDebuff.ID, true:BaseDuration()) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < A.AgonyDebuff.ID, true:BaseDuration() * 1.3) then
                return A.Agony:Show(icon)
            end
            -- corruption,line_cd=15,if=(dot.corruption.remains%dot.corruption.duration)<=(dot.agony.remains%dot.agony.duration)&(dot.corruption.remains%dot.corruption.duration)<=(dot.siphon_life.remains%dot.siphon_life.duration)&dot.corruption.remains<dot.corruption.duration*1.3
            if A.Corruption:IsReady(unit) and ((Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) / A.CorruptionDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) / A.AgonyDebuff.ID, true:BaseDuration()) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) / A.CorruptionDebuff.ID, true:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) / A.SiphonLifeDebuff.ID, true:BaseDuration()) and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) < A.CorruptionDebuff.ID, true:BaseDuration() * 1.3) then
                return A.Corruption:Show(icon)
            end
        end
        
        --Dots
        local function Dots(unit)
            -- seed_of_corruption,if=dot.corruption.remains<=action.seed_of_corruption.cast_time+time_to_shard+4.2*(1-talent.creeping_death.enabled*0.15)&spell_targets.seed_of_corruption_aoe>=3+raid_event.invulnerable.up+talent.writhe_in_agony.enabled&!dot.seed_of_corruption.remains&!action.seed_of_corruption.in_flight
            if A.SeedofCorruption:IsReady(unit) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) <= A.SeedofCorruption:GetSpellCastTime() + time_to_shard + 4.2 * (1 - num(A.CreepingDeath:IsSpellLearned()) * 0.15) and MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3 + raid_event.invulnerable.up + num(A.WritheInAgony:IsSpellLearned()) and not bool(Unit(unit):HasDeBuffs(A.SeedofCorruptionDebuff.ID, true)) and not A.SeedofCorruption:IsSpellInFlight()) then
                return A.SeedofCorruption:Show(icon)
            end
            -- agony,target_if=min:remains,if=talent.creeping_death.enabled&active_dot.agony<6&target.time_to_die>10&(remains<=gcd|cooldown.summon_darkglare.remains>10&(remains<5|!azerite.pandemic_invocation.rank&refreshable))
            if A.Agony:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Agony, 40, "min", EvaluateTargetIfFilterAgony140, EvaluateTargetIfAgony181) then 
                    return A.Agony:Show(icon) 
                end
            end
            -- agony,target_if=min:remains,if=!talent.creeping_death.enabled&active_dot.agony<8&target.time_to_die>10&(remains<=gcd|cooldown.summon_darkglare.remains>10&(remains<5|!azerite.pandemic_invocation.rank&refreshable))
            if A.Agony:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Agony, 40, "min", EvaluateTargetIfFilterAgony187, EvaluateTargetIfAgony228) then 
                    return A.Agony:Show(icon) 
                end
            end
            -- siphon_life,target_if=min:remains,if=(active_dot.siphon_life<8-talent.creeping_death.enabled-spell_targets.sow_the_seeds_aoe)&target.time_to_die>10&refreshable&(!remains&spell_targets.seed_of_corruption_aoe=1|cooldown.summon_darkglare.remains>soul_shard*action.unstable_affliction.execute_time)
            if A.SiphonLife:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SiphonLife, 40, "min", EvaluateTargetIfFilterSiphonLife234, EvaluateTargetIfSiphonLife273) then 
                    return A.SiphonLife:Show(icon) 
                end
            end
            -- corruption,cycle_targets=1,if=spell_targets.seed_of_corruption_aoe<3+raid_event.invulnerable.up+talent.writhe_in_agony.enabled&(remains<=gcd|cooldown.summon_darkglare.remains>10&refreshable)&target.time_to_die>10
            if A.Corruption:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Corruption, 40, EvaluateCycleCorruption280) then
                    return A.Corruption:Show(icon) 
                end
            end
        end
        
        --Fillers
        local function Fillers(unit)
            -- unstable_affliction,line_cd=15,if=cooldown.deathbolt.remains<=gcd*2&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&cooldown.summon_darkglare.remains>20
            if A.UnstableAffliction:IsReady(unit) and (A.Deathbolt:GetCooldown() <= A.GetGCD() * 2 and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 + raid_event.invulnerable.up and A.SummonDarkglare:GetCooldown() > 20) then
                return A.UnstableAffliction:Show(icon)
            end
            -- call_action_list,name=db_refresh,if=talent.deathbolt.enabled&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&(dot.agony.remains<dot.agony.duration*0.75|dot.corruption.remains<dot.corruption.duration*0.75|dot.siphon_life.remains<dot.siphon_life.duration*0.75)&cooldown.deathbolt.remains<=action.agony.gcd*4&cooldown.summon_darkglare.remains>20
            if (A.Deathbolt:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 + raid_event.invulnerable.up and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < A.AgonyDebuff.ID, true:BaseDuration() * 0.75 or Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) < A.CorruptionDebuff.ID, true:BaseDuration() * 0.75 or Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) < A.SiphonLifeDebuff.ID, true:BaseDuration() * 0.75) and A.Deathbolt:GetCooldown() <= action.agony.gcd * 4 and A.SummonDarkglare:GetCooldown() > 20) then
                local ShouldReturn = DbRefresh(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=db_refresh,if=talent.deathbolt.enabled&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&cooldown.summon_darkglare.remains<=soul_shard*action.agony.gcd+action.agony.gcd*3&(dot.agony.remains<dot.agony.duration*1|dot.corruption.remains<dot.corruption.duration*1|dot.siphon_life.remains<dot.siphon_life.duration*1)
            if (A.Deathbolt:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 + raid_event.invulnerable.up and A.SummonDarkglare:GetCooldown() <= Player:SoulShardsP * action.agony.gcd + action.agony.gcd * 3 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < A.AgonyDebuff.ID, true:BaseDuration() * 1 or Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) < A.CorruptionDebuff.ID, true:BaseDuration() * 1 or Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) < A.SiphonLifeDebuff.ID, true:BaseDuration() * 1)) then
                local ShouldReturn = DbRefresh(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- deathbolt,if=cooldown.summon_darkglare.remains>=30+gcd|cooldown.summon_darkglare.remains>140
            if A.Deathbolt:IsReady(unit) and (A.SummonDarkglare:GetCooldown() >= 30 + A.GetGCD() or A.SummonDarkglare:GetCooldown() > 140) then
                return A.Deathbolt:Show(icon)
            end
            -- shadow_bolt,if=buff.movement.up&buff.nightfall.remains
            if A.ShadowBolt:IsReady(unit) and (Unit("player"):IsMoving and bool(Unit("player"):HasBuffs(A.NightfallBuff.ID, true))) then
                return A.ShadowBolt:Show(icon)
            end
            -- agony,if=buff.movement.up&!(talent.siphon_life.enabled&(prev_gcd.1.agony&prev_gcd.2.agony&prev_gcd.3.agony)|prev_gcd.1.agony)
            if A.Agony:IsReady(unit) and (Unit("player"):IsMoving and not (A.SiphonLife:IsSpellLearned() and (Unit("player"):GetSpellLastCast(A.Agony) and Unit("player"):GetSpellLastCast(A.Agony) and Unit("player"):GetSpellLastCast(A.Agony)) or Unit("player"):GetSpellLastCast(A.Agony))) then
                return A.Agony:Show(icon)
            end
            -- siphon_life,if=buff.movement.up&!(prev_gcd.1.siphon_life&prev_gcd.2.siphon_life&prev_gcd.3.siphon_life)
            if A.SiphonLife:IsReady(unit) and (Unit("player"):IsMoving and not (Unit("player"):GetSpellLastCast(A.SiphonLife) and Unit("player"):GetSpellLastCast(A.SiphonLife) and Unit("player"):GetSpellLastCast(A.SiphonLife))) then
                return A.SiphonLife:Show(icon)
            end
            -- corruption,if=buff.movement.up&!prev_gcd.1.corruption&!talent.absolute_corruption.enabled
            if A.Corruption:IsReady(unit) and (Unit("player"):IsMoving and not Unit("player"):GetSpellLastCast(A.Corruption) and not A.AbsoluteCorruption:IsSpellLearned()) then
                return A.Corruption:Show(icon)
            end
            -- drain_life,if=(buff.inevitable_demise.stack>=40-(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>2)*20&(cooldown.deathbolt.remains>execute_time|!talent.deathbolt.enabled)&(cooldown.phantom_singularity.remains>execute_time|!talent.phantom_singularity.enabled)&(cooldown.dark_soul.remains>execute_time|!talent.dark_soul_misery.enabled)&(cooldown.vile_taint.remains>execute_time|!talent.vile_taint.enabled)&cooldown.summon_darkglare.remains>execute_time+10|buff.inevitable_demise.stack>10&target.time_to_die<=10)
            if A.DrainLife:IsReady(unit) and A.BurstIsON(unit) and ((Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) >= 40 - num((MultiUnits:GetByRangeInCombat(5, 5, 10) - raid_event.invulnerable.up > 2)) * 20 and (A.Deathbolt:GetCooldown() > A.DrainLife:GetSpellCastTime() or not A.Deathbolt:IsSpellLearned()) and (A.PhantomSingularity:GetCooldown() > A.DrainLife:GetSpellCastTime() or not A.PhantomSingularity:IsSpellLearned()) and (A.DarkSoul:GetCooldown() > A.DrainLife:GetSpellCastTime() or not A.DarkSoulMisery:IsSpellLearned()) and (A.VileTaint:GetCooldown() > A.DrainLife:GetSpellCastTime() or not A.VileTaint:IsSpellLearned()) and A.SummonDarkglare:GetCooldown() > A.DrainLife:GetSpellCastTime() + 10 or Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) > 10 and Unit(unit):TimeToDie() <= 10)) then
                return A.DrainLife:Show(icon)
            end
            -- haunt
            if A.Haunt:IsReady(unit) then
                return A.Haunt:Show(icon)
            end
            -- drain_soul,interrupt_global=1,chain=1,interrupt=1,cycle_targets=1,if=target.time_to_die<=gcd
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, EvaluateCycleDrainSoul447) then
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&variable.maintain_se&!debuff.shadow_embrace.remains
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul453, EvaluateTargetIfDrainSoul466) then 
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&variable.maintain_se
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul472, EvaluateTargetIfDrainSoul483) then 
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- drain_soul,interrupt_global=1,chain=1,interrupt=1
            if A.DrainSoul:IsReady(unit) then
                return A.DrainSoul:Show(icon)
            end
            -- shadow_bolt,cycle_targets=1,if=talent.shadow_embrace.enabled&variable.maintain_se&!debuff.shadow_embrace.remains&!action.shadow_bolt.in_flight
            if A.ShadowBolt:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowBolt, 40, EvaluateCycleShadowBolt492) then
                    return A.ShadowBolt:Show(icon) 
                end
            end
            -- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se
            if A.ShadowBolt:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowBolt, 40, "min", EvaluateTargetIfFilterShadowBolt508, EvaluateTargetIfShadowBolt519) then 
                    return A.ShadowBolt:Show(icon) 
                end
            end
            -- shadow_bolt
            if A.ShadowBolt:IsReady(unit) then
                return A.ShadowBolt:Show(icon)
            end
        end
        
        --Spenders
        local function Spenders(unit)
            -- unstable_affliction,if=cooldown.summon_darkglare.remains<=soul_shard*execute_time&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=soul_shard*execute_time)
            if A.UnstableAffliction:IsReady(unit) and (A.SummonDarkglare:GetCooldown() <= Player:SoulShardsP * A.UnstableAffliction:GetSpellCastTime() and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() <= Player:SoulShardsP * A.UnstableAffliction:GetSpellCastTime())) then
                return A.UnstableAffliction:Show(icon)
            end
            -- call_action_list,name=fillers,if=(cooldown.summon_darkglare.remains<time_to_shard*(6-soul_shard)|cooldown.summon_darkglare.up)&time_to_die>cooldown.summon_darkglare.remains
            if ((A.SummonDarkglare:GetCooldown() < time_to_shard * (6 - Player:SoulShardsP) or A.SummonDarkglare:GetCooldown() == 0) and Unit(unit):TimeToDie() > A.SummonDarkglare:GetCooldown()) then
                local ShouldReturn = Fillers(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- seed_of_corruption,if=variable.use_seed
            if A.SeedofCorruption:IsReady(unit) and (bool(VarUseSeed)) then
                return A.SeedofCorruption:Show(icon)
            end
            -- unstable_affliction,if=!variable.use_seed&!prev_gcd.1.summon_darkglare&(talent.deathbolt.enabled&cooldown.deathbolt.remains<=execute_time&!azerite.cascading_calamity.enabled|(soul_shard>=5&spell_targets.seed_of_corruption_aoe<2|soul_shard>=2&spell_targets.seed_of_corruption_aoe>=2)&target.time_to_die>4+execute_time&spell_targets.seed_of_corruption_aoe=1|target.time_to_die<=8+execute_time*soul_shard)
            if A.UnstableAffliction:IsReady(unit) and (not bool(VarUseSeed) and not Unit("player"):GetSpellLastCast(A.SummonDarkglare) and (A.Deathbolt:IsSpellLearned() and A.Deathbolt:GetCooldown() <= A.UnstableAffliction:GetSpellCastTime() and not bool(A.CascadingCalamity:GetAzeriteRank()) or (Player:SoulShardsP >= 5 and MultiUnits:GetByRangeInCombat(5, 5, 10) < 2 or Player:SoulShardsP >= 2 and MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2) and Unit(unit):TimeToDie() > 4 + A.UnstableAffliction:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 or Unit(unit):TimeToDie() <= 8 + A.UnstableAffliction:GetSpellCastTime() * Player:SoulShardsP)) then
                return A.UnstableAffliction:Show(icon)
            end
            -- unstable_affliction,if=!variable.use_seed&contagion<=cast_time+variable.padding
            if A.UnstableAffliction:IsReady(unit) and (not bool(VarUseSeed) and contagion <= A.UnstableAffliction:GetSpellCastTime() + VarPadding) then
                return A.UnstableAffliction:Show(icon)
            end
            -- unstable_affliction,cycle_targets=1,if=!variable.use_seed&(!talent.deathbolt.enabled|cooldown.deathbolt.remains>time_to_shard|soul_shard>1)&(!talent.vile_taint.enabled|soul_shard>1)&contagion<=cast_time+variable.padding&(!azerite.cascading_calamity.enabled|buff.cascading_calamity.remains>time_to_shard)
            if A.UnstableAffliction:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.UnstableAffliction, 40, EvaluateCycleUnstableAffliction606) then
                    return A.UnstableAffliction:Show(icon) 
                end
            end
        end
        
      -- call precombat
if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then
  local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
end
      if Unit(unit):IsExists() then
                     -- variable,name=use_seed,value=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>=3+raid_event.invulnerable.up|talent.siphon_life.enabled&spell_targets.seed_of_corruption>=5+raid_event.invulnerable.up|spell_targets.seed_of_corruption>=8+raid_event.invulnerable.up
            if (true) then
                VarUseSeed = num(A.SowtheSeeds:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3 + raid_event.invulnerable.up or A.SiphonLife:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 5 + raid_event.invulnerable.up or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 8 + raid_event.invulnerable.up)
            end
            -- variable,name=padding,op=set,value=action.shadow_bolt.execute_time*azerite.cascading_calamity.enabled
            if (true) then
                VarPadding = A.ShadowBolt:GetSpellCastTime() * A.CascadingCalamity:GetAzeriteRank()
            end
            -- variable,name=padding,op=reset,value=gcd,if=azerite.cascading_calamity.enabled&(talent.drain_soul.enabled|talent.deathbolt.enabled&cooldown.deathbolt.remains<=gcd)
            if (bool(A.CascadingCalamity:GetAzeriteRank()) and (A.DrainSoul:IsSpellLearned() or A.Deathbolt:IsSpellLearned() and A.Deathbolt:GetCooldown() <= A.GetGCD())) then
                VarPadding = 0
            end
            -- variable,name=maintain_se,value=spell_targets.seed_of_corruption_aoe<=1+talent.writhe_in_agony.enabled+talent.absolute_corruption.enabled*2+(talent.writhe_in_agony.enabled&talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>2)+(talent.siphon_life.enabled&!talent.creeping_death.enabled&!talent.drain_soul.enabled)+raid_event.invulnerable.up
            if (true) then
                VarMaintainSe = num(MultiUnits:GetByRangeInCombat(5, 5, 10) <= 1 + num(A.WritheInAgony:IsSpellLearned()) + num(A.AbsoluteCorruption:IsSpellLearned()) * 2 + num((A.WritheInAgony:IsSpellLearned() and A.SowtheSeeds:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) > 2)) + num((A.SiphonLife:IsSpellLearned() and not A.CreepingDeath:IsSpellLearned() and not A.DrainSoul:IsSpellLearned())) + raid_event.invulnerable.up)
            end
            -- call_action_list,name=cooldowns
            if (true) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- drain_soul,interrupt_global=1,chain=1,cycle_targets=1,if=target.time_to_die<=gcd&soul_shard<5
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, EvaluateCycleDrainSoul677) then
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- haunt,if=spell_targets.seed_of_corruption_aoe<=2+raid_event.invulnerable.up
            if A.Haunt:IsReady(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) <= 2 + raid_event.invulnerable.up) then
                return A.Haunt:Show(icon)
            end
            -- summon_darkglare,if=dot.agony.ticking&dot.corruption.ticking&(buff.active_uas.stack=5|soul_shard=0)&(!talent.phantom_singularity.enabled|dot.phantom_singularity.remains)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=gcd|!cooldown.deathbolt.remains|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up)
            if A.SummonDarkglare:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) and (ActiveUAs(unit) == 5 or Player:SoulShardsP == 0) and (not A.PhantomSingularity:IsSpellLearned() or bool(Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true))) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() <= A.GetGCD() or not bool(A.Deathbolt:GetCooldown()) or MultiUnits:GetByRangeInCombat(5, 5, 10) > 1 + raid_event.invulnerable.up)) then
                return A.SummonDarkglare:Show(icon)
            end
            -- deathbolt,if=cooldown.summon_darkglare.remains&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up
            if A.Deathbolt:IsReady(unit) and (bool(A.SummonDarkglare:GetCooldown()) and MultiUnits:GetByRangeInCombat(5, 5, 10) == 1 + raid_event.invulnerable.up) then
                return A.Deathbolt:Show(icon)
            end
            -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
            if A.Agony:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Agony, 40, "min", EvaluateTargetIfFilterAgony707, EvaluateTargetIfAgony724) then 
                    return A.Agony:Show(icon) 
                end
            end
            -- unstable_affliction,target_if=!contagion&target.time_to_die<=8
            if A.UnstableAffliction:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.UnstableAffliction, 40, EvaluateCycleUnstableAffliction731) then
                    return A.UnstableAffliction:Show(icon) 
                end
            end
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,cancel_if=ticks_remain<5,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=gcd*2
            if A.DrainSoul:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul737, EvaluateTargetIfDrainSoul752) then 
                    return A.DrainSoul:Show(icon) 
                end
            end
            -- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=execute_time*2+travel_time&!action.shadow_bolt.in_flight
            if A.ShadowBolt:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.ShadowBolt, 40, "min", EvaluateTargetIfFilterShadowBolt758, EvaluateTargetIfShadowBolt785) then 
                    return A.ShadowBolt:Show(icon) 
                end
            end
            -- phantom_singularity,target_if=max:target.time_to_die,if=time>35&target.time_to_die>16*spell_haste
            if A.PhantomSingularity:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.PhantomSingularity, 40, "max", EvaluateTargetIfFilterPhantomSingularity791, EvaluateTargetIfPhantomSingularity794) then 
                    return A.PhantomSingularity:Show(icon) 
                end
            end
            -- vile_taint,target_if=max:target.time_to_die,if=time>15&target.time_to_die>=10
            if A.VileTaint:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.VileTaint, 40, "max", EvaluateTargetIfFilterVileTaint800, EvaluateTargetIfVileTaint803) then 
                    return A.VileTaint:Show(icon) 
                end
            end
            -- unstable_affliction,target_if=min:contagion,if=!variable.use_seed&soul_shard=5
            if A.UnstableAffliction:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.UnstableAffliction, 40, "min", EvaluateTargetIfFilterUnstableAffliction809, EvaluateTargetIfUnstableAffliction814) then 
                    return A.UnstableAffliction:Show(icon) 
                end
            end
            -- seed_of_corruption,if=variable.use_seed&soul_shard=5
            if A.SeedofCorruption:IsReady(unit) and (bool(VarUseSeed) and Player:SoulShardsP == 5) then
                return A.SeedofCorruption:Show(icon)
            end
            -- call_action_list,name=dots
            if (true) then
                local ShouldReturn = Dots(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- phantom_singularity,if=time<=35
            if A.PhantomSingularity:IsReady(unit) and (Unit("player"):CombatTime() <= 35) then
                return A.PhantomSingularity:Show(icon)
            end
            -- vile_taint,if=time<15
            if A.VileTaint:IsReady(unit) and (Unit("player"):CombatTime() < 15) then
                return A.VileTaint:Show(icon)
            end
            -- dark_soul,if=cooldown.summon_darkglare.remains<10&dot.phantom_singularity.remains|target.time_to_die<20+gcd|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up
            if A.DarkSoul:IsReady(unit) and A.BurstIsON(unit) and (A.SummonDarkglare:GetCooldown() < 10 and bool(Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true)) or Unit(unit):TimeToDie() < 20 + A.GetGCD() or MultiUnits:GetByRangeInCombat(5, 5, 10) > 1 + raid_event.invulnerable.up) then
                return A.DarkSoul:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- call_action_list,name=spenders
            if (true) then
                local ShouldReturn = Spenders(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=fillers
            if (true) then
                local ShouldReturn = Fillers(unit); if ShouldReturn then return ShouldReturn; end
            end
      end

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
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

