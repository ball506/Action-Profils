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
Action[ACTION_CONST_DEATHKNIGHT_UNHOLY] = {
  RaiseDead                              = Action.Create({Type = "Spell", ID = 46584 }),
  ArmyoftheDead                          = Action.Create({Type = "Spell", ID = 42650 }),
  DeathandDecay                          = Action.Create({Type = "Spell", ID = 43265 }),
  Apocalypse                             = Action.Create({Type = "Spell", ID = 275699 }),
  Defile                                 = Action.Create({Type = "Spell", ID = 152280 }),
  Epidemic                               = Action.Create({Type = "Spell", ID = 207317 }),
  DeathCoil                              = Action.Create({Type = "Spell", ID = 47541 }),
  ScourgeStrike                          = Action.Create({Type = "Spell", ID = 55090 }),
  ClawingShadows                         = Action.Create({Type = "Spell", ID = 207311 }),
  FesteringStrike                        = Action.Create({Type = "Spell", ID = 85948 }),
  FesteringWoundDebuff                   = Action.Create({Type = "Spell", ID = 194310 }),
  BurstingSores                          = Action.Create({Type = "Spell", ID = 207264 }),
  SuddenDoomBuff                         = Action.Create({Type = "Spell", ID = 81340 }),
  UnholyFrenzyBuff                       = Action.Create({Type = "Spell", ID = 207289 }),
  DarkTransformation                     = Action.Create({Type = "Spell", ID = 63560 }),
  SummonGargoyle                         = Action.Create({Type = "Spell", ID = 49206 }),
  UnholyFrenzy                           = Action.Create({Type = "Spell", ID = 207289 }),
  MagusoftheDead                         = Action.Create({Type = "Spell", ID = 288417 }),
  SoulReaper                             = Action.Create({Type = "Spell", ID = 130736 }),
  UnholyBlight                           = Action.Create({Type = "Spell", ID = 115989 }),
  Pestilence                             = Action.Create({Type = "Spell", ID = 277234 }),
  ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  ArmyoftheDamned                        = Action.Create({Type = "Spell", ID = 276837 }),
  Outbreak                               = Action.Create({Type = "Spell", ID = 77575 }),
  VirulentPlagueDebuff                   = Action.Create({Type = "Spell", ID = 191587 })
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
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_UNHOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_UNHOLY], { __index = Action })


-- Variables
local VarPoolingForGargoyle = 0;

HL:RegisterForEvent(function()
  VarPoolingForGargoyle = 0
end, "PLAYER_REGEN_ENABLED")

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


local function EvaluateCycleFesteringStrike40(unit)
    return Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) <= 1 and bool(A.DeathandDecay:GetCooldown())
end

local function EvaluateCycleSoulReaper163(unit)
    return Unit(unit):TimeToDie() < 8 and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleOutbreak303(unit)
    return Unit(unit):HasDeBuffs(A.VirulentPlagueDebuff) <= A.GetGCD()
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
     local Precombat, Aoe, Cooldowns, Generic
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
    -- raise_dead
    if A.RaiseDead:IsReady(unit) then
        return A.RaiseDead:Show(icon)
    end
    -- army_of_the_dead,delay=2
    if A.ArmyoftheDead:IsReady(unit) then
        return A.ArmyoftheDead:Show(icon)
    end
    end
    local function Aoe(unit)
        -- death_and_decay,if=cooldown.apocalypse.remains
    if A.DeathandDecay:IsReady(unit) and (bool(A.Apocalypse:GetCooldown())) then
        return A.DeathandDecay:Show(icon)
    end
    -- defile
    if A.Defile:IsReady(unit) then
        return A.Defile:Show(icon)
    end
    -- epidemic,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
    if A.Epidemic:IsReady(unit) and (bool(death_and_decay.ticking) and Player:Rune() < 2 and not bool(VarPoolingForGargoyle)) then
        return A.Epidemic:Show(icon)
    end
    -- death_coil,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle
    if A.DeathCoil:IsReady(unit) and (bool(death_and_decay.ticking) and Player:Rune() < 2 and not bool(VarPoolingForGargoyle)) then
        return A.DeathCoil:Show(icon)
    end
    -- scourge_strike,if=death_and_decay.ticking&cooldown.apocalypse.remains
    if A.ScourgeStrike:IsReady(unit) and (bool(death_and_decay.ticking) and bool(A.Apocalypse:GetCooldown())) then
        return A.ScourgeStrike:Show(icon)
    end
    -- clawing_shadows,if=death_and_decay.ticking&cooldown.apocalypse.remains
    if A.ClawingShadows:IsReady(unit) and (bool(death_and_decay.ticking) and bool(A.Apocalypse:GetCooldown())) then
        return A.ClawingShadows:Show(icon)
    end
    -- epidemic,if=!variable.pooling_for_gargoyle
    if A.Epidemic:IsReady(unit) and (not bool(VarPoolingForGargoyle)) then
        return A.Epidemic:Show(icon)
    end
    -- festering_strike,target_if=debuff.festering_wound.stack<=1&cooldown.death_and_decay.remains
    if A.FesteringStrike:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.FesteringStrike, 40, EvaluateCycleFesteringStrike40) then
            return A.FesteringStrike:Show(icon) 
        end
    end
    -- festering_strike,if=talent.bursting_sores.enabled&spell_targets.bursting_sores>=2&debuff.festering_wound.stack<=1
    if A.FesteringStrike:IsReady(unit) and (A.BurstingSores:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) <= 1) then
        return A.FesteringStrike:Show(icon)
    end
    -- death_coil,if=buff.sudden_doom.react&rune.deficit>=4
    if A.DeathCoil:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.SuddenDoomBuff)) and Player:RuneDeficit() >= 4) then
        return A.DeathCoil:Show(icon)
    end
    -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
    if A.DeathCoil:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.SuddenDoomBuff)) and not bool(VarPoolingForGargoyle) or bool(pet.gargoyle.active)) then
        return A.DeathCoil:Show(icon)
    end
    -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
    if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) > 4) and not bool(VarPoolingForGargoyle)) then
        return A.DeathCoil:Show(icon)
    end
    -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5
    if A.ScourgeStrike:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff) and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) > 4) and A.ArmyoftheDead:GetCooldown() > 5) then
        return A.ScourgeStrike:Show(icon)
    end
    -- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5
    if A.ClawingShadows:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff) and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) > 4) and A.ArmyoftheDead:GetCooldown() > 5) then
        return A.ClawingShadows:Show(icon)
    end
    -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
    if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not bool(VarPoolingForGargoyle)) then
        return A.DeathCoil:Show(icon)
    end
    -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&cooldown.army_of_the_dead.remains>5
    if A.FesteringStrike:IsReady(unit) and (((((Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) < 4 and not Unit("player"):HasBuffs(A.UnholyFrenzyBuff)) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) < 3) and A.Apocalypse:GetCooldown() < 3) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) < 1) and A.ArmyoftheDead:GetCooldown() > 5) then
        return A.FesteringStrike:Show(icon)
    end
    -- death_coil,if=!variable.pooling_for_gargoyle
    if A.DeathCoil:IsReady(unit) and (not bool(VarPoolingForGargoyle)) then
        return A.DeathCoil:Show(icon)
    end
    end
    local function Cooldowns(unit)
        -- army_of_the_dead
    if A.ArmyoftheDead:IsReady(unit) then
        return A.ArmyoftheDead:Show(icon)
    end
    -- apocalypse,if=debuff.festering_wound.stack>=4
    if A.Apocalypse:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) >= 4) then
        return A.Apocalypse:Show(icon)
    end
    -- dark_transformation,if=!raid_event.adds.exists|raid_event.adds.in>15
    if A.DarkTransformation:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 15) then
        return A.DarkTransformation:Show(icon)
    end
    -- summon_gargoyle,if=runic_power.deficit<14
    if A.SummonGargoyle:IsReady(unit) and (Player:RunicPowerDeficit() < 14) then
        return A.SummonGargoyle:Show(icon)
    end
    -- unholy_frenzy,if=debuff.festering_wound.stack<4&!(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled)
    if A.UnholyFrenzy:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) < 4 and not (A.RampingAmplitudeGigavoltEngine:IsEquipped or A.MagusoftheDead:GetAzeriteRank)) then
        return A.UnholyFrenzy:Show(icon)
    end
    -- unholy_frenzy,if=cooldown.apocalypse.remains<2&(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled)
    if A.UnholyFrenzy:IsReady(unit) and (A.Apocalypse:GetCooldown() < 2 and (A.RampingAmplitudeGigavoltEngine:IsEquipped or A.MagusoftheDead:GetAzeriteRank)) then
        return A.UnholyFrenzy:Show(icon)
    end
    -- unholy_frenzy,if=active_enemies>=2&((cooldown.death_and_decay.remains<=gcd&!talent.defile.enabled)|(cooldown.defile.remains<=gcd&talent.defile.enabled))
    if A.UnholyFrenzy:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and ((A.DeathandDecay:GetCooldown() <= A.GetGCD() and not A.Defile:IsSpellLearned()) or (A.Defile:GetCooldown() <= A.GetGCD() and A.Defile:IsSpellLearned()))) then
        return A.UnholyFrenzy:Show(icon)
    end
    -- soul_reaper,target_if=target.time_to_die<8&target.time_to_die>4
    if A.SoulReaper:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.SoulReaper, 40, EvaluateCycleSoulReaper163) then
            return A.SoulReaper:Show(icon) 
        end
    end
    -- soul_reaper,if=(!raid_event.adds.exists|raid_event.adds.in>20)&rune<=(1-buff.unholy_frenzy.up)
    if A.SoulReaper:IsReady(unit) and ((not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 20) and Player:Rune() <= (1 - num(Unit("player"):HasBuffs(A.UnholyFrenzyBuff)))) then
        return A.SoulReaper:Show(icon)
    end
    -- unholy_blight
    if A.UnholyBlight:IsReady(unit) then
        return A.UnholyBlight:Show(icon)
    end
    end
    local function Generic(unit)
        -- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
    if A.DeathCoil:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.SuddenDoomBuff)) and not bool(VarPoolingForGargoyle) or bool(pet.gargoyle.active)) then
        return A.DeathCoil:Show(icon)
    end
    -- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle
    if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 14 and (A.Apocalypse:GetCooldown() > 5 or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) > 4) and not bool(VarPoolingForGargoyle)) then
        return A.DeathCoil:Show(icon)
    end
    -- death_and_decay,if=talent.pestilence.enabled&cooldown.apocalypse.remains
    if A.DeathandDecay:IsReady(unit) and (A.Pestilence:IsSpellLearned() and bool(A.Apocalypse:GetCooldown())) then
        return A.DeathandDecay:Show(icon)
    end
    -- defile,if=cooldown.apocalypse.remains
    if A.Defile:IsReady(unit) and (bool(A.Apocalypse:GetCooldown())) then
        return A.Defile:Show(icon)
    end
    -- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5
    if A.ScourgeStrike:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff) and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) > 4) and A.ArmyoftheDead:GetCooldown() > 5) then
        return A.ScourgeStrike:Show(icon)
    end
    -- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5
    if A.ClawingShadows:IsReady(unit) and (((Unit(unit):HasDeBuffs(A.FesteringWoundDebuff) and A.Apocalypse:GetCooldown() > 5) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) > 4) and A.ArmyoftheDead:GetCooldown() > 5) then
        return A.ClawingShadows:Show(icon)
    end
    -- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
    if A.DeathCoil:IsReady(unit) and (Player:RunicPowerDeficit() < 20 and not bool(VarPoolingForGargoyle)) then
        return A.DeathCoil:Show(icon)
    end
    -- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&cooldown.army_of_the_dead.remains>5
    if A.FesteringStrike:IsReady(unit) and (((((Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) < 4 and not Unit("player"):HasBuffs(A.UnholyFrenzyBuff)) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) < 3) and A.Apocalypse:GetCooldown() < 3) or Unit(unit):HasDeBuffsStacks(A.FesteringWoundDebuff) < 1) and A.ArmyoftheDead:GetCooldown() > 5) then
        return A.FesteringStrike:Show(icon)
    end
    -- death_coil,if=!variable.pooling_for_gargoyle
    if A.DeathCoil:IsReady(unit) and (not bool(VarPoolingForGargoyle)) then
        return A.DeathCoil:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack
    -- variable,name=pooling_for_gargoyle,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle.enabled
    if (true) then
      VarPoolingForGargoyle = num(A.SummonGargoyle:GetCooldown() < 5 and A.SummonGargoyle:IsSpellLearned())
    end
    -- arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle.enabled)&rune.deficit>=5
    if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 65 and (bool(pet.gargoyle.active) or not A.SummonGargoyle:IsSpellLearned()) and Player:RuneDeficit() >= 5) then
        return A.ArcaneTorrent:Show(icon)
    end
    -- blood_fury,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) and (bool(pet.gargoyle.active) or not A.SummonGargoyle:IsSpellLearned()) then
        return A.BloodFury:Show(icon)
    end
    -- berserking,if=buff.unholy_frenzy.up|pet.gargoyle.active|!talent.summon_gargoyle.enabled
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.UnholyFrenzyBuff) or bool(pet.gargoyle.active) or not A.SummonGargoyle:IsSpellLearned()) then
        return A.Berserking:Show(icon)
    end
    -- use_items,if=time>20|!equipped.ramping_amplitude_gigavolt_engine
    -- use_item,name=ramping_amplitude_gigavolt_engine,if=cooldown.apocalypse.remains<2|talent.army_of_the_damned.enabled|raid_event.adds.in<5
    if A.RampingAmplitudeGigavoltEngine:IsReady(unit) and (A.Apocalypse:GetCooldown() < 2 or A.ArmyoftheDamned:IsSpellLearned() or 10000000000 < 5) then
      A.RampingAmplitudeGigavoltEngine:Show(icon)
    end
    -- use_item,name=bygone_bee_almanac,if=cooldown.summon_gargoyle.remains>60|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
    if A.BygoneBeeAlmanac:IsReady(unit) and (A.SummonGargoyle:GetCooldown() > 60 or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime > 20 or not A.RampingAmplitudeGigavoltEngine:IsEquipped) then
      A.BygoneBeeAlmanac:Show(icon)
    end
    -- use_item,name=jes_howler,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
    if A.JesHowler:IsReady(unit) and (bool(pet.gargoyle.active) or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime > 20 or not A.RampingAmplitudeGigavoltEngine:IsEquipped) then
      A.JesHowler:Show(icon)
    end
    -- use_item,name=galecallers_beak,if=pet.gargoyle.active|!talent.summon_gargoyle.enabled&time>20|!equipped.ramping_amplitude_gigavolt_engine
    if A.GalecallersBeak:IsReady(unit) and (bool(pet.gargoyle.active) or not A.SummonGargoyle:IsSpellLearned() and Unit("player"):CombatTime > 20 or not A.RampingAmplitudeGigavoltEngine:IsEquipped) then
      A.GalecallersBeak:Show(icon)
    end
    -- use_item,name=grongs_primal_rage,if=rune<=3&(time>20|!equipped.ramping_amplitude_gigavolt_engine)
    if A.GrongsPrimalRage:IsReady(unit) and (Player:Rune() <= 3 and (Unit("player"):CombatTime > 20 or not A.RampingAmplitudeGigavoltEngine:IsEquipped)) then
      A.GrongsPrimalRage:Show(icon)
    end
    -- potion,if=cooldown.army_of_the_dead.ready|pet.gargoyle.active|buff.unholy_frenzy.up
    if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (A.ArmyoftheDead:HasCooldownUps or bool(pet.gargoyle.active) or Unit("player"):HasBuffs(A.UnholyFrenzyBuff)) then
      A.BattlePotionofStrength:Show(icon)
    end
    -- outbreak,target_if=dot.virulent_plague.remains<=gcd
    if A.Outbreak:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Outbreak, 40, EvaluateCycleOutbreak303) then
            return A.Outbreak:Show(icon) 
        end
    end
    -- call_action_list,name=cooldowns
    if (true) then
      local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- run_action_list,name=aoe,if=active_enemies>=2
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) then
      return Aoe(unit);
    end
    -- call_action_list,name=generic
    if (true) then
      local ShouldReturn = Generic(unit); if ShouldReturn then return ShouldReturn; end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 