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
Action[ACTION_CONST_DRUID_FERAL] = {
  Regrowth                               = Action.Create({Type = "Spell", ID = 8936 }),
  BloodtalonsBuff                        = Action.Create({Type = "Spell", ID = 145152 }),
  Bloodtalons                            = Action.Create({Type = "Spell", ID = 155672 }),
  WildFleshrending                       = Action.Create({Type = "Spell", ID = 279527 }),
  CatFormBuff                            = Action.Create({Type = "Spell", ID = 768 }),
  CatForm                                = Action.Create({Type = "Spell", ID = 768 }),
  ProwlBuff                              = Action.Create({Type = "Spell", ID = 5215 }),
  Prowl                                  = Action.Create({Type = "Spell", ID = 5215 }),
  BerserkBuff                            = Action.Create({Type = "Spell", ID = 106951 }),
  Berserk                                = Action.Create({Type = "Spell", ID = 106951 }),
  TigersFury                             = Action.Create({Type = "Spell", ID = 5217 }),
  TigersFuryBuff                         = Action.Create({Type = "Spell", ID = 5217 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  FeralFrenzy                            = Action.Create({Type = "Spell", ID = 274837 }),
  Incarnation                            = Action.Create({Type = "Spell", ID = 102543 }),
  IncarnationBuff                        = Action.Create({Type = "Spell", ID = 102543 }),
  Shadowmeld                             = Action.Create({Type = "Spell", ID = 58984 }),
  Rake                                   = Action.Create({Type = "Spell", ID = 1822 }),
  RakeDebuff                             = Action.Create({Type = "Spell", ID = 155722 }),
  SavageRoar                             = Action.Create({Type = "Spell", ID = 52610 }),
  PoolResource                           = Action.Create({Type = "Spell", ID = 9999000010 }),
  SavageRoarBuff                         = Action.Create({Type = "Spell", ID = 52610 }),
  PrimalWrath                            = Action.Create({Type = "Spell", ID = 285381 }),
  RipDebuff                              = Action.Create({Type = "Spell", ID = 1079 }),
  Rip                                    = Action.Create({Type = "Spell", ID = 1079 }),
  Sabertooth                             = Action.Create({Type = "Spell", ID = 202031 }),
  Maim                                   = Action.Create({Type = "Spell", ID = 22570 }),
  IronJawsBuff                           = Action.Create({Type = "Spell", ID = 276026 }),
  FerociousBiteMaxEnergy                 = Action.Create({Type = "Spell", ID = 22568 }),
  FerociousBite                          = Action.Create({Type = "Spell", ID = 22568 }),
  PredatorySwiftnessBuff                 = Action.Create({Type = "Spell", ID = 69369 }),
  LunarInspiration                       = Action.Create({Type = "Spell", ID = 155580 }),
  BrutalSlash                            = Action.Create({Type = "Spell", ID = 202028 }),
  ThrashCat                              = Action.Create({Type = "Spell", ID = 106830 }),
  ThrashCatDebuff                        = Action.Create({Type = "Spell", ID = 106830 }),
  ScentofBlood                           = Action.Create({Type = "Spell", ID = 285564 }),
  ScentofBloodBuff                       = Action.Create({Type = "Spell", ID = 285646 }),
  SwipeCat                               = Action.Create({Type = "Spell", ID = 106785 }),
  MoonfireCat                            = Action.Create({Type = "Spell", ID = 155625 }),
  MoonfireCatDebuff                      = Action.Create({Type = "Spell", ID = 155625 }),
  ClearcastingBuff                       = Action.Create({Type = "Spell", ID = 135700 }),
  Shred                                  = Action.Create({Type = "Spell", ID = 5221 }),
  ShadowmeldBuff                         = Action.Create({Type = "Spell", ID = 58984 })
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
Action:CreateEssencesFor(ACTION_CONST_DRUID_FERAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_FERAL], { __index = Action })


-- Variables
local VarUseThrash = 0;
local VarOpenerDone = 0;

HL:RegisterForEvent(function()
  VarUseThrash = 0
  VarOpenerDone = 0
end, "PLAYER_REGEN_ENABLED")

local EnemyRanges = {8, 5}
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

S.FerociousBiteMaxEnergy.CustomCost = {
  [3] = function ()
          if (Player:BuffP(S.IncarnationBuff) or Player:BuffP(S.BerserkBuff)) then return 25
          else return 50
          end
        end
}

S.Rip:RegisterPMultiplier({S.BloodtalonsBuff, 1.2}, {S.SavageRoar, 1.15}, {S.TigersFury, 1.15})
S.Rake:RegisterPMultiplier(
  S.RakeDebuff,
  {function ()
    return Player:IsStealthed(true, true) and 2 or 1;
  end},
  {S.BloodtalonsBuff, 1.2}, {S.SavageRoar, 1.15}, {S.TigersFury, 1.15}
)

local function EvaluateCyclePrimalWrath95(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit(unit):HasDeBuffs(A.RipDebuff) < 4
end

local function EvaluateCyclePrimalWrath106(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2
end

local function EvaluateCycleRip115(unit)
    return not Unit(unit):HasDeBuffs(A.RipDebuff) or (Unit(unit):HasDeBuffs(A.RipDebuff) <= A.RipDebuff:BaseDuration * 0.3) and (not A.Sabertooth:IsSpellLearned()) or (Unit(unit):HasDeBuffs(A.RipDebuff) <= A.RipDebuff:BaseDuration * 0.8 and Player:PMultiplier(A.Rip) > Unit(unit):PMultiplier(A.Rip)) and Unit(unit):TimeToDie() > 8
end

local function EvaluateCycleRake228(unit)
    return not Unit(unit):HasDeBuffs(A.RakeDebuff) or (not A.Bloodtalons:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff) < A.RakeDebuff:BaseDuration * 0.3) and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleRake257(unit)
    return A.Bloodtalons:IsSpellLearned() and Unit("player"):HasBuffs(A.BloodtalonsBuff) and ((Unit(unit):HasDeBuffs(A.RakeDebuff) <= 7) and Player:PMultiplier(A.Rake) > Unit(unit):PMultiplier(A.Rake) * 0.85) and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleMoonfireCat302(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.MoonfireCatDebuff)
end

local function EvaluateCycleFerociousBite418(unit)
    return Unit(unit):HasDeBuffs(A.RipDebuff) and Unit(unit):HasDeBuffs(A.RipDebuff) < 3 and Unit(unit):TimeToDie() > 10 and (A.Sabertooth:IsSpellLearned())
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
     local Precombat, Cooldowns, Finishers, Generators, Opener
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
       local function Precombat(unit)
        -- flask
    -- food
    -- augmentation
    -- regrowth,if=talent.bloodtalons.enabled
    if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned()) then
        return A.Regrowth:Show(icon)
    end
    -- variable,name=use_thrash,value=0
    if (true) then
      VarUseThrash = 0
    end
    -- variable,name=use_thrash,value=2,if=azerite.wild_fleshrending.enabled
    if (A.WildFleshrending:GetAzeriteRank) then
      VarUseThrash = 2
    end
    -- cat_form
    if A.CatForm:IsReady(unit) and Player:HasBuffsDown(A.CatFormBuff) then
        return A.CatForm:Show(icon)
    end
    -- prowl
    if A.Prowl:IsReady(unit) and Player:HasBuffsDown(A.ProwlBuff) then
        return A.Prowl:Show(icon)
    end
    -- snapshot_stats
    -- potion
    if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofAgility:Show(icon)
    end
    -- berserk
    if A.Berserk:IsReady(unit) and Player:HasBuffsDown(A.BerserkBuff) and A.BurstIsON(unit) then
        return A.Berserk:Show(icon)
    end
    end
    local function Cooldowns(unit)
        -- berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up)
    if A.Berserk:IsReady(unit) and A.BurstIsON(unit) and (Player:EnergyPredicted() >= 30 and (A.TigersFury:GetCooldown() > 5 or Unit("player"):HasBuffs(A.TigersFuryBuff))) then
        return A.Berserk:Show(icon)
    end
    -- tigers_fury,if=energy.deficit>=60
    if A.TigersFury:IsReady(unit) and (Player:EnergyDeficitPredicted() >= 60) then
        return A.TigersFury:Show(icon)
    end
    -- berserking
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
        return A.Berserking:Show(icon)
    end
    -- feral_frenzy,if=combo_points=0
    if A.FeralFrenzy:IsReady(unit) and (Player:ComboPoints() == 0) then
        return A.FeralFrenzy:Show(icon)
    end
    -- incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up)
    if A.Incarnation:IsReady(unit) and A.BurstIsON(unit) and (Player:EnergyPredicted() >= 30 and (A.TigersFury:GetCooldown() > 15 or Unit("player"):HasBuffs(A.TigersFuryBuff))) then
        return A.Incarnation:Show(icon)
    end
    -- potion,name=battle_potion_of_agility,if=target.time_to_die<65|(time_to_die<180&(buff.berserk.up|buff.incarnation.up))
    if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit(unit):TimeToDie() < 65 or (Unit(unit):TimeToDie() < 180 and (Unit("player"):HasBuffs(A.BerserkBuff) or Unit("player"):HasBuffs(A.IncarnationBuff)))) then
      A.BattlePotionofAgility:Show(icon)
    end
    -- shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
    if A.Shadowmeld:IsReady(unit) and A.BurstIsON(unit) and (Player:ComboPoints() < 5 and Player:EnergyPredicted() >= A.Rake:Cost() and Target:PMultiplier(A.Rake) < 2.1 and Unit("player"):HasBuffs(A.TigersFuryBuff) and (Unit("player"):HasBuffs(A.BloodtalonsBuff) or not A.Bloodtalons:IsSpellLearned()) and (not A.Incarnation:IsSpellLearned() or A.Incarnation:GetCooldown() > 18) and not Unit("player"):HasBuffs(A.IncarnationBuff)) then
        return A.Shadowmeld:Show(icon)
    end
    -- use_items
    end
    local function Finishers(unit)
        -- pool_resource,for_next=1
    -- savage_roar,if=buff.savage_roar.down
    if A.SavageRoar:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.SavageRoarBuff))) then
      if A.SavageRoar:IsUsablePPool() then
          return A.SavageRoar:Show(icon)
      else
          return A.PoolResource:Show(icon)
      end
    end
    -- pool_resource,for_next=1
    -- primal_wrath,target_if=spell_targets.primal_wrath>1&dot.rip.remains<4
    if A.PrimalWrath:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.PrimalWrath, 8, EvaluateCyclePrimalWrath95) then
            return A.PrimalWrath:Show(icon) 
        end
    end
    -- pool_resource,for_next=1
    -- primal_wrath,target_if=spell_targets.primal_wrath>=2
    if A.PrimalWrath:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.PrimalWrath, 8, EvaluateCyclePrimalWrath106) then
            return A.PrimalWrath:Show(icon) 
        end
    end
    -- pool_resource,for_next=1
    -- rip,target_if=!ticking|(remains<=duration*0.3)&(!talent.sabertooth.enabled)|(remains<=duration*0.8&persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die>8
    if A.Rip:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Rip, 8, EvaluateCycleRip115) then
            return A.Rip:Show(icon) 
        end
    end
    -- pool_resource,for_next=1
    -- savage_roar,if=buff.savage_roar.remains<12
    if A.SavageRoar:IsReady(unit) and (Unit("player"):HasBuffs(A.SavageRoarBuff) < 12) then
      if A.SavageRoar:IsUsablePPool() then
          return A.SavageRoar:Show(icon)
      else
          return A.PoolResource:Show(icon)
      end
    end
    -- pool_resource,for_next=1
    -- maim,if=buff.iron_jaws.up
    if A.Maim:IsReady(unit) and (Unit("player"):HasBuffs(A.IronJawsBuff)) then
      if A.Maim:IsUsablePPool() then
          return A.Maim:Show(icon)
      else
          return A.PoolResource:Show(icon)
      end
    end
    -- ferocious_bite,max_energy=1
    if A.FerociousBiteMaxEnergy:IsReady(unit) and A.FerociousBiteMaxEnergy:IsUsableP then
        return A.FerociousBiteMaxEnergy:Show(icon)
    end
    end
    local function Generators(unit)
        -- regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
    if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned() and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff) and bool(Unit("player"):HasBuffsDown(A.BloodtalonsBuff)) and Player:ComboPoints() == 4 and Unit(unit):HasDeBuffs(A.RakeDebuff) < 4) then
        return A.Regrowth:Show(icon)
    end
    -- regrowth,if=talent.bloodtalons.enabled&buff.bloodtalons.down&buff.predatory_swiftness.up&talent.lunar_inspiration.enabled&dot.rake.remains<1
    if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.BloodtalonsBuff)) and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff) and A.LunarInspiration:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff) < 1) then
        return A.Regrowth:Show(icon)
    end
    -- brutal_slash,if=spell_targets.brutal_slash>desired_targets
    if A.BrutalSlash:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
        return A.BrutalSlash:Show(icon)
    end
    -- pool_resource,for_next=1
    -- thrash_cat,if=(refreshable)&(spell_targets.thrash_cat>2)
    if A.ThrashCat:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff)) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2)) then
      if A.ThrashCat:IsUsablePPool() then
          return A.ThrashCat:Show(icon)
      else
          return A.PoolResource:Show(icon)
      end
    end
    -- pool_resource,for_next=1
    -- thrash_cat,if=(talent.scent_of_blood.enabled&buff.scent_of_blood.down)&spell_targets.thrash_cat>3
    if A.ThrashCat:IsReady(unit) and ((A.ScentofBlood:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.ScentofBloodBuff))) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
      if A.ThrashCat:IsUsablePPool() then
          return A.ThrashCat:Show(icon)
      else
          return A.PoolResource:Show(icon)
      end
    end
    -- pool_resource,for_next=1
    -- swipe_cat,if=buff.scent_of_blood.up
    if A.SwipeCat:IsReady(unit) and (Unit("player"):HasBuffs(A.ScentofBloodBuff)) then
      if A.SwipeCat:IsUsablePPool() then
          return A.SwipeCat:Show(icon)
      else
          return A.PoolResource:Show(icon)
      end
    end
    -- pool_resource,for_next=1
    -- rake,target_if=!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)&target.time_to_die>4
    if A.Rake:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Rake, 8, EvaluateCycleRake228) then
            return A.Rake:Show(icon) 
        end
    end
    -- pool_resource,for_next=1
    -- rake,target_if=talent.bloodtalons.enabled&buff.bloodtalons.up&((remains<=7)&persistent_multiplier>dot.rake.pmultiplier*0.85)&target.time_to_die>4
    if A.Rake:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Rake, 8, EvaluateCycleRake257) then
            return A.Rake:Show(icon) 
        end
    end
    -- moonfire_cat,if=buff.bloodtalons.up&buff.predatory_swiftness.down&combo_points<5
    if A.MoonfireCat:IsReady(unit) and (Unit("player"):HasBuffs(A.BloodtalonsBuff) and bool(Unit("player"):HasBuffsDown(A.PredatorySwiftnessBuff)) and Player:ComboPoints() < 5) then
        return A.MoonfireCat:Show(icon)
    end
    -- brutal_slash,if=(buff.tigers_fury.up&(raid_event.adds.in>(1+max_charges-charges_fractional)*recharge_time))
    if A.BrutalSlash:IsReady(unit) and ((Unit("player"):HasBuffs(A.TigersFuryBuff) and (10000000000 > (1 + A.BrutalSlash:MaxCharges() - A.BrutalSlash:ChargesFractionalP()) * A.BrutalSlash:RechargeP()))) then
        return A.BrutalSlash:Show(icon)
    end
    -- moonfire_cat,target_if=refreshable
    if A.MoonfireCat:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.MoonfireCat, 40, EvaluateCycleMoonfireCat302) then
            return A.MoonfireCat:Show(icon) 
        end
    end
    -- pool_resource,for_next=1
    -- thrash_cat,if=refreshable&((variable.use_thrash=2&(!buff.incarnation.up|azerite.wild_fleshrending.enabled))|spell_targets.thrash_cat>1)
    if A.ThrashCat:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff) and ((VarUseThrash == 2 and (not Unit("player"):HasBuffs(A.IncarnationBuff) or A.WildFleshrending:GetAzeriteRank)) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
      if A.ThrashCat:IsUsablePPool() then
          return A.ThrashCat:Show(icon)
      else
          return A.PoolResource:Show(icon)
      end
    end
    -- thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react&(!buff.incarnation.up|azerite.wild_fleshrending.enabled)
    if A.ThrashCat:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff) and VarUseThrash == 1 and bool(Unit("player"):HasBuffsStacks(A.ClearcastingBuff)) and (not Unit("player"):HasBuffs(A.IncarnationBuff) or A.WildFleshrending:GetAzeriteRank)) then
        return A.ThrashCat:Show(icon)
    end
    -- pool_resource,for_next=1
    -- swipe_cat,if=spell_targets.swipe_cat>1
    if A.SwipeCat:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
      if A.SwipeCat:IsUsablePPool() then
          return A.SwipeCat:Show(icon)
      else
          return A.PoolResource:Show(icon)
      end
    end
    -- shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react
    if A.Shred:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RakeDebuff) > (A.Shred:Cost() + A.Rake:Cost() - Player:EnergyPredicted()) / Player:EnergyRegen() or bool(Unit("player"):HasBuffsStacks(A.ClearcastingBuff))) then
        return A.Shred:Show(icon)
    end
    end
    local function Opener(unit)
        -- tigers_fury
    if A.TigersFury:IsReady(unit) then
        return A.TigersFury:Show(icon)
    end
    -- rake,if=!ticking|buff.prowl.up
    if A.Rake:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RakeDebuff) or Unit("player"):HasBuffs(A.ProwlBuff)) then
        return A.Rake:Show(icon)
    end
    -- variable,name=opener_done,value=dot.rip.ticking
    if (true) then
      VarOpenerDone = num(Unit(unit):HasDeBuffs(A.RipDebuff))
    end
    -- wait,sec=0.001,if=dot.rip.ticking
    -- moonfire_cat,if=!ticking
    if A.MoonfireCat:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.MoonfireCatDebuff)) then
        return A.MoonfireCat:Show(icon)
    end
    -- rip,if=!ticking
    if A.Rip:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RipDebuff)) then
        return A.Rip:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack,if=!buff.prowl.up&!buff.shadowmeld.up
    -- run_action_list,name=opener,if=variable.opener_done=0
    if (VarOpenerDone == 0) then
      return Opener(unit);
    end
    -- cat_form,if=!buff.cat_form.up
    if A.CatForm:IsReady(unit) and (not Unit("player"):HasBuffs(A.CatFormBuff)) then
        return A.CatForm:Show(icon)
    end
    -- rake,if=buff.prowl.up|buff.shadowmeld.up
    if A.Rake:IsReady(unit) and (Unit("player"):HasBuffs(A.ProwlBuff) or Unit("player"):HasBuffs(A.ShadowmeldBuff)) then
        return A.Rake:Show(icon)
    end
    -- call_action_list,name=cooldowns
    if (true) then
      local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- ferocious_bite,target_if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>10&(talent.sabertooth.enabled)
    if A.FerociousBite:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.FerociousBite, 8, EvaluateCycleFerociousBite418) then
            return A.FerociousBite:Show(icon) 
        end
    end
    -- regrowth,if=combo_points=5&buff.predatory_swiftness.up&talent.bloodtalons.enabled&buff.bloodtalons.down&(!buff.incarnation.up|dot.rip.remains<8)
    if A.Regrowth:IsReady(unit) and (Player:ComboPoints() == 5 and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff) and A.Bloodtalons:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.BloodtalonsBuff)) and (not Unit("player"):HasBuffs(A.IncarnationBuff) or Unit(unit):HasDeBuffs(A.RipDebuff) < 8)) then
        return A.Regrowth:Show(icon)
    end
    -- run_action_list,name=finishers,if=combo_points>4
    if (Player:ComboPoints() > 4) then
      return Finishers(unit);
    end
    -- run_action_list,name=generators
    if (true) then
      return Generators(unit);
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 