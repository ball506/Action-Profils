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
local Pull										= Action.BossMods_Pulling()
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

Action[ACTION_CONST_ROGUE_ASSASSINATION] = {
    -- Racial
    ArcaneTorrent								= Create({ Type = "Spell", ID = 50613}),
    BloodFury									= Create({ Type = "Spell", ID = 20572}),
    BagofTricks                                 = Create({ Type = "Spell", ID = 312411}),
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
	StepKidneyFocus								= Create({ Type = "Spell", ID = 291944}), -- Zandalari Racial Icon (Regeneratin)
    -- Suppotive    
    Stealth                                     = Create({ Type = "Spell", ID = 1784}),
    Stealth2                                    = Create({ Type = "Spell", ID = 115191}), -- w/ Subterfuge Talent
    -- Self Defensives
	CrimsonVial									= Create({ Type = "Spell", ID = 185311}),
	Feint										= Create({ Type = "Spell", ID = 1966}),
    -- Burst
	Vendetta									= Create({ Type = "Spell", ID = 79140}),
	Vanish										= Create({ Type = "Spell", ID = 1856}),
    -- Rotation       
	Envenom										= Create({ Type = "Spell", ID = 32645}),
	Garrote										= Create({ Type = "Spell", ID = 703}),
	Rupture										= Create({ Type = "Spell", ID = 1943}),
	Mutilate									= Create({ Type = "Spell", ID = 1329}),
	FanofKnives									= Create({ Type = "Spell", ID = 51723}),
	PoisonedKnife								= Create({ Type = "Spell", ID = 185565}),
    -- Movement    
    Sprint                               		= Create({ Type = "Spell", ID = 2983}),
    -- Utilities
	ShadowStep                          		= Create({ Type = "Spell", ID = 36554}),
	TricksoftheTrade                    		= Create({ Type = "Spell", ID = 57934}),
	-- PvP
	Sap                                 		= Create({ Type = "Spell", ID = 6770}),
	Shiv                                		= Create({ Type = "Spell", ID = 248744}),
	SmokeBomb                            		= Create({ Type = "Spell", ID = 212182}),
	DFA                                  		= Create({ Type = "Spell", ID = 269513}),
	Neuro                                 		= Create({ Type = "Spell", ID = 206328}),
    -- Poisons
	CripplingPoison								= Create({ Type = "Spell", ID = 3408}),
	DeadlyPoison								= Create({ Type = "Spell", ID = 2823}),
	WoundPoison									= Create({ Type = "Spell", ID = 8679}),
    -- Buffs
	SubterfugeBuff								= Create({ Type = "Spell", ID = 115192 , Hidden = true}),
	MasterAssassinBuffs							= Create({ Type = "Spell", ID = 255989 , Hidden = true}),
	HiddenBladesBuff							= Create({ Type = "Spell", ID = 270070 , Hidden = true}),
    -- Debuffs
    ToxicBladeDebuff                            = Create({ Type = "Spell", ID = 245389, Hidden = true}),
	BloodoftheEnemyDebuff						= Create({ Type = "Spell", ID = 297108, Hidden = true}),
	DeadlyPoisonDebuff							= Create({ Type = "Spell", ID = 2818, Hidden = true}),
	RazorCoralDebuff							= Create({ Type = "Spell", ID = 303568, Hidden = true}),
	ConcentratedFlameDebuff						= Create({ Type = "Spell", ID = 295368, Hidden = true}),
    -- Talents
	Subterfuge									= Create({ Type = "Spell", ID = 108208, isTalent = true}), -- Talent 2/2
	MasterAssassin								= Create({ Type = "Spell", ID = 255989, isTalent = true}), -- Talent 2/3
	Vigor										= Create({ Type = "Spell", ID = 14983, isTalent = true}), -- Talent 3/1
    DeeperStratagem								= Create({ Type = "Spell", ID = 193531, isTalent = true}), -- Talent 3/2
	MarkedForDeath								= Create({ Type = "Spell", ID = 137619, isTalent = true}), -- Talent 3/3
	Elusiveness									= Create({ Type = "Spell", ID = 79008, isTalent = true}), -- Talent 4/3
	IronWire									= Create({ Type = "Spell", ID = 196861, isTalent = true}), -- Talent 5/2
    ToxicBlade									= Create({ Type = "Spell", ID = 245388, isTalent = true}), -- Talent 6/2
    Exsanguinate								= Create({ Type = "Spell", ID = 200806, isTalent = true}), -- Talent 6/3
	CrimsonTempest								= Create({ Type = "Spell", ID = 121411, isTalent = true}), -- Talent 7/3
	-- PvP Talents
	SmokeBomb									= Create({ Type = "Spell", ID = 212182, isTalent = true}), 
    -- Items
	PotionofUnbridledFury						= Create({ Type = "Potion",  ID = 169299 }), 
	DribblingInkpod								= Create({ Type = "Trinket", ID = 169319 }),
	PocketsizedComputationDevice				= Create({ Type = "Trinket", ID = 167555 }),
	AshvanesRazorCoral							= Create({ Type = "Trinket", ID = 169311 }),   
	RemoteGuidanceDevice						= Create({ Type = "Trinket", ID = 169769 }), 
	WrithingSegmentofDrestagath					= Create({ Type = "Trinket", ID = 173946 }), 
    -- Hidden 
	PoolResource								= Create({ Type = "Spell", ID = 97238, Hidden = true}),
	Channeling								    = Create({ Type = "Spell", ID = 209274, Hidden = true}),	
	EchoingBlades								= Create({ Type = "Spell", ID = 287649, Hidden = true}), -- Simcraft Azerite
	DoubleDose									= Create({ Type = "Spell", ID = 273007, Hidden = true}), -- Simcraft Azerite
	ScentOfBlood								= Create({ Type = "Spell", ID = 277679, Hidden = true}), -- Simcraft Azerite
	ShroudedSuffocation							= Create({ Type = "Spell", ID = 278666, Hidden = true}), -- Simcraft Azerite
}

Action:CreateEssencesFor(ACTION_CONST_ROGUE_ASSASSINATION)
local A = setmetatable(Action[ACTION_CONST_ROGUE_ASSASSINATION], { __index = Action })


local player									= "player"
local target                                    = "target"
local Temp										= {
	AttackTypes									= {"TotalImun", "DamagePhysImun"},	
	AuraForStun									= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC									= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun						= {"CCTotalImun", "StunImun"},
	AuraForInterrupt							= {"TotalImun", "DamagePhysImun", "KickImun"},
	AuraForSlow									= {"TotalImun", "DamagePhysImun", "CCTotalImun", "Freedom"},
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

Listener:Add("ACTION_EVENT_ROGUE_FORCE_KIDNEY", "UNIT_SPELLCAST_SUCCEEDED", function(...)
	local source, _, spellID = ...
	if source == player and A.KidneyShot.ID == spellID and GetToggle(2, "ForceKidney") then 
		SetToggle(Temp.KidneyShotToggle)
	end 
	
	if source == player and A.KidneyShot.ID == spellID and GetToggle(2, "ForceKidneyF") then 
		SetToggle(Temp.KidneyShotFToggle)
	end 
end)  

local function InMelee(unitID)
	-- @return boolean 
	return A.Mutilate:IsInRange(unitID)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	for unitID in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit(target, unitID)) and (not isCheckCombat or Unit(unitID):CombatTime() > 0) then 
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
	local StealthOOC                        = GetToggle(2, "StealthOOC")
	local CP_KIDNEY							= GetToggle(2, "KidneyCPPvP") 
	local forceKidney						= GetToggle(2, "ForceKidney")
	local forceKidneyF						= GetToggle(2, "ForceKidneyF")
	local SprintTime                        = GetToggle(2, "SprintTime")
	local UseSprint                         = GetToggle(2, "UseSprint")
	local combatTime						= Unit(player):CombatTime()
    local inCombat							= combatTime > 0
    local inStealth							= Player:IsStealthed()
    local isMoving							= Player:IsMoving()
	local isMovingFor						= Player:IsMovingTime()
    local CP								= Player:ComboPoints()
    local CP_MAX							= Player:ComboPointsMax()
	local CP_CAST							= 4
	local canCast							= true
	local energyPoolBurst					= 0
	local PoisonPvE							= GetToggle(2, "PvEPoison")
	local PoisonPvP							= GetToggle(2, "PvPPoison") 


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
	
	-- [[ POISONS ]] 	
	if A.IsInPvP and canCast and not Player:IsMoving() and not Player:IsMounted() then
		if PoisonPvP == "DeadlyPoison" and A.DeadlyPoison:IsReady(player) and Unit(player):HasBuffs(A.DeadlyPoison.ID, true) <= 10 and A.LastPlayerCastName ~= A.DeadlyPoison:Info() then
			return A.DeadlyPoison:Show(icon)
		end
		if PoisonPvP == "WoundPoison" and A.WoundPoison:IsReady(player) and Unit(player):HasBuffs(A.WoundPoison.ID, true) <= 10 and A.LastPlayerCastName ~= A.WoundPoison:Info() then
			return A.WoundPoison:Show(icon)
		end
	end
	if not A.IsInPvP and canCast and not Player:IsMoving() and not Player:IsMounted() then
		if PoisonPvE == "DeadlyPoison" and A.DeadlyPoison:IsReady(player) and Unit(player):HasBuffs(A.DeadlyPoison.ID, true) <= 10 and A.LastPlayerCastName ~= A.DeadlyPoison:Info() then
			return A.DeadlyPoison:Show(icon)
		end
		if PoisonPvE == "WoundPoison" and A.WoundPoison:IsReady(player) and Unit(player):HasBuffs(A.WoundPoison.ID, true) <= 10 and A.LastPlayerCastName ~= A.WoundPoison:Info() then
			return A.WoundPoison:Show(icon)
		end
	end
	
	if A.CripplingPoison:IsReady(player) and Unit(player):HasBuffs(A.CripplingPoison.ID, true) <= 10 and A.LastPlayerCastName ~= A.CripplingPoison:Info() and 
	canCast and not Player:IsMoving() and not Player:IsMounted() then
		return A.CripplingPoison:Show(icon)
	end
	
	
	--print("Opener Step : " .. PoisonPvE)
	
    local function EnemyRotationPvE(unitID)
		local AutoSAP                           = GetToggle(2, "AutoSAP")
		local inAoE								= GetToggle(2, "AoE")
		local VanishDPS							= GetToggle(2, "VanishDPS") 
		local inHoldAoE							= GetToggle(2, "holdAoE")
		local minHoldAoE						= GetToggle(2, "holdAoENum") 
		local AutoMultiDots						= GetToggle(2, "MultiDots")
		local MultiDotsBurst					= GetToggle(2, "MultiDotsBurst")
		local MultiDotsRange					= GetToggle(2, "MultiDotsRange")
		local MultiDotsTTD						= GetToggle(2, "MultiDotsTTD") 
		local MultiDotsMaxAttackTypes				= GetToggle(2, "MultiDotsMaxRupture") 
		local CrimsonFinisherTargets			= GetToggle(2, "MultiDotsCrimsonFinisher") 
		local varSingleTarget					= false
		local useFiller							= false
		local skipRupture						= false
		local skipGarrote						= false
		local skipCycleRupture					= false
		local ActivesRupture 					= MultiUnits:GetByRangeAppliedDoTs(nil, MultiDotsMaxRupture, A.Rupture.ID)
		local MissingRupture					= MultiUnits:GetByRangeMissedDoTs(MultiDotsRange, MultiDotsMaxRupture, A.Rupture.ID, MultiDotsTTD)
		local ActivesSAP                        = MultiUnits:GetByRangeAppliedDoTs(nil, 2, A.Sap.ID)
	
		if A.Vigor:IsSpellLearned() then
			energyPoolBurst = GetToggle(2, "BurstEnergyVigorPvE")
		else
			energyPoolBurst = GetToggle(2, "BurstEnergyPvE")
		end
		
		if Unit(player):HasBuffs("BurstHaste") > 0 then
			energyPoolBurst = 0
		end
		
		varSingleTarget = inAoE and not GetByRange(2, 10) or not inAoE
		useFiller = Player:ComboPointsDeficit() > 1 or Player:EnergyPredicted() >= energyPoolBurst or not varSingleTarget
		skipRupture = Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 3 or 
		Unit(player):HasBuffs(A.MasterAssassinBuffs.ID) > 0 and Unit(unitID):HasDeBuffs(A.Vendetta.ID, true) > 0
		skipGarrote = Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Garrote.ID, true) > 1.5
		skipCycleRupture = inAoE and GetByRange(4, 9) and (Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 or A.ScentOfBlood:GetAzeriteRank() == 0)
		
		-- Stealth with target Enemy
		if A.Stealth:IsReady(player) and not inCombat and canCast and not Player:IsMounted() and not inStealth then
			return A.Stealth:Show(icon)
		end
		
	    -- Sap out of combat
		-- First time 75%DR 
	    if A.Sap:IsReady(unitID) and AutoSAP and ActivesSAP < 1 and inStealth and Unit(unitID):CombatTime() == 0 then
	        if Unit(unitID):HasDeBuffs(A.Sap.ID, true) == 0 and Unit(unitID):IsControlAble("incapacitate", 75) then 
		        return A.Sap:Show(icon)
		    else 
			    -- Second time 25%DR 
		        if Unit(unitID):HasDeBuffs(A.Sap.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Sap.ID, true) <= 1 and Unit(unitID):IsControlAble("incapacitate", 25) then
		            return A.Sap:Show(icon)
			    end
		    end
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
		
		-- Mutilate for kill explosive 
		if Unit(unitID):IsExplosives() and A.Mutilate:IsReady(unitID) and A.Mutilate:AbsentImun(unitID, Temp.AttackTypes) and (ActivesSAP > 0 or not AutoSAP) and canCast then
			return A.Mutilate:Show(icon)
		end
		
		-- Kill Totem
		if Unit(unitID):IsTotem() then
			if A.Envenom:IsReady(unitID) and A.Envenom:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP >= 4 then
				return A.Envenom:Show(icon)
			end
				
			if A.Mutilate:IsReady(unitID) and A.Mutilate:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP < 4 then
				return A.Mutilate:Show(icon)
			end
		end
		
		-- Autodot
		if inAoE and AutoMultiDots and Unit(unitID):HasDeBuffs(A.Garrote.ID, true) > 0 and 
		(
		    A.IronWire:IsSpellLearned() and Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) > 0 and MultiUnits:GetByRangeMissedDoTs(MultiDotsRange, 1, A.Garrote.ID, MultiDotsTTD) >= 1 
		    or 
		    Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 and MissingRupture >= 1 and ActivesRupture <= MultiDotsMaxRupture and Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 0
		) 
		and (Unit(unitID):HasDeBuffs(A.Vendetta.ID, true) == 0 and not MultiDotsBurst or MultiDotsBurst) then 
			return A:Show(icon, ACTION_CONST_AUTOTARGET)
		end
		
		-- Stealthed rotation
		if inStealth and Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 then
			if A.MasterAssassin:IsSpellLearned() and Unit(unitID):HasDeBuffs("BreakAble") == 0 then
				if A.Envenom:IsReady(unitID) and A.Envenom:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP >= 4 then
					return A.Envenom:Show(icon)
				end
				
				if A.Mutilate:IsReady(unitID) and A.Mutilate:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP < 4 then
					return A.Mutilate:Show(icon)
				end
			end
			
			if A.Subterfuge:IsSpellLearned() and Unit(unitID):HasDeBuffs("BreakAble") == 0 then
				if A.Garrote:IsReady(unitID) and A.Garrote:AbsentImun(unitID, Temp.AttackTypes) and canCast then
					return A.Garrote:Show(icon)
				end
			end
			
			return 
		end
		
		--Force Kidney
		if forceKidneyF and A.KidneyShot:IsReady("focus") and A.KidneyShot:AbsentImun("focus", Temp.AttackTypes) and (CP >= CP_KIDNEY or
		Unit("focus"):IsCastingRemains() > GetCurrentGCD() + 0.1 and CP >= 1) then --and Unit(unitID):IsControlAble("stun", 0)
			return A.KidneyShotFocus:Show(icon)
		end
		
		if forceKidney and A.KidneyShot:IsReady(unitID) and A.KidneyShot:AbsentImun(unitID, Temp.AttackTypes) and (CP >= CP_KIDNEY or
		Unit(unitID):IsCastingRemains() > GetCurrentGCD() + 0.1 and CP >= 1) then --and Unit(unitID):IsControlAble("stun", 0)
			return A.KidneyShot:Show(icon)
		end

		if A.Garrote:IsReady(unitID) and A.Garrote:AbsentImun(unitID, Temp.AttackTypes) and canCast and Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) > 0 and 
		(A.IronWire:IsSpellLearned() and GetByRange(2, 15) and A.ShroudedSuffocation:GetAzeriteRank() > 0 and Unit(unitID):HasDeBuffs(A.Garrote.ID, true) == 0 or 
		varSingleTarget and CP < CP_MAX and A.ShroudedSuffocation:GetAzeriteRank() == 3) then
			return A.Garrote:Show(icon)
		end
		
		
		--Burst #1
		if BurstIsON(unitID) and canCast and Unit(unitID):TimeToDie() > 5 then
			if A.GuardianofAzeroth:AutoHeartOfAzerothP(unitID) and (A.Vendetta:GetCooldown() == 0 or A.Vendetta:GetCooldown() > 30) and Unit(player):HasBuffs(A.MasterAssassinBuffs.ID) == 0 and 
			(A.ToxicBlade:IsSpellLearned() and 	A.ToxicBlade:GetCooldown() < 5 or not A.ToxicBlade:IsSpellLearned()) then
				return A.GuardianofAzeroth:Show(icon)
			end
			
			if A.Vendetta:IsReady(unitID) and A.Vendetta:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP >= 3 and
			Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 5 and (A.ToxicBlade:IsSpellLearned() and 	A.ToxicBlade:GetCooldown() <= 10 or not A.ToxicBlade:IsSpellLearned()) and 
			(A.MasterAssassin:IsSpellLearned() and (A.Vanish:GetCooldown() == 0 or A.Vanish:GetCooldown() >= 30 or A.Vanish:GetCooldown() <= A.ToxicBlade:GetCooldown()) 
			or not A.MasterAssassin:IsSpellLearned() or not VanishDPS) then
				return A.Vendetta:Show(icon)
			end
			
			if A.WorldveinResonance:AutoHeartOfAzeroth(unitID) and canCast and (A.ToxicBlade:GetCooldown() <= 9 and A.Vendetta:GetCooldown() > 40 or 
			Unit(unitID):HasDeBuffs(A.Vendetta.ID, true) > 0) then
				return A.WorldveinResonance:Show(icon)
			end
			
			if A.BloodoftheEnemy:AutoHeartOfAzerothP(unitID) and (not A.ToxicBlade:IsSpellLearned() or Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0) and 
			Unit(unitID):HasDeBuffs(A.Vendetta.ID, true) > 0 and (A.MasterAssassin:IsSpellLearned() and (A.Vanish:GetCooldown() == 0 or A.Vanish:GetCooldown() > 30) or not 
			A.MasterAssassin:IsSpellLearned() or not VanishDPS) and (not inHoldAoE or Unit(unitID):IsBoss()) then
				return A.BloodoftheEnemy:Show(icon)  
			end

            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unitID, true) and (not inHoldAoE and GetByRange(2, 10) or Unit(unitID):IsBoss()) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
			if A.Vanish:IsReady(player) and not inStealth and VanishDPS and ((A.MasterAssassin:IsSpellLearned() and 
			Unit(player):HasBuffs(A.MasterAssassinBuffs.ID) == 0) and Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Garrote.ID, true) > 0 and 
			Unit(unitID):HasDeBuffs(A.Vendetta.ID, true) > 0 and (not A.ToxicBlade:IsSpellLearned() or Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0) and 
			(not Azerite:EssenceHasMajor(A.BloodoftheEnemy.ID) or Unit(unitID):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true) > 0)) then
				return A.Vanish:Show(icon)
			end
			
			-- Trinkets
			if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unitID, "DamageMagicImun") and not Temp.IsSlotTrinketBlocked[A.Trinket1.ID] and
			Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 then  
				return A.Trinket1:Show(icon)	
			end 
                
			if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unitID, "DamageMagicImun") and not Temp.IsSlotTrinketBlocked[A.Trinket2.ID] and
			Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 then 
				return A.Trinket2:Show(icon)
			end   
		end
		
		--Trinkets
		
		if A.AshvanesRazorCoral:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Garrote.ID, true) > 0 and canCast and not inStealth and 
		-- no RazorCoralDebuff applied
		(
		    Unit(unitID):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0 and Unit(unitID):TimeToDie() > 4 and MultiUnits:GetByRangeAppliedDoTs(nil, 1, A.RazorCoralDebuff.ID) == 0
		)
		or
		-- RazorCoral specific logic on use
		(
		    Unit(unitID):HealthPercent() <= 31 and Unit(unitID):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 10 and Unit(unitID):TimeToDie() > 4
		)
		then
			return A.AshvanesRazorCoral:Show(icon)
		end
		
		
		if A.RemoteGuidanceDevice:IsReady(unitID) and A.RemoteGuidanceDevice:AbsentImun(unitID, "DamageMagicImun") and canCast and not inStealth and 
		(inAoE and GetByRange(minHoldAoE, 10) and inHoldAoE and GetByRangeTTD(minHoldAoE, 10) > 5 or Unit(unitID):IsBoss()) and Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 then
			return A.RemoteGuidanceDevice:Show(icon)
		end
		
		if A.WrithingSegmentofDrestagath:IsReady(unitID) and A.WrithingSegmentofDrestagath:AbsentImun(unitID, "DamageMagicImun") and canCast and not inStealth and 
		(inAoE and GetByRange(minHoldAoE, 10) and inHoldAoE and GetByRangeTTD(minHoldAoE, 10) > 5 or Unit(unitID):IsBoss()) and Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 then
			return A.WrithingSegmentofDrestagath:Show(icon)
		end
		
		if A.ConcentratedFlame:AutoHeartOfAzerothP(unitID) and Unit(unitID):HasDeBuffs(A.ConcentratedFlameDebuff.ID) == 0 and Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 0 and
		canCast and not inStealth then 
            return A.ConcentratedFlame:Show(icon)
        end 
		
		if A.BloodoftheEnemy:AutoHeartOfAzerothP(unitID) and canCast and not inStealth and inAoE and GetByRange(minHoldAoE, 10) and inHoldAoE and 
		(Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 or Unit(player):HasBuffsStacks(A.HiddenBladesBuff.ID, true) >= 19) and GetByRangeTTD(minHoldAoE, 10) > 5 then
			return A.BloodoftheEnemy:Show(icon)  
		end
		
		if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unitID, true) and canCast and not inStealth and inAoE and GetByRange(minHoldAoE, 10) and inHoldAoE and 
		(Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 or Unit(player):HasBuffsStacks(A.HiddenBladesBuff.ID, true) >= 19) and GetByRangeTTD(minHoldAoE, 10) > 5 then
			return A.FocusedAzeriteBeam:Show(icon)
		end
		
		if A.Garrote:IsReady(unitID) and A.Garrote:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP < CP_MAX and 
		(A.MasterAssassin:IsSpellLearned() and not inStealth and Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 0 or Unit(player):HasBuffs(A.MasterAssassinBuffs.ID) == 0) and
		Unit(unitID):HasDeBuffs(A.Garrote.ID, true) <= 5.4 and (CP == 3 and Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Garrote.ID, true) > 1.5 
		or not skipGarrote) and Unit(unitID):TimeToDie() > 4 and (varSingleTarget or Unit(unitID):IsBoss()) then
			return A.Garrote:Show(icon)
		end
				
		if A.Mutilate:IsReady(unitID) and A.Mutilate:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP == 3 and A.ToxicBlade:GetCooldown() <= 5 and varSingleTarget and
		Unit(unitID):HasDeBuffs(A.Rupture.ID, true) <= 6 then
			return A.Mutilate:Show(icon)
		end
		
		-- Finishers
		if A.CrimsonTempest:IsReady(unitID, true) and A.CrimsonTempest:AbsentImun(unitID, Temp.AttackTypes) and inAoE and canCast and InMelee(unitID) and CP >= 4 and GetByRange(2, 10) and 
		(MultiUnits:GetByRangeMissedDoTs(10, 1, A.CrimsonTempest.ID, 4) >= 1 or Unit(unitID):HasDeBuffs(A.CrimsonTempest.ID, true) < 2 and Unit(unitID):TimeToDie() > 4) and
		Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 then
			return A.CrimsonTempest:Show(icon)
		end
		
		if A.Rupture:IsReady(unitID) and A.Rupture:AbsentImun(unitID, Temp.AttackTypes) and inAoE and not skipRupture and not skipCycleRupture and canCast and CP >= 4 and 
		Unit(unitID):HasDeBuffs(A.Rupture.ID, true) <= 6 and Unit(unitID):TimeToDie() > 4 and Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 and 
		(A.MasterAssassin:IsSpellLearned() and not inStealth or not A.MasterAssassin:IsSpellLearned()) then
			return A.Rupture:Show(icon)
		end		
		
		if A.Rupture:IsReady(unitID) and A.Rupture:AbsentImun(unitID, Temp.AttackTypes) and Player:ComboPoints() >= 4 and canCast and not skipRupture and 
		(Unit(unitID):HasDeBuffs(A.Rupture.ID, true) == 0 or (Unit(unitID):HasDeBuffs(A.Rupture.ID, true) <= 6 or (A.ToxicBlade:IsSpellLearned() and 
		Unit(unitID):HasDeBuffs(A.Rupture.ID, true) <= 9 and A.ToxicBlade:GetCooldown() > 0 and A.ToxicBlade:GetCooldown() < 3) or not A.ToxicBlade:IsSpellLearned())) and 
		(Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 or not GetByRange(2, 10)) and Unit(unitID):TimeToDie() > 4 and 
		(A.MasterAssassin:IsSpellLearned() and not inStealth or not A.MasterAssassin:IsSpellLearned()) then
			return A.Rupture:Show(icon)
		end
		
		if A.CrimsonTempest:IsReady(unitID, true) and A.CrimsonTempest:AbsentImun(unitID, Temp.AttackTypes) and inAoE and canCast and InMelee(unitID) and CP >= 4 and 
		GetByRange(CrimsonFinisherTargets, 9) and Unit(player):HasBuffs(A.SubterfugeBuff.ID, true) == 0 then 
			return A.CrimsonTempest:Show(icon)
		end
		
		if A.ArcaneTorrent:IsRacialReady(unitID) and canCast and Player:EnergyPredicted() + 15 < energyPoolBurst and A.ToxicBlade:GetCooldown() <= 3 and CP >= 3 and 
		Unit(unitID):HasDeBuffs(A.Vendetta.ID, true) > 0 then
			return A.ArcaneTorrent:Show(icon)
		end 
		
		if A.ToxicBlade:IsSpellLearned() and canCast and CP >= 3 and Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 0 and Unit(unitID):TimeToDie() > 4 then 
		--(A.Vendetta:GetCooldown() < 5 and BurstIsON(unitID) or not BurstIsON(unitID)) 
			if A.ToxicBlade:GetCooldown() <= 3 and Player:EnergyPredicted() <= energyPoolBurst and varSingleTarget then
				return A.PoolResource:Show(icon)
			else
				if A.ToxicBlade:IsReady(unitID) and A.ToxicBlade:AbsentImun(unitID, Temp.AttackTypes) then
					if Player:EnergyPredicted() < energyPoolBurst and varSingleTarget then					
						return A.PoolResource:Show(icon)
					else
						return A.ToxicBlade:Show(icon)
					end
				end
			end
		end
		
		if A.Envenom:IsReady(unitID) and A.Envenom:AbsentImun(unitID, Temp.AttackTypes) and CP >= 4 and canCast then
			if not varSingleTarget or Unit(unitID):HasDeBuffs(A.ToxicBladeDebuff.ID, true) > 0 or (not A.ToxicBlade:IsSpellLearned() or A.ToxicBlade:GetCooldown() > 3) or
			(Unit(unitID):HasDeBuffs(A.Vendetta.ID, true) > 0 and (not A.ToxicBlade:IsSpellLearned() or A.ToxicBlade:GetCooldown() > 3)) or Player:EnergyPredicted() >= energyPoolBurst or
			(CP == CP_MAX and Unit(unitID):HasDeBuffs(A.Garrote.ID, true) <= 5.4) or Unit(unitID):TimeToDie() <= 4 then
				return A.Envenom:Show(icon)
			else
				return A.PoolResource:Show(icon)
			end
			
		end

		if A.FanofKnives:IsReady(unitID, true) and A.FanofKnives:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and CP < 4 and
		(useFiller and A.EchoingBlades:GetAzeriteRank() > 0 and inAoE and GetByRange(2, 9)) then
			return A.FanofKnives:Show(icon)
		end
		
		if A.FanofKnives:IsReady(unitID, true) and A.FanofKnives:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and CP < 4 and
		(useFiller and (Unit(player):HasBuffsStacks(A.HiddenBladesBuff.ID, true) >= 19 or 
		(inAoE and (GetByRange(4, 9) and A.DoubleDose:GetAzeriteRank() == 0 or GetByRange(5, 9) and A.DoubleDose:GetAzeriteRank() > 0)))) then
			return A.FanofKnives:Show(icon)
		end		
		
		if A.FanofKnives:IsReady(unitID, true) and A.FanofKnives:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and CP < 4 and
		(useFiller and inAoE and MultiUnits:GetByRangeMissedDoTs(10, 1, A.DeadlyPoisonDebuff.ID) >= 1 and GetByRange(2, 9)) then
			return A.FanofKnives:Show(icon)
		end
		
		if A.Mutilate:IsReady(unitID) and A.Mutilate:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP < 4 and useFiller then
			return A.Mutilate:Show(icon)
		end
    end
	
	local function EnemyRotationPvP(unitID)
		--print("Opener Step : " .. burstStunDR)
		local burstTargetHPPvP					= GetToggle(2, "BurstTargetHealthPvP") 
		
		
		if A.Vigor:IsSpellLearned() then
			energyPoolBurst = GetToggle(2, "BurstEnergyVigorPvP")
		else
			energyPoolBurst = GetToggle(2, "BurstEnergyPvP")
		end
		
		
		if Unit(player):HasBuffs("BurstHaste") > 0 then
			energyPoolBurst = 0
		end
		
		-- Stealth with target Enemy
		if A.Stealth:IsReady(player) and not inCombat and canCast and not Player:IsMounted() and not inStealth then
			return A.Stealth:Show(icon)
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
		
		-- Kill Totem
		if Unit(unitID):IsTotem() then
			if A.Envenom:IsReady(unitID) and A.Envenom:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP >= 4 then
				return A.Envenom:Show(icon)
			end
				
			if A.Mutilate:IsReady(unitID) and A.Mutilate:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP < 4 then
				return A.Mutilate:Show(icon)
			end
		end
		
		
		--Force Kidney
		if forceKidneyF and A.KidneyShot:IsReady("focus", true) and A.KidneyShot:AbsentImun("focus", Temp.AttackTypes) and CP >= CP_KIDNEY and Unit(unitID):IsControlAble("stun", 49) then
			return A.KidneyShotFocus:Show(icon)
		end
		
		if forceKidney and A.KidneyShot:IsReady(unitID) and A.KidneyShot:AbsentImun(unitID, Temp.AttackTypes) and CP >= CP_KIDNEY and Unit(unitID):IsControlAble("stun", 49) then
			return A.KidneyShot:Show(icon)
		end
		
		if BurstIsON(unitID) and canCast and (Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 0 or Unit(unitID):TimeToDie() < 10) then--and Unit(unitID):IsPlayer() then
			if A.KidneyShot:IsReady(unitID) and A.KidneyShot:AbsentImun(unitID, Temp.AttackTypes) and CP >= CP_KIDNEY and Unit(unitID):IsControlAble("stun", 0) and 
			(A.ToxicBlade:IsSpellLearned() and A.ToxicBlade:GetCooldown() == 0 or not A.ToxicBlade:IsSpellLearned()) then
				return A.KidneyShot:Show(icon)
			end
			
			if A.MarkedForDeath:IsReady(unitID) and Unit(unitID):HasDeBuffs("Stuned") > 0 and CP < 3 then
				return A.MarkedForDeath:Show(icon)
			end
			
			if A.Vendetta:IsReady(unitID) and A.Vendetta:AbsentImun(unitID, Temp.AttackTypes) and Unit(unitID):HasDeBuffs("Stuned") > 0 and Unit(unitID):HealthPercent() <= 60 then
				return A.Vendetta:Show(icon)
			end
			
			if A.SmokeBomb:IsReady(player, true) and Unit(unitID):HasDeBuffs("Stuned") > 0 and Unit(unitID):HealthPercent() <= 35 then
				return A.SmokeBomb:Show(icon)
			end
			
			if A.ToxicBlade:IsReady(unitID) and A.ToxicBlade:AbsentImun(unitID, Temp.AttackTypes) and A.KidneyShot:GetCooldown() > 15 then
				return A.ToxicBlade:Show(icon)
			end
			
			-- Trinkets
			if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unitID, "DamageMagicImun") and Unit(unitID):HasDeBuffs("Stuned") > 3 then  
				return A.Trinket1:Show(icon)	
			end 
                
			if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unitID, "DamageMagicImun") and Unit(unitID):HasDeBuffs("Stuned") > 3 then 
				return A.Trinket2:Show(icon)
			end   
		end
		
		if A.ConcentratedFlame:AutoHeartOfAzerothP(unitID) and Unit(unitID):HasDeBuffs(A.ConcentratedFlameDebuff.ID) == 0 and 
		(Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 0 or Unit(unitID):TimeToDie() < 10) and canCast and not inStealth then 
            return A.ConcentratedFlame:Show(icon)
        end 
		
		if A.ReapingFlames:AutoHeartOfAzerothP(unitID) and canCast and not inStealth and (Unit(unitID):HasDeBuffs(A.Rupture.ID, true) > 0 or Unit(unitID):TimeToDie() < 10) then
			return A.ReapingFlames:Show(icon)
		end
		
		if A.Garrote:IsReady(unitID) and A.Garrote:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP < CP_CAST and 
		(Unit(unitID):HasDeBuffs(A.Garrote.ID, true) <= GetGCD() + GetCurrentGCD() + GetPing() + (TMW.UPD_INTV or 0) and Unit(unitID):TimeToDie() > 10  or
		inStealth and A.Subterfuge:IsSpellLearned()) then
			return A.Garrote:Show(icon)
		end
		
		if A.Rupture:IsReady(unitID) and A.Rupture:AbsentImun(unitID, Temp.AttackTypes) and CP >= CP_CAST and canCast and 
		Unit(unitID):HasDeBuffs(A.Rupture.ID, true) <= GetGCD() + GetCurrentGCD() + GetPing() + (TMW.UPD_INTV or 0) and Unit(unitID):TimeToDie() > 10 then
			return A.Rupture:Show(icon)
		end
		
		if A.Envenom:IsReady(unitID) and A.Envenom:AbsentImun(unitID, Temp.AttackTypes) and CP >= CP_CAST and canCast then
			return A.Envenom:Show(icon)
		end
		
		if A.Mutilate:IsReady(unitID) and A.Mutilate:AbsentImun(unitID, Temp.AttackTypes) and canCast and CP < CP_CAST then
			return A.Mutilate:Show(icon)
		end
		
		if A.PoisonedKnife:IsReady(unitID) and A.PoisonedKnife:AbsentImun(unitID, Temp.AttackTypes) and canCast and not inStealth and not InMelee(unitID) and inCombat and (CP < CP_CAST or 
		Unit(unitID):GetMaxSpeed() >= 100 and Unit(unitID):HasDeBuffs("Slowed") == 0 and not Unit(unitID):IsTotem()) then
			return A.PoisonedKnife:Show(icon)
		end	
		
	end
	
	-- Stealth out of combat
	-- Need to check for different spellID depending if Subterfuge is learned or not. 
	local CurrentStealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth -- w/ or w/o Subterfuge Talent		
    if not inCombat and Unit(player):HasBuffs(A.Vanish.ID, true) == 0 and StealthOOC and not Unit(player):HasFlags() and not Player:IsMounted() 
	and CurrentStealth:IsReady(player) and Unit(player):HasBuffs(CurrentStealth.ID, true) == 0 then
       	return CurrentStealth:Show(icon)
    end 
		
	-- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    if IsUnitEnemy(target) then 
        unitID = target
        
		if EnemyRotationPvP(unitID) and A.IsInPvP and not Unit(unitID):IsDead() then 
			return true
		end
		
        if EnemyRotationPvE(unitID) and not Unit(unitID):IsDead() and not A.IsInPvP then 
            return true 
        end 
    end 
    
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 


