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
Action[ACTION_CONST_DRUID_BALANCE] = {
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
    StreakingStars                         = Action.Create({ Type = "Spell", ID = 272871 }),
    ArcanicPulsarBuff                      = Action.Create({ Type = "Spell", ID = 287790 }),
    ArcanicPulsar                          = Action.Create({ Type = "Spell", ID = 287773 }),
    TwinMoons                              = Action.Create({ Type = "Spell", ID = 279620 }),
    StarlordBuff                           = Action.Create({ Type = "Spell", ID = 279709 }),
    Starlord                               = Action.Create({ Type = "Spell", ID = 202345 }),
    StellarDrift                           = Action.Create({ Type = "Spell", ID = 202354 }),
    MoonkinForm                            = Action.Create({ Type = "Spell", ID = 24858 }),
    SolarWrath                             = Action.Create({ Type = "Spell", ID = 190984 }),
    CaIncBuff                              = Action.Create({ Type = "Spell", ID =  }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    CaInc                                  = Action.Create({ Type = "Spell", ID =  }),
    WarriorofElune                         = Action.Create({ Type = "Spell", ID = 202425 }),
    Innervate                              = Action.Create({ Type = "Spell", ID = 29166 }),
    LivelySpirit                           = Action.Create({ Type = "Spell", ID = 279642 }),
    Incarnation                            = Action.Create({ Type = "Spell", ID = 102560 }),
    CelestialAlignment                     = Action.Create({ Type = "Spell", ID = 194223 }),
    LivelySpiritBuff                       = Action.Create({ Type = "Spell", ID = 279646 }),
    FuryofElune                            = Action.Create({ Type = "Spell", ID = 202770 }),
    ForceofNature                          = Action.Create({ Type = "Spell", ID = 205636 }),
    Starfall                               = Action.Create({ Type = "Spell", ID = 191034 }),
    Starsurge                              = Action.Create({ Type = "Spell", ID = 78674 }),
    LunarEmpowermentBuff                   = Action.Create({ Type = "Spell", ID = 164547 }),
    SolarEmpowermentBuff                   = Action.Create({ Type = "Spell", ID = 164545 }),
    Sunfire                                = Action.Create({ Type = "Spell", ID = 93402 }),
    SunfireDebuff                          = Action.Create({ Type = "Spell", ID = 164815 }),
    MoonfireDebuff                         = Action.Create({ Type = "Spell", ID = 164812 }),
    Moonfire                               = Action.Create({ Type = "Spell", ID = 8921 }),
    StellarFlare                           = Action.Create({ Type = "Spell", ID = 202347 }),
    StellarFlareDebuff                     = Action.Create({ Type = "Spell", ID = 202347 }),
    NewMoon                                = Action.Create({ Type = "Spell", ID = 274281 }),
    HalfMoon                               = Action.Create({ Type = "Spell", ID = 274282 }),
    FullMoon                               = Action.Create({ Type = "Spell", ID = 274283 }),
    LunarStrike                            = Action.Create({ Type = "Spell", ID = 194153 }),
    WarriorofEluneBuff                     = Action.Create({ Type = "Spell", ID = 202425 })
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
Action:CreateEssencesFor(ACTION_CONST_DRUID_BALANCE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_BALANCE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarAzSs = 0;
local VarAzAp = 0;
local VarSfTargets = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarAzSs = 0
  VarAzAp = 0
  VarSfTargets = 0
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

local function FutureAstralPower()
    local AstralPower=Player:AstralPower()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit("player"):IsCasting()
        
    if not Unit("player"):IsCasting() then
        return AstralPower
    else
        if spellID = A.NewMoon.ID then
            return AstralPower + 10
        elseif spellID = A.HalfMoon.ID then
            return AstralPower + 20
        elseif spellID = A.FullMoon.ID then
            return AstralPower + 40
        elseif spellID = A.StellarFlare.ID then
            return AstralPower + 8
        elseif spellID = A.SolarWrath.ID then
            return AstralPower + 8
        elseif spellID = A.LunarStrike.ID then
            return AstralPower + 12
        else
            return AstralPower
        end
    end
end


local function EvaluateCycleSunfire208(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.SunfireDebuff.ID, true)) and (bool(ap_check) and math.floor (Unit(unit):TimeToDie() / (2 * Player:SpellHaste())) * MultiUnits:GetByRangeInCombat(40, 5, 10) >= math.ceil (math.floor (2 / MultiUnits:GetByRangeInCombat(40, 5, 10)) * 1.5) + 2 * MultiUnits:GetByRangeInCombat(40, 5, 10) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 + num(A.TwinMoons:IsSpellLearned()) or Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true)) and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or not bool(prev.sunfire)))
end

local function EvaluateCycleMoonfire261(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff.ID, true)) and (bool(ap_check) and math.floor (Unit(unit):TimeToDie() / (2 * Player:SpellHaste())) * MultiUnits:GetByRangeInCombat(40, 5, 10) >= 6 and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or not bool(prev.moonfire)))
end

local function EvaluateCycleStellarFlare286(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.StellarFlareDebuff.ID, true)) and (bool(ap_check) and math.floor (Unit(unit):TimeToDie() / (2 * Player:SpellHaste())) >= 5 and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or not bool(prev.stellar_flare)))
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
        local Precombat
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- variable,name=az_ss,value=azerite.streaking_stars.rank
            if (true) then
                VarAzSs = A.StreakingStars:GetAzeriteRank()
            end
            -- variable,name=az_ap,value=azerite.arcanic_pulsar.rank
            if (true) then
                VarAzAp = A.ArcanicPulsar:GetAzeriteRank()
            end
            -- variable,name=sf_targets,value=4
            if (true) then
                VarSfTargets = 4
            end
            -- variable,name=sf_targets,op=add,value=1,if=talent.twin_moons.enabled&(azerite.arcanic_pulsar.enabled|talent.starlord.enabled)
            if (A.TwinMoons:IsSpellLearned() and (bool(A.ArcanicPulsar:GetAzeriteRank()) or A.Starlord:IsSpellLearned())) then
                VarSfTargets = VarSfTargets + 1
            end
            -- variable,name=sf_targets,op=sub,value=1,if=!azerite.arcanic_pulsar.enabled&!talent.starlord.enabled&talent.stellar_drift.enabled
            if (not bool(A.ArcanicPulsar:GetAzeriteRank()) and not A.Starlord:IsSpellLearned() and A.StellarDrift:IsSpellLearned()) then
                VarSfTargets = VarSfTargets - 1
            end
            -- moonkin_form
            if A.MoonkinForm:IsReady(unit) then
                return A.MoonkinForm:Show(icon)
            end
            -- snapshot_stats
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- solar_wrath
            if A.SolarWrath:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.SolarWrath:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- potion,if=buff.ca_inc.remains>6&active_enemies=1
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 6 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1) then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- potion,name=battle_potion_of_intellect,if=buff.ca_inc.remains>6
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true) > 6) then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- blood_fury,if=buff.ca_inc.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=buff.ca_inc.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- arcane_torrent,if=buff.ca_inc.up
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- lights_judgment,if=buff.ca_inc.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood,if=buff.ca_inc.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=buff.ca_inc.up
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CaIncBuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            -- use_item,name=balefire_branch,if=equipped.159630&cooldown.ca_inc.remains>30
            if A.BalefireBranch:IsReady(unit) and (A.Item159630:IsExists() and A.CaInc:GetCooldown() > 30) then
                A.BalefireBranch:Show(icon)
            end
            -- use_item,name=dread_gladiators_badge,if=equipped.161902&cooldown.ca_inc.remains>30
            if A.DreadGladiatorsBadge:IsReady(unit) and (A.Item161902:IsExists() and A.CaInc:GetCooldown() > 30) then
                A.DreadGladiatorsBadge:Show(icon)
            end
            -- use_item,name=azurethos_singed_plumage,if=equipped.161377&cooldown.ca_inc.remains>30
            if A.AzurethosSingedPlumage:IsReady(unit) and (A.Item161377:IsExists() and A.CaInc:GetCooldown() > 30) then
                A.AzurethosSingedPlumage:Show(icon)
            end
            -- use_items,if=cooldown.ca_inc.remains>30
            -- warrior_of_elune
            if A.WarriorofElune:IsReady(unit) then
                return A.WarriorofElune:Show(icon)
            end
            -- innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.remains<2|cooldown.celestial_alignment.remains<12)
            if A.Innervate:IsReady(unit) and (bool(A.LivelySpirit:GetAzeriteRank()) and (A.Incarnation:GetCooldown() < 2 or A.CelestialAlignment:GetCooldown() < 12)) then
                return A.Innervate:Show(icon)
            end
            -- incarnation,if=astral_power>=40
            if A.Incarnation:IsReady(unit) and (FutureAstralPower >= 40) then
                return A.Incarnation:Show(icon)
            end
            -- celestial_alignment,if=astral_power>=40&(!azerite.lively_spirit.enabled|buff.lively_spirit.up)&(buff.starlord.stack>=2|!talent.starlord.enabled|!variable.az_ss)
            if A.CelestialAlignment:IsReady(unit) and (FutureAstralPower >= 40 and (not bool(A.LivelySpirit:GetAzeriteRank()) or Unit("player"):HasBuffs(A.LivelySpiritBuff.ID, true)) and (Unit("player"):HasBuffsStacks(A.StarlordBuff.ID, true) >= 2 or not A.Starlord:IsSpellLearned() or not bool(VarAzSs))) then
                return A.CelestialAlignment:Show(icon)
            end
            -- fury_of_elune,if=(buff.ca_inc.up|cooldown.ca_inc.remains>30)&solar_wrath.ap_check
            if A.FuryofElune:IsReady(unit) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or A.CaInc:GetCooldown() > 30) and bool(solar_wrath.ap_check)) then
                return A.FuryofElune:Show(icon)
            end
            -- force_of_nature,if=(buff.ca_inc.up|cooldown.ca_inc.remains>30)&ap_check
            if A.ForceofNature:IsReady(unit) and ((Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or A.CaInc:GetCooldown() > 30) and bool(ap_check)) then
                return A.ForceofNature:Show(icon)
            end
            -- cancel_buff,name=starlord,if=buff.starlord.remains<8&!solar_wrath.ap_check
            if (Unit("player"):HasBuffs(A.StarlordBuff.ID, true) < 8 and not bool(solar_wrath.ap_check)) then
                -- if HR.CancelA.StarlordBuff.ID, true then return ""; end
            end
            -- starfall,if=(buff.starlord.stack<3|buff.starlord.remains>=8)&spell_targets>=variable.sf_targets&(target.time_to_die+1)*spell_targets>cost%2.5
            if A.Starfall:IsReady(unit) and ((Unit("player"):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 or Unit("player"):HasBuffs(A.StarlordBuff.ID, true) >= 8) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarSfTargets and (Unit(unit):TimeToDie() + 1) * MultiUnits:GetByRangeInCombat(40, 5, 10) > A.Starfall:Cost() / 2.5) then
                return A.Starfall:Show(icon)
            end
            -- starsurge,if=(talent.starlord.enabled&(buff.starlord.stack<3|buff.starlord.remains>=8&buff.arcanic_pulsar.stack<8)|!talent.starlord.enabled&(buff.arcanic_pulsar.stack<8|buff.ca_inc.up))&spell_targets.starfall<variable.sf_targets&buff.lunar_empowerment.stack+buff.solar_empowerment.stack<4&buff.solar_empowerment.stack<3&buff.lunar_empowerment.stack<3&(!variable.az_ss|!buff.ca_inc.up|!prev.starsurge)|target.time_to_die<=execute_time*astral_power%40|!solar_wrath.ap_check
            if A.Starsurge:IsReady(unit) and ((A.Starlord:IsSpellLearned() and (Unit("player"):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 or Unit("player"):HasBuffs(A.StarlordBuff.ID, true) >= 8 and Unit("player"):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) < 8) or not A.Starlord:IsSpellLearned() and (Unit("player"):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) < 8 or Unit("player"):HasBuffs(A.CaIncBuff.ID, true))) and MultiUnits:GetByRangeInCombat(40, 5, 10) < VarSfTargets and Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) + Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 4 and Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 3 and Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) < 3 and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or not bool(prev.starsurge)) or Unit(unit):TimeToDie() <= A.Starsurge:GetSpellCastTime() * FutureAstralPower / 40 or not bool(solar_wrath.ap_check)) then
                return A.Starsurge:Show(icon)
            end
            -- sunfire,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))*spell_targets>=ceil(floor(2%spell_targets)*1.5)+2*spell_targets&(spell_targets>1+talent.twin_moons.enabled|dot.moonfire.ticking)&(!variable.az_ss|!buff.ca_inc.up|!prev.sunfire)
            if A.Sunfire:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Sunfire, 40, EvaluateCycleSunfire208) then
                    return A.Sunfire:Show(icon) 
                end
            end
            -- moonfire,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))*spell_targets>=6&(!variable.az_ss|!buff.ca_inc.up|!prev.moonfire)
            if A.Moonfire:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Moonfire, 40, EvaluateCycleMoonfire261) then
                    return A.Moonfire:Show(icon) 
                end
            end
            -- stellar_flare,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))>=5&(!variable.az_ss|!buff.ca_inc.up|!prev.stellar_flare)
            if A.StellarFlare:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.StellarFlare, 40, EvaluateCycleStellarFlare286) then
                    return A.StellarFlare:Show(icon) 
                end
            end
            -- new_moon,if=ap_check
            if A.NewMoon:IsReady(unit) and (bool(ap_check)) then
                return A.NewMoon:Show(icon)
            end
            -- half_moon,if=ap_check
            if A.HalfMoon:IsReady(unit) and (bool(ap_check)) then
                return A.HalfMoon:Show(icon)
            end
            -- full_moon,if=ap_check
            if A.FullMoon:IsReady(unit) and (bool(ap_check)) then
                return A.FullMoon:Show(icon)
            end
            -- lunar_strike,if=buff.solar_empowerment.stack<3&(ap_check|buff.lunar_empowerment.stack=3)&((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=2&!buff.solar_empowerment.up)&(!variable.az_ss|!buff.ca_inc.up|(!prev.lunar_strike&!talent.incarnation.enabled|prev.solar_wrath))|variable.az_ss&buff.ca_inc.up&prev.solar_wrath)
            if A.LunarStrike:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 3 and (bool(ap_check) or Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) == 3) and ((Unit("player"):HasBuffs(A.WarriorofEluneBuff.ID, true) or Unit("player"):HasBuffs(A.LunarEmpowermentBuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and not Unit("player"):HasBuffs(A.SolarEmpowermentBuff.ID, true)) and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or (not bool(prev.lunar_strike) and not A.Incarnation:IsSpellLearned() or bool(prev.solar_wrath))) or bool(VarAzSs) and Unit("player"):HasBuffs(A.CaIncBuff.ID, true) and bool(prev.solar_wrath))) then
                return A.LunarStrike:Show(icon)
            end
            -- solar_wrath,if=variable.az_ss<3|!buff.ca_inc.up|!prev.solar_wrath
            if A.SolarWrath:IsReady(unit) and (VarAzSs < 3 or not Unit("player"):HasBuffs(A.CaIncBuff.ID, true) or not bool(prev.solar_wrath)) then
                return A.SolarWrath:Show(icon)
            end
            -- sunfire
            if A.Sunfire:IsReady(unit) then
                return A.Sunfire:Show(icon)
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

