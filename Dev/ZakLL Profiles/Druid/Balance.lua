local TMW 									= TMW 
local Action 								= Action
local TeamCache 							= Action.TeamCache
local EnemyTeam 							= Action.EnemyTeam
local FriendlyTeam 							= Action.FriendlyTeam
local LoC 									= Action.LossOfControl
local Player 								= Action.Player 
local MultiUnits 							= Action.MultiUnits
local UnitCooldown 							= Action.UnitCooldown
local Unit 									= Action.Unit 

Action[ACTION_CONST_DRUID_BALANCE] 			= {
    -- Racial
    ArcaneTorrent							= Action.Create({ Type = "Spell", ID = 50613}),
    BloodFury								= Action.Create({ Type = "Spell", ID = 20572}),
    Fireblood								= Action.Create({ Type = "Spell", ID = 265221}),
    AncestralCall							= Action.Create({ Type = "Spell", ID = 274738}),
    Berserking								= Action.Create({ Type = "Spell", ID = 26297}),
    ArcanePulse								= Action.Create({ Type = "Spell", ID = 260364}),
    QuakingPalm								= Action.Create({ Type = "Spell", ID = 107079}),
    Haymaker								= Action.Create({ Type = "Spell", ID = 287712}), 
    BullRush								= Action.Create({ Type = "Spell", ID = 255654}),    
    WarStomp								= Action.Create({ Type = "Spell", ID = 20549}),
    GiftofNaaru								= Action.Create({ Type = "Spell", ID = 59544}),
    Shadowmeld								= Action.Create({ Type = "Spell", ID = 58984}), -- usable in Action Core 
    Stoneform								= Action.Create({ Type = "Spell", ID = 20594}), 
    WilloftheForsaken						= Action.Create({ Type = "Spell", ID = 7744}), -- not usable in APL but user can Queue it    
    EscapeArtist							= Action.Create({ Type = "Spell", ID = 20589}), -- not usable in APL but user can Queue it
    EveryManforHimself						= Action.Create({ Type = "Spell", ID = 59752}), -- not usable in APL but user can Queue it
	
	-- Crowd Control
	-- Suppotive 
	AbissalHealing							= Action.Create({ Type = "Potion", ID = 169451}),
	Barkskin								= Action.Create({ Type = "Spell", ID = 22812}),
	Soothe									= Action.Create({ Type = "Spell", ID = 2908}),
	RemoveCorruption						= Action.Create({ Type = "Spell", ID = 2782}),
	Swiftmend								= Action.Create({ Type = "Spell", ID = 18562}), -- Talent 3/3 -- Resto Affinity
	-- Spells
	MoonkinForm								= Action.Create({ Type = "Spell", ID = 24858}),
	Sunfire									= Action.Create({ Type = "Spell", ID = 93402}),
	Moonfire								= Action.Create({ Type = "Spell", ID = 8921}),
	LunarStrike								= Action.Create({ Type = "Spell", ID = 194153}),
	SolarWrath								= Action.Create({ Type = "Spell", ID = 190984}),
	Starsurge								= Action.Create({ Type = "Spell", ID = 78674}),
	CelestialAlignment						= Action.Create({ Type = "Spell", ID = 194223}),
	Starfall								= Action.Create({ Type = "Spell", ID = 191034}),
	
	-- Buffs
	StarlordBuff							= Action.Create({ Type = "Spell", ID = 279709, Hidden = true}),
	ArcanicPulsarBuff						= Action.Create({ Type = "Spell", ID = 287790, Hidden = true}),
	CelestialAlignmentBuff					= Action.Create({ Type = "Spell", ID = 194223, Hidden = true}),
	IncarnationBuff							= Action.Create({ Type = "Spell", ID = 102560, Hidden = true}),
	LunarEmpowermentBuff					= Action.Create({ Type = "Spell", ID = 164547, Hidden = true}),
	SolarEmpowermentBuff					= Action.Create({ Type = "Spell", ID = 164545, Hidden = true}),
	WarriorOfEluneBuff						= Action.Create({ Type = "Spell", ID = 202425, Hidden = true}),
	-- Debuffs
	ShiverVenomDebuff						= Action.Create({ Type = "Spell", ID = 301624}),
	-- Trinkets
	PocketsizedComputationDevice			= Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true}),
	ShiverVenomRelic						= Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
	-- Talents
	NaturesBalance							= Action.Create({ Type = "Spell", ID = 202430, isTalent = true}), -- Talent 1/1
	WarriorOfElune							= Action.Create({ Type = "Spell", ID = 202425, isTalent = true}), -- Talent 1/2
	ForceofNature							= Action.Create({ Type = "Spell", ID = 205636, isTalent = true}), -- Talent 1/3
	Starlord								= Action.Create({ Type = "Spell", ID = 202345, isTalent = true}), -- Talent 5/2
	Incarnation								= Action.Create({ Type = "Spell", ID = 102560, isTalent = true}), -- Talent 5/3
	TwinMoons								= Action.Create({ Type = "Spell", ID = 279620, isTalent = true}), -- Talent 6/2
	StellarFlare							= Action.Create({ Type = "Spell", ID = 202347, isTalent = true}), -- Talent 6/3
	ShootingStars							= Action.Create({ Type = "Spell", ID = 202342, isTalent = true}), -- Talent 7/1
	FuryofElune								= Action.Create({ Type = "Spell", ID = 202770, isTalent = true}), -- Talent 7/2
	NewMoon									= Action.Create({ Type = "Spell", ID = 274281, isTalent = true}), -- Talent 7/3
	HalfMoon								= Action.Create({ Type = "Spell", ID = 274282, isTalent = true}), -- Talent 7/3
	FullMoon								= Action.Create({ Type = "Spell", ID = 274283, isTalent = true}), -- Talent 7/3
	-- Hidden	
	ArcanicPulsar							= Action.Create({ Type = "Spell", ID = 287773, Hidden = true}), -- Simcraft Azerite
	StreakingStars							= Action.Create({ Type = "Spell", ID = 272871, Hidden = true}), -- Simcraft Azerite
	BurstDamage								= Action.Create({ Type = "Spell", ID = 194223, Hidden = true}), -- Simcraft Azerite
	CancelBuff								= Action.Create({ Type = "SpellSingleColor", ID = 209749, Color = "GREEN"}),
}

Action:CreateEssencesFor(ACTION_CONST_DRUID_BALANCE)
local A 									= setmetatable(Action[ACTION_CONST_DRUID_BALANCE], { __index = Action })

-------------------------------------------
-- [[ CONDITIONS ]] 
-------------------------------------------
local player 								= "player"
local targettarget							= "targettarget"
local UnitIsUnit							= UnitIsUnit
local canCast								= false
local Temp 									= {
	AttackTypes 							= {"TotalImun", "DamageMagicImun"},
	AuraForStun								= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC								= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun					= {"CCTotalImun", "StunImun"},
	AuraForDisableMag						= {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	AuraForInterrupt						= {"TotalImun", "DamagePhysImun", "KickImun"},
	OpenerRotation							= false,
	UsedReshift								= false,
	CountReset								= 0,
}

local function IsSchoolNatureUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local function IsSchoolArcaneUP()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "ARCANE") == 0
end 

local function FutureAstralPower()
	local AstralPower = Player:AstralPower()
	local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(player):IsCasting()
        
	if not Unit(player):IsCasting() then
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

function Action:ExecuteTime()
	if self:GetSpellCastTime() > A.GetGCD() + A.GetCurrentGCD() then
		return self:GetSpellCastTime()
	else
		return A.GetGCD() + A.GetCurrentGCD()
	end
end

local BlackListedTrinkets = {
    [1] = 167555, -- Pocket Sized Computation Device
	[2] = 169314, -- Azsharas Font of Power
	[3] = 168905, -- ShiverVenomRelic
}

function TrinketIsAllowed()
    local Trinket1IsAllowed = true
	local Trinket2IsAllowed = true
     
   	    for i = 1, #BlackListedTrinkets do
            if Action.Trinket1.ID == BlackListedTrinkets[i] then
                Trinket1IsAllowed = false				
			end
            if Action.Trinket2.ID == BlackListedTrinkets[i] then
                Trinket2IsAllowed = false					
            end
        end
	return Trinket1IsAllowed, Trinket2IsAllowed
end

local function SelfDefensives()

	local BarkskinSelf = A.GetToggle(2, "BarkskinSelf")	
	if A.Barkskin:IsReady(player) and Unit(player):HealthPercent() <= BarkskinSelf and Unit(player):CombatTime() > 0 then
		return A.Barkskin
	end
	
	local SwiftmendSelf = A.GetToggle(2, "SwiftmendSelf")	
	if A.Swiftmend:IsReady(player) and  Unit(player):HealthPercent() <= SwiftmendSelf then
		return A.Swiftmend
	end
	
	local PotHeal = A.GetToggle(2, "AbyssalPot")
	if A.AbissalHealing:IsReady(player) and  Unit(player):HealthPercent() <= PotHeal and Unit(player):CombatTime() > 0 then
		return A.AbissalHealing
	end
	
end
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

A[3] = function(icon)
	local combatTime							= Unit(player):CombatTime()
	local inCombat 								= combatTime > 0
	local AP									= Player:AstralPower()
	local inStealth								= Player:IsStealthed()
	local inMoving								= Player:IsMoving()
	local inAoE									= A.GetToggle(2, "AoE")
	local isMultiDoT							= A.GetToggle(2, "MultiDot")
	local isMultiDoTRange						= A.GetToggle(2, "MultiDotDistance")
	local SF_Target 							= 4
	local SS_Rank								= 0
	local Trinket1IsAllowed, Trinket2IsAllowed 	= TrinketIsAllowed()
	local TrinketON								= ((Action.GetToggle(1, "Trinkets")[1]) or (Action.GetToggle(1, "Trinkets")[2]))

	--Misc
	if A.Incarnation.IsSpellLearned() then
		A.BurstDamage = A.Incarnation
	else 
		A.BurstDamage = A.CelestialAlignment
	end
	
	SS_Rank = A.StreakingStars:GetAzeriteRank()
	
	if A.ArcanicPulsar:GetAzeriteRank() >= 1 then
		SF_Target = SF_Target + 1
	end
	
	if A.Starlord:IsSpellLearned() then
		SF_Target = SF_Target + 1
	end
	
	if A.StreakingStars:GetAzeriteRank() > 2 and A.ArcanicPulsar:GetAzeriteRank() >= 1 then
		SF_Target = SF_Target + 1
	end
	
	if not A.TwinMoons:IsSpellLearned() then
		SF_Target = SF_Target - 1
	end
	
	if A.MoonkinForm:IsReady(player) and (Player:IsStance(0) or (Player:IsStance(1) and Temp.UsedReshift)) then
		return A.MoonkinForm:Show(icon)
	end
	
	if not inMoving and Player:IsStance(4) and not inStealth then
		canCast = true
	else
		canCast = false
	end
	
	if not A.StellarFlare:IsSpellInCasting() and Temp.CountReset > 0 then
		Temp.CountReset = Temp.CountReset - 1
	end 
	--if combatTime == 0 then
	--	Temp.OpenerRotation = true
	--end
	
	local function Enemy(unitID)		
		-- Purge (high) 
		if unitID ~= "targettarget" and A.Soothe:IsReady(unitID, nil, nil, true) and A.Soothe:AbsentImun(unitID, Temp.AuraForOnlyCCAndStun) and A.AuraIsValid(unitID, "UseExpelEnrage", "Enrage") then 
			return A.Soothe:Show(icon)
		end 
		
		--if A.GetToggle(1, "StopCast") and Unit(unitID):HasDeBuffs(A.StellarFlare.ID, true) > 7.2 and A.StellarFlare:IsSpellInCasting() then
		--	return A:Show(icon, ACTION_CONST_STOPCAST)
		--end
		
		if A.StellarFlare:IsSpellInCasting() and Temp.CountReset == 0 then
			Temp.CountReset = 15
		end
		
		if Unit(unitID):HasDeBuffs(A.Sunfire.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Moonfire.ID, true) > 0 and isMultiDoT and
		(MultiUnits:GetByRangeMissedDoTs(isMultiDoTRange, 1, A.Sunfire.ID, 10) >= 1 or MultiUnits:GetByRangeMissedDoTs(isMultiDoTRange, 1, A.Moonfire.ID, 10) >= 1) and 
		(Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) then
			return A:Show(icon, ACTION_CONST_AUTOTARGET)
		end		
		
		--if Temp.OpenerRotation then
	--		if A.StellarFlare:IsReady(unitID) and IsSchoolArcaneUP() and IsSchoolNatureUP() and A.StellarFlare:AbsentImun(unitID, Temp.AttackTypes) and A.LastPlayerCastName ~= A.StellarFlare:Info() and 
	--		Unit(unitID):HasDeBuffs(A.StellarFlare.ID, true) < 7.2 then
	--			return A.StellarFlare:Show(icon)
	--		end
			
	--		if A.Sunfire:IsReady(unitID) and IsSchoolNatureUP() and A.Sunfire:AbsentImun(unitID, Temp.AttackTypes) and Player:IsStance(4) and Unit(unitID):HasDeBuffs(A.Sunfire.ID, true) < 5.4 then
	--			return A.Sunfire:Show(icon)
	--		end
			
	--		if A.Moonfire:IsReady(unitID) and IsSchoolArcaneUP() and A.Moonfire:AbsentImun(unitID, Temp.AttackTypes) and Player:IsStance(4) and Unit(unitID):HasDeBuffs(A.Moonfire.ID, true) < 6.6 then
	--			return A.Moonfire:Show(icon)
	--		end
			
	--		if Unit(unitID):HasDeBuffs(A.Sunfire.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.Moonfire.ID, true) > 0 and (not A.StellarFlare:IsSpellLearned() or
		--	Unit(unitID):HasDeBuffs(A.StellarFlare.ID, true) > 0) then
	--			Temp.OpenerRotation = false
		--	end
	--	end
		
		--if Temp.OpenerRotation then
		--	return true
	--	end
		
		-- Burst
		if unitID ~= "mouseover" and A.BurstIsON(unitID) then		
			if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unitID, "DamageMagicImun") and Trinket1IsAllowed and 
			(Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0) then 
				return A.Trinket1:Show(icon)
            end 
                
            if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unitID, "DamageMagicImun") and Trinket2IsAllowed and
			(Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0) then 
				return A.Trinket2:Show(icon)
            end			
			
			if A.Berserking:AutoRacial(unitID) and canCast and (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or 
			A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0) then
				return A.Berserking:Show(icon)
			end

			if A.Incarnation:IsReady(player) and (Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0 and (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or 
			((A.MemoryofLucidDreams:GetCooldown() > 20 or not A.MemoryofLucidDreams:IsReady(player)) and AP_Check(A.Incarnation))) and (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or
			AP_Check(A.Incarnation)) and (Unit(unitID):HasDeBuffs(A.Sunfire.ID, true) > 8 and Unit(unitID):HasDeBuffs(A.Moonfire.ID, true) > 12 and (not A.StellarFlare:IsSpellLearned() or 
			Unit(unitID):HasDeBuffs(A.StellarFlare.ID, true) > 6))) then
				return A.Incarnation:Show(icon)
			end

			if A.CelestialAlignment:IsReady(player) and (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 and (not A.Starlord:IsSpellLearned() or
			Unit(player):HasBuffs(A.StarlordBuff.ID, true) > 0) and (Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true) > 0 or ((A.MemoryofLucidDreams:GetCooldown() > 20 or
			not A.MemoryofLucidDreams:IsReady(player)) and AP_Check(A.CelestialAlignment))) and (Unit(unitID):HasDeBuffs(A.Sunfire.ID, true) > 2 and Unit(unitID):HasDeBuffs(A.Moonfire.ID, true) > 0
			and (not A.StellarFlare:IsSpellLearned() or Unit(unitID):HasDeBuffs(A.StellarFlare.ID, true) > 0))) then
				return A.CelestialAlignment:Show(icon)
			end
			
			if A.PocketsizedComputationDevice:IsReady(unitID) and A.PocketsizedComputationDevice:AbsentImun(unitID, "DamageMagicImun") and TrinketON and 
			((Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) and 
			Unit(unitID):HasDeBuffs(A.Moonfire.ID, true) > 6 and Unit(unitID):HasDeBuffs(A.Sunfire.ID, true) > 5 and
			(not A.StellarFlare:IsSpellLearned() or Unit(unitID):HasDeBuffs(A.StellarFlare.ID, true) > 0)) and canCast then
				return A.PocketsizedComputationDevice:Show(icon)
			end
		end
		
		-- Trinket out of burst
		if A.ShiverVenomRelic:IsReady(unitID) and A.ShiverVenomRelic:AbsentImun(unitID, "DamageMagicImun") and TrinketON and 
		((Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) and 
		Unit(player):HasBuffs("BurstHaste") == 0 and (Unit(unitID):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5 or Unit(unitID):TimeToDie() <= 5 and MultiUnits:GetActiveEnemies() >= 3 and
		Unit(unitID):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 3)) then
			return A.ShiverVenomRelic:Show(icon)
		end
		
		-- Essences
		if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unitID) and (inAoE and MultiUnits:GetActiveEnemies() >= 2 or Unit(unitID):IsBoss()) and canCast and
		Unit(player):HasBuffs(A.BurstDamage.ID, true) == 0 then
			return A.FocusedAzeriteBeam:Show(icon)
		end
		
		-- Spenders
		if A.Starlord:IsSpellLearned() and  Unit(player):HasBuffs(A.StarlordBuff.ID, true) < 3 and Unit(player):HasBuffs(A.StarlordBuff.ID, true) > 0 and not AP_Check(A.SolarWrath) then
			return A.CancelBuff:Show(icon)
		end
		
		if A.Starfall:IsReady(unitID, true) and IsSchoolArcaneUP() and IsSchoolNatureUP() and A.Starfall:AbsentImun(unitID, Temp.AttackTypes) and 
		((Unit(player):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 or Unit(player):HasBuffs(A.StarlordBuff.ID, true) >= 8) and (inAoE and MultiUnits:GetActiveEnemies() >= SF_Target) and
		(Unit(unitID):TimeToDie() + 1) * MultiUnits:GetByRangeInCombat(40, 5, 10) > A.Starfall:GetSpellPowerCost() / 2.5) and canCast then
			return A.Starfall:Show(icon)
		end

		if A.Starsurge:IsReady(unitID) and IsSchoolArcaneUP() and A.Starsurge:AbsentImun(unitID, Temp.AttackTypes) and Player:IsStance(4) and
		((A.Starlord:IsSpellLearned() and (Unit(player):HasBuffsStacks(A.StarlordBuff.ID, true) < 3 or Unit(player):HasBuffs(A.StarlordBuff.ID, true) >= 5 and
		Unit(player):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) < 8) or not A.Starlord:IsSpellLearned() and (Unit(player):HasBuffsStacks(A.ArcanicPulsarBuff.ID, true) < 8 or
		Unit(player):HasBuffs(A.BurstDamage.ID, true) > 0)) and (inAoE and MultiUnits:GetActiveEnemies() < SF_Target or not inAoE) and 
		Unit(player):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) + Unit(player):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 4 and 
		Unit(player):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 3 and Unit(player):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) < 3 and 
		(SS_Rank == 0 or Unit(player):HasBuffs(A.BurstDamage.ID, true) == 0 or A.LastPlayerCastName ~= A.Starsurge:Info()) or 
		Unit(unitID):TimeToDie() <= A.Starsurge:ExecuteTime() * FutureAstralPower() / 40 or not AP_Check(A.SolarWrath)) then
			return A.Starsurge:Show(icon)
		end
		
		--Misc
		if A.ForceofNature:IsReady(unitID, true) and ((SS_Rank >= 1 and (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and 
		Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) or SS_Rank == 0 and ((Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or A.Incarnation:IsSpellLearned() and 
		Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0) or (A.CelestialAlignment:GetCooldown() > 30 and not A.Incarnation:IsSpellLearned() or A.Incarnation:GetCooldown() > 30))) and 
		AP_Check(A.ForceofNature)) and canCast then
			return A.ForceofNature:Show(icon) 
		end
		
		if A.FuryofElune:IsReady(unitID) and AP_Check(A.SolarWrath) and (inAoE and MultiUnits:GetActiveEnemies() >= 2 or Unit(unitID):IsBoss()) then
			return A.FuryofElune:Show(icon)
		end
		
		-- DoTs 
		if A.Sunfire:IsReady(unitID) and IsSchoolNatureUP() and A.Sunfire:AbsentImun(unitID, Temp.AttackTypes) and Player:IsStance(4) and (AP_Check(A.Sunfire) and 
		Unit(unitID):HasDeBuffs(A.Sunfire.ID, true) < 5.4 and (SS_Rank == 0 or (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or
		A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) or A.LastPlayerCastID ~= A.Sunfire.ID) and 
		((Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) >= 10 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) >= 10) or
		(Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0))) then
			return A.Sunfire:Show(icon)
		end
		
		if A.Moonfire:IsReady(unitID) and IsSchoolArcaneUP() and A.Moonfire:AbsentImun(unitID, Temp.AttackTypes) and Player:IsStance(4) and (AP_Check(A.Moonfire) and 
		Unit(unitID):HasDeBuffs(A.Moonfire.ID, true) < 6.6 and (SS_Rank == 0 or (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or
		A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) or A.LastPlayerCastID ~= A.Moonfire.ID) and 
		((Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) >= 10 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) >= 10) or
		(Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0))) then
			return A.Moonfire:Show(icon)
		end
		
		if A.StellarFlare:IsReady(unitID) and IsSchoolArcaneUP() and IsSchoolNatureUP() and A.StellarFlare:AbsentImun(unitID, Temp.AttackTypes) and 
		A.LastPlayerCastName ~= A.StellarFlare:Info() and Temp.CountReset == 0 and 
		(Unit(unitID):HasDeBuffs(A.StellarFlare.ID, true) < 6.4 and (SS_Rank == 0 or (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or
		A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) or A.LastPlayerCastID ~= A.StellarFlare.ID) and 
		((Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) >= 10 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) >= 10) or
		(Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0))) and 
		canCast and Player:IsStance(4) then
			return A.StellarFlare:Show(icon)
		end
		
		-- Generators
		if A.LunarStrike:IsReady(unitID) and IsSchoolArcaneUP() and A.LunarStrike:AbsentImun(unitID, Temp.AttackTypes) and 
		(Unit(player):HasBuffsStacks(A.SolarEmpowermentBuff.ID, true) < 3 and (AP_Check(A.LunarStrike) or Unit(player):HasBuffsStacks(A.LunarEmpowermentBuff.ID, true) == 3) and 
		((Unit(player):HasBuffs(A.WarriorOfEluneBuff.ID, true) > 0 or Unit(player):HasBuffs(A.LunarEmpowermentBuff.ID, true) > 0 or MultiUnits:GetActiveEnemies() >= 2 and 
		Unit(player):HasBuffs(A.SolarEmpowermentBuff.ID, true) == 0) and (SS_Rank == 0 or (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and 
		Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0)) or SS_Rank >= 1 and (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) > 0 or A.Incarnation:IsSpellLearned() and 
		Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0) and A.LastPlayerCastID == A.SolarWrath.ID)) and canCast then
			return A.LunarStrike:Show(icon)
		end
		
		if A.SolarWrath:IsReady(unitID) and IsSchoolNatureUP() and A.SolarWrath:AbsentImun(unitID, Temp.AttackTypes) and 
		(SS_Rank < 3 or (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) or 
		A.LastPlayerCastID ~= A.SolarWrath.ID) and canCast then
			return A.SolarWrath:Show(icon)
		end
		
		--Move
		if A.Sunfire:IsReady(unitID) and IsSchoolNatureUP() and A.Sunfire:AbsentImun(unitID, Temp.AttackTypes) and Player:IsMovingTime() > 0.2 and Player:IsStance(4) then
			return A.Sunfire:Show(icon)
		end
		
		--if A.Moonfire:IsReady(unitID) and IsSchoolArcaneUP() and A.Moonfire:AbsentImun(unitID, Temp.AttackTypes) and inMoving and Player:IsStance(4) and 
		--(SS_Rank == 0 or (Unit(player):HasBuffs(A.CelestialAlignmentBuff.ID, true) == 0 or A.Incarnation:IsSpellLearned() and Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0) or 
		--A.LastPlayerCastID ~= A.Moonfire.ID) then
		--	return A.Moonfire:Show(icon)
		--end
	end
	
	local function FriendlyRotation(unitID)
		-- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end    
		
		-- Supportive
        if A.RemoveCorruption:IsReady(unitID) and A.RemoveCorruption:AbsentImun(unitID) and A.AuraIsValid(unitID, "UseDispel", "Dispel") then 
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
        unitID = "mouseover"    
        
        if FriendlyRotation(unitID) then 
            return true 
        end             
    end 
	
	if A.IsUnitEnemy("target") and not Unit("target"):IsDead() then 
		unitID = "target"
        
		if Enemy(unitID) then 
			return true 
		end 
	end
end