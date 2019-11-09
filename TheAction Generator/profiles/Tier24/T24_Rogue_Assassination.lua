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
    MarkedForDeath                         = Action.Create({Type = "Spell", ID = 137619 }),
    ApplyPoison                            = Action.Create({Type = "Spell", ID =  }),
    Stealth                                = Action.Create({Type = "Spell", ID =  }),
    Vendetta                               = Action.Create({Type = "Spell", ID = 79140 }),
    VendettaDebuff                         = Action.Create({Type = "Spell", ID = 79140 }),
    ToxicBladeDebuff                       = Action.Create({Type = "Spell", ID = 245389 }),
    RuptureDebuff                          = Action.Create({Type = "Spell", ID = 1943 }),
    Subterfuge                             = Action.Create({Type = "Spell", ID = 108208 }),
    ShroudedSuffocation                    = Action.Create({Type = "Spell", ID =  }),
    GarroteDebuff                          = Action.Create({Type = "Spell", ID = 703 }),
    Garrote                                = Action.Create({Type = "Spell", ID = 703 }),
    Vanish                                 = Action.Create({Type = "Spell", ID = 1856 }),
    Nightstalker                           = Action.Create({Type = "Spell", ID = 14062 }),
    Exsanguinate                           = Action.Create({Type = "Spell", ID = 200806 }),
    DeeperStratagem                        = Action.Create({Type = "Spell", ID = 193531 }),
    RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
    ToxicBlade                             = Action.Create({Type = "Spell", ID = 245388 }),
    PoolResource                           = Action.Create({Type = "Spell", ID = 9999000010 }),
    MasterAssassin                         = Action.Create({Type = "Spell", ID =  }),
    BloodoftheEnemyDebuff                  = Action.Create({Type = "Spell", ID =  }),
    Shadowmeld                             = Action.Create({Type = "Spell", ID = 58984 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
    Envenom                                = Action.Create({Type = "Spell", ID = 32645 }),
    FanofKnives                            = Action.Create({Type = "Spell", ID = 51723 }),
    EchoingBlades                          = Action.Create({Type = "Spell", ID =  }),
    HiddenBladesBuff                       = Action.Create({Type = "Spell", ID =  }),
    DoubleDose                             = Action.Create({Type = "Spell", ID =  }),
    DeadlyPoisonDotDebuff                  = Action.Create({Type = "Spell", ID = 177918 }),
    Blindside                              = Action.Create({Type = "Spell", ID =  }),
    BlindsideBuff                          = Action.Create({Type = "Spell", ID =  }),
    VenomRush                              = Action.Create({Type = "Spell", ID = 152152 }),
    Mutilate                               = Action.Create({Type = "Spell", ID = 1329 }),
    ScentofBlood                           = Action.Create({Type = "Spell", ID =  }),
    Rupture                                = Action.Create({Type = "Spell", ID = 1943 }),
    CrimsonTempest                         = Action.Create({Type = "Spell", ID = 121411 }),
    CrimsonTempestBuff                     = Action.Create({Type = "Spell", ID = 121411 }),
    ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
    ConcentratedFlameBurnDebuff            = Action.Create({Type = "Spell", ID =  }),
    BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
    GuardianofAzeroth                      = Action.Create({Type = "Spell", ID =  }),
    FocusedAzeriteBeam                     = Action.Create({Type = "Spell", ID =  }),
    PurifyingBlast                         = Action.Create({Type = "Spell", ID =  }),
    TheUnboundForce                        = Action.Create({Type = "Spell", ID =  }),
    RecklessForceBuff                      = Action.Create({Type = "Spell", ID =  }),
    RecklessForceCounterBuff               = Action.Create({Type = "Spell", ID =  }),
    RippleInSpace                          = Action.Create({Type = "Spell", ID =  }),
    WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
    LifebloodBuff                          = Action.Create({Type = "Spell", ID =  }),
    MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
    SubterfugeBuff                         = Action.Create({Type = "Spell", ID = 108208 }),
    ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
    ArcanePulse                            = Action.Create({Type = "Spell", ID =  }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 })
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
    Channeling                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                          = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast 				             = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_ROGUE_ASSASSINATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_ASSASSINATION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarVendettaSubterfugeCondition = 0;
local VarVendettaNightstalkerCondition = 0;
local VarVendettaFontCondition = 0;
local VarSingleUnit(unit) = 0;
local VarSsVanishCondition = 0;
local VarEnergyRegenCombined = 0;
local VarUseFiller = 0;
local VarSkipCycleGarrote = 0;
local VarSkipCycleRupture = 0;
local VarSkipRupture = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarVendettaSubterfugeCondition = 0
  VarVendettaNightstalkerCondition = 0
  VarVendettaFontCondition = 0
  VarSingleUnit(unit) = 0
  VarSsVanishCondition = 0
  VarEnergyRegenCombined = 0
  VarUseFiller = 0
  VarSkipCycleGarrote = 0
  VarSkipCycleRupture = 0
  VarSkipRupture = 0
	end 
end)

local EnemyRanges = {40, 10}
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


local function EvaluateTargetIfFilterMarkedForDeath31(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath36(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Unit("player"):ComboPointsDeficit() * 1.5 or Unit("player"):ComboPointsDeficit() >= Rogue.CPMaxSpend())
end

local function EvaluateCycleFanofKnives274(unit)
    return (not Unit(unit):HasDeBuffs(A.DeadlyPoisonDotDebuff)) and (bool(VarUseFiller) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3)
end

local function EvaluateCycleMutilate295(unit)
    return (not Unit(unit):HasDeBuffs(A.DeadlyPoisonDotDebuff)) and (bool(VarUseFiller) and MultiUnits:GetByRangeInCombat(40, 5, 10) == 2)
end

local function EvaluateCycleGarrote414(unit)
  return not bool(VarSkipCycleGarrote) and Unit(unit) ~= self.target and (not A.Subterfuge:IsSpellLearned() or not (A.Vanish:HasCooldownUps and A.Vendetta:GetCooldown() <= 4)) and Unit("player"):ComboPointsDeficit() >= 1 + 3 * num((A.ShroudedSuffocation:GetAzeriteRank() and A.Vanish:HasCooldownUps)) and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff) and (Unit(unit):PMultiplier(A.Garrote) <= 1 or Unit(unit):HasDeBuffs(A.GarroteDebuff) <= A.GarroteDebuff:TickTime and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + num(A.ShroudedSuffocation:GetAzeriteRank())) and (not HL.Exsanguinated(Unit(unit), "Garrote") or Unit(unit):HasDeBuffs(A.GarroteDebuff) <= A.GarroteDebuff:TickTime * 2 and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + num(A.ShroudedSuffocation:GetAzeriteRank())) and not bool(ss_buffed) and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff)) > 12 and (MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff) and A.ShroudedSuffocation:GetAzeriteRank())
end

local function EvaluateCycleRupture565(unit)
  return not bool(VarSkipCycleRupture) and not bool(VarSkipRupture) and Unit(unit) ~= self.target and Unit("player"):ComboPoints() >= 4 and Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff) and (Unit(unit):PMultiplier(A.Rupture) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff) <= A.RuptureDebuff:TickTime and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + num(A.ShroudedSuffocation:GetAzeriteRank())) and (not HL.Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff) <= A.RuptureDebuff:TickTime * 2 and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + num(A.ShroudedSuffocation:GetAzeriteRank())) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff) > 4
end

local function EvaluateTargetIfFilterGarrote721(unit)
  return Unit(unit):HasDeBuffs(A.GarroteDebuff)
end

local function EvaluateTargetIfGarrote758(unit)
  return A.Subterfuge:IsSpellLearned() and (Unit(unit):HasDeBuffs(A.GarroteDebuff) < 12 or Unit(unit):PMultiplier(A.Garrote) <= 1) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff) > 2
end

local function EvaluateTargetIfFilterGarrote776(unit)
  return Unit(unit):HasDeBuffs(A.GarroteDebuff)
end

local function EvaluateTargetIfGarrote807(unit)
  return A.Subterfuge:IsSpellLearned() and A.ShroudedSuffocation:GetAzeriteRank() and Unit(unit):TimeToDie() > Unit(unit):HasDeBuffs(A.GarroteDebuff) and (Unit(unit):HasDeBuffs(A.GarroteDebuff) < 18 or not bool(ss_buffed))
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
        local Precombat, Cds, Direct, Dot, Essences, Stealthed
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>15
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 15) then
                return A.MarkedForDeath:Show(icon)
            end
            -- apply_poison
            if A.ApplyPoison:IsReady(unit) then
                return A.ApplyPoison:Show(icon)
            end
            -- stealth
            if A.Stealth:IsReady(unit) then
                return A.Stealth:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
        end
        local function Cds(unit)
            -- use_item,name=azsharas_font_of_power,if=!stealthed.all&master_assassin_remains=0&(cooldown.vendetta.remains<?cooldown.toxic_blade.remains)<10+10*equipped.ashvanes_razor_coral&!debuff.vendetta.up&!debuff.toxic_blade.up
            if A.AzsharasFontofPower:IsReady(unit) and (not Unit("player"):IsStealthedP(true, true) and MasterAssassinRemains == 0 and num((A.Vendetta:GetCooldown() < ?cooldown.toxic_blade.remains)) < 10 + 10 * num(A.AshvanesRazorCoral:IsExists) and not Unit(unit):HasDeBuffs(A.VendettaDebuff) and not Unit(unit):HasDeBuffs(A.ToxicBladeDebuff)) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- call_action_list,name=essences,if=!stealthed.all&dot.rupture.ticking&master_assassin_remains=0
            if (not Unit("player"):IsStealthedP(true, true) and Unit(unit):HasDeBuffs(A.RuptureDebuff) and MasterAssassinRemains == 0) then
                local ShouldReturn = Essences(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit*1.5|combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath31, EvaluateTargetIfMarkedForDeath36) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 30 - raid_event.adds.duration and Unit("player"):ComboPointsDeficit() >= Rogue.CPMaxSpend()) then
                return A.MarkedForDeath:Show(icon)
            end
            -- variable,name=vendetta_subterfuge_condition,value=!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1&(spell_targets.fan_of_knives<6|!cooldown.vanish.up)
            if (true) then
                VarVendettaSubterfugeCondition = num(not A.Subterfuge:IsSpellLearned() or not A.ShroudedSuffocation:GetAzeriteRank() or Unit(unit):PMultiplier(A.Garrote) > 1 and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 6 or not A.Vanish:HasCooldownUps))
            end
            -- variable,name=vendetta_nightstalker_condition,value=!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled
            if (true) then
                VarVendettaNightstalkerCondition = num(not A.Nightstalker:IsSpellLearned() or not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() < 5 - 2 * num(A.DeeperStratagem:IsSpellLearned()))
            end
            -- variable,name=variable,name=vendetta_font_condition,value=!equipped.azsharas_font_of_power|azerite.shrouded_suffocation.enabled|debuff.razor_coral_debuff.down|trinket.ashvanes_razor_coral.cooldown.remains<10&(cooldown.toxic_blade.remains<1|debuff.toxic_blade.up)
            if (true) then
                VarVendettaFontCondition = num(not A.AzsharasFontofPower:IsExists or A.ShroudedSuffocation:GetAzeriteRank() or bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDeBuffDebuff)) or trinket.ashvanes_razor_coral.cooldown.remains < 10 and (A.ToxicBlade:GetCooldown() < 1 or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff)))
            end
            -- vendetta,if=!stealthed.rogue&dot.rupture.ticking&!debuff.vendetta.up&variable.vendetta_subterfuge_condition&variable.vendetta_nightstalker_condition&variable.vendetta_font_condition
            if A.Vendetta:IsReady(unit) and (not Unit("player"):IsStealthedP(true, false) and Unit(unit):HasDeBuffs(A.RuptureDebuff) and not Unit(unit):HasDeBuffs(A.VendettaDebuff) and bool(VarVendettaSubterfugeCondition) and bool(VarVendettaNightstalkerCondition) and bool(VarVendettaFontCondition)) then
                return A.Vendetta:Show(icon)
            end
            -- vanish,if=talent.exsanguinate.enabled&(talent.nightstalker.enabled|talent.subterfuge.enabled&variable.single_target)&combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1&(!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier<=1)
            if A.Vanish:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and (A.Nightstalker:IsSpellLearned() or A.Subterfuge:IsSpellLearned() and bool(VarSingleUnit(unit))) and Unit("player"):ComboPoints() >= Rogue.CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1 and (not A.Subterfuge:IsSpellLearned() or not A.ShroudedSuffocation:GetAzeriteRank() or Unit(unit):PMultiplier(A.Garrote) <= 1)) then
                return A.Vanish:Show(icon)
            end
            -- vanish,if=talent.nightstalker.enabled&!talent.exsanguinate.enabled&combo_points>=cp_max_spend&debuff.vendetta.up
            if A.Vanish:IsReady(unit) and (A.Nightstalker:IsSpellLearned() and not A.Exsanguinate:IsSpellLearned() and Unit("player"):ComboPoints() >= Rogue.CPMaxSpend() and Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                return A.Vanish:Show(icon)
            end
            -- variable,name=ss_vanish_condition,value=azerite.shrouded_suffocation.enabled&(non_ss_buffed_targets>=1|spell_targets.fan_of_knives=3)&(ss_buffed_targets_above_pandemic=0|spell_targets.fan_of_knives>=6)
            if (true) then
                VarSsVanishCondition = num(A.ShroudedSuffocation:GetAzeriteRank() and (non_ss_buffed_targets >= 1 or MultiUnits:GetByRangeInCombat(40, 5, 10) == 3) and (ss_buffed_targets_above_pandemic == 0 or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 6))
            end
            -- pool_resource,for_next=1,extra_amount=45
            -- vanish,if=talent.subterfuge.enabled&!stealthed.rogue&cooldown.garrote.up&(variable.ss_vanish_condition|!azerite.shrouded_suffocation.enabled&dot.garrote.refreshable)&combo_points.deficit>=((1+2*azerite.shrouded_suffocation.enabled)*spell_targets.fan_of_knives)>?4&raid_event.adds.in>12
            if A.Vanish:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and not Unit("player"):IsStealthedP(true, false) and A.Garrote:HasCooldownUps and (bool(VarSsVanishCondition) or not A.ShroudedSuffocation:GetAzeriteRank() and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff)) and Unit("player"):ComboPointsDeficit() >= num(((1 + 2 * num(A.ShroudedSuffocation:GetAzeriteRank())) * MultiUnits:GetByRangeInCombat(40, 5, 10)) > ?4) and 10000000000 > 12) then
                if A.Vanish:IsUsablePPool(45) then
                    return A.Vanish:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- vanish,if=talent.master_assassin.enabled&!stealthed.all&master_assassin_remains<=0&!dot.rupture.refreshable&dot.garrote.remains>3&debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up)&(!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up)
            if A.Vanish:IsReady(unit) and (A.MasterAssassin:IsSpellLearned() and not Unit("player"):IsStealthedP(true, true) and MasterAssassinRemains <= 0 and not Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff) and Unit(unit):HasDeBuffs(A.GarroteDebuff) > 3 and Unit(unit):HasDeBuffs(A.VendettaDebuff) and (not A.ToxicBlade:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff)) and (not bool(essence.blood_of_the_enemy.major) or Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff))) then
                return A.Vanish:Show(icon)
            end
            -- shadowmeld,if=!stealthed.all&azerite.shrouded_suffocation.enabled&dot.garrote.refreshable&dot.garrote.pmultiplier<=1&combo_points.deficit>=1
            if A.Shadowmeld:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):IsStealthedP(true, true) and A.ShroudedSuffocation:GetAzeriteRank() and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff) and Unit(unit):PMultiplier(A.Garrote) <= 1 and Unit("player"):ComboPointsDeficit() >= 1) then
                return A.Shadowmeld:Show(icon)
            end
            -- exsanguinate,if=dot.rupture.remains>4+4*cp_max_spend&!dot.garrote.refreshable
            if A.Exsanguinate:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff) > 4 + 4 * Rogue.CPMaxSpend() and not Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff)) then
                return A.Exsanguinate:Show(icon)
            end
            -- toxic_blade,if=dot.rupture.ticking&(!equipped.azsharas_font_of_power|cooldown.vendetta.remains>10)
            if A.ToxicBlade:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RuptureDebuff) and (not A.AzsharasFontofPower:IsExists or A.Vendetta:GetCooldown() > 10)) then
                return A.ToxicBlade:Show(icon)
            end
            -- potion,if=buff.bloodlust.react|debuff.vendetta.up
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism or Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                A.ProlongedPower:Show(icon)
            end
            -- blood_fury,if=debuff.vendetta.up
            if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=debuff.vendetta.up
            if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=debuff.vendetta.up
            if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=debuff.vendetta.up
            if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                return A.AncestralCall:Show(icon)
            end
            -- use_item,name=galecallers_boon,if=cooldown.vendetta.remains>45
            if A.GalecallersBoon:IsReady(unit) and (A.Vendetta:GetCooldown() > 45) then
                A.GalecallersBoon:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.vendetta.remains>10-4*equipped.azsharas_font_of_power|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDeBuffDebuff)) or Unit(unit):HasDeBuffs(A.VendettaDebuff) > 10 - 4 * num(A.AzsharasFontofPower:IsExists) or Unit(unit):TimeToDie() < 20) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=master_assassin_remains=0&!debuff.vendetta.up&!debuff.toxic_blade.up&buff.memory_of_lucid_dreams.down&energy<80&dot.rupture.remains>4
            if A.:IsReady(unit) and (MasterAssassinRemains == 0 and not Unit(unit):HasDeBuffs(A.VendettaDebuff) and not Unit(unit):HasDeBuffs(A.ToxicBladeDebuff) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff)) and Unit("player"):EnergyPredicted() < 80 and Unit(unit):HasDeBuffs(A.RuptureDebuff) > 4) then
                A.:Show(icon)
            end
            -- use_item,name=lurkers_insidious_gift,if=debuff.vendetta.up
            if A.LurkersInsidiousGift:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                A.LurkersInsidiousGift:Show(icon)
            end
            -- use_item,name=lustrous_golden_plumage,if=debuff.vendetta.up
            if A.LustrousGoldenPlumage:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                A.LustrousGoldenPlumage:Show(icon)
            end
            -- use_item,effect_name=gladiators_medallion,if=debuff.vendetta.up
            if A.:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                A.:Show(icon)
            end
            -- use_item,effect_name=gladiators_badge,if=debuff.vendetta.up
            if A.:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff)) then
                A.:Show(icon)
            end
            -- use_items
        end
        local function Direct(unit)
            -- envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target)&(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)
            if A.Envenom:IsReady(unit) and (Unit("player"):ComboPoints() >= 4 + num(A.DeeperStratagem:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.VendettaDebuff) or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff) or Unit("player"):EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not bool(VarSingleUnit(unit))) and (not A.Exsanguinate:IsSpellLearned() or A.Exsanguinate:GetCooldown() > 2)) then
                return A.Envenom:Show(icon)
            end
            -- variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target
            if (true) then
                VarUseFiller = num(Unit("player"):ComboPointsDeficit() > 1 or Unit("player"):EnergyDeficitPredicted() <= 25 + VarEnergyRegenCombined or not bool(VarSingleUnit(unit)))
            end
            -- fan_of_knives,if=variable.use_filler&azerite.echoing_blades.enabled&spell_targets.fan_of_knives>=2
            if A.FanofKnives:IsReady(unit) and (bool(VarUseFiller) and A.EchoingBlades:GetAzeriteRank() and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) then
                return A.FanofKnives:Show(icon)
            end
            -- fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|(!priority_rotation&spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue))
            if A.FanofKnives:IsReady(unit) and (bool(VarUseFiller) and (Unit("player"):HasBuffsStacks(A.HiddenBladesBuff) >= 19 or (not bool(priority_rotation) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 4 + num((A.DoubleDose:GetAzeriteRank() > 2)) + num(Unit("player"):IsStealthedP(true, false))))) then
                return A.FanofKnives:Show(icon)
            end
            -- fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3
            if A.FanofKnives:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FanofKnives, 10, EvaluateCycleFanofKnives274) then
                    return A.FanofKnives:Show(icon) 
                end
            end
            -- blindside,if=variable.use_filler&(buff.blindside.up|!talent.venom_rush.enabled&!azerite.double_dose.enabled)
            if A.Blindside:IsReady(unit) and (bool(VarUseFiller) and (Unit("player"):HasBuffs(A.BlindsideBuff) or not A.VenomRush:IsSpellLearned() and not A.DoubleDose:GetAzeriteRank())) then
                return A.Blindside:Show(icon)
            end
            -- mutilate,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives=2
            if A.Mutilate:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Mutilate, 40, EvaluateCycleMutilate295) then
                    return A.Mutilate:Show(icon) 
                end
            end
            -- mutilate,if=variable.use_filler
            if A.Mutilate:IsReady(unit) and (bool(VarUseFiller)) then
                return A.Mutilate:Show(icon)
            end
        end
        local function Dot(unit)
            -- variable,name=skip_cycle_garrote,value=priority_rotation&spell_targets.fan_of_knives>3&(dot.garrote.remains<cooldown.garrote.duration|poisoned_bleeds>5)
            if (true) then
                VarSkipCycleGarrote = num(bool(priority_rotation) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 3 and (Unit(unit):HasDeBuffs(A.GarroteDebuff) < A.Garrote:BaseDuration or Rogue.PoisonedBleeds() > 5))
            end
            -- variable,name=skip_cycle_rupture,value=priority_rotation&spell_targets.fan_of_knives>3&(debuff.toxic_blade.up|(poisoned_bleeds>5&!azerite.scent_of_blood.enabled))
            if (true) then
                VarSkipCycleRupture = num(bool(priority_rotation) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 3 and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff) or (Rogue.PoisonedBleeds() > 5 and not A.ScentofBlood:GetAzeriteRank())))
            end
            -- variable,name=skip_rupture,value=debuff.vendetta.up&(debuff.toxic_blade.up|master_assassin_remains>0)&dot.rupture.remains>2
            if (true) then
                VarSkipRupture = num(Unit(unit):HasDeBuffs(A.VendettaDebuff) and (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff) or MasterAssassinRemains > 0) and Unit(unit):HasDeBuffs(A.RuptureDebuff) > 2)
            end
            -- rupture,if=talent.exsanguinate.enabled&((combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1)|(!ticking&(time>10|combo_points>=2)))
            if A.Rupture:IsReady(unit) and (A.Exsanguinate:IsSpellLearned() and ((Unit("player"):ComboPoints() >= Rogue.CPMaxSpend() and A.Exsanguinate:GetCooldown() < 1) or (not Unit(unit):HasDeBuffs(A.RuptureDebuff) and (Unit("player"):CombatTime > 10 or Unit("player"):ComboPoints() >= 2)))) then
                return A.Rupture:Show(icon)
            end
            -- pool_resource,for_next=1
            -- garrote,if=(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>4&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) and ((not A.Subterfuge:IsSpellLearned() or not (A.Vanish:HasCooldownUps and A.Vendetta:GetCooldown() <= 4)) and Unit("player"):ComboPointsDeficit() >= 1 + 3 * num((A.ShroudedSuffocation:GetAzeriteRank() and A.Vanish:HasCooldownUps)) and Unit(unit):HasDeBuffsRefreshable(A.GarroteDebuff) and (Unit(unit):PMultiplier(A.Garrote) <= 1 or Unit(unit):HasDeBuffs(A.GarroteDebuff) <= A.GarroteDebuff:TickTime and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + num(A.ShroudedSuffocation:GetAzeriteRank())) and (not HL.Exsanguinated(Unit(unit), "Garrote") or Unit(unit):HasDeBuffs(A.GarroteDebuff) <= A.GarroteDebuff:TickTime * 2 and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + num(A.ShroudedSuffocation:GetAzeriteRank())) and not bool(ss_buffed) and (Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.GarroteDebuff)) > 4 and (MasterAssassinRemains == 0 or not Unit(unit):HasDeBuffs(A.GarroteDebuff) and A.ShroudedSuffocation:GetAzeriteRank())) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- garrote,cycle_targets=1,if=!variable.skip_cycle_garrote&target!=self.target&(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1+3*(azerite.shrouded_suffocation.enabled&cooldown.vanish.up)&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&!ss_buffed&(target.time_to_die-remains)>12&(master_assassin_remains=0|!ticking&azerite.shrouded_suffocation.enabled)
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, EvaluateCycleGarrote414) then
                    return A.Garrote:Show(icon) 
                end
            end
            -- crimson_tempest,if=spell_targets>=2&remains<2+(spell_targets>=5)&combo_points>=4
            if A.CrimsonTempest:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and Unit("player"):HasBuffs(A.CrimsonTempestBuff) < 2 + num((MultiUnits:GetByRangeInCombat(40, 5, 10) >= 5)) and Unit("player"):ComboPoints() >= 4) then
                return A.CrimsonTempest:Show(icon)
            end
            -- rupture,if=!variable.skip_rupture&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
            if A.Rupture:IsReady(unit) and (not bool(VarSkipRupture) and Unit("player"):ComboPoints() >= 4 and Unit(unit):HasDeBuffsRefreshable(A.RuptureDebuff) and (Unit(unit):PMultiplier(A.Rupture) <= 1 or Unit(unit):HasDeBuffs(A.RuptureDebuff) <= A.RuptureDebuff:TickTime and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + num(A.ShroudedSuffocation:GetAzeriteRank())) and (not HL.Exsanguinated(Unit(unit), "Rupture") or Unit(unit):HasDeBuffs(A.RuptureDebuff) <= A.RuptureDebuff:TickTime * 2 and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + num(A.ShroudedSuffocation:GetAzeriteRank())) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff) > 4) then
                return A.Rupture:Show(icon)
            end
            -- rupture,cycle_targets=1,if=!variable.skip_cycle_rupture&!variable.skip_rupture&target!=self.target&combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&(!exsanguinated|remains<=tick_time*2&spell_targets.fan_of_knives>=3+azerite.shrouded_suffocation.enabled)&target.time_to_die-remains>4
            if A.Rupture:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rupture, 5, EvaluateCycleRupture565) then
                    return A.Rupture:Show(icon) 
                end
            end
        end
        local function Essences(unit)
            -- concentrated_flame,if=energy.time_to_max>1&!debuff.vendetta.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:IsReady(unit) and (Unit("player"):EnergyTimeToMaxPredicted() > 1 and not Unit(unit):HasDeBuffs(A.VendettaDebuff) and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:FullRechargeTimeP() < A.GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- blood_of_the_enemy,if=debuff.vendetta.up&(!talent.toxic_blade.enabled|debuff.toxic_blade.up&combo_points.deficit<=1|debuff.vendetta.remains<=10)|target.time_to_die<=10
            if A.BloodoftheEnemy:IsReady(unit) and (Unit(unit):HasDeBuffs(A.VendettaDebuff) and (not A.ToxicBlade:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ToxicBladeDebuff) and Unit("player"):ComboPointsDeficit() <= 1 or Unit(unit):HasDeBuffs(A.VendettaDebuff) <= 10) or Unit(unit):TimeToDie() <= 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- guardian_of_azeroth,if=cooldown.vendetta.remains<3|debuff.vendetta.up|target.time_to_die<30
            if A.GuardianofAzeroth:IsReady(unit) and (A.Vendetta:GetCooldown() < 3 or Unit(unit):HasDeBuffs(A.VendettaDebuff) or Unit(unit):TimeToDie() < 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- guardian_of_azeroth,if=floor((target.time_to_die-30)%cooldown)>floor((target.time_to_die-30-cooldown.vendetta.remains)%cooldown)
            if A.GuardianofAzeroth:IsReady(unit) and (math.floor ((Unit(unit):TimeToDie() - 30) / cooldown) > math.floor ((Unit(unit):TimeToDie() - 30 - A.Vendetta:GetCooldown()) / cooldown)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- focused_azerite_beam,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60&energy<70
            if A.FocusedAzeriteBeam:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or 10000000000 > 60 and Unit("player"):EnergyPredicted() < 70) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60
            if A.PurifyingBlast:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or 10000000000 > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessForceBuff) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:IsReady(unit) then
                return A.RippleInSpace:Show(icon)
            end
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.LifebloodBuff) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
            -- memory_of_lucid_dreams,if=energy<50&!cooldown.vendetta.up
            if A.MemoryofLucidDreams:IsReady(unit) and (Unit("player"):EnergyPredicted() < 50 and not A.Vendetta:HasCooldownUps) then
                return A.MemoryofLucidDreams:Show(icon)
            end
        end
        local function Stealthed(unit)
            -- rupture,if=combo_points>=4&(talent.nightstalker.enabled|talent.subterfuge.enabled&(talent.exsanguinate.enabled&cooldown.exsanguinate.remains<=2|!ticking)&variable.single_target)&target.time_to_die-remains>6
            if A.Rupture:IsReady(unit) and (Unit("player"):ComboPoints() >= 4 and (A.Nightstalker:IsSpellLearned() or A.Subterfuge:IsSpellLearned() and (A.Exsanguinate:IsSpellLearned() and A.Exsanguinate:GetCooldown() <= 2 or not Unit(unit):HasDeBuffs(A.RuptureDebuff)) and bool(VarSingleUnit(unit))) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.RuptureDebuff) > 6) then
                return A.Rupture:Show(icon)
            end
            -- pool_resource,for_next=1
            -- garrote,if=azerite.shrouded_suffocation.enabled&buff.subterfuge.up&buff.subterfuge.remains<1.3&!ss_buffed
            if A.Garrote:IsReady(unit) and (A.ShroudedSuffocation:GetAzeriteRank() and Unit("player"):HasBuffs(A.SubterfugeBuff) and Unit("player"):HasBuffs(A.SubterfugeBuff) < 1.3 and not bool(ss_buffed)) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&(remains<12|pmultiplier<=1)&target.time_to_die-remains>2
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateTargetIfFilterGarrote721, EvaluateTargetIfGarrote758) then 
                    return A.Garrote:Show(icon) 
                end
            end
            -- rupture,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&!dot.rupture.ticking&variable.single_target
            if A.Rupture:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.ShroudedSuffocation:GetAzeriteRank() and not Unit(unit):HasDeBuffs(A.RuptureDebuff) and bool(VarSingleUnit(unit))) then
                return A.Rupture:Show(icon)
            end
            -- pool_resource,for_next=1
            -- garrote,target_if=min:remains,if=talent.subterfuge.enabled&azerite.shrouded_suffocation.enabled&target.time_to_die>remains&(remains<18|!ss_buffed)
            if A.Garrote:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Garrote, 40, "min", EvaluateTargetIfFilterGarrote776, EvaluateTargetIfGarrote807) then 
                    return A.Garrote:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- garrote,if=talent.subterfuge.enabled&talent.exsanguinate.enabled&cooldown.exsanguinate.remains<1&prev_gcd.1.rupture&dot.rupture.remains>5+4*cp_max_spend
            if A.Garrote:IsReady(unit) and (A.Subterfuge:IsSpellLearned() and A.Exsanguinate:IsSpellLearned() and A.Exsanguinate:GetCooldown() < 1 and Unit("player"):GetSpellLastCast(A.Rupture) and Unit(unit):HasDeBuffs(A.RuptureDebuff) > 5 + 4 * Rogue.CPMaxSpend()) then
                if A.Garrote:IsUsablePPool() then
                    return A.Garrote:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
        end
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
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
                VarEnergyRegenCombined = Unit("player"):EnergyRegen() + Rogue.PoisonedBleeds() * 7 / (2 * Unit("player"):SpellHaste)
            end
            -- variable,name=single_target,value=spell_targets.fan_of_knives<2
            if (true) then
                VarSingleUnit(unit) = num(MultiUnits:GetByRangeInCombat(40, 5, 10) < 2)
            end
            -- call_action_list,name=stealthed,if=stealthed.rogue
            if (Unit("player"):IsStealthedP(true, false)) then
                local ShouldReturn = Stealthed(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cds,if=(!talent.master_assassin.enabled|dot.garrote.ticking)
            if ((not A.MasterAssassin:IsSpellLearned() or Unit(unit):HasDeBuffs(A.GarroteDebuff))) then
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
            if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):EnergyDeficitPredicted() >= 15 + VarEnergyRegenCombined) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- arcane_pulse
            if A.ArcanePulse:IsReady(unit) then
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

