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
Action[ACTION_CONST_WARLOCK_DESTRUCTION] = {
  SummonPet                              = Action.Create({Type = "Spell", ID = 688 }),
  GrimoireofSacrifice                    = Action.Create({Type = "Spell", ID = 108503 }),
  SoulFire                               = Action.Create({Type = "Spell", ID = 6353 }),
  Incinerate                             = Action.Create({Type = "Spell", ID = 29722 }),
  RainofFire                             = Action.Create({Type = "Spell", ID = 5740 }),
  Cataclysm                              = Action.Create({Type = "Spell", ID = 152108 }),
  Immolate                               = Action.Create({Type = "Spell", ID = 348 }),
  ChannelDemonfire                       = Action.Create({Type = "Spell", ID = 196447 }),
  ImmolateDebuff                         = Action.Create({Type = "Spell", ID = 157736 }),
  ChaosBolt                              = Action.Create({Type = "Spell", ID = 116858 }),
  ActiveHavocBuff                        = Action.Create({Type = "Spell", ID = 80240 }),
  Havoc                                  = Action.Create({Type = "Spell", ID = 80240 }),
  GrimoireofSupremacy                    = Action.Create({Type = "Spell", ID = 266086 }),
  HavocDebuff                            = Action.Create({Type = "Spell", ID = 80240 }),
  GrimoireofSupremacyBuff                = Action.Create({Type = "Spell", ID = 266091 }),
  Conflagrate                            = Action.Create({Type = "Spell", ID = 17962 }),
  Shadowburn                             = Action.Create({Type = "Spell", ID = 17877 }),
  ShadowburnDebuff                       = Action.Create({Type = "Spell", ID = 17877 }),
  BackdraftBuff                          = Action.Create({Type = "Spell", ID = 117828 }),
  SummonInfernal                         = Action.Create({Type = "Spell", ID = 1122 }),
  DarkSoulInstability                    = Action.Create({Type = "Spell", ID = 113858 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  Flashover                              = Action.Create({Type = "Spell", ID = 267115 }),
  RoaringBlaze                           = Action.Create({Type = "Spell", ID = 205184 }),
  InternalCombustion                     = Action.Create({Type = "Spell", ID = 266134 }),
  Eradication                            = Action.Create({Type = "Spell", ID = 196412 }),
  FireandBrimstone                       = Action.Create({Type = "Spell", ID = 196408 }),
  Inferno                                = Action.Create({Type = "Spell", ID = 270545 }),
  EradicationDebuff                      = Action.Create({Type = "Spell", ID = 196414 }),
  DarkSoulInstabilityBuff                = Action.Create({Type = "Spell", ID = 113858 })
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
Action:CreateEssencesFor(ACTION_CONST_WARLOCK_DESTRUCTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_DESTRUCTION], { __index = Action })



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

local function FutureShard ()
  local Shard = Player:SoulShards()
  if not Player:IsCasting() then
    return Shard
  else
    if Player:IsCasting(S.UnstableAffliction) 
        or Player:IsCasting(S.SeedOfCorruption) then
      return Shard - 1
    elseif Player:IsCasting(S.SummonDoomGuard) 
        or Player:IsCasting(S.SummonDoomGuardSuppremacy) 
        or Player:IsCasting(S.SummonInfernal) 
        or Player:IsCasting(S.SummonInfernalSuppremacy) 
        or Player:IsCasting(S.GrimoireFelhunter) 
        or Player:IsCasting(S.SummonFelhunter) then
      return Shard - 1
    else
      return Shard
    end
  end
end


local function EvaluateCycleHavoc48(unit)
  return not (Unit(unit) == sim.target) and Unit(unit):TimeToDie() > 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 8 + raid_event.invulnerable.up and A.GrimoireofSupremacy:IsSpellLearned() and bool(pet.infernal.active) and Unit(unit):HasDebuffs(A.HavocDebuff) <= 10
end

local function EvaluateCycleChaosBolt73(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and A.GrimoireofSupremacy:IsSpellLearned() and pet.infernal.remains > A.ChaosBolt:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 8 + raid_event.invulnerable.up and ((108 * (MultiUnits:GetByRangeInCombat(40, 5, 10) + raid_event.invulnerable.up) / 3) < (240 * (1 + 0.08 * Unit("player"):HasBuffsStacks(A.GrimoireofSupremacyBuff)) / 2 * num((1 + Unit("player"):HasBuffs(A.ActiveHavocBuff) > A.ChaosBolt:GetSpellCastTime()))))
end

local function EvaluateCycleHavoc106(unit)
  return not (Unit(unit) == sim.target) and Unit(unit):TimeToDie() > 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up
end

local function EvaluateCycleChaosBolt115(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and Unit("player"):HasBuffs(A.ActiveHavocBuff) > A.ChaosBolt:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up
end

local function EvaluateCycleImmolate130(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and Unit(unit):HasDebuffsRefreshable(A.ImmolateDebuff) and Unit(unit):HasDebuffs(A.ImmolateDebuff) <= A.Cataclysm:GetCooldown()
end

local function EvaluateCycleSoulFire155(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
end

local function EvaluateCycleConflagrate164(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
end

local function EvaluateCycleShadowburn173(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and ((A.Shadowburn:ChargesP() == 2 or not bool(Unit("player"):HasBuffs(A.BackdraftBuff)) or Unit("player"):HasBuffs(A.BackdraftBuff) > Unit("player"):HasBuffsStacks(A.BackdraftBuff) * A.Incinerate:GetSpellCastTime()))
end

local function EvaluateCycleIncinerate198(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
end

local function EvaluateCycleHavoc248(unit)
  return not (Unit(unit) == sim.target) and Unit(unit):TimeToDie() > 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up and A.GrimoireofSupremacy:IsSpellLearned() and bool(pet.infernal.active) and Unit(unit):HasDebuffs(A.HavocDebuff) <= 10
end

local function EvaluateCycleChaosBolt273(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and A.GrimoireofSupremacy:IsSpellLearned() and pet.infernal.remains > A.ChaosBolt:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up and ((108 * (MultiUnits:GetByRangeInCombat(40, 5, 10) + raid_event.invulnerable.up) / 3) < (240 * (1 + 0.08 * Unit("player"):HasBuffsStacks(A.GrimoireofSupremacyBuff)) / 2 * num((1 + Unit("player"):HasBuffs(A.ActiveHavocBuff) > A.ChaosBolt:GetSpellCastTime()))))
end

local function EvaluateCycleHavoc306(unit)
  return not (Unit(unit) == sim.target) and Unit(unit):TimeToDie() > 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up
end

local function EvaluateCycleChaosBolt315(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and Unit("player"):HasBuffs(A.ActiveHavocBuff) > A.ChaosBolt:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up
end

local function EvaluateCycleImmolate330(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and Unit(unit):HasDebuffsRefreshable(A.ImmolateDebuff) and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 8 + raid_event.invulnerable.up
end

local function EvaluateCycleSoulFire347(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 3 + raid_event.invulnerable.up
end

local function EvaluateCycleConflagrate356(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and (A.Flashover:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.BackdraftBuff) <= 2 or MultiUnits:GetByRangeInCombat(40, 5, 10) <= 7 + raid_event.invulnerable.up or A.RoaringBlaze:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 9 + raid_event.invulnerable.up)
end

local function EvaluateCycleIncinerate371(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
end

local function EvaluateCycleHavoc406(unit)
  return not (Unit(unit) == sim.target) and Unit(unit):TimeToDie() > 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up + num(A.InternalCombustion:IsSpellLearned()) and A.GrimoireofSupremacy:IsSpellLearned() and bool(pet.infernal.active) and Unit(unit):HasDebuffs(A.HavocDebuff) <= 10
end

local function EvaluateCycleChaosBolt435(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and A.GrimoireofSupremacy:IsSpellLearned() and pet.infernal.remains > A.ChaosBolt:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up + num(A.InternalCombustion:IsSpellLearned()) and ((108 * (MultiUnits:GetByRangeInCombat(40, 5, 10) + raid_event.invulnerable.up) / (3 - 0.16 * (MultiUnits:GetByRangeInCombat(40, 5, 10) + raid_event.invulnerable.up))) < (240 * (1 + 0.08 * Unit("player"):HasBuffsStacks(A.GrimoireofSupremacyBuff)) / 2 * num((1 + Unit("player"):HasBuffs(A.ActiveHavocBuff) > A.ChaosBolt:GetSpellCastTime()))))
end

local function EvaluateCycleHavoc464(unit)
  return not (Unit(unit) == sim.target) and Unit(unit):TimeToDie() > 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 3 + raid_event.invulnerable.up and (A.Eradication:IsSpellLearned() or A.InternalCombustion:IsSpellLearned())
end

local function EvaluateCycleChaosBolt481(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and Unit("player"):HasBuffs(A.ActiveHavocBuff) > A.ChaosBolt:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 3 + raid_event.invulnerable.up and (A.Eradication:IsSpellLearned() or A.InternalCombustion:IsSpellLearned())
end

local function EvaluateCycleImmolate500(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and Unit(unit):HasDebuffsRefreshable(A.ImmolateDebuff)
end

local function EvaluateCycleSoulFire517(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
end

local function EvaluateCycleConflagrate526(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
end

local function EvaluateCycleShadowburn535(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and ((A.Shadowburn:ChargesP() == 2 or not bool(Unit("player"):HasBuffs(A.BackdraftBuff)) or Unit("player"):HasBuffs(A.BackdraftBuff) > Unit("player"):HasBuffsStacks(A.BackdraftBuff) * A.Incinerate:GetSpellCastTime()))
end

local function EvaluateCycleIncinerate560(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
end

local function EvaluateCycleImmolate584(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and (Unit(unit):HasDebuffsRefreshable(A.ImmolateDebuff) or A.InternalCombustion:IsSpellLearned() and A.ChaosBolt:IsSpellInFlight() and Unit(unit):HasDebuffs(A.ImmolateDebuff) - A.ChaosBolt:TravelTime() - 5 < A.ImmolateDebuff:BaseDuration * 0.3)
end

local function EvaluateCycleHavoc627(unit)
  return not (Unit(unit) == sim.target) and Unit(unit):TimeToDie() > 10 and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 + raid_event.invulnerable.up
end

local function EvaluateCycleSoulFire652(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
end

local function EvaluateCycleChaosBolt661(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and A.ChaosBolt:GetSpellCastTime() + A.ChaosBolt:TravelTime() < Unit(unit):TimeToDie() and (bool(trinket.proc.intellect.react) and trinket.proc.intellect.remains > A.ChaosBolt:GetSpellCastTime() or bool(trinket.proc.mastery.react) and trinket.proc.mastery.remains > A.ChaosBolt:GetSpellCastTime() or bool(trinket.proc.versatility.react) and trinket.proc.versatility.remains > A.ChaosBolt:GetSpellCastTime() or bool(trinket.proc.crit.react) and trinket.proc.crit.remains > A.ChaosBolt:GetSpellCastTime() or bool(trinket.proc.spell_power.react) and trinket.proc.spell_power.remains > A.ChaosBolt:GetSpellCastTime())
end

local function EvaluateCycleChaosBolt698(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and A.ChaosBolt:GetSpellCastTime() + A.ChaosBolt:TravelTime() < Unit(unit):TimeToDie() and (bool(trinket.stacking_proc.intellect.react) and trinket.stacking_proc.intellect.remains > A.ChaosBolt:GetSpellCastTime() or bool(trinket.stacking_proc.mastery.react) and trinket.stacking_proc.mastery.remains > A.ChaosBolt:GetSpellCastTime() or bool(trinket.stacking_proc.versatility.react) and trinket.stacking_proc.versatility.remains > A.ChaosBolt:GetSpellCastTime() or bool(trinket.stacking_proc.crit.react) and trinket.stacking_proc.crit.remains > A.ChaosBolt:GetSpellCastTime() or bool(trinket.stacking_proc.spell_power.react) and trinket.stacking_proc.spell_power.remains > A.ChaosBolt:GetSpellCastTime())
end

local function EvaluateCycleChaosBolt735(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and A.ChaosBolt:GetSpellCastTime() + A.ChaosBolt:TravelTime() < Unit(unit):TimeToDie() and (A.SummonInfernal:GetCooldown() >= 20 or not A.GrimoireofSupremacy:IsSpellLearned()) and (A.DarkSoulInstability:GetCooldown() >= 20 or not A.DarkSoulInstability:IsSpellLearned()) and (A.Eradication:IsSpellLearned() and Unit(unit):HasDebuffs(A.EradicationDebuff) <= A.ChaosBolt:GetSpellCastTime() or bool(Unit("player"):HasBuffs(A.BackdraftBuff)) or A.InternalCombustion:IsSpellLearned())
end

local function EvaluateCycleChaosBolt772(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and A.ChaosBolt:GetSpellCastTime() + A.ChaosBolt:TravelTime() < Unit(unit):TimeToDie() and (Player:SoulShardsP >= 4 or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff) > A.ChaosBolt:GetSpellCastTime() or bool(pet.infernal.active) or Unit("player"):HasBuffs(A.ActiveHavocBuff) > A.ChaosBolt:GetSpellCastTime())
end

local function EvaluateCycleConflagrate801(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and ((A.Flashover:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.BackdraftBuff) <= 2) or (not A.Flashover:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.BackdraftBuff) < 2))
end

local function EvaluateCycleShadowburn818(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff)) and ((A.Shadowburn:ChargesP() == 2 or not bool(Unit("player"):HasBuffs(A.BackdraftBuff)) or Unit("player"):HasBuffs(A.BackdraftBuff) > Unit("player"):HasBuffsStacks(A.BackdraftBuff) * A.Incinerate:GetSpellCastTime()))
end

local function EvaluateCycleIncinerate843(unit)
  return not bool(Unit(unit):HasDebuffs(A.HavocDebuff))
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
     local Precombat, Cata, Cds, Fnb, Inf
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
       local function Precombat(unit)
        -- flask
    -- food
    -- augmentation
    -- summon_pet
    if A.SummonPet:IsReady(unit) then
        return A.SummonPet:Show(icon)
    end
    -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
    if A.GrimoireofSacrifice:IsReady(unit) and (A.GrimoireofSacrifice:IsSpellLearned()) then
        return A.GrimoireofSacrifice:Show(icon)
    end
    -- snapshot_stats
    -- potion
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- soul_fire
    if A.SoulFire:IsReady(unit) then
        return A.SoulFire:Show(icon)
    end
    -- incinerate,if=!talent.soul_fire.enabled
    if A.Incinerate:IsReady(unit) and (not A.SoulFire:IsSpellLearned()) then
        return A.Incinerate:Show(icon)
    end
    end
    local function Cata(unit)
        -- call_action_list,name=cds
    if A.BurstIsON(unit) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- rain_of_fire,if=soul_shard>=4.5
    if A.RainofFire:IsReady(unit) and (Player:SoulShardsP >= 4.5) then
        return A.RainofFire:Show(icon)
    end
    -- cataclysm
    if A.Cataclysm:IsReady(unit) then
        return A.Cataclysm:Show(icon)
    end
    -- immolate,if=talent.channel_demonfire.enabled&!remains&cooldown.channel_demonfire.remains<=action.chaos_bolt.execute_time
    if A.Immolate:IsReady(unit) and (A.ChannelDemonfire:IsSpellLearned() and not bool(Unit(unit):HasDebuffs(A.ImmolateDebuff)) and A.ChannelDemonfire:GetCooldown() <= A.ChaosBolt:GetSpellCastTime()) then
        return A.Immolate:Show(icon)
    end
    -- channel_demonfire,if=!buff.active_havoc.remains
    if A.ChannelDemonfire:IsReady(unit) and (not bool(Unit("player"):HasBuffs(A.ActiveHavocBuff))) then
        return A.ChannelDemonfire:Show(icon)
    end
    -- havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=8+raid_event.invulnerable.up&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc48) then
            return A.Havoc:Show(icon) 
        end
    end
    -- havoc,if=spell_targets.rain_of_fire<=8+raid_event.invulnerable.up&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    if A.Havoc:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 8 + raid_event.invulnerable.up and A.GrimoireofSupremacy:IsSpellLearned() and bool(pet.infernal.active) and Unit(unit):HasDebuffs(A.HavocDebuff) <= 10) then
        return A.Havoc:Show(icon)
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&talent.grimoire_of_supremacy.enabled&pet.infernal.remains>execute_time&active_enemies<=8+raid_event.invulnerable.up&((108*(spell_targets.rain_of_fire+raid_event.invulnerable.up)%3)<(240*(1+0.08*buff.grimoire_of_supremacy.stack)%2*(1+buff.active_havoc.remains>execute_time)))
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt73) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=4+raid_event.invulnerable.up
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc106) then
            return A.Havoc:Show(icon) 
        end
    end
    -- havoc,if=spell_targets.rain_of_fire<=4+raid_event.invulnerable.up
    if A.Havoc:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up) then
        return A.Havoc:Show(icon)
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&buff.active_havoc.remains>execute_time&spell_targets.rain_of_fire<=4+raid_event.invulnerable.up
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt115) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- immolate,cycle_targets=1,if=!debuff.havoc.remains&refreshable&remains<=cooldown.cataclysm.remains
    if A.Immolate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Immolate, 40, EvaluateCycleImmolate130) then
            return A.Immolate:Show(icon) 
        end
    end
    -- rain_of_fire
    if A.RainofFire:IsReady(unit) then
        return A.RainofFire:Show(icon)
    end
    -- soul_fire,cycle_targets=1,if=!debuff.havoc.remains
    if A.SoulFire:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.SoulFire, 40, EvaluateCycleSoulFire155) then
            return A.SoulFire:Show(icon) 
        end
    end
    -- conflagrate,cycle_targets=1,if=!debuff.havoc.remains
    if A.Conflagrate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Conflagrate, 40, EvaluateCycleConflagrate164) then
            return A.Conflagrate:Show(icon) 
        end
    end
    -- shadowburn,cycle_targets=1,if=!debuff.havoc.remains&((charges=2|!buff.backdraft.remains|buff.backdraft.remains>buff.backdraft.stack*action.incinerate.execute_time))
    if A.Shadowburn:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Shadowburn, 40, EvaluateCycleShadowburn173) then
            return A.Shadowburn:Show(icon) 
        end
    end
    -- incinerate,cycle_targets=1,if=!debuff.havoc.remains
    if A.Incinerate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Incinerate, 40, EvaluateCycleIncinerate198) then
            return A.Incinerate:Show(icon) 
        end
    end
    end
    local function Cds(unit)
        -- summon_infernal,if=target.time_to_die>=210|!cooldown.dark_soul_instability.remains|target.time_to_die<=30+gcd|!talent.dark_soul_instability.enabled
    if A.SummonInfernal:IsReady(unit) and (Unit(unit):TimeToDie() >= 210 or not bool(A.DarkSoulInstability:GetCooldown()) or Unit(unit):TimeToDie() <= 30 + A.GetGCD() or not A.DarkSoulInstability:IsSpellLearned()) then
        return A.SummonInfernal:Show(icon)
    end
    -- dark_soul_instability,if=target.time_to_die>=140|pet.infernal.active|target.time_to_die<=20+gcd
    if A.DarkSoulInstability:IsReady(unit) and (Unit(unit):TimeToDie() >= 140 or bool(pet.infernal.active) or Unit(unit):TimeToDie() <= 20 + A.GetGCD()) then
        return A.DarkSoulInstability:Show(icon)
    end
    -- potion,if=pet.infernal.active|target.time_to_die<65
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (bool(pet.infernal.active) or Unit(unit):TimeToDie() < 65) then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- berserking
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
        return A.Berserking:Show(icon)
    end
    -- blood_fury
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) then
        return A.BloodFury:Show(icon)
    end
    -- fireblood
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) then
        return A.Fireblood:Show(icon)
    end
    -- use_items
    end
    local function Fnb(unit)
        -- call_action_list,name=cds
    if A.BurstIsON(unit) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- rain_of_fire,if=soul_shard>=4.5
    if A.RainofFire:IsReady(unit) and (Player:SoulShardsP >= 4.5) then
        return A.RainofFire:Show(icon)
    end
    -- immolate,if=talent.channel_demonfire.enabled&!remains&cooldown.channel_demonfire.remains<=action.chaos_bolt.execute_time
    if A.Immolate:IsReady(unit) and (A.ChannelDemonfire:IsSpellLearned() and not bool(Unit(unit):HasDebuffs(A.ImmolateDebuff)) and A.ChannelDemonfire:GetCooldown() <= A.ChaosBolt:GetSpellCastTime()) then
        return A.Immolate:Show(icon)
    end
    -- channel_demonfire,if=!buff.active_havoc.remains
    if A.ChannelDemonfire:IsReady(unit) and (not bool(Unit("player"):HasBuffs(A.ActiveHavocBuff))) then
        return A.ChannelDemonfire:Show(icon)
    end
    -- havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=4+raid_event.invulnerable.up&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc248) then
            return A.Havoc:Show(icon) 
        end
    end
    -- havoc,if=spell_targets.rain_of_fire<=4+raid_event.invulnerable.up&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    if A.Havoc:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up and A.GrimoireofSupremacy:IsSpellLearned() and bool(pet.infernal.active) and Unit(unit):HasDebuffs(A.HavocDebuff) <= 10) then
        return A.Havoc:Show(icon)
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&talent.grimoire_of_supremacy.enabled&pet.infernal.remains>execute_time&active_enemies<=4+raid_event.invulnerable.up&((108*(spell_targets.rain_of_fire+raid_event.invulnerable.up)%3)<(240*(1+0.08*buff.grimoire_of_supremacy.stack)%2*(1+buff.active_havoc.remains>execute_time)))
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt273) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=4+raid_event.invulnerable.up
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc306) then
            return A.Havoc:Show(icon) 
        end
    end
    -- havoc,if=spell_targets.rain_of_fire<=4+raid_event.invulnerable.up
    if A.Havoc:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up) then
        return A.Havoc:Show(icon)
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&buff.active_havoc.remains>execute_time&spell_targets.rain_of_fire<=4+raid_event.invulnerable.up
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt315) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- immolate,cycle_targets=1,if=!debuff.havoc.remains&refreshable&spell_targets.incinerate<=8+raid_event.invulnerable.up
    if A.Immolate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Immolate, 40, EvaluateCycleImmolate330) then
            return A.Immolate:Show(icon) 
        end
    end
    -- rain_of_fire
    if A.RainofFire:IsReady(unit) then
        return A.RainofFire:Show(icon)
    end
    -- soul_fire,cycle_targets=1,if=!debuff.havoc.remains&spell_targets.incinerate<=3+raid_event.invulnerable.up
    if A.SoulFire:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.SoulFire, 40, EvaluateCycleSoulFire347) then
            return A.SoulFire:Show(icon) 
        end
    end
    -- conflagrate,cycle_targets=1,if=!debuff.havoc.remains&(talent.flashover.enabled&buff.backdraft.stack<=2|spell_targets.incinerate<=7+raid_event.invulnerable.up|talent.roaring_blaze.enabled&spell_targets.incinerate<=9+raid_event.invulnerable.up)
    if A.Conflagrate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Conflagrate, 40, EvaluateCycleConflagrate356) then
            return A.Conflagrate:Show(icon) 
        end
    end
    -- incinerate,cycle_targets=1,if=!debuff.havoc.remains
    if A.Incinerate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Incinerate, 40, EvaluateCycleIncinerate371) then
            return A.Incinerate:Show(icon) 
        end
    end
    end
    local function Inf(unit)
        -- call_action_list,name=cds
    if A.BurstIsON(unit) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- rain_of_fire,if=soul_shard>=4.5
    if A.RainofFire:IsReady(unit) and (Player:SoulShardsP >= 4.5) then
        return A.RainofFire:Show(icon)
    end
    -- cataclysm
    if A.Cataclysm:IsReady(unit) then
        return A.Cataclysm:Show(icon)
    end
    -- immolate,if=talent.channel_demonfire.enabled&!remains&cooldown.channel_demonfire.remains<=action.chaos_bolt.execute_time
    if A.Immolate:IsReady(unit) and (A.ChannelDemonfire:IsSpellLearned() and not bool(Unit(unit):HasDebuffs(A.ImmolateDebuff)) and A.ChannelDemonfire:GetCooldown() <= A.ChaosBolt:GetSpellCastTime()) then
        return A.Immolate:Show(icon)
    end
    -- channel_demonfire,if=!buff.active_havoc.remains
    if A.ChannelDemonfire:IsReady(unit) and (not bool(Unit("player"):HasBuffs(A.ActiveHavocBuff))) then
        return A.ChannelDemonfire:Show(icon)
    end
    -- havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=4+raid_event.invulnerable.up+talent.internal_combustion.enabled&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc406) then
            return A.Havoc:Show(icon) 
        end
    end
    -- havoc,if=spell_targets.rain_of_fire<=4+raid_event.invulnerable.up+talent.internal_combustion.enabled&talent.grimoire_of_supremacy.enabled&pet.infernal.active&pet.infernal.remains<=10
    if A.Havoc:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 4 + raid_event.invulnerable.up + num(A.InternalCombustion:IsSpellLearned()) and A.GrimoireofSupremacy:IsSpellLearned() and bool(pet.infernal.active) and Unit(unit):HasDebuffs(A.HavocDebuff) <= 10) then
        return A.Havoc:Show(icon)
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&talent.grimoire_of_supremacy.enabled&pet.infernal.remains>execute_time&spell_targets.rain_of_fire<=4+raid_event.invulnerable.up+talent.internal_combustion.enabled&((108*(spell_targets.rain_of_fire+raid_event.invulnerable.up)%(3-0.16*(spell_targets.rain_of_fire+raid_event.invulnerable.up)))<(240*(1+0.08*buff.grimoire_of_supremacy.stack)%2*(1+buff.active_havoc.remains>execute_time)))
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt435) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&spell_targets.rain_of_fire<=3+raid_event.invulnerable.up&(talent.eradication.enabled|talent.internal_combustion.enabled)
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc464) then
            return A.Havoc:Show(icon) 
        end
    end
    -- havoc,if=spell_targets.rain_of_fire<=3+raid_event.invulnerable.up&(talent.eradication.enabled|talent.internal_combustion.enabled)
    if A.Havoc:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 3 + raid_event.invulnerable.up and (A.Eradication:IsSpellLearned() or A.InternalCombustion:IsSpellLearned())) then
        return A.Havoc:Show(icon)
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&buff.active_havoc.remains>execute_time&spell_targets.rain_of_fire<=3+raid_event.invulnerable.up&(talent.eradication.enabled|talent.internal_combustion.enabled)
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt481) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- immolate,cycle_targets=1,if=!debuff.havoc.remains&refreshable
    if A.Immolate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Immolate, 40, EvaluateCycleImmolate500) then
            return A.Immolate:Show(icon) 
        end
    end
    -- rain_of_fire
    if A.RainofFire:IsReady(unit) then
        return A.RainofFire:Show(icon)
    end
    -- soul_fire,cycle_targets=1,if=!debuff.havoc.remains
    if A.SoulFire:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.SoulFire, 40, EvaluateCycleSoulFire517) then
            return A.SoulFire:Show(icon) 
        end
    end
    -- conflagrate,cycle_targets=1,if=!debuff.havoc.remains
    if A.Conflagrate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Conflagrate, 40, EvaluateCycleConflagrate526) then
            return A.Conflagrate:Show(icon) 
        end
    end
    -- shadowburn,cycle_targets=1,if=!debuff.havoc.remains&((charges=2|!buff.backdraft.remains|buff.backdraft.remains>buff.backdraft.stack*action.incinerate.execute_time))
    if A.Shadowburn:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Shadowburn, 40, EvaluateCycleShadowburn535) then
            return A.Shadowburn:Show(icon) 
        end
    end
    -- incinerate,cycle_targets=1,if=!debuff.havoc.remains
    if A.Incinerate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Incinerate, 40, EvaluateCycleIncinerate560) then
            return A.Incinerate:Show(icon) 
        end
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- run_action_list,name=cata,if=spell_targets.infernal_awakening>=3+raid_event.invulnerable.up&talent.cataclysm.enabled
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + raid_event.invulnerable.up and A.Cataclysm:IsSpellLearned()) then
      return Cata(unit);
    end
    -- run_action_list,name=fnb,if=spell_targets.infernal_awakening>=3+raid_event.invulnerable.up&talent.fire_and_brimstone.enabled
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + raid_event.invulnerable.up and A.FireandBrimstone:IsSpellLearned()) then
      return Fnb(unit);
    end
    -- run_action_list,name=inf,if=spell_targets.infernal_awakening>=3+raid_event.invulnerable.up&talent.inferno.enabled
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 + raid_event.invulnerable.up and A.Inferno:IsSpellLearned()) then
      return Inf(unit);
    end
    -- cataclysm
    if A.Cataclysm:IsReady(unit) then
        return A.Cataclysm:Show(icon)
    end
    -- immolate,cycle_targets=1,if=!debuff.havoc.remains&(refreshable|talent.internal_combustion.enabled&action.chaos_bolt.in_flight&remains-action.chaos_bolt.travel_time-5<duration*0.3)
    if A.Immolate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Immolate, 40, EvaluateCycleImmolate584) then
            return A.Immolate:Show(icon) 
        end
    end
    -- call_action_list,name=cds
    if A.BurstIsON(unit) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- channel_demonfire,if=!buff.active_havoc.remains
    if A.ChannelDemonfire:IsReady(unit) and (not bool(Unit("player"):HasBuffs(A.ActiveHavocBuff))) then
        return A.ChannelDemonfire:Show(icon)
    end
    -- havoc,cycle_targets=1,if=!(target=sim.target)&target.time_to_die>10&active_enemies>1+raid_event.invulnerable.up
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc627) then
            return A.Havoc:Show(icon) 
        end
    end
    -- havoc,if=active_enemies>1+raid_event.invulnerable.up
    if A.Havoc:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 + raid_event.invulnerable.up) then
        return A.Havoc:Show(icon)
    end
    -- soul_fire,cycle_targets=1,if=!debuff.havoc.remains
    if A.SoulFire:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.SoulFire, 40, EvaluateCycleSoulFire652) then
            return A.SoulFire:Show(icon) 
        end
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&execute_time+travel_time<target.time_to_die&(trinket.proc.intellect.react&trinket.proc.intellect.remains>cast_time|trinket.proc.mastery.react&trinket.proc.mastery.remains>cast_time|trinket.proc.versatility.react&trinket.proc.versatility.remains>cast_time|trinket.proc.crit.react&trinket.proc.crit.remains>cast_time|trinket.proc.spell_power.react&trinket.proc.spell_power.remains>cast_time)
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt661) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&execute_time+travel_time<target.time_to_die&(trinket.stacking_proc.intellect.react&trinket.stacking_proc.intellect.remains>cast_time|trinket.stacking_proc.mastery.react&trinket.stacking_proc.mastery.remains>cast_time|trinket.stacking_proc.versatility.react&trinket.stacking_proc.versatility.remains>cast_time|trinket.stacking_proc.crit.react&trinket.stacking_proc.crit.remains>cast_time|trinket.stacking_proc.spell_power.react&trinket.stacking_proc.spell_power.remains>cast_time)
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt698) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&execute_time+travel_time<target.time_to_die&(cooldown.summon_infernal.remains>=20|!talent.grimoire_of_supremacy.enabled)&(cooldown.dark_soul_instability.remains>=20|!talent.dark_soul_instability.enabled)&(talent.eradication.enabled&debuff.eradication.remains<=cast_time|buff.backdraft.remains|talent.internal_combustion.enabled)
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt735) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- chaos_bolt,cycle_targets=1,if=!debuff.havoc.remains&execute_time+travel_time<target.time_to_die&(soul_shard>=4|buff.dark_soul_instability.remains>cast_time|pet.infernal.active|buff.active_havoc.remains>cast_time)
    if A.ChaosBolt:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ChaosBolt, 40, EvaluateCycleChaosBolt772) then
            return A.ChaosBolt:Show(icon) 
        end
    end
    -- conflagrate,cycle_targets=1,if=!debuff.havoc.remains&((talent.flashover.enabled&buff.backdraft.stack<=2)|(!talent.flashover.enabled&buff.backdraft.stack<2))
    if A.Conflagrate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Conflagrate, 40, EvaluateCycleConflagrate801) then
            return A.Conflagrate:Show(icon) 
        end
    end
    -- shadowburn,cycle_targets=1,if=!debuff.havoc.remains&((charges=2|!buff.backdraft.remains|buff.backdraft.remains>buff.backdraft.stack*action.incinerate.execute_time))
    if A.Shadowburn:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Shadowburn, 40, EvaluateCycleShadowburn818) then
            return A.Shadowburn:Show(icon) 
        end
    end
    -- incinerate,cycle_targets=1,if=!debuff.havoc.remains
    if A.Incinerate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Incinerate, 40, EvaluateCycleIncinerate843) then
            return A.Incinerate:Show(icon) 
        end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 