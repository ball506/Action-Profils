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
Action[ACTION_CONST_PRIEST_HOLY] = {
  Smite                                  = Action.Create({Type = "Spell", ID =  }),
  HolyFire                               = Action.Create({Type = "Spell", ID =  }),
  HolyFireDebuff                         = Action.Create({Type = "Spell", ID =  }),
  HolyWordChastise                       = Action.Create({Type = "Spell", ID =  }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
  DivineStar                             = Action.Create({Type = "Spell", ID =  }),
  Halo                                   = Action.Create({Type = "Spell", ID =  }),
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  ArcanePulse                            = Action.Create({Type = "Spell", ID =  }),
  HolyNova                               = Action.Create({Type = "Spell", ID =  }),
  Apotheosis                             = Action.Create({Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_PRIEST_HOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PRIEST_HOLY], { __index = Action })



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
     local Precombat
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
       local function Precombat(unit)
        -- flask
    -- food
    -- augmentation
    -- snapshot_stats
    -- potion
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- smite
    if A.Smite:IsReady(unit) then
        return A.Smite:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- use_items
    -- potion,if=buff.bloodlust.react|(raid_event.adds.up&(raid_event.adds.remains>20|raid_event.adds.duration<20))|target.time_to_die<=30
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism or ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (0 > 20 or raid_event.adds.duration < 20)) or Unit(unit):TimeToDie() <= 30) then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- holy_fire,if=dot.holy_fire.ticking&(dot.holy_fire.remains<=gcd|dot.holy_fire.stack<2)&spell_targets.holy_nova<7
    if A.HolyFire:IsReady(unit) and (Target:HasDebuffs(A.HolyFireDebuff) and (Target:HasDebuffs(A.HolyFireDebuff) <= A.GetGCD() or Target:HasDebuffsStacks(A.HolyFireDebuff) < 2) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 7) then
        return A.HolyFire:Show(icon)
    end
    -- holy_word_chastise,if=spell_targets.holy_nova<5
    if A.HolyWordChastise:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 5) then
        return A.HolyWordChastise:Show(icon)
    end
    -- holy_fire,if=dot.holy_fire.ticking&(dot.holy_fire.refreshable|dot.holy_fire.stack<2)&spell_targets.holy_nova<7
    if A.HolyFire:IsReady(unit) and (Target:HasDebuffs(A.HolyFireDebuff) and (Target:HasDebuffsRefreshable(A.HolyFireDebuff) or Target:HasDebuffsStacks(A.HolyFireDebuff) < 2) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 7) then
        return A.HolyFire:Show(icon)
    end
    -- berserking,if=raid_event.adds.in>30|raid_event.adds.remains>8|raid_event.adds.duration<8
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (10000000000 > 30 or 0 > 8 or raid_event.adds.duration < 8) then
        return A.Berserking:Show(icon)
    end
    -- fireblood,if=raid_event.adds.in>20|raid_event.adds.remains>6|raid_event.adds.duration<6
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (10000000000 > 20 or 0 > 6 or raid_event.adds.duration < 6) then
        return A.Fireblood:Show(icon)
    end
    -- ancestral_call,if=raid_event.adds.in>20|raid_event.adds.remains>10|raid_event.adds.duration<10
    if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (10000000000 > 20 or 0 > 10 or raid_event.adds.duration < 10) then
        return A.AncestralCall:Show(icon)
    end
    -- divine_star,if=(raid_event.adds.in>5|raid_event.adds.remains>2|raid_event.adds.duration<2)&spell_targets.divine_star>1
    if A.DivineStar:IsReady(unit) and ((10000000000 > 5 or 0 > 2 or raid_event.adds.duration < 2) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
        return A.DivineStar:Show(icon)
    end
    -- halo,if=(raid_event.adds.in>14|raid_event.adds.remains>2|raid_event.adds.duration<2)&spell_targets.halo>0
    if A.Halo:IsReady(unit) and ((10000000000 > 14 or 0 > 2 or raid_event.adds.duration < 2) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 0) then
        return A.Halo:Show(icon)
    end
    -- lights_judgment,if=raid_event.adds.in>50|raid_event.adds.remains>4|raid_event.adds.duration<4
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (10000000000 > 50 or 0 > 4 or raid_event.adds.duration < 4) then
        return A.LightsJudgment:Show(icon)
    end
    -- arcane_pulse,if=(raid_event.adds.in>40|raid_event.adds.remains>2|raid_event.adds.duration<2)&spell_targets.arcane_pulse>2
    if A.ArcanePulse:IsReady(unit) and ((10000000000 > 40 or 0 > 2 or raid_event.adds.duration < 2) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
        return A.ArcanePulse:Show(icon)
    end
    -- holy_fire,if=!dot.holy_fire.ticking&spell_targets.holy_nova<7
    if A.HolyFire:IsReady(unit) and (not Target:HasDebuffs(A.HolyFireDebuff) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 7) then
        return A.HolyFire:Show(icon)
    end
    -- holy_nova,if=spell_targets.holy_nova>3
    if A.HolyNova:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
        return A.HolyNova:Show(icon)
    end
    -- apotheosis,if=active_enemies<5&(raid_event.adds.in>15|raid_event.adds.in>raid_event.adds.cooldown-5)
    if A.Apotheosis:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 5 and (10000000000 > 15 or 10000000000 > raid_event.adds.cooldown - 5)) then
        return A.Apotheosis:Show(icon)
    end
    -- smite
    if A.Smite:IsReady(unit) then
        return A.Smite:Show(icon)
    end
    -- holy_fire
    if A.HolyFire:IsReady(unit) then
        return A.HolyFire:Show(icon)
    end
    -- divine_star,if=(raid_event.adds.in>5|raid_event.adds.remains>2|raid_event.adds.duration<2)&spell_targets.divine_star>0
    if A.DivineStar:IsReady(unit) and ((10000000000 > 5 or 0 > 2 or raid_event.adds.duration < 2) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 0) then
        return A.DivineStar:Show(icon)
    end
    -- holy_nova,if=raid_event.movement.remains>gcd*0.3&spell_targets.holy_nova>0
    if A.HolyNova:IsReady(unit) and (raid_event.movement.remains > A.GetGCD() * 0.3 and MultiUnits:GetByRangeInCombat(40, 5, 10) > 0) then
        return A.HolyNova:Show(icon)
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 