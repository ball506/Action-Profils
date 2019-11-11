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
Action[ACTION_CONST_SHAMAN_ENHANCEMENT] = {
    LightningShield                        = Action.Create({Type = "Spell", ID = 192106 }),
    CrashLightning                         = Action.Create({Type = "Spell", ID = 187874 }),
    CrashLightningBuff                     = Action.Create({Type = "Spell", ID = 187874 }),
    Rockbiter                              = Action.Create({Type = "Spell", ID = 193786 }),
    Landslide                              = Action.Create({Type = "Spell", ID = 197992 }),
    LandslideBuff                          = Action.Create({Type = "Spell", ID = 202004 }),
    Windstrike                             = Action.Create({Type = "Spell", ID = 115356 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    AscendanceBuff                         = Action.Create({Type = "Spell", ID = 114051 }),
    Ascendance                             = Action.Create({Type = "Spell", ID = 114051 }),
    FeralSpirit                            = Action.Create({Type = "Spell", ID = 51533 }),
    Strike                                 = Action.Create({Type = "Spell", ID =  }),
    EarthenSpike                           = Action.Create({Type = "Spell", ID = 188089 }),
    Stormstrike                            = Action.Create({Type = "Spell", ID = 17364 }),
    LightningConduit                       = Action.Create({Type = "Spell", ID = 275388 }),
    LightningConduitDebuff                 = Action.Create({Type = "Spell", ID = 275391 }),
    StormbringerBuff                       = Action.Create({Type = "Spell", ID = 201845 }),
    GatheringStormsBuff                    = Action.Create({Type = "Spell", ID = 198300 }),
    LightningBolt                          = Action.Create({Type = "Spell", ID = 187837 }),
    Overcharge                             = Action.Create({Type = "Spell", ID = 210727 }),
    Sundering                              = Action.Create({Type = "Spell", ID = 197214 }),
    ForcefulWinds                          = Action.Create({Type = "Spell", ID = 262647 }),
    Flametongue                            = Action.Create({Type = "Spell", ID = 193796 }),
    SearingAssault                         = Action.Create({Type = "Spell", ID = 192087 }),
    LavaLash                               = Action.Create({Type = "Spell", ID = 60103 }),
    PrimalPrimer                           = Action.Create({Type = "Spell", ID = 272992 }),
    HotHand                                = Action.Create({Type = "Spell", ID = 201900 }),
    HotHandBuff                            = Action.Create({Type = "Spell", ID = 215785 }),
    StrengthofEarthBuff                    = Action.Create({Type = "Spell", ID = 273465 }),
    CrashingStorm                          = Action.Create({Type = "Spell", ID = 192246 }),
    Frostbrand                             = Action.Create({Type = "Spell", ID = 196834 }),
    Hailstorm                              = Action.Create({Type = "Spell", ID = 210853 }),
    FrostbrandBuff                         = Action.Create({Type = "Spell", ID = 196834 }),
    PrimalPrimerDebuff                     = Action.Create({Type = "Spell", ID = 273006 }),
    FlametongueBuff                        = Action.Create({Type = "Spell", ID = 194084 }),
    FuryofAir                              = Action.Create({Type = "Spell", ID = 197211 }),
    FuryofAirBuff                          = Action.Create({Type = "Spell", ID = 197211 }),
    TotemMastery                           = Action.Create({Type = "Spell", ID = 262395 }),
    ResonanceTotemBuff                     = Action.Create({Type = "Spell", ID = 262419 }),
    SunderingDebuff                        = Action.Create({Type = "Spell", ID = 197214 }),
    NaturalHarmony                         = Action.Create({Type = "Spell", ID = 278697 }),
    NaturalHarmonyFrostBuff                = Action.Create({Type = "Spell", ID = 279029 }),
    NaturalHarmonyFireBuff                 = Action.Create({Type = "Spell", ID = 279028 }),
    NaturalHarmonyNatureBuff               = Action.Create({Type = "Spell", ID = 279033 }),
    WindShear                              = Action.Create({Type = "Spell", ID = 57994 }),
    EarthenSpikeDebuff                     = Action.Create({Type = "Spell", ID = 188089 }),
    Boulderfist                            = Action.Create({Type = "Spell", ID = 246035 }),
    StrengthofEarth                        = Action.Create({Type = "Spell", ID = 273461 })
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
Action:CreateEssencesFor(ACTION_CONST_SHAMAN_ENHANCEMENT)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ENHANCEMENT], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarFurycheckCl = 0;
local VarCooldownSync = 0;
local VarFurycheckEs = 0;
local VarFurycheckSs = 0;
local VarFurycheckLb = 0;
local VarOcpoolSs = 0;
local VarOcpoolCl = 0;
local VarOcpoolLl = 0;
local VarFurycheckLl = 0;
local VarFurycheckFb = 0;
local VarClpoolLl = 0;
local VarClpoolSs = 0;
local VarFreezerburnEnabled = 0;
local VarOcpool = 0;
local VarOcpoolFb = 0;
local VarRockslideEnabled = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarFurycheckCl = 0
  VarCooldownSync = 0
  VarFurycheckEs = 0
  VarFurycheckSs = 0
  VarFurycheckLb = 0
  VarOcpoolSs = 0
  VarOcpoolCl = 0
  VarOcpoolLl = 0
  VarFurycheckLl = 0
  VarFurycheckFb = 0
  VarClpoolLl = 0
  VarClpoolSs = 0
  VarFreezerburnEnabled = 0
  VarOcpool = 0
  VarOcpoolFb = 0
  VarRockslideEnabled = 0
	end 
end)

local EnemyRanges = {40, 8, 5}
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


local function EvaluateCycleStormstrike72(unit)
  return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and bool(A.LightningConduit:GetAzeriteRank()) and not Unit(unit):HasDeBuffs(A.LightningConduitDebuff.ID, true) and bool(VarFurycheckSs)
end

local function EvaluateTargetIfFilterLavaLash202(unit)
  return Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true)
end

local function EvaluateTargetIfLavaLash217(unit)
  return A.PrimalPrimer:GetAzeriteRank() >= 2 and Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 and bool(VarFurycheckLl) and bool(VarClpoolLl)
end


local function EvaluateCycleStormstrike228(unit)
  return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and bool(A.LightningConduit:GetAzeriteRank()) and not Unit(unit):HasDeBuffs(A.LightningConduitDebuff.ID, true) and bool(VarFurycheckSs)
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
        local Precombat, Asc, Cds, DefaultCore, Filler, FreezerburnCore, Maintenance, Opener, Priority
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofAgility:Show(icon)
            end
            -- lightning_shield
            if A.LightningShield:IsReady(unit) then
                return A.LightningShield:Show(icon)
            end
        end
        
        --Asc
        local function Asc(unit)
            -- crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (not Unit("player"):HasBuffs(A.CrashLightningBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and bool(VarFurycheckCl)) then
                return A.CrashLightning:Show(icon)
            end
            -- rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
            if A.Rockbiter:IsReady(unit) and (A.Landslide:IsSpellLearned() and not Unit("player"):HasBuffs(A.LandslideBuff.ID, true) and A.Rockbiter:ChargesFractionalP() > 1.7) then
                return A.Rockbiter:Show(icon)
            end
            -- windstrike
            if A.Windstrike:IsReady(unit) then
                return A.Windstrike:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- bloodlust,if=azerite.ancestral_resonance.enabled
            -- berserking,if=variable.cooldown_sync
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (bool(VarCooldownSync)) then
                return A.Berserking:Show(icon)
            end
            -- blood_fury,if=variable.cooldown_sync
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (bool(VarCooldownSync)) then
                return A.BloodFury:Show(icon)
            end
            -- fireblood,if=variable.cooldown_sync
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (bool(VarCooldownSync)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=variable.cooldown_sync
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (bool(VarCooldownSync)) then
                return A.AncestralCall:Show(icon)
            end
            -- potion,if=buff.ascendance.up|!talent.ascendance.enabled&feral_spirit.remains>5|target.time_to_die<=60
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or not A.Ascendance:IsSpellLearned() and feral_spirit.remains > 5 or Unit(unit):TimeToDie() <= 60) then
                A.BattlePotionofAgility:Show(icon)
            end
            -- feral_spirit
            if A.FeralSpirit:IsReady(unit) then
                return A.FeralSpirit:Show(icon)
            end
            -- ascendance,if=cooldown.strike.remains>0
            if A.Ascendance:IsReady(unit) and (A.Strike:GetCooldown() > 0) then
                return A.Ascendance:Show(icon)
            end
            -- earth_elemental
        end
        
        --DefaultCore
        local function DefaultCore(unit)
            -- earthen_spike,if=variable.furyCheck_ES
            if A.EarthenSpike:IsReady(unit) and (bool(VarFurycheckEs)) then
                return A.EarthenSpike:Show(icon)
            end
            -- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS
            if A.Stormstrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Stormstrike, 40, EvaluateCycleStormstrike72) then
                    return A.Stormstrike:Show(icon) 
                end
            end
            -- stormstrike,if=buff.stormbringer.up|(active_enemies>1&buff.gathering_storms.up&variable.furyCheck_SS)
            if A.Stormstrike:IsReady(unit) and (Unit("player"):HasBuffs(A.StormbringerBuff.ID, true) or (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffs(A.GatheringStormsBuff.ID, true) and bool(VarFurycheckSs))) then
                return A.Stormstrike:Show(icon)
            end
            -- crash_lightning,if=active_enemies>=3&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and bool(VarFurycheckCl)) then
                return A.CrashLightning:Show(icon)
            end
            -- lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck_LB&maelstrom>=40
            if A.LightningBolt:IsReady(unit) and (A.Overcharge:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and bool(VarFurycheckLb) and Unit("player"):Maelstrom() >= 40) then
                return A.LightningBolt:Show(icon)
            end
            -- stormstrike,if=variable.OCPool_SS&variable.furyCheck_SS
            if A.Stormstrike:IsReady(unit) and (bool(VarOcpoolSs) and bool(VarFurycheckSs)) then
                return A.Stormstrike:Show(icon)
            end
        end
        
        --Filler
        local function Filler(unit)
            -- sundering
            if A.Sundering:IsReady(unit) then
                return A.Sundering:Show(icon)
            end
            -- crash_lightning,if=talent.forceful_winds.enabled&active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (A.ForcefulWinds:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and bool(VarFurycheckCl)) then
                return A.CrashLightning:Show(icon)
            end
            -- flametongue,if=talent.searing_assault.enabled
            if A.Flametongue:IsReady(unit) and (A.SearingAssault:IsSpellLearned()) then
                return A.Flametongue:Show(icon)
            end
            -- lava_lash,if=!azerite.primal_primer.enabled&talent.hot_hand.enabled&buff.hot_hand.react
            if A.LavaLash:IsReady(unit) and (not bool(A.PrimalPrimer:GetAzeriteRank()) and A.HotHand:IsSpellLearned() and bool(Unit("player"):HasBuffsStacks(A.HotHandBuff.ID, true))) then
                return A.LavaLash:Show(icon)
            end
            -- crash_lightning,if=active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and bool(VarFurycheckCl)) then
                return A.CrashLightning:Show(icon)
            end
            -- rockbiter,if=maelstrom<70&!buff.strength_of_earth.up
            if A.Rockbiter:IsReady(unit) and (Unit("player"):Maelstrom() < 70 and not Unit("player"):HasBuffs(A.StrengthofEarthBuff.ID, true)) then
                return A.Rockbiter:Show(icon)
            end
            -- crash_lightning,if=talent.crashing_storm.enabled&variable.OCPool_CL
            if A.CrashLightning:IsReady(unit) and (A.CrashingStorm:IsSpellLearned() and bool(VarOcpoolCl)) then
                return A.CrashLightning:Show(icon)
            end
            -- lava_lash,if=variable.OCPool_LL&variable.furyCheck_LL
            if A.LavaLash:IsReady(unit) and (bool(VarOcpoolLl) and bool(VarFurycheckLl)) then
                return A.LavaLash:Show(icon)
            end
            -- rockbiter
            if A.Rockbiter:IsReady(unit) then
                return A.Rockbiter:Show(icon)
            end
            -- frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8+gcd&variable.furyCheck_FB
            if A.Frostbrand:IsReady(unit) and (A.Hailstorm:IsSpellLearned() and Unit("player"):HasBuffs(A.FrostbrandBuff.ID, true) < 4.8 + A.GetGCD() and bool(VarFurycheckFb)) then
                return A.Frostbrand:Show(icon)
            end
            -- flametongue
            if A.Flametongue:IsReady(unit) then
                return A.Flametongue:Show(icon)
            end
        end
        
        --FreezerburnCore
        local function FreezerburnCore(unit)
            -- lava_lash,target_if=max:debuff.primal_primer.stack,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack=10&variable.furyCheck_LL&variable.CLPool_LL
            if A.LavaLash:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.LavaLash, 40, "max", EvaluateTargetIfFilterLavaLash202, EvaluateTargetIfLavaLash217) then 
                    return A.LavaLash:Show(icon) 
                end
            end
            -- earthen_spike,if=variable.furyCheck_ES
            if A.EarthenSpike:IsReady(unit) and (bool(VarFurycheckEs)) then
                return A.EarthenSpike:Show(icon)
            end
            -- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS
            if A.Stormstrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Stormstrike, 40, EvaluateCycleStormstrike228) then
                    return A.Stormstrike:Show(icon) 
                end
            end
            -- stormstrike,if=buff.stormbringer.up|(active_enemies>1&buff.gathering_storms.up&variable.furyCheck_SS)
            if A.Stormstrike:IsReady(unit) and (Unit("player"):HasBuffs(A.StormbringerBuff.ID, true) or (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit("player"):HasBuffs(A.GatheringStormsBuff.ID, true) and bool(VarFurycheckSs))) then
                return A.Stormstrike:Show(icon)
            end
            -- crash_lightning,if=active_enemies>=3&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and bool(VarFurycheckCl)) then
                return A.CrashLightning:Show(icon)
            end
            -- lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck_LB&maelstrom>=40
            if A.LightningBolt:IsReady(unit) and (A.Overcharge:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and bool(VarFurycheckLb) and Unit("player"):Maelstrom() >= 40) then
                return A.LightningBolt:Show(icon)
            end
            -- lava_lash,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack>7&variable.furyCheck_LL&variable.CLPool_LL
            if A.LavaLash:IsReady(unit) and (A.PrimalPrimer:GetAzeriteRank() >= 2 and Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) > 7 and bool(VarFurycheckLl) and bool(VarClpoolLl)) then
                return A.LavaLash:Show(icon)
            end
            -- stormstrike,if=variable.OCPool_SS&variable.furyCheck_SS&variable.CLPool_SS
            if A.Stormstrike:IsReady(unit) and (bool(VarOcpoolSs) and bool(VarFurycheckSs) and bool(VarClpoolSs)) then
                return A.Stormstrike:Show(icon)
            end
            -- lava_lash,if=debuff.primal_primer.stack=10&variable.furyCheck_LL
            if A.LavaLash:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 and bool(VarFurycheckLl)) then
                return A.LavaLash:Show(icon)
            end
        end
        
        --Maintenance
        local function Maintenance(unit)
            -- flametongue,if=!buff.flametongue.up
            if A.Flametongue:IsReady(unit) and (not Unit("player"):HasBuffs(A.FlametongueBuff.ID, true)) then
                return A.Flametongue:Show(icon)
            end
            -- frostbrand,if=talent.hailstorm.enabled&!buff.frostbrand.up&variable.furyCheck_FB
            if A.Frostbrand:IsReady(unit) and (A.Hailstorm:IsSpellLearned() and not Unit("player"):HasBuffs(A.FrostbrandBuff.ID, true) and bool(VarFurycheckFb)) then
                return A.Frostbrand:Show(icon)
            end
        end
        
        --Opener
        local function Opener(unit)
            -- rockbiter,if=maelstrom<15&time<gcd
            if A.Rockbiter:IsReady(unit) and (Unit("player"):Maelstrom() < 15 and Unit("player"):CombatTime < A.GetGCD()) then
                return A.Rockbiter:Show(icon)
            end
        end
        
        --Priority
        local function Priority(unit)
            -- crash_lightning,if=active_enemies>=(8-(talent.forceful_winds.enabled*3))&variable.freezerburn_enabled&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= (8 - (num(A.ForcefulWinds:IsSpellLearned()) * 3)) and bool(VarFreezerburnEnabled) and bool(VarFurycheckCl)) then
                return A.CrashLightning:Show(icon)
            end
            -- lava_lash,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack=10&active_enemies=1&variable.freezerburn_enabled&variable.furyCheck_LL
            if A.LavaLash:IsReady(unit) and (A.PrimalPrimer:GetAzeriteRank() >= 2 and Unit(unit):HasDeBuffsStacks(A.PrimalPrimerDebuff.ID, true) == 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and bool(VarFreezerburnEnabled) and bool(VarFurycheckLl)) then
                return A.LavaLash:Show(icon)
            end
            -- crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck_CL
            if A.CrashLightning:IsReady(unit) and (not Unit("player"):HasBuffs(A.CrashLightningBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and bool(VarFurycheckCl)) then
                return A.CrashLightning:Show(icon)
            end
            -- fury_of_air,if=!buff.fury_of_air.up&maelstrom>=20&spell_targets.fury_of_air_damage>=(1+variable.freezerburn_enabled)
            if A.FuryofAir:IsReady(unit) and (not Unit("player"):HasBuffs(A.FuryofAirBuff.ID, true) and Unit("player"):Maelstrom() >= 20 and MultiUnits:GetByRangeInCombat(40, 5, 10) >= (1 + VarFreezerburnEnabled)) then
                return A.FuryofAir:Show(icon)
            end
            -- fury_of_air,if=buff.fury_of_air.up&&spell_targets.fury_of_air_damage<(1+variable.freezerburn_enabled)
            if A.FuryofAir:IsReady(unit) and (Unit("player"):HasBuffs(A.FuryofAirBuff.ID, true) and true and MultiUnits:GetByRangeInCombat(40, 5, 10) < (1 + VarFreezerburnEnabled)) then
                return A.FuryofAir:Show(icon)
            end
            -- totem_mastery,if=buff.resonance_totem.remains<=2*gcd
            if A.TotemMastery:IsReady(unit) and (Unit("player"):HasBuffs(A.ResonanceTotemBuff.ID, true) <= 2 * A.GetGCD()) then
                return A.TotemMastery:Show(icon)
            end
            -- sundering,if=active_enemies>=3
            if A.Sundering:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
                return A.Sundering:Show(icon)
            end
            -- rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7
            if A.Rockbiter:IsReady(unit) and (A.Landslide:IsSpellLearned() and not Unit("player"):HasBuffs(A.LandslideBuff.ID, true) and A.Rockbiter:ChargesFractionalP() > 1.7) then
                return A.Rockbiter:Show(icon)
            end
            -- frostbrand,if=(azerite.natural_harmony.enabled&buff.natural_harmony_frost.remains<=2*gcd)&talent.hailstorm.enabled&variable.furyCheck_FB
            if A.Frostbrand:IsReady(unit) and ((bool(A.NaturalHarmony:GetAzeriteRank()) and Unit("player"):HasBuffs(A.NaturalHarmonyFrostBuff.ID, true) <= 2 * A.GetGCD()) and A.Hailstorm:IsSpellLearned() and bool(VarFurycheckFb)) then
                return A.Frostbrand:Show(icon)
            end
            -- flametongue,if=(azerite.natural_harmony.enabled&buff.natural_harmony_fire.remains<=2*gcd)
            if A.Flametongue:IsReady(unit) and ((bool(A.NaturalHarmony:GetAzeriteRank()) and Unit("player"):HasBuffs(A.NaturalHarmonyFireBuff.ID, true) <= 2 * A.GetGCD())) then
                return A.Flametongue:Show(icon)
            end
            -- rockbiter,if=(azerite.natural_harmony.enabled&buff.natural_harmony_nature.remains<=2*gcd)&maelstrom<70
            if A.Rockbiter:IsReady(unit) and ((bool(A.NaturalHarmony:GetAzeriteRank()) and Unit("player"):HasBuffs(A.NaturalHarmonyNatureBuff.ID, true) <= 2 * A.GetGCD()) and Unit("player"):Maelstrom() < 70) then
                return A.Rockbiter:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- wind_shear
            if A.WindShear:IsReady(unit) and Action.GetToggle.InterruptEnabled then
                return A.WindShear:Show(icon)
            end
            -- variable,name=cooldown_sync,value=(talent.ascendance.enabled&(buff.ascendance.up|cooldown.ascendance.remains>50))|(!talent.ascendance.enabled&(feral_spirit.remains>5|cooldown.feral_spirit.remains>50))
            if (true) then
                VarCooldownSync = num((A.Ascendance:IsSpellLearned() and (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true) or A.Ascendance:GetCooldown() > 50)) or (not A.Ascendance:IsSpellLearned() and (feral_spirit.remains > 5 or A.FeralSpirit:GetCooldown() > 50)))
            end
            -- variable,name=furyCheck_SS,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.stormstrike.cost))
            if (true) then
                VarFurycheckSs = num(Unit("player"):Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.Stormstrike:Cost())))
            end
            -- variable,name=furyCheck_LL,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.lava_lash.cost))
            if (true) then
                VarFurycheckLl = num(Unit("player"):Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.LavaLash:Cost())))
            end
            -- variable,name=furyCheck_CL,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.crash_lightning.cost))
            if (true) then
                VarFurycheckCl = num(Unit("player"):Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.CrashLightning:Cost())))
            end
            -- variable,name=furyCheck_FB,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.frostbrand.cost))
            if (true) then
                VarFurycheckFb = num(Unit("player"):Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.Frostbrand:Cost())))
            end
            -- variable,name=furyCheck_ES,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.earthen_spike.cost))
            if (true) then
                VarFurycheckEs = num(Unit("player"):Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + A.EarthenSpike:Cost())))
            end
            -- variable,name=furyCheck_LB,value=maelstrom>=(talent.fury_of_air.enabled*(6+40))
            if (true) then
                VarFurycheckLb = num(Unit("player"):Maelstrom() >= (num(A.FuryofAir:IsSpellLearned()) * (6 + 40)))
            end
            -- variable,name=OCPool,value=(active_enemies>1|(cooldown.lightning_bolt.remains>=2*gcd))
            if (true) then
                VarOcpool = num((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or (A.LightningBolt:GetCooldown() >= 2 * A.GetGCD())))
            end
            -- variable,name=OCPool_SS,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.stormstrike.cost)))
            if (true) then
                VarOcpoolSs = num((bool(VarOcpool) or Unit("player"):Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.Stormstrike:Cost()))))
            end
            -- variable,name=OCPool_LL,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.lava_lash.cost)))
            if (true) then
                VarOcpoolLl = num((bool(VarOcpool) or Unit("player"):Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.LavaLash:Cost()))))
            end
            -- variable,name=OCPool_CL,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.crash_lightning.cost)))
            if (true) then
                VarOcpoolCl = num((bool(VarOcpool) or Unit("player"):Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.CrashLightning:Cost()))))
            end
            -- variable,name=OCPool_FB,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.frostbrand.cost)))
            if (true) then
                VarOcpoolFb = num((bool(VarOcpool) or Unit("player"):Maelstrom() >= (num(A.Overcharge:IsSpellLearned()) * (40 + A.Frostbrand:Cost()))))
            end
            -- variable,name=CLPool_LL,value=active_enemies=1|maelstrom>=(action.crash_lightning.cost+action.lava_lash.cost)
            if (true) then
                VarClpoolLl = num(MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Unit("player"):Maelstrom() >= (A.CrashLightning:Cost() + A.LavaLash:Cost()))
            end
            -- variable,name=CLPool_SS,value=active_enemies=1|maelstrom>=(action.crash_lightning.cost+action.stormstrike.cost)
            if (true) then
                VarClpoolSs = num(MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Unit("player"):Maelstrom() >= (A.CrashLightning:Cost() + A.Stormstrike:Cost()))
            end
            -- variable,name=freezerburn_enabled,value=(talent.hot_hand.enabled&talent.hailstorm.enabled&azerite.primal_primer.enabled)
            if (true) then
                VarFreezerburnEnabled = num((A.HotHand:IsSpellLearned() and A.Hailstorm:IsSpellLearned() and bool(A.PrimalPrimer:GetAzeriteRank())))
            end
            -- variable,name=rockslide_enabled,value=(!variable.freezerburn_enabled&(talent.boulderfist.enabled&talent.landslide.enabled&azerite.strength_of_earth.enabled))
            if (true) then
                VarRockslideEnabled = num((not bool(VarFreezerburnEnabled) and (A.Boulderfist:IsSpellLearned() and A.Landslide:IsSpellLearned() and bool(A.StrengthofEarth:GetAzeriteRank()))))
            end
            -- auto_attack
            -- use_items
            -- call_action_list,name=opener
            if (true) then
                local ShouldReturn = Opener(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=asc,if=buff.ascendance.up
            if (Unit("player"):HasBuffs(A.AscendanceBuff.ID, true)) then
                local ShouldReturn = Asc(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=priority
            if (true) then
                local ShouldReturn = Priority(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=maintenance,if=active_enemies<3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                local ShouldReturn = Maintenance(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cds
            if (true) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=freezerburn_core,if=variable.freezerburn_enabled
            if (bool(VarFreezerburnEnabled)) then
                local ShouldReturn = FreezerburnCore(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=default_core,if=!variable.freezerburn_enabled
            if (not bool(VarFreezerburnEnabled)) then
                local ShouldReturn = DefaultCore(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=maintenance,if=active_enemies>=3
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
                local ShouldReturn = Maintenance(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=filler
            if (true) then
                local ShouldReturn = Filler(unit); if ShouldReturn then return ShouldReturn; end
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

