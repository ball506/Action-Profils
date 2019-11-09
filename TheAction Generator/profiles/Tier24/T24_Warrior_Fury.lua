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
  MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
  GuardianofAzeroth                      = Action.Create({Type = "Spell", ID =  }),
  RecklessnessBuff                       = Action.Create({Type = "Spell", ID = 1719 }),
  Recklessness                           = Action.Create({Type = "Spell", ID = 1719 }),
  HeroicLeap                             = Action.Create({Type = "Spell", ID = 6544 }),
  Siegebreaker                           = Action.Create({Type = "Spell", ID = 280772 }),
  Rampage                                = Action.Create({Type = "Spell", ID = 184367 }),
  MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
  FrothingBerserker                      = Action.Create({Type = "Spell", ID = 215571 }),
  Carnage                                = Action.Create({Type = "Spell", ID = 202922 }),
  EnrageBuff                             = Action.Create({Type = "Spell", ID = 184362 }),
  Massacre                               = Action.Create({Type = "Spell", ID = 206315 }),
  Execute                                = Action.Create({Type = "Spell", ID = 5308 }),
  FuriousSlash                           = Action.Create({Type = "Spell", ID = 100130 }),
  FuriousSlashBuff                       = Action.Create({Type = "Spell", ID = 202539 }),
  Bladestorm                             = Action.Create({Type = "Spell", ID = 46924 }),
  Bloodthirst                            = Action.Create({Type = "Spell", ID = 23881 }),
  ColdSteelHotBlood                      = Action.Create({Type = "Spell", ID =  }),
  DragonRoar                             = Action.Create({Type = "Spell", ID = 118000 }),
  RagingBlow                             = Action.Create({Type = "Spell", ID = 85288 }),
  Whirlwind                              = Action.Create({Type = "Spell", ID = 190411 }),
  Charge                                 = Action.Create({Type = "Spell", ID = 100 }),
  BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
  PurifyingBlast                         = Action.Create({Type = "Spell", ID =  }),
  SiegebreakerBuff                       = Action.Create({Type = "Spell", ID =  }),
  RippleInSpace                          = Action.Create({Type = "Spell", ID =  }),
  WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
  FocusedAzeriteBeam                     = Action.Create({Type = "Spell", ID =  }),
  ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
  ConcentratedFlameBurnDebuff            = Action.Create({Type = "Spell", ID =  }),
  TheUnboundForce                        = Action.Create({Type = "Spell", ID =  }),
  RecklessForceBuff                      = Action.Create({Type = "Spell", ID =  }),
  GuardianofAzerothBuff                  = Action.Create({Type = "Spell", ID =  }),
  MeatCleaverBuff                        = Action.Create({Type = "Spell", ID = 280392 }),
  RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
  ConductiveInkDeBuffDebuff              = Action.Create({Type = "Spell", ID =  }),
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
    -- use_item,name=azsharas_font_of_power
    if A.AzsharasFontofPower:IsReady(unit) then
      A.AzsharasFontofPower:Show(icon)
    end
    -- memory_of_lucid_dreams
    if A.MemoryofLucidDreams:IsReady(unit) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    -- guardian_of_azeroth
    if A.GuardianofAzeroth:IsReady(unit) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- recklessness
    if A.Recklessness:IsReady(unit) and Player:HasBuffsDown(A.RecklessnessBuff) and A.BurstIsON(unit) then
        return A.Recklessness:Show(icon)
    end
    -- potion
    if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofStrength:Show(icon)
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
    -- rampage,if=(buff.recklessness.up|buff.memory_of_lucid_dreams.up)|(talent.frothing_berserker.enabled|talent.carnage.enabled&(buff.enrage.remains<gcd|rage>90)|talent.massacre.enabled&(buff.enrage.remains<gcd|rage>90))
    if A.Rampage:IsReady(unit) and ((Unit("player"):HasBuffs(A.RecklessnessBuff) or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff)) or (A.FrothingBerserker:IsSpellLearned() or A.Carnage:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff) < A.GetGCD() or Player:Rage() > 90) or A.Massacre:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff) < A.GetGCD() or Player:Rage() > 90))) then
        return A.Rampage:Show(icon)
    end
    -- execute
    if A.Execute:IsReady(unit) then
        return A.Execute:Show(icon)
    end
    -- furious_slash,if=!buff.bloodlust.up&buff.furious_slash.remains<3
    if A.FuriousSlash:IsReady(unit) and (not Unit("player"):HasHeroism and Unit("player"):HasBuffs(A.FuriousSlashBuff) < 3) then
        return A.FuriousSlash:Show(icon)
    end
    -- bladestorm,if=prev_gcd.1.rampage
    if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):GetSpellLastCast(A.Rampage)) then
        return A.Bladestorm:Show(icon)
    end
    -- bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1
    if A.Bloodthirst:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.EnrageBuff)) or A.ColdSteelHotBlood:GetAzeriteRank > 1) then
        return A.Bloodthirst:Show(icon)
    end
    -- dragon_roar,if=buff.enrage.up
    if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.EnrageBuff)) then
        return A.DragonRoar:Show(icon)
    end
    -- raging_blow,if=charges=2
    if A.RagingBlow:IsReady(unit) and (A.RagingBlow:ChargesP() == 2) then
        return A.RagingBlow:Show(icon)
    end
    -- bloodthirst
    if A.Bloodthirst:IsReady(unit) then
        return A.Bloodthirst:Show(icon)
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
    -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
    if A.HeroicLeap:IsReady(unit) and ((raid_event.movement.distance > 25 and 10000000000 > 45)) then
        return A.HeroicLeap:Show(icon)
    end
    -- potion
    if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofStrength:Show(icon)
    end
    -- rampage,if=cooldown.recklessness.remains<3
    if A.Rampage:IsReady(unit) and (A.Recklessness:GetCooldown() < 3) then
        return A.Rampage:Show(icon)
    end
    -- blood_of_the_enemy,if=buff.recklessness.up
    if A.BloodoftheEnemy:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff)) then
        return A.BloodoftheEnemy:Show(icon)
    end
    -- purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
    if A.PurifyingBlast:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff) and not Unit("player"):HasBuffs(A.SiegebreakerBuff)) then
        return A.PurifyingBlast:Show(icon)
    end
    -- ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
    if A.RippleInSpace:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff) and not Unit("player"):HasBuffs(A.SiegebreakerBuff)) then
        return A.RippleInSpace:Show(icon)
    end
    -- worldvein_resonance,if=!buff.recklessness.up&!buff.siegebreaker.up
    if A.WorldveinResonance:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff) and not Unit("player"):HasBuffs(A.SiegebreakerBuff)) then
        return A.WorldveinResonance:Show(icon)
    end
    -- focused_azerite_beam,if=!buff.recklessness.up&!buff.siegebreaker.up
    if A.FocusedAzeriteBeam:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff) and not Unit("player"):HasBuffs(A.SiegebreakerBuff)) then
        return A.FocusedAzeriteBeam:Show(icon)
    end
    -- concentrated_flame,if=!buff.recklessness.up&!buff.siegebreaker.up&dot.concentrated_flame_burn.remains=0
    if A.ConcentratedFlame:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff) and not Unit("player"):HasBuffs(A.SiegebreakerBuff) and Target:HasDeBuffs(A.ConcentratedFlameBurnDebuff) == 0) then
        return A.ConcentratedFlame:Show(icon)
    end
    -- the_unbound_force,if=buff.reckless_force.up
    if A.TheUnboundForce:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessForceBuff)) then
        return A.TheUnboundForce:Show(icon)
    end
    -- guardian_of_azeroth,if=!buff.recklessness.up
    if A.GuardianofAzeroth:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff)) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- memory_of_lucid_dreams,if=!buff.recklessness.up
    if A.MemoryofLucidDreams:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff)) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    -- recklessness,if=!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major|cooldown.guardian_of_azeroth.remains>20|buff.guardian_of_azeroth.up|cooldown.blood_of_the_enemy.remains<gcd
    if A.Recklessness:IsReady(unit) and A.BurstIsON(unit) and (not bool(essence.condensed_lifeforce.major) and not bool(essence.blood_of_the_enemy.major) or A.GuardianofAzeroth:GetCooldown() > 20 or Unit("player"):HasBuffs(A.GuardianofAzerothBuff) or A.BloodoftheEnemy:GetCooldown() < A.GetGCD()) then
        return A.Recklessness:Show(icon)
    end
    -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
    if A.Whirlwind:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and not Unit("player"):HasBuffs(A.MeatCleaverBuff)) then
        return A.Whirlwind:Show(icon)
    end
    -- use_item,name=ashvanes_razor_coral,if=!debuff.razor_coral_debuff.up|(target.health.pct<30.1&debuff.conductive_ink_debuff.up)|(!debuff.conductive_ink_debuff.up&buff.memory_of_lucid_dreams.up|prev_gcd.2.guardian_of_azeroth|prev_gcd.2.recklessness&(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major))
    if A.AshvanesRazorCoral:IsReady(unit) and (not Target:HasDeBuffs(A.RazorCoralDeBuffDebuff) or (Unit(unit):HealthPercent < 30.1 and Target:HasDeBuffs(A.ConductiveInkDeBuffDebuff)) or (not Target:HasDeBuffs(A.ConductiveInkDeBuffDebuff) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff) or Unit("player"):GetSpellLastCast(A.GuardianofAzeroth) or Unit("player"):GetSpellLastCast(A.Recklessness) and (not bool(essence.memory_of_lucid_dreams.major) and not bool(essence.condensed_lifeforce.major)))) then
      A.AshvanesRazorCoral:Show(icon)
    end
    -- blood_fury
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) then
        return A.BloodFury:Show(icon)
    end
    -- berserking
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
        return A.Berserking:Show(icon)
    end
    -- lights_judgment,if=buff.recklessness.down
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.RecklessnessBuff))) then
        return A.LightsJudgment:Show(icon)
    end
    -- fireblood
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) then
        return A.Fireblood:Show(icon)
    end
    -- ancestral_call
    if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) then
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
 