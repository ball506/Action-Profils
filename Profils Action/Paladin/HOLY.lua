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
local IsSpellInRange                            = A.IsSpellInRange
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
	BlessingofSacrifice                    = Create({ Type = "Spell", ID = 6940 }),
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
	-- PvP
	UltimateSacrifice                      = Create({ Type = "Spell", ID = 199452 }),
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
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
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
    local MinInterrupt = A.GetToggle(2, "MinInterrupt")
	local MaxInterrupt = A.GetToggle(2, "MaxInterrupt")
	
    if useKick and A.Rebuke:IsReady(unit) and A.Rebuke:AbsentImun(unit, Temp.TotalAndPhysKick, true) and Unit(unit):CanInterrupt(true, nil, MinInterrupt, MaxInterrupt) then 
	    -- Notification					
        Action.SendNotification("Rebuke interrupting on Target ", A.Rebuke.ID)
        return A.Rebuke
    end 
    
    if useCC and A.HammerofJustice:IsReady(unit) and A.HammerofJustice:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
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

-- Return total active GlimmerofLight Buff for player only
local function GlimmerofLightBuffCount()
    return HealingEngine.GetBuffsCount(A.GlimmerofLightBuff.ID, 2, player, true)
end

-- Return total active Beacon of Light Buff for player only
local function ActiveBeacon()
    return HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 2, player, true)
end

-- Return valid members that can be healed
--@parameter IsPlayer : return only members that are real players
local function GetValidMembers(IsPlayer)
    local HealingEngineMembersALL = A.HealingEngine.GetMembersAll()
	if not IsPlayer then 
		return #HealingEngineMembersALL
	else 
		local total = 0 
		if #HealingEngineMembersALL > 0 then 
			for i = 1, #HealingEngineMembersALL do
				if Unit(HealingEngineMembersALL[i].Unit):IsPlayer() then
					total = total + 1
				end
			end 
		end 
		return total 
	end 
end

local function SacrificeAble(unit)
    -- Function to check if we can use sacriface with max profit time duration on unit
    local dmg, u_ttd, bubble, shield = Unit(unit):GetDMG() * 0.7, Unit(unit):TimeToDie() * 0.7, Unit(player):HasBuffs(642, true), 1
    -- -20% incoming damage
    local shield_buff = Unit(player):HasBuffs(498, true)
    if shield_buff > 0 then 
        shield = dmg * ( 0.2 - (0.2 - (shield_buff * 0.2 / 8)) )
    end
    
    local p_ttd, p_chp = 0, UnitHealth("player")
    if not A.UltimateSacrifice:IsSpellLearned() or not A.IsInPvP then
        -- Real player's ttd to lower 20% under sacriface and shield buff
        local p_mhp = UnitHealthMax("player") * 0.2
        if p_chp > p_mhp and dmg > 0 and u_ttd > 0 then 
            local muliplier = 0.75
            -- If Protection then 100% receiving damage by Sacriface
            if Unit(player):HasSpec(66) then 
                muliplier = 1
            end     
            p_ttd = math.abs(        
                -- Current HP without 20% / incdmg by Sacriface + already exist incdmg for yourself
                (p_chp - p_mhp) /
                (( dmg * muliplier * (1 - (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)/2/100)) ) + Unit(player):GetDMG() )
            )     
        end
    else
        p_ttd = math.abs(        
            -- Current HP / incdmg by Sacriface + already exist incdmg for yourself
            p_chp /
            (( dmg * (1 - (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)/2/100)) ) + Unit(player):GetDMG() )
        )    
    end 
    
    if bubble > 0 then 
        p_ttd = p_ttd + bubble
    end
    
    return p_ttd + GetCurrentGCD() >= u_ttd, p_ttd
end

-- Hand of Sacrifice
local function HoS(unit, Icon, hp, IsRealDMG, IsDeffensed)  
    return 
    UnitExists(unit) and 
    UnitIsPlayer(unit) and
    not UnitIsUnit(unit, "player") and
    not Unit(unit):InLOS() and 
    (UnitInRaid(unit) or UnitInParty(unit)) and
    --Env.SpellUsable(6940) and 
	A.BlessingofSacrifice:IsReady(unit) and
    IsSpellInRange(6940, unit) and 
    Unit(unit):HasDeBuffs(33786, true) == 0 and -- Cyclone 
    UnitHealth("player") > UnitHealthMax("player") * 0.2 and       
    (
        -- MSG System TO ACTION
        --(
        --    Icon and 
         --   MacroSpells(Icon, "HoS") 
        --) or  
        -- HoS conditions 
        (
           -- HoS_toggle and 
            SacrificeAble(unit) and 
            Unit(unit):HasBuffs(1022, true) == 0 and -- BoP
			-- Check args
            (
                not IsRealDMG or
                Unit(unit):GetRealTimeDMG() > 0
            ) and 
            ( 
                not IsDeffensed or 
                Unit(unit):HasBuffs("DeffBuffs", true) == 0
            ) and 
            -- Check if unit don't will be killed 
            (
				not Unit(player):HasSpec(65) or -- Holy
                Unit(unit):TimeToDie() >= 4 
            ) and 
            -- Conditions
            (
                -- Check for HP arg
                ( 
                    hp and 
                    UnitHealth(unit) <= UnitHealthMax(unit) * (hp / 100)
                ) or 
                -- Another check 
                (
                    Unit(unit):TimeToDie() < 14 and 
                    (
                        (
                            UnitHealth(unit) <= UnitHealthMax(unit) * 0.35 and 
                            (
                                Unit(unit):GetHEAL()  * 1.4 < Unit(unit):GetDMG() or
                                UnitHealth(unit) <= Unit(unit):GetDMG() * 3.5 
                            ) 
                        ) or 
                        -- if unit has 35% dmg per sec 
                        Unit(unit):GetRealTimeDMG() >= UnitHealthMax(unit) * 0.35 or 
                        -- if unit has sustain 20% dmg per sec 
                        Unit(unit):GetDMG() >= UnitHealthMax(unit) * 0.2
                    )
                )
            )
        )
    )
end 

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
	local GlimmerofLightBuffCount = GlimmerofLightBuffCount()
	local ActiveBeacon = ActiveBeacon()
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
	local LucidDreamManaPercent = GetToggle(2, "LucidDreamManaPercent")	
	local LifeBindersInvocationUnits = GetToggle(2, "LifeBindersInvocationUnits")	
	local LifeBindersInvocationHP = GetToggle(2, "LifeBindersInvocationHP")	
	local ForceGlimmerOnMaxUnits = GetToggle(2, "ForceGlimmerOnMaxUnits")
	local AuraMasteryAoETTD = GetToggle(2, "AuraMasteryAoETTD")
	local AuraMasteryAfter = GetToggle(2, "AuraMasteryAfter")
	local AuraMasteryBelowHealthPercent = GetToggle(2, "AuraMasteryBelowHealthPercent")
	local AuraMasteryLast = GetToggle(2, "AuraMasteryLast")
	local AuraMasteryUnits = GetToggle(2, "AuraMasteryUnits")
	
    -- Healing Engine vars
	local ReceivedLast5sec = LastIncDMG(player, 5)
	local AVG_DMG = HealingEngine.GetIncomingDMGAVG()
	local AVG_HPS = HealingEngine.GetIncomingHPSAVG()
	local TeamCacheEnemySize = TeamCache.Enemy.Size
	local TeamCacheFriendlySize = TeamCache.Friendly.Size
	local TeamCacheFriendlyType = TeamCache.Friendly.Type or "none" 

	
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
		
        -- HPvE #1 Judgment
		if A.Judgement:IsReady(unit) and A.JudgementofLight:IsSpellLearned() and
        (
            -- MouseOver
            (      
                GetToggle(2, "mouseover") and
                A.IsUnitEnemy("mouseover") and        
                SpellInRange("mouseover", 20271) and
                Unit("mouseover"):HasBuffs(33786, true) == 0 and
                Unit("mouseover"):PT(196941, "debuff") and       				
                A.Judgement:AbsentImun("mouseover", Temp.TotalAndPhys, true) 
            ) or 
            -- Target
            ( 
                (
                    not GetToggle(2, "mouseover") or
                    not A.MouseHasFrame()
                ) and       
                A.IsUnitEnemy("target") and        
                SpellInRange("target", 20271) and
                Unit("target"):HasBuffs(33786, true) == 0 and 
                Unit("target"):PT(196941, "debuff") and        
                A.Judgement:AbsentImun("target", Temp.TotalAndPhys, true) 
            ) or 
            -- TargetTarget
            ( 
                (
                    not GetToggle(2, "mouseover") or
                    not A.MouseHasFrame() or
                    not A.IsUnitEnemy("mouseover")
                ) and
                not A.IsUnitEnemy("target") and
                A.IsUnitEnemy("targettarget") and
                SpellInRange("targettarget", 20271) and
                Unit("targettarget"):HasBuffs(33786, true) == 0 and -- Cyclone
                Unit("targettarget"):PT(196941, "debuff") and        
                A.Judgement:AbsentImun("targettarget", Temp.TotalAndPhys, true)          
            ) 
        )
        then
			return A.Judgement:Show(icon)
		end
		
		-- HolyShock
		if A.HolyShock:IsReady(unit) and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 then
			return A.HolyShock:Show(icon)
		end
		
		-- Crusader Strike
		if A.CrusaderStrike:IsReady(unit) and A.CrusadersMight:IsSpellLearned() and
        -- Holy Shock
        A.HolyShock:GetCooldown() > GetCurrentGCD() and
        (
            -- MouseOver
            (      
                GetToggle(2, "mouseover") and
                A.IsUnitEnemy("mouseover") and        
                SpellInRange("mouseover", 35395) and
                Unit("mouseover"):HasBuffs(33786, true) == 0 and               
                A.CrusaderStrike:AbsentImun("mouseover", Temp.TotalAndPhys, true)
            ) or 
            -- Target
            ( 
                (
                    not GetToggle(2, "mouseover") or
                    not A.MouseHasFrame() 
                ) and        
                A.IsUnitEnemy("target") and        
                SpellInRange("target", 35395) and
                Unit("target"):HasBuffs(33786, true) == 0 and                
                A.CrusaderStrike:AbsentImun("target", Temp.TotalAndPhys, true)  
            ) or
            -- TargetTarget
            ( 
                (
                    not GetToggle(2, "mouseover") or
                    not A.MouseHasFrame() or
                    not A.IsUnitEnemy("mouseover")
                ) and
                not A.IsUnitEnemy("target") and
                A.IsUnitEnemy("targettarget") and
                SpellInRange("targettarget", 35395) and
                Unit("targettarget"):HasBuffs(33786, true) == 0 and -- Cyclone             
                A.CrusaderStrike:AbsentImun("targettarget", Temp.TotalAndPhys, true)          
            ) 
        )
		then
			return A.CrusaderStrike:Show(icon)
		end
		
		-- Consecration
		if A.Consecration:IsReady(player) and Unit(unit):GetRange() <= 6 and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) == 0 and Consecration() <= 3 then
			return A.Consecration:Show(icon)
		end
		
		-- HPvE #2 Judgment
		if A.Judgement:IsReady(unit) and InMelee(unit) and 
        (
            -- MouseOver
            (      
                GetToggle(2, "mouseover") and
                A.IsUnitEnemy("mouseover") and        
                SpellInRange("mouseover", 20271) and
                Unit("mouseover"):HasBuffs(33786, true) == 0 and
				Unit("mouseover"):HasDeBuffs(A.Judgement.ID, "player", true) <= CurrentTimeGCD() and
                A.Judgement:AbsentImun("mouseover", Temp.TotalAndPhys, true)  
            ) or 
            -- Target
            ( 
                (
                    not GetToggle(2, "mouseover") or
                    not A.MouseHasFrame() or
                    not A.IsUnitEnemy("mouseover")
                ) and        
                A.IsUnitEnemy("target") and        
                SpellInRange("target", 20271) and
                Unit("target"):HasBuffs(33786, true) == 0 and 
                Unit("target"):HasDeBuffs(A.Judgement.ID, "player", true) <= CurrentTimeGCD() and 
                A.Judgement:AbsentImun("target", Temp.TotalAndPhys, true)   
            ) or
            -- TargetTarget
            ( 
                (
                    not GetToggle(2, "mouseover") or
                    not A.MouseHasFrame() or
                    not A.IsUnitEnemy("mouseover")
                ) and
                not A.IsUnitEnemy("target") and
                A.IsUnitEnemy("targettarget") and
                SpellInRange("targettarget", 20271) and
                Unit("targettarget"):HasBuffs(33786, true) == 0 and -- Cyclone
                Unit("targettarget"):HasDeBuffs(A.Judgement.ID, "player", true) <= CurrentTimeGCD() and
                A.Judgement:AbsentImun("targettarget", Temp.TotalAndPhys, true)          
            ) 
        )		
		then
			return A.Judgement:Show(icon)
		end
		
		-- CrusaderStrike
		if A.CrusaderStrike:IsReady(unit) and Unit(unit):GetRange() <= 8 and Unit(player):HasBuffs(A.AvengingCrusader.ID, true) > 0 then
			return A.CrusaderStrike:Show(icon)
		end
 
    end
    DamageRotation = Action.MakeFunctionCachedDynamic(DamageRotation)
	
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingRotation(unit)
	    -- Current Tanks table
	    local CurrentTanks = HealingEngine.GetMembersByMode("TANK")

        -- Passive Divine Shield
        if A.DivineShield:IsReady(player) and combatTime > 0 and
        (
            not Unit(player):HasSpec(65) or -- Holy
            (
                not UnitIsUnit("target", "player") and
                (
                    not GetToggle(2, "mouseover") or
                    not A.MouseHasFrame() or
                    not UnitIsUnit("mouseover", "player")
                )        
            ) or
            (
                Unit("player"):TimeToDieX(10) < 3 and
                (
                    MultiUnits:GetByRange(10, 1) or
                    EnemyTeam("DAMAGER"):PlayersInRange(1, 10)
                ) and
                Unit("player"):GetDMG() > Unit("player"):GetHPS() 
            )
        ) and
        (
            not Unit(player):HasSpec(66) or -- Protection
            Unit(player):HasDeBuffs(31850, true) <= 0.1 -- Ardent Defender    
        ) and
        Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and -- Forbearance
        (
            (
                Unit("player"):HealthPercent() < DivineShieldHP and
                Unit("player"):TimeToDieX(20) <= GCD() * 1.5 + CurrentTimeGCD()
            ) or
            (
                A.IsInPvP and
                Unit(player):IsFocused() and
                Unit("player"):HealthPercent() < 35 and
                not Unit("player"):HasFlags() and
                (
                    Unit("player"):HealthPercent() <= 21 or
                    (                
                        Unit("player"):HasBuffs("DeffBuffs") == 0 and
                        FriendlyTeam("HEALER"):GetCC() and
                        Unit("player"):IsExecuted()
                    ) or            
                    (
                        Unit("player"):UseDeff() and
                        Unit(player):TimeToDie() <= GCD() * 3
                    )
                )
            ) 
        ) and
        (
            Unit("player"):HasBuffs("DeffBuffs") <= CurrentTimeGCD() or
            Unit("player"):HealthPercent() < 15   
        )
		then
            -- Notification					
            Action.SendNotification("Emergency " .. A.GetSpellInfo(A.DivineShield.ID), A.DivineShield.ID)
			return A.DivineShield:Show(icon)
		end	

		
		-- DivineShield Save yourself
	--[[	if A.DivineShield:IsReady(player) and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and
        (
		    Unit(player):HealthPercent() <= DivineShieldHP 
			or 
			Unit(player):TimeToDie() < DivineShieldTTD 
        )			
		then
            -- Notification					
            Action.SendNotification("Emergency " .. A.GetSpellInfo(A.DivineShield.ID), A.DivineShield.ID)
			return A.DivineShield:Show(icon)
		end	]]--

        -- Tank Emergency
        -- HPvE Lay on Hands
        if A.LayOnHands:IsReady(unit) and A.Zone ~= "arena" and not Action.InstanceInfo.isRated and combatTime > 0 and
        (
            -- MouseOver
            (
                GetToggle(2, "mouseover") and
                UnitExists("mouseover") and 
                A.MouseHasFrame() and                       
                not A.IsUnitEnemy("mouseover") and 
                Unit("mouseover"):HealthPercent() < 30 and        
                (
                    A.PredictHeal("LayonHands", "mouseover") or           
                    UnitHealth("mouseover") <= UnitHealthMax("mouseover") * 0.17
                ) and
                UnitIsPlayer("mouseover") and  
                SpellInRange("mouseover", 633) and 
                Unit("mouseover"):HasBuffs(33786, true) == 0 and
                -- Forbearance
                Unit("mouseover"):HasDeBuffs(A.Forbearance.ID, true) == 0 
            ) or 
            -- Target
            (
                (
                    not GetToggle(2, "mouseover") or 
                    not UnitExists("mouseover")
                ) and        
                not A.IsUnitEnemy("target") and
                Unit("target"):HealthPercent() < 30 and 
                (
                    A.PredictHeal("LayonHands", "target") or            
                    UnitHealth("target") <= UnitHealthMax("target") * 0.17
                ) and
                UnitIsPlayer("target") and  
                SpellInRange("target", 633) and
                Unit("target"):HasBuffs(33786, true) == 0 and
                -- Forbearance
                Unit("target"):HasDeBuffs(A.Forbearance.ID, true) == 0 
            )
        )
		then
            -- Notification					
            Action.SendNotification("Emergency " .. A.GetSpellInfo(A.LayOnHands.ID), A.LayOnHands.ID)
            return A.LayOnHands:Show(icon)
        end

    --[[    if A.LayOnHands:IsReady(unit) and Unit(unit):HasDeBuffs(A.Forbearance.ID, true) == 0 then
            if GetLowestAlly("TANK", "HP") < LayOnHandsHP then
				--HealingEngine.SetTarget(unit)
				ForceHealingTarget("TANK")
            end

            if Unit(unit):GUID() == GetLowestTank("GUID") and
            (
		        Unit(unit):HealthPercent() <= LayOnHandsHP 
			    or 
			    Unit(unit):TimeToDie() < LayOnHandsTTD 
            )			
			then
                -- Notification					
                Action.SendNotification("Emergency " .. A.GetSpellInfo(A.LayOnHands.ID), A.LayOnHands.ID)
                return A.LayOnHands:Show(icon)
            end
        end
]]--
        -- Custom Beacon TANK
		local getmembersAll = HealingEngine.GetMembersAll()
		if BeaconWorkMode == "Tanking Units" and not Unit(unit):IsTank() then
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(unit):InLOS() then 
		  	        if Unit(getmembersAll[i].Unit):IsTank() then
		                HealingEngine.SetTarget(getmembersAll[i].Unit, 1)    -- Add 1sec delay in case of emergency switch              					
                    end					
                end				
            end	
        else
		    if BeaconWorkMode == "Tanking Units" and Unit(unit):IsTank() and Unit(unit):HasBuffs(A.BeaconofLight.ID, true) == 0 and ActiveBeacon == 0
			then 
                -- Notification					
                Action.SendNotification("Placing " .. A.GetSpellInfo(A.BeaconofLight.ID) .. " on " .. UnitName(unit), A.BeaconofLight.ID)		
		        return A.BeaconofLight:Show(icon)
		    end
		end
		
		-- Custom Beacon
        if A.BeaconofLight:IsReady(unit) and BeaconWorkMode == "Mostly Inc. Damage" and Unit(unit):HasBuffs(A.BeaconofLight.ID, true) == 0 then
            HealingEngine.SetTargetMostlyIncDMG(1)
            return A.BeaconofLight:Show(icon)
        end
		
		-- Custom Beacon
        if A.BeaconofLight:IsReady(unit) and BeaconWorkMode == "HPS < Inc. Damage" then
            if GetLowestAlly("ALL", "HP") < 99 then
                --HealingEngine.SetTarget(unit)
				ForceHealingTarget("ALL")
			end
			

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and Unit(unit):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unit):GetHPS() < Unit(unit):GetDMG() then
                return A.BeaconofLight:Show(icon)
            end
        end
		
		--Dispell
		if A.Cleanse:IsReady(unit) and AuraIsValid(unit, "UseDispel", "Dispel") then
			return A.Cleanse:Show(icon)
		end

        -- HolyAvenger
		if A.HolyAvenger:IsReady(unit) and A.BurstIsON(unit) and A.HolyAvenger:IsSpellLearned() and combatTime > 8 and
        -- AW Original
        Unit("player"):HasBuffs(A.AvengingWrath.ID, "player", true) == 0 and
        (       
            -- HealingEngine conditions for burst raid/party heal
            (
                GetToggle(2, "AoE") and
                (
                    (
                        not GetToggle(2, "mouseover") or
                        not A.MouseHasFrame() or
                        not A.IsUnitEnemy("mouseover")
                    ) and
                    not A.IsUnitEnemy("target") 
                ) and
                (            
                    (
                        TeamCacheFriendlySize > 1 and 
                        (
                            AVG_DMG and
                            ReceivedLast5sec and 
                            AVG_HPS and
                            (
                                ReceivedLast5sec > AVG_DMG + AVG_HPS or
                                AVG_DMG >= AVG_HPS * 3
                            ) 
                        ) and
                        (
                            HealingEngine.GetTimeToDieUnits(15) >= GetValidMembers(true) * 0.5 or
                            HealingEngine.GetBelowHealthPercentercentUnits(60) >= GetValidMembers(true) * 0.5
                        )
                    ) or        
                    (
                        TeamCacheFriendlyType == "party" and
                        HealingEngine.GetBelowHealthPercentercentUnits(40) >= 3
                    ) or 
                    (
                        TeamCacheFriendlyType == "raid" and
                        HealingEngine.GetBelowHealthPercentercentUnits(55) >= 5              
                    )
                )
            ) or
            -- MouseOver
            (
                GetToggle(2, "mouseover") and
                UnitExists("mouseover") and 
                MouseHasFrame() and               
                not A.IsUnitEnemy("mouseover") and                 
                UnitIsPlayer("mouseover") and
                Unit("mouseover"):GetRange() <= 40 and
                --oPL["PvPMouseoverCyclone"] and
                Unit("mouseover"):HasDeBuffs(33786, true) <= GetCurrentGCD() + GetGCD() and
                UnitHealth("mouseover") <= UnitHealthMax("mouseover") * 0.7 and
                Unit("mouseover"):GetRealTimeDMG() > 0 and
                (                          
                    Unit("mouseover"):GetDMG() > UnitHealthMax("mouseover")*0.2 or
                    Unit("mouseover"):GetDMG() > getHEAL("mouseover") * 1.2 or
                    UnitHealth("mouseover") <= UnitHealthMax("mouseover")*0.25
                ) and
                Unit("mouseover"):TimeToDie() > 3
            ) or 
            -- Target
            (
                (
                    not GetToggle(2, "mouseover") or 
                    not UnitExists("mouseover") 
                ) and       
                not A.IsUnitEnemy("target") and
                UnitIsPlayer("target") and
                Unit("target"):GetRange() <= 40 and 
                --Unit("mouseover"):HasBuffs(33786, true) and
                Unit("target"):HasDeBuffs(33786, true) <= GetCurrentGCD() + GetGCD() and
                UnitHealth("target") <= UnitHealthMax("target") * 0.7 and
                Unit("target"):GetRealTimeDMG() > 0 and
                (                        
                    Unit("target"):GetDMG() > UnitHealthMax("target")*0.2 or
                    Unit("target"):GetDMG() > getHEAL("target") * 1.2 or            
                    UnitHealth("target") <= UnitHealthMax("target")*0.25
                ) and        
                Unit("target"):TimeToDie() > 3
            ) 
        )		
		then
            -- Notification					
            Action.SendNotification("Burst " .. A.GetSpellInfo(A.HolyAvenger.ID), A.HolyAvenger.ID)
            return A.HolyAvenger:Show(icon)
        end

		-- Avenging Wrath
		if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and Unit("player"):HasBuffs({A.AvengingCrusader.ID, A.AvengingWrath.ID}, "player", true) == 0 and
        (
            -- HEALING
            (
                not A.AvengingCrusader:IsSpellLearned() and
                A.AvengingWrath:GetCooldown() == 0 and
                combatTime > 8 and
                -- Holy Avenger, AW Original
		        Unit("player"):HasBuffs({A.HolyAvenger.ID, A.AvengingWrath.ID}, "player", true) <= GetCurrentGCD() and
                (       
                    -- HealingEngine conditions for burst raid/party heal
                    (
                        GetToggle(2, "AoE") and
                        (
                            (
                                not A.GetToggle(2, "mouseover") or
                                not A.MouseHasFrame() or
                                not A.IsUnitEnemy("mouseover")
                            ) and
                            not A.IsUnitEnemy("target") 
                        ) and
                        (
                            (
                                TeamCacheFriendlySize > 1 and
                                ReceivedLast5sec > AVG_DMG + AVG_HPS 
                                and 
                                HealingEngine.GetTimeToDieUnits(16) >= TeamCacheFriendlySize * 0.67
                            ) or
                            (
                                TeamCacheFriendlyType == "party" and
                                HealingEngine.GetBelowHealthPercentercentUnits(45) >= 3
                            ) or 
                            (
                                TeamCacheFriendlyType == "raid" and
                                HealingEngine.GetBelowHealthPercentercentUnits(55) >= 4
                            )  
                        )                
                    ) or
                    -- MouseOver
                    (
                        A.GetToggle(2, "mouseover") and
                        UnitExists("mouseover") and 
                        A.MouseHasFrame() and               
                        not A.IsUnitEnemy("mouseover") and                 
                        UnitIsPlayer("mouseover") and
                        Unit("mouseover"):GetRange() <= 40 and
                        --Unit("mouseover"):HasBuffs(33786, true) and
                        Unit("mouseover"):HasDeBuffs(33786, true) <= GetCurrentGCD() + GetGCD() and
                        UnitHealth("mouseover") <= UnitHealthMax("mouseover") * 0.4
                        and
                        Unit("mouseover"):GetRealTimeDMG() > 0 and
                        (
                            Unit("mouseover"):GetDMG() > Unit("mouseover"):GetHEAL() * 1.2 or
                            UnitHealth("mouseover") <= UnitHealthMax("mouseover") * 0.35 
                        ) and
                        Unit("mouseover"):TimeToDie() > 4
                    ) or 
                    -- Target
                    (
                        (
                            not A.GetToggle(2, "mouseover") or 
                            not UnitExists("mouseover") 
                        ) and       
                        not A.IsUnitEnemy("target") and
                        UnitIsPlayer("target") and
                        Unit("target"):GetRange() <= 40 and 
                        -- Unit(unit):HasDeBuffs(33786, true) and
                        Unit("target"):HasDeBuffs(33786, true) <= GetCurrentGCD() + GetGCD() and
                        UnitHealth("target") <= UnitHealthMax("target") * 0.4 and
                        Unit("target"):GetRealTimeDMG() >= 0 and
                        (
                            Unit("target"):GetDMG() > Unit("target"):GetHEAL() * 1.2 or
                            UnitHealth("target") <= UnitHealthMax("target") * 0.35
                        ) and
                        Unit("target"):TimeToDie() > 4
                    )
                )
            ) or
            -- DAMAGE
            (
                (
                    (
                        A.AvengingCrusader:IsSpellLearned() and
                        A.AvengingCrusade:GetCooldown() == 0
                    ) or
                    (
                        not A.AvengingCrusader:IsSpellLearned() and
                        A.AvengingWrath:GetCooldown() == 0
                    )
                ) and
                combatTime > 0 and
                (
                    (
                        A.GetToggle(2, "mouseover") and
                        A.IsUnitEnemy("mouseover") and                
                        Unit("mouseover"):GetLevel() == -1 and
                        Unit("mouseover"):GetRange() <= 40
                    ) or
                    (
                        A.IsUnitEnemy("target") and
                        Unit("target"):GetLevel() == -1 and
                        Unit("target"):GetRange() <= 40
                    )
                )
            )
        ) 
		then
            -- Notification					
            Action.SendNotification("Burst " .. A.GetSpellInfo(A.AvengingWrath.ID), A.AvengingWrath.ID)			
            return A.AvengingWrath:Show(icon)
        end

        -- Aura Mastery			
		if A.AuraMastery:IsReady(player) and A.BurstIsON(unit) and combatTime > AuraMasteryAfter and -- AuraMasteryAfter
		(
   		    HealingEngine.GetTimeToDieUnits(AuraMasteryAoETTD) >= GetValidMembers(true) * 0.4 -- AuraMasteryAoETTD
		    or
   		    ReceivedLast5sec > AVG_DMG * AuraMasteryLast -- AuraMasteryLast
		    or
    	    HealingEngine.GetBelowHealthPercentercentUnits(AuraMasteryBelowHealthPercent) >= GetValidMembers(true) * 0.35 -- -- AuraMasteryBelowHealthPercent
			or
			HealingEngine.GetBelowHealthPercentercentUnits(AuraMasteryBelowHealthPercent) >= AuraMasteryUnits -- -- AuraMasteryBelowHealthPercent
		) 			
		then
            -- Notification					
            Action.SendNotification("Burst " .. A.GetSpellInfo(A.AuraMastery.ID), A.AuraMastery.ID)		    	
			return A.AuraMastery:Show(icon)
		end

	    -- Life Binders Invocation
	    if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, true) and A.BurstIsON(unit) and HealingEngine.GetBelowHealthPercentercentUnits(LifeBindersInvocationHP, 40) >= LifeBindersInvocationUnits then
            -- Notification					
            Action.SendNotification("Burst " .. A.GetSpellInfo(A.LifeBindersInvocation.ID), A.LifeBindersInvocation.ID)			
	    	return A.LifeBindersInvocation:Show(icon)
	    end
			
	    -- Overcharge Mana
	    if A.OverchargeMana:AutoHeartOfAzeroth(unit, true) then
	    	return A.OverchargeMana:Show(icon)
	    end

        -- AvengingCrusader
		if A.AvengingCrusader:IsReady(unit) and A.BurstIsON(unit) and Unit(player):HasBuffs(A.AuraMastery.ID, true) == 0 and Unit(player):HasBuffs(A.HolyAvenger.ID, true) == 0 then
            -- Notification					
            Action.SendNotification("Burst " .. A.GetSpellInfo(A.AvengingCrusader.ID), A.AvengingCrusader.ID)			
            return A.AvengingCrusader:Show(icon)
        end	
				
		-- MemoryofLucidDreams if less than 85% mana left
		if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Player:Mana() < Player:ManaMax() * (LucidDreamManaPercent / 100) then
			return A.MemoryofLucidDreams:Show(icon)
		end

        -- Blessing Of Sacrifice
        if A.BlessingofSacrifice:IsReady(unit) and combatTime > 0 and UnitHealth("player") > UnitHealthMax("player") * 0.2 and
        (
            -- MouseOver
            (
                A.GetToggle(2, "mouseover") and        
                A.MouseHasFrame() and                      
                not A.IsUnitEnemy("mouseover") and                 
                (UnitInRaid("mouseover") or UnitInParty("mouseover")) and
                Unit("mouseover"):HasBuffs(33786, true) == 0 and        
                (
                    (    
                        not Unit("mouseover"):Role("TANK") and
                        (
                            HoS("mouseover", nil, nil, true, true) or
                            (
                                HealingEngine.IsMostlyIncDMG("mouseover") and
                                Unit("mouseover"):GetDMG()>UnitHealthMax("mouseover")*0.3                        
                            )
                        )
                    ) or 
                    (
                        Unit("mouseover"):Role("TANK") and
                        -- Divine Shield
                        Unit(player):HasBuffs(642, true) > 5 and
                        Unit("mouseover"):GetRealTimeDMG() >= UnitHealthMax("mouseover") * 0.2
                    )
                )
            ) or 
            -- Target
            (  
                (
                    not A.GetToggle(2, "mouseover") or 
                    not UnitExists("mouseover") 
                ) and     
                (UnitInRaid("target") or UnitInParty("target")) and
                not A.IsUnitEnemy("target") and                 
                Unit("target"):HasDeBuffs(33786, true) == 0 and   
                (
                    (
                        (
                            not Unit("target"):Role("TANK") and
                            (
                                HoS("target", nil, nil, true, true) or
                                (
                                    HealingEngine.IsMostlyIncDMG("mouseover") and
                                    Unit("target"):GetDMG() > UnitHealthMax("target")*0.3 
                                )
                            )                
                        )
                    ) or 
                    (
                        Unit("target"):Role("TANK") and
                        -- Divine Shield
                        Unit(player):HasBuffs(642, true) > 5 and
                        Unit("target"):GetRealTimeDMG() >= UnitHealthMax("target") * 0.2
                    )
                )        
            )
        )
      	then
        	return A.BlessingofSacrifice:Show(icon)
     	end

  	  	-- Blessing of Freedom
      	if A.BlessingofFreedom:IsReady(unit) and 

      	(
        	 -- MouseOver
          	(
             	A.GetToggle(2, "mouseover") and        
            	A.MouseHasFrame() and                      
            	not A.IsUnitEnemy("mouseover") and                          
            	Unit("mouseover"):TimeToDie() > GetGCD() * 3.8 and
              	HoF("mouseover")
          	) 
			or 
         	-- Target
          	(
            	(
               	    not A.GetToggle(2, "mouseover") or 
              	    not UnitExists("mouseover") 
             	) and       
             	not A.IsUnitEnemy("target") and        
             	Unit(unit):TimeToDie() > GetGCD() * 3.8 and
             	HoF("target")
         	)
     	)
      	then
        	return A.BlessingofFreedom:Show(icon)
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

        -- Special Glimmer of Light Buff spreader
		if A.HolyShock:IsReadyByPassCastGCD(unit) and A.GlimmerofLight:GetAzeriteRank() >= 2 and GlimmerofLightBuffCount < 8 and ForceGlimmerOnMaxUnits then
		    if IsInGroup() or A.IsInPvP or IsInRaid() then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= HolyShockHP and Unit(getmembersAll[i].Unit):HasBuffs(A.GlimmerofLightBuff.ID, true) == 0 and not Unit(getmembersAll[i].Unit):InLOS()  then 
			            HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 0.5sec delay in case of emergency switch 
                        -- Notification					
                        Action.SendNotification("Spreading " .. A.GetSpellInfo(A.GlimmerofLightBuff.ID), A.GlimmerofLightBuff.ID)							
                    end				
                end	
			end
		end

		-- Holy Shock
        if A.HolyShock:IsReadyByPassCastGCD(unit) then
            if GetLowestAlly("ALL", "HP") <= HolyShockHP then
                --HealingEngine.SetTarget(unit)
				ForceHealingTarget("ALL")
            end

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and Unit(unit):HasDeBuffs(A.GlimmerofLightBuff.ID, true) == 0 and
            (
		        Unit(unit):HealthPercent() <= HolyShockHP 
			    or 
			    Unit(unit):TimeToDie() < HolyShockTTD 
				or
				ForceGlimmerOnMaxUnits
            )			
			then
                return A.HolyShock:Show(icon)
            end
        end

        -- Judgment Of Light
        if (isMulti or A.GetToggle(2, "AoE")) and A.Judgement:IsReady(unit) and A.JudgementofLight:IsSpellLearned() and A.IsUnitEnemy(unit) then
            return A.Judgement:Show(icon)
        end

		-- LightsHammer
		if (isMulti or A.GetToggle(2, "AoE")) and A.LightsHammer:IsReady(unit) and A.LightsHammer:IsSpellLearned() and
        (
            (
                not A.GetToggle(2, "mouseover") or
                not A.MouseHasFrame() or
                not A.IsUnitEnemy("mouseover")
            ) and
            not A.IsUnitEnemy("target") 
        ) and
        (            
            (
                TeamCacheFriendlySize > 1 and
                (
                    ReceivedLast5sec > AVG_DMG + AVG_HPS or
                    AVG_DMG >= AVG_HPS * 2
                ) and
                (
                    HealingEngine.GetTimeToDieUnits(15) >= ValidMembers(true) * 0.5 or
                    HealingEngine.GetBelowHealthPercentercentUnits(50) >= ValidMembers(true) * 0.5
                )
            ) or        
            (
                TeamCacheFriendlyType == "party" and
                HealingEngine.GetBelowHealthPercentercentUnits(50) >= 3
            ) or 
            (
                TeamCacheFriendlyType == "raid" and
                HealingEngine.GetBelowHealthPercentercentUnits(65) >= 6              
            ) or
            -- Master Aur
			A.LastPlayerCastName == A.AuraMastery:Info()
        )		
		then
			return A.LightsHammer:Show(icon)
		end
		
		-- Holy Prism
		if (isMulti or A.GetToggle(2, "AoE")) and A.HolyPrism:IsSpellLearned() and
		(
    		-- HPS
    		-- MouseOver
    		(
        		A.GetToggle(2, "mouseover") and
        		UnitExists("mouseover") and 
        		A.MouseHasFrame() and                        
        		not A.IsUnitEnemy("mouseover") and                 
        		SpellInRange("mouseover", 114165) and
        		Unit("mouseover"):HasBuffs(33786, true) == 0 and
        		A.PredictHeal("HolyPrism", "mouseover")
    		) or 
    		-- Target
    		(
        		(
            		not A.GetToggle(2, "mouseover") or 
            		not UnitExists("mouseover") 
        		) and        
        		not A.IsUnitEnemy("target") and
        		SpellInRange("target", 20473) and
        		Unit(unit):HasDeBuffs(33786, true) == 0 and
        		A.PredictHeal("HolyPrism", "target")
    		) or
    		-- DMG
    		-- MouseOver
    		(
        		A.GetToggle(2, "mouseover") and
        		A.IsUnitEnemy("mouseover") and
        		SpellInRange("mouseover", 114165) and
        		Unit("mouseover"):HasBuffs(33786, true) == 0 and
        		(
            		not GetToggle(2, "AoE") or
            		HealingEngine.HealingBySpell("HolyPrismAoE", 114165) >= 2
        		) and
        		A.HolyPrism:AbsentImun("mouseover", Temp.TotalAndMag, true)		
    		) or
    		-- Target
    		(
        		(
            		not A.GetToggle(2, "mouseover") or
            		not A.MouseHasFrame() or
            		not A.IsUnitEnemy("mouseover")
        		) and
        		A.IsUnitEnemy("target") and
        		A.HolyPrism:AbsentImun("target", Temp.TotalAndMag, true)  
    		)    
		)
		then		
			return A.HolyPrism:Show(icon)
		end

        -- Bestow Faith
        if A.BestowFaith:IsSpellLearned() and A.BestowFaith:IsReady(unit) and A.BestowFaith:IsSpellLearned() and
        (
            -- MouseOver
            (
                GetToggle(2, "mouseover") and
                UnitExists("mouseover") and 
                A.MouseHasFrame() and                        
                not A.IsUnitEnemy("mouseover") and                 
                SpellInRange("mouseover", 223306) and
                Unit("mouseover"):HasBuffs(33786, true) == 0 and
                A.PredictHeal("BestowFaith", "mouseover") 
            ) or 
            -- Target
            (
                (
                    not GetToggle(2, "mouseover") or 
                    not UnitExists("mouseover") 
                ) and        
                not A.IsUnitEnemy("target") and
                SpellInRange("target", 223306) and
                Unit("target"):HasBuffs(33786, true) == 0 and
                A.PredictHeal("BestowFaith", "target") 
            )
        )
		then
            return A.BestowFaith:Show(icon)
        end
		
        -- Bestow Faith
   --[[     if A.BestowFaith:IsSpellLearned() and A.BestowFaith:IsReady(unit) then
            if GetLowestAlly("TANK", "HP") <= 95 then
                --HealingEngine.SetTarget(unit)
				ForceHealingTarget("TANK")
            end
            if Unit(unit):GUID() == GetLowestAlly("TANK", "GUID") and Unit(unit):HealthPercent() <= 95 then
                return A.BestowFaith:Show(icon)
            end
        end ]]--
		
		-- Concentrated Flame Heal
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) then
            if GetLowestAlly("ALL", "HP") <= 75 then
                --HealingEngine.SetTarget(unit)
				ForceHealingTarget("ALL")
            end

            if Unit(unit):GUID() == GetLowestAlly("ALL", "GUID") and Unit(unit):HealthPercent() <= 75 then
                return A.ConcentratedFlame:Show(icon)
            end
        end
		
		-- Vitality Conduit
        if A.VitalityConduit:AutoHeartOfAzeroth(unit, true) then
            if GetLowestAlly("TANK", "HP") <= 75 then
			    --HealingEngine.SetTarget(unit)
                ForceHealingTarget("TANK")
            end

            if Unit(unit):GUID() == GetLowestAlly("TANK", "GUID") and Unit(unit):HealthPercent() <= 75 then
                return A.VitalityConduit:Show(icon)
            end
        end

        -- HPvE #1 HolyLight
        local InfLight = Unit(player):HasBuffs(A.InfusionofLight.ID, true)
        local cast_t = Unit("player"):CastTime(A.InfusionofLight.ID)
        if A.HolyLight:IsReady(unit) and
            -- Infusion of Light
            InfLight > 0 and
            InfLight > cast_t + CurrentTimeGCD() + 0.1 and
            Unit("player"):GetCurrentSpeed() == 0 and 
            (
                -- MouseOver
                (
                    GetToggle(2, "mouseover") and
                    UnitExists("mouseover") and 
                    A.MouseHasFrame() and                        
                    not A.IsUnitEnemy("mouseover") and                 
                    SpellInRange("mouseover", 82326) and
                    Unit("mouseover"):HasBuffs(33786, true) < cast_t + CurrentTimeGCD() and
                    A.PredictHeal("HolyLight", "mouseover") and
                    TimeToDie("mouseover") > cast_t + CurrentTimeGCD() + 1
                ) or 
                -- Target
                (
                    (
                        not GetToggle(2, "mouseover") or 
                        not UnitExists("mouseover") or 
                        A.IsUnitEnemy("mouseover")
                    ) and        
                    not A.IsUnitEnemy("target") and
                    SpellInRange("target", 82326) and
                    Unit("target"):HasBuffs(33786, true) < cast_t + CurrentTimeGCD() and
                    A.PredictHeal("HolyLight", "target") and
                    TimeToDie("target") > cast_t + CurrentTimeGCD() + 1
                )
            )
		then
            return A.HolyLight:Show(icon)
        end

		
        -- Holy Light
   --[[     if A.HolyLight:IsReady(unit) and not isMoving and Unit(player):HasBuffs(A.InfusionofLight.ID, true) > 0 then
            if GetLowestAlly("ALL", "HP") <= HolyLightHP then
                --HealingEngine.SetTarget(unit)
				ForceHealingTarget("ALL")
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
        end ]]--
		
        -- Flash of Light
        if A.FlashofLight:IsReady(unit) and not isMoving then
            if GetLowestAlly("ALL", "HP") <= FlashofLightHP then
               -- HealingEngine.SetTarget(unit)
				ForceHealingTarget("ALL")
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
        if (isMulti or A.GetToggle(2, "AoE")) and A.CrusaderStrike:IsReady(unit) and Unit(unit):GetRange() <= 8 and A.CrusadersMight:IsSpellLearned() and not A.HolyShock:IsReady(unit) and A.IsUnitEnemy(unit) --and unit ~= "mouseover" 
		then
            return A.CrusaderStrike:Show(icon)
        end

        --Holy Light
        if A.HolyLight:IsReady(unit) and not isMoving then
            if GetLowestAlly("ALL", "HP") <= HolyLightHP then
                --HealingEngine.SetTarget(unit)
				ForceHealingTarget("ALL")
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
               -- HealingEngine.SetTarget(unit)
				ForceHealingTarget("ALL")
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