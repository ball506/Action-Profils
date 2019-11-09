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
Action[ACTION_CONST_PALADIN_RETRIBUTION] = {
  ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
  WakeofAshes                            = Action.Create({Type = "Spell", ID = 255937 }),
  AvengingWrathBuff                      = Action.Create({Type = "Spell", ID = 31884 }),
  CrusadeBuff                            = Action.Create({Type = "Spell", ID = 231895 }),
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  ShieldofVengeance                      = Action.Create({Type = "Spell", ID = 184662 }),
  AvengingWrath                          = Action.Create({Type = "Spell", ID = 31884 }),
  InquisitionBuff                        = Action.Create({Type = "Spell", ID = 84963 }),
  Inquisition                            = Action.Create({Type = "Spell", ID = 84963 }),
  Crusade                                = Action.Create({Type = "Spell", ID = 231895 }),
  RighteousVerdict                       = Action.Create({Type = "Spell", ID = 267610 }),
  ExecutionSentence                      = Action.Create({Type = "Spell", ID = 267798 }),
  DivineStorm                            = Action.Create({Type = "Spell", ID = 53385 }),
  DivinePurposeBuff                      = Action.Create({Type = "Spell", ID = 223819 }),
  EmpyreanPowerBuff                      = Action.Create({Type = "Spell", ID = 286393 }),
  JudgmentDebuff                         = Action.Create({Type = "Spell", ID = 197277 }),
  TemplarsVerdict                        = Action.Create({Type = "Spell", ID = 85256 }),
  HammerofWrath                          = Action.Create({Type = "Spell", ID = 24275 }),
  BladeofJustice                         = Action.Create({Type = "Spell", ID = 184575 }),
  Judgment                               = Action.Create({Type = "Spell", ID = 20271 }),
  Consecration                           = Action.Create({Type = "Spell", ID = 205228 }),
  CrusaderStrike                         = Action.Create({Type = "Spell", ID = 35395 }),
  Sequence                               = Action.Create({Type = "Spell", ID =  }),
  Rebuke                                 = Action.Create({Type = "Spell", ID = 96231 })
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
Action:CreateEssencesFor(ACTION_CONST_PALADIN_RETRIBUTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_RETRIBUTION], { __index = Action })


-- Variables
local VarDsCastable = 0;
local VarHow = 0;

HL:RegisterForEvent(function()
  VarDsCastable = 0
  VarHow = 0
end, "PLAYER_REGEN_ENABLED")

local EnemyRanges = {40, 8, 5}
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
     local Precombat, Cooldowns, Finishers, Generators, Opener
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
    -- arcane_torrent,if=!talent.wake_of_ashes.enabled
    if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (not A.WakeofAshes:IsSpellLearned()) then
        return A.ArcaneTorrent:Show(icon)
    end
    end
    local function Cooldowns(unit)
        -- use_item,name=jes_howler,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
    if A.JesHowler:IsReady(unit) and (Unit("player"):HasBuffs(A.AvengingWrathBuff) or Unit("player"):HasBuffs(A.CrusadeBuff) and Unit("player"):HasBuffsStacks(A.CrusadeBuff) == 10) then
      A.JesHowler:Show(icon)
    end
    -- potion,if=(buff.bloodlust.react|buff.avenging_wrath.up|buff.crusade.up&buff.crusade.remains<25|target.time_to_die<=40)
    if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and ((Unit("player"):HasHeroism or Unit("player"):HasBuffs(A.AvengingWrathBuff) or Unit("player"):HasBuffs(A.CrusadeBuff) and Unit("player"):HasBuffs(A.CrusadeBuff) < 25 or Unit(unit):TimeToDie() <= 40)) then
      A.BattlePotionofStrength:Show(icon)
    end
    -- lights_judgment,if=spell_targets.lights_judgment>=2|(!raid_event.adds.exists|raid_event.adds.in>75)
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 75)) then
        return A.LightsJudgment:Show(icon)
    end
    -- fireblood,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AvengingWrathBuff) or Unit("player"):HasBuffs(A.CrusadeBuff) and Unit("player"):HasBuffsStacks(A.CrusadeBuff) == 10) then
        return A.Fireblood:Show(icon)
    end
    -- shield_of_vengeance
    if A.ShieldofVengeance:IsReady(unit) then
        return A.ShieldofVengeance:Show(icon)
    end
    -- avenging_wrath,if=buff.inquisition.up|!talent.inquisition.enabled
    if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.InquisitionBuff) or not A.Inquisition:IsSpellLearned()) then
        return A.AvengingWrath:Show(icon)
    end
    -- crusade,if=holy_power>=4
    if A.Crusade:IsReady(unit) and A.BurstIsON(unit) and (Player:HolyPower() >= 4) then
        return A.Crusade:Show(icon)
    end
    end
    local function Finishers(unit)
        -- variable,name=ds_castable,value=spell_targets.divine_storm>=2&!talent.righteous_verdict.enabled|spell_targets.divine_storm>=3&talent.righteous_verdict.enabled
    if (true) then
      VarDsCastable = num(MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and not A.RighteousVerdict:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and A.RighteousVerdict:IsSpellLearned())
    end
    -- inquisition,if=buff.inquisition.down|buff.inquisition.remains<5&holy_power>=3|talent.execution_sentence.enabled&cooldown.execution_sentence.remains<10&buff.inquisition.remains<15|cooldown.avenging_wrath.remains<15&buff.inquisition.remains<20&holy_power>=3
    if A.Inquisition:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.InquisitionBuff)) or Unit("player"):HasBuffs(A.InquisitionBuff) < 5 and Player:HolyPower() >= 3 or A.ExecutionSentence:IsSpellLearned() and A.ExecutionSentence:GetCooldown() < 10 and Unit("player"):HasBuffs(A.InquisitionBuff) < 15 or A.AvengingWrath:GetCooldown() < 15 and Unit("player"):HasBuffs(A.InquisitionBuff) < 20 and Player:HolyPower() >= 3) then
        return A.Inquisition:Show(icon)
    end
    -- execution_sentence,if=spell_targets.divine_storm<=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
    if A.ExecutionSentence:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2 and (not A.Crusade:IsSpellLearned() or A.Crusade:GetCooldown() > A.GetGCD() * 2)) then
        return A.ExecutionSentence:Show(icon)
    end
    -- divine_storm,if=variable.ds_castable&buff.divine_purpose.react
    if A.DivineStorm:IsReady(unit) and (bool(VarDsCastable) and bool(Unit("player"):HasBuffsStacks(A.DivinePurposeBuff))) then
        return A.DivineStorm:Show(icon)
    end
    -- divine_storm,if=variable.ds_castable&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)|buff.empyrean_power.up&debuff.judgment.down&buff.divine_purpose.down
    if A.DivineStorm:IsReady(unit) and (bool(VarDsCastable) and (not A.Crusade:IsSpellLearned() or A.Crusade:GetCooldown() > A.GetGCD() * 2) or Unit("player"):HasBuffs(A.EmpyreanPowerBuff) and bool(Target:HasDeBuffsDown(A.JudgmentDebuff)) and bool(Unit("player"):HasBuffsDown(A.DivinePurposeBuff))) then
        return A.DivineStorm:Show(icon)
    end
    -- templars_verdict,if=buff.divine_purpose.react
    if A.TemplarsVerdict:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.DivinePurposeBuff))) then
        return A.TemplarsVerdict:Show(icon)
    end
    -- templars_verdict,if=(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence.enabled|buff.crusade.up&buff.crusade.stack<10|cooldown.execution_sentence.remains>gcd*2)
    if A.TemplarsVerdict:IsReady(unit) and ((not A.Crusade:IsSpellLearned() or A.Crusade:GetCooldown() > A.GetGCD() * 3) and (not A.ExecutionSentence:IsSpellLearned() or Unit("player"):HasBuffs(A.CrusadeBuff) and Unit("player"):HasBuffsStacks(A.CrusadeBuff) < 10 or A.ExecutionSentence:GetCooldown() > A.GetGCD() * 2)) then
        return A.TemplarsVerdict:Show(icon)
    end
    end
    local function Generators(unit)
        -- variable,name=HoW,value=(!talent.hammer_of_wrath.enabled|target.health.pct>=20&(buff.avenging_wrath.down|buff.crusade.down))
    if (true) then
      VarHow = num((not A.HammerofWrath:IsSpellLearned() or Unit(unit):HealthPercent >= 20 and (bool(Unit("player"):HasBuffsDown(A.AvengingWrathBuff)) or bool(Unit("player"):HasBuffsDown(A.CrusadeBuff)))))
    end
    -- call_action_list,name=finishers,if=holy_power>=5
    if (Player:HolyPower() >= 5) then
      local ShouldReturn = Finishers(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- wake_of_ashes,if=(!raid_event.adds.exists|raid_event.adds.in>15|spell_targets.wake_of_ashes>=2)&(holy_power<=0|holy_power=1&cooldown.blade_of_justice.remains>gcd)
    if A.WakeofAshes:IsReady(unit) and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 15 or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) and (Player:HolyPower() <= 0 or Player:HolyPower() == 1 and A.BladeofJustice:GetCooldown() > A.GetGCD())) then
        return A.WakeofAshes:Show(icon)
    end
    -- blade_of_justice,if=holy_power<=2|(holy_power=3&(cooldown.hammer_of_wrath.remains>gcd*2|variable.HoW))
    if A.BladeofJustice:IsReady(unit) and (Player:HolyPower() <= 2 or (Player:HolyPower() == 3 and (A.HammerofWrath:GetCooldown() > A.GetGCD() * 2 or bool(VarHow)))) then
        return A.BladeofJustice:Show(icon)
    end
    -- judgment,if=holy_power<=2|(holy_power<=4&(cooldown.blade_of_justice.remains>gcd*2|variable.HoW))
    if A.Judgment:IsReady(unit) and (Player:HolyPower() <= 2 or (Player:HolyPower() <= 4 and (A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or bool(VarHow)))) then
        return A.Judgment:Show(icon)
    end
    -- hammer_of_wrath,if=holy_power<=4
    if A.HammerofWrath:IsReady(unit) and (Player:HolyPower() <= 4) then
        return A.HammerofWrath:Show(icon)
    end
    -- consecration,if=holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2
    if A.Consecration:IsReady(unit) and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2) then
        return A.Consecration:Show(icon)
    end
    -- call_action_list,name=finishers,if=talent.hammer_of_wrath.enabled&(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up)
    if (A.HammerofWrath:IsSpellLearned() and (Unit(unit):HealthPercent <= 20 or Unit("player"):HasBuffs(A.AvengingWrathBuff) or Unit("player"):HasBuffs(A.CrusadeBuff))) then
      local ShouldReturn = Finishers(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2&cooldown.consecration.remains>gcd*2)
    if A.CrusaderStrike:IsReady(unit) and (A.CrusaderStrike:ChargesFractionalP() >= 1.75 and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 or Player:HolyPower() == 4 and A.BladeofJustice:GetCooldown() > A.GetGCD() * 2 and A.Judgment:GetCooldown() > A.GetGCD() * 2 and A.Consecration:GetCooldown() > A.GetGCD() * 2)) then
        return A.CrusaderStrike:Show(icon)
    end
    -- call_action_list,name=finishers
    if (true) then
      local ShouldReturn = Finishers(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- crusader_strike,if=holy_power<=4
    if A.CrusaderStrike:IsReady(unit) and (Player:HolyPower() <= 4) then
        return A.CrusaderStrike:Show(icon)
    end
    -- arcane_torrent,if=holy_power<=4
    if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (Player:HolyPower() <= 4) then
        return A.ArcaneTorrent:Show(icon)
    end
    end
    local function Opener(unit)
        -- sequence,if=talent.wake_of_ashes.enabled&talent.crusade.enabled&talent.execution_sentence.enabled&!talent.hammer_of_wrath.enabled,name=wake_opener_ES_CS:shield_of_vengeance:blade_of_justice:judgment:crusade:templars_verdict:wake_of_ashes:templars_verdict:crusader_strike:execution_sentence
    if A.Sequence:IsReady(unit) and (A.WakeofAshes:IsSpellLearned() and A.Crusade:IsSpellLearned() and A.ExecutionSentence:IsSpellLearned() and not A.HammerofWrath:IsSpellLearned()) then
        return A.Sequence:Show(icon)
    end
    -- sequence,if=talent.wake_of_ashes.enabled&talent.crusade.enabled&!talent.execution_sentence.enabled&!talent.hammer_of_wrath.enabled,name=wake_opener_CS:shield_of_vengeance:blade_of_justice:judgment:crusade:templars_verdict:wake_of_ashes:templars_verdict:crusader_strike:templars_verdict
    if A.Sequence:IsReady(unit) and (A.WakeofAshes:IsSpellLearned() and A.Crusade:IsSpellLearned() and not A.ExecutionSentence:IsSpellLearned() and not A.HammerofWrath:IsSpellLearned()) then
        return A.Sequence:Show(icon)
    end
    -- sequence,if=talent.wake_of_ashes.enabled&talent.crusade.enabled&talent.execution_sentence.enabled&talent.hammer_of_wrath.enabled,name=wake_opener_ES_HoW:shield_of_vengeance:blade_of_justice:judgment:crusade:templars_verdict:wake_of_ashes:templars_verdict:hammer_of_wrath:execution_sentence
    if A.Sequence:IsReady(unit) and (A.WakeofAshes:IsSpellLearned() and A.Crusade:IsSpellLearned() and A.ExecutionSentence:IsSpellLearned() and A.HammerofWrath:IsSpellLearned()) then
        return A.Sequence:Show(icon)
    end
    -- sequence,if=talent.wake_of_ashes.enabled&talent.crusade.enabled&!talent.execution_sentence.enabled&talent.hammer_of_wrath.enabled,name=wake_opener_HoW:shield_of_vengeance:blade_of_justice:judgment:crusade:templars_verdict:wake_of_ashes:templars_verdict:hammer_of_wrath:templars_verdict
    if A.Sequence:IsReady(unit) and (A.WakeofAshes:IsSpellLearned() and A.Crusade:IsSpellLearned() and not A.ExecutionSentence:IsSpellLearned() and A.HammerofWrath:IsSpellLearned()) then
        return A.Sequence:Show(icon)
    end
    -- sequence,if=talent.wake_of_ashes.enabled&talent.inquisition.enabled,name=wake_opener_Inq:shield_of_vengeance:blade_of_justice:judgment:inquisition:avenging_wrath:wake_of_ashes
    if A.Sequence:IsReady(unit) and (A.WakeofAshes:IsSpellLearned() and A.Inquisition:IsSpellLearned()) then
        return A.Sequence:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack
    -- rebuke
    if A.Rebuke:IsReady(unit) and Action.GetToggle.InterruptEnabled then
        return A.Rebuke:Show(icon)
    end
    -- call_action_list,name=opener
    if (true) then
      local ShouldReturn = Opener(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=cooldowns
    if A.BurstIsON(unit) then
      local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=generators
    if (true) then
      local ShouldReturn = Generators(unit); if ShouldReturn then return ShouldReturn; end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 