-----------------------------
-- Taste TMW Action Rotation
-----------------------------
local Action                                 = Action
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
--local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
--local Pet                                     = LibStub("PetLibrary")
--local Azerite                                 = LibStub("AzeriteTraits")

local setmetatable                            = setmetatable


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
    -- Misc
    BurningRush                          = Action.Create({ Type = "Spell", ID = 278727     }),
    Channeling                            = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
	TargetEnemy                           = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
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
	TargetEnemy                           = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    CyclotronicBlast                      = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                 = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
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
    GuardianofAzeroth3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
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
    -- Here come all the stuff needed by simcraft but not classic spells or items. 
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARLOCK_AFFLICTION)        -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_AFFLICTION], { __index = Action })


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
		if Player:InRaid() then
    		return true
		else
		    return false
		end
    elseif choice == "In Dungeon" then 
		if Player:InDungeon() then
    		return true
		else
		    return false
		end
	elseif choice == "In PvP" then 	
		if Player:InPvP() then 
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

-- Agony TickTime
local function AgonyTickTime()
    local BaseTickTime = 2
    if not BaseTickTime or BaseTickTime == 0 then 
	    return 0 
	end
    local Hasted = true
    if Hasted then
        return BaseTickTime * Player:SpellHaste() 
	end
    return BaseTickTime
end

-- "time.to.shard"
local function TimeToShard()
    local ActiveAgony = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.Agony.ID, 5)
    if ActiveAgony == 0 then
        return 10000 
    end
    return 1 / (0.16 / math.sqrt(ActiveAgony) * (ActiveAgony == 1 and 1.15 or 1) * ActiveAgony / AgonyTickTime())
end

-- Enum all UnstableAffliction Debuffs
local UnstableAfflictionDebuffs = {
    233490,
    233496,
    233497,
    233498,
    233499
};

-- Return ActiveUAs count
local function ActiveUAs(unit)
    local UACount = 0
    for _, UADebuff in pairs(UnstableAfflictionDebuffs) do
        if Unit(unit):HasDeBuffs(UADebuff) > 0 then 
		    UACount = UACount + 1 
		end
    end
    return UACount
end

-- "contagion"
local function Contagion(unit)
    local MaximumDuration = 0
    for _, UADebuff in pairs(UnstableAfflictionDebuffs) do
        local UARemains = Unit(unit):HasDeBuffs(UADebuff)
        if UARemains > MaximumDuration then
            MaximumDuration = UARemains
        end
    end
    return MaximumDuration
end

local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, {"TotalImun", "DamageMagicImun", "KickImun"}, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        return A.PetKick
    end 
    
    if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, {"TotalImun", "DamageMagicImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("stun", 0) then 
        return A.Shadowfury              
    end          
	
	if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, {"TotalImun", "DamagePhysImun", "CCTotalImun"}, true) and Unit(unit):IsControlAble("disorient", 0) then 
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
local function EvaluateTargetIfFilterAgony160(Target)
    return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID)
end

local function EvaluateTargetIfAgony201(Target)
    return A.CreepingDeath:IsSpellLearned() and ActiveAgony < 6 and Unit(unit):TimeToDie() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID) < 5 or not bool(A.PandemicInvocation:AzeriteRank()) and Target:DebuffRefreshableCP(A.AgonyDebuff.ID)))
end

local function EvaluateTargetIfFilterAgony207(Target)
    return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID)
end

local function EvaluateTargetIfAgony248(Target)
    return not A.CreepingDeath:IsSpellLearned() and ActiveAgony < 8 and Unit(unit):TimeToDie() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and (Unit(unit):HasDeBuffs(A.AgonyDebuff.ID) < 5 or not bool(A.PandemicInvocation:AzeriteRank()) and Target:DebuffRefreshableCP(A.AgonyDebuff.ID)))
end

local function EvaluateTargetIfFilterSiphonLife254(Target)
    return Unit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID)
end

local function EvaluateTargetIfSiphonLife293(Target)
    return (ActiveSiphonLife < 8 - num(A.CreepingDeath:IsSpellLearned()) - MultiUnits:GetByRange(40, 5)) and Unit(unit):TimeToDie() > 10 and Target:DebuffRefreshableCP(A.SiphonLifeDebuff.ID) and (Target:DebuffDownP(A.SiphonLifeDebuff.ID) and MultiUnits:GetByRange(40, 5) == 1 or A.SummonDarkglare:GetCooldown() > Player:SoulShardsP() * A.UnstableAffliction:GetSpellCastTime())
end

local function EvaluateCycleCorruption300(Target)
    return MultiUnits:GetByRange(40, 5) < 3 + num(A.WritheInAgony:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID) <= A.GetGCD() or A.SummonDarkglare:GetCooldown() > 10 and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID) <= 4) and Unit(unit):TimeToDie() > 10
end

local function EvaluateCycleDrainSoul479(Target)
    return Unit(unit):TimeToDie() <= A.GetGCD()
end

local function EvaluateTargetIfFilterDrainSoul485(Target)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID)
end

local function EvaluateTargetIfDrainSoul498(Target)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and Target:DebuffDownP(A.ShadowEmbraceDebuff.ID)
end

local function EvaluateTargetIfFilterDrainSoul504(Target)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID)
end

local function EvaluateTargetIfDrainSoul515(Target)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe)
end

local function EvaluateCycleShadowBolt524(Target)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and Target:DebuffDownP(A.ShadowEmbraceDebuff.ID) and not A.ShadowBolt:IsSpellInFlight()
end

local function EvaluateTargetIfFilterShadowBolt540(Target)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID)
end

local function EvaluateTargetIfShadowBolt551(Target)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe)
end

local function EvaluateCycleUnstableAffliction640(Target)
    return not bool(VarUseSeed) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() > time_to_shard or Player:SoulShardsP() > 1) and (not A.VileTaint:IsSpellLearned() or Player:SoulShardsP() > 1) and contagion <= A.UnstableAffliction:CastTime() + VarPadding and (not A.CascadingCalamity:AzeriteEnabled() or Player:BuffRemainsP(A.CascadingCalamityBuff.ID) > time_to_shard)
end

local function EvaluateCycleDrainSoul711(Target)
    return Unit(unit):TimeToDie() <= A.GetGCD() and Player:SoulShardsP() < 5
end

local function EvaluateTargetIfFilterAgony751(Target)
    return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID)
end

local function EvaluateTargetIfAgony768(Target)
    return Unit(unit):HasDeBuffs(A.AgonyDebuff.ID) <= A.GetGCD() + A.ShadowBolt:GetSpellCastTime() and Unit(unit):TimeToDie() > 8
end

local function EvaluateCycleUnstableAffliction781(Target)
    return not bool(contagion) and Unit(unit):TimeToDie() <= 8
end

local function EvaluateTargetIfFilterDrainSoul787(Target)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID)
end

local function EvaluateTargetIfDrainSoul802(Target)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID) <= A.GetGCD() * 2
end

local function EvaluateTargetIfFilterShadowBolt808(Target)
    return Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID)
end

local function EvaluateTargetIfShadowBolt835(Target)
    return A.ShadowEmbrace:IsSpellLearned() and bool(VarMaintainSe) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff) and Unit(unit):HasDeBuffs(A.ShadowEmbraceDebuff.ID) <= A.ShadowBolt:GetSpellCastTime() * 2 + A.ShadowBolt:TravelTime() and not A.ShadowBolt:IsSpellInFlight()
end

local function EvaluateTargetIfFilterPhantomSingularity841(Target)
    return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfPhantomSingularity850(Target)
    return Unit("player"):CombatTime() > 35 and Unit(unit):TimeToDie() > 16 * Player:SpellHaste() and (not A.VisionofPerfectionMinor:IsSpellLearned() and not bool(A.DreadfulCalling:AzeriteRank()) or A.SummonDarkglare:GetCooldown() > 45 + Player:SoulShardsP() * A.DreadfulCalling:AzeriteRank() or A.SummonDarkglare:GetCooldown() < 15 * Player:SpellHaste() + Player:SoulShardsP() * A.DreadfulCalling:AzeriteRank())
end

local function EvaluateTargetIfFilterVileTaint856(Target)
    return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfVileTaint859(Target)
    return Unit("player"):CombatTime() > 15 and Unit(unit):TimeToDie() >= 10 and (A.SummonDarkglare:GetCooldown() > 30 or A.SummonDarkglare:GetCooldown() < 10 and Unit(unit):HasDeBuffs(A.CorruptionDebuff.ID) >= 10 and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) >= 10 or not A.SiphonLife:IsSpellLearned()))
end

local function EvaluateTargetIfFilterUnstableAffliction865(Target)
    return contagion
end

local function EvaluateTargetIfUnstableAffliction870(Target)
    return not bool(VarUseSeed) and Player:SoulShardsP() == 5
end

local function Init ()
  HL.RegisterNucleusAbility(27285, 10, 6)               -- Seed Explosion
end
-- Init data for splash data (To Check)
Init()



-- [3] Single Rotation
A[3] = function(icon, isMulti)

    local ActiveAgony = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.Agony.ID, 5)
    local ActiveCorruption = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.Corruption.ID, 5)
    local ActiveSiphonLife = MultiUnits:GetByRangeAppliedDoTs(40, 10, A.SiphonLife.ID, 5)
    local isMoving = Player:IsMoving()
	local ShouldStop = Action.ShouldStop()
	local Pull = Action.BossMods_Pulling()
    local CanMultidot = HandleMultidots()
	local unit = "player"
	-- Simc
    local time_to_shard = TimeToShard()
    local contagion = Contagion()
	
	-- Rotation
	local function EnemyRotation(unit)
	


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
        print("No Pet Data") 
    end	
	
	-- Multidots var
	MissingCorruption = MultiUnits:GetByRangeMissedDoTs(40, 5, 146739) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
	MissingAgony = MultiUnits:GetByRangeMissedDoTs(40, 5, 980) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    --print(MissingVampiricTouch)
    AppliedCorruption = MultiUnits:GetByRangeAppliedDoTs(40, 5, 146739) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
 	AppliedAgony = MultiUnits:GetByRangeAppliedDoTs(40, 5, 980) --MultiDots(40, A.FlameShockDebuff, 15, 4) --MultiUnits:GetByRangeMissedDoTs(40, 10, 188389)  MultiUnits:GetByRangeMissedDoTs(range, stop, dots, ttd)
    --print(AppliedVampiricTouch)
    CorruptionToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 146739, 5)
    AgonyToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 980, 5)
    --SiphonLifeToRefresh = MultiUnits:GetByRangeDoTsToRefresh(40, 5, 980, 5)
	--print(VampiricTouchToRefresh)
	
	
	local function Precombat_DBM()
	if Everyone.TargetIsValid() then
        -- summon_pet
        if SummonPet:IsCastableP() and not ShouldStop and (not Player:IsMoving()) and not Player:ShouldStopCasting() and not Pet:IsActive() and (not bool(Player:BuffRemainsP(A.GrimoireofSacrificeBuff)))  then
            if HR.Cast(SummonPet, true) then return "summon_pet 3"; end
        end
        -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
        if A.GrimoireofSacrifice:IsCastableP() and not ShouldStop and Player:BuffDownP(A.GrimoireofSacrificeBuff) and (A.GrimoireofSacrifice:IsSpellLearned()) then
            if HR.Cast(A.GrimoireofSacrifice, true) then return "grimoire_of_sacrifice 5"; end
         end
        -- snapshot_stats
        -- pre potion haunt
        if I.PotionofUnbridledFury:IsReady() and not ShouldStop and A.Haunt:IsSpellLearned() and Action.GetToggle(1, "Potion") and Pull > A.Haunt:GetSpellCastTime() + 1 and Pull <= A.Haunt:GetSpellCastTime() + 2 then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 14"; end
        end
        -- pre potion no haunt
        if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") and not A.Haunt:IsSpellLearned() and Pull > A.Haunt:GetSpellCastTime() + 1 and Pull <= A.ShadowBolt:GetSpellCastTime() + 2 then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 14"; end
        end
        -- haunt
        if A.Haunt:IsCastableP() and not ShouldStop and not Player:IsMoving() and Pull > 0.1 and Pull <= A.Haunt:GetSpellCastTime() + 0.05 and (not Player:IsMoving()) and not Player:ShouldStopCasting() and Player:DebuffDownP(A.HauntDebuff) then
            if HR.Cast(A.Haunt) then return "haunt 20"; end
        end
        -- shadow_bolt,if=!talent.haunt.enabled&spell_targets.seed_of_corruption_aoe<3
        if A.ShadowBolt:IsCastableP() and not ShouldStop and Pull > 0.1 and Pull <= A.ShadowBolt:GetSpellCastTime() and (not Player:IsMoving()) and not Player:ShouldStopCasting() and (not A.Haunt:IsSpellLearned() and active_enemies() < 3) then
            if HR.Cast(A.ShadowBolt) then return "shadow_bolt 24"; end
        end
        return 0, 462338
	end
    end
    
    local function Precombat()
        -- flask
        -- food
        -- summon_pet
        if SummonPet:IsCastableP() and not ShouldStop and not Pet:Exists() then
            if HR.Cast(SummonPet, true) then return "summon_pet 3"; end
        end
	  if Everyone.TargetIsValid() then
        -- augmentation
        -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
        if A.GrimoireofSacrifice:IsCastableP() and not ShouldStop and Player:BuffDownP(A.GrimoireofSacrificeBuff) and (A.GrimoireofSacrifice:IsSpellLearned()) then
            if HR.Cast(A.GrimoireofSacrifice, true) then return "grimoire_of_sacrifice 5"; end
        end
        -- TODO Check for valid target
        --if TargetIsValid() then
        -- use_item,name=azsharas_font_of_power
        -- Using main icon, since only Haunt will be suggested precombat if equipped and that's optional
        if I.AzsharasFontofPower:IsEquipped() and TrinketON() and not ShouldStop and I.AzsharasFontofPower:IsReady() then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 15"; end
        end
        -- seed_of_corruption,if=spell_targets.seed_of_corruption_aoe>=3&!equipped.169314
        if A.SeedofCorruption:IsCastableP() and not ShouldStop and Action.GetToggle(2, "AoE") and Player:DebuffDownP(A.SeedofCorruptionDebuff) and (MultiUnits:GetByRange(40, 5) >= 3 and not I.AzsharasFontofPower:IsEquipped()) then
            if HR.Cast(A.SeedofCorruption) then return "seed_of_corruption 16"; end
        end
        -- haunt
        if A.Haunt:IsCastableP() and not ShouldStop and Player:DebuffDownP(A.HauntDebuff) then
            if HR.Cast(A.Haunt) then return "haunt 20"; end
        end
        -- shadow_bolt,if=!talent.haunt.enabled&spell_targets.seed_of_corruption_aoe<3&!equipped.169314
        if A.ShadowBolt:IsCastableP() and not ShouldStop and (not A.Haunt:IsSpellLearned() and MultiUnits:GetByRange(40, 5) < 3 and not I.AzsharasFontofPower:IsEquipped()) then
            if HR.Cast(A.ShadowBolt) then return "shadow_bolt 24"; end
        end
      end
    end
    
    local function Cooldowns()
        -- use_item,name=azsharas_font_of_power,if=(!talent.phantom_singularity.enabled|cooldown.phantom_singularity.remains<4*spell_haste|!cooldown.phantom_singularity.remains)&cooldown.summon_darkglare.remains<19*spell_haste+soul_shard*azerite.dreadful_calling.rank&dot.agony.remains&dot.corruption.remains&(dot.siphon_life.remains|!talent.siphon_life.enabled)
        if I.AzsharasFontofPower:IsEquipped() and TrinketON() and not ShouldStop and I.AzsharasFontofPower:IsReady() and ((not A.PhantomSingularity:IsSpellLearned() or A.PhantomSingularity:GetCooldown() < 4 * Player:SpellHaste() or A.PhantomSingularity:CooldownUpP()) and A.SummonDarkglare:GetCooldown() < 19 * Player:SpellHaste() + Player:SoulShardsP() * A.DreadfulCalling:AzeriteRank() and Unit(unit):HasDeBuffs(A.AgonyDebuff) and Unit(unit):HasDeBuffs(A.CorruptionDebuff) and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) or not A.SiphonLife:IsSpellLearned())) then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 30"; end
        end
        -- potion,if=(talent.dark_soul_misery.enabled&cooldown.summon_darkglare.up&cooldown.dark_soul.up)|cooldown.summon_darkglare.up|target.time_to_die<30
        if I.PotionofUnbridledFury:IsReady() and not ShouldStop and Action.GetToggle(1, "Potion") and ((A.DarkSoulMisery:IsSpellLearned() and A.SummonDarkglare:CooldownUpP() and A.DarkSoulMisery:CooldownUpP()) or A.SummonDarkglare:CooldownUpP() or Unit(unit):TimeToDie() < 30) then
            if HR.Cast(I.PotionofUnbridledFury) then return "battle_potion_of_intellect 40"; end
        end
        -- use_items,if=cooldown.summon_darkglare.remains>70|time_to_die<20|((buff.active_uas.stack=5|soul_shard=0)&(!talent.phantom_singularity.enabled|cooldown.phantom_singularity.remains)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=gcd|!cooldown.deathbolt.remains)&!cooldown.summon_darkglare.remains)
        -- fireblood,if=!cooldown.summon_darkglare.up
        if A.Fireblood:IsCastableP() and not ShouldStop and HR.CDsON() and (not A.SummonDarkglare:CooldownUpP()) then
            if HR.Cast(A.Fireblood, Action.GetToggle(2, "OffGCDasOffGCD")) then return "fireblood 51"; end
        end
        -- blood_fury,if=!cooldown.summon_darkglare.up
        if A.BloodFury:IsCastableP() and not ShouldStop and HR.CDsON() and (not A.SummonDarkglare:CooldownUpP()) then
            if HR.Cast(A.BloodFury, Action.GetToggle(2, "OffGCDasOffGCD")) then return "blood_fury 55"; end
        end
        -- memory_of_lucid_dreams,if=time>30
        if A.MemoryofLucidDreams:IsCastableP() and not ShouldStop and HR.CDsON() and (Unit("player"):CombatTime() > 30) then
            if HR.Cast(A.UnleashHeartOfAzeroth, Action.GetToggle(2, "OffGCDasOffGCD")) then return ""; end
        end
        -- dark_soul,if=target.time_to_die<20+gcd|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up|talent.sow_the_seeds.enabled&cooldown.summon_darkglare.remains>=cooldown.summon_darkglare.duration-10
        if A.DarkSoulMisery:IsReadyP() and  HR.CDsON() and (Unit(unit):TimeToDie() < 20 + A.GetGCD() or MultiUnits:GetByRange(40, 5) > 1 or A.SowtheSeeds:IsSpellLearned() and A.SummonDarkglare:GetCooldown() >= A.SummonDarkglare:BaseDuration() - 10) then
            if HR.Cast(A.DarkSoulMisery, Action.GetToggle(2, "OffGCDasOffGCD")) then return ""; end
        end
        -- blood_of_the_enemy,if=pet.darkglare.remains|(!cooldown.deathbolt.remains|!talent.deathbolt.enabled)&cooldown.summon_darkglare.remains>=80&essence.blood_of_the_enemy.rank>1
        if A.BloodoftheEnemy:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (A.SummonDarkglare:GetCooldown() > 160 or (A.Deathbolt:CooldownUpP() or not A.Deathbolt:IsSpellLearned()) and A.SummonDarkglare:GetCooldown() >= 80 and not A.BloodoftheEnemy:ID() == 297108) then
            if HR.Cast(A.UnleashHeartOfAzeroth) then return ""; end
        end
        -- use_item,name=pocketsized_computation_device,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
        if I.PocketsizedComputationDevice:IsEquipped() and TrinketON() and I.PocketsizedComputationDevice:IsReady() and Action.AbsentImun(nil, unit, "DamageMagicImun") and (A.SummonDarkglare:GetCooldown() >= 25 and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
            if HR.Cast(I.PocketsizedComputationDevice) then return "pocketsized_computation_device 50"; end
        end
        -- use_item,name=rotcrusted_voodoo_doll,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
        if I.RotcrustedVoodooDoll:IsEquipped() and TrinketON() and not ShouldStop and I.RotcrustedVoodooDoll:IsReady() and (A.SummonDarkglare:GetCooldown() >= 25 and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
            if HR.Cast(I.RotcrustedVoodooDoll) then return "rotcrusted_voodoo_doll"; end
        end
        -- use_item,name=shiver_venom_relic,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
        if I.ShiverVenomRelic:IsEquipped() and TrinketON() and not ShouldStop and Target:DebuffStackP(A.ShiverVenomDebuff) >= 5 and I.ShiverVenomRelic:IsReady() and (A.SummonDarkglare:GetCooldown() >= 25 and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
            if HR.Cast(I.ShiverVenomRelic) then return "shiver_venom_relic"; end
        end
        -- use_item,name=aquipotent_nautilus,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
        if I.AquipotentNautilus:IsEquipped() and TrinketON() and not ShouldStop and I.AquipotentNautilus:IsReady() and (A.SummonDarkglare:GetCooldown() >= 25 and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
            if HR.Cast(I.AquipotentNautilus) then return "aquipotent_nautilus"; end
        end
        -- use_item,name=tidestorm_codex,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
        if I.TidestormCodex:IsEquipped() and TrinketON() and not ShouldStop and I.TidestormCodex:IsReady() and (A.SummonDarkglare:GetCooldown() >= 25 and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
            if HR.Cast(I.TidestormCodex) then return "tidestorm_codex"; end
        end
        -- use_item,name=vial_of_storms,if=cooldown.summon_darkglare.remains>=25&(cooldown.deathbolt.remains|!talent.deathbolt.enabled)
        if I.VialofStorms:IsEquipped() and TrinketON() and not ShouldStop and I.VialofStorms:IsReady() and (A.SummonDarkglare:GetCooldown() >= 25 and (bool(A.Deathbolt:GetCooldown()) or not A.Deathbolt:IsSpellLearned())) then
            if HR.Cast(I.VialofStorms) then return "vial_of_storms"; end
        end
        -- worldvein_resonance,if=buff.lifeblood.stack<3
        if A.WorldveinResonance:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Player:BuffStackP(A.LifebloodBuff) < 3) then
            if HR.Cast(A.WorldveinResonance) then return "worldvein_resonance 63"; end
        end
        -- ripple_in_space
        if A.RippleInSpace:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(A.RippleInSpace) then return "ripple_in_space 67"; end
        end
    end
    
    local function DbRefresh()
        -- siphon_life,line_cd=15,if=(dot.siphon_life.remains%dot.siphon_life.duration)<=(dot.agony.remains%dot.agony.duration)&(dot.siphon_life.remains%dot.siphon_life.duration)<=(dot.corruption.remains%dot.corruption.duration)&dot.siphon_life.remains<dot.siphon_life.duration*1.3
        if A.SiphonLife:IsCastableP() and not ShouldStop and ((Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) / A.SiphonLifeDebuff:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.AgonyDebuff) / A.AgonyDebuff:BaseDuration()) and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) / A.SiphonLifeDebuff:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.CorruptionDebuff) / A.CorruptionDebuff:BaseDuration()) and Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) < A.SiphonLifeDebuff:BaseDuration() * 1.3) then
            if HR.Cast(A.SiphonLife) then return "siphon_life 69"; end
        end
        -- agony,line_cd=15,if=(dot.agony.remains%dot.agony.duration)<=(dot.corruption.remains%dot.corruption.duration)&(dot.agony.remains%dot.agony.duration)<=(dot.siphon_life.remains%dot.siphon_life.duration)&dot.agony.remains<dot.agony.duration*1.3
        if A.Agony:IsCastableP() and not ShouldStop and ((Unit(unit):HasDeBuffs(A.AgonyDebuff) / A.AgonyDebuff:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.CorruptionDebuff) / A.CorruptionDebuff:BaseDuration()) and (Unit(unit):HasDeBuffs(A.AgonyDebuff) / A.AgonyDebuff:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) / A.SiphonLifeDebuff:BaseDuration()) and Unit(unit):HasDeBuffs(A.AgonyDebuff) < A.AgonyDebuff:BaseDuration() * 1.3) then
            if HR.Cast(A.Agony) then return "agony 91"; end
        end
        -- corruption,line_cd=15,if=(dot.corruption.remains%dot.corruption.duration)<=(dot.agony.remains%dot.agony.duration)&(dot.corruption.remains%dot.corruption.duration)<=(dot.siphon_life.remains%dot.siphon_life.duration)&dot.corruption.remains<dot.corruption.duration*1.3
        if A.Corruption:IsCastableP() and not A.AbsoluteCorruption:IsSpellLearned() and not ShouldStop and ((Unit(unit):HasDeBuffs(A.CorruptionDebuff) / A.CorruptionDebuff:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.AgonyDebuff) / A.AgonyDebuff:BaseDuration()) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff) / A.CorruptionDebuff:BaseDuration()) <= (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) / A.SiphonLifeDebuff:BaseDuration()) and Unit(unit):HasDeBuffs(A.CorruptionDebuff) < A.CorruptionDebuff:BaseDuration() * 1.3) then
            if HR.Cast(A.Corruption) then return "corruption 113"; end
        end
    end
    
    
    local function Dots()
        -- seed_of_corruption,if=dot.corruption.remains<=action.seed_of_corruption.cast_time+time_to_shard+4.2*(1-talent.creeping_death.enabled*0.15)&spell_targets.seed_of_corruption_aoe>=3+raid_event.invulnerable.up+talent.writhe_in_agony.enabled&!dot.seed_of_corruption.remains&!action.seed_of_corruption.in_flight
        if A.SeedofCorruption:IsCastableP() and not ShouldStop and Action.GetToggle(2, "AoE") and (Unit(unit):HasDeBuffs(A.CorruptionDebuff) <= A.SeedofCorruption:CastTime() + time_to_shard + 4.2 * (1 - num(A.CreepingDeath:IsSpellLearned()) * 0.15) and MultiUnits:GetByRange(40, 5) >= 3 + num(A.WritheInAgony:IsSpellLearned()) and Target:DebuffDownP(A.SeedofCorruptionDebuff) and not A.SeedofCorruption:IsSpellInFlight()) then
            if HR.Cast(A.SeedofCorruption) then return "seed_of_corruption 135"; end
        end
        -- agony,target_if=min:remains,if=talent.creeping_death.enabled&active_dot.agony<6&target.time_to_die>10&(remains<=gcd|cooldown.summon_darkglare.remains>10&(remains<5|!azerite.pandemic_invocation.rank&refreshable))
        if A.Agony:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterAgony160(Target) and EvaluateTargetIfAgony201(Target)  then
            if HR.Cast(A.Agony) then return "agony 203" end
        end
        -- agony,target_if=min:remains,if=!talent.creeping_death.enabled&active_dot.agony<8&target.time_to_die>10&(remains<=gcd|cooldown.summon_darkglare.remains>10&(remains<5|!azerite.pandemic_invocation.rank&refreshable))
        if A.Agony:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterAgony207(Target) and EvaluateTargetIfAgony248(Target) then
            if HR.Cast(A.Agony) then return "agony 250" end
        end
        -- siphon_life,target_if=min:remains,if=(active_dot.siphon_life<8-talent.creeping_death.enabled-spell_targets.sow_the_seeds_aoe)&target.time_to_die>10&refreshable&(!remains&spell_targets.seed_of_corruption_aoe=1|cooldown.summon_darkglare.remains>soul_shard*action.unstable_affliction.execute_time)
        if A.SiphonLife:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterSiphonLife254(Target) and EvaluateTargetIfSiphonLife293(Target) then
            if HR.Cast(A.SiphonLife) then return "siphon_life 295" end
        end
		-- siphon_life,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314
        if A.SiphonLife:IsCastableP() and not ShouldStop and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) <= 4 or Target:DebuffDownP(A.SiphonLifeDebuff)) and Unit("player"):CombatTime() < 15 then
            if HR.Cast(A.SiphonLife) then return "siphon_life 774"; end
        end
		-- corruption,cycle_targets=1,if=!prevgcd.corruption&refreshable&target.time_to_die<=5
        if A.Corruption:IsCastableP() and not ShouldStop and not A.AbsoluteCorruption:IsSpellLearned() and not Player:PrevGCDP(1, A.Corruption) and (Target:DebuffDownP(A.CorruptionDebuff) or Unit(unit):HasDeBuffs(A.CorruptionDebuff) <= 4) then
		    if HR.Cast(A.Corruption) then return "corruption 318" end
        end
        -- corruption,cycle_targets=1,if=spell_targets.seed_of_corruption_aoe<3+raid_event.invulnerable.up+talent.writhe_in_agony.enabled&(remains<=gcd|cooldown.summon_darkglare.remains>10&refreshable)&target.time_to_die>10
        if A.Corruption:IsCastableP() and not A.AbsoluteCorruption:IsSpellLearned() and (Target:DebuffDownP(A.CorruptionDebuff) or Unit(unit):HasDeBuffs(A.CorruptionDebuff) <= 4) and not ShouldStop and EvaluateCycleCorruption300(Target) then
            if HR.Cast(A.Corruption) then return "corruption 318" end
        end
		-- corruption,cycle_targets=1,if=!prevgcd.corruption&refreshable&target.time_to_die<=5
        if A.Corruption:IsCastableP() and A.AbsoluteCorruption:IsSpellLearned() and not Player:PrevGCDP(1, A.Corruption) and not Target:Debuff(A.CorruptionDebuff) and (Unit("player"):CombatTime() <= 5 or Unit(unit):TimeToDie() <= 30) then
            if HR.Cast(A.Corruption) then return "corruption 318" end
        end	
    end
    
    
    local function Fillers()
        -- unstable_affliction,line_cd=15,if=cooldown.deathbolt.remains<=gcd*2&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&cooldown.summon_darkglare.remains>20
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and A.Deathbolt:GetCooldown() <= A.GetGCD() * 2 and MultiUnits:GetByRange(40, 5) == 1 and A.SummonDarkglare:GetCooldown() > 20 then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 319"; end
        end
        -- unstable_affliction,line_cd=15,if=cooldown.deathbolt.remains<=gcd*2&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&cooldown.summon_darkglare.remains>20
        if not HR.CDsON() and A.UnstableAffliction:IsReadyP() and Player:SoulShardsP() >= 1 and not ShouldStop and not bool(VarUseSeed) and contagion <= A.UnstableAffliction:CastTime() + VarPadding  then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 319"; end
        end
        -- call_action_list,name=db_refresh,if=talent.deathbolt.enabled&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&(dot.agony.remains<dot.agony.duration*0.75|dot.corruption.remains<dot.corruption.duration*0.75|dot.siphon_life.remains<dot.siphon_life.duration*0.75)&cooldown.deathbolt.remains<=action.agony.gcd*4&cooldown.summon_darkglare.remains>20
        if HR.CDsON() and (A.Deathbolt:IsSpellLearned() and not ShouldStop and MultiUnits:GetByRange(40, 5) == 1 and (Unit(unit):HasDeBuffs(A.AgonyDebuff) < A.AgonyDebuff:BaseDuration() * 0.75 or Unit(unit):HasDeBuffs(A.CorruptionDebuff) < A.CorruptionDebuff:BaseDuration() * 0.75 or Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) < A.SiphonLifeDebuff:BaseDuration() * 0.75) and A.Deathbolt:GetCooldown() <= A.Agony:GCD() * 4 and A.SummonDarkglare:GetCooldown() > 20) then
            local ShouldReturn = DbRefresh(); if ShouldReturn then return ShouldReturn; end
        end
        -- call_action_list,name=db_refresh,if=talent.deathbolt.enabled&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&cooldown.summon_darkglare.remains<=soul_shard*action.agony.gcd+action.agony.gcd*3&(dot.agony.remains<dot.agony.duration*1|dot.corruption.remains<dot.corruption.duration*1|dot.siphon_life.remains<dot.siphon_life.duration*1)
        if HR.CDsON() and A.Deathbolt:IsSpellLearned() and not ShouldStop and MultiUnits:GetByRange(40, 5) == 1 and A.SummonDarkglare:GetCooldown() <= Player:SoulShardsP() * A.Agony:GCD() + A.Agony:GCD() * 3 and (Unit(unit):HasDeBuffs(A.AgonyDebuff) < A.AgonyDebuff:BaseDuration() * 1 or Unit(unit):HasDeBuffs(A.CorruptionDebuff) < A.CorruptionDebuff:BaseDuration() * 1 or Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) < A.SiphonLifeDebuff:BaseDuration() * 1) then
            local ShouldReturn = DbRefresh(); if ShouldReturn then return ShouldReturn; end
        end
        -- deathbolt,if=cooldown.summon_darkglare.remains>=30+gcd|cooldown.summon_darkglare.remains>140
        if A.Deathbolt:IsCastableP() and not ShouldStop and ActiveUAs() >= 1 and Player:SoulShardsP() <= 1 and (A.SummonDarkglare:GetCooldown() >= 30 + A.GetGCD() or A.SummonDarkglare:GetCooldown() > 140) then
            if HR.Cast(A.Deathbolt) then return "deathbolt 381"; end
        end
        -- shadow_bolt,if=buff.movement.up&buff.nightfall.remains
        if A.ShadowBolt:IsCastableP() and not ShouldStop and Player:IsMoving() and Player:BuffP(A.NightfallBuff) then
            if HR.Cast(A.ShadowBolt) then return "shadow_bolt 387"; end
        end
        -- agony,if=buff.movement.up&!(talent.siphon_life.enabled&(prev_gcd.1.agony&prev_gcd.2.agony&prev_gcd.3.agony)|prev_gcd.1.agony)
        if A.Agony:IsCastableP() and not ShouldStop and Player:IsMoving() and not (A.SiphonLife:IsSpellLearned() and (Player:PrevGCDP(1, A.Agony) and Player:PrevGCDP(2, A.Agony) and Player:PrevGCDP(3, A.Agony)) or Player:PrevGCDP(1, A.Agony)) then
            if HR.Cast(A.Agony) then return "agony 391"; end
        end
        -- siphon_life,if=buff.movement.up&!(prev_gcd.1.siphon_life&prev_gcd.2.siphon_life&prev_gcd.3.siphon_life)
        if A.SiphonLife:IsCastableP() and not ShouldStop and Player:IsMoving() and not (Player:PrevGCDP(1, A.SiphonLife) and Player:PrevGCDP(2, A.SiphonLife) and Player:PrevGCDP(3, A.SiphonLife)) then
            if HR.Cast(A.SiphonLife) then return "siphon_life 403"; end
        end
        -- corruption,if=buff.movement.up&!prev_gcd.1.corruption&!talent.absolute_corruption.enabled
        if A.Corruption:IsCastableP() and not ShouldStop and Player:IsMoving() and not Player:PrevGCDP(1, A.Corruption) and not A.AbsoluteCorruption:IsSpellLearned() and not Unit(unit):HasDeBuffs(A.CorruptionDebuff) then
            if HR.Cast(A.Corruption) then return "corruption 411"; end
        end
        --  drain_life,if=buff.inevitable_demise.stack>10&target.time_to_die<=10
        if A.DrainLife:IsCastableP() and not ShouldStop and Player:BuffStackP(A.InevitableDemiseBuff) > 10 and Unit(unit):TimeToDie() <= 10 then
            if HR.Cast(A.DrainLife) then return "drain_life 412"; end
        end
        -- drain_life,if=talent.siphon_life.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=2)&dot.agony.remains>5*spell_haste&dot.corruption.remains>gcd&(dot.siphon_life.remains>gcd|!talent.siphon_life.enabled)&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
        if A.DrainLife:IsCastableP() and not ShouldStop and A.SiphonLife:IsSpellLearned() and Player:BuffStackP(A.InevitableDemiseBuff) >= 50 - 20 * num(MultiUnits:GetByRange(40, 5) >= 2) and Unit(unit):HasDeBuffs(A.AgonyDebuff) > 5 * Player:SpellHaste() and Unit(unit):HasDeBuffs(A.CorruptionDebuff) > A.GetGCD() and (Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) > A.GetGCD() or not A.SiphonLife:IsSpellLearned()) and (Unit(unit):HasDeBuffs(A.HauntDebuff) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste() then
            if HR.Cast(A.DrainLife) then return "drain_life 413"; end
        end
        -- drain_life,if=talent.writhe_in_agony.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=3)-5*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up=2)&dot.agony.remains>5*spell_haste&dot.corruption.remains>gcd&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
        if A.DrainLife:IsCastableP() and not ShouldStop and A.WritheInAgony:IsSpellLearned() and Player:BuffStackP(A.InevitableDemiseBuff) >= 50 - 20 * num(MultiUnits:GetByRange(40, 5) >= 3) - 5 * num(MultiUnits:GetByRange(40, 5) == 2) and Unit(unit):HasDeBuffs(A.AgonyDebuff) > 5 * Player:SpellHaste() and Target.DebuffRemainsP(A.CorruptionDebuff) > A.GetGCD() and (Unit(unit):HasDeBuffs(A.HauntDebuff) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste() then
            if HR.Cast(A.DrainLife) then return "drain_life 414"; end
        end
        -- drain_life,if=talent.absolute_corruption.enabled&buff.inevitable_demise.stack>=50-20*(spell_targets.seed_of_corruption_aoe-raid_event.invulnerable.up>=4)&dot.agony.remains>5*spell_haste&(debuff.haunt.remains>5*spell_haste|!talent.haunt.enabled)&contagion>5*spell_haste
        if A.DrainLife:IsCastableP() and not ShouldStop and A.AbsoluteCorruption:IsSpellLearned() and Player:BuffStackP(A.InevitableDemiseBuff) >= 50 - 20 * num(MultiUnits:GetByRange(40, 5) >= 4) and Unit(unit):HasDeBuffs(A.AgonyDebuff) > 5 * Player:SpellHaste() and (Unit(unit):HasDeBuffs(A.HauntDebuff) > 5 * Player:SpellHaste() or not A.Haunt:IsSpellLearned()) and contagion > 5 * Player:SpellHaste() then
            if HR.Cast(A.DrainLife) then return "drain_life 415"; end
        end
        -- haunt
        if A.Haunt:IsCastableP() and not ShouldStop then
            if HR.Cast(A.Haunt) then return "haunt 461"; end
        end
        -- focused_azerite_beam
        if A.FocusedAzeriteBeam:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(A.UnleashHeartOfAzeroth) then return "focused_azerite_beam 463"; end
        end
        -- purifying_blast
        if A.PurifyingBlast:IsCastableP() and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop then
            if HR.Cast(A.UnleashHeartOfAzeroth) then return "purifying_blast 465"; end
        end
        -- concentrated_flame,if=!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight
        if A.ConcentratedFlame:IsReadyP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Target:DebuffDownP(A.ConcentratedFlameBurn) and not A.ConcentratedFlame:IsSpellInFlight()) then
            if HR.Cast(A.UnleashHeartOfAzeroth) then return "concentrated_flame 467"; end
        end
        -- drain_soul,interrupt_global=1,chain=1,interrupt=1,cycle_targets=1,if=target.time_to_die<=gcd
        if A.DrainSoul:IsCastableP() and not ShouldStop and EvaluateCycleDrainSoul479(Target) then
            if HR.Cast(A.DrainSoul) then return "drain_soul 481" end
        end
        -- drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&variable.maintain_se&!debuff.shadow_embrace.remains
        if A.DrainSoul:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterDrainSoul485(Target) and EvaluateTargetIfDrainSoul498(Target) then
            if HR.Cast(A.DrainSoul) then return "drain_soul 500" end
        end
        -- drain_soul,target_if=min:debuff.shadow_embrace.remains,chain=1,interrupt_if=ticks_remain<5,interrupt_global=1,if=talent.shadow_embrace.enabled&variable.maintain_se
        if A.DrainSoul:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterDrainSoul504(Target) and EvaluateTargetIfDrainSoul515(Target) then
            if HR.Cast(A.DrainSoul) then return "drain_soul 517" end
        end
        -- drain_soul,interrupt_global=1,chain=1,interrupt=1
        if A.DrainSoul:IsCastableP() and not ShouldStop then
            if HR.Cast(A.DrainSoul) then return "drain_soul 518"; end
        end
        -- shadow_bolt,cycle_targets=1,if=talent.shadow_embrace.enabled&variable.maintain_se&!debuff.shadow_embrace.remains&!action.shadow_bolt.in_flight
        if A.ShadowBolt:IsCastableP() and not ShouldStop and EvaluateCycleShadowBolt524(Target)  then
            if HR.Cast(A.ShadowBolt) then return "shadow_bolt 536" end
        end
        -- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se
        if A.ShadowBolt:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterShadowBolt540(Target) and EvaluateTargetIfShadowBolt551(Target) then
            if HR.Cast(A.ShadowBolt) then return "shadow_bolt 553" end
        end
        -- shadow_bolt
        if A.ShadowBolt:IsCastableP() and not ShouldStop then
            if HR.Cast(A.ShadowBolt) then return "shadow_bolt 554"; end
        end
    end
    
    
    local function Spenders()
        -- unstable_affliction,if=cooldown.summon_darkglare.remains<=soul_shard*(execute_time+azerite.dreadful_calling.rank)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=soul_shard*execute_time)&(talent.sow_the_seeds.enabled|dot.phantom_singularity.remains|dot.vile_taint.remains)
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and A.SummonDarkglare:GetCooldown() <= Player:SoulShardsP() * (A.UnstableAffliction:GetSpellCastTime() + A.DreadfulCalling:AzeriteRank()) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() <= Player:SoulShardsP() * A.UnstableAffliction:GetSpellCastTime()) and (A.SowtheSeeds:IsSpellLearned() or Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff) or Unit(unit):HasDeBuffs(A.VileTaint)) then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 556"; end
        end
        -- call_action_list,name=fillers,if=(cooldown.summon_darkglare.remains<time_to_shard*(5-soul_shard)|cooldown.summon_darkglare.up)&time_to_die>cooldown.summon_darkglare.remains
        if not ShouldStop and (A.SummonDarkglare:GetCooldown() < time_to_shard * (5 - Player:SoulShardsP()) or A.SummonDarkglare:CooldownUpP()) and Unit(unit):TimeToDie() > A.SummonDarkglare:GetCooldown() then
            local ShouldReturn = Fillers(); if ShouldReturn then return ShouldReturn; end
        end
        -- seed_of_corruption,if=variable.use_seed
        if A.SeedofCorruption:IsCastableP() and not ShouldStop and Action.GetToggle(2, "AoE") and (bool(VarUseSeed)) then
            if HR.Cast(A.SeedofCorruption) then return "seed_of_corruption 590"; end
        end
        -- unstable_affliction,if=!variable.use_seed&!prev_gcd.1.summon_darkglare&(talent.deathbolt.enabled&cooldown.deathbolt.remains<=execute_time&!azerite.cascading_calamity.enabled|(soul_shard>=5&spell_targets.seed_of_corruption_aoe<2|soul_shard>=2&spell_targets.seed_of_corruption_aoe>=2)&target.time_to_die>4+execute_time&spell_targets.seed_of_corruption_aoe=1|target.time_to_die<=8+execute_time*soul_shard)
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and not bool(VarUseSeed) and not Player:PrevGCDP(1, A.SummonDarkglare) and (A.Deathbolt:IsSpellLearned() and A.Deathbolt:GetCooldown() <= A.UnstableAffliction:GetSpellCastTime() and not A.CascadingCalamity:AzeriteEnabled() or (Player:SoulShardsP() >= 5 and MultiUnits:GetByRange(40, 5) < 2 or Player:SoulShardsP() >= 2 and MultiUnits:GetByRange(40, 5) >= 2) and Unit(unit):TimeToDie() > 4 + A.UnstableAffliction:GetSpellCastTime() and MultiUnits:GetByRange(40, 5) == 1 or Unit(unit):TimeToDie() <= 8 + A.UnstableAffliction:GetSpellCastTime() * Player:SoulShardsP()) then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 594"; end
        end
        -- unstable_affliction,if=!variable.use_seed&contagion<=cast_time+variable.padding
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and not bool(VarUseSeed) and contagion <= A.UnstableAffliction:CastTime() + VarPadding then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 624"; end
        end
		-- unstable_affliction,cycle_targets=1,if=!variable.use_seed&(!talent.deathbolt.enabled|cooldown.deathbolt.remains>time_to_shard|soul_shard>1)&(!talent.vile_taint.enabled|soul_shard>1)&contagion<=cast_time+variable.padding&(!azerite.cascading_calamity.enabled|buff.cascading_calamity.remains>time_to_shard)
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and A.CascadingCalamity:AzeriteEnabled() and not Player:BuffP(A.CascadingCalamityBuff) and ActiveUAs() >= 1 and contagion <= A.UnstableAffliction:CastTime() + VarPadding + 1 then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 662" end
        end
        -- unstable_affliction,cycle_targets=1,if=!variable.use_seed&(!talent.deathbolt.enabled|cooldown.deathbolt.remains>time_to_shard|soul_shard>1)&(!talent.vile_taint.enabled|soul_shard>1)&contagion<=cast_time+variable.padding&(!azerite.cascading_calamity.enabled|buff.cascading_calamity.remains>time_to_shard)
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and EvaluateCycleUnstableAffliction640(Target)  then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 662" end
        end
    end
    
	-- call DBM precombat
    if not Player:AffectingCombat() and Action.GetToggle(1, "DBM") and not Player:IsCasting() then
        local ShouldReturn = Precombat_DBM(); 
            if ShouldReturn then return ShouldReturn; 
        end    
    end
    -- call non DBM precombat
    if not Player:AffectingCombat() and not Action.GetToggle(1, "DBM") and not Player:IsCasting() then        
        local ShouldReturn = Precombat(); 
            if ShouldReturn then return ShouldReturn; 
        end    
    end
	
	-- Call Ashvane mythic burst on first P2 (If your guild is doing it this way)
	if PrepareAshvaneBurst() then 
   	    -- haunt
        if A.Haunt:IsCastableP() and not ShouldStop then
            if HR.Cast(A.Haunt) then return "haunt 461"; end
        end
        -- drain_life,
        if A.DrainLife:IsCastableP() and not ShouldStop and Player:BuffStackP(A.InevitableDemiseBuff) >= 45 and Unit(unit):HasDeBuffs(A.AgonyDebuff) > 5 * Player:SpellHaste() then
            if HR.Cast(A.DrainLife) then return "drain_life 415"; end
        end
		-- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
        if A.Agony:IsCastableP() and not ShouldStop and not HR.CDsON() and Unit(unit):HasDeBuffs(A.AgonyDebuff) <= 5 then
            if HR.Cast(A.Agony) then return "siphon_life 770" end
        end
	    -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
        if A.Corruption:IsCastableP() and not ShouldStop and not HR.CDsON() and Unit(unit):HasDeBuffs(A.CorruptionDebuff) <= 4 then
            if HR.Cast(A.Corruption) then return "siphon_life 770" end
        end
	    -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
        if A.SiphonLife:IsCastableP() and not ShouldStop and not HR.CDsON() and Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) <= 4 then
            if HR.Cast(A.SiphonLife) then return "siphon_life 770" end
        end
		-- unstable_affliction,if=cooldown.summon_darkglare.remains<=soul_shard*(execute_time+azerite.dreadful_calling.rank)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=soul_shard*execute_time)&(talent.sow_the_seeds.enabled|dot.phantom_singularity.remains|dot.vile_taint.remains)
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and Player:SoulShardsP() == 5 and not Player:PrevGCDP(1, A.UnstableAffliction) then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 556"; end
        end
		-- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=execute_time*2+travel_time&!action.shadow_bolt.in_flight
        if A.ShadowBolt:IsCastableP() and not ShouldStop and Player:SoulShardsP() < 5 then
            if HR.Cast(A.ShadowBolt) then return "shadow_bolt 837" end
        end	
	end
	
	------------------------------------------------------
	---------------- MOUSE OVER ROTATION -----------------
	------------------------------------------------------
	-- Mouseover DPS Rotation
	-- Only handling mouseover multidots and dots refreshable
	local function MouseoverRotation(unit)
		
		-- Variables
		local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover") 
        inRange = A.Agony:IsInRange(unit)
		
		-- PetKick
        if useKick and A.PetKick:IsReady() and ActionUnit(unit):CanInterrupt(true) then 
                if HR.Cast(A.PetKick, true) then return "PetKick 5"; end
        else 
            return
        end   	
				
		-- Agony
		if A.Agony:IsReady(unit) and not ShouldStop and (ActionUnit(unit):HasDeBuffs(A.AgonyDebuff.ID) <= 5 or ActionUnit(unit):HasDeBuffs(A.AgonyDebuff.ID) == 0) and not Player:PrevGCDP(1, A.Agony) and ActionUnit(unit):TimeToDie() >= 15 then
			if HR.Cast(A.Agony) then return "shadow_bolt 837" end
		end	
		
		-- Corruption
		if A.Corruption:IsReady(unit) and not ShouldStop and (ActionUnit(unit):HasDeBuffs(A.CorruptionDebuff.ID) <= 5 or ActionUnit(unit):HasDeBuffs(A.CorruptionDebuff.ID) == 0) and not Player:PrevGCDP(1, A.Corruption) and ActionUnit(unit):TimeToDie() >= 15 then
			if HR.Cast(A.Corruption) then return "shadow_bolt 837" end
		end	
		
		-- Siphon Life
		if A.SiphonLife:IsReady(unit) and A.SiphonLife:IsSpellLearned() and not ShouldStop and (ActionUnit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID) <= 5 or ActionUnit(unit):HasDeBuffs(A.SiphonLifeDebuff.ID) == 0) and not Player:PrevGCDP(1, A.SiphonLife) and ActionUnit(unit):TimeToDie() >= 15 then
			if HR.Cast(A.SiphonLife) then return "shadow_bolt 837" end
		end
		
	end
	
	-- Mouseover Dispel Magic
    local function DispellMagic()
    	-- SingeMagic
	    if A.SingeMagic:IsCastable() and not ShouldStop and Action.AuraIsValid("mouseover", "UseDispel", "Magic") then
	        if HR.Cast(A.SingeMagic) then return "SingeMagic 69" end
        end	
    end
	
	
	-- Make use of all trinkets of the game
	-- Dont forget to add check on SIMC recommanded trinkets to keep using them with APLs.
	local function TrinketsRotation(icon)
	    --print(Trinket1IsAllowed)	
        -- print(Trinket2IsAllowed)
		
       	-- Trinkets
       	if A.Trinket1:IsReady("target") and Trinket1IsAllowed and A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	return A.Trinket1:Show(icon)
   	    end 
              
   		if A.Trinket2:IsReady("target") and Trinket2IsAllowed and A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
       	   	return A.Trinket2:Show(icon)
   	    end  	   	
     	
   	end	
    
    --- In Combat
    if Player:AffectingCombat() and not PrepareAshvaneBurst() then
	
	    -- Interrupt Handler
        local Trinket1IsAllowed, Trinket2IsAllowed = TrinketIsAllowed()
        local unit = "target"
        local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
        
		-- PetKick
        if useKick and A.PetKick:IsReady() and Target:IsInterruptible() then 
		    if ActionUnit(unit):CanInterrupt(true, nil, 25, 70) then
                if HR.Cast(A.PetKick, true) then return "PetKick 5"; end
            end 
        end 
        -- Mouseover rotation         
        if Action.IsUnitEnemy("mouseover") and Action.GetToggle(2, "mouseover") then 
            unit = "mouseover"
                
            if MouseoverRotation(unit) then 
                return true 
            end 
        end		
        -- Dispell Magic Mouseover
        if Action.GetToggle(2, "mouseover") and not Action.IsUnitEnemy("mouseover") then
            local ShouldReturn = DispellMagic(); if ShouldReturn then return ShouldReturn; end
        end
		-- Auto Multi Dot	  
	    if not Player:PrevGCDP(1, A.TargetEnemy)  and Action.GetToggle(2, "AutoDot") and CanMultidot 
		and ((MissingAgony >= 1 or MissingCorruption >= 1) or (AgonyToRefresh >= 1)) and MultiUnits:GetByRange(40, 5) > 2 and MultiUnits:GetByRange(40, 5) <= 5 
		and Unit(unit):HasDeBuffs(A.AgonyDebuff) >= 8 then
            if HR.Cast(A.TargetEnemy) then return "TargetEnemy 69" end
        end		
        -- variable,name=use_seed,value=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>=3+raid_event.invulnerable.up|talent.siphon_life.enabled&spell_targets.seed_of_corruption>=5+raid_event.invulnerable.up|spell_targets.seed_of_corruption>=8+raid_event.invulnerable.up
        if (true) then
            VarUseSeed = num(A.SowtheSeeds:IsSpellLearned() and MultiUnits:GetByRange(40, 5) >= 3 or A.SiphonLife:IsSpellLearned() and MultiUnits:GetByRange(40, 5) >= 5 or MultiUnits:GetByRange(40, 5) >= 8)
        end
        -- variable,name=padding,op=set,value=action.shadow_bolt.execute_time*azerite.cascading_calamity.enabled
        if (true) then
            VarPadding = A.ShadowBolt:GetSpellCastTime() * num(A.CascadingCalamity:AzeriteEnabled())
        end
        -- variable,name=padding,op=reset,value=gcd,if=azerite.cascading_calamity.enabled&(talent.drain_soul.enabled|talent.deathbolt.enabled&cooldown.deathbolt.remains<=gcd)
        if (A.CascadingCalamity:AzeriteEnabled() and (A.DrainSoul:IsSpellLearned() or A.Deathbolt:IsSpellLearned() and A.Deathbolt:GetCooldown() <= A.GetGCD())) then
            VarPadding = 0
        end
        -- variable,name=maintain_se,value=spell_targets.seed_of_corruption_aoe<=1+talent.writhe_in_agony.enabled+talent.absolute_corruption.enabled*2+(talent.writhe_in_agony.enabled&talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption_aoe>2)+(talent.siphon_life.enabled&!talent.creeping_death.enabled&!talent.drain_soul.enabled)+raid_event.invulnerable.up
        if (true) then
            VarMaintainSe = num(MultiUnits:GetByRange(40, 5) <= 1 + num(A.WritheInAgony:IsSpellLearned()) + num(A.AbsoluteCorruption:IsSpellLearned()) * 2 + num((A.WritheInAgony:IsSpellLearned() and A.SowtheSeeds:IsSpellLearned() and MultiUnits:GetByRange(40, 5) > 2)) + num((A.SiphonLife:IsSpellLearned() and not A.CreepingDeath:IsSpellLearned() and not A.DrainSoul:IsSpellLearned())))
        end		
        -- call_action_list,name=cooldowns
        if (true) and HR.CDsON() then
            local ShouldReturn = Cooldowns(); if ShouldReturn then return ShouldReturn; end
        end
		-- Non SIMC Custom Trinket1
	    if Action.GetToggle(1, "Trinkets")[1] and A.Trinket1:IsReady("target") and Trinket1IsAllowed then	    
       	    if A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
      	   	    return A.Trinket1:Show(icon)
   	        end 		
	    end
		
		-- Non SIMC Custom Trinket2
	    if Action.GetToggle(1, "Trinkets")[2] and A.Trinket2:IsReady("target") and Trinket2IsAllowed then	    
       	    if A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
      	   	    return A.Trinket2:Show(icon)
   	        end 	
	    end
        -- drain_soul,interrupt_global=1,chain=1,cycle_targets=1,if=target.time_to_die<=gcd&soul_shard<5
        if A.DrainSoul:IsCastableP() and not ShouldStop and EvaluateCycleDrainSoul711(Target) then
            if HR.Cast(A.DrainSoul) then return "drain_soul 713" end
        end
        -- haunt,if=spell_targets.seed_of_corruption_aoe<=2+raid_event.invulnerable.up
        if A.Haunt:IsCastableP() and not ShouldStop and (MultiUnits:GetByRange(40, 5) <= 2) then
            if HR.Cast(A.Haunt) then return "haunt 714"; end
        end
        -- summon_darkglare,if=dot.agony.ticking&dot.corruption.ticking&(buff.active_uas.stack=5|soul_shard=0)&(!talent.phantom_singularity.enabled|dot.phantom_singularity.remains)&(!talent.deathbolt.enabled|cooldown.deathbolt.remains<=gcd|!cooldown.deathbolt.remains|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up)
        if A.SummonDarkglare:IsCastableP() and HR.CDsON() and (Unit(unit):HasDeBuffs(A.AgonyDebuff) and (Unit(unit):HasDeBuffs(A.CorruptionDebuff) or A.AbsoluteCorruption:IsSpellLearned()) and (ActiveUAs() == 5 or Player:SoulShardsP() == 0) and (not A.PhantomSingularity:IsSpellLearned() or Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff)) and (not A.Deathbolt:IsSpellLearned() or A.Deathbolt:GetCooldown() <= A.GetGCD() or A.Deathbolt:CooldownUpP() or MultiUnits:GetByRange(40, 5) > 1)) then
            if HR.Cast(A.SummonDarkglare, Action.GetToggle(2, "OffGCDasOffGCD")) then return "summon_darkglare 716"; end
        end
        -- deathbolt,if=cooldown.summon_darkglare.remains&spell_targets.seed_of_corruption_aoe=1+raid_event.invulnerable.up&(!essence.vision_of_perfection.minor&!azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains>30)
        if A.Deathbolt:IsCastableP() and not ShouldStop and ActiveUAs() >= 1 and Player:SoulShardsP() <= 1 and (A.SummonDarkglare:GetCooldown() >= 30 and MultiUnits:GetByRange(40, 5) == 1 and (not A.VisionofPerfectionMinor:IsSpellLearned() and not bool(A.DreadfulCalling:AzeriteRank()) or A.SummonDarkglare:GetCooldown() > 30)) then
            if HR.Cast(A.Deathbolt) then return "deathbolt 734"; end
        end 
        -- deathbolt,if=shard<=1&!cooldowns
        if A.Deathbolt:IsCastableP() and not ShouldStop and not HR.CDsON() and Player:SoulShardsP() <= 1 then
            if HR.Cast(A.Deathbolt) then return "deathbolt 734"; end
        end 
        -- the_unbound_force,if=buff.reckless_force.remains
        if A.TheUnboundForce:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Player:BuffP(A.RecklessForceBuff)) then
            if HR.Cast(A.UnleashHeartOfAzeroth) then return "the_unbound_force 744"; end
        end
        -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
        if A.Agony:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterAgony751(Target) and EvaluateTargetIfAgony768(Target)  then
            if HR.Cast(A.Agony) then return "agony 770" end
        end
        -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
        if A.Agony:IsCastableP() and not ShouldStop and not HR.CDsON() and Unit(unit):HasDeBuffs(A.AgonyDebuff) <= 5 then
            if HR.Cast(A.Agony) then return "agony 770" end
        end
        -- memory_of_lucid_dreams,if=time<30
        if A.MemoryofLucidDreams:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and (Unit("player"):CombatTime() < 30) then
            if HR.Cast(A.UnleashHeartOfAzeroth) then return "memory_of_lucid_dreams 771"; end
        end
        -- # Temporary fix to make sure azshara's font doesn't break darkglare usage.
        -- agony,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314
        if A.Agony:IsCastableP() and not ShouldStop and (Unit("player"):CombatTime() > 30 and A.SummonDarkglare:GetCooldown() <= 15 and I.AzsharasFontofPower:IsEquipped()) then
            if HR.Cast(A.Agony) then return "agony 772"; end
        end
        -- corruption,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314&!talent.absolute_corruption.enabled&(talent.siphon_life.enabled|spell_targets.seed_of_corruption_aoe>1&spell_targets.seed_of_corruption_aoe<=3)
        if A.Corruption:IsCastableP() and not ShouldStop and (Unit("player"):CombatTime() > 30 and A.SummonDarkglare:GetCooldown() <= 15 and I.AzsharasFontofPower:IsEquipped() and not A.AbsoluteCorruption:IsSpellLearned() and (A.SiphonLife:IsSpellLearned() or MultiUnits:GetByRange(40, 5) > 1 and MultiUnits:GetByRange(40, 5) <= 3)) then
            if HR.Cast(A.Corruption) then return "corruption 773"; end
        end
        -- siphon_life,line_cd=30,if=time>30&cooldown.summon_darkglare.remains<=15&equipped.169314
        if A.SiphonLife:IsCastableP() and not ShouldStop and (Unit("player"):CombatTime() > 30 and A.SummonDarkglare:GetCooldown() <= 15 and I.AzsharasFontofPower:IsEquipped()) then
            if HR.Cast(A.SiphonLife) then return "siphon_life 774"; end
        end
	    -- agony,target_if=min:dot.agony.remains,if=remains<=gcd+action.shadow_bolt.execute_time&target.time_to_die>8
        if A.SiphonLife:IsCastableP() and not ShouldStop and not HR.CDsON() and Unit(unit):HasDeBuffs(A.SiphonLifeDebuff) <= 4 then
            if HR.Cast(A.SiphonLife) then return "siphon_life 770" end
        end
        -- unstable_affliction,target_if=!contagion&target.time_to_die<=8
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and EvaluateCycleUnstableAffliction781(Target) then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 783" end
        end
        -- drain_soul,target_if=min:debuff.shadow_embrace.remains,cancel_if=ticks_remain<5,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=gcd*2
        if A.DrainSoul:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterDrainSoul787(Target) and EvaluateTargetIfDrainSoul802(Target) then
            if HR.Cast(A.DrainSoul) then return "drain_soul 804" end
        end
        -- shadow_bolt,target_if=min:debuff.shadow_embrace.remains,if=talent.shadow_embrace.enabled&variable.maintain_se&debuff.shadow_embrace.remains&debuff.shadow_embrace.remains<=execute_time*2+travel_time&!action.shadow_bolt.in_flight
        if A.ShadowBolt:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterShadowBolt808(Target) and EvaluateTargetIfShadowBolt835(Target) then
            if HR.Cast(A.ShadowBolt) then return "shadow_bolt 837" end
        end
        -- phantom_singularity,target_if=max:target.time_to_die,if=time>35&target.time_to_die>16*spell_haste&(!essence.vision_of_perfection.minor&!azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains>45+soul_shard*azerite.dreadful_calling.rank|cooldown.summon_darkglare.remains<15*spell_haste+soul_shard*azerite.dreadful_calling.rank)
        if A.PhantomSingularity:IsCastableP() and (A.SummonDarkglare:GetCooldown() >= 45 or A.SummonDarkglare:IsReady()) and not ShouldStop and EvaluateTargetIfFilterPhantomSingularity841(Target) and EvaluateTargetIfPhantomSingularity850(Target) then
            if HR.Cast(A.PhantomSingularity) then return "phantom_singularity 852" end
        end
        -- unstable_affliction,target_if=min:contagion,if=!variable.use_seed&soul_shard=5
        if A.UnstableAffliction:IsReadyP() and not ShouldStop and EvaluateTargetIfFilterUnstableAffliction865(Target) and EvaluateTargetIfUnstableAffliction870(Target) then
            if HR.Cast(A.UnstableAffliction) then return "unstable_affliction 872" end
        end
        -- seed_of_corruption,if=variable.use_seed&soul_shard=5
        if A.SeedofCorruption:IsCastableP() and not ShouldStop and Action.GetToggle(2, "AoE") and (bool(VarUseSeed) and Player:SoulShardsP() == 5) then
            if HR.Cast(A.SeedofCorruption) then return "seed_of_corruption 873"; end
        end	
        -- call_action_list,name=dots
        if (true) then
            local ShouldReturn = Dots(); if ShouldReturn then return ShouldReturn; end
        end
        -- vile_taint,target_if=max:target.time_to_die,if=time>15&target.time_to_die>=10&(cooldown.summon_darkglare.remains>30|cooldown.summon_darkglare.remains<10&dot.agony.remains>=10&dot.corruption.remains>=10&(dot.siphon_life.remains>=10|!talent.siphon_life.enabled))
        if A.VileTaint:IsCastableP() and not ShouldStop and EvaluateTargetIfFilterVileTaint856(Target) and EvaluateTargetIfVileTaint859(Target) then
            if HR.Cast(A.VileTaint) then return "vile_taint 861" end
        end
        -- use_item,name=azsharas_font_of_power,if=time<=3
        if I.AzsharasFontofPower:IsEquipped() and TrinketON() and not ShouldStop and I.AzsharasFontofPower:IsReady() and (Unit("player"):CombatTime() <= 3) then
            if HR.Cast(I.AzsharasFontofPower) then return "azsharas_font_of_power 879"; end
        end
        -- phantom_singularity,if=time<=35
        if A.PhantomSingularity:IsCastableP() and not ShouldStop and (Unit("player"):CombatTime() <= 35) then
            if HR.Cast(A.PhantomSingularity, Action.GetToggle(2, "OffGCDasOffGCD")) then return "phantom_singularity 881"; end
        end
        -- vile_taint,if=time<15
        if A.VileTaint:IsCastableP() and not ShouldStop and (Unit("player"):CombatTime() < 15) then
            if HR.Cast(A.VileTaint) then return "vile_taint 883"; end
        end
        -- dark_soul,if=cooldown.summon_darkglare.remains<15+soul_shard*azerite.dreadful_calling.enabled&(dot.phantom_singularity.remains|dot.vile_taint.remains|!talent.phantom_singularity.enabled&!talent.vile_taint.enabled)|target.time_to_die<20+gcd|spell_targets.seed_of_corruption_aoe>1+raid_event.invulnerable.up
        if A.DarkSoulMisery:IsCastableP() and not ShouldStop and HR.CDsON() and (A.SummonDarkglare:GetCooldown() < 15 + Player:SoulShardsP() * num(A.DreadfulCalling:AzeriteEnabled()) and (Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff) or Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff) or not A.PhantomSingularity:IsSpellLearned() and not A.VileTaint:IsSpellLearned()) or Unit(unit):TimeToDie() < 20 + A.GetGCD() or MultiUnits:GetByRange(40, 5) > 1) then
            if HR.Cast(A.DarkSoulMisery, Action.GetToggle(2, "OffGCDasOffGCD")) then return "dark_soul 885"; end
        end
        -- guardian_of_azeroth,if=cooldown.summon_darkglare.remains<15+soul_shard*azerite.dreadful_calling.enabled|(azerite.dreadful_calling.rank|essence.vision_of_perfection.rank)&time>30&target.time_to_die>=210)&(dot.phantom_singularity.remains|dot.vile_taint.remains|!talent.phantom_singularity.enabled&!talent.vile_taint.enabled)|target.time_to_die<30+gcd
        if A.GuardianofAzeroth:IsCastableP() and Action.GetToggle(1, "HeartOfAzeroth") and not ShouldStop and HR.CDsON() and A.SummonDarkglare:GetCooldown() < 15 + Player:SoulShardsP() * num(A.DreadfulCalling:AzeriteEnabled()) or ((A.DreadfulCalling:AzeriteEnabled() or A.VisionofPerfectionMinor:IsSpellLearned()) and Unit("player"):CombatTime() > 30 and Unit(unit):TimeToDie() >= 210) and (Unit(unit):HasDeBuffs(A.PhantomSingularityDebuff) or Unit(unit):HasDeBuffs(A.VileTaint) or not A.PhantomSingularity:IsSpellLearned() and not A.VileTaint:IsSpellLearned()) then
            if HR.Cast(A.GuardianofAzeroth) then return ""; end
        end
        -- berserking
        if A.Berserking:IsReadyP() and not ShouldStop and HR.CDsON() then
            if HR.Cast(A.Berserking, Action.GetToggle(2, "OffGCDasOffGCD")) then return "berserking 891"; end
        end
        -- call_action_list,name=spenders
        if (true) and not ShouldStop then
            local ShouldReturn = Spenders(); if ShouldReturn then return ShouldReturn; end
        end
        -- call_action_list,name=fillers
        if (true) and not ShouldStop then
            local ShouldReturn = Fillers(); if ShouldReturn then return ShouldReturn; end
        end	
    end
end
-- Finished

-----------------------------------------
--                 ROTATION  
-----------------------------------------

-- [3] is Single rotation (supports all actions)
A[3] = function(icon)
    if APL(icon) then 
        return true 
    end
end

--[[
-- [6] is Passive rotation (limited actions, usually @player, @raid1, @arena1)
A[6] = function(icon)    
    return ArenaRotation(icon, "arena1")
end

-- [7] is Passive rotation (limited actions, usually @party1, @raid2, @arena2)
A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    
    return ArenaRotation(icon, "arena2")
end

-- [8] is Passive rotation (limited actions, usually @party2, @raid3, @arena3)
A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    
    return ArenaRotation(icon, "arena3")
end]]--