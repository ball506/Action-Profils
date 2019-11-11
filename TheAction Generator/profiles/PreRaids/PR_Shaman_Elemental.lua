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
Action[ACTION_CONST_SHAMAN_ELEMENTAL] = {
    TotemMastery                           = Action.Create({Type = "Spell", ID = 210643 }),
    StormkeeperBuff                        = Action.Create({Type = "Spell", ID = 191634 }),
    Stormkeeper                            = Action.Create({Type = "Spell", ID = 191634 }),
    FireElemental                          = Action.Create({Type = "Spell", ID = 198067 }),
    StormElemental                         = Action.Create({Type = "Spell", ID = 192249 }),
    ElementalBlast                         = Action.Create({Type = "Spell", ID = 117014 }),
    LavaBurst                              = Action.Create({Type = "Spell", ID = 51505 }),
    Ascendance                             = Action.Create({Type = "Spell", ID = 114050 }),
    LiquidMagmaTotem                       = Action.Create({Type = "Spell", ID = 192222 }),
    FlameShock                             = Action.Create({Type = "Spell", ID = 188389 }),
    FlameShockDebuff                       = Action.Create({Type = "Spell", ID = 188389 }),
    WindGustBuff                           = Action.Create({Type = "Spell", ID = 263806 }),
    Earthquake                             = Action.Create({Type = "Spell", ID = 61882 }),
    MasteroftheElements                    = Action.Create({Type = "Spell", ID = 16166 }),
    MasteroftheElementsBuff                = Action.Create({Type = "Spell", ID = 260734 }),
    LavaSurgeBuff                          = Action.Create({Type = "Spell", ID = 77762 }),
    AscendanceBuff                         = Action.Create({Type = "Spell", ID = 114050 }),
    LavaBeam                               = Action.Create({Type = "Spell", ID = 114074 }),
    ChainLightning                         = Action.Create({Type = "Spell", ID = 188443 }),
    FrostShock                             = Action.Create({Type = "Spell", ID = 196840 }),
    SurgeofPowerBuff                       = Action.Create({Type = "Spell", ID = 285514 }),
    Icefury                                = Action.Create({Type = "Spell", ID = 210714 }),
    IcefuryBuff                            = Action.Create({Type = "Spell", ID = 210714 }),
    NaturalHarmony                         = Action.Create({Type = "Spell", ID = 278697 }),
    SurgeofPower                           = Action.Create({Type = "Spell", ID = 262303 }),
    LightningBolt                          = Action.Create({Type = "Spell", ID = 188196 }),
    EarthShock                             = Action.Create({Type = "Spell", ID = 8042 }),
    CalltheThunder                         = Action.Create({Type = "Spell", ID = 260897 }),
    EchooftheElementals                    = Action.Create({Type = "Spell", ID = 275381 }),
    ResonanceTotemBuff                     = Action.Create({Type = "Spell", ID = 202192 }),
    WindShear                              = Action.Create({Type = "Spell", ID = 57994 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 })
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
Action:CreateEssencesFor(ACTION_CONST_SHAMAN_ELEMENTAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ELEMENTAL], { __index = Action })



local EnemyRanges = {40, 5}
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
-------------- PRE APL SETUP -------------
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

------------------------------------------
--------------- DEFENSIVES ---------------
------------------------------------------
local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
		
    -- UnendingResolve
 --[[   local UnendingResolve = A.GetToggle(2, "UnendingResolve")
    if     UnendingResolve >= 0 and A.UnendingResolve:IsReady("player") and 
    (
        (     -- Auto 
            UnendingResolve >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            UnendingResolve < 100 and 
            Unit("player"):HealthPercent() <= UnendingResolve
        )
    ) 
    then 
        return A.UnendingResolve
    end ]]--
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

------------------------------------------
--------------- INTERRUPTS ---------------
------------------------------------------
local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
  --  if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
  --      return A.PetKick
  --  end 
    
  --  if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
  --      return A.Shadowfury              
  --  end          
	
	--if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 0) then 
    --    return A.Fear              
    --end
    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

------------------------------------------
---------------- AntiFake ----------------
------------------------------------------

-- [1] CC AntiFake Rotation
--[[local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.LegSweepGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.LegSweepGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))) or 
                (not A.IsInPvP and MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1)
            )
        )
    )
    then 
        return A.LegSweepGreen:Show(icon)         
    end                                                                     
end]]--

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
        --    if not notKickAble and A.PetKick:IsReady(unit, nil, nil, true) and A.PetKick:AbsentImun(unit, Temp.TotalAndMag, true) then
        --        return A.PetKick:Show(icon)                                                  
        --    end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end


local function EvaluateCycleFlameShock61(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 5 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < 120 or MultiUnits:GetByRangeInCombat(40, 5, 10) == 3 and Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14)
end

local function EvaluateCycleFlameShock116(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true)
end

local function EvaluateCycleFlameShock313(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)
end

local function EvaluateCycleFlameShock394(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)
end

local function EvaluateCycleFlameShock443(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true)
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
        local Precombat, Aoe, SingleUnit(unit)
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- totem_mastery
            if A.TotemMastery:IsReady(unit) then
                return A.TotemMastery:Show(icon)
            end
            -- earth_elemental,if=!talent.primal_elementalist.enabled
            -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if A.Stormkeeper:IsReady(unit) and Unit("player"):HasBuffsDown(A.StormkeeperBuff.ID, true) and (A.Stormkeeper:IsSpellLearned() and ((MultiUnits:GetByRangeInCombat(40, 5, 10) - 1) < 3 or 10000000000 > 50)) then
                return A.Stormkeeper:Show(icon)
            end
            -- fire_elemental,if=!talent.storm_elemental.enabled
            if A.FireElemental:IsReady(unit) and A.BurstIsON(unit) and (not A.StormElemental:IsSpellLearned()) then
                return A.FireElemental:Show(icon)
            end
            -- storm_elemental,if=talent.storm_elemental.enabled
            if A.StormElemental:IsReady(unit) and A.BurstIsON(unit) and (A.StormElemental:IsSpellLearned()) then
                return A.StormElemental:Show(icon)
            end
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- elemental_blast,if=talent.elemental_blast.enabled
            if A.ElementalBlast:IsReady(unit) and (A.ElementalBlast:IsSpellLearned()) then
                return A.ElementalBlast:Show(icon)
            end
            -- lava_burst,if=!talent.elemental_blast.enabled
            if A.LavaBurst:IsReady(unit) and (not A.ElementalBlast:IsSpellLearned()) then
                return A.LavaBurst:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
            -- stormkeeper,if=talent.stormkeeper.enabled
            if A.Stormkeeper:IsReady(unit) and (A.Stormkeeper:IsSpellLearned()) then
                return A.Stormkeeper:Show(icon)
            end
            -- ascendance,if=talent.ascendance.enabled&(talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120&cooldown.storm_elemental.remains>15|!talent.storm_elemental.enabled)
            if A.Ascendance:IsReady(unit) and A.BurstIsON(unit) and (A.Ascendance:IsSpellLearned() and (A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 120 and A.StormElemental:GetCooldown() > 15 or not A.StormElemental:IsSpellLearned())) then
                return A.Ascendance:Show(icon)
            end
            -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled
            if A.LiquidMagmaTotem:IsReady(unit) and (A.LiquidMagmaTotem:IsSpellLearned()) then
                return A.LiquidMagmaTotem:Show(icon)
            end
            -- flame_shock,target_if=refreshable&spell_targets.chain_lightning<5&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120|spell_targets.chain_lightning=3&buff.wind_gust.stack<14)
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, EvaluateCycleFlameShock61) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- earthquake,if=!talent.master_of_the_elements.enabled|buff.stormkeeper.up|maelstrom>=(100-4*spell_targets.chain_lightning)|buff.master_of_the_elements.up|spell_targets.chain_lightning>3
            if A.Earthquake:IsReady(unit) and (not A.MasteroftheElements:IsSpellLearned() or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or Unit("player"):Maelstrom() >= (100 - 4 * MultiUnits:GetByRangeInCombat(40, 5, 10)) or Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
                return A.Earthquake:Show(icon)
            end
            -- lava_burst,if=(buff.lava_surge.up|buff.ascendance.up)&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)
            if A.LavaBurst:IsReady(unit) and ((Unit("player"):HasBuffs(A.LavaSurgeBuff.ID, true) or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < 120)) then
                return A.LavaBurst:Show(icon)
            end
            -- elemental_blast,if=talent.elemental_blast.enabled&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)
            if A.ElementalBlast:IsReady(unit) and (A.ElementalBlast:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() < 120)) then
                return A.ElementalBlast:Show(icon)
            end
            -- lava_beam,if=talent.ascendance.enabled
            if A.LavaBeam:IsReady(unit) and (A.Ascendance:IsSpellLearned()) then
                return A.LavaBeam:Show(icon)
            end
            -- chain_lightning
            if A.ChainLightning:IsReady(unit) then
                return A.ChainLightning:Show(icon)
            end
            -- lava_burst,moving=1,if=talent.ascendance.enabled
            if A.LavaBurst:IsReady(unit) and isMoving and (A.Ascendance:IsSpellLearned()) then
                return A.LavaBurst:Show(icon)
            end
            -- flame_shock,moving=1,target_if=refreshable
            if A.FlameShock:IsReady(unit) and isMoving then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, EvaluateCycleFlameShock116) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- frost_shock,moving=1
            if A.FrostShock:IsReady(unit) and isMoving then
                return A.FrostShock:Show(icon)
            end
        end
        
        --SingleUnit(unit)
        local function SingleUnit(unit)(unit)
            -- flame_shock,if=(!ticking|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<2*gcd|dot.flame_shock.remains<=gcd|talent.ascendance.enabled&dot.flame_shock.remains<(cooldown.ascendance.remains+buff.ascendance.duration)&cooldown.ascendance.remains<4&(!talent.storm_elemental.enabled|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120))&buff.wind_gust.stack<14&!buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) and ((not Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) or A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 2 * A.GetGCD() or Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) <= A.GetGCD() or A.Ascendance:IsSpellLearned() and Unit(unit):HasDeBuffs(A.FlameShockDebuff.ID, true) < (A.Ascendance:GetCooldown() + A.AscendanceBuff.ID, true:BaseDuration()) and A.Ascendance:GetCooldown() < 4 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:IsSpellLearned() and A.StormElemental:GetCooldown() < 120)) and Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14 and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)) then
                return A.FlameShock:Show(icon)
            end
            -- ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains>120)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.Ascendance:IsReady(unit) and A.BurstIsON(unit) and (A.Ascendance:IsSpellLearned() and (Unit("player"):CombatTime >= 60 or Unit("player"):HasHeroism) and A.LavaBurst:GetCooldown() > 0 and (not A.StormElemental:IsSpellLearned() or A.StormElemental:GetCooldown() > 120) and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) then
                return A.Ascendance:Show(icon)
            end
            -- elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&buff.master_of_the_elements.up&maelstrom<60|!talent.master_of_the_elements.enabled)&(!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)|azerite.natural_harmony.rank=3&buff.wind_gust.stack<14)
            if A.ElementalBlast:IsReady(unit) and (A.ElementalBlast:IsSpellLearned() and (A.MasteroftheElements:IsSpellLearned() and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) and Unit("player"):Maelstrom() < 60 or not A.MasteroftheElements:IsSpellLearned()) and (not (A.StormElemental:GetCooldown() > 120 and A.StormElemental:IsSpellLearned()) or A.NaturalHarmony:GetAzeriteRank() == 3 and Unit("player"):HasBuffsStacks(A.WindGustBuff.ID, true) < 14)) then
                return A.ElementalBlast:Show(icon)
            end
            -- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)&(!talent.surge_of_power.enabled|buff.surge_of_power.up|maelstrom>=44)
            if A.Stormkeeper:IsReady(unit) and (A.Stormkeeper:IsSpellLearned() and ((MultiUnits:GetByRangeInCombat(40, 5, 10) - 1) < 3 or 10000000000 > 50) and (not A.SurgeofPower:IsSpellLearned() or Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) or Unit("player"):Maelstrom() >= 44)) then
                return A.Stormkeeper:Show(icon)
            end
            -- liquid_magma_totem,if=talent.liquid_magma_totem.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)
            if A.LiquidMagmaTotem:IsReady(unit) and (A.LiquidMagmaTotem:IsSpellLearned() and ((MultiUnits:GetByRangeInCombat(40, 5, 10) - 1) < 3 or 10000000000 > 50)) then
                return A.LiquidMagmaTotem:Show(icon)
            end
            -- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<2&(buff.master_of_the_elements.up&!talent.surge_of_power.enabled|buff.surge_of_power.up)
            if A.LightningBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 and (Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) and not A.SurgeofPower:IsSpellLearned() or Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true))) then
                return A.LightningBolt:Show(icon)
            end
            -- earthquake,if=active_enemies>1&spell_targets.chain_lightning>1&(!talent.surge_of_power.enabled|!dot.flame_shock.refreshable|cooldown.storm_elemental.remains>120)&(!talent.master_of_the_elements.enabled|buff.master_of_the_elements.up|maelstrom>=92)
            if A.Earthquake:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and (not A.SurgeofPower:IsSpellLearned() or not Unit(unit):HasDeBuffsRefreshable(A.FlameShockDebuff.ID, true) or A.StormElemental:GetCooldown() > 120) and (not A.MasteroftheElements:IsSpellLearned() or Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) or Unit("player"):Maelstrom() >= 92)) then
                return A.Earthquake:Show(icon)
            end
            -- earth_shock,if=!buff.surge_of_power.up&talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|maelstrom>=92+30*talent.call_the_thunder.enabled|buff.stormkeeper.up&active_enemies<2)|!talent.master_of_the_elements.enabled&(buff.stormkeeper.up|maelstrom>=90+30*talent.call_the_thunder.enabled|!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)&expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)>=30*(1+(azerite.echo_of_the_elementals.rank>=2)))
            if A.EarthShock:IsReady(unit) and (not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and A.MasteroftheElements:IsSpellLearned() and (Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true) or Unit("player"):Maelstrom() >= 92 + 30 * num(A.CalltheThunder:IsSpellLearned()) or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 2) or not A.MasteroftheElements:IsSpellLearned() and (Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or Unit("player"):Maelstrom() >= 90 + 30 * num(A.CalltheThunder:IsSpellLearned()) or not (A.StormElemental:GetCooldown() > 120 and A.StormElemental:IsSpellLearned()) and expected_combat_length - Unit("player"):CombatTime - A.StormElemental:GetCooldown() - 150 * math.floor ((expected_combat_length - Unit("player"):CombatTime - A.StormElemental:GetCooldown()) / 150) >= 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))))) then
                return A.EarthShock:Show(icon)
            end
            -- earth_shock,if=talent.surge_of_power.enabled&!buff.surge_of_power.up&cooldown.lava_burst.remains<=gcd&(!talent.storm_elemental.enabled&!(cooldown.fire_elemental.remains>120)|talent.storm_elemental.enabled&!(cooldown.storm_elemental.remains>120))
            if A.EarthShock:IsReady(unit) and (A.SurgeofPower:IsSpellLearned() and not Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and A.LavaBurst:GetCooldown() <= A.GetGCD() and (not A.StormElemental:IsSpellLearned() and not (A.FireElemental:GetCooldown() > 120) or A.StormElemental:IsSpellLearned() and not (A.StormElemental:GetCooldown() > 120))) then
                return A.EarthShock:Show(icon)
            end
            -- lightning_bolt,if=cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled
            if A.LightningBolt:IsReady(unit) and (A.StormElemental:GetCooldown() > 120 and A.StormElemental:IsSpellLearned()) then
                return A.LightningBolt:Show(icon)
            end
            -- frost_shock,if=talent.icefury.enabled&talent.master_of_the_elements.enabled&buff.icefury.up&buff.master_of_the_elements.up
            if A.FrostShock:IsReady(unit) and (A.Icefury:IsSpellLearned() and A.MasteroftheElements:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and Unit("player"):HasBuffs(A.MasteroftheElementsBuff.ID, true)) then
                return A.FrostShock:Show(icon)
            end
            -- lava_burst,if=buff.ascendance.up
            if A.LavaBurst:IsReady(unit) and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                return A.LavaBurst:Show(icon)
            end
            -- flame_shock,target_if=refreshable&active_enemies>1&buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, EvaluateCycleFlameShock313) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- lava_burst,if=talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains)%150))<(expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)))
            if A.LavaBurst:IsReady(unit) and (A.StormElemental:IsSpellLearned() and A.LavaBurst:GetCooldown() == 0 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and (expected_combat_length - Unit("player"):CombatTime - A.StormElemental:GetCooldown() - 150 * math.floor ((expected_combat_length - Unit("player"):CombatTime - A.StormElemental:GetCooldown()) / 150) < 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))) or (1.16 * (expected_combat_length - Unit("player"):CombatTime) - A.StormElemental:GetCooldown() - 150 * math.floor ((1.16 * (expected_combat_length - Unit("player"):CombatTime) - A.StormElemental:GetCooldown()) / 150)) < (expected_combat_length - Unit("player"):CombatTime - A.StormElemental:GetCooldown() - 150 * math.floor ((expected_combat_length - Unit("player"):CombatTime - A.StormElemental:GetCooldown()) / 150)))) then
                return A.LavaBurst:Show(icon)
            end
            -- lava_burst,if=!talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains)%150))<(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)))
            if A.LavaBurst:IsReady(unit) and (not A.StormElemental:IsSpellLearned() and A.LavaBurst:GetCooldown() == 0 and Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true) and (expected_combat_length - Unit("player"):CombatTime - A.FireElemental:GetCooldown() - 150 * math.floor ((expected_combat_length - Unit("player"):CombatTime - A.FireElemental:GetCooldown()) / 150) < 30 * (1 + num((A.EchooftheElementals:GetAzeriteRank() >= 2))) or (1.16 * (expected_combat_length - Unit("player"):CombatTime) - A.FireElemental:GetCooldown() - 150 * math.floor ((1.16 * (expected_combat_length - Unit("player"):CombatTime) - A.FireElemental:GetCooldown()) / 150)) < (expected_combat_length - Unit("player"):CombatTime - A.FireElemental:GetCooldown() - 150 * math.floor ((expected_combat_length - Unit("player"):CombatTime - A.FireElemental:GetCooldown()) / 150)))) then
                return A.LavaBurst:Show(icon)
            end
            -- lightning_bolt,if=buff.surge_of_power.up
            if A.LightningBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.SurgeofPowerBuff.ID, true)) then
                return A.LightningBolt:Show(icon)
            end
            -- lava_burst,if=cooldown_react
            if A.LavaBurst:IsReady(unit) and (A.LavaBurst:GetCooldown() == 0) then
                return A.LavaBurst:Show(icon)
            end
            -- flame_shock,target_if=refreshable&!buff.surge_of_power.up
            if A.FlameShock:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, EvaluateCycleFlameShock394) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- totem_mastery,if=talent.totem_mastery.enabled&(buff.resonance_totem.remains<6|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15))
            if A.TotemMastery:IsReady(unit) and (A.TotemMastery:IsSpellLearned() and (Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) < 6 or (Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) < (A.AscendanceBuff.ID, true:BaseDuration() + A.Ascendance:GetCooldown()) and A.Ascendance:GetCooldown() < 15))) then
                return A.TotemMastery:Show(icon)
            end
            -- frost_shock,if=talent.icefury.enabled&buff.icefury.up&(buff.icefury.remains<gcd*4*buff.icefury.stack|buff.stormkeeper.up|!talent.master_of_the_elements.enabled)
            if A.FrostShock:IsReady(unit) and (A.Icefury:IsSpellLearned() and Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and (Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) < A.GetGCD() * 4 * Unit("player"):HasBuffsStacks(A.IcefuryBuff.ID, true) or Unit("player"):HasBuffs(A.StormkeeperBuff.ID, true) or not A.MasteroftheElements:IsSpellLearned())) then
                return A.FrostShock:Show(icon)
            end
            -- icefury,if=talent.icefury.enabled
            if A.Icefury:IsReady(unit) and (A.Icefury:IsSpellLearned()) then
                return A.Icefury:Show(icon)
            end
            -- lightning_bolt
            if A.LightningBolt:IsReady(unit) then
                return A.LightningBolt:Show(icon)
            end
            -- flame_shock,moving=1,target_if=refreshable
            if A.FlameShock:IsReady(unit) and isMoving then
                if Action.Utils.CastTargetIf(A.FlameShock, 40, EvaluateCycleFlameShock443) then
                    return A.FlameShock:Show(icon) 
                end
            end
            -- flame_shock,moving=1,if=movement.distance>6
            if A.FlameShock:IsReady(unit) and isMoving and (Unit(unit):GetRange() > 6) then
                return A.FlameShock:Show(icon)
            end
            -- frost_shock,moving=1
            if A.FrostShock:IsReady(unit) and isMoving then
                return A.FrostShock:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- bloodlust,if=azerite.ancestral_resonance.enabled
            -- potion,if=expected_combat_length-time<30|cooldown.fire_elemental.remains>120|cooldown.storm_elemental.remains>120
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (expected_combat_length - Unit("player"):CombatTime < 30 or A.FireElemental:GetCooldown() > 120 or A.StormElemental:GetCooldown() > 120) then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- wind_shear
            if A.WindShear:IsReady(unit) and Action.GetToggle.InterruptEnabled then
                return A.WindShear:Show(icon)
            end
            -- totem_mastery,if=talent.totem_mastery.enabled&buff.resonance_totem.remains<2
            if A.TotemMastery:IsReady(unit) and (A.TotemMastery:IsSpellLearned() and Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) < 2) then
                return A.TotemMastery:Show(icon)
            end
            -- fire_elemental,if=!talent.storm_elemental.enabled
            if A.FireElemental:IsReady(unit) and A.BurstIsON(unit) and (not A.StormElemental:IsSpellLearned()) then
                return A.FireElemental:Show(icon)
            end
            -- storm_elemental,if=talent.storm_elemental.enabled&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up)
            if A.StormElemental:IsReady(unit) and A.BurstIsON(unit) and (A.StormElemental:IsSpellLearned() and (not A.Icefury:IsSpellLearned() or not Unit("player"):HasBuffs(A.IcefuryBuff.ID, true) and not A.Icefury:GetCooldown() == 0)) then
                return A.StormElemental:Show(icon)
            end
            -- earth_elemental,if=!talent.primal_elementalist.enabled|talent.primal_elementalist.enabled&(cooldown.fire_elemental.remains<120&!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120&talent.storm_elemental.enabled)
            -- use_items
            -- blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or A.Ascendance:GetCooldown() > 50) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=!talent.ascendance.enabled|buff.ascendance.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or A.Ascendance:GetCooldown() > 50) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remains>50
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not A.Ascendance:IsSpellLearned() or Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or A.Ascendance:GetCooldown() > 50) then
                return A.AncestralCall:Show(icon)
            end
            -- run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2)
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2 and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2 or MultiUnits:GetByRangeInCombat(40, 5, 10) > 2)) then
                return Aoe(unit);
            end
            -- run_action_list,name=single_target
            if (true) then
                return SingleUnitunit(unit);
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

