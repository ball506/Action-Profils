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
Action[ACTION_CONST_DEATHKNIGHT_UNHOLY] = {
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
    RaiseDead                              = Action.Create({ Type = "Spell", ID = 46584 }),
    ArmyoftheDead                          = Action.Create({ Type = "Spell", ID = 42650 }),
    DeathandDecay                          = Action.Create({ Type = "Spell", ID = 43265 }),
    Apocalypse                             = Action.Create({ Type = "Spell", ID = 275699 }),
    Defile                                 = Action.Create({ Type = "Spell", ID = 152280 }),
    Epidemic                               = Action.Create({ Type = "Spell", ID = 207317 }),
    DeathCoil                              = Action.Create({ Type = "Spell", ID = 47541 }),
    ScourgeStrike                          = Action.Create({ Type = "Spell", ID = 55090 }),
    ClawingShadows                         = Action.Create({ Type = "Spell", ID = 207311 }),
    FesteringStrike                        = Action.Create({ Type = "Spell", ID = 85948 }),
    FesteringWoundDebuff                   = Action.Create({ Type = "Spell", ID = 194310 }),
    BurstingSores                          = Action.Create({ Type = "Spell", ID = 207264 }),
    SuddenDoomBuff                         = Action.Create({ Type = "Spell", ID = 81340 }),
    UnholyFrenzyBuff                       = Action.Create({ Type = "Spell", ID = 207289 }),
    DarkTransformation                     = Action.Create({ Type = "Spell", ID = 63560 }),
    SummonGargoyle                         = Action.Create({ Type = "Spell", ID = 49206 }),
    UnholyFrenzy                           = Action.Create({ Type = "Spell", ID = 207289 }),
    MagusoftheDead                         = Action.Create({ Type = "Spell", ID = 288417 }),
    SoulReaper                             = Action.Create({ Type = "Spell", ID = 130736 }),
    UnholyBlight                           = Action.Create({ Type = "Spell", ID = 115989 }),
    Pestilence                             = Action.Create({ Type = "Spell", ID = 277234 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArmyoftheDamned                        = Action.Create({ Type = "Spell", ID = 276837 }),
    Outbreak                               = Action.Create({ Type = "Spell", ID = 77575 }),
    VirulentPlagueDebuff                   = Action.Create({ Type = "Spell", ID = 191587 })
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
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_UNHOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_UNHOLY], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPoolingForGargoyle = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarPoolingForGargoyle = 0
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


local function EvaluateCycleFesteringStrike42(unit)
    return Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 1 and bool(A.DeathandDecay:GetCooldown())
end

local function EvaluateCycleSoulReaper167(unit)
    return Unit(unit):TimeToDie() < 8 and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleOutbreak401(unit)
    return Unit(unit):HasDeBuffs(A.VirulentPlagueDebuff.ID, true) <= A.GetGCD()
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
        local Precombat, Aoe, Cooldowns, Essences, Generic
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
            -- raise_dead
            if A.RaiseDead:IsReady(unit) then
                return A.RaiseDead:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- army_of_the_dead,delay=2
            if A.ArmyoftheDead:IsReady(unit) then
                return A.ArmyoftheDead:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
            -- death_and_decay,if=cooldown.apocalypse.remains
            if A.DeathandDecay:IsReady(unit) and (bool(A.Apocalypse:GetCooldown())) then
                return A.DeathandDecay:Show(icon)
            end
            -- defile
            if A.Defile:IsReady(unit) then
                return A.Defile:Show(icon)
            end
            -- epidemic,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady(unit) and (bool(death_and_decay.ticking) and Player:Rune() < 2 and not bool(VarPoolingForGargoyle)) then
                return A.Epidemic:Show(icon)
            end
            -- death_coil,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (bool(death_and_decay.ticking) and Player:Rune() < 2 and not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
            -- scourge_strike,if=death_and_decay.ticking&cooldown.apocalypse.remains
            if A.ScourgeStrike:IsReady(unit) and (bool(death_and_decay.ticking) and bool(A.Apocalypse:GetCooldown())) then
                return A.ScourgeStrike:Show(icon)
            end
            -- clawing_shadows,if=death_and_decay.ticking&cooldown.apocalypse.remains
            if A.ClawingShadows:IsReady(unit) and (bool(death_and_decay.ticking) and bool(A.Apocalypse:GetCooldown())) then
                return A.ClawingShadows:Show(icon)
            end
            -- epidemic,if=!variable.pooling_for_gargoyle
            if A.Epidemic:IsReady(unit) and (not bool(VarPoolingForGargoyle)) then
                return A.Epidemic:Show(icon)
            end
            -- festering_strike,target_if=debuff.festering_wound.stack<=1&cooldown.death_and_decay.remains
            if A.FesteringStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FesteringStrike, 40, "min", EvaluateCycleFesteringStrike42) then
                    return A.FesteringStrike:Show(icon) 
                end
            end
            -- festering_strike,if=talent.bursting_sores.enabled&spell_targets.bursting_sores>=2&debuff.festering_wound.stack<=1
            if A.FesteringStrike:IsReady(unit) and (A.BurstingSores:IsSpellLearned() and MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) <= 1) then
                return A.FesteringStrike:Show(icon)
            end
            -- death_coil,if=buff.sudden_doom.react&rune.deficit>=4
            if A.DeathCoil:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true)) and Player:RuneDeficit() >= 4) then
                return A.DeathCoil:Show(icon)
            end
            -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true)) and not bool(VarPoolingForGargoyle) or bool(Pet:IsActive(A.Gargoyle.ID))) then
                return A.DeathCoil:Show(icon)
            end
            -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
            -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ScourgeStrike:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (A.ArmyoftheDead:GetCooldown() > 5 or bool(death_knight.disable_aotd))) then
                return A.ScourgeStrike:Show(icon)
            end
            -- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ClawingShadows:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (A.ArmyoftheDead:GetCooldown() > 5 or bool(death_knight.disable_aotd))) then
                return A.ClawingShadows:Show(icon)
            end
            -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
            -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.FesteringStrike:IsReady(unit) and (((((Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and not Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true)) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 3) and A.Apocalypse:GetCooldown() < 3) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 1) and (A.ArmyoftheDead:GetCooldown() > 5 or bool(death_knight.disable_aotd))) then
                return A.FesteringStrike:Show(icon)
            end
            -- death_coil,if=!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- army_of_the_dead
            if A.ArmyoftheDead:IsReady(unit) then
                return A.ArmyoftheDead:Show(icon)
            end
            -- apocalypse,if=debuff.festering_wound.stack>=4
            if A.Apocalypse:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) >= 4) then
                return A.Apocalypse:Show(icon)
            end
            -- dark_transformation,if=!raid_event.adds.exists|raid_event.adds.in>15
            if A.DarkTransformation:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 15) then
                return A.DarkTransformation:Show(icon)
            end
            -- summon_gargoyle,if=runic_power.deficit<14
            if A.SummonGargoyle:IsReady(unit) and (Player:RunicPowerDeficit() < 14) then
                return A.SummonGargoyle:Show(icon)
            end
            -- unholy_frenzy,if=essence.vision_of_perfection.enabled|(essence.condensed_lifeforce.enabled&pet.apoc_ghoul.active)|debuff.festering_wound.stack<4&!(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled)|cooldown.apocalypse.remains<2&(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled)
            if A.UnholyFrenzy:IsReady(unit) and (bool(A.VisionofPerfection:IsSpellLearned()) or (bool(A.CondensedLifeforce:IsSpellLearned()) and bool(Pet:IsActive(A.ApocGhoul.ID))) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and not (A.RampingAmplitudeGigavoltEngine:IsExists() or bool(A.MagusoftheDead:GetAzeriteRank())) or A.Apocalypse:GetCooldown() < 2 and (A.RampingAmplitudeGigavoltEngine:IsExists() or bool(A.MagusoftheDead:GetAzeriteRank()))) then
                return A.UnholyFrenzy:Show(icon)
            end
            -- unholy_frenzy,if=active_enemies>=2&((cooldown.death_and_decay.remains<=gcd&!talent.defile.enabled)|(cooldown.defile.remains<=gcd&talent.defile.enabled))
            if A.UnholyFrenzy:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and ((A.DeathandDecay:GetCooldown() <= A.GetGCD() and not A.Defile:IsSpellLearned()) or (A.Defile:GetCooldown() <= A.GetGCD() and A.Defile:IsSpellLearned()))) then
                return A.UnholyFrenzy:Show(icon)
            end
            -- soul_reaper,target_if=target.time_to_die<8&target.time_to_die>4
            if A.SoulReaper:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SoulReaper, 40, "min", EvaluateCycleSoulReaper167) then
                    return A.SoulReaper:Show(icon) 
                end
            end
            -- soul_reaper,if=(!raid_event.adds.exists|raid_event.adds.in>20)&rune<=(1-buff.unholy_frenzy.up)
            if A.SoulReaper:IsReady(unit) and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 20) and Player:Rune() <= (1 - num(Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true)))) then
                return A.SoulReaper:Show(icon)
            end
            -- unholy_blight
            if A.UnholyBlight:IsReady(unit) then
                return A.UnholyBlight:Show(icon)
            end
        end
        
        --Essences
        local function Essences(unit)
            -- memory_of_lucid_dreams,if=rune.time_to_1>gcd&runic_power<40
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:RuneTimeToX(1) > A.GetGCD() and Player:RunicPower() < 40) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- blood_of_the_enemy,if=(cooldown.death_and_decay.remains&spell_targets.death_and_decay>1)|(cooldown.defile.remains&spell_targets.defile>1)|(cooldown.apocalypse.remains&cooldown.death_and_decay.ready)
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((bool(A.DeathandDecay:GetCooldown()) and MultiUnits:GetByRangeInCombat(30, 5, 10) > 1) or (bool(A.Defile:GetCooldown()) and MultiUnits:GetByRangeInCombat(5, 5, 10) > 1) or (bool(A.Apocalypse:GetCooldown()) and A.DeathandDecay:GetCooldown() == 0)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- guardian_of_azeroth,if=(cooldown.apocalypse.remains<6&cooldown.army_of_the_dead.remains>cooldown.condensed_lifeforce.remains)|cooldown.army_of_the_dead.remains<2
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((A.Apocalypse:GetCooldown() < 6 and A.ArmyoftheDead:GetCooldown() > A.CondensedLifeforce:GetCooldown()) or A.ArmyoftheDead:GetCooldown() < 2) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<11
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 11) then
                return A.TheUnboundForce:Show(icon)
            end
            -- focused_azerite_beam,if=!death_and_decay.ticking
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not bool(death_and_decay.ticking)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- concentrated_flame,if=dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- purifying_blast,if=!death_and_decay.ticking
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not bool(death_and_decay.ticking)) then
                return A.PurifyingBlast:Show(icon)
            end
            -- worldvein_resonance,if=!death_and_decay.ticking
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not bool(death_and_decay.ticking)) then
                return A.WorldveinResonance:Show(icon)
            end
            -- ripple_in_space,if=!death_and_decay.ticking
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not bool(death_and_decay.ticking)) then
                return A.RippleInSpace:Show(icon)
            end
        end
        
        --Generic
        local function Generic(unit)
            -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.SuddenDoomBuff.ID, true)) and not bool(VarPoolingForGargoyle) or bool(Pet:IsActive(A.Gargoyle.ID))) then
                return A.DeathCoil:Show(icon)
            end
            -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
            -- death_and_decay,if=talent.pestilence.enabled&cooldown.apocalypse.remains
            if A.DeathandDecay:IsReady(unit) and (A.Pestilence:IsSpellLearned() and bool(A.Apocalypse:GetCooldown())) then
                return A.DeathandDecay:Show(icon)
            end
            -- defile,if=cooldown.apocalypse.remains
            if A.Defile:IsReady(unit) and (bool(A.Apocalypse:GetCooldown())) then
                return A.Defile:Show(icon)
            end
            -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ScourgeStrike:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (A.ArmyoftheDead:GetCooldown() > 5 or bool(death_knight.disable_aotd))) then
                return A.ScourgeStrike:Show(icon)
            end
            -- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.ClawingShadows:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff.ID, true) and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) > 4) and (A.ArmyoftheDead:GetCooldown() > 5 or bool(death_knight.disable_aotd))) then
                return A.ClawingShadows:Show(icon)
            end
            -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
            -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)
            if A.FesteringStrike:IsReady(unit) and (((((Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 4 and not Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true)) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 3) and A.Apocalypse:GetCooldown() < 3) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) < 1) and (A.ArmyoftheDead:GetCooldown() > 5 or bool(death_knight.disable_aotd))) then
                return A.FesteringStrike:Show(icon)
            end
            -- death_coil,if=!variable.pooling_for_gargoyle
            if A.DeathCoil:IsReady(unit) and (not bool(VarPoolingForGargoyle)) then
                return A.DeathCoil:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- variable,name=pooling_for_gargoyle,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle.enabled
            if (true) then
                VarPoolingForGargoyle = num(A.SummonGargoyle:GetCooldown() < 5 and A.SummonGargoyle:IsSpellLearned())
            end
            -- arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle.enabled)&rune.deficit>=5
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 65 and (bool(Pet:IsActive(A.Gargoyle.ID)) or not A.SummonGargoyle:IsSpellLearned()) and Player:RuneDeficit() >= 5) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- blood_fury,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (bool(Pet:IsActive(A.Gargoyle.ID)) or not A.SummonGargoyle:IsSpellLearned()) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=buff.unholy_frenzy.up|pet.gargoyle.active|(talent.army_of_the_damned.enabled&pet.apoc_ghoul.active)
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true) or bool(Pet:IsActive(A.Gargoyle.ID)) or (A.ArmyoftheDamned:IsSpellLearned() and bool(Pet:IsActive(A.ApocGhoul.ID)))) then
                return A.Berserking:Show(icon)
            end
            -- use_items,if=time>20|!equipped.ramping_amplitude_gigavolt_engine|!equipped.vision_of_demise
            -- use_item,name=azsharas_font_of_power,if=(essence.vision_of_perfection.major&!talent.unholy_frenzy.enabled)|(!essence.condensed_lifeforce.major&!essence.vision_of_perfection.major)
            if A.AzsharasFontofPower:IsReady(unit) and ((bool(Azerite:EssenceHasMajor(A.VisionofPerfection.ID)) and not A.UnholyFrenzy:IsSpellLearned()) or (not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) and not bool(Azerite:EssenceHasMajor(A.VisionofPerfection.ID)))) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=cooldown.apocalypse.remains<14&(essence.condensed_lifeforce.major|essence.vision_of_perfection.major&talent.unholy_frenzy.enabled)
            if A.AzsharasFontofPower:IsReady(unit) and (A.Apocalypse:GetCooldown() < 14 and (bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) or bool(Azerite:EssenceHasMajor(A.VisionofPerfection.ID)) and A.UnholyFrenzy:IsSpellLearned())) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=target.1.time_to_die<cooldown.apocalypse.remains+34
            if A.AzsharasFontofPower:IsReady(unit) and (target.1.time_to_die < A.Apocalypse:GetCooldown() + 34) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack<1
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) < 1) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=pet.guardian_of_azeroth.active&pet.apoc_ghoul.active
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(pet.guardian_of_azeroth.active) and bool(Pet:IsActive(A.ApocGhoul.ID))) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=cooldown.apocalypse.ready&(essence.condensed_lifeforce.major&target.1.time_to_die<cooldown.condensed_lifeforce.remains+20|!essence.condensed_lifeforce.major)
            if A.AshvanesRazorCoral:IsReady(unit) and (A.Apocalypse:GetCooldown() == 0 and (bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)) and target.1.time_to_die < A.CondensedLifeforce:GetCooldown() + 20 or not bool(Azerite:EssenceHasMajor(A.CondensedLifeforce.ID)))) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=target.1.time_to_die<cooldown.apocalypse.remains+20
            if A.AshvanesRazorCoral:IsReady(unit) and (target.1.time_to_die < A.Apocalypse:GetCooldown() + 20) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=vision_of_demise,if=(cooldown.apocalypse.ready&debuff.festering_wound.stack>=4&essence.vision_of_perfection.enabled)|buff.unholy_frenzy.up|pet.gargoyle.active
            if A.VisionofDemise:IsReady(unit) and ((A.Apocalypse:GetCooldown() == 0 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff.ID, true) >= 4 and bool(A.VisionofPerfection:IsSpellLearned())) or Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true) or bool(Pet:IsActive(A.Gargoyle.ID))) then
                A.VisionofDemise:Show(icon)
            end
            -- use_item,name=ramping_amplitude_gigavolt_engine,if=cooldown.apocalypse.remains<2|talent.army_of_the_damned.enabled|raid_event.adds.in<5
            if A.RampingAmplitudeGigavoltEngine:IsReady(unit) and (A.Apocalypse:GetCooldown() < 2 or A.ArmyoftheDamned:IsSpellLearned() or 10000000000 < 5) then
                A.RampingAmplitudeGigavoltEngine:Show(icon)
            end
            -- use_item,name=bygone_bee_almanac,if=cooldown.summon_gargoyle.remains>60|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.BygoneBeeAlmanac:IsReady(unit) and (A.SummonGargoyle:GetCooldown() > 60 or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                A.BygoneBeeAlmanac:Show(icon)
            end
            -- use_item,name=jes_howler,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.JesHowler:IsReady(unit) and (bool(Pet:IsActive(A.Gargoyle.ID)) or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                A.JesHowler:Show(icon)
            end
            -- use_item,name=galecallers_beak,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
            if A.GalecallersBeak:IsReady(unit) and (bool(Pet:IsActive(A.Gargoyle.ID)) or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists()) then
                A.GalecallersBeak:Show(icon)
            end
            -- use_item,name=grongs_primal_rage,if=rune<=3&(time>20|!equipped.ramping_amplitude_gigavolt_engine)
            if A.GrongsPrimalRage:IsReady(unit) and (Player:Rune() <= 3 and (Unit("player"):CombatTime() > 20 or not A.RampingAmplitudeGigavoltEngine:IsExists())) then
                A.GrongsPrimalRage:Show(icon)
            end
            -- potion,if=cooldown.army_of_the_dead.ready|pet.gargoyle.active|buff.unholy_frenzy.up
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (A.ArmyoftheDead:GetCooldown() == 0 or bool(Pet:IsActive(A.Gargoyle.ID)) or Unit("player"):HasBuffs(A.UnholyFrenzyBuff.ID, true)) then
                A.BattlePotionofStrength:Show(icon)
            end
            -- outbreak,target_if=dot.virulent_plague.remains<=gcd
            if A.Outbreak:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Outbreak, 40, "min", EvaluateCycleOutbreak401) then
                    return A.Outbreak:Show(icon) 
                end
            end
            -- call_action_list,name=essences
            if (true) then
                local ShouldReturn = Essences(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cooldowns
            if (true) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- run_action_list,name=aoe,if=active_enemies>=2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) then
                return Aoe(unit);
            end
            -- call_action_list,name=generic
            if (true) then
                local ShouldReturn = Generic(unit); if ShouldReturn then return ShouldReturn; end
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

