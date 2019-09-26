------------------------------------------------------------
---------------- Wolftech Action Hunter Classic -------------
------------------------------------------------------------
-- locals
local Action                                = Action
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local Pet                                    = LibStub("PetLibrary")
local setmetatable, pairs, select, wipe        = setmetatable, pairs, select, wipe
local UnitPowerType                         = UnitPowerType 
local UnitIsUnit                            = UnitIsUnit
local IsUsableSpell                            = IsUsableSpell

-- All spells and action
Action[Action.HUNTER] = {
    -- Night elf 
    Shadowmeld = Action.Create({ Type = "Spell", ID = 20580 }),
    -- Dwarf     
    Stoneform = Action.Create({ Type = "Spell", ID = 20594 }),     
    -- Troll 
    Berserking = Action.Create({ Type = "Spell", ID = 20554 }), 

    -- Damager 
    Aimedshot = Action.Create({ Type = "Spell", ID = 19434, useMaxRank = true, isTalent = true }), 
    Multishot = Action.Create({ Type = "Spell", ID = 2643, useMaxRank = true }), 
    Autoshot = Action.Create({ Type = "Spell", ID = 75 }),
    Volley = Action.Create({ Type = "Spell", ID = 14295, useMaxRank = true }),
    Serpentsting = Action.Create({ Type = "Spell", ID = 1976, useMaxRank = true }),	

	-- DropCombat
	Disengage = Action.Create({ Type = "Spell", ID = 781, useMaxRank = true }),
	FeignDeath = Action.Create({ Type = "Spell", ID = 5384 }),
	
	-- Buff
	Trueshot = Action.Create({ Type = "Spell", ID = 19506, useMaxRank = true, isTalent = true }),
	Hawk = Action.Create({ Type = "Spell", ID = 13165, useMaxRank = true }),
	Mark = Action.Create({ Type = "Spell", ID = 1130, useMaxRank = true }),
	
	-- Slow
	Wingclip = Action.Create({ Type = "Spell", ID = 2974, useMaxRank = true }),
	
	-- Healpet
	Mendpet = Action.Create({ Type = "Spell", ID = 136, useMaxRank = true }),
	
	-- Melee
	Raptorstrike = Action.Create({ Type = "Spell", ID = 2973, useMaxRank = true }),

    -- Potions
    MajorManaPotion = Action.Create({ Type = "Potion", ID = 13444 }),
	MajorHealingPotion = Action.Create({ Type = "Potion", ID = 13446 }),
	
    -- Trinkets 
    -- TalismanofEphemeralPower                = Action.Create({ Type = "Trinket",          ID = 18820                                                                }), -- not used in APL but can Queue 
    -- ZandalarianHeroCharm                    = Action.Create({ Type = "Trinket",          ID = 19950                                                                }), -- not used in APL but can Queue 

}    
local A = setmetatable(Action[Action.HUNTER], { __index = Action })

-- For racials use following values as Key from racial key:
local RacialKeys = {
	NightElf = "Shadowmeld",
	Human = "Perception",
	Gnome = "EscapeArtist",
	Dwarf = "Stoneform",
	Scourge = "WilloftheForsaken",
	Troll = "Berserking",
	Tauren = "WarStomp",
	Orc = "BloodFury",
}

-- Local used to check immunities
local Temp                                  = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
}

-- Defensives abilities
local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    -- FeignDeath on large burst damage
	
	-- Get the FeignDeath setting from ProfileUI : FeignDeathHP
    local FeignDeath = A.GetToggle(2, "FeignDeathHP")
    if     FeignDeath >= 0 and A.FeignDeath:IsReady("player") and
    (
        (     -- Auto 
            FeignDeath >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 3 or 
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
            FeignDeath < 100 and 
            Unit("player"):HealthPercent() <= FeignDeath
        )
    ) 
    then 
        return A.FeignDeath
    end 
    
    -- Stoneform on deffensive
    local Stoneform = A.GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP("player", nil, nil, true) and 
    (
        (     -- Auto 
            Stoneform >= 100 and 
            (
                (
                    not A.IsInPvP and                         
                    Unit("player"):TimeToDieX(65) < 3 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            Stoneform < 100 and 
            Unit("player"):HealthPercent() <= Stoneform
        )
    ) 
    then 
        return A.Stoneform
    end     
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:AutoRacial("player", true, nil, true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 

-- Interrupts
local function Interrupts(unit, isSoothingMistCasting)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")
    -- Your interrupt
    if useKick and A.YourInterruptSpell:IsReady(unit) and A.YourInterruptSpell:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then 
        if ActionUnit(unit):CanInterrupt(true) then 
		    return A.YourInterruptSpel
        end			
    end 
     -- Your CC
    if useCC and A.YourCCSpell:IsReady(unit) and A.YourCCSpell:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then 
        if ActionUnit(unit):CanInterrupt(true) then 
		    return A.YourCCSpell
        end			
    end 	
    
    if useRacial and A.QuakingPalm:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit, nil, nil, isSoothingMistCasting) then 
        return A.BullRush
    end      
     
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)


-- [3] Rotation 
A[3] = function(icon)
    local combatTime       = Unit("player"):CombatTime()
    local inCombat         = combatTime > 0
    local inRaidPvE        = TeamCache.Friendly.Type == "raid" and not A.IsInPvP
 
    -- DPS Rotation
    local function DamageRotation(unit)
        
        -- Interrupts
        local Interrupt = Interrupts(unit, isSoothingMistCasting)
        if Interrupt then 
            return Interrupt:Show(icon)
        end 
		
        -- Trueshot Aura 
        if A.trueshot:IsReady("player") and (Unit("player"):HasBuffs(A.Trueshot.ID, false) <= A.GetGCD() or Unit("player"):HasBuffsStacks(A.InnerFire.ID, true) <= 1) then 
            return A.Trueshot:Show(icon)
        end 
		
        -- Autoshot
        if A.Autoshot:IsReady(unitID) and A.Autoshot:AbsentImun(unitID, Temp.AttackTypes) Player:IsStaying() then 
            return A.Autoshot:Show(icon)
        end 
        
        -- Aimedshot
        if A.Aimedshot:IsReady(unitID) and A.Aimedshot:AbsentImun(unitID, Temp.AttackTypes) Player:IsStaying() then 
            return A.Aimedshot:Show(icon)
        end 
         
        -- CD's
        if A.BurstIsON(unitID) and A.AbsentImun(nil, unitID) then 
            -- Racials 
            if A.Berserking:AutoRacial(unitID) and Unit(unitID):InRange() then 

                    return A.Berserking:Show(icon)
                end                 
            end     
                  

        
        -- PvE: Stoneform (self dispel)
        if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and (A.AuraIsValid("player", "UseDispel", "Poison") or A.AuraIsValid("player", "UseDispel", "Bleed") or A.AuraIsValid("player", "UseDispel", "Disease")) then 
            return A.Stoneform:Show(icon)
        end     

        
        -- PvE: FeignDeath (agro dump)
        if inCombat and not A.IsInPvP and A.Zone ~= "none" and TeamCache.Friendly.Type and A.FeignDeath:IsReady("player") and (Unit("player"):IsTankingAoE()) then 
            return A.FeignDeath:Show(icon)
        end 
        
        -- PvE: Shadowmeld (agro dump)
        if inCombat and not A.IsInPvP and A.Zone ~= "none" and TeamCache.Friendly.Type and A.PlayerRace == "NightElf" and A.Shadowmeld:IsRacialReady("player") and Unit("player"):IsTankingAoE() then 
            return A.Shadowmeld:Show(icon)
        end 
        
        
        -- Out of combat: Self Buffer 
        if not inCombat and PlayerRebuff() then 
            return true 
        end 
        
        -- Runes 
        if inCombat and A.CanUseManaRune(icon) then 
            return true 
        end 
        
        -- Mana Potion 
        if inCombat and A.MajorManaPotion:IsReady("player") and Unit("player"):PowerPercent() <= A.GetToggle(2, "ManaPotion") then 
            return A.MajorManaPotion:Show(icon)
        end         
    end 
	
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Function to execute if our mouseover is hostile
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    -- Function to execute if our target is hostile
    if A.IsUnitEnemy("target") then 
        unit = "target"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
end 