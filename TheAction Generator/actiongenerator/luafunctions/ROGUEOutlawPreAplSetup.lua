------------------------------------------
---------- OUTLAW PRE APL SETUP ----------
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

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Unit("player"):ComboPoints(), CPMaxSpend());
end

-- APL Action Lists (and Variables)
local SappedSoulSpells = {
    {A.Kick.ID, "Cast Kick (Sapped Soul)", function () return Unit(unit):IsInRange(A.SinisterStrike); end},
    {A.Feint.ID, "Cast Feint (Sapped Soul)", function () return true; end},
    {A.CrimsonVial.ID, "Cast Crimson Vial (Sapped Soul)", function () return true; end}
};

-- Roll the bones buff list
local RtB_BuffsList = {
    
    [1] = A.Broadside.ID, 
    [2] = A.GrandMelee.ID, 
    [3] = A.BuriedTreasure.ID, 
    [4] = A.RuthlessPrecision.ID,
    [5] = A.TrueBearing.ID,
    [6] = A.SkullandCrossbones.ID
}

-- Roll the bones list on player checker
local function RtB_List (Type, List)
    if not RtB_List then 
        RtB_List = {}; 
    end
    
    if not RtB_List[Type] then 
        RtB_List[Type] = {}; 
    end
    local Sequence = table.concat(List);
    
    -- All
    if Type == "All" then
        if not RtB_List[Type][Sequence] then
            local Count = 0;
            for i = 1, #List do
                if Unit("player"):HasBuffs(RtB_BuffsList[List[i]], true) > 0 then
                    Count = Count + 1;
                end
            end
            RtB_List[Type][Sequence] = Count == #List and true or false;
        end        
        -- Any
    else
        if not RtB_List[Type][Sequence] then
            RtB_List[Type][Sequence] = false;
            for i = 1, #List do
                if Unit("player"):HasBuffs(RtB_BuffsList[List[i]], true) > 0 then
                    RtB_List[Type][Sequence] = true;
                    break;
                end
            end
        end
    end
    return RtB_List[Type][Sequence];
end

-- Roll the bones current buff remaining time
local function RtB_BuffRemains()
    if not RtB_BuffRemains then
        local RtB_BuffRemains = 0;
        for i = 1, #RtB_BuffsList do
            if Unit("player"):HasBuffs(RtB_BuffsList[i], true) > 0 then
                RtB_BuffRemains = Unit("player"):HasBuffs(RtB_BuffsList[i], true)
                break
            end
        end
    end
    return RtB_BuffRemains
end

-- Get the number of Roll the Bones buffs currently on
local function RtB_Buffs()
    local RtB_Buffs = 0
    for i = 1, #RtB_BuffsList do
        if Unit("player"):HasBuffs(RtB_BuffsList[i], true) > 0 then
            RtB_Buffs = RtB_Buffs + 1
        end
    end
    return RtB_Buffs
end

-- Used to handle different UI choices and return Roll the Bones conditions
local function CheckGoodBuffs()
    local choice = Action.GetToggle(2, "RolltheBonesLogic")
    local GotGoodBuff = false
    
    if choice == "1BUFF" then
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and RtB_Buffs() < 1 and true) or false;
    elseif choice == "MYTHICPLUS" then
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and (Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0) and not (RtB_Buffs() >= 2) and true) or false
    elseif choice == "AOESTRAT" then   
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and (Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0) and not (RtB_Buffs() >= 2) and true) or false
    elseif choice == "BROADSIDE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0 and true) or false;
    elseif choice == "BURIEDTREASURE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.BuriedTreasure.ID, true) == 0 and true) or false;
    elseif choice == "GRANDMELEE" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and true) or false;
    elseif choice == "SKULLANDCROSS" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 0 and true) or false;
    elseif choice == "RUTHLESSPRECISION" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and true) or false;
    elseif choice == "TRUEBEARING" then  
        GotGoodBuff = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.TrueBearing.ID, true) == 0 and true) or false;
    elseif choice == "SIMC" then  
        if Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0 and MultiUnits:GetByRange(A.GetToggle(2, "BladeFlurryRange"), 5, 5) >= 2 then
			GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or (RtB_Buffs() == 2 and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 1) or
                    (RtB_Buffs() < 2 and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0 and Unit("player"):HasBuffs(A.Broadside.ID, true) == 0))) and true or false;
        elseif A.SnakeEyesPower:GetAzeriteRank() >= 2 then
            GotGoodBuff = (RtB_Buffs() < 2 ) and true or false;
            -- # Do not reroll if Snake Eyes is at 2+ stacks of the buff (1+ stack with Broadside up)
            -- actions+=/variable,name=rtb_reroll,op=reset,if=azerite.snake_eyeA.rank>=2&buff.snake_eyeA.stack>=2-buff.broadside.up
            if Unit("player"):HasBuffsStacks(A.SnakeEyesBuff.ID, true) >= 2 - num(Unit("player"):HasBuffs(A.Broadside.ID, true) > 0) then
                GotGoodBuff = false;
            end
        elseif A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0 then
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
                    Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) <= A.BetweentheEyes:GetCooldown())) and true or false;
        else
            GotGoodBuff = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) > 0 or
                    (Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0 and Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) == 0))) and true or false;
        end
    else
        return
    end
    return GotGoodBuff
end

-- Roll the Bones rerolling strategy, return true if we should reroll
local function RtB_Reroll()
    
    local RtB_Reroll = false
    
    -- Defensive Override : Grand Melee if HP < 60
    if Action.GetToggle(2, "SoloMode") and Unit("player"):HealthPercent() < Action.GetToggle(2, "RolltheBonesLeechHP") then
        RtB_Reroll = (not A.SliceandDice:IsSpellLearned() and Unit("player"):HasBuffs(A.GrandMelee.ID, true) == 0) and true or false;
        -- 1+ Buff
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "1BUFF" then
        RtB_Reroll = CheckGoodBuffs()
        -- Mythic+
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "MYTHICPLUS" then
        RtB_Reroll = CheckGoodBuffs()
        -- Broadside
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "AOESTRAT" and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 or (not Unit("target"):IsBoss()) then
        RtB_Reroll = CheckGoodBuffs()
        -- Broadside
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "BROADSIDE" then
        RtB_Reroll = CheckGoodBuffs()
        -- Buried Treasure
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "BURIEDTREASURE" then
        RtB_Reroll = CheckGoodBuffs()
        -- Grand Melee
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "GRANDMELEE" then
        RtB_Reroll = CheckGoodBuffs()
        -- Skull and Crossbones
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "SKULLANDCROSS" then
        RtB_Reroll = CheckGoodBuffs()
        -- Ruthless Precision
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "RUTHLESSPRECISION" then
        RtB_Reroll = CheckGoodBuffs()
        -- True Bearing
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "TRUEBEARING" then
        RtB_Reroll = CheckGoodBuffs()
        -- SimC Default
    elseif Action.GetToggle(2, "RolltheBonesLogic") == "SIMC" then
        RtB_Reroll = CheckGoodBuffs()
    else
        return false
    end
    return RtB_Reroll;
end

-- # Condition to use Stealth cooldowns for Ambush
local function Ambush_Condition ()
    -- actions+=/variable,name=ambush_condition,value=combo_pointA.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossboneA.up&!buff.keep_your_wits_about_you.up
    return Player:ComboPointsDeficit() >= 2 + 2 * ((A.GhostlyStrike:IsSpellLearned() and A.GhostlyStrike:GetCooldown() < 1) and 1 or 0)
    + (Unit("player"):HasBuffs(A.Broadside.ID, true) > 0 and 1 or 0) and Player:EnergyPredicted() > 60 and Unit("player"):HasBuffs(A.SkullandCrossbones.ID, true) == 0 and Unit("player"):HasBuffs(A.KeepYourWitsBuff.ID, true) == 0;
end

-- actions+=/variable,name=bte_condition,value=buff.ruthless_precision.up|(azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled)&buff.roll_the_boneA.up
local function BtECondition ()
    return Unit("player"):HasBuffs(A.RuthlessPrecision.ID, true) > 0 or (A.Deadshot:GetAzeriteRank() > 0 or A.AceUpYourSleeve:GetAzeriteRank() > 0) and RtB_Buffs() >= 1;
end

-- # With multiple targets, this variable is checked to decide whether some CDs should be synced with Blade Flurry
-- actions+=/variable,name=blade_flurry_sync,value=spell_targetA.blade_flurry<2&raid_event.addA.in>20|buff.blade_flurry.up
local function Blade_Flurry_Sync ()
    return not Action.GetToggle(2,"AoE") or MultiUnits:GetByRangeInCombat(8, 5, 10) < 2 or Unit("player"):HasBuffs(A.BladeFlurry.ID, true) > 0
end

local function EnergyTimeToMaxRounded ()
    -- Round to the nearesth 10th to reduce prediction instability on very high regen rates
    return math.floor(Unit("player"):EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end

-- Marked for Death Sniping
-- Will try to get best unit to apply Marked for Death considering time to die to get cooldown reset
local BestUnit, BestUnitTTD;
local function MfDSniping (MarkedforDeath)
    local unit = "target"
    
    if MarkedforDeath:IsReady(unit) and A.MarkedforDeath:IsSpellLearned() then
        -- Get Units up to 30y for MfD.
        
        BestUnit, BestUnitTTD = nil, 60;
        local unit = "target"
        local MOunit = "mouseover"
        local MOTTD = Unit("mouseover"):GetRange() <= 30 and Unit("mouseover"):TimeToDie() or 11111;
        local TTD = Unit(unit):TimeToDie()
        
        for _, CycleUnit in pairs(MultiUnits:GetActiveUnitPlates()) do
            
            -- Note: Increased the SimC condition by 50% since we are slower.
            -- TEST - REMOVED 50% lowered value on Action
            if not Unit(CycleUnit):IsMfdBlacklisted() and TTD < Player:ComboPointsDeficit() * 1 and TTD < BestUnitTTD then
                if MOTTD - TTD > 1 then
                    BestUnit, BestUnitTTD = Unit(CycleUnit), TTD;
                else
                    BestUnit, BestUnitTTD = MouseOver, MOTTD;
                end
            end
        end
        if BestUnit and BestUnit:InfoGUID() ~= Unit(CycleUnit):InfoGUID() then
            return A:Show(icon, ACTION_CONST_AUTOTARGET)
        end
    end
end


-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
    
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    -- Emergency Riposte
    local Riposte = Action.GetToggle(2, "RiposteHP")
    if     Riposte >= 0 and A.Riposte:IsReady("player") and 
    (
        (   -- Auto 
            Riposte >= 100 and 
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
            Riposte < 100 and 
            Unit("player"):HealthPercent() <= Riposte
        )
    ) 
    then 
        return A.Riposte
    end  
    
    -- Emergency Feint
    local Feint = Action.GetToggle(2, "FeintHP")
    if     Feint >= 0 and A.Feint:IsReady("player") and 
    (
        (   -- Auto 
            Feint >= 100 and 
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
            Feint < 100 and 
            Unit("player"):HealthPercent() <= Feint
        )
    ) 
    then 
        return A.Feint
    end          
    
    -- Emergency CrimsonVial
    local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
    if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
    (
        (   -- Auto 
            CrimsonVial >= 100 and 
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
            CrimsonVial < 100 and 
            Unit("player"):HealthPercent() <= CrimsonVial
        )
    ) 
    then 
        return A.CrimsonVial
    end          
    
    -- Emergency Cloak of Shadow
    local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
    if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
    (
        (   -- Auto 
            CloakofShadow >= 100 and 
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
            CloakofShadow < 100 and 
            Unit("player"):HealthPercent() <= CloakofShadow
        )
    ) 
    then 
        return A.CloakofShadow
    end 
    
    -- Emergency Vanish
    local Vanish = Action.GetToggle(2, "VanishDefensive")
    if     Vanish >= 0 and A.Vanish:IsReady("player") and 
    (
        (   -- Auto 
            Vanish >= 100 and 
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
            Vanish < 100 and 
            Unit("player"):HealthPercent() <= Vanish
        )
    ) 
    then 
        return A.Vanish
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

-- TO USE AFTER NEXT ACTION UPDATE
local function InterruptsNEW(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, not A.Kick:IsReady(unit)) -- A.Kick non GCD spell
    
	if castDoneTime > 0 then
        if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
            -- Notification                    
            Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
            return A.Kick
        end 
    
        if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
            return A.Gouge              
        end          
    
        if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
            -- Notification                    
            Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
            return A.CheapShot              
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
end

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Kick:IsReady(unit) and A.Kick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        -- Notification                    
        Action.SendNotification("Kick on : " .. UnitName(unit), A.Kick.ID)
        return A.Kick
    end 
    
    if useCC and A.Gouge:IsReady(unit) and A.Gouge:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification                    
        Action.SendNotification("Gouge on : " .. UnitName(unit), A.Gouge.ID)
        return A.Gouge              
    end          
    
    if useCC and Player:IsStealthed() and A.CheapShot:IsReady(unit) and A.CheapShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        -- Notification                    
        Action.SendNotification("CheapShot on : " .. UnitName(unit), A.CheapShot.ID)
        return A.CheapShot              
    end
    
    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("QuakingPalm on : " .. UnitName(unit), A.QuakingPalm.ID)
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("Haymaker on : " .. UnitName(unit), A.Haymaker.ID)
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("WarStomp on : " .. UnitName(unit), A.WarStomp.ID)
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit) then 
        -- Notification                    
        Action.SendNotification("BullRush on : " .. UnitName(unit), A.BullRush.ID)
        return A.BullRush
    end      
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)