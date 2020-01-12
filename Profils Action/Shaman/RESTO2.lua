local TMW                                     = TMW 

local Action                                 = Action
local Listener                                 = Action.Listener
local Create                                 = Action.Create
local GetSpellInfo                            = Action.GetSpellInfo
local GetToggle                                = Action.GetToggle
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local ShouldStop                            = Action.ShouldStop
local AuraIsValid                            = Action.AuraIsValid
local InterruptIsValid                        = Action.InterruptIsValid
local BurstIsON                                = Action.BurstIsON
local BossMods_Pulling                        = Action.BossMods_Pulling

local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local IsUnitEnemy                            = Action.IsUnitEnemy 
local IsUnitFriendly                        = Action.IsUnitFriendly 

local TeamCacheFriendly                        = TeamCache.Friendly
local HealingEngineMembersALL                = HealingEngine.GetMembersAll() -- function call!
local HealingEngineGetMinimumUnits            = HealingEngine.GetMinimumUnits
local HealingEngineGetIncomingDMGAVG        = HealingEngine.GetIncomingDMGAVG
local HealingEngineGetIncomingHPSAVG        = HealingEngine.GetIncomingHPSAVG

local _G, setmetatable, select, math        = _G, setmetatable, select, math 
local ACTION_CONST_STOPCAST                    = _G.ACTION_CONST_STOPCAST
local ACTION_CONST_SPELLID_FREEZING_TRAP    = _G.ACTION_CONST_SPELLID_FREEZING_TRAP
local huge                                     = math.huge


-- Spells
Action[ACTION_CONST_SHAMAN_RESTORATION] = {
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
    -- Main Spells
    Riptide                                = Action.Create({ Type = "Spell", ID = 61295   }),
	HealingSurge                           = Action.Create({ Type = "Spell", ID = 8004   }),
	HealingWave                            = Action.Create({ Type = "Spell", ID = 77472   }),	
	ChainHeal                              = Action.Create({ Type = "Spell", ID = 1064   }),
	HealingRain                            = Action.Create({ Type = "Spell", ID = 73920   }),
	HealingStreamTotem                     = Action.Create({ Type = "Spell", ID = 5394   }),
	TidalWaveBuff                          = Action.Create({ Type = "Spell", ID = 53390   }),
	-- Offensive Abilities
	FlameShock                             = Action.Create({ Type = "Spell", ID = 188838   }),
	FlameShockDebuff                       = Action.Create({ Type = "Spell", ID = 188389   }),
	LavaBurst                              = Action.Create({ Type = "Spell", ID = 51505   }),
	LightningBolt                          = Action.Create({ Type = "Spell", ID = 403   }),
	ChainLightning                         = Action.Create({ Type = "Spell", ID = 421   }),
	-- Cooldowns
	HealingTideTotem                       = Action.Create({ Type = "Spell", ID = 108280   }),
	SpiritLinkTotem                        = Action.Create({ Type = "Spell", ID = 98008   }),
	SpiritWalkersGrace                     = Action.Create({ Type = "Spell", ID = 79206   }),
	-- Defensives
	AstralShift                            = Action.Create({ Type = "Spell", ID = 108271   }),
	-- Utilities
	AncestralSpirit                        = Action.Create({ Type = "Spell", ID = 2008   }),
	AncestralVision                        = Action.Create({ Type = "Spell", ID = 212048   }),
	AstralRecall                           = Action.Create({ Type = "Spell", ID = 556   }),
	EarthbindTotem                         = Action.Create({ Type = "Spell", ID = 2484   }),
	FarSight                               = Action.Create({ Type = "Spell", ID = 6196   }),
	GhostWolf                              = Action.Create({ Type = "Spell", ID = 2645   }),
	Bloodlust                              = Action.Create({ Type = "Spell", ID = 2825   }),
	Heroism                                = Action.Create({ Type = "Spell", ID = 32182   }),
	Hex                                    = Action.Create({ Type = "Spell", ID = 51514   }),
    HexGreen                               = Action.Create({ Type = "SpellSingleColor", ID = 51514, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
	Purge                                  = Action.Create({ Type = "Spell", ID = 370   }),
	PurifySpirit                           = Action.Create({ Type = "Spell", ID = 77130   }),
	WaterWalking                           = Action.Create({ Type = "Spell", ID = 546   }),
	AncestralGift                          = Action.Create({ Type = "Spell", ID = 290254, Hidden = true}), -- PvP Talent - Silence and interrupt immune
	WindShear                              = Action.Create({ Type = "Spell", ID = 57994   }),
    WindShearAntiFake                      = Action.Create({ Type = "Spell", ID = 57994, Desc = "[2] Kick", QueueForbidden = true    }),
	TremorTotem                            = Action.Create({ Type = "Spell", ID = 8143   }),
	EarthElemental                         = Action.Create({ Type = "Spell", ID = 198103   }),
	CapacitorTotem                         = Action.Create({ Type = "Spell", ID = 192058   }),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, QueueForbidden = true }), 
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
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
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
Action:CreateEssencesFor(ACTION_CONST_SHAMAN_RESTORATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_RESTORATION], { __index = Action })


local player                                = "player"
local Temp                                  = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = 
GetTotemInfo, IsMouseButtonDown, UnitIsUnit

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    IsUnitEnemy(unit) and 
    Unit(unit):IsControlAble("incapacitate", 0) and 
    A.HexGreen:AbsentImun(unit, Temp.TotalAndPhysAndCC, true)          
end 
A[1] = function(icon)    
    if     A.HexGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun("mouseover") or 
        AntiFakeStun("target") or 
        AntiFakeStun("targettarget") or 
        (
            not IsUnitEnemy("mouseover") and 
            not IsUnitEnemy("target") and             
            not IsUnitEnemy("targettarget") 
        )
    )
    then 
        return A.HexGreen:Show(icon)         
    end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unit
    if IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif IsUnitEnemy("target") then 
        unit = "target"
    elseif IsUnitEnemy("targettarget") then 
        unit = "targettarget"
    end 
    
    if unit then         
        local total, sleft, _, _, _, notKickAble = Unit(unit):CastTime()
        if sleft > 0 then                                     
            if A.WindShearAntiFake:IsReady(unit) and A.WindShearAntiFake:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then
                return A.WindShearAntiFake:Show(icon)                  
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

local function IsEnoughHPS(unit)
    return Unit(player):GetHPS() > Unit(unit):GetDMG()
end 

local function IsSaveManaPhase()
    if not A.IsInPvP and GetToggle(2, "ManaManagement") and Unit(player):HasBuffs(A.Innervate.ID) == 0 then 
        local bossID
        for i = 1, MAX_BOSS_FRAMES do 
            bossID = "boss" .. i
            if Unit(bossID):IsExists() and not Unit(bossID):IsDead() and Unit(player):PowerPercent() < Unit(bossID):HealthPercent() then 
                return true 
            end 
        end 
    end 
    return Unit(player):PowerPercent() < 20 
end 
IsSaveManaPhase = A.MakeFunctionCachedStatic(IsSaveManaPhase)

local function HealingRainDuration()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 136037 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end
HealingRainDuration = A.MakeFunctionCachedStatic(HealingRainDuration)

-- Cached parts 
-- PvP: Balance Solar Interrupt 
UnitCooldown:Register("arena", 78675, 60) 
-- PvP: Mage Counterspell
UnitCooldown:Register("arena", 2139, 24)
-- SpiritWalkersGrace with AncestralGift talent to give player silence and interrupt immunities
local function CanSpiritWalkersGrace(mode)
    if A.IsInPvP and A.SpiritWalkersGrace:IsReady("player") and Unit(player):HasBuffs(A.SpiritWalkersGrace.ID, true) == 0 and A.AncestralGift:IsSpellLearned() then 
        -- If melee is around (doesn't tracking their kick but anyway)
        if not mode and EnemyTeam("DAMAGER_MELEE"):GetUnitID(15) ~= "none" then 
            return true 
        end 
        
        -- Catch Balance Interrupt if enemy in burst or while rooted
        if UnitCooldown:GetCooldown("arena", 78675) == 0 then 
            local UnitBalance = EnemyTeam("DAMAGER_RANGE"):GetUnitID(40, 102)         
            if UnitBalance ~= "none" and Unit(UnitBalance):InCC() == 0 and Unit(player):HasBuffs("Reflect") == 0 then
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
            if UnitMage ~= "none" and Unit(UnitMage):InCC() == 0 and Unit(player):HasBuffs("Reflect") == 0 then
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
CanSpiritWalkersGrace = A.MakeFunctionCachedDynamic(CanSpiritWalkersGrace)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    if CanSpiritWalkersGrace("CATCH") then 
        return A.SpiritWalkersGrace
    end 
    
    -- EarthShieldHP
    local EarthShield = A.GetToggle(2, "EarthShieldHP")
    if     EarthShield >= 0 and A.EarthShield:IsReady("player") and  
    (
        (     -- Auto 
            EarthShield >= 100 and 
            (
                Unit("player"):HasBuffsStacks(A.EarthShield.ID, true) <= 3 
                or A.IsInPvP and Unit("player"):HasBuffsStacks(A.EarthShield.ID, true) <= 2
            ) 
        ) or 
        (    -- Custom
            EarthShield < 100 and 
            Unit("player"):HasBuffs(A.EarthShield.ID, true) <= 5 and 
            Unit("player"):HealthPercent() <= EarthShield
        )
    ) 
    then 
        return A.EarthShield
    end
    
    -- HealingSurgeHP
    local HealingSurge = A.GetToggle(2, "HealingSurgeHP")
    if     HealingSurge >= 0 and A.HealingSurge:IsReady("player") and 
    (
        (     -- Auto 
            HealingSurge >= 100 and 
            (
                -- HP lose per sec >= 40
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 40 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.40 or 
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
            HealingSurge < 100 and 
            Unit("player"):HealthPercent() <= HealingSurge
        )
    ) 
    then 
        return A.HealingSurge
    end
    
    -- Abyssal Healing Potion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady("player") and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 25
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 25 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.25 or 
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
    
    -- AstralShift
    local AstralShift = A.GetToggle(2, "AstralShiftHP")
    if     AstralShift >= 0 and A.AstralShift:IsReady("player") and 
    (
        (     -- Auto 
            AstralShift >= 100 and 
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
            AstralShift < 100 and 
            Unit("player"):HealthPercent() <= AstralShift
        )
    ) 
    then 
        return A.AstralShift
    end   
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 

local function Interrupts(unit)
    local useKick, useCC, useRacial = InterruptIsValid(unit, "TargetMouseover")
    
    if useKick and A.WindShear:IsReady(unit) and A.WindShear:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then 
        return A.WindShear              
    end   
	
    if useCC and A.Hex:IsReady(unit) and A.Hex:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        return A.Hex              
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

local function CanHealingTideTotem()
    if A.HealingTideTotem:IsReady("player", true, nil, nil) and IsSchoolFree() then 
        local HealingTideTotemHP = GetToggle(2, "HealingTideTotemHP")
        local HealingTideTotemUnits = GetToggle(2, "HealingTideTotemUnits") 
        
        -- Auto Counter
        if HealingTideTotemUnits > 40 then 
            HealingTideTotemUnits = HealingEngineGetMinimumUnits(1)
            -- Reduce size in raid by 20%
            if HealingTideTotemUnits > 5 then 
                HealingTideTotemUnits = HealingTideTotemUnits - (#HealingEngineMembersALL * 0.2)
            end 
            -- If user typed counter higher than max available members 
        elseif HealingTideTotemUnits >= TeamCacheFriendly.Size then 
            HealingTideTotemUnits = TeamCacheFriendly.Size
        end 
        
        if HealingTideTotemUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #HealingEngineMembersALL do 
            -- Auto HP 
            if HealingTideTotemHP >= 100 and A.HealingTideTotem:PredictHeal("HealingTideTotem", HealingEngineMembersALL[i].Unit, 400) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if HealingTideTotemHP < 100 and HealingEngineMembersALL[i].HP <= HealingTideTotemHP then 
                counter = counter + 1
            end 
            
            if counter >= HealingTideTotemUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanHealingTideTotem = A.MakeFunctionCachedStatic(CanHealingTideTotem)

local function CanHealingStreamTotem()
    if A.HealingStreamTotem:IsReady(unit, true, nil, nil) and IsSchoolFree() then 
        local HealingStreamTotemHP = GetToggle(2, "HealingStreamTotemHP")
        local HealingStreamTotemUnits = GetToggle(2, "HealingStreamTotemUnits") 
        
        -- Auto Counter
        if HealingStreamTotemUnits > 40 then 
            HealingStreamTotemUnits = HealingEngineGetMinimumUnits(1)
            -- Reduce size in raid by 35%
            if HealingStreamTotemUnits > 5 then 
                HealingStreamTotemUnits = HealingStreamTotemUnits - (#HealingEngineMembersALL * 0.35)
            end 
            -- If user typed counter higher than max available members 
        elseif HealingStreamTotemUnits >= TeamCacheFriendly.Size then 
            HealingStreamTotemUnits = TeamCacheFriendly.Size
        end 
        
        if HealingStreamTotemUnits < 3 and not A.IsInPvP then 
            return false 
        end 
        
        local counter = 0 
        for i = 1, #HealingEngineMembersALL do 
            -- Auto HP 
            if HealingStreamTotemHP >= 100 and A.HealingStreamTotem:PredictHeal("HealingStreamTotem", HealingEngineMembersALL[i].Unit, 1500) then 
                counter = counter + 1
            end 
            
            -- Custom HP 
            if HealingStreamTotemHP < 100 and HealingEngineMembersALL[i].HP <= HealingStreamTotemHP then 
                counter = counter + 1
            end 
            
            if counter >= HealingStreamTotemUnits then 
                return true 
            end 
        end 
    end 
    return false 
end 
CanHealingStreamTotem = A.MakeFunctionCachedStatic(CanHealingStreamTotem)


local StopCast = false 

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    
    local unit                     = player
    local isMoving                 = Player:IsMoving()
    local isSoothingMistCasting = Unit(unit):IsCastingRemains(A.SoothingMist.ID) > 0
    local inMelee                 = false
    
    local function DamageRotation(unit)
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- Interrupts
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end         
                
        -- PvP CrownControl (Enemy Healer)
        if A.IsInPvP then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(40)
            
            if EnemyHealerUnitID ~= "none" and A.Hex:IsReady(EnemyHealerUnitID, true, nil, nil) and A.Hex:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("incapacitate", 0) and Unit(EnemyHealerUnitID):InCC() <= GetCurrentGCD() then
                return A.Hex:Show(icon)     
            end 
        end 
        
        -- Bursting 
        if BurstIsON(unit) and A.AbsentImun(nil, unit, Temp.TotalAndPhys) then 
            
            if Unit(unit):HealthPercent() <= GetToggle(2, "RacialBurstDamaging") then 
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
            end 
        end
        
        -- Trinkets 
        if inMelee and A.AbsentImun(nil, unit, Temp.TotalAndPhys) and Unit(unit):HealthPercent() <= GetToggle(2, "TrinketBurstDamaging") then 
            if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end     
        end     
        
        -- Damage Rotation 
		
        if A.LavaBurst:IsReady(unit) and A.LavaBurst:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):HasDeBuffs(A.FlameShock.ID, true) > 0 and Unit("player"):HasBuffs(A.LavaSurge.ID, true) > 0 then 
            return A.LavaBurst:Show(icon)
        end 
 
        if A.FlameShock:IsReady(unit) and A.FlameShock:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):HasDeBuffs(A.FlameShock.ID, true) == 0 then 
            return A.FlameShock:Show(icon)
        end 

        if A.LightningBolt:IsReady(unit) and A.LightningBolt:AbsentImun(unit, Temp.TotalAndMag) and Unit(unit):HasDeBuffs(A.FlameShock.ID, true) > 0 then 
            return A.LightningBolt:Show(icon)
        end 
        
        -- Azerite Essence 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if     (isMulti or GetToggle(2, "AoE")) and A.RippleinSpace:AutoHeartOfAzerothP(unit) and A.RippleinSpace:AbsentImun(unit, Temp.TotalAndMag) and MultiUnits:GetByRange(25, 3) >= 3 and 
        (
            not A.IsInPvP or 
            not EnemyTeam("HEALER"):IsBreakAble(25)    
        ) 
        then 
            return A.RippleinSpace:Show(icon)
        end 
                    
    end 
    
    local function HealingRotation(unit)
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unit) then 
            return A.ArcaneTorrent:Show(icon)
        end     
        
        -- Out of combat / Precombat
        if Unit(player):CombatTime() == 0 then 
		    -- Rez
            if A.AncestralSpirit:IsReady(unit, true, nil, nil) and Unit(unit):InGroup() and Unit(unit):IsDead() and Unit(unit):IsPlayer() and Unit(unit):GetRange() <= 100 and not isMoving and IsSchoolFree() then 
                return A.AncestralSpirit:Show(icon)
            end 
            -- Mass rez
            if A.AncestralVision:IsReady(unit) and Unit(unit):IsDead() and Unit(unit):IsPlayer() and not isMoving and IsSchoolFree() then 
                return A.AncestralVision:Show(icon)
            end 
            
            if A.SummonJadeSerpentStatue:IsReady(unit, true, nil, nil) and JadeSerpentStatue.GetRange() > 40 and Player:IsStayingTime() > 2.5 and IsSchoolFree() then 
                return A.SummonJadeSerpentStatue:Show(icon)
            end 
            
            local Pull = BossMods_Pulling()  
            if Pull > 0 then 
                -- Timing
                local extra_time = GetCurrentGCD() + 0.1
                local RenewingMist, EnvelopingMist, ChiBurst, TigersLust
                if A.RenewingMist:IsReady(unit, nil, nil, true) and A.RenewingMist:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.RenewingMist.ID, true) == 0 then 
                    RenewingMist = true 
                    extra_time = extra_time + GetGCD()
                end 
                
                if A.EnvelopingMist:IsReady(unit, nil, nil, true) and A.EnvelopingMist:AbsentImun(unit) and not isMoving and IsSchoolFree() then 
                    EnvelopingMist = true 
                    extra_time = extra_time + Unit(player):CastTime(A.EnvelopingMist.ID)
                end 
                
                if (isMulti or GetToggle(2, "AoE")) and A.ChiBurst:IsReady(unit, true, nil, true) and not isMoving and IsSchoolFree() then 
                    ChiBurst = true 
                    extra_time = extra_time + Unit(player):CastTime(A.ChiBurst.ID)
                end 
                
                if A.TigersLust:IsReady(unit, true, nil, true) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() then
                    TigersLust = true
                    extra_time = extra_time + GetGCD()
                end 
                
                -- Pull Rotation
                if RenewingMist and Pull <= extra_time then 
                    if A.ThunderFocusTea:IsReady(unit, true, nil, true) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                        return A.ThunderFocusTea:Show(icon)
                    end 
                    if not ShouldStop() then 
                        return A.RenewingMist:Show(icon)
                    end 
                end 
                
                if EnvelopingMist and not ShouldStop() and Pull <= extra_time then 
                    return A.EnvelopingMist:Show(icon)
                end 
                
                if ChiBurst and not ShouldStop() and Pull <= extra_time then 
                    return A.ChiBurst:Show(icon)
                end 
                
                if TigersLust and not ShouldStop() and Pull <= extra_time then 
                    return A.TigersLust:Show(icon)
                end 
                
                return 
            end 
            
            if A.HealingSphere:IsReady(unit, true, nil, true) and IsSchoolFree() and (not GetToggle(2, "MouseButtonsCheck") or (not IsMouseButtonDown("LeftButton") and not IsMouseButtonDown("RightButton"))) then 
                return A.HealingSphere:Show(icon)
            end 
        end 
        
        -- Interrupts (@targettarget)
        if unit == "target" and IsUnitEnemy("targettarget") then 
            local Interrupt = Interrupts("targettarget")
            if Interrupt then 
                return Interrupt:Show(icon)
            end 
        end    
        
        -- Bursting 
        if BurstIsON(unit) then 
            -- Multi (for [4])
            if isMulti then 
                if CanRevival(isSoothingMistCasting) then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit) and not IsEnoughHPS(unit) and Unit(player):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Revival:Show(icon)
                end 
                
                if CanInvokeChiJitheRedCrane(isSoothingMistCasting) then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit) and not IsEnoughHPS(unit) and Unit(player):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.InvokeChiJitheRedCrane:Show(icon)
                end 
                
                -- Azerite Essence
                if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit) then 
                    return A.LifeBindersInvocation:Show(icon)
                end             
            end 
            
            -- Single 
            if A.LifeCocoon:IsReady(unit) and A.LifeCocoon:AbsentImun(unit) and IsSchoolFree() then 
                local LifeCocoon = GetToggle(2, "LifeCocoon")
                
                -- Auto 
                if     LifeCocoon >= 100 and not IsEnoughHPS(unit) and Unit(unit):HasBuffs("DeffBuffs") == 0 and (
                    (Unit(unit):TimeToDieX(20) < 3 and Unit(unit):HealthPercent() < 60) or 
                    (A.IsInPvP and Unit(unit):HealthPercent() < 80 and (Unit(unit):HasDeBuffs("DamageDeBuffs") > 5 or Unit(unit):IsExecuted()))
                ) 
                then 
                    return A.LifeCocoon:Show(icon)
                end 
                
                -- Custom 
                if LifeCocoon < 100 and Unit(unit):HealthPercent() <= LifeCocoon then 
                    return A.LifeCocoon:Show(icon)
                end 
            end                         
            
            -- Azerite Essence
            if A.Standstill:AutoHeartOfAzeroth(unit) then 
                return A.Standstill:Show(icon)
            end 
            
            -- Racial 
            local RacialBurstHealing = GetToggle(2, "RacialBurstHealing")            
            if  Unit(unit):InRange() and A.AbsentImun(nil, unit) and 
            (
                -- Auto
                (RacialBurstHealing >= 100 and not IsEnoughHPS(unit) and (Unit(unit):TimeToDieX(45) < 5 or (A.IsInPvP and Unit(unit):UseBurst()))) or 
                -- Custom            
                (RacialBurstHealing < 100 and Unit(unit):HealthPercent() <= RacialBurstHealing)
            )
            then 
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
            end 
            
            -- AoE
            if not isMulti and GetToggle(2, "AoE") then 
                if CanRevival(isSoothingMistCasting) then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit) and not IsEnoughHPS(unit) and Unit(player):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.Revival:Show(icon)
                end 
                
                if CanInvokeChiJitheRedCrane(isSoothingMistCasting) then 
                    if A.OverchargeMana:AutoHeartOfAzerothP(unit) and not IsEnoughHPS(unit) and Unit(player):PowerPercent() > 20 then 
                        return A.OverchargeMana:Show(icon)
                    end 
                    
                    return A.InvokeChiJitheRedCrane:Show(icon)
                end 
                
                -- Azerite Essence
                if A.LifeBindersInvocation:AutoHeartOfAzeroth(unit) then 
                    return A.LifeBindersInvocation:Show(icon)
                end                                 
            end 
        end 
        
        -- PvP CrownControl (@targettarget)
        if unit == "target" and IsUnitEnemy("targettarget") and A.GrappleWeaponIsReady("targettarget", false, isSoothingMistCasting) then 
            return A.GrappleWeapon:Show(icon)
        end 
        
        -- PvP CrownControl (Enemy Healer)
        if A.IsInPvP and A.LegSweep:IsReady(nil, nil, nil, isSoothingMistCasting) then 
            local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(5 + (A.TigerTailSweep:IsSpellLearned() and 2 or 0))
            
            if EnemyHealerUnitID ~= "none" and A.LegSweep:AbsentImun(EnemyHealerUnitID, Temp.TotalAndPhysAndCCAndStun, true) and Unit(EnemyHealerUnitID):IsControlAble("stun", 0) and Unit(EnemyHealerUnitID):InCC() <= GetCurrentGCD() then
                return A.LegSweep:Show(icon)     
            end 
        end 
        
        -- Racial 
        if A.GiftofNaaru:AutoRacial(unit) and Unit(unit):HealthPercent() <= GetToggle(2, "RacialBurstHealing") then 
            return A.GiftofNaaru:Show(icon)
        end 
        
        -- Trinkets         
        if A.AbsentImun(nil, unit) and Unit(unit):HealthPercent() <= GetToggle(2, "TrinketBurstHealing") and Unit(unit):InRange() then 
            if A.Trinket1:IsReady(unit) and A.Trinket1:GetItemCategory() ~= "DPS" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit) and A.Trinket2:GetItemCategory() ~= "DPS" then 
                return A.Trinket2:Show(icon)
            end     
        end     
        
        -- Rotation         
        if A.Detox:IsReady(unit) and A.Detox:AbsentImun(unit) and IsSchoolFree() and AuraIsValid(unit, "UseDispel", "Dispel") and Unit(unit):TimeToDie() > 5 then 
            return A.Detox:Show(icon)
        end 
        
        if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() and Unit(unit):TimeToDie() > 6 then 
            if Unit(unit):HasDeBuffs("Rooted") > 1.5 then 
                return A.TigersLust:Show(icon)
            end 
            
            local cUnitSpeed = Unit(unit):GetCurrentSpeed()
            if cUnitSpeed > 0 and cUnitSpeed < 64 and (UnitIsUnit(unit, player) or Unit(unit):IsMelee()) then 
                return A.TigersLust:Show(icon)
            end 
        end 
        
        if A.Detox:IsReady(unit) and A.Detox:AbsentImun(unit) and IsSchoolFree() and AuraIsValid(unit, "UseDispel", "MagicMovement") and Unit(unit):TimeToDie() > 12 then 
            return A.Detox:Show(icon)
        end 
        
        if (isMulti or GetToggle(2, "AoE")) then 
            if A.VitalityConduit:AutoHeartOfAzeroth(unit) then 
                return A.VitalityConduit:Show(icon)
            end
            
            if CanEssenceFont(isSoothingMistCasting) then 
                if CanZenFocusTea(nil, isSoothingMistCasting) then 
                    return A.ZenFocusTea:Show(icon)
                end 
                
                if A.OverchargeMana:AutoHeartOfAzerothP(unit) and (not IsEnoughHPS(unit) or HealingEngineGetIncomingDMGAVG() > HealingEngineGetIncomingHPSAVG() + 10) then 
                    return A.OverchargeMana:Show(icon)
                end 
                
                return A.EssenceFont:Show(icon)
            end 
        end 
        
        -- Multi (for [4])
        if isMulti then 
            if CanRefreshingJadeWind(isSoothingMistCasting) then
                return A.RefreshingJadeWind:Show(icon)
            end 
            if CanChiWave(isSoothingMistCasting) then 
                return A.ChiWave:Show(icon)
            end 
            if CanChiBurst(isSoothingMistCasting) then 
                return A.ChiBurst:Show(icon)
            end 
        end
        
        -- Super Emergency 
        local Emergency = Unit(unit):TimeToDieX(25) < 4 and Unit(unit):HealthPercent() <= 60
        if not isSoothingMistCasting and Emergency and A.SoothingMist:IsReady(unit) and Unit(unit):DeBuffCyclone() == 0 and IsSchoolFree() and Unit(unit):HealthPercent() <= GetToggle(2, "SoothingMistHP") then 
            if A.SummonJadeSerpentStatue:IsReady(unit, true, nil, true) and JadeSerpentStatue.GetRange() > 40 and Unit(unit):TimeToDie() > 3 then 
                return A.SummonJadeSerpentStatue:Show(icon)
            end     
            if not isMoving then
                if CanZenFocusTea(nil, isSoothingMistCasting) then 
                    return A.ZenFocusTea:Show(icon)
                end 
                return A.SoothingMist:Show(icon)
            end
        end 
        
        if isSoothingMistCasting and not isMoving and Emergency and A.EnvelopingMist:IsReady(unit) and A.EnvelopingMist:AbsentImun(unit) and IsSchoolFree() and Unit(player):IsCastingRemains(A.EnvelopingMist.ID) == 0 and Unit(unit):HasBuffs(A.EnvelopingMist.ID, true) == 0 and A.EnvelopingMist:PredictHeal("EnvelopingMist", unit) then 
            if A.ThunderFocusTea:IsReady(unit, true, nil, nil) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end             
            return A.EnvelopingMist:Show(icon)
        end 
        
        if isSoothingMistCasting and not isMoving and Emergency and A.SurgingMist:IsReady(unit) and A.SurgingMist:AbsentImun(unit) and IsSchoolFree() and A.SurgingMist:PredictHeal("SurgingMist", unit) then 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end             
            return A.SurgingMist:Show(icon)
        end 
        
        if isSoothingMistCasting and not isMoving and Emergency and A.Vivify:IsReady(unit) and A.Vivify:AbsentImun(unit) and IsSchoolFree() and A.Vivify:PredictHeal("Vivify", unit) then 
            if IsSaveManaPhase() and A.ThunderFocusTea:IsReady(unit, true, nil, nil) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end 
            return A.Vivify:Show(icon)
        end     
        
        -- Continue Rotation         
        if A.RenewingMist:IsReady(unit) and A.RenewingMist:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.RenewingMist.ID, true) <= GetCurrentGCD() and (isMulti or A.RenewingMist:PredictHeal("RenewingMist", unit)) then 
            if A.ThunderFocusTea:IsReady(unit, true, nil, nil) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end     
            
            return A.RenewingMist:Show(icon)
        end                 
        
        if not isMulti and GetToggle(2, "AoE") then 
            if CanRefreshingJadeWind(isSoothingMistCasting) then
                return A.RefreshingJadeWind:Show(icon)
            end 
            if CanChiWave(isSoothingMistCasting) then 
                return A.ChiWave:Show(icon)
            end 
            if CanChiBurst(isSoothingMistCasting) then 
                return A.ChiBurst:Show(icon)
            end 
        end             
        
        -- Fistweaving Rotation (@targettarget)
        if unit == "target" and IsUnitEnemy("targettarget") then
            inMelee = A.TigerPalm:IsInRange("targettarget")
            
            if not isMulti and A.RisingMist:IsSpellLearned() and A.RenewingMist:IsReady(unit) and A.RenewingMist:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.RenewingMist.ID, true) <= GetCurrentGCD() then 
                if A.ThunderFocusTea:IsReady(player, true, nil, isSoothingMistCasting) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                    return A.ThunderFocusTea:Show(icon)
                end     
                
                return A.RenewingMist:Show(icon)
            end             
            
            if A.RisingMist:IsSpellLearned() and A.RisingSunKick:IsReady("targettarget", nil, nil, isSoothingMistCasting) and A.RisingSunKick:AbsentImun("targettarget", Temp.TotalAndPhys) then 
                if A.ThunderFocusTea:IsReady(player, true, nil, isSoothingMistCasting) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                    return A.ThunderFocusTea:Show(icon)
                end 
                return A.RisingSunKick:Show(icon)
            end               
            
            if A.SpiritoftheCrane:IsSpellLearned() and A.BlackoutKick:IsReady("targettarget", nil, nil, isSoothingMistCasting) and A.BlackoutKick:AbsentImun("targettarget", Temp.TotalAndPhys) and Unit(player):HasBuffsStacks(A.TeachingsoftheMonastery.ID, true) >= 3 then 
                return A.BlackoutKick:Show(icon)
            end 
            
            if A.SpiritoftheCrane:IsSpellLearned() and A.TigerPalm:IsReady("targettarget", nil, nil, isSoothingMistCasting) and A.TigerPalm:AbsentImun("targettarget", Temp.TotalAndPhys) and Unit(player):HasBuffsStacks(A.TeachingsoftheMonastery.ID, true) < 3 then 
                return A.TigerPalm:Show(icon)
            end             
        end 
        
        if Unit(player):CombatTime() > 0 and A.ManaTea:IsReady(player, true, nil, isSoothingMistCasting) and IsSchoolFree() and Unit(player):HasBuffs(A.Innervate.ID) == 0 and (HealingEngine.GetTimeToFullHealth() > 12 or HealingEngineGetIncomingDMGAVG() > 30) then 
            return A.ManaTea:Show(icon)
        end 
        
        -- Azerite Essences 
        if Unit(player):CombatTime() > 0 and A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit) and Unit(player):PowerPercent() < 85 and (not A.ManaTea:IsSpellLearned() or Unit(player):HasBuffs(A.ManaTea.ID, true) == 0) then 
            return A.MemoryofLucidDreams:Show(icon)
        end         
        
        if Unit(player):CombatTime() > 0 and A.WorldveinResonance:AutoHeartOfAzeroth(unit) and Player:IsStayingTime() > 2 then 
            return A.WorldveinResonance:Show(icon)
        end        
        
        -- Misc 
        local Mana = GetToggle(2, "ManaPotion") 
        if Unit(player):CombatTime() > 0 and Mana > 0 and Unit(player):PowerPercent() <= Mana then 
            if A.PotionofReconstitution:IsReady(player, true, nil, isSoothingMistCasting) and not isMoving and Player:IsStayingTime() > 1.5 then 
                if A.MemoryofLucidDreams:AutoHeartOfAzerothP(player, isSoothingMistCasting) then 
                    return A.MemoryofLucidDreams:Show(icon)
                end 
                
                return A.PotionofReconstitution:Show(icon)                
            end 
            
            if A.CoastalManaPotion:IsReady(player, true, nil, isSoothingMistCasting) then 
                return A.CoastalManaPotion:Show(icon)
            end 
        end 
        
        -- Azerite Essences 
        if A.ConcentratedFlame:AutoHeartOfAzeroth(unit) then 
            return A.ConcentratedFlame:Show(icon)
        end 
        
        if A.Refreshment:AutoHeartOfAzeroth(unit) then 
            return A.Refreshment:Show(icon)
        end 
        
        -- Normal Rotation 
        local SoothingMistHP = GetToggle(2, "SoothingMistHP")
        if     not isSoothingMistCasting and A.SoothingMist:IsReady(unit) and Unit(unit):DeBuffCyclone() == 0 and IsSchoolFree() and 
        ( 
            (
                SoothingMistHP < 100 and 
                Unit(unit):HealthPercent() <= SoothingMistHP  
            ) or 
            (
                SoothingMistHP >= 100 and 
                A.Vivify:PredictHeal("Vivify", unit, 200)
            )
        )
        then
            local SoothingMistWorkMode = GetToggle(2, "SoothingMistWorkMode")
            if     SoothingMistWorkMode == "Always" or 
            (
                (SoothingMistWorkMode == "Auto" or SoothingMistWorkMode == "Tanking Units") and 
                (Unit(unit):IsTank() or Unit(unit):IsTanking("targettarget"))
            ) or 
            (
                (SoothingMistWorkMode == "Auto" or SoothingMistWorkMode == "Mostly Inc. Damage") and 
                HealingEngine.IsMostlyIncDMG(unit)
            ) or 
            (
                (SoothingMistWorkMode == "Auto" or SoothingMistWorkMode == "HPS < Inc. Damage") and 
                not IsEnoughHPS(unit)
            )
            then 
                if A.SummonJadeSerpentStatue:IsReady() and JadeSerpentStatue.GetRange() > 40 then 
                    return A.SummonJadeSerpentStatue:Show(icon)
                end     
                
                if not isMoving then
                    if CanZenFocusTea(nil, isSoothingMistCasting) then 
                        return A.ZenFocusTea:Show(icon)
                    end 
                    
                    return A.SoothingMist:Show(icon)
                end 
            end
        end 
        
        if not isMoving and A.EnvelopingMist:IsReady(unit) and A.EnvelopingMist:AbsentImun(unit) and IsSchoolFree() and Unit(player):IsCastingRemains(A.EnvelopingMist.ID) == 0 and Unit(unit):HasBuffs(A.EnvelopingMist.ID, true) == 0 and A.EnvelopingMist:PredictHeal("EnvelopingMist", unit, 300) then 
            if A.ThunderFocusTea:IsReady(unit, true, nil, nil) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end             
            return A.EnvelopingMist:Show(icon)
        end 
        
        if not isMoving and A.SurgingMist:IsReady(unit) and A.SurgingMist:AbsentImun(unit) and IsSchoolFree() and A.SurgingMist:PredictHeal("SurgingMist", unit) then 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end             
            return A.SurgingMist:Show(icon)
        end 
        
        if not isMoving and A.Vivify:IsReady(unit) and A.Vivify:AbsentImun(unit) and IsSchoolFree() and A.Vivify:PredictHeal("Vivify", unit) then 
            if IsSaveManaPhase() and A.ThunderFocusTea:IsReady(unit, true, nil, nil) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            if CanZenFocusTea(nil, isSoothingMistCasting) then 
                return A.ZenFocusTea:Show(icon)
            end 
            return A.Vivify:Show(icon)
        end                 
        
        -- Damage Rotation 
        if unit == "target" and IsUnitEnemy("targettarget") then 
            local CanMakeDamage = DamageRotation("targettarget")
            if CanMakeDamage then 
                return true 
            end 
        end 
        
        -- Totally nothing to do 
        if not isMulti and A.RenewingMist:IsReady(unit) and A.RenewingMist:AbsentImun(unit) and IsSchoolFree() and Unit(unit):HasBuffs(A.RenewingMist.ID, true) <= GetCurrentGCD() then 
            if Unit(player):CombatTime() > 0 and A.ThunderFocusTea:IsReady(unit, true, nil, nil) and Unit(player):HasBuffs(A.ThunderFocusTea.ID, true) == 0 then
                return A.ThunderFocusTea:Show(icon)
            end 
            return A.RenewingMist:Show(icon)            
        end         
    end 
    
    -- Defensive
    local SelfDefensive = SelfDefensives(isSoothingMistCasting)
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Mouseover 
    if IsUnitEnemy("mouseover") then 
        unit = "mouseover"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    if IsUnitFriendly("mouseover") then 
        unit = "mouseover"    
        
        if HealingRotation(unit) then 
            return true 
        end             
    end 
    
    -- Target / TargetTarget     
    if IsUnitEnemy("target") then 
        unit = "target"
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    if IsUnitFriendly("target") then 
        unit = "target"
        
        if HealingRotation(unit) then 
            return true 
        end 
    end 
    
    -- Misc 
    if A.IsInPvP and A.HealingSphere:IsReady() and IsSchoolFree() and (not GetToggle(2, "MouseButtonsCheck") or (not IsMouseButtonDown("LeftButton") and not IsMouseButtonDown("RightButton"))) then 
        return A.HealingSphere:Show(icon)
    end     
    
    if A.Zone == "arena" and Unit(player):CombatTime() == 0 and not Player:IsMounted() and A.SpinningCraneKick:IsReady() and (isMulti or GetToggle(2, "AoE")) and EnemyTeam():HasInvisibleUnits() and not EnemyTeam("HEALER"):IsBreakAble(8) then 
        return A.SpinningCraneKick:Show(icon)         
    end 
    
    -- Movement
    -- If not moving or moving lower than 2.5 sec 
    if Player:IsMovingTime() < 2.5 then 
        return 
    end 
    
    if not A.ChiTorpedo:IsSpellLearned() and A.Roll:IsReady() and (unit == player or not Unit(unit):IsExists()) and IsIndoors() and Unit(player):CombatTime() == 0 then 
        return A.Roll:Show(icon)
    end 
    
    if A.ChiTorpedo:IsReady() and (unit == player or not Unit(unit):IsExists()) and IsIndoors() and Unit(player):CombatTime() == 0 then 
        return A.ChiTorpedo:Show(icon)
    end     
end 

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end 

-- [5] Trinket Rotation
-- No specialization trinket actions 
A[5] = nil 

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
        local isSoothingMistCasting = Unit(player):IsCastingRemains(A.SoothingMist.ID) > 0
        
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("playr"):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then                 
            -- PvP Pet Taunt        
            if A.Provoke:IsReady(nil, nil, nil, isSoothingMistCasting) and EnemyTeam():IsTauntPetAble(A.Provoke) then 
                -- Freezing Trap 
                if FreezingTrapUsedByEnemy() then 
                    return A.Provoke
                end 
                
                -- Casting BreakAble CC
                if EnemyTeam():IsCastingBreakAble(0.5) then 
                    return A.Provoke 
                end 
                
                -- Try avoid something totally random at opener (like sap / blind)
                if Unit(player):CombatTime() <= 5 and (Unit(player):CombatTime() > 0 or Unit("target"):CombatTime() > 0 or MultiUnits:GetByRangeInCombat(nil, 1) >= 1) then 
                    return A.Provoke 
                end             
            end 
            
            -- if Provoke used then don't overleap attempts to control avoid 
            if Unit(player):GetSpellLastCast(A.Provoke.ID) > 2 then                              
                -- PvP Roll 
                if not A.ChiTorpedo:IsSpellLearned() and A.Roll:IsReady(nil, nil, nil, isSoothingMistCasting) and FreezingTrapUsedByEnemy() then 
                    return A.Roll
                end 
                
                -- PvP ChiTorpedo 
                if A.ChiTorpedo:IsReady(nil, nil, nil, isSoothingMistCasting) and FreezingTrapUsedByEnemy() then 
                    return A.ChiTorpedo
                end 
            end 
        end 
        
        -- PvP Disarm 
        if A.GrappleWeaponIsReady(unit, false, isSoothingMistCasting) and not Unit(unit):InLOS() then
            return A.GrappleWeapon
        end         
    end 
end 

local function PartyRotation(unit)
    local isSoothingMistCasting = Unit(player):IsCastingRemains(A.SoothingMist.ID) > 0
    
    -- Tiger Lust
    if A.TigersLust:IsReady(unit) and A.TigersLust:AbsentImun(unit) and IsSchoolFree() and not Unit(player, 5):HasFlags() and (Unit(unit):IsMelee() or Unit(unit):IsFocused(nil, true) or Unit(unit):HasBuffs("DamageBuffs") > 0) and not Unit(unit):InLOS() then 
        if Unit(unit):HasDeBuffs("Rooted") > GetGCD() then 
            return A.TigersLust
        end 
        
        local cMoving = Unit(unit):GetCurrentSpeed()
        if cMoving > 0 and cMoving < 64 then -- 64 because unit can moving backward 
            return A.TigersLust
        end 
    end 
    
    -- Detox 
    if A.Detox:IsReady(unit) and A.Detox:AbsentImun(unit) and IsSchoolFree() and AuraIsValid(unit, "UseDispel", "Dispel") and not Unit(unit):InLOS() then                         
        return A.Detox
    end     
end 

A[6] = function(icon)    
    if StopCast and Unit(player):IsCastingRemains(A.SoothingMist.ID) > 0 then 
        return A:Show(icon, ACTION_CONST_STOPCAST)
    end 
    
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

