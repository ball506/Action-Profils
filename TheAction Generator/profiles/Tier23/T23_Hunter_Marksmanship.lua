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
    TrueshotBuff                           = Action.Create({Type = "Spell", ID = 288613 }),
    Trueshot                               = Action.Create({Type = "Spell", ID = 288613 }),
    AimedShot                              = Action.Create({Type = "Spell", ID = 19434 }),
    UnerringVisionBuff                     = Action.Create({Type = "Spell", ID = 274447 }),
    UnerringVision                         = Action.Create({Type = "Spell", ID = 274444 }),
    CallingtheShots                        = Action.Create({Type = "Spell", ID = 260404 }),
    SurgingShots                           = Action.Create({Type = "Spell", ID = 287707 }),
    Streamline                             = Action.Create({Type = "Spell", ID = 260367 }),
    FocusedFire                            = Action.Create({Type = "Spell", ID = 278531 }),
    RapidFire                              = Action.Create({Type = "Spell", ID = 257044 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Action.Create({Type = "Spell", ID = 26297 }),
    CarefulAim                             = Action.Create({Type = "Spell", ID = 260228 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    BloodFuryBuff                          = Action.Create({Type = "Spell", ID = 20572 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    ExplosiveShot                          = Action.Create({Type = "Spell", ID = 212431 }),
    Barrage                                = Action.Create({Type = "Spell", ID = 120360 }),
    AMurderofCrows                         = Action.Create({Type = "Spell", ID = 131894 }),
    SerpentSting                           = Action.Create({Type = "Spell", ID = 271788 }),
    SerpentStingDebuff                     = Action.Create({Type = "Spell", ID = 271788 }),
    ArcaneShot                             = Action.Create({Type = "Spell", ID = 185358 }),
    MasterMarksmanBuff                     = Action.Create({Type = "Spell", ID = 269576 }),
    PreciseShotsBuff                       = Action.Create({Type = "Spell", ID = 260242 }),
    IntheRhythm                            = Action.Create({Type = "Spell", ID = 264198 }),
    PiercingShot                           = Action.Create({Type = "Spell", ID = 198670 }),
    SteadyShot                             = Action.Create({Type = "Spell", ID = 56641 }),
    TrickShotsBuff                         = Action.Create({Type = "Spell", ID = 257622 }),
    Multishot                              = Action.Create({Type = "Spell", ID = 257620 })
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
Action:CreateEssencesFor(ACTION_CONST_HUNTER_MARKSMANSHIP)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_MARKSMANSHIP], { __index = Action })





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
        local Precombat, Cds, St, Trickshots
        --Precombat
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
            if A.HuntersMark:IsReady(unit) and Unit("player"):HasDebuffsDown(A.HuntersMarkDebuff.ID, true) then
                return A.HuntersMark:Show(icon)
            end
            -- double_tap,precast_time=10
            if A.DoubleTap:IsReady(unit) then
                return A.DoubleTap:Show(icon)
            end
            -- trueshot,precast_time=1.5,if=active_enemies>2
            if A.Trueshot:IsReady(unit) and Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.Trueshot:Show(icon)
            end
            -- aimed_shot,if=active_enemies<3
            if A.AimedShot:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.AimedShot:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- hunters_mark,if=debuff.hunters_mark.down
            if A.HuntersMark:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.HuntersMarkDebuff.ID, true))) then
                return A.HuntersMark:Show(icon)
            end
            -- double_tap,if=target.time_to_die<15|cooldown.aimed_shot.remains<gcd&(buff.trueshot.up&(buff.unerring_vision.stack>6|!azerite.unerring_vision.enabled)|!talent.calling_the_shots.enabled)&(!azerite.surging_shots.enabled&!talent.streamline.enabled&!azerite.focused_fire.enabled)
            if A.DoubleTap:IsReady(unit) and (Unit(unit):TimeToDie() < 15 or A.AimedShot:GetCooldown() < A.GetGCD() and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit("player"):HasBuffsStacks(A.UnerringVisionBuff.ID, true) > 6 or not bool(A.UnerringVision:GetAzeriteRank())) or not A.CallingtheShots:IsSpellLearned()) and (not bool(A.SurgingShots:GetAzeriteRank()) and not A.Streamline:IsSpellLearned() and not bool(A.FocusedFire:GetAzeriteRank()))) then
                return A.DoubleTap:Show(icon)
            end
            -- double_tap,if=cooldown.rapid_fire.remains<gcd&(buff.trueshot.up&(buff.unerring_vision.stack>6|!azerite.unerring_vision.enabled)|!talent.calling_the_shots.enabled)&(azerite.surging_shots.enabled|talent.streamline.enabled|azerite.focused_fire.enabled)
            if A.DoubleTap:IsReady(unit) and (A.RapidFire:GetCooldown() < A.GetGCD() and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit("player"):HasBuffsStacks(A.UnerringVisionBuff.ID, true) > 6 or not bool(A.UnerringVision:GetAzeriteRank())) or not A.CallingtheShots:IsSpellLearned()) and (bool(A.SurgingShots:GetAzeriteRank()) or A.Streamline:IsSpellLearned() or bool(A.FocusedFire:GetAzeriteRank()))) then
                return A.DoubleTap:Show(icon)
            end
            -- berserking,if=buff.trueshot.up&(target.time_to_die>cooldown.berserking.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<13
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit(unit):TimeToDie() > A.Berserking:BaseDuration() + A.BerserkingBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 13) then
                return A.Berserking:Show(icon)
            end
            -- blood_fury,if=buff.trueshot.up&(target.time_to_die>cooldown.blood_fury.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<16
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit(unit):TimeToDie() > A.BloodFury:BaseDuration() + A.BloodFuryBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
                return A.BloodFury:Show(icon)
            end
            -- ancestral_call,if=buff.trueshot.up&(target.time_to_die>cooldown.ancestral_call.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<16
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit(unit):TimeToDie() > A.AncestralCall:BaseDuration() + duration or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) then
                return A.AncestralCall:Show(icon)
            end
            -- fireblood,if=buff.trueshot.up&(target.time_to_die>cooldown.fireblood.duration+duration|(target.health.pct<20|!talent.careful_aim.enabled))|target.time_to_die<9
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit(unit):TimeToDie() > A.Fireblood:BaseDuration() + duration or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned())) or Unit(unit):TimeToDie() < 9) then
                return A.Fireblood:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            -- potion,if=buff.trueshot.react&buff.bloodlust.react|buff.trueshot.up&ca_execute|target.time_to_die<25
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") and (bool(Unit("player"):HasBuffsStacks(A.TrueshotBuff.ID, true)) and Unit("player"):HasHeroism or Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and bool(ca_execute) or Unit(unit):TimeToDie() < 25) then
                A.BattlePotionofAgility:Show(icon)
            end
            -- trueshot,if=cooldown.rapid_fire.remains&target.time_to_die>cooldown.trueshot.duration_guess+duration|(target.health.pct<20|!talent.careful_aim.enabled)|target.time_to_die<15
            if A.Trueshot:IsReady(unit) and (bool(A.RapidFire:GetCooldown()) and Unit(unit):TimeToDie() > cooldown.trueshot.duration_guess + A.TrueshotBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned()) or Unit(unit):TimeToDie() < 15) then
                return A.Trueshot:Show(icon)
            end
        end
        
        --St
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
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not A.SerpentSting:IsSpellInFlight()) then
                return A.SerpentSting:Show(icon)
            end
            -- rapid_fire,if=focus<50&(buff.bloodlust.up&buff.trueshot.up|buff.trueshot.down)
            if A.RapidFire:IsReady(unit) and (Player:Focus() < 50 and (Unit("player"):HasHeroism and Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or bool(Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true)))) then
                return A.RapidFire:Show(icon)
            end
            -- arcane_shot,if=buff.master_marksman.up&buff.trueshot.up&focus+cast_regen<focus.max
            if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true) and Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and Player:Focus() + Unit("player"):FocusCastRegen(A.ArcaneShot:GetSpellCastTime) < Player:FocusMax()) then
                return A.ArcaneShot:Show(icon)
            end
            -- aimed_shot,if=buff.precise_shots.down|cooldown.aimed_shot.full_recharge_time<action.aimed_shot.cast_time|buff.trueshot.up
            if A.AimedShot:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.PreciseShotsBuff.ID, true)) or A.AimedShot:FullRechargeTimeP() < A.AimedShot:GetSpellCastTime() or Unit("player"):HasBuffs(A.TrueshotBuff.ID, true)) then
                return A.AimedShot:Show(icon)
            end
            -- rapid_fire,if=focus+cast_regen<focus.max|azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1|azerite.surging_shots.enabled|talent.streamline.enabled
            if A.RapidFire:IsReady(unit) and (Player:Focus() + Unit("player"):FocusCastRegen(A.RapidFire:GetSpellCastTime) < Player:FocusMax() or bool(A.FocusedFire:GetAzeriteRank()) or A.IntheRhythm:GetAzeriteRank() > 1 or bool(A.SurgingShots:GetAzeriteRank()) or A.Streamline:IsSpellLearned()) then
                return A.RapidFire:Show(icon)
            end
            -- piercing_shot
            if A.PiercingShot:IsReady(unit) then
                return A.PiercingShot:Show(icon)
            end
            -- arcane_shot,if=focus>85|(buff.precise_shots.up|focus>45&cooldown.trueshot.remains&target.time_to_die<25)&buff.trueshot.down|target.time_to_die<5
            if A.ArcaneShot:IsReady(unit) and (Player:Focus() > 85 or (Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) or Player:Focus() > 45 and bool(A.Trueshot:GetCooldown()) and Unit(unit):TimeToDie() < 25) and bool(Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true)) or Unit(unit):TimeToDie() < 5) then
                return A.ArcaneShot:Show(icon)
            end
            -- steady_shot
            if A.SteadyShot:IsReady(unit) then
                return A.SteadyShot:Show(icon)
            end
        end
        
        --Trickshots
        local function Trickshots(unit)
            -- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
            -- explosive_shot
            if A.ExplosiveShot:IsReady(unit) then
                return A.ExplosiveShot:Show(icon)
            end
            -- rapid_fire,if=buff.trick_shots.up&(azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1|azerite.surging_shots.enabled|talent.streamline.enabled)
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) and (bool(A.FocusedFire:GetAzeriteRank()) or A.IntheRhythm:GetAzeriteRank() > 1 or bool(A.SurgingShots:GetAzeriteRank()) or A.Streamline:IsSpellLearned())) then
                return A.RapidFire:Show(icon)
            end
            -- aimed_shot,if=buff.trick_shots.up&(buff.precise_shots.down|cooldown.aimed_shot.full_recharge_time<action.aimed_shot.cast_time)
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) and (bool(Unit("player"):HasBuffsDown(A.PreciseShotsBuff.ID, true)) or A.AimedShot:FullRechargeTimeP() < A.AimedShot:GetSpellCastTime())) then
                return A.AimedShot:Show(icon)
            end
            -- rapid_fire,if=buff.trick_shots.up
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true)) then
                return A.RapidFire:Show(icon)
            end
            -- multishot,if=buff.trick_shots.down|buff.precise_shots.up|focus>70
            if A.Multishot:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.TrickShotsBuff.ID, true)) or Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) or Player:Focus() > 70) then
                return A.Multishot:Show(icon)
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
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not A.SerpentSting:IsSpellInFlight()) then
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

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_shot
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

