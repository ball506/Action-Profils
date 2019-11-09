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
Action[ACTION_CONST_WARRIOR_PROTECTION] = {
  ThunderClap                            = Action.Create({Type = "Spell", ID = 6343 }),
  DemoralizingShout                      = Action.Create({Type = "Spell", ID = 1160 }),
  BoomingVoice                           = Action.Create({Type = "Spell", ID = 202743 }),
  DragonRoar                             = Action.Create({Type = "Spell", ID = 118000 }),
  Revenge                                = Action.Create({Type = "Spell", ID = 6572 }),
  Ravager                                = Action.Create({Type = "Spell", ID = 228920 }),
  ShieldBlock                            = Action.Create({Type = "Spell", ID = 2565 }),
  ShieldSlam                             = Action.Create({Type = "Spell", ID = 23922 }),
  ShieldBlockBuff                        = Action.Create({Type = "Spell", ID = 132404 }),
  UnstoppableForce                       = Action.Create({Type = "Spell", ID = 275336 }),
  AvatarBuff                             = Action.Create({Type = "Spell", ID = 107574 }),
  BraceForImpact                         = Action.Create({Type = "Spell", ID = 277636 }),
  DeafeningCrash                         = Action.Create({Type = "Spell", ID = 272824 }),
  Devastate                              = Action.Create({Type = "Spell", ID = 20243 }),
  Intercept                              = Action.Create({Type = "Spell", ID = 198304 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
  IgnorePain                             = Action.Create({Type = "Spell", ID = 190456 }),
  Avatar                                 = Action.Create({Type = "Spell", ID = 107574 })
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
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_PROTECTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_PROTECTION], { __index = Action })



local EnemyRanges = {5}
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
     local Precombat, Aoe, St
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
    end
    local function Aoe(unit)
        -- thunder_clap
    if A.ThunderClap:IsReady(unit) then
        return A.ThunderClap:Show(icon)
    end
    -- demoralizing_shout,if=talent.booming_voice.enabled
    if A.DemoralizingShout:IsReady(unit) and (A.BoomingVoice:IsSpellLearned()) then
        return A.DemoralizingShout:Show(icon)
    end
    -- dragon_roar
    if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
        return A.DragonRoar:Show(icon)
    end
    -- revenge
    if A.Revenge:IsReady(unit) then
        return A.Revenge:Show(icon)
    end
    -- ravager
    if A.Ravager:IsReady(unit) then
        return A.Ravager:Show(icon)
    end
    -- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down
    if A.ShieldBlock:IsReady(unit) and (A.ShieldSlam:HasCooldownUps and bool(Unit("player"):HasBuffsDown(A.ShieldBlockBuff))) then
        return A.ShieldBlock:Show(icon)
    end
    -- shield_slam
    if A.ShieldSlam:IsReady(unit) then
        return A.ShieldSlam:Show(icon)
    end
    end
    local function St(unit)
        -- thunder_clap,if=spell_targets.thunder_clap=2&talent.unstoppable_force.enabled&buff.avatar.up
    if A.ThunderClap:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) == 2 and A.UnstoppableForce:IsSpellLearned() and Unit("player"):HasBuffs(A.AvatarBuff)) then
        return A.ThunderClap:Show(icon)
    end
    -- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down&azerite.brace_for_impact.rank>azerite.deafening_crash.rank&buff.avatar.up
    if A.ShieldBlock:IsReady(unit) and (A.ShieldSlam:HasCooldownUps and bool(Unit("player"):HasBuffsDown(A.ShieldBlockBuff)) and A.BraceForImpact:GetAzeriteRank > A.DeafeningCrash:GetAzeriteRank and Unit("player"):HasBuffs(A.AvatarBuff)) then
        return A.ShieldBlock:Show(icon)
    end
    -- shield_slam,if=azerite.brace_for_impact.rank>azerite.deafening_crash.rank&buff.avatar.up&buff.shield_block.up
    if A.ShieldSlam:IsReady(unit) and (A.BraceForImpact:GetAzeriteRank > A.DeafeningCrash:GetAzeriteRank and Unit("player"):HasBuffs(A.AvatarBuff) and Unit("player"):HasBuffs(A.ShieldBlockBuff)) then
        return A.ShieldSlam:Show(icon)
    end
    -- thunder_clap,if=(talent.unstoppable_force.enabled&buff.avatar.up)
    if A.ThunderClap:IsReady(unit) and ((A.UnstoppableForce:IsSpellLearned() and Unit("player"):HasBuffs(A.AvatarBuff))) then
        return A.ThunderClap:Show(icon)
    end
    -- demoralizing_shout,if=talent.booming_voice.enabled
    if A.DemoralizingShout:IsReady(unit) and (A.BoomingVoice:IsSpellLearned()) then
        return A.DemoralizingShout:Show(icon)
    end
    -- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down
    if A.ShieldBlock:IsReady(unit) and (A.ShieldSlam:HasCooldownUps and bool(Unit("player"):HasBuffsDown(A.ShieldBlockBuff))) then
        return A.ShieldBlock:Show(icon)
    end
    -- shield_slam
    if A.ShieldSlam:IsReady(unit) then
        return A.ShieldSlam:Show(icon)
    end
    -- dragon_roar
    if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
        return A.DragonRoar:Show(icon)
    end
    -- thunder_clap
    if A.ThunderClap:IsReady(unit) then
        return A.ThunderClap:Show(icon)
    end
    -- revenge
    if A.Revenge:IsReady(unit) then
        return A.Revenge:Show(icon)
    end
    -- ravager
    if A.Ravager:IsReady(unit) then
        return A.Ravager:Show(icon)
    end
    -- devastate
    if A.Devastate:IsReady(unit) then
        return A.Devastate:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack
    -- intercept,if=time=0
    if A.Intercept:IsReady(unit) and (Unit("player"):CombatTime == 0) then
        return A.Intercept:Show(icon)
    end
    -- use_items,if=cooldown.avatar.remains>20
    -- use_item,name=grongs_primal_rage,if=buff.avatar.down
    if A.GrongsPrimalRage:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.AvatarBuff))) then
      A.GrongsPrimalRage:Show(icon)
    end
    -- blood_fury
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) then
        return A.BloodFury:Show(icon)
    end
    -- berserking
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
        return A.Berserking:Show(icon)
    end
    -- arcane_torrent
    if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) then
        return A.ArcaneTorrent:Show(icon)
    end
    -- lights_judgment
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
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
    -- potion,if=buff.avatar.up|target.time_to_die<25
    if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.AvatarBuff) or Unit(unit):TimeToDie() < 25) then
      A.BattlePotionofStrength:Show(icon)
    end
    -- ignore_pain,if=rage.deficit<25+20*talent.booming_voice.enabled*cooldown.demoralizing_shout.ready
    if A.IgnorePain:IsReady(unit) and (Player:RageDeficit() < 25 + 20 * num(A.BoomingVoice:IsSpellLearned()) * num(A.DemoralizingShout:HasCooldownUps)) then
        return A.IgnorePain:Show(icon)
    end
    -- avatar
    if A.Avatar:IsReady(unit) and A.BurstIsON(unit) then
        return A.Avatar:Show(icon)
    end
    -- run_action_list,name=aoe,if=spell_targets.thunder_clap>=3
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
      return Aoe(unit);
    end
    -- call_action_list,name=st
    if (true) then
      local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 