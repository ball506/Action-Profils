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
  CrashingChaosBuff                      = Action.Create({Type = "Spell", ID =  }),
  GrimoireofSupremacy                    = Action.Create({Type = "Spell", ID = 266086 }),
  Havoc                                  = Action.Create({Type = "Spell", ID = 80240 }),
  RainofFireDebuff                       = Action.Create({Type = "Spell", ID = 5740 }),
  ChannelDemonfire                       = Action.Create({Type = "Spell", ID = 196447 }),
  ImmolateDebuff                         = Action.Create({Type = "Spell", ID = 157736 }),
  Immolate                               = Action.Create({Type = "Spell", ID = 348 }),
  Cataclysm                              = Action.Create({Type = "Spell", ID = 152108 }),
  HavocDebuff                            = Action.Create({Type = "Spell", ID = 80240 }),
  ChaosBolt                              = Action.Create({Type = "Spell", ID = 116858 }),
  Inferno                                = Action.Create({Type = "Spell", ID = 270545 }),
  FocusedAzeriteBeam                     = Action.Create({Type = "Spell", ID =  }),
  PurifyingBlast                         = Action.Create({Type = "Spell", ID =  }),
  FireandBrimstone                       = Action.Create({Type = "Spell", ID = 196408 }),
  BackdraftBuff                          = Action.Create({Type = "Spell", ID = 117828 }),
  Conflagrate                            = Action.Create({Type = "Spell", ID = 17962 }),
  Shadowburn                             = Action.Create({Type = "Spell", ID = 17877 }),
  ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
  ConcentratedFlameBurnDebuff            = Action.Create({Type = "Spell", ID =  }),
  SummonInfernal                         = Action.Create({Type = "Spell", ID = 1122 }),
  GuardianofAzeroth                      = Action.Create({Type = "Spell", ID =  }),
  DarkSoulInstability                    = Action.Create({Type = "Spell", ID = 113858 }),
  DarkSoulInstabilityBuff                = Action.Create({Type = "Spell", ID = 113858 }),
  MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
  BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
  WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
  RippleInSpace                          = Action.Create({Type = "Spell", ID =  }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  GrimoireofSupremacyBuff                = Action.Create({Type = "Spell", ID = 266091 }),
  InternalCombustion                     = Action.Create({Type = "Spell", ID = 266134 }),
  ShadowburnDebuff                       = Action.Create({Type = "Spell", ID = 17877 }),
  TheUnboundForce                        = Action.Create({Type = "Spell", ID =  }),
  RecklessForceBuff                      = Action.Create({Type = "Spell", ID =  }),
  Flashover                              = Action.Create({Type = "Spell", ID = 267115 }),
  CrashingChaos                          = Action.Create({Type = "Spell", ID =  }),
  Eradication                            = Action.Create({Type = "Spell", ID = 196412 }),
  EradicationDebuff                      = Action.Create({Type = "Spell", ID = 196414 })
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


-- Variables
local VarPoolSoulShards = 0;

HL:RegisterForEvent(function()
  VarPoolSoulShards = 0
end, "PLAYER_REGEN_ENABLED")

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


local function EvaluateCycleImmolate46(unit)
  return Unit(unit):HasDeBuffs(A.ImmolateDebuff) < 5 and (not A.Cataclysm:IsSpellLearned() or A.Cataclysm:GetCooldown() > Unit(unit):HasDeBuffs(A.ImmolateDebuff))
end

local function EvaluateCycleHavoc71(unit)
  return not (Unit(unit) == self.target) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4
end

local function EvaluateCycleHavoc106(unit)
  return not (Unit(unit) == self.target) and (not A.GrimoireofSupremacy:IsSpellLearned() or not A.Inferno:IsSpellLearned() or A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.HavocDebuff) <= 10)
end

local function EvaluateCycleImmolate501(unit)
  return Unit(unit):HasDeBuffsRefreshable(A.ImmolateDebuff) and (not A.Cataclysm:IsSpellLearned() or A.Cataclysm:GetCooldown() > Unit(unit):HasDeBuffs(A.ImmolateDebuff))
end

local function EvaluateCycleHavoc566(unit)
  return not (Unit(unit) == self.target) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff) > A.ImmolateDebuff:BaseDuration * 0.5 or not A.InternalCombustion:IsSpellLearned()) and (not A.SummonInfernal:HasCooldownUps or not A.GrimoireofSupremacy:IsSpellLearned() or A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.HavocDebuff) <= 10)
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
     local Precombat, Aoe, Cds, GosupInfernal, Havoc
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
    local function Aoe(unit)
        -- rain_of_fire,if=pet.infernal.active&(buff.crashing_chaos.down|!talent.grimoire_of_supremacy.enabled)&(!cooldown.havoc.ready|active_enemies>3)
    if A.RainofFire:IsReady(unit) and (bool(pet.infernal.active) and (bool(Unit("player"):HasBuffsDown(A.CrashingChaosBuff)) or not A.GrimoireofSupremacy:IsSpellLearned()) and (not A.Havoc:HasCooldownUps or MultiUnits:GetByRangeInCombat(40, 5, 10) > 3)) then
        return A.RainofFire:Show(icon)
    end
    -- channel_demonfire,if=dot.immolate.remains>cast_time
    if A.ChannelDemonfire:IsReady(unit) and (Target:HasDeBuffs(A.ImmolateDebuff) > A.ChannelDemonfire:GetSpellCastTime()) then
        return A.ChannelDemonfire:Show(icon)
    end
    -- immolate,cycle_targets=1,if=remains<5&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
    if A.Immolate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Immolate, 40, EvaluateCycleImmolate46) then
            return A.Immolate:Show(icon) 
        end
    end
    -- call_action_list,name=cds
    if A.BurstIsON(unit) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- havoc,cycle_targets=1,if=!(target=self.target)&active_enemies<4
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc71) then
            return A.Havoc:Show(icon) 
        end
    end
    -- chaos_bolt,if=talent.grimoire_of_supremacy.enabled&pet.infernal.active&(havoc_active|talent.cataclysm.enabled|talent.inferno.enabled&active_enemies<4)
    if A.ChaosBolt:IsReady(unit) and (A.GrimoireofSupremacy:IsSpellLearned() and bool(pet.infernal.active) and (bool(havoc_active) or A.Cataclysm:IsSpellLearned() or A.Inferno:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 4)) then
        return A.ChaosBolt:Show(icon)
    end
    -- rain_of_fire
    if A.RainofFire:IsReady(unit) then
        return A.RainofFire:Show(icon)
    end
    -- focused_azerite_beam
    if A.FocusedAzeriteBeam:IsReady(unit) then
        return A.FocusedAzeriteBeam:Show(icon)
    end
    -- purifying_blast
    if A.PurifyingBlast:IsReady(unit) then
        return A.PurifyingBlast:Show(icon)
    end
    -- havoc,cycle_targets=1,if=!(target=self.target)&(!talent.grimoire_of_supremacy.enabled|!talent.inferno.enabled|talent.grimoire_of_supremacy.enabled&pet.infernal.remains<=10)
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc106) then
            return A.Havoc:Show(icon) 
        end
    end
    -- incinerate,if=talent.fire_and_brimstone.enabled&buff.backdraft.up&soul_shard<5-0.2*active_enemies
    if A.Incinerate:IsReady(unit) and (A.FireandBrimstone:IsSpellLearned() and Unit("player"):HasBuffs(A.BackdraftBuff) and Player:SoulShardsP < 5 - 0.2 * MultiUnits:GetByRangeInCombat(40, 5, 10)) then
        return A.Incinerate:Show(icon)
    end
    -- soul_fire
    if A.SoulFire:IsReady(unit) then
        return A.SoulFire:Show(icon)
    end
    -- conflagrate,if=buff.backdraft.down
    if A.Conflagrate:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BackdraftBuff))) then
        return A.Conflagrate:Show(icon)
    end
    -- shadowburn,if=!talent.fire_and_brimstone.enabled
    if A.Shadowburn:IsReady(unit) and (not A.FireandBrimstone:IsSpellLearned()) then
        return A.Shadowburn:Show(icon)
    end
    -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight&active_enemies<5
    if A.ConcentratedFlame:IsReady(unit) and (not bool(Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff)) and not A.ConcentratedFlame:IsSpellInFlight() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 5) then
        return A.ConcentratedFlame:Show(icon)
    end
    -- incinerate
    if A.Incinerate:IsReady(unit) then
        return A.Incinerate:Show(icon)
    end
    end
    local function Cds(unit)
        -- immolate,if=talent.grimoire_of_supremacy.enabled&remains<8&cooldown.summon_infernal.remains<4.5
    if A.Immolate:IsReady(unit) and (A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.ImmolateDebuff) < 8 and A.SummonInfernal:GetCooldown() < 4.5) then
        return A.Immolate:Show(icon)
    end
    -- conflagrate,if=talent.grimoire_of_supremacy.enabled&cooldown.summon_infernal.remains<4.5&!buff.backdraft.up&soul_shard<4.3
    if A.Conflagrate:IsReady(unit) and (A.GrimoireofSupremacy:IsSpellLearned() and A.SummonInfernal:GetCooldown() < 4.5 and not Unit("player"):HasBuffs(A.BackdraftBuff) and Player:SoulShardsP < 4.3) then
        return A.Conflagrate:Show(icon)
    end
    -- use_item,name=azsharas_font_of_power,if=cooldown.summon_infernal.up|cooldown.summon_infernal.remains<=4
    if A.AzsharasFontofPower:IsReady(unit) and (A.SummonInfernal:HasCooldownUps or A.SummonInfernal:GetCooldown() <= 4) then
      A.AzsharasFontofPower:Show(icon)
    end
    -- summon_infernal
    if A.SummonInfernal:IsReady(unit) then
        return A.SummonInfernal:Show(icon)
    end
    -- guardian_of_azeroth,if=pet.infernal.active
    if A.GuardianofAzeroth:IsReady(unit) and (bool(pet.infernal.active)) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- dark_soul_instability,if=pet.infernal.active&(pet.infernal.remains<20.5|pet.infernal.remains<22&soul_shard>=3.6|!talent.grimoire_of_supremacy.enabled)
    if A.DarkSoulInstability:IsReady(unit) and (bool(pet.infernal.active) and (Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff) < 20.5 or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff) < 22 and Player:SoulShardsP >= 3.6 or not A.GrimoireofSupremacy:IsSpellLearned())) then
        return A.DarkSoulInstability:Show(icon)
    end
    -- memory_of_lucid_dreams,if=pet.infernal.active&(pet.infernal.remains<15.5|soul_shard<3.5&(buff.dark_soul_instability.up|!talent.grimoire_of_supremacy.enabled&dot.immolate.remains>12))
    if A.MemoryofLucidDreams:IsReady(unit) and (bool(pet.infernal.active) and (pet.infernal.remains < 15.5 or Player:SoulShardsP < 3.5 and (Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff) or not A.GrimoireofSupremacy:IsSpellLearned() and Unit(unit):HasDeBuffs(A.ImmolateDebuff) > 12))) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    -- summon_infernal,if=target.time_to_die>cooldown.summon_infernal.duration+30
    if A.SummonInfernal:IsReady(unit) and (Unit(unit):TimeToDie() > A.SummonInfernal:BaseDuration + 30) then
        return A.SummonInfernal:Show(icon)
    end
    -- guardian_of_azeroth,if=time>30&target.time_to_die>cooldown.guardian_of_azeroth.duration+30
    if A.GuardianofAzeroth:IsReady(unit) and (Unit("player"):CombatTime > 30 and Unit(unit):TimeToDie() > A.GuardianofAzeroth:BaseDuration + 30) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- summon_infernal,if=talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains>target.time_to_die
    if A.SummonInfernal:IsReady(unit) and (A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() > Unit(unit):TimeToDie()) then
        return A.SummonInfernal:Show(icon)
    end
    -- guardian_of_azeroth,if=cooldown.summon_infernal.remains>target.time_to_die
    if A.GuardianofAzeroth:IsReady(unit) and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie()) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- dark_soul_instability,if=cooldown.summon_infernal.remains>target.time_to_die&pet.infernal.remains<20.5
    if A.DarkSoulInstability:IsReady(unit) and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() and Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff) < 20.5) then
        return A.DarkSoulInstability:Show(icon)
    end
    -- memory_of_lucid_dreams,if=cooldown.summon_infernal.remains>target.time_to_die&(pet.infernal.remains<15.5|buff.dark_soul_instability.up&soul_shard<3)
    if A.MemoryofLucidDreams:IsReady(unit) and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() and (pet.infernal.remains < 15.5 or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff) and Player:SoulShardsP < 3)) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    -- summon_infernal,if=target.time_to_die<30
    if A.SummonInfernal:IsReady(unit) and (Unit(unit):TimeToDie() < 30) then
        return A.SummonInfernal:Show(icon)
    end
    -- guardian_of_azeroth,if=target.time_to_die<30
    if A.GuardianofAzeroth:IsReady(unit) and (Unit(unit):TimeToDie() < 30) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- dark_soul_instability,if=target.time_to_die<21&target.time_to_die>4
    if A.DarkSoulInstability:IsReady(unit) and (Unit(unit):TimeToDie() < 21 and Unit(unit):TimeToDie() > 4) then
        return A.DarkSoulInstability:Show(icon)
    end
    -- memory_of_lucid_dreams,if=target.time_to_die<16&target.time_to_die>6
    if A.MemoryofLucidDreams:IsReady(unit) and (Unit(unit):TimeToDie() < 16 and Unit(unit):TimeToDie() > 6) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    -- blood_of_the_enemy
    if A.BloodoftheEnemy:IsReady(unit) then
        return A.BloodoftheEnemy:Show(icon)
    end
    -- worldvein_resonance
    if A.WorldveinResonance:IsReady(unit) then
        return A.WorldveinResonance:Show(icon)
    end
    -- ripple_in_space
    if A.RippleInSpace:IsReady(unit) then
        return A.RippleInSpace:Show(icon)
    end
    -- potion,if=pet.infernal.active|target.time_to_die<30
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (bool(pet.infernal.active) or Unit(unit):TimeToDie() < 30) then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- berserking,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (bool(pet.infernal.active) and (not A.GrimoireofSupremacy:IsSpellLearned() or (not bool(essence.memory_of_lucid_dreams.major) or bool(Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff))) and (not A.DarkSoulInstability:IsSpellLearned() or bool(Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff)))) or Unit(unit):TimeToDie() <= 15) then
        return A.Berserking:Show(icon)
    end
    -- blood_fury,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (bool(pet.infernal.active) and (not A.GrimoireofSupremacy:IsSpellLearned() or (not bool(essence.memory_of_lucid_dreams.major) or bool(Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff))) and (not A.DarkSoulInstability:IsSpellLearned() or bool(Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff)))) or Unit(unit):TimeToDie() <= 15) then
        return A.BloodFury:Show(icon)
    end
    -- fireblood,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|(!essence.memory_of_lucid_dreams.major|buff.memory_of_lucid_dreams.remains)&(!talent.dark_soul_instability.enabled|buff.dark_soul_instability.remains))|target.time_to_die<=15
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (bool(pet.infernal.active) and (not A.GrimoireofSupremacy:IsSpellLearned() or (not bool(essence.memory_of_lucid_dreams.major) or bool(Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff))) and (not A.DarkSoulInstability:IsSpellLearned() or bool(Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff)))) or Unit(unit):TimeToDie() <= 15) then
        return A.Fireblood:Show(icon)
    end
    -- use_items,if=pet.infernal.active&(!talent.grimoire_of_supremacy.enabled|pet.infernal.remains<=20)|target.time_to_die<=20
    -- use_item,name=pocketsized_computation_device,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
    if A.PocketsizedComputationDevice:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
      A.PocketsizedComputationDevice:Show(icon)
    end
    -- use_item,name=rotcrusted_voodoo_doll,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
    if A.RotcrustedVoodooDoll:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
      A.RotcrustedVoodooDoll:Show(icon)
    end
    -- use_item,name=shiver_venom_relic,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
    if A.ShiverVenomRelic:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
      A.ShiverVenomRelic:Show(icon)
    end
    -- use_item,name=aquipotent_nautilus,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
    if A.AquipotentNautilus:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
      A.AquipotentNautilus:Show(icon)
    end
    -- use_item,name=tidestorm_codex,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
    if A.TidestormCodex:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
      A.TidestormCodex:Show(icon)
    end
    -- use_item,name=vial_of_storms,if=dot.immolate.remains>=5&(cooldown.summon_infernal.remains>=20|target.time_to_die<30)
    if A.VialofStorms:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ImmolateDebuff) >= 5 and (A.SummonInfernal:GetCooldown() >= 20 or Unit(unit):TimeToDie() < 30)) then
      A.VialofStorms:Show(icon)
    end
    end
    local function GosupInfernal(unit)
        -- rain_of_fire,if=soul_shard=5&!buff.backdraft.up&buff.memory_of_lucid_dreams.up&buff.grimoire_of_supremacy.stack<=10
    if A.RainofFire:IsReady(unit) and (Player:SoulShardsP == 5 and not Unit("player"):HasBuffs(A.BackdraftBuff) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff) and Unit("player"):HasBuffsStacks(A.GrimoireofSupremacyBuff) <= 10) then
        return A.RainofFire:Show(icon)
    end
    -- chaos_bolt,if=buff.backdraft.up
    if A.ChaosBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.BackdraftBuff)) then
        return A.ChaosBolt:Show(icon)
    end
    -- chaos_bolt,if=soul_shard>=4.2-buff.memory_of_lucid_dreams.up
    if A.ChaosBolt:IsReady(unit) and (Player:SoulShardsP >= 4.2 - num(Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff))) then
        return A.ChaosBolt:Show(icon)
    end
    -- chaos_bolt,if=!cooldown.conflagrate.up
    if A.ChaosBolt:IsReady(unit) and (not A.Conflagrate:HasCooldownUps) then
        return A.ChaosBolt:Show(icon)
    end
    -- chaos_bolt,if=cast_time<pet.infernal.remains&pet.infernal.remains<cast_time+gcd
    if A.ChaosBolt:IsReady(unit) and (A.ChaosBolt:GetSpellCastTime() < pet.infernal.remains and pet.infernal.remains < A.ChaosBolt:GetSpellCastTime() + A.GetGCD()) then
        return A.ChaosBolt:Show(icon)
    end
    -- conflagrate,if=buff.backdraft.down&buff.memory_of_lucid_dreams.up&soul_shard>=1.3
    if A.Conflagrate:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BackdraftBuff)) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff) and Player:SoulShardsP >= 1.3) then
        return A.Conflagrate:Show(icon)
    end
    -- conflagrate,if=buff.backdraft.down&!buff.memory_of_lucid_dreams.up&(soul_shard>=2.8|charges_fractional>1.9&soul_shard>=1.3)
    if A.Conflagrate:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BackdraftBuff)) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff) and (Player:SoulShardsP >= 2.8 or A.Conflagrate:ChargesFractionalP() > 1.9 and Player:SoulShardsP >= 1.3)) then
        return A.Conflagrate:Show(icon)
    end
    -- conflagrate,if=pet.infernal.remains<5
    if A.Conflagrate:IsReady(unit) and (pet.infernal.remains < 5) then
        return A.Conflagrate:Show(icon)
    end
    -- conflagrate,if=charges>1
    if A.Conflagrate:IsReady(unit) and (A.Conflagrate:ChargesP() > 1) then
        return A.Conflagrate:Show(icon)
    end
    -- soul_fire
    if A.SoulFire:IsReady(unit) then
        return A.SoulFire:Show(icon)
    end
    -- shadowburn
    if A.Shadowburn:IsReady(unit) then
        return A.Shadowburn:Show(icon)
    end
    -- incinerate
    if A.Incinerate:IsReady(unit) then
        return A.Incinerate:Show(icon)
    end
    end
    local function Havoc(unit)
        -- conflagrate,if=buff.backdraft.down&soul_shard>=1&soul_shard<=4
    if A.Conflagrate:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BackdraftBuff)) and Player:SoulShardsP >= 1 and Player:SoulShardsP <= 4) then
        return A.Conflagrate:Show(icon)
    end
    -- immolate,if=talent.internal_combustion.enabled&remains<duration*0.5|!talent.internal_combustion.enabled&refreshable
    if A.Immolate:IsReady(unit) and (A.InternalCombustion:IsSpellLearned() and Unit(unit):HasDeBuffs(A.ImmolateDebuff) < A.ImmolateDebuff:BaseDuration * 0.5 or not A.InternalCombustion:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.ImmolateDebuff)) then
        return A.Immolate:Show(icon)
    end
    -- chaos_bolt,if=cast_time<havoc_remains
    if A.ChaosBolt:IsReady(unit) and (A.ChaosBolt:GetSpellCastTime() < havoc_remains) then
        return A.ChaosBolt:Show(icon)
    end
    -- soul_fire
    if A.SoulFire:IsReady(unit) then
        return A.SoulFire:Show(icon)
    end
    -- shadowburn,if=active_enemies<3|!talent.fire_and_brimstone.enabled
    if A.Shadowburn:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or not A.FireandBrimstone:IsSpellLearned()) then
        return A.Shadowburn:Show(icon)
    end
    -- incinerate,if=cast_time<havoc_remains
    if A.Incinerate:IsReady(unit) and (A.Incinerate:GetSpellCastTime() < havoc_remains) then
        return A.Incinerate:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- call_action_list,name=havoc,if=havoc_active&active_enemies<5-talent.inferno.enabled+(talent.inferno.enabled&talent.internal_combustion.enabled)
    if (bool(havoc_active) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 5 - num(A.Inferno:IsSpellLearned()) + num((A.Inferno:IsSpellLearned() and A.InternalCombustion:IsSpellLearned()))) then
      local ShouldReturn = Havoc(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- cataclysm,if=!(pet.infernal.active&dot.immolate.remains+1>pet.infernal.remains)|spell_targets.cataclysm>1|!talent.grimoire_of_supremacy.enabled
    if A.Cataclysm:IsReady(unit) and (not (bool(pet.infernal.active) and Unit(unit):HasDeBuffs(A.ImmolateDebuff) + 1 > pet.infernal.remains) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or not A.GrimoireofSupremacy:IsSpellLearned()) then
        return A.Cataclysm:Show(icon)
    end
    -- call_action_list,name=aoe,if=active_enemies>2
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
      local ShouldReturn = Aoe(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- immolate,cycle_targets=1,if=refreshable&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains)
    if A.Immolate:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Immolate, 40, EvaluateCycleImmolate501) then
            return A.Immolate:Show(icon) 
        end
    end
    -- immolate,if=talent.internal_combustion.enabled&action.chaos_bolt.in_flight&remains<duration*0.5
    if A.Immolate:IsReady(unit) and (A.InternalCombustion:IsSpellLearned() and A.ChaosBolt:IsSpellInFlight() and Unit(unit):HasDeBuffs(A.ImmolateDebuff) < A.ImmolateDebuff:BaseDuration * 0.5) then
        return A.Immolate:Show(icon)
    end
    -- call_action_list,name=cds
    if A.BurstIsON(unit) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- focused_azerite_beam,if=!pet.infernal.active|!talent.grimoire_of_supremacy.enabled
    if A.FocusedAzeriteBeam:IsReady(unit) and (not bool(pet.infernal.active) or not A.GrimoireofSupremacy:IsSpellLearned()) then
        return A.FocusedAzeriteBeam:Show(icon)
    end
    -- the_unbound_force,if=buff.reckless_force.react
    if A.TheUnboundForce:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.RecklessForceBuff))) then
        return A.TheUnboundForce:Show(icon)
    end
    -- purifying_blast
    if A.PurifyingBlast:IsReady(unit) then
        return A.PurifyingBlast:Show(icon)
    end
    -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight
    if A.ConcentratedFlame:IsReady(unit) and (not bool(Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff)) and not A.ConcentratedFlame:IsSpellInFlight()) then
        return A.ConcentratedFlame:Show(icon)
    end
    -- channel_demonfire
    if A.ChannelDemonfire:IsReady(unit) then
        return A.ChannelDemonfire:Show(icon)
    end
    -- havoc,cycle_targets=1,if=!(target=self.target)&(dot.immolate.remains>dot.immolate.duration*0.5|!talent.internal_combustion.enabled)&(!cooldown.summon_infernal.ready|!talent.grimoire_of_supremacy.enabled|talent.grimoire_of_supremacy.enabled&pet.infernal.remains<=10)
    if A.Havoc:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Havoc, 40, EvaluateCycleHavoc566) then
            return A.Havoc:Show(icon) 
        end
    end
    -- call_action_list,name=gosup_infernal,if=talent.grimoire_of_supremacy.enabled&pet.infernal.active
    if (A.GrimoireofSupremacy:IsSpellLearned() and bool(pet.infernal.active)) then
      local ShouldReturn = GosupInfernal(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- soul_fire
    if A.SoulFire:IsReady(unit) then
        return A.SoulFire:Show(icon)
    end
    -- variable,name=pool_soul_shards,value=active_enemies>1&cooldown.havoc.remains<=10|cooldown.summon_infernal.remains<=15&(talent.grimoire_of_supremacy.enabled|talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains<=15)|talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains<=15&(cooldown.summon_infernal.remains>target.time_to_die|cooldown.summon_infernal.remains+cooldown.summon_infernal.duration>target.time_to_die)
    if (true) then
      VarPoolSoulShards = num(MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and A.Havoc:GetCooldown() <= 10 or A.SummonInfernal:GetCooldown() <= 15 and (A.GrimoireofSupremacy:IsSpellLearned() or A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() <= 15) or A.DarkSoulInstability:IsSpellLearned() and A.DarkSoulInstability:GetCooldown() <= 15 and (A.SummonInfernal:GetCooldown() > Unit(unit):TimeToDie() or A.SummonInfernal:GetCooldown() + A.SummonInfernal:BaseDuration > Unit(unit):TimeToDie()))
    end
    -- conflagrate,if=buff.backdraft.down&soul_shard>=1.5-0.3*talent.flashover.enabled&!variable.pool_soul_shards
    if A.Conflagrate:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BackdraftBuff)) and Player:SoulShardsP >= 1.5 - 0.3 * num(A.Flashover:IsSpellLearned()) and not bool(VarPoolSoulShards)) then
        return A.Conflagrate:Show(icon)
    end
    -- shadowburn,if=soul_shard<2&(!variable.pool_soul_shards|charges>1)
    if A.Shadowburn:IsReady(unit) and (Player:SoulShardsP < 2 and (not bool(VarPoolSoulShards) or A.Shadowburn:ChargesP() > 1)) then
        return A.Shadowburn:Show(icon)
    end
    -- chaos_bolt,if=(talent.grimoire_of_supremacy.enabled|azerite.crashing_chaos.enabled)&pet.infernal.active|buff.dark_soul_instability.up|buff.reckless_force.react&buff.reckless_force.remains>cast_time
    if A.ChaosBolt:IsReady(unit) and ((A.GrimoireofSupremacy:IsSpellLearned() or A.CrashingChaos:GetAzeriteRank) and bool(pet.infernal.active) or Unit("player"):HasBuffs(A.DarkSoulInstabilityBuff) or bool(Unit("player"):HasBuffsStacks(A.RecklessForceBuff)) and Unit("player"):HasBuffs(A.RecklessForceBuff) > A.ChaosBolt:GetSpellCastTime()) then
        return A.ChaosBolt:Show(icon)
    end
    -- chaos_bolt,if=buff.backdraft.up&!variable.pool_soul_shards&!talent.eradication.enabled
    if A.ChaosBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.BackdraftBuff) and not bool(VarPoolSoulShards) and not A.Eradication:IsSpellLearned()) then
        return A.ChaosBolt:Show(icon)
    end
    -- chaos_bolt,if=!variable.pool_soul_shards&talent.eradication.enabled&(debuff.eradication.remains<cast_time|buff.backdraft.up)
    if A.ChaosBolt:IsReady(unit) and (not bool(VarPoolSoulShards) and A.Eradication:IsSpellLearned() and (Unit(unit):HasDeBuffs(A.EradicationDebuff) < A.ChaosBolt:GetSpellCastTime() or Unit("player"):HasBuffs(A.BackdraftBuff))) then
        return A.ChaosBolt:Show(icon)
    end
    -- chaos_bolt,if=(soul_shard>=4.5-0.2*active_enemies)&(!talent.grimoire_of_supremacy.enabled|cooldown.summon_infernal.remains>7)
    if A.ChaosBolt:IsReady(unit) and ((Player:SoulShardsP >= 4.5 - 0.2 * MultiUnits:GetByRangeInCombat(40, 5, 10)) and (not A.GrimoireofSupremacy:IsSpellLearned() or A.SummonInfernal:GetCooldown() > 7)) then
        return A.ChaosBolt:Show(icon)
    end
    -- conflagrate,if=charges>1
    if A.Conflagrate:IsReady(unit) and (A.Conflagrate:ChargesP() > 1) then
        return A.Conflagrate:Show(icon)
    end
    -- incinerate
    if A.Incinerate:IsReady(unit) then
        return A.Incinerate:Show(icon)
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 