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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_MAGE_ARCANE] = {
    ArcaneIntellectBuff                    = Action.Create({Type = "Spell", ID = 1459 }),
    ArcaneIntellect                        = Action.Create({Type = "Spell", ID = 1459 }),
    ArcaneFamiliarBuff                     = Action.Create({Type = "Spell", ID = 210126 }),
    ArcaneFamiliar                         = Action.Create({Type = "Spell", ID = 205022 }),
    Equipoise                              = Action.Create({Type = "Spell", ID = 286027 }),
    MirrorImage                            = Action.Create({Type = "Spell", ID = 55342 }),
    ArcaneBlast                            = Action.Create({Type = "Spell", ID = 30451 }),
    Evocation                              = Action.Create({Type = "Spell", ID = 12051 }),
    ChargedUp                              = Action.Create({Type = "Spell", ID = 205032 }),
    ArcaneChargeBuff                       = Action.Create({Type = "Spell", ID = 36032 }),
    NetherTempest                          = Action.Create({Type = "Spell", ID = 114923 }),
    NetherTempestDebuff                    = Action.Create({Type = "Spell", ID = 114923 }),
    RuneofPowerBuff                        = Action.Create({Type = "Spell", ID = 116014 }),
    ArcanePowerBuff                        = Action.Create({Type = "Spell", ID = 12042 }),
    RuleofThreesBuff                       = Action.Create({Type = "Spell", ID = 264774 }),
    Overpowered                            = Action.Create({Type = "Spell", ID = 155147 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    RuneofPower                            = Action.Create({Type = "Spell", ID = 116011 }),
    ArcanePower                            = Action.Create({Type = "Spell", ID = 12042 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    PresenceofMind                         = Action.Create({Type = "Spell", ID = 205025 }),
    PresenceofMindBuff                     = Action.Create({Type = "Spell", ID = 205025 }),
    BerserkingBuff                         = Action.Create({Type = "Spell", ID = 26297 }),
    BloodFuryBuff                          = Action.Create({Type = "Spell", ID = 20572 }),
    ArcaneOrb                              = Action.Create({Type = "Spell", ID = 153626 }),
    Resonance                              = Action.Create({Type = "Spell", ID = 205028 }),
    ArcaneBarrage                          = Action.Create({Type = "Spell", ID = 44425 }),
    ArcaneExplosion                        = Action.Create({Type = "Spell", ID = 1449 }),
    ArcaneMissiles                         = Action.Create({Type = "Spell", ID = 5143 }),
    ClearcastingBuff                       = Action.Create({Type = "Spell", ID = 263725 }),
    Amplification                          = Action.Create({Type = "Spell", ID = 236628 }),
    ArcanePummeling                        = Action.Create({Type = "Spell", ID = 270669 }),
    Supernova                              = Action.Create({Type = "Spell", ID = 157980 }),
    BlinkAny                               = Action.Create({Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_MAGE_ARCANE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_ARCANE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarConserveMana = 0;
local VarTotalBurns = 0;
local VarAverageBurnLength = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarConserveMana = 0
  VarTotalBurns = 0
  VarAverageBurnLength = 0
	end 
end)

local EnemyRanges = {40, 10}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end


local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- PRE APL SETUP -------------
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

------------------------------------------
--------------- DEFENSIVES ---------------
------------------------------------------
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
 --[[   local UnendingResolve = A.GetToggle(2, "UnendingResolve")
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
    end ]]--
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

------------------------------------------
--------------- INTERRUPTS ---------------
------------------------------------------
local function Interrupts(unit)
    local useKick, useCC, useRacial = A.InterruptIsValid(unit, "TargetMouseover")    
    
  --  if useKick and A.PetKick:IsReady(unit) and A.PetKick:AbsentImun(unit, Temp.TotalAndMagKick, true) and Unit(unit):CanInterrupt(true, nil, 25, 70) then 
  --      return A.PetKick
  --  end 
    
  --  if useCC and A.Shadowfury:IsReady(unit) and MultiUnits:GetActiveEnemies() >= 2 and A.Shadowfury:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("stun", 0) then 
  --      return A.Shadowfury              
  --  end          
	
	--if useCC and A.Fear:IsReady(unit) and A.Fear:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(unit):IsControlAble("disorient", 0) then 
    --    return A.Fear              
    --end
    
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

------------------------------------------
---------------- AntiFake ----------------
------------------------------------------

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
        --    if not notKickAble and A.PetKick:IsReady(unit, nil, nil, true) and A.PetKick:AbsentImun(unit, Temp.TotalAndMag, true) then
        --        return A.PetKick:Show(icon)                                                  
        --    end 
            
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

Player.ArcaneBurnPhase = {}
local BurnPhase = Player.ArcaneBurnPhase

function BurnPhase:Reset()
  self.state = false
  self.last_start = HL.GetTime()
  self.last_stop = HL.GetTime()
end
BurnPhase:Reset()

function BurnPhase:Start()
  if Player:AffectingCombat() then
    self.state = true
    self.last_start = HL.GetTime()
  end
end

function BurnPhase:Stop()
  self.state = false
  self.last_stop = HL.GetTime()
end

function BurnPhase:On()
  return self.state or (not Player:AffectingCombat() and Player:IsCasting() and ((A.ArcanePower:CooldownRemainsP() == 0 and A.Evocation:CooldownRemainsP() <= VarAverageBurnLength and (Player:ArcaneChargesP() == Player:ArcaneChargesMax() or (A.ChargedUp:IsSpellLearned() and A.ChargedUp:CooldownRemainsP() == 0)))))
end

function BurnPhase:Duration()
  return self.state and (HL.GetTime() - self.last_start) or 0
end

HL:RegisterForEvent(function()
  BurnPhase:Reset()
end, "PLAYER_REGEN_DISABLED")

local function PresenceOfMindMax ()
  return 2
end

local function ArcaneMissilesProcMax ()
  return 3
end

function Player:ArcaneChargesP()
  return math.min(self:ArcaneCharges() + num(self:IsCasting(A.ArcaneBlast)),4)
end

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

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Burn, Conserve, Movement
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- arcane_intellect
            if A.ArcaneIntellect:IsReady(unit) and Unit("player"):HasBuffsDown(A.ArcaneIntellectBuff.ID, true, true) then
                return A.ArcaneIntellect:Show(icon)
            end
            -- arcane_familiar
            if A.ArcaneFamiliar:IsReady(unit) and Unit("player"):HasBuffsDown(A.ArcaneFamiliarBuff.ID, true) then
                return A.ArcaneFamiliar:Show(icon)
            end
            -- variable,name=conserve_mana,op=set,value=60+20*azerite.equipoise.enabled
            if (true) then
                VarConserveMana = 60 + 20 * A.Equipoise:GetAzeriteRank()
            end
            -- snapshot_stats
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- arcane_blast
            if A.ArcaneBlast:IsReady(unit) then
                return A.ArcaneBlast:Show(icon)
            end
        end
        
        --Burn
        local function Burn(unit)
            -- variable,name=total_burns,op=add,value=1,if=!burn_phase
            if (not BurnPhase:On()) then
                VarTotalBurns = VarTotalBurns + 1
            end
            -- start_burn_phase,if=!burn_phase
            if (not BurnPhase:On()) then
                BurnPhase:Start
            end
            -- stop_burn_phase,if=burn_phase&prev_gcd.1.evocation&target.time_to_die>variable.average_burn_length&burn_phase_duration>0
            if (BurnPhase:On() and Unit("player"):GetSpellLastCast(A.Evocation) and Unit(unit):TimeToDie() > VarAverageBurnLength and BurnPhase:Duration() > 0) then
                BurnPhase:Stop
            end
            -- charged_up,if=buff.arcane_charge.stack<=1
            if A.ChargedUp:IsReady(unit) and (Unit("player"):ArcaneChargesP <= 1) then
                return A.ChargedUp:Show(icon)
            end
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
            -- nether_tempest,if=(refreshable|!ticking)&buff.arcane_charge.stack=buff.arcane_charge.max_stack&buff.rune_of_power.down&buff.arcane_power.down
            if A.NetherTempest:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.NetherTempestDebuff.ID, true) or not Unit(unit):HasDeBuffs(A.NetherTempestDebuff.ID, true)) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and bool(Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true))) then
                return A.NetherTempest:Show(icon)
            end
            -- arcane_blast,if=buff.rule_of_threes.up&talent.overpowered.enabled&active_enemies<3
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RuleofThreesBuff.ID, true) and A.Overpowered:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.ArcaneBlast:Show(icon)
            end
            -- lights_judgment,if=buff.arcane_power.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true))) then
                return A.LightsJudgment:Show(icon)
            end
            -- rune_of_power,if=!buff.arcane_power.up&(mana.pct>=50|cooldown.arcane_power.remains=0)&(buff.arcane_charge.stack=buff.arcane_charge.max_stack)
            if A.RuneofPower:IsReady(unit) and (not Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) and (Unit("player"):ManaPercentageP() >= 50 or A.ArcanePower:GetCooldown() == 0) and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax)) then
                return A.RuneofPower:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- arcane_power
            if A.ArcanePower:IsReady(unit) and A.BurstIsON(unit) then
                return A.ArcanePower:Show(icon)
            end
            -- use_items,if=buff.arcane_power.up|target.time_to_die<cooldown.arcane_power.remains
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            -- presence_of_mind,if=(talent.rune_of_power.enabled&buff.rune_of_power.remains<=buff.presence_of_mind.max_stack*action.arcane_blast.execute_time)|buff.arcane_power.remains<=buff.presence_of_mind.max_stack*action.arcane_blast.execute_time
            if A.PresenceofMind:IsReady(unit) and A.BurstIsON(unit) and ((A.RuneofPower:IsSpellLearned() and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) <= PresenceOfMindMax * A.ArcaneBlast:GetSpellCastTime()) or Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) <= PresenceOfMindMax * A.ArcaneBlast:GetSpellCastTime()) then
                return A.PresenceofMind:Show(icon)
            end
            -- potion,if=buff.arcane_power.up&(buff.berserking.up|buff.blood_fury.up|!(race.troll|race.orc))
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.ArcanePowerBuff.ID, true) and (Unit("player"):HasBuffs(A.BerserkingBuff.ID, true) or Unit("player"):HasBuffs(A.BloodFuryBuff.ID, true) or not (Unit("player"):IsRace("Troll") or Unit("player"):IsRace("Orc")))) then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- arcane_orb,if=buff.arcane_charge.stack=0|(active_enemies<3|(active_enemies<2&talent.resonance.enabled))
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP == 0 or (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 or (MultiUnits:GetByRangeInCombat(40, 5, 10) < 2 and A.Resonance:IsSpellLearned()))) then
                return A.ArcaneOrb:Show(icon)
            end
            -- arcane_barrage,if=active_enemies>=3&(buff.arcane_charge.stack=buff.arcane_charge.max_stack)
            if A.ArcaneBarrage:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax)) then
                return A.ArcaneBarrage:Show(icon)
            end
            -- arcane_explosion,if=active_enemies>=3
            if A.ArcaneExplosion:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3) then
                return A.ArcaneExplosion:Show(icon)
            end
            -- arcane_missiles,if=buff.clearcasting.react&active_enemies<3&(talent.amplification.enabled|(!talent.overpowered.enabled&azerite.arcane_pummeling.rank>=2)|buff.arcane_power.down),chain=1
            if A.ArcaneMissiles:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true)) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3 and (A.Amplification:IsSpellLearned() or (not A.Overpowered:IsSpellLearned() and A.ArcanePummeling:GetAzeriteRank() >= 2) or bool(Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true)))) then
                return A.ArcaneMissiles:Show(icon)
            end
            -- arcane_blast,if=active_enemies<3
            if A.ArcaneBlast:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.ArcaneBlast:Show(icon)
            end
            -- variable,name=average_burn_length,op=set,value=(variable.average_burn_length*variable.total_burns-variable.average_burn_length+(burn_phase_duration))%variable.total_burns
            if (true) then
                VarAverageBurnLength = (VarAverageBurnLength * VarTotalBurns - VarAverageBurnLength + (BurnPhase:Duration())) / VarTotalBurns
            end
            -- evocation,interrupt_if=mana.pct>=85,interrupt_immediate=1
            if A.Evocation:IsReady(unit) then
                return A.Evocation:Show(icon)
            end
            -- arcane_barrage
            if A.ArcaneBarrage:IsReady(unit) then
                return A.ArcaneBarrage:Show(icon)
            end
        end
        
        --Conserve
        local function Conserve(unit)
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
            -- charged_up,if=buff.arcane_charge.stack=0
            if A.ChargedUp:IsReady(unit) and (Unit("player"):ArcaneChargesP == 0) then
                return A.ChargedUp:Show(icon)
            end
            -- nether_tempest,if=(refreshable|!ticking)&buff.arcane_charge.stack=buff.arcane_charge.max_stack&buff.rune_of_power.down&buff.arcane_power.down
            if A.NetherTempest:IsReady(unit) and ((Unit(unit):HasDeBuffsRefreshable(A.NetherTempestDebuff.ID, true) or not Unit(unit):HasDeBuffs(A.NetherTempestDebuff.ID, true)) and Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and bool(Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.ArcanePowerBuff.ID, true))) then
                return A.NetherTempest:Show(icon)
            end
            -- arcane_orb,if=buff.arcane_charge.stack<=2&(cooldown.arcane_power.remains>10|active_enemies<=2)
            if A.ArcaneOrb:IsReady(unit) and (Unit("player"):ArcaneChargesP <= 2 and (A.ArcanePower:GetCooldown() > 10 or MultiUnits:GetByRangeInCombat(40, 5, 10) <= 2)) then
                return A.ArcaneOrb:Show(icon)
            end
            -- arcane_blast,if=buff.rule_of_threes.up&buff.arcane_charge.stack>3
            if A.ArcaneBlast:IsReady(unit) and (Unit("player"):HasBuffs(A.RuleofThreesBuff.ID, true) and Unit("player"):ArcaneChargesP > 3) then
                return A.ArcaneBlast:Show(icon)
            end
            -- use_item,name=tidestorm_codex,if=buff.rune_of_power.down&!buff.arcane_power.react&cooldown.arcane_power.remains>20
            if A.TidestormCodex:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) and not bool(Unit("player"):HasBuffsStacks(A.ArcanePowerBuff.ID, true)) and A.ArcanePower:GetCooldown() > 20) then
                A.TidestormCodex:Show(icon)
            end
            -- rune_of_power,if=buff.arcane_charge.stack=buff.arcane_charge.max_stack&(full_recharge_time<=execute_time|full_recharge_time<=cooldown.arcane_power.remains|target.time_to_die<=cooldown.arcane_power.remains)
            if A.RuneofPower:IsReady(unit) and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax and (A.RuneofPower:FullRechargeTimeP() <= A.RuneofPower:GetSpellCastTime() or A.RuneofPower:FullRechargeTimeP() <= A.ArcanePower:GetCooldown() or Unit(unit):TimeToDie() <= A.ArcanePower:GetCooldown())) then
                return A.RuneofPower:Show(icon)
            end
            -- arcane_missiles,if=mana.pct<=95&buff.clearcasting.react&active_enemies<3,chain=1
            if A.ArcaneMissiles:IsReady(unit) and (Unit("player"):ManaPercentageP() <= 95 and bool(Unit("player"):HasBuffsStacks(A.ClearcastingBuff.ID, true)) and MultiUnits:GetByRangeInCombat(40, 5, 10) < 3) then
                return A.ArcaneMissiles:Show(icon)
            end
            -- arcane_barrage,if=((buff.arcane_charge.stack=buff.arcane_charge.max_stack)&((mana.pct<=variable.conserve_mana)|(talent.rune_of_power.enabled&cooldown.arcane_power.remains>cooldown.rune_of_power.full_recharge_time&mana.pct<=variable.conserve_mana+25))|(talent.arcane_orb.enabled&cooldown.arcane_orb.remains<=gcd&cooldown.arcane_power.remains>10))|mana.pct<=(variable.conserve_mana-10)
            if A.ArcaneBarrage:IsReady(unit) and (((Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax) and ((Unit("player"):ManaPercentageP() <= VarConserveMana) or (A.RuneofPower:IsSpellLearned() and A.ArcanePower:GetCooldown() > A.RuneofPower:FullRechargeTimeP() and Unit("player"):ManaPercentageP() <= VarConserveMana + 25)) or (A.ArcaneOrb:IsSpellLearned() and A.ArcaneOrb:GetCooldown() <= A.GetGCD() and A.ArcanePower:GetCooldown() > 10)) or Unit("player"):ManaPercentageP() <= (VarConserveMana - 10)) then
                return A.ArcaneBarrage:Show(icon)
            end
            -- supernova,if=mana.pct<=95
            if A.Supernova:IsReady(unit) and (Unit("player"):ManaPercentageP() <= 95) then
                return A.Supernova:Show(icon)
            end
            -- arcane_explosion,if=active_enemies>=3&(mana.pct>=variable.conserve_mana|buff.arcane_charge.stack=3)
            if A.ArcaneExplosion:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 3 and (Unit("player"):ManaPercentageP() >= VarConserveMana or Unit("player"):ArcaneChargesP == 3)) then
                return A.ArcaneExplosion:Show(icon)
            end
            -- arcane_blast
            if A.ArcaneBlast:IsReady(unit) then
                return A.ArcaneBlast:Show(icon)
            end
            -- arcane_barrage
            if A.ArcaneBarrage:IsReady(unit) then
                return A.ArcaneBarrage:Show(icon)
            end
        end
        
        --Movement
        local function Movement(unit)
            -- blink_any,if=movement.distance>=10
            if A.BlinkAny:IsReady(unit) and (Unit(unit):GetRange() >= 10) then
                return A.BlinkAny:Show(icon)
            end
            -- presence_of_mind
            if A.PresenceofMind:IsReady(unit) and A.BurstIsON(unit) then
                return A.PresenceofMind:Show(icon)
            end
            -- arcane_missiles
            if A.ArcaneMissiles:IsReady(unit) then
                return A.ArcaneMissiles:Show(icon)
            end
            -- arcane_orb
            if A.ArcaneOrb:IsReady(unit) then
                return A.ArcaneOrb:Show(icon)
            end
            -- supernova
            if A.Supernova:IsReady(unit) then
                return A.Supernova:Show(icon)
            end
        end
        
-- call precombat
if not Player:AffectingCombat() and not Player:IsCasting() then
  local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- counterspell,if=target.debuff.casting.react
            -- call_action_list,name=burn,if=burn_phase|target.time_to_die<variable.average_burn_length
            if A.BurstIsON(unit) and (BurnPhase:On() or Unit(unit):TimeToDie() < VarAverageBurnLength) then
                local ShouldReturn = Burn(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=burn,if=(cooldown.arcane_power.remains=0&cooldown.evocation.remains<=variable.average_burn_length&(buff.arcane_charge.stack=buff.arcane_charge.max_stack|(talent.charged_up.enabled&cooldown.charged_up.remains=0&buff.arcane_charge.stack<=1)))
            if A.BurstIsON(unit) and ((A.ArcanePower:GetCooldown() == 0 and A.Evocation:GetCooldown() <= VarAverageBurnLength and (Unit("player"):ArcaneChargesP == Unit("player"):ArcaneChargesMax or (A.ChargedUp:IsSpellLearned() and A.ChargedUp:GetCooldown() == 0 and Unit("player"):ArcaneChargesP <= 1)))) then
                local ShouldReturn = Burn(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=conserve,if=!burn_phase
            if (not BurnPhase:On()) then
                local ShouldReturn = Conserve(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=movement
            if (true) then
                local ShouldReturn = Movement(unit); if ShouldReturn then return ShouldReturn; end
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

