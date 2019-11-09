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
Action[ACTION_CONST_PRIEST_SHADOW] = {
  WhispersoftheDamned                    = Action.Create({Type = "Spell", ID = 275722 }),
  SearingDialogue                        = Action.Create({Type = "Spell", ID = 272788 }),
  DeathThroes                            = Action.Create({Type = "Spell", ID = 278659 }),
  ThoughtHarvester                       = Action.Create({Type = "Spell", ID = 288340 }),
  SpitefulApparitions                    = Action.Create({Type = "Spell", ID = 277682 }),
  ShadowformBuff                         = Action.Create({Type = "Spell", ID = 232698 }),
  Shadowform                             = Action.Create({Type = "Spell", ID = 232698 }),
  MindBlast                              = Action.Create({Type = "Spell", ID = 8092 }),
  VampiricTouchDebuff                    = Action.Create({Type = "Spell", ID = 34914 }),
  VampiricTouch                          = Action.Create({Type = "Spell", ID = 34914 }),
  MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
  VoidformBuff                           = Action.Create({Type = "Spell", ID = 194249 }),
  BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
  GuardianofAzeroth                      = Action.Create({Type = "Spell", ID =  }),
  FocusedAzeriteBeam                     = Action.Create({Type = "Spell", ID =  }),
  PurifyingBlast                         = Action.Create({Type = "Spell", ID =  }),
  TheUnboundForce                        = Action.Create({Type = "Spell", ID =  }),
  ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
  ChorusofInsanityBuff                   = Action.Create({Type = "Spell", ID =  }),
  RippleInSpace                          = Action.Create({Type = "Spell", ID =  }),
  WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
  LifebloodBuff                          = Action.Create({Type = "Spell", ID =  }),
  ChorusofInsanity                       = Action.Create({Type = "Spell", ID =  }),
  VoidEruption                           = Action.Create({Type = "Spell", ID = 228260 }),
  DarkAscension                          = Action.Create({Type = "Spell", ID = 280711 }),
  MindSear                               = Action.Create({Type = "Spell", ID = 48045 }),
  HarvestedThoughtsBuff                  = Action.Create({Type = "Spell", ID = 288343 }),
  VoidBolt                               = Action.Create({Type = "Spell", ID = 205448 }),
  ShadowWordDeath                        = Action.Create({Type = "Spell", ID = 32379 }),
  SurrenderToMadness                     = Action.Create({Type = "Spell", ID = 193223 }),
  DarkVoid                               = Action.Create({Type = "Spell", ID = 263346 }),
  ShadowWordPainDebuff                   = Action.Create({Type = "Spell", ID = 589 }),
  Mindbender                             = Action.Create({Type = "Spell", ID = 200174 }),
  ShadowCrash                            = Action.Create({Type = "Spell", ID = 205385 }),
  ShadowWordPain                         = Action.Create({Type = "Spell", ID = 589 }),
  Misery                                 = Action.Create({Type = "Spell", ID = 238558 }),
  VoidTorrent                            = Action.Create({Type = "Spell", ID = 263165 }),
  MindFlay                               = Action.Create({Type = "Spell", ID = 15407 }),
  ShadowWordVoid                         = Action.Create({Type = "Spell", ID = 205351 })
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
Action:CreateEssencesFor(ACTION_CONST_PRIEST_SHADOW)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PRIEST_SHADOW], { __index = Action })


-- Variables
local VarMindBlastTargets = 0;
local VarSwpTraitRanksCheck = 0;
local VarVtTraitRanksCheck = 0;
local VarVtMisTraitRanksCheck = 0;
local VarVtMisSdCheck = 0;
local VarDotsUp = 0;

HL:RegisterForEvent(function()
  VarMindBlastTargets = 0
  VarSwpTraitRanksCheck = 0
  VarVtTraitRanksCheck = 0
  VarVtMisTraitRanksCheck = 0
  VarVtMisSdCheck = 0
  VarDotsUp = 0
end, "PLAYER_REGEN_ENABLED")

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

local function InsanityThreshold ()
	return S.LegacyOfTheVoid:IsAvailable() and 60 or 90;
end
local function ExecuteRange ()
	return 20;
end

local function EvaluateCycleShadowWordDeath135(unit)
    return Unit(unit):TimeToDie() < 3 or bool(Unit("player"):HasBuffsDown(A.VoidformBuff))
end

local function EvaluateCycleMindBlast154(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) < VarMindBlastTargets
end

local function EvaluateCycleShadowWordPain165(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff) and Unit(unit):TimeToDie() > ((num(true) - 1.2 + 3.3 * MultiUnits:GetByRangeInCombat(40, 5, 10)) * VarSwpTraitRanksCheck * (1 - 0.012 * A.SearingDialogue:GetAzeriteRank * MultiUnits:GetByRangeInCombat(40, 5, 10)))) and (not A.Misery:IsSpellLearned())
end

local function EvaluateCycleVampiricTouch184(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.VampiricTouchDebuff)) and (Unit(unit):TimeToDie() > ((1 + 3.3 * MultiUnits:GetByRangeInCombat(40, 5, 10)) * VarVtTraitRanksCheck * (1 + 0.10 * A.SearingDialogue:GetAzeriteRank * MultiUnits:GetByRangeInCombat(40, 5, 10))))
end

local function EvaluateCycleVampiricTouch201(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff)) and ((A.Misery:IsSpellLearned() and Unit(unit):TimeToDie() > ((1.0 + 2.0 * MultiUnits:GetByRangeInCombat(40, 5, 10)) * VarVtMisTraitRanksCheck * (VarVtMisSdCheck * MultiUnits:GetByRangeInCombat(40, 5, 10)))))
end

local function EvaluateCycleMindSear220(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1
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
     local Precombat, Cds, Cleave, CritCds, Single
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
    -- variable,name=mind_blast_targets,op=set,value=floor((4.5+azerite.whispers_of_the_damned.rank)%(1+0.27*azerite.searing_dialogue.rank))
    if (true) then
      VarMindBlastTargets = math.floor ((4.5 + A.WhispersoftheDamned:GetAzeriteRank) / (1 + 0.27 * A.SearingDialogue:GetAzeriteRank))
    end
    -- variable,name=swp_trait_ranks_check,op=set,value=(1-0.07*azerite.death_throes.rank+0.2*azerite.thought_harvester.rank)*(1-0.09*azerite.thought_harvester.rank*azerite.searing_dialogue.rank)
    if (true) then
      VarSwpTraitRanksCheck = (1 - 0.07 * A.DeathThroes:GetAzeriteRank + 0.2 * A.ThoughtHarvester:GetAzeriteRank) * (1 - 0.09 * A.ThoughtHarvester:GetAzeriteRank * A.SearingDialogue:GetAzeriteRank)
    end
    -- variable,name=vt_trait_ranks_check,op=set,value=(1-0.04*azerite.thought_harvester.rank-0.05*azerite.spiteful_apparitions.rank)
    if (true) then
      VarVtTraitRanksCheck = (1 - 0.04 * A.ThoughtHarvester:GetAzeriteRank - 0.05 * A.SpitefulApparitions:GetAzeriteRank)
    end
    -- variable,name=vt_mis_trait_ranks_check,op=set,value=(1-0.07*azerite.death_throes.rank-0.03*azerite.thought_harvester.rank-0.055*azerite.spiteful_apparitions.rank)*(1-0.027*azerite.thought_harvester.rank*azerite.searing_dialogue.rank)
    if (true) then
      VarVtMisTraitRanksCheck = (1 - 0.07 * A.DeathThroes:GetAzeriteRank - 0.03 * A.ThoughtHarvester:GetAzeriteRank - 0.055 * A.SpitefulApparitions:GetAzeriteRank) * (1 - 0.027 * A.ThoughtHarvester:GetAzeriteRank * A.SearingDialogue:GetAzeriteRank)
    end
    -- variable,name=vt_mis_sd_check,op=set,value=1-0.014*azerite.searing_dialogue.rank
    if (true) then
      VarVtMisSdCheck = 1 - 0.014 * A.SearingDialogue:GetAzeriteRank
    end
    -- shadowform,if=!buff.shadowform.up
    if A.Shadowform:IsReady(unit) and Player:HasBuffsDown(A.ShadowformBuff) and (not Unit("player"):HasBuffs(A.ShadowformBuff)) then
        return A.Shadowform:Show(icon)
    end
    -- use_item,name=azsharas_font_of_power
    if A.AzsharasFontofPower:IsReady(unit) then
      A.AzsharasFontofPower:Show(icon)
    end
    -- mind_blast,if=spell_targets.mind_sear<2|azerite.thought_harvester.rank=0
    if A.MindBlast:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 or A.ThoughtHarvester:GetAzeriteRank == 0) then
        return A.MindBlast:Show(icon)
    end
    -- vampiric_touch
    if A.VampiricTouch:IsReady(unit) and Player:HasDebuffsDown(A.VampiricTouchDebuff) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
        return A.VampiricTouch:Show(icon)
    end
    end
    local function Cds(unit)
        -- memory_of_lucid_dreams,if=(buff.voidform.stack>20&insanity<=50)|buff.voidform.stack>(26+7*buff.bloodlust.up)|(current_insanity_drain*((gcd.max*2)+action.mind_blast.cast_time))>insanity
    if A.MemoryofLucidDreams:IsReady(unit) and ((Unit("player"):HasBuffsStacks(A.VoidformBuff) > 20 and Player:Insanity() <= 50) or Unit("player"):HasBuffsStacks(A.VoidformBuff) > (26 + 7 * num(Unit("player"):HasHeroism)) or (current_insanity_drain * ((A.GetGCD() * 2) + A.MindBlast:GetSpellCastTime())) > Player:Insanity()) then
        return A.MemoryofLucidDreams:Show(icon)
    end
    -- blood_of_the_enemy
    if A.BloodoftheEnemy:IsReady(unit) then
        return A.BloodoftheEnemy:Show(icon)
    end
    -- guardian_of_azeroth,if=buff.voidform.stack>15
    if A.GuardianofAzeroth:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.VoidformBuff) > 15) then
        return A.GuardianofAzeroth:Show(icon)
    end
    -- focused_azerite_beam,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
    if A.FocusedAzeriteBeam:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or 10000000000 > 60) then
        return A.FocusedAzeriteBeam:Show(icon)
    end
    -- purifying_blast,if=spell_targets.mind_sear>=2|raid_event.adds.in>60
    if A.PurifyingBlast:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or 10000000000 > 60) then
        return A.PurifyingBlast:Show(icon)
    end
    -- the_unbound_force
    if A.TheUnboundForce:IsReady(unit) then
        return A.TheUnboundForce:Show(icon)
    end
    -- concentrated_flame,line_cd=6,if=time<=10|(buff.chorus_of_insanity.stack>=15&buff.voidform.up)|full_recharge_time<gcd|target.time_to_die<5
    if A.ConcentratedFlame:IsReady(unit) and (Unit("player"):CombatTime <= 10 or (Unit("player"):HasBuffsStacks(A.ChorusofInsanityBuff) >= 15 and Unit("player"):HasBuffs(A.VoidformBuff)) or A.ConcentratedFlame:FullRechargeTimeP() < A.GetGCD() or Unit(unit):TimeToDie() < 5) then
        return A.ConcentratedFlame:Show(icon)
    end
    -- ripple_in_space
    if A.RippleInSpace:IsReady(unit) then
        return A.RippleInSpace:Show(icon)
    end
    -- worldvein_resonance,if=buff.lifeblood.stack<3
    if A.WorldveinResonance:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.LifebloodBuff) < 3) then
        return A.WorldveinResonance:Show(icon)
    end
    -- call_action_list,name=crit_cds,if=(buff.voidform.up&buff.chorus_of_insanity.stack>20)|azerite.chorus_of_insanity.rank=0
    if ((Unit("player"):HasBuffs(A.VoidformBuff) and Unit("player"):HasBuffsStacks(A.ChorusofInsanityBuff) > 20) or A.ChorusofInsanity:GetAzeriteRank == 0) then
      local ShouldReturn = CritCds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- use_items
    end
    local function Cleave(unit)
        -- void_eruption
    if A.VoidEruption:IsReady(unit) then
        return A.VoidEruption:Show(icon)
    end
    -- dark_ascension,if=buff.voidform.down
    if A.DarkAscension:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.VoidformBuff))) then
        return A.DarkAscension:Show(icon)
    end
    -- vampiric_touch,if=!ticking&azerite.thought_harvester.rank>=1
    if A.VampiricTouch:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.VampiricTouchDebuff) and A.ThoughtHarvester:GetAzeriteRank >= 1) then
        return A.VampiricTouch:Show(icon)
    end
    -- mind_sear,if=buff.harvested_thoughts.up
    if A.MindSear:IsReady(unit) and (Unit("player"):HasBuffs(A.HarvestedThoughtsBuff)) then
        return A.MindSear:Show(icon)
    end
    -- void_bolt
    if A.VoidBolt:IsReady(unit) then
        return A.VoidBolt:Show(icon)
    end
    -- call_action_list,name=cds
    if (true) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- shadow_word_death,target_if=target.time_to_die<3|buff.voidform.down
    if A.ShadowWordDeath:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ShadowWordDeath, 40, EvaluateCycleShadowWordDeath135) then
            return A.ShadowWordDeath:Show(icon) 
        end
    end
    -- surrender_to_madness,if=buff.voidform.stack>10+(10*buff.bloodlust.up)
    if A.SurrenderToMadness:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.VoidformBuff) > 10 + (10 * num(Unit("player"):HasHeroism))) then
        return A.SurrenderToMadness:Show(icon)
    end
    -- dark_void,if=raid_event.adds.in>10&(dot.shadow_word_pain.refreshable|target.time_to_die>30)
    if A.DarkVoid:IsReady(unit) and (10000000000 > 10 and (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff) or Unit(unit):TimeToDie() > 30)) then
        return A.DarkVoid:Show(icon)
    end
    -- mindbender
    if A.Mindbender:IsReady(unit) then
        return A.Mindbender:Show(icon)
    end
    -- mind_blast,target_if=spell_targets.mind_sear<variable.mind_blast_targets
    if A.MindBlast:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.MindBlast, 40, EvaluateCycleMindBlast154) then
            return A.MindBlast:Show(icon) 
        end
    end
    -- shadow_crash,if=(raid_event.adds.in>5&raid_event.adds.duration<2)|raid_event.adds.duration>2
    if A.ShadowCrash:IsReady(unit) and ((10000000000 > 5 and raid_event.adds.duration < 2) or raid_event.adds.duration > 2) then
        return A.ShadowCrash:Show(icon)
    end
    -- shadow_word_pain,target_if=refreshable&target.time_to_die>((-1.2+3.3*spell_targets.mind_sear)*variable.swp_trait_ranks_check*(1-0.012*azerite.searing_dialogue.rank*spell_targets.mind_sear)),if=!talent.misery.enabled
    if A.ShadowWordPain:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ShadowWordPain, 40, EvaluateCycleShadowWordPain165) then
            return A.ShadowWordPain:Show(icon) 
        end
    end
    -- vampiric_touch,target_if=refreshable,if=target.time_to_die>((1+3.3*spell_targets.mind_sear)*variable.vt_trait_ranks_check*(1+0.10*azerite.searing_dialogue.rank*spell_targets.mind_sear))
    if A.VampiricTouch:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.VampiricTouch, 40, EvaluateCycleVampiricTouch184) then
            return A.VampiricTouch:Show(icon) 
        end
    end
    -- vampiric_touch,target_if=dot.shadow_word_pain.refreshable,if=(talent.misery.enabled&target.time_to_die>((1.0+2.0*spell_targets.mind_sear)*variable.vt_mis_trait_ranks_check*(variable.vt_mis_sd_check*spell_targets.mind_sear)))
    if A.VampiricTouch:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.VampiricTouch, 40, EvaluateCycleVampiricTouch201) then
            return A.VampiricTouch:Show(icon) 
        end
    end
    -- void_torrent,if=buff.voidform.up
    if A.VoidTorrent:IsReady(unit) and (Unit("player"):HasBuffs(A.VoidformBuff)) then
        return A.VoidTorrent:Show(icon)
    end
    -- mind_sear,target_if=spell_targets.mind_sear>1,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
    if A.MindSear:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.MindSear, 40, EvaluateCycleMindSear220) then
            return A.MindSear:Show(icon) 
        end
    end
    -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
    if A.MindFlay:IsReady(unit) then
        return A.MindFlay:Show(icon)
    end
    -- shadow_word_pain
    if A.ShadowWordPain:IsReady(unit) then
        return A.ShadowWordPain:Show(icon)
    end
    end
    local function CritCds(unit)
        -- use_item,name=azsharas_font_of_power
    if A.AzsharasFontofPower:IsReady(unit) then
      A.AzsharasFontofPower:Show(icon)
    end
    -- use_item,effect_name=cyclotronic_blast
    if A.:IsReady(unit) then
      A.:Show(icon)
    end
    end
    local function Single(unit)
        -- void_eruption
    if A.VoidEruption:IsReady(unit) then
        return A.VoidEruption:Show(icon)
    end
    -- dark_ascension,if=buff.voidform.down
    if A.DarkAscension:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.VoidformBuff))) then
        return A.DarkAscension:Show(icon)
    end
    -- void_bolt
    if A.VoidBolt:IsReady(unit) then
        return A.VoidBolt:Show(icon)
    end
    -- call_action_list,name=cds
    if (true) then
      local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- mind_sear,if=buff.harvested_thoughts.up&cooldown.void_bolt.remains>=1.5&azerite.searing_dialogue.rank>=1
    if A.MindSear:IsReady(unit) and (Unit("player"):HasBuffs(A.HarvestedThoughtsBuff) and A.VoidBolt:GetCooldown() >= 1.5 and A.SearingDialogue:GetAzeriteRank >= 1) then
        return A.MindSear:Show(icon)
    end
    -- shadow_word_death,if=target.time_to_die<3|cooldown.shadow_word_death.charges=2|(cooldown.shadow_word_death.charges=1&cooldown.shadow_word_death.remains<gcd.max)
    if A.ShadowWordDeath:IsReady(unit) and (Unit(unit):TimeToDie() < 3 or A.ShadowWordDeath:ChargesP() == 2 or (A.ShadowWordDeath:ChargesP() == 1 and A.ShadowWordDeath:GetCooldown() < A.GetGCD())) then
        return A.ShadowWordDeath:Show(icon)
    end
    -- surrender_to_madness,if=buff.voidform.stack>10+(10*buff.bloodlust.up)
    if A.SurrenderToMadness:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.VoidformBuff) > 10 + (10 * num(Unit("player"):HasHeroism))) then
        return A.SurrenderToMadness:Show(icon)
    end
    -- dark_void,if=raid_event.adds.in>10
    if A.DarkVoid:IsReady(unit) and (10000000000 > 10) then
        return A.DarkVoid:Show(icon)
    end
    -- mindbender,if=talent.mindbender.enabled|(buff.voidform.stack>18|target.time_to_die<15)
    if A.Mindbender:IsReady(unit) and (A.Mindbender:IsSpellLearned() or (Unit("player"):HasBuffsStacks(A.VoidformBuff) > 18 or Unit(unit):TimeToDie() < 15)) then
        return A.Mindbender:Show(icon)
    end
    -- shadow_word_death,if=!buff.voidform.up|(cooldown.shadow_word_death.charges=2&buff.voidform.stack<15)
    if A.ShadowWordDeath:IsReady(unit) and (not Unit("player"):HasBuffs(A.VoidformBuff) or (A.ShadowWordDeath:ChargesP() == 2 and Unit("player"):HasBuffsStacks(A.VoidformBuff) < 15)) then
        return A.ShadowWordDeath:Show(icon)
    end
    -- shadow_crash,if=raid_event.adds.in>5&raid_event.adds.duration<20
    if A.ShadowCrash:IsReady(unit) and (10000000000 > 5 and raid_event.adds.duration < 20) then
        return A.ShadowCrash:Show(icon)
    end
    -- mind_blast,if=variable.dots_up&((raid_event.movement.in>cast_time+0.5&raid_event.movement.in<4)|!talent.shadow_word_void.enabled|buff.voidform.down|buff.voidform.stack>14&(insanity<70|charges_fractional>1.33)|buff.voidform.stack<=14&(insanity<60|charges_fractional>1.33))
    if A.MindBlast:IsReady(unit) and (bool(VarDotsUp) and ((10000000000 > A.MindBlast:GetSpellCastTime() + 0.5 and 10000000000 < 4) or not A.ShadowWordVoid:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.VoidformBuff)) or Unit("player"):HasBuffsStacks(A.VoidformBuff) > 14 and (Player:Insanity() < 70 or A.MindBlast:ChargesFractionalP() > 1.33) or Unit("player"):HasBuffsStacks(A.VoidformBuff) <= 14 and (Player:Insanity() < 60 or A.MindBlast:ChargesFractionalP() > 1.33))) then
        return A.MindBlast:Show(icon)
    end
    -- void_torrent,if=dot.shadow_word_pain.remains>4&dot.vampiric_touch.remains>4&buff.voidform.up
    if A.VoidTorrent:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ShadowWordPainDebuff) > 4 and Unit(unit):HasDeBuffs(A.VampiricTouchDebuff) > 4 and Unit("player"):HasBuffs(A.VoidformBuff)) then
        return A.VoidTorrent:Show(icon)
    end
    -- shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&!talent.dark_void.enabled
    if A.ShadowWordPain:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff) and Unit(unit):TimeToDie() > 4 and not A.Misery:IsSpellLearned() and not A.DarkVoid:IsSpellLearned()) then
        return A.ShadowWordPain:Show(icon)
    end
    -- vampiric_touch,if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)
    if A.VampiricTouch:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.VampiricTouchDebuff) and Unit(unit):TimeToDie() > 6 or (A.Misery:IsSpellLearned() and Unit(unit):HasDeBuffsRefreshable(A.ShadowWordPainDebuff))) then
        return A.VampiricTouch:Show(icon)
    end
    -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(cooldown.void_bolt.up|cooldown.mind_blast.up)
    if A.MindFlay:IsReady(unit) then
        return A.MindFlay:Show(icon)
    end
    -- shadow_word_pain
    if A.ShadowWordPain:IsReady(unit) then
        return A.ShadowWordPain:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- potion,if=buff.bloodlust.react|target.time_to_die<=80|target.health.pct<35
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism or Unit(unit):TimeToDie() <= 80 or Unit(unit):HealthPercent < 35) then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- variable,name=dots_up,op=set,value=dot.shadow_word_pain.ticking&dot.vampiric_touch.ticking
    if (true) then
      VarDotsUp = num(Unit(unit):HasDeBuffs(A.ShadowWordPainDebuff) and Unit(unit):HasDeBuffs(A.VampiricTouchDebuff))
    end
    -- run_action_list,name=cleave,if=active_enemies>1
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
      return Cleave(unit);
    end
    -- run_action_list,name=single,if=active_enemies=1
    if (MultiUnits:GetByRangeInCombat(40, 5, 10) == 1) then
      return Single(unit);
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 