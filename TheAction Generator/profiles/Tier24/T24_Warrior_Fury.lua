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
Action[ACTION_CONST_WARRIOR_FURY] = {
    MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
    GuardianofAzeroth                      = Action.Create({Type = "Spell", ID =  }),
    RecklessnessBuff                       = Action.Create({Type = "Spell", ID = 1719 }),
    Recklessness                           = Action.Create({Type = "Spell", ID = 1719 }),
    HeroicLeap                             = Action.Create({Type = "Spell", ID = 6544 }),
    Siegebreaker                           = Action.Create({Type = "Spell", ID = 280772 }),
    Rampage                                = Action.Create({Type = "Spell", ID = 184367 }),
    MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
    FrothingBerserker                      = Action.Create({Type = "Spell", ID = 215571 }),
    Carnage                                = Action.Create({Type = "Spell", ID = 202922 }),
    EnrageBuff                             = Action.Create({Type = "Spell", ID = 184362 }),
    Massacre                               = Action.Create({Type = "Spell", ID = 206315 }),
    Execute                                = Action.Create({Type = "Spell", ID = 5308 }),
    FuriousSlash                           = Action.Create({Type = "Spell", ID = 100130 }),
    FuriousSlashBuff                       = Action.Create({Type = "Spell", ID = 202539 }),
    Bladestorm                             = Action.Create({Type = "Spell", ID = 46924 }),
    Bloodthirst                            = Action.Create({Type = "Spell", ID = 23881 }),
    ColdSteelHotBlood                      = Action.Create({Type = "Spell", ID =  }),
    DragonRoar                             = Action.Create({Type = "Spell", ID = 118000 }),
    RagingBlow                             = Action.Create({Type = "Spell", ID = 85288 }),
    Whirlwind                              = Action.Create({Type = "Spell", ID = 190411 }),
    Charge                                 = Action.Create({Type = "Spell", ID = 100 }),
    BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
    PurifyingBlast                         = Action.Create({Type = "Spell", ID =  }),
    SiegebreakerBuff                       = Action.Create({Type = "Spell", ID =  }),
    RippleInSpace                          = Action.Create({Type = "Spell", ID =  }),
    WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
    FocusedAzeriteBeam                     = Action.Create({Type = "Spell", ID =  }),
    ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
    ConcentratedFlameBurnDebuff            = Action.Create({Type = "Spell", ID =  }),
    TheUnboundForce                        = Action.Create({Type = "Spell", ID =  }),
    RecklessForceBuff                      = Action.Create({Type = "Spell", ID =  }),
    GuardianofAzerothBuff                  = Action.Create({Type = "Spell", ID =  }),
    MeatCleaverBuff                        = Action.Create({Type = "Spell", ID = 280392 }),
    RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
    ConductiveInkDeBuffDebuff              = Action.Create({Type = "Spell", ID =  }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 })
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
    Channeling                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                          = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast 				             = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })



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
        local Precombat, Movement, SingleUnit(unit)
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:IsReady(unit) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:IsReady(unit) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- recklessness
            if A.Recklessness:IsReady(unit) and Unit("player"):HasBuffsDown(A.RecklessnessBuff.ID, true) and A.BurstIsON(unit) then
                return A.Recklessness:Show(icon)
            end
            -- potion
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStrength:Show(icon)
            end
        end
        
        --Movement
        local function Movement(unit)
            -- heroic_leap
            if A.HeroicLeap:IsReady(unit) then
                return A.HeroicLeap:Show(icon)
            end
        end
        
        --SingleUnit(unit)
        local function SingleUnit(unit)(unit)
            -- siegebreaker
            if A.Siegebreaker:IsReady(unit) and A.BurstIsON(unit) then
                return A.Siegebreaker:Show(icon)
            end
            -- rampage,if=(buff.recklessness.up|buff.memory_of_lucid_dreams.up)|(talent.frothing_berserker.enabled|talent.carnage.enabled&(buff.enrage.remains<gcd|rage>90)|talent.massacre.enabled&(buff.enrage.remains<gcd|rage>90))
            if A.Rampage:IsReady(unit) and ((Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) or Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true)) or (A.FrothingBerserker:IsSpellLearned() or A.Carnage:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < A.GetGCD() or Unit("player"):Rage() > 90) or A.Massacre:IsSpellLearned() and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true) < A.GetGCD() or Unit("player"):Rage() > 90))) then
                return A.Rampage:Show(icon)
            end
            -- execute
            if A.Execute:IsReady(unit) then
                return A.Execute:Show(icon)
            end
            -- furious_slash,if=!buff.bloodlust.up&buff.furious_slash.remains<3
            if A.FuriousSlash:IsReady(unit) and (not Unit("player"):HasHeroism and Unit("player"):HasBuffs(A.FuriousSlashBuff.ID, true) < 3) then
                return A.FuriousSlash:Show(icon)
            end
            -- bladestorm,if=prev_gcd.1.rampage
            if A.Bladestorm:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):GetSpellLastCast(A.Rampage)) then
                return A.Bladestorm:Show(icon)
            end
            -- bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1
            if A.Bloodthirst:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.EnrageBuff.ID, true)) or A.ColdSteelHotBlood:GetAzeriteRank() > 1) then
                return A.Bloodthirst:Show(icon)
            end
            -- dragon_roar,if=buff.enrage.up
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.EnrageBuff.ID, true)) then
                return A.DragonRoar:Show(icon)
            end
            -- raging_blow,if=charges=2
            if A.RagingBlow:IsReady(unit) and (A.RagingBlow:ChargesP() == 2) then
                return A.RagingBlow:Show(icon)
            end
            -- bloodthirst
            if A.Bloodthirst:IsReady(unit) then
                return A.Bloodthirst:Show(icon)
            end
            -- raging_blow,if=talent.carnage.enabled|(talent.massacre.enabled&rage<80)|(talent.frothing_berserker.enabled&rage<90)
            if A.RagingBlow:IsReady(unit) and (A.Carnage:IsSpellLearned() or (A.Massacre:IsSpellLearned() and Unit("player"):Rage() < 80) or (A.FrothingBerserker:IsSpellLearned() and Unit("player"):Rage() < 90)) then
                return A.RagingBlow:Show(icon)
            end
            -- furious_slash,if=talent.furious_slash.enabled
            if A.FuriousSlash:IsReady(unit) and (A.FuriousSlash:IsSpellLearned()) then
                return A.FuriousSlash:Show(icon)
            end
            -- whirlwind
            if A.Whirlwind:IsReady(unit) then
                return A.Whirlwind:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- charge
            if A.Charge:IsReady(unit) then
                return A.Charge:Show(icon)
            end
            -- run_action_list,name=movement,if=movement.distance>5
            if (movement.distance > 5) then
                return Movement(unit);
            end
            -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
            if A.HeroicLeap:IsReady(unit) and ((raid_event.movement.distance > 25 and 10000000000 > 45)) then
                return A.HeroicLeap:Show(icon)
            end
            -- potion
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStrength:Show(icon)
            end
            -- rampage,if=cooldown.recklessness.remains<3
            if A.Rampage:IsReady(unit) and (A.Recklessness:GetCooldown() < 3) then
                return A.Rampage:Show(icon)
            end
            -- blood_of_the_enemy,if=buff.recklessness.up
            if A.BloodoftheEnemy:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- purifying_blast,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.PurifyingBlast:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.PurifyingBlast:Show(icon)
            end
            -- ripple_in_space,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.RippleInSpace:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.RippleInSpace:Show(icon)
            end
            -- worldvein_resonance,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.WorldveinResonance:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.WorldveinResonance:Show(icon)
            end
            -- focused_azerite_beam,if=!buff.recklessness.up&!buff.siegebreaker.up
            if A.FocusedAzeriteBeam:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- concentrated_flame,if=!buff.recklessness.up&!buff.siegebreaker.up&dot.concentrated_flame_burn.remains=0
            if A.ConcentratedFlame:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true) and not Unit("player"):HasBuffs(A.SiegebreakerBuff.ID, true) and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up
            if A.TheUnboundForce:IsReady(unit) and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true)) then
                return A.TheUnboundForce:Show(icon)
            end
            -- guardian_of_azeroth,if=!buff.recklessness.up
            if A.GuardianofAzeroth:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- memory_of_lucid_dreams,if=!buff.recklessness.up
            if A.MemoryofLucidDreams:IsReady(unit) and (not Unit("player"):HasBuffs(A.RecklessnessBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- recklessness,if=!essence.condensed_lifeforce.major&!essence.blood_of_the_enemy.major|cooldown.guardian_of_azeroth.remains>20|buff.guardian_of_azeroth.up|cooldown.blood_of_the_enemy.remains<gcd
            if A.Recklessness:IsReady(unit) and A.BurstIsON(unit) and (not bool(essence.condensed_lifeforce.major) and not bool(essence.blood_of_the_enemy.major) or A.GuardianofAzeroth:GetCooldown() > 20 or Unit("player"):HasBuffs(A.GuardianofAzerothBuff.ID, true) or A.BloodoftheEnemy:GetCooldown() < A.GetGCD()) then
                return A.Recklessness:Show(icon)
            end
            -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up
            if A.Whirlwind:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and not Unit("player"):HasBuffs(A.MeatCleaverBuff.ID, true)) then
                return A.Whirlwind:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=!debuff.razor_coral_debuff.up|(target.health.pct<30.1&debuff.conductive_ink_debuff.up)|(!debuff.conductive_ink_debuff.up&buff.memory_of_lucid_dreams.up|prev_gcd.2.guardian_of_azeroth|prev_gcd.2.recklessness&(!essence.memory_of_lucid_dreams.major&!essence.condensed_lifeforce.major))
            if A.AshvanesRazorCoral:IsReady(unit) and (not Unit(unit):HasDeBuffs(A.RazorCoralDeBuffDebuff.ID, true) or (Unit(unit):HealthPercent() < 30.1 and Unit(unit):HasDeBuffs(A.ConductiveInkDeBuffDebuff.ID, true)) or (not Unit(unit):HasDeBuffs(A.ConductiveInkDeBuffDebuff.ID, true) and Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff.ID, true) or Unit("player"):GetSpellLastCast(A.GuardianofAzeroth) or Unit("player"):GetSpellLastCast(A.Recklessness) and (not bool(essence.memory_of_lucid_dreams.major) and not bool(essence.condensed_lifeforce.major)))) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- blood_fury
            if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- lights_judgment,if=buff.recklessness.down
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (bool(Unit("player"):HasBuffsDown(A.RecklessnessBuff.ID, true))) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood
            if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:IsReady(unit) and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
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

