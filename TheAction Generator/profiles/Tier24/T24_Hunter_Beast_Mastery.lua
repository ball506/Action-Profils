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
  WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
  GuardianofAzeroth                      = Action.Create({Type = "Spell", ID =  }),
  MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
  FocusedAzeriteBeam                     = Action.Create({Type = "Spell", ID =  }),
  AspectoftheWildBuff                    = Action.Create({Type = "Spell", ID = 193530 }),
  AspectoftheWild                        = Action.Create({Type = "Spell", ID = 193530 }),
  PrimalInstinctsBuff                    = Action.Create({Type = "Spell", ID = 279810 }),
  PrimalInstincts                        = Action.Create({Type = "Spell", ID = 279806 }),
  BestialWrathBuff                       = Action.Create({Type = "Spell", ID = 19574 }),
  BestialWrath                           = Action.Create({Type = "Spell", ID = 19574 }),
  AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  BerserkingBuff                         = Action.Create({Type = "Spell", ID = 26297 }),
  KillerInstinct                         = Action.Create({Type = "Spell", ID = 273887 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  BloodFuryBuff                          = Action.Create({Type = "Spell", ID = 20572 }),
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  FrenzyBuff                             = Action.Create({Type = "Spell", ID = 272790 }),
  PotionofUnbridledFuryBuff              = Action.Create({Type = "Spell", ID =  }),
  UnbridledFuryBuff                      = Action.Create({Type = "Spell", ID =  }),
  LifebloodBuff                          = Action.Create({Type = "Spell", ID =  }),
  RippleInSpace                          = Action.Create({Type = "Spell", ID =  }),
  BarbedShot                             = Action.Create({Type = "Spell", ID = 217200 }),
  BarbedShotDebuff                       = Action.Create({Type = "Spell", ID =  }),
  Multishot                              = Action.Create({Type = "Spell", ID = 2643 }),
  BeastCleaveBuff                        = Action.Create({Type = "Spell", ID = 118455, "pet" }),
  Stampede                               = Action.Create({Type = "Spell", ID = 201430 }),
  OneWiththePack                         = Action.Create({Type = "Spell", ID = 199528 }),
  ChimaeraShot                           = Action.Create({Type = "Spell", ID = 53209 }),
  AMurderofCrows                         = Action.Create({Type = "Spell", ID = 131894 }),
  Barrage                                = Action.Create({Type = "Spell", ID = 120360 }),
  KillCommand                            = Action.Create({Type = "Spell", ID = 34026 }),
  RapidReload                            = Action.Create({Type = "Spell", ID =  }),
  DireBeast                              = Action.Create({Type = "Spell", ID = 120679 }),
  PurifyingBlast                         = Action.Create({Type = "Spell", ID =  }),
  ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
  BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
  TheUnboundForce                        = Action.Create({Type = "Spell", ID =  }),
  RecklessForceBuff                      = Action.Create({Type = "Spell", ID =  }),
  RecklessForceCounterBuff               = Action.Create({Type = "Spell", ID =  }),
  CobraShot                              = Action.Create({Type = "Spell", ID = 193455 }),
  SpittingCobra                          = Action.Create({Type = "Spell", ID = 194407 }),
  ConcentratedFlameBurnDebuff            = Action.Create({Type = "Spell", ID =  }),
  DanceofDeath                           = Action.Create({Type = "Spell", ID =  }),
  DanceofDeathBuff                       = Action.Create({Type = "Spell", ID =  }),
  MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
  RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
  CyclotronicBlast                       = Action.Create({Type = "Spell", ID =  })
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


local function EvaluateTargetIfFilterBarbedShot125(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff)
end

local function EvaluateTargetIfBarbedShot136(unit)
  return Pet:HasBuffs(A.FrenzyBuff) and Pet:HasBuffs(A.FrenzyBuff) <= A.GetGCD()
end

local function EvaluateTargetIfFilterBarbedShot146(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff)
end

local function EvaluateTargetIfBarbedShot159(unit)
  return A.BarbedShot:FullRechargeTimeP() < A.GetGCD() and bool(A.BestialWrath:GetCooldown())
end

local function EvaluateTargetIfFilterBarbedShot197(unit)
  return Unit(unit):HasDeBuffs(A.BarbedShotDebuff)
end

local function EvaluateTargetIfBarbedShot222(unit)
  return bool(Pet:HasBuffsDown(A.FrenzyBuff)) and (A.BarbedShot:ChargesFractionalP() > 1.8 or Unit("player"):HasBuffs(A.BestialWrathBuff)) or A.AspectoftheWild:GetCooldown() < A.FrenzyBuff:BaseDuration - A.GetGCD() and A.PrimalInstincts:GetAzeriteRank or A.BarbedShot:ChargesFractionalP() > 1.4 or Unit(unit):TimeToDie() < 9
end
--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
	--------------------
	---  VARIABLES   ---
	--------------------
   local isMoving = A.Player:IsMoving()
   local inCombat = Unit("player"):CombatTime() > 0
   local ShouldStop = Action.ShouldStop()
   local Pull = Action.BossMods_Pulling()
   local CanMultidot = HandleMultidots()
   local unit = "player"
   ------------------------------------------------------
   ---------------- ENEMY UNIT ROTATION -----------------
   ------------------------------------------------------
   local function EnemyRotation(unit)
     local Precombat, Cds, Cleave, St
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
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
    -- use_item,name=azsharas_font_of_power
    if A.AzsharasFontofPower:IsReady(unit) then
      A.AzsharasFontofPower:Show(icon)
    end
    -- worldvein_resonance
    if A.WorldveinResonance:IsReady(unit) then
        return A.WorldveinResonance:Show(icon)
    end
    -- guardian_of_azeroth
    if A.GuardianofAzeroth:IsReady(unit) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- memory_of_lucid_dreams
    if A.MemoryofLucidDreams:IsReady(unit) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    -- use_item,effect_name=cyclotronic_blast,if=!raid_event.invulnerable.exists&(trinket.1.has_cooldown+trinket.2.has_cooldown<2|equipped.variable_intensity_gigavolt_oscillating_reactor)
    if A.:IsReady(unit) and (not bool(raid_event.invulnerable.exists) and (trinket.1.has_cooldown + trinket.2.has_cooldown < 2 or A.VariableIntensityGigavoltOscillatingReactor:IsEquipped)) then
      A.:Show(icon)
    end
    -- focused_azerite_beam,if=!raid_event.invulnerable.exists
    if A.FocusedAzeriteBeam:IsReady(unit) and (not bool(raid_event.invulnerable.exists)) then
        return A.FocusedAzeriteBeam:Show(icon)
    end
    -- aspect_of_the_wild,precast_time=1.1,if=!azerite.primal_instincts.enabled&!essence.essence_of_the_focusing_iris.major&(equipped.azsharas_font_of_power|!equipped.cyclotronic_blast)
    if A.AspectoftheWild:IsReady(unit) and Player:HasBuffsDown(A.AspectoftheWildBuff) and (not A.PrimalInstincts:GetAzeriteRank and not bool(essence.essence_of_the_focusing_iris.major) and (A.AzsharasFontofPower:IsEquipped or not A.CyclotronicBlast:IsEquipped)) then
        return A.AspectoftheWild:Show(icon)
    end
    -- bestial_wrath,precast_time=1.5,if=azerite.primal_instincts.enabled&!essence.essence_of_the_focusing_iris.major&(equipped.azsharas_font_of_power|!equipped.cyclotronic_blast)
    if A.BestialWrath:IsReady(unit) and Player:HasBuffsDown(A.BestialWrathBuff) and (A.PrimalInstincts:GetAzeriteRank and not bool(essence.essence_of_the_focusing_iris.major) and (A.AzsharasFontofPower:IsEquipped or not A.CyclotronicBlast:IsEquipped)) then
        return A.BestialWrath:Show(icon)
    end
    end
    local function Cds(unit)
        -- ancestral_call,if=cooldown.bestial_wrath.remains>30
    if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
        return A.AncestralCall:Show(icon)
    end
    -- fireblood,if=cooldown.bestial_wrath.remains>30
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) then
        return A.Fireblood:Show(icon)
    end
    -- berserking,if=buff.aspect_of_the_wild.up&(target.time_to_die>cooldown.berserking.duration+duration|(target.health.pct<35|!talent.killer_instinct.enabled))|target.time_to_die<13
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff) and (Unit(unit):TimeToDie() > A.Berserking:BaseDuration + A.BerserkingBuff:BaseDuration or (Unit(unit):HealthPercent < 35 or not A.KillerInstinct:IsSpellLearned())) or Unit(unit):TimeToDie() < 13) then
        return A.Berserking:Show(icon)
    end
    -- blood_fury,if=buff.aspect_of_the_wild.up&(target.time_to_die>cooldown.blood_fury.duration+duration|(target.health.pct<35|!talent.killer_instinct.enabled))|target.time_to_die<16
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff) and (Unit(unit):TimeToDie() > A.BloodFury:BaseDuration + A.BloodFuryBuff:BaseDuration or (Unit(unit):HealthPercent < 35 or not A.KillerInstinct:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
        return A.BloodFury:Show(icon)
    end
    -- lights_judgment,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains>gcd.max|!pet.cat.buff.frenzy.up
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Pet:HasBuffs(A.FrenzyBuff) and Pet:HasBuffs(A.FrenzyBuff) > A.GetGCD() or not Pet:HasBuffs(A.FrenzyBuff)) then
        return A.LightsJudgment:Show(icon)
    end
    -- potion,if=buff.bestial_wrath.up&buff.aspect_of_the_wild.up&(target.health.pct<35|!talent.killer_instinct.enabled)|((consumable.potion_of_unbridled_fury|consumable.unbridled_fury)&target.time_to_die<61|target.time_to_die<26)
    if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.BestialWrathBuff) and Unit("player"):HasBuffs(A.AspectoftheWildBuff) and (Unit(unit):HealthPercent < 35 or not A.KillerInstinct:IsSpellLearned()) or ((Unit(unit):HasBuffs(A.PotionofUnbridledFuryBuff) or Unit(unit):HasBuffs(A.UnbridledFuryBuff)) and Unit(unit):TimeToDie() < 61 or Unit(unit):TimeToDie() < 26)) then
      A.BattlePotionofAgility:Show(icon)
    end
    -- worldvein_resonance,if=buff.lifeblood.stack<4
    if A.WorldveinResonance:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.LifebloodBuff) < 4) then
        return A.WorldveinResonance:Show(icon)
    end
    -- guardian_of_azeroth,if=cooldown.aspect_of_the_wild.remains<10|target.time_to_die>cooldown+duration|target.time_to_die<30
    if A.GuardianofAzeroth:IsReady(unit) and (A.AspectoftheWild:GetCooldown() < 10 or Unit(unit):TimeToDie() > cooldown + duration or Unit(unit):TimeToDie() < 30) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- ripple_in_space
    if A.RippleInSpace:IsReady(unit) then
        return A.RippleInSpace:Show(icon)
    end
    -- memory_of_lucid_dreams
    if A.MemoryofLucidDreams:IsReady(unit) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    end
    local function Cleave(unit)
        -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains<=gcd.max
    if A.BarbedShot:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot125, EvaluateTargetIfBarbedShot136) then 
            return A.BarbedShot:Show(icon) 
        end
    end
    -- multishot,if=gcd.max-pet.cat.buff.beast_cleave.remains>0.25
    if A.Multishot:IsReady(unit) and (A.GetGCD() - Pet:HasBuffs(A.BeastCleaveBuff) > 0.25) then
        return A.Multishot:Show(icon)
    end
    -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=full_recharge_time<gcd.max&cooldown.bestial_wrath.remains
    if A.BarbedShot:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot146, EvaluateTargetIfBarbedShot159) then 
            return A.BarbedShot:Show(icon) 
        end
    end
    -- aspect_of_the_wild
    if A.AspectoftheWild:IsReady(unit) then
        return A.AspectoftheWild:Show(icon)
    end
    -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
    if A.Stampede:IsReady(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff) and Unit("player"):HasBuffs(A.BestialWrathBuff) or Unit(unit):TimeToDie() < 15) then
        return A.Stampede:Show(icon)
    end
    -- bestial_wrath,if=cooldown.aspect_of_the_wild.remains_guess>20|talent.one_with_the_pack.enabled|target.time_to_die<15
    if A.BestialWrath:IsReady(unit) and (cooldown.aspect_of_the_wild.remains_guess > 20 or A.OneWiththePack:IsSpellLearned() or Unit(unit):TimeToDie() < 15) then
        return A.BestialWrath:Show(icon)
    end
    -- chimaera_shot
    if A.ChimaeraShot:IsReady(unit) then
        return A.ChimaeraShot:Show(icon)
    end
    -- a_murder_of_crows
    if A.AMurderofCrows:IsReady(unit) then
        return A.AMurderofCrows:Show(icon)
    end
    -- barrage
    if A.Barrage:IsReady(unit) then
        return A.Barrage:Show(icon)
    end
    -- kill_command,if=active_enemies<4|!azerite.rapid_reload.enabled
    if A.KillCommand:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 or not A.RapidReload:GetAzeriteRank) then
        return A.KillCommand:Show(icon)
    end
    -- dire_beast
    if A.DireBeast:IsReady(unit) then
        return A.DireBeast:Show(icon)
    end
    -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.cat.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<pet.cat.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|charges_fractional>1.4|target.time_to_die<9
    if A.BarbedShot:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.BarbedShot, 40, "min", EvaluateTargetIfFilterBarbedShot197, EvaluateTargetIfBarbedShot222) then 
            return A.BarbedShot:Show(icon) 
        end
    end
    -- focused_azerite_beam
    if A.FocusedAzeriteBeam:IsReady(unit) then
        return A.FocusedAzeriteBeam:Show(icon)
    end
    -- purifying_blast
    if A.PurifyingBlast:IsReady(unit) then
        return A.PurifyingBlast:Show(icon)
    end
    -- concentrated_flame
    if A.ConcentratedFlame:IsReady(unit) then
        return A.ConcentratedFlame:Show(icon)
    end
    -- blood_of_the_enemy
    if A.BloodoftheEnemy:IsReady(unit) then
        return A.BloodoftheEnemy:Show(icon)
    end
    -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
    if A.TheUnboundForce:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessForceBuff) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff) < 10) then
        return A.TheUnboundForce:Show(icon)
    end
    -- multishot,if=azerite.rapid_reload.enabled&active_enemies>2
    if A.Multishot:IsReady(unit) and (A.RapidReload:GetAzeriteRank and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
        return A.Multishot:Show(icon)
    end
    -- cobra_shot,if=cooldown.kill_command.remains>focus.time_to_max&(active_enemies<3|!azerite.rapid_reload.enabled)
    if A.CobraShot:IsReady(unit) and (A.KillCommand:GetCooldown() > Player:FocusTimeToMaxPredicted() and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or not A.RapidReload:GetAzeriteRank)) then
        return A.CobraShot:Show(icon)
    end
    -- spitting_cobra
    if A.SpittingCobra:IsReady(unit) then
        return A.SpittingCobra:Show(icon)
    end
    end
    local function St(unit)
        -- barbed_shot,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains<gcd|cooldown.bestial_wrath.remains&(full_recharge_time<gcd|azerite.primal_instincts.enabled&cooldown.aspect_of_the_wild.remains<gcd)
    if A.BarbedShot:IsReady(unit) and (Pet:HasBuffs(A.FrenzyBuff) and Pet:HasBuffs(A.FrenzyBuff) < A.GetGCD() or bool(A.BestialWrath:GetCooldown()) and (A.BarbedShot:FullRechargeTimeP() < A.GetGCD() or A.PrimalInstincts:GetAzeriteRank and A.AspectoftheWild:GetCooldown() < A.GetGCD())) then
        return A.BarbedShot:Show(icon)
    end
    -- concentrated_flame,if=focus+focus.regen*gcd<focus.max&buff.bestial_wrath.down&(!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight)|full_recharge_time<gcd|target.time_to_die<5
    if A.ConcentratedFlame:IsReady(unit) and (Player:Focus() + Player:FocusRegen() * A.GetGCD() < Player:FocusMax() and bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff)) and (not bool(Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff)) and not A.ConcentratedFlame:IsSpellInFlight()) or A.ConcentratedFlame:FullRechargeTimeP() < A.GetGCD() or Unit(unit):TimeToDie() < 5) then
        return A.ConcentratedFlame:Show(icon)
    end
    -- aspect_of_the_wild,if=cooldown.barbed_shot.charges<2|pet.cat.buff.frenzy.stack>2|!azerite.primal_instincts.enabled
    if A.AspectoftheWild:IsReady(unit) and (A.BarbedShot:ChargesP() < 2 or Pet:HasBuffsStacks(A.FrenzyBuff) > 2 or not A.PrimalInstincts:GetAzeriteRank) then
        return A.AspectoftheWild:Show(icon)
    end
    -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
    if A.Stampede:IsReady(unit) and (Unit("player"):HasBuffs(A.AspectoftheWildBuff) and Unit("player"):HasBuffs(A.BestialWrathBuff) or Unit(unit):TimeToDie() < 15) then
        return A.Stampede:Show(icon)
    end
    -- a_murder_of_crows,if=cooldown.bestial_wrath.remains
    if A.AMurderofCrows:IsReady(unit) and (bool(A.BestialWrath:GetCooldown())) then
        return A.AMurderofCrows:Show(icon)
    end
    -- focused_azerite_beam,if=buff.bestial_wrath.down|target.time_to_die<5
    if A.FocusedAzeriteBeam:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff)) or Unit(unit):TimeToDie() < 5) then
        return A.FocusedAzeriteBeam:Show(icon)
    end
    -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10|target.time_to_die<5
    if A.TheUnboundForce:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessForceBuff) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff) < 10 or Unit(unit):TimeToDie() < 5) then
        return A.TheUnboundForce:Show(icon)
    end
    -- bestial_wrath
    if A.BestialWrath:IsReady(unit) then
        return A.BestialWrath:Show(icon)
    end
    -- kill_command
    if A.KillCommand:IsReady(unit) then
        return A.KillCommand:Show(icon)
    end
    -- chimaera_shot
    if A.ChimaeraShot:IsReady(unit) then
        return A.ChimaeraShot:Show(icon)
    end
    -- dire_beast
    if A.DireBeast:IsReady(unit) then
        return A.DireBeast:Show(icon)
    end
    -- barbed_shot,if=pet.cat.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<pet.cat.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|azerite.dance_of_death.rank>1&buff.dance_of_death.down&crit_pct_current>40|target.time_to_die<9
    if A.BarbedShot:IsReady(unit) and (bool(Pet:HasBuffsDown(A.FrenzyBuff)) and (A.BarbedShot:ChargesFractionalP() > 1.8 or Unit("player"):HasBuffs(A.BestialWrathBuff)) or A.AspectoftheWild:GetCooldown() < A.FrenzyBuff:BaseDuration - A.GetGCD() and A.PrimalInstincts:GetAzeriteRank or A.DanceofDeath:GetAzeriteRank > 1 and bool(Unit("player"):HasBuffsDown(A.DanceofDeathBuff)) and crit_pct_current > 40 or Unit(unit):TimeToDie() < 9) then
        return A.BarbedShot:Show(icon)
    end
    -- purifying_blast,if=buff.bestial_wrath.down|target.time_to_die<8
    if A.PurifyingBlast:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff)) or Unit(unit):TimeToDie() < 8) then
        return A.PurifyingBlast:Show(icon)
    end
    -- blood_of_the_enemy
    if A.BloodoftheEnemy:IsReady(unit) then
        return A.BloodoftheEnemy:Show(icon)
    end
    -- barrage
    if A.Barrage:IsReady(unit) then
        return A.Barrage:Show(icon)
    end
    -- cobra_shot,if=(focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost|cooldown.kill_command.remains>1+gcd|buff.memory_of_lucid_dreams.up)&cooldown.kill_command.remains>1
    if A.CobraShot:IsReady(unit) and ((Player:Focus() - A.CobraShot:Cost() + Player:FocusRegen() * (A.KillCommand:GetCooldown() - 1) > A.KillCommand:Cost() or A.KillCommand:GetCooldown() > 1 + A.GetGCD() or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff)) and A.KillCommand:GetCooldown() > 1) then
        return A.CobraShot:Show(icon)
    end
    -- spitting_cobra
    if A.SpittingCobra:IsReady(unit) then
        return A.SpittingCobra:Show(icon)
    end
    -- barbed_shot,if=charges_fractional>1.4
    if A.BarbedShot:IsReady(unit) and (A.BarbedShot:ChargesFractionalP() > 1.4) then
        return A.BarbedShot:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_shot
    -- use_items
    -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.up&(prev_gcd.1.aspect_of_the_wild|!equipped.cyclotronic_blast&buff.aspect_of_the_wild.up)&(target.health.pct<35|!essence.condensed_lifeforce.major)|(debuff.razor_coral_debuff.down|target.time_to_die<26)&target.time_to_die>(24*(cooldown.cyclotronic_blast.remains+4<target.time_to_die))
    if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RazorCoralDeBuffDebuff) and (Unit("player"):GetSpellLastCast(A.AspectoftheWild) or not A.CyclotronicBlast:IsEquipped and Unit("player"):HasBuffs(A.AspectoftheWildBuff)) and (Unit(unit):HealthPercent < 35 or not bool(essence.condensed_lifeforce.major)) or (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDeBuffDebuff)) or Unit(unit):TimeToDie() < 26) and Unit(unit):TimeToDie() > (24 * num((A.CyclotronicBlast:GetCooldown() + 4 < Unit(unit):TimeToDie())))) then
      A.AshvanesRazorCoral:Show(icon)
    end
    -- use_item,effect_name=cyclotronic_blast,if=buff.bestial_wrath.down|target.time_to_die<5
    if A.:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BestialWrathBuff)) or Unit(unit):TimeToDie() < 5) then
      A.:Show(icon)
    end
    -- call_action_list,name=cds
    if (true) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=st,if=active_enemies<2
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2) then
      local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=cleave,if=active_enemies>1
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
      local ShouldReturn = Cleave(unit); if ShouldReturn then return ShouldReturn; end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 