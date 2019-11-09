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
Action[ACTION_CONST_MONK_BREWMASTER] = {
    ChiBurst                               = Action.Create({Type = "Spell", ID = 123986 }),
    ChiWave                                = Action.Create({Type = "Spell", ID = 115098 }),
    DampenHarm                             = Action.Create({Type = "Spell", ID = 122278 }),
    FortifyingBrewBuff                     = Action.Create({Type = "Spell", ID = 115203 }),
    FortifyingBrew                         = Action.Create({Type = "Spell", ID = 115203 }),
    DampenHarmBuff                         = Action.Create({Type = "Spell", ID = 122278 }),
    DiffuseMagicBuff                       = Action.Create({Type = "Spell", ID =  }),
    RazorCoralDeBuffDebuff                 = Action.Create({Type = "Spell", ID =  }),
    ConductiveInkDeBuffDebuff              = Action.Create({Type = "Spell", ID =  }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    InvokeNiuzaotheBlackOx                 = Action.Create({Type = "Spell", ID = 132578 }),
    IronskinBrew                           = Action.Create({Type = "Spell", ID = 115308 }),
    BlackoutComboBuff                      = Action.Create({Type = "Spell", ID = 228563 }),
    ElusiveBrawlerBuff                     = Action.Create({Type = "Spell", ID =  }),
    IronskinBrewBuff                       = Action.Create({Type = "Spell", ID = 215479 }),
    Brews                                  = Action.Create({Type = "Spell", ID = 115308 }),
    BlackOxBrew                            = Action.Create({Type = "Spell", ID = 115399 }),
    PurifyingBrew                          = Action.Create({Type = "Spell", ID = 119582 }),
    KegSmash                               = Action.Create({Type = "Spell", ID = 121253 }),
    TigerPalm                              = Action.Create({Type = "Spell", ID = 100780 }),
    RushingJadeWind                        = Action.Create({Type = "Spell", ID = 116847 }),
    RushingJadeWindBuff                    = Action.Create({Type = "Spell", ID = 116847 }),
    SpecialDelivery                        = Action.Create({Type = "Spell", ID =  }),
    ExpelHarm                              = Action.Create({Type = "Spell", ID =  }),
    BlackoutStrike                         = Action.Create({Type = "Spell", ID = 205523 }),
    ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
    ConcentratedFlameDebuff                = Action.Create({Type = "Spell", ID =  }),
    HeartEssence                           = Action.Create({Type = "Spell", ID =  }),
    BreathofFire                           = Action.Create({Type = "Spell", ID = 115181 }),
    BreathofFireDotDebuff                  = Action.Create({Type = "Spell", ID = 123725 }),
    BlackoutCombo                          = Action.Create({Type = "Spell", ID = 196736 }),
    ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 })
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
Action:CreateEssencesFor(ACTION_CONST_MONK_BREWMASTER)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MONK_BREWMASTER], { __index = Action })



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
        local Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- chi_burst
            if A.ChiBurst:IsReady(unit) then
                return A.ChiBurst:Show(icon)
            end
            -- chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
        end
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- gift_of_the_ox,if=health<health.max*0.65
            -- dampen_harm,if=incoming_damage_1500ms&buff.fortifying_brew.down
            if A.DampenHarm:IsReady(unit) and (bool(incoming_damage_1500ms) and bool(Unit("player"):HasBuffsDown(A.FortifyingBrewBuff))) then
                return A.DampenHarm:Show(icon)
            end
            -- fortifying_brew,if=incoming_damage_1500ms&(buff.dampen_harm.down|buff.diffuse_magic.down)
            if A.FortifyingBrew:IsReady(unit) and (bool(incoming_damage_1500ms) and (bool(Unit("player"):HasBuffsDown(A.DampenHarmBuff)) or bool(Unit("player"):HasBuffsDown(A.DiffuseMagicBuff)))) then
                return A.FortifyingBrew:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<31|target.time_to_die<20
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDeBuffDebuff)) or Unit(unit):HasDeBuffs(A.ConductiveInkDeBuffDebuff) and Unit(unit):HealthPercent < 31 or Unit(unit):TimeToDie() < 20) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_items
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- blood_fury
            if A.BloodFury:IsReady(unit) and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:IsReady(unit) and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
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
            -- invoke_niuzao_the_black_ox,if=target.time_to_die>25
            if A.InvokeNiuzaotheBlackOx:IsReady(unit) and A.BurstIsON(unit) and (Unit(unit):TimeToDie() > 25) then
                return A.InvokeNiuzaotheBlackOx:Show(icon)
            end
            -- ironskin_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2&!buff.ironskin_brew.up
            if A.IronskinBrew:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff)) and incoming_damage_1999ms > (health.max * 0.1 + stagger.last_tick_damage_4) and Unit("player"):HasBuffsStacks(A.ElusiveBrawlerBuff) < 2 and not Unit("player"):HasBuffs(A.IronskinBrewBuff)) then
                return A.IronskinBrew:Show(icon)
            end
            -- ironskin_brew,if=cooldown.brews.charges_fractional>1&cooldown.black_ox_brew.remains<3
            if A.IronskinBrew:IsReady(unit) and (A.Brews:ChargesFractionalP() > 1 and A.BlackOxBrew:GetCooldown() < 3) then
                return A.IronskinBrew:Show(icon)
            end
            -- purifying_brew,if=stagger.pct>(6*(3-(cooldown.brews.charges_fractional)))&(stagger.last_tick_damage_1>((0.02+0.001*(3-cooldown.brews.charges_fractional))*stagger.last_tick_damage_30))
            if A.PurifyingBrew:IsReady(unit) and (stagger.pct > (6 * (3 - (A.Brews:ChargesFractionalP()))) and (stagger.last_tick_damage_1 > ((0.02 + 0.001 * (3 - A.Brews:ChargesFractionalP())) * stagger.last_tick_damage_30))) then
                return A.PurifyingBrew:Show(icon)
            end
            -- black_ox_brew,if=cooldown.brews.charges_fractional<0.5
            if A.BlackOxBrew:IsReady(unit) and (A.Brews:ChargesFractionalP() < 0.5) then
                return A.BlackOxBrew:Show(icon)
            end
            -- black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
            if A.BlackOxBrew:IsReady(unit) and ((Unit("player"):EnergyPredicted() + (Unit("player"):EnergyRegen() * A.KegSmash:GetCooldown())) < 40 and bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff)) and A.KegSmash:HasCooldownUps) then
                return A.BlackOxBrew:Show(icon)
            end
            -- keg_smash,if=spell_targets>=2
            if A.KegSmash:IsReady(unit) and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2) then
                return A.KegSmash:Show(icon)
            end
            -- tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up
            if A.TigerPalm:IsReady(unit) and (A.RushingJadeWind:IsSpellLearned() and Unit("player"):HasBuffs(A.BlackoutComboBuff) and Unit("player"):HasBuffs(A.RushingJadeWindBuff)) then
                return A.TigerPalm:Show(icon)
            end
            -- tiger_palm,if=(talent.invoke_niuzao_the_black_ox.enabled|talent.special_delivery.enabled)&buff.blackout_combo.up
            if A.TigerPalm:IsReady(unit) and ((A.InvokeNiuzaotheBlackOx:IsSpellLearned() or A.SpecialDelivery:IsSpellLearned()) and Unit("player"):HasBuffs(A.BlackoutComboBuff)) then
                return A.TigerPalm:Show(icon)
            end
            -- expel_harm,if=buff.gift_of_the_ox.stack>4
            if A.ExpelHarm:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.GiftoftheOxBuff) > 4) then
                return A.ExpelHarm:Show(icon)
            end
            -- blackout_strike
            if A.BlackoutStrike:IsReady(unit) then
                return A.BlackoutStrike:Show(icon)
            end
            -- keg_smash
            if A.KegSmash:IsReady(unit) then
                return A.KegSmash:Show(icon)
            end
            -- concentrated_flame,if=dot.concentrated_flame.remains=0
            if A.ConcentratedFlame:IsReady(unit) and (Unit(unit):HasDeBuffs(A.ConcentratedFlameDebuff) == 0) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- heart_essence,if=!essence.the_crucible_of_flame.major
            if A.HeartEssence:IsReady(unit) and (not bool(essence.the_crucible_of_flame.major)) then
                return A.HeartEssence:Show(icon)
            end
            -- expel_harm,if=buff.gift_of_the_ox.stack>=3
            if A.ExpelHarm:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.GiftoftheOxBuff) >= 3) then
                return A.ExpelHarm:Show(icon)
            end
            -- rushing_jade_wind,if=buff.rushing_jade_wind.down
            if A.RushingJadeWind:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.RushingJadeWindBuff))) then
                return A.RushingJadeWind:Show(icon)
            end
            -- breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&&dot.breath_of_fire_dot.refreshable))
            if A.BreathofFire:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.BlackoutComboBuff)) and (Unit("player"):HasNotHeroism or (Unit("player"):HasHeroism and true and Unit(unit):HasDeBuffsRefreshable(A.BreathofFireDotDebuff)))) then
                return A.BreathofFire:Show(icon)
            end
            -- chi_burst
            if A.ChiBurst:IsReady(unit) then
                return A.ChiBurst:Show(icon)
            end
            -- chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
            -- expel_harm,if=buff.gift_of_the_ox.stack>=2
            if A.ExpelHarm:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.GiftoftheOxBuff) >= 2) then
                return A.ExpelHarm:Show(icon)
            end
            -- tiger_palm,if=!talent.blackout_combo.enabled&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
            if A.TigerPalm:IsReady(unit) and (not A.BlackoutCombo:IsSpellLearned() and A.KegSmash:GetCooldown() > A.GetGCD() and (Unit("player"):EnergyPredicted() + (Unit("player"):EnergyRegen() * (A.KegSmash:GetCooldown() + A.GetGCD()))) >= 65) then
                return A.TigerPalm:Show(icon)
            end
            -- arcane_torrent,if=energy<31
            if A.ArcaneTorrent:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):EnergyPredicted() < 31) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- rushing_jade_wind
            if A.RushingJadeWind:IsReady(unit) then
                return A.RushingJadeWind:Show(icon)
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

