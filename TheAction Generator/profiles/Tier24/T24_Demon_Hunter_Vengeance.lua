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
Action[ACTION_CONST_DEMONHUNTER_VENGEANCE] = {
    SigilofFlame                           = Action.Create({Type = "Spell", ID = 204596 }),
    FieryBrand                             = Action.Create({Type = "Spell", ID =  }),
    InfernalStrike                         = Action.Create({Type = "Spell", ID = 189110 }),
    ImmolationAura                         = Action.Create({Type = "Spell", ID = 178740 }),
    FieryBrandDebuff                       = Action.Create({Type = "Spell", ID =  }),
    FelDevastation                         = Action.Create({Type = "Spell", ID = 212084 }),
    ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
    ConcentratedFlameBurnDebuff            = Action.Create({Type = "Spell", ID =  }),
    WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
    LifebloodBuff                          = Action.Create({Type = "Spell", ID =  }),
    MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
    HeartEssence                           = Action.Create({Type = "Spell", ID =  }),
    MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
    RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
    ConductiveInkDeBuffDebuff              = Action.Create({Type = "Spell", ID =  }),
    DemonSpikes                            = Action.Create({Type = "Spell", ID = 203720 }),
    Metamorphosis                          = Action.Create({Type = "Spell", ID = 191427 }),
    SpiritBomb                             = Action.Create({Type = "Spell", ID =  }),
    SoulCleave                             = Action.Create({Type = "Spell", ID = 228477 }),
    Felblade                               = Action.Create({Type = "Spell", ID = 232893 }),
    Fracture                               = Action.Create({Type = "Spell", ID =  }),
    Shear                                  = Action.Create({Type = "Spell", ID = 203782 }),
    ThrowGlaive                            = Action.Create({Type = "Spell", ID = 204157 }),
    ConsumeMagic                           = Action.Create({Type = "Spell", ID = 183752 }),
    CharredFlesh                           = Action.Create({Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_DEMONHUNTER_VENGEANCE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_VENGEANCE], { __index = Action })



local EnemyRanges = {}
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
        local Precombat, Brand, Cooldowns, Defensives, Normal
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofAgility:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
        end
        
        --Brand
        local function Brand(unit)
            -- sigil_of_flame,if=cooldown.fiery_brand.remains<2
            if A.SigilofFlame:IsReady(unit) and (A.FieryBrand:GetCooldown() < 2) then
                return A.SigilofFlame:Show(icon)
            end
            -- infernal_strike,if=cooldown.fiery_brand.remains=0
            if A.InfernalStrike:IsReady(unit) and (A.FieryBrand:GetCooldown() == 0) then
                return A.InfernalStrike:Show(icon)
            end
            -- fiery_brand
            if A.FieryBrand:IsReady(unit) then
                return A.FieryBrand:Show(icon)
            end
            -- immolation_aura,if=dot.fiery_brand.ticking
            if A.ImmolationAura:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true)) then
                return A.ImmolationAura:Show(icon)
            end
            -- fel_devastation,if=dot.fiery_brand.ticking
            if A.FelDevastation:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true)) then
                return A.FelDevastation:Show(icon)
            end
            -- infernal_strike,if=dot.fiery_brand.ticking
            if A.InfernalStrike:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true)) then
                return A.InfernalStrike:Show(icon)
            end
            -- sigil_of_flame,if=dot.fiery_brand.ticking
            if A.SigilofFlame:IsReady(unit) and (Unit(unit):HasDeBuffs(A.FieryBrandDebuff.ID, true)) then
                return A.SigilofFlame:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- potion
            if A.BattlePotionofAgility:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofAgility:Show(icon)
            end
            -- concentrated_flame,if=(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:IsReady(unit) and ((not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:FullRechargeTimeP() < A.GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:IsReady(unit) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- heart_essence
            if A.HeartEssence:IsReady(unit) then
                return A.HeartEssence:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=buff.memory_of_lucid_dreams.down
            if A.CyclotronicBlast:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true))) then
                A.CyclotronicBlast:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDeBuffDebuff.ID, true)) or Unit(unit):HasDeBuffs(A.ConductiveInkDeBuffDebuff.ID, true) and Unit(unit):HealthPercent() < 31 or Unit(unit):TimeToDie() < 20) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_items
        end
        
        --Defensives
        local function Defensives(unit)
            -- demon_spikes
            if A.DemonSpikes:IsReady(unit) then
                return A.DemonSpikes:Show(icon)
            end
            -- metamorphosis
            if A.Metamorphosis:IsReady(unit) then
                return A.Metamorphosis:Show(icon)
            end
            -- fiery_brand
            if A.FieryBrand:IsReady(unit) then
                return A.FieryBrand:Show(icon)
            end
        end
        
        --Normal
        local function Normal(unit)
            -- infernal_strike
            if A.InfernalStrike:IsReady(unit) then
                return A.InfernalStrike:Show(icon)
            end
            -- spirit_bomb,if=soul_fragments>=4
            if A.SpiritBomb:IsReady(unit) and (soul_fragments >= 4) then
                return A.SpiritBomb:Show(icon)
            end
            -- soul_cleave,if=!talent.spirit_bomb.enabled
            if A.SoulCleave:IsReady(unit) and (not A.SpiritBomb:IsSpellLearned()) then
                return A.SoulCleave:Show(icon)
            end
            -- soul_cleave,if=talent.spirit_bomb.enabled&soul_fragments=0
            if A.SoulCleave:IsReady(unit) and (A.SpiritBomb:IsSpellLearned() and soul_fragments == 0) then
                return A.SoulCleave:Show(icon)
            end
            -- immolation_aura,if=pain<=90
            if A.ImmolationAura:IsReady(unit) and (Unit("player"):Pain() <= 90) then
                return A.ImmolationAura:Show(icon)
            end
            -- felblade,if=pain<=70
            if A.Felblade:IsReady(unit) and (Unit("player"):Pain() <= 70) then
                return A.Felblade:Show(icon)
            end
            -- fracture,if=soul_fragments<=3
            if A.Fracture:IsReady(unit) and (soul_fragments <= 3) then
                return A.Fracture:Show(icon)
            end
            -- fel_devastation
            if A.FelDevastation:IsReady(unit) then
                return A.FelDevastation:Show(icon)
            end
            -- sigil_of_flame
            if A.SigilofFlame:IsReady(unit) then
                return A.SigilofFlame:Show(icon)
            end
            -- shear
            if A.Shear:IsReady(unit) then
                return A.Shear:Show(icon)
            end
            -- throw_glaive
            if A.ThrowGlaive:IsReady(unit) then
                return A.ThrowGlaive:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- consume_magic
            if A.ConsumeMagic:IsReady(unit) then
                return A.ConsumeMagic:Show(icon)
            end
            -- call_action_list,name=brand,if=talent.charred_flesh.enabled
            if (A.CharredFlesh:IsSpellLearned()) then
                local ShouldReturn = Brand(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=defensives
            if (true) then
                local ShouldReturn = Defensives(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cooldowns
            if (true) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=normal
            if (true) then
                local ShouldReturn = Normal(unit); if ShouldReturn then return ShouldReturn; end
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

