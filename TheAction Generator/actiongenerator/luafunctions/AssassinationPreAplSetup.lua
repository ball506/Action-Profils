---------------------------------------------------
-------------- ASSASSINATION PREAPL ---------------
---------------------------------------------------
local BleedTickTime, ExsanguinatedBleedTickTime = 2 / Unit("player"):SpellHaste(), 1 / Unit("player"):SpellHaste();
local Stealth;
local RuptureThreshold, RuptureDMGThreshold, GarroteDMGThreshold;
local ComboPoints, ComboPointsDeficit, Energy_Regen_Combined, PoisonedBleeds;
local PriorityRotation;

-- Master Assassin Remains Check
local MasterAssassinBuff, NominalDuration = 256735, 3;
local function MasterAssassinRemains()
    if Unit("player"):HasBuffs(MasterAssassinBuff, true) < 0 then
        return A.GetCurrentGCD() + NominalDuration;
    else
        return Unit("player"):HasBuffs(MasterAssassinBuff, true);
    end
end

function Poisoned (unit)
    return (Unit(unit):HasDeBuffs(A.DeadlyPoisonDebuff.ID, true) or Unit(unit):HasDeBuffs(A.WoundPoisonDebuff.ID, true)) and true or false;
end

function Bleeds (unit)
    return (Unit(unit):HasDeBuffs(A.Garrote.ID, true) and 1 or 0) + (Unit(unit):HasDeBuffs(A.Rupture.ID, true) and 1 or 0)
    + (Unit(unit):HasDeBuffs(A.CrimsonTempest.ID, true) and 1 or 0) + (Unit(unit):HasDeBuffs(A.InternalBleeding.ID, true) and 1 or 0);
end
  
local PoisonedBleedsCount = 0;
function PoisonedBleeds ()
    PoisonedBleedsCount = 0;
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Garrote.ID) -- Garrote count
 	local AppliedInternalBleeding = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.InternalBleeding.ID) -- InternalBleeding count
 	local AppliedRupture = MultiUnits:GetByRangeAppliedDoTs(40, 5, A.Rupture.ID) -- Rupture count
	
	PoisonedBleedsCount = AppliedGarrote + AppliedInternalBleeding + AppliedRupture
	
    return PoisonedBleedsCount;
end
	
---------------------------------------------------
------- SIMC CUSTOM FUNCTION / EXPRESSION ---------
---------------------------------------------------

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsSpellLearned() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Unit("player"):ComboPoints(), CPMaxSpend());
end

-- Spells Damage
A.Envenom:RegisterDamage(
-- Envenom DMG Formula:
--    AP * CP * Env_APCoef * Aura_M * ToxicB_M * DS_M * Mastery_M * Versa_M
function ()
    return
        -- Attack Power
        Player:AttackPower() *
        -- Combo Points
        CPSpend() *
        -- Envenom AP Coef
        0.16 *
        -- Aura Multiplier (SpellID: 137037)
        1.27 *
        -- Toxic Blade Multiplier
        (Unit(unit):HasDeBuffs(A.ToxicBladeDebuff.ID, true) and 1.3 or 1) *
        -- Deeper Stratagem Multiplier
        (A.DeeperStratagem:IsSpellLearned() and 1.05 or 1) *
        -- Mastery Finisher Multiplier
        (1 + Player:MasteryPct()/100) *
        -- Versatility Damage Multiplier
        (1 + Player:VersatilityDmgPct()/100);
    end
);
A.Mutilate:RegisterDamage(
    function ()
        return
            -- Attack Power (MH Factor + OH Factor)
            Player:AttackPower() *
            -- Mutilate Coefficient
            0.35 *
            -- Aura Multiplier (SpellID: 137037)
            1.27 *
            -- Versatility Damage Multiplier
            (1 + Player:VersatilityDmgPct()/100);
    end
);
local function NighstalkerMultiplier ()
    return A.Nightstalker:IsSpellLearned() and Unit("player"):IsStealthed() and 1.5 or 1;
end
local function SubterfugeGarroteMultiplier ()
    return A.Subterfuge:IsSpellLearned() and Unit("player"):IsStealthed() and 2 or 1;
end

RegisterPMultiplier( -- Garrote dot and action
	A.Garrote.ID,    -- Garrote action
	A.GarroteDebuff.ID,  -- GarroteDebuff dot

    {NighstalkerMultiplier},
    {SubterfugeGarroteMultiplier}
)

RegisterPMultiplier( -- Rupture dot and action
	A.Rupture.ID,    -- Rupture action
	A.RuptureDebuff.ID,  -- RuptureDebuff dot

    {NighstalkerMultiplier}
)

-- Spell ID Changes check
Stealth = A.Subterfuge:IsSpellLearned() and A.Stealth2 or A.Stealth; -- w/ or w/o Subterfuge Talent

-- Stealth
function Stealth(Stealth, Setting)
    if Action.GetToggle(2, "StealthOOC") and Stealth:IsReady("player") and not Unit("player"):IsStealthed() then
        return Stealth:Show(icon)
    end
    return false;
end

---------------------------------------------------
------------------- DEFENSIVES --------------------
---------------------------------------------------

-- Crimson Vial
function CrimsonVial(CrimsonVial)
    if A.CrimsonVial:IsReady(unit) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "CrimsonVialHP") then
        return A.CrimsonVial:Show(icon)
    end
    return false;
end

-- Feint
function Feint(Feint)
    if A.Feint:IsReady(unit) and not Unit("player"):HasBuffs(A.Feint.ID, true) and Unit("player"):HealthPercent() <= Action.GetToggle(2, "FeintHP") then
        return A.Feint:Show(icon)
    end
end

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax()
		
    if ActionUnit("player"):CombatTime() == 0 then 
        return 
    end 

    -- Emergency Evade
    local Evade = Action.GetToggle(2, "EvadeHP")
    if     Evade >= 0 and A.Evade:IsReady("player") and 
    (
        (   -- Auto 
            Evade >= 100 and 
            (
                -- HP lose per sec >= 20
                ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                -- TTD 
                ActionUnit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        ActionUnit("player"):UseDeff() or 
                        (
                            ActionUnit("player", 5):HasFlags() and 
                            ActionUnit("player"):GetRealTimeDMG() > 0 and 
                            ActionUnit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Evade < 100 and 
            ActionUnit("player"):HealthPercent() <= Evade
        )
    ) 
    then 
        return A.Evade:Show(icon)Cast Evade (Defensives)"; end
    end  
		
    -- Emergency Feint
        local Feint = Action.GetToggle(2, "FeintHP")
        if     Feint >= 0 and A.Feint:IsReady("player") and 
        (
            (   -- Auto 
                Feint >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Feint < 100 and 
                ActionUnit("player"):HealthPercent() <= Feint
            )
        ) 
        then 
            return A.Feint:Show(icon)Cast Evade (Defensives)"; end
        end  		

        -- Emergency CrimsonVial
        local CrimsonVial = Action.GetToggle(2, "CrimsonVialHP")
        if     CrimsonVial >= 0 and A.CrimsonVial:IsReady("player") and 
        (
            (   -- Auto 
                CrimsonVial >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CrimsonVial < 100 and 
                ActionUnit("player"):HealthPercent() <= CrimsonVial
            )
        ) 
        then 
            return A.CrimsonVial:Show(icon)Cast Evade (Defensives)"; end
        end  		

        -- Emergency Cloak of Shadow
        local CloakofShadow = Action.GetToggle(2, "CloakofShadowHP")
        if     CloakofShadow >= 0 and A.CloakofShadow:IsReady("player") and 
        (
            (   -- Auto 
                CloakofShadow >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                CloakofShadow < 100 and 
                ActionUnit("player"):HealthPercent() <= CloakofShadow
            )
        ) 
        then 
            return A.CloakofShadow:Show(icon)Cast Evade (Defensives)"; end
        end 
		
        -- Emergency Vanish
        local Vanish = Action.GetToggle(2, "VanishDefensive")
        if     Vanish >= 0 and A.Vanish:IsReady("player") and 
        (
            (   -- Auto 
                Vanish >= 100 and 
                (
                    -- HP lose per sec >= 20
                    ActionUnit("player"):GetDMG() * 100 / ActionUnit("player"):HealthMax() >= 20 or 
                    ActionUnit("player"):GetRealTimeDMG() >= ActionUnit("player"):HealthMax() * 0.20 or 
                    -- TTD 
                    ActionUnit("player"):TimeToDieX(25) < 5 or 
                    (
                        A.IsInPvP and 
                        (
                            ActionUnit("player"):UseDeff() or 
                            (
                                ActionUnit("player", 5):HasFlags() and 
                                ActionUnit("player"):GetRealTimeDMG() > 0 and 
                                ActionUnit("player"):IsFocused() 
                            )
                        )
                    )
                ) and 
                ActionUnit("player"):HasBuffs("DeffBuffs", true) == 0
            ) or 
            (    -- Custom
                Vanish < 100 and 
                ActionUnit("player"):HealthPercent() <= Vanish
            )
        ) 
    then 
        return A.Vanish:Show(icon)
    end  

end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function RefreshPoisons()
    local choice = Action.GetToggle(2, "PoisonToUse")
	
	if A.CripplingPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.CripplingPoison) <= 10 or not Unit("player"):BuffP(A.CripplingPoison)) and not Unit("player"):PrevGCDP(1, A.CripplingPoison) and not Unit("player"):IsCasting() then
	    return A.CripplingPoison:Show(icon)
	end	
	-- Wound Poison
	if choice == "Wound Poison" then 
	    if A.WoundPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.WoundPoison) <= 10 or not Unit("player"):BuffP(A.WoundPoison)) and not Unit("player"):PrevGCDP(1, A.WoundPoison) and not Unit("player"):IsCasting() then 
		    return A.WoundPoison:Show(icon)
        end
	-- Deadly Poison
	elseif choice == "Deadly Poison" then
	    if A.DeadlyPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.DeadlyPoison) <= 10 or not Unit("player"):BuffP(A.DeadlyPoison)) and not Unit("player"):PrevGCDP(1, A.DeadlyPoison) and not Unit("player"):IsCasting() then 
		    return A.DeadlyPoison:Show(icon)
        end
	elseif choice == "Auto" then
	    -- Auto
	    if Action.IsInPvP and A.WoundPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.WoundPoison) <= 10 or not Unit("player"):BuffP(A.WoundPoison)) and not Unit("player"):PrevGCDP(1, A.WoundPoison) and not Unit("player"):IsCasting() then 		
	        return A.WoundPoison:Show(icon)
		else
		    if A.DeadlyPoison:IsCastableP() and (Unit("player"):BuffRemainsP(A.DeadlyPoison) <= 10 or not Unit("player"):BuffP(A.DeadlyPoison)) and not Action.IsInPvP and not Unit("player"):PrevGCDP(1, A.DeadlyPoison) and not Unit("player"):IsCasting() then
		        return A.DeadlyPoison:Show(icon)
		    end
	    end
	else
	    return
	end	
end
	
-- Check if the Priority Rotation variable should be set
local function UsePriorityRotation()
    if Cache.EnemiesCount[10] < 2 then
        return false
    end
    if Action.GetToggle(2, "UsePriorityRotation") == "Always" then
        return true
    end
    if Action.GetToggle(2, "UsePriorityRotation") == "On Bosses" and Unit(unit):IsInBossList() then
        return true
    end
    -- Zul Mythic
    if Unit("player"):InstanceDifficulty() == 16 and Unit(unit):NPCID() == 138967 then
        return true
    end
    return false
end

-- Fake ss_buffed (wonky without Subterfuge but why would you, eh?)
local function SSBuffed(unit)
    return A.ShroudedSuffocation:GetAzeriteRank() > 0
end

-- non_ss_buffed_targets
local function NonSSBuffedTargets()
    local count = 0;
    
	local MissingGarrote = MultiUnits:GetByRangeMissedDoTs(10, 5, A.Garrote.ID)   
	
	count = MissingGarrote
	
    return count;
end

-- ss_buffed_targets_above_pandemic
local function SSBuffedTargetsAbovePandemic()
    local count = 0;
    local GarroteToRefresh = MultiUnits:GetByRangeDoTsToRefresh(10, 5, A.Garrote.ID, 5.4)
    local AppliedGarrote = MultiUnits:GetByRangeAppliedDoTs(10, 5, A.Garrote.ID) -- Garrote count

    count = AppliedGarrote - GarroteToRefresh

    return count;
end
