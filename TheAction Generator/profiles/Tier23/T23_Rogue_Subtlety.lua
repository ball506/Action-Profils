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
Action[ACTION_CONST_ROGUE_SUBTLETY] = {
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
    StealthBuff                            = Action.Create({ Type = "Spell", ID = 1784 }),
    MarkedForDeath                         = Action.Create({ Type = "Spell", ID = 137619 }),
    ShadowBladesBuff                       = Action.Create({ Type = "Spell", ID = 121471 }),
    ShadowBlades                           = Action.Create({ Type = "Spell", ID = 121471 }),
    ShurikenStorm                          = Action.Create({ Type = "Spell", ID = 197835 }),
    Gloomblade                             = Action.Create({ Type = "Spell", ID = 200758 }),
    Backstab                               = Action.Create({ Type = "Spell", ID = 53 }),
    SymbolsofDeathBuff                     = Action.Create({ Type = "Spell", ID = 212283 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    ShadowDance                            = Action.Create({ Type = "Spell", ID = 185313 }),
    ShadowDanceBuff                        = Action.Create({ Type = "Spell", ID = 185313 }),
    ShurikenTornadoBuff                    = Action.Create({ Type = "Spell", ID =  }),
    SymbolsofDeath                         = Action.Create({ Type = "Spell", ID = 212283 }),
    NightbladeDebuff                       = Action.Create({ Type = "Spell", ID = 195452 }),
    ShurikenTornado                        = Action.Create({ Type = "Spell", ID =  }),
    ShadowFocus                            = Action.Create({ Type = "Spell", ID = 108209 }),
    Subterfuge                             = Action.Create({ Type = "Spell", ID = 108208 }),
    Eviscerate                             = Action.Create({ Type = "Spell", ID = 196819 }),
    NightsVengeanceBuff                    = Action.Create({ Type = "Spell", ID =  }),
    SecretTechnique                        = Action.Create({ Type = "Spell", ID =  }),
    Nightblade                             = Action.Create({ Type = "Spell", ID = 195452 }),
    DarkShadow                             = Action.Create({ Type = "Spell", ID = 245687 }),
    NightsVengeance                        = Action.Create({ Type = "Spell", ID =  }),
    ReplicatingShadows                     = Action.Create({ Type = "Spell", ID =  }),
    Nightstalker                           = Action.Create({ Type = "Spell", ID = 14062 }),
    Vanish                                 = Action.Create({ Type = "Spell", ID = 1856 }),
    FindWeaknessDebuff                     = Action.Create({ Type = "Spell", ID =  }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984 }),
    PoolResource                           = Action.Create({ Type = "Spell", ID = 9999000010 }),
    TheFirstDance                          = Action.Create({ Type = "Spell", ID =  }),
    Shadowstrike                           = Action.Create({ Type = "Spell", ID = 185438 }),
    DeeperStratagem                        = Action.Create({ Type = "Spell", ID = 193531 }),
    VanishBuff                             = Action.Create({ Type = "Spell", ID = 1856 }),
    FindWeakness                           = Action.Create({ Type = "Spell", ID =  }),
    BladeIntheShadows                      = Action.Create({ Type = "Spell", ID =  }),
    Vigor                                  = Action.Create({ Type = "Spell", ID = 14983 }),
    MasterofShadows                        = Action.Create({ Type = "Spell", ID =  }),
    Alacrity                               = Action.Create({ Type = "Spell", ID =  }),
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
Action:CreateEssencesFor(ACTION_CONST_ROGUE_SUBTLETY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_SUBTLETY], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarUsePriorityRotation = 0;
local VarShdThreshold = 0;
local VarStealthThreshold = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarUsePriorityRotation = 0
  VarShdThreshold = 0
  VarStealthThreshold = 0
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


local function EvaluateTargetIfFilterMarkedForDeath83(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath88(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() or not Unit("player"):IsStealthed(true, true) and Player:ComboPointsDeficit() >= CPMaxSpend())
end


local function EvaluateCycleNightblade169(unit)
  return not bool(VarUsePriorityRotation) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 and (bool(A.NightsVengeance:GetAzeriteRank()) or not bool(A.ReplicatingShadows:GetAzeriteRank()) or MultiUnits:GetByRangeInCombat(10, 5, 10) - A.NightbladeDebuff.ID, true:ActiveDot >= 2) and not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and Unit(unit):TimeToDie() >= (5 + (2 * Player:ComboPoints())) and Unit(unit):HasDeBuffsRefreshable(A.NightbladeDebuff.ID, true)
end

local function EvaluateCycleShadowstrike290(unit)
  return A.SecretTechnique:IsSpellLearned() and A.FindWeakness:IsSpellLearned() and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 and MultiUnits:GetByRangeInCombat(10, 5, 10) == 2 and Unit(unit):TimeToDie() - remains > 6
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
        local Precombat, Build, Cds, Finish, StealthCds, Stealthed
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- stealth
            if A.Stealth:IsReady(unit) and Unit("player"):HasBuffsDown(A.StealthBuff.ID, true) then
                return A.Stealth:Show(icon)
            end
            -- marked_for_death,precombat_seconds=15
            if A.MarkedForDeath:IsReady(unit) then
                return A.MarkedForDeath:Show(icon)
            end
            -- shadow_blades,precombat_seconds=1
            if A.ShadowBlades:IsReady(unit) and Unit("player"):HasBuffsDown(A.ShadowBladesBuff.ID, true) then
                return A.ShadowBlades:Show(icon)
            end
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
        end
        
        --Build
        local function Build(unit)
            -- shuriken_storm,if=spell_targets>=2
            if A.ShurikenStorm:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2) then
                return A.ShurikenStorm:Show(icon)
            end
            -- gloomblade
            if A.Gloomblade:IsReady(unit) then
                return A.Gloomblade:Show(icon)
            end
            -- backstab
            if A.Backstab:IsReady(unit) then
                return A.Backstab:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- potion,if=buff.bloodlust.react|buff.symbols_of_death.up&(buff.shadow_blades.up|cooldown.shadow_blades.remains<=10)
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism() or Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and (Unit("player"):HasBuffs(A.ShadowBladesBuff.ID, true) or A.ShadowBlades:GetCooldown() <= 10)) then
                A.ProlongedPower:Show(icon)
            end
            -- use_item,name=variable_intensity_gigavolt_oscillating_reactor,if=buff.symbols_of_death.up|target.time_to_die<20
            if A.VariableIntensityGigavoltOscillatingReactor:IsReady(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) or Unit(unit):TimeToDie() < 20) then
                A.VariableIntensityGigavoltOscillatingReactor:Show(icon)
            end
            -- blood_fury,if=buff.symbols_of_death.up
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=buff.symbols_of_death.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=buff.symbols_of_death.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=buff.symbols_of_death.up
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            -- shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.ShadowDance:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) <= 3.5) then
                return A.ShadowDance:Show(icon)
            end
            -- symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.SymbolsofDeath:IsReady(unit) and (Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) <= 3.5) then
                return A.SymbolsofDeath:Show(icon)
            end
            -- symbols_of_death,if=dot.nightblade.ticking&(!talent.shuriken_tornado.enabled|talent.shadow_focus.enabled|spell_targets.shuriken_storm<3|!cooldown.shuriken_tornado.up)
            if A.SymbolsofDeath:IsReady(unit) and (Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) and (not A.ShurikenTornado:IsSpellLearned() or A.ShadowFocus:IsSpellLearned() or MultiUnits:GetByRangeInCombat(10, 5, 10) < 3 or not A.ShurikenTornado:GetCooldown() == 0)) then
                return A.SymbolsofDeath:Show(icon)
            end
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath83, EvaluateTargetIfMarkedForDeath88) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&!stealthed.all&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 30 - raid_event.adds.duration and not Unit("player"):IsStealthed(true, true) and Player:ComboPointsDeficit() >= CPMaxSpend()) then
                return A.MarkedForDeath:Show(icon)
            end
            -- shadow_blades,if=combo_points.deficit>=2+stealthed.all
            if A.ShadowBlades:IsReady(unit) and (Player:ComboPointsDeficit() >= 2 + num(Unit("player"):IsStealthed(true, true))) then
                return A.ShadowBlades:Show(icon)
            end
            -- shuriken_tornado,if=spell_targets>=3&!talent.shadow_focus.enabled&dot.nightblade.ticking&!stealthed.all&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1
            if A.ShurikenTornado:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and not A.ShadowFocus:IsSpellLearned() and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) and not Unit("player"):IsStealthed(true, true) and A.SymbolsofDeath:GetCooldown() == 0 and A.ShadowDance:ChargesP() >= 1) then
                return A.ShurikenTornado:Show(icon)
            end
            -- shuriken_tornado,if=spell_targets>=3&talent.shadow_focus.enabled&dot.nightblade.ticking&buff.symbols_of_death.up
            if A.ShurikenTornado:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and A.ShadowFocus:IsSpellLearned() and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.ShurikenTornado:Show(icon)
            end
            -- shadow_dance,if=!buff.shadow_dance.up&target.time_to_die<=5+talent.subterfuge.enabled&!raid_event.adds.up
            if A.ShadowDance:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and Unit(unit):TimeToDie() <= 5 + num(A.Subterfuge:IsSpellLearned()) and not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.ShadowDance:Show(icon)
            end
        end
        
        --Finish
        local function Finish(unit)
            -- eviscerate,if=talent.shadow_focus.enabled&buff.nights_vengeance.up&spell_targets.shuriken_storm>=2+3*talent.secret_technique.enabled
            if A.Eviscerate:IsReady(unit) and (A.ShadowFocus:IsSpellLearned() and Unit("player"):HasBuffs(A.NightsVengeanceBuff.ID, true) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 + 3 * num(A.SecretTechnique:IsSpellLearned())) then
                return A.Eviscerate:Show(icon)
            end
            -- nightblade,if=(!talent.dark_shadow.enabled|!buff.shadow_dance.up)&target.time_to_die-remains>6&remains<tick_time*2
            if A.Nightblade:IsReady(unit) and ((not A.DarkShadow:IsSpellLearned() or not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true)) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) > 6 and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) < A.NightbladeDebuff.ID, true:TickTime() * 2) then
                return A.Nightblade:Show(icon)
            end
            -- nightblade,cycle_targets=1,if=!variable.use_priority_rotation&spell_targets.shuriken_storm>=2&(azerite.nights_vengeance.enabled|!azerite.replicating_shadows.enabled|spell_targets.shuriken_storm-active_dot.nightblade>=2)&!buff.shadow_dance.up&target.time_to_die>=(5+(2*combo_points))&refreshable
            if A.Nightblade:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Nightblade, 40, "min", EvaluateCycleNightblade169) then
                    return A.Nightblade:Show(icon) 
                end
            end
            -- nightblade,if=remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
            if A.Nightblade:IsReady(unit) and (Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) < A.SymbolsofDeath:GetCooldown() + 10 and A.SymbolsofDeath:GetCooldown() <= 5 and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) > A.SymbolsofDeath:GetCooldown() + 5) then
                return A.Nightblade:Show(icon)
            end
            -- secret_technique,if=buff.symbols_of_death.up&(!talent.dark_shadow.enabled|buff.shadow_dance.up)
            if A.SecretTechnique:IsReady(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and (not A.DarkShadow:IsSpellLearned() or Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true))) then
                return A.SecretTechnique:Show(icon)
            end
            -- secret_technique,if=spell_targets.shuriken_storm>=2+talent.dark_shadow.enabled+talent.nightstalker.enabled
            if A.SecretTechnique:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2 + num(A.DarkShadow:IsSpellLearned()) + num(A.Nightstalker:IsSpellLearned())) then
                return A.SecretTechnique:Show(icon)
            end
            -- eviscerate
            if A.Eviscerate:IsReady(unit) then
                return A.Eviscerate:Show(icon)
            end
        end
        
        --StealthCds
        local function StealthCds(unit)
            -- variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=1.75
            if (true) then
                VarShdThreshold = num(A.ShadowDance:ChargesFractionalP() >= 1.75)
            end
            -- vanish,if=!variable.shd_threshold&debuff.find_weakness.remains<1&combo_points.deficit>1
            if A.Vanish:IsReady(unit) and (not bool(VarShdThreshold) and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 and Player:ComboPointsDeficit() > 1) then
                return A.Vanish:Show(icon)
            end
            -- pool_resource,for_next=1,extra_amount=40
            -- shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&debuff.find_weakness.remains<1&combo_points.deficit>1
            if A.Shadowmeld:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:EnergyPredicted() >= 40 and Player:EnergyDeficitPredicted() >= 10 and not bool(VarShdThreshold) and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 and Player:ComboPointsDeficit() > 1) then
                if A.Shadowmeld:IsUsablePPool(40) then
                    return A.Shadowmeld:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- shadow_dance,if=(!talent.dark_shadow.enabled|dot.nightblade.remains>=5+talent.subterfuge.enabled)&(!talent.nightstalker.enabled&!talent.dark_shadow.enabled|!variable.use_priority_rotation|combo_points.deficit<=1+2*azerite.the_first_dance.enabled)&(variable.shd_threshold|buff.symbols_of_death.remains>=1.2|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10)
            if A.ShadowDance:IsReady(unit) and ((not A.DarkShadow:IsSpellLearned() or Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) >= 5 + num(A.Subterfuge:IsSpellLearned())) and (not A.Nightstalker:IsSpellLearned() and not A.DarkShadow:IsSpellLearned() or not bool(VarUsePriorityRotation) or Player:ComboPointsDeficit() <= 1 + 2 * A.TheFirstDance:GetAzeriteRank()) and (bool(VarShdThreshold) or Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) >= 1.2 or MultiUnits:GetByRangeInCombat(10, 5, 10) >= 4 and A.SymbolsofDeath:GetCooldown() > 10)) then
                return A.ShadowDance:Show(icon)
            end
            -- shadow_dance,if=target.time_to_die<cooldown.symbols_of_death.remains&!raid_event.adds.up
            if A.ShadowDance:IsReady(unit) and (Unit(unit):TimeToDie() < A.SymbolsofDeath:GetCooldown() and not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.ShadowDance:Show(icon)
            end
        end
        
        --Stealthed
        local function Stealthed(unit)
            -- shadowstrike,if=buff.stealth.up
            if A.Shadowstrike:IsReady(unit) and (Unit("player"):HasBuffs(A.StealthBuff.ID, true)) then
                return A.Shadowstrike:Show(icon)
            end
            -- call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&(buff.vanish.up|azerite.the_first_dance.enabled&!talent.dark_shadow.enabled&!talent.subterfuge.enabled))
            if (Player:ComboPointsDeficit() <= 1 - num((A.DeeperStratagem:IsSpellLearned() and (Unit("player"):HasBuffs(A.VanishBuff.ID, true) or bool(A.TheFirstDance:GetAzeriteRank()) and not A.DarkShadow:IsSpellLearned() and not A.Subterfuge:IsSpellLearned())))) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- shadowstrike,cycle_targets=1,if=talent.secret_technique.enabled&talent.find_weakness.enabled&debuff.find_weakness.remains<1&spell_targets.shuriken_storm=2&target.time_to_die-remains>6
            if A.Shadowstrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Shadowstrike, 40, "min", EvaluateCycleShadowstrike290) then
                    return A.Shadowstrike:Show(icon) 
                end
            end
            -- shadowstrike,if=!talent.deeper_stratagem.enabled&azerite.blade_in_the_shadows.rank=3&spell_targets.shuriken_storm=3
            if A.Shadowstrike:IsReady(unit) and (not A.DeeperStratagem:IsSpellLearned() and A.BladeIntheShadows:GetAzeriteRank() == 3 and MultiUnits:GetByRangeInCombat(10, 5, 10) == 3) then
                return A.Shadowstrike:Show(icon)
            end
            -- shuriken_storm,if=spell_targets>=3
            if A.ShurikenStorm:IsReady(unit) and (MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3) then
                return A.ShurikenStorm:Show(icon)
            end
            -- shadowstrike
            if A.Shadowstrike:IsReady(unit) then
                return A.Shadowstrike:Show(icon)
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
            -- call_action_list,name=cds
            if (true) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- run_action_list,name=stealthed,if=stealthed.all
            if (Unit("player"):IsStealthed(true, true)) then
                return Stealthed(unit);
            end
            -- nightblade,if=target.time_to_die>6&remains<gcd.max&combo_points>=4-(time<10)*2
            if A.Nightblade:IsReady(unit) and (Unit(unit):TimeToDie() > 6 and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) < A.GetGCD() and Player:ComboPoints() >= 4 - num((Unit("player"):CombatTime() < 10)) * 2) then
                return A.Nightblade:Show(icon)
            end
            -- variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
            if (true) then
                VarUsePriorityRotation = num(bool(priority_rotation) and MultiUnits:GetByRangeInCombat(10, 5, 10) >= 2)
            end
            -- call_action_list,name=stealth_cds,if=variable.use_priority_rotation
            if (bool(VarUsePriorityRotation)) then
                local ShouldReturn = StealthCds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- variable,name=stealth_threshold,value=25+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+talent.shadow_focus.enabled*20+talent.alacrity.enabled*10+15*(spell_targets.shuriken_storm>=3)
            if (true) then
                VarStealthThreshold = 25 + num(A.Vigor:IsSpellLearned()) * 35 + num(A.MasterofShadows:IsSpellLearned()) * 25 + num(A.ShadowFocus:IsSpellLearned()) * 20 + num(A.Alacrity:IsSpellLearned()) * 10 + 15 * num((MultiUnits:GetByRangeInCombat(10, 5, 10) >= 3))
            end
            -- call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold&combo_points.deficit>=4
            if (Player:EnergyDeficitPredicted() <= VarStealthThreshold and Player:ComboPointsDeficit() >= 4) then
                local ShouldReturn = StealthCds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold&talent.dark_shadow.enabled&talent.secret_technique.enabled&cooldown.secret_technique.up&spell_targets.shuriken_storm<=4
            if (Player:EnergyDeficitPredicted() <= VarStealthThreshold and A.DarkShadow:IsSpellLearned() and A.SecretTechnique:IsSpellLearned() and A.SecretTechnique:GetCooldown() == 0 and MultiUnits:GetByRangeInCombat(10, 5, 10) <= 4) then
                local ShouldReturn = StealthCds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=finish,if=combo_points.deficit<=1|target.time_to_die<=1&combo_points>=3
            if (Player:ComboPointsDeficit() <= 1 or Unit(unit):TimeToDie() <= 1 and Player:ComboPoints() >= 3) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
            if (MultiUnits:GetByRangeInCombat(10, 5, 10) == 4 and Player:ComboPoints() >= 4) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
            if (Player:EnergyDeficitPredicted() <= VarStealthThreshold) then
                local ShouldReturn = Build(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- arcane_torrent,if=energy.deficit>=15+energy.regen
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:EnergyDeficitPredicted() >= 15 + Player:EnergyRegen()) then
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

