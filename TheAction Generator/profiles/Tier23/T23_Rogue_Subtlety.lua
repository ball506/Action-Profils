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
    StealthBuff                            = Action.Create({Type = "Spell", ID = 1784 }),
    Stealth                                = Action.Create({Type = "Spell", ID = 1784 }),
    MarkedForDeath                         = Action.Create({Type = "Spell", ID = 137619 }),
    ShadowBladesBuff                       = Action.Create({Type = "Spell", ID = 121471 }),
    ShadowBlades                           = Action.Create({Type = "Spell", ID = 121471 }),
    ShurikenStorm                          = Action.Create({Type = "Spell", ID = 197835 }),
    Gloomblade                             = Action.Create({Type = "Spell", ID = 200758 }),
    Backstab                               = Action.Create({Type = "Spell", ID = 53 }),
    SymbolsofDeathBuff                     = Action.Create({Type = "Spell", ID = 212283 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    ShadowDance                            = Action.Create({Type = "Spell", ID = 185313 }),
    ShadowDanceBuff                        = Action.Create({Type = "Spell", ID = 185313 }),
    ShurikenTornadoBuff                    = Action.Create({Type = "Spell", ID =  }),
    SymbolsofDeath                         = Action.Create({Type = "Spell", ID = 212283 }),
    NightbladeDebuff                       = Action.Create({Type = "Spell", ID = 195452 }),
    ShurikenTornado                        = Action.Create({Type = "Spell", ID =  }),
    ShadowFocus                            = Action.Create({Type = "Spell", ID = 108209 }),
    Subterfuge                             = Action.Create({Type = "Spell", ID = 108208 }),
    Eviscerate                             = Action.Create({Type = "Spell", ID = 196819 }),
    NightsVengeanceBuff                    = Action.Create({Type = "Spell", ID =  }),
    SecretTechnique                        = Action.Create({Type = "Spell", ID =  }),
    Nightblade                             = Action.Create({Type = "Spell", ID = 195452 }),
    DarkShadow                             = Action.Create({Type = "Spell", ID = 245687 }),
    NightsVengeance                        = Action.Create({Type = "Spell", ID =  }),
    ReplicatingShadows                     = Action.Create({Type = "Spell", ID =  }),
    Nightstalker                           = Action.Create({Type = "Spell", ID = 14062 }),
    Vanish                                 = Action.Create({Type = "Spell", ID = 1856 }),
    FindWeaknessDebuff                     = Action.Create({Type = "Spell", ID =  }),
    Shadowmeld                             = Action.Create({Type = "Spell", ID = 58984 }),
    PoolResource                           = Action.Create({Type = "Spell", ID = 9999000010 }),
    TheFirstDance                          = Action.Create({Type = "Spell", ID =  }),
    Shadowstrike                           = Action.Create({Type = "Spell", ID = 185438 }),
    DeeperStratagem                        = Action.Create({Type = "Spell", ID = 193531 }),
    VanishBuff                             = Action.Create({Type = "Spell", ID = 1856 }),
    FindWeakness                           = Action.Create({Type = "Spell", ID =  }),
    BladeIntheShadows                      = Action.Create({Type = "Spell", ID =  }),
    Vigor                                  = Action.Create({Type = "Spell", ID = 14983 }),
    MasterofShadows                        = Action.Create({Type = "Spell", ID =  }),
    Alacrity                               = Action.Create({Type = "Spell", ID =  }),
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
Action:CreateEssencesFor(ACTION_CONST_ROGUE_SUBTLETY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_SUBTLETY], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarUsePriorityRotation = 0;
local VarShdThreshold = 0;
local VarStealthThreshold = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarUsePriorityRotation = 0
  VarShdThreshold = 0
  VarStealthThreshold = 0
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


local function EvaluateTargetIfFilterMarkedForDeath83(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath88(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Unit("player"):ComboPointsDeficit() or not Unit("player"):IsStealthedP(true, true) and Unit("player"):ComboPointsDeficit() >= Rogue.CPMaxSpend())
end

local function EvaluateCycleNightblade169(unit)
  return not bool(VarUsePriorityRotation) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and (A.NightsVengeance:GetAzeriteRank() or not A.ReplicatingShadows:GetAzeriteRank() or MultiUnits:GetByRangeInCombat(40, 5, 10) - A.NightbladeDebuff:ActiveDot >= 2) and not Unit("player"):HasBuffs(A.ShadowDanceBuff) and Unit(unit):TimeToDie() >= (5 + (2 * Unit("player"):ComboPoints())) and Unit(unit):HasDeBuffsRefreshable(A.NightbladeDebuff)
end

local function EvaluateCycleShadowstrike290(unit)
  return A.SecretTechnique:IsSpellLearned() and A.FindWeakness:IsSpellLearned() and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff) < 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 2 and Unit(unit):TimeToDie() - remains > 6
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
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- stealth
            if A.Stealth:IsReady(unit) and Unit("player"):HasBuffsDown(A.StealthBuff) then
                return A.Stealth:Show(icon)
            end
            -- marked_for_death,precombat_seconds=15
            if A.MarkedForDeath:IsReady(unit) then
                return A.MarkedForDeath:Show(icon)
            end
            -- shadow_blades,precombat_seconds=1
            if A.ShadowBlades:IsReady(unit) and Unit("player"):HasBuffsDown(A.ShadowBladesBuff) then
                return A.ShadowBlades:Show(icon)
            end
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
        end
        local function Build(unit)
            -- shuriken_storm,if=spell_targets>=2
            if A.ShurikenStorm:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) then
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
        local function Cds(unit)
            -- potion,if=buff.bloodlust.react|buff.symbols_of_death.up&(buff.shadow_blades.up|cooldown.shadow_blades.remains<=10)
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism or Unit("player"):HasBuffs(A.SymbolsofDeathBuff) and (Unit("player"):HasBuffs(A.ShadowBladesBuff) or A.ShadowBlades:GetCooldown() <= 10)) then
                A.ProlongedPower:Show(icon)
            end
            -- use_item,name=variable_intensity_gigavolt_oscillating_reactor,if=buff.symbols_of_death.up|target.time_to_die<20
            if A.VariableIntensityGigavoltOscillatingReactor:IsReady(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff) or Unit(unit):TimeToDie() < 20) then
                A.VariableIntensityGigavoltOscillatingReactor:Show(icon)
            end
            -- blood_fury,if=buff.symbols_of_death.up
            if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=buff.symbols_of_death.up
            if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff)) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=buff.symbols_of_death.up
            if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=buff.symbols_of_death.up
            if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff)) then
                return A.AncestralCall:Show(icon)
            end
            -- shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.ShadowDance:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff) <= 3.5) then
                return A.ShadowDance:Show(icon)
            end
            -- symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.SymbolsofDeath:IsReady(unit) and (Unit("player"):HasBuffs(A.ShurikenTornadoBuff) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff) <= 3.5) then
                return A.SymbolsofDeath:Show(icon)
            end
            -- symbols_of_death,if=dot.nightblade.ticking&(!talent.shuriken_tornado.enabled|talent.shadow_focus.enabled|spell_targets.shuriken_storm<3|!cooldown.shuriken_tornado.up)
            if A.SymbolsofDeath:IsReady(unit) and (Unit(unit):HasDeBuffs(A.NightbladeDebuff) and (not A.ShurikenTornado:IsSpellLearned() or A.ShadowFocus:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or not A.ShurikenTornado:HasCooldownUps)) then
                return A.SymbolsofDeath:Show(icon)
            end
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath83, EvaluateTargetIfMarkedForDeath88) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&!stealthed.all&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 30 - raid_event.adds.duration and not Unit("player"):IsStealthedP(true, true) and Unit("player"):ComboPointsDeficit() >= Rogue.CPMaxSpend()) then
                return A.MarkedForDeath:Show(icon)
            end
            -- shadow_blades,if=combo_points.deficit>=2+stealthed.all
            if A.ShadowBlades:IsReady(unit) and (Unit("player"):ComboPointsDeficit() >= 2 + num(Unit("player"):IsStealthedP(true, true))) then
                return A.ShadowBlades:Show(icon)
            end
            -- shuriken_tornado,if=spell_targets>=3&!talent.shadow_focus.enabled&dot.nightblade.ticking&!stealthed.all&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1
            if A.ShurikenTornado:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and not A.ShadowFocus:IsSpellLearned() and Unit(unit):HasDeBuffs(A.NightbladeDebuff) and not Unit("player"):IsStealthedP(true, true) and A.SymbolsofDeath:HasCooldownUps and A.ShadowDance:ChargesP() >= 1) then
                return A.ShurikenTornado:Show(icon)
            end
            -- shuriken_tornado,if=spell_targets>=3&talent.shadow_focus.enabled&dot.nightblade.ticking&buff.symbols_of_death.up
            if A.ShurikenTornado:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and A.ShadowFocus:IsSpellLearned() and Unit(unit):HasDeBuffs(A.NightbladeDebuff) and Unit("player"):HasBuffs(A.SymbolsofDeathBuff)) then
                return A.ShurikenTornado:Show(icon)
            end
            -- shadow_dance,if=!buff.shadow_dance.up&target.time_to_die<=5+talent.subterfuge.enabled&!raid_event.adds.up
            if A.ShadowDance:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff) and Unit(unit):TimeToDie() <= 5 + num(A.Subterfuge:IsSpellLearned()) and not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.ShadowDance:Show(icon)
            end
        end
        local function Finish(unit)
            -- eviscerate,if=talent.shadow_focus.enabled&buff.nights_vengeance.up&spell_targets.shuriken_storm>=2+3*talent.secret_technique.enabled
            if A.Eviscerate:IsReady(unit) and (A.ShadowFocus:IsSpellLearned() and Unit("player"):HasBuffs(A.NightsVengeanceBuff) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 + 3 * num(A.SecretTechnique:IsSpellLearned())) then
                return A.Eviscerate:Show(icon)
            end
            -- nightblade,if=(!talent.dark_shadow.enabled|!buff.shadow_dance.up)&target.time_to_die-remains>6&remains<tick_time*2
            if A.Nightblade:IsReady(unit) and ((not A.DarkShadow:IsSpellLearned() or not Unit("player"):HasBuffs(A.ShadowDanceBuff)) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.NightbladeDebuff) > 6 and Unit(unit):HasDeBuffs(A.NightbladeDebuff) < A.NightbladeDebuff:TickTime * 2) then
                return A.Nightblade:Show(icon)
            end
            -- nightblade,cycle_targets=1,if=!variable.use_priority_rotation&spell_targets.shuriken_storm>=2&(azerite.nights_vengeance.enabled|!azerite.replicating_shadows.enabled|spell_targets.shuriken_storm-active_dot.nightblade>=2)&!buff.shadow_dance.up&target.time_to_die>=(5+(2*combo_points))&refreshable
            if A.Nightblade:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Nightblade, 40, EvaluateCycleNightblade169) then
                    return A.Nightblade:Show(icon) 
                end
            end
            -- nightblade,if=remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
            if A.Nightblade:IsReady(unit) and (Unit(unit):HasDeBuffs(A.NightbladeDebuff) < A.SymbolsofDeath:GetCooldown() + 10 and A.SymbolsofDeath:GetCooldown() <= 5 and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.NightbladeDebuff) > A.SymbolsofDeath:GetCooldown() + 5) then
                return A.Nightblade:Show(icon)
            end
            -- secret_technique,if=buff.symbols_of_death.up&(!talent.dark_shadow.enabled|buff.shadow_dance.up)
            if A.SecretTechnique:IsReady(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff) and (not A.DarkShadow:IsSpellLearned() or Unit("player"):HasBuffs(A.ShadowDanceBuff))) then
                return A.SecretTechnique:Show(icon)
            end
            -- secret_technique,if=spell_targets.shuriken_storm>=2+talent.dark_shadow.enabled+talent.nightstalker.enabled
            if A.SecretTechnique:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 + num(A.DarkShadow:IsSpellLearned()) + num(A.Nightstalker:IsSpellLearned())) then
                return A.SecretTechnique:Show(icon)
            end
            -- eviscerate
            if A.Eviscerate:IsReady(unit) then
                return A.Eviscerate:Show(icon)
            end
        end
        local function StealthCds(unit)
            -- variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=1.75
            if (true) then
                VarShdThreshold = num(A.ShadowDance:ChargesFractionalP() >= 1.75)
            end
            -- vanish,if=!variable.shd_threshold&debuff.find_weakness.remains<1&combo_points.deficit>1
            if A.Vanish:IsReady(unit) and (not bool(VarShdThreshold) and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff) < 1 and Unit("player"):ComboPointsDeficit() > 1) then
                return A.Vanish:Show(icon)
            end
            -- pool_resource,for_next=1,extra_amount=40
            -- shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&debuff.find_weakness.remains<1&combo_points.deficit>1
            if A.Shadowmeld:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):EnergyPredicted() >= 40 and Unit("player"):EnergyDeficitPredicted() >= 10 and not bool(VarShdThreshold) and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff) < 1 and Unit("player"):ComboPointsDeficit() > 1) then
                if A.Shadowmeld:IsUsablePPool(40) then
                    return A.Shadowmeld:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- shadow_dance,if=(!talent.dark_shadow.enabled|dot.nightblade.remains>=5+talent.subterfuge.enabled)&(!talent.nightstalker.enabled&!talent.dark_shadow.enabled|!variable.use_priority_rotation|combo_points.deficit<=1+2*azerite.the_first_dance.enabled)&(variable.shd_threshold|buff.symbols_of_death.remains>=1.2|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10)
            if A.ShadowDance:IsReady(unit) and ((not A.DarkShadow:IsSpellLearned() or Unit(unit):HasDeBuffs(A.NightbladeDebuff) >= 5 + num(A.Subterfuge:IsSpellLearned())) and (not A.Nightstalker:IsSpellLearned() and not A.DarkShadow:IsSpellLearned() or not bool(VarUsePriorityRotation) or Unit("player"):ComboPointsDeficit() <= 1 + 2 * num(A.TheFirstDance:GetAzeriteRank())) and (bool(VarShdThreshold) or Unit("player"):HasBuffs(A.SymbolsofDeathBuff) >= 1.2 or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 4 and A.SymbolsofDeath:GetCooldown() > 10)) then
                return A.ShadowDance:Show(icon)
            end
            -- shadow_dance,if=target.time_to_die<cooldown.symbols_of_death.remains&!raid_event.adds.up
            if A.ShadowDance:IsReady(unit) and (Unit(unit):TimeToDie() < A.SymbolsofDeath:GetCooldown() and not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.ShadowDance:Show(icon)
            end
        end
        local function Stealthed(unit)
            -- shadowstrike,if=buff.stealth.up
            if A.Shadowstrike:IsReady(unit) and (Unit("player"):HasBuffs(A.StealthBuff)) then
                return A.Shadowstrike:Show(icon)
            end
            -- call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&(buff.vanish.up|azerite.the_first_dance.enabled&!talent.dark_shadow.enabled&!talent.subterfuge.enabled))
            if (Unit("player"):ComboPointsDeficit() <= 1 - num((A.DeeperStratagem:IsSpellLearned() and (Unit("player"):HasBuffs(A.VanishBuff) or A.TheFirstDance:GetAzeriteRank() and not A.DarkShadow:IsSpellLearned() and not A.Subterfuge:IsSpellLearned())))) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- shadowstrike,cycle_targets=1,if=talent.secret_technique.enabled&talent.find_weakness.enabled&debuff.find_weakness.remains<1&spell_targets.shuriken_storm=2&target.time_to_die-remains>6
            if A.Shadowstrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Shadowstrike, 40, EvaluateCycleShadowstrike290) then
                    return A.Shadowstrike:Show(icon) 
                end
            end
            -- shadowstrike,if=!talent.deeper_stratagem.enabled&azerite.blade_in_the_shadows.rank=3&spell_targets.shuriken_storm=3
            if A.Shadowstrike:IsReady(unit) and (not A.DeeperStratagem:IsSpellLearned() and A.BladeIntheShadows:GetAzeriteRank() == 3 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 3) then
                return A.Shadowstrike:Show(icon)
            end
            -- shuriken_storm,if=spell_targets>=3
            if A.ShurikenStorm:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
                return A.ShurikenStorm:Show(icon)
            end
            -- shadowstrike
            if A.Shadowstrike:IsReady(unit) then
                return A.Shadowstrike:Show(icon)
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
            -- call_action_list,name=cds
            if (true) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- run_action_list,name=stealthed,if=stealthed.all
            if (Unit("player"):IsStealthedP(true, true)) then
                return Stealthed(unit);
            end
            -- nightblade,if=target.time_to_die>6&remains<gcd.max&combo_points>=4-(time<10)*2
            if A.Nightblade:IsReady(unit) and (Unit(unit):TimeToDie() > 6 and Unit(unit):HasDeBuffs(A.NightbladeDebuff) < A.GetGCD() and Unit("player"):ComboPoints() >= 4 - num((Unit("player"):CombatTime < 10)) * 2) then
                return A.Nightblade:Show(icon)
            end
            -- variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
            if (true) then
                VarUsePriorityRotation = num(bool(priority_rotation) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2)
            end
            -- call_action_list,name=stealth_cds,if=variable.use_priority_rotation
            if (bool(VarUsePriorityRotation)) then
                local ShouldReturn = StealthCds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- variable,name=stealth_threshold,value=25+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+talent.shadow_focus.enabled*20+talent.alacrity.enabled*10+15*(spell_targets.shuriken_storm>=3)
            if (true) then
                VarStealthThreshold = 25 + num(A.Vigor:IsSpellLearned()) * 35 + num(A.MasterofShadows:IsSpellLearned()) * 25 + num(A.ShadowFocus:IsSpellLearned()) * 20 + num(A.Alacrity:IsSpellLearned()) * 10 + 15 * num((MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3))
            end
            -- call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold&combo_points.deficit>=4
            if (Unit("player"):EnergyDeficitPredicted() <= VarStealthThreshold and Unit("player"):ComboPointsDeficit() >= 4) then
                local ShouldReturn = StealthCds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold&talent.dark_shadow.enabled&talent.secret_technique.enabled&cooldown.secret_technique.up&spell_targets.shuriken_storm<=4
            if (Unit("player"):EnergyDeficitPredicted() <= VarStealthThreshold and A.DarkShadow:IsSpellLearned() and A.SecretTechnique:IsSpellLearned() and A.SecretTechnique:HasCooldownUps and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4) then
                local ShouldReturn = StealthCds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=finish,if=combo_points.deficit<=1|target.time_to_die<=1&combo_points>=3
            if (Unit("player"):ComboPointsDeficit() <= 1 or Unit(unit):TimeToDie() <= 1 and Unit("player"):ComboPoints() >= 3) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) == 4 and Unit("player"):ComboPoints() >= 4) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
            if (Unit("player"):EnergyDeficitPredicted() <= VarStealthThreshold) then
                local ShouldReturn = Build(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- arcane_torrent,if=energy.deficit>=15+energy.regen
            if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):EnergyDeficitPredicted() >= 15 + Unit("player"):EnergyRegen()) then
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

