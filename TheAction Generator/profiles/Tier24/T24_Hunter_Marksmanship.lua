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
Action[ACTION_CONST_HUNTER_MARKSMANSHIP] = {
  HuntersMarkDebuff                      = Action.Create({Type = "Spell", ID = 257284 }),
  HuntersMark                            = Action.Create({Type = "Spell", ID = 257284 }),
  DoubleTap                              = Action.Create({Type = "Spell", ID = 260402 }),
  WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
  GuardianofAzeroth                      = Action.Create({Type = "Spell", ID =  }),
  MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
  TrueshotBuff                           = Action.Create({Type = "Spell", ID = 288613 }),
  Trueshot                               = Action.Create({Type = "Spell", ID = 288613 }),
  AimedShot                              = Action.Create({Type = "Spell", ID = 19434 }),
  RapidFire                              = Action.Create({Type = "Spell", ID = 257044 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  BerserkingBuff                         = Action.Create({Type = "Spell", ID = 26297 }),
  CarefulAim                             = Action.Create({Type = "Spell", ID = 260228 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  BloodFuryBuff                          = Action.Create({Type = "Spell", ID = 20572 }),
  AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  LifebloodBuff                          = Action.Create({Type = "Spell", ID =  }),
  RippleInSpace                          = Action.Create({Type = "Spell", ID =  }),
  PotionofUnbridledFuryBuff              = Action.Create({Type = "Spell", ID =  }),
  UnbridledFuryBuff                      = Action.Create({Type = "Spell", ID =  }),
  PreciseShotsBuff                       = Action.Create({Type = "Spell", ID = 260242 }),
  ExplosiveShot                          = Action.Create({Type = "Spell", ID = 212431 }),
  Barrage                                = Action.Create({Type = "Spell", ID = 120360 }),
  AMurderofCrows                         = Action.Create({Type = "Spell", ID = 131894 }),
  SerpentSting                           = Action.Create({Type = "Spell", ID = 271788 }),
  SerpentStingDebuff                     = Action.Create({Type = "Spell", ID = 271788 }),
  BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
  UnerringVisionBuff                     = Action.Create({Type = "Spell", ID = 274447 }),
  UnerringVision                         = Action.Create({Type = "Spell", ID = 274444 }),
  FocusedAzeriteBeam                     = Action.Create({Type = "Spell", ID =  }),
  ArcaneShot                             = Action.Create({Type = "Spell", ID = 185358 }),
  MasterMarksmanBuff                     = Action.Create({Type = "Spell", ID = 269576 }),
  MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
  DoubleTapBuff                          = Action.Create({Type = "Spell", ID =  }),
  PiercingShot                           = Action.Create({Type = "Spell", ID = 198670 }),
  PurifyingBlast                         = Action.Create({Type = "Spell", ID =  }),
  ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
  ConcentratedFlameBurnDebuff            = Action.Create({Type = "Spell", ID =  }),
  TheUnboundForce                        = Action.Create({Type = "Spell", ID =  }),
  RecklessForceBuff                      = Action.Create({Type = "Spell", ID =  }),
  RecklessForceCounterBuff               = Action.Create({Type = "Spell", ID =  }),
  FocusedFire                            = Action.Create({Type = "Spell", ID = 278531 }),
  SteadyShot                             = Action.Create({Type = "Spell", ID = 56641 }),
  TrickShotsBuff                         = Action.Create({Type = "Spell", ID = 257622 }),
  IntheRhythm                            = Action.Create({Type = "Spell", ID = 264198 }),
  SurgingShots                           = Action.Create({Type = "Spell", ID = 287707 }),
  Streamline                             = Action.Create({Type = "Spell", ID = 260367 }),
  Multishot                              = Action.Create({Type = "Spell", ID = 257620 }),
  GuardianofAzerothBuff                  = Action.Create({Type = "Spell", ID =  }),
  RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
  BloodoftheEnemyDebuff                  = Action.Create({Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_HUNTER_MARKSMANSHIP)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_MARKSMANSHIP], { __index = Action })



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
     local Precombat, Cds, St, Trickshots
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
       local function Precombat(unit)
        -- flask
    -- augmentation
    -- food
    -- snapshot_stats
    -- potion
    if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofAgility:Show(icon)
    end
    -- hunters_mark
    if A.HuntersMark:IsReady(unit) and Player:HasDebuffsDown(A.HuntersMarkDebuff) then
        return A.HuntersMark:Show(icon)
    end
    -- double_tap,precast_time=10
    if A.DoubleTap:IsReady(unit) then
        return A.DoubleTap:Show(icon)
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
    -- use_item,name=azsharas_font_of_power
    if A.AzsharasFontofPower:IsReady(unit) then
      A.AzsharasFontofPower:Show(icon)
    end
    -- trueshot,precast_time=1.5,if=active_enemies>2
    if A.Trueshot:IsReady(unit) and Player:HasBuffsDown(A.TrueshotBuff) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
        return A.Trueshot:Show(icon)
    end
    -- aimed_shot,if=active_enemies<3
    if A.AimedShot:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
        return A.AimedShot:Show(icon)
    end
    end
    local function Cds(unit)
        -- hunters_mark,if=debuff.hunters_mark.down&!buff.trueshot.up
    if A.HuntersMark:IsReady(unit) and (bool(Target:HasDeBuffsDown(A.HuntersMarkDebuff)) and not Unit("player"):HasBuffs(A.TrueshotBuff)) then
        return A.HuntersMark:Show(icon)
    end
    -- double_tap,if=cooldown.rapid_fire.remains<gcd|cooldown.rapid_fire.remains<cooldown.aimed_shot.remains|target.time_to_die<20
    if A.DoubleTap:IsReady(unit) and (A.RapidFire:GetCooldown() < A.GetGCD() or A.RapidFire:GetCooldown() < A.AimedShot:GetCooldown() or Unit(unit):TimeToDie() < 20) then
        return A.DoubleTap:Show(icon)
    end
    -- berserking,if=buff.trueshot.up&(target.time_to_die>cooldown.berserking.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<13
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) and (Unit(unit):TimeToDie() > A.Berserking:BaseDuration + A.BerserkingBuff:BaseDuration or (Unit(unit):HealthPercent < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 13) then
        return A.Berserking:Show(icon)
    end
    -- blood_fury,if=buff.trueshot.up&(target.time_to_die>cooldown.blood_fury.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<16
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) and (Unit(unit):TimeToDie() > A.BloodFury:BaseDuration + A.BloodFuryBuff:BaseDuration or (Unit(unit):HealthPercent < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
        return A.BloodFury:Show(icon)
    end
    -- ancestral_call,if=buff.trueshot.up&(target.time_to_die>cooldown.ancestral_call.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<16
    if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) and (Unit(unit):TimeToDie() > A.AncestralCall:BaseDuration + duration or (Unit(unit):HealthPercent < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
        return A.AncestralCall:Show(icon)
    end
    -- fireblood,if=buff.trueshot.up&(target.time_to_die>cooldown.fireblood.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<9
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) and (Unit(unit):TimeToDie() > A.Fireblood:BaseDuration + duration or (Unit(unit):HealthPercent < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 9) then
        return A.Fireblood:Show(icon)
    end
    -- lights_judgment
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
        return A.LightsJudgment:Show(icon)
    end
    -- worldvein_resonance,if=buff.lifeblood.stack<4&!buff.trueshot.up
    if A.WorldveinResonance:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.LifebloodBuff) < 4 and not Unit("player"):HasBuffs(A.TrueshotBuff)) then
        return A.WorldveinResonance:Show(icon)
    end
    -- guardian_of_azeroth,if=(ca_execute|target.time_to_die>cooldown.guardian_of_azeroth.duration+duration)&(buff.trueshot.up|cooldown.trueshot.remains<16)|target.time_to_die<31
    if A.GuardianofAzeroth:IsReady(unit) and ((bool(ca_execute) or Unit(unit):TimeToDie() > A.GuardianofAzeroth:BaseDuration + duration) and (Unit("player"):HasBuffs(A.TrueshotBuff) or A.Trueshot:GetCooldown() < 16) or Unit(unit):TimeToDie() < 31) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- ripple_in_space,if=cooldown.trueshot.remains<7
    if A.RippleInSpace:IsReady(unit) and (A.Trueshot:GetCooldown() < 7) then
        return A.RippleInSpace:Show(icon)
    end
    -- memory_of_lucid_dreams,if=!buff.trueshot.up
    if A.MemoryofLucidDreams:IsReady(unit) and (not Unit("player"):HasBuffs(A.TrueshotBuff)) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    -- potion,if=buff.trueshot.react&buff.bloodlust.react|buff.trueshot.up&ca_execute|((consumable.potion_of_unbridled_fury|consumable.unbridled_fury)&target.time_to_die<61|target.time_to_die<26)
    if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (bool(Unit("player"):HasBuffsStacks(A.TrueshotBuff)) and Unit("player"):HasHeroism or Unit("player"):HasBuffs(A.TrueshotBuff) and bool(ca_execute) or ((Unit(unit):HasBuffs(A.PotionofUnbridledFuryBuff) or Unit(unit):HasBuffs(A.UnbridledFuryBuff)) and Unit(unit):TimeToDie() < 61 or Unit(unit):TimeToDie() < 26)) then
      A.BattlePotionofAgility:Show(icon)
    end
    -- trueshot,if=focus>60&(buff.precise_shots.down&cooldown.rapid_fire.remains&target.time_to_die>cooldown.trueshot.duration_guess+duration|target.health.pct<20|!talent.careful_aim.enabled)|target.time_to_die<15
    if A.Trueshot:IsReady(unit) and (Player:Focus() > 60 and (bool(Unit("player"):HasBuffsDown(A.PreciseShotsBuff)) and bool(A.RapidFire:GetCooldown()) and Unit(unit):TimeToDie() > cooldown.trueshot.duration_guess + A.TrueshotBuff:BaseDuration or Unit(unit):HealthPercent < 20 or not A.CarefulAim:IsSpellLearned()) or Unit(unit):TimeToDie() < 15) then
        return A.Trueshot:Show(icon)
    end
    end
    local function St(unit)
        -- explosive_shot
    if A.ExplosiveShot:IsReady(unit) then
        return A.ExplosiveShot:Show(icon)
    end
    -- barrage,if=active_enemies>1
    if A.Barrage:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
        return A.Barrage:Show(icon)
    end
    -- a_murder_of_crows
    if A.AMurderofCrows:IsReady(unit) then
        return A.AMurderofCrows:Show(icon)
    end
    -- serpent_sting,if=refreshable&!action.serpent_sting.in_flight
    if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) and not A.SerpentSting:IsSpellInFlight()) then
        return A.SerpentSting:Show(icon)
    end
    -- rapid_fire,if=buff.trueshot.down|focus<70
    if A.RapidFire:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.TrueshotBuff)) or Player:Focus() < 70) then
        return A.RapidFire:Show(icon)
    end
    -- blood_of_the_enemy,if=buff.trueshot.up&(buff.unerring_vision.stack>4|!azerite.unerring_vision.enabled)|target.time_to_die<11
    if A.BloodoftheEnemy:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) and (Unit("player"):HasBuffsStacks(A.UnerringVisionBuff) > 4 or not A.UnerringVision:GetAzeriteRank) or Unit(unit):TimeToDie() < 11) then
        return A.BloodoftheEnemy:Show(icon)
    end
    -- focused_azerite_beam,if=!buff.trueshot.up|target.time_to_die<5
    if A.FocusedAzeriteBeam:IsReady(unit) and (not Unit("player"):HasBuffs(A.TrueshotBuff) or Unit(unit):TimeToDie() < 5) then
        return A.FocusedAzeriteBeam:Show(icon)
    end
    -- arcane_shot,if=buff.trueshot.up&buff.master_marksman.up&!buff.memory_of_lucid_dreams.up
    if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) and Unit("player"):HasBuffs(A.MasterMarksmanBuff) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff)) then
        return A.ArcaneShot:Show(icon)
    end
    -- aimed_shot,if=buff.trueshot.up|(buff.double_tap.down|ca_execute)&buff.precise_shots.down|full_recharge_time<cast_time&cooldown.trueshot.remains
    if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) or (bool(Unit("player"):HasBuffsDown(A.DoubleTapBuff)) or bool(ca_execute)) and bool(Unit("player"):HasBuffsDown(A.PreciseShotsBuff)) or A.AimedShot:FullRechargeTimeP() < A.AimedShot:GetSpellCastTime() and bool(A.Trueshot:GetCooldown())) then
        return A.AimedShot:Show(icon)
    end
    -- arcane_shot,if=buff.trueshot.up&buff.master_marksman.up&buff.memory_of_lucid_dreams.up
    if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) and Unit("player"):HasBuffs(A.MasterMarksmanBuff) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff)) then
        return A.ArcaneShot:Show(icon)
    end
    -- piercing_shot
    if A.PiercingShot:IsReady(unit) then
        return A.PiercingShot:Show(icon)
    end
    -- purifying_blast,if=!buff.trueshot.up|target.time_to_die<8
    if A.PurifyingBlast:IsReady(unit) and (not Unit("player"):HasBuffs(A.TrueshotBuff) or Unit(unit):TimeToDie() < 8) then
        return A.PurifyingBlast:Show(icon)
    end
    -- concentrated_flame,if=focus+focus.regen*gcd<focus.max&buff.trueshot.down&(!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight)|full_recharge_time<gcd|target.time_to_die<5
    if A.ConcentratedFlame:IsReady(unit) and (Player:Focus() + Player:FocusRegen() * A.GetGCD() < Player:FocusMax() and bool(Unit("player"):HasBuffsDown(A.TrueshotBuff)) and (not bool(Target:HasDeBuffs(A.ConcentratedFlameBurnDebuff)) and not A.ConcentratedFlame:IsSpellInFlight()) or A.ConcentratedFlame:FullRechargeTimeP() < A.GetGCD() or Unit(unit):TimeToDie() < 5) then
        return A.ConcentratedFlame:Show(icon)
    end
    -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10|target.time_to_die<5
    if A.TheUnboundForce:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessForceBuff) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff) < 10 or Unit(unit):TimeToDie() < 5) then
        return A.TheUnboundForce:Show(icon)
    end
    -- arcane_shot,if=buff.trueshot.down&(buff.precise_shots.up&(focus>41|buff.master_marksman.up)|(focus>50&azerite.focused_fire.enabled|focus>75)&(cooldown.trueshot.remains>5|focus>80)|target.time_to_die<5)
    if A.ArcaneShot:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.TrueshotBuff)) and (Unit("player"):HasBuffs(A.PreciseShotsBuff) and (Player:Focus() > 41 or Unit("player"):HasBuffs(A.MasterMarksmanBuff)) or (Player:Focus() > 50 and A.FocusedFire:GetAzeriteRank or Player:Focus() > 75) and (A.Trueshot:GetCooldown() > 5 or Player:Focus() > 80) or Unit(unit):TimeToDie() < 5)) then
        return A.ArcaneShot:Show(icon)
    end
    -- steady_shot
    if A.SteadyShot:IsReady(unit) then
        return A.SteadyShot:Show(icon)
    end
    end
    local function Trickshots(unit)
        -- barrage
    if A.Barrage:IsReady(unit) then
        return A.Barrage:Show(icon)
    end
    -- explosive_shot
    if A.ExplosiveShot:IsReady(unit) then
        return A.ExplosiveShot:Show(icon)
    end
    -- aimed_shot,if=buff.trick_shots.up&ca_execute&buff.double_tap.up
    if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff) and bool(ca_execute) and Unit("player"):HasBuffs(A.DoubleTapBuff)) then
        return A.AimedShot:Show(icon)
    end
    -- rapid_fire,if=buff.trick_shots.up&(azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1|azerite.surging_shots.enabled|talent.streamline.enabled)
    if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff) and (A.FocusedFire:GetAzeriteRank or A.IntheRhythm:GetAzeriteRank > 1 or A.SurgingShots:GetAzeriteRank or A.Streamline:IsSpellLearned())) then
        return A.RapidFire:Show(icon)
    end
    -- aimed_shot,if=buff.trick_shots.up&(buff.precise_shots.down|cooldown.aimed_shot.full_recharge_time<action.aimed_shot.cast_time|buff.trueshot.up)
    if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff) and (bool(Unit("player"):HasBuffsDown(A.PreciseShotsBuff)) or A.AimedShot:FullRechargeTimeP() < A.AimedShot:GetSpellCastTime() or Unit("player"):HasBuffs(A.TrueshotBuff))) then
        return A.AimedShot:Show(icon)
    end
    -- rapid_fire,if=buff.trick_shots.up
    if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff)) then
        return A.RapidFire:Show(icon)
    end
    -- multishot,if=buff.trick_shots.down|buff.precise_shots.up&!buff.trueshot.up|focus>70
    if A.Multishot:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.TrickShotsBuff)) or Unit("player"):HasBuffs(A.PreciseShotsBuff) and not Unit("player"):HasBuffs(A.TrueshotBuff) or Player:Focus() > 70) then
        return A.Multishot:Show(icon)
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
    -- piercing_shot
    if A.PiercingShot:IsReady(unit) then
        return A.PiercingShot:Show(icon)
    end
    -- a_murder_of_crows
    if A.AMurderofCrows:IsReady(unit) then
        return A.AMurderofCrows:Show(icon)
    end
    -- serpent_sting,if=refreshable&!action.serpent_sting.in_flight
    if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff) and not A.SerpentSting:IsSpellInFlight()) then
        return A.SerpentSting:Show(icon)
    end
    -- steady_shot
    if A.SteadyShot:IsReady(unit) then
        return A.SteadyShot:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_shot
    -- use_item,name=azsharas_font_of_power,if=cooldown.trueshot.remains<18|target.time_to_die<40
    if A.AzsharasFontofPower:IsReady(unit) and (A.Trueshot:GetCooldown() < 18 or Unit(unit):TimeToDie() < 40) then
      A.AzsharasFontofPower:Show(icon)
    end
    -- use_item,name=ashvanes_razor_coral,if=buff.trueshot.up&(buff.guardian_of_azeroth.up|!essence.condensed_lifeforce.major.rank3&ca_execute)|debuff.razor_coral_debuff.down|target.time_to_die<20
    if A.AshvanesRazorCoral:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff) and (Unit("player"):HasBuffs(A.GuardianofAzerothBuff) or not bool(essence.condensed_lifeforce.major.rank3) and bool(ca_execute)) or bool(Target:HasDeBuffsDown(A.RazorCoralDeBuffDebuff)) or Unit(unit):TimeToDie() < 20) then
      A.AshvanesRazorCoral:Show(icon)
    end
    -- use_item,name=pocketsized_computation_device,if=!buff.trueshot.up&!essence.blood_of_the_enemy.major.rank3|debuff.blood_of_the_enemy.up|target.time_to_die<5
    if A.PocketsizedComputationDevice:IsReady(unit) and (not Unit("player"):HasBuffs(A.TrueshotBuff) and not bool(essence.blood_of_the_enemy.major.rank3) or Target:HasDeBuffs(A.BloodoftheEnemyDebuff) or Unit(unit):TimeToDie() < 5) then
      A.PocketsizedComputationDevice:Show(icon)
    end
    -- use_items,if=buff.trueshot.up|!talent.calling_the_shots.enabled|target.time_to_die<20
    -- call_action_list,name=cds
    if (true) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=st,if=active_enemies<3
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
      local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=trickshots,if=active_enemies>2
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
      local ShouldReturn = Trickshots(unit); if ShouldReturn then return ShouldReturn; end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 