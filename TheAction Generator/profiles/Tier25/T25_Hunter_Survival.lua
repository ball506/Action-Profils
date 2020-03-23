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
Action[ACTION_CONST_HUNTER_SURVIVAL] = {
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
    SummonPet                              = Action.Create({ Type = "Spell", ID = 883 }),
    CoordinatedAssaultBuff                 = Action.Create({ Type = "Spell", ID = 266779 }),
    CoordinatedAssault                     = Action.Create({ Type = "Spell", ID = 266779 }),
    SteelTrapDebuff                        = Action.Create({ Type = "Spell", ID = 162487 }),
    SteelTrap                              = Action.Create({ Type = "Spell", ID = 162488 }),
    Harpoon                                = Action.Create({ Type = "Spell", ID = 190925 }),
    MongooseBite                           = Action.Create({ Type = "Spell", ID = 259387 }),
    BlurofTalonsBuff                       = Action.Create({ Type = "Spell", ID = 277969 }),
    RaptorStrike                           = Action.Create({ Type = "Spell", ID = 186270 }),
    FlankingStrike                         = Action.Create({ Type = "Spell", ID = 269751 }),
    KillCommand                            = Action.Create({ Type = "Spell", ID = 259489 }),
    BloodseekerDebuff                      = Action.Create({ Type = "Spell", ID = 259277 }),
    WildfireBomb                           = Action.Create({ Type = "Spell", ID = 259495 }),
    WildfireBombDebuff                     = Action.Create({ Type = "Spell", ID = 269747 }),
    MongooseFuryBuff                       = Action.Create({ Type = "Spell", ID = 259388 }),
    SerpentSting                           = Action.Create({ Type = "Spell", ID = 259491 }),
    SerpentStingDebuff                     = Action.Create({ Type = "Spell", ID = 259491 }),
    AMurderofCrows                         = Action.Create({ Type = "Spell", ID = 131894 }),
    TipoftheSpearBuff                      = Action.Create({ Type = "Spell", ID = 260286 }),
    ShrapnelBombDebuff                     = Action.Create({ Type = "Spell", ID = 270339 }),
    Chakrams                               = Action.Create({ Type = "Spell", ID = 259391 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Action.Create({ Type = "Spell", ID = 26297 }),
    GuardianofAzerothBuff                  = Action.Create({ Type = "Spell", ID =  }),
    BloodFuryBuff                          = Action.Create({ Type = "Spell", ID = 20572 }),
    PotionofUnbridledFuryBuff              = Action.Create({ Type = "Spell", ID =  }),
    AspectoftheEagle                       = Action.Create({ Type = "Spell", ID = 186289 }),
    WildfireInfusion                       = Action.Create({ Type = "Spell", ID = 271014 }),
    ReapingFlames                          = Action.Create({ Type = "Spell", ID =  }),
    Carve                                  = Action.Create({ Type = "Spell", ID = 187708 }),
    GuerrillaTactics                       = Action.Create({ Type = "Spell", ID = 264332 }),
    LatentPoisonDebuff                     = Action.Create({ Type = "Spell", ID = 273286 }),
    Butchery                               = Action.Create({ Type = "Spell", ID = 212436 }),
    InternalBleedingDebuff                 = Action.Create({ Type = "Spell", ID = 270343 }),
    VipersVenomBuff                        = Action.Create({ Type = "Spell", ID = 268552 }),
    TermsofEngagement                      = Action.Create({ Type = "Spell", ID = 265895 }),
    VipersVenom                            = Action.Create({ Type = "Spell", ID = 268501 }),
    AlphaPredator                          = Action.Create({ Type = "Spell", ID = 269737 }),
    BirdsofPrey                            = Action.Create({ Type = "Spell", ID = 260331 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_HUNTER_SURVIVAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_SURVIVAL], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarCarveCdr = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarCarveCdr = 0
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

A.WildfireBombNormal  = 259495
A.ShrapnelBomb        = 270335
A.PheromoneBomb       = 270323
A.VolatileBomb        = 271045

local WildfireInfusions = {
  A.ShrapnelBomb,
  A.PheromoneBomb,
  A.VolatileBomb,
}

local function CurrentWildfireInfusion ()
  if A.WildfireInfusion:IsSpellLearned() then
    for _, infusion in pairs(WildfireInfusions) do
      if infusion:IsSpellLearned() then return infusion end
    end
  end
  return A.WildfireBombNormal
end

A.RaptorStrikeNormal  = 186270
A.RaptorStrikeEagle   = 265189
A.MongooseBiteNormal  = 259387
A.MongooseBiteEagle   = 265888

local function CurrentRaptorStrike ()
  return A.RaptorStrikeEagle:IsSpellLearned() and A.RaptorStrikeEagle or A.RaptorStrikeNormal
end

local function CurrentMongooseBite ()
  return A.MongooseBiteEagle:IsSpellLearned() and A.MongooseBiteEagle or A.MongooseBiteNormal
end

local function EvaluateTargetIfFilterKillCommand55(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand72(unit)
  return A.KillCommand:FullRechargeTimeP() < 1.5 * A.GetGCD() and Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax()
end


local function EvaluateTargetIfFilterKillCommand134(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand153(unit)
  return Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax() and (Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5 or Player:Focus() < A.MongooseBite:Cost())
end


local function EvaluateCycleCarveCdr472(unit)
    return (MultiUnits:GetByRangeInCombat(8, 5, 10) < 5) and (MultiUnits:GetByRangeInCombat(8, 5, 10) < 5)
end

local function EvaluateTargetIfFilterMongooseBite508(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true)
end

local function EvaluateTargetIfMongooseBite517(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true) == 10
end


local function EvaluateTargetIfFilterKillCommand525(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand538(unit)
  return Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax()
end


local function EvaluateTargetIfFilterSerpentSting574(unit)
  return Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true)
end

local function EvaluateTargetIfSerpentSting591(unit)
  return bool(Unit("player"):HasBuffsStacks(A.VipersVenomBuff.ID, true))
end


local function EvaluateTargetIfFilterSerpentSting609(unit)
  return Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true)
end

local function EvaluateTargetIfSerpentSting632(unit)
  return Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff.ID, true) < 3
end


local function EvaluateTargetIfFilterMongooseBite638(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true)
end

local function EvaluateTargetIfFilterRaptorStrike649(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff.ID, true)
end

local function EvaluateTargetIfFilterKillCommand692(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff.ID, true)
end

local function EvaluateTargetIfKillCommand705(unit)
  return Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax()
end

--- ======= ACTION LISTS =======
local function APL()
        local Precombat, Apst, Apwfi, Cds, Cleave, St, Wfi
  UpdateRanges()
  Everyone.AoEToggleEnemiesUpdate()
  S.WildfireBomb = CurrentWildfireInfusion()
  S.RaptorStrike = CurrentRaptorStrike()
  S.MongooseBite = CurrentMongooseBite()
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- summon_pet
            if A.SummonPet:IsReady(unit) then
                return A.SummonPet:Show(icon)
            end
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and Unit("player"):HasBuffsDown(A.CoordinatedAssaultBuff.ID, true) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
            -- potion,dynamic_prepot=1
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofAgility:Show(icon)
            end
            -- steel_trap
            if A.SteelTrap:IsReady(unit) and Unit("player"):HasDebuffsDown(A.SteelTrapDebuff.ID, true) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.SteelTrap:Show(icon)
            end
            -- harpoon
            if A.Harpoon:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.Harpoon:Show(icon)
            end
        end
        
        --Apst
        local function Apst(unit)
            -- mongoose_bite,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * A.GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * A.GetGCD())) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * A.GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * A.GetGCD())) then
                return A.RaptorStrike:Show(icon)
            end
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            -- kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand55, EvaluateTargetIfKillCommand72) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.SteelTrap:GetSpellCastTime) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
            -- wildfire_bomb,if=focus+cast_regen<focus.max&!ticking&!buff.memory_of_lucid_dreams.up&(full_recharge_time<1.5*gcd|!dot.wildfire_bomb.ticking&!buff.coordinated_assault.up|!dot.wildfire_bomb.ticking&buff.mongoose_fury.stack<1)|time_to_die<18&!dot.wildfire_bomb.ticking
            if A.WildfireBomb:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() and not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and (A.WildfireBomb:FullRechargeTimeP() < 1.5 * A.GetGCD() or not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) or not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 1) or Unit(unit):TimeToDie() < 18 and not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true)) then
                return A.WildfireBomb:Show(icon)
            end
            -- serpent_sting,if=!dot.serpent_sting.ticking&!buff.coordinated_assault.up
            if A.SerpentSting:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand134, EvaluateTargetIfKillCommand153) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- serpent_sting,if=refreshable&!buff.coordinated_assault.up&buff.mongoose_fury.stack<5
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5) then
                return A.SerpentSting:Show(icon)
            end
            -- a_murder_of_crows,if=!buff.coordinated_assault.up
            if A.AMurderofCrows:IsReady(unit) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.AMurderofCrows:Show(icon)
            end
            -- coordinated_assault,if=!buff.coordinated_assault.up
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- mongoose_bite,if=buff.mongoose_fury.up|focus+cast_regen>focus.max-10|buff.coordinated_assault.up
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) or Player:Focus() + Unit("player"):FocusCastRegen(A.MongooseBite:GetSpellCastTime) > Player:FocusMax() - 10 or Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            -- wildfire_bomb,if=!ticking
            if A.WildfireBomb:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true)) then
                return A.WildfireBomb:Show(icon)
            end
        end
        
        --Apwfi
        local function Apwfi(unit)
            -- mongoose_bite,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return A.RaptorStrike:Show(icon)
            end
            -- serpent_sting,if=!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd|focus+cast_regen<focus.max&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if A.WildfireBomb:IsReady(unit) and (A.WildfireBomb:FullRechargeTimeP() < 1.5 * A.GetGCD() or Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) and Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) or S.PheromoneBomb:IsLearned() and not Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) and Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() - Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) * 3)) then
                return A.WildfireBomb:Show(icon)
            end
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- mongoose_bite,if=buff.mongoose_fury.remains&next_wi_bomb.pheromone
            if A.MongooseBite:IsReady(unit) and (bool(Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true)) and S.PheromoneBomb:IsLearned()) then
                return A.MongooseBite:Show(icon)
            end
            -- kill_command,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max-20
            if A.KillCommand:IsReady(unit) and (A.KillCommand:FullRechargeTimeP() < 1.5 * A.GetGCD() and Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax() - 20) then
                return A.KillCommand:Show(icon)
            end
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.SteelTrap:GetSpellCastTime) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
            -- raptor_strike,if=buff.tip_of_the_spear.stack=3|dot.shrapnel_bomb.ticking
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff.ID, true) == 3 or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true)) then
                return A.RaptorStrike:Show(icon)
            end
            -- mongoose_bite,if=dot.shrapnel_bomb.ticking
            if A.MongooseBite:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true)) then
                return A.MongooseBite:Show(icon)
            end
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&focus>30&dot.serpent_sting.remains>5*gcd
            if A.WildfireBomb:IsReady(unit) and (S.ShrapnelBomb:IsLearned() and Player:Focus() > 30 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 5 * A.GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            -- chakrams,if=!buff.mongoose_fury.remains
            if A.Chakrams:IsReady(unit) and (not bool(Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true))) then
                return A.Chakrams:Show(icon)
            end
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            -- kill_command,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax() and (Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 5 or Player:Focus() < A.MongooseBite:Cost())) then
                return A.KillCommand:Show(icon)
            end
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            -- mongoose_bite,if=buff.mongoose_fury.up|focus>40|dot.shrapnel_bomb.ticking
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) or Player:Focus() > 40 or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true)) then
                return A.MongooseBite:Show(icon)
            end
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
            if A.WildfireBomb:IsReady(unit) and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) or S.PheromoneBomb:IsLearned() or S.ShrapnelBomb:IsLearned() and Player:Focus() > 50) then
                return A.WildfireBomb:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- blood_fury,if=cooldown.coordinated_assault.remains>30
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.BloodFury:Show(icon)
            end
            -- ancestral_call,if=cooldown.coordinated_assault.remains>30
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.AncestralCall:Show(icon)
            end
            -- fireblood,if=cooldown.coordinated_assault.remains>30
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.Fireblood:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            -- berserking,if=cooldown.coordinated_assault.remains>60|time_to_die<13
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 60 or Unit(unit):TimeToDie() < 13) then
                return A.Berserking:Show(icon)
            end
            -- potion,if=buff.guardian_of_azeroth.up&(buff.berserking.up|buff.blood_fury.up|!race.troll)|(consumable.potion_of_unbridled_fury&target.time_to_die<61|target.time_to_die<26)|!essence.condensed_lifeforce.major&buff.coordinated_assault.up
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) and (Unit("player"):HasBuffs(A.BerserkingBuff.ID, true) or Unit("player"):HasBuffs(A.BloodFuryBuff.ID, true) or not Unit("player"):IsRace("Troll")) or (Unit(unit):HasBuffs(A.PotionofUnbridledFuryBuff.ID, true) and Unit(unit):TimeToDie() < 61 or Unit(unit):TimeToDie() < 26) or not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                A.BattlePotionofAgility:Show(icon)
            end
            -- aspect_of_the_eagle,if=target.distance>=6
            if A.AspectoftheEagle:IsReady(unit) and A.BurstIsON(unit) and (target.distance >= 6) then
                return A.AspectoftheEagle:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=equipped.dribbling_inkpod&(debuff.razor_coral_debuff.down|time_to_pct_30<1|(health.pct<30&buff.guardian_of_azeroth.up|buff.memory_of_lucid_dreams.up))|(!equipped.dribbling_inkpod&(buff.memory_of_lucid_dreams.up|buff.guardian_of_azeroth.up&cooldown.guardian_of_azeroth.remains>175)|debuff.razor_coral_debuff.down)|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (A.DribblingInkpod:IsExists() and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or time_to_pct_30 < 1 or (health.pct < 30 and Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true))) or (not A.DribblingInkpod:IsExists() and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) and A.GuardianofAzeroth:GetCooldown() > 175) or bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true))) or Unit(unit):TimeToDie() < 20) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=galecallers_boon,if=cooldown.memory_of_lucid_dreams.remains|talent.wildfire_infusion.enabled&cooldown.coordinated_assault.remains|!essence.memory_of_lucid_dreams.major&cooldown.coordinated_assault.remains
            if A.GalecallersBoon:IsReady(unit) and (bool(A.MemoryofLucidDreams:GetCooldown()) or A.WildfireInfusion:IsSpellLearned() and bool(A.CoordinatedAssault:GetCooldown()) or not bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and bool(A.CoordinatedAssault:GetCooldown())) then
                A.GalecallersBoon:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.coordinated_assault.up
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
            -- concentrated_flame,if=full_recharge_time<1*gcd
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.ConcentratedFlame:FullRechargeTimeP() < 1 * A.GetGCD()) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
            if A.ReapingFlames:IsReady(unit) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or target.time_to_pct_20 > 30) then
                return A.ReapingFlames:Show(icon)
            end
            -- mongoose_bite,if=essence.memory_of_lucid_dreams.major&!cooldown.memory_of_lucid_dreams.remains
            if A.MongooseBite:IsReady(unit) and (bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and not bool(A.MemoryofLucidDreams:GetCooldown())) then
                return A.MongooseBite:Show(icon)
            end
            -- wildfire_bomb,if=essence.memory_of_lucid_dreams.major&full_recharge_time<1.5*gcd&focus<action.mongoose_bite.cost&!cooldown.memory_of_lucid_dreams.remains
            if A.WildfireBomb:IsReady(unit) and (bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)) and A.WildfireBomb:FullRechargeTimeP() < 1.5 * A.GetGCD() and Player:Focus() < A.MongooseBite:Cost() and not bool(A.MemoryofLucidDreams:GetCooldown())) then
                return A.WildfireBomb:Show(icon)
            end
            -- memory_of_lucid_dreams,if=focus<action.mongoose_bite.cost&buff.coordinated_assault.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:Focus() < A.MongooseBite:Cost() and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
        end
        
        --Cleave
        local function Cleave(unit)
            -- variable,name=carve_cdr,op=setif,value=active_enemies,value_else=5,condition=active_enemies<5
            if  then
                if Action.Utils.CastTargetIf(VarCarveCdr, 8, "min", EvaluateCycleCarveCdr472) then
                    return VarCarveCdr:Show(icon) 
                end
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- carve,if=dot.shrapnel_bomb.ticking
            if A.Carve:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true)) then
                return A.Carve:Show(icon)
            end
            -- wildfire_bomb,if=!talent.guerrilla_tactics.enabled|full_recharge_time<gcd
            if A.WildfireBomb:IsReady(unit) and (not A.GuerrillaTactics:IsSpellLearned() or A.WildfireBomb:FullRechargeTimeP() < A.GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            -- mongoose_bite,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack=10
            if A.MongooseBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MongooseBite, 8, "max", EvaluateTargetIfFilterMongooseBite508, EvaluateTargetIfMongooseBite517) then 
                    return A.MongooseBite:Show(icon) 
                end
            end
            -- chakrams
            if A.Chakrams:IsReady(unit) then
                return A.Chakrams:Show(icon)
            end
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand525, EvaluateTargetIfKillCommand538) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- butchery,if=full_recharge_time<gcd|!talent.wildfire_infusion.enabled|dot.shrapnel_bomb.ticking&dot.internal_bleeding.stack<3
            if A.Butchery:IsReady(unit) and (A.Butchery:FullRechargeTimeP() < A.GetGCD() or not A.WildfireInfusion:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) and Unit(unit):HasDeBuffsStacks(A.InternalBleedingDebuff.ID, true) < 3) then
                return A.Butchery:Show(icon)
            end
            -- carve,if=talent.guerrilla_tactics.enabled
            if A.Carve:IsReady(unit) and (A.GuerrillaTactics:IsSpellLearned()) then
                return A.Carve:Show(icon)
            end
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            -- wildfire_bomb,if=dot.wildfire_bomb.refreshable|talent.wildfire_infusion.enabled
            if A.WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.WildfireBombDebuff.ID, true) or A.WildfireInfusion:IsSpellLearned()) then
                return A.WildfireBomb:Show(icon)
            end
            -- serpent_sting,target_if=min:remains,if=buff.vipers_venom.react
            if A.SerpentSting:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SerpentSting, 8, "min", EvaluateTargetIfFilterSerpentSting574, EvaluateTargetIfSerpentSting591) then 
                    return A.SerpentSting:Show(icon) 
                end
            end
            -- carve,if=cooldown.wildfire_bomb.remains>variable.carve_cdr%2
            if A.Carve:IsReady(unit) and (A.WildfireBomb:GetCooldown() > VarCarveCdr / 2) then
                return A.Carve:Show(icon)
            end
            -- steel_trap
            if A.SteelTrap:IsReady(unit) then
                return A.SteelTrap:Show(icon)
            end
            -- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            -- serpent_sting,target_if=min:remains,if=refreshable&buff.tip_of_the_spear.stack<3
            if A.SerpentSting:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SerpentSting, 8, "min", EvaluateTargetIfFilterSerpentSting609, EvaluateTargetIfSerpentSting632) then 
                    return A.SerpentSting:Show(icon) 
                end
            end
            -- mongoose_bite,target_if=max:debuff.latent_poison.stack
            if A.MongooseBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MongooseBite, 8, "max", EvaluateTargetIfFilterMongooseBite638) then 
                    return A.MongooseBite:Show(icon) 
                end
            end
            -- raptor_strike,target_if=max:debuff.latent_poison.stack
            if A.RaptorStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RaptorStrike, 8, "max", EvaluateTargetIfFilterRaptorStrike649) then 
                    return A.RaptorStrike:Show(icon) 
                end
            end
        end
        
        --St
        local function St(unit)
            -- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Player:FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            -- raptor_strike,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * A.GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * A.GetGCD())) then
                return A.RaptorStrike:Show(icon)
            end
            -- mongoose_bite,if=buff.coordinated_assault.up&(buff.coordinated_assault.remains<1.5*gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<1.5*gcd)
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) < 1.5 * A.GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < 1.5 * A.GetGCD())) then
                return A.MongooseBite:Show(icon)
            end
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand692, EvaluateTargetIfKillCommand705) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- serpent_sting,if=buff.vipers_venom.up&buff.vipers_venom.remains<1*gcd
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) < 1 * A.GetGCD()) then
                return A.SerpentSting:Show(icon)
            end
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.SteelTrap:GetSpellCastTime) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
            -- wildfire_bomb,if=focus+cast_regen<focus.max&!ticking&!buff.memory_of_lucid_dreams.up&(full_recharge_time<1.5*gcd|!dot.wildfire_bomb.ticking&!buff.coordinated_assault.up|!dot.wildfire_bomb.ticking&buff.mongoose_fury.stack<1)|time_to_die<18&!dot.wildfire_bomb.ticking
            if A.WildfireBomb:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() and not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) and (A.WildfireBomb:FullRechargeTimeP() < 1.5 * A.GetGCD() or not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true) or not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true) and Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) < 1) or Unit(unit):TimeToDie() < 18 and not Unit(unit):HasDeBuffs(A.WildfireBombDebuff.ID, true)) then
                return A.WildfireBomb:Show(icon)
            end
            -- serpent_sting,if=buff.vipers_venom.up&dot.serpent_sting.remains<4*gcd|dot.serpent_sting.refreshable&!buff.coordinated_assault.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 4 * A.GetGCD() or Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            -- a_murder_of_crows,if=!buff.coordinated_assault.up
            if A.AMurderofCrows:IsReady(unit) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.AMurderofCrows:Show(icon)
            end
            -- coordinated_assault,if=!buff.coordinated_assault.up
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- mongoose_bite,if=buff.mongoose_fury.up|focus+cast_regen>focus.max-20&talent.vipers_venom.enabled|focus+cast_regen>focus.max-1&talent.terms_of_engagement.enabled|buff.coordinated_assault.up
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) or Player:Focus() + Unit("player"):FocusCastRegen(A.MongooseBite:GetSpellCastTime) > Player:FocusMax() - 20 and A.VipersVenom:IsSpellLearned() or Player:Focus() + Unit("player"):FocusCastRegen(A.MongooseBite:GetSpellCastTime) > Player:FocusMax() - 1 and A.TermsofEngagement:IsSpellLearned() or Unit("player"):HasBuffs(A.CoordinatedAssaultBuff.ID, true)) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            -- wildfire_bomb,if=dot.wildfire_bomb.refreshable
            if A.WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.WildfireBombDebuff.ID, true)) then
                return A.WildfireBomb:Show(icon)
            end
            -- serpent_sting,if=buff.vipers_venom.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
        end
        
        --Wfi
        local function Wfi(unit)
            -- harpoon,if=focus+cast_regen<focus.max&talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.Harpoon:GetSpellCastTime) < Player:FocusMax() and A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            -- mongoose_bite,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike,if=buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd
            if A.RaptorStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) and Unit("player"):HasBuffs(A.BlurofTalonsBuff.ID, true) < A.GetGCD()) then
                return A.RaptorStrike:Show(icon)
            end
            -- serpent_sting,if=buff.vipers_venom.up&buff.vipers_venom.remains<1.5*gcd|!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) < 1.5 * A.GetGCD() or not Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd&focus+cast_regen<focus.max|(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if A.WildfireBomb:IsReady(unit) and (A.WildfireBomb:FullRechargeTimeP() < 1.5 * A.GetGCD() and Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() or (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) and Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) or S.PheromoneBomb:IsLearned() and not Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true) and Player:Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Player:FocusMax() - Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) * 3)) then
                return A.WildfireBomb:Show(icon)
            end
            -- kill_command,if=focus+cast_regen<focus.max-focus.regen
            if A.KillCommand:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Player:FocusMax() - Player:FocusRegen()) then
                return A.KillCommand:Show(icon)
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- steel_trap,if=focus+cast_regen<focus.max
            if A.SteelTrap:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.SteelTrap:GetSpellCastTime) < Player:FocusMax()) then
                return A.SteelTrap:Show(icon)
            end
            -- wildfire_bomb,if=full_recharge_time<1.5*gcd
            if A.WildfireBomb:IsReady(unit) and (A.WildfireBomb:FullRechargeTimeP() < 1.5 * A.GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- serpent_sting,if=buff.vipers_venom.up&dot.serpent_sting.remains<4*gcd
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true) and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) < 4 * A.GetGCD()) then
                return A.SerpentSting:Show(icon)
            end
            -- mongoose_bite,if=dot.shrapnel_bomb.ticking|buff.mongoose_fury.stack=5
            if A.MongooseBite:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff.ID, true) or Unit("player"):HasBuffsStacks(A.MongooseFuryBuff.ID, true) == 5) then
                return A.MongooseBite:Show(icon)
            end
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&dot.serpent_sting.remains>5*gcd
            if A.WildfireBomb:IsReady(unit) and (S.ShrapnelBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) > 5 * A.GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            -- chakrams,if=!buff.mongoose_fury.remains
            if A.Chakrams:IsReady(unit) and (not bool(Unit("player"):HasBuffs(A.MongooseFuryBuff.ID, true))) then
                return A.Chakrams:Show(icon)
            end
            -- mongoose_bite
            if A.MongooseBite:IsReady(unit) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            -- serpent_sting,if=buff.vipers_venom.up
            if A.SerpentSting:IsReady(unit) and (Unit("player"):HasBuffs(A.VipersVenomBuff.ID, true)) then
                return A.SerpentSting:Show(icon)
            end
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel
            if A.WildfireBomb:IsReady(unit) and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff.ID, true) or S.PheromoneBomb:IsLearned() or S.ShrapnelBomb:IsLearned()) then
                return A.WildfireBomb:Show(icon)
            end
        end
        
  if Everyone.TargetIsValid() then
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end
            -- auto_attack
            -- use_items
            -- call_action_list,name=cds
            if (true) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- mongoose_bite,if=active_enemies=1&(talent.alpha_predator.enabled&target.time_to_die<10|target.time_to_die<5)
            if A.MongooseBite:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) == 1 and (A.AlphaPredator:IsSpellLearned() and Unit(unit):TimeToDie() < 10 or Unit(unit):TimeToDie() < 5)) then
                return A.MongooseBite:Show(icon)
            end
            -- call_action_list,name=apwfi,if=active_enemies<3&talent.chakrams.enabled&talent.alpha_predator.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and A.Chakrams:IsSpellLearned() and A.AlphaPredator:IsSpellLearned()) then
                local ShouldReturn = Apwfi(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=wfi,if=active_enemies<3&talent.chakrams.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and A.Chakrams:IsSpellLearned()) then
                local ShouldReturn = Wfi(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=st,if=active_enemies<3&!talent.alpha_predator.enabled&!talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and not A.AlphaPredator:IsSpellLearned() and not A.WildfireInfusion:IsSpellLearned()) then
                local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=apst,if=active_enemies<3&talent.alpha_predator.enabled&!talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and A.AlphaPredator:IsSpellLearned() and not A.WildfireInfusion:IsSpellLearned()) then
                local ShouldReturn = Apst(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=apwfi,if=active_enemies<3&talent.alpha_predator.enabled&talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and A.AlphaPredator:IsSpellLearned() and A.WildfireInfusion:IsSpellLearned()) then
                local ShouldReturn = Apwfi(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=wfi,if=active_enemies<3&!talent.alpha_predator.enabled&talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) < 3 and not A.AlphaPredator:IsSpellLearned() and A.WildfireInfusion:IsSpellLearned()) then
                local ShouldReturn = Wfi(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cleave,if=active_enemies>1&!talent.birds_of_prey.enabled|active_enemies>2
            if (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1 and not A.BirdsofPrey:IsSpellLearned() or MultiUnits:GetByRangeInCombat(8, 5, 10) > 2) then
                local ShouldReturn = Cleave(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
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

