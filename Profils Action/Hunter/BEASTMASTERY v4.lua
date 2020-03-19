--- ====================== ACTION HEADER ============================ ---
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
Action[ACTION_CONST_HUNTER_BEASTMASTERY] = {
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
    -- Generics
    SummonPet                              = Action.Create({ Type = "Spell", ID = 883, Texture = 136 }),
    AspectoftheWildBuff                    = Action.Create({ Type = "Spell", ID = 193530 }),
    AspectoftheWild                        = Action.Create({ Type = "Spell", ID = 193530 }),
    PrimalInstinctsBuff                    = Action.Create({ Type = "Spell", ID = 279810 }),
    PrimalInstincts                        = Action.Create({ Type = "Spell", ID = 279806 }),
    BestialWrathBuff                       = Action.Create({ Type = "Spell", ID = 19574 }),
    BestialWrath                           = Action.Create({ Type = "Spell", ID = 19574 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    BerserkingBuff                         = Action.Create({ Type = "Spell", ID = 26297 }),
    KillerInstinct                         = Action.Create({ Type = "Spell", ID = 273887 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    BloodFuryBuff                          = Action.Create({ Type = "Spell", ID = 20572 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    FrenzyBuff                             = Action.Create({ Type = "Spell", ID = 272790 }),
    LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295078 }),
    BarbedShot                             = Action.Create({ Type = "Spell", ID = 217200 }),
	BarbedShotDebuff                       = Action.Create({ Type = "Spell", ID = 217200 }),
    Multishot                              = Action.Create({ Type = "Spell", ID = 2643 }),
    BeastCleaveBuff                        = Action.Create({ Type = "Spell", ID = 118455 }),
    Stampede                               = Action.Create({ Type = "Spell", ID = 201430 }),
    OneWiththePack                         = Action.Create({ Type = "Spell", ID = 199528 }),
    ChimaeraShot                           = Action.Create({ Type = "Spell", ID = 53209 }),
    AMurderofCrows                         = Action.Create({ Type = "Spell", ID = 131894 }),
    Barrage                                = Action.Create({ Type = "Spell", ID = 120360 }),
    KillCommand                            = Action.Create({ Type = "Spell", ID = 34026 }),
    RapidReload                            = Action.Create({ Type = "Spell", ID = 278530 }),
    DireBeast                              = Action.Create({ Type = "Spell", ID = 120679 }),
    CobraShot                              = Action.Create({ Type = "Spell", ID = 193455 }),
    SpittingCobra                          = Action.Create({ Type = "Spell", ID = 194407 }),
    DanceofDeath                           = Action.Create({ Type = "Spell", ID = 274443 }),
    DanceofDeathBuff                       = Action.Create({ Type = "Spell", ID = 274443 }),
	AnimalCompanion                        = Action.Create({ Type = "Spell", ID = 267116 , isTalent = true, Hidden = true     }), -- Avoid error with second pet with no abilities
    -- Pet
    CallPet                                = Action.Create({ Type = "Spell", ID = 883, Texture = 136 }),
    MendPet                                = Action.Create({ Type = "Spell", ID = 136, Texture = 136  }),
    RevivePet                              = Action.Create({ Type = "Spell", ID = 982, Texture = 136 }),
    SpiritShock                            = Action.Create({ Type = "SpellSingleColor", ID = 264265, Color = "BLUE" }), -- Pet dispell/purge
    SonicBlast                             = Action.Create({ Type = "SpellSingleColor", ID = 264263, Color = "YELLOW" }), -- Pet dispell/purge
    CounterShot                            = Action.Create({ Type = "Spell", ID = 147362 }),
    Exhilaration                           = Action.Create({ Type = "Spell", ID = 109304 }),
	SpiritMend                             = Action.Create({ Type = "SpellSingleColor", ID = 90361, Color = "YELLOW"}), 
	BindingShot                            = Action.Create({ Type = "Spell", ID = 109248  }), 
	Smack                                  = Action.Create({ Type = "Spell", ID = 49966  }), 
	Claw                                   = Action.Create({ Type = "Spell", ID = 16827  }), 
	Bite                                   = Action.Create({ Type = "Spell", ID = 17253  }), 		
	-- Defensives
	AspectoftheTurtle                      = Action.Create({ Type = "Spell", ID = 274441 }),
	FeignDeath                             = Action.Create({ Type = "Spell", ID = 5384 }),
    -- Trinkets
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true  }),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true  }),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
    RecklessForceCounter                   = Action.Create({ Type = "Spell", ID = 298409, Hidden = true     }),
    DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon
	PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
	GrandDelusionsDebuff                   = Action.Create({ Type = "Spell", ID = 319695, Hidden = true     }), -- Corruption pet chasing you
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_HUNTER_BEASTMASTERY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_HUNTER_BEASTMASTERY], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"
local pet = "pet"
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

-- API - Spell
-- Example of create:
Pet:Add(253, {
	-- number accepted
	17253, -- Bite
	16827, -- Claw
	49966, -- Smack
	--47481, -- Gnaw
	-- strings also accepted!
--	"Gnaw",
--	(GetSpellInfo(47481)), -- must be in '(' ')' because call this function will return multi returns through ',' 
})

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
	
    -- Exhilaration
    local Exhilaration = GetToggle(2, "ExhilarationHP")
    if     Exhilaration >= 0 and A.Exhilaration:IsReady(player) and 
    (
        (     -- Auto 
            Exhilaration >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
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
        ) or 
        (    -- Custom
            Exhilaration < 100 and 
            Unit(player):HealthPercent() <= Exhilaration
        )
    ) 
    then 
	    -- Notification					
        Action.SendNotification("[DEF] Exhilaration", A.Exhilaration.ID)
        return A.Exhilaration
    end
	
    -- SpiritMend
	local CurrentCreatureFamily = UnitCreatureFamily(pet)
    local SpiritMend = GetToggle(2, "SpiritMendHP")
    if     SpiritMend >= 0 and A.SpiritMend:IsReady(pet) and not A.AnimalCompanion:IsSpellLearned() and CurrentCreatureFamily == "Spirit Beast" and 
    (
        (     -- Auto 
            SpiritMend >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(15) < 3 or 
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
        ) or 
        (    -- Custom
            SpiritMend < 100 and 
            Unit(player):HealthPercent() <= SpiritMend
        )
    ) 
    then 
		    -- Notification					
        Action.SendNotification("[DEF] Spirit Mend", A.SpiritMend.ID)
        return A.SpiritMend
    end	
	
    -- AspectoftheTurtle
    local AspectoftheTurtle = GetToggle(2, "Turtle")
    if     AspectoftheTurtle >= 0 and A.AspectoftheTurtle:IsReady(player) and 
    (
        (     -- Auto 
            AspectoftheTurtle >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
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
        ) or 
        (    -- Custom
            AspectoftheTurtle < 100 and 
            Unit(player):HealthPercent() <= AspectoftheTurtle
        )
    ) 
    then
		    -- Notification					
        Action.SendNotification("[DEF] Aspect of the Turtle", A.AspectoftheTurtle.ID)	
        return A.AspectoftheTurtle
    end     
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady(player, true) and not A.IsInPvP and A.AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
    if useKick and A.CounterShot:IsReady(unit) and A.CounterShot:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, MinInterrupt, MaxInterrupt) then 
	    -- Notification					
        Action.SendNotification("Counter Shot interrupting on Target ", A.CounterShot.ID)
        return A.CounterShot
    end 
    
    if useCC and A.BindingShot:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.BindingShot:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
	    -- Notification					
        Action.SendNotification("Binding Shot interrupting...", A.BindingShot.ID)
        return A.BindingShot              
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

-- Offensive dispel rotation
local function PurgeDispellMagic(unit)
	local CurrentCreatureFamily = UnitCreatureFamily("pet") 
	
	-- SpiritShock
	if A.SpiritShock:IsReady(unit) and CurrentCreatureFamily == "Spirit Beast" and not ShouldStop and (Action.AuraIsValid(unit, "UseExpelEnrage", "Enrage") or Action.AuraIsValid(unit, "UseDispel", "Magic")) then
		return A.SpiritShock:Show(icon)
    end
			
    -- SonicBlast
    if A.SonicBlast:IsReady(unit) and CurrentCreatureFamily == "Bat" and not ShouldStop and (Action.AuraIsValid(unit, "UseExpelEnrage", "Enrage") or Action.AuraIsValid(unit, "UseDispel", "Magic")) then
        return A.SonicBlast:Show(icon)
    end		
end
PurgeDispellMagic = A.MakeFunctionCachedDynamic(PurgeDispellMagic)

local function InRange(unit)
	-- @return boolean 
	return A.BarbedShot:IsInRange(unit)
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

-- BestialWrath Handler UI --
local function HandleBestialWrath()
    local choice = GetToggle(2, "BestialWrathMode")
	local unit = "target"
    return     (
        (A.BurstIsON(unit) and choice[1]) or 
        (GetByRange(2, 40) and choice[2]) or
        (A.BestialWrath:IsReady(player) and choice[3])
    )
 
  --[[  local choice = GetToggle(2, "BestialWrathMode")
	--print(choice) 
    local unit = "target"
    -- CDs ON
    if choice[1] then 
	    return A.BurstIsON(unit) or false 
	-- AoE Only
	elseif choice[2] then
	    -- also checks CDs
	    if choice[1] then
		    return (A.BurstIsON(unit) and MultiUnits:GetByRange(40) >= MinAoETargets and GetToggle(2, "AoE")) or false
		else
		    return (MultiUnits:GetByRange(40) > 2 and GetToggle(2, "AoE")) or false
		end
	-- Everytime
	elseif choice[3] then
        return A.BestialWrath:IsReady(player) or false
	else
	    return false
	end	]]--	
end

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
            if not notKickAble and A.CounterShot:IsReady(unit, nil, nil, true) and A.CounterShot:AbsentImun(unit, Temp.TotalAndMag, true) then
                return A.CounterShot:Show(icon)                                                  
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

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
	local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = player
	local profileStop = false
	local MendPet = Action.GetToggle(2, "MendPet")
	local DBM = Action.GetToggle(1, "DBM")
	local HeartOfAzeroth = Action.GetToggle(1, "HeartOfAzeroth")
	local Racial = Action.GetToggle(1, "Racial")
	local Potion = Action.GetToggle(1, "Potion")
	local MultishotMinAoETargets = Action.GetToggle(2, "MultishotMinAoETargets")
	local MultishotMaxAoERange = Action.GetToggle(2, "MultishotMaxAoERange")
	local UnbridledFuryAuto = GetToggle(2, "UnbridledFuryAuto")
	local UnbridledFuryTTD = GetToggle(2, "UnbridledFuryTTD")
	local UnbridledFuryWithBloodlust = GetToggle(2, "UnbridledFuryWithBloodlust")
	local UnbridledFuryHP = GetToggle(2, "UnbridledFuryHP")
	local UnbridledFuryWithExecute = GetToggle(2, "UnbridledFuryWithExecute")
	local BarbedShotRefreshSec = GetToggle(2, "BarbedShotRefreshSec")
	local FocusedAzeriteBeamTTD = GetToggle(2, "FocusedAzeriteBeamTTD")
	local FocusedAzeriteBeamUnits = GetToggle(2, "FocusedAzeriteBeamUnits")
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
	local TrinketsAoE = GetToggle(2, "TrinketsAoE")
	local TrinketsMinTTD = GetToggle(2, "TrinketsMinTTD")
	local TrinketsUnitsRange = GetToggle(2, "TrinketsUnitsRange")
	local TrinketsMinUnits = GetToggle(2, "TrinketsMinUnits")
	local MinInterrupt = GetToggle(2, "MinInterrupt")
	local MaxInterrupt = GetToggle(2, "MaxInterrupt")
	local UseFeignDeathOnThingFromBeyond = GetToggle(2, "UseFeignDeathOnThingFromBeyond")
	local AoEMode = A.GetToggle(2, "AoEMode")
	Pet:DisableErrors(true)
	-- Azerite beam protection channel
	local CanCast = true
	local TotalCast, CurrentCastLeft, CurrentCastDone = Unit(player):CastTime()
	local _, castStartedTime, castEndTime = Unit(player):IsCasting()
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(player):IsCastingRemains()
	-- Ensure all channel and cast are really safe
	-- Double protection with check on current casts and also timestamp of the cast
	if (spellID == A.FocusedAzeriteBeam.ID) then 
	    if (CurrentCastLeft > 0 or secondsLeft > 0 or isChannel) then
		    if TMW.time < castEndTime then			
			    CanCast = false
	        else
	            CanCast = true
			end
		end
	end
	-- Showing icon PoolResource to make sure nothing else is read by GG
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
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
		
		-- Interrupt Handler
 	 	
  		local unit = "target"
   		local useKick, useCC, useRacial = Action.InterruptIsValid(unit, "TargetMouseover")    
        local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		    
		-- Interrupt
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end  
      

		
		-- Feign Death & Thing from Beyond
--[[		if UseFeignDeathOnThingFromBeyond and A.FeignDeath:IsReady(player) and Player:GetCurrentCorruption() >= 40 and inCombat then
            local CurrentNameplates = MultiUnits:GetActiveUnitPlates()
            if CurrentNameplates then  
                for Currents_UnitID in pairs(CurrentNameplates) do             
                    if Unit(Currents_UnitID):NPCID() == 160966 or Unit(Currents_UnitID):NPCID() == 161895 then 
                        return A.FeignDeath:Show(icon)
                    end         
                end 
            end		    
		end
		]]--
		if Unit(player):HasDeBuffs(A.GrandDelusionsDebuff.ID, true) > 0 and A.FeignDeath:IsReady(player) then
		    return A.FeignDeath:Show(icon)
		end
		
        -- mendpet
        if A.MendPet:IsReady(player) and Pet:IsActive() and Unit(pet):HealthPercent() > 0 and
        (
 			-- AUTO
			(
			    MendPet >= 100 and
			    (
		             -- HP lose per sec >= 30
                    Unit(pet):GetDMG() * 100 / Unit(pet):HealthMax() >= 30 or 
                    Unit(pet):GetRealTimeDMG() >= Unit(pet):HealthMax() * 0.30 or 
                    -- TTD 
                    Unit(pet):TimeToDieX(15) < 2  
				)				
			) 
			or  
			-- MANUAL
		    (
			    MendPet < 100 and
				Unit(pet):HealthPercent() <= MendPet and Unit(pet):HasBuffs(A.MendPet.ID, true) == 0
			)
             
		)
		then
		    return A.MendPet:Show(icon)
        end
			
	    -- summon_pet if not active
        if not Pet:IsActive() and A.MendPet:IsReady(player) and not A.LastPlayerCastName == A.MendPet:Info() then
		    return A.MendPet:Show(icon)
        end
			
        -- call_action_list,name=purge_dispellmagic
        if inCombat and PurgeDispellMagic(unit) then
            return true
        end
			
        -- use_items
        -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.up&(prev_gcd.1.aspect_of_the_wild|!equipped.cyclotronic_blast&buff.aspect_of_the_wild.up)&(target.health.pct<35|!essence.condensed_lifeforce.major)|(debuff.razor_coral_debuff.down|target.time_to_die<26)&target.time_to_die>(24*(cooldown.cyclotronic_blast.remains+4<target.time_to_die))
        if inCombat and A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) > 0 and (A.LastPlayerCastName == A.AspectoftheWild:Info() or not A.CyclotronicBlast:IsExists() and Unit(player):HasBuffs(A.AspectoftheWildBuff.ID, true) > 0) and (Unit(unit):HealthPercent() < 35 or not A.GuardianofAzeroth:IsSpellLearned()) or (Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) == 0 or Unit(unit):TimeToDie() < 26) and Unit(unit):TimeToDie() > (24 * num((A.CyclotronicBlast:GetCooldown() + 4 < Unit(unit):TimeToDie())))) then
            return A.AshvanesRazorCoral:Show(icon)
        end
			
        -- use_item,effect_name=cyclotronic_blast,if=buff.bestial_wrath.down|target.time_to_die<5
        if inCombat and A.CyclotronicBlast:IsReady(unit) and (Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) == 0 or Unit(unit):TimeToDie() < 5) then
            return A.CyclotronicBlast:Show(icon)
        end     

        -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.turtle.buff.frenzy.up&pet.turtle.buff.frenzy.remains<=gcd.max
        if inCombat and A.BarbedShot:IsReadyByPassCastGCD(unit) and --Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true) > 0 and 
		(
			Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) > 0 and Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) <= BarbedShotRefreshSec + A.GetPing()
			or 
			Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) == 0
		)
		then
            return A.BarbedShot:Show(icon) 
        end
			
		--Precombat
        if combatTime == 0 and not profileStop and Unit(unit):IsExists() and unit ~= "mouseover" then
            -- flask
            -- augmentation
            -- food
            -- summon_pet
            if A.SummonPet:IsReady(unit) and not Pet:IsActive() then
                return A.SummonPet:Show(icon)
            end
			
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(player)
			and ((Pull > 0.1 and Pull <= 8) or not DBM) 
			then
			 	 -- Notification					
                Action.SendNotification("Stop moving!! Azsharas Font of Power", A.AzsharasFontofPower.ID) 
                return A.AzsharasFontofPower:Show(icon)
            end
			
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Potion
			and ((Pull > 0.1 and Pull < 1.5 + A.GetGCD()) or not DBM) 
			then
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- worldvein_resonance
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth
			and ((Pull > 0.1 and Pull < 1.5) or not DBM) 
			then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth
			and ((Pull > 0.1 and Pull < 1.5) or not DBM) 
			then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth
			and ((Pull > 0.1 and Pull < 1.5) or not DBM) 
			then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- focused_azerite_beam,if=!raid_event.invulnerable.exists
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth
			and ((Pull > 0.1 and Pull < 1) or not DBM) then
                return A.FocusedAzeriteBeam:Show(icon)
            end	
			
            -- aspect_of_the_wild,precast_time=1.1,if=!azerite.primal_instincts.enabled&!essence.essence_of_the_focusing_iris.major&(equipped.azsharas_font_of_power|!equipped.cyclotronic_blast)
            if A.BurstIsON(unit) and not inCombat and A.AspectoftheWild:IsReady(player) and Unit(player):HasBuffs(A.AspectoftheWildBuff.ID, true) == 0 and (A.PrimalInstincts:GetAzeriteRank() == 0 and not A.FocusedAzeriteBeam:IsSpellLearned() and (A.AzsharasFontofPower:IsExists() or not A.CyclotronicBlast:IsExists()))
			and ((Pull > 0.1 and Pull <= 1.2) or not DBM) 
			then
                return A.AspectoftheWild:Show(icon)
            end
			
            -- bestial_wrath,precast_time=1.5,if=azerite.primal_instincts.enabled&!essence.essence_of_the_focusing_iris.major&(equipped.azsharas_font_of_power|!equipped.cyclotronic_blast)
            if A.BestialWrath:IsReady(player) and HandleBestialWrath() 
			and not inCombat and Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) == 0 and (A.PrimalInstincts:GetAzeriteRank() > 0 and not Azerite:EssenceHasMajor(A.FocusedAzeriteBeam.ID) and (A.AzsharasFontofPower:IsExists() or not A.CyclotronicBlast:IsExists()))
			and ((Pull > 0.1 and Pull <= 1.6) or not DBM) 
			then
                return A.BestialWrath:Show(icon)
            end
			
			-- cobra_shot
			if A.BarbedShot:IsReadyByPassCastGCD(unit) and not inCombat and 
			((Pull > 0.1 and Pull < 0.7) or not DBM) then
                return A.BarbedShot:Show(icon)
            end	
			
        end
        
		-- Burst Phase
		if BurstIsON(unit) and unit ~= "mouseover" and inCombat and not profileStop and CanCast then
            -- ancestral_call,if=cooldown.bestial_wrath.remains>30
            if A.AncestralCall:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) 
			then
                return A.AncestralCall:Show(icon)
            end
			
            -- fireblood,if=cooldown.bestial_wrath.remains>30
            if A.Fireblood:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (A.BestialWrath:GetCooldown() > 30) 
			then
                return A.Fireblood:Show(icon)
            end
			
            -- berserking,if=buff.aspect_of_the_wild.up&(target.time_to_die>cooldown.berserking.duration+duration|(target.health.pct<35|!talent.killer_instinct.enabled))|target.time_to_die<13
            if A.Berserking:AutoRacial(unit) and Racial and A.BurstIsON(unit) 
			and (Unit(player):HasBuffs(A.AspectoftheWildBuff.ID, true) and (Unit(unit):TimeToDie() > 10 
			or (Unit(unit):HealthPercent() < 35 or not A.KillerInstinct:IsSpellLearned())) or Unit(unit):TimeToDie() < 13) 
			then
                return A.Berserking:Show(icon)
            end

            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and UnbridledFuryAuto
			and 
			(
				(UnbridledFuryWithBloodlust and Unit(player):HasHeroism())
				or
				(UnbridledFuryWithExecute and Unit(unit):HealthPercent() <= 30)
			)
			and Unit(unit):TimeToDie() > UnbridledFuryTTD
			then
 	            -- Notification					
                Action.SendNotification("Burst: Potion of Unbridled Fury", A.PotionofUnbridledFury.ID)	
                return A.PotionofUnbridledFury:Show(icon)
            end
			
            -- blood_fury,if=buff.aspect_of_the_wild.up&(target.time_to_die>cooldown.blood_fury.duration+duration|(target.health.pct<35|!talent.killer_instinct.enabled))|target.time_to_die<16
            if A.BloodFury:AutoRacial(unit) and Racial and A.BurstIsON(unit) and (Unit(player):HasBuffs(A.AspectoftheWildBuff.ID, true) and (Unit(unit):TimeToDie() > 15 or (Unit(unit):HealthPercent() < 35 or not A.KillerInstinct:IsSpellLearned())) or Unit(unit):TimeToDie() < 16) 
			then
                return A.BloodFury:Show(icon)
            end
			
            -- lights_judgment,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains>gcd.max|!pet.cat.buff.frenzy.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) and Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) > A.GetGCD() or not Unit(pet):HasBuffs(A.FrenzyBuff.ID, true)) 
			then
                return A.LightsJudgment:Show(icon)
            end
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) and Racial and A.BurstIsON(unit) then
                return A.BagofTricks:Show(icon)
            end
			
			-- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.ReapingFlames:Show(icon)
            end
			
			-- moment_of_glory
            if A.MomentofGlory:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.MomentofGlory:Show(icon)
            end

			-- ReplicaofKnowledge
            if A.ReplicaofKnowledge:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth then
                return A.ReplicaofKnowledge:Show(icon)
            end	
			
            -- worldvein_resonance,if=buff.lifeblood.stack<4
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffsStacks(A.LifebloodBuff.ID, true) < 4) 
			then
                return A.WorldveinResonance:Show(icon)
            end
			
            -- guardian_of_azeroth,if=cooldown.aspect_of_the_wild.remains<10|target.time_to_die>cooldown+duration|target.time_to_die<30
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth 
			then
                return A.GuardianofAzeroth:Show(icon)
            end
			
            -- ripple_in_space
            if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth 
			then
                return A.RippleinSpace:Show(icon)
            end
			
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and HeartOfAzeroth 
			then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
	    	-- Non SIMC Custom Trinket1
	        if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then 
      	        return A.Trinket1:Show(icon)
   	        end 		
	        
		    -- Non SIMC Custom Trinket2
	        if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and	    
			(
    			TrinketsAoE and GetByRange(TrinketsMinUnits, TrinketsUnitsRange) and Player:AreaTTD(TrinketsUnitsRange) > TrinketsMinTTD
				or
				not TrinketAoE and Unit(unit):TimeToDie() >= TrinketsMinTTD 					
			)
			then
      	       	return A.Trinket2:Show(icon) 	
	        end
			
        end
       
        -- AoE Cleave
        if (isMulti or GetToggle(2, "AoE")) and CanCast and
	        (
                -- Range by pet
				AoEMode == "RangeByPet" and 
				(
				    Pet:GetMultiUnitsBySpell(17253) > 1 or -- Bite
				    Pet:GetMultiUnitsBySpell(16827) > 1 or -- Claw
				    Pet:GetMultiUnitsBySpell(49966) > 1 -- Smack					
				)
				or 
				-- Range by nameplate
				AoEMode == "RangeByNameplate" and
				(					    
				    GetByRange(1, 40, true)
				)
				or
				-- Range by active enemies CLEU
				AoEMode == "RangeByCLEU" and
				(        				
					MultiUnits:GetActiveEnemies() > 1					     
				)
			)
	    then 
		    
                -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.turtle.buff.frenzy.up&pet.turtle.buff.frenzy.remains<=gcd.max
                if A.BarbedShot:IsReadyByPassCastGCD(unit) and --Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true) > 0 and 
			    (
			        Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) > 0 and Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) <= BarbedShotRefreshSec + A.GetPing()
				    or 
				    Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) == 0
		    	)
		    	then
                    return A.BarbedShot:Show(icon) 
                end
			
                -- multishot,if=gcd.max-pet.turtle.buff.beast_cleave.remains>0.25
                if A.Multishot:IsReady(unit) and GetToggle(2, "AoE") and (A.GetGCD() - Unit(pet):HasBuffs(A.BeastCleaveBuff.ID, true) > 0.25) and 
				(
					-- Range by pet
					AoEMode == "RangeByPet" and 
					(
						Pet:GetMultiUnitsBySpell(17253) >= MultishotMinAoETargets or -- Bite
						Pet:GetMultiUnitsBySpell(16827) >= MultishotMinAoETargets or -- Claw
						Pet:GetMultiUnitsBySpell(49966) >= MultishotMinAoETargets -- Smack					
					)
					or 
					-- Range by nameplate
					AoEMode == "RangeByNameplate" and
					(					    
						GetByRange(MultishotMinAoETargets, MultishotMaxAoERange) 
					)
					or
					-- Range by active enemies CLEU
					AoEMode == "RangeByCLEU" and
					(        				
						MultiUnits:GetActiveEnemies() >= MultishotMinAoETargets					     
					)
			    )	
				then
                    return A.Multishot:Show(icon)
                end
			
                -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=full_recharge_time<gcd.max&cooldown.bestial_wrath.remains
                if A.BarbedShot:IsReadyByPassCastGCD(unit) then
                    if Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true) > 0 and A.BarbedShot:GetSpellChargesFullRechargeTime() < A.GetGCD() and A.BestialWrath:GetCooldown() > 0 then 
                        return A.BarbedShot:Show(icon) 
                    end
                end
			
                -- aspect_of_the_wild
                if A.AspectoftheWild:IsReady(unit) and A.BurstIsON(unit) then
                    return A.AspectoftheWild:Show(icon)
                end
		    	
                -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
                if A.Stampede:IsReady(unit) and 
		    	(
			        Unit(player):HasBuffs(A.AspectoftheWildBuff.ID, true) > 0 and Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) > 0
				    or 
				    Unit(unit):TimeToDie() < 15
		    	)
			    then
                    return A.Stampede:Show(icon)
                end
			
               -- bestial_wrath,if=cooldown.aspect_of_the_wild.remains_guess>20|talent.one_with_the_pack.enabled|target.time_to_die<15
                if A.BestialWrath:IsReady(player) and HandleBestialWrath() and 
			    (
			        A.AspectoftheWild:GetCooldown() > 20 
			    	or 
			    	A.OneWiththePack:IsSpellLearned() 
			    	or 
			    	Unit(unit):TimeToDie() < 15
		    	)
			    then
                    return A.BestialWrath:Show(icon)
                end
			
                -- chimaera_shot
                if A.ChimaeraShot:IsReady(unit) then
                    return A.ChimaeraShot:Show(icon)
                end
			
                -- a_murder_of_crows
                if A.AMurderofCrows:IsReady(unit) then
                    return A.AMurderofCrows:Show(icon)
                end
			
                -- barrage
                if A.Barrage:IsReady(unit) then
                    return A.Barrage:Show(icon)
                end
			
                -- kill_command,if=active_enemies<4|!azerite.rapid_reload.enabled
                if A.KillCommand:IsReadyByPassCastGCD(unit) and 
				(
					(
						-- Range by pet
						AoEMode == "RangeByPet" and 
						(
							Pet:GetMultiUnitsBySpell(17253) < 4 or -- Bite
							Pet:GetMultiUnitsBySpell(16827) < 4 or -- Claw
							Pet:GetMultiUnitsBySpell(49966) < 4 -- Smack					
						)
						or 
						-- Range by nameplate
						AoEMode == "RangeByNameplate" and
						(					    
							GetByRange(4, 40, false, true) 
						)
						or
						-- Range by active enemies CLEU
						AoEMode == "RangeByCLEU" and
						(        				
							MultiUnits:GetActiveEnemies() < 4					     
						)
					) 
				    or A.RapidReload:GetAzeriteRank() == 0
                )				
				then
                    return A.KillCommand:Show(icon)
                end
			
                -- dire_beast
                if A.DireBeast:IsReady(unit) then
                    return A.DireBeast:Show(icon)
                end
			
                -- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.turtle.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<pet.turtle.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|charges_fractional>1.4|target.time_to_die<9
                if A.BarbedShot:IsReadyByPassCastGCD(unit) then
                    if Unit(unit):HasDeBuffs(A.BarbedShotDebuff.ID, true) > 0 and Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) == 0 and (A.BarbedShot:GetSpellChargesFrac() > 1.8 or Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) > 0) or A.AspectoftheWild:GetCooldown() < 8 - A.GetGCD() and A.PrimalInstincts:GetAzeriteRank() > 0 then 
                        return A.BarbedShot:Show(icon) 
                    end
                end
			
                -- focused_azerite_beam,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
                if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and CanCast and BurstIsON(unit) and UseHeartOfAzeroth 
		    	and (GetByRange(FocusedAzeriteBeamUnits, 30) or Unit(unit):IsBoss()) and Unit(unit):TimeToDie() >= FocusedAzeriteBeamTTD
		    	then
 	                -- Notification					
                    Action.SendNotification("Stop moving!! Focused Azerite Beam", A.FocusedAzeriteBeam.ID)                 
			    	return A.FocusedAzeriteBeam:Show(icon)
                end
			
                -- purifying_blast
                if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                    return A.PurifyingBlast:Show(icon)
                end
			
                -- concentrated_flame
                if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth then
                    return A.ConcentratedFlame:Show(icon)
                end
			
                -- blood_of_the_enemy
                if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and A.BurstIsON(unit) then
                    return A.BloodoftheEnemy:Show(icon)
                end
			
                -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
                if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and (Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0 or Unit(player):HasBuffsStacks(A.RecklessForceCounter.ID, true) < 10) then
                    return A.TheUnboundForce:Show(icon)
                end
			
                -- multishot,if=azerite.rapid_reload.enabled&active_enemies>2
                if A.Multishot:IsReady(unit) and GetToggle(2, "AoE") and A.RapidReload:GetAzeriteRank() > 0 and 
				(
					-- Range by pet
					AoEMode == "RangeByPet" and 
					(
						Pet:GetMultiUnitsBySpell(17253) >= MultishotMinAoETargets or -- Bite
						Pet:GetMultiUnitsBySpell(16827) >= MultishotMinAoETargets or -- Claw
						Pet:GetMultiUnitsBySpell(49966) >= MultishotMinAoETargets -- Smack					
					)
					or 
					-- Range by nameplate
					AoEMode == "RangeByNameplate" and
					(					    
						GetByRange(MultishotMinAoETargets, MultishotMaxAoERange) 
					)
					or
					-- Range by active enemies CLEU
					AoEMode == "RangeByCLEU" and
					(        				
						MultiUnits:GetActiveEnemies() >= MultishotMinAoETargets					     
					)
			    )	
				then
                    return A.Multishot:Show(icon)
                end
			
                -- cobra_shot,if=cooldown.kill_command.remains>focus.time_to_max&(active_enemies<3|!azerite.rapid_reload.enabled)
                if A.CobraShot:IsReady(unit) and 
		    	(
			        A.KillCommand:GetCooldown() > Player:FocusTimeToMaxPredicted() and 
				   (
					    (
    						-- Range by pet
					        AoEMode == "RangeByPet" and 
					        (
				    	        Pet:GetMultiUnitsBySpell(17253) < MultishotMinAoETargets or -- Bite
				    	        Pet:GetMultiUnitsBySpell(16827) < MultishotMinAoETargets or -- Claw
				   	            Pet:GetMultiUnitsBySpell(49966) < MultishotMinAoETargets -- Smack					
					        )
					        or 
					        -- Range by nameplate
					        AoEMode == "RangeByNameplate" and
					        (					    
				   	            GetByRange(MultishotMinAoETargets, 40, false, true)
					        )
					        or
					        -- Range by active enemies CLEU
					        AoEMode == "RangeByCLEU" and
					        (        				
					    	    MultiUnits:GetActiveEnemies() < MultishotMinAoETargets					     
				    	    )
						)	
			    		or A.RapidReload:GetAzeriteRank() == 0
			    	)
		    	)
		    	then
                    return A.CobraShot:Show(icon)
                end
			
                -- spitting_cobra
                if A.SpittingCobra:IsReady(unit) then
                    return A.SpittingCobra:Show(icon)
                end
            end
			
			
			-- SINGLE Target
            -- call_action_list,name=st,if=active_enemies<2
            if (isMulti or GetToggle(2, "AoE")) and
			(
                -- Range by pet
				AoEMode == "RangeByPet" and 
				(
				    Pet:GetMultiUnitsBySpell(17253) < 2 or -- Bite
				    Pet:GetMultiUnitsBySpell(16827) < 2 or -- Claw
				    Pet:GetMultiUnitsBySpell(49966) < 2 -- Smack					
				)
				or 
				-- Range by nameplate
				AoEMode == "RangeByNameplate" and
				(					    
				    GetByRange(2, 40, false, true)
				)
				or
				-- Range by active enemies CLEU
				AoEMode == "RangeByCLEU" and
				(        				
					MultiUnits:GetActiveEnemies() < 2	
                )					
			) or not GetToggle(2, "AoE")
	        then 			
            -- barbed_shot,if=pet.turtle.buff.frenzy.up&pet.turtle.buff.frenzy.remains<gcd|cooldown.bestial_wrath.remains&(full_recharge_time<gcd|azerite.primal_instincts.enabled&cooldown.aspect_of_the_wild.remains<gcd)
            if A.BarbedShot:IsReadyByPassCastGCD(unit) and 
			(
			    Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) > 0 and Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) < A.GetGCD() 
				or 
				A.BestialWrath:GetCooldown() > 0 and 
				(
				    A.BarbedShot:GetSpellChargesFullRechargeTime() < A.GetGCD() 
					or 
					A.PrimalInstincts:GetAzeriteRank() > 0 and A.AspectoftheWild:GetCooldown() < A.GetGCD()
				)
			)
			then
                return A.BarbedShot:Show(icon)
            end
			
            -- concentrated_flame,if=focus+focus.regen*gcd<focus.max&buff.bestial_wrath.down&(!dot.concentrated_flame_burn.remains&!action.concentrated_flame.in_flight)|full_recharge_time<gcd|target.time_to_die<5
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			(
			    Player:Focus() + Player:FocusRegen() * A.GetGCD() < Player:FocusMax() and Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) == 0 and 
				(
				    Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight()
				) 
				or 
				A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD() 
				or
				Unit(unit):TimeToDie() < 5
			)
			then
                return A.ConcentratedFlame:Show(icon)
            end
			
            -- aspect_of_the_wild,if=cooldown.barbed_shot.charges<1|!azerite.primal_instincts.enabled
            if A.AspectoftheWild:IsReady(unit) and A.BurstIsON(unit) and (A.BarbedShot:GetSpellCharges() < 1 or A.PrimalInstincts:GetAzeriteRank() == 0) then
                return A.AspectoftheWild:Show(icon)
            end
			
            -- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15
            if A.Stampede:IsReady(unit) and 
			(
			    Unit(player):HasBuffs(A.AspectoftheWildBuff.ID, true) > 0 and Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) > 0 
				or 
				Unit(unit):TimeToDie() < 15
			)
			then
                return A.Stampede:Show(icon)
            end
			
            -- a_murder_of_crows
            if A.AMurderofCrows:IsReady(unit) then
                return A.AMurderofCrows:Show(icon)
            end
			
            -- focused_azerite_beam,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			(
			    Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) == 0 
				or
				Unit(unit):TimeToDie() < 5
			) 
			then
                return A.FocusedAzeriteBeam:Show(icon)
            end
			
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10|target.time_to_die<5
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			(
			    Unit(player):HasBuffs(A.RecklessForceBuff.ID, true) > 0 
				or 
				Unit(player):HasBuffsStacks(A.RecklessForceCounter.ID, true) < 10 
				or
				Unit(unit):TimeToDie() < 5
			)
			then
                return A.TheUnboundForce:Show(icon)
            end
			
            -- bestial_wrath,if=!buff.bestial_wrath.up&cooldown.aspect_of_the_wild.remains>15|target.time_to_die<15+gcd
            if A.BestialWrath:IsReady(player) and HandleBestialWrath() and 
			(
			    Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) == 0 and A.AspectoftheWild:GetCooldown() > 15 
				or
				Unit(unit):TimeToDie() < 15 + A.GetGCD()
			)
			then
                return A.BestialWrath:Show(icon)
            end
			
            -- barbed_shot,if=azerite.dance_of_death.rank>1&buff.dance_of_death.remains<gcd&Player:CritChancePct()>40
            if A.BarbedShot:IsReadyByPassCastGCD(unit) and (A.DanceofDeath:GetAzeriteRank() > 1 and Unit(player):HasBuffs(A.DanceofDeathBuff.ID, true) < A.GetGCD() and Player:CritChancePct() > 40) then
                return A.BarbedShot:Show(icon)
            end
			
            -- blood_of_the_enemy,if=buff.aspect_of_the_wild.remains>10+gcd|target.time_to_die<10+gcd
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			(
			    Unit(player):HasBuffs(A.AspectoftheWildBuff.ID, true) > 10 + A.GetGCD() 
				or 
				Unit(unit):TimeToDie() < 10 + A.GetGCD()
			)
			then
                return A.BloodoftheEnemy:Show(icon)
            end
			
            -- kill_command
            if A.KillCommand:IsReadyByPassCastGCD(unit) then
                return A.KillCommand:Show(icon)
            end
			
            -- bag_of_tricks,if=buff.bestial_wrath.down|target.time_to_die<5
            if A.BagofTricks:IsReady(unit) and (Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) == 0 or Unit(unit):TimeToDie() < 5) then
                return A.BagofTricks:Show(icon)
            end
			
            -- chimaera_shot
            if A.ChimaeraShot:IsReady(unit) then
                return A.ChimaeraShot:Show(icon)
            end
			
            -- dire_beast
            if A.DireBeast:IsReady(unit) then
                return A.DireBeast:Show(icon)
            end
			
            -- barbed_shot,if=talent.one_with_the_pack.enabled&charges_fractional>1.5|charges_fractional>1.8|cooldown.aspect_of_the_wild.remains<pet.turtle.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|target.time_to_die<9
            if A.BarbedShot:IsReadyByPassCastGCD(unit) and 
			(
			    A.OneWiththePack:IsSpellLearned() and A.BarbedShot:GetSpellChargesFrac() > 1.5 
				or
				A.BarbedShot:GetSpellChargesFrac() > 1.8 
				or 
				A.AspectoftheWild:GetCooldown() < 8 - A.GetGCD() and A.PrimalInstincts:GetAzeriteRank() > 0
				or 
				Unit(unit):TimeToDie() < 9
			)
			then
                return A.BarbedShot:Show(icon)
            end
			
            -- purifying_blast,if=buff.bestial_wrath.down|target.time_to_die<8
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and HeartOfAzeroth and 
			(
			   Unit(player):HasBuffs(A.BestialWrathBuff.ID, true) == 0
			   or
			   Unit(unit):TimeToDie() < 8
			)
			then
                return A.PurifyingBlast:Show(icon)
            end
			
            -- barrage
            if A.Barrage:IsReady(unit) then
                return A.Barrage:Show(icon)
            end
			
            -- cobra_shot,if=(focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost|cooldown.kill_command.remains>1+gcd&cooldown.bestial_wrath.remains_guess>focus.time_to_max|buff.memory_of_lucid_dreams.up)&cooldown.kill_command.remains>1|target.time_to_die<3
            if A.CobraShot:IsReady(unit) and 
			(
			    (
				    Player:Focus() - A.CobraShot:GetSpellPowerCost() + Player:FocusRegen() * (A.KillCommand:GetCooldown() - 1) > A.KillCommand:GetSpellPowerCost() 
					or
					A.KillCommand:GetCooldown() > 1 + A.GetGCD() and A.BestialWrath:GetCooldown() > Player:FocusTimeToMaxPredicted() 
					or
					Unit(player):HasBuffs(A.MemoryofLucidDreams.ID, true)
				)
				and A.KillCommand:GetCooldown() > 1 
				or
				Unit(unit):TimeToDie() < 3
			)
			then
                return A.CobraShot:Show(icon)
            end
			
            -- spitting_cobra
            if A.SpittingCobra:IsReady(unit) then
                return A.SpittingCobra:Show(icon)
            end
			
            -- barbed_shot,if=pet.turtle.buff.frenzy.duration-gcd>full_recharge_time
            if A.BarbedShot:IsReadyByPassCastGCD(unit) and (Unit(pet):HasBuffs(A.FrenzyBuff.ID, true) - A.GetGCD() > A.BarbedShot:GetSpellChargesFullRechargeTime()) then
                return A.BarbedShot:Show(icon)
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
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not GetToggle(2, "PartyUnits")[2]) then 
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

