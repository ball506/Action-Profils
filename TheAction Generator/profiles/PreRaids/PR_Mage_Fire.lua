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
Action[ACTION_CONST_MAGE_FIRE] = {
    ArcaneIntellectBuff                    = Action.Create({Type = "Spell", ID = 1459 }),
    ArcaneIntellect                        = Action.Create({Type = "Spell", ID = 1459 }),
    MirrorImage                            = Action.Create({Type = "Spell", ID = 55342 }),
    Pyroblast                              = Action.Create({Type = "Spell", ID = 11366 }),
    LivingBomb                             = Action.Create({Type = "Spell", ID = 44457 }),
    CombustionBuff                         = Action.Create({Type = "Spell", ID = 190319 }),
    Combustion                             = Action.Create({Type = "Spell", ID = 190319 }),
    Meteor                                 = Action.Create({Type = "Spell", ID = 153561 }),
    RuneofPowerBuff                        = Action.Create({Type = "Spell", ID = 116014 }),
    RuneofPower                            = Action.Create({Type = "Spell", ID = 116011 }),
    Firestarter                            = Action.Create({Type = "Spell", ID = 205026 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    FireBlast                              = Action.Create({Type = "Spell", ID = 108853 }),
    BlasterMasterBuff                      = Action.Create({Type = "Spell", ID = 274598 }),
    Fireball                               = Action.Create({Type = "Spell", ID = 133 }),
    BlasterMaster                          = Action.Create({Type = "Spell", ID = 274596 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    Scorch                                 = Action.Create({Type = "Spell", ID = 2948 }),
    HeatingUpBuff                          = Action.Create({Type = "Spell", ID = 48107 }),
    HotStreakBuff                          = Action.Create({Type = "Spell", ID = 48108 }),
    PyroclasmBuff                          = Action.Create({Type = "Spell", ID = 269651 }),
    PhoenixFlames                          = Action.Create({Type = "Spell", ID = 257541 }),
    DragonsBreath                          = Action.Create({Type = "Spell", ID = 31661 }),
    FlameOn                                = Action.Create({Type = "Spell", ID = 205029 }),
    Flamestrike                            = Action.Create({Type = "Spell", ID = 2120 }),
    FlamePatch                             = Action.Create({Type = "Spell", ID = 205037 }),
    SearingTouch                           = Action.Create({Type = "Spell", ID = 269644 }),
    AlexstraszasFury                       = Action.Create({Type = "Spell", ID = 235870 }),
    Kindling                               = Action.Create({Type = "Spell", ID = 155148 })
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
Action:CreateEssencesFor(ACTION_CONST_MAGE_FIRE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_FIRE], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarCombustionRopCutoff = 0;
local VarFireBlastPooling = 0;
local VarPhoenixPooling = 0;

A.Listener:Add("ACTION_EVENT_COMBAT_TRACKER", "PLAYER_REGEN_ENABLED", 				function()
  VarCombustionRopCutoff = 0
  VarFireBlastPooling = 0
  VarPhoenixPooling = 0
	end 
end)

local EnemyRanges = {40}
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

A.PhoenixFlames:RegisterInFlight();
A.Pyroblast:RegisterInFlight(A.CombustionBuff);
A.Fireball:RegisterInFlight(A.CombustionBuff);

function A.Firestarter:ActiveStatus()
    return (A.Firestarter:IsSpellLearned() and (Unit(unit):HealthPercent() > 90)) and 1 or 0
end

function A.Firestarter:ActiveRemains()
    return A.Firestarter:IsSpellLearned() and ((Unit(unit):HealthPercent() > 90) and Unit(unit):TimeToDieX(90, 3) or 0)
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
        local Precombat, ActiveTalents, BmCombustionPhase, CombustionPhase, RopPhase, StandardRotation, Trinkets
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- arcane_intellect
            if A.ArcaneIntellect:IsReady(unit) and Unit("player"):HasBuffsDown(A.ArcaneIntellectBuff.ID, true, true) then
                return A.ArcaneIntellect:Show(icon)
            end
            -- variable,name=combustion_rop_cutoff,op=set,value=60
            if (true) then
                VarCombustionRopCutoff = 60
            end
            -- snapshot_stats
            -- mirror_image
            if A.MirrorImage:IsReady(unit) then
                return A.MirrorImage:Show(icon)
            end
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- pyroblast
            if A.Pyroblast:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.Pyroblast:Show(icon)
            end
        end
        
        --ActiveTalents
        local function ActiveTalents(unit)
            -- living_bomb,if=active_enemies>1&buff.combustion.down&(cooldown.combustion.remains>cooldown.living_bomb.duration|cooldown.combustion.ready)
            if A.LivingBomb:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) and (A.Combustion:GetCooldown() > A.LivingBomb:BaseDuration() or A.Combustion:GetCooldown() == 0)) then
                return A.LivingBomb:Show(icon)
            end
            -- meteor,if=buff.rune_of_power.up&(firestarter.remains>cooldown.meteor.duration|!firestarter.active)|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1|(cooldown.meteor.duration<cooldown.combustion.remains|cooldown.combustion.ready)&!talent.rune_of_power.enabled&(cooldown.meteor.duration<firestarter.remains|!talent.firestarter.enabled|!firestarter.active)
            if A.Meteor:IsReady(unit) and (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) and (S.Firestarter:ActiveRemains() > A.Meteor:BaseDuration() or not bool(S.Firestarter:ActiveStatus())) or A.RuneofPower:GetCooldown() > Unit(unit):TimeToDie() and A.RuneofPower:ChargesP() < 1 or (A.Meteor:BaseDuration() < A.Combustion:GetCooldown() or A.Combustion:GetCooldown() == 0) and not A.RuneofPower:IsSpellLearned() and (A.Meteor:BaseDuration() < S.Firestarter:ActiveRemains() or not A.Firestarter:IsSpellLearned() or not bool(S.Firestarter:ActiveStatus()))) then
                return A.Meteor:Show(icon)
            end
        end
        
        --BmCombustionPhase
        local function BmCombustionPhase(unit)
            -- lights_judgment,if=buff.combustion.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true))) then
                return A.LightsJudgment:Show(icon)
            end
            -- living_bomb,if=buff.combustion.down&active_enemies>1
            if A.LivingBomb:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.LivingBomb:Show(icon)
            end
            -- rune_of_power,if=buff.combustion.down
            if A.RuneofPower:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true))) then
                return A.RuneofPower:Show(icon)
            end
            -- fire_blast,use_while_casting=1,if=buff.blaster_master.down&(talent.rune_of_power.enabled&action.rune_of_power.executing&action.rune_of_power.execute_remains<0.6|(cooldown.combustion.ready|buff.combustion.up)&!talent.rune_of_power.enabled&!action.pyroblast.in_flight&!action.fireball.in_flight)
            if A.FireBlast:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BlasterMasterBuff.ID, true)) and (A.RuneofPower:IsSpellLearned() and bool(action.rune_of_power.executing) and action.rune_of_power.execute_remains < 0.6 or (A.Combustion:GetCooldown() == 0 or Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) and not A.RuneofPower:IsSpellLearned() and not A.Pyroblast:IsSpellInFlight() and not A.Fireball:IsSpellInFlight())) then
                return A.FireBlast:Show(icon)
            end
            -- call_action_list,name=active_talents
            if (true) then
                local ShouldReturn = ActiveTalents(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- combustion,use_off_gcd=1,use_while_casting=1,if=azerite.blaster_master.enabled&((action.meteor.in_flight&action.meteor.in_flight_remains<0.2)|!talent.meteor.enabled|prev_gcd.1.meteor)&(buff.rune_of_power.up|!talent.rune_of_power.enabled)
            if A.Combustion:IsReady(unit) and A.BurstIsON(unit) and (bool(A.BlasterMaster:GetAzeriteRank()) and ((A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains < 0.2) or not A.Meteor:IsSpellLearned() or Unit("player"):GetSpellLastCast(A.Meteor)) and (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) or not A.RuneofPower:IsSpellLearned())) then
                return A.Combustion:Show(icon)
            end
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            -- call_action_list,name=trinkets
            if (true) then
                local ShouldReturn = Trinkets(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up
            if A.Pyroblast:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.Scorch) and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            -- pyroblast,if=buff.hot_streak.up
            if A.Pyroblast:IsReady(unit) and (Unit("player"):HasBuffs(A.HotStreakBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.combustion.remains
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true)) and A.Pyroblast:GetSpellCastTime() < Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            -- phoenix_flames
            if A.PhoenixFlames:IsReady(unit) then
                return A.PhoenixFlames:Show(icon)
            end
            -- fire_blast,use_off_gcd=1,if=buff.blaster_master.stack=1&buff.hot_streak.down&!buff.pyroclasm.react&prev_gcd.1.pyroblast&(buff.blaster_master.remains<0.15|gcd.remains<0.15)
            if A.FireBlast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BlasterMasterBuff.ID, true) == 1 and bool(Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true)) and not bool(Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true)) and Unit("player"):GetSpellLastCast(A.Pyroblast) and (Unit("player"):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.15 or A.GetGCD() < 0.15)) then
                return A.FireBlast:Show(icon)
            end
            -- fire_blast,use_while_casting=1,if=buff.blaster_master.stack=1&(action.scorch.executing&action.scorch.execute_remains<0.15|buff.blaster_master.remains<0.15)
            if A.FireBlast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BlasterMasterBuff.ID, true) == 1 and (bool(action.scorch.executing) and action.scorch.execute_remains < 0.15 or Unit("player"):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.15)) then
                return A.FireBlast:Show(icon)
            end
            -- scorch,if=buff.hot_streak.down&(cooldown.fire_blast.remains<cast_time|action.fire_blast.charges>0)
            if A.Scorch:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true)) and (A.FireBlast:GetCooldown() < A.Scorch:GetSpellCastTime() or A.FireBlast:ChargesP() > 0)) then
                return A.Scorch:Show(icon)
            end
            -- fire_blast,use_while_casting=1,use_off_gcd=1,if=buff.blaster_master.stack>1&(prev_gcd.1.scorch&!buff.hot_streak.up&!action.scorch.executing|buff.blaster_master.remains<0.15)
            if A.FireBlast:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BlasterMasterBuff.ID, true) > 1 and (Unit("player"):GetSpellLastCast(A.Scorch) and not Unit("player"):HasBuffs(A.HotStreakBuff.ID, true) and not bool(action.scorch.executing) or Unit("player"):HasBuffs(A.BlasterMasterBuff.ID, true) < 0.15)) then
                return A.FireBlast:Show(icon)
            end
            -- living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1
            if A.LivingBomb:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) < A.GetGCD() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.LivingBomb:Show(icon)
            end
            -- dragons_breath,if=buff.combustion.remains<gcd.max
            if A.DragonsBreath:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) < A.GetGCD()) then
                return A.DragonsBreath:Show(icon)
            end
            -- scorch
            if A.Scorch:IsReady(unit) then
                return A.Scorch:Show(icon)
            end
        end
        
        --CombustionPhase
        local function CombustionPhase(unit)
            -- lights_judgment,if=buff.combustion.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true))) then
                return A.LightsJudgment:Show(icon)
            end
            -- call_action_list,name=bm_combustion_phase,if=azerite.blaster_master.enabled&talent.flame_on.enabled
            if (bool(A.BlasterMaster:GetAzeriteRank()) and A.FlameOn:IsSpellLearned()) then
                local ShouldReturn = BmCombustionPhase(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- rune_of_power,if=buff.combustion.down
            if A.RuneofPower:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true))) then
                return A.RuneofPower:Show(icon)
            end
            -- call_action_list,name=active_talents
            if (true) then
                local ShouldReturn = ActiveTalents(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- combustion,use_off_gcd=1,use_while_casting=1,if=(!azerite.blaster_master.enabled|!talent.flame_on.enabled)&((action.meteor.in_flight&action.meteor.in_flight_remains<=0.5)|!talent.meteor.enabled)&(buff.rune_of_power.up|!talent.rune_of_power.enabled)
            if A.Combustion:IsReady(unit) and A.BurstIsON(unit) and ((not bool(A.BlasterMaster:GetAzeriteRank()) or not A.FlameOn:IsSpellLearned()) and ((A.Meteor:IsSpellInFlight() and action.meteor.in_flight_remains <= 0.5) or not A.Meteor:IsSpellLearned()) and (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) or not A.RuneofPower:IsSpellLearned())) then
                return A.Combustion:Show(icon)
            end
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            -- call_action_list,name=trinkets
            if (true) then
                local ShouldReturn = Trinkets(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- flamestrike,if=((talent.flame_patch.enabled&active_enemies>2)|active_enemies>6)&buff.hot_streak.react
            if A.Flamestrike:IsReady(unit) and (((A.FlamePatch:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 6) and bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.Flamestrike:Show(icon)
            end
            -- pyroblast,if=buff.pyroclasm.react&buff.combustion.remains>cast_time
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true)) and Unit("player"):HasBuffs(A.CombustionBuff.ID, true) > A.Pyroblast:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            -- pyroblast,if=buff.hot_streak.react
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.Pyroblast:Show(icon)
            end
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(!azerite.blaster_master.enabled|!talent.flame_on.enabled)&((buff.combustion.up&(buff.heating_up.react&!action.pyroblast.in_flight&!action.scorch.executing)|(action.scorch.execute_remains&buff.heating_up.down&buff.hot_streak.down&!action.pyroblast.in_flight)))
            if A.FireBlast:IsReady(unit) and ((not bool(A.BlasterMaster:GetAzeriteRank()) or not A.FlameOn:IsSpellLearned()) and ((Unit("player"):HasBuffs(A.CombustionBuff.ID, true) and (bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and not A.Pyroblast:IsSpellInFlight() and not bool(action.scorch.executing)) or (bool(action.scorch.execute_remains) and bool(Unit("player"):HasBuffsDown(A.HeatingUpBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.HotStreakBuff.ID, true)) and not A.Pyroblast:IsSpellInFlight())))) then
                return A.FireBlast:Show(icon)
            end
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up
            if A.Pyroblast:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.Scorch) and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            -- phoenix_flames
            if A.PhoenixFlames:IsReady(unit) then
                return A.PhoenixFlames:Show(icon)
            end
            -- scorch,if=buff.combustion.remains>cast_time&buff.combustion.up|buff.combustion.down
            if A.Scorch:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) > A.Scorch:GetSpellCastTime() and Unit("player"):HasBuffs(A.CombustionBuff.ID, true) or bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true))) then
                return A.Scorch:Show(icon)
            end
            -- living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1
            if A.LivingBomb:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) < A.GetGCD() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.LivingBomb:Show(icon)
            end
            -- dragons_breath,if=buff.combustion.remains<gcd.max&buff.combustion.up
            if A.DragonsBreath:IsReady(unit) and (Unit("player"):HasBuffs(A.CombustionBuff.ID, true) < A.GetGCD() and Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) then
                return A.DragonsBreath:Show(icon)
            end
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Scorch:Show(icon)
            end
        end
        
        --RopPhase
        local function RopPhase(unit)
            -- rune_of_power
            if A.RuneofPower:IsReady(unit) then
                return A.RuneofPower:Show(icon)
            end
            -- flamestrike,if=((talent.flame_patch.enabled&active_enemies>1)|active_enemies>4)&buff.hot_streak.react
            if A.Flamestrike:IsReady(unit) and (((A.FlamePatch:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 4) and bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.Flamestrike:Show(icon)
            end
            -- pyroblast,if=buff.hot_streak.react
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.Pyroblast:Show(icon)
            end
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0|firestarter.active&buff.rune_of_power.up)&(!buff.heating_up.react&!buff.hot_streak.react&!prev_off_gcd.fire_blast&(action.fire_blast.charges>=2|(action.phoenix_flames.charges>=1&talent.phoenix_flames.enabled)|(talent.alexstraszas_fury.enabled&cooldown.dragons_breath.ready)|(talent.searing_touch.enabled&target.health.pct<=30)|(talent.firestarter.enabled&firestarter.active)))
            if A.FireBlast:IsReady(unit) and ((A.Combustion:GetCooldown() > 0 or bool(S.Firestarter:ActiveStatus()) and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true)) and (not bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and not bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) and not Unit("player"):PrevOffGCDP(1, A.FireBlast) and (A.FireBlast:ChargesP() >= 2 or (A.PhoenixFlames:ChargesP() >= 1 and A.PhoenixFlames:IsSpellLearned()) or (A.AlexstraszasFury:IsSpellLearned() and A.DragonsBreath:GetCooldown() == 0) or (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30) or (A.Firestarter:IsSpellLearned() and bool(S.Firestarter:ActiveStatus()))))) then
                return A.FireBlast:Show(icon)
            end
            -- call_action_list,name=active_talents
            if (true) then
                local ShouldReturn = ActiveTalents(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&buff.rune_of_power.remains>cast_time
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true)) and A.Pyroblast:GetSpellCastTime() < Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true) and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) > A.Pyroblast:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0|firestarter.active&buff.rune_of_power.up)&(buff.heating_up.react&(target.health.pct>=30|!talent.searing_touch.enabled))
            if A.FireBlast:IsReady(unit) and ((A.Combustion:GetCooldown() > 0 or bool(S.Firestarter:ActiveStatus()) and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true)) and (bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and (Unit(unit):HealthPercent() >= 30 or not A.SearingTouch:IsSpellLearned()))) then
                return A.FireBlast:Show(icon)
            end
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0|firestarter.active&buff.rune_of_power.up)&talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.heating_up.react&!buff.hot_streak.react)
            if A.FireBlast:IsReady(unit) and ((A.Combustion:GetCooldown() > 0 or bool(S.Firestarter:ActiveStatus()) and Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true)) and A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and (bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and not bool(action.scorch.executing) or not bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and not bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)))) then
                return A.FireBlast:Show(icon)
            end
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&(!talent.flame_patch.enabled|active_enemies=1)
            if A.Pyroblast:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.Scorch) and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true) and A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and (not A.FlamePatch:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) == 1)) then
                return A.Pyroblast:Show(icon)
            end
            -- phoenix_flames,if=!prev_gcd.1.phoenix_flames&buff.heating_up.react
            if A.PhoenixFlames:IsReady(unit) and (not Unit("player"):GetSpellLastCast(A.PhoenixFlames) and bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true))) then
                return A.PhoenixFlames:Show(icon)
            end
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Scorch:Show(icon)
            end
            -- dragons_breath,if=active_enemies>2
            if A.DragonsBreath:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.DragonsBreath:Show(icon)
            end
            -- flamestrike,if=(talent.flame_patch.enabled&active_enemies>2)|active_enemies>5
            if A.Flamestrike:IsReady(unit) and ((A.FlamePatch:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 5) then
                return A.Flamestrike:Show(icon)
            end
            -- fireball
            if A.Fireball:IsReady(unit) then
                return A.Fireball:Show(icon)
            end
        end
        
        --StandardRotation
        local function StandardRotation(unit)
            -- flamestrike,if=((talent.flame_patch.enabled&active_enemies>1&!firestarter.active)|active_enemies>4)&buff.hot_streak.react
            if A.Flamestrike:IsReady(unit) and (((A.FlamePatch:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and not bool(S.Firestarter:ActiveStatus())) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 4) and bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))) then
                return A.Flamestrike:Show(icon)
            end
            -- pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) and Unit("player"):HasBuffs(A.HotStreakBuff.ID, true) < A.Fireball:GetSpellCastTime()) then
                return A.Pyroblast:Show(icon)
            end
            -- pyroblast,if=buff.hot_streak.react&(prev_gcd.1.fireball|firestarter.active|action.pyroblast.in_flight)
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) and (Unit("player"):GetSpellLastCast(A.Fireball) or bool(S.Firestarter:ActiveStatus()) or A.Pyroblast:IsSpellInFlight())) then
                return A.Pyroblast:Show(icon)
            end
            -- pyroblast,if=buff.hot_streak.react&target.health.pct<=30&talent.searing_touch.enabled
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) and Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Pyroblast:Show(icon)
            end
            -- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains
            if A.Pyroblast:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.PyroclasmBuff.ID, true)) and A.Pyroblast:GetSpellCastTime() < Unit("player"):HasBuffs(A.PyroclasmBuff.ID, true)) then
                return A.Pyroblast:Show(icon)
            end
            -- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0&buff.rune_of_power.down|firestarter.active)&!talent.kindling.enabled&!variable.fire_blast_pooling&(((action.fireball.executing|action.pyroblast.executing)&(buff.heating_up.react|firestarter.active&!buff.hot_streak.react&!buff.heating_up.react))|(talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!action.pyroblast.in_flight&!action.fireball.in_flight))|(firestarter.active&(action.pyroblast.in_flight|action.fireball.in_flight)&!buff.heating_up.react&!buff.hot_streak.react))
            if A.FireBlast:IsReady(unit) and ((A.Combustion:GetCooldown() > 0 and bool(Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true)) or bool(S.Firestarter:ActiveStatus())) and not A.Kindling:IsSpellLearned() and not bool(VarFireBlastPooling) and (((bool(action.fireball.executing) or bool(action.pyroblast.executing)) and (bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) or bool(S.Firestarter:ActiveStatus()) and not bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) and not bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)))) or (A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and (bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and not bool(action.scorch.executing) or not bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) and not bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and bool(action.scorch.executing) and not A.Pyroblast:IsSpellInFlight() and not A.Fireball:IsSpellInFlight())) or (bool(S.Firestarter:ActiveStatus()) and (A.Pyroblast:IsSpellInFlight() or A.Fireball:IsSpellInFlight()) and not bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and not bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true))))) then
                return A.FireBlast:Show(icon)
            end
            -- fire_blast,if=talent.kindling.enabled&buff.heating_up.react&(cooldown.combustion.remains>full_recharge_time+2+talent.kindling.enabled|firestarter.remains>full_recharge_time|(!talent.rune_of_power.enabled|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1)&cooldown.combustion.remains>target.time_to_die)
            if A.FireBlast:IsReady(unit) and (A.Kindling:IsSpellLearned() and bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) and (A.Combustion:GetCooldown() > A.FireBlast:FullRechargeTimeP() + 2 + num(A.Kindling:IsSpellLearned()) or S.Firestarter:ActiveRemains() > A.FireBlast:FullRechargeTimeP() or (not A.RuneofPower:IsSpellLearned() or A.RuneofPower:GetCooldown() > Unit(unit):TimeToDie() and A.RuneofPower:ChargesP() < 1) and A.Combustion:GetCooldown() > Unit(unit):TimeToDie())) then
                return A.FireBlast:Show(icon)
            end
            -- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&((talent.flame_patch.enabled&active_enemies=1&!firestarter.active)|(active_enemies<4&!talent.flame_patch.enabled))
            if A.Pyroblast:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.Scorch) and Unit("player"):HasBuffs(A.HeatingUpBuff.ID, true) and A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30 and ((A.FlamePatch:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and not bool(S.Firestarter:ActiveStatus())) or (MultiUnits:GetByRangeInCombat(40, 5, 10) < 4 and not A.FlamePatch:IsSpellLearned()))) then
                return A.Pyroblast:Show(icon)
            end
            -- phoenix_flames,if=(buff.heating_up.react|(!buff.hot_streak.react&(action.fire_blast.charges>0|talent.searing_touch.enabled&target.health.pct<=30)))&!variable.phoenix_pooling
            if A.PhoenixFlames:IsReady(unit) and ((bool(Unit("player"):HasBuffsStacks(A.HeatingUpBuff.ID, true)) or (not bool(Unit("player"):HasBuffsStacks(A.HotStreakBuff.ID, true)) and (A.FireBlast:ChargesP() > 0 or A.SearingTouch:IsSpellLearned() and Unit(unit):HealthPercent() <= 30))) and not bool(VarPhoenixPooling)) then
                return A.PhoenixFlames:Show(icon)
            end
            -- call_action_list,name=active_talents
            if (true) then
                local ShouldReturn = ActiveTalents(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- dragons_breath,if=active_enemies>1
            if A.DragonsBreath:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) then
                return A.DragonsBreath:Show(icon)
            end
            -- scorch,if=target.health.pct<=30&talent.searing_touch.enabled
            if A.Scorch:IsReady(unit) and (Unit(unit):HealthPercent() <= 30 and A.SearingTouch:IsSpellLearned()) then
                return A.Scorch:Show(icon)
            end
            -- fireball
            if A.Fireball:IsReady(unit) then
                return A.Fireball:Show(icon)
            end
            -- scorch
            if A.Scorch:IsReady(unit) then
                return A.Scorch:Show(icon)
            end
        end
        
        --Trinkets
        local function Trinkets(unit)
            -- use_items
        end
        
-- call precombat
if not Player:AffectingCombat() and not Player:IsCasting() then
  local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- counterspell
            -- mirror_image,if=buff.combustion.down
            if A.MirrorImage:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true))) then
                return A.MirrorImage:Show(icon)
            end
            -- rune_of_power,if=talent.firestarter.enabled&firestarter.remains>full_recharge_time|cooldown.combustion.remains>variable.combustion_rop_cutoff&buff.combustion.down|target.time_to_die<cooldown.combustion.remains&buff.combustion.down
            if A.RuneofPower:IsReady(unit) and (A.Firestarter:IsSpellLearned() and S.Firestarter:ActiveRemains() > A.RuneofPower:FullRechargeTimeP() or A.Combustion:GetCooldown() > VarCombustionRopCutoff and bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true)) or Unit(unit):TimeToDie() < A.Combustion:GetCooldown() and bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true))) then
                return A.RuneofPower:Show(icon)
            end
            -- call_action_list,name=combustion_phase,if=(talent.rune_of_power.enabled&cooldown.combustion.remains<=action.rune_of_power.cast_time|cooldown.combustion.ready)&!firestarter.active|buff.combustion.up
            if A.BurstIsON(unit) and ((A.RuneofPower:IsSpellLearned() and A.Combustion:GetCooldown() <= A.RuneofPower:GetSpellCastTime() or A.Combustion:GetCooldown() == 0) and not bool(S.Firestarter:ActiveStatus()) or Unit("player"):HasBuffs(A.CombustionBuff.ID, true)) then
                local ShouldReturn = CombustionPhase(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
            if (Unit("player"):HasBuffs(A.RuneofPowerBuff.ID, true) and bool(Unit("player"):HasBuffsDown(A.CombustionBuff.ID, true))) then
                local ShouldReturn = RopPhase(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- variable,name=fire_blast_pooling,value=talent.rune_of_power.enabled&cooldown.rune_of_power.remains<cooldown.fire_blast.full_recharge_time&(cooldown.combustion.remains>variable.combustion_rop_cutoff|firestarter.active)&(cooldown.rune_of_power.remains<target.time_to_die|action.rune_of_power.charges>0)|cooldown.combustion.remains<action.fire_blast.full_recharge_time+cooldown.fire_blast.duration*azerite.blaster_master.enabled&!firestarter.active&cooldown.combustion.remains<target.time_to_die|talent.firestarter.enabled&firestarter.active&firestarter.remains<cooldown.fire_blast.full_recharge_time+cooldown.fire_blast.duration*azerite.blaster_master.enabled
            if (true) then
                VarFireBlastPooling = num(A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() < A.FireBlast:FullRechargeTimeP() and (A.Combustion:GetCooldown() > VarCombustionRopCutoff or bool(S.Firestarter:ActiveStatus())) and (A.RuneofPower:GetCooldown() < Unit(unit):TimeToDie() or A.RuneofPower:ChargesP() > 0) or A.Combustion:GetCooldown() < A.FireBlast:FullRechargeTimeP() + A.FireBlast:BaseDuration() * A.BlasterMaster:GetAzeriteRank() and not bool(S.Firestarter:ActiveStatus()) and A.Combustion:GetCooldown() < Unit(unit):TimeToDie() or A.Firestarter:IsSpellLearned() and bool(S.Firestarter:ActiveStatus()) and S.Firestarter:ActiveRemains() < A.FireBlast:FullRechargeTimeP() + A.FireBlast:BaseDuration() * A.BlasterMaster:GetAzeriteRank())
            end
            -- variable,name=phoenix_pooling,value=talent.rune_of_power.enabled&cooldown.rune_of_power.remains<cooldown.phoenix_flames.full_recharge_time&cooldown.combustion.remains>variable.combustion_rop_cutoff&(cooldown.rune_of_power.remains<target.time_to_die|action.rune_of_power.charges>0)|cooldown.combustion.remains<action.phoenix_flames.full_recharge_time&cooldown.combustion.remains<target.time_to_die
            if (true) then
                VarPhoenixPooling = num(A.RuneofPower:IsSpellLearned() and A.RuneofPower:GetCooldown() < A.PhoenixFlames:FullRechargeTimeP() and A.Combustion:GetCooldown() > VarCombustionRopCutoff and (A.RuneofPower:GetCooldown() < Unit(unit):TimeToDie() or A.RuneofPower:ChargesP() > 0) or A.Combustion:GetCooldown() < A.PhoenixFlames:FullRechargeTimeP() and A.Combustion:GetCooldown() < Unit(unit):TimeToDie())
            end
            -- call_action_list,name=standard_rotation
            if (true) then
                local ShouldReturn = StandardRotation(unit); if ShouldReturn then return ShouldReturn; end
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

