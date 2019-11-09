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
Action[ACTION_CONST_MONK_BREWMASTER] = {
  ChiBurst                               = Action.Create({Type = "Spell", ID = 123986 }),
  ChiWave                                = Action.Create({Type = "Spell", ID = 115098 }),
  DampenHarm                             = Action.Create({Type = "Spell", ID = 122278 }),
  FortifyingBrewBuff                     = Action.Create({Type = "Spell", ID = 115203 }),
  FortifyingBrew                         = Action.Create({Type = "Spell", ID = 115203 }),
  DampenHarmBuff                         = Action.Create({Type = "Spell", ID = 122278 }),
  DiffuseMagicBuff                       = Action.Create({Type = "Spell", ID =  }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
  InvokeNiuzaotheBlackOx                 = Action.Create({Type = "Spell", ID = 132578 }),
  IronskinBrew                           = Action.Create({Type = "Spell", ID = 115308 }),
  BlackoutComboBuff                      = Action.Create({Type = "Spell", ID = 228563 }),
  ElusiveBrawlerBuff                     = Action.Create({Type = "Spell", ID =  }),
  IronskinBrewBuff                       = Action.Create({Type = "Spell", ID = 215479 }),
  Brews                                  = Action.Create({Type = "Spell", ID = 115308 }),
  BlackOxBrew                            = Action.Create({Type = "Spell", ID = 115399 }),
  PurifyingBrew                          = Action.Create({Type = "Spell", ID = 119582 }),
  KegSmash                               = Action.Create({Type = "Spell", ID = 121253 }),
  TigerPalm                              = Action.Create({Type = "Spell", ID = 100780 }),
  RushingJadeWind                        = Action.Create({Type = "Spell", ID = 116847 }),
  RushingJadeWindBuff                    = Action.Create({Type = "Spell", ID = 116847 }),
  SpecialDelivery                        = Action.Create({Type = "Spell", ID =  }),
  BlackoutStrike                         = Action.Create({Type = "Spell", ID = 205523 }),
  BreathofFire                           = Action.Create({Type = "Spell", ID = 115181 }),
  BreathofFireDotDebuff                  = Action.Create({Type = "Spell", ID = 123725 }),
  BlackoutCombo                          = Action.Create({Type = "Spell", ID = 196736 }),
  ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 })
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
Action:CreateEssencesFor(ACTION_CONST_MONK_BREWMASTER)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MONK_BREWMASTER], { __index = Action })



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
     local Precombat
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
       local function Precombat(unit)
        -- flask
    -- food
    -- augmentation
    -- snapshot_stats
    -- potion
    if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.ProlongedPower:Show(icon)
    end
    -- chi_burst
    if A.ChiBurst:IsReady(unit) then
        return A.ChiBurst:Show(icon)
    end
    -- chi_wave
    if A.ChiWave:IsReady(unit) then
        return A.ChiWave:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack
    -- gift_of_the_ox,if=health<health.max*0.65
    -- dampen_harm,if=incoming_damage_1500ms&buff.fortifying_brew.down
    if A.DampenHarm:IsReady(unit) and (bool(incoming_damage_1500ms) and bool(Unit("player"):HasBuffsDown(A.FortifyingBrewBuff))) then
        return A.DampenHarm:Show(icon)
    end
    -- fortifying_brew,if=incoming_damage_1500ms&(buff.dampen_harm.down|buff.diffuse_magic.down)
    if A.FortifyingBrew:IsReady(unit) and (bool(incoming_damage_1500ms) and (bool(Unit("player"):HasBuffsDown(A.DampenHarmBuff)) or bool(Unit("player"):HasBuffsDown(A.DiffuseMagicBuff)))) then
        return A.FortifyingBrew:Show(icon)
    end
    -- use_item,name=lustrous_golden_plumage
    if A.LustrousGoldenPlumage:IsReady(unit) then
      A.LustrousGoldenPlumage:Show(icon)
    end
    -- potion
    if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.ProlongedPower:Show(icon)
    end
    -- blood_fury
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) then
        return A.BloodFury:Show(icon)
    end
    -- berserking
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
        return A.Berserking:Show(icon)
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
    -- invoke_niuzao_the_black_ox,if=target.time_to_die>25
    if A.InvokeNiuzaotheBlackOx:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):TimeToDie() > 25) then
        return A.InvokeNiuzaotheBlackOx:Show(icon)
    end
    -- ironskin_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2&!buff.ironskin_brew.up
    if A.IronskinBrew:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff)) and incoming_damage_1999ms > (health.max * 0.1 + stagger.last_tick_damage_4) and Unit("player"):HasBuffsStacks(A.ElusiveBrawlerBuff) < 2 and not Unit("player"):HasBuffs(A.IronskinBrewBuff)) then
        return A.IronskinBrew:Show(icon)
    end
    -- ironskin_brew,if=cooldown.brews.charges_fractional>1&cooldown.black_ox_brew.remains<3
    if A.IronskinBrew:IsReady(unit) and (A.Brews:ChargesFractionalP() > 1 and A.BlackOxBrew:GetCooldown() < 3) then
        return A.IronskinBrew:Show(icon)
    end
    -- purifying_brew,if=stagger.pct>(6*(3-(cooldown.brews.charges_fractional)))&(stagger.last_tick_damage_1>((0.02+0.001*(3-cooldown.brews.charges_fractional))*stagger.last_tick_damage_30))
    if A.PurifyingBrew:IsReady(unit) and (stagger.pct > (6 * (3 - (A.Brews:ChargesFractionalP()))) and (stagger.last_tick_damage_1 > ((0.02 + 0.001 * (3 - A.Brews:ChargesFractionalP())) * stagger.last_tick_damage_30))) then
        return A.PurifyingBrew:Show(icon)
    end
    -- black_ox_brew,if=cooldown.brews.charges_fractional<0.5
    if A.BlackOxBrew:IsReady(unit) and (A.Brews:ChargesFractionalP() < 0.5) then
        return A.BlackOxBrew:Show(icon)
    end
    -- black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
    if A.BlackOxBrew:IsReady(unit) and ((Player:EnergyPredicted() + (Player:EnergyRegen() * A.KegSmash:GetCooldown())) < 40 and bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff)) and A.KegSmash:HasCooldownUps) then
        return A.BlackOxBrew:Show(icon)
    end
    -- keg_smash,if=spell_targets>=2
    if A.KegSmash:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) then
        return A.KegSmash:Show(icon)
    end
    -- tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up
    if A.TigerPalm:IsReady(unit) and (A.RushingJadeWind:IsSpellLearned() and Unit("player"):HasBuffs(A.BlackoutComboBuff) and Unit("player"):HasBuffs(A.RushingJadeWindBuff)) then
        return A.TigerPalm:Show(icon)
    end
    -- tiger_palm,if=(talent.invoke_niuzao_the_black_ox.enabled|talent.special_delivery.enabled)&buff.blackout_combo.up
    if A.TigerPalm:IsReady(unit) and ((A.InvokeNiuzaotheBlackOx:IsSpellLearned() or A.SpecialDelivery:IsSpellLearned()) and Unit("player"):HasBuffs(A.BlackoutComboBuff)) then
        return A.TigerPalm:Show(icon)
    end
    -- blackout_strike
    if A.BlackoutStrike:IsReady(unit) then
        return A.BlackoutStrike:Show(icon)
    end
    -- keg_smash
    if A.KegSmash:IsReady(unit) then
        return A.KegSmash:Show(icon)
    end
    -- rushing_jade_wind,if=buff.rushing_jade_wind.down
    if A.RushingJadeWind:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RushingJadeWindBuff))) then
        return A.RushingJadeWind:Show(icon)
    end
    -- breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&&dot.breath_of_fire_dot.refreshable))
    if A.BreathofFire:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff)) and (Unit("player"):HasNotHeroism or (Unit("player"):HasHeroism and true and Target:HasDebuffsRefreshable(A.BreathofFireDotDebuff)))) then
        return A.BreathofFire:Show(icon)
    end
    -- chi_burst
    if A.ChiBurst:IsReady(unit) then
        return A.ChiBurst:Show(icon)
    end
    -- chi_wave
    if A.ChiWave:IsReady(unit) then
        return A.ChiWave:Show(icon)
    end
    -- tiger_palm,if=!talent.blackout_combo.enabled&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
    if A.TigerPalm:IsReady(unit) and (not A.BlackoutCombo:IsSpellLearned() and A.KegSmash:GetCooldown() > A.GetGCD() and (Player:EnergyPredicted() + (Player:EnergyRegen() * (A.KegSmash:GetCooldown() + A.GetGCD()))) >= 65) then
        return A.TigerPalm:Show(icon)
    end
    -- arcane_torrent,if=energy<31
    if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (Player:EnergyPredicted() < 31) then
        return A.ArcaneTorrent:Show(icon)
    end
    -- rushing_jade_wind
    if A.RushingJadeWind:IsReady(unit) then
        return A.RushingJadeWind:Show(icon)
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 