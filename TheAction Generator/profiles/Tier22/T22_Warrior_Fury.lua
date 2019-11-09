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
Action[ACTION_CONST_WARRIOR_FURY] = {
  RecklessnessBuff                       = Action.Create({Type = "Spell", ID = 1719 }),
  Recklessness                           = Action.Create({Type = "Spell", ID = 1719 }),
  FuriousSlashBuff                       = Action.Create({Type = "Spell", ID = 202539 }),
  FuriousSlash                           = Action.Create({Type = "Spell", ID = 100130 }),
  RecklessAbandon                        = Action.Create({Type = "Spell", ID = 202751 }),
  HeroicLeap                             = Action.Create({Type = "Spell", ID = 6544 }),
  Siegebreaker                           = Action.Create({Type = "Spell", ID = 280772 }),
  Rampage                                = Action.Create({Type = "Spell", ID = 184367 }),
  FrothingBerserker                      = Action.Create({Type = "Spell", ID = 215571 }),
  Carnage                                = Action.Create({Type = "Spell", ID = 202922 }),
  EnrageBuff                             = Action.Create({Type = "Spell", ID = 184362 }),
  Massacre                               = Action.Create({Type = "Spell", ID = 206315 }),
  Execute                                = Action.Create({Type = "Spell", ID = 5308 }),
  Bloodthirst                            = Action.Create({Type = "Spell", ID = 23881 }),
  RagingBlow                             = Action.Create({Type = "Spell", ID = 85288 }),
  Bladestorm                             = Action.Create({Type = "Spell", ID = 46924 }),
  SiegebreakerDebuff                     = Action.Create({Type = "Spell", ID = 280773 }),
  DragonRoar                             = Action.Create({Type = "Spell", ID = 118000 }),
  Whirlwind                              = Action.Create({Type = "Spell", ID = 190411 }),
  Charge                                 = Action.Create({Type = "Spell", ID = 100 }),
  FujiedasFuryBuff                       = Action.Create({Type = "Spell", ID =  }),
  MeatCleaverBuff                        = Action.Create({Type = "Spell", ID = 280392 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 })
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
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })



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
     local Precombat, Movement, SingleTarget
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
       local function Precombat(unit)
        -- flask
    -- food
    -- augmentation
    -- snapshot_stats
    -- potion
    if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofStrength:Show(icon)
    end
    -- recklessness,if=!talent.furious_slash.enabled&!talent.reckless_abandon.enabled
    if A.Recklessness:IsReady(unit) and Player:HasBuffsDown(A.RecklessnessBuff) and A.BurstIsON(unit) and (not A.FuriousSlash:IsSpellLearned() and not A.RecklessAbandon:IsSpellLearned()) then
        return A.Recklessness:Show(icon)
    end
    end
    local function Movement(unit)
        -- heroic_leap
    if A.HeroicLeap:IsReady(unit) then
        return A.HeroicLeap:Show(icon)
    end
    end
    local function SingleTarget(unit)
        -- siegebreaker
    if A.Siegebreaker:IsReady(unit) and A.BurstIsON(unit) then
        return A.Siegebreaker:Show(icon)
    end
    -- rampage,if=buff.recklessness.up|(talent.frothing_berserker.enabled|talent.carnage.enabled&(buff.enrage.remains<gcd|rage>90)|talent.massacre.enabled&(buff.enrage.remains<gcd|rage>90))
    if A.Rampage:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff) or (A.FrothingBerserker:IsSpellLearned() or A.Carnage:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff) < A.GetGCD() or Player:Rage() > 90) or A.Massacre:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff) < A.GetGCD() or Player:Rage() > 90))) then
        return A.Rampage:Show(icon)
    end
    -- execute,if=buff.enrage.up
    if A.Execute:IsReady(unit) and (Unit("player"):HasBuffs(A.EnrageBuff)) then
        return A.Execute:Show(icon)
    end
    -- bloodthirst,if=buff.enrage.down
    if A.Bloodthirst:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.EnrageBuff))) then
        return A.Bloodthirst:Show(icon)
    end
    -- raging_blow,if=charges=2
    if A.RagingBlow:IsReady(unit) and (A.RagingBlow:ChargesP() == 2) then
        return A.RagingBlow:Show(icon)
    end
    -- bloodthirst
    if A.Bloodthirst:IsReady(unit) then
        return A.Bloodthirst:Show(icon)
    end
    -- bladestorm,if=prev_gcd.1.rampage&(debuff.siegebreaker.up|!talent.siegebreaker.enabled)
    if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):GetSpellLastCast(A.Rampage) and (Target:HasDebuffs(A.SiegebreakerDebuff) or not A.Siegebreaker:IsSpellLearned())) then
        return A.Bladestorm:Show(icon)
    end
    -- dragon_roar,if=buff.enrage.up
    if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.EnrageBuff)) then
        return A.DragonRoar:Show(icon)
    end
    -- raging_blow,if=talent.carnage.enabled|(talent.massacre.enabled&rage<80)|(talent.frothing_berserker.enabled&rage<90)
    if A.RagingBlow:IsReady(unit) and (A.Carnage:IsSpellLearned() or (A.Massacre:IsSpellLearned() and Player:Rage() < 80) or (A.FrothingBerserker:IsSpellLearned() and Player:Rage() < 90)) then
        return A.RagingBlow:Show(icon)
    end
    -- furious_slash,if=talent.furious_slash.enabled
    if A.FuriousSlash:IsReady(unit) and (A.FuriousSlash:IsSpellLearned()) then
        return A.FuriousSlash:Show(icon)
    end
    -- whirlwind
    if A.Whirlwind:IsReady(unit) then
        return A.Whirlwind:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack
    -- charge
    if A.Charge:IsReady(unit) then
        return A.Charge:Show(icon)
    end
    -- run_action_list,name=movement,if=movement.distance>5
    if (movement.distance > 5) then
      return Movement(unit);
    end
    -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)|!raid_event.movement.exists
    if A.HeroicLeap:IsReady(unit) and ((raid_event.movement.distance > 25 and 10000000000 > 45) or not false) then
        return A.HeroicLeap:Show(icon)
    end
    -- potion
    if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofStrength:Show(icon)
    end
    -- furious_slash,if=talent.furious_slash.enabled&(buff.furious_slash.stack<3|buff.furious_slash.remains<3|(cooldown.recklessness.remains<3&buff.furious_slash.remains<9))
    if A.FuriousSlash:IsReady(unit) and (A.FuriousSlash:IsSpellLearned() and (Unit("player"):HasBuffsStacks(A.FuriousSlashBuff) < 3 or Unit("player"):HasBuffs(A.FuriousSlashBuff) < 3 or (A.Recklessness:GetCooldown() < 3 and Unit("player"):HasBuffs(A.FuriousSlashBuff) < 9))) then
        return A.FuriousSlash:Show(icon)
    end
    -- bloodthirst,if=equipped.kazzalax_fujiedas_fury&(buff.fujiedas_fury.down|remains<2)
    if A.Bloodthirst:IsReady(unit) and (A.KazzalaxFujiedasFury:IsEquipped and (bool(Unit("player"):HasBuffsDown(A.FujiedasFuryBuff)) or remains < 2)) then
        return A.Bloodthirst:Show(icon)
    end
    -- rampage,if=cooldown.recklessness.remains<3
    if A.Rampage:IsReady(unit) and (A.Recklessness:GetCooldown() < 3) then
        return A.Rampage:Show(icon)
    end
    -- recklessness
    if A.Recklessness:IsReady(unit) and A.BurstIsON(unit) then
        return A.Recklessness:Show(icon)
    end
    -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
    if A.Whirlwind:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and not Unit("player"):HasBuffs(A.MeatCleaverBuff)) then
        return A.Whirlwind:Show(icon)
    end
    -- blood_fury,if=buff.recklessness.up
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff)) then
        return A.BloodFury:Show(icon)
    end
    -- berserking,if=buff.recklessness.up
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff)) then
        return A.Berserking:Show(icon)
    end
    -- lights_judgment,if=buff.recklessness.down
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.RecklessnessBuff))) then
        return A.LightsJudgment:Show(icon)
    end
    -- fireblood,if=buff.recklessness.up
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff)) then
        return A.Fireblood:Show(icon)
    end
    -- ancestral_call,if=buff.recklessness.up
    if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff)) then
        return A.AncestralCall:Show(icon)
    end
    -- run_action_list,name=single_target
    if (true) then
      return SingleTarget(unit);
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 