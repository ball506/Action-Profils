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
Action[ACTION_CONST_WARLOCK_DEMONOLOGY] = {
  SummonPet                              = Action.Create({Type = "Spell", ID = 30146 }),
  InnerDemons                            = Action.Create({Type = "Spell", ID = 267216 }),
  Demonbolt                              = Action.Create({Type = "Spell", ID = 264178 }),
  SoulStrike                             = Action.Create({Type = "Spell", ID = 264057 }),
  ShadowBolt                             = Action.Create({Type = "Spell", ID = 686 }),
  Implosion                              = Action.Create({Type = "Spell", ID = 196277 }),
  WildImpsBuff                           = Action.Create({Type = "Spell", ID =  }),
  CallDreadstalkers                      = Action.Create({Type = "Spell", ID = 104316 }),
  BilescourgeBombers                     = Action.Create({Type = "Spell", ID = 267211 }),
  HandofGuldan                           = Action.Create({Type = "Spell", ID = 105174 }),
  DemonicPowerBuff                       = Action.Create({Type = "Spell", ID = 265273 }),
  DemonicCalling                         = Action.Create({Type = "Spell", ID = 205145 }),
  GrimoireFelguard                       = Action.Create({Type = "Spell", ID = 111898 }),
  SummonDemonicTyrant                    = Action.Create({Type = "Spell", ID = 265187 }),
  DemonicCallingBuff                     = Action.Create({Type = "Spell", ID = 205146 }),
  DemonicCoreBuff                        = Action.Create({Type = "Spell", ID = 264173 }),
  SummonVilefiend                        = Action.Create({Type = "Spell", ID = 264119 }),
  Doom                                   = Action.Create({Type = "Spell", ID = 265412 }),
  DoomDebuff                             = Action.Create({Type = "Spell", ID = 265412 }),
  NetherPortal                           = Action.Create({Type = "Spell", ID = 267217 }),
  NetherPortalBuff                       = Action.Create({Type = "Spell", ID = 267218 }),
  PowerSiphon                            = Action.Create({Type = "Spell", ID = 264130 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  DemonicStrength                        = Action.Create({Type = "Spell", ID = 267171 }),
  DreadstalkersBuff                      = Action.Create({Type = "Spell", ID =  }),
  DemonicConsumption                     = Action.Create({Type = "Spell", ID = 267215 }),
  GrimoireFelguardBuff                   = Action.Create({Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_WARLOCK_DEMONOLOGY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_DEMONOLOGY], { __index = Action })



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


local function EvaluateCycleDoom120(unit)
  return Unit(unit):HasDeBuffsRefreshable(A.DoomDebuff)
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
     local Precombat, BuildAShard, Implosion, NetherPortal, NetherPortalActive, NetherPortalBuilding
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
    -- inner_demons,if=talent.inner_demons.enabled
    if A.InnerDemons:IsReady(unit) and (A.InnerDemons:IsSpellLearned()) then
        return A.InnerDemons:Show(icon)
    end
    -- snapshot_stats
    -- potion
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- demonbolt
    if A.Demonbolt:IsReady(unit) then
        return A.Demonbolt:Show(icon)
    end
    end
    local function BuildAShard(unit)
        -- soul_strike
    if A.SoulStrike:IsReady(unit) then
        return A.SoulStrike:Show(icon)
    end
    -- shadow_bolt
    if A.ShadowBolt:IsReady(unit) then
        return A.ShadowBolt:Show(icon)
    end
    end
    local function Implosion(unit)
        -- implosion,if=(buff.wild_imps.stack>=6&(soul_shard<3|prev_gcd.1.call_dreadstalkers|buff.wild_imps.stack>=9|prev_gcd.1.bilescourge_bombers|(!prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan))&!prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan&buff.demonic_power.down)|(time_to_die<3&buff.wild_imps.stack>0)|(prev_gcd.2.call_dreadstalkers&buff.wild_imps.stack>2&!talent.demonic_calling.enabled)
    if A.Implosion:IsReady(unit) and ((Unit("player"):HasBuffsStacks(A.WildImpsBuff) >= 6 and (Player:SoulShardsP < 3 or Unit("player"):GetSpellLastCast(A.CallDreadstalkers) or Unit("player"):HasBuffsStacks(A.WildImpsBuff) >= 9 or Unit("player"):GetSpellLastCast(A.BilescourgeBombers) or (not Unit("player"):GetSpellLastCast(A.HandofGuldan) and not Unit("player"):GetSpellLastCast(A.HandofGuldan))) and not Unit("player"):GetSpellLastCast(A.HandofGuldan) and not Unit("player"):GetSpellLastCast(A.HandofGuldan) and bool(Unit("player"):HasBuffsDown(A.DemonicPowerBuff))) or (Unit(unit):TimeToDie() < 3 and Unit("player"):HasBuffsStacks(A.WildImpsBuff) > 0) or (Unit("player"):GetSpellLastCast(A.CallDreadstalkers) and Unit("player"):HasBuffsStacks(A.WildImpsBuff) > 2 and not A.DemonicCalling:IsSpellLearned())) then
        return A.Implosion:Show(icon)
    end
    -- grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains<13|!equipped.132369
    if A.GrimoireFelguard:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() < 13 or not A.Item132369:IsEquipped) then
        return A.GrimoireFelguard:Show(icon)
    end
    -- call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14
    if A.CallDreadstalkers:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() < 9 and bool(Unit("player"):HasBuffs(A.DemonicCallingBuff))) or (A.SummonDemonicTyrant:GetCooldown() < 11 and not bool(Unit("player"):HasBuffs(A.DemonicCallingBuff))) or A.SummonDemonicTyrant:GetCooldown() > 14) then
        return A.CallDreadstalkers:Show(icon)
    end
    -- summon_demonic_tyrant
    if A.SummonDemonicTyrant:IsReady(unit) then
        return A.SummonDemonicTyrant:Show(icon)
    end
    -- hand_of_guldan,if=soul_shard>=5
    if A.HandofGuldan:IsReady(unit) and (Player:SoulShardsP >= 5) then
        return A.HandofGuldan:Show(icon)
    end
    -- hand_of_guldan,if=soul_shard>=3&(((prev_gcd.2.hand_of_guldan|buff.wild_imps.stack>=3)&buff.wild_imps.stack<9)|cooldown.summon_demonic_tyrant.remains<=gcd*2|buff.demonic_power.remains>gcd*2)
    if A.HandofGuldan:IsReady(unit) and (Player:SoulShardsP >= 3 and (((Unit("player"):GetSpellLastCast(A.HandofGuldan) or Unit("player"):HasBuffsStacks(A.WildImpsBuff) >= 3) and Unit("player"):HasBuffsStacks(A.WildImpsBuff) < 9) or A.SummonDemonicTyrant:GetCooldown() <= A.GetGCD() * 2 or Unit("player"):HasBuffs(A.DemonicPowerBuff) > A.GetGCD() * 2)) then
        return A.HandofGuldan:Show(icon)
    end
    -- demonbolt,if=prev_gcd.1.hand_of_guldan&soul_shard>=1&(buff.wild_imps.stack<=3|prev_gcd.3.hand_of_guldan)&soul_shard<4&buff.demonic_core.up
    if A.Demonbolt:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.HandofGuldan) and Player:SoulShardsP >= 1 and (Unit("player"):HasBuffsStacks(A.WildImpsBuff) <= 3 or Unit("player"):GetSpellLastCast(A.HandofGuldan)) and Player:SoulShardsP < 4 and Unit("player"):HasBuffs(A.DemonicCoreBuff)) then
        return A.Demonbolt:Show(icon)
    end
    -- summon_vilefiend,if=(cooldown.summon_demonic_tyrant.remains>40&spell_targets.implosion<=2)|cooldown.summon_demonic_tyrant.remains<12
    if A.SummonVilefiend:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() > 40 and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2) or A.SummonDemonicTyrant:GetCooldown() < 12) then
        return A.SummonVilefiend:Show(icon)
    end
    -- bilescourge_bombers,if=cooldown.summon_demonic_tyrant.remains>9
    if A.BilescourgeBombers:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() > 9) then
        return A.BilescourgeBombers:Show(icon)
    end
    -- soul_strike,if=soul_shard<5&buff.demonic_core.stack<=2
    if A.SoulStrike:IsReady(unit) and (Player:SoulShardsP < 5 and Unit("player"):HasBuffsStacks(A.DemonicCoreBuff) <= 2) then
        return A.SoulStrike:Show(icon)
    end
    -- demonbolt,if=soul_shard<=3&buff.demonic_core.up&(buff.demonic_core.stack>=3|buff.demonic_core.remains<=gcd*5.7)
    if A.Demonbolt:IsReady(unit) and (Player:SoulShardsP <= 3 and Unit("player"):HasBuffs(A.DemonicCoreBuff) and (Unit("player"):HasBuffsStacks(A.DemonicCoreBuff) >= 3 or Unit("player"):HasBuffs(A.DemonicCoreBuff) <= A.GetGCD() * 5.7)) then
        return A.Demonbolt:Show(icon)
    end
    -- doom,cycle_targets=1,max_cycle_targets=7,if=refreshable
    if A.Doom:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Doom, 40, EvaluateCycleDoom120) then
            return A.Doom:Show(icon) 
        end
    end
    -- call_action_list,name=build_a_shard
    if (true) then
      local ShouldReturn = BuildAShard(unit); if ShouldReturn then return ShouldReturn; end
    end
    end
    local function NetherPortal(unit)
        -- call_action_list,name=nether_portal_building,if=cooldown.nether_portal.remains<20
    if (A.NetherPortal:GetCooldown() < 20) then
      local ShouldReturn = NetherPortalBuilding(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=nether_portal_active,if=cooldown.nether_portal.remains>165
    if (A.NetherPortal:GetCooldown() > 165) then
      local ShouldReturn = NetherPortalActive(unit); if ShouldReturn then return ShouldReturn; end
    end
    end
    local function NetherPortalActive(unit)
        -- bilescourge_bombers
    if A.BilescourgeBombers:IsReady(unit) then
        return A.BilescourgeBombers:Show(icon)
    end
    -- grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains<13|!equipped.132369
    if A.GrimoireFelguard:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() < 13 or not A.Item132369:IsEquipped) then
        return A.GrimoireFelguard:Show(icon)
    end
    -- summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|cooldown.summon_demonic_tyrant.remains<12
    if A.SummonVilefiend:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() > 40 or A.SummonDemonicTyrant:GetCooldown() < 12) then
        return A.SummonVilefiend:Show(icon)
    end
    -- call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14
    if A.CallDreadstalkers:IsReady(unit) and ((A.SummonDemonicTyrant:GetCooldown() < 9 and bool(Unit("player"):HasBuffs(A.DemonicCallingBuff))) or (A.SummonDemonicTyrant:GetCooldown() < 11 and not bool(Unit("player"):HasBuffs(A.DemonicCallingBuff))) or A.SummonDemonicTyrant:GetCooldown() > 14) then
        return A.CallDreadstalkers:Show(icon)
    end
    -- call_action_list,name=build_a_shard,if=soul_shard=1&(cooldown.call_dreadstalkers.remains<action.shadow_bolt.cast_time|(talent.bilescourge_bombers.enabled&cooldown.bilescourge_bombers.remains<action.shadow_bolt.cast_time))
    if (Player:SoulShardsP == 1 and (A.CallDreadstalkers:GetCooldown() < A.ShadowBolt:GetSpellCastTime() or (A.BilescourgeBombers:IsSpellLearned() and A.BilescourgeBombers:GetCooldown() < A.ShadowBolt:GetSpellCastTime()))) then
      local ShouldReturn = BuildAShard(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- hand_of_guldan,if=((cooldown.call_dreadstalkers.remains>action.demonbolt.cast_time)&(cooldown.call_dreadstalkers.remains>action.shadow_bolt.cast_time))&cooldown.nether_portal.remains>(165+action.hand_of_guldan.cast_time)
    if A.HandofGuldan:IsReady(unit) and (((A.CallDreadstalkers:GetCooldown() > A.Demonbolt:GetSpellCastTime()) and (A.CallDreadstalkers:GetCooldown() > A.ShadowBolt:GetSpellCastTime())) and A.NetherPortal:GetCooldown() > (165 + A.HandofGuldan:GetSpellCastTime())) then
        return A.HandofGuldan:Show(icon)
    end
    -- summon_demonic_tyrant,if=buff.nether_portal.remains<5&soul_shard=0
    if A.SummonDemonicTyrant:IsReady(unit) and (Unit("player"):HasBuffs(A.NetherPortalBuff) < 5 and Player:SoulShardsP == 0) then
        return A.SummonDemonicTyrant:Show(icon)
    end
    -- summon_demonic_tyrant,if=buff.nether_portal.remains<action.summon_demonic_tyrant.cast_time+0.5
    if A.SummonDemonicTyrant:IsReady(unit) and (Unit("player"):HasBuffs(A.NetherPortalBuff) < A.SummonDemonicTyrant:GetSpellCastTime() + 0.5) then
        return A.SummonDemonicTyrant:Show(icon)
    end
    -- demonbolt,if=buff.demonic_core.up
    if A.Demonbolt:IsReady(unit) and (Unit("player"):HasBuffs(A.DemonicCoreBuff)) then
        return A.Demonbolt:Show(icon)
    end
    -- call_action_list,name=build_a_shard
    if (true) then
      local ShouldReturn = BuildAShard(unit); if ShouldReturn then return ShouldReturn; end
    end
    end
    local function NetherPortalBuilding(unit)
        -- nether_portal,if=soul_shard>=5&(!talent.power_siphon.enabled|buff.demonic_core.up)
    if A.NetherPortal:IsReady(unit) and (Player:SoulShardsP >= 5 and (not A.PowerSiphon:IsSpellLearned() or Unit("player"):HasBuffs(A.DemonicCoreBuff))) then
        return A.NetherPortal:Show(icon)
    end
    -- call_dreadstalkers
    if A.CallDreadstalkers:IsReady(unit) then
        return A.CallDreadstalkers:Show(icon)
    end
    -- hand_of_guldan,if=cooldown.call_dreadstalkers.remains>18&soul_shard>=3
    if A.HandofGuldan:IsReady(unit) and (A.CallDreadstalkers:GetCooldown() > 18 and Player:SoulShardsP >= 3) then
        return A.HandofGuldan:Show(icon)
    end
    -- power_siphon,if=buff.wild_imps.stack>=2&buff.demonic_core.stack<=2&buff.demonic_power.down&soul_shard>=3
    if A.PowerSiphon:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.WildImpsBuff) >= 2 and Unit("player"):HasBuffsStacks(A.DemonicCoreBuff) <= 2 and bool(Unit("player"):HasBuffsDown(A.DemonicPowerBuff)) and Player:SoulShardsP >= 3) then
        return A.PowerSiphon:Show(icon)
    end
    -- hand_of_guldan,if=soul_shard>=5
    if A.HandofGuldan:IsReady(unit) and (Player:SoulShardsP >= 5) then
        return A.HandofGuldan:Show(icon)
    end
    -- call_action_list,name=build_a_shard
    if (true) then
      local ShouldReturn = BuildAShard(unit); if ShouldReturn then return ShouldReturn; end
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- potion,if=pet.demonic_tyrant.active|target.time_to_die<30
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (bool(pet.demonic_tyrant.active) or Unit(unit):TimeToDie() < 30) then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- use_items,if=pet.demonic_tyrant.active|target.time_to_die<=15
    -- berserking,if=pet.demonic_tyrant.active|target.time_to_die<=15
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (bool(pet.demonic_tyrant.active) or Unit(unit):TimeToDie() <= 15) then
        return A.Berserking:Show(icon)
    end
    -- blood_fury,if=pet.demonic_tyrant.active|target.time_to_die<=15
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (bool(pet.demonic_tyrant.active) or Unit(unit):TimeToDie() <= 15) then
        return A.BloodFury:Show(icon)
    end
    -- fireblood,if=pet.demonic_tyrant.active|target.time_to_die<=15
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (bool(pet.demonic_tyrant.active) or Unit(unit):TimeToDie() <= 15) then
        return A.Fireblood:Show(icon)
    end
    -- doom,if=!ticking&time_to_die>30&spell_targets.implosion<2
    if A.Doom:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.DoomDebuff) and Unit(unit):TimeToDie() > 30 and MultiUnits:GetByRangeInCombat(40, 5, 10) < 2) then
        return A.Doom:Show(icon)
    end
    -- demonic_strength,if=(buff.wild_imps.stack<6|buff.demonic_power.up)|spell_targets.implosion<2
    if A.DemonicStrength:IsReady(unit) and ((Unit("player"):HasBuffsStacks(A.WildImpsBuff) < 6 or Unit("player"):HasBuffs(A.DemonicPowerBuff)) or MultiUnits:GetByRangeInCombat(40, 5, 10) < 2) then
        return A.DemonicStrength:Show(icon)
    end
    -- call_action_list,name=nether_portal,if=talent.nether_portal.enabled&spell_targets.implosion<=2
    if (A.NetherPortal:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2) then
      local ShouldReturn = NetherPortal(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=implosion,if=spell_targets.implosion>1
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
      local ShouldReturn = Implosion(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains<13|!equipped.132369
    if A.GrimoireFelguard:IsReady(unit) and (A.SummonDemonicTyrant:GetCooldown() < 13 or not A.Item132369:IsEquipped) then
        return A.GrimoireFelguard:Show(icon)
    end
    -- summon_vilefiend,if=equipped.132369|cooldown.summon_demonic_tyrant.remains>40|cooldown.summon_demonic_tyrant.remains<12
    if A.SummonVilefiend:IsReady(unit) and (A.Item132369:IsEquipped or A.SummonDemonicTyrant:GetCooldown() > 40 or A.SummonDemonicTyrant:GetCooldown() < 12) then
        return A.SummonVilefiend:Show(icon)
    end
    -- call_dreadstalkers,if=equipped.132369|(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14
    if A.CallDreadstalkers:IsReady(unit) and (A.Item132369:IsEquipped or (A.SummonDemonicTyrant:GetCooldown() < 9 and bool(Unit("player"):HasBuffs(A.DemonicCallingBuff))) or (A.SummonDemonicTyrant:GetCooldown() < 11 and not bool(Unit("player"):HasBuffs(A.DemonicCallingBuff))) or A.SummonDemonicTyrant:GetCooldown() > 14) then
        return A.CallDreadstalkers:Show(icon)
    end
    -- summon_demonic_tyrant,if=equipped.132369|(buff.dreadstalkers.remains>cast_time&(buff.wild_imps.stack>=3+talent.inner_demons.enabled+talent.demonic_consumption.enabled*3|prev_gcd.1.hand_of_guldan&(!talent.demonic_consumption.enabled|buff.wild_imps.stack>=3+talent.inner_demons.enabled))&(soul_shard<3|buff.dreadstalkers.remains<gcd*2.7|buff.grimoire_felguard.remains<gcd*2.7))
    if A.SummonDemonicTyrant:IsReady(unit) and (A.Item132369:IsEquipped or (Unit("player"):HasBuffs(A.DreadstalkersBuff) > A.SummonDemonicTyrant:GetSpellCastTime() and (Unit("player"):HasBuffsStacks(A.WildImpsBuff) >= 3 + num(A.InnerDemons:IsSpellLearned()) + num(A.DemonicConsumption:IsSpellLearned()) * 3 or Unit("player"):GetSpellLastCast(A.HandofGuldan) and (not A.DemonicConsumption:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.WildImpsBuff) >= 3 + num(A.InnerDemons:IsSpellLearned()))) and (Player:SoulShardsP < 3 or Unit("player"):HasBuffs(A.DreadstalkersBuff) < A.GetGCD() * 2.7 or Unit("player"):HasBuffs(A.GrimoireFelguardBuff) < A.GetGCD() * 2.7))) then
        return A.SummonDemonicTyrant:Show(icon)
    end
    -- power_siphon,if=buff.wild_imps.stack>=2&buff.demonic_core.stack<=2&buff.demonic_power.down&spell_targets.implosion<2
    if A.PowerSiphon:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.WildImpsBuff) >= 2 and Unit("player"):HasBuffsStacks(A.DemonicCoreBuff) <= 2 and bool(Unit("player"):HasBuffsDown(A.DemonicPowerBuff)) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 2) then
        return A.PowerSiphon:Show(icon)
    end
    -- doom,if=talent.doom.enabled&refreshable&time_to_die>(dot.doom.remains+30)
    if A.Doom:IsReady(unit) and (A.Doom:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.DoomDebuff) and Unit(unit):TimeToDie() > (Unit(unit):HasDeBuffs(A.DoomDebuff) + 30)) then
        return A.Doom:Show(icon)
    end
    -- hand_of_guldan,if=soul_shard>=5|(soul_shard>=3&cooldown.call_dreadstalkers.remains>4&(!talent.summon_vilefiend.enabled|cooldown.summon_vilefiend.remains>3))
    if A.HandofGuldan:IsReady(unit) and (Player:SoulShardsP >= 5 or (Player:SoulShardsP >= 3 and A.CallDreadstalkers:GetCooldown() > 4 and (not A.SummonVilefiend:IsSpellLearned() or A.SummonVilefiend:GetCooldown() > 3))) then
        return A.HandofGuldan:Show(icon)
    end
    -- soul_strike,if=soul_shard<5&buff.demonic_core.stack<=2
    if A.SoulStrike:IsReady(unit) and (Player:SoulShardsP < 5 and Unit("player"):HasBuffsStacks(A.DemonicCoreBuff) <= 2) then
        return A.SoulStrike:Show(icon)
    end
    -- demonbolt,if=soul_shard<=3&buff.demonic_core.up&((cooldown.summon_demonic_tyrant.remains<10|cooldown.summon_demonic_tyrant.remains>22)|buff.demonic_core.stack>=3|buff.demonic_core.remains<5|time_to_die<25)
    if A.Demonbolt:IsReady(unit) and (Player:SoulShardsP <= 3 and Unit("player"):HasBuffs(A.DemonicCoreBuff) and ((A.SummonDemonicTyrant:GetCooldown() < 10 or A.SummonDemonicTyrant:GetCooldown() > 22) or Unit("player"):HasBuffsStacks(A.DemonicCoreBuff) >= 3 or Unit("player"):HasBuffs(A.DemonicCoreBuff) < 5 or Unit(unit):TimeToDie() < 25)) then
        return A.Demonbolt:Show(icon)
    end
    -- bilescourge_bombers
    if A.BilescourgeBombers:IsReady(unit) then
        return A.BilescourgeBombers:Show(icon)
    end
    -- call_action_list,name=build_a_shard
    if (true) then
      local ShouldReturn = BuildAShard(unit); if ShouldReturn then return ShouldReturn; end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 