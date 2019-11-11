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
Action[ACTION_CONST_MONK_WINDWALKER] = {
    ChiBurst                               = Action.Create({Type = "Spell", ID = 123986 }),
    SerenityBuff                           = Action.Create({Type = "Spell", ID = 152173 }),
    Serenity                               = Action.Create({Type = "Spell", ID = 152173 }),
    FistoftheWhiteTiger                    = Action.Create({Type = "Spell", ID = 261947 }),
    ChiWave                                = Action.Create({Type = "Spell", ID = 115098 }),
    InvokeXuentheWhiteTiger                = Action.Create({Type = "Spell", ID = 123904 }),
    RisingSunKick                          = Action.Create({Type = "Spell", ID = 107428 }),
    MarkoftheCraneDebuff                   = Action.Create({Type = "Spell", ID = 228287 }),
    WhirlingDragonPunch                    = Action.Create({Type = "Spell", ID = 152175 }),
    FistsofFury                            = Action.Create({Type = "Spell", ID = 113656 }),
    EnergizingElixir                       = Action.Create({Type = "Spell", ID = 115288 }),
    TigerPalm                              = Action.Create({Type = "Spell", ID = 100780 }),
    RushingJadeWind                        = Action.Create({Type = "Spell", ID = 261715 }),
    RushingJadeWindBuff                    = Action.Create({Type = "Spell", ID = 261715 }),
    SpinningCraneKick                      = Action.Create({Type = "Spell", ID = 101546 }),
    ReverseHarm                            = Action.Create({Type = "Spell", ID =  }),
    HitCombo                               = Action.Create({Type = "Spell", ID = 196741 }),
    FlyingSerpentKick                      = Action.Create({Type = "Spell", ID = 101545 }),
    BokProcBuff                            = Action.Create({Type = "Spell", ID = 116768 }),
    BlackoutKick                           = Action.Create({Type = "Spell", ID = 100784 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    StormEarthandFire                      = Action.Create({Type = "Spell", ID = 137639 }),
    TouchofDeath                           = Action.Create({Type = "Spell", ID = 115080 }),
    TouchofDeathDebuff                     = Action.Create({Type = "Spell", ID =  }),
    StormEarthandFireBuff                  = Action.Create({Type = "Spell", ID = 137639 }),
    DanceofChijiBuff                       = Action.Create({Type = "Spell", ID =  }),
    SpearHandStrike                        = Action.Create({Type = "Spell", ID = 116705 }),
    TouchofKarma                           = Action.Create({Type = "Spell", ID = 122470 }),
    OpenPalmStrikes                        = Action.Create({Type = "Spell", ID =  }),
    GloryoftheDawn                         = Action.Create({Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_MONK_WINDWALKER)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MONK_WINDWALKER], { __index = Action })



local EnemyRanges = {40, 8}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end


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


local function EvaluateTargetIfFilterRisingSunKick25(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick38(unit)
  return (A.WhirlingDragonPunch:IsSpellLearned() and A.WhirlingDragonPunch:GetCooldown() < 5) and A.FistsofFury:GetCooldown() > 3
end


local function EvaluateTargetIfFilterTigerPalm68(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm77(unit)
  return Unit("player"):ChiMax() - Unit("player"):Chi() >= 2 and (not A.HitCombo:IsSpellLearned() or not bool(combo_break))
end


local function EvaluateTargetIfFilterBlackoutKick89(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick102(unit)
  return bool(combo_strike) and (Unit("player"):HasBuffs(A.BokProcBuff.ID, true) or (A.HitCombo:IsSpellLearned() and Unit("player"):GetSpellLastCast(A.TigerPalm) and Unit("player"):Chi() < 4))
end


local function EvaluateTargetIfFilterRisingSunKick185(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick196(unit)
  return Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) or A.WhirlingDragonPunch:GetCooldown() < 4
end


local function EvaluateTargetIfFilterBlackoutKick224(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick235(unit)
  return bool(combo_strike) and (A.FistsofFury:GetCooldown() > 4 or Unit("player"):Chi() >= 4 or (Unit("player"):Chi() == 2 and Unit("player"):GetSpellLastCast(A.TigerPalm)))
end


local function EvaluateTargetIfFilterRisingSunKick255(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick262(unit)
  return Unit("player"):ChiMax() - Unit("player"):Chi() < 2
end


local function EvaluateTargetIfFilterTigerPalm268(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm275(unit)
  return bool(combo_strike) and Unit("player"):ChiMax() - Unit("player"):Chi() >= 2
end


local function EvaluateTargetIfFilterRisingSunKick281(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFilterRisingSunKick292(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick307(unit)
  return MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or Unit("player"):GetSpellLastCast(A.SpinningCraneKick)
end


local function EvaluateTargetIfFilterBlackoutKick363(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFilterRisingSunKick376(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfRisingSunKick383(unit)
  return Unit("player"):Chi() >= 5
end


local function EvaluateTargetIfFilterRisingSunKick391(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfFilterBlackoutKick424(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfBlackoutKick437(unit)
  return bool(combo_strike) and (A.RisingSunKick:GetCooldown() > 3 or Unit("player"):Chi() >= 3) and (A.FistsofFury:GetCooldown() > 4 or Unit("player"):Chi() >= 4 or (Unit("player"):Chi() == 2 and Unit("player"):GetSpellLastCast(A.TigerPalm)))
end


local function EvaluateTargetIfFilterTigerPalm453(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm460(unit)
  return bool(combo_strike) and Unit("player"):ChiMax() - Unit("player"):Chi() >= 2
end


local function EvaluateTargetIfFilterTigerPalm520(unit)
  return Unit(unit):HasDeBuffs(A.MarkoftheCraneDebuff.ID, true)
end

local function EvaluateTargetIfTigerPalm535(unit)
  return not bool(combo_break) and (Unit("player"):EnergyTimeToMaxPredicted() < 1 or (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2) or (Unit("player"):EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)) and Unit("player"):ChiMax() - Unit("player"):Chi() >= 2 and not bool(Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true))
end


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Aoe, Cd, Rskless, Serenity, St, Tod
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- chi_burst,if=(!talent.serenity.enabled|!talent.fist_of_the_white_tiger.enabled)
            if A.ChiBurst:IsReady(unit) and ((not A.Serenity:IsSpellLearned() or not A.FistoftheWhiteTiger:IsSpellLearned())) then
                return A.ChiBurst:Show(icon)
            end
            -- chi_wave,if=talent.fist_of_the_white_tiger.enabled
            if A.ChiWave:IsReady(unit) and (A.FistoftheWhiteTiger:IsSpellLearned()) then
                return A.ChiWave:Show(icon)
            end
            -- invoke_xuen_the_white_tiger
            if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.BurstIsON(unit) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.whirling_dragon_punch.remains<5)&cooldown.fists_of_fury.remains>3
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick25, EvaluateTargetIfRisingSunKick38) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- whirling_dragon_punch
            if A.WhirlingDragonPunch:IsReady(unit) then
                return A.WhirlingDragonPunch:Show(icon)
            end
            -- energizing_elixir,if=!prev_gcd.1.tiger_palm&chi<=1&energy<50
            if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):GetSpellLastCast(A.TigerPalm) and Unit("player"):Chi() <= 1 and Unit("player"):EnergyPredicted() < 50) then
                return A.EnergizingElixir:Show(icon)
            end
            -- fists_of_fury,if=energy.time_to_max>3
            if A.FistsofFury:IsReady(unit) and (Unit("player"):EnergyTimeToMaxPredicted() > 3) then
                return A.FistsofFury:Show(icon)
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down
            if A.RushingJadeWind:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true))) then
                return A.RushingJadeWind:Show(icon)
            end
            -- spinning_crane_kick,if=combo_strike&(((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2))|energy.time_to_max<=3)
            if A.SpinningCraneKick:IsReady(unit) and (bool(combo_strike) and (((Unit("player"):Chi() > 3 or A.FistsofFury:GetCooldown() > 6) and (Unit("player"):Chi() >= 5 or A.FistsofFury:GetCooldown() > 2)) or Unit("player"):EnergyTimeToMaxPredicted() <= 3)) then
                return A.SpinningCraneKick:Show(icon)
            end
            -- reverse_harm,if=chi.max-chi>=2
            if A.ReverseHarm:IsReady(unit) and (Unit("player"):ChiMax() - Unit("player"):Chi() >= 2) then
                return A.ReverseHarm:Show(icon)
            end
            -- chi_burst,if=chi<=3
            if A.ChiBurst:IsReady(unit) and (Unit("player"):Chi() <= 3) then
                return A.ChiBurst:Show(icon)
            end
            -- fist_of_the_white_tiger,if=chi.max-chi>=3
            if A.FistoftheWhiteTiger:IsReady(unit) and (Unit("player"):ChiMax() - Unit("player"):Chi() >= 3) then
                return A.FistoftheWhiteTiger:Show(icon)
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|!combo_break)
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm68, EvaluateTargetIfTigerPalm77) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- chi_wave,if=!combo_break
            if A.ChiWave:IsReady(unit) and (not bool(combo_break)) then
                return A.ChiWave:Show(icon)
            end
            -- flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
            if A.FlyingSerpentKick:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BokProcBuff.ID, true))) then
                return A.FlyingSerpentKick:Show(icon)
            end
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(buff.bok_proc.up|(talent.hit_combo.enabled&prev_gcd.1.tiger_palm&chi<4))
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick89, EvaluateTargetIfBlackoutKick102) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
        end
        
        --Cd
        local function Cd(unit)
            -- invoke_xuen_the_white_tiger
            if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.BurstIsON(unit) then
                return A.InvokeXuentheWhiteTiger:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):ChiMax() - Unit("player"):Chi() >= 1 and Unit("player"):EnergyTimeToMaxPredicted() >= 0.5) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            -- call_action_list,name=tod
            if (true) then
                local ShouldReturn = Tod(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|(cooldown.fists_of_fury.remains<=9&chi>=3&cooldown.whirling_dragon_punch.remains<=14&cooldown.touch_of_death.remains>=90)|target.time_to_die<=15|dot.touch_of_death.remains
            if A.StormEarthandFire:IsReady(unit) and A.BurstIsON(unit) and (A.StormEarthandFire:ChargesP() == 2 or (A.FistsofFury:GetCooldown() <= 9 and Unit("player"):Chi() >= 3 and A.WhirlingDragonPunch:GetCooldown() <= 14 and A.TouchofDeath:GetCooldown() >= 90) or Unit(unit):TimeToDie() <= 15 or bool(Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true))) then
                return A.StormEarthandFire:Show(icon)
            end
            -- concentrated_flame,if=dot.concentrated_flame_burn.remains<=2
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) <= 2) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- the_unbound_force
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.TheUnboundForce:Show(icon)
            end
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- use_item,name=pocketsized_computation_device,if=dot.touch_of_death.remains
            if A.PocketsizedComputationDevice:IsReady(unit) and (bool(Unit(unit):HasDeBuffs(A.TouchofDeathDebuff.ID, true))) then
                A.PocketsizedComputationDevice:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=((equipped.cyclotronic_blast&cooldown.cyclotronic_blast.remains>=20)|!equipped.cyclotronic_blast)&(debuff.razor_coral_debuff.down|(!equipped.dribbling_inkpod|target.time_to_pct_30.remains<8)&buff.storm_earth_and_fire.remains>13|target.time_to_die<21)
            if A.AshvanesRazorCoral:IsReady(unit) and (((A.CyclotronicBlast:IsExists() and A.CyclotronicBlast:GetCooldown() >= 20) or not A.CyclotronicBlast:IsExists()) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or (not A.DribblingInkpod:IsExists() or Unit(unit):TimeToDieX(30) < 8) and Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) > 13 or Unit(unit):TimeToDie() < 21)) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- serenity,if=cooldown.rising_sun_kick.remains<=2|target.time_to_die<=12
            if A.Serenity:IsReady(unit) and A.BurstIsON(unit) and (A.RisingSunKick:GetCooldown() <= 2 or Unit(unit):TimeToDie() <= 12) then
                return A.Serenity:Show(icon)
            end
            -- memory_of_lucid_dreams,if=energy<40&buff.storm_earth_and_fire.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):EnergyPredicted() < 40 and Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
            -- use_items,if=(equipped.cyclotronic_blast&cooldown.cyclotronic_blast.remains<=20)|!equipped.cyclotronic_blast
        end
        
        --Rskless
        local function Rskless(unit)
            -- whirling_dragon_punch
            if A.WhirlingDragonPunch:IsReady(unit) then
                return A.WhirlingDragonPunch:Show(icon)
            end
            -- fists_of_fury
            if A.FistsofFury:IsReady(unit) then
                return A.FistsofFury:Show(icon)
            end
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=buff.storm_earth_and_fire.up|cooldown.whirling_dragon_punch.remains<4
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick185, EvaluateTargetIfRisingSunKick196) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
            if A.RushingJadeWind:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true)) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.RushingJadeWind:Show(icon)
            end
            -- reverse_harm,if=chi.max-chi>=2
            if A.ReverseHarm:IsReady(unit) and (Unit("player"):ChiMax() - Unit("player"):Chi() >= 2) then
                return A.ReverseHarm:Show(icon)
            end
            -- fist_of_the_white_tiger,if=chi<=2
            if A.FistoftheWhiteTiger:IsReady(unit) and (Unit("player"):Chi() <= 2) then
                return A.FistoftheWhiteTiger:Show(icon)
            end
            -- energizing_elixir,if=chi<=3&energy<50
            if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):Chi() <= 3 and Unit("player"):EnergyPredicted() < 50) then
                return A.EnergizingElixir:Show(icon)
            end
            -- spinning_crane_kick,if=combo_strike&buff.dance_of_chiji.react
            if A.SpinningCraneKick:IsReady(unit) and (bool(combo_strike) and bool(Unit("player"):HasBuffsStacks(A.DanceofChijiBuff.ID, true))) then
                return A.SpinningCraneKick:Show(icon)
            end
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(cooldown.fists_of_fury.remains>4|chi>=4|(chi=2&prev_gcd.1.tiger_palm))
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick224, EvaluateTargetIfBlackoutKick235) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
            -- chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
            -- chi_burst,if=chi.max-chi>=1&active_enemies=1|chi.max-chi>=2
            if A.ChiBurst:IsReady(unit) and (Unit("player"):ChiMax() - Unit("player"):Chi() >= 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Unit("player"):ChiMax() - Unit("player"):Chi() >= 2) then
                return A.ChiBurst:Show(icon)
            end
            -- flying_serpent_kick,if=prev_gcd.1.blackout_kick&chi>3,interrupt=1
            if A.FlyingSerpentKick:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.BlackoutKick) and Unit("player"):Chi() > 3) then
                return A.FlyingSerpentKick:Show(icon)
            end
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi<2
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick255, EvaluateTargetIfRisingSunKick262) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm268, EvaluateTargetIfTigerPalm275) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick281) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
        end
        
        --Serenity
        local function Serenity(unit)
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=active_enemies<3|prev_gcd.1.spinning_crane_kick
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick292, EvaluateTargetIfRisingSunKick307) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- fists_of_fury,if=(buff.bloodlust.up&prev_gcd.1.rising_sun_kick)|buff.serenity.remains<1|(active_enemies>1&active_enemies<5)
            if A.FistsofFury:IsReady(unit) and ((Unit("player"):HasHeroism and Unit("player"):GetSpellLastCast(A.RisingSunKick)) or Unit("player"):HasBuffs(A.SerenityBuff.ID, true) < 1 or (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) < 5)) then
                return A.FistsofFury:Show(icon)
            end
            -- fist_of_the_white_tiger,if=talent.hit_combo.enabled&energy.time_to_max<2&prev_gcd.1.blackout_kick&chi<=2
            if A.FistoftheWhiteTiger:IsReady(unit) and (A.HitCombo:IsSpellLearned() and Unit("player"):EnergyTimeToMaxPredicted() < 2 and Unit("player"):GetSpellLastCast(A.BlackoutKick) and Unit("player"):Chi() <= 2) then
                return A.FistoftheWhiteTiger:Show(icon)
            end
            -- tiger_palm,if=talent.hit_combo.enabled&energy.time_to_max<1&prev_gcd.1.blackout_kick&chi.max-chi>=2
            if A.TigerPalm:IsReady(unit) and (A.HitCombo:IsSpellLearned() and Unit("player"):EnergyTimeToMaxPredicted() < 1 and Unit("player"):GetSpellLastCast(A.BlackoutKick) and Unit("player"):ChiMax() - Unit("player"):Chi() >= 2) then
                return A.TigerPalm:Show(icon)
            end
            -- spinning_crane_kick,if=combo_strike&(active_enemies>=3|(talent.hit_combo.enabled&prev_gcd.1.blackout_kick)|(active_enemies=2&prev_gcd.1.blackout_kick))
            if A.SpinningCraneKick:IsReady(unit) and (bool(combo_strike) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 or (A.HitCombo:IsSpellLearned() and Unit("player"):GetSpellLastCast(A.BlackoutKick)) or (MultiUnits:GetByRangeInCombat(40, 5, 10) == 2 and Unit("player"):GetSpellLastCast(A.BlackoutKick)))) then
                return A.SpinningCraneKick:Show(icon)
            end
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick363) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
        end
        
        --St
        local function St(unit)
            -- whirling_dragon_punch
            if A.WhirlingDragonPunch:IsReady(unit) then
                return A.WhirlingDragonPunch:Show(icon)
            end
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=chi>=5
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick376, EvaluateTargetIfRisingSunKick383) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- fists_of_fury,if=energy.time_to_max>3
            if A.FistsofFury:IsReady(unit) and (Unit("player"):EnergyTimeToMaxPredicted() > 3) then
                return A.FistsofFury:Show(icon)
            end
            -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
            if A.RisingSunKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick391) then 
                    return A.RisingSunKick:Show(icon) 
                end
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
            if A.RushingJadeWind:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RushingJadeWindBuff.ID, true)) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.RushingJadeWind:Show(icon)
            end
            -- reverse_harm,if=chi.max-chi>=2
            if A.ReverseHarm:IsReady(unit) and (Unit("player"):ChiMax() - Unit("player"):Chi() >= 2) then
                return A.ReverseHarm:Show(icon)
            end
            -- fist_of_the_white_tiger,if=chi<=2
            if A.FistoftheWhiteTiger:IsReady(unit) and (Unit("player"):Chi() <= 2) then
                return A.FistoftheWhiteTiger:Show(icon)
            end
            -- energizing_elixir,if=chi<=3&energy<50
            if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):Chi() <= 3 and Unit("player"):EnergyPredicted() < 50) then
                return A.EnergizingElixir:Show(icon)
            end
            -- spinning_crane_kick,if=combo_strike&buff.dance_of_chiji.react
            if A.SpinningCraneKick:IsReady(unit) and (bool(combo_strike) and bool(Unit("player"):HasBuffsStacks(A.DanceofChijiBuff.ID, true))) then
                return A.SpinningCraneKick:Show(icon)
            end
            -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&(cooldown.rising_sun_kick.remains>3|chi>=3)&(cooldown.fists_of_fury.remains>4|chi>=4|(chi=2&prev_gcd.1.tiger_palm))
            if A.BlackoutKick:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick424, EvaluateTargetIfBlackoutKick437) then 
                    return A.BlackoutKick:Show(icon) 
                end
            end
            -- chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
            -- chi_burst,if=chi.max-chi>=1&active_enemies=1|chi.max-chi>=2
            if A.ChiBurst:IsReady(unit) and (Unit("player"):ChiMax() - Unit("player"):Chi() >= 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Unit("player"):ChiMax() - Unit("player"):Chi() >= 2) then
                return A.ChiBurst:Show(icon)
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm453, EvaluateTargetIfTigerPalm460) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- flying_serpent_kick,if=prev_gcd.1.blackout_kick&chi>3,interrupt=1
            if A.FlyingSerpentKick:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.BlackoutKick) and Unit("player"):Chi() > 3) then
                return A.FlyingSerpentKick:Show(icon)
            end
        end
        
        --Tod
        local function Tod(unit)
            -- touch_of_death,if=equipped.cyclotronic_blast&target.time_to_die>9&cooldown.cyclotronic_blast.remains<=2
            if A.TouchofDeath:IsReady(unit) and A.BurstIsON(unit) and (A.CyclotronicBlast:IsExists() and Unit(unit):TimeToDie() > 9 and A.CyclotronicBlast:GetCooldown() <= 2) then
                return A.TouchofDeath:Show(icon)
            end
            -- touch_of_death,if=!equipped.cyclotronic_blast&equipped.dribbling_inkpod&target.time_to_die>9&(target.time_to_pct_30.remains>=130|target.time_to_pct_30.remains<8)
            if A.TouchofDeath:IsReady(unit) and A.BurstIsON(unit) and (not A.CyclotronicBlast:IsExists() and A.DribblingInkpod:IsExists() and Unit(unit):TimeToDie() > 9 and (Unit(unit):TimeToDieX(30) >= 130 or Unit(unit):TimeToDieX(30) < 8)) then
                return A.TouchofDeath:Show(icon)
            end
            -- touch_of_death,if=!equipped.cyclotronic_blast&!equipped.dribbling_inkpod&target.time_to_die>9
            if A.TouchofDeath:IsReady(unit) and A.BurstIsON(unit) and (not A.CyclotronicBlast:IsExists() and not A.DribblingInkpod:IsExists() and Unit(unit):TimeToDie() > 9) then
                return A.TouchofDeath:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- spear_hand_strike,if=target.debuff.casting.react
            if A.SpearHandStrike:IsReady(unit) and Action.GetToggle.InterruptEnabled and (Unit(unit):IsCasting) then
                return A.SpearHandStrike:Show(icon)
            end
            -- touch_of_karma,interval=90,pct_health=0.5
            if A.TouchofKarma:IsReady(unit) then
                return A.TouchofKarma:Show(icon)
            end
            -- potion,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.SerenityBuff.ID, true) or Unit("player"):HasBuffs(A.StormEarthandFireBuff.ID, true) or (not A.Serenity:IsSpellLearned() and bool(trinket.proc.agility.react)) or Unit("player"):HasHeroism or Unit(unit):TimeToDie() <= 60) then
                A.ProlongedPower:Show(icon)
            end
            -- call_action_list,name=serenity,if=buff.serenity.up
            if (Unit("player"):HasBuffs(A.SerenityBuff.ID, true)) then
                local ShouldReturn = Serenity(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- reverse_harm,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2))&chi.max-chi>=2
            if A.ReverseHarm:IsReady(unit) and ((Unit("player"):EnergyTimeToMaxPredicted() < 1 or (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2)) and Unit("player"):ChiMax() - Unit("player"):Chi() >= 2) then
                return A.ReverseHarm:Show(icon)
            end
            -- fist_of_the_white_tiger,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2)|(energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5))&chi.max-chi>=3
            if A.FistoftheWhiteTiger:IsReady(unit) and ((Unit("player"):EnergyTimeToMaxPredicted() < 1 or (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2) or (Unit("player"):EnergyTimeToMaxPredicted() < 4 and A.FistsofFury:GetCooldown() < 1.5)) and Unit("player"):ChiMax() - Unit("player"):Chi() >= 3) then
                return A.FistoftheWhiteTiger:Show(icon)
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=!combo_break&(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2)|(energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5))&chi.max-chi>=2&!dot.touch_of_death.remains
            if A.TigerPalm:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm520, EvaluateTargetIfTigerPalm535) then 
                    return A.TigerPalm:Show(icon) 
                end
            end
            -- chi_wave,if=!talent.fist_of_the_white_tiger.enabled&time<=3
            if A.ChiWave:IsReady(unit) and (not A.FistoftheWhiteTiger:IsSpellLearned() and Unit("player"):CombatTime <= 3) then
                return A.ChiWave:Show(icon)
            end
            -- call_action_list,name=cd
            if (true) then
                local ShouldReturn = Cd(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=rskless,if=!ptr&active_enemies<3&azerite.open_palm_strikes.enabled&!azerite.glory_of_the_dawn.enabled
            if (not bool(ptr) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 and bool(A.OpenPalmStrikes:GetAzeriteRank()) and not bool(A.GloryoftheDawn:GetAzeriteRank())) then
                local ShouldReturn = Rskless(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=st,if=active_enemies<3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=aoe,if=active_enemies>=3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
                local ShouldReturn = Aoe(unit); if ShouldReturn then return ShouldReturn; end
            end
        end
    end

    -- End on EnemyRotation()

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
local function FreezingTrapUsedByEnemy()
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
end

