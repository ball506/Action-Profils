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
Action[ACTION_CONST_PRIEST_HOLY] = {
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
    Smite                                  = Action.Create({ Type = "Spell", ID =  }),
    HolyFire                               = Action.Create({ Type = "Spell", ID =  }),
    HolyFireDebuff                         = Action.Create({ Type = "Spell", ID =  }),
    HolyWordChastise                       = Action.Create({ Type = "Spell", ID =  }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    DivineStar                             = Action.Create({ Type = "Spell", ID =  }),
    Halo                                   = Action.Create({ Type = "Spell", ID =  }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID =  }),
    HolyNova                               = Action.Create({ Type = "Spell", ID =  }),
    Apotheosis                             = Action.Create({ Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_PRIEST_HOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PRIEST_HOLY], { __index = Action })





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
        local Precombat
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- smite
            if A.Smite:IsReady(unit) then
                return A.Smite:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- use_items
            -- potion,if=buff.bloodlust.react|(raid_event.adds.up&(raid_event.adds.remains>20|raid_event.adds.duration<20))|target.time_to_die<=30
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism() or ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (0 > 20 or raid_event.adds.duration < 20)) or Unit(unit):TimeToDie() <= 30) then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- holy_fire,if=dot.holy_fire.ticking&(dot.holy_fire.remains<=gcd|dot.holy_fire.stack<2)&spell_targets.holy_nova<7
            if A.HolyFire:IsReady(unit) and (Unit(unit):HasDeBuffs(A.HolyFireDebuff.ID, true) and (Unit(unit):HasDeBuffs(A.HolyFireDebuff.ID, true) <= A.GetGCD() or Unit(unit):HasDeBuffsStacks(A.HolyFireDebuff.ID, true) < 2) and MultiUnits:GetByRangeInCombat(5, 5, 10) < 7) then
                return A.HolyFire:Show(icon)
            end
            -- holy_word_chastise,if=spell_targets.holy_nova<5
            if A.HolyWordChastise:IsReady(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) < 5) then
                return A.HolyWordChastise:Show(icon)
            end
            -- holy_fire,if=dot.holy_fire.ticking&(dot.holy_fire.refreshable|dot.holy_fire.stack<2)&spell_targets.holy_nova<7
            if A.HolyFire:IsReady(unit) and (Unit(unit):HasDeBuffs(A.HolyFireDebuff.ID, true) and (Unit(unit):HasDeBuffsRefreshable(A.HolyFireDebuff.ID, true) or Unit(unit):HasDeBuffsStacks(A.HolyFireDebuff.ID, true) < 2) and MultiUnits:GetByRangeInCombat(5, 5, 10) < 7) then
                return A.HolyFire:Show(icon)
            end
            -- berserking,if=raid_event.adds.in>30|raid_event.adds.remains>8|raid_event.adds.duration<8
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (10000000000 > 30 or 0 > 8 or raid_event.adds.duration < 8) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=raid_event.adds.in>20|raid_event.adds.remains>6|raid_event.adds.duration<6
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (10000000000 > 20 or 0 > 6 or raid_event.adds.duration < 6) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=raid_event.adds.in>20|raid_event.adds.remains>10|raid_event.adds.duration<10
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (10000000000 > 20 or 0 > 10 or raid_event.adds.duration < 10) then
                return A.AncestralCall:Show(icon)
            end
            -- divine_star,if=(raid_event.adds.in>5|raid_event.adds.remains>2|raid_event.adds.duration<2)&spell_targets.divine_star>1
            if A.DivineStar:IsReady(unit) and ((10000000000 > 5 or 0 > 2 or raid_event.adds.duration < 2) and MultiUnits:GetByRangeInCombat(5, 5, 10) > 1) then
                return A.DivineStar:Show(icon)
            end
            -- halo,if=(raid_event.adds.in>14|raid_event.adds.remains>2|raid_event.adds.duration<2)&spell_targets.halo>0
            if A.Halo:IsReady(unit) and ((10000000000 > 14 or 0 > 2 or raid_event.adds.duration < 2) and MultiUnits:GetByRangeInCombat(5, 5, 10) > 0) then
                return A.Halo:Show(icon)
            end
            -- lights_judgment,if=raid_event.adds.in>50|raid_event.adds.remains>4|raid_event.adds.duration<4
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (10000000000 > 50 or 0 > 4 or raid_event.adds.duration < 4) then
                return A.LightsJudgment:Show(icon)
            end
            -- arcane_pulse,if=(raid_event.adds.in>40|raid_event.adds.remains>2|raid_event.adds.duration<2)&spell_targets.arcane_pulse>2
            if A.ArcanePulse:AutoRacial(unit) and Action.GetToggle(1, "Racial") and ((10000000000 > 40 or 0 > 2 or raid_event.adds.duration < 2) and MultiUnits:GetByRangeInCombat(5, 5, 10) > 2) then
                return A.ArcanePulse:Show(icon)
            end
            -- holy_fire,if=!dot.holy_fire.ticking&spell_targets.holy_nova<7
            if A.HolyFire:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.HolyFireDebuff.ID, true) and MultiUnits:GetByRangeInCombat(5, 5, 10) < 7) then
                return A.HolyFire:Show(icon)
            end
            -- holy_nova,if=spell_targets.holy_nova>3
            if A.HolyNova:IsReady(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) > 3) then
                return A.HolyNova:Show(icon)
            end
            -- apotheosis,if=active_enemies<5&(raid_event.adds.in>15|raid_event.adds.in>raid_event.adds.cooldown-5)
            if A.Apotheosis:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 5 and (10000000000 > 15 or 10000000000 > raid_event.adds.cooldown - 5)) then
                return A.Apotheosis:Show(icon)
            end
            -- smite
            if A.Smite:IsReady(unit) then
                return A.Smite:Show(icon)
            end
            -- holy_fire
            if A.HolyFire:IsReady(unit) then
                return A.HolyFire:Show(icon)
            end
            -- divine_star,if=(raid_event.adds.in>5|raid_event.adds.remains>2|raid_event.adds.duration<2)&spell_targets.divine_star>0
            if A.DivineStar:IsReady(unit) and ((10000000000 > 5 or 0 > 2 or raid_event.adds.duration < 2) and MultiUnits:GetByRangeInCombat(5, 5, 10) > 0) then
                return A.DivineStar:Show(icon)
            end
            -- holy_nova,if=raid_event.movement.remains>gcd*0.3&spell_targets.holy_nova>0
            if A.HolyNova:IsReady(unit) and (raid_event.movement.remains > A.GetGCD() * 0.3 and MultiUnits:GetByRangeInCombat(5, 5, 10) > 0) then
                return A.HolyNova:Show(icon)
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

