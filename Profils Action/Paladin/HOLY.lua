-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local TMW                                       = TMW 
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
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print
local wipe                                      = wipe 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local TMW                                       = TMW
local _G, setmetatable                          = _G, setmetatable
local select, unpack, table, pairs              = select, unpack, table, pairs 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower


--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_PALADIN_HOLY] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Spells
    Cleanse                                = Create({ Type = "Spell", ID = 4987 }),
    Judgement                              = Create({ Type = "Spell", ID = 275773 }),
    CrusaderStrike                         = Create({ Type = "Spell", ID = 35395 }),
    Consecration                           = Create({ Type = "Spell", ID = 26573 }),
    LightoftheMartyr                       = Create({ Type = "Spell", ID = 183998 }),
    LightoftheMartyrStack                  = Create({ Type = "Spell", ID = 223316 }),
    FlashofLight                           = Create({ Type = "Spell", ID = 19750 }),
    HolyShock                              = Create({ Type = "Spell", ID = 20473 }),
    InfusionofLight                        = Create({ Type = "Spell", ID = 54149 }),
    BeaconofLight                          = Create({ Type = "Spell", ID = 53563 }),
    BeaconofVirtue                         = Create({ Type = "Spell", ID = 200025 }),
    LightofDawn                            = Create({ Type = "Spell", ID = 85222 }),
	AuraMastery                            = Create({ Type = "Spell", ID = 31821 }),
	AvengingWrath                          = Create({ Type = "Spell", ID = 31884 }),
	HolyAvenger                            = Create({ Type = "Spell", ID = 105809 }),
	BestowFaith                            = Create({ Type = "Spell", ID = 223306 }),
	AvengingCrusader                       = Create({ Type = "Spell", ID = 216331 }),
	JudgmentOfLightHoly                    = Create({ Type = "Spell", ID = 183778 }),
	BlessingOfSacrifice                    = Create({ Type = "Spell", ID = 6940 }),
	BeaconOfFaith                          = Create({ Type = "Spell", ID = 156910 }),
	JudgementofLight                       = Create({ Type = "Spell", ID = 183778 }),
	CrusadersMight                         = Create({ Type = "Spell", ID = 196926 }),
	ConsecrationUp                         = Create({ Type = "Spell", ID = 204242 }),
	JudgmentUp                             = Create({ Type = "Spell", ID = 214222 }),
	HolyPrism                              = Create({ Type = "Spell", ID = 114165 }),
	LightsHammer                           = Create({ Type = "Spell", ID = 114158 }),
	-- Utilities
    Cavalier                               = Create({ Type = "Spell", ID = 190784     }),
	JusticarsVengeance                     = Create({ Type = "Spell", ID = 215661    }),
    BlessingofProtectionYellow             = Create({ Type = "Spell", ID = 1022, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    BlessingofProtection                   = Create({ Type = "Spell", ID = 1022     }), 
    WordofGlory                            = Create({ Type = "Spell", ID = 210191     }),
    BlessingofFreedom                      = Create({ Type = "Spell", ID = 1044     }),
    BlessingofFreedomYellow                = Create({ Type = "Spell", ID = 1044, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),	
    HammerofJustice                        = Create({ Type = "Spell", ID = 853     }),
	HammerofJusticeGreen                   = Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
	DivineShield                           = Create({ Type = "Spell", ID = 642     }),
	FlashofLight                           = Create({ Type = "Spell", ID = 19750   }),
    CleanseToxins                          = Create({ Type = "Spell", ID = 213644   }),
	Rebuke                                 = Create({ Type = "Spell", ID = 96231     }),
    -- Azerite
    DivineRevelations                      = Create({ Type = "Spell", ID = 275469 }),
	GlimmerofLight                         = Create({ Type = "Spell", ID = 287268 }),
    -- Healing
    HolyLight                              = Create({ Type = "Spell", ID = 82326 }),
    LayOnHands                             = Create({ Type = "Spell", ID = 633 }),
    Forbearance                            = Create({ Type = "Spell", ID = 25771 }),
    DivineProtection                       = Create({ Type = "Spell", ID = 498 }),
	GlimmerofLightBuff                     = Create({ Type = "Spell", ID = 287280, Hidden = true     }),
    -- Raid
	DarkestDepths                          = Create({ Type = "Spell", ID = 292127, Hidden = true     }), -- Eternal Palace debuff heal
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Create({ Type = "Spell", ID = 296320, Hidden = true     }),
    VisionofPerfectionMinor2               = Create({ Type = "Spell", ID = 299367, Hidden = true     }),
    VisionofPerfectionMinor3               = Create({ Type = "Spell", ID = 299369, Hidden = true     }),
    UnleashHeartOfAzeroth                  = Create({ Type = "Spell", ID = 280431, Hidden = true     }),
    RecklessForceBuff                      = Create({ Type = "Spell", ID = 302932, Hidden = true     }),	
    PoolResource                           = Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    DummyTest                              = Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon	
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PALADIN_HOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_HOLY], { __index = Action })

-- Get Lowest Tank
local function GetLowestTank(option)
    -- Get Current Tanks Table
    local CurrentTanks = A.HealingEngine.GetMembersByMode("TANK")
   
    -- Protect against nil values
    if #CurrentTanks == 0 then
        if option == "GUID" then
            return "NoGuid"
        end

        if option == 'HP' then
            return 1000
        end
        
		if option == 'AHP' then
            return 1000
        end
		
        if option == 'UnitID' then
            return "NoUnit"
        end
    end

    -- GUID
    if option == "GUID" then
        return CurrentTanks[1].GUID or "NoGuid"
    end
	
    -- HP
    if option == 'HP' then
        return CurrentTanks[1].HP or 1000
    end
	
    -- AHP
    if option == 'AHP' then
        return CurrentTanks[1].AHP or 1000
    end
	
    -- UnitID
    if option == 'UnitID' then
        return CurrentTanks[1].Unit or "NoUnit"
    end
end

-- Get Lowest Healer
local function GetLowestHealer(option)
    -- Get Current Healers Table
    local CurrentHealers = A.HealingEngine.GetMembersByMode("HEALER")

    -- Protect against nil values
    if #CurrentHealers == 0 then
        if option == "GUID" then
            return "NoGuid"
        end

        if option == 'HP' then
            return 1000
        end
        
		if option == 'AHP' then
            return 1000
        end
		
        if option == 'UnitID' then
            return "NoUnit"
        end
    end

    -- GUID
    if option == "GUID" then
        return CurrentHealers[1].GUID or "NoGuid"
    end
	
    -- HP
    if option == 'HP' then
        return CurrentHealers[1].HP or 1000
    end
	
    -- AHP
    if option == 'AHP' then
        return CurrentHealers[1].AHP or 1000
    end
	
    -- UnitID
    if option == 'UnitID' then
        return CurrentHealers[1].Unit or "NoUnit"
    end
end

-- Get Lowest DPS
local function GetLowestDamager(option)
    -- Get Current Damagers Table
    local CurrentDamagers = A.HealingEngine.GetMembersByMode("DAMAGER")
    --Unit = member, GUID = memberGUID, HP = memberhp, AHP = memberahp, isPlayer = true, incDMG = Actual_DMG
   
    -- Protect against nil values
    if #CurrentDamagers == 0 then
        if option == "GUID" then
            return "NoGuid"
        end

        if option == 'HP' then
            return 1000
        end
        
		if option == 'AHP' then
            return 1000
        end
		
        if option == 'UnitID' then
            return "NoUnit"
        end
    end

    -- GUID
    if option == "GUID" then
        return CurrentDamagers[1].GUID or "NoGuid"
    end
	
    -- HP
    if option == 'HP' then
        return CurrentDamagers[1].HP or 1000
    end
	
    -- AHP
    if option == 'AHP' then
        return CurrentDamagers[1].AHP or 1000
    end
	
    -- UnitID
    if option == 'UnitID' then
        return CurrentDamagers[1].Unit or "NoUnit"
    end
end

-- Get Lowest ALL
local function GetLowestALL(option)
    -- Get Current Members Table
    local CurrentMembers = A.HealingEngine.GetMembersAll()
    --Unit = member, GUID = memberGUID, HP = memberhp, AHP = memberahp, isPlayer = true, incDMG = Actual_DMG
   
    -- Protect against nil values
    if #CurrentMembers == 0 then
        if option == "GUID" then
            return "NoGuid"
        end

        if option == 'HP' then
            return 1000
        end
        
		if option == 'AHP' then
            return 1000
        end
		
        if option == 'UnitID' then
            return "NoUnit"
        end
    end

    -- GUID
    if option == "GUID" then
        return CurrentMembers[1].GUID or "NoGuid"
    end
	
    -- HP
    if option == 'HP' then
        return CurrentMembers[1].HP or 1000
    end
	
    -- AHP
    if option == 'AHP' then
        return CurrentMembers[1].AHP or 1000
    end
	
    -- UnitID
    if option == 'UnitID' then
        return CurrentMembers[1].Unit or "NoUnit"
    end
end

-- Get Lowest Ally depending on parameters 
-- @parameters target and option are mandatory
-- @target can be "TANK", "DAMAGER", "HEALER" or "ALL"
-- @option can be "GUID", "HP", "AHP" or "UnitID"
-- return the current lowest member depending of choosen option

local function GetLowestAlly(target, option)
    if target == "TANK" then
        return GetLowestTank(option)
    end

    if target == "DAMAGER" then
        return GetLowestDamager(option)
    end

    if target == "HEALER" then
        return GetLowestHealer(option)
    end

    if target == "ALL" then
        return GetLowestALL(option)
    end
end

healingTarget = "None"
healingTargetGUID = "None"

-- Custom targetting function
-- @Parameter: TARGET is mandatory
-- @usage: Arguments can be "TANK", "HEALER", "DAMAGER", "ALL"
-- Return current LowestAlly based on arguments, example: current lowest tank
local function ForceHealingTarget(TARGET)
    --local target = TARGET or nil
	local CurrentHealers = A.HealingEngine.GetMembersByMode("HEALER")
	local CurrentDamagers = A.HealingEngine.GetMembersByMode("DAMAGER")
	local CurrentTanks = A.HealingEngine.GetMembersByMode("TANK")
	local CurrentMembers = A.HealingEngine.GetMembersAll()
    healingTarget = "None"
    healingTargetGUID = "None"
    HealingEngine.SetTarget(healingTarget)

    if TARGET == "TANK" then
        healingTarget = CurrentTanks[1].Unit
        healingTargetGUID = CurrentTanks[1].GUID
        HealingEngine.SetTarget(healingTarget)
        return
    end

    if TARGET == "DPS" and CurrentDamagers[1].HP < hp then
        healingTarget = CurrentDamagers[1].Unit
        healingTargetGUID = CurrentDamagers[1].GUID
        HealingEngine.SetTarget(healingTarget)
        return
    end

    if TARGET == "HEAL" and CurrentHealers[1].HP < hp then
        healingTarget = CurrentHealers[1].Unit
        healingTargetGUID = CurrentHealers[1].GUID
        HealingEngine.SetTarget(healingTarget)
        return
    end

    if TARGET == "ALL" and CurrentMembers[1].HP < 99 then
        healingTarget = CurrentMembers[1].Unit
        healingTargetGUID = CurrentMembers[1].GUID
        HealingEngine.SetTarget(healingTarget)
        return
    end
end

-- APL Main
function ShouldDispell()
    -- Do not dispel these spells
    local blacklist = {
        33786,
        131736,
        30108,
        124465,
        34914
    }

    local dispelTypes = {
        "Poison",
        "Disease",
        "Magic"
    }
    for i = 1, 40 do
        for x = 1, #dispelTypes do
            if select(5, UnitDebuff("mouseover", i)) == dispelTypes[x] then
                for i = 1, #blacklist do
                    if UnitDebuff("mouseover", blacklist[i]) then
                        return false
                    end
                end
                return true
            end
        end
    end
    return false
end

local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local player = "player"

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.Judgement:IsInRange(unit)
end 

-- @return boolean  
-- @parameters count, range are mandatory, others parameters optionals
local ActiveUnitPlates = MultiUnits:GetActiveUnitPlates()
local function GetByRange(count, range, isCheckEqual, isCheckCombat)
	local c = 0 
	for unit in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
			if InMelee(unit) then 
				c = c + 1
			elseif range then 
				local r = Unit(unit):GetRange()
				if r > 0 and r <= range then 
					c = c + 1
				end 
			end 
			
			if c >= count then 
				return true 
			end 
		end 
	end
end  

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 10 and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.HammerofJusticeGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.HammerofJusticeGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 10)) or 
                (not A.IsInPvP and GetByRange(1, 10))
            )
        )
    )
    then 
        return A.HammerofJusticeGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.Rebuke:IsReady(unit, nil, nil, true) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.Rebuke:Show(icon)                                                  
            end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

-----------------------------------------
--        ROTATION FUNCTIONS           --
-----------------------------------------

-- Return number
-- Consecration duration left
local function Consecration()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 135926 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end

-- Return boolean
-- Current HPS > Incoming damage
local function IsEnoughHPS(unit)
    return Unit(player):GetHPS() > Unit(unit):GetDMG()
end 

-- Return boolean
-- Current Group HPS > Incoming damage
local function IsGroupEnoughHPS()
    return ((HealingEngine.GetIncomingHPSAVG() > HealingEngine.GetIncomingDMGAVG()) or (not IsInRaid() and not IsInGroup()))
end

-- Return boolean
-- Current Group is taking massive damage that need burst
local function NeedEmergencyHPS()
    return ( HealingEngine.GetIncomingHPSAVG() * 2 < HealingEngine.GetIncomingDMGAVG() )
end

-- Return boolean
-- Current Group is taking ultra massive damage that need burst
local function NeedUltraEmergencyHPS()
    return ( HealingEngine.GetIncomingHPSAVG() * 3 < HealingEngine.GetIncomingDMGAVG() )
end

-- Mana Management
local function IsSaveManaPhase()
    if not A.IsInPvP and A.GetToggle(2, "ManaManagement") and Unit(player):HasBuffs(A.Innervate.ID) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit(player):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit(player):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Rebuke:IsReady(unit) and A.Rebuke:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, MinInterrupt, MaxInterrupt) then 
	    -- Notification					
        Action.SendNotification("Rebuke interrupting on Target ", A.Rebuke.ID)
        return A.Rebuke
    end 
    
    if useCC and A.HammerofJustice:IsReady(unit) and A.HammerofJustice:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	    -- Notification					
        Action.SendNotification("HammerofJustice interrupting...", A.HammerofJustice.ID)
        return A.HammerofJustice              
    end          
	    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

-- [3] Single Rotation
A[3] = function(icon, isMulti)

    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
	local DBM = GetToggle(1 ,"DBM")
	local Potion = GetToggle(1, "Potion")
	local Racial = GetToggle(1, "Racial")
	local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")	
	local Emergency = NeedEmergencyHPS()
	local SuperEmergency = NeedUltraEmergencyHPS()	
	-- ProfileUI vars
	local DivineShieldHP = GetToggle(2, "DivineShieldHP")
	local DivineShieldTTD = GetToggle(2, "DivineShieldTTD")
	local LayOnHandsHP = GetToggle(2, "LayOnHandsHP")
	local LayOnHandsTTD = GetToggle(2, "LayOnHandsTTD")
	local HolyShockHP = GetToggle(2, "HolyShockHP")
	local HolyShockTTD = GetToggle(2, "HolyShockTTD")
	local LightofDawnHP = GetToggle(2, "LightofDawnHP")
	local LightofDawnTTD = GetToggle(2, "LightofDawnTTD")	
	local LightofDawnUnits = GetToggle(2, "LightofDawnUnits")
	local FlashofLightHP = GetToggle(2, "FlashofLightHP")
	local FlashofLightTTD = GetToggle(2, "FlashofLightTTD")
	local HolyLightHP = GetToggle(2, "HolyLightHP")
	local HolyLightTTD = GetToggle(2, "HolyLightTTD")
	local LightoftheMartyrHP = GetToggle(2, "LightoftheMartyrHP")
	local LightoftheMartyrTTD = GetToggle(2, "LightoftheMartyrTTD")
	local LightsHammerHP = GetToggle(2, "LightsHammerHP")
	local LightsHammerTTD = GetToggle(2, "LightsHammerTTD")
	local HolyPrismHP = GetToggle(2, "HolyPrismHP")
	local HolyPrismTTD = GetToggle(2, "HolyPrismTTD")	
	local BeaconofVirtueHP = GetToggle(2, "BeaconofVirtueHP")
	local BeaconofVirtueTTD = GetToggle(2, "BeaconofVirtueTTD")	
	local BeaconWorkMode = GetToggle(2, "BeaconWorkMode")	
	
	
    --------------------
    --- DPS ROTATION ---
    --------------------
    local function DamageRotation(unit)
	
        -- Out of Combat
        LeftCtrl = IsLeftControlKeyDown();
        LeftShift = IsLeftShiftKeyDown();
        LeftAlt = IsLeftAltKeyDown();
        
		-- Interrupts
        local Interrupt = Interrupts(unit)
        if inCombat and Interrupt then 
            return Interrupt:Show(icon)
        end 
        
		-- Judgement
		if A.Judgement:IsReady(unit) and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 then
			return A.Judgement:Show(icon)
		end
		
		-- HolyShock
		if A.HolyShock:IsReady(unit) and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 then
			return A.HolyShock:Show(icon)
		end
		
		-- CrusaderStrike
		if A.CrusaderStrike:IsReady(unit) and InMelee(unit) and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 then
			return A.CrusaderStrike:Show(icon)
		end
		
		-- Consecration
		if A.Consecration:IsReady(player) and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 and Consecration() <= 3 then
			return A.Consecration:Show(icon)
		end
		
		-- Judgement
		if A.Judgement:IsReady(unit) and InMelee(unit) and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) > 0 then
			return A.Judgement:Show(icon)
		end
		
		-- CrusaderStrike
		if A.CrusaderStrike:IsReady(unit) and InMelee(unit) and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) > 0 then
			return A.CrusaderStrike:Show(icon)
		end

        -- Bursting 
        if A.BurstIsON(unit) and InMelee(unit) then 
            
            if Unit(unit):HealthPercent() <= A.GetToggle(2, "RacialBurstDamaging") then 
                if A.BloodFury:AutoRacial(unit, nil, nil, true) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit, nil, nil, true) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit, nil, nil, true) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit, nil, nil, true) then 
                    return A.Berserking:Show(icon)
                end 
            end 
        end
        
        -- Trinkets DPS
        if inRange and Unit(unit):HealthPercent() <= A.GetToggle(2, "TrinketBurstDamaging") then 
            if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end     
        end  
    end
    DamageRotation = Action.MakeFunctionCachedDynamic(DamageRotation)
	
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingRotation(unit)
	    -- Current Tanks table
	    local CurrentTanks = HealingEngine.GetMembersByMode("TANK")
		
		-- DivineShield Save yourself
		if A.DivineShield:IsReady(unit) and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and
        (
		    Unit(player):HealthPercent() <= DivineShieldHP 
			or 
			Unit(player):TimeToDie() < DivineShieldTTD 
        )			
		then
			return A.DivineShield:Show(icon)
		end	

        -- Tank Emergency
        if A.LayOnHands:IsReady(unit) and Unit(unit):HasDeBuffs(A.Forbearance.ID, true) == 0 then
            if GetLowestAlly("TANK", "HP") < LayOnHandsHP then
				HealingEngine.SetTarget(unit)
				--ForceHealingTarget("TANK")
            end

            if Unit(unit):GUID() == GetLowestTank("GUID") and
            (
		        Unit(unit):HealthPercent() <= LayOnHandsHP 
			    or 
			    Unit(unit):TimeToDie() < LayOnHandsTTD 
            )			
			then
                return A.LayOnHands:Show(icon)
            end
        end
		
		-- Custom Beacon TANK
        if A.BeaconofLight:IsReady(unit) and BeaconWorkMode == "Tanking Units" and Unit(unit):HasBuffs(A.BeaconofLight.ID, true) == 0 then
            if GetLowestAlly("TANK", "HP") < 99 then
                HealingEngine.SetTarget(unit)
			end
			--ForceHealingTarget(BeaconWorkMode)

            if Unit(unit):GUID() == GetLowestAlly("TANK", "GUID") and Unit(unit):HealthPercent() < 99 then
                return A.BeaconofLight:Show(icon)
            end
        end
		
		-- Custom Beacon
        if A.BeaconofLight:IsReady(unit) and BeaconWorkMode == "Mostly Inc. Damage" and Unit(unit):HasBuffs(A.BeaconofLight.ID, true) == 0 then
            HealingEngine.SetTargetMostlyIncDMG(1)
            return A.BeaconofLight:Show(icon)
        end
		
		-- Custom Beacon
        if A.BeaconofLight:IsReady(unit) and BeaconWorkMode == "HPS < Inc. Damage" and Unit(unit):HasBuffs(A.BeaconofLight.ID, true) == 0 then
            if GetLowestAlly("ALL", "HP") < 99 then
                HealingEngine.SetTarget(unit)
			end
			--ForceHealingTarget(BeaconWorkMode)

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and Unit(unit):GetHPS() < Unit(unit):GetDMG() then
                return A.BeaconofLight:Show(icon)
            end
        end
		
		--Dispell
		--if not Player:CanAttack(Target) and A.Cleanse:IsReady(unit) and Target:HasDispelableDebuff("Magic", "Poison", "Disease") then
			--return A.Cleanse:Show(icon)
		--end

        --Manuel Cooldown and not Glimmer of Light
	    if A.BurstIsON(unit) and A.GlimmerofLight:GetAzeriteRank() < 3 and Emergency then
		    
			-- AvengingWrath
		    if A.AvengingWrath:IsReady(unit) and Unit(player):HasBuffs(A.AuraMastery.ID, true) == 0 and Unit(player):HasBuffs(A.HolyAvenger.ID, true) == 0 then
                return A.AvengingWrath:Show(icon)
            end
			
            -- AvengingCrusader
		    if A.AvengingCrusader:IsReady(unit) and Unit(player):HasBuffs(A.AuraMastery.ID, true) == 0 and Unit(player):HasBuffs(A.HolyAvenger.ID, true) == 0 then
                return A.AvengingCrusader:Show(icon)
            end	
			
		    -- HolyAvenger
		    if A.HolyAvenger:IsReady(unit) and Unit(player):HasBuffs(A.AuraMastery.ID, true) == 0 and Unit(player):HasBuffs(A.AvengingWrath.ID, true) == 0 and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 then
                return A.HolyAvenger:Show(icon)
            end
			
            -- AuraMastery
		    if A.AuraMastery:IsReady(unit) and Unit(player):HasBuffs(A.AvengingWrath.ID, true) == 0 and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 and Unit(player):HasBuffs(A.HolyAvenger.ID, true) == 0 then
		    	return A.AuraMastery:Show(icon)
		    end
			
		    -- LifeBindersInvocation
		    if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, true) and HealingEngine.GetBelowHealthPercentercentUnits(85, 40) >= 5 then
		    	return A.LifeBindersInvocation:Show(icon)
		    end
			
		    -- OverchargeMana
		    if A.OverchargeMana:AutoHeartOfAzeroth(unit, true) then
		    	return A.OverchargeMana:Show(icon)
		    end
	    end
		
		-- MemoryofLucidDreams if less than 85% mana left
		if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Player:Mana() < Player:ManaMax() * 0.85 then
			return A.MemoryofLucidDreams:Show(icon)
		end
		
	    --Manuel Cooldown and Glimmer of Light
	    if A.BurstIsON(unit) and A.GlimmerofLight:GetAzeriteRank() >= 3 and Emergency then
	    	
			-- AvengingWrath
			if A.AvengingWrath:IsReady(unit) and Unit(player):HasBuffs(A.AuraMastery.ID, true) == 0 and Unit(player):HasBuffs(A.HolyAvenger.ID, true) == 0 then
                return A.AvengingWrath:Show(icon)
            end
		
		    -- HolyAvenger
	    	if A.HolyAvenger:IsReady(unit) and Unit(player):HasBuffs(A.AuraMastery.ID, true) == 0 then
                return A.HolyAvenger:Show(icon)
            end

            -- AuraMastery
		    if A.AuraMastery:IsReady(unit) and Unit(player):HasBuffs(A.AvengingWrath.ID, true) == 0 and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 and Unit(player):HasBuffs(A.HolyAvenger.ID, true) == 0 then
		    	return A.AuraMastery:Show(icon)
		    end
		    
			-- LifeBindersInvocation
	    	if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, true) and HealingEngine.GetBelowHealthPercentercentUnits(85, 40) >= 5 then
		    	return A.LifeBindersInvocation:Show(icon)
		    end
		    
			-- OverchargeMana
		    if A.OverchargeMana:AutoHeartOfAzeroth(unit, true) then
		    	return A.OverchargeMana:Show(icon)
		    end
	    end
		
		-- MemoryofLucidDreams if less than 85% mana left
	--	if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Player:Mana() < Player:ManaMax() * 0.85 then
	--		return A.UnleashHeartofAzeroth:Show(icon)
	--	end
		
		--AuraMastery settings
        if A.AuraMastery:IsReady(unit) and A.BurstIsON(unit) and Unit(player):HasBuffs(A.AvengingWrath.ID, true) == 0 and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 and Unit(player):HasBuffs(A.HolyAvenger.ID, true) == 0 then
            if HealingEngine.GetBelowHealthPercentercentUnits(50, 40) > 3 then -- HP, Range
                return A.AuraMastery:Show(icon)
            end
        end
		
		--Use Trinkets
        --if I.RevitalizingVoodooTotem:IsReady(unit) then
            --if GetLowestAlly("TANK", "HP") < 75 then
                --ForceHealingTarget("TANK")
            --end
            --if Unit(unit):GUID() == GetLowestAlly("TANK", "GUID") and Unit(unit):HealthPercent() < 75 then
                --return A.GiftoftheNaaru:Show(icon)
            --end
        --end

        -- Beacon of Virtue
        if A.BeaconofVirtue:IsReady(unit) and HealingEngine.GetBelowHealthPercentercentUnits(BeaconofVirtueHP, 40) >= BeaconofVirtueUnits then
			return A.BeaconofVirtue:Show(icon)
		end

        -- Light of Dawn
        if A.LightofDawn:IsReady(unit) and HealingEngine.GetBelowHealthPercentercentUnits(LightofDawnHP, 40) >= LightofDawnUnits then
			return A.LightofDawn:Show(icon)
        end

		-- Holy Shock
        if A.HolyShock:IsReady(unit) then
            if GetLowestAlly("ALL", "HP") <= HolyShockHP then
                HealingEngine.SetTarget(unit)
				--ForceHealingTarget("ALL")
            end

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and Unit(unit):HasDeBuffs(A.GlimmerofLightBuff.ID, true) == 0 and
            (
		        Unit(unit):HealthPercent() <= HolyShockHP 
			    or 
			    Unit(unit):TimeToDie() < HolyShockTTD 
            )			
			then
                return A.HolyShock:Show(icon)
            end
        end

        -- Judgment Of Light
        if (isMulti or A.GetToggle(2, "AoE")) and A.Judgement:IsReady(unit) and A.JudgementofLight:IsSpellLearned() and inCombat then
            return A.Judgement:Show(icon)
        end
		
		-- LightsHammer
		if (isMulti or A.GetToggle(2, "AoE")) and A.LightsHammer:IsReady(unit) and HealingEngine.GetBelowHealthPercentercentUnits(75, 40) >= 5 then
			return A.LightsHammer:Show(icon)
		end
		
		-- Holy Prism
		if (isMulti or A.GetToggle(2, "AoE")) and A.HolyPrism:IsReady(unit) and HealingEngine.GetBelowHealthPercentercentUnits(75, 40) >= 3 then
			return A.HolyPrism:Show(icon)
		end
		
        --Bestow Faith
        if A.BestowFaith:IsSpellLearned() and A.BestowFaith:IsReady(unit) then
            if GetLowestAlly("TANK", "HP") <= 95 then
                HealingEngine.SetTarget(unit)
				--ForceHealingTarget("TANK")
            end
            if Unit(unit):GUID() == GetLowestAlly("TANK", "GUID") and Unit(unit):HealthPercent() <= 95 then
                return A.BestowFaith:Show(icon)
            end
        end
		
		-- Concentrated Flame Heal
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) then
            if GetLowestAlly("ALL", "HP") <= 75 then
                HealingEngine.SetTarget(unit)
				--ForceHealingTarget("ALL")
            end

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and Unit(unit):HealthPercent() <= 75 then
                return A.ConcentratedFlame:Show(icon)
            end
        end
		
		-- Vitality Conduit
        if A.VitalityConduit:AutoHeartOfAzeroth(unit, true) then
            if GetLowestAlly("TANK", "HP") <= 75 then
			    HealingEngine.SetTarget(unit)
                --ForceHealingTarget("TANK")
            end

            if Unit(unit):GUID() == GetLowestAlly("TANK", "GUID") and Unit(unit):HealthPercent() <= 75 then
                return A.VitalityConduit:Show(icon)
            end
        end
		
        -- Flash of Light
        if A.FlashofLight:IsReady(unit) and not isMoving then
            if GetLowestAlly("ALL", "HP") <= FlashofLightHP then
                HealingEngine.SetTarget(unit)
            end

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and
            (
		        Unit(unit):HealthPercent() <= FlashofLightHP 
			    or 
			    Unit(unit):TimeToDie() < FlashofLightTTD 
            )			
			then
                return A.FlashofLight:Show(icon)
            end
        end

        -- Crusader Strike
        if (isMulti or A.GetToggle(2, "AoE")) and A.CrusaderStrike:IsReady(unit) and A.CrusadersMight:IsSpellLearned() and not A.HolyShock:IsReady(unit) and A.IsUnitEnemy(unit) and unit ~= "mouseover" then
            return A.CrusaderStrike:Show(icon)
        end

        --Holy Light
        if A.HolyLight:IsReady(unit) and not isMoving then
            if GetLowestAlly("ALL", "HP") <= HolyLightHP then
                HealingEngine.SetTarget(unit)
            end

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and
            (
		        Unit(unit):HealthPercent() <= HolyLightHP 
			    or 
			    Unit(unit):TimeToDie() < HolyLightTTD 
            )			
			then
                return A.HolyLight:Show(icon)
            end
        end
		
        --Light of the Martyr
        if A.LightoftheMartyr:IsReady(unit) and isMoving and Unit(player):HealthPercent() > 75 then
            if GetLowestAlly("ALL", "HP") <= LightoftheMartyrHP then
                HealingEngine.SetTarget(unit)
            end

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and
            (
		        Unit(unit):HealthPercent() <= LightoftheMartyrHP 
			    or 
			    Unit(unit):TimeToDie() < LightoftheMartyrTTD 
            )			
			then
                return A.LightoftheMartyr:Show(icon)
            end
        end

    end	
    HealingRotation = Action.MakeFunctionCachedDynamic(HealingRotation)
	
    -- DPS Mouseover 
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"	
		
        if DamageRotation(unit) then 
            return true 
        end 
    end 
	
	-- Heal Mouseover
    if A.IsUnitFriendly("mouseover") then 
        unit = "mouseover"  
		
        if HealingRotation(unit) then 
            return true 
        end             
    end  
	
    -- DPS Target     
    if A.IsUnitEnemy("target") then 
        unit = "target"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
	
    -- Heal Target 
    if A.IsUnitFriendly("target") then 
        unit = "target" 
		
        if HealingRotation(unit) then 
            return true 
        end 
    end 
	
    -- DPS targettarget     
    if A.IsUnitEnemy("targettarget") then 
        unit = "targettarget"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
        
end 

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
    Unit(player):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end ]]--

local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.HammerofJustice:IsReady() and A.HammerofJustice:IsSpellLearned() and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.HammerofJustice
            end 
        end
    end 
end 

local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

   	--Dispell
 --	if A.CleanseToxins:IsReady(unit) and Action.AuraIsValid(unit, "UseDispel", "Magic") --("Poison", "Disease") 
--	then
--	    return A.CleanseToxins
--	end

  	-- BlessingofFreedom
    if A.BlessingofFreedom:IsReady(unit) and Unit(unit):HasDeBuffs("Rooted") > 0 and not Unit(unit):InLOS() then
        return A.BlessingofFreedom
    end
	
  	-- BlessingofProtection
    if A.BlessingofProtection:IsReady(unit) and not Unit(unit):InLOS() and 	 
	(
	   -- HP lose per sec >= 20
        Unit(unit):GetDMG() * 100 / Unit(unit):HealthMax() >= 30 
		or 
        Unit(unit):GetRealTimeDMG() >= Unit(unit):HealthMax() * 0.30 
		or 
        -- TTD 
        Unit(unit):TimeToDieX(10) < 3 
	)
	then
        return A.BlessingofProtection
    end
	
end 

A[6] = function(icon)
    -- StopCast if destination is known as unitID 
    if Temp.LastPrimaryUnitID and CanStopCastingOverHeal() then 
        return A:Show(icon, ACTION_CONST_STOPCAST)
    end
	
    local Arena = ArenaRotation("arena1")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    
    local Arena = ArenaRotation("arena2")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    local Arena = ArenaRotation("arena3")
    if Arena then 
        return Arena:Show(icon)
    end 
end