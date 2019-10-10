local TMW                                   = TMW 

local Action                                = Action
local TeamCache                             = Action.TeamCache
local EnemyTeam                             = Action.EnemyTeam
local FriendlyTeam                          = Action.FriendlyTeam
--local HealingEngine                       = Action.HealingEngine
local LoC                                   = Action.LossOfControl
local Player								= Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                          = Action.UnitCooldown
local Unit                                  = Action.Unit 
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")

local setmetatable                          = setmetatable

Action[ACTION_CONST_WARRIOR_FURY] = {
    -- Racial
    ArcaneTorrent                       = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                           = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                           = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                       = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                          = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                         = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                         = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                            = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                            = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                            = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                         = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                          = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                           = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                   = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                        = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                  = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    PetKick                             = Action.Create({ Type = "Spell", ID = 47482, Color = "RED", Desc = "RED" }),  
	-- CrownControl
	StormBolt							= Action.Create({ Type = "Spell", ID = 107570    }),
	StormBoltGreen						= Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
	Pummel                              = Action.Create({ Type = "Spell", ID = 6552    }),
	PummelGreen							= Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true }),  
	IntimidatingShout                   = Action.Create({ Type = "Spell", ID = 5246    }),
	PiercingHowl						= Action.Create({ Type = "Spell", ID = 23600    }),
	-- Self Defensive
	EnragedRegeneration					= Action.Create({ Type = "Spell", ID = 184364   }),
	RallyingCry							= Action.Create({ Type = "Spell", ID = 97462    }),
   -- Generics Spells
    Recklessness                          = Action.Create({ Type = "Spell", ID = 1719    }),
    FuriousSlash                          = Action.Create({ Type = "Spell", ID = 100130, isTalent = true    }), -- Talent
    RecklessAbandon                       = Action.Create({ Type = "Spell", ID = 202751    }),
    HeroicLeap                            = Action.Create({ Type = "Spell", ID = 6544    }),
    Siegebreaker                          = Action.Create({ Type = "Spell", ID = 280772    }),
    Rampage                               = Action.Create({ Type = "Spell", ID = 184367    }),
    FrothingBerserker                     = Action.Create({ Type = "Spell", ID = 215571, isTalent = true    }), -- Talent
    Carnage                               = Action.Create({ Type = "Spell", ID = 202922, isTalent = true    }), -- Talent
    Massacre                              = Action.Create({ Type = "Spell", ID = 206315, isTalent = true    }), -- Talent
    --Execute                               = MultiSpell(5308, 280735    }),
    Bloodthirst                           = Action.Create({ Type = "Spell", ID = 23881    }),
    RagingBlow                            = Action.Create({ Type = "Spell", ID = 85288    }),
    Bladestorm                            = Action.Create({ Type = "Spell", ID = 46924    }),
    DragonRoar                            = Action.Create({ Type = "Spell", ID = 118000    }),
    Whirlwind                             = Action.Create({ Type = "Spell", ID = 190411    }),
    Charge                                = Action.Create({ Type = "Spell", ID = 100    }),
    LightsJudgment                        = Action.Create({ Type = "Spell", ID = 255647    }),
    ColdSteelHotBlood                     = Action.Create({ Type = "Spell", ID = 288080    }),
	ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368    }),
	
    -- Misc
	Disable									= Action.Create({ Type = "Spell", ID = 116095    }), 
	BerserkerRage							= Action.Create({ Type = "Spell", ID = 18499    }),
    Channeling								= Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    Victorious								= Action.Create({ Type = "Spell", ID = 32216, Hidden = true     }),
    VictoryRush								= Action.Create({ Type = "Spell", ID = 34428, Hidden = true     }),
	ImpendingVictory						= Action.Create({ Type = "Spell", ID = 202168, Hidden = true     }),
    -- Buffs
    RecklessForceBuff                     = Action.Create({ Type = "Spell", ID = 302932, Hidden = true}),
    FujiedasFuryBuff                      = Action.Create({ Type = "Spell", ID = 207775, Hidden = true}),
    MeatCleaverBuff                       = Action.Create({ Type = "Spell", ID = 85739, Hidden = true}),
	EnrageBuff                            = Action.Create({ Type = "Spell", ID = 184362, Hidden = true}),
    FuriousSlashBuff                      = Action.Create({ Type = "Spell", ID = 202539, Hidden = true}),
    RecklessnessBuff                      = Action.Create({ Type = "Spell", ID = 1719, Hidden = true}),
	Enrage                                = Action.Create({ Type = "Spell", ID = 184362, Hidden = true}),
	SuddenDeathBuff                       = Action.Create({ Type = "Spell", ID = 280776, Hidden = true}),
    -- Debuffs 
    RazorCoralDebuff                      = Action.Create({ Type = "Spell", ID = 303568, Hidden = true}),
    ConductiveInkDebuff                   = Action.Create({ Type = "Spell", ID = 302565, Hidden = true}),
    SiegebreakerDebuff                    = Action.Create({ Type = "Spell", ID = 280773, Hidden = true}),
    -- Trinkets
    TrinketTest                          = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                         = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555 }),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                         = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
	AshvanesRazorCoral                   = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Potions
    PotionofUnbridledFury                = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    PotionTest                           = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
    -- Misc
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
	
	ExecuteDefault                        = Action.Create({ Type = "Spell", ID = 5308, Hidden = true}),
    ExecuteMassacre                       = Action.Create({ Type = "Spell", ID = 280735, Hidden = true}),
	
    -- Hidden Heart of Azeroth
    VisionofPerfectionMinor               = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2              = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3              = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                 = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                       = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    FocusedAzeriteBeam                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                        = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                      = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                   = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                  = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}),
	CondensedLifeforce                    = Action.Create({ Type = "HeartOfAzeroth", ID = 295834, Hidden = true}),
	CondensedLifeforce2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299354, Hidden = true}),
	CondensedLifeforce3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299357, Hidden = true}),
}

Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })

local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local RallyingCry = A.GetToggle(2, "RallyingCry")
    if     RallyingCry >= 0 and A.RallyingCry:IsReady("player") and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
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
            RallyingCry < 100 and 
            Unit("player"):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end  
	
	local EnragedRegeneration = A.GetToggle(2, "EnragedRegeneration")
    if     EnragedRegeneration >= 0 and A.EnragedRegeneration:IsReady("player") and 
    (
        (     -- Auto 
            EnragedRegeneration >= 100 and 
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
            EnragedRegeneration < 100 and 
            Unit("player"):HealthPercent() <= EnragedRegeneration
        )
    ) 
    then 
        return A.EnragedRegeneration
    end  
    
    
    -- Stoneform on deffensive
    local Stoneform = A.GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP("player") and 
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
                            Unit("player"):IsFocused()                                 
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
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "KickImun"}, true) and Unit(unit):CanInterrupt(true) then 
        return A.Pummel
    end 
    
    if useCC and A.StormBolt:IsReady(unit) and A.StormBolt:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.StormBolt              
    end          
	
	if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("disorient", 0) then 
        return A.IntimidatingShout              
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

-----------------------------------------
--                 ROTATION  
-----------------------------------------
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local unit = "player"
    local isMoving = Player:IsMoving()
    local inMelee = false
	
	local function EnemyRotation(unit)
		-- Variables
        inMelee = A.Rampage:IsInRange(unit)

		-- Interrupts
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end  

		if A.VictoryRush:IsReady(unit) and Unit("player"):HealthPercent() <= A.GetToggle(2, "VictoryRush") then
			return A.VictoryRush:Show(icon)
		end

		if A.ExecuteDefault:IsReady(unit) and (Unit("player"):HasBuffs(A.SuddenDeathBuff.ID, true) > 1 or Unit("player"):HasBuffs(A.EnrageBuff.ID, true) > 0) then
			return A.ExecuteDefault:Show(icon)
		end

		-- PiercingHowl (slow)
        if unit ~= "mouseover" and  Unit(unit):GetRange() <= 14 and (A.IsInPvP or (not Unit(unit):IsBoss() and Unit(unit):IsMovingOut())) and A.PiercingHowl:IsReady(unit) and A.PiercingHowl:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"}, true) and Unit(unit):GetMaxSpeed() >= 100 and Unit(unit):HasDeBuffs("Slowed") == 0 and not Unit(unit):IsTotem() then 
            return A.PiercingHowl:Show(icon)
        end

		-- AoE
		if A.GetToggle(2, "AoE") and MultiUnits:GetByRange(8, 2) >= 2 and A.Whirlwind:IsReady(unit, true) and Unit("player"):HasBuffs(A.MeatCleaverBuff.ID, true) <= 0 then
			return A.Whirlwind:Show(icon)
		end

		-- 

		-- Bursting #2
        if unit ~= "mouseover" and A.BurstIsON(unit) then             
            -- Simcraft 
            -- Cooldowns --
            
            if inMelee then 
                -- Racials 
                if A.BloodFury:AutoRacial(unit) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit) then 
                    return A.Berserking:Show(icon)
                end 
                
                -- Trinkets
                if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                    return A.Trinket1:Show(icon)
                end 
                
                if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                    return A.Trinket2:Show(icon)
                end                     
            end 

			if A.Recklessness:IsReady(unit) and inMelee then
				return A.Recklessness:Show(icon)
			end
            
            -- call_action_list,name=essences
            if (isMulti or A.GetToggle(2, "AoE")) and A.BloodoftheEnemy:AutoHeartOfAzeroth(unit) then                                 
                return A.BloodoftheEnemy:Show(icon)                                                 
            end 
            
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit) then 
                return A.FocusedAzeriteBeam:Show(icon)
            end 
            
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit) then 
                return A.GuardianofAzeroth:Show(icon)
            end 
            
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit) then 
                return A.WorldveinResonance:Show(icon)
            end 
        end


		-- Single 
		if A.Siegebreaker:IsReady(unit) then
			return A.Siegebreaker:Show(icon)
        end 

		if A.Rampage:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) < 1 or (A.FrothingBerserker:IsSpellLearned() or A.Carnage:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < A.GetCurrentGCD() + 0.1 or Player:Rage() > 90) or A.Massacre:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < A.GetCurrentGCD() + 0.1 or Player:Rage() > 90))) then
			return A.Rampage:Show(icon)
		end

		if A.ExecuteDefault:IsReady(unit) then
			return A.ExecuteDefault:Show(icon)
		end

		if A.FuriousSlash:IsReady(unit) and Unit("player"):HasBuffs(A.FuriousSlashBuff.ID, true) < 3 then
			return A.FuriousSlash:Show(icon)
		end

		if A.Bloodthirst:IsReady(unit) and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) <= 0) then
			return A.Bloodthirst:Show(icon)
		end

		if A.DragonRoar:IsReady(unit, true) and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) > 0)  and Unit(unit):GetRange() <= 12 then
			return A.DragonRoar:Show(icon)
		end

		if A.RagingBlow:IsReady(unit) and (A.RagingBlow:GetSpellCharges() == 2) then
			return A.RagingBlow:Show(icon)
		end

		if A.Bloodthirst:IsReady(unit) then
			return A.Bloodthirst:Show(icon)
		end

		if A.RagingBlow:IsReady(unit) and (A.Carnage:IsSpellLearned() or (A.Massacre:IsSpellLearned() and  Player:Rage() < 80) or (A.FrothingBerserker:IsSpellLearned() and Player:Rage() < 90)) then
			return A.RagingBlow:Show(icon)
		end

		if A.FuriousSlash:IsReady(unit) then
			return A.FuriousSlash:Show(icon)
		end

		if A.Whirlwind:IsReady(unit, true) and inMelee then
			return A.Whirlwind:Show(icon)
		end
		

		-- Misc - Supportive 
        if A.BerserkerRage:IsReady("player") then 
            if Unit("player"):HasDeBuffs("Fear") >= 4 then 
                return A.BerserkerRage:Show(icon)
            end 
        end 	
 	end 

	-- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Trinkets (Defensive)
    if Unit("player"):CombatTime() > 0 and Unit("player"):HealthPercent() <= A.GetToggle(2, "TrinketDefensive") then 
        if A.Trinket1:IsReady("player") and A.Trinket1:GetItemCategory() ~= "DPS" then 
            return A.Trinket1:Show(icon)
        end 
        
        if A.Trinket2:IsReady("player") and A.Trinket2:GetItemCategory() ~= "DPS" then 
            return A.Trinket2:Show(icon)
        end             
    end 
    
    -- Mouseover     
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
    
    -- Target             
    if A.IsUnitEnemy("target") then 
        unit = "target"
        
        if EnemyRotation(unit) then 
            return true 
        end 
    end 
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
    end 	
end  