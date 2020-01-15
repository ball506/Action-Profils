--- ====================== ACTION HEADER ============================ ---
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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DEMONHUNTER_HAVOC] = {
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
    MetamorphosisBuff                      = Action.Create({ Type = "Spell", ID = 162264 }),
    Metamorphosis                          = Action.Create({ Type = "Spell", ID = 191427 }),
    ChaoticTransformation                  = Action.Create({ Type = "Spell", ID = 288754 }),
    Demonic                                = Action.Create({ Type = "Spell", ID = 213410 }),
    EyeBeam                                = Action.Create({ Type = "Spell", ID = 198013 }),
    BladeDance                             = Action.Create({ Type = "Spell", ID = 188499 }),
    Nemesis                                = Action.Create({ Type = "Spell", ID = 206491 }),
    NemesisDebuff                          = Action.Create({ Type = "Spell", ID = 206491 }),
    FelBarrage                             = Action.Create({ Type = "Spell", ID = 258925 }),
    DarkSlash                              = Action.Create({ Type = "Spell", ID = 258860 }),
    Annihilation                           = Action.Create({ Type = "Spell", ID = 201427 }),
    DarkSlashDebuff                        = Action.Create({ Type = "Spell", ID = 258860 }),
    ChaosStrike                            = Action.Create({ Type = "Spell", ID = 162794 }),
    DeathSweep                             = Action.Create({ Type = "Spell", ID = 210152 }),
    RevolvingBlades                        = Action.Create({ Type = "Spell", ID = 279581 }),
    ImmolationAura                         = Action.Create({ Type = "Spell", ID = 258920 }),
    Felblade                               = Action.Create({ Type = "Spell", ID = 232893 }),
    FelRush                                = Action.Create({ Type = "Spell", ID = 195072 }),
    DemonBlades                            = Action.Create({ Type = "Spell", ID = 203555 }),
    DemonsBite                             = Action.Create({ Type = "Spell", ID = 162243 }),
    ThrowGlaive                            = Action.Create({ Type = "Spell", ID = 185123 }),
    VengefulRetreat                        = Action.Create({ Type = "Spell", ID = 198793 }),
    LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295078 }),
    Momentum                               = Action.Create({ Type = "Spell", ID = 206476 }),
    PreparedBuff                           = Action.Create({ Type = "Spell", ID = 203650 }),
    FelMastery                             = Action.Create({ Type = "Spell", ID = 192939 }),
    BlindFury                              = Action.Create({ Type = "Spell", ID = 203550 }),
    FirstBlood                             = Action.Create({ Type = "Spell", ID = 206416 }),
    TrailofRuin                            = Action.Create({ Type = "Spell", ID = 258881 }),
    MomentumBuff                           = Action.Create({ Type = "Spell", ID = 208628 }), 
    FelEruption                            = Action.Create({ Type = "Spell", ID = 211881}),
    Blur                                   = Action.Create({ Type = "Spell", ID = 198589}),
    ConsumeMagic                           = Action.Create({ Type = "Spell", ID = 278326}),
    Darkness                               = Action.Create({ Type = "Spell", ID = 196718}),
    RecklessForceCounter                   = Action.Create({ Type = "Spell", ID = 298409}),
    RecklessForceCounter2                  = Action.Create({ Type = "Spell", ID = 302917}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368}),
    --PickUpFragment                         = Action.Create({ Type = "Spell", ID =  }),
    --EyesofRage                             = Action.Create({ Type = "Spell", ID = 278500 }),
    Imprison                               = Action.Create({ Type = "Spell", ID = 217832}),
    ImprisonAntiFake                       = Action.Create({ Type = "Spell", ID = 217832, Desc = "[2] Kick", Hidden = true, QueueForbidden = true    }),
    Disrupt                                = Action.Create({ Type = "Spell", ID = 183752}),
    DisruptGreen		                   = Action.Create({ Type = "SpellSingleColor", ID = 183752, Color = "GREEN", Desc = "[2] Kick", Hidden = true, QueueForbidden = true }),
    ChaosNova                              = Action.Create({ Type = "Spell", ID = 179057}),
    ChaosNovaGreen						   = Action.Create({ Type = "SpellSingleColor", ID = 179057, Color = "GREEN", Desc = "[1] CC", Hidden = true, QueueForbidden = true }),
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
    -- Potions, 
    BattlePotionofAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionofAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Potions
    PotionofUnbridledFury                 = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),
    PotionofFocusedResolve                = Action.Create({ Type = "Potion", ID = 168506, QueueForbidden = true }),
	AbyssalHealingPotion    			 = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }),	
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
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    PoolResource                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DEMONHUNTER_HAVOC)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_HAVOC], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPoolingForMeta = 0;
local VarWaitingForNemesis = 0;
local VarBladeDance = 0;
local VarPoolingForBladeDance = 0;
local VarPoolingForEyeBeam = 0;
local VarWaitingForMomentum = 0;
local VarWaitingForDarkSlash = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarPoolingForMeta = 0
  VarWaitingForNemesis = 0
  VarBladeDance = 0
  VarPoolingForBladeDance = 0
  VarPoolingForEyeBeam = 0
  VarWaitingForMomentum = 0
  VarWaitingForDarkSlash = 0
end)



local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

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

local function IsInMeleeRange()
  if A.Felblade:GetSpellTimeSinceLastCast() <= A.GetGCD() then
    return true
  elseif A.VengefulRetreat:GetSpellTimeSinceLastCast() < 1.0 then  
    return false
  end
  return A.ChaosStrike:IsInRange(unit)
end

local function IsMetaExtendedByDemonic()
  if not Player:BuffP(A.MetamorphosisBuff) then
    return false;
  elseif(A.EyeBeam:TimeSinceLastCast() < A.MetamorphosisImpact:TimeSinceLastCast()) then
    return true;
  end

  return false;
end

local function MetamorphosisCooldownAdjusted()
  -- TODO: Make this better by sampling the Fury expenses over time instead of approximating
  if A.ConvergenceofFates:IsEquipped() and A.DelusionsOfGrandeur:IsEquipped() then
    return A.Metamorphosis:CooldownRemainsP() * 0.56;
  elseif A.ConvergenceofFates:IsEquipped() then
    return A.Metamorphosis:CooldownRemainsP() * 0.78;
  elseif A.DelusionsOfGrandeur:IsEquipped() then
    return A.Metamorphosis:CooldownRemainsP() * 0.67;
  end
  return A.Metamorphosis:CooldownRemainsP()
end

-- EyeBeam Handler UI --
local function HandleEyeBeam()
    local choice = A.GetToggle(2, "EyeBeamMode")
	--print(choice) 
    local unit = "target"
    -- CDs ON
    if choice[1] then 
	    return A.BurstIsON(unit) or false 
	-- AoE Only
	elseif choice[2] then
	    -- also checks CDs
	    if choice[1] then
		    return (A.BurstIsON(unit) and MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 and A.GetToggle(2, "AoE")) or false
		else
		    return (MultiUnits:GetByRangeInCombat(8, 5, 10) > 2 and A.GetToggle(2, "AoE")) or false
		end
	-- Everytime
	elseif choice[3] then
        return A.EyeBeam:IsReady(unit) or false
	else
	    return false
	end		
end

-- FelRush handler
local function UseMoves()
  return Action.GetToggle(2, "UseMoves") --or S.FelRush:Charges() == 2  
end



-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    Action.IsUnitEnemy(unit) and  
    Unit(unit):GetRange() <= 5 and 
    Unit(unit):IsControlAble("stun", 0) and 
    A.ChaosNovaGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    if     A.ChaosNovaGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        (
            not Action.IsUnitEnemy("mouseover") and 
            not Action.IsUnitEnemy("target") and                     
            (
                (Action.IsInPvP and EnemyTeam():PlayersInRange(1, 5)) or 
                (not Action.IsInPvP and MultiUnits:GetByRange(5, 1) >= 1)
            )
        )
    )
    then 
        return A.ChaosNovaGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if Action.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif Action.IsUnitEnemy("target") then 
        unit = "target"
    end 
    
    if unit then         
        local castLeft, _, _, _, notKickAble = Unit(unit):IsCastingRemains()
        if castLeft > 0 then             
            -- Disrupt
			if not notKickAble and A.DisruptGreen:IsReady(unit, nil, nil, true) and A.DisruptGreen:AbsentImun(unit, Temp.TotalAndPhysKick, true) then
                return A.DisruptGreen:Show(icon)                                                  
            end 
			
            -- Imprison
            if A.ImprisonAntiFake:IsReady(unit, nil, nil, true) and A.ImprisonAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then
                return A.ImprisonAntiFake:Show(icon)                  
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
    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  

    -- Darkness
    local Darkness = A.GetToggle(2, "Darkness")
    if     Darkness >= 0 and A.Darkness:IsReady("player") and 
    (
        (     -- Auto 
            Darkness >= 100 and 
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
            Darkness < 100 and 
            Unit("player"):HealthPercent() <= Darkness
        )
    ) 
    then 
        return A.Darkness
    end
	
    -- Blur
    local Blur = A.GetToggle(2, "Blur")
    if     Blur >= 0 and A.Blur:IsReady("player") and 
    (
        (     -- Auto 
            Blur >= 100 and 
            (
                -- HP lose per sec >= 10
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 10 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.10 or 
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
            Blur < 100 and 
            Unit("player"):HealthPercent() <= Blur
        )
    ) 
    then 
        return A.Blur
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
     
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
	
	
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
	-- Fel Eruption
	if (useCC or useKick) and A.FelEruption:IsSpellLearned() and A.FelEruption:IsReady(unit) and MultiUnits:GetByRangeInCombat(20, 5, 10) < 2 and A.FelEruption:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun") then 
        return A.FelEruption              
    end 
	
    -- Chaos Nova    
    if (useCC or useKick) and A.ChaosNova:IsReady(unit) and MultiUnits:GetByRange(10, 5, 10) > 1 and A.ChaosNova:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) and Unit(unit):IsControlAble("stun") then 
        return A.ChaosNova              
    end 
    
	-- Imprison    
    if (useCC or useKick) and not A.Disrupt:IsReady(unit) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
        return A.Imprison              
    end 
	
	-- Disrupt
    if useKick and A.Disrupt:IsReady(unit) and A.Disrupt:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
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
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"
	local HoABossOnly = A.GetToggle(2, "HoABossOnly")
	-- Eyebeam protection channel
	local CanCast = true
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit("player"):IsCastingRemains()
		-- @return:
		-- [1] Currect Casting Left Time (seconds) (@number)
		-- [2] Current Casting Left Time (percent) (@number)
		-- [3] spellID (@number)
		-- [4] spellName (@string)
		-- [5] notInterruptable (@boolean, false is able to be interrupted)
		-- [6] isChannel (@boolean)
	if percentLeft > 0.01 and spellID == A.EyeBeam.ID and isChannel then 
	    CanCast = false
	else
	    CanCast = true
	end
	
	if not CanCast then
	    return A.PoolResource:Show(icon)
	end
	--print(CanCast)
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Cooldown, DarkSlash, Demonic, Essences, Normal
        
        -- auto_attack
        -- variable,name=blade_dance,value=talent.first_blood.enabled|spell_targets.blade_dance1>=(3-talent.trail_of_ruin.enabled)
        VarBladeDance = A.FirstBlood:IsSpellLearned() or MultiUnits:GetByRange(8, 5, 10) >= (3 - num(A.TrailofRuin:IsSpellLearned()))
        -- variable,name=waiting_for_nemesis,value=!(!talent.nemesis.enabled|cooldown.nemesis.ready|cooldown.nemesis.remains>target.time_to_die|cooldown.nemesis.remains>60)
        VarWaitingForNemesis = not (not A.Nemesis:IsSpellLearned() or A.Nemesis:GetCooldown() == 0 or A.Nemesis:GetCooldown() > Unit(unit):TimeToDie() or A.Nemesis:GetCooldown() > 60)           
        -- variable,name=pooling_for_meta,value=!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30&(!variable.waiting_for_nemesis|cooldown.nemesis.remains<10)            
        VarPoolingForMeta = not A.Demonic:IsSpellLearned() and A.Metamorphosis:GetCooldown() < 6 and Player:Fury() < 90 and (not VarWaitingForNemesis or A.Nemesis:GetCooldown() < 10)            
        -- variable,name=pooling_for_blade_dance,value=variable.blade_dance&(fury<75-talent.first_blood.enabled*20)            
        VarPoolingForBladeDance = VarBladeDance and (Player:Fury() < 75 - num(A.FirstBlood:IsSpellLearned()) * 20)           
        -- variable,name=pooling_for_eye_beam,value=talent.demonic.enabled&!talent.blind_fury.enabled&cooldown.eye_beam.remains<(gcd.max*2)&fury.deficit>20
        VarPoolingForEyeBeam = A.Demonic:IsSpellLearned() and not A.BlindFury:IsSpellLearned() and A.EyeBeam:GetCooldown() < (A.GetGCD() * 2) and Player:Fury() < 100            
        -- variable,name=waiting_for_dark_slash,value=talent.dark_slash.enabled&!variable.pooling_for_blade_dance&!variable.pooling_for_meta&cooldown.dark_slash.up
        VarWaitingForDarkSlash = A.DarkSlash:IsSpellLearned() and not VarPoolingForBladeDance and not VarPoolingForMeta and A.DarkSlash:GetCooldown() == 0          
        -- variable,name=waiting_for_momentum,value=talent.momentum.enabled&!buff.momentum.up
        VarWaitingForMomentum = A.Momentum:IsSpellLearned() and Unit("player"):HasBuffs(A.MomentumBuff.ID, true) == 0
            
		--print(VarBladeDance)

		
		--Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.BattlePotionofAgility:IsReady(unit) and not ShouldStop and Action.GetToggle(1, "Potion") and ((Pull > 0.1 and Pull <= 1) or not Action.GetToggle(1, "DBM")) then
                return A.BattlePotionofAgility:Show(icon)
            end
            -- potion
            if A.PotionofFocusedResolve:IsReady(unit) and not ShouldStop and Action.GetToggle(1, "Potion") and ((Pull > 0.1 and Pull <= 1) or not Action.GetToggle(1, "DBM")) then
                return A.PotionofFocusedResolve:Show(icon)
            end
            -- potion
            if A.PotionofUnbridledFury:IsReady(unit) and not ShouldStop and Action.GetToggle(1, "Potion") and ((Pull > 0.1 and Pull <= 1) or not Action.GetToggle(1, "DBM")) then
                return A.PotionofUnbridledFury:Show(icon)
            end
            -- metamorphosis,if=!azerite.chaotic_transformation.enabled
            if A.Metamorphosis:IsReady("player") and Unit("player"):HasBuffsDown(A.MetamorphosisBuff.ID, true) and (A.ChaoticTransformation:GetAzeriteRank() == 0) 
			and ((Pull > 0.1 and Pull <= 0.2) or not Action.GetToggle(1, "DBM")) 
			then
                return A.Metamorphosis:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) and not ShouldStop then
                return A.AzsharasFontofPower:Show(icon)
            end
        end
		
        --Essences
        local function Essences(unit)
            -- concentrated_flame,if=(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzeroth(unit, true) and CanCast and Action.GetToggle(1, "HeartOfAzeroth") 
			and (
			        (Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:GetSpellChargesFullRechargeTime() < A.GetGCD())
			    ) then
                return A.ConcentratedFlame:Show(icon)
            end
			-- reaping_flames
            if A.ReapingFlames:AutoHeartOfAzeroth(unit, true) and CanCast then
                return A.ReapingFlames:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.metamorphosis.up|target.time_to_die<=10
            if A.BloodoftheEnemy:AutoHeartOfAzeroth(unit, true) and ((HoABossOnly and Unit(unit):IsBoss()) or not HoABossOnly) and CanCast and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) or Unit(unit):TimeToDie() <= 10) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- guardian_of_azeroth,if=(buff.metamorphosis.up&cooldown.metamorphosis.ready)|buff.metamorphosis.remains>25|target.time_to_die<=30
            if A.GuardianofAzeroth:AutoHeartOfAzeroth(unit, true) and ((HoABossOnly and Unit(unit):IsBoss()) or not HoABossOnly) and CanCast and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and ((Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and A.Metamorphosis:GetCooldown() == 0) or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 25 or Unit(unit):TimeToDie() <= 30) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- focused_azerite_beam,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
            if A.FocusedAzeriteBeam:AutoHeartOfAzeroth(unit, true) and ((HoABossOnly and Unit(unit):IsBoss()) or not HoABossOnly) and CanCast and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 ) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast,if=spell_targets.blade_dance1>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzeroth(unit, true) and ((HoABossOnly and Unit(unit):IsBoss()) or not HoABossOnly) and CanCast and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 ) then
                return A.PurifyingBlast:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzeroth(unit, true) and ((HoABossOnly and Unit(unit):IsBoss()) or not HoABossOnly) and CanCast and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzeroth(unit, true) and ((HoABossOnly and Unit(unit):IsBoss()) or not HoABossOnly) and CanCast and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:AutoHeartOfAzeroth(unit, true) and ((HoABossOnly and Unit(unit):IsBoss()) or not HoABossOnly) and CanCast and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
            -- memory_of_lucid_dreams,if=fury<40&buff.metamorphosis.up
            if A.MemoryofLucidDreams:AutoHeartOfAzeroth(unit, true) and ((HoABossOnly and Unit(unit):IsBoss()) or not HoABossOnly) and CanCast and A.BurstIsON(unit) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:Fury() < 40 and Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
        end
        
        --Cooldown
        local function Cooldown(unit)		
		
            -- metamorphosis,if=!(talent.demonic.enabled|variable.pooling_for_meta|variable.waiting_for_nemesis)|target.time_to_die<25
            if A.Metamorphosis:IsReady("player") and (not (A.Demonic:IsSpellLearned()) or Unit(unit):TimeToDie() < 25) then
                return A.Metamorphosis:Show(icon)
            end
            -- metamorphosis,if=talent.demonic.enabled&(!azerite.chaotic_transformation.enabled|(cooldown.eye_beam.remains>20&(!variable.blade_dance|cooldown.blade_dance.remains>gcd.max)))
            if A.Metamorphosis:IsReady("player") and Unit("player"):HasBuffsDown(A.MetamorphosisBuff.ID, true) and (A.Demonic:IsSpellLearned() and (A.ChaoticTransformation:GetAzeriteRank() == 0 or (A.EyeBeam:GetCooldown() > 20 and (not VarBladeDance or A.BladeDance:GetCooldown() > A.GetGCD())))) then
                return A.Metamorphosis:Show(icon)
            end
            -- nemesis,target_if=min:target.time_to_die,if=raid_event.adds.exists&debuff.nemesis.down&(active_enemies>desired_targets|raid_event.adds.in>60)
            if A.Nemesis:IsSpellLearned() and A.Nemesis:IsReady(unit) 
			and (
			       -- Unit("player"):HasBuffs("DamageBuffs") > 0
					--or
					Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 0
			    )z
			then 
                return A.Nemesis:Show(icon) 
            end
            -- potion,if=buff.metamorphosis.remains>25|target.time_to_die<60
            if A.PotionofUnbridledFury:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 25 or Unit(unit):TimeToDie() < 60) then
                return A.PotionofUnbridledFury:Show(icon)
            end
            -- use_item,name=galecallers_boon,if=!talent.fel_barrage.enabled|cooldown.fel_barrage.ready
            if A.GalecallersBoon:IsReady(unit) and (not A.FelBarrage:IsSpellLearned() or A.FelBarrage:GetCooldown() == 0) then
                return A.GalecallersBoon:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=buff.metamorphosis.up&buff.memory_of_lucid_dreams.down&(!variable.blade_dance|!cooldown.blade_dance.ready)
            if A.CyclotronicBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) and (not VarBladeDance or not A.BladeDance:GetCooldown() == 0)) then
                return A.CyclotronicBlast:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|(debuff.conductive_ink_debuff.up|buff.metamorphosis.remains>20)&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit)  
			and (
			    Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true) 
				or 
				    (
				        (
						    (
							    Unit(unit):HealthPercent() < 31 and Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 10 and Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 15 
							)
						    or 
						    (
						        Unit(unit):HealthPercent() < 31 and Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) > 0 and Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 0
						    )
					    )
					)
				) 
			then
                return A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=cooldown.metamorphosis.remains<10|cooldown.metamorphosis.remains>60
            if A.AzsharasFontofPower:IsReady(unit) and (A.Metamorphosis:GetCooldown() < 10 or A.Metamorphosis:GetCooldown() > 60) then
                return A.AzsharasFontofPower:Show(icon)
            end
            -- use_items,if=buff.metamorphosis.up
            -- call_action_list,name=essences
            if Essences(unit) then
                return true
            end

        end
        
        --DarkSlash
        local function DarkSlash(unit)
            -- dark_slash,if=fury>=80&(!variable.blade_dance|!cooldown.blade_dance.ready)
            if A.DarkSlash:IsReady(unit) and (Player:Fury() >= 40 and (not VarBladeDance or not A.BladeDance:GetCooldown() == 0)) then
                return A.DarkSlash:Show(icon)
            end
            -- annihilation,if=debuff.dark_slash.up
            if A.Annihilation:IsReady(unit) and IsInMeleeRange() and (Unit(unit):HasDeBuffs(A.DarkSlashDebuff.ID, true)) then
                return A.Annihilation:Show(icon)
            end
            -- chaos_strike,if=debuff.dark_slash.up
            if A.ChaosStrike:IsReady(unit) and IsInMeleeRange() and (Unit(unit):HasDeBuffs(A.DarkSlashDebuff.ID, true)) then
                return A.ChaosStrike:Show(icon)
            end
        end
        
        --Demonic
        local function Demonic(unit)
            -- death_sweep,if=variable.blade_dance
            if A.DeathSweep:IsReady(unit) and not Unit(unit):IsTotem() and Unit(unit):GetRange() <= 5 and (VarBladeDance) then
                return A.DeathSweep:Show(icon)
            end
            -- eye_beam,if=raid_event.adds.up|raid_event.adds.in>25
            if A.EyeBeam:IsReady(unit) and A.BladeDance:GetCooldown() <= 2 and not Unit(unit):IsTotem() and HandleEyeBeam()  then
                return A.EyeBeam:Show(icon)
            end
            -- fel_barrage,if=((!cooldown.eye_beam.up|buff.metamorphosis.up)&raid_event.adds.in>30)|active_enemies>desired_targets
            if A.FelBarrage:IsReady(unit) and 
			(
			    (
				    (A.EyeBeam:GetCooldown() > 0 or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 0)
				) 
				or 
				MultiUnits:GetByRangeInCombat(40, 5, 10) > 1
			) 
			then
                return A.FelBarrage:Show(icon)
            end
            -- blade_dance,if=variable.blade_dance&!cooldown.metamorphosis.ready&(cooldown.eye_beam.remains>(5-azerite.revolving_blades.rank*3)|(raid_event.adds.in>cooldown&raid_event.adds.in<25))
            if A.BladeDance:IsReady(unit) and not Unit(unit):IsTotem() and Unit(unit):GetRange() <= 5 and (VarBladeDance and A.Metamorphosis:GetCooldown() > 0) then
                return A.BladeDance:Show(icon)
            end
            -- blade_dance,if=variable.blade_dance&!cooldown.metamorphosis.ready&(cooldown.eye_beam.remains>(5-azerite.revolving_blades.rank*3)|(raid_event.adds.in>cooldown&raid_event.adds.in<25))
            if A.BladeDance:IsReady(unit) and not Unit(unit):IsTotem() and Unit(unit):GetRange() <= 5 and (VarBladeDance) then
                return A.BladeDance:Show(icon)
            end
            -- immolation_aura
            if A.ImmolationAura:IsReady(unit) then
                return A.ImmolationAura:Show(icon)
            end
            -- annihilation,if=!variable.pooling_for_blade_dance
            if A.Annihilation:IsReady(unit) and (not VarPoolingForBladeDance or (Player:Fury() > 40)) then
                return A.Annihilation:Show(icon)
            end
            -- felblade,if=fury.deficit>=40
            if A.Felblade:IsReady(unit) and A.Felblade:IsSpellLearned() and (Player:Fury() < 60) then
                return A.Felblade:Show(icon)
            end
            -- chaos_strike,if=!variable.pooling_for_blade_dance&!variable.pooling_for_eye_beam
            if A.ChaosStrike:IsReady(unit) and (Player:Fury() > 40) then
                return A.ChaosStrike:Show(icon)
            end
            -- demons_bite
            if A.DemonsBite:IsReady(unit) and not A.DemonBlades:IsSpellLearned() then
                return A.DemonsBite:Show(icon)
            end			
            -- felblade,if=movement.distance>15|buff.out_of_range.up
            if A.Felblade:IsReady(unit) and A.Felblade:IsSpellLearned() and (Unit(unit):GetRange() > 15) and not A.Momentum:IsSpellLearned() then
                return A.Felblade:Show(icon)
            end
            -- throw_glaive,if=buff.out_of_range.up
            if A.ThrowGlaive:IsReady(unit) and (Unit(unit):GetRange() > 15) and A.ThrowGlaive:GetSpellCharges() > 1 and not A.Momentum:IsSpellLearned() then
                return A.ThrowGlaive:Show(icon)
            end
            -- throw_glaive,if=talent.demon_blades.enabled
            if A.ThrowGlaive:IsReady(unit) and (A.DemonBlades:IsSpellLearned() or A.ThrowGlaive:GetSpellCharges() == 2) then
                return A.ThrowGlaive:Show(icon)
            end
        end
              
        --Normal
        local function Normal(unit)

            -- fel_barrage,if=((!cooldown.eye_beam.up|buff.metamorphosis.up)&raid_event.adds.in>30)|active_enemies>desired_targets
            if A.FelBarrage:IsReady(unit) and 
			(
			    (
				    (A.EyeBeam:GetCooldown() > 0 or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) > 0)
				) 
				or 
				MultiUnits:GetByRangeInCombat(40, 5, 10) > 1
			) 
			then
                return A.FelBarrage:Show(icon)
            end
            -- death_sweep,if=variable.blade_dance
            if A.DeathSweep:IsReady(unit) and not Unit(unit):IsTotem() and Unit(unit):GetRange() <= 5 and (VarBladeDance) then
                return A.DeathSweep:Show(icon)
            end
            -- immolation_aura
            if A.ImmolationAura:IsReady(unit) then
                return A.ImmolationAura:Show(icon)
            end
            -- eye_beam,if=active_enemies>1&(!raid_event.adds.exists|raid_event.adds.up)&!variable.waiting_for_momentum
            if A.EyeBeam:IsReady(unit) and A.BladeDance:GetCooldown() <= 2 and not Unit(unit):IsTotem() and HandleEyeBeam()  then
                return A.EyeBeam:Show(icon)
            end
            -- blade_dance,if=variable.blade_dance
            if A.BladeDance:IsReady(unit) and not Unit(unit):IsTotem() and Unit(unit):GetRange() <= 5 and (VarBladeDance) then
                return A.BladeDance:Show(icon)
            end
            -- felblade,if=fury.deficit>=40
            if A.Felblade:IsReady(unit) and A.Felblade:IsSpellLearned() and Player:Fury() <= 80 then
                return A.Felblade:Show(icon)
            end
            -- eye_beam,if=!talent.blind_fury.enabled&!variable.waiting_for_dark_slash&raid_event.adds.in>cooldown
            if A.EyeBeam:IsReady(unit) and A.BladeDance:GetCooldown() <= 2 and not Unit(unit):IsTotem() and HandleEyeBeam() and (not A.BlindFury:IsSpellLearned() and not VarWaitingForDarkSlash) then
                return A.EyeBeam:Show(icon)
            end
            -- annihilation,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance&!variable.waiting_for_dark_slash
            if A.Annihilation:IsReady(unit) and ((A.DemonBlades:IsSpellLearned()  or Player:Fury() >= 40 or Unit("player"):HasBuffs(A.MetamorphosisBuff.ID, true) < 5) and not VarPoolingForBladeDance and not VarWaitingForDarkSlash) then
                return A.Annihilation:Show(icon)
            end
			-- chaos_strike
            if A.ChaosStrike:IsReady(unit) and (Player:Fury() > 40) then
                return A.ChaosStrike:Show(icon)
            end
            -- eye_beam,if=talent.blind_fury.enabled&raid_event.adds.in>cooldown
            if A.EyeBeam:IsReady(unit) and A.BladeDance:GetCooldown() <= 2 and not Unit(unit):IsTotem() and HandleEyeBeam() and A.BlindFury:IsSpellLearned() then
                return A.EyeBeam:Show(icon)
            end
            -- demons_bite
            if A.DemonsBite:IsReady(unit) and not A.DemonBlades:IsSpellLearned() then
                return A.DemonsBite:Show(icon)
            end
            -- felblade,if=movement.distance>15|buff.out_of_range.up
            if A.Felblade:IsReady(unit) and A.Felblade:IsSpellLearned() and (Unit(unit):GetRange() > 15) and not A.Momentum:IsSpellLearned() then
                return A.Felblade:Show(icon)
            end
            -- throw_glaive,if=buff.out_of_range.up
            if A.ThrowGlaive:IsReady(unit) and (Unit(unit):GetRange() > 15) and A.ThrowGlaive:GetSpellCharges() > 1 and not A.Momentum:IsSpellLearned() then
                return A.ThrowGlaive:Show(icon)
            end
            -- throw_glaive,if=talent.demon_blades.enabled
            if A.ThrowGlaive:IsReady(unit) and (A.DemonBlades:IsSpellLearned() or A.ThrowGlaive:GetSpellCharges() == 2) then
                return A.ThrowGlaive:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
		    -- Interrupt Handler 	 	
   		    local useKick, useCC, useRacial = Action.InterruptIsValid("target", "TargetMouseover")    
            local Trinket1IsAllowed, Trinket2IsAllowed = TR.TrinketIsAllowed()
		
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
			
			-----------------------------
            -- Specials Dungeon behavior
	        local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(unit):IsCastingRemains()
			
			-- Tol Dagor : Deadeye	
            -- Use Blade Dance 100% chance dodge just before end of cast...			
            if A.BladeDance:IsReady(unit) and spellID == 256039 and secondsLeft <= (A.GetCurrentGCD() + A.GetGCD() + A.GetPing()) then
                return A.BladeDance:Show(icon)
            end
			-- Use Death Sweep 100% chance dodge just before end of cast...
            if A.DeathSweep:IsReady(unit) and spellID == 256039 and secondsLeft <= (A.GetCurrentGCD() + A.GetGCD() + A.GetPing()) then
                return A.DeathSweep:Show(icon)
            end		
			
            -- Tol Dagor : Upheaval
			-- Fel Rush
            --if A.FelRush:IsReady("player") and Unit("player"):HasBuffs(257608, true) > 0 and Unit("player"):HasBuffs(257608, true) > 0	then
            --    return A.FelRush:Show(icon)
            --end	
			
			-- Fel Rush & VengefulRetreat special combo
			
			-- VengefulRetreat
            if A.VengefulRetreat:IsReady("player") and A.Momentum:IsSpellLearned() and (A.Felblade:IsReady(unit) or A.Felblade:GetCooldown() < 2 or not A.Felblade:IsSpellLearned())
			and Unit("player"):HasBuffsDown(A.PreparedBuff.ID, true) and Unit("player"):CombatTime() > 3 
			then				
                return A.VengefulRetreat:Show(icon)
            end
			
			-- ThrowGlaive
			--if A.LastPlayerCastID == A.VengefulRetreat.ID and A.ThrowGlaive:IsReadyByPassCastGCD(unit, nil, nil, true) and A.VengefulRetreat:GetCooldown() >= 19 and A.VengefulRetreat:GetCooldown() <= 20 then
			--	return A.ThrowGlaive:Show(icon)
			--end			
			
			-- FelRush
			if (A.LastPlayerCastID == A.VengefulRetreat.ID or (Unit(unit):GetRange() >= 15 and UseMoves())) and A.FelRush:IsReadyByPassCastGCD(unit, nil, nil, true) then
			    return A.FelRush:Show(icon)
			end
			
			-- Felblade
			if (A.LastPlayerCastID == A.FelRush.ID and Unit(unit):GetRange() >= 2 and UseMoves()) and A.Felblade:IsSpellLearned() and A.Felblade:IsReadyByPassCastGCD(unit, nil, nil, true) then
			    return A.Felblade:Show(icon)
			end
			
            -- eye_beam,if=active_enemies>1&(!raid_event.adds.exists|raid_event.adds.up)&!variable.waiting_for_momentum
            if A.EyeBeam:IsReady(unit) and not Unit(unit):IsTotem() and HandleEyeBeam()  then
                return A.EyeBeam:Show(icon)
            end
			
            -- Arcane Torrent dispell or if FuryDeficit >= 30
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and Unit("player"):CombatTime() > 4 and (Action.AuraIsValid(unit, "UseDispel", "Dispel") or Player:Fury() < 80) then
                return A.ArcaneTorrent:Show(icon)
            end	
			
            -- bag_of_tricks
            if A.BagofTricks:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BagofTricks:Show(icon)
            end
			
            -- call_action_list,name=cooldown,if=gcd.remains=0
            if (A.GetCurrentGCD() == 0) and A.BurstIsON(unit) and Cooldown(unit) then
                return true
            end
			
	    	-- Non SIMC Custom Trinket1
	        if A.Trinket1:IsReady(unit) and Trinket1IsAllowed then	    
           	    if A.BurstIsON(unit) then 
      	       	    return A.Trinket1:Show(icon)
   	            end 		
	        end
		
		    -- Non SIMC Custom Trinket2
	        if A.Trinket2:IsReady(unit) and Trinket2IsAllowed then	    
       	        if A.BurstIsON(unit) then 
      	       	    return A.Trinket2:Show(icon)
   	            end 	
	        end
            -- pick_up_fragment,if=fury.deficit>=35&(!azerite.eyes_of_rage.enabled|cooldown.eye_beam.remains>1.4)
            --if A.PickUpFragment:IsReady(unit) and (Player:FuryDeficit() >= 35 and (not bool(A.EyesofRage:GetAzeriteRank()) or A.EyeBeam:GetCooldown() > 1.4)) then
            --    return A.PickUpFragment:Show(icon)
            --end

            -- call_action_list,name=dark_slash,if=talent.dark_slash.enabled&(variable.waiting_for_dark_slash|debuff.dark_slash.up)
            if (A.DarkSlash:IsSpellLearned() and (VarWaitingForDarkSlash or Unit(unit):HasDeBuffs(A.DarkSlashDebuff.ID, true) > 0)) then
			    if DarkSlash(unit) then 
				    return true
                end
            end
            -- run_action_list,name=demonic,if=talent.demonic.enabled
            if (A.Demonic:IsSpellLearned()) and Demonic(unit) then
                return true 
            end
            -- run_action_list,name=normal
            if Normal(unit) then
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
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:Getunit("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 

local function ArenaRotation(icon, unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "PvP")   
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" then 
			-- Disrupt
   		    if useKick and A.Disrupt:IsReady(unit) and A.Disrupt:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
      		    return A.Disrupt
   			end 	
            -- Imprison Casting BreakAble CC
            if A.Imprison:IsReady(unit) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.Imprison:Show(icon)
            end 
			-- Purge
		    -- Note: Toggles  ("UseDispel", "UsePurge", "UseExpelEnrage")
            -- Category ("Dispel", "MagicMovement", "PurgeFriendly", "PurgeHigh", "PurgeLow", "Enrage")
            if A.ConsumeMagic:IsReady(unit) and Action.AuraIsValid(unit, "UsePurge", "PurgeHigh") then
                return A.ConsumeMagic:Show(icon)
            end	
        end
    end 
end 
--[[local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
    end
end]]-- 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    --local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    --local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end

