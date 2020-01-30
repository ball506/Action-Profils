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
Action[ACTION_CONST_ROGUE_ASSASSINATION] = {
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
    ApplyPoison                            = Action.Create({ Type = "Spell", ID =  }),
    MarkedForDeath                         = Action.Create({ Type = "Spell", ID = 137619 }),
    VendettaDebuff                         = Action.Create({ Type = "Spell", ID = 79140 }),
    Vendetta                               = Action.Create({ Type = "Spell", ID = 79140 }),
    Subterfuge                             = Action.Create({ Type = "Spell", ID = 108208 }),
    GarroteDebuff                          = Action.Create({ Type = "Spell", ID = 703 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    RuptureDebuff                          = Action.Create({ Type = "Spell", ID = 1943 }),
    ShroudedSuffocation                    = Action.Create({ Type = "Spell", ID =  }),
    Nightstalker                           = Action.Create({ Type = "Spell", ID = 14062 }),
    Exsanguinate                           = Action.Create({ Type = "Spell", ID = 200806 }),
    DeeperStratagem                        = Action.Create({ Type = "Spell", ID = 193531 }),
    Vanish                                 = Action.Create({ Type = "Spell", ID = 1856 }),
    Garrote                                = Action.Create({ Type = "Spell", ID = 703 }),
    MasterAssassin                         = Action.Create({ Type = "Spell", ID =  }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984 }),
    ToxicBlade                             = Action.Create({ Type = "Spell", ID = 245388 }),
    Envenom                                = Action.Create({ Type = "Spell", ID = 32645 }),
    ToxicBladeDebuff                       = Action.Create({ Type = "Spell", ID = 245389 }),
    FanofKnives                            = Action.Create({ Type = "Spell", ID = 51723 }),
    EchoingBlades                          = Action.Create({ Type = "Spell", ID =  }),
    HiddenBladesBuff                       = Action.Create({ Type = "Spell", ID =  }),
    DoubleDose                             = Action.Create({ Type = "Spell", ID =  }),
    DeadlyPoisonDotDebuff                  = Action.Create({ Type = "Spell", ID = 177918 }),
    Blindside                              = Action.Create({ Type = "Spell", ID =  }),
    BlindsideBuff                          = Action.Create({ Type = "Spell", ID =  }),
    VenomRush                              = Action.Create({ Type = "Spell", ID = 152152 }),
    Mutilate                               = Action.Create({ Type = "Spell", ID = 1329 }),
    Rupture                                = Action.Create({ Type = "Spell", ID = 1943 }),
    PoolResource                           = Action.Create({ Type = "Spell", ID = 9999000010 }),
    CrimsonTempest                         = Action.Create({ Type = "Spell", ID = 121411 }),
    CrimsonTempestBuff                     = Action.Create({ Type = "Spell", ID = 121411 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID =  }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 })
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
Action:CreateEssencesFor(ACTION_CONST_ROGUE_ASSASSINATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_ASSASSINATION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarSingleUnit(unit) = 0;
local VarEnergyRegenCombined = 0;
local VarUseFiller = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarSingleUnit(unit) = 0
  VarEnergyRegenCombined = 0
  VarUseFiller = 0
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

---------------------------------------------------
-------------- ASSASSINATION PREAPL ---------------
---------------------------------------------------
local BleedTickTime, ExsanguinatedBleedTickTime = 2 / Unit("player"):SpellHaste(), 1 / Unit("player"):SpellHaste();
local Stealth;
local RuptureThreshold, RuptureDMGThreshold, GarroteDMGThreshold;
local ComboPoints, ComboPointsDeficit, Energy_Regen_Combined, PoisonedBleeds;
local PriorityRotation;

-- Master Assassin Remains Check
local MasterAssassinBuff, NominalDuration = 256735, 3;
local function MasterAssassinRemains()
    if Unit("player"):HasBuffs(MasterAssassinBuff, true) < 0 then
        return A.GetCurrentGCD() + NominalDuration;
    else
        return Unit("player"):HasBuffs(MasterAssassinBuff, true);
    end
end

function Poisoned (unit)
    return (Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) or Unit(unit):HasDeBuffs(A.WoundPoisonDebuff.ID, true)) and true or false;
end

function Bleeds (unit)
    return (Unit(unit):HasDeBuffs(A.Garrote.ID, true) and 1 or 0) + (Unit(unit):HasDeBuffs(A.Rupture.ID, true) and 1 or 0)
    + (Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) and 1 or 0) + (Unit(unit):HasDeBuffs(A.InternalBleeding.ID, true) and 1 or 0);
end
  
local PoisonedBleedsCount = 0;
function PoisonedBleeds ()
    PoisonedBleedsCount = 0;
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Garrote.ID) -- Garrote count
 	local AppliedInternalBleeding = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.InternalBleeding.ID) -- InternalBleeding count
 	local AppliedRupture = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Rupture.ID) -- Rupture count
	
	PoisonedBleedsCount = AppliedGarrote + AppliedInternalBleeding + AppliedRupture
	
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
    return mathmin(Unit("player"):ComboPoints(), CPMaxSpend());
end

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
        (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and 1.3 or 1) *
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
local function NighstalkerMultiplier ()
    return A.Nightstalker:IsSpellLearned() and Unit("player"):IsStealthed() and 1.5 or 1;
end
local function SubterfugeGarroteMultiplier ()
    return A.Subterfuge:IsSpellLearned() and Unit("player"):IsStealthed() and 2 or 1;
end

RegisterPMultiplier( -- Garrote dot and action
	A.Garrote.ID,    -- Garrote action
	A.GarroteDebuff.ID,  -- GarroteDebuff dot

    {NighstalkerMultiplier},
    {SubterfugeGarroteMultiplier}
)

RegisterPMultiplier( -- Rupture dot and action
	A.Rupture.ID,    -- Rupture action
	A.RuptureDebuff.ID,  -- RuptureDebuff dot

    {NighstalkerMultiplier}
)

-- Spell ID Changes check
Stealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth; -- w/ or w/o Subterfuge Talent

-- Stealth
function Stealth(Stealth, Setting)
    if Action.GetToggle(2, "StealthOOC") and Stealth:IsReady("player") and not Unit("player"):IsStealthed() then
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
    local HPLoosePerSecond = ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax()
		
    if ActionUnit("player"):CombatTime() == 0 then 
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
                ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                -- TTD 
                ActionUnit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        ActionUnit("player"):UseDeff() or 
                        (
                            ActionUnit("player", 5):HasFlags() and 
                            ActionUnit("player"):GetRealTimeDMG() > 0 and 
                            ActionUnit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Evade < 100 and 
            ActionUnit("player"):HealthPercent() <= Evade
        )
    ) 
    then 
        return A.Evade:Show(icon)Cast Evade (Defensives)"; end
    end  
		
    -- Emergency Feint
        local Feint = Action.GetToggle(2, "FeintHP")
        if     Feint >= 0 and A.Feint:IsReady("player") and 
        (
            (   -- Auto 
                Feint >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Feint < 100 and 
                ActionUnit("player"):HealthPercent() <= Feint
            )
        ) 
        then 
            return A.Feint:Show(icon)Cast Evade (Defensives)"; end
        end  		

        -- Emergency CrimsonVial
        local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
        if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
        (
            (   -- Auto 
                CrimsonVial >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CrimsonVial < 100 and 
                ActionUnit("player"):HealthPercent() <= CrimsonVial
            )
        ) 
        then 
            return A.CrimsonVial:Show(icon)Cast Evade (Defensives)"; end
        end  		

        -- Emergency Cloak of Shadow
        local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
        if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
        (
            (   -- Auto 
                CloakofShadow >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CloakofShadow < 100 and 
                ActionUnit("player"):HealthPercent() <= CloakofShadow
            )
        ) 
        then 
            return A.CloakofShadow:Show(icon)Cast Evade (Defensives)"; end
        end 
		
        -- Emergency Vanish
        local Vanish = Action.GetToggle(2, "VanishDefensive")
        if     Vanish >= 0 and A.Vanish:IsReady("player") and 
        (
            (   -- Auto 
                Vanish >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Vanish < 100 and 
                ActionUnit("player"):HealthPercent() <= Vanish
            )
        ) 
    then 
        return A.Vanish:Show(icon)
    end  

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function RefreshPoisons()
    local choice = Action.GetToggle(2, "PoisonToUse")
	
	if A.CripplingPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.CripplingPoison) <= 10 or not Unit("player"):BuffP(A.CripplingPoison)) and not Unit("player"):PrevGCDP(1, A.CripplingPoison) and not Unit("player"):IsCasting() then
	    return A.CripplingPoison:Show(icon)
	end	
	-- Wound Poison
	if choice == "Wound Poison" then 
	    if A.WoundPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.WoundPoison) <= 10 or not Unit("player"):BuffP(A.WoundPoison)) and not Unit("player"):PrevGCDP(1, A.WoundPoison) and not Unit("player"):IsCasting() then 
		    return A.WoundPoison:Show(icon)
        end
	-- Deadly Poison
	elseif choice == "Deadly Poison" then
	    if A.DeadlyPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.DeadlyPoison) <= 10 or not Unit("player"):BuffP(A.DeadlyPoison)) and not Unit("player"):PrevGCDP(1, A.DeadlyPoison) and not Unit("player"):IsCasting() then 
		    return A.DeadlyPoison:Show(icon)
        end
	elseif choice == "Auto" then
	    -- Auto
	    if Action.IsInPvP and A.WoundPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.WoundPoison) <= 10 or not Unit("player"):BuffP(A.WoundPoison)) and not Unit("player"):PrevGCDP(1, A.WoundPoison) and not Unit("player"):IsCasting() then 		
	        return A.WoundPoison:Show(icon)
		else
		    if A.DeadlyPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.DeadlyPoison) <= 10 or not Unit("player"):BuffP(A.DeadlyPoison)) and not Action.IsInPvP and not Unit("player"):PrevGCDP(1, A.DeadlyPoison) and not Unit("player"):IsCasting() then
		        return A.DeadlyPoison:Show(icon)
		    end
	    end
	else
	    return
	end	
end
	
-- Check if the Priority Rotation variable should be set
local function UsePriorityRotation()
    if Cache.EnemiesCount[10] < 2 then
        return false
    end
    if Action.GetToggle(2, "UsePriorityRotation") == "Always" then
        return true
    end
    if Action.GetToggle(2, "UsePriorityRotation") == "On Bosses" and Unit(unit):IsInBossList() then
        return true
    end
    -- Zul Mythic
    if Unit("player"):InstanceDifficulty() == 16 and Unit(unit):NPCID() == 138967 then
        return true
    end
    return false
end

-- Fake ss_buffed (wonky without Subterfuge but why would you, eh?)
local function SSBuffed(unit)
    return A.ShroudedSuffocation:GetAzeriteRank() > 0
end

-- non_ss_buffed_targets
local function NonSSBuffedTargets()
    local count = 0;
    
	local MissingGarrote = MultiUnits:GetByRangeMissedDoTs(10, 5, A.Garrote.ID)   
	
	count = MissingGarrote
	
    return count;
end

-- ss_buffed_targets_above_pandemic
local function SSBuffedTargetsAbovePandemic()
    local count = 0;
    local GarroteToRefresh = MultiUnits:GetByRangeDoTsToRefresh(10, 5, A.Garrote.ID, 5.4)
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(10, 5, A.Garrote.ID) -- Garrote count

    count = AppliedGarrote - GarroteToRefresh

    return count;
end


local function EvaluateTargetIfFilterMarkedForDeath45(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath50(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() * 1.5 or Player:ComboPointsDeficit() >= CPMaxSpend())
end


local function EvaluateCycleFanofKnives183(unit)
    return (not Unit(unit):HasDeBuffs(A.DeadlyPoisonDotDebuff.ID, true)) and (bool(VarUseFiller) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3)
end

local function EvaluateCycleMutilate204(unit)
    return (not Unit(unit):HasDeBuffs(A.DeadlyPoisonDotDebuff.ID, true)) and (bool(VarUseFiller) and MultiUnits:GetByRangeInCombat(10, 5, 10) == 2)
end

local function EvaluateCycleGarrote233(unit)
  return (not A.Subterfuge:IsSpellLearned() or not (A.Vanish:GetCooldown() == 0 and A.Vendetta:GetCooldown() <= 4)) and Player:ComboPointsDeficit() >= 1 and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and (A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not A.Exsanguinated(Unit(unit), "Garrote") or Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= A.GarroteDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and not bool(ss_buffed) and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 4 and MultiUnits:GetByRangeInCombat(10, 5, 10) <= 1 or Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 12)
end

local function EvaluateCycleRupture322(unit)
  return Player:ComboPoints() >= 4 and Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true) and (A.PMultiplier(unit, A.RuptureDebuff.ID) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and (not A.Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) <= A.RuptureDebuff.ID, true:TickTime() * 2 and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3 + A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4
end

local function EvaluateCycleGarrote399(unit)
  return A.Subterfuge:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 2
end

local function EvaluateCycleGarrote420(unit)
  return A.Subterfuge:IsSpellLearned() and Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) <= 10 and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) > 2
end

local function EvaluateCycleGarrote455(unit)
  return A.Subterfuge:IsSpellLearned() and bool(A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):TimeToDie() > Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and Player:ComboPointsDeficit() > 1
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
        local Precombat, Cds, Direct, Dot, Stealthed
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- apply_poison
            if A.ApplyPoison:IsReady(unit) then
                return A.ApplyPoison:Show(icon)
            end
            -- stealth
            if A.Stealth:IsReady(unit) then
                return A.Stealth:Show(icon)
            end
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>40
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 40) then
                return A.MarkedForDeath:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- potion,if=buff.bloodlust.react|debuff.vendetta.up
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism() or Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                A.ProlongedPower:Show(icon)
            end
            -- use_item,name=galecallers_boon,if=cooldown.vendetta.remains<=1&(!talent.subterfuge.enabled|dot.garrote.pmultiplier>1)|cooldown.vendetta.remains>45
            if A.GalecallersBoon:IsReady(unit) and (A.Vendetta:GetCooldown() <= 1 and (not A.Subterfuge:IsSpellLearned() or A.PMultiplier(unit, A.GarroteDebuff.ID) > 1) or A.Vendetta:GetCooldown() > 45) then
                A.GalecallersBoon:Show(icon)
            end
            -- blood_fury,if=debuff.vendetta.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=debuff.vendetta.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=debuff.vendetta.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=debuff.vendetta.up
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit*1.5|combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath45, EvaluateTargetIfMarkedForDeath50) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 30 - raid_event.adds.duration and Player:ComboPointsDeficit() >= CPMaxSpend()) then
                return A.MarkedForDeath:Show(icon)
            end
            -- vendetta,if=!stealthed.rogue&dot.rupture.ticking&(!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1)&(!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled)
            if A.Vendetta:IsReady(unit) and (not Unit("player"):IsStealthed(true, false) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and (not A.Subterfuge:IsSpellLearned() or not bool(A.ShroudedSuffocation:GetAzeriteRank()) or A.PMultiplier(unit, A.GarroteDebuff.ID) > 1) and (not A.Nightstalker:IsSpellLearned() or not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() < 5 - 2 * num(A.DeeperStratagem:IsSpellLearned()))) then
                return A.Vendetta:Show(icon)
            end
            -- vanish,if=talent.subterfuge.enabled&!dot.garrote.ticking&variable.single_target
            if A.Vanish:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and not Unit(unit):HasDeBuffs(A.GarroteDebuff.ID, true) and bool(VarSingleUnit(unit))) then
                return A.Vanish:Show(icon)
            end
            -- vanish,if=talent.exsanguinate.enabled&(talent.nightstalker.enabled|talent.subterfuge.enabled&variable.single_target)&combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1&(!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier<=1)
            if A.Vanish:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and (A.Nightstalker:IsSpellLearned() or A.Subterfuge:IsSpellLearned() and bool(VarSingleUnit(unit))) and Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1 and (not A.Subterfuge:IsSpellLearned() or not bool(A.ShroudedSuffocation:GetAzeriteRank()) or A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1)) then
                return A.Vanish:Show(icon)
            end
            -- vanish,if=talent.nightstalker.enabled&!talent.exsanguinate.enabled&combo_points>=cp_max_spend&debuff.vendetta.up
            if A.Vanish:IsReady(unit) and (A.Nightstalker:IsSpellLearned() and not A.Exsanguinate:IsSpellLearned() and Player:ComboPoints() >= CPMaxSpend() and Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true)) then
                return A.Vanish:Show(icon)
            end
            -- vanish,if=talent.subterfuge.enabled&(!talent.exsanguinate.enabled|!variable.single_target)&!stealthed.rogue&cooldown.garrote.up&dot.garrote.refreshable&(spell_targets.fan_of_knives<=3&combo_points.deficit>=1+spell_targets.fan_of_knives|spell_targets.fan_of_knives>=4&combo_points.deficit>=4)
            if A.Vanish:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and (not A.Exsanguinate:IsSpellLearned() or not bool(VarSingleUnit(unit))) and not Unit("player"):IsStealthed(true, false) and A.Garrote:GetCooldown() == 0 and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and (MultiUnits:GetByRangeInCombat(10, 5, 10) <= 3 and Player:ComboPointsDeficit() >= 1 + MultiUnits:GetByRangeInCombat(10, 5, 10) or MultiUnits:GetByRangeInCombat(10, 5, 10) >= 4 and Player:ComboPointsDeficit() >= 4)) then
                return A.Vanish:Show(icon)
            end
            -- vanish,if=talent.master_assassin.enabled&!stealthed.all&master_assassin_remains<=0&!dot.rupture.refreshable
            if A.Vanish:IsReady(unit) and (A.MasterAssassin:IsSpellLearned() and not Unit("player"):IsStealthed(true, true) and MasterAssassinRemains <= 0 and not Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff.ID, true)) then
                return A.Vanish:Show(icon)
            end
            -- shadowmeld,if=!stealthed.all&azerite.shrouded_suffocation.enabled&dot.garrote.refreshable&dot.garrote.pmultiplier<=1&combo_points.deficit>=1
            if A.Shadowmeld:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not Unit("player"):IsStealthed(true, true) and bool(A.ShroudedSuffocation:GetAzeriteRank()) and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true) and A.PMultiplier(unit, A.GarroteDebuff.ID) <= 1 and Player:ComboPointsDeficit() >= 1) then
                return A.Shadowmeld:Show(icon)
            end
            -- exsanguinate,if=dot.rupture.remains>4+4*cp_max_spend&!dot.garrote.refreshable
            if A.Exsanguinate:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 4 + 4 * CPMaxSpend() and not Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff.ID, true)) then
                return A.Exsanguinate:Show(icon)
            end
            -- toxic_blade,if=dot.rupture.ticking
            if A.ToxicBlade:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true)) then
                return A.ToxicBlade:Show(icon)
            end
        end
        
        --Direct
        local function Direct(unit)
            -- envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target)&(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)
            if A.Envenom:IsReady(unit) and (Player:ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.VendettaDebuff.ID, true) or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) or Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not bool(VarSingleUnit(unit))) and (not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() > 2)) then
                return A.Envenom:Show(icon)
            end
            -- variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target
            if (true) then
                VarUseFiller = num(Player:ComboPointsDeficit() > 1 or Player:EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not bool(VarSingleUnit(unit)))
            end
            -- fan_of_knives,if=variable.use_filler&azerite.echoing_blades.enabled&spell_targets.fan_of_knives>=2
            if A.FanofKnives:IsReady(unit) and (bool(VarUseFiller) and bool(A.EchoingBlades:GetAzeriteRank()) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2) then
                return A.FanofKnives:Show(icon)
            end
            -- fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue)
            if A.FanofKnives:IsReady(unit) and (bool(VarUseFiller) and (Unit("player"):HasBuffsStacks(A.HiddenBladesBuff.ID, true) >= 19 or MultiUnits:GetByRangeInCombat(10, 5, 10) >= 4 + num((A.DoubleDose:GetAzeriteRank() > 2)) + num(Unit("player"):IsStealthed(true, false)))) then
                return A.FanofKnives:Show(icon)
            end
            -- fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3
            if A.FanofKnives:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FanofKnives, 10, "min", EvaluateCycleFanofKnives183) then
                    return A.FanofKnives:Show(icon) 
                end
            end
            -- blindside,if=variable.use_filler&(buff.blindside.up|!talent.venom_rush.enabled&!azerite.double_dose.enabled)
            if A.Blindside:IsReady(unit) and (bool(VarUseFiller) and (Unit("player"):HasBuffs(A.BlindsideBuff.ID, true) or not A.VenomRush:IsSpellLearned() and not bool(A.DoubleDose:GetAzeriteRank()))) then
                return A.Blindside:Show(icon)
            end
            -- mutilate,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives=2
            if A.Mutilate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Mutilate, 40, "min", EvaluateCycleMutilate204) then
                    return A.Mutilate:Show(icon) 
                end
            end
            -- mutilate,if=variable.use_filler
            if A.Mutilate:IsReady(unit) and (bool(VarUseFiller)) then
                return A.Mutilate:Show(icon)
            end
        end
        
        --Dot
        local function Dot(unit)
            -- rupture,if=talent.exsanguinate.enabled&((combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1)|(!ticking&(time>10|combo_points>=2)))
            if A.Rupture:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and ((Player:ComboPoints() >= CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1) or (not Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) and (Unit("player"):CombatTime() > 10 or Player:ComboPoints() >= 2)))) then
                return A.Rupture:Show(icon)
            end
            -- pool_resource,for_next=1
            -- garrote,cycle_targets=1,if=(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains>4&spell_targets.fan_of_knives<=1|target.time_to_die-remains>12)
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateCycleGarrote233) then
                    return A.Garrote:Show(icon) 
                end
            end
            -- crimson_tempest,if=spell_targets>=2&remains<2+(spell_targets>=5)&combo_points>=4
            if A.CrimsonTempest:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and Unit("player"):HasBuffs(A.CrimsonTempestBuff.ID, true) < 2 + num((MultiUnits:GetByRangeInCombat(40, 5, 10) >= 5)) and Player:ComboPoints() >= 4) then
                return A.CrimsonTempest:Show(icon)
            end
            -- rupture,cycle_targets=1,if=combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
            if A.Rupture:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rupture, 5, "min", EvaluateCycleRupture322) then
                    return A.Rupture:Show(icon) 
                end
            end
        end
        
        --Stealthed
        local function Stealthed(unit)
            -- rupture,if=combo_points>=4&(talent.nightstalker.enabled|talent.subterfuge.enabled&(talent.exsanguinate.enabled&cooldown.exsanguinate.remains<=2|!ticking)&variable.single_target)&target.time_to_die-remains>6
            if A.Rupture:IsReady(unit) and (Player:ComboPoints() >= 4 and (A.Nightstalker:IsSpellLearned() or A.Subterfuge:IsSpellLearned() and (A.Exsanguinate:IsSpellLearned() and A.Exsanguinate:GetCooldown() <= 2 or not Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true)) and bool(VarSingleUnit(unit))) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 6) then
                return A.Rupture:Show(icon)
            end
            -- garrote,cycle_targets=1,if=talent.subterfuge.enabled&refreshable&target.time_to_die-remains>2
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateCycleGarrote399) then
                    return A.Garrote:Show(icon) 
                end
            end
            -- garrote,cycle_targets=1,if=talent.subterfuge.enabled&remains<=10&pmultiplier<=1&target.time_to_die-remains>2
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateCycleGarrote420) then
                    return A.Garrote:Show(icon) 
                end
            end
            -- rupture,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&!dot.rupture.ticking
            if A.Rupture:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and bool(A.ShroudedSuffocation:GetAzeriteRank()) and not Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true)) then
                return A.Rupture:Show(icon)
            end
            -- garrote,cycle_targets=1,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&target.time_to_die>remains&combo_points.deficit>1
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateCycleGarrote455) then
                    return A.Garrote:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- garrote,if=talent.subterfuge.enabled&talent.exsanguinate.enabled&cooldown.exsanguinate.remains<1&prev_gcd.1.rupture&dot.rupture.remains>5+4*cp_max_spend
            if A.Garrote:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.Exsanguinate:IsSpellLearned() and A.Exsanguinate:GetCooldown() < 1 and Unit("player"):GetSpellLastCast(A.Rupture) and Unit(unit):HasDeBuffs(A.RuptureDebuff.ID, true) > 5 + 4 * CPMaxSpend()) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
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
                VarSingleUnit(unit) = num(MultiUnits:GetByRangeInCombat(10, 5, 10) < 2)
            end
            -- call_action_list,name=stealthed,if=stealthed.rogue
            if (Unit("player"):IsStealthed(true, false)) then
                local ShouldReturn = Stealthed(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cds
            if (true) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=dot
            if (true) then
                local ShouldReturn = Dot(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=direct
            if (true) then
                local ShouldReturn = Direct(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- arcane_torrent,if=energy.deficit>=15+variable.energy_regen_combined
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:EnergyDeficitPredicted() >= 15 + VarEnergyRegenCombined) then
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

