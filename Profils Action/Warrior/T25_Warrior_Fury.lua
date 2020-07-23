-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local Action                                    = Action
local Listener                                    = Action.Listener
local Create                                    = Action.Create
local GetToggle                                    = Action.GetToggle
local SetToggle                                    = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                                = Action.GetCurrentGCD
local GetPing                                    = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                    = Action.BurstIsON
local AuraIsValid                                = Action.AuraIsValid
local InterruptIsValid                            = Action.InterruptIsValid
local FrameHasSpell                                = Action.FrameHasSpell
local Azerite                                    = LibStub("AzeriteTraits")
local Utils                                        = Action.Utils
local TeamCache                                    = Action.TeamCache
local EnemyTeam                                    = Action.EnemyTeam
local FriendlyTeam                                = Action.FriendlyTeam
local LoC                                        = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                                = Action.UnitCooldown
local Unit                                        = Action.Unit 
local IsUnitEnemy                                = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local ActiveUnitPlates                            = MultiUnits:GetActiveUnitPlates()
local _G, setmetatable                            = _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_WARRIOR_FURY] = {
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
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    -- Generics
    RecklessnessBuff                       = Action.Create({ Type = "Spell", ID = 1719, Hidden = true     }),
    Recklessness                           = Action.Create({ Type = "Spell", ID = 1719      }),
    HeroicLeap                             = Action.Create({ Type = "Spell", ID = 6544      }),
    Siegebreaker                           = Action.Create({ Type = "Spell", ID = 280772      }),
    Rampage                                = Action.Create({ Type = "Spell", ID = 184367      }),
    FrothingBerserker                      = Action.Create({ Type = "Spell", ID = 215571      }),
    Carnage                                = Action.Create({ Type = "Spell", ID = 202922      }),
    EnrageBuff                             = Action.Create({ Type = "Spell", ID = 184362, Hidden = true     }),
    Massacre                               = Action.Create({ Type = "Spell", ID = 206315      }),
    Execute                                = Action.Create({ Type = "Spell", ID = 5308      }),
    FuriousSlash                           = Action.Create({ Type = "Spell", ID = 100130      }),
    FuriousSlashBuff                       = Action.Create({ Type = "Spell", ID = 202539, Hidden = true     }),
    Bladestorm                             = Action.Create({ Type = "Spell", ID = 46924      }),
    Bloodthirst                            = Action.Create({ Type = "Spell", ID = 23881      }),
    ColdSteelHotBlood                       = Action.Create({ Type = "Spell", ID = 288080, Hidden = true     }), 
    DragonRoar                             = Action.Create({ Type = "Spell", ID = 118000      }),
    RagingBlow                             = Action.Create({ Type = "Spell", ID = 85288      }),
    Whirlwind                              = Action.Create({ Type = "Spell", ID = 190411      }),
    Charge                                 = Action.Create({ Type = "Spell", ID = 100      }),
    MeatCleaverBuff                        = Action.Create({ Type = "Spell", ID = 85739, Hidden = true     }), --85739 -- 280392
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297      }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647      }),
    SiegebreakerDebuff                     = Action.Create({ Type = "Spell", ID = 280773, Hidden = true     }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221      }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738      }),
    BattleShout                            = Action.Create({ Type = "Spell", ID = 6673         }),
    SuddenDeathBuff                        = Action.Create({ Type = "Spell", ID = 280776, Hidden = true}),
    -- Self Defensive
    EnragedRegeneration                    = Action.Create({ Type = "Spell", ID = 184364         }),
    BerserkerRage                          = Action.Create({ Type = "Spell", ID = 18499         }),
    VictoryRush                               = Action.Create({ Type = "Spell", ID = 34428         }),
    ImpendingVictory                       = Action.Create({ Type = "Spell", ID = 202168         }),
    RallyingCry                               = Action.Create({ Type = "Spell", ID = 97462         }),
    Interception                           = Action.Create({ Type = "Spell", ID = 198304         }),
    -- CrownControl
    Stormbolt                              = Action.Create({ Type = "Spell", ID = 107570    }),
    StormboltGreen                         = Action.Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true    }),
    Pummel                                   = Action.Create({ Type = "Spell", ID = 6552    }),
    PummelGreen                               = Action.Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true    }),  
    IntimidatingShout                      = Action.Create({ Type = "Spell", ID = 5246, Hidden = true     }),
    PiercingHowl                           = Action.Create({ Type = "Spell", ID = 23600    }), 
    PiercingHowlDebuff                     = Action.Create({ Type = "Spell", ID = 23600, Hidden = true     }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, Hidden = true, QueueForbidden = true }), 
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
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
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
    DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon
    PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })

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
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InRange(unit)
    -- @return boolean 
    return A.Bloodthirst:IsInRange(unit)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function GetByRange(count, range, isStrictlySuperior, isStrictlyInferior, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    
    if isStrictlySuperior == nil then
        isStrictlySuperior = false
    end
    
    if isStrictlyInferior == nil then
        isStrictlyInferior = false
    end    
    
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InRange(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            -- Strictly superior than >
            if isStrictlySuperior and not isStrictlyInferior then
                if c > count then
                    return true
                end
            end
            
            -- Stryctly inferior <
            if isStrictlyInferior and not isStrictlySuperior then
                if c < count then
                    return true
                end
            end
            
            -- Classic >=
            if not isStrictlyInferior and not isStrictlySuperior then
                if c >= count then 
                    return true 
                end 
            end
        end 
        
    end
    
end  
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    A.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 20 and 
    (
        (A.IsInPvP and Unit(unit):IsControlAble("stun", 0)) 
        or
        not A.IsInPvP        
    ) 
    and A.StormboltGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if    A.StormboltGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not A.IsUnitEnemy("mouseover") and 
            not A.IsUnitEnemy("target")
        )
    )
    then 
        return A.StormboltGreen:Show(icon)         
    end                                                                     
end

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
            -- Pummel        
            if not notKickAble and A.PummelGreen:IsReady(unit, nil, nil, true) and A.PummelGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)                                                  
            end 
            
            -- Stormbolt
            if A.Stormbolt:IsReady(unit, nil, nil, true) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndStun, true) and Unit(unit):IsControlAble("stun", 0) then
                return A.Stormbolt:Show(icon)                  
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

local function SelfDefensives()
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    -- Enraged Regeneration
    local EnragedRegeneration = A.GetToggle(2, "EnragedRegeneration")
    if     EnragedRegeneration >= 0 and A.EnragedRegeneration:IsReady(player) and 
    (
        (   -- Auto 
            EnragedRegeneration >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
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
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) 
        or 
        (   -- Custom
            EnragedRegeneration < 100 and 
            Unit(player):HealthPercent() <= EnragedRegeneration
        )
    ) 
    then 
        return A.EnragedRegeneration
    end 
    
    -- Rallying Cry
    local RallyingCry = A.GetToggle(2, "RallyingCry")
    if     RallyingCry >= 0 and A.RallyingCry:IsReady(player) and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
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
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) 
        or 
        (    -- Custom
            RallyingCry < 100 and 
            Unit(player):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end  
    
end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Pummel:IsReadyByPassCastGCD(unit) or not A.Pummel:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells
local function Interrupts(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    
	if castRemainsTime < A.GetLatency() then
        -- Pummel
        if useKick and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            return A.Pummel
        end 
    
        -- Stormbolt
        if useCC and A.Stormbolt:IsReady(unit) and A.Stormbolt:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("stun", 0) then
            return A.Stormbolt              
        end  
    
        -- IntimidatingShout
        if useCC and A.IntimidatingShout:IsReady(unit) and A.IntimidatingShout:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("fear", 0) then 
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
end


--------------------------------
--- ======= ACTION LISTS =======
--------------------------------
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local DBM = GetToggle(1 ,"DBM")
    local Potion = GetToggle(1, "Potion")
    local Racial = GetToggle(1, "Racial")
    local HeartOfAzeroth = GetToggle(1, "HeartOfAzeroth")
    -- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
    local TrinketsAoE = GetToggle(2, "TrinketsAoE")
    local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
    local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
    local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")
    local BloodoftheEnemySyncAoE = GetToggle(2, "BloodoftheEnemySyncAoE")
    local BloodoftheEnemyAoETTD = GetToggle(2, "BloodoftheEnemyAoETTD")
    local BloodoftheEnemyUnits = GetToggle(2, "BloodoftheEnemyUnits")
    local MinAoETargets = GetToggle(2, "MinAoETargets")
    local MaxAoERange = GetToggle(2, "MaxAoERange")
    
    
    local UseCharge = GetToggle(2, "UseCharge")
    local ChargeTime = GetToggle(2, "ChargeTime")
    local UseHeroicLeap = GetToggle(2, "UseHeroicLeap") 
    local HeroicLeapTime = GetToggle(2, "HeroicLeapTime")
    local SmartStormbolt = GetToggle(2, "SmartStormbolt")
    local profileStop = false
    local CanCast = true
    -- FocusedAzeriteBeam protection channel
    local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
    -- @return:
    -- [1] Currect Casting Left Time (seconds) (@number)
    -- [2] Current Casting Left Time (percent) (@number)
    -- [3] spellID (@number)
    -- [4] spellName (@string)
    -- [5] notInterruptable (@boolean, false is able to be interrupted)
    -- [6] isChannel (@boolean)
    if secondsLeft > 0 and spellName == A.FocusedAzeriteBeam:Info() then 
        CanCast = false
    else
        CanCast = true
    end    
    
    if not CanCast then
        return A.PoolResource:Show(icon)
    end
    
    
    ------------------------------------
    ---------- DUMMY DPS TEST ----------
    ------------------------------------
    local DummyTime = GetToggle(2, "DummyTime")
    if DummyTime > 0 then
        local unit = "target"
        local endtimer = 0
        
        if Unit(unit):IsExists() and Unit(unit):IsDummy() then
            if Unit(player):CombatTime() >= (DummyTime * 60) then
                StopAttack()
                endtimer = TMW.time
                --ClearTarget() -- Protected ? 
                -- Notification                    
                Action.SendNotification(DummyTime .. " Minutes Dummy Test Concluded - Profile Stopped", A.DummyTest.ID)            
                
                if endtimer < TMW.time + 5 then
                    profileStop = true
                    --return A.DummyTest:Show(icon)
                end
            end
        end
    end    
    -- Mounted
    if Player:IsMounted() then
        profileStop = true
    end
    
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        
        local function Precombat_DBM(unit)            
            -- flask
            -- food
            -- augmentation
            -- battle_shout
            if A.BattleShout:IsReady(player) and A.BattleShout:GetSpellTimeSinceLastCast() >= 60 and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 then
                return A.BattleShout:Show(icon)
            end            
            if Unit(unit):IsExists() then
                -- snapshot_stats
                -- use_item,name=azsharas_font_of_power
                if A.AzsharasFontofPower:IsReady(player) and TR.TrinketON() and Pull > 1 and Pull <= 6 then
                    return A.AzsharasFontofPower:Show(icon)
                end
                
                -- memory_of_lucid_dreams
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and BurstIsON(unit) and not ShouldStop and Pull > 0.1 and Pull <= 2 then
                    return A.MemoryofLucidDreams:Show(icon)
                end
                
                -- guardian_of_azeroth
                if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and BurstIsON(unit) and not ShouldStop and Pull > 0.1 and Pull <= 2 then
                    return A.GuardianofAzeroth:Show(icon)
                end
                
                -- potion
                if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and Pull > 0.1 and Pull <= 1 + GetGCD() then
                    return A.PotionofUnbridledFury:Show(icon)
                end
                
                -- recklessness
                if A.Recklessness:IsReady(player) and A.BurstIsON(unit) and InRange(unit) and not ShouldStop and Pull > 0.1 and Pull <= 0.7 then
                    return A.Recklessness:Show(icon)
                end
                
                -- charge
                if A.Charge:IsReady(unit) and UseCharge and isMovingFor >= ChargeTime then
                    return A.Charge:Show(icon)
                end    
                
            end
        end
        
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- augmentation
            if A.BattleShout:IsReady(player) and A.BattleShout:GetSpellTimeSinceLastCast() >= 60 and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 then
                return A.BattleShout:Show(icon)
            end
            if Unit(unit):IsExists() then
                -- snapshot_stats
                -- use_item,name=azsharas_font_of_power
                if A.AzsharasFontofPower:IsReady(player) and A.AzsharasFontofPower:IsReady(unit) and TR.TrinketON() then
                    return A.AzsharasFontofPower:Show(icon)
                end
                
                -- memory_of_lucid_dreams
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and not ShouldStop and BurstIsON(unit)  then
                    return A.MemoryofLucidDreams:Show(icon)
                end
                
                -- guardian_of_azeroth
                if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and not ShouldStop and BurstIsON(unit)  then
                    return A.GuardianofAzeroth:Show(icon)
                end
                
                -- recklessness
                if A.Recklessness:IsReady(player) and A.BurstIsON(unit) and not ShouldStop and InRange(unit) then
                    return A.Recklessness:Show(icon)
                end
                
                -- potion
                if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                    return A.PotionofUnbridledFury:Show(icon)
                end
                
                -- charge
                if A.Charge:IsReady(unit) and UseCharge and isMovingFor >= ChargeTime then
                    return A.Charge:Show(icon)
                end 
                
            end
        end
        
        local function Movement(unit)
            -- heroic_leap
            if A.HeroicLeap:IsReady(unit) and not ShouldStop then
                return A.HeroicLeap:Show(icon)
            end
        end
        
        local function SingleTarget(unit)

            -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
            if A.Whirlwind:IsReady(unit) and not ShouldStop and A.GetToggle(2, "AoE") and (GetByRange(1, 8, true) and Unit(player):HasBuffs(A.MeatCleaverBuff.ID, true) == 0) then
                return A.Whirlwind:Show(icon)
            end
                       
            -- furious_slash,buff/stacks.furious_slash.remains<3
            if A.FuriousSlash:IsReady(unit) and not ShouldStop and (Unit(player):HasBuffs(A.FuriousSlashBuff.ID, true) <= 2 or Unit(player):HasBuffsStacks(A.FuriousSlashBuff.ID, true) < 3) then
                return A.FuriousSlash:Show(icon)
            end
            
            -- siegebreaker
            if A.Siegebreaker:IsReady(unit) and not ShouldStop and InRange(unit) and 
			(
			    A.Recklessness:GetCooldown() > 30 
				or 
				Unit(player):HasBuffs(A.Recklessness.ID, true) > 0 
				or
				not A.BurstIsON(unit)
			) 
			then
                return A.Siegebreaker:Show(icon)
            end
            
            -- rampage
            if A.Rampage:IsReady(unit) and InRange(unit) and 
            (((A.FrothingBerserker:IsSpellLearned() and Player:Rage() >= 95) 
                    or 
                    A.Carnage:IsSpellLearned() and ((Unit(player):HasBuffs(A.EnrageBuff.ID, true) == 0 and Player:Rage() >= 75) or Player:Rage() > 90)) 
                or 
                A.Massacre:IsSpellLearned() and ((Unit(player):HasBuffs(A.EnrageBuff.ID, true) == 0 and Player:Rage() >= 85) or Player:Rage() > 90)) 
            then
                return A.Rampage:Show(icon)
            end
            
            -- execute
            if A.Execute:IsReady(unit) and InRange(unit) and not ShouldStop then
                return A.Execute:Show(icon)
            end
            
            -- bloodthirst,azerite.cold_steel_hot_blood.rank>1
            if A.Bloodthirst:IsReady(unit) and InRange(unit) and not ShouldStop and A.ColdSteelHotBlood:GetAzeriteRank() > 1 then
                return A.Bloodthirst:Show(icon)
            end
            
            -- raging_blow,if=charges=2
            if A.RagingBlow:IsReady(unit) and InRange(unit) and not ShouldStop and (A.RagingBlow:GetSpellCharges() == 2) and Unit(player):HasBuffs(A.EnrageBuff.ID, true) > 0 and A.ColdSteelHotBlood:GetAzeriteRank() <= 1 then
                return A.RagingBlow:Show(icon)
            end
            
            -- bloodthirst
            if A.Bloodthirst:IsReady(unit) and InRange(unit) and not ShouldStop then
                return A.Bloodthirst:Show(icon)
            end
            
            -- bladestorm
            if A.Bladestorm:IsReadyByPassCastGCD(player) and not ShouldStop and Unit(player):HasBuffs(A.EnrageBuff.ID, true) > 0 and (GetByRange(3, 8, true) or Unit(unit):IsBoss()) then
                return A.Bladestorm:Show(icon)
            end
            
            -- raging_blow
            if A.RagingBlow:IsReady(unit) and InRange(unit) and not ShouldStop then
                return A.RagingBlow:Show(icon)
            end
            
            -- furious_slash,if=talent.furious_slash.enabled
            if A.FuriousSlash:IsReady(unit) and InRange(unit) and not ShouldStop and (A.FuriousSlash:IsSpellLearned()) then
                return A.FuriousSlash:Show(icon)
            end
            
            -- whirlwind
            if A.Whirlwind:IsReady(unit) and InRange(unit) and not ShouldStop then
                return A.Whirlwind:Show(icon)
            end
            
        end
        
        -- Out of combat call DBM precombat
        local Precombat_DBMRot = Precombat_DBM(unit)
        if not inCombat and Precombat_DBMRot and Action.GetToggle(1, "DBM") and CanCast then 
            return true
        end
        
        -- Out of combat call non DBM precombat
        local PrecombatRot = Precombat(unit)
        if not inCombat and PrecombatRot and not Action.GetToggle(1, "DBM") and CanCast then 
            return true
        end   
        
        -- In Combat
        if inCombat and Unit(unit):IsExists() then
            -- auto_attack
            -- augmentation
            -- battle_shout
            if A.BattleShout:IsReady(player) and A.BattleShout:GetSpellTimeSinceLastCast() >= 60 and Unit(player):HasBuffs(A.BattleShout.ID, true) == 0 then
                return A.BattleShout:Show(icon)
            end
            
            -- Smart Stormbolt            
            if SmartStormbolt then
                local Stormbolt_Nameplates = MultiUnits:GetActiveUnitPlates()
                if Stormbolt_Nameplates then                                         
                    for Stormbolt_UnitID in pairs(Stormbolt_Nameplates) do                            
                        for k, v in pairs(TR.Lists.Storm_Spells_List) do
                            if (TR.Lists.Storm_Unit_List[select(6, Unit(Stormbolt_UnitID):InfoGUID())] ~= nil or UnitCastingInfo(Stormbolt_UnitID) == GetSpellInfo(v) or UnitChannelInfo(Stormbolt_UnitID) == GetSpellInfo(v)) and Unit(Stormbolt_UnitID):GetRange() <= 20 then                           
                                if A.Stormbolt:IsSpellLearned() and A.Stormbolt:IsReadyByPassCastGCD(player) then
                                    return A.Stormbolt:Show(icon)
                                end
                            end
                        end    
                    end 
                end                        
            end      
            
            -- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end    
            
            -- charge
            if A.Charge:IsReady(unit) and UseCharge and isMovingFor > ChargeTime then
                return A.Charge:Show(icon)
            end
            
            -- run_action_list,name=movement,if=movement.distance>5
            if Unit(unit):GetRange() > 5 then
                -- heroic_leap
                if A.HeroicLeap:IsReady(unit) and UseHeroicLeap and isMovingFor > HeroicLeapTime then
                    return A.HeroicLeap:Show(icon)
                end
            end
            
            -- Victory Rush
            if A.VictoryRush:IsReady(unit) and Unit(player):HealthPercent() <= Action.GetToggle(2, "VictoryRush") then
                return A.VictoryRush:Show(icon)
            end
            
            -- ImpendingVictory
            if A.ImpendingVictory:IsReady(unit) and not ShouldStop and Unit(player):HealthPercent() <= Action.GetToggle(2, "ImpendingVictory") then
                return A.VictoryRush:Show(icon)
            end
            
            -- execute,if=buff.enrage.up
            if A.Execute:IsReady(unit) and InRange(unit) and not ShouldStop and Unit(player):HasBuffs(A.SuddenDeathBuff.ID, true) > 1 then
                return A.Execute:Show(icon)
            end
            
            -- Misc - Supportive 
            if A.BerserkerRage:IsReady(player) then 
                if Unit(player):HasDeBuffs("Fear") >= 4 then 
                    return A.BerserkerRage:Show(icon)
                end 
            end 
            
            -- Interrupts
            -- run_action_list,name=movement,if=movement.distance>5
            -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
            if ((not InRange(unit)) and Unit(unit):GetRange() <= 40) then
                return Movement(unit);
            end
            
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.PotionofUnbridledFury:Show(icon)
            end
            
            -- rampage,if=cooldown.recklessness.remains<3
            if A.Rampage:IsReady(unit) and InRange(unit) and (A.Recklessness:GetCooldown() < 3) then
                return A.Rampage:Show(icon)
            end
            
            -- blood_of_the_enemy,if=buff.recklessness.up
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and (GetByRange(4, 8) or Unit(unit):IsBoss()) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.Recklessness.ID, true) == 0 and Unit(unit):HasDeBuffs(A.SiegebreakerDebuff.ID, true) == 0) then
                return A.BloodoftheEnemy:Show(icon)
            end
            
            -- purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.Recklessness.ID, true) == 0 and Unit(unit):HasDeBuffs(A.SiegebreakerDebuff.ID, true) == 0) then
                return A.PurifyingBlast:Show(icon)
            end
            
            -- ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.RippleinSpace:AutoHeartOfAzerothP(unit, true) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.Recklessness.ID, true) == 0 and Unit(unit):HasDeBuffs(A.SiegebreakerDebuff.ID, true) == 0) then
                return A.RippleinSpace:Show(icon)
            end
            
            -- worldvein_resonance,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.Recklessness.ID, true) == 0 and Unit(unit):HasDeBuffs(A.SiegebreakerDebuff.ID, true) == 0) then
                return A.WorldveinResonance:Show(icon)
            end
            
            -- focused_azerite_beam,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and (GetByRange(4, 8) or Unit(unit):IsBoss()) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.Recklessness.ID, true) == 0 and Unit(unit):HasDeBuffs(A.SiegebreakerDebuff.ID, true) == 0) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            
            -- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzerothP(unit, true) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.ReapingFlames:Show(icon)
            end
            
            -- concentrated_flame,if=!buff.recklessness.up&!buff.siegebreaker.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.Recklessness.ID, true) == 0 and Unit(unit):HasDeBuffs(A.SiegebreakerDebuff.ID, true) == 0 and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0) then
                return A.TheUnboundForce:Show(icon)
            end
            
            -- guardian_of_azeroth,if=!buff.recklessness.up
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and not ShouldStop and BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) == 0) then
                return A.GuardianofAzeroth:Show(icon)
            end
            
            -- memory_of_lucid_dreams,if=!buff.recklessness.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and BurstIsON(unit) and not ShouldStop and Action.GetToggle(1, "HeartOfAzeroth") and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) == 0) then
                return A.MemoryofLucidDreams:Show(icon)
            end

            -- Reck if rage is > 90 and SiegebreakerDebuff
            if A.Recklessness:IsReady(unit) and InRange(unit) and A.BurstIsON(unit) and not ShouldStop then
                return A.Recklessness:Show(icon)
            end
            
            -- dragonroar with aoe check or target is boss
            if A.DragonRoar:IsReadyByPassCastGCD(player) and not ShouldStop and Unit(player):HasBuffs(A.EnrageBuff.ID, true) > 0 and (GetByRange(2, 8, true) or Unit(unit):IsBoss()) then
                return A.DragonRoar:Show(icon)
            end
            
            -- dragonroar pure single target and NOT AoE activated (so we force single target)
            if A.DragonRoar:IsReadyByPassCastGCD(player) and not A.GetToggle(2, "AoE") and not ShouldStop and Unit(player):HasBuffs(A.EnrageBuff.ID, true) > 0 then
                return A.DragonRoar:Show(icon)
            end
            
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(debuff.conductive_ink_debuff.up|buff.metamorphosis.remains>20)&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsExists() and A.AshvanesRazorCoral:IsReady(unit) and TR.TrinketON() and 
            (
                Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 
                or 
                (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0 and Unit(unit):HealthPercent() <= 30 and Unit(unit):TimeToDie() >= 10)
            )
            then
                return A.AshvanesRazorCoral:Show(icon)
            end
            
            -- Non SIMC Custom Trinket1
            if Action.GetToggle(1, "Trinkets")[1] and A.Trinket1:IsReady(unit) and Trinket1IsAllowed then        
                if A.Trinket1:AbsentImun(unit, "DamageMagicImun")  then 
                    return A.Trinket1:Show(icon)
                end         
            end
            
            -- Non SIMC Custom Trinket2
            if Action.GetToggle(1, "Trinkets")[2] and A.Trinket2:IsReady(unit) and Trinket2IsAllowed then        
                if A.Trinket2:AbsentImun(unit, "DamageMagicImun")  then 
                    return A.Trinket2:Show(icon)
                end     
            end
            
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and not ShouldStop and BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            
            -- berserking
            if A.Berserking:AutoRacial(unit) and not ShouldStop and BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            
            -- lights_judgment,if=buff.recklessness.down
            if A.LightsJudgment:AutoRacial(unit) and not ShouldStop and BurstIsON(unit) and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) == 0) then
                return A.LightsJudgment:Show(icon)
            end
            
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and not ShouldStop and BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and not ShouldStop and BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            
            -- run_action_list,name=single_target
            if SingleTarget(unit) then
                return true
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
    Unit(player):GetDR("incapacitate") >= 50 
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
        if unit == "arena1" and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then 
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
end]]--

