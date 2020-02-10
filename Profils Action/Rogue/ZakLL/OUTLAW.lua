local Action									= Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
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

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit

Action[ACTION_CONST_ROGUE_OUTLAW] = {
    -- Racial
    ArcaneTorrent								= Create({ Type = "Spell", ID = 50613}),
    BloodFury									= Create({ Type = "Spell", ID = 20572}),
    Fireblood									= Create({ Type = "Spell", ID = 265221}),
    AncestralCall								= Create({ Type = "Spell", ID = 274738}),
    Berserking									= Create({ Type = "Spell", ID = 26297}),
    ArcanePulse									= Create({ Type = "Spell", ID = 260364}),
    QuakingPalm									= Create({ Type = "Spell", ID = 107079}),
    Haymaker                                    = Create({ Type = "Spell", ID = 287712}), 
    WarStomp                                    = Create({ Type = "Spell", ID = 20549}),
    BullRush                                    = Create({ Type = "Spell", ID = 255654}),    
    GiftofNaaru									= Create({ Type = "Spell", ID = 59544}),
    Shadowmeld									= Create({ Type = "Spell", ID = 58984}), -- usable in Action Core 
    Stoneform									= Create({ Type = "Spell", ID = 20594}), 
    WilloftheForsaken							= Create({ Type = "Spell", ID = 7744}), -- not usable in APL but user can Queue it    
    EscapeArtist                                = Create({ Type = "Spell", ID = 20589}), -- not usable in APL but user can Queue it
    EveryManforHimself                          = Create({ Type = "Spell", ID = 59752}), -- not usable in APL but user can Queue it
    -- CrownControl    
	KidneyShot									= Create({ Type = "Spell", ID = 408}),
	KidneyShotFocus								= Create({ Type = "Spell", ID = 248744}), -- Shiv Pixel Kidney Shot Focus
	Blind										= Create({ Type = "Spell", ID = 2094}),
    Kick                                  	    = Create({ Type = "Spell", ID = 1766}),
    CheapShot                             		= Create({ Type = "Spell", ID = 1833}),
    -- Suppotive    
    Stealth										= Create({ Type = "Spell", ID = 1784}),
    -- Self Defensives
	CrimsonVial									= Create({ Type = "Spell", ID = 185311}),
	Feint										= Create({ Type = "Spell", ID = 1966}),
	Vanish										= Create({ Type = "Spell", ID = 1856}),
    -- Burst
	BladeFlurry									= Create({ Type = "Spell", ID = 13877}),
	AdrenalineRush								= Create({ Type = "Spell", ID = 13750}),
	RolltheBones								= Create({ Type = "Spell", ID = 193316}),
    -- Rotation       
	PistolShot									= Create({ Type = "Spell", ID = 185763}),
	SinisterStrike								= Create({ Type = "Spell", ID = 193315}),
	Dispatch									= Create({ Type = "Spell", ID = 2098}),
	BetweentheEyes								= Create({ Type = "Spell", ID = 199804}),
	Ambush										= Create({ Type = "Spell", ID = 8676}),
	-- PvP
	Sap                                 		= Create({ Type = "Spell", ID = 6770}),
	SmokeBomb                            		= Create({ Type = "Spell", ID = 212182}),
	DFA                                  		= Create({ Type = "Spell", ID = 269513}),
    -- Movement    
    Sprint                               		= Create({ Type = "Spell", ID = 2983}),
    -- Buffs
	KeepYourWitsBuff							= Create({ Type = "Spell", ID = 288988, Hidden = true}),
	OpportunityBuff								= Create({ Type = "Spell", ID = 195627, Hidden = true}),
	DeadshotBuff								= Create({ Type = "Spell", ID = 272940, Hidden = true}),
	LoadedDiceBuff								= Create({ Type = "Spell", ID = 256171, Hidden = true}),
	SnakeEyesBuff								= Create({ Type = "Spell", ID = 275863, Hidden = true}),
	-- Roll the Bones
    Broadside									= Create({ Type = "Spell", ID = 193356, Hidden = true}),
    BuriedTreasure								= Create({ Type = "Spell", ID = 199600, Hidden = true}),
    GrandMelee									= Create({ Type = "Spell", ID = 193358, Hidden = true}),
    RuthlessPrecision							= Create({ Type = "Spell", ID = 193357, Hidden = true}),
    SkullandCrossbones							= Create({ Type = "Spell", ID = 199603, Hidden = true}),
    TrueBearing									= Create({ Type = "Spell", ID = 193359, Hidden = true}),
	
    -- Debuffs
	BloodoftheEnemyDebuff						= Create({ Type = "Spell", ID = 297108, Hidden = true}),
	RazorCoralDebuff							= Create({ Type = "Spell", ID = 303568, Hidden = true}),
	ConcentratedFlameDebuff						= Create({ Type = "Spell", ID = 295368, Hidden = true}),
    -- Talents
	QuickDraw									= Create({ Type = "Spell", ID = 196938, isTalent = true}), -- Talent 1/2
	Vigor										= Create({ Type = "Spell", ID = 14983, isTalent = true}), -- Talent 3/1
	DeeperStratagem								= Create({ Type = "Spell", ID = 193531, isTalent = true}), -- Talent 3/2
	MarkedforDeath								= Create({ Type = "Spell", ID = 137619, isTalent = true}), -- Talent 3/3
	Elusiveness									= Create({ Type = "Spell", ID = 79008, isTalent = true}), -- Talent 4/3
	SliceandDice								= Create({ Type = "Spell", ID = 5171, isTalent = true}), -- Talent 6/3
	BladeRush									= Create({ Type = "Spell", ID = 271877, isTalent = true}), -- Talent 7/2
    -- Items
	PotionofUnbridledFury						= Create({ Type = "Potion",  ID = 169299 }), 
	DribblingInkpod								= Create({ Type = "Trinket", ID = 169319 }),
	PocketsizedComputationDevice				= Create({ Type = "Trinket", ID = 167555 }),
	AshvanesRazorCoral							= Create({ Type = "Trinket", ID = 169311 }),   
	RemoteGuidanceDevice						= Create({ Type = "Trinket", ID = 169769 }), 
	WrithingSegmentofDrestagath					= Create({ Type = "Trinket", ID = 173946 }), 
    -- Hidden 
	PoolResource								= Create({ Type = "Spell", ID = 97238, Hidden = true}),
	Channeling                                  = Create({ Type = "Spell", ID = 209274, Hidden = true     }),
	AceUpYourSleeve								= Create({ Type = "Spell", ID = 278676, Hidden = true}), -- Simcraft Azerite
	Deadshot									= Create({ Type = "Spell", ID = 272935, Hidden = true}), -- Simcraft Azerite
	SnakeEyes									= Create({ Type = "Spell", ID = 275846, Hidden = true}), -- Simcraft Azerite
}

Action:CreateEssencesFor(ACTION_CONST_ROGUE_OUTLAW)
local A = setmetatable(Action[ACTION_CONST_ROGUE_OUTLAW], { __index = Action })


local player									= "player"
local PartyUnits
local Temp										= {
	AttackTypes									= {"TotalImun", "DamagePhysImun"},	
	AuraForStun									= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC									= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun						= {"CCTotalImun", "StunImun"},
	AuraForInterrupt							= {"TotalImun", "DamagePhysImun", "KickImun"},
	KidneyShotToggle							= {2, "ForceKidney", "Set Queue Kidney Shot: "},
	KidneyShotFToggle							= {2, "ForceKidneyF", "Set Queue Focus Kidney Shot: "},
    IsSlotTrinketBlocked						= {
		[A.AshvanesRazorCoral.ID]				= true,
		[A.PocketsizedComputationDevice.ID]		= true,
		[A.DribblingInkpod.ID]					= true, 
		[A.RemoteGuidanceDevice.ID]				= true, 
		[A.WrithingSegmentofDrestagath.ID]      = true,
    },
}

local IsIndoors, UnitIsUnit = 
IsIndoors, UnitIsUnit          

local pairs, math = pairs, math
local huge = math.huge                                                    

--[[Listener:Add("ACTION_EVENT_ROGUE_FORCE_KIDNEY", "UNIT_SPELLCAST_SUCCEEDED", function(...)
	local source, _, spellID = ...
	if source == player and A.KidneyShot.ID == spellID and GetToggle(2, "ForceKidney") then 
		SetToggle(Temp.KidneyShotToggle)
	end 
	
	if source == player and A.KidneyShot.ID == spellID and GetToggle(2, "ForceKidneyF") then 
		SetToggle(Temp.KidneyShotFToggle)
	end 
end)  ]]

local function InMelee(unitID)
	-- @return boolean 
	return A.SinisterStrike:IsInRange(unitID)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	for unitID in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unitID)) and (not isCheckCombat or Unit(unitID):CombatTime() > 0) then 
			if InMelee(unitID) then 
				c = c + 1
			elseif range then 
				local r = Unit(unitID):GetRange()
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

local function GetByRangeTTD(self, count, range)
    -- @return number
    local total, total_ttd = 0, 0

    for unitID in pairs(ActiveUnitPlates) do 
        if not range or Unit(unitID):CanInterract(range) then 
            total = total + 1
			total_ttd = total_ttd + Unit(unitID):TimeToDie()
        end 
        
        if count and total >= count then 
            break 
        end 
    end 
	
    if total > 0 then 
      return total_ttd / total     
	else  
		return huge
	end
end 
GetByRangeTTD = A.MakeFunctionCachedDynamic(GetByRangeTTD)

local function Interrupts(unitID)
    local useKick, useCC, useRacial = InterruptIsValid(unitID, "TargetMouseover")    
    
    if useKick and A.Kick:IsReady(unitID) and A.Kick:AbsentImun(unitID, Temp.AuraForInterrupt, true) and Unit(unitID):CanInterrupt(true) then 
		return A.Kick
    end     
	
	if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unitID) and A.CheapShot:AbsentImun(unitID, Temp.AuraForOnlyCCAndStun, true) and Unit(unitID):IsControlAble("stun") then 
		return A.CheapShot              
    end
    
    if useRacial and A.QuakingPalm:AutoRacial(unitID) then 
		return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unitID) then 
		return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unitID) then 
		return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unitID) then 
		return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function num(val)
    if val then return 1 else return 0 end
end

local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end

local rtbBuffsList = {
    [1] = A.Broadside.ID, 
	[2] = A.GrandMelee.ID, 
    [3] = A.BuriedTreasure.ID, 
	[4] = A.RuthlessPrecision.ID,
	[5] = A.TrueBearing.ID,
	[6] = A.SkullandCrossbones.ID
}

local function rtbBuffsCount() 
	local count = 0
	
	for i = 1, #rtbBuffsList do
		if Unit(player):HasBuffs(rtbBuffsList[i], true) > 0 then
			count = count + 1
		end
	end
	
	return count
end

local function rtbBuffsTimer() 
	local timer = 0
	
	for i = 1, #rtbBuffsList do
		if Unit(player):HasBuffs(rtbBuffsList[i], true) > 0 then
			timer = Unit(player):HasBuffs(rtbBuffsList[i], true)
		end
	end
	
	return timer
end

local function rtbReroll(unitID, inAoE, range) 
	local varReroll = false
	
	if inAoE and GetByRange(2, 20, false, true) and GetByRangeTTD(2, range) > 5 then
		local buffsCount = rtbBuffsCount()
		
		if Unit(player):HasBuffs(A.SkullandCrossbones.ID, true) > 0 then
			buffsCount = buffsCount - 1
		end
		
		if (A.Vigor:IsSpellLearned() or A.MarkedforDeath:IsSpellLearned()) and buffsCount < 2 and 
		Unit(player):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit(player):HasBuffs(A.GrandMelee.ID, true) == 0 then
			varReroll = true
		end
		
		if A.DeeperStratagem:IsSpellLearned() and buffsCount < 2 and Unit(player):HasBuffs(A.Broadside.ID, true) == 0 and
		Unit(player):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit(player):HasBuffs(A.GrandMelee.ID, true) == 0 then
			varReroll = true
		end
		
		if Unit(player):HasBuffs(A.BladeFlurry.ID, true) == 0 and rtbBuffsCount() > 0 and rtbBuffsTimer()  > 3 then
			varReroll = false
		end
	elseif (not inAoE or MultiUnits:GetByRange(20, 2) < 2 or Unit(unitID):IsBoss()) and Unit(unitID):TimeToDie() > 10 then
		if (A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0) and rtbBuffsCount() < 2 and (Unit(player):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
		Unit(player):HasBuffs(A.RuthlessPrecision.ID, true) <= A.BetweentheEyes:GetCooldown()) then
			varReroll = true
		elseif rtbBuffsCount() < 2 and (Unit(player):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or Unit(player):HasBuffs(A.GrandMelee.ID, true) == 0 and 
		Unit(player):HasBuffs(A.RuthlessPrecision.ID, true) == 0) then
			varReroll = true
		end
	end	
	return varReroll
end

local function GetOpener(unitID) 
	local openerName = (A.IsInPvP and A.GetToggle(2, "OpenerPvP")) or (not A.IsInPvP and A.GetToggle(2, "OpenerPvE"))
	if openerName ~= "OFF" then 
		if openerName == "AUTO" then 
			if A.IsInPvP then 
				local isPlayer = Unit(unitID):IsPlayer()
			else
				if A.CheapShot:IsReadyByPassCastGCD(unitID, nil, nil, true) and A.CheapShot:AbsentImun(target, Temp.AuraForOnlyCCAndStun) and not Unit(unitID):IsBoss() then
					return "CheapShot"
				end
				
				if A.Ambush:IsReadyByPassCastGCD(unitID, nil, nil, true) and A.Ambush:AbsentImun(unitID, Temp.AttackTypes) then
					return "Ambush"
				end
			end
			
			openerName = "OFF"	
		else
			local isBroken = true
			
			if openerName == "Sap" and A.Sap:IsReadyByPassCastGCD(unitID, nil, nil, true) and MultiUnits:GetByRangeAppliedDoTs(nil, 2, A.Sap.ID) < 1 and Unit(unitID):CombatTime() == 0 then
				 if Unit(unitID):HasDeBuffs(A.Sap.ID, true) == 0 and Unit(unitID):IsControlAble("incapacitate", 75) then 
					isBroken = false
				 elseif Unit(unitID):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Sap.ID, true) <= 1 and Unit(unitID):IsControlAble("incapacitate", 25) then
					isBroken = false			 
				 end
			end
			
			if openerName == "CheapShot" and A.CheapShot:IsReadyByPassCastGCD(unitID, nil, nil, true) and A.CheapShot:AbsentImun(target, Temp.AuraForOnlyCCAndStun) and not Unit(unitID):IsBoss() then
				isBroken = false
			end
		
			if openerName == "Ambush" and A.Ambush:IsReadyByPassCastGCD(unitID, nil, nil, true) and A.Ambush:AbsentImun(unitID, Temp.AttackTypes) then
				isBroken = false
			end
			
			if isBroken then 
				openerName = "OFF"
			end
		end
	end
	
	return openerName
end

local function SelfDefensives()
	if Unit(player):CombatTime() == 0 then 
        return 
    end
	
	local CrimsonVial = Action.GetToggle(2, "CrimsonVialDef")
	
	if A.CrimsonVial:IsReady(player) and CrimsonVial >= 0 and CrimsonVial < 100 and Unit(player):HealthPercent() <= CrimsonVial then
		return A.CrimsonVial
	end	
	
	local Feint = GetToggle(2, "FeintDef")
    if Feint >= 0 and A.Feint:IsReady(player) and 
    (
        (     -- Auto 
            Feint >= 100 and A.Elusiveness:IsSpellLearned() and
            (
                (
                    not A.IsInPvP and 
                    Unit(player):HealthPercent() < 40 and 
                    Unit(player):TimeToDieX(20) < 6
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            
							Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs") == 0
        ) or 
        (    -- Custom
            Feint < 100 and A.Elusiveness:IsSpellLearned() and
            Unit(player):HealthPercent() <= Feint
        )
    ) 
    then 
        return A.Feint
    end 
end
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)
-----------------------------------------
--                 ROTATION  
-----------------------------------------

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local unitID							= "player"
    local energy							= Player:Energy()
    local inAoE								= GetToggle(2, "AoE")
    local StealthOOC                        = GetToggle(2, "StealthOOC")
    
	local bladeFurryRange					= GetToggle(2, "BladeFlurryRange")
	local bladeFurryTargets					= GetToggle(2, "BladeFlurryTargets")
	local inHoldAoE							= GetToggle(2, "holdAoE")
	local minHoldAoE						= GetToggle(2, "holdAoENum") 
    local combatTime						= Unit(player):CombatTime()
    local inCombat							= combatTime > 0
	local SprintTime                        = GetToggle(2, "SprintTime")
	local UseSprint                         = GetToggle(2, "UseSprint")
    local isMoving							= Player:IsMoving()
	local isMovingFor						= Player:IsMovingTime()
    local ShouldStop 						= Action.ShouldStop()
    local inStealth							= Player:IsStealthed()
    local CP								= Player:ComboPoints()
    local CP_MAX							= Player:ComboPointsMax()
	local CP_CAST							= 4
	local canCast							= true
	local useFinish							= false
	local BtECondition						= false
	local bladeFurrySync					= false
	--print("Opener Step : " .. Temp.OpenerRotationPhase)
	
	-- Focused Azerite Beam protection channel
	local canCast = true
	local TotalCast, CurrentCastLeft, CurrentCastDone = Unit(player):CastTime()
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
	if (spellID == A.FocusedAzeriteBeam.ID) then 
	    if (CurrentCastLeft > 0 or secondsLeft > 0 or isChannel) then
	        canCast = false
	    else
	        canCast = true
		end
	end
	
	if not canCast then
	    return A.Channeling:Show(icon)
	end		
	
    local function EnemyRotationPvE(unitID)		
		BtECondition = Unit(player):HasBuffs(A.OpportunityBuff.ID, true) > 0 or (A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0) and rtbBuffsCount() > 0
		bladeFurrySync = inAoE and MultiUnits:GetByRange(10, 2) < 2 or not inAoE or Unit(player):HasBuffs(A.BladeFlurry.ID, true) > 0
		
		-- Stealth with target Enemy
		if A.Stealth:IsReady(player) and not inCombat and canCast and not Player:IsMounted() and not inStealth then
			return A.Stealth:Show(icon)
		end

		local openerName = GetOpener(unitID)
		if openerName ~= "AUTO" and openerName ~= "OFF" and inStealth then
			return A[openerName]:Show(icon)	
		end
		
		-- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end 
		
		-- Interrupts
		local Interrupt = Interrupts(unitID)
		if Interrupt then 
			return Interrupt:Show(icon)
		end 
		
	    -- Sprint if out of range 
        if A.Sprint:IsReady("player") and isMovingFor > SprintTime and UseSprint then
            return A.Sprint:Show(icon)
        end		
		
		if A.BladeFlurry:IsReady(player) and inAoE and canCast and not inStealth and GetByRange(bladeFurryTargets, bladeFurryRange) and 
		Unit(player):HasBuffs(A.BladeFlurry.ID, true) <= GetCurrentGCD() and GetByRangeTTD(bladeFurryTargets, bladeFurryRange) >= 3 then
			return A.BladeFlurry:Show(icon)
		end
		
		
		if inStealth then
			return 
		end
		
		--Burst #1
		if BurstIsON(unitID) and canCast and Unit(unitID):TimeToDie() > 5 and not inStealth then			
			if A.AdrenalineRush:IsReady(player) and Unit(unitID):HasDeBuffs(A.AdrenalineRush.ID, true) and EnergyTimeToMaxRounded() > 1 then
				return A.AdrenalineRush:Show(icon) 
			end
			
			if A.BloodoftheEnemy:AutoHeartOfAzerothP(unitID) and bladeFurrySync and A.BetweentheEyes:GetCooldown() == 0 and BtECondition and 
			(not inHoldAoE or Unit(unitID):IsBoss()) then
				return A.BloodoftheEnemy:Show(icon)
			end
			
            -- focused_azerite_beam,if=spell_targets.fan_of_knives>=2|raid_event.adds.in>60&energy<70
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unitID, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRange(10) >= 2) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
			if A.GuardianofAzeroth:AutoHeartOfAzerothP(unitID) then
				return A.GuardianofAzeroth:Show(icon)
			end
			
			if A.BladeRush:IsReady(unitID) and A.BladeRush:AbsentImun(unitID, Temp.AttackTypes) and Player:EnergyTimeToMaxPredicted() > 1 and bladeFurrySync then
				return A.BladeRush:Show(icon)
			end
			
			-- Trinkets
			if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unitID, "DamageMagicImun") and not Temp.IsSlotTrinketBlocked[A.Trinket1.ID] then  
				return A.Trinket1:Show(icon)	
			end 
                
			if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unitID, "DamageMagicImun") and not Temp.IsSlotTrinketBlocked[A.Trinket2.ID] then 
				return A.Trinket2:Show(icon)
			end   
		end
		
		--Trinkets
		if A.AshvanesRazorCoral:IsReady(unitID, true) and (Unit(unitID):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 and Unit(unitID):TimeToDie() > 4 and canCast and not inStealth and
		MultiUnits:GetByRangeAppliedDoTs(nil, 1, A.RazorCoralDebuff.ID) == 0) and InMelee(unitID) then
			return A.AshvanesRazorCoral:Show(icon)
		end
		
		if A.RemoteGuidanceDevice:IsReady(unitID) and A.RemoteGuidanceDevice:AbsentImun(unitID, "DamageMagicImun") and canCast and not inStealth and 
		(inAoE and GetByRange(minHoldAoE, 10) and inHoldAoE and GetByRangeTTD(minHoldAoE, 10) > 5 or Unit(unitID):IsBoss()) and InMelee(unitID) then
			return A.RemoteGuidanceDevice:Show(icon)
		end
		
		if A.WrithingSegmentofDrestagath:IsReady(unitID) and A.WrithingSegmentofDrestagath:AbsentImun(unitID, "DamageMagicImun") and canCast and not inStealth and 
		(inAoE and GetByRange(minHoldAoE, 10) and inHoldAoE and GetByRangeTTD(minHoldAoE, 10) > 5 or Unit(unitID):IsBoss()) and InMelee(unitID) then
			return A.WrithingSegmentofDrestagath:Show(icon)
		end
		
		-- Essences
		if A.BloodoftheEnemy:AutoHeartOfAzerothP(unitID) and canCast and not inStealth and inAoE and inHoldAoE and GetByRange(minHoldAoE, 10) and 
		GetByRangeTTD(minHoldAoE, 10) > 5 and bladeFurrySync and A.BetweentheEyes:GetCooldown() == 0 and BtECondition and rtbBuffsCount() >= 1 then
			return A.BloodoftheEnemy:Show(icon)
		end
		
		--Finishers
		if CP >= CP_MAX - (num(Unit(player):HasBuffs(A.Broadside.ID, true) > 0) + num(Unit(player):HasBuffs(A.OpportunityBuff.ID, true) > 0)) *
		num(A.QuickDraw:IsSpellLearned() and (not A.MarkedforDeath:IsSpellLearned() or A.MarkedforDeath:GetCooldown() > 1)) and not inStealth then
			
			if A.BetweentheEyes:IsReady(unitID) and A.BetweentheEyes:AbsentImun(unitID, Temp.AttackTypes) and canCast and (Unit(player):HasBuffs(A.RuthlessPrecision.ID, true) > 0 or 
			Unit(player):HasBuffs(A.Broadside.ID, true) > 0 and (A.AceUpYourSleeve:GetAzeriteRank() >= 1 or A.Deadshot:GetAzeriteRank() >= 1) or A.AceUpYourSleeve:GetAzeriteRank() >= 2 or 
			A.Deadshot:GetAzeriteRank() >= 2 or A.AceUpYourSleeve:GetAzeriteRank() >= 1 and A.Deadshot:GetAzeriteRank() >= 1) and rtbBuffsCount() >= 1 and 
			Unit(player):HasBuffs(A.DeadshotBuff.ID, true) == 0 then
				return A.BetweentheEyes:Show(icon)
			end
			
			if A.RolltheBones:IsReady(player) and canCast and (GetByRange(bladeFurryTargets, bladeFurryRange) and Unit(player):HasBuffs(A.BladeFlurry.ID, true) == 0 or
			not GetByRange(bladeFurryTargets, bladeFurryRange)) and rtbBuffsCount() < 2 and (Unit(player):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or 
			Unit(player):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit(player):HasBuffs(A.GrandMelee.ID, true) == 0) then
				return A.RolltheBones:Show(icon)
			end
			
			if A.RolltheBones:IsReady(player) and canCast and (GetByRange(bladeFurryTargets, bladeFurryRange) and Unit(player):HasBuffs(A.BladeFlurry.ID, true) == 0 or
			not GetByRange(bladeFurryTargets, bladeFurryRange)) and (A.AceUpYourSleeve:GetAzeriteRank() >= 1 or A.Deadshot:GetAzeriteRank() >= 1) and 
			rtbBuffsCount() < 2 and (Unit(player):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or 
			Unit(player):HasBuffs(A.RuthlessPrecision.ID, true) <= A.BetweentheEyes:GetCooldown()) then
				return A.RolltheBones:Show(icon)
			end
			
			if A.RolltheBones:IsReady(player) and canCast and (A.SnakeEyes:GetAzeriteRank() >= 2 and Unit(player):HasBuffsStacks(A.SnakeEyesBuff.ID, true) <= 2 -
			num(Unit(player):HasBuffs(A.Broadside.ID, true) > 0) or (A.SnakeEyes:GetAzeriteRank() < 2 and (GetByRange(bladeFurryTargets, bladeFurryRange) and 
			Unit(player):HasBuffs(A.BladeFlurry.ID, true) == 0 or not GetByRange(bladeFurryTargets, bladeFurryRange)))) and rtbBuffsCount() < 2 and (A.SnakeEyes:GetAzeriteRank() == 1 or
			A.SnakeEyes:GetAzeriteRank() >= 2 or A.SnakeEyes:GetAzeriteRank() >= 3 and rtbBuffsCount() < 5) then
				return A.RolltheBones:Show(icon)
			end
			
			if A.RolltheBones:IsReady(player) and canCast and rtbBuffsTimer() <= 3 then
				return A.RolltheBones:Show(icon)
			end

			if A.BetweentheEyes:IsReady(unitID) and A.BetweentheEyes:AbsentImun(unitID, Temp.AttackTypes) and canCast and (A.AceUpYourSleeve:GetAzeriteRank() >= 1 or 
			A.Deadshot:GetAzeriteRank() >= 1) and Unit(player):HasBuffs(A.DeadshotBuff.ID, true) == 0 then
				return A.BetweentheEyes:Show(icon)
			end
	
			if A.Dispatch:IsReady(unitID) and A.Dispatch:AbsentImun(unitID, Temp.AttackTypes) and canCast then
				return A.Dispatch:Show(icon)
			end
			
			if A.BetweentheEyes:IsReady(unitID) and A.BetweentheEyes:AbsentImun(unitID, Temp.AttackTypes) and canCast and not InMelee(unitID) and 
			Unit(player):HasBuffs(A.DeadshotBuff.ID, true) == 0 and Unit(unitID):HealthPercent() < 100 then
				return A.BetweentheEyes:Show(icon)
			end			
		end	
		
		---if A.SliceandDice:IsReady(player) and canCast and useFinish and A.SliceandDice:IsSpellLearned() and Unit(player):HasBuffs(A.SliceandDice.ID, true) < Unit(unit):TimeToDie() and 
		--Unit(player):HasBuffs(A.SliceandDice.ID, true) < (1 + CP) * 1.8 then
		--	return A.SliceandDice:Show(icon)
		--end

		--if A.RolltheBones:IsReady(player) and canCast and useFinish and A.LastPlayerCastName ~= A.RolltheBones:Info() and 
		--((rtbBuffsTimer() < 3 and Unit(unitID):TimeToDie() > 5) or rtbReroll(unitID, inAoE, bladeFurryRange)) then
		--	return A.RolltheBones:Show(icon)
		--end
		-- Builders
		if A.PistolShot:IsReady(unitID) and A.PistolShot:AbsentImun(unitID, Temp.AttackTypes) and canCast and not inStealth and
		Player:ComboPointsDeficit() >= (1 + num(Unit(player):HasBuffs(A.Broadside.ID, true) > 0) + num(A.QuickDraw:IsSpellLearned())) and
		(Unit(player):HasBuffsStacks(A.KeepYourWitsBuff.ID, true) < 14 or Unit(player):HasBuffs(A.DeadshotBuff.ID, true) > 0 or energy < 45) and 
		Unit(player):HasBuffs(A.OpportunityBuff.ID, true) > 0 then
			return A.PistolShot:Show(icon)
		end
		
		--if A.PistolShot:IsReady(unitID) and A.PistolShot:AbsentImun(unitID, Temp.AttackTypes) and canCast and not useFinish and (Unit(player):HasBuffs(A.OpportunityBuff.ID, true) > 0 and
		--(Unit(player):HasBuffsStacks(A.KeepYourWitsBuff.ID, true) < 14 or Unit(player):HasBuffs(A.DeadshotBuff.ID, true) > GetCurrentGCD() or energy < 45)) then
		--	return A.PistolShot:Show(icon)
		--end
		
		if A.SinisterStrike:IsReady(unitID) and A.SinisterStrike:AbsentImun(unitID, Temp.AttackTypes) and canCast then
			return A.SinisterStrike:Show(icon)
		end
		
		if A.PistolShot:IsReady(unitID) and A.PistolShot:AbsentImun(unitID, Temp.AttackTypes) and canCast and not inStealth and CP < CP_MAX and 
		Unit(unitID):HealthPercent() < 100 and not InMelee(unitID) and Unit(player):HasBuffs(A.DeadshotBuff.ID, true) == 0 then
			return A.PistolShot:Show(icon)
		end

    end

	-- Stealth out of combat
	-- Need to check for different spellID depending if Subterfuge is learned or not. 
    if not inCombat and Unit(player):HasBuffs(A.Vanish.ID, true) == 0 and StealthOOC and not Unit(player):HasFlags() and not Player:IsMounted() 
	and A.Stealth:IsReady(player) and Unit(player):HasBuffs(A.Stealth.ID, true) == 0 then
       	return A.Stealth:Show(icon)
    end 
	
	-- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    if IsUnitEnemy("target") then 
        unitID = "target"
        
        if EnemyRotationPvE(unitID) and not Unit(unitID):IsDead() then 
            return true 
        end 
    end 
    
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 


