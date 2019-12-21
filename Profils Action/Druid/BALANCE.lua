--- ====================== ACTION HEADER ============================ ---
local TMW                                    = TMW
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
local wipe                                   = wipe 
local math_floor                             = math.floor
local math_ceil                              = math.ceil
local setmetatable, select, unpack, table, pairs    = 
setmetatable, select, unpack, table, pairs 
local tinsert                                = table.insert 
local CombatLogGetCurrentEventInfo           = CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower =
UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local TR                                     = Action.TasteRotation
--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DRUID_BALANCE] = {
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
    --BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    StreakingStars                         = Action.Create({ Type = "Spell", ID = 272871 }),
    ArcanicPulsarBuff                      = Action.Create({ Type = "Spell", ID = 287790 }),
    ArcanicPulsar                          = Action.Create({ Type = "Spell", ID = 287773 }),
    StarlordBuff                           = Action.Create({ Type = "Spell", ID = 279709 }),
    Starlord                               = Action.Create({ Type = "Spell", ID = 202345 }),
    TwinMoons                              = Action.Create({ Type = "Spell", ID = 279620 }),
    MoonkinForm                            = Action.Create({ Type = "Spell", ID = 24858 }),
    SolarWrath                             = Action.Create({ Type = "Spell", ID = 190984 }),
    Starsurge                              = Action.Create({ Type = "Spell", ID = 78674 }),
    CelestialAlignmentBuff                 = Action.Create({ Type = "Spell", ID = 194223 }),
    IncarnationBuff                        = Action.Create({ Type = "Spell", ID = 102560 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    MoonfireDebuff                         = Action.Create({ Type = "Spell", ID = 164812 }),
    SunfireDebuff                          = Action.Create({ Type = "Spell", ID = 164815 }),
    StellarFlare                           = Action.Create({ Type = "Spell", ID = 202347 }),
    StellarFlareDebuff                     = Action.Create({ Type = "Spell", ID = 202347 }),
    ShiverVenomDebuff                      = Action.Create({ Type = "Spell", ID = 301624     }),	
    Thorns                                 = Action.Create({ Type = "Spell", ID = 467 }),
    WarriorofElune                         = Action.Create({ Type = "Spell", ID = 202425 }),
    Innervate                              = Action.Create({ Type = "Spell", ID = 29166 }),
    LivelySpirit                           = Action.Create({ Type = "Spell", ID = 279642 }),
    Incarnation                            = Action.Create({ Type = "Spell", ID = 102560 }),
    CelestialAlignment                     = Action.Create({ Type = "Spell", ID = 194223 }),
    ForceofNature                          = Action.Create({ Type = "Spell", ID = 205636 }),
    LivelySpiritBuff                       = Action.Create({ Type = "Spell", ID = 279646 }),
    FuryofElune                            = Action.Create({ Type = "Spell", ID = 202770 }),
    Starfall                               = Action.Create({ Type = "Spell", ID = 191034 }),
    LunarEmpowermentBuff                   = Action.Create({ Type = "Spell", ID = 164547 }),
    SolarEmpowermentBuff                   = Action.Create({ Type = "Spell", ID = 164545 }),
    Sunfire                                = Action.Create({ Type = "Spell", ID = 93402 }),
    Moonfire                               = Action.Create({ Type = "Spell", ID = 8921 }),
    NewMoon                                = Action.Create({ Type = "Spell", ID = 274281 }),
    HalfMoon                               = Action.Create({ Type = "Spell", ID = 274282 }),
    FullMoon                               = Action.Create({ Type = "Spell", ID = 274283 }),
    LunarStrike                            = Action.Create({ Type = "Spell", ID = 194153 }),
    WarriorofEluneBuff                     = Action.Create({ Type = "Spell", ID = 202425 }),
    Renewal                                = Action.Create({ Type = "Spell", ID = 108238     }),
    SolarBeam                              = Action.Create({ Type = "Spell", ID = 78675     }), 
    ShootingStars                          = Action.Create({ Type = "Spell", ID = 202342     }),
    NaturesBalance                         = Action.Create({ Type = "Spell", ID = 202430     }),	
	-- Utilities
	Typhoon                                = Action.Create({ Type = "Spell", ID = 132469   }),
	MightyBash                             = Action.Create({ Type = "Spell", ID = 5211   }),
	Soothe                                 = Action.Create({ Type = "Spell", ID = 2908   }),    
	EntanglingRoots                        = Action.Create({ Type = "Spell", ID = 339   }), 
	RemoveCorruption                       = Action.Create({ Type = "Spell", ID = 2782  }),
	Cyclone                                = Action.Create({ Type = "Spell", ID = 33786 }),
    -- Defensive
	Barkskin                               = Action.Create({ Type = "Spell", ID = 22812   }),	
	Swiftmend								= Action.Create({ Type = "Spell", ID = 18562}), -- Talent 3/3 -- Resto Affinity
	CancelStarlord                         = Action.Create({ Type = "Spell", ID = 208683, Hidden = true}), -- 208683 Gladiator medaillon remap
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
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	AbyssalHealingPotion    			   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }),	
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
Action:CreateEssencesFor(ACTION_CONST_DRUID_BALANCE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_BALANCE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarAzSs = 0;
local VarAzAp = 0;
local VarSfTargets = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarAzSs = 0
  VarAzAp = 0
  VarSfTargets = 0
end)



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
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForStun								= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC								= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun					= {"CCTotalImun", "StunImun"},
	AuraForDisableMag						= {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AuraForInterrupt						= {"TotalImun", "DamagePhysImun", "KickImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function FutureAstralPower()
    local AstralPower = Player:AstralPower()
    local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit("player"):IsCasting()
        
    if not Unit("player"):IsCasting() then
        return AstralPower
    else
        if spellID == A.NewMoon.ID then
            return AstralPower + 10
        elseif spellID == A.HalfMoon.ID then
            return AstralPower + 20
        elseif spellID == A.FullMoon.ID then
            return AstralPower + 40
        elseif spellID == A.StellarFlare.ID then
            return AstralPower + 8
        elseif spellID == A.SolarWrath.ID then
            return AstralPower + 8
        elseif spellID == A.LunarStrike.ID then
            return AstralPower + 12
        else
            return AstralPower
        end
    end
end

-- Return current CelestialAlignment or Incarnation
local function CaInc()
    return A.Incarnation:IsSpellLearned() and A.Incarnation or A.CelestialAlignment
end

-- Return current CelestialAlignment or Incarnation (with ID to work with buff checks)
local function CaIncID()
    return A.Incarnation:IsSpellLearned() and A.Incarnation.ID or A.CelestialAlignment.ID
end

local function AP_Check(spell)
  local APGen = 0
  local CurAP = Player:AstralPower()
  if spell == A.Sunfire or spell == A.Moonfire then 
    APGen = 3
  elseif spell == A.StellarFlare or spell == A.SolarWrath then
    APGen = 8
  elseif spell == A.Incarnation or spell == A.CelestialAlignment then
    APGen = 40
  elseif spell == A.ForceofNature then
    APGen = 20
  elseif spell == A.LunarStrike then
    APGen = 12
  end
  
  if A.ShootingStars:IsSpellLearned() then 
    APGen = APGen + 4
  end
  if A.NaturesBalance:IsSpellLearned() then
    APGen = APGen + 2
  end
  
  if CurAP + APGen < Player:AstralPowerMax() then
    return true
  else
    return false
  end
end

local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if Player:InDungeon() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if Player:InPvP() then 
    		return true
		else
		    return false
		end		
    elseif choice == "Everywhere" then 
        return true
    else
		return false
    end
	--print(choice)
end

local function IsSchoolNatureUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function IsSchoolArcaneUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "ARCANE") == 0
end 

local function EvaluateCycleCyclotronicBlast105(unit)
    return (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) and (Unit("player"):HasBuffs(CaIncID, true) == 0)
end

local function EvaluateCycleShiverVenomRelic122(unit)
    return (Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5) and (Unit("player"):HasBuffs(CaIncID, true) == 0 and not Unit("player"):HasHeroism())
end

local function SelfDefensives()
	-- Renewal
	local Renewal = A.GetToggle(2, "RenewalHP")
    if A.Renewal:IsReady("player") and Unit("player"):HealthPercent() <= Renewal then
        return A.Renewal:Show(icon)
    end			
	
    -- Barkskin	
	local Barkskin = A.GetToggle(2, "BarkskinHP")	
	if A.Barkskin:IsReady("player") and Unit("player"):HealthPercent() <= Barkskin and Unit("player"):CombatTime() > 0 then
		return A.Barkskin
	end
	
	-- Swiftmend
	local Swiftmend = A.GetToggle(2, "SwiftmendHP")	
	if A.Swiftmend:IsReady("player") and  Unit("player"):HealthPercent() <= Swiftmend then
		return A.Swiftmend
	end
	
	-- HealingPotion
	local PotHeal = A.GetToggle(2, "AbyssalPot")
	if A.AbyssalHealingPotion:IsReady("player") and  Unit("player"):HealthPercent() <= PotHeal and Unit("player"):CombatTime() > 0 then
		return A.AbyssalHealingPotion
	end
	
end
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

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
    local CaIncID = CaIncID()
	local CaInc = CaInc()
	local isMultiDoT = A.GetToggle(2, "MultiDot")
	local isMultiDoTRange = A.GetToggle(2, "MultiDotDistance")	
    local MoonfireToRefresh = MultiUnits:GetByRangeDoTsToRefresh(isMultiDoTRange, 2, A.Moonfire.ID, 5)
    local SunfireToRefresh = MultiUnits:GetByRangeDoTsToRefresh(isMultiDoTRange, 2, A.Sunfire.ID, 5)
	local MissingSunfire = MultiUnits:GetByRangeMissedDoTs(isMultiDoTRange, 2, A.Sunfire.ID, 10)
	local MissingMoonfire = MultiUnits:GetByRangeMissedDoTs(isMultiDoTRange, 2, A.Moonfire.ID, 10)

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) and not inCombat then
                return A.AzsharasFontofPower:Show(icon)
            end
            -- potion,dynamic_prepot=1
            if A.PotionofUnbridledFury:IsReady(unit) and not inCombat and Action.GetToggle(1, "Potion") 
			and ((Pull > 0.1 and Pull <= A.SolarWrath:GetSpellCastTime() + A.GetGCD()) or not Action.GetToggle(1, "DBM"))
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
            -- solar_wrath
            if A.SolarWrath:IsReady(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() 
            and ((Pull > 0.1 and Pull <= A.SolarWrath:GetSpellCastTime()) or not Action.GetToggle(1, "DBM"))			
			then
                return A.SolarWrath:Show(icon)
            end
            -- solar_wrath
            if A.SolarWrath:IsReady(unit) and not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem()
            and ((Pull > 0.1 and Pull <= A.SolarWrath:GetSpellCastTime()) or not Action.GetToggle(1, "DBM"))
			then
                return A.SolarWrath:Show(icon)
            end
            -- starsurge_with_talent_naturesbalance
            if A.Starsurge:IsReady(unit) and not inCombat and A.NaturesBalance:IsSpellLearned()
			and ((Pull > 0.1 and Pull <= 0.5) or not Action.GetToggle(1, "DBM"))
			then
                return A.Starsurge:Show(icon)
            end
        end
		
		-- Auto multidot
		local function Multidots(unit)
		    if Unit(unit):HasDeBuffs(A.Sunfire.ID, true) > 0 and MultiUnits:GetActiveEnemies() <= 5 and Unit(unit):HasDeBuffs(A.Moonfire.ID, true) > 0 and A.GetToggle(2, "AoE") and
		    (
			    (MissingSunfire >= 1 )
				or 
				(MissingMoonfire >= 1 )
			) 
			then
			    return A:Show(icon, ACTION_CONST_AUTOTARGET)
		    end		
		end
        
		-- Pandemic
		local function Pandemic(unit)
		    --sunfire
		    if A.Sunfire:IsReady(unit) then
			    if Unit(unit):HasDeBuffs(A.Sunfire.ID, true) <= 5.4 and A.LastPlayerCastID ~= A.Sunfire.ID and IsSchoolNatureUP() and A.Sunfire:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsStance(4) and AP_Check(A.Sunfire)
				and (
				        VarAzSs == 0 or
				        (
				            Unit("player"):HasBuffs(CaIncID, true) == 0 
				        ) 
				        or A.LastPlayerCastID ~= A.Sunfire.ID
					) 					
				and (
				        (Unit("player"):HasBuffs(CaIncID, true) >= 7) or
		                (Unit("player"):HasBuffs(CaIncID, true) == 0)
		            )
		        or  (
				        Unit("player"):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) >= 7 and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) <= 10
					) 
				then
				    return A.Sunfire:Show(icon)
                end	
			end
			
		    --moonfire
		    if A.Moonfire:IsReady(unit) then
			    if Unit(unit):HasDeBuffs(A.Moonfire.ID, true) <= 5.4 and A.LastPlayerCastID ~= A.Moonfire.ID and IsSchoolNatureUP() and A.Moonfire:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsStance(4) and AP_Check(A.Moonfire)
				and (
				        VarAzSs == 0 or
				        (
				            Unit("player"):HasBuffs(CaIncID, true) == 0 
				        ) 
				        or A.LastPlayerCastID ~= A.Moonfire.ID
					) 					
				and (
				        (Unit("player"):HasBuffs(CaIncID, true) >= 7) or
		                (Unit("player"):HasBuffs(CaIncID, true) == 0)
		            )
		        or  (
				        Unit("player"):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) >= 7 and Unit(unit):HasDeBuffs(A.Moonfire.ID, true) <= 10
					) 
				then
				    return A.Moonfire:Show(icon)
                end	
			end
			
		    --stellar_flare
		    if A.StellarFlare:IsReady(unit) then
			    if Unit(unit):HasDeBuffs(A.StellarFlare.ID, true) <= 5.4 and A.LastPlayerCastID ~= A.StellarFlare.ID and IsSchoolNatureUP() and A.StellarFlare:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsStance(4) and AP_Check(A.StellarFlare)
				and (
				        VarAzSs == 0 or
				        (
				            Unit("player"):HasBuffs(CaIncID, true) == 0 
				        ) 
				        or A.LastPlayerCastID ~= A.StellarFlare.ID
					) 					
				and (
				        (Unit("player"):HasBuffs(CaIncID, true) >= 7) or
		                (Unit("player"):HasBuffs(CaIncID, true) == 0)
		            )
		        or  (
				        Unit("player"):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) >= 7 and Unit(unit):HasDeBuffs(A.StellarFlare.ID, true) <= 10
					) 
				then
				    return A.StellarFlare:Show(icon)
                end	
			end

		end
		
		-- Burst
        local function Burst(unit)	
            
			-- Trinkets 1		
			if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unit, "DamageMagicImun") and Trinket1IsAllowed and 
			(Unit("player"):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or A.Incarnation:IsSpellLearned() and Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) > 0) then 
				return A.Trinket1:Show(icon)
            end 
			
            -- Trinkets 2   
            if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unit, "DamageMagicImun") and Trinket2IsAllowed and
			(Unit("player"):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or A.Incarnation:IsSpellLearned() and Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) > 0) then 
				return A.Trinket2:Show(icon)
            end	
			
			-- Berserking
			if A.Berserking:AutoRacial(unit) and (Unit("player"):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or 
			A.Incarnation:IsSpellLearned() and Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) > 0) then
				return A.Berserking:Show(icon)
			end			
			
            -- Celestial Alignment & Incarnation
			if CaInc:IsReady("player") and (Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true) > 6 or not A.StellarFlare:IsSpellLearned()) and (Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 
			or AP_Check(CaInc)) and Unit("player"):HasBuffs(CaIncID, true) == 0 and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 5 and Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 6 
			then
	            if (not A.Starlord:IsSpellLearned() or Unit("player"):HasBuffs(A.StarlordBuff.ID, true) > 0) 
				    and (Unit("player"):HasBuffs(CaIncID, true) == 0 and (Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) 
				    or ((A.MemoryofLucidDreams:GetCooldown() > 20 or not bool(A.MemoryofLucidDreams:IsSpellLearned())) and AP_Check(CaInc))) 
				    and (Unit("player"):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or AP_Check(CaInc))) 
				then
                    -- Notification					
                    Action.SendNotification("Activated burst phase", CaIncID)
			    	return CaInc:Show(icon)
				end				                
            end

			-- Pocketsized Computation Device
			if A.PocketsizedComputationDevice:IsReady(unit) and A.PocketsizedComputationDevice:AbsentImun(unit, "DamageMagicImun") and TrinketON and 
			((Unit("player"):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) == 0) and 
			Unit(unit):HasDeBuffs(A.Moonfire.ID, true) > 6 and Unit(unit):HasDeBuffs(A.Sunfire.ID, true) > 5 and
			(not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlare.ID, true) > 0)) 
			then
				return A.PocketsizedComputationDevice:Show(icon)
			end
		end
		
        -- moonkin_form
        if A.MoonkinForm:IsReady("player") and not Unit("player"):HasBuffs(A.MoonkinForm.ID, true) and A.GetToggle(2, "ShowMoonkinFormOOC") then
            return A.MoonkinForm:Show(icon)
        end
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
		    
			-- Rotation Vars
			-- variable,name=az_ss,value=azerite.streaking_stars.rank
            local VarAzSs = A.StreakingStars:GetAzeriteRank()				
            -- variable,name=az_ap,value=azerite.arcanic_pulsar.rank
            local VarAzAp = A.ArcanicPulsar:GetAzeriteRank()				
            -- variable,name=sf_targets,value=4
            local VarSfTargets = 4				
            -- variable,name=sf_targets,op=add,value=1,if=azerite.arcanic_pulsar.enabled
            if (A.ArcanicPulsar:GetAzeriteRank() > 0) then
                VarSfTargets = VarSfTargets + 1
            end			
            -- variable,name=sf_targets,op=add,value=1,if=talent.starlord.enabled
            if (A.Starlord:IsSpellLearned()) then
                VarSfTargets = VarSfTargets + 1
            end			
            -- variable,name=sf_targets,op=add,value=1,if=azerite.streaking_stars.rank>2&azerite.arcanic_pulsar.enabled
            if (A.StreakingStars:GetAzeriteRank() > 2 and A.ArcanicPulsar:GetAzeriteRank() > 0) then
                VarSfTargets = VarSfTargets + 1
            end			
            -- variable,name=sf_targets,op=sub,value=1,if=!talent.twin_moons.enabled
            if (not A.TwinMoons:IsSpellLearned()) then
                VarSfTargets = VarSfTargets - 1
            end
			
		    -- Interrupt Handler 	 	
  		    local unit = "target"
   		    local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
            local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
	        local castLeft, _, spellID, _, notKickAble = Unit(unit):IsCastingRemains()
		
  	        -- SolarBeam
  	        if useKick and A.SolarBeam:IsReady() and A.SolarBeam:IsSpellLearned() then 
		      	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
				    -- Notification					
                    Action.SendNotification("Solar Beam on: " .. UnitName(unit), A.SolarBeam.ID) 
          	        return A.SolarBeam:Show(icon)
             	end 
          	end 	
			
     	    -- MightyBash
      	    if useCC and A.MightyBash:IsSpellLearned() and A.MightyBash:IsReady(unit) then 
	  		    if Unit(unit):CanInterrupt(true, nil, 25, 70) then
				    -- Notification					
                    Action.SendNotification("Mighty Bash on: " .. UnitName(unit), A.MightyBash.ID) 
     	            return A.MightyBash:Show(icon)
     	        end 
     	    end 	
			
			-- Soothe
			if unit ~= "targettarget" and A.Soothe:IsReady(unit, nil, nil, true) 
			and A.Soothe:AbsentImun(unit, Temp.AuraForOnlyCCAndStun) and A.AuraIsValid(unit, "UseExpelEnrage", "Enrage") 
			then 
			    -- Notification					
                Action.SendNotification("Soothe on: " .. UnitName(unit), A.Soothe.ID) 					
                return A.Soothe:Show(icon)
            end         
		
			-- Auto multidots
            if (isMulti or A.GetToggle(2, "AoE")) and HandleMultidots() then 
                if Multidots(unit) then 
				    return true
				end
			end		

			-- Burst
			if unit ~= "mouseover" and A.BurstIsON(unit) then
                if Burst(unit) then 
				    return true
				end
			end	

		    -- Starlord CancelBuff
		    if A.Starlord:IsSpellLearned() and Unit("player"):HasBuffs(A.StarlordBuff.ID, true) <= 5 and Unit("player"):HasBuffs(A.StarlordBuff.ID, true) > 0 and FutureAstralPower() >= 80 
			then
			    Player:CancelBuff(A.StarlordBuff:Info())
		    end
			
		    -- Spenders
			
			-- starfall
		    if A.Starfall:IsReady(unit, true) and IsSchoolArcaneUP() and IsSchoolNatureUP() and A.Starfall:AbsentImun(unit, Temp.TotalAndPhys) and 
		    ((Unit("player"):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 or Unit("player"):HasBuffs(A.StarlordBuff.ID, true) >= 8) and (A.GetToggle(2, "AoE") and MultiUnits:GetActiveEnemies() >= VarSfTargets) and
		    (Unit(unit):TimeToDie() + 1) * MultiUnits:GetActiveEnemies() > A.Starfall:GetSpellPowerCost() / 2.5)  
			then
			    return A.Starfall:Show(icon)
		    end
			
		    -- starsurge
		    if A.Starsurge:IsReady(unit) and IsSchoolArcaneUP() and A.Starsurge:AbsentImun(unit, Temp.TotalAndPhys) and Player:IsStance(4) and
		    ((A.Starlord:IsSpellLearned() and (Unit("player"):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 or Unit("player"):HasBuffs(A.StarlordBuff.ID, true) >= 5) or not 
		    A.Starlord:IsSpellLearned() and (Unit("player"):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) < 8 or (Unit("player"):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or 
		    A.Incarnation:IsSpellLearned() and Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) > 0))) and (A.GetToggle(2, "AoE") and MultiUnits:GetActiveEnemies() < VarSfTargets or not A.GetToggle(2, "AoE")) and 
		    Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) + Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 4 and 
		    Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 3 and Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) < 3 and (VarAzSs == 0 or 
		    (Unit("player"):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) == 0) or 
		    A.LastPlayerCastID ~= A.Starsurge.ID) or Unit(unit):TimeToDie() <= A.Starsurge:GetSpellCastTime() * FutureAstralPower() / 40 or not AP_Check(A.SolarWrath)) 
			then
			    return A.Starsurge:Show(icon)
		    end			
							
			-- Pandemic
			if true then
                if Pandemic(unit) then 
				    return true
				end
			end
			
            -- potion,if=buff.celestial_alignment.remains>13|buff.incarnation.remains>16.5
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 13 or Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) > 16.5) then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- berserking,if=buff.ca_inc.up
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(CaIncID, true)) then
                return A.Berserking:Show(icon)
            end
			
            -- use_item,name=azsharas_font_of_power,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.AzsharasFontofPower:IsReady(unit) then
                if (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) then
    				if (Unit("player"):HasBuffs(CaIncID, true) == 0) then
                        return A.AzsharasFontofPower:Show(icon) 
					end
                end
            end
			
            -- guardian_of_azeroth,if=(!talent.starlord.enabled|buff.starlord.up)&!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                if (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) then
				    if ((not A.Starlord:IsSpellLearned() or Unit("player"):HasBuffs(A.StarlordBuff.ID, true)) and Unit("player"):HasBuffs(CaIncID, true) == 0) then
                        return A.GuardianofAzeroth:Show(icon) 
					end
                end
            end
			
            -- use_item,effect_name=cyclotronic_blast,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.CyclotronicBlast:IsReady(unit) then
                if (Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) and Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true))) then
				    if (Unit("player"):HasBuffs(CaIncID, true) == 0) then
                        return A.CyclotronicBlast:Show(icon) 
					end
                end
            end
			
            -- use_item,name=shiver_venom_relic,if=!buff.ca_inc.up&!buff.bloodlust.up,target_if=dot.shiver_venom.stack>=5
            if A.ShiverVenomRelic:IsReady(unit) and A.ShiverVenomRelic:AbsentImun(unit, Temp.TotalAndMag) then
                if (Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5 
				or Unit(unit):TimeToDie() <= 5 and MultiUnits:GetActiveEnemies() >= 3 and Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 3) 
				and Unit("player"):HasBuffs(CaIncID, true) == 0 then
                    return A.ShiverVenomRelic:Show(icon) 
                end
            end
				
	 		-- Non SIMC Custom Trinket1
	        if Action.GetToggle(1, "Trinkets")[1] and A.Trinket1:IsReady(unit) and Trinket1IsAllowed then	    
       	        if A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	        return A.Trinket1:Show(icon)
   	            end 		
	        end	
			
		    -- Non SIMC Custom Trinket2
	        if Action.GetToggle(1, "Trinkets")[2] and A.Trinket2:IsReady(unit) and Trinket2IsAllowed then	    
       	        if A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
      	   	        return A.Trinket2:Show(icon)
   	            end 	
	        end	
			
            -- blood_of_the_enemy,if=cooldown.ca_inc.remains>30
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (CaInc:GetCooldown() > 30) then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- memory_of_lucid_dreams,if=!buff.ca_inc.up&(astral_power<25|cooldown.ca_inc.remains>30),target_if=dot.sunfire.remains>10&dot.moonfire.remains>10&(!talent.stellar_flare.enabled|dot.stellar_flare.remains>10)
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
			    if Unit(unit):HasDeBuffs(A.SunfireDebuff.ID, true) > 10 then
			        if (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true) > 10) and (Unit("player"):HasBuffs(CaIncID, true) == 0 and (FutureAstralPower() < 25 or CaInc:GetCooldown() > 30)) then
                        return A.MemoryofLucidDreams:Show(icon) 
					end
                end
            end
			
            -- purifying_blast
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
			
            -- concentrated_flame
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
			    if Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 0 then
				    if (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true) > 0) and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
                        return A.TheUnboundForce:Show(icon) 
					end
                end
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- focused_azerite_beam,if=(!variable.az_ss|!buff.ca_inc.up),target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
			    if Unit(unit):HasDeBuffs(A.MoonfireDebuff.ID, true) > 0 then
				    if (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff.ID, true) > 0) and ((not bool(VarAzSs) or Unit("player"):HasBuffs(CaIncID, true) == 0)) then
                        return A.FocusedAzeriteBeam:Show(icon) 
					end
                end
            end
			
            -- thorns
            if A.Thorns:IsReady(unit) then
                return A.Thorns:Show(icon)
            end
			
            -- warrior_of_elune
            if A.WarriorofElune:IsReady(unit) then
                return A.WarriorofElune:Show(icon)
            end
			
			-- fury_of_elune
		    if A.FuryofElune:IsReady(unitID) and AP_Check(A.SolarWrath) and (A.GetToggle(2, "AoE") and MultiUnits:GetActiveEnemies() >= 2 or Unit(unitID):IsBoss()) then
			    return A.FuryofElune:Show(icon)
		    end
			
            -- innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.remains<2|cooldown.celestial_alignment.remains<12)
            if A.Innervate:IsReady(unit) and (bool(A.LivelySpirit:GetAzeriteRank()) and (A.Incarnation:GetCooldown() < 2 or A.CelestialAlignment:GetCooldown() < 12)) then
                return A.Innervate:Show(icon)
            end
			
            -- force_of_nature,if=(variable.az_ss&!buff.ca_inc.up|!variable.az_ss&(buff.ca_inc.up|cooldown.ca_inc.remains>30))&ap_check
            if A.ForceofNature:IsReady(unit) and ((bool(VarAzSs) and Unit("player"):HasBuffs(CaIncID, true) == 0 or not bool(VarAzSs) and (Unit("player"):HasBuffs(CaIncID, true) > 0 or CaInc:GetCooldown() > 30)) 
			and AP_Check(A.ForceofNature)) 
			then
                return A.ForceofNature:Show(icon)
            end	

            -- new_moon,if=ap_check
            if A.NewMoon:IsReady(unit) and AP_Check(A.NewMoon) then
                return A.NewMoon:Show(icon)
            end
			
            -- half_moon,if=ap_check
            if A.HalfMoon:IsReady(unit) and AP_Check(A.HalfMoon) then
                return A.HalfMoon:Show(icon)
            end
			
            -- full_moon,if=ap_check
            if A.FullMoon:IsReady(unit) and AP_Check(A.FullMoon) then
                return A.FullMoon:Show(icon)
            end
			
			
            -- lunar_strike,if=buff.solar_empowerment.stack<3&(ap_check|buff.lunar_empowerment.stack=3)&((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=2&!buff.solar_empowerment.up)&(!variable.az_ss|!buff.ca_inc.up)|variable.az_ss&buff.ca_inc.up&prev.solar_wrath)
            if A.LunarStrike:IsReady(unit) and IsSchoolArcaneUP() and A.LunarStrike:AbsentImun(unit, Temp.TotalAndPhys) and 
			(
			    Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 2 
			    and (AP_Check(A.LunarStrike) or Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) == 3) and 
				(
			        (
					    Unit("player"):HasBuffs(A.WarriorofEluneBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.LunarEmpowermentBuff.ID, true) > 0 or MultiUnits:GetActiveEnemies() >= 2 
						and Unit("player"):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0
					) 
					and (not bool(VarAzSs) or Unit("player"):HasBuffs(CaIncID, true) == 0) 
					or bool(VarAzSs) and Unit("player"):HasBuffs(CaIncID, true) > 0 and A.LastPlayerCastID == A.SolarWrath.ID
				)
			) 
			then
                return A.LunarStrike:Show(icon)
            end
			
            -- solar_wrath,if=variable.az_ss<3|!buff.ca_inc.up|!prev.solar_wrath
            if A.SolarWrath:IsReady(unit) and IsSchoolNatureUP() and A.SolarWrath:AbsentImun(unit, Temp.TotalAndPhys) and 
			    (
				    VarAzSs < 3 or Unit("player"):HasBuffs(CaIncID, true) == 0 or A.LastPlayerCastID ~= A.SolarWrath.ID
				) 
			then
                return A.SolarWrath:Show(icon)
            end			
	
		    --Move
		    if A.Sunfire:IsReady(unit) and IsSchoolNatureUP() and A.Sunfire:AbsentImun(unit, Temp.TotalAndPhys) and isMoving and Player:IsStance(4) and 
		    (VarAzSs == 0 or (Unit("player"):HasBuffs(CaIncID, true) == 0) or 
		     A.LastPlayerCastID ~= A.Sunfire.ID) then
			    return A.Sunfire:Show(icon)
		    end
		
		    if A.Moonfire:IsReady(unit) and IsSchoolArcaneUP() and A.Moonfire:AbsentImun(unit, Temp.TotalAndPhys) and isMoving and Player:IsStance(4) and 
		    (VarAzSs == 0 or (Unit("player"):HasBuffs(CaIncID, true) == 0) or 
		    A.LastPlayerCastID ~= A.Moonfire.ID) then
			    return A.Moonfire:Show(icon)
		    end
        end
    end

    -- End on EnemyRotation()
	
	-- Friendly Rotation mouseover
	local function FriendlyRotation(unit)
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit) then 
            return A.ArcaneTorrent:Show(icon)
        end    
        
        -- Out of combat        
       -- if Unit("player"):CombatTime() == 0 and A.Resurrection:IsReady(unit) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolHolyUP() then 
        --    return A.Resurrection:Show(icon)
       -- end 
        
        -- Supportive
        if A.RemoveCorruption:IsReady(unit) and A.RemoveCorruption:AbsentImun(unit) and A.AuraIsValid(unit, "UseDispel", "Dispel") then 
            return A.RemoveCorruption:Show(icon)
        end 
    end
	
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Mouseover     
    if A.IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if FriendlyRotation(unit) then 
            return true 
        end             
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
		
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
	
	-- Mouseover     
    if A.IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if FriendlyRotation(unit) then 
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
            -- Root enemy moving out
            if A.EntanglingRoots:IsReady() and EnemyTeam():IsMovingOut() then 
                return A.EntanglingRoots:Show(icon)
            end 
            -- Cyclone enemy healer moving out
            if A.Cyclone:IsReady() and A.Cyclone:IsSpellLearned() and A.EnemyTeam("HEALER"):IsMovingOut() then 
                return A.Cyclone:Show(icon)
            end 
        end
    end 
end 

local function PartyRotation(unit)
    --if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
    --    return false 
    --end

    -- Purge
    if A.ArcaneTorrent:AutoRacial(unit) then 
        return A.ArcaneTorrent:Show(icon)
    end    
        
    -- Out of combat        
    -- if Unit("player"):CombatTime() == 0 and A.Resurrection:IsReady(unit) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolHolyUP() then 
    --    return A.Resurrection:Show(icon)
    -- end 
        
    -- Supportive
    if A.RemoveCorruption:IsReady(unit) and A.RemoveCorruption:AbsentImun(unit) and A.AuraIsValid(unit, "UseDispel", "Dispel") then 
        return A.RemoveCorruption:Show(icon)
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

