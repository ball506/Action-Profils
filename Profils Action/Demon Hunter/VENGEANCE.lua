-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
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
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DEMONHUNTER_VENGEANCE] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Abilities
    Frailty                                = Action.Create({ Type = "Spell", ID = 247456     }),
    ImmolationAura                         = Action.Create({ Type = "Spell", ID = 178740     }),
    InfernalStrike                         = Action.Create({ Type = "Spell", ID = 189110     }),
    Shear                                  = Action.Create({ Type = "Spell", ID = 203782     }),
    SoulFragments                          = Action.Create({ Type = "Spell", ID = 203981     }),
    ThrowGlaive                            = Action.Create({ Type = "Spell", ID = 204157     }), 
	Imprison                               = Action.Create({ Type = "Spell", ID = 217832     }),
    -- Sigils	
    SigilofFlameNoCS                       = Action.Create({ Type = "Spell", ID = 204596, Hidden = true}),
    SigilofFlameCS                         = Action.Create({ Type = "Spell", ID = 204513     }),
    SigilofFlame                           = Action.Create({ Type = "Spell", ID = 204596     }),
    SigilofFlame2                          = Action.Create({ Type = "Spell", ID = 204513, Hidden = true}),
	SigilofChains                          = Action.Create({ Type = "Spell", ID = 202138     }), -- 70% Snare + grip all enemies around 30yards
	SigilofMisery                          = Action.Create({ Type = "Spell", ID = 207684     }), -- AoE Interrupt "Fear"
	SigilofSilence                         = Action.Create({ Type = "Spell", ID = 202137     }), -- 30yards Silence for 6sec
    SoulCleave                             = Action.Create({ Type = "Spell", ID = 228477     }), 
    -- Defensive 
    DemonSpikes                            = Action.Create({ Type = "Spell", ID = 203720     }),
    FieryBrand                             = Action.Create({ Type = "Spell", ID = 204021     }),
    Torment                                = Action.Create({ Type = "Spell", ID = 185245     }),  -- Taunt
    -- Talents
    CharredFlesh                           = Action.Create({ Type = "Spell", ID = 264002     }),
    ConcentratedSigils                     = Action.Create({ Type = "Spell", ID = 207666     }),
    Felblade                               = Action.Create({ Type = "Spell", ID = 232893     }),
    FelDevastation                         = Action.Create({ Type = "Spell", ID = 212084     }),
    Fracture                               = Action.Create({ Type = "Spell", ID = 263642     }),
    SoulBarrier                            = Action.Create({ Type = "Spell", ID = 263648     }),
    SpiritBomb                             = Action.Create({ Type = "Spell", ID = 247454     }),
    -- Utility 
    Disrupt                                = Action.Create({ Type = "Spell", ID = 183752     }),
    Metamorphosis                          = Action.Create({ Type = "Spell", ID = 187827     }),
    ChaosNova                              = Action.Create({ Type = "Spell", ID = 179057}),
    Blur                                   = Action.Create({ Type = "Spell", ID = 198589}),
    ConsumeMagic                           = Action.Create({ Type = "Spell", ID = 278326}),
    Darkness                               = Action.Create({ Type = "Spell", ID = 196718}),
    -- Buffs
    -- Debuffs
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true}),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true}),
    SpiritBombDebuff                       = Action.Create({ Type = "Spell", ID = 247456, Hidden = true}),
    FieryBrandDebuff                       = Action.Create({ Type = "Spell", ID = 207771, Hidden = true}), 
    DemonSpikesBuff                        = Action.Create({ Type = "Spell", ID = 203819, Hidden = true}), 
    SigilofFlameDebuff                     = Action.Create({ Type = "Spell", ID = 204598, Hidden = true}),  
    -- Generics
    LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295078 }),
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, Hidden = true, QueueForbidden = true }), 
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, Hidden = true, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, Hidden = true, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, Hidden = true, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, Hidden = true, QueueForbidden = true }), 
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, Hidden = true, QueueForbidden = true }), 
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, Hidden = true, QueueForbidden = true }), 
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, Hidden = true, QueueForbidden = true }), 
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, Hidden = true, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, Hidden = true, QueueForbidden = true }), 
    BattlePotionofAgility                  = Action.Create({ Type = "Potion", ID = 163223, Hidden = true, QueueForbidden = true }),
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, Hidden = true, QueueForbidden = true }), 
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, Hidden = true, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, Hidden = true, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, Hidden = true, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, Hidden = true, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, Hidden = true, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, Hidden = true, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, Hidden = true, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, Hidden = true, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, Hidden = true, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, Hidden = true, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, Hidden = true, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, Hidden = true, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, Hidden = true, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, Hidden = true, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, Hidden = true, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, Hidden = true, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, Hidden = true, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, Hidden = true, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, Hidden = true, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, Hidden = true, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, Hidden = true, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, Hidden = true, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DEMONHUNTER_VENGEANCE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_VENGEANCE], { __index = Action })


local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
------------------------------------------
-------------- COMMON PREAPL -------------
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
    AuraTaunt                               = {A.Torment.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Disrupt:IsReadyByPassCastGCD(unit) or not A.Disrupt:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells
local function Interrupts(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    local EnemiesCasting = MultiUnits:GetByRangeCasting(30, 5, true, "TargetMouseover")
	
	if castRemainsTime < A.GetLatency() then    
	
	    -- Sigil of Chains (Snare)
	    if useCC and A.SigilofChains:IsReady("player") and A.SigilofChains:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):GetRange() > 5 then 
            return A.SigilofChains              
        end 
	
	    -- Sigil of Misery (Disorient)
	    if useCC and A.SigilofMisery:IsReady("player") and EnemiesCasting > 1 and A.SigilofMisery:AbsentImun(unit, Temp.TotalAndCC, true) then 
            return A.SigilofMisery              
        end 
	
	    -- Sigil of Silence (Silence)
	    if useKick and (not A.Disrupt:IsReady(unit) or EnemiesCasting > 1) and A.SigilofSilence:IsReady("player") and A.SigilofSilence:AbsentImun(unit, Temp.TotalAndCC, true) then 
            return A.SigilofSilence              
        end 

	    -- Imprison    
        if useCC and A.Imprison:IsReady(unit) and not A.Disrupt:IsReady(unit) then        
	    	return A.Imprison              
        end 
	
        -- Chaos Nova    
        if useCC and A.ChaosNova:IsReady(unit) and EnemiesCasting > 1 and A.ChaosNova:AbsentImun(unit, Temp.TotalAndCC, true) then 
            return A.ChaosNova              
        end 
	
	    -- Disrupt
        if useKick and A.Disrupt:IsReady(unit) and A.Disrupt:AbsentImun(unit, Temp.TotalAndMagKick, true) then 
            return A.Disrupt
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

-- Soul Fragments function taking into consideration aura lag
local function UpdateSoulFragments()
    SoulFragments = Unit("player"):HasBuffsStacks(A.SoulFragments.ID, true)
		
    -- Casting Spirit Bomb or Soul Cleave immediately updates the buff
    if Unit("player"):GetSpellLastCast(A.SpiritBomb.ID, true) < A.GetGCD()
    or Unit("player"):GetSpellLastCast(A.SoulCleave.ID, true) < A.GetGCD() then
        SoulFragmentsAdjusted = 0
        return;
    end

    -- Check if we have cast Fracture or Shear within the last GCD and haven't "snapshot" yet
    if SoulFragmentsAdjusted == 0 then
        if A.Fracture:IsSpellLearned() then
            if Unit("player"):GetSpellLastCast(A.Fracture.ID, true) < A.GetGCD() and A.Fracture:GetSpellTimeSinceLastCast() ~= LastSoulFragmentAdjustment then
                SoulFragmentsAdjusted = math.min(SoulFragments + 2, 5)
                LastSoulFragmentAdjustment = A.Fracture:GetSpellTimeSinceLastCast()
            end
        else
            if A.Shear:GetSpellTimeSinceLastCast() < A.GetGCD() and A.Fracture.Shear ~= LastSoulFragmentAdjustment then
                SoulFragmentsAdjusted = math.min(SoulFragments + 1, 5)
                LastSoulFragmentAdjustment = A.Shear:GetSpellTimeSinceLastCast()
            end
        end
    else
        -- If we have a soul fragement "snapshot", see if we should invalidate it based on time
        if A.Fracture:IsSpellLearned() then
            if A.Fracture:GetSpellTimeSinceLastCast() >= A.GetGCD() then
                SoulFragmentsAdjusted = 0
            end
        else
            if A.Shear:GetSpellTimeSinceLastCast() >= A.GetGCD() then
                SoulFragmentsAdjusted = 0
            end
        end
    end

    -- If we have a higher Soul Fragment "snapshot", use it instead
    if SoulFragmentsAdjusted > SoulFragments then
        SoulFragments = SoulFragmentsAdjusted
    elseif SoulFragmentsAdjusted > 0 then
        -- Otherwise, the "snapshot" is invalid, so reset it if it has a value
        -- Relevant in cases where we use a generator two GCDs in a row
        SoulFragmentsAdjusted = 0
    end
end

-- Melee Is In Range w/ Movement Handlers
local function UpdateIsInMeleeRange()
    if A.Felblade:GetSpellTimeSinceLastCast() < A.GetGCD()
    or A.InfernalStrike:GetSpellTimeSinceLastCast() < A.GetGCD() then
        IsInMeleeRange = true;
        IsInAoERange = true;
        return;
    end
			
    local IsInMeleeRange = Unit("target"):GetRange() <= 5
    local IsInAoERange = IsInMeleeRange or MultiUnits:GetByRange(8, 5, 10) > 0;
end

-- Current HPS > Incoming damage
local function IsInDanger(unit)
    return Unit("player"):GetHPS() < Unit("player"):GetDMG()
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local combatTime = Unit("player"):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local ActiveMitigationNeeded = Player:ActiveMitigationNeeded()
    local IsTanking = Unit("player"):IsTanking("target", 8) or Unit("player"):IsTankingAoE(8)
    UpdateSoulFragments()
    UpdateIsInMeleeRange()
    local SoulFragments = Unit("player"):HasBuffsStacks(A.SoulFragments.ID, true)
    local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        -- vars
		local Precombat, Brand, Cooldowns, Defensives, Normal
		-- Return boolean		
		local IsInDanger = IsInDanger(unit)
		local HPLoosePerSecond = Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax()
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.SuperiorSteelskinPotion:IsReady(unit) and Action.GetToggle(1, "Potion") and (Pull > 0 and Pull <= 2 or not A.GetToggle(1 ,"DBM"))
			then
                return A.SuperiorSteelskinPotion:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady("player") and (Pull > 0 and Pull <= 6 or not A.GetToggle(1 ,"DBM"))
			then
                return A.AzsharasFontofPower:Show(icon)
            end
        end
        
        --Brand
        local function Brand(unit)
            -- sigil_of_flame,if=cooldown.fiery_brand.remains<2
            if A.SigilofFlame:IsReady("player") and (A.FieryBrand:GetCooldown() < 2) then
                return A.SigilofFlame:Show(icon)
            end
            -- infernal_strike,if=cooldown.fiery_brand.remains=0
            if A.InfernalStrike:IsReady("player") and A.LastPlayerCastID ~= A.InfernalStrike.ID and (A.FieryBrand:GetCooldown() == 0) and (A.InfernalStrike:GetSpellCharges() > 1 or not A.GetToggle(2, "ConserveInfernalStrike")) then
                return A.InfernalStrike:Show(icon)
            end
            -- fiery_brand
            if A.FieryBrand:IsReady(unit) then
                return A.FieryBrand:Show(icon)
            end
            -- immolation_aura,if=dot.fiery_brand.ticking
            if A.ImmolationAura:IsReady("player") and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true) > 0) then
                return A.ImmolationAura:Show(icon)
            end
            -- fel_devastation,if=dot.fiery_brand.ticking
            if A.FelDevastation:IsReady("player") and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true) > 0) then
                return A.FelDevastation:Show(icon)
            end
            -- infernal_strike,if=dot.fiery_brand.ticking
            if A.InfernalStrike:IsReady("player") and A.LastPlayerCastID ~= A.InfernalStrike.ID and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true) > 0) and (A.InfernalStrike:GetSpellCharges() > 1 or not A.GetToggle(2, "ConserveInfernalStrike")) then
                return A.InfernalStrike:Show(icon)
            end
            -- sigil_of_flame,if=dot.fiery_brand.ticking
            if A.SigilofFlame:IsReady("player") and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true) > 0) then
                return A.SigilofFlame:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- potion
            if A.SuperiorSteelskinPotion:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.SuperiorSteelskinPotion:Show(icon)
            end
			
            -- concentrated_flame,if=(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- heart_essence

            -- use_item,effect_name=cyclotronic_blast,if=buff.memory_of_lucid_dreams.down
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) then
                return A.CyclotronicBlast:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) or Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) > 0 and Unit(unit):HealthPercent() < 31) then
                return A.AshvanesRazorCoral:Show(icon)
            end
            -- use_items
        end
        
        --Defensives
        local function Defensives(unit)
			
			-- Non SIMC Custom Trinket1
	        if A.Trinket1:IsReady("player") and A.Trinket1:GetItemCategory() ~= "DPS" then	    
      	       	return A.Trinket1:Show(icon)		
	        end	
			
	    	-- Non SIMC Custom Trinket2
	        if A.Trinket2:IsReady("player") and A.Trinket2:GetItemCategory() ~= "DPS" then	    
      	       	return A.Trinket2:Show(icon)		
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
                return A.AbyssalHealingPotion:Show(icon)
            end 
			
            -- demon_spikes
            if A.DemonSpikes:IsReady(unit) and A.LastPlayerCastID ~= A.DemonSpikes.ID and 
			    (
				    A.DemonSpikes:GetSpellCharges() > 1 
					or
				    IsInDanger 
				    or                 
			        -- HP lose per sec >= 10
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 
				    or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 
				    or 
                    -- TTD 
                    Unit("player"):TimeToDieX(40) < 5 
				)
			then
                return A.DemonSpikes:Show(icon)
            end
            -- metamorphosis
            if A.Metamorphosis:IsReady(unit) and A.BurstIsON(unit) and 
			    (
				    IsInDanger 
				    or                 
			        -- HP lose per sec >= 20
                    Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 
				    or 
                    Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 
				    or 
                    -- TTD 
                    Unit("player"):TimeToDieX(25) < 5 
				)  
			then
                return A.Metamorphosis:Show(icon)
            end
            -- fiery_brand
            if A.FieryBrand:IsReady(unit) then
                return A.FieryBrand:Show(icon)
            end
        end
        
        --Normal
        local function Normal(unit)
            -- infernal_strike
            if A.InfernalStrike:IsReady("player") and A.LastPlayerCastID ~= A.InfernalStrike.ID and (A.InfernalStrike:GetSpellCharges() > 1 or not A.GetToggle(2, "ConserveInfernalStrike")) then
                return A.InfernalStrike:Show(icon)
            end
            -- spirit_bomb,if=SoulFragments>=4
            if A.SpiritBomb:IsReady(unit) and (SoulFragments >= 4) then
                return A.SpiritBomb:Show(icon)
            end
            -- soul_cleave,if=!talent.spirit_bomb.enabled
            if A.SoulCleave:IsReady(unit) and (not A.SpiritBomb:IsSpellLearned()) then
                return A.SoulCleave:Show(icon)
            end
            -- soul_cleave,if=talent.spirit_bomb.enabled&SoulFragments=0
            if A.SoulCleave:IsReady(unit) and (A.SpiritBomb:IsSpellLearned() and SoulFragments == 0) then
                return A.SoulCleave:Show(icon)
            end
            -- immolation_aura,if=pain<=90
            if A.ImmolationAura:IsReady("player") and Player:Pain() <= 90 then
                return A.ImmolationAura:Show(icon)
            end
            -- felblade,if=pain<=70
            if A.Felblade:IsReady(unit) and (Player:Pain() <= 70) then
                return A.Felblade:Show(icon)
            end
            -- fracture,if=SoulFragments<=3
            if A.Fracture:IsReady(unit) and (SoulFragments <= 3) then
                return A.Fracture:Show(icon)
            end
            -- fel_devastation
            if A.FelDevastation:IsReady("player") then
                return A.FelDevastation:Show(icon)
            end
            -- sigil_of_flame
            if A.SigilofFlame:IsReady("player") then
                return A.SigilofFlame:Show(icon)
            end
            -- shear
            if A.Shear:IsReady(unit) then
                return A.Shear:Show(icon)
            end
            -- throw_glaive
            if A.ThrowGlaive:IsReady(unit) then
                return A.ThrowGlaive:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
            
			-- auto_attack
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end
			
		    -- Purge
		    -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
            -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
            if A.ConsumeMagic:IsReady(unit) and Action.AuraIsValid(unit, "UsePurge", "PurgeHigh") then
                return A.ConsumeMagic:Show(icon)
            end	
			
			-- VigilantProtector
            if A.VigilantProtector:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.VigilantProtector:Show(icon)
            end

		    -- Taunt 
            if A.GetToggle(2, "AutoTaunt") 
			and combatTime > 0     
			then 
			     -- if not fully aggroed or we are not current target then use taunt
			    if A.Torment:IsReady(unit, true, nil, nil, nil) and not Unit(unit):IsBoss() and not Unit(unit):IsDummy() and Unit(unit):GetRange() <= 30 and ( Unit("targettarget"):InfoGUID() ~= Unit("player"):InfoGUID() ) then 
                    return A.Torment:Show(icon)
				-- else if all good on current target, switch to another one we know we dont currently tank
                else
                    local Growl_Nameplates = MultiUnits:GetActiveUnitPlates()
                    if Torment_Nameplates then  
                        for Torment_UnitID in pairs(Torment_Nameplates) do             
                            if not UnitIsUnit("target", Torment_UnitID) and A.Torment:IsReady(Torment_UnitID, true, nil, nil, nil) and not Unit(Torment_UnitID):IsDummy() and not Unit(Torment_UnitID):IsBoss() and Unit(Torment_UnitID):GetRange() <= 30 and not Unit(Torment_UnitID):InLOS() and Unit("player"):ThreatSituation(Torment_UnitID) ~= 3 then 
                                return A:Show(icon, ACTION_CONST_AUTOTARGET)
                            end         
                        end 
                    end
				end
            end 
						
	    	-- Non SIMC Custom Trinket1
	        if A.Trinket1:IsReady(unit) and Trinket1IsAllowed then	    
      	       	return A.Trinket1:Show(icon)		
	        end
		
		    -- Non SIMC Custom Trinket2
	        if A.Trinket2:IsReady(unit) and Trinket2IsAllowed then	    
      	       	return A.Trinket2:Show(icon)	
	        end
					
            -- call_action_list,name=brand,if=talent.charred_flesh.enabled
            if (A.CharredFlesh:IsSpellLearned()) and Brand(unit) then
                return true
            end
			
            -- call_action_list,name=defensives
            if Defensives(unit) then
                return true
            end
			
            -- call_action_list,name=cooldowns
            if Cooldowns(unit) then
                return true
            end
			
            -- call_action_list,name=normal
            if Normal(unit) then
                return true
            end
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
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
end
-- Finished

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
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end]]--

