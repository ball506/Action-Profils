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

Action[ACTION_CONST_DRUID_FERAL] 			= {
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
	
	CastBarsInterrupt						= Action.Create({ Type = "Spell",ID = 106839, Desc = "[CastBars] Interrupt", QueueForbidden = true, BlockForbidden = true	}), 	-- Kick 
	
	-- Suppotive 
	AbissalHealing							= Action.Create({ Type = "Potion", ID = 169451}),
	Regrowth								= Action.Create({ Type = "Spell", ID = 8936}),
	Soothe									= Action.Create({ Type = "Spell", ID = 2908}),
	RemoveCorruption						= Action.Create({ Type = "Spell", ID = 2782}),
	-- Spells
	CatForm									= Action.Create({ Type = "Spell", ID = 768}),
	BearForm								= Action.Create({ Type = "Spell", ID = 5487}),
	TravelForm								= Action.Create({ Type = "Spell", ID = 783}),
    Prowl									= Action.Create({ Type = "Spell", ID = 5215}),
    Berserk									= Action.Create({ Type = "Spell", ID = 106951}),
	Rake									= Action.Create({ Type = "Spell", ID = 1822}),
	ThrashCat								= Action.Create({ Type = "Spell", ID = 106830}),
	SwipeCat								= Action.Create({ Type = "Spell", ID = 106785}),
	MoonfireCat								= Action.Create({ Type = "Spell", ID = 155625}),
	Shred									= Action.Create({ Type = "Spell", ID = 5221}),
	Rip										= Action.Create({ Type = "Spell", ID = 1079}),
	TigersFury								= Action.Create({ Type = "Spell", ID = 5217}),
	FerociousBite							= Action.Create({ Type = "Spell", ID = 22568}),
	-- Buffs
	PredatorySwiftnessBuff					= Action.Create({ Type = "Spell", ID = 69369, Hidden = true}),
	BloodtalonsBuff							= Action.Create({ Type = "Spell", ID = 145152, Hidden = true}),
	ScentofBloodBuff						= Action.Create({ Type = "Spell", ID = 285646, Hidden = true}),
	TigersFuryBuff							= Action.Create({ Type = "Spell", ID = 5217, Hidden = true}),
	IncarnationBuff							= Action.Create({ Type = "Spell", ID = 102543, Hidden = true}),
	BerserkBuff								= Action.Create({ Type = "Spell", ID = 106951, Hidden = true}),
	ClearcastingBuff						= Action.Create({ Type = "Spell", ID = 135700, Hidden = true}),
	ProwlBuff								= Action.Create({ Type = "Spell", ID = 5215, Hidden = true}),
	-- Debuffs
	RakeDebuff								= Action.Create({ Type = "Spell", ID = 155722, Hidden = true}),
	ThrashCatDebuff							= Action.Create({ Type = "Spell", ID = 106830, Hidden = true}),
	MoonfireCatDebuff						= Action.Create({ Type = "Spell", ID = 155625, Hidden = true}),
	RipDebuff								= Action.Create({ Type = "Spell", ID = 1079, Hidden = true}),
	ConcentratedFlameDebuff					= Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
	--Talents
	Sabertooth								= Action.Create({ Type = "Spell", ID = 202031, isTalent = true}), -- Talent 1/2
	LunarInspiration						= Action.Create({ Type = "Spell", ID = 155580, isTalent = true}), -- Talent 1/3
	WildCharge								= Action.Create({ Type = "Spell", ID = 102401, isTalent = true}), -- Talent 2/3
	BalanceAffinity							= Action.Create({ Type = "Spell", ID = 197488, isTalent = true}), -- Talent 3/1
	MightyBash								= Action.Create({ Type = "Spell", ID = 5211, isTalent = true}), -- Talent 4/1
	Typhoon									= Action.Create({ Type = "Spell", ID = 132469, isTalent = true}), -- Talent 4/3
	ScentofBlood							= Action.Create({ Type = "Spell", ID = 285564, isTalent = true}), -- Talent 6/1
	BrutalSlash								= Action.Create({ Type = "Spell", ID = 202028, isTalent = true}), -- Talent 6/2
	PrimalWrath								= Action.Create({ Type = "Spell", ID = 285381, isTalent = true}), -- Talent 6/3
	Bloodtalons								= Action.Create({ Type = "Spell", ID = 155672, isTalent = true}), -- Talent 7/2
	FeralFrenzy								= Action.Create({ Type = "Spell", ID = 274837, isTalent = true}), -- Talent 7/3
	Thorns									= Action.Create({ Type = "Spell", ID = 236696, isTalent = true}), -- PvP Talent
	--Hidden
	RepeatPerformanceDebuff					= Action.Create({ Type = "Spell", ID = 301244, Hidden = true}), -- Queens Court - Repeat Performance debuff
	WildChargeCat							= Action.Create({ Type = "Spell", ID = 49376, Hidden = true}),	
	WildFleshRending						= Action.Create({ Type = "Spell", ID = 279527, Hidden = true}), -- Simcraft Azerite
	Channeling								= Action.Create({ Type = "Spell", ID = 209274, Hidden = true}),	
}
Action:CreateEssencesFor(ACTION_CONST_DRUID_FERAL)
local A 									= setmetatable(Action[ACTION_CONST_DRUID_FERAL], { __index = Action })

-------------------------------------------
-- [[ CONDITIONS ]] 
-------------------------------------------
local player 								= "player"
local targettarget							= "targettarget"
local UnitIsUnit							= UnitIsUnit
local Temp 									= {
	AttackTypes 							= {"TotalImun", "DamagePhysImun"},	
	AuraForStun								= {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},	
	AuraForCC								= {"TotalImun", "DamagePhysImun", "CCTotalImun"},
	AuraForOnlyCCAndStun					= {"CCTotalImun", "StunImun"},
	OpenerRotation							= false,
	UsedReshift								= false
}

A.Listener:Add("ACTION_EVENT_DRUID", "PLAYER_REGEN_ENABLED", function() 	
	Temp.OpenerRotation = true
end)

local function InMelee(unitID)
	-- @return boolean 
	return A.Shred:IsInRange(unitID)
end 

function Action:IsEnoughEnergy(energy, saveEnergy)
    -- @return boolean 
    -- Note: Returns true if we can safe use spell to leave enough energy for interrupt or CC 
    return not saveEnergy or energy >= self:GetSpellPowerCost() + saveEnergy
end 

function Action:IsEnoughEnergyPool(Offset)
	return (Player:EnergyPredicted() >= (self:GetSpellPowerCost() + ( Offset and Offset or 0 ) ) )
end

-- [Cast Bars]
function Action.Main_CastBars(unitID, list) 
	-- IsReadyM here just to skip gcd and block checks
	if A.IsInitialized and A.Zone == "pvp" and A.CastBarsInterrupt:IsReadyM(unitID) and A.InterruptIsValid(unitID, list) and A.CastBarsInterrupt:AbsentImun(unitID, Temp.AuraForInterrupt) then  
		return true 		
	end 
end



local function SelfDefensives()
	if Unit(player):CombatTime() == 0 then 
        return 
    end
	
	local RegrowthOffensive = A.GetToggle(2, "RegrowthOffensive")
	local RegrowthDefensive = A.GetToggle(2, "RegrowthDefensive")
	
	if RegrowthDefensive >= 0 and A.Regrowth:IsReady(player) and 
	(not A.Bloodtalons:IsSpellLearned() or not RegrowthOffensive) and Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) > 0 and
	(
        (     -- Auto 
            RegrowthDefensive >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            )
        ) or 
        (    -- Custom
            RegrowthDefensive < 100 and 
            Unit(player):HealthPercent() <= RegrowthDefensive
        )
    ) 
    then 
        return A.Regrowth
    end 
	
end
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- [3] Single Rotation
A[3] = function(icon)
	-- Player
	local energy 		  			= Player:Energy()
	local inAoE						= A.GetToggle(2, "AoE")
	local inAoERanged				= 8 + (A.BalanceAffinity:IsSpellLearned() and 3 or 0) 
	local combatTime				= Unit(player):CombatTime()
	local inCombat 					= combatTime > 0
	local inStealth					= Player:IsStealthed()
	local refreshTime				= (A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER) * 2
	local openerDistance			= A.GetToggle(2, "OpenerSpellsDistance") 
	local prowlDistance				= A.GetToggle(2, "ProwlDistance")
	local canCast
	
	if (Player:IsCasting() or Player:IsChanneling()) and Unit(player):HasBuffs(A.TravelForm.ID, true) == 0 then
		canCast = false
	else 
		canCast = true
	end
	
	if A.BearForm:IsReady(player) and Unit(player):HasDeBuffs("Rooted") > A.GetGCD() + A.GetCurrentGCD() and not Temp.UsedReshift then
		Temp.UsedReshift = true
		return A.BearForm:Show(icon)
	end 
	
	if A.CatForm:IsReady(player) and Temp.UsedReshift then 
		return A.CatForm:Show(icon)
	end
	
	if A.LastPlayerCastID == A.CatForm.ID and Temp.UsedReshift then
		Temp.UsedReshift = false
	end
	
	if combatTime == 0 then
		Temp.OpenerRotation = true
	end
	
--	if Unit("player"):HealthPercent() < 50 then
	--	return A.AbissalHealing:Show(icon)
	--end
	
	local function Enemy(unitID)
		
		-- Purge (high) 
		if unitID ~= "targettarget" and A.Soothe:IsReady(unitID, nil, nil, true) and A.Soothe:AbsentImun(unitID, Temp.AuraForOnlyCCAndStun) and A.AuraIsValid(unitID, "UseExpelEnrage", "Enrage") then 
			return A.Soothe:Show(icon)
		end 
		
		--Misc		
		--Cat form if bug regrowth
		if not Temp.OpenerRotation and InMelee(unitID) and (A.Regrowth:IsSpellInCasting() or (Unit(player):HasBuffs(A.TravelForm.ID, true) == 0 and Unit(player):HasBuffs(A.BearForm.ID, true) == 0) and
		Unit(player):HasBuffs(A.CatForm.ID, true) == 0) then
			return A.CatForm:Show(icon)
		end
		
		
		if A.Prowl:IsReady(player) and not inCombat and canCast and not Player:IsMounted() and Unit(player):HasBuffs(A.TravelForm.ID, true) == 0 and Unit(player):HasBuffs(A.ProwlBuff.ID, true) == 0 and 
		Unit(unitID):GetRange() <= prowlDistance then
			return A.Prowl:Show(icon)
		end
		
		if Unit(unitID):IsExplosives() then
			if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unitID, Temp.AttackTypes) and canCast then
				return A.Rake:Show(icon)
			end

		end
		
	--	if A.Bloodtalons:IsSpellLearned() and (A.TigersFury:GetCooldown() < Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true)) and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) > 0 and 
	--	Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) < 4 and not Temp.OpenerRotation and (Unit(player):HasBuffs("BurstHaste") == 0 and Unit(player):HasBuffs(A.BerserkBuff.ID, true) == 0) then
	--		canCast = false
			
		--	if A.FerociousBite:IsReady(unitID) and A.FerociousBite:AbsentImun(unitID, Temp.AttackTypes) and energy >= 50 and Player:ComboPoints() == Player:ComboPointsMax() then
	--			return A.FerociousBite:Show(icon) 
		--	end
			
		--	return A.TigersFury:Show(icon)
	--	end
		if A.TigersFury:IsReady(player) and InMelee(unitID) and canCast and not Temp.OpenerRotation and Player:EnergyDeficitPredicted() >= 60 then -- and (not A.Bloodtalons:IsSpellLearned() or 
		--Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) < 8) then
		--if A.TigersFury:IsReady(player) and InMelee(unitID) and canCast and not Temp.OpenerRotation and (Player:EnergyDeficitPredicted() >= 60 and not A.Bloodtalons:IsSpellLearned() or 
		--Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) > 0) then
			--if Player:ComboPoints() == Player:ComboPointsMax() then
			--	if energy < 40 then
			--		return A.TigersFury:Show(icon)
			--	end
				
			--	if A.PrimalWrath:IsReady(unitID, true) and InMelee(unitID) and A.PrimalWrath:AbsentImun(unitID, Temp.AttackTypes) and inAoE and MultiUnits:GetByRange(inAoERanged, 3) > 2 then
			--		return A.PrimalWrath:Show(icon)
		--		end
				
		--		if A.FerociousBite:IsReady(unitID) and A.FerociousBite:AbsentImun(unitID, Temp.AttackTypes) and energy >= 50 then
		--			return A.FerociousBite:Show(icon) 
		--		end
		--	end
			
		
			return A.TigersFury:Show(icon)
		end	
			
		--Bursts CDS
		if unitID ~= "mouseover" and A.BurstIsON(unitID) and InMelee(unitID) and not Temp.OpenerRotation and Unit(player):HasBuffs(A.CatForm.ID, true) > 0 then
			if A.Berserk:IsReady(player) and (energy >= 30 and (A.TigersFury:GetCooldown() > 5 or Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0)) and not inStealth then
				return A.Berserk:Show(icon) 
			end
			
			if A.Berserking:AutoRacial(unitID) and (A.TigersFury:GetCooldown() > 5 or Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0)	and not inStealth and Unit(player):HasBuffs("BurstHaste") == 0 and 
			Unit(player):HasBuffs(A.BerserkBuff.ID, true) == 0 then 
				return A.Berserking:Show(icon)
			end 
			
			if A.FeralFrenzy:IsReady(unitID) and canCast and (Player:ComboPoints() == 0) and not inStealth then 
				return A.FeralFrenzy:Show(icon) 
			end
			
			if A.GuardianofAzeroth:AutoHeartOfAzerothP(unitID) and canCast and Unit(unitID):HasDeBuffs(A.RipDebuff.ID) > 0 and Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 then 
                return A.GuardianofAzeroth:Show(icon)
            end
			
			-- Trinkets
            if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and A.Trinket1:AbsentImun(unitID, "DamageMagicImun") and Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 then 
				return A.Trinket1:Show(icon)
            end 
                
            if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and A.Trinket2:AbsentImun(unitID, "DamageMagicImun") and Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 then 
				return A.Trinket2:Show(icon)
            end 
		end
		
		--Opener
		if Temp.OpenerRotation and Unit(unitID):GetRange() <= openerDistance then 
			if A.Berserk:IsReady(player) and A.BurstIsON(unitID) and not A.IsInPvP then
				return A.Berserk:Show(icon) 
			end
			
			if A.TigersFury:IsReady(player) then
				return A.TigersFury:Show(icon)
			end
			
			if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unitID, Temp.AttackTypes) and (Unit(player):HasBuffs(A.ProwlBuff.ID, true) > 0 or Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) == 0) then
				return A.Rake:Show(icon)
			end
			
			if A.PrimalWrath:IsReady(unitID, true) and InMelee(unitID) and A.PrimalWrath:AbsentImun(unitID, Temp.AttackTypes) and inAoE and MultiUnits:GetByRange(inAoERanged, 2) > 1 and 
			Unit(unitID):HasDeBuffs(A.RipDebuff.ID) == 0 then
				return A.PrimalWrath:Show(icon)
			end
			
			if A.Rip:IsReady(unitID) and A.Rip:AbsentImun(unitID, Temp.AttackTypes) and Unit(unitID):HasDeBuffs(A.RipDebuff.ID) == 0 and ((inAoe and MultiUnits:GetByRange(inAoERanged, 2) < 2) or not inAoe) then
				return A.Rip:Show(icon)
			end
			
			if A.ThrashCat:IsReady(unitID, true) and A.ThrashCat:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and A.WildFleshRending:GetAzeriteRank() >= 1 and Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) == 0 then
				return A.ThrashCat:Show(icon) 
			end
			
			if Unit(unitID):HasDeBuffs(A.RipDebuff.ID) > 0 and (A.WildFleshRending:GetAzeriteRank() == 0 or Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) > 0) then 
				Temp.OpenerRotation = false
			end
		
			return 
		end
		
		--Finishers
		if Player:ComboPoints() == Player:ComboPointsMax() then
		
			if A.Regrowth:IsReady(player) and A.LastPlayerCastName ~= A.Regrowth:Info() and not inStealth and canCast and (A.Bloodtalons:IsSpellLearned() and 
			Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) > 0 and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0) then
				return A.Regrowth:Show(icon)
			end
		
			if A.PrimalWrath:IsReady(unitID, true) and InMelee(unitID) and A.PrimalWrath:AbsentImun(unitID, Temp.AttackTypes) and canCast and 
			inAoE and MultiUnits:GetByRange(inAoERanged, 2) > 1 and Unit(unitID):HasDeBuffs(A.RipDebuff.ID) < 4 then
				return A.PrimalWrath:Show(icon)
			end
			
			if A.PrimalWrath:IsReady(unitID, true) and InMelee(unitID) and A.PrimalWrath:AbsentImun(unitID, Temp.AttackTypes) and canCast and 
			inAoE and MultiUnits:GetByRange(inAoERanged, 3) > 2 then
				return A.PrimalWrath:Show(icon)
			end
		
			if A.Rip:IsReady(unitID) and A.Rip:AbsentImun(unitID, Temp.AttackTypes) and canCast and (Unit(unitID):HasDeBuffs(A.RipDebuff.ID) == 0 or 
			(Unit(unitID):HasDeBuffs(A.RipDebuff.ID) <= refreshTime) and (not A.Sabertooth:IsSpellLearned()) or (Unit(unitID):HasDeBuffs(A.RipDebuff.ID) <= refreshTime and 
			A.Persistent_PMultiplier(A.Rip.ID) > A.PMultiplier(unitID, A.Rip.ID)) and Unit(unitID):TimeToDie() > 8) and (inAoe and MultiUnits:GetByRange(inAoERanged, 6) < 6 or not inAoe) then
				return A.Rip:Show(icon)
			end
			
			if A.FerociousBite:IsReady(unitID) and A.FerociousBite:AbsentImun(unitID, Temp.AttackTypes) and canCast then
				if Unit(player):HasBuffs(A.IncarnationBuff.ID, true) > 0 or Unit(player):HasBuffs(A.BerserkBuff.ID, true) > 0 then
					return A.FerociousBite:Show(icon)
				else if energy >= 50 then
					return A.FerociousBite:Show(icon) end
				end
			end	 	
		end
		
		-- Essences
		if A.ConcentratedFlame:AutoHeartOfAzerothP(unitID) and (Unit(unitID):HasDeBuffs(A.ConcentratedFlameDebuff.ID) == 0) and (inCombat and Unit(unitID):CombatTime() > 0) and
		(Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) > 0 or A.WildFleshRending:GetAzeriteRank() == 0) and Unit(unitID):HasDeBuffs(A.RipDebuff.ID) > 0 and Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) > 0 and 
		Unit(player):HasBuffs(A.BerserkBuff.ID, true) == 0 then 
            return A.ConcentratedFlame:Show(icon)
        end 
		
		if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unitID) and MultiUnits:GetByRange(10, 2) >= 2 then 
			return A.FocusedAzeriteBeam:Show(icon)
        end 
		
		--Generators
		if Player:ComboPoints() < Player:ComboPointsMax() then
			--regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
			if A.Regrowth:IsReady(player) and A.LastPlayerCastName ~= A.Regrowth:Info() and canCast and (A.Bloodtalons:IsSpellLearned() and 
			Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) > 0 and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 and Player:ComboPoints() == 4 and 
			Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) < 4) and (A.TigersFury:GetCooldown() > 5 or energy >= 50 and A.TigersFury:IsReady(player)) then
				return A.Regrowth:Show(icon)
			end	
			
			--/regrowth,if=talent.bloodtalons.enabled&buff.bloodtalons.down&buff.predatory_swiftness.up&talent.lunar_inspiration.enabled&dot.rake.remains<1
			if A.Regrowth:IsReady(player) and A.LastPlayerCastName ~= A.Regrowth:Info() and canCast and (A.Bloodtalons:IsSpellLearned() and 
			Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) > 0 and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 and Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) < 1 and 
			A.LunarInspiration:IsSpellLearned()) then
				return A.Regrowth:Show(icon) 
			end
			
			--Brutal Slash AoE >= 2 
			if A.BrutalSlash:IsReady(unitID, true) and A.BrutalSlash:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and A.BrutalSlash:IsSpellLearned() and canCast and (inAoE and MultiUnits:GetByRange(inAoERanged, 2) > 1) and 
			(A.WildFleshRending:GetAzeriteRank() >= 1 and Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) > refreshTime or A.WildFleshRending:GetAzeriteRank() == 0) then 
				return A.BrutalSlash:Show(icon) 
			end
			
			--thrash_cat,if=(refreshable)&(spell_targets.thrash_cat>2)
			if A.ThrashCat:IsReady(unitID, true) and A.ThrashCat:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and (Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) < refreshTime) and
			(inAoE and MultiUnits:GetByRange(inAoERanged, 3) > 2) then 
				return A.ThrashCat:Show(icon) 
			end
			
			--thrash_cat,if=(talent.scent_of_blood.enabled&buff.scent_of_blood.down)&spell_targets.thrash_cat>3
			if A.ThrashCat:IsReady(unitID, true) and A.ThrashCat:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and (A.ScentofBlood:IsSpellLearned() 
			and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0) and (inAoE and MultiUnits:GetByRange(inAoERanged, 4) > 3) then 
				return A.ThrashCat:Show(icon) 
			end
			
			--swipe_cat,if=buff.scent_of_blood.up|
			if A.SwipeCat:IsReady(unitID, true) and A.SwipeCat:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and not A.BrutalSlash:IsSpellLearned() and (Unit(player):HasBuffs(A.ScentofBloodBuff.ID, true) > 0) then
				return A.SwipeCat:Show(icon) 
			end
			
			--Rake if not A.Bloodtalons:IsSpellLearned()
			if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unitID, Temp.AttackTypes) and canCast and A.LastPlayerCastName ~= A.Rake:Info() and (not A.Bloodtalons:IsSpellLearned() and 
			Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) < 4 and Unit(unitID):TimeToDie() > 4) and (inAoe and MultiUnits:GetByRange(inAoERanged, 6) < 6 or not inAoe) then
				return A.Rake:Show(icon)
			end
			
			--Rake A.Bloodtalons:IsSpellLearned()
		--	if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unitID, Temp.AttackTypes) and canCast and A.LastPlayerCastName ~= A.Rake:Info() and (A.Bloodtalons:IsSpellLearned() and 
			--Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) > 0 and ((Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) < 4 and A.Persistent_PMultiplier(A.Rake.ID) > A.PMultiplier(unitID, A.Rake.ID) and A.TigersFury:GetCooldown() > 6) or
		--	(Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) < 4 and A.Persistent_PMultiplier(A.Rake.ID) > A.PMultiplier(unitID, A.Rake.ID) and Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0)) and
			--Unit(unitID):TimeToDie() > 4) and (inAoe and MultiUnits:GetByRange(inAoERanged, 6) < 6 or not inAoe) then
		--		return A.Rake:Show(icon)
			--end
			if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unitID, Temp.AttackTypes) and canCast and A.LastPlayerCastName ~= A.Rake:Info() and (A.Bloodtalons:IsSpellLearned() and 
			Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) > 0 and (Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) < 4 and A.Persistent_PMultiplier(A.Rake.ID) > A.PMultiplier(unitID, A.Rake.ID) * 0.85 ) and
			Unit(unitID):TimeToDie() > 4) and (inAoe and MultiUnits:GetByRange(inAoERanged, 6) < 6 or not inAoe) then
				return A.Rake:Show(icon)
			end
			
			--moonfire_cat,if=buff.bloodtalons.up&buff.predatory_swiftness.down&combo_points<5
			if A.MoonfireCat:IsReady(unitID) and A.MoonfireCat:AbsentImun(unitID, Temp.AttackTypes) and canCast and A.LunarInspiration:IsSpellLearned() and (Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) > 0 and 
			Unit(player):HasBuffs(A.PredatorySwiftnessBuff.ID, true) == 0) then
				return A.MoonfireCat:Show(icon) 
			end
			
			if A.BrutalSlash:IsReady(unitID, true) and A.BrutalSlash:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and A.BrutalSlash:IsSpellLearned() and canCast and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 and 
			Unit(player):HasBuffs(A.BerserkBuff.ID, true) == 0 and (A.WildFleshRending:GetAzeriteRank() >= 1 and Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) > refreshTime or A.WildFleshRending:GetAzeriteRank() == 0) and 
			(Player:ComboPoints() == 4 or A.BrutalSlash:GetSpellCharges() > 1 or A.BrutalSlash:GetSpellChargesFullRechargeTime() < 19) and Unit(player):HasBuffs(A.ClearcastingBuff.ID, true) == 0 then
				return A.BrutalSlash:Show(icon) 
			end
			
			--if A.BrutalSlash:IsReady(unitID, true) and A.BrutalSlash:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and A.BrutalSlash:IsSpellLearned() and canCast and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 and 
			--(Unit(player):HasBuffs(A.TigersFuryBuff.ID, true) > 0 and (10000000000 > (1 + A.BrutalSlash:GetSpellChargesMax() - A.BrutalSlash:GetSpellChargesFrac()) * A.BrutalSlash:GetSpellChargesFullRechargeTime())) and 
			--Unit(player):HasBuffs(A.BerserkBuff.ID, true) == 0 and (A.WildFleshRending:GetAzeriteRank() >= 1 and Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) > 0 or
		--	A.WildFleshRending:GetAzeriteRank() == 0) then
			--	return A.BrutalSlash:Show(icon) 
		--	end
			
			--moonfire_cat,target_if=refreshable
			if A.MoonfireCat:IsReady(unitID) and A.MoonfireCat:AbsentImun(unitID, Temp.AttackTypes) and canCast and A.LunarInspiration:IsSpellLearned() and Unit(unitID):HasDeBuffs(A.MoonfireCatDebuff.ID) < refreshTime then
				return A.MoonfireCat:Show(icon) 
			end	
			
			--thrash_cat,if=refreshable&((variable.use_thrash=2&(!buff.incarnation.up|azerite.wild_fleshrending.enabled))|spell_targets.thrash_cat>1)
			if A.ThrashCat:IsReady(unitID, true) and A.ThrashCat:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 and
			(Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) < 4 and ((Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0 or A.WildFleshRending:GetAzeriteRank() >= 1) or (inAoE and MultiUnits:GetByRange(inAoERanged, 2) > 1))) then 
				return A.ThrashCat:Show(icon) 
			end
			
			--thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react&(!buff.incarnation.up|azerite.wild_fleshrending.enabled)
			if A.ThrashCat:IsReady(unitID, true) and A.ThrashCat:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and Unit(player):HasBuffs(A.BloodtalonsBuff.ID, true) == 0 and
			(Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) < 4 and (Unit(player):HasBuffsStacks(A.ClearcastingBuff.ID, true) and (Unit(player):HasBuffs(A.IncarnationBuff.ID, true) == 0 or A.WildFleshRending:GetAzeriteRank() >= 1))) then
				return A.ThrashCat:Show(icon) 
			end
			
			--swipe_cat,if=spell_targets.swipe_cat>1
			if A.SwipeCat:IsReady(unitID, true) and A.SwipeCat:AbsentImun(unitID, Temp.AttackTypes) and InMelee(unitID) and canCast and not A.BrutalSlash:IsSpellLearned() and (inAoE and MultiUnits:GetByRange(inAoERanged, 3) > 2) then 
				return A.SwipeCat:Show(icon) 
			end
			
			--shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react
			if A.Shred:IsReady(unitID) and A.Shred:AbsentImun(unitID, Temp.AttackTypes) and canCast and (Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) > (A.Shred:GetSpellPowerCost() + A.Rake:GetSpellPowerCost() -
			Player:EnergyPredicted()) / Player:EnergyRegen() or Unit(player):HasBuffsStacks(A.ClearcastingBuff.ID, true)) and 
			(inAoe and MultiUnits:GetByRange(inAoERanged, 3) < 3 or not inAoe) and (A.WildFleshRending:GetAzeriteRank() >= 1 and (Unit(unitID):HasDeBuffs(A.ThrashCatDebuff.ID) > refreshTime or Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) == 0) or A.WildFleshRending:GetAzeriteRank() == 0) then
				return A.Shred:Show(icon) 
			end
		end
	end	
	
	local function FriendlyRotation(unitID)
		-- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end    
		
		-- Out of combat        
       -- if Unit("player"):CombatTime() == 0 and A.Resurrection:IsReady(unitID) and Unit(unitID):IsDead() and Unit(unitID):IsPlayer() and not isMoving and IsSchoolHolyUP() then 
        --    return A.Resurrection:Show(icon)
       -- end 
		
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

local function ArenaRotation(icon, unitID)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then     
		--Dispell
		if unitID ~= "targettarget" and A.Soothe:IsReady(unitID, nil, nil, true) and A.Soothe:AbsentImun(unitID, Temp.AuraForOnlyCCAndStun) and A.AuraIsValid(unitID, "UseExpelEnrage", "Enrage") then 
			return A.Soothe:Show(icon)
		end 
		
		if Player:ComboPoints() == Player:ComboPointsMax() then
			if A.Rip:IsReady(unitID) and A.Rip:AbsentImun(unitID, Temp.AttackTypes) and Unit(unitID):HasDeBuffs(A.RipDebuff.ID) <= A.GetGCD() + A.GetCurrentGCD() and Unit(unitID):TimeToDie() > 4 then
				return A.Rip:Show(icon)
			end
		end
		
		if Player:ComboPoints() < Player:ComboPointsMax() then
			if A.Rake:IsReady(unitID) and A.Rake:AbsentImun(unitID, Temp.AttackTypes) and Unit(unitID):HasDeBuffs(A.RakeDebuff.ID, true, true) <= A.GetGCD() + A.GetCurrentGCD() and Unit(unitID):TimeToDie() > 4 then
				return A.Rake:Show(icon)
			end
		end
	end
end

local function PartyRotation(unitID) 

end 

A[6] = function(icon)    
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)   
	return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)   
	return ArenaRotation(icon, "arena3")
end