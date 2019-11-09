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
Action[ACTION_CONST_DEATHKNIGHT_BLOOD] = {
  DeathStrike                            = Action.Create({Type = "Spell", ID = 49998 }),
  BloodDrinker                           = Action.Create({Type = "Spell", ID = 206931 }),
  DancingRuneWeaponBuff                  = Action.Create({Type = "Spell", ID = 81256 }),
  Marrowrend                             = Action.Create({Type = "Spell", ID = 195182 }),
  BoneShieldBuff                         = Action.Create({Type = "Spell", ID = 195181 }),
  HeartEssence                           = Action.Create({Type = "Spell", ID =  }),
  BloodBoil                              = Action.Create({Type = "Spell", ID = 50842 }),
  HemostasisBuff                         = Action.Create({Type = "Spell", ID =  }),
  Ossuary                                = Action.Create({Type = "Spell", ID = 219786 }),
  Bonestorm                              = Action.Create({Type = "Spell", ID = 194844 }),
  Heartbreaker                           = Action.Create({Type = "Spell", ID = 221536 }),
  DeathandDecay                          = Action.Create({Type = "Spell", ID =  }),
  RuneStrike                             = Action.Create({Type = "Spell", ID =  }),
  HeartStrike                            = Action.Create({Type = "Spell", ID = 206930 }),
  CrimsonScourgeBuff                     = Action.Create({Type = "Spell", ID = 81141 }),
  RapidDecomposition                     = Action.Create({Type = "Spell", ID = 194662 }),
  Consumption                            = Action.Create({Type = "Spell", ID = 205223 }),
  ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  DancingRuneWeapon                      = Action.Create({Type = "Spell", ID = 49028 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
  Tombstone                              = Action.Create({Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_BLOOD)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_BLOOD], { __index = Action })



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
     local Precombat, Standard
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
    local function Standard(unit)
        -- death_strike,if=runic_power.deficit<=10
    if A.DeathStrike:IsReady(unit) and (Player:RunicPowerDeficit() <= 10) then
        return A.DeathStrike:Show(icon)
    end
    -- blooddrinker,if=!buff.dancing_rune_weapon.up
    if A.BloodDrinker:IsReady(unit) and (not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff)) then
        return A.BloodDrinker:Show(icon)
    end
    -- marrowrend,if=(buff.bone_shield.remains<=rune.time_to_3|buff.bone_shield.remains<=(gcd+cooldown.blooddrinker.ready*talent.blooddrinker.enabled*2)|buff.bone_shield.stack<3)&runic_power.deficit>=20
    if A.Marrowrend:IsReady(unit) and ((Unit("player"):HasBuffs(A.BoneShieldBuff) <= Player:RuneTimeToX(3) or Unit("player"):HasBuffs(A.BoneShieldBuff) <= (A.GetGCD() + num(A.BloodDrinker:HasCooldownUps) * num(A.BloodDrinker:IsSpellLearned()) * 2) or Unit("player"):HasBuffsStacks(A.BoneShieldBuff) < 3) and Player:RunicPowerDeficit() >= 20) then
        return A.Marrowrend:Show(icon)
    end
    -- heart_essence,if=!buff.dancing_rune_weapon.up
    if A.HeartEssence:IsReady(unit) and (not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff)) then
        return A.HeartEssence:Show(icon)
    end
    -- blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
    if A.BloodBoil:IsReady(unit) and (A.BloodBoil:ChargesFractionalP() >= 1.8 and (Unit("player"):HasBuffsStacks(A.HemostasisBuff) <= (5 - MultiUnits:GetByRangeInCombat(40, 5, 10)) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 2)) then
        return A.BloodBoil:Show(icon)
    end
    -- marrowrend,if=buff.bone_shield.stack<5&talent.ossuary.enabled&runic_power.deficit>=15
    if A.Marrowrend:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BoneShieldBuff) < 5 and A.Ossuary:IsSpellLearned() and Player:RunicPowerDeficit() >= 15) then
        return A.Marrowrend:Show(icon)
    end
    -- bonestorm,if=runic_power>=100&!buff.dancing_rune_weapon.up
    if A.Bonestorm:IsReady(unit) and (Player:RunicPower() >= 100 and not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff)) then
        return A.Bonestorm:Show(icon)
    end
    -- death_strike,if=runic_power.deficit<=(15+buff.dancing_rune_weapon.up*5+spell_targets.heart_strike*talent.heartbreaker.enabled*2)|target.1.time_to_die<10
    if A.DeathStrike:IsReady(unit) and (Player:RunicPowerDeficit() <= (15 + num(Unit("player"):HasBuffs(A.DancingRuneWeaponBuff)) * 5 + MultiUnits:GetByRangeInCombat(40, 5, 10) * num(A.Heartbreaker:IsSpellLearned()) * 2) or target.1.time_to_die < 10) then
        return A.DeathStrike:Show(icon)
    end
    -- death_and_decay,if=spell_targets.death_and_decay>=3
    if A.DeathandDecay:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
        return A.DeathandDecay:Show(icon)
    end
    -- rune_strike,if=(charges_fractional>=1.8|buff.dancing_rune_weapon.up)&rune.time_to_3>=gcd
    if A.RuneStrike:IsReady(unit) and ((A.RuneStrike:ChargesFractionalP() >= 1.8 or Unit("player"):HasBuffs(A.DancingRuneWeaponBuff)) and Player:RuneTimeToX(3) >= A.GetGCD()) then
        return A.RuneStrike:Show(icon)
    end
    -- heart_strike,if=buff.dancing_rune_weapon.up|rune.time_to_4<gcd
    if A.HeartStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff) or Player:RuneTimeToX(4) < A.GetGCD()) then
        return A.HeartStrike:Show(icon)
    end
    -- blood_boil,if=buff.dancing_rune_weapon.up
    if A.BloodBoil:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff)) then
        return A.BloodBoil:Show(icon)
    end
    -- death_and_decay,if=buff.crimson_scourge.up|talent.rapid_decomposition.enabled|spell_targets.death_and_decay>=2
    if A.DeathandDecay:IsReady(unit) and (Unit("player"):HasBuffs(A.CrimsonScourgeBuff) or A.RapidDecomposition:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) then
        return A.DeathandDecay:Show(icon)
    end
    -- consumption
    if A.Consumption:IsReady(unit) then
        return A.Consumption:Show(icon)
    end
    -- blood_boil
    if A.BloodBoil:IsReady(unit) then
        return A.BloodBoil:Show(icon)
    end
    -- heart_strike,if=rune.time_to_3<gcd|buff.bone_shield.stack>6
    if A.HeartStrike:IsReady(unit) and (Player:RuneTimeToX(3) < A.GetGCD() or Unit("player"):HasBuffsStacks(A.BoneShieldBuff) > 6) then
        return A.HeartStrike:Show(icon)
    end
    -- use_item,name=grongs_primal_rage
    if A.GrongsPrimalRage:IsReady(unit) then
      A.GrongsPrimalRage:Show(icon)
    end
    -- rune_strike
    if A.RuneStrike:IsReady(unit) then
        return A.RuneStrike:Show(icon)
    end
    -- arcane_torrent,if=runic_power.deficit>20
    if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 20) then
        return A.ArcaneTorrent:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack
    -- blood_fury,if=cooldown.dancing_rune_weapon.ready&(!cooldown.blooddrinker.ready|!talent.blooddrinker.enabled)
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (A.DancingRuneWeapon:HasCooldownUps and (not A.BloodDrinker:HasCooldownUps or not A.BloodDrinker:IsSpellLearned())) then
        return A.BloodFury:Show(icon)
    end
    -- berserking
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
        return A.Berserking:Show(icon)
    end
    -- use_items,if=cooldown.dancing_rune_weapon.remains>90
    -- use_item,name=razdunks_big_red_button
    if A.RazdunksBigRedButton:IsReady(unit) then
      A.RazdunksBigRedButton:Show(icon)
    end
    -- use_item,name=merekthas_fang
    if A.MerekthasFang:IsReady(unit) then
      A.MerekthasFang:Show(icon)
    end
    -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
    if A.AshvanesRazorCoral:IsReady(unit) and (bool(Target:HasDeBuffsDown(A.RazorCoralDeBuffDebuff))) then
      A.AshvanesRazorCoral:Show(icon)
    end
    -- use_item,name=ashvanes_razor_coral,if=buff.dancing_rune_weapon.up&debuff.razor_coral_debuff.up
    if A.AshvanesRazorCoral:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff) and Target:HasDeBuffs(A.RazorCoralDeBuffDebuff)) then
      A.AshvanesRazorCoral:Show(icon)
    end
    -- potion,if=buff.dancing_rune_weapon.up
    if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff)) then
      A.BattlePotionofStrength:Show(icon)
    end
    -- dancing_rune_weapon,if=!talent.blooddrinker.enabled|!cooldown.blooddrinker.ready
    if A.DancingRuneWeapon:IsReady(unit) and A.BurstIsON(unit) and (not A.BloodDrinker:IsSpellLearned() or not A.BloodDrinker:HasCooldownUps) then
        return A.DancingRuneWeapon:Show(icon)
    end
    -- tombstone,if=buff.bone_shield.stack>=7
    if A.Tombstone:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BoneShieldBuff) >= 7) then
        return A.Tombstone:Show(icon)
    end
    -- call_action_list,name=standard
    if (true) then
      local ShouldReturn = Standard(unit); if ShouldReturn then return ShouldReturn; end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 