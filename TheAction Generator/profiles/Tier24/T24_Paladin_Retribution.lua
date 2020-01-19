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
Action[ACTION_CONST_PALADIN_RETRIBUTION] = {
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
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    WakeofAshes                            = Action.Create({ Type = "Spell", ID = 255937 }),
    AvengingWrathBuff                      = Action.Create({ Type = "Spell", ID = 31884 }),
    CrusadeBuff                            = Action.Create({ Type = "Spell", ID = 231895 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    ShieldofVengeance                      = Action.Create({ Type = "Spell", ID = 184662 }),
    SeethingRageBuff                       = Action.Create({ Type = "Spell", ID =  }),
    Crusade                                = Action.Create({ Type = "Spell", ID = 231895 }),
    AvengingWrath                          = Action.Create({ Type = "Spell", ID = 31884 }),
    InquisitionBuff                        = Action.Create({ Type = "Spell", ID = 84963 }),
    Inquisition                            = Action.Create({ Type = "Spell", ID = 84963 }),
    BladeofJustice                         = Action.Create({ Type = "Spell", ID = 184575 }),
    Judgment                               = Action.Create({ Type = "Spell", ID = 20271 }),
    RighteousVerdict                       = Action.Create({ Type = "Spell", ID = 267610 }),
    EmpyreanPowerBuff                      = Action.Create({ Type = "Spell", ID = 286393 }),
    JudgmentDebuff                         = Action.Create({ Type = "Spell", ID = 197277 }),
    DivinePurposeBuff                      = Action.Create({ Type = "Spell", ID = 223819 }),
    AvengingWrathAutocritBuff              = Action.Create({ Type = "Spell", ID =  }),
    ExecutionSentence                      = Action.Create({ Type = "Spell", ID = 267798 }),
    DivineStorm                            = Action.Create({ Type = "Spell", ID = 53385 }),
    TemplarsVerdict                        = Action.Create({ Type = "Spell", ID = 85256 }),
    HammerofWrath                          = Action.Create({ Type = "Spell", ID = 24275 }),
    Consecration                           = Action.Create({ Type = "Spell", ID = 205228 }),
    CrusaderStrike                         = Action.Create({ Type = "Spell", ID = 35395 }),
    ReapingFlames                          = Action.Create({ Type = "Spell", ID =  }),
    Rebuke                                 = Action.Create({ Type = "Spell", ID = 96231 })
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
Action:CreateEssencesFor(ACTION_CONST_PALADIN_RETRIBUTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_RETRIBUTION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarWingsPool = 0;
local VarDsCastable = 0;
local VarHow = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarWingsPool = 0
  VarDsCastable = 0
  VarHow = 0
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
        local Precombat, Cooldowns, Finishers, Generators
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
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- arcane_torrent,if=!talent.wake_of_ashes.enabled
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.WakeofAshes:IsSpellLearned()) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- potion,if=(cooldown.guardian_of_azeroth.remains>90|!essence.condensed_lifeforce.major)&(buff.bloodlust.react|buff.avenging_wrath.up&buff.avenging_wrath.remains>18|buff.crusade.up&buff.crusade.remains<25)
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and ((A.GuardianofAzeroth:GetCooldown() > 90 or not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID))) and (Unit("player"):HasHeroism() or Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) and Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) > 18 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) < 25)) then
                A.BattlePotionofStrength:Show(icon)
            end
            -- lights_judgment,if=spell_targets.lights_judgment>=2|(!raid_event.adds.exists|raid_event.adds.in>75)
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2 or (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 75)) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) then
                return A.Fireblood:Show(icon)
            end
            -- shield_of_vengeance,if=buff.seething_rage.down&buff.memory_of_lucid_dreams.down
            if A.ShieldofVengeance:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.SeethingRageBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true))) then
                return A.ShieldofVengeance:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(buff.avenging_wrath.remains>=20|buff.crusade.stack=10&buff.crusade.remains>15)&(cooldown.guardian_of_azeroth.remains>90|target.time_to_die<30|!essence.condensed_lifeforce.major)
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) >= 20 or Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10 and Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) > 15) and (A.GuardianofAzeroth:GetCooldown() > 90 or Unit(unit):TimeToDie() < 30 or not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)))) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- the_unbound_force,if=time<=2|buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):CombatTime() <= 2 or Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- guardian_of_azeroth,if=!talent.crusade.enabled&(cooldown.avenging_wrath.remains<5&holy_power>=3&(buff.inquisition.up|!talent.inquisition.enabled)|cooldown.avenging_wrath.remains>=45)|(talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|holy_power>=3&time<10&talent.wake_of_ashes.enabled|cooldown.crusade.remains>=45)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not A.Crusade:IsSpellLearned() and (A.AvengingWrath:GetCooldown() < 5 and Player:HolyPower() >= 3 and (Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) or not A.Inquisition:IsSpellLearned()) or A.AvengingWrath:GetCooldown() >= 45) or (A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 4 or Player:HolyPower() >= 3 and Unit("player"):CombatTime() < 10 and A.WakeofAshes:IsSpellLearned() or A.Crusade:GetCooldown() >= 45)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- worldvein_resonance,if=cooldown.avenging_wrath.remains<gcd&holy_power>=3|talent.crusade.enabled&cooldown.crusade.remains<gcd&holy_power>=4|cooldown.avenging_wrath.remains>=45|cooldown.crusade.remains>=45
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.AvengingWrath:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 3 or A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() < A.GetGCD() and Player:HolyPower() >= 4 or A.AvengingWrath:GetCooldown() >= 45 or A.Crusade:GetCooldown() >= 45) then
                return A.WorldveinResonance:Show(icon)
            end
            -- focused_azerite_beam,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)&!(buff.avenging_wrath.up|buff.crusade.up)&(cooldown.blade_of_justice.remains>gcd*3&cooldown.judgment.remains>gcd*3)
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 30 or MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2) and not (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true)) and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 3 and A.Judgment:GetCooldown() > A.GetGCD() * 3)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- memory_of_lucid_dreams,if=(buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10)&holy_power<=3
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) == 10) and Player:HolyPower() <= 3) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- purifying_blast,if=(!raid_event.adds.exists|raid_event.adds.in>30|spell_targets.divine_storm>=2)
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 30 or MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2)) then
                return A.PurifyingBlast:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=!(buff.avenging_wrath.up|buff.crusade.up)&(cooldown.blade_of_justice.remains>gcd*3&cooldown.judgment.remains>gcd*3)
            if A.CyclotronicBlast:IsReady(unit) and (not (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true)) and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 3 and A.Judgment:GetCooldown() > A.GetGCD() * 3)) then
                A.CyclotronicBlast:Show(icon)
            end
            -- avenging_wrath,if=(!talent.inquisition.enabled|buff.inquisition.up)&holy_power>=3
            if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and ((not A.Inquisition:IsSpellLearned() or Unit("player"):HasBuffs(A.InquisitionBuff.ID, true)) and Player:HolyPower() >= 3) then
                return A.AvengingWrath:Show(icon)
            end
            -- crusade,if=holy_power>=4|holy_power>=3&time<10&talent.wake_of_ashes.enabled
            if A.Crusade:IsReady(unit) and A.BurstIsON(unit) and (Player:HolyPower() >= 4 or Player:HolyPower() >= 3 and Unit("player"):CombatTime() < 10 and A.WakeofAshes:IsSpellLearned()) then
                return A.Crusade:Show(icon)
            end
        end
        
        --Finishers
        local function Finishers(unit)
            -- variable,name=wings_pool,value=!equipped.169314&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>gcd*3|cooldown.crusade.remains>gcd*3)|equipped.169314&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>gcd*6|cooldown.crusade.remains>gcd*6)
            if (true) then
                VarWingsPool = num(not A.Item169314:IsExists() and (not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 or A.Crusade:GetCooldown() > A.GetGCD() * 3) or A.Item169314:IsExists() and (not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > A.GetGCD() * 6 or A.Crusade:GetCooldown() > A.GetGCD() * 6))
            end
            -- variable,name=ds_castable,value=spell_targets.divine_storm>=2&!talent.righteous_verdict.enabled|spell_targets.divine_storm>=3&talent.righteous_verdict.enabled|buff.empyrean_power.up&debuff.judgment.down&buff.divine_purpose.down&buff.avenging_wrath_autocrit.down
            if (true) then
                VarDsCastable = num(MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 and not A.RighteousVerdict:IsSpellLearned() or MultiUnits:GetByRangeInCombat(8, 5, 10) >= 3 and A.RighteousVerdict:IsSpellLearned() or Unit("player"):HasBuffs(A.EmpyreanPowerBuff.ID, true) and bool(Unit(unit):HasDeBuffsDown(A.JudgmentDebuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.DivinePurposeBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.AvengingWrathAutocritBuff.ID, true)))
            end
            -- inquisition,if=buff.avenging_wrath.down&(buff.inquisition.down|buff.inquisition.remains<8&holy_power>=3|talent.execution_sentence.enabled&cooldown.execution_sentence.remains<10&buff.inquisition.remains<15|cooldown.avenging_wrath.remains<15&buff.inquisition.remains<20&holy_power>=3)
            if A.Inquisition:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.AvengingWrathBuff.ID, true)) and (bool(Unit("player"):HasBuffsDown(A.InquisitionBuff.ID, true)) or Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 8 and Player:HolyPower() >= 3 or A.ExecutionSentence:IsSpellLearned() and A.ExecutionSentence:GetCooldown() < 10 and Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 15 or A.AvengingWrath:GetCooldown() < 15 and Unit("player"):HasBuffs(A.InquisitionBuff.ID, true) < 20 and Player:HolyPower() >= 3)) then
                return A.Inquisition:Show(icon)
            end
            -- execution_sentence,if=spell_targets.divine_storm<=2&(!talent.crusade.enabled&cooldown.avenging_wrath.remains>10|talent.crusade.enabled&buff.crusade.down&cooldown.crusade.remains>10|buff.crusade.stack>=7)
            if A.ExecutionSentence:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) <= 2 and (not A.Crusade:IsSpellLearned() and A.AvengingWrath:GetCooldown() > 10 or A.Crusade:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.CrusadeBuff.ID, true)) and A.Crusade:GetCooldown() > 10 or Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) >= 7)) then
                return A.ExecutionSentence:Show(icon)
            end
            -- divine_storm,if=variable.ds_castable&variable.wings_pool&((!talent.execution_sentence.enabled|(spell_targets.divine_storm>=2|cooldown.execution_sentence.remains>gcd*2))|(cooldown.avenging_wrath.remains>gcd*3&cooldown.avenging_wrath.remains<10|cooldown.crusade.remains>gcd*3&cooldown.crusade.remains<10|buff.crusade.up&buff.crusade.stack<10))
            if A.DivineStorm:IsReady(unit) and (bool(VarDsCastable) and bool(VarWingsPool) and ((not A.ExecutionSentence:IsSpellLearned() or (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2)) or (A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 and A.AvengingWrath:GetCooldown() < 10 or A.Crusade:GetCooldown() > A.GetGCD() * 3 and A.Crusade:GetCooldown() < 10 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) < 10))) then
                return A.DivineStorm:Show(icon)
            end
            -- templars_verdict,if=variable.wings_pool&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*2|cooldown.avenging_wrath.remains>gcd*3&cooldown.avenging_wrath.remains<10|cooldown.crusade.remains>gcd*3&cooldown.crusade.remains<10|buff.crusade.up&buff.crusade.stack<10)
            if A.TemplarsVerdict:IsReady(unit) and (bool(VarWingsPool) and (not A.ExecutionSentence:IsSpellLearned() or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2 or A.AvengingWrath:GetCooldown() > A.GetGCD() * 3 and A.AvengingWrath:GetCooldown() < 10 or A.Crusade:GetCooldown() > A.GetGCD() * 3 and A.Crusade:GetCooldown() < 10 or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true) and Unit("player"):HasBuffsStacks(A.CrusadeBuff.ID, true) < 10)) then
                return A.TemplarsVerdict:Show(icon)
            end
        end
        
        --Generators
        local function Generators(unit)
            -- variable,name=HoW,value=(!talent.hammer_of_wrath.enabled|target.health.pct>=20&!(buff.avenging_wrath.up|buff.crusade.up))
            if (true) then
                VarHow = num((not A.HammerofWrath:IsSpellLearned() or Unit(unit):HealthPercent() >= 20 and not (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true))))
            end
            -- call_action_list,name=finishers,if=holy_power>=5|buff.memory_of_lucid_dreams.up|buff.seething_rage.up|talent.inquisition.enabled&buff.inquisition.down&holy_power>=3
            if (Player:HolyPower() >= 5 or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit("player"):HasBuffs(A.SeethingRageBuff.ID, true) or A.Inquisition:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.InquisitionBuff.ID, true)) and Player:HolyPower() >= 3) then
                local ShouldReturn = Finishers(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- wake_of_ashes,if=(!raid_event.adds.exists|raid_event.adds.in>15|spell_targets.wake_of_ashes>=2)&(holy_power<=0|holy_power=1&cooldown.blade_of_justice.remains>gcd)&(cooldown.avenging_wrath.remains>10|talent.crusade.enabled&cooldown.crusade.remains>10)
            if A.WakeofAshes:IsReady(unit) and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 15 or MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2) and (Player:HolyPower() <= 0 or Player:HolyPower() == 1 and A.BladeofJustice:GetCooldown() > A.GetGCD()) and (A.AvengingWrath:GetCooldown() > 10 or A.Crusade:IsSpellLearned() and A.Crusade:GetCooldown() > 10)) then
                return A.WakeofAshes:Show(icon)
            end
            -- blade_of_justice,if=holy_power<=2|(holy_power=3&(cooldown.hammer_of_wrath.remains>gcd*2|variable.HoW))
            if A.BladeofJustice:IsReady(unit) and (Player:HolyPower() <= 2 or (Player:HolyPower() == 3 and (A.HammerofWrath:GetCooldown() > A.GetGCD() * 2 or bool(VarHow)))) then
                return A.BladeofJustice:Show(icon)
            end
            -- judgment,if=holy_power<=2|(holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|variable.HoW))
            if A.Judgment:IsReady(unit) and (Player:HolyPower() <= 2 or (Player:HolyPower() <= 4 and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or bool(VarHow)))) then
                return A.Judgment:Show(icon)
            end
            -- hammer_of_wrath,if=holy_power<=4
            if A.HammerofWrath:IsReady(unit) and (Player:HolyPower() <= 4) then
                return A.HammerofWrath:Show(icon)
            end
            -- consecration,if=holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2
            if A.Consecration:IsReady(unit) and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2) then
                return A.Consecration:Show(icon)
            end
            -- call_action_list,name=finishers,if=talent.hammer_of_wrath.enabled&target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up
            if (A.HammerofWrath:IsSpellLearned() and Unit(unit):HealthPercent() <= 20 or Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) or Unit("player"):HasBuffs(A.CrusadeBuff.ID, true)) then
                local ShouldReturn = Finishers(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2&cooldown.consecration.remains>gcd*2)
            if A.CrusaderStrike:IsReady(unit) and (A.CrusaderStrike:ChargesFractionalP() >= 1.75 and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2 and A.Consecration:GetCooldown() > A.GetGCD() * 2)) then
                return A.CrusaderStrike:Show(icon)
            end
            -- call_action_list,name=finishers
            if (true) then
                local ShouldReturn = Finishers(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
            -- reaping_flames
            if A.ReapingFlames:IsReady(unit) then
                return A.ReapingFlames:Show(icon)
            end
            -- crusader_strike,if=holy_power<=4
            if A.CrusaderStrike:IsReady(unit) and (Player:HolyPower() <= 4) then
                return A.CrusaderStrike:Show(icon)
            end
            -- arcane_torrent,if=holy_power<=4
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:HolyPower() <= 4) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- rebuke
            if A.Rebuke:IsReady(unit) and Action.GetToggle.InterruptEnabled then
                return A.Rebuke:Show(icon)
            end
            -- call_action_list,name=cooldowns
            if A.BurstIsON(unit) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=generators
            if (true) then
                local ShouldReturn = Generators(unit); if ShouldReturn then return ShouldReturn; end
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

