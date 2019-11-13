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
Action[ACTION_CONST_DEATHKNIGHT_FROST] = {
    RemorselessWinter                      = Action.Create({Type = "Spell", ID = 196770 }),
    GatheringStorm                         = Action.Create({Type = "Spell", ID = 194912 }),
    FrozenTempest                          = Action.Create({Type = "Spell", ID =  }),
    RimeBuff                               = Action.Create({Type = "Spell", ID =  }),
    GlacialAdvance                         = Action.Create({Type = "Spell", ID = 194913 }),
    Frostscythe                            = Action.Create({Type = "Spell", ID = 207230 }),
    FrostStrike                            = Action.Create({Type = "Spell", ID = 49143 }),
    RazoriceDebuff                         = Action.Create({Type = "Spell", ID = 51714 }),
    HowlingBlast                           = Action.Create({Type = "Spell", ID = 49184 }),
    KillingMachineBuff                     = Action.Create({Type = "Spell", ID = 51124 }),
    RunicAttenuation                       = Action.Create({Type = "Spell", ID = 207104 }),
    Obliterate                             = Action.Create({Type = "Spell", ID = 49020 }),
    HornofWinter                           = Action.Create({Type = "Spell", ID = 57330 }),
    ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
    PillarofFrost                          = Action.Create({Type = "Spell", ID = 51271 }),
    ChainsofIce                            = Action.Create({Type = "Spell", ID = 45524 }),
    ColdHeartBuff                          = Action.Create({Type = "Spell", ID =  }),
    PillarofFrostBuff                      = Action.Create({Type = "Spell", ID =  }),
    FrostwyrmsFury                         = Action.Create({Type = "Spell", ID = 279302 }),
    IcyCitadel                             = Action.Create({Type = "Spell", ID =  }),
    UnholyStrengthBuff                     = Action.Create({Type = "Spell", ID = 53365 }),
    IcyCitadelBuff                         = Action.Create({Type = "Spell", ID =  }),
    BreathofSindragosaDebuff               = Action.Create({Type = "Spell", ID =  }),
    BreathofSindragosa                     = Action.Create({Type = "Spell", ID = 152279 }),
    EmpowerRuneWeaponBuff                  = Action.Create({Type = "Spell", ID =  }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    EmpowerRuneWeapon                      = Action.Create({Type = "Spell", ID = 47568 }),
    ColdHeart                              = Action.Create({Type = "Spell", ID =  }),
    FrozenPulseBuff                        = Action.Create({Type = "Spell", ID =  }),
    FrozenPulse                            = Action.Create({Type = "Spell", ID = 194909 }),
    FrostFeverDebuff                       = Action.Create({Type = "Spell", ID =  }),
    IcyTalonsBuff                          = Action.Create({Type = "Spell", ID = 194879 }),
    Obliteration                           = Action.Create({Type = "Spell", ID = 281238 })
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
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_FROST)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_FROST], { __index = Action })





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


local function EvaluateCycleFrostStrike22(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned() and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike57(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate80(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike101(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate124(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RuneTimeToX(4) < A.GetGCD() and Player:RunicPowerDeficit() >= 25 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike143(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() < 20 and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate172(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleFrostStrike195(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate214(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPower() <= 30 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate237(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RuneTimeToX(5) < A.GetGCD() or Player:RunicPower() <= 45 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate262(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and Player:RunicPowerDeficit() > 25 or Player:Rune() > 3 and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate426(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned() and not Unit("player"):HasBuffs(A.RimeBuff.ID, true) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 3
end

local function EvaluateCycleObliterate459(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and bool(Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true)) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and (Unit("player"):GetSpellLastCast(A.FrostStrike) or Unit("player"):GetSpellLastCast(A.HowlingBlast) or Unit("player"):GetSpellLastCast(A.GlacialAdvance)))
end

local function EvaluateCycleFrostStrike500(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not Unit("player"):HasBuffs(A.RimeBuff.ID, true) or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD() and not A.Frostscythe:IsSpellLearned()
end

local function EvaluateCycleObliterate523(unit)
    return (Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) < 5 or Unit(unit):HasDeBuffs(A.RazoriceDebuff.ID, true) < 10) and not A.Frostscythe:IsSpellLearned()
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
        local Precombat, Aoe, BosPooling, BosTicking, ColdHeart, Cooldowns, Obliteration, Standard
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStrength:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
            -- remorseless_winter,if=talent.gathering_storm.enabled|(azerite.frozen_tempest.rank&spell_targets.remorseless_winter>=3&!buff.rime.up)
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned() or (bool(A.FrozenTempest:GetAzeriteRank()) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 3 and not Unit("player"):HasBuffs(A.RimeBuff.ID, true))) then
                return A.RemorselessWinter:Show(icon)
            end
            -- glacial_advance,if=talent.frostscythe.enabled
            if A.GlacialAdvance:IsReady(unit) and (A.Frostscythe:IsSpellLearned()) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, EvaluateCycleFrostStrike22) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
            if A.FrostStrike:IsReady(unit) and (A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            -- frostscythe,if=buff.killing_machine.up
            if A.Frostscythe:IsReady(unit) and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true)) then
                return A.Frostscythe:Show(icon)
            end
            -- glacial_advance,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
            if A.GlacialAdvance:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit<(15+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, EvaluateCycleFrostStrike57) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.FrostStrike:Show(icon)
            end
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
            -- frostscythe
            if A.Frostscythe:IsReady(unit) then
                return A.Frostscythe:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>(25+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate80) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
            -- glacial_advance
            if A.GlacialAdvance:IsReady(unit) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, EvaluateCycleFrostStrike101) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike
            if A.FrostStrike:IsReady(unit) then
                return A.FrostStrike:Show(icon)
            end
            -- horn_of_winter
            if A.HornofWinter:IsReady(unit) then
                return A.HornofWinter:Show(icon)
            end
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        --BosPooling
        local function BosPooling(unit)
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&rune.time_to_4<gcd&runic_power.deficit>=25&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate124) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=rune.time_to_4<gcd&runic_power.deficit>=25
            if A.Obliterate:IsReady(unit) and (Player:RuneTimeToX(4) < A.GetGCD() and Player:RunicPowerDeficit() >= 25) then
                return A.Obliterate:Show(icon)
            end
            -- glacial_advance,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>rune.time_to_4&spell_targets.glacial_advance>=2
            if A.GlacialAdvance:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit<20&cooldown.pillar_of_frost.remains>rune.time_to_4&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, EvaluateCycleFrostStrike143) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>rune.time_to_4
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4)) then
                return A.FrostStrike:Show(icon)
            end
            -- frostscythe,if=buff.killing_machine.up&runic_power.deficit>(15+talent.runic_attenuation.enabled*3)&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and Player:RunicPowerDeficit() > (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- frostscythe,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and (Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate172) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() >= (35 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
            -- glacial_advance,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&spell_targets.glacial_advance>=2
            if A.GlacialAdvance:IsReady(unit) and (A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40 and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, EvaluateCycleFrostStrike195) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40
            if A.FrostStrike:IsReady(unit) and (A.PillarofFrost:GetCooldown() > Player:RuneTimeToX(4) and Player:RunicPowerDeficit() < 40) then
                return A.FrostStrike:Show(icon)
            end
        end
        
        --BosTicking
        local function BosTicking(unit)
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power<=30&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate214) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power<=30
            if A.Obliterate:IsReady(unit) and (Player:RunicPower() <= 30) then
                return A.Obliterate:Show(icon)
            end
            -- remorseless_winter,if=talent.gathering_storm.enabled
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned()) then
                return A.RemorselessWinter:Show(icon)
            end
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&rune.time_to_5<gcd|runic_power<=45&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate237) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=rune.time_to_5<gcd|runic_power<=45
            if A.Obliterate:IsReady(unit) and (Player:RuneTimeToX(5) < A.GetGCD() or Player:RunicPower() <= 45) then
                return A.Obliterate:Show(icon)
            end
            -- frostscythe,if=buff.killing_machine.up&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- horn_of_winter,if=runic_power.deficit>=30&rune.time_to_3>gcd
            if A.HornofWinter:IsReady(unit) and (Player:RunicPowerDeficit() >= 30 and Player:RuneTimeToX(3) > A.GetGCD()) then
                return A.HornofWinter:Show(icon)
            end
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
            -- frostscythe,if=spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&runic_power.deficit>25|rune>3&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate262) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=runic_power.deficit>25|rune>3
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > 25 or Player:Rune() > 3) then
                return A.Obliterate:Show(icon)
            end
            -- arcane_torrent,if=runic_power.deficit>20
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 20) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        --ColdHeart
        local function ColdHeart(unit)
            -- chains_of_ice,if=buff.cold_heart.stack>5&target.time_to_die<gcd
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) > 5 and Unit(unit):TimeToDie() < A.GetGCD()) then
                return A.ChainsofIce:Show(icon)
            end
            -- chains_of_ice,if=(buff.pillar_of_frost.remains<=gcd*(1+cooldown.frostwyrms_fury.ready)|buff.pillar_of_frost.remains<rune.time_to_3)&buff.pillar_of_frost.up&azerite.icy_citadel.rank<=2
            if A.ChainsofIce:IsReady(unit) and ((Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) <= A.GetGCD() * (1 + num(A.FrostwyrmsFury:GetCooldown() == 0)) or Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < Player:RuneTimeToX(3)) and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.IcyCitadel:GetAzeriteRank() <= 2) then
                return A.ChainsofIce:Show(icon)
            end
            -- chains_of_ice,if=buff.pillar_of_frost.remains<8&buff.unholy_strength.remains<gcd*(1+cooldown.frostwyrms_fury.ready)&buff.unholy_strength.remains&buff.pillar_of_frost.up&azerite.icy_citadel.rank<=2
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 8 and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) < A.GetGCD() * (1 + num(A.FrostwyrmsFury:GetCooldown() == 0)) and bool(Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true)) and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.IcyCitadel:GetAzeriteRank() <= 2) then
                return A.ChainsofIce:Show(icon)
            end
            -- chains_of_ice,if=(buff.icy_citadel.remains<=gcd*(1+cooldown.frostwyrms_fury.ready)|buff.icy_citadel.remains<rune.time_to_3)&buff.icy_citadel.up&azerite.icy_citadel.enabled&azerite.icy_citadel.rank>2
            if A.ChainsofIce:IsReady(unit) and ((Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) <= A.GetGCD() * (1 + num(A.FrostwyrmsFury:GetCooldown() == 0)) or Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) < Player:RuneTimeToX(3)) and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) and bool(A.IcyCitadel:GetAzeriteRank()) and A.IcyCitadel:GetAzeriteRank() > 2) then
                return A.ChainsofIce:Show(icon)
            end
            -- chains_of_ice,if=buff.icy_citadel.remains<8&buff.unholy_strength.remains<gcd*(1+cooldown.frostwyrms_fury.ready)&buff.unholy_strength.remains&buff.icy_citadel.up&!azerite.icy_citadel.enabled&azerite.icy_citadel.rank>2
            if A.ChainsofIce:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) < 8 and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) < A.GetGCD() * (1 + num(A.FrostwyrmsFury:GetCooldown() == 0)) and bool(Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true)) and Unit("player"):HasBuffs(A.IcyCitadelBuff.ID, true) and not bool(A.IcyCitadel:GetAzeriteRank()) and A.IcyCitadel:GetAzeriteRank() > 2) then
                return A.ChainsofIce:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- use_items,if=(cooldown.pillar_of_frost.ready|cooldown.pillar_of_frost.remains>20)&(!talent.breath_of_sindragosa.enabled|cooldown.empower_rune_weapon.remains>95)
            -- use_item,name=grongs_primal_rage,if=rune<=3&!buff.pillar_of_frost.up&(!dot.breath_of_sindragosa.ticking|!talent.breath_of_sindragosa.enabled)
            if A.GrongsPrimalRage:IsReady(unit) and (Player:Rune() <= 3 and not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and (not Unit(unit):HasDeBuffs(A.BreathofSindragosaDebuff.ID, true) or not A.BreathofSindragosa:IsSpellLearned())) then
                A.GrongsPrimalRage:Show(icon)
            end
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                A.RazdunksBigRedButton:Show(icon)
            end
            -- use_item,name=merekthas_fang,if=!dot.breath_of_sindragosa.ticking&!buff.pillar_of_frost.up
            if A.MerekthasFang:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.BreathofSindragosaDebuff.ID, true) and not Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) then
                A.MerekthasFang:Show(icon)
            end
            -- potion,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true)) then
                A.BattlePotionofStrength:Show(icon)
            end
            -- blood_fury,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and Unit("player"):HasBuffs(A.EmpowerRuneWeaponBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=buff.pillar_of_frost.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- pillar_of_frost,if=cooldown.empower_rune_weapon.remains
            if A.PillarofFrost:IsReady(unit) and (bool(A.EmpowerRuneWeapon:GetCooldown())) then
                return A.PillarofFrost:Show(icon)
            end
            -- breath_of_sindragosa,if=cooldown.empower_rune_weapon.remains&cooldown.pillar_of_frost.remains
            if A.BreathofSindragosa:IsReady(unit) and (bool(A.EmpowerRuneWeapon:GetCooldown()) and bool(A.PillarofFrost:GetCooldown())) then
                return A.BreathofSindragosa:Show(icon)
            end
            -- empower_rune_weapon,if=cooldown.pillar_of_frost.ready&!talent.breath_of_sindragosa.enabled&rune.time_to_5>gcd&runic_power.deficit>=10|target.time_to_die<20
            if A.EmpowerRuneWeapon:IsReady(unit) and (A.PillarofFrost:GetCooldown() == 0 and not A.BreathofSindragosa:IsSpellLearned() and Player:RuneTimeToX(5) > A.GetGCD() and Player:RunicPowerDeficit() >= 10 or Unit(unit):TimeToDie() < 20) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
            -- empower_rune_weapon,if=(cooldown.pillar_of_frost.ready|target.time_to_die<20)&talent.breath_of_sindragosa.enabled&rune>=3&runic_power>60
            if A.EmpowerRuneWeapon:IsReady(unit) and ((A.PillarofFrost:GetCooldown() == 0 or Unit(unit):TimeToDie() < 20) and A.BreathofSindragosa:IsSpellLearned() and Player:Rune() >= 3 and Player:RunicPower() > 60) then
                return A.EmpowerRuneWeapon:Show(icon)
            end
            -- call_action_list,name=cold_heart,if=talent.cold_heart.enabled&((buff.cold_heart.stack>=10&debuff.razorice.stack=5)|target.time_to_die<=gcd)
            if (A.ColdHeart:IsSpellLearned() and ((Unit("player"):HasBuffsStacks(A.ColdHeartBuff.ID, true) >= 10 and Unit(unit):HasDeBuffsStacks(A.RazoriceDebuff.ID, true) == 5) or Unit(unit):TimeToDie() <= A.GetGCD())) then
                local ShouldReturn = ColdHeart(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- frostwyrms_fury,if=(buff.pillar_of_frost.remains<=gcd|(buff.pillar_of_frost.remains<8&buff.unholy_strength.remains<=gcd&buff.unholy_strength.up))&buff.pillar_of_frost.up&azerite.icy_citadel.rank<=2
            if A.FrostwyrmsFury:IsReady(unit) and ((Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) <= A.GetGCD() or (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) < 8 and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true) <= A.GetGCD() and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true))) and Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.IcyCitadel:GetAzeriteRank() <= 2) then
                return A.FrostwyrmsFury:Show(icon)
            end
            -- frostwyrms_fury,if=target.time_to_die<gcd|(target.time_to_die<cooldown.pillar_of_frost.remains&buff.unholy_strength.up)
            if A.FrostwyrmsFury:IsReady(unit) and (Unit(unit):TimeToDie() < A.GetGCD() or (Unit(unit):TimeToDie() < A.PillarofFrost:GetCooldown() and Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true))) then
                return A.FrostwyrmsFury:Show(icon)
            end
        end
        
        --Obliteration
        local function Obliteration(unit)
            -- remorseless_winter,if=talent.gathering_storm.enabled
            if A.RemorselessWinter:IsReady(unit) and (A.GatheringStorm:IsSpellLearned()) then
                return A.RemorselessWinter:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled&!buff.rime.up&spell_targets.howling_blast>=3
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate426) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=!talent.frostscythe.enabled&!buff.rime.up&spell_targets.howling_blast>=3
            if A.Obliterate:IsReady(unit) and (not A.Frostscythe:IsSpellLearned() and not Unit("player"):HasBuffs(A.RimeBuff.ID, true) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 3) then
                return A.Obliterate:Show(icon)
            end
            -- frostscythe,if=(buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance)))&spell_targets.frostscythe>=2
            if A.Frostscythe:IsReady(unit) and ((bool(Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true)) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and (Unit("player"):GetSpellLastCast(A.FrostStrike) or Unit("player"):GetSpellLastCast(A.HowlingBlast) or Unit("player"):GetSpellLastCast(A.GlacialAdvance)))) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) then
                return A.Frostscythe:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate459) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate,if=buff.killing_machine.react|(buff.killing_machine.up&(prev_gcd.1.frost_strike|prev_gcd.1.howling_blast|prev_gcd.1.glacial_advance))
            if A.Obliterate:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.KillingMachineBuff.ID, true)) or (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and (Unit("player"):GetSpellLastCast(A.FrostStrike) or Unit("player"):GetSpellLastCast(A.HowlingBlast) or Unit("player"):GetSpellLastCast(A.GlacialAdvance)))) then
                return A.Obliterate:Show(icon)
            end
            -- glacial_advance,if=(!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd)&spell_targets.glacial_advance>=2
            if A.GlacialAdvance:IsReady(unit) and ((not Unit("player"):HasBuffs(A.RimeBuff.ID, true) or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD()) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2) then
                return A.GlacialAdvance:Show(icon)
            end
            -- howling_blast,if=buff.rime.up&spell_targets.howling_blast>=2
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2) then
                return A.HowlingBlast:Show(icon)
            end
            -- frost_strike,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd&!talent.frostscythe.enabled
            if A.FrostStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FrostStrike, 10, EvaluateCycleFrostStrike500) then
                    return A.FrostStrike:Show(icon) 
                end
            end
            -- frost_strike,if=!buff.rime.up|runic_power.deficit<10|rune.time_to_2>gcd
            if A.FrostStrike:IsReady(unit) and (not Unit("player"):HasBuffs(A.RimeBuff.ID, true) or Player:RunicPowerDeficit() < 10 or Player:RuneTimeToX(2) > A.GetGCD()) then
                return A.FrostStrike:Show(icon)
            end
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            -- obliterate,target_if=(debuff.razorice.stack<5|debuff.razorice.remains<10)&!talent.frostscythe.enabled
            if A.Obliterate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Obliterate, 10, EvaluateCycleObliterate523) then
                    return A.Obliterate:Show(icon) 
                end
            end
            -- obliterate
            if A.Obliterate:IsReady(unit) then
                return A.Obliterate:Show(icon)
            end
        end
        
        --Standard
        local function Standard(unit)
            -- remorseless_winter
            if A.RemorselessWinter:IsReady(unit) then
                return A.RemorselessWinter:Show(icon)
            end
            -- frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
            if A.FrostStrike:IsReady(unit) and (A.RemorselessWinter:GetCooldown() <= 2 * A.GetGCD() and A.GatheringStorm:IsSpellLearned()) then
                return A.FrostStrike:Show(icon)
            end
            -- howling_blast,if=buff.rime.up
            if A.HowlingBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RimeBuff.ID, true)) then
                return A.HowlingBlast:Show(icon)
            end
            -- obliterate,if=!buff.frozen_pulse.up&talent.frozen_pulse.enabled
            if A.Obliterate:IsReady(unit) and (not Unit("player"):HasBuffs(A.FrozenPulseBuff.ID, true) and A.FrozenPulse:IsSpellLearned()) then
                return A.Obliterate:Show(icon)
            end
            -- frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
            if A.FrostStrike:IsReady(unit) and (Player:RunicPowerDeficit() < (15 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.FrostStrike:Show(icon)
            end
            -- frostscythe,if=buff.killing_machine.up&rune.time_to_4>=gcd
            if A.Frostscythe:IsReady(unit) and (Unit("player"):HasBuffs(A.KillingMachineBuff.ID, true) and Player:RuneTimeToX(4) >= A.GetGCD()) then
                return A.Frostscythe:Show(icon)
            end
            -- obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
            if A.Obliterate:IsReady(unit) and (Player:RunicPowerDeficit() > (25 + num(A.RunicAttenuation:IsSpellLearned()) * 3)) then
                return A.Obliterate:Show(icon)
            end
            -- frost_strike
            if A.FrostStrike:IsReady(unit) then
                return A.FrostStrike:Show(icon)
            end
            -- horn_of_winter
            if A.HornofWinter:IsReady(unit) then
                return A.HornofWinter:Show(icon)
            end
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- howling_blast,if=!dot.frost_fever.ticking&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.HowlingBlast:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.FrostFeverDebuff.ID, true) and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.HowlingBlast:Show(icon)
            end
            -- glacial_advance,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&spell_targets.glacial_advance>=2&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.GlacialAdvance:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) <= A.GetGCD() and Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) and MultiUnits:GetByRangeInCombat(30, 5, 10) >= 2 and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.GlacialAdvance:Show(icon)
            end
            -- frost_strike,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
            if A.FrostStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) <= A.GetGCD() and Unit("player"):HasBuffs(A.IcyTalonsBuff.ID, true) and (not A.BreathofSindragosa:IsSpellLearned() or A.BreathofSindragosa:GetCooldown() > 15)) then
                return A.FrostStrike:Show(icon)
            end
            -- call_action_list,name=cooldowns
            if (true) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&(cooldown.breath_of_sindragosa.remains<5|(cooldown.breath_of_sindragosa.remains<20&target.time_to_die<35))
            if (A.BreathofSindragosa:IsSpellLearned() and (A.BreathofSindragosa:GetCooldown() < 5 or (A.BreathofSindragosa:GetCooldown() < 20 and Unit(unit):TimeToDie() < 35))) then
                return BosPooling(unit);
            end
            -- run_action_list,name=bos_ticking,if=dot.breath_of_sindragosa.ticking
            if (Unit(unit):HasDeBuffs(A.BreathofSindragosaDebuff.ID, true)) then
                return BosTicking(unit);
            end
            -- run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
            if (Unit("player"):HasBuffs(A.PillarofFrostBuff.ID, true) and A.Obliteration:IsSpellLearned()) then
                return Obliteration(unit);
            end
            -- run_action_list,name=aoe,if=active_enemies>=2
            if (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2) then
                return Aoe(unit);
            end
            -- call_action_list,name=standard
            if (true) then
                local ShouldReturn = Standard(unit); if ShouldReturn then return ShouldReturn; end
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

