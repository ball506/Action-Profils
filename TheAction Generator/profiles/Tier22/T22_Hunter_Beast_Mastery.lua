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
Action[ACTION_CONST_HUNTER_BEASTMASTERY] = {
    SummonPet                              = Action.Create({Type = "Spell", ID = 883 }),
    AspectoftheWildBuff                    = Action.Create({Type = "Spell", ID = 193530 }),
    AspectoftheWild                        = Action.Create({Type = "Spell", ID = 193530 }),
    PrimalInstinctsBuff                    = Action.Create({Type = "Spell", ID = 279810 }),
    PrimalInstincts                        = Action.Create({Type = "Spell", ID = 279806 }),
    BestialWrathBuff                       = Action.Create({Type = "Spell", ID = 19574 }),
    BestialWrath                           = Action.Create({Type = "Spell", ID = 19574 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    KillerInstinct                         = Action.Create({Type = "Spell", ID = 273887 }),
    BarbedShot                             = Action.Create({Type = "Spell", ID = 217200 }),
    FrenzyBuff                             = Action.Create({Type = "Spell", ID = 272790 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    SpittingCobra                          = Action.Create({Type = "Spell", ID = 194407 }),
    AMurderofCrows                         = Action.Create({Type = "Spell", ID = 131894 }),
    Stampede                               = Action.Create({Type = "Spell", ID = 201430 }),
    Multishot                              = Action.Create({Type = "Spell", ID = 2643 }),
    BeastCleaveBuff                        = Action.Create({Type = "Spell", ID = 118455, "pet" }),
    Barrage                                = Action.Create({Type = "Spell", ID = 120360 }),
    ChimaeraShot                           = Action.Create({Type = "Spell", ID = 53209 }),
    KillCommand                            = Action.Create({Type = "Spell", ID = 34026 }),
    DireBeast                              = Action.Create({Type = "Spell", ID = 120679 }),
    CobraShot                              = Action.Create({Type = "Spell", ID = 193455 }),
    ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 })
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
Action:CreateEssencesFor(ACTION_CONST_HUNTER_BEASTMASTERY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_BEASTMASTERY], { __index = Action })



local EnemyRanges = {40}
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
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- summon_pet
            if A.SummonPet:IsReady(unit) then
                return A.SummonPet:Show(icon)
            end
            -- snapshot_stats
            -- potion
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofAgility:Show(icon)
            end
            -- aspect_of_the_wild,precast_time=1.1,if=!azerite.primal_instincts.enabled
            if A.AspectoftheWild:IsReady(unit) and Unit("player"):HasBuffsDown(A.AspectoftheWildBuff) and (not A.PrimalInstincts:GetAzeriteRank()) then
                return A.AspectoftheWild:Show(icon)
            end
            -- bestial_wrath,precast_time=1.5,if=azerite.primal_instincts.enabled
            if A.BestialWrath:IsReady(unit) and Unit("player"):HasBuffsDown(A.BestialWrathBuff) and (A.PrimalInstincts:GetAzeriteRank()) then
                return A.BestialWrath:Show(icon)
            end
        end
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_shot
            -- use_items
            -- berserking,if=cooldown.bestial_wrath.remains>30
            if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
                return A.Berserking:Show(icon)
            end
            -- blood_fury,if=cooldown.bestial_wrath.remains>30
            if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
                return A.BloodFury:Show(icon)
            end
            -- ancestral_call,if=cooldown.bestial_wrath.remains>30
            if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
                return A.AncestralCall:Show(icon)
            end
            -- fireblood,if=cooldown.bestial_wrath.remains>30
            if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
                return A.Fireblood:Show(icon)
            end
            -- potion,if=buff.bestial_wrath.up&buff.aspect_of_the_wild.up&(target.health.pct<35|!talent.killer_instinct.enabled)|target.time_to_die<25
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.BestialWrathBuff) and Unit("player"):HasBuffs(A.AspectoftheWildBuff) and (Unit(unit):HealthPercent < 35 or not A.KillerInstinct:IsSpellLearned()) or Unit(unit):TimeToDie() < 25) then
                A.BattlePotionofAgility:Show(icon)
            end
            -- barbed_shot,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains<=gcd.max|full_recharge_time<gcd.max&cooldown.bestial_wrath.remains
            if A.BarbedShot:IsReady(unit) and (Pet:HasBuffs(A.FrenzyBuff) and Pet:HasBuffs(A.FrenzyBuff) <= A.GetGCD() or A.BarbedShot:FullRechargeTimeP() < A.GetGCD() and bool(A.BestialWrath:GetCooldown())) then
                return A.BarbedShot:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            -- spitting_cobra
            if A.SpittingCobra:IsReady(unit) then
                return A.SpittingCobra:Show(icon)
            end
            -- aspect_of_the_wild
            if A.AspectoftheWild:IsReady(unit) then
                return A.AspectoftheWild:Show(icon)
            end
            -- a_murder_of_crows,if=active_enemies=1
            if A.AMurderofCrows:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1) then
                return A.AMurderofCrows:Show(icon)
            end
            -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
            if A.Stampede:IsReady(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff) and Unit("player"):HasBuffs(A.BestialWrathBuff) or Unit(unit):TimeToDie() < 15) then
                return A.Stampede:Show(icon)
            end
            -- multishot,if=spell_targets>2&gcd.max-pet.cat.buff.beast_cleave.remains>0.25
            if A.Multishot:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2 and A.GetGCD() - Pet:HasBuffs(A.BeastCleaveBuff) > 0.25) then
                return A.Multishot:Show(icon)
            end
            -- bestial_wrath,if=cooldown.aspect_of_the_wild.remains>20|target.time_to_die<15
            if A.BestialWrath:IsReady(unit) and (A.AspectoftheWild:GetCooldown() > 20 or Unit(unit):TimeToDie() < 15) then
                return A.BestialWrath:Show(icon)
            end
            -- barrage,if=active_enemies>1
            if A.Barrage:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.Barrage:Show(icon)
            end
            -- chimaera_shot,if=spell_targets>1
            if A.ChimaeraShot:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.ChimaeraShot:Show(icon)
            end
            -- multishot,if=spell_targets>1&gcd.max-pet.cat.buff.beast_cleave.remains>0.25
            if A.Multishot:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and A.GetGCD() - Pet:HasBuffs(A.BeastCleaveBuff) > 0.25) then
                return A.Multishot:Show(icon)
            end
            -- kill_command
            if A.KillCommand:IsReady(unit) then
                return A.KillCommand:Show(icon)
            end
            -- chimaera_shot
            if A.ChimaeraShot:IsReady(unit) then
                return A.ChimaeraShot:Show(icon)
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- dire_beast
            if A.DireBeast:IsReady(unit) then
                return A.DireBeast:Show(icon)
            end
            -- barbed_shot,if=pet.cat.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<6&azerite.primal_instincts.enabled|target.time_to_die<9
            if A.BarbedShot:IsReady(unit) and (bool(Pet:HasBuffsDown(A.FrenzyBuff)) and (A.BarbedShot:ChargesFractionalP() > 1.8 or Unit("player"):HasBuffs(A.BestialWrathBuff)) or A.AspectoftheWild:GetCooldown() < 6 and A.PrimalInstincts:GetAzeriteRank() or Unit(unit):TimeToDie() < 9) then
                return A.BarbedShot:Show(icon)
            end
            -- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
            -- cobra_shot,if=(active_enemies<2|cooldown.kill_command.remains>focus.time_to_max)&(focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost|cooldown.kill_command.remains>1+gcd)&cooldown.kill_command.remains>1
            if A.CobraShot:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 or A.KillCommand:GetCooldown() > Unit("player"):FocusTimeToMaxPredicted()) and (Unit("player"):Focus() - A.CobraShot:Cost() + Unit("player"):FocusRegen() * (A.KillCommand:GetCooldown() - 1) > A.KillCommand:Cost() or A.KillCommand:GetCooldown() > 1 + A.GetGCD()) and A.KillCommand:GetCooldown() > 1) then
                return A.CobraShot:Show(icon)
            end
            -- arcane_torrent
            if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
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

