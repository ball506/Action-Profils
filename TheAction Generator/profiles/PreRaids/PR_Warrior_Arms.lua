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
Action[ACTION_CONST_WARRIOR_ARMS] = {
    Skullsplitter                          = Action.Create({Type = "Spell", ID = 260643 }),
    DeadlyCalm                             = Action.Create({Type = "Spell", ID = 262228 }),
    DeadlyCalmBuff                         = Action.Create({Type = "Spell", ID = 262228 }),
    Ravager                                = Action.Create({Type = "Spell", ID = 152277 }),
    ColossusSmash                          = Action.Create({Type = "Spell", ID = 167105 }),
    Warbreaker                             = Action.Create({Type = "Spell", ID = 262161 }),
    ColossusSmashDebuff                    = Action.Create({Type = "Spell", ID = 208086 }),
    Bladestorm                             = Action.Create({Type = "Spell", ID = 227847 }),
    Cleave                                 = Action.Create({Type = "Spell", ID = 845 }),
    Slam                                   = Action.Create({Type = "Spell", ID = 1464 }),
    CrushingAssaultBuff                    = Action.Create({Type = "Spell", ID = 278826 }),
    MortalStrike                           = Action.Create({Type = "Spell", ID = 12294 }),
    OverpowerBuff                          = Action.Create({Type = "Spell", ID = 7384 }),
    Dreadnaught                            = Action.Create({Type = "Spell", ID = 262150 }),
    ExecutionersPrecisionBuff              = Action.Create({Type = "Spell", ID = 242188 }),
    Execute                                = Action.Create({Type = "Spell", ID = 163201 }),
    Overpower                              = Action.Create({Type = "Spell", ID = 7384 }),
    SweepingStrikesBuff                    = Action.Create({Type = "Spell", ID = 260708 }),
    TestofMight                            = Action.Create({Type = "Spell", ID = 275529 }),
    TestofMightBuff                        = Action.Create({Type = "Spell", ID = 275540 }),
    DeepWoundsDebuff                       = Action.Create({Type = "Spell", ID = 262115 }),
    SuddenDeathBuff                        = Action.Create({Type = "Spell", ID = 52437 }),
    StoneHeartBuff                         = Action.Create({Type = "Spell", ID = 225947 }),
    SweepingStrikes                        = Action.Create({Type = "Spell", ID = 260708 }),
    Whirlwind                              = Action.Create({Type = "Spell", ID = 1680 }),
    FervorofBattle                         = Action.Create({Type = "Spell", ID = 202316 }),
    Rend                                   = Action.Create({Type = "Spell", ID = 772 }),
    RendDebuff                             = Action.Create({Type = "Spell", ID = 772 }),
    AngerManagement                        = Action.Create({Type = "Spell", ID = 152278 }),
    SeismicWave                            = Action.Create({Type = "Spell", ID = 277639 }),
    Charge                                 = Action.Create({Type = "Spell", ID = 100 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    Avatar                                 = Action.Create({Type = "Spell", ID = 107574 }),
    Massacre                               = Action.Create({Type = "Spell", ID = 281001 })
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
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_ARMS)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })



local EnemyRanges = {8}
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

A.ExecuteDefault    = 163201
A.ExecuteMassacre   = 281000

local function UpdateExecuteID()
    A.Execute = A.Massacre:IsSpellLearned() and A.ExecuteMassacre or A.ExecuteDefault
end

--- ======= ACTION LISTS =======
local function APL()
        local Precombat, Execute, FiveUnit(unit), Hac, SingleUnit(unit)
  UpdateRanges()
  Everyone.AoEToggleEnemiesUpdate()
  UpdateExecuteID()
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStrength:Show(icon)
            end
        end
        
        --Execute
        local function Execute(unit)
            -- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down)
            if A.Skullsplitter:IsReady(unit) and (Unit("player"):Rage() < 60 and (not A.DeadlyCalm:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true)))) then
                return A.Skullsplitter:Show(icon)
            end
            -- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            -- colossus_smash,if=debuff.colossus_smash.down
            if A.ColossusSmash:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.ColossusSmash:Show(icon)
            end
            -- warbreaker,if=debuff.colossus_smash.down
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.Warbreaker:Show(icon)
            end
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            -- bladestorm,if=rage<30&!buff.deadly_calm.up
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):Rage() < 30 and not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true)) then
                return A.Bladestorm:Show(icon)
            end
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            -- slam,if=buff.crushing_assault.up
            if A.Slam:IsReady(unit) and (Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true)) then
                return A.Slam:Show(icon)
            end
            -- mortal_strike,if=buff.overpower.stack=2&talent.dreadnaught.enabled|buff.executioners_precision.stack=2
            if A.MortalStrike:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.OverpowerBuff.ID, true) == 2 and A.Dreadnaught:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.ExecutionersPrecisionBuff.ID, true) == 2) then
                return A.MortalStrike:Show(icon)
            end
            -- execute,if=buff.deadly_calm.up
            if A.Execute:IsReady(unit) and (Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true)) then
                return A.Execute:Show(icon)
            end
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            -- execute
            if A.Execute:IsReady(unit) then
                return A.Execute:Show(icon)
            end
        end
        
        --FiveUnit(unit)
        local function FiveUnit(unit)(unit)
            -- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down)
            if A.Skullsplitter:IsReady(unit) and (Unit("player"):Rage() < 60 and (not A.DeadlyCalm:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true)))) then
                return A.Skullsplitter:Show(icon)
            end
            -- ravager,if=(!talent.warbreaker.enabled|cooldown.warbreaker.remains<2)
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and ((not A.Warbreaker:IsSpellLearned() or A.Warbreaker:GetCooldown() < 2)) then
                return A.Ravager:Show(icon)
            end
            -- colossus_smash,if=debuff.colossus_smash.down
            if A.ColossusSmash:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.ColossusSmash:Show(icon)
            end
            -- warbreaker,if=debuff.colossus_smash.down
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.Warbreaker:Show(icon)
            end
            -- bladestorm,if=buff.sweeping_strikes.down&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.SweepingStrikesBuff.ID, true)) and (not A.DeadlyCalm:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true))) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 4.5 and not bool(A.TestofMight:GetAzeriteRank())) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) then
                return A.Bladestorm:Show(icon)
            end
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            -- cleave
            if A.Cleave:IsReady(unit) then
                return A.Cleave:Show(icon)
            end
            -- execute,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|(buff.sudden_death.react|buff.stone_heart.react)&(buff.sweeping_strikes.up|cooldown.sweeping_strikes.remains>8)
            if A.Execute:IsReady(unit) and ((not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or (bool(Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true)) or bool(Unit("player"):HasBuffsStacks(A.StoneHeartBuff.ID, true))) and (Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) or A.SweepingStrikes:GetCooldown() > 8)) then
                return A.Execute:Show(icon)
            end
            -- mortal_strike,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sweeping_strikes.up&buff.overpower.stack=2&(talent.dreadnaught.enabled|buff.executioners_precision.stack=2)
            if A.MortalStrike:IsReady(unit) and ((not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true) and Unit("player"):HasBuffsStacks(A.OverpowerBuff.ID, true) == 2 and (A.Dreadnaught:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.ExecutionersPrecisionBuff.ID, true) == 2)) then
                return A.MortalStrike:Show(icon)
            end
            -- whirlwind,if=debuff.colossus_smash.up|(buff.crushing_assault.up&talent.fervor_of_battle.enabled)
            if A.Whirlwind:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or (Unit("player"):HasBuffs(A.CrushingAssaultBuff.ID, true) and A.FervorofBattle:IsSpellLearned())) then
                return A.Whirlwind:Show(icon)
            end
            -- whirlwind,if=buff.deadly_calm.up|rage>60
            if A.Whirlwind:IsReady(unit) and (Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) or Unit("player"):Rage() > 60) then
                return A.Whirlwind:Show(icon)
            end
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            -- whirlwind
            if A.Whirlwind:IsReady(unit) then
                return A.Whirlwind:Show(icon)
            end
        end
        
        --Hac
        local function Hac(unit)
            -- rend,if=remains<=duration*0.3&(!raid_event.adds.up|buff.sweeping_strikes.up)
            if A.Rend:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= A.RendDebuff.ID, true:BaseDuration * 0.3 and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or Unit("player"):HasBuffs(A.SweepingStrikesBuff.ID, true))) then
                return A.Rend:Show(icon)
            end
            -- skullsplitter,if=rage<60&(cooldown.deadly_calm.remains>3|!talent.deadly_calm.enabled)
            if A.Skullsplitter:IsReady(unit) and (Unit("player"):Rage() < 60 and (A.DeadlyCalm:GetCooldown() > 3 or not A.DeadlyCalm:IsSpellLearned())) then
                return A.Skullsplitter:Show(icon)
            end
            -- deadly_calm,if=(cooldown.bladestorm.remains>6|talent.ravager.enabled&cooldown.ravager.remains>6)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.DeadlyCalm:IsReady(unit) and ((A.Bladestorm:GetCooldown() > 6 or A.Ravager:IsSpellLearned() and A.Ravager:GetCooldown() > 6) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.DeadlyCalm:Show(icon)
            end
            -- ravager,if=(raid_event.adds.up|raid_event.adds.in>target.time_to_die)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > Unit(unit):TimeToDie()) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            -- colossus_smash,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
            if A.ColossusSmash:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 40 or (10000000000 > 20 and A.AngerManagement:IsSpellLearned())) then
                return A.ColossusSmash:Show(icon)
            end
            -- warbreaker,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or 10000000000 > 40 or (10000000000 > 20 and A.AngerManagement:IsSpellLearned())) then
                return A.Warbreaker:Show(icon)
            end
            -- bladestorm,if=(debuff.colossus_smash.up&raid_event.adds.in>target.time_to_die)|raid_event.adds.up&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and 10000000000 > Unit(unit):TimeToDie()) or (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) > 4.5 and not bool(A.TestofMight:GetAzeriteRank())) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) then
                return A.Bladestorm:Show(icon)
            end
            -- overpower,if=!raid_event.adds.up|(raid_event.adds.up&azerite.seismic_wave.enabled)
            if A.Overpower:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and bool(A.SeismicWave:GetAzeriteRank()))) then
                return A.Overpower:Show(icon)
            end
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            -- execute,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sudden_death.react
            if A.Execute:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or (not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2) or bool(Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true))) then
                return A.Execute:Show(icon)
            end
            -- mortal_strike,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)
            if A.MortalStrike:IsReady(unit) and (not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) or (not A.Cleave:IsSpellLearned() and Unit(unit):HasDeBuffs(A.DeepWoundsDebuff.ID, true) < 2)) then
                return A.MortalStrike:Show(icon)
            end
            -- whirlwind,if=raid_event.adds.up
            if A.Whirlwind:IsReady(unit) and ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.Whirlwind:Show(icon)
            end
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            -- whirlwind,if=talent.fervor_of_battle.enabled
            if A.Whirlwind:IsReady(unit) and (A.FervorofBattle:IsSpellLearned()) then
                return A.Whirlwind:Show(icon)
            end
            -- slam,if=!talent.fervor_of_battle.enabled&!raid_event.adds.up
            if A.Slam:IsReady(unit) and (not A.FervorofBattle:IsSpellLearned() and not (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return A.Slam:Show(icon)
            end
        end
        
        --SingleUnit(unit)
        local function SingleUnit(unit)(unit)
            -- rend,if=remains<=duration*0.3&debuff.colossus_smash.down
            if A.Rend:IsReady(unit) and (Unit(unit):HasDeBuffs(A.RendDebuff.ID, true) <= A.RendDebuff.ID, true:BaseDuration * 0.3 and bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.Rend:Show(icon)
            end
            -- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down)
            if A.Skullsplitter:IsReady(unit) and (Unit("player"):Rage() < 60 and (not A.DeadlyCalm:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true)))) then
                return A.Skullsplitter:Show(icon)
            end
            -- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
            if A.Ravager:IsReady(unit) and A.BurstIsON(unit) and (not Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) and (A.ColossusSmash:GetCooldown() < 2 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 2))) then
                return A.Ravager:Show(icon)
            end
            -- colossus_smash,if=debuff.colossus_smash.down
            if A.ColossusSmash:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.ColossusSmash:Show(icon)
            end
            -- warbreaker,if=debuff.colossus_smash.down
            if A.Warbreaker:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.Warbreaker:Show(icon)
            end
            -- deadly_calm
            if A.DeadlyCalm:IsReady(unit) then
                return A.DeadlyCalm:Show(icon)
            end
            -- execute,if=buff.sudden_death.react
            if A.Execute:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.SuddenDeathBuff.ID, true))) then
                return A.Execute:Show(icon)
            end
            -- bladestorm,if=cooldown.mortal_strike.remains&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.up&!azerite.test_of_might.enabled)|buff.test_of_might.up)
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (bool(A.MortalStrike:GetCooldown()) and (not A.DeadlyCalm:IsSpellLearned() or bool(Unit("player"):HasBuffsDown(A.DeadlyCalmBuff.ID, true))) and ((Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) and not bool(A.TestofMight:GetAzeriteRank())) or Unit("player"):HasBuffs(A.TestofMightBuff.ID, true))) then
                return A.Bladestorm:Show(icon)
            end
            -- cleave,if=spell_targets.whirlwind>2
            if A.Cleave:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 2) then
                return A.Cleave:Show(icon)
            end
            -- overpower,if=azerite.seismic_wave.rank=3
            if A.Overpower:IsReady(unit) and (A.SeismicWave:GetAzeriteRank() == 3) then
                return A.Overpower:Show(icon)
            end
            -- mortal_strike
            if A.MortalStrike:IsReady(unit) then
                return A.MortalStrike:Show(icon)
            end
            -- whirlwind,if=talent.fervor_of_battle.enabled&(buff.deadly_calm.up|rage>=60)
            if A.Whirlwind:IsReady(unit) and (A.FervorofBattle:IsSpellLearned() and (Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) or Unit("player"):Rage() >= 60)) then
                return A.Whirlwind:Show(icon)
            end
            -- overpower
            if A.Overpower:IsReady(unit) then
                return A.Overpower:Show(icon)
            end
            -- whirlwind,if=talent.fervor_of_battle.enabled&(!azerite.test_of_might.enabled|debuff.colossus_smash.up)
            if A.Whirlwind:IsReady(unit) and (A.FervorofBattle:IsSpellLearned() and (not bool(A.TestofMight:GetAzeriteRank()) or Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true))) then
                return A.Whirlwind:Show(icon)
            end
            -- slam,if=!talent.fervor_of_battle.enabled&(!azerite.test_of_might.enabled|debuff.colossus_smash.up|buff.deadly_calm.up|rage>=60)
            if A.Slam:IsReady(unit) and (not A.FervorofBattle:IsSpellLearned() and (not bool(A.TestofMight:GetAzeriteRank()) or Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true) or Unit("player"):HasBuffs(A.DeadlyCalmBuff.ID, true) or Unit("player"):Rage() >= 60)) then
                return A.Slam:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end
  if Everyone.TargetIsValid() then
            -- charge
            if A.Charge:IsReady(unit) then
                return A.Charge:Show(icon)
            end
            -- auto_attack
            -- potion
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStrength:Show(icon)
            end
            -- blood_fury,if=debuff.colossus_smash.up
            if A.BloodFury:AutoRacial(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true)) then
                return A.BloodFury:Show(icon)
            end
            -- berserking,if=debuff.colossus_smash.up
            if A.Berserking:AutoRacial(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true)) then
                return A.Berserking:Show(icon)
            end
            -- arcane_torrent,if=debuff.colossus_smash.down&cooldown.mortal_strike.remains>1.5&rage<50
            if A.ArcaneTorrent:AutoRacial(unit) and A.BurstIsON(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true)) and A.MortalStrike:GetCooldown() > 1.5 and Unit("player"):Rage() < 50) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- lights_judgment,if=debuff.colossus_smash.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit(unit):HasDeBuffsDown(A.ColossusSmashDebuff.ID, true))) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood,if=debuff.colossus_smash.up
            if A.Fireblood:AutoRacial(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call,if=debuff.colossus_smash.up
            if A.AncestralCall:AutoRacial(unit) and A.BurstIsON(unit) and (Unit(unit):HasDeBuffs(A.ColossusSmashDebuff.ID, true)) then
                return A.AncestralCall:Show(icon)
            end
            -- avatar,if=cooldown.colossus_smash.remains<8|(talent.warbreaker.enabled&cooldown.warbreaker.remains<8)
            if A.Avatar:IsReady(unit) and A.BurstIsON(unit) and (A.ColossusSmash:GetCooldown() < 8 or (A.Warbreaker:IsSpellLearned() and A.Warbreaker:GetCooldown() < 8)) then
                return A.Avatar:Show(icon)
            end
            -- sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>10|cooldown.colossus_smash.remains>8|azerite.test_of_might.enabled)
            if A.SweepingStrikes:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and (A.Bladestorm:GetCooldown() > 10 or A.ColossusSmash:GetCooldown() > 8 or bool(A.TestofMight:GetAzeriteRank()))) then
                return A.SweepingStrikes:Show(icon)
            end
            -- run_action_list,name=hac,if=raid_event.adds.exists
            if ((MultiUnits:GetByRangeInCombat(40, 5, 10) > 1)) then
                return Hac(unit);
            end
            -- run_action_list,name=five_target,if=spell_targets.whirlwind>4
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 4) then
                return FiveUnitunit(unit);
            end
            -- run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
            if ((A.Massacre:IsSpellLearned() and Unit(unit):HealthPercent() < 35) or Unit(unit):HealthPercent() < 20) then
                return Execute(unit);
            end
            -- run_action_list,name=single_target
            if (true) then
                return SingleUnitunit(unit);
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

