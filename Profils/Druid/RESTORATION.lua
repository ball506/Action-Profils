local TMW                                     = TMW 

local Action                                 = Action
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")

local setmetatable                            = setmetatable


Action[ACTION_CONST_DRUID_RESTORATION] = {
    -- Racial
    ArcaneTorrent                             = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                                 = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                                   = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                              = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                                = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                                  = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                                  = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                                  = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                                  = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                                  = Action.Create({ Type = "Spell", ID = 255654     }),    
    GiftofNaaru                               = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                                  = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                                  = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                          = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                              = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                          = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Roots   
    EntanglingRoots                                = Action.Create({ Type = "Spell", ID = 339    }),
    MassEntanglement                        = Action.Create({ Type = "Spell", ID = 102359, isTalent = true   }), 
    -- Disorient
	Cyclone                                    = Action.Create({ Type = "Spell", ID = 33786, isTalent = true   }), -- PvP Talent
	-- Stun
	MightyBash                                = Action.Create({ Type = "Spell", ID = 5211, isTalent = true   }),
	-- Knockbacks
	Typhoon                                    = Action.Create({ Type = "Spell", ID = 132469, isTalent = true   }),
    -- Hots
    Lifebloom                                  = Action.Create({ Type = "Spell", ID = 33763     }),
	Rejuvenation                                   = Action.Create({ Type = "Spell", ID = 774     }),
	RejuvenationGermimation                        = Action.Create({ Type = "Spell", ID = 155777    }),
    WildGrowth                                  = Action.Create({ Type = "Spell", ID = 48438     }),
	CenarionWard                                  = Action.Create({ Type = "Spell", ID = 102351, isTalent = true     }),
	-- Direct Heals
	Regrowth                                   = Action.Create({ Type = "Spell", ID = 8936     }),
	Swiftmend                                  = Action.Create({ Type = "Spell", ID = 18562     }),
    -- Self Defensives
    Barkskin                                  = Action.Create({ Type = "Spell", ID = 22812     }),
	-- Cooldowns
	Ironbark                                   = Action.Create({ Type = "Spell", ID = 102342     }),
	Tranquility                                   = Action.Create({ Type = "Spell", ID = 740     }),
    Innervate                                   = Action.Create({ Type = "Spell", ID = 29166     }),
    -- Shapeshift
    TravelForm                                   = Action.Create({ Type = "Spell", ID = 783     }), 
    BearForm                                     = Action.Create({ Type = "Spell", ID = 5487     }), 
    CatForm                                     = Action.Create({ Type = "Spell", ID = 768     }), 
    AquaticForm                                   = Action.Create({ Type = "Spell", ID = 276012     }), 	
    -- Utilities
	UrsolVortex                                   = Action.Create({ Type = "Spell", ID = 102793     }),
    NaturesCure                                   = Action.Create({ Type = "Spell", ID = 88423     }),  
	Dash                                   = Action.Create({ Type = "Spell", ID = 88423     }), 
	Rebirth                                   = Action.Create({ Type = "Spell", ID = 20484     }),  -- Combat Rez
	Revive                                   = Action.Create({ Type = "Spell", ID = 50769     }), 
	Hibernate                                   = Action.Create({ Type = "Spell", ID = 2637     }), 
	Soothe                                   = Action.Create({ Type = "Spell", ID = 50769     }), 
	Prowl                                   = Action.Create({ Type = "Spell", ID = 2908     }), 
	Revitalize                               = Action.Create({ Type = "Spell", ID = 212040     }), 
    -- Healing Spells      
    Efflorescence                                   = Action.Create({ Type = "Spell", ID = 145205     }),
	Renewal                                   = Action.Create({ Type = "Spell", ID = 108238, isTalent = true     }),
	-- Talents
	SouloftheForest                           = Action.Create({ Type = "Spell", ID = 102351, isTalent = true, Hidden = true     }),
	IncarnationTreeofLife                       = Action.Create({ Type = "Spell", ID = 33891, isTalent = true     }),
	Flourish                                   = Action.Create({ Type = "Spell", ID = 197721, isTalent = true     }),
	Photosynthesis                           = Action.Create({ Type = "Spell", ID = 274902, isTalent = true, Hidden = true     }),
	Germination                           = Action.Create({ Type = "Spell", ID = 155675, isTalent = true, Hidden = true     }),
	GuardianAffinity                         = Action.Create({ Type = "Spell", ID = 197721, isTalent = true, Hidden = true     }),
	FeralAffinity                           = Action.Create({ Type = "Spell", ID = 274902, isTalent = true, Hidden = true     }),
	BalanceAffinity                           = Action.Create({ Type = "Spell", ID = 155675, isTalent = true, Hidden = true     }),	
	InnerPeace                           = Action.Create({ Type = "Spell", ID = 197073, isTalent = true, Hidden = true     }),
	Stonebark                           = Action.Create({ Type = "Spell", ID = 197061, isTalent = true, Hidden = true     }),
	Prosperity                           = Action.Create({ Type = "Spell", ID = 200383, isTalent = true, Hidden = true     }),
	Abundance 	                                = Action.Create({ Type = "Spell", ID = 207383, isTalent = true, Hidden = true     }),
	SpringBlossoms                           = Action.Create({ Type = "Spell", ID = 207385, isTalent = true, Hidden = true     }),
	Cultivation                             = Action.Create({ Type = "Spell", ID = 200390, isTalent = true, Hidden = true     }),
    -- PvP Talents
	Disentanglement                                   = Action.Create({ Type = "Spell", ID = 233673, isTalent = true, Hidden = true     }),
	EntanglingBark                                   = Action.Create({ Type = "Spell", ID = 247543, isTalent = true, Hidden = true     }),
	EarlySpring                                   = Action.Create({ Type = "Spell", ID = 203624, isTalent = true, Hidden = true     }),
	Nourish                                   = Action.Create({ Type = "Spell", ID = 289022, isTalent = true     }),
	Overgrowth                                   = Action.Create({ Type = "Spell", ID = 203651, isTalent = true     }),
	Thorns                                   = Action.Create({ Type = "Spell", ID = 305497, isTalent = true     }),
	DeepRoots                                   = Action.Create({ Type = "Spell", ID = 233755, isTalent = true, Hidden = true     }),		
    MarkoftheWild                                   = Action.Create({ Type = "Spell", ID = 289318, isTalent = true     }),
	FocusedGrowth                                   = Action.Create({ Type = "Spell", ID = 203553, isTalent = true, Hidden = true     }),
	MasterShapeshifter                                   = Action.Create({ Type = "Spell", ID = 289237, isTalent = true     }),
	-- Azerites
    AutumnLeaves                                   = Action.Create({ Type = "Spell", ID = 274432, Hidden = true     }),
	EarlyHarvest                                   = Action.Create({ Type = "Spell", ID = 287251, Hidden = true     }),
	GroveTending                                   = Action.Create({ Type = "Spell", ID = 279778, Hidden = true     }),
	LivelySpirit                                   = Action.Create({ Type = "Spell", ID = 279642, Hidden = true     }),
	RampantGrowth                                   = Action.Create({ Type = "Spell", ID = 278515, Hidden = true     }),
	WakingDream                                   = Action.Create({ Type = "Spell", ID = 278513, Hidden = true     }),
	-- Offensives Spells
    Moonfire                                   = Action.Create({ Type = "Spell", ID = 164812     }),
	Sunfire                                   = Action.Create({ Type = "Spell", ID = 93402     }),
	SolarWrath                                   = Action.Create({ Type = "Spell", ID = 5176     }),
	-- Offensives abilities with Affinity
	-- Boomkin
	Starsurge                               = Action.Create({ Type = "Spell", ID = 5176     }),
	LunarStrike                               = Action.Create({ Type = "Spell", ID = 194153     }),
	MoonkinForm                               = Action.Create({ Type = "Spell", ID = 24858     }),
	-- Guardian
	FrenziedRegeneration                               = Action.Create({ Type = "Spell", ID = 22842     }),
	Ironfur                               = Action.Create({ Type = "Spell", ID = 192081     }),
	Thrash                               = Action.Create({ Type = "Spell", ID = 106832     }),
	-- Feral
	Swipe                               = Action.Create({ Type = "Spell", ID = 213764     }),
	Rip                               = Action.Create({ Type = "Spell", ID = 1079     }),
	FerociousBite                               = Action.Create({ Type = "Spell", ID = 22568     }),
	Rake                               = Action.Create({ Type = "Spell", ID = 1822     }),	
	Shred                              = Action.Create({ Type = "Spell", ID = 106785 }),
    -- Movememnt    

    -- Items
    
    -- Hidden 
    TigerTailSweep                            = Action.Create({ Type = "Spell", ID = 264348,     isTalent = true, Hidden = true }), -- 4/1 Talent +2y increased range of LegSweep    
    RisingMist                                = Action.Create({ Type = "Spell", ID = 274909,     isTalent = true, Hidden = true }), -- 7/3 Talent "Fistweaving Rotation by damage healing"
    SpiritoftheCrane                        = Action.Create({ Type = "Spell", ID = 210802,     isTalent = true, Hidden = true }), -- 3/2 Talent "Mana regen by BlackoutKick"
    Innervate                                = Action.Create({ Type = "Spell", ID = 29166,     Hidden = true }), -- Buff condition for Mana Tea and Mana Saving
    TeachingsoftheMonastery                    = Action.Create({ Type = "Spell", ID = 202090,     Hidden = true }), -- Buff condition for Blackout Kick
}

Action:CreateEssencesFor(ACTION_CONST_DRUID_RESTORATION)
local A = setmetatable(Action[ACTION_CONST_DRUID_RESTORATION], { __index = Action })

local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                                = {"TotalImun", "DamageMagicImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = 
GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 and A.MightyBash:IsSpellLearned() and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.MightyBash:IsReady(nil, nil, nil, true) and A.MightyBash:IsSpellLearned() and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        AntiFakeStun("targettarget") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and             
            not A.IsUnitEnemy("targettarget") and            
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 5)) or 
                (not A.IsInPvP and MultiUnits:GetByRange(5, 1) >= 1)
            )
        )
    )
    then 
        return A.MightyBash:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    elseif A.IsUnitEnemy("targettarget") then 
        unit = "targettarget"
    end 
    
    if unit then         
        local total, sleft, _, _, _, notKickAble = Unit(unit):CastTime()
        if sleft > 0 then                                     
            if A.MightyBash:IsReady(unit, nil, nil, true) and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then
                return A.MightyBash:Show(icon)                  
            end 
            
            -- Racials 
            if A.QuakingPalm:IsRacialReadyP(unit, nil, nil, true) then 
                return A.QuakingPalm:Show(icon)
            end 
            
            if A.Haymaker:IsRacialReadyP(unit, nil, nil, true) then 
                return A.Haymaker:Show(icon)
            end 
            
            if A.WarStomp:IsRacialReadyP(unit, nil, nil, true) then 
                return A.WarStomp:Show(icon)
            end 
            
            if A.BullRush:IsRacialReadyP(unit, nil, nil, true) then 
                return A.BullRush:Show(icon)
            end                         
        end 
    end                                                                                 
end

-----------------------------------------
--                 ROTATION  
-----------------------------------------
--[[
local function ChiJi()
    -- InvokeChiJitheRedCrane
    for i = 1, MAX_TOTEMS do 
        local have, name, start, duration = GetTotemInfo(i)
        if duration and duration == 25 then 
            return duration - (TMW.time - start)
        end 
    end 
    return 0
end
]]

-- Return number
-- Efflorescence duration left
local function Efflorescence()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 134222 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end

-- Return boolean
-- Current HPS > Incoming damage
local function IsEnoughHPS(unit)
    return Unit("player"):GetHPS() > Unit(unit):GetDMG()
end 

local function IsSaveManaPhase()
    if not A.IsInPvP and A.GetToggle(2, "ManaManagement") and Unit("player"):HasBuffs(A.Innervate.ID) == 0 then 
        for i = 1, MAX_BOSS_FRAMES do 
            if Unit("boss" .. i):IsExists() and not Unit("boss" .. i):IsDead() and Unit("player"):PowerPercent() < Unit("boss" .. i):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit("player"):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)

-- Cached parts 
-- PvP: Balance Solar Interrupt 
UnitCooldown:Register("arena", 78675, 60) 
-- PvP: Mage Counterspell
UnitCooldown:Register("arena", 2139, 24)
--[[local function CanZenFocusTea(mode, true)
    if A.IsInPvP and A.ZenFocusTea:IsReady(nil, nil, nil, true) and Unit("player"):HasBuffs(A.ZenFocusTea.ID, true) == 0 then 
        -- If melee is around (doesn't tracking their kick but anyway)
        if not mode and EnemyTeam("DAMAGER_MELEE"):GetUnitID(15) ~= "none" then 
            return true 
        end 
        
        -- Catch Balance Interrupt if enemy in burst or while rooted
        if UnitCooldown:GetCooldown("arena", 78675) == 0 then 
            local UnitBalance = EnemyTeam("DAMAGER_RANGE"):GetUnitID(40, 102)         
            if UnitBalance ~= "none" and Unit(UnitBalance):InCC() == 0 and Unit("player"):HasBuffs("Reflect") == 0 then
                -- If rooted 
                if mode == "CATCH" and LoC:Get("ROOT") > 0 then 
                    return true   
                end 
                -- If bursting 
                if not mode and (EnemyTeam("DAMAGER"):GetBuffs("DamageBuffs", 40) > 0 or FriendlyTeam():GetTTD(1, 8)) then 
                    return true 
                end 
            end 
        end 
        
        -- Catch Mage Interrupt if enemy in burst or through Blink / Shrimmer 
        if not mode and UnitCooldown:GetCooldown("arena", 2139) == 0 then 
            local UnitMage = EnemyTeam("DAMAGER_RANGE"):GetUnitID(60, {62, 63, 64})
            if UnitMage ~= "none" and Unit(UnitMage):InCC() == 0 and Unit("player"):HasBuffs("Reflect") == 0 then
                -- If Blink / Shrimmer  
                if Unit(UnitMage):GetRange() > 40 and Unit(UnitMage):GetBlinkOrShrimmer() <= 1.5 then 
                    return true   
                end 
                -- If bursting 
                if EnemyTeam("DAMAGER"):GetBuffs("DamageBuffs", 40) > 0 or FriendlyTeam():GetTTD(1, 8) then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanZenFocusTea = A.MakeFunctionCachedDynamic(CanZenFocusTea)  ]]--

local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    --if CanZenFocusTea("CATCH", true) then 
    --    return A.ZenFocusTea
    --end 
    
	-- Barkskin
    local Barkskin = A.GetToggle(2, "Barkskin")
    if     Barkskin >= 0 and A.Barkskin:IsReady("player", nil, nil, true) and IsSchoolFree() and
    (
        (     -- Auto 
            Barkskin >= 85 and 
            (
                Unit("player"):HealthPercent() <= 50 or
                (                        
                    Unit("player"):HealthPercent() < 70 and 
                    A.Barkskin:GetSpellChargesFrac() > 1.1
                )
            )
        ) or 
        (    -- Custom
            Barkskin < 85 and 
            Unit("player"):HealthPercent() <= Barkskin
        )
    ) 
    then 
        return A.Barkskin
    end 
    
	-- Iron Bark
    local Ironbark = A.GetToggle(2, "Ironbark")
    if     Ironbark >= 0 and A.Ironbark:IsReady("player", nil, nil, true) and
    (
        (     -- Auto 
            Ironbark >= 100 and 
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
            Ironbark < 100 and 
            Unit("player"):HealthPercent() <= Ironbark
        )
    ) 
    then 
        return A.Ironbark
    end 
    
	-- Bear Form
    local BearForm = A.GetToggle(2, "BearForm")
    if     BearForm >= 0 and A.BearForm:IsReady("player", nil, nil, true) and
    (
        (     -- Auto 
            BearForm >= 100 and 
            Unit("player"):TimeToDieMagicX(35) < 4 and 
            -- Magic Damage still appear
            Unit("player"):GetRealTimeDMG(4) > 0 and 
            Unit("player"):HasBuffs("DeffBuffsMagic") == 0
        ) or 
        (    -- Custom
            BearForm < 100 and 
            Unit("player"):HealthPercent() <= BearForm
        )
    ) 
    then 
        return A.BearForm
    end
    
    -- Stoneform on defensive
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

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")
    
    if useCC and A.MightyBash:IsReady(unit, nil, nil, true) and A.MightyBash:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.MightyBash              
    end             
    
    if useRacial and A.QuakingPalm:AutoRacial(unit, nil, nil, true) then 
        return A.QuakingPalm
    end 
    
    if useRacial and A.Haymaker:AutoRacial(unit, nil, nil, true) then 
        return A.Haymaker
    end 
    
    if useRacial and A.WarStomp:AutoRacial(unit, nil, nil, true) then 
        return A.WarStomp
    end 
    
    if useRacial and A.BullRush:AutoRacial(unit, nil, nil, true) then 
        return A.BullRush
    end      
    
    if useCC and A.LegSweep:IsReady(unit, true, nil, true) and Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and Unit(unit):IsCastingRemains() > A.GetCurrentGCD() + 0.1 and A.LegSweep:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
        return A.LegSweep     
    end 
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CanTranquility()
    if A.Tranquility:IsReady(unit, true, nil, true) and IsSchoolFree() then 
        local TranquilityHP = A.GetToggle(2, "Tranquility")
        local TranquilityUnits = A.GetToggle(2, "TranquilityUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
        -- Auto Counter
        if TranquilityUnits > 40 then 
            TranquilityUnits = HealingEngine.GetMinimumUnits(1)
            -- Reduce size in raid by 20%
            if TranquilityUnits > 5 then 
                TranquilityUnits = TranquilityUnits - (#totalMembers * 0.2)
            end 
            -- If user typed counter higher than max available members 
        elseif TranquilityUnits >= TeamCache.Friendly.Size then 
            TranquilityUnits = TeamCache.Friendly.Size
        end 
        
        if TranquilityUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            -- Auto HP 
            if TranquilityHP >= 100 and A.Tranquility:PredictHeal("Tranquility", totalMembers[i].Unit, 400) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if TranquilityHP < 100 and totalMembers[i].HP <= TranquilityHP then 
                counter = counter + 1
            end 
            
            if counter >= TranquilityUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanTranquility = A.MakeFunctionCachedStatic(CanTranquility)

local function CanFlourish()
    if A.Flourish:IsReady(unit, true, nil, true) and IsSchoolFree() then 
        local FlourishHP = A.GetToggle(2, "Flourish")
        local FlourishUnits = A.GetToggle(2, "FlourishUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
        -- Auto Counter
        if FlourishUnits > 40 then 
            FlourishUnits = HealingEngine.GetMinimumUnits(1)
            -- Reduce size in raid by 35%
            if FlourishUnits > 5 then 
                FlourishUnits = FlourishUnits - (#totalMembers * 0.35)
            end 
            -- If user typed counter higher than max available members 
        elseif FlourishUnits >= TeamCache.Friendly.Size then 
            FlourishUnits = TeamCache.Friendly.Size
        end 
        
        if FlourishUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            -- Auto HP 
            if FlourishHP >= 100 and A.Flourish:PredictHeal("Flourish", totalMembers[i].Unit, 1500) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if FlourishHP < 100 and totalMembers[i].HP <= FlourishHP then 
                counter = counter + 1
            end 
            
            if counter >= FlourishUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanFlourish = A.MakeFunctionCachedStatic(CanFlourish)

local function CanWildGrowth()
    if A.WildGrowth:IsReady(unit, true, nil, true) and IsSchoolFree() then 
        local WildGrowthHP = A.GetToggle(2, "WildGrowth")
        local WildGrowthUnits = A.GetToggle(2, "WildGrowthUnits") 
        local totalMembers = HealingEngine.GetMembersAll()
        -- Auto Counter
        if WildGrowthUnits > 6 then 
            WildGrowthUnits = HealingEngine.GetMinimumUnits(IsSaveManaPhase() and 0 or 1, 6)
        end
        
        if WildGrowthUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 30 then 
                -- Auto HP 
                if WildGrowthHP >= 100 and A.WildGrowth:PredictHeal("WildGrowth", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                -- Custom HP 
                if WildGrowthHP < 100 and totalMembers[i].HP <= WildGrowthHP then 
                    counter = counter + 1
                end 
                
                if counter >= WildGrowthUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanWildGrowth = A.MakeFunctionCachedStatic(CanWildGrowth)

local function ShouldRejuvenation()
    if A.Rejuvenation:IsReady(unit, true, nil, true) and IsSchoolFree() then 
        local totalMembers = HealingEngine.GetMembersAll()		 
        local RejuvenationUnits = HealingEngine.GetMinimumUnits(2, 4)
        
        if RejuvenationUnits < 2 and not A.IsInPvP then 
            return false 
        end
		
        local RejuvenationCount = 0
        local counter = 0 
		
		-- Get number of Rejuvenation for all members
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 40 then 
			    if Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) > 0 and not A.Germination:IsSpellLearned() then
				    RejuvenationCount = RejuvenationCount + 1
				elseif Unit(totalMembers[i].Unit):HasBuffs(A.Rejuvenation.ID, true) > 0 and not Unit(totalMembers[i].Unit):HasBuffs(A.Germination.ID, true) > 0 and A.Germination:IsSpellLearned() then
					RejuvenationCount = RejuvenationCount + 0.5
                else
                    return				
				end
				
                if A.Rejuvenation:PredictHeal("Rejuvenation", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                if counter >= RejuvenationCount then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
ShouldRejuvenation = A.MakeFunctionCachedStatic(ShouldRejuvenation)


local function CanRefreshingJadeWind()
    if A.RefreshingJadeWind:IsReady(unit, true, nil, true) and IsSchoolFree() then 
        local totalMembers = HealingEngine.GetMembersAll()
        local RefreshingJadeWindUnits = HealingEngine.GetMinimumUnits(2, 4)
        
        if RefreshingJadeWindUnits < 2 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 10 then 
                if A.RefreshingJadeWind:PredictHeal("RefreshingJadeWind", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                if counter >= RefreshingJadeWindUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end
CanRefreshingJadeWind = A.MakeFunctionCachedStatic(CanRefreshingJadeWind)

local function CanChiWave()
    if A.ChiWave:IsReady(unit, true, nil, true) and IsSchoolFree() then 
        local totalMembers = HealingEngine.GetMembersAll()
        local ChiWaveUnits = HealingEngine.GetMinimumUnits(2, 4)
        
        if ChiWaveUnits < 2 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 25 then 
                if A.ChiWave:PredictHeal("ChiWave", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                if counter >= ChiWaveUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanChiWave = A.MakeFunctionCachedStatic(CanChiWave)

local function CanChiBurst()
    if not Player:IsMoving() and A.ChiBurst:IsReady(unit, true, nil, true) and IsSchoolFree() then 
        local totalMembers = HealingEngine.GetMembersAll()
        local ChiBurstUnits = HealingEngine.GetMinimumUnits(2, 4)
        
        if ChiBurstUnits < 2 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #totalMembers do 
            if Unit(totalMembers[i].Unit):GetRange() <= 40 then 
                if A.ChiBurst:PredictHeal("ChiBurst", totalMembers[i].Unit) then 
                    counter = counter + 1
                end 
                
                if counter >= ChiBurstUnits then 
                    return true 
                end 
            end 
        end 
    end 
    return false 
end 
CanChiBurst = A.MakeFunctionCachedStatic(CanChiBurst)

local StopCast = false 
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    local unit                     = "player"
    local isMoving                 = Player:IsMoving()
    --local true = Unit(unit):IsCastingRemains(A.SoothingMist.ID) > 0
    local inRange                 = false
    
    local function DamageRotation(unit)
        inRange = A.Sunfire:IsInRange(unit)
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit, nil, nil, true) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- Interrupts
        local Interrupt = Interrupts(unit, true)
        if Interrupt then 
            return Interrupt:Show(icon)
        end         
		
        -- PvP MightyBash (@targettarget)
        if unit == "target" and A.IsUnitEnemy("targettarget") and A.MightyBashIsReady("targettarget", false, true) then 
            return A.MightyBash:Show(icon)
        end 
        
        -- PvP MightyBash (Enemy Healer)
        if A.IsInPvP and A.MightyBash:IsReady(nil, nil, nil, true) then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(25)
            
            if EnemyHealerUnitID ~= "none" and A.MightyBash:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("stun", 0) and Unit(EnemyHealerUnitID):InCC() <= A.GetCurrentGCD() then
                return A.MightyBash:Show(icon)     
            end 
        end 
        
        -- Bursting 
        if A.BurstIsON(unit) and inRange and A.AbsentImun(nil, unit, Temp.TotalAndPhys) then 
            if A.WayoftheCrane:IsReady(unit, true, nil, true) then 
                return A.WayoftheCrane:Show(icon)
            end 
            
            if Unit(unit):HealthPercent() <= A.GetToggle(2, "RacialBurstDamaging") then 
                if A.BloodFury:AutoRacial(unit, nil, nil, true) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit, nil, nil, true) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit, nil, nil, true) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit, nil, nil, true) then 
                    return A.Berserking:Show(icon)
                end 
            end 
        end
        
        -- Trinkets 
        if inRange and A.AbsentImun(nil, unit, Temp.TotalAndMag) and Unit(unit):HealthPercent() <= A.GetToggle(2, "TrinketBurstDamaging") then 
            if A.Trinket1:IsReady(unit, nil, nil, true) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit, nil, nil, true) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end     
        end     
        
        -- Rotation DPS

		-- Balance Affinity rotation
        if A.BalanceAffinity:IsSpellLearned() and IsEnoughHPS(unit) then 
		    -- MoonkinForm
			if A.MoonkinForm:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.MoonkinForm.ID, true) == 0 then
			    return A.MoonkinForm:Show(icon)
			end			
			-- Starsurge
			if A.Starsurge:IsReady(unit, nil, nil, true) and A.Player:AstralPower() >= 40 then
			    return A.Starsurge:Show(icon)
			end
			-- LunarStrike
   			if A.LunarStrike:IsReady(unit, nil, nil, true)   then
			    return A.LunarStrike:Show(icon)
			end
        end
		-- Feral Affinity rotation
        if A.FeralAffinity:IsSpellLearned() and IsEnoughHPS(unit) then 
		    -- Catform
			if A.Catform:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.CatForm.ID, true) == 0 then
			    return A.Catform:Show(icon)
			end	
			-- Prowl
			if A.Prowl:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.Prowl.ID, true) == 0 then
			    return A.Prowl:Show(icon)
			end				
		    -- Rake
			if A.Rake:IsReady(unit, nil, nil, true) and Unit(unit):HasDeBuffs(A.Rake.ID) <= 2 then
			    return A.Rake:Show(icon)
			end			
			-- Rip
			if A.Rip:IsReady(unit, nil, nil, true) and Unit(unit):HasDeBuffs(A.Rake.ID) > 2 and Unit(unit):HasDeBuffs(A.Rip.ID) <= 2 then
			    return A.Rip:Show(icon)
			end
			-- FerociousBite
   			if A.FerociousBite:IsReady(unit, nil, nil, true) and MultiUnits:GetByRange(25, 3) < 2 and Unit(unit):HasDeBuffs(A.Rake.ID) > 2 and Unit(unit):HasDeBuffs(A.Rip.ID) > 2 then
			    return A.FerociousBite:Show(icon)
			end
			-- Shred aoe
   			if A.Shred:IsReady(unit, nil, nil, true) and MultiUnits:GetByRange(25, 3) >= 3  then
			    return A.Shred:Show(icon)
			end
        end 		
		-- Sunfire
        if A.Sunfire:IsReady(unit, nil, nil, true) and IsEnoughHPS(unit) and A.Sunfire:AbsentImun(unit, Temp.TotalAndMag) and (Unit(unit):HasDeBuffs(A.Sunfire.ID) <= 2 or Unit(unit):HasDeBuffs(A.Sunfire.ID) == 0) then 
            return A.Sunfire:Show(icon)
        end 
        -- Moonfire
        if A.Moonfire:IsReady(unit, nil, nil, true) and IsEnoughHPS(unit) and A.Moonfire:AbsentImun(unit, Temp.TotalAndMag) and (Unit(unit):HasDeBuffs(A.Moonfire.ID) <= 2 or Unit(unit):HasDeBuffs(A.Moonfire.ID) == 0)then 
            return A.Moonfire:Show(icon)
        end        
        -- SolarWrath
   		if A.SolarWrath:IsReady(unit, nil, nil, true) and IsEnoughHPS(unit) then
		    return A.SolarWrath:Show(icon)
		end       
        -- Azerite Essence 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if     (isMulti or A.GetToggle(2, "AoE")) and A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and A.RippleinSpace:AbsentImun(unit, Temp.TotalAndMag) and MultiUnits:GetByRange(25, 3) >= 3 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)    
        ) 
        then 
            return A.RippleinSpace:Show(icon)
        end 
        
        -- Continue Rotation 
        if (isMulti or A.GetToggle(2, "AoE")) and A.ArcanePulse:AutoRacial(unit, true, nil, true) then 
            return A.ArcanePulse:Show(icon)
        end 
        
        if     (isMulti or A.GetToggle(2, "AoE")) and A.MightyBash:IsReady(unit, true, nil, true) and A.MightyBash:AbsentImun(unit, Temp.TotalAndMag) and MultiUnits:GetByRange(8, 3) >= 3 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(8)                
        )
        then 
            return A.MightyBash:Show(icon)
        end 
                   
    end 
    
    local function HealingRotation(unit)
        --local isAffectedByRejuvenation = Unit(unit):HasBuffs(A.isAffectedByRejuvenation.ID, true) > 0 and true
		--local isAffectedByWildGrowth = Unit(unit):HasBuffs(A.isAffectedByWildGrowth.ID, true) > 0 and true
		
        -- Stopcasting 
        --if A.GetToggle(1, "StopCast") and true and ((A.GetToggle(2, "SoothingMistStopCast")[1] and not isAffectedBySoothingMist) or (A.GetToggle(2, "SoothingMistStopCast")[2] and isAffectedBySoothingMist and Unit(unit):HealthPercent() >= 100 and IsEnoughHPS(unit))) then 
        --    StopCast = true -- passing to A[6]
        --    return             
        --end         
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit, nil, nil, true) then 
            return A.ArcaneTorrent:Show(icon)
        end     
        
        -- Out of combat / Precombat
        if Unit("player"):CombatTime() == 0 then 
			-- Prowl
			--if A.Prowl:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.Prowl.ID, true) == 0 then
			--    return A.Prowl:Show(icon)
			--end	
            -- Mass Rez
			if A.Revitalize:IsReady(unit, true, nil, true) and Unit(unit):InGroup() and Unit(unit):IsDead() and Unit(unit):IsPlayer() and Unit(unit):GetRange() <= 100 and not isMoving and IsSchoolFree() then 
                return A.Revitalize:Show(icon)
            end 
            -- Rez
            if A.Revive:IsReady(unit, nil, nil, true) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolFree() then 
                return A.Revive:Show(icon)
            end 
            -- Efflorescence out of combat
            if A.Efflorescence:IsReady(unit, true, nil, true) and Efflorescence() <= 5 and Player:IsStayingTime() > 3 and IsSchoolFree() then 
                return A.Efflorescence:Show(icon)
            end 
            
			-- BossMods
            local Pull = A.BossMods_Pulling()  
            if Pull > 0 then 
                -- Timing
                local extra_time = A.GetCurrentGCD() + 0.1
                local Lifebloom, Rejuvenation, WildGrowth, TigersLust
                if A.Lifebloom:IsReady(unit, nil, nil, true) and A.Lifebloom:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.Lifebloom.ID, true) == 0 then 
                    Lifebloom = true 
                    extra_time = extra_time + A.GetGCD()
                end 
                
                if A.Rejuvenation:IsReady(unit, nil, nil, true) and A.Rejuvenation:AbsentImun(unit) and isMoving and IsSchoolFree() then 
                    Rejuvenation = true 
                    extra_time = extra_time + Unit("player"):CastTime(A.Rejuvenation.ID)
                end 
                
                if (isMulti or A.GetToggle(2, "AoE")) and A.WildGrowth:IsReady(unit, true, nil, true) and not isMoving and IsSchoolFree() then 
                    WildGrowth = true 
                    extra_time = extra_time + Unit("player"):CastTime(A.WildGrowth.ID)
                end                 
                
                -- Pull Rotation
                if Lifebloom and Pull <= extra_time then 
                    if A.Rejuvenation:IsReady(unit, true, nil, true) and Unit("player"):HasBuffs(A.Rejuvenation.ID, true) == 0 then
                        return A.Rejuvenation:Show(icon)
                    end 
                    if not A.ShouldStop() then 
                        return A.Lifebloom:Show(icon)
                    end 
                end 
                
                if Rejuvenation and not A.ShouldStop() and Pull <= extra_time then 
                    return A.Rejuvenation:Show(icon)
                end 
                
                if WildGrowth and not A.ShouldStop() and Pull <= extra_time then 
                    return A.WildGrowth:Show(icon)
                end                  
                
                return 
            end 
            
            if A.Efflorescence:IsReady(unit, true, nil, true) and IsSchoolFree() and (not A.GetToggle(2, "MouseButtonsCheck") or (not IsMouseButtonDown("LeftButton") and not IsMouseButtonDown("RightButton"))) then 
                return A.Efflorescence:Show(icon)
            end 
        end 
        
        -- Interrupts (@targettarget)
        if unit == "target" and A.IsUnitEnemy("targettarget") then 
            local Interrupt = Interrupts("targettarget", true)
            if Interrupt then 
                return Interrupt:Show(icon)
            end 
        end    
        
        -- Bursting 
        if A.BurstIsON(unit) then 
            -- Multi (for [4])
            if isMulti then 
                if CanTranquility(true) then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Tranquility:Show(icon)
                end 
                
                if CanFlourish(true) then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Flourish:Show(icon)
                end 
                
                -- Azerite Essence
                if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, true) then 
                    return A.LifeBindersInvocation:Show(icon)
                end             
            end 
            
            -- Single 
            if A.Ironbark:IsReady(unit, nil, nil, true) and A.Ironbark:AbsentImun(unit) and IsSchoolFree() then 
                local Ironbark = A.GetToggle(2, "Ironbark")
                
                -- Auto 
                if     Ironbark >= 100 and not IsEnoughHPS(unit) and Unit(unit):HasBuffs("DeffBuffs") == 0 and (
                    (Unit(unit):TimeToDieX(20) < 3 and Unit(unit):HealthPercent() < 60) or 
                    (A.IsInPvP and Unit(unit):HealthPercent() < 80 and (Unit(unit):HasDeBuffs("DamageDeBuffs") > 5 or Unit(unit):IsExecuted()))
                ) 
                then 
                    return A.Ironbark:Show(icon)
                end 
                
                -- Custom 
                if Ironbark < 100 and Unit(unit):HealthPercent() <= Ironbark then 
                    return A.Ironbark:Show(icon)
                end 
            end                         
            
            -- Azerite Essence
            if A.Standstill:AutoHeartOfAzeroth(unit, true) then 
                return A.Standstill:Show(icon)
            end 
            
            -- Racial 
            local RacialBurstHealing = A.GetToggle(2, "RacialBurstHealing")            
            if  Unit(unit):InRange() and A.AbsentImun(nil, unit) and 
            (
                -- Auto
                (RacialBurstHealing >= 100 and not IsEnoughHPS(unit) and (Unit(unit):TimeToDieX(45) < 5 or (A.IsInPvP and Unit(unit):UseBurst()))) or 
                -- Custom            
                (RacialBurstHealing < 100 and Unit(unit):HealthPercent() <= RacialBurstHealing)
            )
            then 
                if A.BloodFury:AutoRacial(unit, nil, nil, true) then 
                    return A.BloodFury:Show(icon)
                end 
                
                if A.Fireblood:AutoRacial(unit, nil, nil, true) then 
                    return A.Fireblood:Show(icon)
                end 
                
                if A.AncestralCall:AutoRacial(unit, nil, nil, true) then 
                    return A.AncestralCall:Show(icon)
                end 
                
                if A.Berserking:AutoRacial(unit, nil, nil, true) then 
                    return A.Berserking:Show(icon)
                end             
            end 
            
            -- AoE
            if not isMulti and A.GetToggle(2, "AoE") then 
                if CanTranquility(true) then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Tranquility:Show(icon)
                end 
                
                if CanFlourish(true) then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and not IsEnoughHPS(unit) and Unit("player"):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Flourish:Show(icon)
                end 
                
                -- Azerite Essence
                if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit, true) then 
                    return A.LifeBindersInvocation:Show(icon)
                end                                 
            end 
        end 
        
        -- PvP MightyBash (@targettarget)
        if unit == "target" and A.IsUnitEnemy("targettarget") and A.MightyBashIsReady("targettarget", false, true) then 
            return A.MightyBash:Show(icon)
        end 
        
        -- PvP MightyBash (Enemy Healer)
        if A.IsInPvP and A.MightyBash:IsReady(nil, nil, nil, true) then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(25)
            
            if EnemyHealerUnitID ~= "none" and A.MightyBash:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("stun", 0) and Unit(EnemyHealerUnitID):InCC() <= A.GetCurrentGCD() then
                return A.MightyBash:Show(icon)     
            end 
        end 
        
        -- Racial 
        if A.GiftofNaaru:AutoRacial(unit, nil, nil, true) and Unit(unit):HealthPercent() <= A.GetToggle(2, "RacialBurstHealing") then 
            return A.GiftofNaaru:Show(icon)
        end 
        
        -- Trinkets         
        if A.AbsentImun(nil, unit) and Unit(unit):HealthPercent() <= A.GetToggle(2, "TrinketBurstHealing") and Unit(unit):InRange() then 
            if A.Trinket1:IsReady(unit, nil, nil, true) and A.Trinket1:GetItemCategory() ~= "DPS" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit, nil, nil, true) and A.Trinket2:GetItemCategory() ~= "DPS" then 
                return A.Trinket2:Show(icon)
            end     
        end     
        
        -- Rotation         
        if A.NaturesCure:IsReady(unit, nil, nil, true) and A.NaturesCure:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel") and Unit(unit):TimeToDie() > 5 then 
            return A.NaturesCure:Show(icon)
        end 
        
		-- Dash
        if A.Dash:IsReady(unit, nil, nil, true) and A.Dash:AbsentImun(unit) and IsSchoolFree() and Unit(unit):TimeToDie() > 6 then 
            if Unit(unit):HasDeBuffs("Rooted") > 1.5 then 
                return A.Dash:Show(icon)
            end 
            
            local cUnitSpeed = Unit(unit):GetCurrentSpeed()
            if cUnitSpeed > 0 and cUnitSpeed < 64 and (UnitIsUnit(unit, "player") or Unit(unit):IsMelee()) then 
                return A.Dash:Show(icon)
            end 
        end 
        
		-- NaturesCure
        if A.NaturesCure:IsReady(unit, nil, nil, true) and A.NaturesCure:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "MagicMovement") and Unit(unit):TimeToDie() > 12 then 
            return A.NaturesCure:Show(icon)
        end 
        
        if (isMulti or A.GetToggle(2, "AoE")) then 
            if A.VitalityConduit:AutoHeartOfAzeroth(unit, true) then 
                return A.VitalityConduit:Show(icon)
            end
            
            if CanWildGrowth(true) then                 
                if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and (not IsEnoughHPS(unit) or HealingEngine.GetIncomingDMGAVG() > HealingEngine.GetIncomingHPSAVG() + 10) then 
                    return A.OverchargeMana:Show(icon)
                end 
                
                return A.WildGrowth:Show(icon)
            end 
        end 
        
        -- Multi (for [4])
        if isMulti then 
            if CanWildGrowth(true) then                 
                if A.OverchargeMana:AutoHeartOfAzerothP(unit, true) and (not IsEnoughHPS(unit) or HealingEngine.GetIncomingDMGAVG() > HealingEngine.GetIncomingHPSAVG() + 10) then 
                    return A.OverchargeMana:Show(icon)
                end 
                
                return A.WildGrowth:Show(icon)
            end 
            if ShouldRejuvenation(true) then 
                return A.Rejuvenation:Show(icon)
            end 
            if Efflorescence() <= 3 then 
                return A.Efflorescence:Show(icon)
            end 
        end
        
        -- Super Emergency 
        local Emergency = Unit(unit):TimeToDieX(25) < 4 and Unit(unit):HealthPercent() <= 60
        if not true and Emergency and A.Swiftmend:IsReady(unit) and Unit(unit):DeBuffCyclone() == 0 and IsSchoolFree() and Unit(unit):HealthPercent() <= A.GetToggle(2, "SwiftmendHP") then 
            if A.Ironbark:IsReady(unit, true, nil, true) and Unit(unit):TimeToDie() > 3 then 
                return A.Ironbark:Show(icon)
            end     
            if not isMoving then
                if A.Regrowth:IsReady(unit, true, nil, true) then 
                    return A.Regrowth:Show(icon)
                end                
            end
			return A.Swiftmend:Show(icon)
        end 
        
        -- Innervate Bomb combo
        if true and Emergency and A.Innervate:IsReady(unit, nil, nil, true) and IsSchoolFree() then 
            -- Refresh Efflorescence
			if Unit(unit):HasBuffs(A.Innervate.ID) > 10 then
                return A.Efflorescence:Show(icon)
            end			
			-- Maximize Rejuvenation on group
			if ShouldRejuvenation(nil, true) and Unit(unit):HasBuffs(A.Innervate.ID) >= 5 then 
                return A.Rejuvenation:Show(icon)
            end 
            -- Then Apply Wild Growth            
            if CanWildGrowth(true) and HealingEngine.GetIncomingDMGAVG() > HealingEngine.GetIncomingHPSAVG() + 10 and Unit(unit):HasBuffs(A.Innervate.ID) >= 2 then
                return A.WildGrowth:Show(icon)
            end
            -- and use Flourish for burst			
            if Unit("player"):GetSpellLastCast(A.WildGrowth.ID, true) <= 2 and Unit(unit):HasBuffs(A.Innervate.ID) > 0.1  then
                return A.Flourish:Show(icon)
            end	
        end 
            
        
        -- Continue Rotation                    
        
        if not isMulti and A.GetToggle(2, "AoE") then 
            if CanWildGrowth(true) then
                return A.WildGrowth:Show(icon)
            end 
            if ShouldRejuvenation(true) then 
                return A.Rejuvenation:Show(icon)
            end 
        end
		
		-- Catweaving rotation (@targettarget)
        if unit == "target" and A.IsUnitEnemy("targettarget") and A.FeralAffinity:IsSpellLearned() and IsEnoughHPS(unit) then 
		    inRange = A.Rake:IsInRange("targettarget")
			
		    -- Catform
			if A.Catform:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.CatForm.ID, true) == 0 then
			    return A.Catform:Show(icon)
			end	
			-- Prowl
			if A.Prowl:IsReady(unit, nil, nil, true) and Unit("player"):HasBuffs(A.Prowl.ID, true) == 0 then
			    return A.Prowl:Show(icon)
			end				
		    -- Rake
			if A.Rake:IsReady(unit, nil, nil, true) and Unit(unit):HasDeBuffs(A.Rake.ID) <= 2 then
			    return A.Rake:Show(icon)
			end			
			-- Rip
			if A.Rip:IsReady(unit, nil, nil, true) and Unit(unit):HasDeBuffs(A.Rake.ID) > 2 and Unit(unit):HasDeBuffs(A.Rip.ID) <= 2 then
			    return A.Rip:Show(icon)
			end
			-- FerociousBite
   			if A.FerociousBite:IsReady(unit, nil, nil, true) and MultiUnits:GetByRange(25, 3) < 2 and Unit(unit):HasDeBuffs(A.Rake.ID) > 2 and Unit(unit):HasDeBuffs(A.Rip.ID) > 2 then
			    return A.FerociousBite:Show(icon)
			end
			-- Shred aoe
   			if A.Shred:IsReady(unit, nil, nil, true) and MultiUnits:GetByRange(25, 3) >= 3  then
			    return A.Shred:Show(icon)
			end
        end        
        
        -- Azerite Essences 
        if Unit("player"):CombatTime() > 0 and A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Unit("player"):PowerPercent() < 85 and (not A.ManaTea:IsSpellLearned() or Unit("player"):HasBuffs(A.ManaTea.ID, true) == 0) then 
            return A.MemoryofLucidDreams:Show(icon)
        end         
        
        if Unit("player"):CombatTime() > 0 and A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Player:IsStayingTime() > 2 then 
            return A.WorldveinResonance:Show(icon)
        end  		
        
        -- Misc 
        local Mana = A.GetToggle(2, "ManaPotion") 
        if Unit("player"):CombatTime() > 0 and Mana > 0 and Unit("player"):PowerPercent() <= Mana then 
            if A.PotionofReconstitution:IsReady("player", true, nil, true) and not isMoving and Player:IsStayingTime() > 1.5 then 
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP("player", true) then 
                    return A.MemoryofLucidDreams:Show(icon)
                end 
                
                return A.PotionofReconstitution:Show(icon)                
            end 
            
            if A.CoastalManaPotion:IsReady("player", true, nil, true) then 
                return A.CoastalManaPotion:Show(icon)
            end 
        end 
        
        -- Azerite Essences 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if A.Refreshment:AutoHeartOfAzeroth(unit, true) then 
            return A.Refreshment:Show(icon)
        end 
        
        -- Normal Rotation 
        local LifebloomHP = A.GetToggle(2, "LifebloomHP")
        if     not true and A.SoothingMist:IsReady(unit) and Unit(unit):DeBuffCyclone() == 0 and IsSchoolFree() and 
        ( 
            (
                LifebloomHP < 100 and 
                Unit(unit):HealthPercent() <= LifebloomHP  
            ) or 
            (
                LifebloomHP >= 100 and 
                A.Rejuvenation:PredictHeal("Rejuvenation", unit, 200)
            )
        )
        then
            local LifebloomWorkMode = A.GetToggle(2, "LifebloomWorkMode")
            if     LifebloomWorkMode == "Always" or 
            (
                (LifebloomWorkMode == "Auto" or LifebloomWorkMode == "Tanking Units") and 
                (Unit(unit):IsTank() or Unit(unit):IsTanking("targettarget"))
            ) or 
            (
                (LifebloomWorkMode == "Auto" or LifebloomWorkMode == "Mostly Inc. Damage") and 
                HealingEngine.IsMostlyIncDMG(unit)
            ) or 
            (
                (LifebloomWorkMode == "Auto" or LifebloomWorkMode == "HPS < Inc. Damage") and 
                not IsEnoughHPS(unit)
            )
            then 
                if A.CenarionWard:IsReady() and CenarionWard.GetRange() < 40 then 
                    return A.CenarionWard:Show(icon)
                end     
                
                if not isMoving and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) > 2 then
                    if CanWildGrowth(nil, true) then 
                        return A.WildGrowth:Show(icon)
                    end                    
                end 
				return A.Lifebloom:Show(icon)
            end
        end 
         
        -- Rejuvenation while moving
        if isMoving and A.Rejuvenation:IsReady(unit, nil, nil, true) and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) <= 3  and IsSchoolFree() and A.Rejuvenation:PredictHeal("Rejuvenation", unit) then             
            return A.Rejuvenation:Show(icon)
        end
		
        -- Rejuvenation while moving Germination
        if isMoving and A.Rejuvenation:IsReady(unit, nil, nil, true) and A.Germination:IsSpellLearned() and Unit(unit):HasBuffs(A.Rejuvenation.ID, true) > 3 and Unit(unit):HasBuffs(A.RejuvenationGermimation.ID, true) <= 3  and IsSchoolFree() and A.Rejuvenation:PredictHeal("Rejuvenation", unit) then             
            return A.Rejuvenation:Show(icon)
        end 		                 
        
        -- Damage Rotation 
        if unit == "target" and A.IsUnitEnemy("targettarget") then 
            local CanMakeDamage = DamageRotation("targettarget")
            if CanMakeDamage then 
                return true 
            end 
        end 
        
        -- Totally nothing to do 
        if not isMulti and A.SolarWrath:IsReady(unit, nil, nil, true) and A.SolarWrath:AbsentImun(unit) and IsSchoolFree() and Unit("player"):HasBuffs(A.Innervate.ID) == 0 then 
            if Unit("player"):CombatTime() > 0 and HealingEngine.GetIncomingDMGAVG() <= 5 then
                return A.SolarWrath:Show(icon)
            end            
        end		
    end 
    
    -- Defensive
    local SelfDefensive = SelfDefensives(true)
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Mouseover 
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    if A.IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if HealingRotation(unit) then 
            return true 
        end             
    end 
    
    -- Target / TargetTarget     
    if A.IsUnitEnemy("target") then 
        unit = "target"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    if A.IsUnitFriendly("target") then 
        unit = "target"
        
        if HealingRotation(unit) then 
            return true 
        end 
    end 
    
    -- Misc 
    if A.IsInPvP and A.Nourish:IsReady() and IsSchoolFree() then 
        return A.Nourish:Show(icon)
    end     
    
    if A.Zone == "arena" and Unit("player"):CombatTime() == 0 and not Player:IsMounted() and A.Sunfire:IsReady() and (isMulti or A.GetToggle(2, "AoE")) and EnemyTeam():HasInvisibleUnits() and not EnemyTeam("HEALER"):IsBreakAble(8) then 
        return A.Sunfire:Show(icon)         
    end 
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
    end 
        
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

-- [5] Trinket Rotation
-- No specialization trinket actions 

-- Passive 
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) > UnitCooldown:GetMaxDuration("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) - 2 and 
    UnitCooldown:IsSpellInFly("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) and 
    Unit("plauer"):GetDR("incapacitate") > 0 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", ACTION_CONST_SPELLID_FREEZING_TRAP)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 

local function ArenaRotation(unit)
    if A.IsInPvP and not Player:IsStealthed() and not Player:IsMounted() then             
        --local remainCast = Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0
        
        -- Note: "arena1" is just identification of meta 6
        --if unit == "arena1" and (Unit("playr"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then                 
        --    return 
        --end 
        
        -- PvP Disarm 
        if A.MightyBashIsReady(unit, false, true) and not Unit(unit):InLOS() then
            return A.MightyBash
        end         
    end 
end 

local function PartyRotation(unit)
    --local castRemain = Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0
    
    -- Dash
    if A.Dash:IsReady(unit, nil, nil, true) and IsSchoolFree() and not Unit("player", 5):HasFlags() and (Unit(unit):IsMelee() or Unit(unit):IsFocused(nil, true) or Unit(unit):HasBuffs("DamageBuffs") > 0) and not Unit(unit):InLOS() then 
        if Unit(unit):HasDeBuffs("Rooted") > A.GetGCD() then 
            return A.Dash
        end 
        
        local cMoving = Unit(unit):GetCurrentSpeed()
        if cMoving > 0 and cMoving < 64 then -- 64 because unit can moving backward 
            return A.Dash
        end 
    end 
    
    -- Detox 
    if A.NaturesCure:IsReady(unit, nil, nil, true) and A.NaturesCure:AbsentImun(unit) and IsSchoolFree() and A.AuraIsValid(unit, "UseDispel", "Dispel") and not Unit(unit):InLOS() then                         
        return A.NaturesCure
    end     
end 

A[6] = function(icon)    
    --if StopCast and Unit("player"):IsCastingRemains(A.SoothingMist.ID) > 0 then 
    --    return A:Show(icon, ACTION_CONST_STOPCAST)
    --end 
    
    StopCast = false 
    
    local Arena = ArenaRotation("arena1")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    
    local Arena = ArenaRotation("arena2")
    if Arena then 
        return Arena:Show(icon)
    end 
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    local Arena = ArenaRotation("arena3")
    if Arena then 
        return Arena:Show(icon)
    end 
end