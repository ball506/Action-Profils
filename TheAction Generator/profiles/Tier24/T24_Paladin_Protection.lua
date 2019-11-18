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
Action[ACTION_CONST_PALADIN_PROTECTION] = {
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
    -- Generics
    ConsecrationBuff                       = Action.Create({ Type = "Spell", ID = 188370 }),
    Consecration                           = Action.Create({ Type = "Spell", ID = 26573 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AvengingWrathBuff                      = Action.Create({ Type = "Spell", ID = 31884 }),
    Seraphim                               = Action.Create({ Type = "Spell", ID = 152262 }),
    ShieldoftheRighteous                   = Action.Create({ Type = "Spell", ID = 53600 }),
    AvengingWrath                          = Action.Create({ Type = "Spell", ID = 31884 }),
    SeraphimBuff                           = Action.Create({ Type = "Spell", ID = 152262 }),
    BastionofLight                         = Action.Create({ Type = "Spell", ID = 204035 }),
    Judgment                               = Action.Create({ Type = "Spell", ID = 20271 }),
    AvengersShield                         = Action.Create({ Type = "Spell", ID = 31935 }),
    LifebloodBuff                          = Action.Create({ Type = "Spell", ID = 295078 }),
    AvengersValorBuff                      = Action.Create({ Type = "Spell", ID =  }),
    CrusadersJudgment                      = Action.Create({ Type = "Spell", ID =  }),
    TheCrucibleofFlame                     = Action.Create({ Type = "Spell", ID =  }),
    AnimaofDeath                           = Action.Create({ Type = "Spell", ID =  }),
    BlessedHammer                          = Action.Create({ Type = "Spell", ID = 204019 }),
    HammeroftheRighteous                   = Action.Create({ Type = "Spell", ID = 53595 }),
    HeartEssence                           = Action.Create({ Type = "Spell", ID = 298554 }),
    AnimaofLifeandDeath                    = Action.Create({ Type = "Spell", ID =  })
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
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
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
Action:CreateEssencesFor(ACTION_CONST_PALADIN_PROTECTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_PROTECTION], { __index = Action })





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
        local Precombat, Cooldowns
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.BattlePotionofStamina:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStamina:Show(icon)
            end
            -- consecration
            if A.Consecration:IsReady(unit) and Unit("player"):HasBuffsDown(A.ConsecrationBuff.ID, true) then
                return A.Consecration:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- fireblood,if=buff.avenging_wrath.up
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true)) then
                return A.Fireblood:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=cooldown.seraphim.remains<=10|!talent.seraphim.enabled
            if A.AzsharasFontofPower:IsReady(unit) and (A.Seraphim:GetCooldown() <= 10 or not A.Seraphim:IsSpellLearned()) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=(debuff.razor_coral_debuff.stack>7&buff.avenging_wrath.up)|debuff.razor_coral_debuff.stack=0
            if A.AshvanesRazorCoral:IsReady(unit) and ((Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 7 and Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true)) or Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- seraphim,if=cooldown.shield_of_the_righteous.charges_fractional>=2
            if A.Seraphim:IsReady(unit) and (A.ShieldoftheRighteous:ChargesFractionalP() >= 2) then
                return A.Seraphim:Show(icon)
            end
            -- avenging_wrath,if=buff.seraphim.up|cooldown.seraphim.remains<2|!talent.seraphim.enabled
            if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) or A.Seraphim:GetCooldown() < 2 or not A.Seraphim:IsSpellLearned()) then
                return A.AvengingWrath:Show(icon)
            end
            -- memory_of_lucid_dreams,if=!talent.seraphim.enabled|cooldown.seraphim.remains<=gcd|buff.seraphim.up
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (not A.Seraphim:IsSpellLearned() or A.Seraphim:GetCooldown() <= A.GetGCD() or Unit("player"):HasBuffs(A.SeraphimBuff.ID, true)) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- bastion_of_light,if=cooldown.shield_of_the_righteous.charges_fractional<=0.5
            if A.BastionofLight:IsReady(unit) and (A.ShieldoftheRighteous:ChargesFractionalP() <= 0.5) then
                return A.BastionofLight:Show(icon)
            end
            -- potion,if=buff.avenging_wrath.up
            if A.BattlePotionofStamina:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true)) then
                A.BattlePotionofStamina:Show(icon)
            end
            -- use_items,if=buff.seraphim.up|!talent.seraphim.enabled
            -- use_item,name=grongs_primal_rage,if=cooldown.judgment.full_recharge_time>4&cooldown.avengers_shield.remains>4&(buff.seraphim.up|cooldown.seraphim.remains+4+gcd>expected_combat_length-time)&consecration.up
            if A.GrongsPrimalRage:IsReady(unit) and (A.Judgment:FullRechargeTimeP() > 4 and A.AvengersShield:GetCooldown() > 4 and (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) or A.Seraphim:GetCooldown() + 4 + A.GetGCD() > expected_combat_length - Unit("player"):CombatTime()) and bool(consecration.up)) then
                A.GrongsPrimalRage:Show(icon)
            end
            -- use_item,name=pocketsized_computation_device,if=cooldown.judgment.full_recharge_time>4*spell_haste&cooldown.avengers_shield.remains>4*spell_haste&(!equipped.grongs_primal_rage|!trinket.grongs_primal_rage.cooldown.up)&consecration.up
            if A.PocketsizedComputationDevice:IsReady(unit) and (A.Judgment:FullRechargeTimeP() > 4 * Player:SpellHaste() and A.AvengersShield:GetCooldown() > 4 * Player:SpellHaste() and (not A.GrongsPrimalRage:IsExists() or not bool(trinket.grongs_primal_rage.cooldown.up)) and bool(consecration.up)) then
                A.PocketsizedComputationDevice:Show(icon)
            end
            -- use_item,name=merekthas_fang,if=!buff.avenging_wrath.up&(buff.seraphim.up|!talent.seraphim.enabled)
            if A.MerekthasFang:IsReady(unit) and (not Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) and (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) or not A.Seraphim:IsSpellLearned())) then
                A.MerekthasFang:Show(icon)
            end
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                A.RazdunksBigRedButton:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- call_action_list,name=cooldowns
            if (true) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
            -- shield_of_the_righteous,if=(buff.avengers_valor.up&cooldown.shield_of_the_righteous.charges_fractional>=2.5)&(cooldown.seraphim.remains>gcd|!talent.seraphim.enabled)
            if A.ShieldoftheRighteous:IsReady(unit) and ((Unit("player"):HasBuffs(A.AvengersValorBuff.ID, true) and A.ShieldoftheRighteous:ChargesFractionalP() >= 2.5) and (A.Seraphim:GetCooldown() > A.GetGCD() or not A.Seraphim:IsSpellLearned())) then
                return A.ShieldoftheRighteous:Show(icon)
            end
            -- shield_of_the_righteous,if=(buff.avenging_wrath.up&!talent.seraphim.enabled)|buff.seraphim.up&buff.avengers_valor.up
            if A.ShieldoftheRighteous:IsReady(unit) and ((Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) and not A.Seraphim:IsSpellLearned()) or Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) and Unit("player"):HasBuffs(A.AvengersValorBuff.ID, true)) then
                return A.ShieldoftheRighteous:Show(icon)
            end
            -- shield_of_the_righteous,if=(buff.avenging_wrath.up&buff.avenging_wrath.remains<4&!talent.seraphim.enabled)|(buff.seraphim.remains<4&buff.seraphim.up)
            if A.ShieldoftheRighteous:IsReady(unit) and ((Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) and Unit("player"):HasBuffs(A.AvengingWrathBuff.ID, true) < 4 and not A.Seraphim:IsSpellLearned()) or (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) < 4 and Unit("player"):HasBuffs(A.SeraphimBuff.ID, true))) then
                return A.ShieldoftheRighteous:Show(icon)
            end
            -- lights_judgment,if=buff.seraphim.up&buff.seraphim.remains<3
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) and Unit("player"):HasBuffs(A.SeraphimBuff.ID, true) < 3) then
                return A.LightsJudgment:Show(icon)
            end
            -- consecration,if=!consecration.up
            if A.Consecration:IsReady(unit) and (not bool(consecration.up)) then
                return A.Consecration:Show(icon)
            end
            -- judgment,if=(cooldown.judgment.remains<gcd&cooldown.judgment.charges_fractional>1&cooldown_react)|!talent.crusaders_judgment.enabled
            if A.Judgment:IsReady(unit) and ((A.Judgment:GetCooldown() < A.GetGCD() and A.Judgment:ChargesFractionalP() > 1 and A.Judgment:GetCooldown() == 0) or not A.CrusadersJudgment:IsSpellLearned()) then
                return A.Judgment:Show(icon)
            end
            -- avengers_shield,if=cooldown_react
            if A.AvengersShield:IsReady(unit) and (A.AvengersShield:GetCooldown() == 0) then
                return A.AvengersShield:Show(icon)
            end
            -- judgment,if=cooldown_react|!talent.crusaders_judgment.enabled
            if A.Judgment:IsReady(unit) and (A.Judgment:GetCooldown() == 0 or not A.CrusadersJudgment:IsSpellLearned()) then
                return A.Judgment:Show(icon)
            end
            -- concentrated_flame,if=(!talent.seraphim.enabled|buff.seraphim.up)&!dot.concentrated_flame_burn.remains>0|essence.the_crucible_of_flame.rank<3
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and ((not A.Seraphim:IsSpellLearned() or Unit("player"):HasBuffs(A.SeraphimBuff.ID, true)) and num(not bool(Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true))) > 0 or A.TheCrucibleofFlame:GetRank() < 3) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- lights_judgment,if=!talent.seraphim.enabled|buff.seraphim.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (not A.Seraphim:IsSpellLearned() or Unit("player"):HasBuffs(A.SeraphimBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            -- anima_of_death
            if A.AnimaofDeath:IsReady(unit) then
                return A.AnimaofDeath:Show(icon)
            end
            -- blessed_hammer,strikes=3
            if A.BlessedHammer:IsReady(unit) then
                return A.BlessedHammer:Show(icon)
            end
            -- hammer_of_the_righteous
            if A.HammeroftheRighteous:IsReady(unit) then
                return A.HammeroftheRighteous:Show(icon)
            end
            -- consecration
            if A.Consecration:IsReady(unit) then
                return A.Consecration:Show(icon)
            end
            -- heart_essence,if=!(essence.the_crucible_of_flame.major|essence.worldvein_resonance.major|essence.anima_of_life_and_death.major|essence.memory_of_lucid_dreams.major)
            if A.HeartEssence:IsReady(unit) and (not (bool(Azerite:EssenceHasMajor(A.TheCrucibleofFlame.ID)) or bool(Azerite:EssenceHasMajor(A.WorldveinResonance.ID)) or bool(Azerite:EssenceHasMajor(A.AnimaofLifeandDeath.ID)) or bool(Azerite:EssenceHasMajor(A.MemoryofLucidDreams.ID)))) then
                return A.HeartEssence:Show(icon)
            end
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
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
end]]--

