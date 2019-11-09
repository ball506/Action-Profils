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
Action[ACTION_CONST_MONK_WINDWALKER] = {
  ChiBurst                               = Action.Create({Type = "Spell", ID = 123986 }),
  SerenityBuff                           = Action.Create({Type = "Spell", ID = 152173 }),
  Serenity                               = Action.Create({Type = "Spell", ID = 152173 }),
  FistoftheWhiteTiger                    = Action.Create({Type = "Spell", ID = 261947 }),
  ChiWave                                = Action.Create({Type = "Spell", ID = 115098 }),
  RisingSunKick                          = Action.Create({Type = "Spell", ID = 107428 }),
  MarkoftheCraneDebuff                   = Action.Create({Type = "Spell", ID = 228287 }),
  WhirlingDragonPunch                    = Action.Create({Type = "Spell", ID = 152175 }),
  FistsofFury                            = Action.Create({Type = "Spell", ID = 113656 }),
  EnergizingElixir                       = Action.Create({Type = "Spell", ID = 115288 }),
  TigerPalm                              = Action.Create({Type = "Spell", ID = 100780 }),
  RushingJadeWind                        = Action.Create({Type = "Spell", ID = 261715 }),
  RushingJadeWindBuff                    = Action.Create({Type = "Spell", ID = 261715 }),
  SpinningCraneKick                      = Action.Create({Type = "Spell", ID = 101546 }),
  HitCombo                               = Action.Create({Type = "Spell", ID = 196741 }),
  FlyingSerpentKick                      = Action.Create({Type = "Spell", ID = 101545 }),
  BokProcBuff                            = Action.Create({Type = "Spell", ID = 116768 }),
  BlackoutKick                           = Action.Create({Type = "Spell", ID = 100784 }),
  InvokeXuentheWhiteTiger                = Action.Create({Type = "Spell", ID = 123904 }),
  BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
  TouchofDeath                           = Action.Create({Type = "Spell", ID = 115080 }),
  StormEarthandFire                      = Action.Create({Type = "Spell", ID = 137639 }),
  DanceofChijiBuff                       = Action.Create({Type = "Spell", ID =  }),
  SwiftRoundhouseBuff                    = Action.Create({Type = "Spell", ID = 278710 }),
  SpearHandStrike                        = Action.Create({Type = "Spell", ID = 116705 }),
  TouchofKarma                           = Action.Create({Type = "Spell", ID = 122470 }),
  StormEarthandFireBuff                  = Action.Create({Type = "Spell", ID = 137639 })
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
Action:CreateEssencesFor(ACTION_CONST_MONK_WINDWALKER)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MONK_WINDWALKER], { __index = Action })



local EnemyRanges = {40, 8}
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


local function EvaluateTargetIfFilterRisingSunKick19(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfRisingSunKick32(unit)
  return (A.WhirlingDragonPunch:IsSpellLearned() and A.WhirlingDragonPunch:GetCooldown() < 5) and A.FistsofFury:GetCooldown() > 3
end

local function EvaluateTargetIfFilterTigerPalm62(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfTigerPalm73(unit)
  return Player:ChiMax() - Player:Chi() >= 2 and (not A.HitCombo:IsSpellLearned() or not Unit("player"):GetSpellLastCast(A.TigerPalm))
end

local function EvaluateTargetIfFilterBlackoutKick85(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfBlackoutKick100(unit)
  return not Unit("player"):GetSpellLastCast(A.BlackoutKick) and (Unit("player"):HasBuffs(A.BokProcBuff) or (A.HitCombo:IsSpellLearned() and Unit("player"):GetSpellLastCast(A.TigerPalm) and Player:Chi() < 4))
end

local function EvaluateTargetIfFilterRisingSunKick136(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfRisingSunKick151(unit)
  return MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or Unit("player"):GetSpellLastCast(A.SpinningCraneKick)
end

local function EvaluateTargetIfFilterBlackoutKick193(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfFilterRisingSunKick206(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfRisingSunKick213(unit)
  return Player:Chi() >= 5
end

local function EvaluateTargetIfFilterRisingSunKick221(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfFilterBlackoutKick254(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfBlackoutKick271(unit)
  return not Unit("player"):GetSpellLastCast(A.BlackoutKick) and (A.RisingSunKick:GetCooldown() > 3 or Player:Chi() >= 3) and (A.FistsofFury:GetCooldown() > 4 or Player:Chi() >= 4 or (Player:Chi() == 2 and Unit("player"):GetSpellLastCast(A.TigerPalm))) and Unit("player"):HasBuffsStacks(A.SwiftRoundhouseBuff) < 2
end

local function EvaluateTargetIfFilterTigerPalm287(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfTigerPalm296(unit)
  return not Unit("player"):GetSpellLastCast(A.TigerPalm) and Player:ChiMax() - Player:Chi() >= 2
end

local function EvaluateTargetIfFilterTigerPalm332(unit)
  return Unit(unit):HasDebuffs(A.MarkoftheCraneDebuff)
end

local function EvaluateTargetIfTigerPalm345(unit)
  return (Player:EnergyTimeToMaxPredicted() < 1 or (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2)) and Player:ChiMax() - Player:Chi() >= 2 and not Unit("player"):GetSpellLastCast(A.TigerPalm)
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
     local Precombat, Aoe, Cd, Serenity, St
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
    -- chi_burst,if=(!talent.serenity.enabled|!talent.fist_of_the_white_tiger.enabled)
    if A.ChiBurst:IsReady(unit) and ((not A.Serenity:IsSpellLearned() or not A.FistoftheWhiteTiger:IsSpellLearned())) then
        return A.ChiBurst:Show(icon)
    end
    -- chi_wave
    if A.ChiWave:IsReady(unit) then
        return A.ChiWave:Show(icon)
    end
    end
    local function Aoe(unit)
        -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.whirling_dragon_punch.remains<5)&cooldown.fists_of_fury.remains>3
    if A.RisingSunKick:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick19, EvaluateTargetIfRisingSunKick32) then 
            return A.RisingSunKick:Show(icon) 
        end
    end
    -- whirling_dragon_punch
    if A.WhirlingDragonPunch:IsReady(unit) then
        return A.WhirlingDragonPunch:Show(icon)
    end
    -- energizing_elixir,if=!prev_gcd.1.tiger_palm&chi<=1&energy<50
    if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):GetSpellLastCast(A.TigerPalm) and Player:Chi() <= 1 and Player:EnergyPredicted() < 50) then
        return A.EnergizingElixir:Show(icon)
    end
    -- fists_of_fury,if=energy.time_to_max>3
    if A.FistsofFury:IsReady(unit) and (Player:EnergyTimeToMaxPredicted() > 3) then
        return A.FistsofFury:Show(icon)
    end
    -- rushing_jade_wind,if=buff.rushing_jade_wind.down
    if A.RushingJadeWind:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RushingJadeWindBuff))) then
        return A.RushingJadeWind:Show(icon)
    end
    -- spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&(((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2))|energy.time_to_max<=3)
    if A.SpinningCraneKick:IsReady(unit) and (not Unit("player"):GetSpellLastCast(A.SpinningCraneKick) and (((Player:Chi() > 3 or A.FistsofFury:GetCooldown() > 6) and (Player:Chi() >= 5 or A.FistsofFury:GetCooldown() > 2)) or Player:EnergyTimeToMaxPredicted() <= 3)) then
        return A.SpinningCraneKick:Show(icon)
    end
    -- chi_burst,if=chi<=3
    if A.ChiBurst:IsReady(unit) and (Player:Chi() <= 3) then
        return A.ChiBurst:Show(icon)
    end
    -- fist_of_the_white_tiger,if=chi.max-chi>=3
    if A.FistoftheWhiteTiger:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 3) then
        return A.FistoftheWhiteTiger:Show(icon)
    end
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|!prev_gcd.1.tiger_palm)
    if A.TigerPalm:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm62, EvaluateTargetIfTigerPalm73) then 
            return A.TigerPalm:Show(icon) 
        end
    end
    -- chi_wave
    if A.ChiWave:IsReady(unit) then
        return A.ChiWave:Show(icon)
    end
    -- flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
    if A.FlyingSerpentKick:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BokProcBuff))) then
        return A.FlyingSerpentKick:Show(icon)
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(buff.bok_proc.up|(talent.hit_combo.enabled&prev_gcd.1.tiger_palm&chi<4))
    if A.BlackoutKick:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick85, EvaluateTargetIfBlackoutKick100) then 
            return A.BlackoutKick:Show(icon) 
        end
    end
    end
    local function Cd(unit)
        -- invoke_xuen_the_white_tiger
    if A.InvokeXuentheWhiteTiger:IsReady(unit) and A.BurstIsON(unit) then
        return A.InvokeXuentheWhiteTiger:Show(icon)
    end
    -- use_item,name=lustrous_golden_plumage
    if A.LustrousGoldenPlumage:IsReady(unit) then
      A.LustrousGoldenPlumage:Show(icon)
    end
    -- blood_fury
    if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) then
        return A.BloodFury:Show(icon)
    end
    -- berserking
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
        return A.Berserking:Show(icon)
    end
    -- arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
    if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (Player:ChiMax() - Player:Chi() >= 1 and Player:EnergyTimeToMaxPredicted() >= 0.5) then
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
    -- touch_of_death,if=target.time_to_die>9
    if A.TouchofDeath:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):TimeToDie() > 9) then
        return A.TouchofDeath:Show(icon)
    end
    -- storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|(cooldown.fists_of_fury.remains<=6&chi>=3&cooldown.rising_sun_kick.remains<=1)|target.time_to_die<=15
    if A.StormEarthandFire:IsReady(unit) and A.BurstIsON(unit) and (A.StormEarthandFire:ChargesP() == 2 or (A.FistsofFury:GetCooldown() <= 6 and Player:Chi() >= 3 and A.RisingSunKick:GetCooldown() <= 1) or Unit(unit):TimeToDie() <= 15) then
        return A.StormEarthandFire:Show(icon)
    end
    -- serenity,if=cooldown.rising_sun_kick.remains<=2|target.time_to_die<=12
    if A.Serenity:IsReady(unit) and A.BurstIsON(unit) and (A.RisingSunKick:GetCooldown() <= 2 or Unit(unit):TimeToDie() <= 12) then
        return A.Serenity:Show(icon)
    end
    end
    local function Serenity(unit)
        -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=active_enemies<3|prev_gcd.1.spinning_crane_kick
    if A.RisingSunKick:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick136, EvaluateTargetIfRisingSunKick151) then 
            return A.RisingSunKick:Show(icon) 
        end
    end
    -- fists_of_fury,if=(buff.bloodlust.up&prev_gcd.1.rising_sun_kick)|buff.serenity.remains<1|(active_enemies>1&active_enemies<5)
    if A.FistsofFury:IsReady(unit) and ((Unit("player"):HasHeroism and Unit("player"):GetSpellLastCast(A.RisingSunKick)) or Unit("player"):HasBuffs(A.SerenityBuff) < 1 or (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) < 5)) then
        return A.FistsofFury:Show(icon)
    end
    -- spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&(active_enemies>=3|(active_enemies=2&prev_gcd.1.blackout_kick))
    if A.SpinningCraneKick:IsReady(unit) and (not Unit("player"):GetSpellLastCast(A.SpinningCraneKick) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 or (MultiUnits:GetByRangeInCombat(40, 5, 10) == 2 and Unit("player"):GetSpellLastCast(A.BlackoutKick)))) then
        return A.SpinningCraneKick:Show(icon)
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains
    if A.BlackoutKick:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick193) then 
            return A.BlackoutKick:Show(icon) 
        end
    end
    end
    local function St(unit)
        -- whirling_dragon_punch
    if A.WhirlingDragonPunch:IsReady(unit) then
        return A.WhirlingDragonPunch:Show(icon)
    end
    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=chi>=5
    if A.RisingSunKick:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick206, EvaluateTargetIfRisingSunKick213) then 
            return A.RisingSunKick:Show(icon) 
        end
    end
    -- fists_of_fury,if=energy.time_to_max>3
    if A.FistsofFury:IsReady(unit) and (Player:EnergyTimeToMaxPredicted() > 3) then
        return A.FistsofFury:Show(icon)
    end
    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
    if A.RisingSunKick:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.RisingSunKick, 40, "min", EvaluateTargetIfFilterRisingSunKick221) then 
            return A.RisingSunKick:Show(icon) 
        end
    end
    -- spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&buff.dance_of_chiji.up
    if A.SpinningCraneKick:IsReady(unit) and (not Unit("player"):GetSpellLastCast(A.SpinningCraneKick) and Unit("player"):HasBuffs(A.DanceofChijiBuff)) then
        return A.SpinningCraneKick:Show(icon)
    end
    -- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
    if A.RushingJadeWind:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RushingJadeWindBuff)) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
        return A.RushingJadeWind:Show(icon)
    end
    -- fist_of_the_white_tiger,if=chi<=2
    if A.FistoftheWhiteTiger:IsReady(unit) and (Player:Chi() <= 2) then
        return A.FistoftheWhiteTiger:Show(icon)
    end
    -- energizing_elixir,if=chi<=3&energy<50
    if A.EnergizingElixir:IsReady(unit) and A.BurstIsON(unit) and (Player:Chi() <= 3 and Player:EnergyPredicted() < 50) then
        return A.EnergizingElixir:Show(icon)
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(cooldown.rising_sun_kick.remains>3|chi>=3)&(cooldown.fists_of_fury.remains>4|chi>=4|(chi=2&prev_gcd.1.tiger_palm))&buff.swift_roundhouse.stack<2
    if A.BlackoutKick:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.BlackoutKick, 40, "min", EvaluateTargetIfFilterBlackoutKick254, EvaluateTargetIfBlackoutKick271) then 
            return A.BlackoutKick:Show(icon) 
        end
    end
    -- chi_wave
    if A.ChiWave:IsReady(unit) then
        return A.ChiWave:Show(icon)
    end
    -- chi_burst,if=chi.max-chi>=1&active_enemies=1|chi.max-chi>=2
    if A.ChiBurst:IsReady(unit) and (Player:ChiMax() - Player:Chi() >= 1 and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 or Player:ChiMax() - Player:Chi() >= 2) then
        return A.ChiBurst:Show(icon)
    end
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.tiger_palm&chi.max-chi>=2
    if A.TigerPalm:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm287, EvaluateTargetIfTigerPalm296) then 
            return A.TigerPalm:Show(icon) 
        end
    end
    -- flying_serpent_kick,if=prev_gcd.1.blackout_kick&chi>3&buff.swift_roundhouse.stack<2,interrupt=1
    if A.FlyingSerpentKick:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.BlackoutKick) and Player:Chi() > 3 and Unit("player"):HasBuffsStacks(A.SwiftRoundhouseBuff) < 2) then
        return A.FlyingSerpentKick:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack
    -- spear_hand_strike,if=target.debuff.casting.react
    if A.SpearHandStrike:IsReady(unit) and Action.GetToggle.InterruptEnabled and (Unit(unit):IsCasting) then
        return A.SpearHandStrike:Show(icon)
    end
    -- touch_of_karma,interval=90,pct_health=0.5
    if A.TouchofKarma:IsReady(unit) then
        return A.TouchofKarma:Show(icon)
    end
    -- potion,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
    if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.SerenityBuff) or Unit("player"):HasBuffs(A.StormEarthandFireBuff) or (not A.Serenity:IsSpellLearned() and bool(trinket.proc.agility.react)) or Unit("player"):HasHeroism or Unit(unit):TimeToDie() <= 60) then
      A.ProlongedPower:Show(icon)
    end
    -- call_action_list,name=serenity,if=buff.serenity.up
    if (Unit("player"):HasBuffs(A.SerenityBuff)) then
      local ShouldReturn = Serenity(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- fist_of_the_white_tiger,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2))&chi.max-chi>=3
    if A.FistoftheWhiteTiger:IsReady(unit) and ((Player:EnergyTimeToMaxPredicted() < 1 or (A.Serenity:IsSpellLearned() and A.Serenity:GetCooldown() < 2)) and Player:ChiMax() - Player:Chi() >= 3) then
        return A.FistoftheWhiteTiger:Show(icon)
    end
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2))&chi.max-chi>=2&!prev_gcd.1.tiger_palm
    if A.TigerPalm:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.TigerPalm, 40, "min", EvaluateTargetIfFilterTigerPalm332, EvaluateTargetIfTigerPalm345) then 
            return A.TigerPalm:Show(icon) 
        end
    end
    -- call_action_list,name=cd
    if (true) then
      local ShouldReturn = Cd(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=st,if=active_enemies<3
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
      local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=aoe,if=active_enemies>=3
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
      local ShouldReturn = Aoe(unit); if ShouldReturn then return ShouldReturn; end
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 