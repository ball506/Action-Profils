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
Action[ACTION_CONST_DRUID_FERAL] = {
    WildFleshrending                       = Action.Create({Type = "Spell", ID = 279527 }),
    Regrowth                               = Action.Create({Type = "Spell", ID = 8936 }),
    BloodtalonsBuff                        = Action.Create({Type = "Spell", ID = 145152 }),
    Bloodtalons                            = Action.Create({Type = "Spell", ID = 155672 }),
    CatFormBuff                            = Action.Create({Type = "Spell", ID = 768 }),
    CatForm                                = Action.Create({Type = "Spell", ID = 768 }),
    ProwlBuff                              = Action.Create({Type = "Spell", ID = 5215 }),
    Prowl                                  = Action.Create({Type = "Spell", ID = 5215 }),
    BerserkBuff                            = Action.Create({Type = "Spell", ID = 106951 }),
    Berserk                                = Action.Create({Type = "Spell", ID = 106951 }),
    TigersFury                             = Action.Create({Type = "Spell", ID = 5217 }),
    TigersFuryBuff                         = Action.Create({Type = "Spell", ID = 5217 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    Thorns                                 = Action.Create({Type = "Spell", ID = 467 }),
    ThornsDebuff                           = Action.Create({Type = "Spell", ID = 467 }),
    FeralFrenzy                            = Action.Create({Type = "Spell", ID = 274837 }),
    HeartEssence                           = Action.Create({Type = "Spell", ID = 298554 }),
    Incarnation                            = Action.Create({Type = "Spell", ID = 102543 }),
    IncarnationBuff                        = Action.Create({Type = "Spell", ID = 102543 }),
    Shadowmeld                             = Action.Create({Type = "Spell", ID = 58984 }),
    Rake                                   = Action.Create({Type = "Spell", ID = 1822 }),
    RakeDebuff                             = Action.Create({Type = "Spell", ID = 155722 }),
    JungleFury                             = Action.Create({Type = "Spell", ID = 274424 }),
    SavageRoar                             = Action.Create({Type = "Spell", ID = 52610 }),
    PoolResource                           = Action.Create({Type = "Spell", ID = 9999000010 }),
    SavageRoarBuff                         = Action.Create({Type = "Spell", ID = 52610 }),
    PrimalWrath                            = Action.Create({Type = "Spell", ID = 285381 }),
    RipDebuff                              = Action.Create({Type = "Spell", ID = 1079 }),
    Rip                                    = Action.Create({Type = "Spell", ID = 1079 }),
    Sabertooth                             = Action.Create({Type = "Spell", ID = 202031 }),
    Maim                                   = Action.Create({Type = "Spell", ID = 22570 }),
    IronJawsBuff                           = Action.Create({Type = "Spell", ID = 276026 }),
    FerociousBiteMaxEnergy                 = Action.Create({Type = "Spell", ID = 22568 }),
    FerociousBite                          = Action.Create({Type = "Spell", ID = 22568 }),
    PredatorySwiftnessBuff                 = Action.Create({Type = "Spell", ID = 69369 }),
    LunarInspiration                       = Action.Create({Type = "Spell", ID = 155580 }),
    BrutalSlash                            = Action.Create({Type = "Spell", ID = 202028 }),
    ThrashCat                              = Action.Create({Type = "Spell", ID = 106830 }),
    ThrashCatDebuff                        = Action.Create({Type = "Spell", ID = 106830 }),
    ScentofBlood                           = Action.Create({Type = "Spell", ID = 285564 }),
    ScentofBloodBuff                       = Action.Create({Type = "Spell", ID = 285646 }),
    SwipeCat                               = Action.Create({Type = "Spell", ID = 106785 }),
    MoonfireCat                            = Action.Create({Type = "Spell", ID = 155625 }),
    MoonfireCatDebuff                      = Action.Create({Type = "Spell", ID = 155625 }),
    ClearcastingBuff                       = Action.Create({Type = "Spell", ID = 135700 }),
    Shred                                  = Action.Create({Type = "Spell", ID = 5221 }),
    ShadowmeldBuff                         = Action.Create({Type = "Spell", ID = 58984 })
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
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DRUID_FERAL)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_FERAL], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarUseThrash = 0;
local VarOpenerDone = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarUseThrash = 0
  VarOpenerDone = 0
	end 
end)

local EnemyRanges = {30, 8, 5}
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

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 




local function EvaluateCyclePrimalWrath169(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) < 4
end

local function EvaluateCyclePrimalWrath180(unit)
    return MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2
end

local function EvaluateCycleRip189(unit)
    return not Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) or (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) <= A.RipDebuff.ID, true:BaseDuration() * 0.3) and (not A.Sabertooth:IsSpellLearned()) or (Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) <= A.RipDebuff.ID, true:BaseDuration() * 0.8 and A.Persistent_PMultiplier(A.Rip) > A.PMultiplier(unit, A.RipDebuff.ID)) and Unit(unit):TimeToDie() > 8
end

local function EvaluateTargetIfFilterFerociousBite248(unit)
  return max:druid.rip.ticks_gained_on_refresh
end

local function EvaluateCycleRake326(unit)
    return not Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) or (not A.Bloodtalons:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < A.RakeDebuff.ID, true:BaseDuration() * 0.3) and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleRake355(unit)
    return A.Bloodtalons:IsSpellLearned() and Unit("player"):HasBuffs(A.BloodtalonsBuff.ID, true) and ((Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) <= 7) and A.Persistent_PMultiplier(A.Rake) > A.PMultiplier(unit, A.RakeDebuff.ID) * 0.85) and Unit(unit):TimeToDie() > 4
end

local function EvaluateCycleMoonfireCat398(unit)
    return Unit(unit):HasDeBuffsRefreshable(A.MoonfireCatDebuff.ID, true)
end

local function EvaluateCycleFerociousBite514(unit)
    return Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) and Unit(unit):HasDeBuffs(A.RipDebuff.ID, true) < 3 and Unit(unit):TimeToDie() > 10 and (A.Sabertooth:IsSpellLearned())
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Cooldowns, Finishers, Generators, Opener
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- variable,name=use_thrash,value=0
            if (true) then
                VarUseThrash = 0
            end
            -- variable,name=use_thrash,value=2,if=azerite.wild_fleshrending.enabled
            if (bool(A.WildFleshrending:GetAzeriteRank())) then
                VarUseThrash = 2
            end
            -- regrowth,if=talent.bloodtalons.enabled
            if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned()) then
                return A.Regrowth:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- cat_form
            if A.CatForm:IsReady(unit) and Unit("player"):HasBuffsDown(A.CatFormBuff.ID, true) then
                return A.CatForm:Show(icon)
            end
            -- prowl
            if A.Prowl:IsReady(unit) and Unit("player"):HasBuffsDown(A.ProwlBuff.ID, true) then
                return A.Prowl:Show(icon)
            end
            -- potion,dynamic_prepot=1
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofAgility:Show(icon)
            end
            -- berserk
            if A.Berserk:IsReady(unit) and Unit("player"):HasBuffsDown(A.BerserkBuff.ID, true) and A.BurstIsON(unit) then
                return A.Berserk:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up)
            if A.Berserk:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):EnergyPredicted() >= 30 and (A.TigersFury:GetCooldown() > 5 or Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true))) then
                return A.Berserk:Show(icon)
            end
            -- tigers_fury,if=energy.deficit>=60
            if A.TigersFury:IsReady(unit) and (Unit("player"):EnergyDeficitPredicted() >= 60) then
                return A.TigersFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- thorns,if=active_enemies>desired_targets|raid_event.adds.in>45
            if A.Thorns:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or 10000000000 > 45) then
                return A.Thorns:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.tigers_fury.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            -- memory_of_lucid_dreams,if=buff.tigers_fury.up&buff.berserk.down
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) and bool(Unit("player"):HasBuffsDown(A.BerserkBuff.ID, true))) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.tigers_fury.up
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- feral_frenzy,if=combo_points=0
            if A.FeralFrenzy:IsReady(unit) and (Unit("player"):ComboPoints() == 0) then
                return A.FeralFrenzy:Show(icon)
            end
            -- focused_azerite_beam,if=active_enemies>desired_targets|(raid_event.adds.in>90&energy.deficit>=50)
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or (10000000000 > 90 and Unit("player"):EnergyDeficitPredicted() >= 50)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast,if=active_enemies>desired_targets|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 or 10000000000 > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            -- heart_essence,if=buff.tigers_fury.up
            if A.HeartEssence:IsReady(unit) and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true)) then
                return A.HeartEssence:Show(icon)
            end
            -- incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up)
            if A.Incarnation:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):EnergyPredicted() >= 30 and (A.TigersFury:GetCooldown() > 15 or Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true))) then
                return A.Incarnation:Show(icon)
            end
            -- potion,if=target.time_to_die<65|(time_to_die<180&(buff.berserk.up|buff.incarnation.up))
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit(unit):TimeToDie() < 65 or (Unit(unit):TimeToDie() < 180 and (Unit("player"):HasBuffs(A.BerserkBuff.ID, true) or Unit("player"):HasBuffs(A.IncarnationBuff.ID, true)))) then
                A.BattlePotionofAgility:Show(icon)
            end
            -- shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
            if A.Shadowmeld:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):ComboPoints() < 5 and Unit("player"):EnergyPredicted() >= A.Rake:Cost() and A.PMultiplier(unit, A.RakeDebuff.ID) < 2.1 and Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) and (Unit("player"):HasBuffs(A.BloodtalonsBuff.ID, true) or not A.Bloodtalons:IsSpellLearned()) and (not A.Incarnation:IsSpellLearned() or A.Incarnation:GetCooldown() > 18) and not Unit("player"):HasBuffs(A.IncarnationBuff.ID, true)) then
                return A.Shadowmeld:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.time_to_pct_30<1.5|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=25-10*debuff.blood_of_the_enemy.up|target.time_to_die<40)&buff.tigers_fury.remains>10
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(unit):TimeToDieX(30) < 1.5 or not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) >= 25 - 10 * num(Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true)) or Unit(unit):TimeToDie() < 40) and Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) > 10) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=(energy.deficit>=energy.regen*3)&buff.tigers_fury.down&!azerite.jungle_fury.enabled
            if A.CyclotronicBlast:IsReady(unit) and ((Unit("player"):EnergyDeficitPredicted() >= Unit("player"):EnergyRegen() * 3) and bool(Unit("player"):HasBuffsDown(A.TigersFuryBuff.ID, true)) and not bool(A.JungleFury:GetAzeriteRank())) then
                A.CyclotronicBlast:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=buff.tigers_fury.up&azerite.jungle_fury.enabled
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) and bool(A.JungleFury:GetAzeriteRank())) then
                A.CyclotronicBlast:Show(icon)
            end
            -- use_item,effect_name=azsharas_font_of_power,if=energy.deficit>=50
            if A.AzsharasFontofPower:IsReady(unit) and (Unit("player"):EnergyDeficitPredicted() >= 50) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_items,if=buff.tigers_fury.up|target.time_to_die<20
        end
        
        --Finishers
        local function Finishers(unit)
            -- pool_resource,for_next=1
            -- savage_roar,if=buff.savage_roar.down
            if A.SavageRoar:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.SavageRoarBuff.ID, true))) then
                if A.SavageRoar:IsUsablePPool() then
                    return A.SavageRoar:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- primal_wrath,target_if=spell_targets.primal_wrath>1&dot.rip.remains<4
            if A.PrimalWrath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.PrimalWrath, 8, EvaluateCyclePrimalWrath169) then
                    return A.PrimalWrath:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- primal_wrath,target_if=spell_targets.primal_wrath>=2
            if A.PrimalWrath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.PrimalWrath, 8, EvaluateCyclePrimalWrath180) then
                    return A.PrimalWrath:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- rip,target_if=!ticking|(remains<=duration*0.3)&(!talent.sabertooth.enabled)|(remains<=duration*0.8&persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die>8
            if A.Rip:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rip, 8, EvaluateCycleRip189) then
                    return A.Rip:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- savage_roar,if=buff.savage_roar.remains<12
            if A.SavageRoar:IsReady(unit) and (Unit("player"):HasBuffs(A.SavageRoarBuff.ID, true) < 12) then
                if A.SavageRoar:IsUsablePPool() then
                    return A.SavageRoar:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- maim,if=buff.iron_jaws.up
            if A.Maim:IsReady(unit) and (Unit("player"):HasBuffs(A.IronJawsBuff.ID, true)) then
                if A.Maim:IsUsablePPool() then
                    return A.Maim:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- ferocious_bite,max_energy=1,target_if=max:druid.rip.ticks_gained_on_refresh
            if A.FerociousBiteMaxEnergy:IsReady(unit) and A.FerociousBiteMaxEnergy:IsUsableP then
                if Action.Utils.CastTargetIf(A.FerociousBiteMaxEnergy, 8, "max", EvaluateTargetIfFilterFerociousBite248) then 
                    return A.FerociousBiteMaxEnergy:Show(icon) 
                end
            end
        end
        
        --Generators
        local function Generators(unit)
            -- regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
            if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned() and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff.ID, true) and bool(Unit("player"):HasBuffsDown(A.BloodtalonsBuff.ID, true)) and Unit("player"):ComboPoints() == 4 and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < 4) then
                return A.Regrowth:Show(icon)
            end
            -- regrowth,if=talent.bloodtalons.enabled&buff.bloodtalons.down&buff.predatory_swiftness.up&talent.lunar_inspiration.enabled&dot.rake.remains<1
            if A.Regrowth:IsReady(unit) and (A.Bloodtalons:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.BloodtalonsBuff.ID, true)) and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff.ID, true) and A.LunarInspiration:IsSpellLearned() and Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) < 1) then
                return A.Regrowth:Show(icon)
            end
            -- brutal_slash,if=spell_targets.brutal_slash>desired_targets
            if A.BrutalSlash:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.BrutalSlash:Show(icon)
            end
            -- pool_resource,for_next=1
            -- thrash_cat,if=(refreshable)&(spell_targets.thrash_cat>2)
            if A.ThrashCat:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff.ID, true)) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2)) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- thrash_cat,if=(talent.scent_of_blood.enabled&buff.scent_of_blood.down)&spell_targets.thrash_cat>3
            if A.ThrashCat:IsReady(unit) and ((A.ScentofBlood:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.ScentofBloodBuff.ID, true))) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 3) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- swipe_cat,if=buff.scent_of_blood.up|(action.swipe_cat.damage*spell_targets.swipe_cat>(action.rake.damage+(action.rake_bleed.tick_damage*5)))
            if A.SwipeCat:IsReady(unit) and (Unit("player"):HasBuffs(A.ScentofBloodBuff.ID, true) or (action.swipe_cat.damage * MultiUnits:GetByRangeInCombat(40, 5, 10) > (action.rake.damage + (action.rake_bleed.tick_damage * 5)))) then
                if A.SwipeCat:IsUsablePPool() then
                    return A.SwipeCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- pool_resource,for_next=1
            -- rake,target_if=!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)&target.time_to_die>4
            if A.Rake:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rake, 8, EvaluateCycleRake326) then
                    return A.Rake:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- rake,target_if=talent.bloodtalons.enabled&buff.bloodtalons.up&((remains<=7)&persistent_multiplier>dot.rake.pmultiplier*0.85)&target.time_to_die>4
            if A.Rake:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.Rake, 8, EvaluateCycleRake355) then
                    return A.Rake:Show(icon) 
                end
            end
            -- moonfire_cat,if=buff.bloodtalons.up&buff.predatory_swiftness.down&combo_points<5
            if A.MoonfireCat:IsReady(unit) and (Unit("player"):HasBuffs(A.BloodtalonsBuff.ID, true) and bool(Unit("player"):HasBuffsDown(A.PredatorySwiftnessBuff.ID, true)) and Unit("player"):ComboPoints() < 5) then
                return A.MoonfireCat:Show(icon)
            end
            -- brutal_slash,if=(buff.tigers_fury.up&(raid_event.adds.in>(1+max_charges-charges_fractional)*recharge_time))
            if A.BrutalSlash:IsReady(unit) and ((Unit("player"):HasBuffs(A.TigersFuryBuff.ID, true) and (10000000000 > (1 + A.BrutalSlash:MaxCharges() - A.BrutalSlash:ChargesFractionalP()) * A.BrutalSlash:RechargeP()))) then
                return A.BrutalSlash:Show(icon)
            end
            -- moonfire_cat,target_if=refreshable
            if A.MoonfireCat:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MoonfireCat, 40, EvaluateCycleMoonfireCat398) then
                    return A.MoonfireCat:Show(icon) 
                end
            end
            -- pool_resource,for_next=1
            -- thrash_cat,if=refreshable&((variable.use_thrash=2&(!buff.incarnation.up|azerite.wild_fleshrending.enabled))|spell_targets.thrash_cat>1)
            if A.ThrashCat:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff.ID, true) and ((VarUseThrash == 2 and (not Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) or bool(A.WildFleshrending:GetAzeriteRank()))) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                if A.ThrashCat:IsUsablePPool() then
                    return A.ThrashCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react&(!buff.incarnation.up|azerite.wild_fleshrending.enabled)
            if A.ThrashCat:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.ThrashCatDebuff.ID, true) and VarUseThrash == 1 and bool(Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true)) and (not Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) or bool(A.WildFleshrending:GetAzeriteRank()))) then
                return A.ThrashCat:Show(icon)
            end
            -- pool_resource,for_next=1
            -- swipe_cat,if=spell_targets.swipe_cat>1
            if A.SwipeCat:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                if A.SwipeCat:IsUsablePPool() then
                    return A.SwipeCat:Show(icon)
                else
                    return A.PoolResource:Show(icon)
                end
            end
            -- shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react
            if A.Shred:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) > (A.Shred:Cost() + A.Rake:Cost() - Unit("player"):EnergyPredicted()) / Unit("player"):EnergyRegen() or bool(Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true))) then
                return A.Shred:Show(icon)
            end
        end
        
        --Opener
        local function Opener(unit)
            -- tigers_fury
            if A.TigersFury:IsReady(unit) then
                return A.TigersFury:Show(icon)
            end
            -- rake,if=!ticking|buff.prowl.up
            if A.Rake:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RakeDebuff.ID, true) or Unit("player"):HasBuffs(A.ProwlBuff.ID, true)) then
                return A.Rake:Show(icon)
            end
            -- variable,name=opener_done,value=dot.rip.ticking
            if (true) then
                VarOpenerDone = num(Unit(unit):HasDeBuffs(A.RipDebuff.ID, true))
            end
            -- wait,sec=0.001,if=dot.rip.ticking
            -- moonfire_cat,if=!ticking
            if A.MoonfireCat:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.MoonfireCatDebuff.ID, true)) then
                return A.MoonfireCat:Show(icon)
            end
            -- rip,if=!ticking
            if A.Rip:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RipDebuff.ID, true)) then
                return A.Rip:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack,if=!buff.prowl.up&!buff.shadowmeld.up
            -- run_action_list,name=opener,if=variable.opener_done=0
            if (VarOpenerDone == 0) then
                return Opener(unit);
            end
            -- cat_form,if=!buff.cat_form.up
            if A.CatForm:IsReady(unit) and (not Unit("player"):HasBuffs(A.CatFormBuff.ID, true)) then
                return A.CatForm:Show(icon)
            end
            -- rake,if=buff.prowl.up|buff.shadowmeld.up
            if A.Rake:IsReady(unit) and (Unit("player"):HasBuffs(A.ProwlBuff.ID, true) or Unit("player"):HasBuffs(A.ShadowmeldBuff.ID, true)) then
                return A.Rake:Show(icon)
            end
            -- call_action_list,name=cooldowns
            if (true) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- ferocious_bite,target_if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>10&(talent.sabertooth.enabled)
            if A.FerociousBite:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.FerociousBite, 8, EvaluateCycleFerociousBite514) then
                    return A.FerociousBite:Show(icon) 
                end
            end
            -- regrowth,if=combo_points=5&buff.predatory_swiftness.up&talent.bloodtalons.enabled&buff.bloodtalons.down
            if A.Regrowth:IsReady(unit) and (Unit("player"):ComboPoints() == 5 and Unit("player"):HasBuffs(A.PredatorySwiftnessBuff.ID, true) and A.Bloodtalons:IsSpellLearned() and bool(Unit("player"):HasBuffsDown(A.BloodtalonsBuff.ID, true))) then
                return A.Regrowth:Show(icon)
            end
            -- run_action_list,name=finishers,if=combo_points>4
            if (Unit("player"):ComboPoints() > 4) then
                return Finishers(unit);
            end
            -- run_action_list,name=generators
            if (true) then
                return Generators(unit);
            end
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 

    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 

    end
end
-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end

