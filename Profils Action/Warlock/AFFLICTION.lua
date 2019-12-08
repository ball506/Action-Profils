-----------------------------
-- Taste TMW Action Rotation
-----------------------------
local Action                                 = Action
local TeamCache                              = Action.TeamCache
local EnemyTeam                              = Action.EnemyTeam
local FriendlyTeam                           = Action.FriendlyTeam
--local HealingEngine                        = Action.HealingEngine
local LoC                                    = Action.LossOfControl
local Player                                 = Action.Player 
local MultiUnits                             = Action.MultiUnits
local UnitCooldown                           = Action.UnitCooldown
local Unit                                   = Action.Unit 
local Pet                                    = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local setmetatable                           = setmetatable
local TR                                     = Action.TasteRotation

Action[ACTION_CONST_WARLOCK_AFFLICTION] = {
    -- Racial
    ArcaneTorrent                        = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                            = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                            = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                        = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                           = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                          = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                          = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                             = Action.Create({ Type = "Spell", ID = 287712     }), 
    BullRush                             = Action.Create({ Type = "Spell", ID = 255654     }),    
    WarStomp                             = Action.Create({ Type = "Spell", ID = 20549     }),
    GiftofNaaru                          = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                           = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                            = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                    = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it    
    EscapeArtist                         = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                   = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics Spells
    DreadfulCalling                      = Action.Create({ Type = "Spell", ID = 278727     }),
    SummonImp                            = Action.Create({ Type = "Spell", ID = 688        }),    
    SummonVoidwalker                     = Action.Create({ Type = "Spell", ID = 697        }),
    SummonFelhunter                      = Action.Create({ Type = "Spell", ID = 691        }),
    SummonSuccubus                       = Action.Create({ Type = "Spell", ID = 712        }),
    GrimoireofSacrifice                  = Action.Create({ Type = "Spell", ID = 108503     }),
    SeedofCorruption                     = Action.Create({ Type = "Spell", ID = 27243      }),
    Haunt                                = Action.Create({ Type = "Spell", ID = 48181      }),
    ShadowBolt                           = Action.Create({ Type = "Spell", ID = 232670     }),
    DarkSoulMisery                       = Action.Create({ Type = "Spell", ID = 113860     }),
    SummonDarkglare                      = Action.Create({ Type = "Spell", ID = 205180     }),
    SiphonLife                           = Action.Create({ Type = "Spell", ID = 63106      }),
    Agony                                = Action.Create({ Type = "Spell", ID = 980        }),
    Corruption                           = Action.Create({ Type = "Spell", ID = 172        }),
    CreepingDeath                        = Action.Create({ Type = "Spell", ID = 264000     }),
    WritheInAgony                        = Action.Create({ Type = "Spell", ID = 196102     }),
    UnstableAffliction                   = Action.Create({ Type = "Spell", ID = 30108      }),
    Deathbolt                            = Action.Create({ Type = "Spell", ID = 264106     }),
    AbsoluteCorruption                   = Action.Create({ Type = "Spell", ID = 196103     }),
    DrainLife                            = Action.Create({ Type = "Spell", ID = 234153     }),
    PhantomSingularity                   = Action.Create({ Type = "Spell", ID = 205179     }),
    VileTaint                            = Action.Create({ Type = "Spell", ID = 278350     }),
    DrainSoul                            = Action.Create({ Type = "Spell", ID = 198590     }),
    ShadowEmbrace                        = Action.Create({ Type = "Spell", ID = 32388      }),
    CascadingCalamity                    = Action.Create({ Type = "Spell", ID = 275372     }),
    SowtheSeeds                          = Action.Create({ Type = "Spell", ID = 196226     }),
    PetKick                              = Action.Create({ Type = "SpellSingleColor", ID = 119910, Color = "RED", Desc = "RED Color for Pet Target kick" }),  
    FearGreen                            = Action.Create({ Type = "SpellSingleColor", ID = 5782, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true }),	
    Fear                                 = Action.Create({ Type = "Spell", ID = 5782       }),
    SpellLock                            = Action.Create({ Type = "Spell", ID = 119898     }),
    DispellMagic                         = Action.Create({ Type = "Spell", ID = 111400     }),
    Shadowfury                           = Action.Create({ Type = "Spell", ID = 30283      }),
    PandemicInvocation                   = Action.Create({ Type = "Spell", ID = 289364     }),
    -- Defensive
    UnendingResolve                      = Action.Create({ Type = "Spell", ID = 104773     }),
	SingeMagic                           = Action.Create({ Type = "Spell", ID = 89808, Color = "YELLOW", Desc = "YELLOW Color for Pet Target dispel"     }),
    -- Utilities
    DemonicCircle                        = Action.Create({ Type = "Spell", ID = 268358     }),
    DemonicCircleTeleport                = Action.Create({ Type = "Spell", ID = 48020     }),
	-- Misc
    BurningRush                          = Action.Create({ Type = "Spell", ID = 278727     }),
    Channeling                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    --TargetEnemy                          = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
	--StopCast 				             = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    -- Buffs
    GrimoireofSacrificeBuff              = Action.Create({ Type = "Spell", ID = 196099, Hidden = true     }),
    ActiveUasBuff                        = Action.Create({ Type = "Spell", ID = 233490, Hidden = true     }),
    InevitableDemiseBuff                 = Action.Create({ Type = "Spell", ID = 273525, Hidden = true     }),
    NightfallBuff                        = Action.Create({ Type = "Spell", ID = 264571, Hidden = true     }),
    CascadingCalamityBuff                = Action.Create({ Type = "Spell", ID = 275378, Hidden = true     }),
    WrackingBrillianceBuff               = Action.Create({ Type = "Spell", ID = 272891, Hidden = true    }),
    -- Debuffs 
    ShadowEmbraceDebuff                  = Action.Create({ Type = "Spell", ID = 32390, Hidden = true     }),
    ShiverVenomDebuff                    = Action.Create({ Type = "Spell", ID = 301624, Hidden = true     }),
    SeedofCorruptionDebuff               = Action.Create({ Type = "Spell", ID = 27243, Hidden = true}),
    HauntDebuff                          = Action.Create({ Type = "Spell", ID = 48181, Hidden = true}),
    UnstableAfflictionDebuff             = Action.Create({ Type = "Spell", ID = 30108, Hidden = true}),
    PhantomSingularityDebuff             = Action.Create({ Type = "Spell", ID = 205179, Hidden = true}),
    SiphonLifeDebuff                     = Action.Create({ Type = "Spell", ID = 63106, Hidden = true}),
    AgonyDebuff                          = Action.Create({ Type = "Spell", ID = 980, Hidden = true}),
    CorruptionDebuff                     = Action.Create({ Type = "Spell", ID = 146739, Hidden = true     }),
	-- UA Debuff
    UnstableAfflictionDebuff1             = Action.Create({ Type = "Spell", ID = 233490, Hidden = true}),	
    UnstableAfflictionDebuff2             = Action.Create({ Type = "Spell", ID = 233496, Hidden = true}),   
    UnstableAfflictionDebuff3             = Action.Create({ Type = "Spell", ID = 233497, Hidden = true}),  
    UnstableAfflictionDebuff4             = Action.Create({ Type = "Spell", ID = 233498, Hidden = true}),   
    UnstableAfflictionDebuff5             = Action.Create({ Type = "Spell", ID = 233499, Hidden = true}),
    -- PvP
    NetherWard                           = Action.Create({ Type = "Spell", ID = 212295     }), -- Spell Reflect	
	DemonArmor                           = Action.Create({ Type = "Spell", ID = 285933     }), -- Demon Armor PvP		
	CurseofTongues                       = Action.Create({ Type = "Spell", ID = 199890     }), -- 30% increase cast time on target for 10sec
	CurseofWeakness                      = Action.Create({ Type = "Spell", ID = 199892     }), -- 30% reduction attack power for 10sec
	CastingCircle                        = Action.Create({ Type = "Spell", ID = 221703     }), -- Silence interrupt immune for 8sec
	CurseofShadows                       = Action.Create({ Type = "Spell", ID = 234877     }), -- Additional damage 10sec
	RotandDecay                          = Action.Create({ Type = "Spell", ID = 212371, Hidden = true        }), -- Drain Life increasing dots duration by 1sec per tick
	Soulshatter                          = Action.Create({ Type = "Spell", ID = 212356     }), -- Big burst on multi target 
    -- Trinkets
    TrinketTest                          = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                         = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                  = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice         = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                 = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                     = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                   = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                       = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                         = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    -- Potions
    PotionofUnbridledFury                = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    PotionTest                           = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }),
    -- Misc
    CyclotronicBlast                     = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    -- Hidden Heart of Azeroth
    VisionofPerfectionMinor              = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}), -- used by APL 
    VisionofPerfectionMinor2             = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3             = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    -- Here come all the stuff needed by simcraft but not classic spells or items. 
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARLOCK_AFFLICTION)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_AFFLICTION], { __index = Action })

-- Used for VisionofPerfectionMinor check
local function DetermineEssenceRanks()
    A.VisionofPerfectionMinor = A.VisionofPerfectionMinor2:IsSpellLearned() and A.VisionofPerfectionMinor2 or A.VisionofPerfectionMinor
    A.VisionofPerfectionMinor = A.VisionofPerfectionMinor3:IsSpellLearned() and A.VisionofPerfectionMinor3 or A.VisionofPerfectionMinor
end
DetermineEssenceRanks = A.MakeFunctionCachedStatic(DetermineEssenceRanks)

-- Pet Handler UI --
local function HandlePetChoice()
    local choice = Action.GetToggle(2, "PetChoice")
    local currentspell = "Spell(688)"
    
    if choice == "IMP" then
        --print("IMP")
        currentspell = "Spell(688)"    
    elseif choice == "VOIDWALKER" then
        --print("VOIDWALKER")
        currentspell = "Spell(697)"
    elseif choice == "FELHUNTER" then 
        --print("FELHUNTER")    
        currentspell = "Spell(691)"
    elseif choice == "SUCCUBUS" then 
        --print("SUCCUBUS")    
        currentspell = "Spell(712)"
    else
        print("No Pet Data")
    end
    return choice
end

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
		if IsInPvP() then 
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

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

Action.Enum.SpellDuration = {
    -- SiphonLife  
    [63106] = {15000, 19500},
    -- Agony
    [980] = {18000, 23400},
    --Corruption
    [146739] = {14000, 18200},
    -- Darkglare
    [205180] = {20000, 26000},

}

-- Base Duration of a dot/hot/channel...
local SpellDuration = Action.Enum.SpellDuration
function A:BaseDuration()
    local Duration = SpellDuration[self.SpellID]
    if not Duration or Duration == 0 then 
	    return 0 
	end
    local BaseDuration = Duration[1]
    return BaseDuration / 1000
end

-- Pandemic Threshold
function A:PandemicThreshold()
    local BaseDuration = self:BaseDuration()
    if not BaseDuration or BaseDuration == 0 then 
	    return 0 
    end
    return BaseDuration * 0.3
end

local UnstableAfflictionDebuffs = {
  [1] = 233490,
  [2] = 233496,
  [3] = 233497,
  [4] = 233498,
  [5] = 233499
};

local function ActiveUAs(unit)
  local UACount = 0
  for i = 1, #UnstableAfflictionDebuffs do
    if Unit(unit):HasDeBuffsStacks(UnstableAfflictionDebuffs[i], true, true) > 0 then 
	    UACount = UACount + 1 
	end
  end
  return UACount
end

local function Contagion(unit)
    local MaximumDuration = 0
    for i = 1, #UnstableAfflictionDebuffs do
        local UARemains = Unit(unit):HasDeBuffs(UnstableAfflictionDebuffs[i], true, true)
        if UARemains > MaximumDuration then
            MaximumDuration = UARemains
        end
    end
    return MaximumDuration
end

-- Agony TickTime 
local function AgonyTickTime()
    local BaseTickTime = 2
    local Hasted = true
    if Hasted then
        return BaseTickTime * Player:SpellHaste() 
	end
    return BaseTickTime
end

-- "time.to.shard"
local function TimeToShard()
    local ActiveAgony = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.AgonyDebuff.ID)
    if ActiveAgony == 0 then
        return 10000 
    end
    return 1 / (0.16 / math.sqrt(ActiveAgony) * (ActiveAgony == 1 and 1.15 or 1) * ActiveAgony / AgonyTickTime())
end

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

local function SelfDefensives()
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
		
    -- UnendingResolve
    local UnendingResolve = A.GetToggle(2, "UnendingResolve")
    if     UnendingResolve >= 0 and A.UnendingResolve:IsReady("player") and 
    (
        (     -- Auto 
            UnendingResolve >= 100 and 
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
            UnendingResolve < 100 and 
            Unit("player"):HealthPercent() <= UnendingResolve
        )
    ) 
    then 
        return A.UnendingResolve
    end     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        return A.PetKick
    end 
    
    if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.Shadowfury              
    end          
	
	if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 0) then 
        return A.Fear              
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

-- [1] CC AntiFake Rotation
--[[local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0) and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.LegSweepGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.LegSweepGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target") and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))) or 
                (not A.IsInPvP and MultiUnits:GetByRange(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0), 1) >= 1)
            )
        )
    )
    then 
        return A.LegSweepGreen:Show(icon)         
    end                                                                     
end]]--

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.PetKick:IsReady(unit, nil, nil, true) and A.PetKick:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.PetKick:Show(icon)                                                  
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
--           TARGET CYCLE              --
-----------------------------------------

-- Evaluate Target cycle functions 
local function EvaluateTargetIfFilterAgony160(unit)
    return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony201(unit)
    return A.CreepingDeath:IsSpellLearned() and MultiUnits:GetByRangeAppliedDoTs(40, 10, A.Agony.ID, 5) < 6 and Unit(unit):TimeToDie() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < 5 or not A.PandemicInvocation:GetAzeriteRank() and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= (A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER)))
end

local function EvaluateTargetIfFilterAgony207(unit)
    return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony248(unit)
    return not A.CreepingDeath:IsSpellLearned() and MultiUnits:GetByRangeAppliedDoTs(40, 10, A.Agony.ID, 5) < 8 and Unit(unit):TimeToDie() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) < 5 or not A.PandemicInvocation:GetAzeriteRank() and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= (A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER)))
end

local function EvaluateTargetIfFilterSiphonLife254(unit)
    return Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true)
end

local function EvaluateTargetIfSiphonLife293(unit)
    return (MultiUnits:GetByRangeAppliedDoTs(40, 10, A.SiphonLife.ID, 5) < 8 - num(A.CreepingDeath:IsSpellLearned()) - MultiUnits:GetActiveEnemies() and Unit(unit):TimeToDie() > 10 and Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) <= (A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER) and Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) == 0 and MultiUnits:GetActiveEnemies() == 1 or A.SummonDarkglare:GetCooldown() > Player:SoulShardsP() * A.UnstableAffliction:GetSpellCastTime())
end

local function EvaluateCycleCorruption300(unit)
    return MultiUnits:GetActiveEnemies() < 3 + num(A.WritheInAgony:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) <= 4) and Unit(unit):TimeToDie() > 10
end

local function EvaluateCycleDrainSoul479(unit)
    return Unit(unit):TimeToDie() <= A.GetGCD()
end

local function EvaluateTargetIfFilterDrainSoul485(unit)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul498(unit)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) == 0
end

local function EvaluateTargetIfFilterDrainSoul504(unit)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul515(unit)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe)
end

local function EvaluateCycleShadowBolt524(unit)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) == 0 and not A.ShadowBolt:IsSpellInFlight()
end

local function EvaluateTargetIfFilterShadowBolt540(unit)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfShadowBolt551(unit)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe)
end

local function EvaluateCycleUnstableAffliction640(unit)
    return not bool(VarUseSeed) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() > time_to_shard or Player:SoulShardsP() > 1) and (not A.VileTaint:IsSpellLearned() or Player:SoulShardsP() > 1) and contagion <= A.UnstableAffliction:GetSpellCastTime() + VarPadding and (not A.CascadingCalamity:GetAzeriteRank() >= 1 or Player:BuffRemainsP(A.CascadingCalamityBuff.ID) > time_to_shard)
end

local function EvaluateCycleDrainSoul711(unit)
    return Unit(unit):TimeToDie() <= A.GetGCD() and Player:SoulShardsP() < 5
end

local function EvaluateTargetIfFilterAgony751(unit)
    return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true)
end

local function EvaluateTargetIfAgony768(unit)
    return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= A.GetGCD() + A.ShadowBolt:GetSpellCastTime() and Unit(unit):TimeToDie() > 8
end

local function EvaluateCycleUnstableAffliction781(unit)
    return contagion < 1 and Unit(unit):TimeToDie() <= 8
end

local function EvaluateTargetIfFilterDrainSoul787(unit)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfDrainSoul802(unit)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff, true) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) <= A.GetGCD() * 2
end

local function EvaluateTargetIfFilterShadowBolt808(unit)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true)
end

local function EvaluateTargetIfShadowBolt835(unit)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff, true) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID, true) <= A.ShadowBolt:GetSpellCastTime() * 2 and not A.ShadowBolt:IsSpellInFlight()
end

local function EvaluateTargetIfFilterPhantomSingularity841(unit)
    return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfPhantomSingularity850(unit)
    return Unit("player"):CombatTime() > 35 and Unit(unit):TimeToDie() > 16 * Player:SpellHaste() and (not A.VisionofPerfectionMinor:IsSpellLearned() and not A.DreadfulCalling:GetAzeriteRank() or A.SummonDarkglare:GetCooldown() > 45 + Player:SoulShardsP() * A.DreadfulCalling:GetAzeriteRank() or A.SummonDarkglare:GetCooldown() < 15 * Player:SpellHaste() + Player:SoulShardsP() * A.DreadfulCalling:GetAzeriteRank())
end

local function EvaluateTargetIfFilterVileTaint856(unit)
    return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfVileTaint859(unit)
    return Unit("player"):CombatTime() > 15 and Unit(unit):TimeToDie() >= 10 and (A.SummonDarkglare:GetCooldown() > 30 or A.SummonDarkglare:GetCooldown() < 10 and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) >= 10 and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) >= 10 or not A.SiphonLife:IsSpellLearned()))
end

local function EvaluateTargetIfFilterUnstableAffliction865(unit)
    return contagion
end

local function EvaluateTargetIfUnstableAffliction870(unit)
    return not bool(VarUseSeed) and Player:SoulShardsP() == 5
end


-- [3] Single Rotation
A[3] = function(icon, isMulti)
	
	--------------------
	---  VARIABLES   ---
	--------------------
    local ActiveAgony = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.Agony.ID, 5)
    local ActiveCorruption = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.Corruption.ID, 5)
    local ActiveSiphonLife = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.SiphonLife.ID, 5)
    local isMoving = A.Player:IsMoving()
	local inCombat = Unit("player"):CombatTime() > 0
	local ShouldStop = Action.ShouldStop()
	local Pull = Action.BossMods_Pulling()
    local CanMultidot = HandleMultidots()
	local unit = "player"
    local time_to_shard = TimeToShard()
	local PredictSpells = A.GetToggle(2, "PredictSpells")
	local MultiDotDistance = A.GetToggle(2, "MultiDotDistance")
	
	DetermineEssenceRanks()
	-- Multidots var
	MissingCorruption = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.Corruption.ID) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
	MissingAgony = MultiUnits:GetByRangeMissedDoTs(MultiDotDistance, 5, A.Agony.ID) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    --print(MissingVampiricTouch)
    local AppliedCorruption = MultiUnits:GetByRangeAppliedDoTs(MultiDotDistance, 5, 146739) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
 	local AppliedAgony = MultiUnits:GetByRangeAppliedDoTs(MultiDotDistance, 5, 980) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    --print(AppliedVampiricTouch)
    --CorruptionToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 146739, 5)
    --AgonyToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 980, 5)
    --SiphonLifeToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 980, 5)
	--print(VampiricTouchToRefresh)

	-- Pet Selection Menu
    local PetSpell = HandlePetChoice()    
    if PetSpell == "IMP" then
        SummonPet = A.SummonImp    
    elseif PetSpell == "VOIDWALKER" then
        SummonPet = A.SummonVoidwalker
    elseif PetSpell == "FELHUNTER" then    
        SummonPet = A.SummonFelhunter
    elseif PetSpell == "SUCCUBUS" then     
        SummonPet = A.SummonSuccubus
    else
        Action.Print("Error : You have to select Pet in UI Settings.") 
    end	
	
    -- Summon Pet 
	if SummonPet:IsReady(unit) and not ShouldStop and (not isMoving) and not Pet:IsActive() and not Unit("player"):HasBuffs(A.GrimoireofSacrificeBuff.ID, true) then
       	return SummonPet:Show(icon)
   	end
	
	------------------------------------------------------
	---------------- ENEMY UNIT ROTATION -----------------
	------------------------------------------------------
	local function EnemyRotation(unit)	
	    
		inRange = A.Agony:IsInRange(unit)
		local contagion = Contagion(unit)

	    -- Interrupt vars		
        local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")  
		-- Trinkets vars
        local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
		
		-- Out of combat with DBM Pull timer support
		if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" then -- and not Unit(unit):IsTotem()
     	    
			-- summon_pet
       		if SummonPet:IsReady(unit) and not ShouldStop and (not isMoving) and not Pet:IsActive() and not Unit("player"):HasBuffs(A.GrimoireofSacrificeBuff.ID, true) then
            	return SummonPet:Show(icon)
        	end
			
       	 	-- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
        	if A.GrimoireofSacrifice:IsReady(unit) and not ShouldStop and Unit("player"):HasBuffs(A.GrimoireofSacrificeBuff.ID, true) == 0 and A.GrimoireofSacrifice:IsSpellLearned() then
            	return A.GrimoireofSacrifice:Show(icon)
         	end
			
       	 	-- pre potion haunt
        	if A.PotionofUnbridledFury:IsReady(unit) and not ShouldStop and A.Haunt:IsSpellLearned() and Action.GetToggle(1, "Potion") and Pull > A.Haunt:GetSpellCastTime() + 1 and Pull <= A.Haunt:GetSpellCastTime() + 2 then
            	return A.PotionofUnbridledFury:Show(icon)
        	end
			
        	-- pre potion no haunt
        	if A.PotionofUnbridledFury:IsReady(unit) and not ShouldStop and Action.GetToggle(1, "Potion") and not A.Haunt:IsSpellLearned() and Pull > A.ShadowBolt:GetSpellCastTime() + 1 and Pull <= A.ShadowBolt:GetSpellCastTime() + 2 then
            	return A.PotionofUnbridledFury:Show(icon)
        	end
			
        	-- haunt
        	if A.Haunt:IsReady(unit, nil, nil, PredictSpells) and not ShouldStop and not isMoving and Pull > 0.1 and Pull <= A.Haunt:GetSpellCastTime() + 0.05 and (not isMoving) and Unit(unit):HasDeBuffs(A.HauntDebuff.ID, true) == 0 then
            	return A.Haunt:Show(icon)
        	end
			
        	-- shadow_bolt,if=!talent.haunt.enabled&spell_targets.seed_of_corruption_aoe<3
        	if A.ShadowBolt:IsReady(unit) and not ShouldStop and Pull > 0.1 and Pull <= A.ShadowBolt:GetSpellCastTime() and not isMoving and (not A.Haunt:IsSpellLearned() and MultiUnits:GetActiveEnemies() < 3) then
            	return A.ShadowBolt:Show(icon)
        	end
			
		end
	
		-- Out of combat without DBM Pull timer support
		if not inCombat and Unit(unit):IsExists() and not Action.GetToggle(1, "DBM") and unit ~= "mouseover" then -- and not Unit(unit):IsTotem()
			
        	-- summon_pet
        	if SummonPet:IsReady(unit) and (not isMoving) and not ShouldStop and not Pet:IsActive() then
            	return SummonPet:Show(icon)
        	end
			
        	-- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
        	if A.GrimoireofSacrifice:IsReady(unit) and not ShouldStop and Unit("player"):HasBuffs(A.GrimoireofSacrificeBuff.ID, true) == 0 and (A.GrimoireofSacrifice:IsSpellLearned()) then
            	return A.GrimoireofSacrifice:Show(icon)
        	end
			
        	-- use_item,name=azsharas_font_of_power
        	if A.AzsharasFontofPower:IsExists() and (not isMoving) and TR.TrinketON() and not ShouldStop and A.AzsharasFontofPower:IsReady(unit) then
            	return A.AzsharasFontofPower:Show(icon)
        	end
			
        	-- seed_of_corruption,if=spell_targets.seed_of_corruption_aoe>=3&!equipped.169314
        	if A.SeedofCorruption:IsReady(unit) and (not isMoving) and not ShouldStop and (isMulti or A.GetToggle(2, "AoE")) and Unit(unit):HasDeBuffs(A.SeedofCorruptionDebuff.ID, true) == 0 and (MultiUnits:GetActiveEnemies() >= 3 and not A.AzsharasFontofPower:IsExists()) then
            	return A.SeedofCorruption:Show(icon)
        	end
			
        	-- haunt
        	if A.Haunt:IsReady(unit, nil, nil, PredictSpells) and (not isMoving) and not ShouldStop and Unit(unit):HasDeBuffs(A.HauntDebuff.ID, true) == 0 then
            	return A.Haunt:Show(icon)
        	end
			
        	-- shadow_bolt,if=!talent.haunt.enabled&spell_targets.seed_of_corruption_aoe<3&!equipped.169314
        	if A.ShadowBolt:IsReady(unit) and not isMoving and not ShouldStop and (not A.Haunt:IsSpellLearned() and MultiUnits:GetActiveEnemies() < 3 and not A.AzsharasFontofPower:IsExists()) then
            	return A.ShadowBolt:Show(icon)
        	end
			
    	end	
    
	    -- Maintain Dots
        local function Pandemic(unit)
		
            -- actions.mouseover+=/Agony
            if     Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= 5.4 + A.GetGCD() + A.GetPing() and A.Agony:IsReady(unit, true) and A.Agony:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() <= 40 and A.LastPlayerCastID ~= A.Agony.ID then 
                return A.Agony:Show(icon)
            end 
            
            -- actions.mouseover+=/Corruption
            if     Unit(unit):HasDeBuffs(A.Corruption.ID, true) <= 4.2 + A.GetGCD() + A.GetPing() and A.Corruption:IsReady(unit, true) and A.Corruption:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() <= 40 and A.LastPlayerCastID ~= A.Corruption.ID then 
                return A.Corruption:Show(icon)
            end 
			
            -- actions.mouseover+=/SiphonLife
            if     Unit(unit):HasDeBuffs(A.SiphonLife.ID, true) <= 4.5 + A.GetGCD() + A.GetPing() and A.SiphonLife:IsReady(unit, true) and A.SiphonLife:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() <= 40 and A.LastPlayerCastID ~= A.SiphonLife.ID then 
                return A.SiphonLife:Show(icon)
            end 
			
        end
    
        -- Rotation Fillers 
        local function Fillers(unit)
		
            -- unstable_affliction,line_cd=15,if=cooldown.deathbolt.remains<=gcd*2&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&cooldown.summon_darkglare.remains>20
            if A.UnstableAffliction:IsReady(unit, nil, nil, PredictSpells) and (not isMoving) and not ShouldStop and A.Deathbolt:GetCooldown() <= A.GetGCD() * 2 and MultiUnits:GetActiveEnemies() == 1 and A.SummonDarkglare:GetCooldown() > 20 then
                return A.UnstableAffliction:Show(icon)
            end
			
            -- deathbolt,if=cooldown.summon_darkglare.remains>=30+gcd|cooldown.summon_darkglare.remains>140
            if A.Deathbolt:IsReady(unit) and not ShouldStop and (A.SummonDarkglare:GetCooldown() >= 30 + A.GetGCD() or A.SummonDarkglare:GetCooldown() > 140) then
                return A.Deathbolt:Show(icon)
            end
			
            -- shadow_bolt,if=buff.movement.up&buff.nightfall.remains
            if A.ShadowBolt:IsReady(unit) and not ShouldStop and isMoving and Unit("player"):HasBuffs(A.NightfallBuff.ID, true) then
                return A.ShadowBolt:Show(icon)
            end
			
            -- agony,if=buff.movement.up&!(talent.siphon_life.enabled&(prev_gcd.1.agony&prev_gcd.2.agony&prev_gcd.3.agony)|prev_gcd.1.agony)
            if A.Agony:IsReady(unit) and not ShouldStop and isMoving and not (A.SiphonLife:IsSpellLearned() and (Unit("player"):GetSpellLastCast(A.Agony.ID, true) and A.Agony:GetSpellTimeSinceLastCast() >= 2 * A.GetGCD() and A.Agony:GetSpellTimeSinceLastCast() >= 3 * A.GetGCD()) or Unit("player"):GetSpellLastCast(A.Agony.ID, true)) then
                return A.Agony:Show(icon)
            end
			
            -- siphon_life,if=buff.movement.up&!(prev_gcd.1.siphon_life&prev_gcd.2.siphon_life&prev_gcd.3.siphon_life)
            if A.SiphonLife:IsReady(unit) and not ShouldStop and isMoving and not (Unit("player"):GetSpellLastCast(A.SiphonLife.ID, true) and A.SiphonLife:GetSpellTimeSinceLastCast() >= 2 * A.GetGCD() and A.SiphonLife:GetSpellTimeSinceLastCast() >= 3 * A.GetGCD()) then
                return A.SiphonLife:Show(icon)
            end
			
            -- corruption,if=buff.movement.up&!prev_gcd.1.corruption&!talent.absolute_corruption.enabled
            if A.Corruption:IsReady(unit) and not ShouldStop and isMoving and not Unit("player"):GetSpellLastCast(A.Corruption.ID, true) and not A.AbsoluteCorruption:IsSpellLearned() and not Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) then
                return A.Corruption:Show(icon)
            end
			
            --  drain_life,if=buff.inevitable_demise.stack>10&target.time_to_die<=10
            if A.DrainLife:IsReady(unit) and (not isMoving) and not ShouldStop and Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) > 10 and Unit(unit):TimeToDie() <= 10 then
                return A.DrainLife:Show(icon)
            end
			
            -- drain_life,if=talent.siphon_life.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=2)&dot.agony.remains>5*spell_haste&dot.corruption.remains>gcd&(dot.siphon_life.remains>gcd|!talent.siphon_life.enabled)&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
            if A.DrainLife:IsReady(unit) and (not isMoving) and not ShouldStop and A.SiphonLife:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) >= 50 - 20 * num(MultiUnits:GetActiveEnemies() >= 2) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 5 * Player:SpellHaste() and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) > A.GetGCD() and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) > A.GetGCD() or not A.SiphonLife:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.HauntDebuff.ID, true) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste() then
                return A.DrainLife:Show(icon)
            end
			
            -- drain_life,if=talent.writhe_in_agony.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=3)-5*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up=2)&dot.agony.remains>5*spell_haste&dot.corruption.remains>gcd&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
            if A.DrainLife:IsReady(unit) and (not isMoving) and not ShouldStop and A.WritheInAgony:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) >= 50 - 20 * num(MultiUnits:GetActiveEnemies() >= 3) - 5 * num(MultiUnits:GetActiveEnemies() == 2) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 5 * Player:SpellHaste() and Target.DebuffRemainsP(A.CorruptionDebuff) > A.GetGCD() and (Unit(unit):HasDeBuffs(A.HauntDebuff.ID, true) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste() then
                return A.DrainLife:Show(icon)
            end
			
            -- drain_life,if=talent.absolute_corruption.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=4)&dot.agony.remains>5*spell_haste&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
            if A.DrainLife:IsReady(unit) and (not isMoving) and not ShouldStop and A.AbsoluteCorruption:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) >= 50 - 20 * num(MultiUnits:GetActiveEnemies() >= 4) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 5 * Player:SpellHaste() and (Unit(unit):HasDeBuffs(A.HauntDebuff.ID, true) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste() then
                return A.DrainLife:Show(icon)
            end
			
            -- haunt
            if A.Haunt:IsReady(unit, nil, nil, PredictSpells) and (not isMoving) and A.Haunt:GetCooldown() <= (A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER) and not ShouldStop then
                return A.Haunt:Show(icon)
            end
			
            -- focused_azerite_beam
            if A.FocusedAzeriteBeam:IsReady(unit) and (not isMoving) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- purifying_blast
            if A.PurifyingBlast:IsReady(unit) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight()) then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- drain_soul,interrupt_global=1,chain=1,interrupt=1,cycle_targets=1,if=target.time_to_die<=gcd
            if A.DrainSoul:IsReady(unit) and (not isMoving) and not ShouldStop and Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateCycleDrainSoul479) then
                return A.DrainSoul:Show(icon)
            end
			
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&variable.maintain_se&!debuff.shadow_embrace.remains
            if A.DrainSoul:IsReady(unit) and (not isMoving) and not ShouldStop and Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul485, EvaluateTargetIfDrainSoul498) then
                return A.DrainSoul:Show(icon)
            end
			
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&variable.maintain_se
            if A.DrainSoul:IsReady(unit) and (not isMoving) and not ShouldStop and Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul504, EvaluateTargetIfDrainSoul515) then
                return A.DrainSoul:Show(icon)
            end
			
            -- drain_soul,interrupt_global=1,chain=1,interrupt=1
            if A.DrainSoul:IsReady(unit) and (not isMoving) and not ShouldStop then
                return A.DrainSoul:Show(icon)
            end
			
            -- shadow_bolt,cycle_targets=1,if=talent.shadow_embrace.enabled&variable.maintain_se&!debuff.shadow_embrace.remains&!action.shadow_bolt.in_flight
            if A.ShadowBolt:IsReady(unit) and not isMoving and not ShouldStop and Action.Utils.CastTargetIf(A.ShadowBolt, 40, "min", EvaluateCycleShadowBolt524) then
                return A.ShadowBolt:Show(icon)
            end
			
            -- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se
            if A.ShadowBolt:IsReady(unit) and not isMoving and not ShouldStop and Action.Utils.CastTargetIf(A.ShadowBolt, 40, "min", EvaluateTargetIfFilterShadowBolt540, EvaluateTargetIfShadowBolt551) then
                return A.ShadowBolt:Show(icon)
            end
			
            -- shadow_bolt
            if A.ShadowBolt:IsReady(unit) and not isMoving and not ShouldStop then
               return A.ShadowBolt:Show(icon)
            end
			
        end
    
    
        local function Spenders(unit)
		
            -- unstable_affliction,if=cooldown.summon_darkglare.remains<=soul_shard*(execute_time+azerite.dreadful_calling.rank)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=soul_shard*execute_time)&(talent.sow_the_seeds.enabled|dot.phantom_singularity.remains|dot.vile_taint.remains)
            if A.UnstableAffliction:IsReady(unit, nil, nil, PredictSpells) and not isMoving  and not ShouldStop and A.SummonDarkglare:GetCooldown() <= Player:SoulShardsP() * A.UnstableAffliction:GetSpellCastTime() and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() <= Player:SoulShardsP() * A.UnstableAffliction:GetSpellCastTime()) and (A.SowtheSeeds:IsSpellLearned() or Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true) or Unit(unit):HasDeBuffs(A.VileTaint.ID, true)) then
                return A.UnstableAffliction:Show(icon)
            end
			
            -- call_action_list,name=fillers,if=(cooldown.summon_darkglare.remains<time_to_shard*(5-soul_shard)|cooldown.summon_darkglare.up)&time_to_die>cooldown.summon_darkglare.remains
            if (A.SummonDarkglare:GetCooldown() < time_to_shard * (5 - Player:SoulShardsP()) or A.SummonDarkglare:GetCooldown() == 0) and Unit(unit):TimeToDie() > A.SummonDarkglare:GetCooldown() then
                if Fillers(unit) then 
                    return true 
                end 
            end
						
            -- seed_of_corruption,if=variable.use_seed
            if A.SeedofCorruption:IsReady(unit) and not isMoving and not ShouldStop and (isMulti or A.GetToggle(2, "AoE")) and (bool(VarUseSeed)) then
                return A.SeedofCorruption:Show(icon)
            end
			
            -- unstable_affliction,if=!variable.use_seed&!prev_gcd.1.summon_darkglare&(talent.deathbolt.enabled&cooldown.deathbolt.remains<=execute_time&!azerite.cascading_calamity.enabled|(soul_shard>=5&spell_targets.seed_of_corruption_aoe<2|soul_shard>=2&spell_targets.seed_of_corruption_aoe>=2)&target.time_to_die>4+execute_time&spell_targets.seed_of_corruption_aoe=1|target.time_to_die<=8+execute_time*soul_shard)
            if A.UnstableAffliction:IsReady(unit, nil, nil, PredictSpells) and not isMoving and not ShouldStop and not bool(VarUseSeed) and not Unit("player"):GetSpellLastCast(A.SummonDarkglare.ID, true) and (A.Deathbolt:IsSpellLearned() and A.Deathbolt:GetCooldown() <= A.UnstableAffliction:GetSpellCastTime() and not A.CascadingCalamity:GetAzeriteRank() or (Player:SoulShardsP() >= 5 and MultiUnits:GetActiveEnemies() < 2 or Player:SoulShardsP() >= 2 and MultiUnits:GetActiveEnemies() >= 2) and Unit(unit):TimeToDie() > 4 + A.UnstableAffliction:GetSpellCastTime() and MultiUnits:GetActiveEnemies() == 1 or Unit(unit):TimeToDie() <= 8 + A.UnstableAffliction:GetSpellCastTime() * Player:SoulShardsP()) then
                return A.UnstableAffliction:Show(icon)
            end
			
            -- unstable_affliction,if=!variable.use_seed&contagion<=cast_time+variable.padding
           -- if A.UnstableAffliction:IsReady(unit, nil, nil, PredictSpells) and not isMoving  and not ShouldStop and not bool(VarUseSeed) and contagion <= A.UnstableAffliction:GetSpellCastTime() then
          --      return A.UnstableAffliction:Show(icon)
          --  end
			
		    -- unstable_affliction,cycle_targets=1,if=!variable.use_seed&(!talent.deathbolt.enabled|cooldown.deathbolt.remains>time_to_shard|soul_shard>1)&(!talent.vile_taint.enabled|soul_shard>1)&contagion<=cast_time+variable.padding&(!azerite.cascading_calamity.enabled|buff.cascading_calamity.remains>time_to_shard)
          --  if A.UnstableAffliction:IsReady(unit, nil, nil, PredictSpells) and not isMoving  and not ShouldStop and A.CascadingCalamity:GetAzeriteRank() >= 1 and (not Unit("player"):HasBuffs(A.CascadingCalamityBuff.ID, true) or Unit("player"):HasBuffs(A.CascadingCalamityBuff.ID, true) <= (A.UnstableAffliction:GetSpellCastTime() + A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER))  and ActiveUAs(unit) >= 1 then
          --     return A.UnstableAffliction:Show(icon)
          --  end
			
            -- unstable_affliction,cycle_targets=1,if=!variable.use_seed&(!talent.deathbolt.enabled|cooldown.deathbolt.remains>time_to_shard|soul_shard>1)&(!talent.vile_taint.enabled|soul_shard>1)&contagion<=cast_time+variable.padding&(!azerite.cascading_calamity.enabled|buff.cascading_calamity.remains>time_to_shard)
          --  if A.UnstableAffliction:IsReady(unit, nil, nil, PredictSpells) and not isMoving and not ShouldStop and Action.Utils.CastTargetIf(A.UnstableAffliction, 40, "min", EvaluateCycleUnstableAffliction640) then
          --      return A.UnstableAffliction:Show(icon)
          --  end
						
        end 

		-- Combat started and valid unit
		if inCombat and Unit(unit):IsExists() and unit ~= "mouseover" then -- and not Unit(unit):IsTotem()
			
			-- Demon Armor PvP
			if A.IsInPvP and A.DemonArmor:IsReady("player") and A.DemonArmor:IsSpellLearned() and not Unit("player"):HasBuffs(A.DemonArmor.ID, true) then 
	            return A.DemonArmor:Show(icon)
            end 
			
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end
            
			-- Burst incoming notification
			local TimeToBurst = A.SummonDarkglare:GetCooldown() 
			if A.BurstIsON(unit) and A.SummonDarkglare:GetCooldown() <= time_to_shard * (5 - Player:SoulShardsP()) and Unit("player"):CombatTime() > 30 then
			    Action.SendNotification("Preparing burst : " .. TimeToBurst .. " sec", A.SummonDarkglare.ID)
				--return
			end
			
			-- Locals variables
            local castLeft, _, _, _, notKickAble = Unit("player"):IsCastingRemains()
            local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = A.Unit("player"):IsCasting()
			
			-- Allow stop cast to improve Contagion uptime
			if spellID == A.ShadowBolt.ID and Player:SoulShardsP() > 0 then
			    if contagion <= A.UnstableAffliction:GetSpellCastTime() + A.GetPing() + A.GetGCD() then
				    if (A.SummonDarkglare:GetCooldown() > time_to_shard * 6) or not A.BurstIsON(unit) then
					    Action.SendNotification("Stopping cast to maintain UA", A.UnstableAffliction.ID)
                        return A:Show(icon, ACTION_CONST_STOPCAST) -- A.StopCast:Show(icon)
					end
			    end
			end
			
			-- Fake stop cast PvP			
			-- Need to find a way to track if unit got interrupt available ?
			--if A.IsInPvP and castLeft > 0 and Unit("player"):IsControlAble("silence") 
            --and (Unit("player"):IsFocused("MELEE") or EnemyTeam("HEALER"):GetRange() <= 30) 
			--then
            --    return A:Show(icon, ACTION_CONST_STOPCAST) -- A.StopCast:Show(icon)
			--end

			-- Auto Multidot
			if Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) > 0 and Action.GetToggle(2, "AutoDot") and CanMultidot
		    and (MissingAgony >= 1 or MissingCorruption >= 1) and 
		   (Unit("player"):HasBuffs(A.DarkSoulMisery.ID, true) == 0 ) then
			    return A:Show(icon, ACTION_CONST_AUTOTARGET)
		    end	
							
            -- variable,name=use_seed,value=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>=3+raid_event.invulnerable.up|talent.siphon_life.enabled&spell_targets.seed_of_corruption>=5+raid_event.invulnerable.up|spell_targets.seed_of_corruption>=8+raid_event.invulnerable.up
            if (true) then
                VarUseSeed = num(A.SowtheSeeds:IsSpellLearned() and MultiUnits:GetActiveEnemies() >= 3 or A.SiphonLife:IsSpellLearned() and MultiUnits:GetActiveEnemies() >= 5 or MultiUnits:GetActiveEnemies() >= 8)
            end
		
            -- variable,name=padding,op=set,value=action.shadow_bolt.execute_time*azerite.cascading_calamity.enabled
            if (true) then
                VarPadding = A.ShadowBolt:GetSpellCastTime() * num(A.CascadingCalamity:GetAzeriteRank() >= 1)
            end
		
            -- variable,name=padding,op=reset,value=gcd,if=azerite.cascading_calamity.enabled&(talent.drain_soul.enabled|talent.deathbolt.enabled&cooldown.deathbolt.remains<=gcd)
            if (A.CascadingCalamity:GetAzeriteRank() >= 1 and (A.DrainSoul:IsSpellLearned() or A.Deathbolt:IsSpellLearned() and A.Deathbolt:GetCooldown() <= A.GetGCD())) then
                VarPadding = 0
            end
		
            -- variable,name=maintain_se,value=spell_targets.seed_of_corruption_aoe<=1+talent.writhe_in_agony.enabled+talent.absolute_corruption.enabled*2+(talent.writhe_in_agony.enabled&talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>2)+(talent.siphon_life.enabled&!talent.creeping_death.enabled&!talent.drain_soul.enabled)+raid_event.invulnerable.up
            if (true) then
                VarMaintainSe = num(MultiUnits:GetActiveEnemies() <= 1 + num(A.WritheInAgony:IsSpellLearned()) + num(A.AbsoluteCorruption:IsSpellLearned()) * 2 + num((A.WritheInAgony:IsSpellLearned() and A.SowtheSeeds:IsSpellLearned() and MultiUnits:GetActiveEnemies() > 2)) + num((A.SiphonLife:IsSpellLearned() and not A.CreepingDeath:IsSpellLearned() and not A.DrainSoul:IsSpellLearned())))
            end		
		
		    -- #1 Burst on current target 
		    if A.BurstIsON(unit) and unit ~= "mouseover" then 
                
				-- use_item,name=azsharas_font_of_power,if=(!talent.phantom_singularity.enabled|cooldown.phantom_singularity.remains<4*spell_haste|!cooldown.phantom_singularity.remains)&cooldown.summon_darkglare.remains<19*spell_haste+soul_shard*azerite.dreadful_calling.rank&dot.agony.remains&dot.corruption.remains&(dot.siphon_life.remains|!talent.siphon_life.enabled)
                if TR.TrinketON() and not ShouldStop and not isMoving and A.AzsharasFontofPower:IsReady(unit) and ((not A.PhantomSingularity:IsSpellLearned() or A.PhantomSingularity:GetCooldown() < 4 * Player:SpellHaste() or A.PhantomSingularity:GetCooldown() == 0) and A.SummonDarkglare:GetCooldown() < 19 * Player:SpellHaste() + Player:SoulShardsP() * A.DreadfulCalling:GetAzeriteRank() and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 0 and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) > 0 and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID, true) > 0 or not A.SiphonLife:IsSpellLearned())) then
                    return A.AzsharasFontofPower:Show(icon)
                end
				
                -- potion,if=(talent.dark_soul_misery.enabled&cooldown.summon_darkglare.up&cooldown.dark_soul.up)|cooldown.summon_darkglare.up|target.time_to_die<30
                if A.PotionofUnbridledFury:IsReady(unit) and not ShouldStop and Action.GetToggle(1, "Potion") and ((A.DarkSoulMisery:IsSpellLearned() and A.SummonDarkglare:GetCooldown() == 0 and A.DarkSoulMisery:GetCooldown() == 0) or A.SummonDarkglare:GetCooldown() == 0 or Unit(unit):TimeToDie() < 30) then
                    return A.PotionofUnbridledFury:Show(icon)
                end
				
                -- use_items,if=cooldown.summon_darkglare.remains>70|time_to_die<20|((buff.active_uas.stack=5|soul_shard=0)&(!talent.phantom_singularity.enabled|cooldown.phantom_singularity.remains)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=gcd|!cooldown.deathbolt.remains)&!cooldown.summon_darkglare.remains)
                -- fireblood,if=!cooldown.summon_darkglare.up
                if A.Fireblood:AutoRacial(unit) and not ShouldStop and A.BurstIsON(unit) and (not A.SummonDarkglare:GetCooldown() == 0) then
                    return A.Fireblood:Show(icon)
                end
				
                -- blood_fury,if=!cooldown.summon_darkglare.up
                if A.BloodFury:AutoRacial(unit) and not ShouldStop and A.BurstIsON(unit) and (not A.SummonDarkglare:GetCooldown() == 0) then
                    return A.BloodFury:Show(icon)
                end
				
                -- memory_of_lucid_dreams,if=time>30
                if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and A.BurstIsON(unit) and (Unit("player"):CombatTime() > 30) then
                    return A.MemoryofLucidDreams:Show(icon)
                end
				
                -- dark_soul,if=target.time_to_die<20+gcd|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up|talent.sow_the_seeds.enabled&cooldown.summon_darkglare.remains>=cooldown.summon_darkglare.duration-10
                if A.DarkSoulMisery:IsReady("player") and A.BurstIsON(unit) and (Unit(unit):TimeToDie() < 20 + A.GetGCD() or MultiUnits:GetActiveEnemies() > 1 or A.SowtheSeeds:IsSpellLearned() and A.SummonDarkglare:GetCooldown() >= 20 - 10) then
                    return A.DarkSoulMisery:Show(icon)
                end
				
                -- blood_of_the_enemy,if=pet.darkglare.remains|(!cooldown.deathbolt.remains|!talent.deathbolt.enabled)&cooldown.summon_darkglare.remains>=80&essence.blood_of_the_enemy.rank>1
                if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (A.SummonDarkglare:GetCooldown() > 160 or (A.Deathbolt:GetCooldown() == 0 or not A.Deathbolt:IsSpellLearned()) and A.SummonDarkglare:GetCooldown() >= 80 and not A.BloodoftheEnemy:ID() == 297108) then
                    return A.BloodoftheEnemy:Show(icon)
                end
				
                -- use_item,name=pocketsized_computation_device,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
                if TR.TrinketON() and A.PocketsizedComputationDevice:IsReady(unit) and A.PocketsizedComputationDevice:AbsentImun(unit, Temp.TotalAndMag) and (A.SummonDarkglare:GetCooldown() >= 25 and (A.Deathbolt:GetCooldown() or not A.Deathbolt:IsSpellLearned())) then
                    return A.PocketsizedComputationDevice:Show(icon)
                end
				
                -- use_item,name=rotcrusted_voodoo_doll,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
                if TR.TrinketON() and not ShouldStop and A.RotcrustedVoodooDoll:IsReady(unit) and A.RotcrustedVoodooDoll:AbsentImun(unit, Temp.TotalAndMag) and (A.SummonDarkglare:GetCooldown() >= 25 and (A.Deathbolt:GetCooldown() or not A.Deathbolt:IsSpellLearned())) then
                    return A.RotcrustedVoodooDoll:Show(icon)
                end
				
                -- use_item,name=shiver_venom_relic,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
                if TR.TrinketON() and not ShouldStop and A.ShiverVenomRelic:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff.ID, true) >= 5 and A.ShiverVenomRelic:IsReady(unit) and (A.SummonDarkglare:GetCooldown() >= 25 and (A.Deathbolt:GetCooldown() or not A.Deathbolt:IsSpellLearned())) then
                    return A.ShiverVenomRelic:Show(icon)
                end
				
                -- use_item,name=aquipotent_nautilus,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
                if TR.TrinketON() and not ShouldStop and A.AquipotentNautilus:IsReady(unit) and A.AquipotentNautilus:AbsentImun(unit, Temp.TotalAndMag) and (A.SummonDarkglare:GetCooldown() >= 25 and (A.Deathbolt:GetCooldown() or not A.Deathbolt:IsSpellLearned())) then
                    return A.AquipotentNautilus:Show(icon)
                end
				
                -- use_item,name=tidestorm_codex,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
                if TR.TrinketON() and not ShouldStop and A.TidestormCodex:IsReady(unit) and A.TidestormCodex:AbsentImun(unit, Temp.TotalAndMag) and (A.SummonDarkglare:GetCooldown() >= 25 and (A.Deathbolt:GetCooldown() or not A.Deathbolt:IsSpellLearned())) then
                    return A.TidestormCodex:Show(icon)
                end
				
                -- use_item,name=vial_of_storms,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
                if TR.TrinketON() and not ShouldStop and A.VialofStorms:IsReady(unit) and A.VialofStorms:AbsentImun(unit, Temp.TotalAndMag) and (A.SummonDarkglare:GetCooldown() >= 25 and (A.Deathbolt:GetCooldown() or not A.Deathbolt:IsSpellLearned())) then
                    return A.VialofStorms:Show(icon)
                end
				
                -- worldvein_resonance,if=buff.lifeblood.stack<3
                if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                    return A.WorldveinResonance:Show(icon)
                end
				
                -- ripple_in_space
                if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
                    return A.RippleinSpace:Show(icon)
                end
				
            end
		
		    -- Make use of all trinkets of the game EXCEPT Blacklisted ones that need specific behavior
           	if TR.TrinketON() and A.Trinket1:IsReady("target") and Trinket1IsAllowed and A.Trinket1:AbsentImun(unit, Temp.TotalAndMag)  then 
      	   	    return A.Trinket1:Show(icon)
   	        end 
              
   		    if TR.TrinketON() and A.Trinket2:IsReady("target") and Trinket2IsAllowed and A.Trinket2:AbsentImun(unit, Temp.TotalAndMag)  then 
       	       	return A.Trinket2:Show(icon)
   	        end  	   	
     		
            -- drain_soul,interrupt_global=1,chain=1,cycle_targets=1,if=target.time_to_die<=gcd&soul_shard<5
            if A.DrainSoul:IsReady(unit) and not isMoving and not ShouldStop and Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateCycleDrainSoul711) then
                return A.DrainSoul:Show(icon)
            end
		
            -- haunt,if=spell_targets.seed_of_corruption_aoe<=2+raid_event.invulnerable.up
            if A.Haunt:IsReady(unit, nil, nil, PredictSpells) and not isMoving and A.Haunt:GetCooldown() <= (A.GetGCD() + A.GetCurrentGCD() + A.GetPing() + (TMW.UPD_INTV or 0) + ACTION_CONST_CACHE_DEFAULT_TIMER) and not ShouldStop and (MultiUnits:GetActiveEnemies() <= 2) then
               return A.Haunt:Show(icon)
            end
			
			local PlayercastLeft, _, _, _, notKickAble = Unit("player"):IsCastingRemains()
			-- Trick here to ensure we maintain Contagion everytime
            -- unstable_affliction,target_if=min:contagion
            if A.UnstableAffliction:IsReady(unit, nil, nil, PredictSpells) and Unit("player"):CombatTime() > 3 and (A.SummonDarkglare:GetCooldown() > 40 or not A.BurstIsON(unit)) and not isMoving and not ShouldStop and Player:SoulShardsP() >= 1 and (not contagion or contagion <= (A.UnstableAffliction:GetSpellCastTime() + A.GetGCD() + PlayercastLeft + A.GetCurrentGCD() + A.GetPing() + 0.125)) then
                return A.UnstableAffliction:Show(icon)
            end

            -- Pandemic
            if (true) then
                if Pandemic(unit) then 
                    return true 
                end 
            end	

            -- drain_life,if=talent.absolute_corruption.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=4)&dot.agony.remains>5*spell_haste&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
            if A.DrainLife:IsReady(unit) and not isMoving and not ShouldStop and Unit("player"):HasBuffsStacks(A.InevitableDemiseBuff.ID, true) >= 45 
			or A.IsInPvP and A.RotandDecay:IsSpellLearned() and contagion > 0 and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) > 5.4 + A.GetGCD() and Unit(unit):HasDeBuffs(A.Corruption.ID, true) > 4.2 + A.GetGCD() 
			and contagion > 3 and (A.SummonDarkglare:GetCooldown() > 3 or not A.BurstIsON(unit))
			then
                return A.DrainLife:Show(icon)
            end					
            
   			-- Curse of Tongues
			if A.IsInPvP and A.CurseofTongues:IsReady() and A.CurseofTongues:IsSpellLearned() and not Unit(unit):IsMelee() then 
	            return A.CurseofTongues:Show(icon)
            end 
			
			-- Curse of Weakness
			if A.IsInPvP and A.CurseofWeakness:IsReady() and A.CurseofWeakness:IsSpellLearned() and Unit(unit):IsMelee() then 
	            return A.CurseofWeakness:Show(icon)
            end 
			
			-- Curse of Shadows
			if A.IsInPvP and A.CurseofShadows:IsReady() and A.CurseofShadows:IsSpellLearned() then 
	            return A.CurseofShadows:Show(icon)
            end 
			
			-- Soulshatter
			if A.IsInPvP and A.Soulshatter:IsReady() and A.Soulshatter:IsSpellLearned() and MultiUnits:GetActiveEnemies() >= 3
			-- Get applied Corruption and Agony
            and AppliedCorruption >= 4 and AppliedAgony >= 4 
			then 
	            return A.Soulshatter:Show(icon)
            end  
			
            -- phantom_singularity,if=time<=35
            if A.PhantomSingularity:IsReady(unit) and not ShouldStop and (Unit("player"):CombatTime() <= 35) and (ActiveUAs(unit) == 5 or Player:SoulShardsP() == 0)  then
                return A.PhantomSingularity:Show(icon)
            end
		
            -- summon_darkglare,if=dot.agony.ticking&dot.corruption.ticking&(buff.active_uas.stack=5|soul_shard=0)&(!talent.phantom_singularity.enabled|dot.phantom_singularity.remains)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=gcd|!cooldown.deathbolt.remains|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up)
            if A.SummonDarkglare:IsReady("player") and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID, true) or A.AbsoluteCorruption:IsSpellLearned()) and (ActiveUAs(unit) == 5 or Player:SoulShardsP() == 0) and (not A.PhantomSingularity:IsSpellLearned() or Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true)) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() <= A.GetGCD() or A.Deathbolt:GetCooldown() == 0 or MultiUnits:GetActiveEnemies() > 1)) then
                return A.SummonDarkglare:Show(icon)
            end
		
            -- deathbolt,if=cooldown.summon_darkglare.remains&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&(!essence.vision_of_perfection.minor&!azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains>30)
            if A.Deathbolt:IsReady(unit) and not ShouldStop and ActiveUAs(unit) >= 1 and Player:SoulShardsP() <= 1 and (A.SummonDarkglare:GetCooldown() >= 30 and MultiUnits:GetActiveEnemies() == 1 and (not A.VisionofPerfectionMinor:IsSpellLearned() and not A.DreadfulCalling:GetAzeriteRank() or A.SummonDarkglare:GetCooldown() > 30)) then
                return A.Deathbolt:Show(icon)
            end 
		
            -- deathbolt,if=shard<=1&!cooldowns
            if A.Deathbolt:IsReady(unit) and not ShouldStop and not A.BurstIsON(unit) and Player:SoulShardsP() <= 1 then
                return A.Deathbolt:Show(icon)
            end 
		
            -- the_unbound_force,if=buff.reckless_force.remains
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) then
                return A.TheUnboundForce:Show(icon)
            end
		
            -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
            if A.Agony:IsReady(unit) and not ShouldStop and Action.Utils.CastTargetIf(A.Agony, 40, "min", EvaluateTargetIfFilterAgony751, EvaluateTargetIfAgony768) 
			then
                return A.Agony:Show(icon)
            end
		
            -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
            if A.Agony:IsReady(unit) and not ShouldStop and not A.BurstIsON(unit) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= 5.4 
			then
                return A.Agony:Show(icon)
            end
		
            -- memory_of_lucid_dreams,if=time<30
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Unit("player"):CombatTime() < 30) then
                return A.MemoryofLucidDreams:Show(icon)
            end
		
            -- # Temporary fix to make sure azshara's font doesn't break darkglare usage.
            -- agony,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314
            if A.Agony:IsReady(unit) and not ShouldStop and (Unit("player"):CombatTime() > 30 and A.SummonDarkglare:GetCooldown() <= 15 and A.AzsharasFontofPower:IsExists()) 
			then
                return A.Agony:Show(icon)
            end
		
            -- corruption,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314&!talent.absolute_corruption.enabled&(talent.siphon_life.enabled|spell_targets.seed_of_corruption_aoe>1&spell_targets.seed_of_corruption_aoe<=3)
            if A.Corruption:IsReady(unit) and not ShouldStop and (Unit("player"):CombatTime() > 30 and A.SummonDarkglare:GetCooldown() <= 15 and A.AzsharasFontofPower:IsExists() and not A.AbsoluteCorruption:IsSpellLearned() and (A.SiphonLife:IsSpellLearned() or MultiUnits:GetActiveEnemies() > 1 and MultiUnits:GetActiveEnemies() <= 3)) then
                return A.Corruption:Show(icon)
            end
		
            -- drain_soul,target_if=min:debuff.shadow_embrace.remains,cancel_if=ticks_remain<5,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=gcd*2
            if A.DrainSoul:IsReady(unit) and not isMoving and not ShouldStop and Action.Utils.CastTargetIf(A.DrainSoul, 40, "min", EvaluateTargetIfFilterDrainSoul787, EvaluateTargetIfDrainSoul802) then
                return A.DrainSoul:Show(icon)
            end
		
            -- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=execute_time*2+travel_time&!action.shadow_bolt.in_flight
            if A.ShadowBolt:IsReady(unit) and not isMoving and not ShouldStop and Action.Utils.CastTargetIf(A.ShadowBolt, 40, "min", EvaluateTargetIfFilterShadowBolt808, EvaluateTargetIfShadowBolt835) then
                return A.ShadowBolt:Show(icon)
            end
		
            -- phantom_singularity,target_if=max:target.time_to_die,if=time>35&target.time_to_die>16*spell_haste&(!essence.vision_of_perfection.minor&!azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains>45+soul_shard*azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains<15*spell_haste+soul_shard*azerite.dreadful_calling.rank)
            if A.PhantomSingularity:IsReady(unit) and (A.SummonDarkglare:GetCooldown() >= 45 or A.SummonDarkglare:IsReady(unit)) and not ShouldStop and Action.Utils.CastTargetIf(A.PhantomSingularity, 40, "min", EvaluateTargetIfFilterPhantomSingularity841, EvaluateTargetIfPhantomSingularity850) then
                return A.PhantomSingularity:Show(icon)
            end
				
            -- unstable_affliction,target_if=min:contagion,if=!variable.use_seed&soul_shard=5
            if A.UnstableAffliction:IsReady(unit, nil, nil, PredictSpells) and not isMoving and not ShouldStop and Action.Utils.CastTargetIf(A.UnstableAffliction, 40, "min", EvaluateTargetIfFilterUnstableAffliction865, EvaluateTargetIfUnstableAffliction870) then
                return A.UnstableAffliction:Show(icon)
            end
		
            -- seed_of_corruption,if=variable.use_seed&soul_shard=5
            if A.SeedofCorruption:IsReady(unit) and not isMoving and not ShouldStop and (isMulti or A.GetToggle(2, "AoE")) and (bool(VarUseSeed) and Player:SoulShardsP() == 5) then
                return A.SeedofCorruption:Show(icon)
            end	
		
            -- vile_taint,target_if=max:target.time_to_die,if=time>15&target.time_to_die>=10&(cooldown.summon_darkglare.remains>30|cooldown.summon_darkglare.remains<10&dot.agony.remains>=10&dot.corruption.remains>=10&(dot.siphon_life.remains>=10|!talent.siphon_life.enabled))
            if A.VileTaint:IsReady(unit) and not ShouldStop and Action.Utils.CastTargetIf(A.VileTaint, 40, "min", EvaluateTargetIfFilterVileTaint856, EvaluateTargetIfVileTaint859) then
                return A.VileTaint:Show(icon)
            end
		
            -- use_item,name=azsharas_font_of_power,if=time<=3
            if A.AzsharasFontofPower:IsExists() and not isMoving and TR.TrinketON() and not ShouldStop and A.AzsharasFontofPower:IsReady(unit) and (Unit("player"):CombatTime() <= 3) then
                return A.AzsharasFontofPower:Show(icon)
            end
		
            -- vile_taint,if=time<15
            if A.VileTaint:IsReady(unit) and not ShouldStop and (Unit("player"):CombatTime() < 15) then 
                return A.VileTaint:Show(icon)
            end
		
            -- dark_soul,if=cooldown.summon_darkglare.remains<15+soul_shard*azerite.dreadful_calling.enabled&(dot.phantom_singularity.remains|dot.vile_taint.remains|!talent.phantom_singularity.enabled&!talent.vile_taint.enabled)|target.time_to_die<20+gcd|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up
            if A.DarkSoulMisery:IsReady("player") and not ShouldStop and A.BurstIsON(unit) and A.SummonDarkglare:GetCooldown() < 15 and (Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true) or not A.PhantomSingularity:IsSpellLearned()) or Unit(unit):TimeToDie() < 20 + A.GetGCD() then
                return A.DarkSoulMisery:Show(icon)
            end
		
            -- guardian_of_azeroth,if=cooldown.summon_darkglare.remains<15+soul_shard*azerite.dreadful_calling.enabled|(azerite.dreadful_calling.rank|essence.vision_of_perfection.rank)&time>30&target.time_to_die>=210)&(dot.phantom_singularity.remains|dot.vile_taint.remains|!talent.phantom_singularity.enabled&!talent.vile_taint.enabled)|target.time_to_die<30+gcd
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and A.BurstIsON(unit) and A.SummonDarkglare:GetCooldown() < 15 + Player:SoulShardsP() * num(A.DreadfulCalling:GetAzeriteRank() >= 1) or ((A.DreadfulCalling:GetAzeriteRank() >= 1 or A.VisionofPerfectionMinor:IsSpellLearned()) and Unit("player"):CombatTime() > 30 and Unit(unit):TimeToDie() >= 210) and (Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff.ID, true) or Unit(unit):HasDeBuffs(A.VileTaint.ID, true) or not A.PhantomSingularity:IsSpellLearned() and not A.VileTaint:IsSpellLearned()) then
                return A.GuardianofAzeroth:Show(icon)
            end
		
            -- berserking
            if A.Berserking:AutoRacial(unit) and not ShouldStop and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
		
            -- call_action_list,name=spenders
            if (true) and not ShouldStop then
                if Spenders(unit) then 
                    return true 
                end 		
            end
		
            -- call_action_list,name=fillers
            if (true) and not ShouldStop then 
                if Fillers(unit) then 
                    return true 
                end 
            end
        end			

        -- Mouseover
        if unit == "mouseover" then  -- and not Unit(unit):IsTotem()
	
			-- Variables
		    local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover") 
            inRange = A.Agony:IsInRange(unit)
		
		    -- PetKick
            if useKick and A.PetKick:IsReady(unit) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
                return A.PetKick:Show(icon)
            end 

    	    -- SingeMagic
	        if A.SingeMagic:IsCastable() and not A.IsUnitEnemy("mouseover") and not ShouldStop and Action.AuraIsValid(unit, "UseDispel", "Magic") then
	            return A.SingeMagic:Show(icon)
            end		
	
            -- actions.mouseover+=/Agony
            if     (A.GetToggle(2, "AoE") or MultiUnits:GetActiveEnemies() <= 4) and Unit(unit):HasDeBuffs(A.AgonyDebuff.ID, true) <= 5.4 and A.Agony:IsReady(unit, true) and A.Agony:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() <= 40 and A.LastPlayerCastID ~= A.Agony.ID then 
                return A.Agony:Show(icon)
            end 
            
            -- actions.mouseover+=/Corruption
            if     (A.GetToggle(2, "AoE") or MultiUnits:GetActiveEnemies() <= 4) and Unit(unit):HasDeBuffs(A.Corruption.ID, true) <= 4.2 and A.Corruption:IsReady(unit, true) and A.Corruption:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() <= 40 and A.LastPlayerCastID ~= A.Corruption.ID then
			    return A.Corruption:Show(icon)
            end 
			
            -- actions.mouseover+=/SiphonLife
            if     (A.GetToggle(2, "AoE") or MultiUnits:GetActiveEnemies() <= 4) and Unit(unit):HasDeBuffs(A.SiphonLife.ID, true) <= 4.5 and A.SiphonLife:IsReady(unit, true) and A.SiphonLife:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):GetRange() <= 40 and A.LastPlayerCastID ~= A.SiphonLife.ID then 
                return A.SiphonLife:Show(icon)
            end 			
		end	
			
		

	end
	-- End on EnemyRotation()
	
    -- Defensive
    local SelfDefensive = SelfDefensives()
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
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
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
local function FreezingTrapUsedByEnemy()
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
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
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
end