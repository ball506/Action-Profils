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
    ShurikenStorm                          = Action.Create({Type = "Spell", ID = 197835 }),
    Gloomblade                             = Action.Create({Type = "Spell", ID = 200758 }),
    Perforate                              = Action.Create({Type = "Spell", ID =  }),
    Backstab                               = Action.Create({Type = "Spell", ID = 53 }),
    ShadowDance                            = Action.Create({Type = "Spell", ID = 185313 }),
    ShadowDanceBuff                        = Action.Create({Type = "Spell", ID = 185313 }),
    ShurikenTornadoBuff                    = Action.Create({Type = "Spell", ID =  }),
    SymbolsofDeath                         = Action.Create({Type = "Spell", ID = 212283 }),
    NightbladeDebuff                       = Action.Create({Type = "Spell", ID = 195452 }),
    ShurikenTornado                        = Action.Create({Type = "Spell", ID =  }),
    PoolResource                           = Action.Create({Type = "Spell", ID = 9999000010 }),
    ShadowBlades                           = Action.Create({Type = "Spell", ID = 121471 }),
    ShadowFocus                            = Action.Create({Type = "Spell", ID = 108209 }),
    BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
    NightsVengeance                        = Action.Create({Type = "Spell", ID =  }),
    NightsVengeanceBuff                    = Action.Create({Type = "Spell", ID =  }),
    SymbolsofDeathBuff                     = Action.Create({Type = "Spell", ID = 212283 }),
    Subterfuge                             = Action.Create({Type = "Spell", ID = 108208 }),
    ShadowBladesBuff                       = Action.Create({Type = "Spell", ID = 121471 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
    ConductiveInkDeBuffDebuff              = Action.Create({Type = "Spell", ID =  }),
    BloodoftheEnemyDebuff                  = Action.Create({Type = "Spell", ID =  }),
    ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
    ConcentratedFlameBurnDebuff            = Action.Create({Type = "Spell", ID =  }),
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
    Eviscerate                             = Action.Create({Type = "Spell", ID = 196819 }),
    Nightblade                             = Action.Create({Type = "Spell", ID = 195452 }),
    DarkShadow                             = Action.Create({Type = "Spell", ID = 245687 }),
    ReplicatingShadows                     = Action.Create({Type = "Spell", ID =  }),
    SecretTechnique                        = Action.Create({Type = "Spell", ID =  }),
    Vanish                                 = Action.Create({Type = "Spell", ID = 1856 }),
    FindWeaknessDebuff                     = Action.Create({Type = "Spell", ID =  }),
    Shadowmeld                             = Action.Create({Type = "Spell", ID = 58984 }),
    TheFirstDance                          = Action.Create({Type = "Spell", ID =  }),
    Nightstalker                           = Action.Create({Type = "Spell", ID = 14062 }),
    Shadowstrike                           = Action.Create({Type = "Spell", ID = 185438 }),
    FindWeakness                           = Action.Create({Type = "Spell", ID =  }),
    VanishBuff                             = Action.Create({Type = "Spell", ID = 1856 }),
    DeeperStratagem                        = Action.Create({Type = "Spell", ID = 193531 }),
    BladeIntheShadows                      = Action.Create({Type = "Spell", ID =  }),
    Weaponmaster                           = Action.Create({Type = "Spell", ID =  }),
    Inevitability                          = Action.Create({Type = "Spell", ID =  }),
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
local VarShdComboPoints = 0;
local VarStealthThreshold = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarUsePriorityRotation = 0
  VarShdThreshold = 0
  VarShdComboPoints = 0
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


local function EvaluateTargetIfFilterMarkedForDeath79(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath84(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Unit("player"):ComboPointsDeficit() or not Unit("player"):IsStealthedP(true, true) and Unit("player"):ComboPointsDeficit() >= Rogue.CPMaxSpend())
end


local function EvaluateCycleNightblade242(unit)
  return not bool(VarUsePriorityRotation) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and (bool(A.NightsVengeance:GetAzeriteRank()) or not bool(A.ReplicatingShadows:GetAzeriteRank()) or MultiUnits:GetByRangeInCombat(40, 5, 10) - A.NightbladeDebuff.ID, true:ActiveDot >= 2) and not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and Unit(unit):TimeToDie() >= (5 + (2 * Unit("player"):ComboPoints())) and Unit(unit):HasDeBuffsRefreshable(A.NightbladeDebuff.ID, true)
end

local function EvaluateCycleShadowstrike379(unit)
  return A.SecretTechnique:IsSpellLearned() and A.FindWeakness:IsSpellLearned() and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 2 and Unit(unit):TimeToDie() - remains > 6
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
        local Precombat, Build, Cds, Essences, Finish, StealthCds, Stealthed
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
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
        end
        
        --Build
        local function Build(unit)
            -- shuriken_storm,if=spell_targets>=2+(talent.gloomblade.enabled&azerite.perforate.rank>=2&position_back)
            if A.ShurikenStorm:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 + num((A.Gloomblade:IsSpellLearned() and A.Perforate:GetAzeriteRank() >= 2 and bool(position_back)))) then
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
            -- shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.ShadowDance:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) <= 3.5) then
                return A.ShadowDance:Show(icon)
            end
            -- symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
            if A.SymbolsofDeath:IsReady(unit) and (Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) and Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) <= 3.5) then
                return A.SymbolsofDeath:Show(icon)
            end
            -- call_action_list,name=essences,if=!stealthed.all&dot.nightblade.ticking
            if (not Unit("player"):IsStealthedP(true, true) and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true)) then
                local ShouldReturn = Essences(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- pool_resource,for_next=1,if=!talent.shadow_focus.enabled
            -- shuriken_tornado,if=energy>=60&dot.nightblade.ticking&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1
            if A.ShurikenTornado:IsReady(unit) and (Unit("player"):EnergyPredicted() >= 60 and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) and A.SymbolsofDeath:GetCooldown() == 0 and A.ShadowDance:ChargesP() >= 1) then
                if A.ShurikenTornado:IsUsablePPool() then
                    return A.ShurikenTornado:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- symbols_of_death,if=dot.nightblade.ticking&!cooldown.shadow_blades.up&(!talent.shuriken_tornado.enabled|talent.shadow_focus.enabled|cooldown.shuriken_tornado.remains>2)&(!essence.blood_of_the_enemy.major|cooldown.blood_of_the_enemy.remains>2)&(azerite.nights_vengeance.rank<2|buff.nights_vengeance.up)
            if A.SymbolsofDeath:IsReady(unit) and (Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) and not A.ShadowBlades:GetCooldown() == 0 and (not A.ShurikenTornado:IsSpellLearned() or A.ShadowFocus:IsSpellLearned() or A.ShurikenTornado:GetCooldown() > 2) and (not bool(essence.blood_of_the_enemy.major) or A.BloodoftheEnemy:GetCooldown() > 2) and (A.NightsVengeance:GetAzeriteRank() < 2 or Unit("player"):HasBuffs(A.NightsVengeanceBuff.ID, true))) then
                return A.SymbolsofDeath:Show(icon)
            end
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath79, EvaluateTargetIfMarkedForDeath84) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&!stealthed.all&combo_points.deficit>=cp_max_spend
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 30 - raid_event.adds.duration and not Unit("player"):IsStealthedP(true, true) and Unit("player"):ComboPointsDeficit() >= Rogue.CPMaxSpend()) then
                return A.MarkedForDeath:Show(icon)
            end
            -- shadow_blades,if=!stealthed.all&dot.nightblade.ticking&combo_points.deficit>=2
            if A.ShadowBlades:IsReady(unit) and (not Unit("player"):IsStealthedP(true, true) and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) and Unit("player"):ComboPointsDeficit() >= 2) then
                return A.ShadowBlades:Show(icon)
            end
            -- shuriken_tornado,if=talent.shadow_focus.enabled&dot.nightblade.ticking&buff.symbols_of_death.up
            if A.ShurikenTornado:IsReady(unit) and (A.ShadowFocus:IsSpellLearned() and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.ShurikenTornado:Show(icon)
            end
            -- shadow_dance,if=!buff.shadow_dance.up&target.time_to_die<=5+talent.subterfuge.enabled&!raid_event.adds.up
            if A.ShadowDance:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and Unit(unit):TimeToDie() <= 5 + num(A.Subterfuge:IsSpellLearned()) and not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.ShadowDance:Show(icon)
            end
            -- potion,if=buff.bloodlust.react|buff.symbols_of_death.up&(buff.shadow_blades.up|cooldown.shadow_blades.remains<=10)
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism or Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and (Unit("player"):HasBuffs(A.ShadowBladesBuff.ID, true) or A.ShadowBlades:GetCooldown() <= 10)) then
                A.ProlongedPower:Show(icon)
            end
            -- blood_fury,if=buff.symbols_of_death.up
            if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=buff.symbols_of_death.up
            if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- fireblood,if=buff.symbols_of_death.up
            if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=buff.symbols_of_death.up
            if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=!stealthed.all&dot.nightblade.ticking&!buff.symbols_of_death.up&energy.deficit>=30
            if A.CyclotronicBlast:IsReady(unit) and (not Unit("player"):IsStealthedP(true, true) and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) and not Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and Unit("player"):EnergyDeficitPredicted() >= 30) then
                A.CyclotronicBlast:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=!buff.shadow_dance.up&cooldown.symbols_of_death.remains<10
            if A.AzsharasFontofPower:IsReady(unit) and (not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true) and A.SymbolsofDeath:GetCooldown() < 10) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<32&target.health.pct>=30|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=25-10*debuff.blood_of_the_enemy.up|target.time_to_die<40)&buff.symbols_of_death.remains>8
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDeBuffDebuff.ID, true)) or Unit(unit):HasDeBuffs(A.ConductiveInkDeBuffDebuff.ID, true) and Unit(unit):HealthPercent() < 32 and Unit(unit):HealthPercent() >= 30 or not Unit(unit):HasDeBuffs(A.ConductiveInkDeBuffDebuff.ID, true) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDeBuffDebuff.ID, true) >= 25 - 10 * num(Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true)) or Unit(unit):TimeToDie() < 40) and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) > 8) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=mydas_talisman
            if A.MydasTalisman:IsReady(unit) then
                A.MydasTalisman:Show(icon)
            end
            -- use_items,if=buff.symbols_of_death.up|target.time_to_die<20
        end
        
        --Essences
        local function Essences(unit)
            -- concentrated_flame,if=energy.time_to_max>1&!buff.symbols_of_death.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:IsReady(unit) and (Unit("player"):EnergyTimeToMaxPredicted() > 1 and not Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:FullRechargeTimeP() < A.GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- blood_of_the_enemy,if=!cooldown.shadow_blades.up&cooldown.symbols_of_death.up|target.time_to_die<=10
            if A.BloodoftheEnemy:IsReady(unit) and (not A.ShadowBlades:GetCooldown() == 0 and A.SymbolsofDeath:GetCooldown() == 0 or Unit(unit):TimeToDie() <= 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:IsReady(unit) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- focused_azerite_beam,if=(spell_targets.shuriken_storm>=2|raid_event.adds.in>60)&!cooldown.symbols_of_death.up&!buff.symbols_of_death.up&energy.deficit>=30
            if A.FocusedAzeriteBeam:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or 10000000000 > 60) and not A.SymbolsofDeath:GetCooldown() == 0 and not Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and Unit("player"):EnergyDeficitPredicted() >= 30) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast,if=spell_targets.shuriken_storm>=2|raid_event.adds.in>60
            if A.PurifyingBlast:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or 10000000000 > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:IsReady(unit) then
                return A.RippleInSpace:Show(icon)
            end
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
            -- memory_of_lucid_dreams,if=energy<40&buff.symbols_of_death.up
            if A.MemoryofLucidDreams:IsReady(unit) and (Unit("player"):EnergyPredicted() < 40 and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
        end
        
        --Finish
        local function Finish(unit)
            -- pool_resource,for_next=1
            -- eviscerate,if=buff.nights_vengeance.up
            if A.Eviscerate:IsReady(unit) and (Unit("player"):HasBuffs(A.NightsVengeanceBuff.ID, true)) then
                if A.Eviscerate:IsUsablePPool() then
                    return A.Eviscerate:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- nightblade,if=(!talent.dark_shadow.enabled|!buff.shadow_dance.up)&target.time_to_die-remains>6&remains<tick_time*2
            if A.Nightblade:IsReady(unit) and ((not A.DarkShadow:IsSpellLearned() or not Unit("player"):HasBuffs(A.ShadowDanceBuff.ID, true)) and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) > 6 and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) < A.NightbladeDebuff.ID, true:TickTime * 2) then
                return A.Nightblade:Show(icon)
            end
            -- nightblade,cycle_targets=1,if=!variable.use_priority_rotation&spell_targets.shuriken_storm>=2&(azerite.nights_vengeance.enabled|!azerite.replicating_shadows.enabled|spell_targets.shuriken_storm-active_dot.nightblade>=2)&!buff.shadow_dance.up&target.time_to_die>=(5+(2*combo_points))&refreshable
            if A.Nightblade:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Nightblade, 40, EvaluateCycleNightblade242) then
                    return A.Nightblade:Show(icon) 
                end
            end
            -- nightblade,if=remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
            if A.Nightblade:IsReady(unit) and (Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) < A.SymbolsofDeath:GetCooldown() + 10 and A.SymbolsofDeath:GetCooldown() <= 5 and Unit(unit):TimeToDie() - Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) > A.SymbolsofDeath:GetCooldown() + 5) then
                return A.Nightblade:Show(icon)
            end
            -- secret_technique
            if A.SecretTechnique:IsReady(unit) then
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
            -- vanish,if=!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1&cooldown.symbols_of_death.remains>=3
            if A.Vanish:IsReady(unit) and (not bool(VarShdThreshold) and Unit("player"):ComboPointsDeficit() > 1 and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 and A.SymbolsofDeath:GetCooldown() >= 3) then
                return A.Vanish:Show(icon)
            end
            -- pool_resource,for_next=1,extra_amount=40
            -- shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1
            if A.Shadowmeld:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):EnergyPredicted() >= 40 and Unit("player"):EnergyDeficitPredicted() >= 10 and not bool(VarShdThreshold) and Unit("player"):ComboPointsDeficit() > 1 and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1) then
                if A.Shadowmeld:IsUsablePPool(40) then
                    return A.Shadowmeld:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- variable,name=shd_combo_points,value=combo_points.deficit>=4
            if (true) then
                VarShdComboPoints = num(Unit("player"):ComboPointsDeficit() >= 4)
            end
            -- variable,name=shd_combo_points,value=combo_points.deficit<=1+2*azerite.the_first_dance.enabled,if=variable.use_priority_rotation&(talent.nightstalker.enabled|talent.dark_shadow.enabled)
            if (bool(VarUsePriorityRotation) and (A.Nightstalker:IsSpellLearned() or A.DarkShadow:IsSpellLearned())) then
                VarShdComboPoints = num(Unit("player"):ComboPointsDeficit() <= 1 + 2 * A.TheFirstDance:GetAzeriteRank())
            end
            -- shadow_dance,if=variable.shd_combo_points&(!talent.dark_shadow.enabled|dot.nightblade.remains>=5+talent.subterfuge.enabled)&(variable.shd_threshold|buff.symbols_of_death.remains>=1.2|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10)&(azerite.nights_vengeance.rank<2|buff.nights_vengeance.up)
            if A.ShadowDance:IsReady(unit) and (bool(VarShdComboPoints) and (not A.DarkShadow:IsSpellLearned() or Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) >= 5 + num(A.Subterfuge:IsSpellLearned())) and (bool(VarShdThreshold) or Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) >= 1.2 or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 4 and A.SymbolsofDeath:GetCooldown() > 10) and (A.NightsVengeance:GetAzeriteRank() < 2 or Unit("player"):HasBuffs(A.NightsVengeanceBuff.ID, true))) then
                return A.ShadowDance:Show(icon)
            end
            -- shadow_dance,if=variable.shd_combo_points&target.time_to_die<cooldown.symbols_of_death.remains&!raid_event.adds.up
            if A.ShadowDance:IsReady(unit) and (bool(VarShdComboPoints) and Unit(unit):TimeToDie() < A.SymbolsofDeath:GetCooldown() and not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.ShadowDance:Show(icon)
            end
        end
        
        --Stealthed
        local function Stealthed(unit)
            -- shadowstrike,if=(talent.find_weakness.enabled|spell_targets.shuriken_storm<3)&(buff.stealth.up|buff.vanish.up)
            if A.Shadowstrike:IsReady(unit) and ((A.FindWeakness:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) and (Unit("player"):HasBuffs(A.StealthBuff.ID, true) or Unit("player"):HasBuffs(A.VanishBuff.ID, true))) then
                return A.Shadowstrike:Show(icon)
            end
            -- call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
            if (Unit("player"):HasBuffs(A.ShurikenTornadoBuff.ID, true) and Unit("player"):ComboPointsDeficit() <= 2) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) == 4 and Unit("player"):ComboPoints() >= 4) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&(buff.vanish.up|azerite.the_first_dance.enabled&!talent.dark_shadow.enabled&!talent.subterfuge.enabled&spell_targets.shuriken_storm<3))
            if (Unit("player"):ComboPointsDeficit() <= 1 - num((A.DeeperStratagem:IsSpellLearned() and (Unit("player"):HasBuffs(A.VanishBuff.ID, true) or bool(A.TheFirstDance:GetAzeriteRank()) and not A.DarkShadow:IsSpellLearned() and not A.Subterfuge:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3)))) then
                local ShouldReturn = Finish(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- gloomblade,if=azerite.perforate.rank>=2&spell_targets.shuriken_storm<=2&position_back
            if A.Gloomblade:IsReady(unit) and (A.Perforate:GetAzeriteRank() >= 2 and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2 and bool(position_back)) then
                return A.Gloomblade:Show(icon)
            end
            -- shadowstrike,cycle_targets=1,if=talent.secret_technique.enabled&talent.find_weakness.enabled&debuff.find_weakness.remains<1&spell_targets.shuriken_storm=2&target.time_to_die-remains>6
            if A.Shadowstrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Shadowstrike, 40, EvaluateCycleShadowstrike379) then
                    return A.Shadowstrike:Show(icon) 
                end
            end
            -- shadowstrike,if=!talent.deeper_stratagem.enabled&azerite.blade_in_the_shadows.rank=3&spell_targets.shuriken_storm=3
            if A.Shadowstrike:IsReady(unit) and (not A.DeeperStratagem:IsSpellLearned() and A.BladeIntheShadows:GetAzeriteRank() == 3 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 3) then
                return A.Shadowstrike:Show(icon)
            end
            -- shadowstrike,if=variable.use_priority_rotation&(talent.find_weakness.enabled&debuff.find_weakness.remains<1|talent.weaponmaster.enabled&spell_targets.shuriken_storm<=4|azerite.inevitability.enabled&buff.symbols_of_death.up&spell_targets.shuriken_storm<=3+azerite.blade_in_the_shadows.enabled)
            if A.Shadowstrike:IsReady(unit) and (bool(VarUsePriorityRotation) and (A.FindWeakness:IsSpellLearned() and Unit(unit):HasDeBuffs(A.FindWeaknessDebuff.ID, true) < 1 or A.Weaponmaster:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 or bool(A.Inevitability:GetAzeriteRank()) and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 3 + A.BladeIntheShadows:GetAzeriteRank())) then
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
            if A.Nightblade:IsReady(unit) and (Unit(unit):TimeToDie() > 6 and Unit(unit):HasDeBuffs(A.NightbladeDebuff.ID, true) < A.GetGCD() and Unit("player"):ComboPoints() >= 4 - num((Unit("player"):CombatTime < 10)) * 2) then
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
            -- call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
            if (Unit("player"):EnergyDeficitPredicted() <= VarStealthThreshold) then
                local ShouldReturn = StealthCds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- nightblade,if=azerite.nights_vengeance.enabled&!buff.nights_vengeance.up&combo_points.deficit>1&(spell_targets.shuriken_storm<2|variable.use_priority_rotation)&(cooldown.symbols_of_death.remains<=3|(azerite.nights_vengeance.rank>=2&buff.symbols_of_death.remains>3&!stealthed.all&cooldown.shadow_dance.charges_fractional>=0.9))
            if A.Nightblade:IsReady(unit) and (bool(A.NightsVengeance:GetAzeriteRank()) and not Unit("player"):HasBuffs(A.NightsVengeanceBuff.ID, true) and Unit("player"):ComboPointsDeficit() > 1 and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 or bool(VarUsePriorityRotation)) and (A.SymbolsofDeath:GetCooldown() <= 3 or (A.NightsVengeance:GetAzeriteRank() >= 2 and Unit("player"):HasBuffs(A.SymbolsofDeathBuff.ID, true) > 3 and not Unit("player"):IsStealthedP(true, true) and A.ShadowDance:ChargesFractionalP() >= 0.9))) then
                return A.Nightblade:Show(icon)
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

