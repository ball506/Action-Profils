------------------------------------------
--------- GUARDIAN PRE APL SETUP ---------
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

local function GetStance()
    -- @return number (1 - Bear, 2 - Cat, 3 - Travel)
    return Player:GetStance()
end 

local function Swipe()
  if Unit("player"):HasBuffs(A.CatForm.ID, true) > 0 then
    return A.SwipeCat
  else
    return A.SwipeBear
  end
end

local function Thrash()
  if Unit("player"):HasBuffs(A.CatForm.ID, true) > 0 then
    return A.ThrashCat
  else
    return A.ThrashBear
  end
end

-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
		
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 

		
    -- Emergency Ironfur
        local Ironfur = Action.GetToggle(2, "IronfurHP")
        if     Ironfur >= 0 and A.Ironfur:IsReady("player") and
        (
            (   -- Auto 
                Ironfur >= 100 and 
                (
                    -- HP lose per sec >= 2
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 2 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.02 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            Unit("player"):UseDeff() or 
                            (
                                Unit("player", 5):HasFlags() and 
                                Unit("player"):GetRealTimeDMG() > 0 and 
                                Unit("player"):IsFocused() 
                            )
                        )
                    )
                ) 
            ) or 
            (    -- Custom
                Ironfur < 100 and 
                Unit("player"):HealthPercent() <= Ironfur
            )
        ) 
        then 
            return A.Ironfur
        end  		

        -- Emergency FrenziedRegeneration
        local FrenziedRegeneration = Action.GetToggle(2, "FrenziedRegenerationHP")
        if     FrenziedRegeneration >= 0 and A.FrenziedRegeneration:IsReady("player") and Unit("player"):HasBuffs(A.FrenziedRegeneration.ID, true) == 0 and
        (
            (   -- Auto 
                FrenziedRegeneration >= 100 and 
                (
                    -- HP lose per sec >= 5
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 15 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.15 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or 
					-- Custom logic with current HPS and DMG
					Unit("player"):HealthPercent() <= 85 or
					Unit("player"):GetHEAL() * 2 < Unit("player"):GetDMG() or
                    (
                        A.IsInPvP and 
                        (
                            Unit("player"):UseDeff() or 
                            (
                                Unit("player", 5):HasFlags() and 
                                Unit("player"):GetRealTimeDMG() > 0 and 
                                Unit("player"):IsFocused() 
                            )
                        )
                    )
                ) 
            ) or 
            (    -- Custom
                FrenziedRegeneration < 100 and 
                Unit("player"):HealthPercent() <= FrenziedRegeneration
            )
        ) 
        then 
            return A.FrenziedRegeneration
        end  		
		
        -- Emergency Barkskin
        local Barkskin = Action.GetToggle(2, "BarkskinHP")
        if     Barkskin >= 0 and A.Barkskin:IsReady("player") and 
        (
            (   -- Auto 
                Barkskin >= 100 and 
                (
                    -- HP lose per sec >= 10
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 or 
					-- Custom logic with current HPS and DMG
					Unit("player"):HealthPercent() <= 65 or
                    (
                        A.IsInPvP and 
                        (
                            Unit("player"):UseDeff() or 
                            (
                                Unit("player", 5):HasFlags() and 
                                Unit("player"):GetRealTimeDMG() > 0 and 
                                Unit("player"):IsFocused() 
                            )
                        )
                    )
                ) 
            ) or 
            (    -- Custom
                Barkskin < 100 and 
                Unit("player"):HealthPercent() <= Barkskin
            )
        ) 
    then 
        return A.Barkskin
    end  
	
    -- Survival Instincts
    local SurvivalInstincts = Action.GetToggle(2, "SurvivalInstinctsHP")
    if     SurvivalInstincts >= 0 and A.SurvivalInstincts:IsReady("player") and Unit("player"):HasBuffs(A.SurvivalInstincts.ID, true) == 0 and
    (
        (   -- Auto 
            SurvivalInstincts >= 100 and 
            (
                -- HP lose per sec >= 15
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 25 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
				-- Custom logic with current HPS and DMG
				Unit("player"):HealthPercent() <= 45 or
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            SurvivalInstincts < 100 and 
            Unit("player"):HealthPercent() <= SurvivalInstincts
        )
    ) 
    then 
        return A.SurvivalInstincts
    end
	
		    -- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit("player"):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
	
end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    local EnemiesCasting = MultiUnits:GetByRangeCasting(10, 5, true, "TargetMouseover")
		
    -- SkullBash
    if useKick and A.SkullBash:IsReady(unit) then 
     	if Unit(unit):CanInterrupt(true, nil, 25, 70) then
       	    return A.SkullBash
       	end 
   	end 
	
   	 -- MightyBash
   	if useCC and A.MightyBash:IsSpellLearned() and A.MightyBash:IsReady(unit) then 
 		if Unit(unit):CanInterrupt(true, nil, 25, 70) then
   	        return A.MightyBash
   	    end 
   	end 

 	 -- IncapacitatingRoar
   	if useCC and EnemiesCasting >= 3 and (not A.MightyBash:IsSpellLearned() or not A.MightyBash:IsReady(unit)) and A.IncapacitatingRoar:IsReady(unit) then 
 		if Unit(unit):CanInterrupt(true, nil, 25, 70) then
   	        return A.IncapacitatingRoar
   	    end 
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

-- Multidot Handler UI --
local function HandleMultidots()
    local choice = Action.GetToggle(2, "AutoDotSelection")
       
    if choice == "In Raid" then
		if IsInRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if IsInGroup() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if A.IsInPvP then 
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