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
Action[ACTION_CONST_HUNTER_SURVIVAL] = {
    SummonPet                              = Action.Create({Type = "Spell", ID = 883 }),
    SteelTrapDebuff                        = Action.Create({Type = "Spell", ID = 162487 }),
    SteelTrap                              = Action.Create({Type = "Spell", ID = 162488 }),
    Harpoon                                = Action.Create({Type = "Spell", ID = 190925 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    CoordinatedAssault                     = Action.Create({Type = "Spell", ID = 266779 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Action.Create({Type = "Spell", ID = 26297 }),
    CoordinatedAssaultBuff                 = Action.Create({Type = "Spell", ID = 266779 }),
    BloodFuryBuff                          = Action.Create({Type = "Spell", ID = 20572 }),
    AspectoftheEagle                       = Action.Create({Type = "Spell", ID = 186289 }),
    AMurderofCrows                         = Action.Create({Type = "Spell", ID = 131894 }),
    Carve                                  = Action.Create({Type = "Spell", ID = 187708 }),
    ShrapnelBombDebuff                     = Action.Create({Type = "Spell", ID = 270339 }),
    WildfireBomb                           = Action.Create({Type = "Spell", ID = 259495 }),
    GuerrillaTactics                       = Action.Create({Type = "Spell", ID = 264332 }),
    WildfireBombDebuff                     = Action.Create({Type = "Spell", ID = 269747 }),
    MongooseBite                           = Action.Create({Type = "Spell", ID = 259387 }),
    LatentPoisonDebuff                     = Action.Create({Type = "Spell", ID = 273286 }),
    Chakrams                               = Action.Create({Type = "Spell", ID = 259391 }),
    KillCommand                            = Action.Create({Type = "Spell", ID = 259489 }),
    BloodseekerDebuff                      = Action.Create({Type = "Spell", ID = 259277 }),
    Butchery                               = Action.Create({Type = "Spell", ID = 212436 }),
    WildfireInfusion                       = Action.Create({Type = "Spell", ID = 271014 }),
    InternalBleedingDebuff                 = Action.Create({Type = "Spell", ID = 270343 }),
    FlankingStrike                         = Action.Create({Type = "Spell", ID = 269751 }),
    SerpentSting                           = Action.Create({Type = "Spell", ID = 259491 }),
    SerpentStingDebuff                     = Action.Create({Type = "Spell", ID = 259491 }),
    VipersVenomBuff                        = Action.Create({Type = "Spell", ID = 268552 }),
    TermsofEngagement                      = Action.Create({Type = "Spell", ID = 265895 }),
    TipoftheSpearBuff                      = Action.Create({Type = "Spell", ID = 260286 }),
    RaptorStrike                           = Action.Create({Type = "Spell", ID = 186270 }),
    MongooseFuryBuff                       = Action.Create({Type = "Spell", ID = 259388 }),
    LatentPoison                           = Action.Create({Type = "Spell", ID = 273283 }),
    VenomousFangs                          = Action.Create({Type = "Spell", ID = 274590 }),
    BirdsofPrey                            = Action.Create({Type = "Spell", ID = 260331 }),
    BlurofTalonsBuff                       = Action.Create({Type = "Spell", ID = 277969 }),
    AlphaPredator                          = Action.Create({Type = "Spell", ID = 269737 }),
    VipersVenom                            = Action.Create({Type = "Spell", ID = 268501 }),
    BlurofTalons                           = Action.Create({Type = "Spell", ID = 277653 }),
    WildernessSurvival                     = Action.Create({Type = "Spell", ID = 278532 }),
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
Action:CreateEssencesFor(ACTION_CONST_HUNTER_SURVIVAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_SURVIVAL], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarCarveCdr = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarCarveCdr = 0
	end 
end)

local EnemyRanges = {8}
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

A.WildfireBombNormal  = 259495
A.ShrapnelBomb        = 270335
A.PheromoneBomb       = 270323
A.VolatileBomb        = 271045

local WildfireInfusions = {
  A.ShrapnelBomb,
  A.PheromoneBomb,
  A.VolatileBomb,
}

local function CurrentWildfireInfusion ()
  if A.WildfireInfusion:IsAvailable() then
    for _, infusion in pairs(WildfireInfusions) do
      if infusion:IsSpellLearned() then return infusion end
    end
  end
  return A.WildfireBombNormal
end

A.RaptorStrikeNormal  = 186270
A.RaptorStrikeEagle   = 265189
A.MongooseBiteNormal  = 259387
A.MongooseBiteEagle   = 265888

local function CurrentRaptorStrike ()
  return A.RaptorStrikeEagle:IsSpellLearned() and A.RaptorStrikeEagle or A.RaptorStrikeNormal
end

local function CurrentMongooseBite ()
  return A.MongooseBiteEagle:IsSpellLearned() and A.MongooseBiteEagle or A.MongooseBiteNormal
end

local function EvaluateCycleCarveCdr62(unit)
    return (MultiUnits:GetByRangeInCombat(40, 5, 10) < 5) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 5)
end

local function EvaluateTargetIfFilterMongooseBite98(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff)
end

local function EvaluateTargetIfMongooseBite107(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff) == 10
end

local function EvaluateTargetIfFilterKillCommand115(unit)
  return Unit(unit):DebuffRemainsP(A.BloodseekerDebuff)
end

local function EvaluateTargetIfKillCommand128(unit)
  return Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Unit("player"):FocusMax()
end

local function EvaluateTargetIfFilterSerpentSting164(unit)
  return Unit(unit):HasDeBuffs(A.SerpentStingDebuff)
end

local function EvaluateTargetIfSerpentSting181(unit)
  return bool(Unit("player"):HasBuffsStacks(A.VipersVenomBuff))
end

local function EvaluateTargetIfFilterSerpentSting199(unit)
  return Unit(unit):HasDeBuffs(A.SerpentStingDebuff)
end

local function EvaluateTargetIfSerpentSting222(unit)
  return Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) and Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff) < 3
end

local function EvaluateTargetIfFilterMongooseBite228(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff)
end

local function EvaluateTargetIfFilterRaptorStrike239(unit)
  return Unit(unit):HasDeBuffsStacks(A.LatentPoisonDebuff)
end
--- ======= ACTION LISTS =======
local function APL()
        local Precombat, Cds, Cleave, MbApWfiSt, St, WfiSt
  UpdateRanges()
  Everyone.AoEToggleEnemiesUpdate()
  S.WildfireBomb = CurrentWildfireInfusion()
  S.RaptorStrike = CurrentRaptorStrike()
  S.MongooseBite = CurrentMongooseBite()
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
            -- steel_trap
            if A.SteelTrap:IsReady(unit) and Unit("player"):HasDebuffsDown(A.SteelTrapDebuff) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.SteelTrap:Show(icon)
            end
            -- harpoon
            if A.Harpoon:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.Harpoon:Show(icon)
            end
        end
        local function Cds(unit)
            -- blood_fury,if=cooldown.coordinated_assault.remains>30
            if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.BloodFury:Show(icon)
            end
            -- ancestral_call,if=cooldown.coordinated_assault.remains>30
            if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.AncestralCall:Show(icon)
            end
            -- fireblood,if=cooldown.coordinated_assault.remains>30
            if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 30) then
                return A.Fireblood:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            -- berserking,if=cooldown.coordinated_assault.remains>60|time_to_die<11
            if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (A.CoordinatedAssault:GetCooldown() > 60 or Unit(unit):TimeToDie() < 11) then
                return A.Berserking:Show(icon)
            end
            -- potion,if=buff.coordinated_assault.up&(buff.berserking.up|buff.blood_fury.up|!race.troll&!race.orc)|time_to_die<26
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff) and (Unit("player"):HasBuffs(A.BerserkingBuff) or Unit("player"):HasBuffs(A.BloodFuryBuff) or not Unit("player"):IsRace("Troll") and not Unit("player"):IsRace("Orc")) or Unit(unit):TimeToDie() < 26) then
                A.BattlePotionofAgility:Show(icon)
            end
            -- aspect_of_the_eagle,if=target.distance>=6
            if A.AspectoftheEagle:IsReady(unit) and A.BurstIsON(unit) and (target.distance >= 6) then
                return A.AspectoftheEagle:Show(icon)
            end
        end
        local function Cleave(unit)
            -- variable,name=carve_cdr,op=setif,value=active_enemies,value_else=5,condition=active_enemies<5
            if  then
                if Action.Utils.CastTargetIf(VarCarveCdr, 8, EvaluateCycleCarveCdr62) then
                    return VarCarveCdr:Show(icon) 
                end
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- carve,if=dot.shrapnel_bomb.ticking
            if A.Carve:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff)) then
                return A.Carve:Show(icon)
            end
            -- wildfire_bomb,if=!talent.guerrilla_tactics.enabled|full_recharge_time<gcd
            if A.WildfireBomb:IsReady(unit) and (not A.GuerrillaTactics:IsSpellLearned() or A.WildfireBomb:FullRechargeTimeP() < A.GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            -- mongoose_bite,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack=10
            if A.MongooseBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MongooseBite, 8, "max", EvaluateTargetIfFilterMongooseBite98, EvaluateTargetIfMongooseBite107) then 
                    return A.MongooseBite:Show(icon) 
                end
            end
            -- chakrams
            if A.Chakrams:IsReady(unit) then
                return A.Chakrams:Show(icon)
            end
            -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
            if A.KillCommand:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.KillCommand, 8, "min", EvaluateTargetIfFilterKillCommand115, EvaluateTargetIfKillCommand128) then 
                    return A.KillCommand:Show(icon) 
                end
            end
            -- butchery,if=full_recharge_time<gcd|!talent.wildfire_infusion.enabled|dot.shrapnel_bomb.ticking&dot.internal_bleeding.stack<3
            if A.Butchery:IsReady(unit) and (A.Butchery:FullRechargeTimeP() < A.GetGCD() or not A.WildfireInfusion:IsSpellLearned() or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff) and Unit(unit):HasDeBuffsStacks(A.InternalBleedingDebuff) < 3) then
                return A.Butchery:Show(icon)
            end
            -- carve,if=talent.guerrilla_tactics.enabled
            if A.Carve:IsReady(unit) and (A.GuerrillaTactics:IsSpellLearned()) then
                return A.Carve:Show(icon)
            end
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Unit("player"):FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            -- wildfire_bomb,if=dot.wildfire_bomb.refreshable|talent.wildfire_infusion.enabled
            if A.WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.WildfireBombDebuff) or A.WildfireInfusion:IsSpellLearned()) then
                return A.WildfireBomb:Show(icon)
            end
            -- serpent_sting,target_if=min:remains,if=buff.vipers_venom.react
            if A.SerpentSting:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SerpentSting, 8, "min", EvaluateTargetIfFilterSerpentSting164, EvaluateTargetIfSerpentSting181) then 
                    return A.SerpentSting:Show(icon) 
                end
            end
            -- carve,if=cooldown.wildfire_bomb.remains>variable.carve_cdr%2
            if A.Carve:IsReady(unit) and (A.WildfireBomb:GetCooldown() > VarCarveCdr / 2) then
                return A.Carve:Show(icon)
            end
            -- steel_trap
            if A.SteelTrap:IsReady(unit) then
                return A.SteelTrap:Show(icon)
            end
            -- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            -- serpent_sting,target_if=min:remains,if=refreshable&buff.tip_of_the_spear.stack<3
            if A.SerpentSting:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.SerpentSting, 8, "min", EvaluateTargetIfFilterSerpentSting199, EvaluateTargetIfSerpentSting222) then 
                    return A.SerpentSting:Show(icon) 
                end
            end
            -- mongoose_bite,target_if=max:debuff.latent_poison.stack
            if A.MongooseBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MongooseBite, 8, "max", EvaluateTargetIfFilterMongooseBite228) then 
                    return A.MongooseBite:Show(icon) 
                end
            end
            -- raptor_strike,target_if=max:debuff.latent_poison.stack
            if A.RaptorStrike:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.RaptorStrike, 8, "max", EvaluateTargetIfFilterRaptorStrike239) then 
                    return A.RaptorStrike:Show(icon) 
                end
            end
        end
        local function MbApWfiSt(unit)
            -- serpent_sting,if=!dot.serpent_sting.ticking
            if A.SerpentSting:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.SerpentStingDebuff)) then
                return A.SerpentSting:Show(icon)
            end
            -- wildfire_bomb,if=full_recharge_time<gcd|(focus+cast_regen<focus.max)&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if A.WildfireBomb:IsReady(unit) and (A.WildfireBomb:FullRechargeTimeP() < A.GetGCD() or (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Unit("player"):FocusMax()) and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff) and Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) or S.PheromoneBomb:IsLearned() and not Unit("player"):HasBuffs(A.MongooseFuryBuff) and Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Unit("player"):FocusMax() - Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) * 3)) then
                return A.WildfireBomb:Show(icon)
            end
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- steel_trap
            if A.SteelTrap:IsReady(unit) then
                return A.SteelTrap:Show(icon)
            end
            -- mongoose_bite,if=buff.mongoose_fury.remains&next_wi_bomb.pheromone
            if A.MongooseBite:IsReady(unit) and (bool(Unit("player"):HasBuffs(A.MongooseFuryBuff)) and S.PheromoneBomb:IsLearned()) then
                return A.MongooseBite:Show(icon)
            end
            -- kill_command,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) and (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Unit("player"):FocusMax() and (Unit("player"):HasBuffsStacks(A.MongooseFuryBuff) < 5 or Unit("player"):Focus() < A.MongooseBite:Cost())) then
                return A.KillCommand:Show(icon)
            end
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&focus>60&dot.serpent_sting.remains>3*gcd
            if A.WildfireBomb:IsReady(unit) and (S.ShrapnelBomb:IsLearned() and Unit("player"):Focus() > 60 and Unit(unit):HasDeBuffs(A.SerpentStingDebuff) > 3 * A.GetGCD()) then
                return A.WildfireBomb:Show(icon)
            end
            -- serpent_sting,if=refreshable&(next_wi_bomb.volatile&!dot.shrapnel_bomb.ticking|azerite.latent_poison.enabled|azerite.venomous_fangs.enabled)
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) and (S.VolatileBomb:IsLearned() and not Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff) or A.LatentPoison:GetAzeriteRank() or A.VenomousFangs:GetAzeriteRank())) then
                return A.SerpentSting:Show(icon)
            end
            -- mongoose_bite,if=buff.mongoose_fury.up|focus>60|dot.shrapnel_bomb.ticking
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff) or Unit("player"):Focus() > 60 or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff)) then
                return A.MongooseBite:Show(icon)
            end
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff)) then
                return A.SerpentSting:Show(icon)
            end
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
            if A.WildfireBomb:IsReady(unit) and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff) or S.PheromoneBomb:IsLearned() or S.ShrapnelBomb:IsLearned() and Unit("player"):Focus() > 50) then
                return A.WildfireBomb:Show(icon)
            end
        end
        local function St(unit)
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- mongoose_bite,if=talent.birds_of_prey.enabled&buff.coordinated_assault.up&(buff.coordinated_assault.remains<gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd)
            if A.MongooseBite:IsReady(unit) and (A.BirdsofPrey:IsSpellLearned() and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff) < A.GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff) and Unit("player"):HasBuffs(A.BlurofTalonsBuff) < A.GetGCD())) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike,if=talent.birds_of_prey.enabled&buff.coordinated_assault.up&(buff.coordinated_assault.remains<gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd)
            if A.RaptorStrike:IsReady(unit) and (A.BirdsofPrey:IsSpellLearned() and Unit("player"):HasBuffs(A.CoordinatedAssaultBuff) and (Unit("player"):HasBuffs(A.CoordinatedAssaultBuff) < A.GetGCD() or Unit("player"):HasBuffs(A.BlurofTalonsBuff) and Unit("player"):HasBuffs(A.BlurofTalonsBuff) < A.GetGCD())) then
                return A.RaptorStrike:Show(icon)
            end
            -- serpent_sting,if=buff.vipers_venom.react&buff.vipers_venom.remains<gcd
            if A.SerpentSting:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.VipersVenomBuff)) and Unit("player"):HasBuffs(A.VipersVenomBuff) < A.GetGCD()) then
                return A.SerpentSting:Show(icon)
            end
            -- kill_command,if=focus+cast_regen<focus.max&(!talent.alpha_predator.enabled|full_recharge_time<gcd)
            if A.KillCommand:IsReady(unit) and (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Unit("player"):FocusMax() and (not A.AlphaPredator:IsSpellLearned() or A.KillCommand:FullRechargeTimeP() < A.GetGCD())) then
                return A.KillCommand:Show(icon)
            end
            -- wildfire_bomb,if=focus+cast_regen<focus.max&(full_recharge_time<gcd|!dot.wildfire_bomb.ticking&(buff.mongoose_fury.down|full_recharge_time<4.5*gcd))
            if A.WildfireBomb:IsReady(unit) and (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Unit("player"):FocusMax() and (A.WildfireBomb:FullRechargeTimeP() < A.GetGCD() or not Unit(unit):HasDeBuffs(A.WildfireBombDebuff) and (bool(Unit("player"):HasBuffsDown(A.MongooseFuryBuff)) or A.WildfireBomb:FullRechargeTimeP() < 4.5 * A.GetGCD()))) then
                return A.WildfireBomb:Show(icon)
            end
            -- serpent_sting,if=buff.vipers_venom.react&dot.serpent_sting.remains<4*gcd|!talent.vipers_venom.enabled&!dot.serpent_sting.ticking&!buff.coordinated_assault.up
            if A.SerpentSting:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.VipersVenomBuff)) and Unit(unit):HasDeBuffs(A.SerpentStingDebuff) < 4 * A.GetGCD() or not A.VipersVenom:IsSpellLearned() and not Unit(unit):HasDeBuffs(A.SerpentStingDebuff) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff)) then
                return A.SerpentSting:Show(icon)
            end
            -- serpent_sting,if=refreshable&(azerite.latent_poison.rank>2|azerite.latent_poison.enabled&azerite.venomous_fangs.enabled|(azerite.latent_poison.enabled|azerite.venomous_fangs.enabled)&(!azerite.blur_of_talons.enabled|!talent.birds_of_prey.enabled|!buff.coordinated_assault.up))
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) and (A.LatentPoison:GetAzeriteRank() > 2 or A.LatentPoison:GetAzeriteRank() and A.VenomousFangs:GetAzeriteRank() or (A.LatentPoison:GetAzeriteRank() or A.VenomousFangs:GetAzeriteRank()) and (not A.BlurofTalons:GetAzeriteRank() or not A.BirdsofPrey:IsSpellLearned() or not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff)))) then
                return A.SerpentSting:Show(icon)
            end
            -- steel_trap
            if A.SteelTrap:IsReady(unit) then
                return A.SteelTrap:Show(icon)
            end
            -- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- chakrams
            if A.Chakrams:IsReady(unit) then
                return A.Chakrams:Show(icon)
            end
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Unit("player"):FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            -- kill_command,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<4|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) and (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Unit("player"):FocusMax() and (Unit("player"):HasBuffsStacks(A.MongooseFuryBuff) < 4 or Unit("player"):Focus() < A.MongooseBite:Cost())) then
                return A.KillCommand:Show(icon)
            end
            -- mongoose_bite,if=buff.mongoose_fury.up|focus>60
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff) or Unit("player"):Focus() > 60) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            -- serpent_sting,if=dot.serpent_sting.refreshable&!buff.coordinated_assault.up
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) and not Unit("player"):HasBuffs(A.CoordinatedAssaultBuff)) then
                return A.SerpentSting:Show(icon)
            end
            -- wildfire_bomb,if=dot.wildfire_bomb.refreshable
            if A.WildfireBomb:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.WildfireBombDebuff)) then
                return A.WildfireBomb:Show(icon)
            end
        end
        local function WfiSt(unit)
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
            -- coordinated_assault
            if A.CoordinatedAssault:IsReady(unit) and A.BurstIsON(unit) then
                return A.CoordinatedAssault:Show(icon)
            end
            -- mongoose_bite,if=azerite.wilderness_survival.enabled&next_wi_bomb.volatile&dot.serpent_sting.remains>2.1*gcd&dot.serpent_sting.remains<3.5*gcd&cooldown.wildfire_bomb.remains>2.5*gcd
            if A.MongooseBite:IsReady(unit) and (A.WildernessSurvival:GetAzeriteRank() and S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff) > 2.1 * A.GetGCD() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff) < 3.5 * A.GetGCD() and A.WildfireBomb:GetCooldown() > 2.5 * A.GetGCD()) then
                return A.MongooseBite:Show(icon)
            end
            -- wildfire_bomb,if=full_recharge_time<gcd|(focus+cast_regen<focus.max)&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
            if A.WildfireBomb:IsReady(unit) and (A.WildfireBomb:FullRechargeTimeP() < A.GetGCD() or (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Unit("player"):FocusMax()) and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff) and Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) or S.PheromoneBomb:IsLearned() and not Unit("player"):HasBuffs(A.MongooseFuryBuff) and Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.WildfireBomb:GetSpellCastTime) < Unit("player"):FocusMax() - Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) * 3)) then
                return A.WildfireBomb:Show(icon)
            end
            -- kill_command,if=focus+cast_regen<focus.max&buff.tip_of_the_spear.stack<3&(!talent.alpha_predator.enabled|buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
            if A.KillCommand:IsReady(unit) and (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.KillCommand:GetSpellCastTime) < Unit("player"):FocusMax() and Unit("player"):HasBuffsStacks(A.TipoftheSpearBuff) < 3 and (not A.AlphaPredator:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.MongooseFuryBuff) < 5 or Unit("player"):Focus() < A.MongooseBite:Cost())) then
                return A.KillCommand:Show(icon)
            end
            -- raptor_strike,if=dot.internal_bleeding.stack<3&dot.shrapnel_bomb.ticking&!talent.mongoose_bite.enabled
            if A.RaptorStrike:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.InternalBleedingDebuff) < 3 and Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff) and not A.MongooseBite:IsSpellLearned()) then
                return A.RaptorStrike:Show(icon)
            end
            -- wildfire_bomb,if=next_wi_bomb.shrapnel&buff.mongoose_fury.down&(cooldown.kill_command.remains>gcd|focus>60)&!dot.serpent_sting.refreshable
            if A.WildfireBomb:IsReady(unit) and (S.ShrapnelBomb:IsLearned() and bool(Unit("player"):HasBuffsDown(A.MongooseFuryBuff)) and (A.KillCommand:GetCooldown() > A.GetGCD() or Unit("player"):Focus() > 60) and not Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff)) then
                return A.WildfireBomb:Show(icon)
            end
            -- steel_trap
            if A.SteelTrap:IsReady(unit) then
                return A.SteelTrap:Show(icon)
            end
            -- flanking_strike,if=focus+cast_regen<focus.max
            if A.FlankingStrike:IsReady(unit) and (Unit("player"):Focus() + Unit("player"):FocusCastRegen(A.FlankingStrike:GetSpellCastTime) < Unit("player"):FocusMax()) then
                return A.FlankingStrike:Show(icon)
            end
            -- serpent_sting,if=buff.vipers_venom.react|refreshable&(!talent.mongoose_bite.enabled|!talent.vipers_venom.enabled|next_wi_bomb.volatile&!dot.shrapnel_bomb.ticking|azerite.latent_poison.enabled|azerite.venomous_fangs.enabled|buff.mongoose_fury.stack=5)
            if A.SerpentSting:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.VipersVenomBuff)) or Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) and (not A.MongooseBite:IsSpellLearned() or not A.VipersVenom:IsSpellLearned() or S.VolatileBomb:IsLearned() and not Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff) or A.LatentPoison:GetAzeriteRank() or A.VenomousFangs:GetAzeriteRank() or Unit("player"):HasBuffsStacks(A.MongooseFuryBuff) == 5)) then
                return A.SerpentSting:Show(icon)
            end
            -- harpoon,if=talent.terms_of_engagement.enabled
            if A.Harpoon:IsReady(unit) and (A.TermsofEngagement:IsSpellLearned()) then
                return A.Harpoon:Show(icon)
            end
            -- mongoose_bite,if=buff.mongoose_fury.up|focus>60|dot.shrapnel_bomb.ticking
            if A.MongooseBite:IsReady(unit) and (Unit("player"):HasBuffs(A.MongooseFuryBuff) or Unit("player"):Focus() > 60 or Unit(unit):HasDeBuffs(A.ShrapnelBombDebuff)) then
                return A.MongooseBite:Show(icon)
            end
            -- raptor_strike
            if A.RaptorStrike:IsReady(unit) then
                return A.RaptorStrike:Show(icon)
            end
            -- serpent_sting,if=refreshable
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff)) then
                return A.SerpentSting:Show(icon)
            end
            -- wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
            if A.WildfireBomb:IsReady(unit) and (S.VolatileBomb:IsLearned() and Unit(unit):HasDeBuffs(A.SerpentStingDebuff) or S.PheromoneBomb:IsLearned() or S.ShrapnelBomb:IsLearned() and Unit("player"):Focus() > 50) then
                return A.WildfireBomb:Show(icon)
            end
        end
  if Everyone.TargetIsValid() then
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end
            -- auto_attack
            -- use_items
            -- call_action_list,name=cds
            if (true) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=mb_ap_wfi_st,if=active_enemies<3&talent.wildfire_infusion.enabled&talent.alpha_predator.enabled&talent.mongoose_bite.enabled
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 and A.WildfireInfusion:IsSpellLearned() and A.AlphaPredator:IsSpellLearned() and A.MongooseBite:IsSpellLearned()) then
                local ShouldReturn = MbApWfiSt(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=wfi_st,if=active_enemies<3&talent.wildfire_infusion.enabled
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 and A.WildfireInfusion:IsSpellLearned()) then
                local ShouldReturn = WfiSt(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=st,if=active_enemies<2
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2) then
                local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cleave,if=active_enemies>1
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                local ShouldReturn = Cleave(unit); if ShouldReturn then return ShouldReturn; end
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

