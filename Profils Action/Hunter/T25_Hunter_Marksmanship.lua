-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local Action									= Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell								= Action.FrameHasSpell
local Azerite									= LibStub("AzeriteTraits")
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_HUNTER_MARKSMANSHIP] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    HuntersMarkDebuff                      = Action.Create({ Type = "Spell", ID = 257284 }),
    HuntersMark                            = Action.Create({ Type = "Spell", ID = 257284 }),
    DoubleTap                              = Action.Create({ Type = "Spell", ID = 260402 }),
    TrueshotBuff                           = Action.Create({ Type = "Spell", ID = 288613 }),
    Trueshot                               = Action.Create({ Type = "Spell", ID = 288613 }),
    AimedShot                              = Action.Create({ Type = "Spell", ID = 19434 }),
    RapidFire                              = Action.Create({ Type = "Spell", ID = 257044 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Action.Create({ Type = "Spell", ID = 26297 }),
    CarefulAim                             = Action.Create({ Type = "Spell", ID = 260228 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    BloodFuryBuff                          = Action.Create({ Type = "Spell", ID = 20572 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    PreciseShotsBuff                       = Action.Create({ Type = "Spell", ID = 260242 }),
    ExplosiveShot                          = Action.Create({ Type = "Spell", ID = 212431 }),
    Barrage                                = Action.Create({ Type = "Spell", ID = 120360 }),
    AMurderofCrows                         = Action.Create({ Type = "Spell", ID = 131894 }),
    SerpentSting                           = Action.Create({ Type = "Spell", ID = 271788 }),
    SerpentStingDebuff                     = Action.Create({ Type = "Spell", ID = 271788 }),
    UnerringVisionBuff                     = Action.Create({ Type = "Spell", ID = 274447 }),
    UnerringVision                         = Action.Create({ Type = "Spell", ID = 274444 }),
    ArcaneShot                             = Action.Create({ Type = "Spell", ID = 185358 }),
    MasterMarksmanBuff                     = Action.Create({ Type = "Spell", ID = 269576 }),
    DoubleTapBuff                          = Action.Create({ Type = "Spell", ID = 260402 }),
    PiercingShot                           = Action.Create({ Type = "Spell", ID = 198670 }),
    FocusedFire                            = Action.Create({ Type = "Spell", ID = 278531 }),
    SteadyShot                             = Action.Create({ Type = "Spell", ID = 56641 }),
    TrickShotsBuff                         = Action.Create({ Type = "Spell", ID = 257622 }),
    IntheRhythm                            = Action.Create({ Type = "Spell", ID = 264198 }),
    SurgingShots                           = Action.Create({ Type = "Spell", ID = 287707 }),
    Streamline                             = Action.Create({ Type = "Spell", ID = 260367 }),
    Multishot                              = Action.Create({ Type = "Spell", ID = 257620 }),
    CallingtheShots                        = Action.Create({ Type = "Spell", ID = 260404 }),
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
    BattlePotionofAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
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

	-- Azerite beam protection channel
	local CanCast = true
	local TotalCast, CurrentCastLeft, CurrentCastDone = Unit(player):CastTime()
	local _, castStartedTime, castEndTime = Unit(player):IsCasting()
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
	-- Ensure all channel and cast are really safe
	-- Double protection with check on current casts and also timestamp of the cast
	if (spellID == A.FocusedAzeriteBeam.ID) then 
	    if (CurrentCastLeft > 0 or secondsLeft > 0 or isChannel) then
		    if TMW.time < castEndTime then			
			    CanCast = false
	        else
	            CanCast = true
			end
		end
	end
	-- Showing icon PoolResource to make sure nothing else is read by GG
	if not CanCast then
	    return A.PoolResource:Show(icon)
	end
	------------------------------------
	---------- DUMMY DPS TEST ----------
	------------------------------------
	local DummyTime = GetToggle(2, "DummyTime")
	if DummyTime > 0 then
    	local unit = "target"
		local endtimer = 0
		
    	if Unit(unit):IsExists() and Unit(unit):IsDummy() then
        	if Unit(player):CombatTime() >= (DummyTime * 60) then
            	StopAttack()
				endtimer = TMW.time
            	--ClearTarget() -- Protected ? 
	       	    -- Notification					
          	    Action.SendNotification(DummyTime .. " Minutes Dummy Test Concluded - Profile Stopped", A.DummyTest.ID)			
         	    
				if endtimer < TMW.time + 5 then
				    profileStop = true
				    --return A.DummyTest:Show(icon)
				end
    	    end
  	    end
	end	
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

		--Precombat
        if combatTime == 0 and not profileStop and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- hunters_mark
            if A.HuntersMark:IsReady(unit) and Unit("player"):HasDebuffsDown(A.HuntersMarkDebuff.ID, true) then
                return A.HuntersMark:Show(icon)
            end
			
            -- double_tap,precast_time=10
            if A.DoubleTap:IsReady(unit) then
                return A.DoubleTap:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player) then
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- trueshot,precast_time=1.5,if=active_enemies>2
            if A.Trueshot:IsReady(unit) and Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.Trueshot:Show(icon)
            end
			
            -- potion,dynamic_prepot=1
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- aimed_shot,if=active_enemies<3
            if A.AimedShot:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.AimedShot:Show(icon)
            end
			
        end
        
        --Cds
        local function Cds(unit)
            -- hunters_mark,if=debuff.hunters_mark.down&!buff.trueshot.up
            if A.HuntersMark:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.HuntersMarkDebuff.ID, true)) and not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true)) then
                return A.HuntersMark:Show(icon)
            end
            -- double_tap,if=cooldown.rapid_fire.remains<gcd|cooldown.rapid_fire.remains<cooldown.aimed_shot.remains|target.time_to_die<20
            if A.DoubleTap:IsReady(unit) and (A.RapidFire:GetCooldown() < A.GetGCD() or A.RapidFire:GetCooldown() < A.AimedShot:GetCooldown() or Unit(unit):TimeToDie() < 20) then
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
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) then
                return A.BagofTricks:Show(icon)
            end
            -- reaping_flames,if=target.health.pct>80|target.health.pct<=20|target.time_to_pct_20>30
            if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and (Unit(unit):HealthPercent() > 80 or Unit(unit):HealthPercent() <= 20 or target.time_to_pct_20 > 30) then
                return A.ReapingFlames:Show(icon)
            end
            -- worldvein_resonance,if=(trinket.azsharas_font_of_power.cooldown.remains>20|!equipped.azsharas_font_of_power|target.time_to_die<trinket.azsharas_font_of_power.cooldown.duration+34&target.health.pct>20)&(cooldown.trueshot.remains_guess<3|(essence.vision_of_perfection.minor&target.time_to_die>cooldown+buff.worldvein_resonance.duration))|target.time_to_die<20
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((trinket.azsharas_font_of_power.cooldown.remains > 20 or not A.AzsharasFontofPower:IsExists() or Unit(unit):TimeToDie() < trinket.azsharas_font_of_power.cooldown.duration + 34 and Unit(unit):HealthPercent() > 20) and (cooldown.trueshot.remains_guess < 3 or (bool(Azerite:EssenceHasMinor(A.VisionofPerfection.ID)) and Unit(unit):TimeToDie() > cooldown + A.WorldveinResonanceBuff.ID, true:BaseDuration())) or Unit(unit):TimeToDie() < 20) then
                return A.WorldveinResonance:Show(icon)
            end
            -- guardian_of_azeroth,if=(ca_execute|target.time_to_die>cooldown+30)&(buff.trueshot.up|cooldown.trueshot.remains<16)|target.time_to_die<31
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((bool(ca_execute) or Unit(unit):TimeToDie() > cooldown + 30) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or A.Trueshot:GetCooldown() < 16) or Unit(unit):TimeToDie() < 31) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- ripple_in_space,if=cooldown.trueshot.remains<7
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.Trueshot:GetCooldown() < 7) then
                return A.RippleinSpace:Show(icon)
            end
            -- memory_of_lucid_dreams,if=!buff.trueshot.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- potion,if=buff.trueshot.react&buff.bloodlust.react|buff.trueshot.up&target.health.pct<20|((consumable.potion_of_unbridled_fury|consumable.unbridled_fury)&target.time_to_die<61|target.time_to_die<26)
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (bool(Unit("player"):HasBuffsStacks(A.TrueshotBuff.ID, true)) and Unit("player"):HasHeroism() or Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and Unit(unit):HealthPercent() < 20 or ((Unit(unit):HasBuffs(A.PotionofUnbridledFuryBuff.ID, true) or Unit(unit):HasBuffs(A.UnbridledFuryBuff.ID, true)) and Unit(unit):TimeToDie() < 61 or Unit(unit):TimeToDie() < 26)) then
                A.PotionofUnbridledFury:Show(icon)
            end
            -- trueshot,if=focus>60&(buff.precise_shots.down&cooldown.rapid_fire.remains&target.time_to_die>cooldown.trueshot.duration_guess+buff.trueshot.duration|(target.health.pct<20|!talent.careful_aim.enabled)&(!equipped.azsharas_font_of_power|trinket.azsharas_font_of_power.cooldown.remains>15))|target.time_to_die<15
            if A.Trueshot:IsReady(unit) and (Player:Focus() > 60 and (bool(Unit("player"):HasBuffsDown(A.PreciseShotsBuff.ID, true)) and bool(A.RapidFire:GetCooldown()) and Unit(unit):TimeToDie() > cooldown.trueshot.duration_guess + A.TrueshotBuff.ID, true:BaseDuration() or (Unit(unit):HealthPercent() < 20 or not A.CarefulAim:IsSpellLearned()) and (not A.AzsharasFontofPower:IsExists() or trinket.azsharas_font_of_power.cooldown.remains > 15)) or Unit(unit):TimeToDie() < 15) then
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
            -- rapid_fire,if=buff.trueshot.down|focus<70
            if A.RapidFire:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true)) or Player:Focus() < 70) then
                return A.RapidFire:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.trueshot.up&(buff.unerring_vision.stack>4|!azerite.unerring_vision.enabled)|target.time_to_die<11
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit("player"):HasBuffsStacks(A.UnerringVisionBuff.ID, true) > 4 or not bool(A.UnerringVision:GetAzeriteRank())) or Unit(unit):TimeToDie() < 11) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- focused_azerite_beam,if=!buff.trueshot.up|target.time_to_die<5
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or Unit(unit):TimeToDie() < 5) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- arcane_shot,if=buff.trueshot.up&buff.master_marksman.up&!buff.memory_of_lucid_dreams.up
            if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true) and not Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.ArcaneShot:Show(icon)
            end
            -- aimed_shot,if=buff.trueshot.up|(buff.double_tap.down|ca_execute)&buff.precise_shots.down|full_recharge_time<cast_time&cooldown.trueshot.remains
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or (bool(Unit("player"):HasBuffsDown(A.DoubleTapBuff.ID, true)) or bool(ca_execute)) and bool(Unit("player"):HasBuffsDown(A.PreciseShotsBuff.ID, true)) or A.AimedShot:GetSpellChargesFullRechargeTime() < A.AimedShot:GetSpellCastTime() and bool(A.Trueshot:GetCooldown())) then
                return A.AimedShot:Show(icon)
            end
            -- arcane_shot,if=buff.trueshot.up&buff.master_marksman.up&buff.memory_of_lucid_dreams.up
            if A.ArcaneShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.ArcaneShot:Show(icon)
            end
            -- piercing_shot
            if A.PiercingShot:IsReady(unit) then
                return A.PiercingShot:Show(icon)
            end
            -- purifying_blast,if=!buff.trueshot.up|target.time_to_die<8
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or Unit(unit):TimeToDie() < 8) then
                return A.PurifyingBlast:Show(icon)
            end
            -- concentrated_flame,if=focus+focus.regen*gcd<focus.max&buff.trueshot.down&(!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight)|full_recharge_time<gcd|target.time_to_die<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:Focus() + Player:FocusRegen() * A.GetGCD() < Player:FocusMax() and bool(Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true)) and (not bool(Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true)) and not A.ConcentratedFlame:IsSpellInFlight()) or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD() or Unit(unit):TimeToDie() < 5) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10|target.time_to_die<5
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10 or Unit(unit):TimeToDie() < 5) then
                return A.TheUnboundForce:Show(icon)
            end
            -- arcane_shot,if=buff.trueshot.down&(buff.precise_shots.up&(focus>41|buff.master_marksman.up)|(focus>50&azerite.focused_fire.enabled|focus>75)&(cooldown.trueshot.remains>5|focus>80)|target.time_to_die<5)
            if A.ArcaneShot:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.TrueshotBuff.ID, true)) and (Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) and (Player:Focus() > 41 or Unit("player"):HasBuffs(A.MasterMarksmanBuff.ID, true)) or (Player:Focus() > 50 and bool(A.FocusedFire:GetAzeriteRank()) or Player:Focus() > 75) and (A.Trueshot:GetCooldown() > 5 or Player:Focus() > 80) or Unit(unit):TimeToDie() < 5)) then
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
            -- aimed_shot,if=buff.trick_shots.up&ca_execute&buff.double_tap.up
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) and bool(ca_execute) and Unit("player"):HasBuffs(A.DoubleTapBuff.ID, true)) then
                return A.AimedShot:Show(icon)
            end
            -- rapid_fire,if=buff.trick_shots.up&(azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1|azerite.surging_shots.enabled|talent.streamline.enabled)
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) and (bool(A.FocusedFire:GetAzeriteRank()) or A.IntheRhythm:GetAzeriteRank() > 1 or bool(A.SurgingShots:GetAzeriteRank()) or A.Streamline:IsSpellLearned())) then
                return A.RapidFire:Show(icon)
            end
            -- aimed_shot,if=buff.trick_shots.up&(buff.precise_shots.down|cooldown.aimed_shot.full_recharge_time<action.aimed_shot.cast_time|buff.trueshot.up)
            if A.AimedShot:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true) and (bool(Unit("player"):HasBuffsDown(A.PreciseShotsBuff.ID, true)) or A.AimedShot:GetSpellChargesFullRechargeTime() < A.AimedShot:GetSpellCastTime() or Unit("player"):HasBuffs(A.TrueshotBuff.ID, true))) then
                return A.AimedShot:Show(icon)
            end
            -- rapid_fire,if=buff.trick_shots.up
            if A.RapidFire:IsReady(unit) and (Unit("player"):HasBuffs(A.TrickShotsBuff.ID, true)) then
                return A.RapidFire:Show(icon)
            end
            -- multishot,if=buff.trick_shots.down|buff.precise_shots.up&!buff.trueshot.up|focus>70
            if A.Multishot:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.TrickShotsBuff.ID, true)) or Unit("player"):HasBuffs(A.PreciseShotsBuff.ID, true) and not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or Player:Focus() > 70) then
                return A.Multishot:Show(icon)
            end
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
            -- blood_of_the_enemy
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
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
            if A.SerpentSting:IsReady(unit) and (Unit(unit):HasDeBuffsRefreshable(A.SerpentStingDebuff.ID, true) and not A.SerpentSting:IsSpellInFlight()) then
                return A.SerpentSting:Show(icon)
            end
            -- steady_shot
            if A.SteadyShot:IsReady(unit) then
                return A.SteadyShot:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_shot
            -- use_item,name=lurkers_insidious_gift,if=cooldown.trueshot.remains_guess<15|target.time_to_die<30
            if A.LurkersInsidiousGift:IsReady(unit) and (cooldown.trueshot.remains_guess < 15 or Unit(unit):TimeToDie() < 30) then
                A.LurkersInsidiousGift:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=(target.time_to_die>cooldown+34|target.health.pct<20|target.time_to_pct_20<15)&cooldown.trueshot.remains_guess<15|target.time_to_die<35
            if A.AzsharasFontofPower:IsReady(player) and ((Unit(unit):TimeToDie() > cooldown + 34 or Unit(unit):HealthPercent() < 20 or target.time_to_pct_20 < 15) and cooldown.trueshot.remains_guess < 15 or Unit(unit):TimeToDie() < 35) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=lustrous_golden_plumage,if=cooldown.trueshot.remains_guess<5|target.time_to_die<20
            if A.LustrousGoldenPlumage:IsReady(unit) and (cooldown.trueshot.remains_guess < 5 or Unit(unit):TimeToDie() < 20) then
                A.LustrousGoldenPlumage:Show(icon)
            end
            -- use_item,name=galecallers_boon,if=buff.trueshot.up|!talent.calling_the_shots.enabled|target.time_to_die<10
            if A.GalecallersBoon:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) or not A.CallingtheShots:IsSpellLearned() or Unit(unit):TimeToDie() < 10) then
                A.GalecallersBoon:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=buff.trueshot.up&(buff.guardian_of_azeroth.up|!essence.condensed_lifeforce.major&target.health.pct<20)|debuff.razor_coral_debuff.down|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and (Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) or not Azerite:EssenceHasMajor(A.CondensedLifeforce.ID) and Unit(unit):HealthPercent() < 20) or bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or Unit(unit):TimeToDie() < 20) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=pocketsized_computation_device,if=!buff.trueshot.up&!essence.blood_of_the_enemy.major|debuff.blood_of_the_enemy.up|target.time_to_die<5
            if A.PocketsizedComputationDevice:IsReady(unit) and (not Unit("player"):HasBuffs(A.TrueshotBuff.ID, true) and not bool(Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID)) or Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true) or Unit(unit):TimeToDie() < 5) then
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

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
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
--[[local function FreezingTrapUsedByEnemy()
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
end]]--

