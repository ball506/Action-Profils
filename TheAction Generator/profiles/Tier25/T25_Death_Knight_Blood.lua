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
Action[ACTION_CONST_DEATHKNIGHT_BLOOD] = {
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
    DeathStrike                            = Action.Create({ Type = "Spell", ID = 49998 }),
    BloodDrinker                           = Action.Create({ Type = "Spell", ID = 206931 }),
    DancingRuneWeaponBuff                  = Action.Create({ Type = "Spell", ID = 81256 }),
    Marrowrend                             = Action.Create({ Type = "Spell", ID = 195182 }),
    BoneShieldBuff                         = Action.Create({ Type = "Spell", ID = 195181 }),
    HeartEssence                           = Action.Create({ Type = "Spell", ID = 298554 }),
    BloodBoil                              = Action.Create({ Type = "Spell", ID = 50842 }),
    HemostasisBuff                         = Action.Create({ Type = "Spell", ID = 273947 }),
    Ossuary                                = Action.Create({ Type = "Spell", ID = 219786 }),
    Bonestorm                              = Action.Create({ Type = "Spell", ID = 194844 }),
    Heartbreaker                           = Action.Create({ Type = "Spell", ID = 221536 }),
    DeathandDecay                          = Action.Create({ Type = "Spell", ID = 43265 }),
    RuneStrike                             = Action.Create({ Type = "Spell", ID = 210764 }),
    HeartStrike                            = Action.Create({ Type = "Spell", ID = 206930 }),
    CrimsonScourgeBuff                     = Action.Create({ Type = "Spell", ID = 81141 }),
    RapidDecomposition                     = Action.Create({ Type = "Spell", ID = 194662 }),
    Consumption                            = Action.Create({ Type = "Spell", ID = 205223 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    DancingRuneWeapon                      = Action.Create({ Type = "Spell", ID = 49028 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID =  }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    UnholyStrengthBuff                     = Action.Create({ Type = "Spell", ID = 53365 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    BagofTricks                            = Action.Create({ Type = "Spell", ID =  }),
    Tombstone                              = Action.Create({ Type = "Spell", ID = 219809 })
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
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_BLOOD)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_BLOOD], { __index = Action })





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
        local Precombat, Standard
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
        
        --Standard
        local function Standard(unit)
            -- death_strike,if=runic_power.deficit<=10
            if A.DeathStrike:IsReady(unit) and (Player:RunicPowerDeficit() <= 10) then
                return A.DeathStrike:Show(icon)
            end
            -- blooddrinker,if=!buff.dancing_rune_weapon.up
            if A.BloodDrinker:IsReady(unit) and (not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.BloodDrinker:Show(icon)
            end
            -- marrowrend,if=(buff.bone_shield.remains<=rune.time_to_3|buff.bone_shield.remains<=(gcd+cooldown.blooddrinker.ready*talent.blooddrinker.enabled*2)|buff.bone_shield.stack<3)&runic_power.deficit>=20
            if A.Marrowrend:IsReady(unit) and ((Unit("player"):HasBuffs(A.BoneShieldBuff.ID, true) <= Player:RuneTimeToX(3) or Unit("player"):HasBuffs(A.BoneShieldBuff.ID, true) <= (A.GetGCD() + num(A.BloodDrinker:GetCooldown() == 0) * num(A.BloodDrinker:IsSpellLearned()) * 2) or Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) < 3) and Player:RunicPowerDeficit() >= 20) then
                return A.Marrowrend:Show(icon)
            end
            -- heart_essence,if=!buff.dancing_rune_weapon.up
            if A.HeartEssence:IsReady(unit) and (not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.HeartEssence:Show(icon)
            end
            -- blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
            if A.BloodBoil:IsReady(unit) and (A.BloodBoil:ChargesFractionalP() >= 1.8 and (Unit("player"):HasBuffsStacks(A.HemostasisBuff.ID, true) <= (5 - MultiUnits:GetByRangeInCombat(5, 5, 10)) or MultiUnits:GetByRangeInCombat(5, 5, 10) > 2)) then
                return A.BloodBoil:Show(icon)
            end
            -- marrowrend,if=buff.bone_shield.stack<5&talent.ossuary.enabled&runic_power.deficit>=15
            if A.Marrowrend:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) < 5 and A.Ossuary:IsSpellLearned() and Player:RunicPowerDeficit() >= 15) then
                return A.Marrowrend:Show(icon)
            end
            -- bonestorm,if=runic_power>=100&!buff.dancing_rune_weapon.up
            if A.Bonestorm:IsReady(unit) and (Player:RunicPower() >= 100 and not Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.Bonestorm:Show(icon)
            end
            -- death_strike,if=runic_power.deficit<=(15+buff.dancing_rune_weapon.up*5+spell_targets.heart_strike*talent.heartbreaker.enabled*2)|target.1.time_to_die<10
            if A.DeathStrike:IsReady(unit) and (Player:RunicPowerDeficit() <= (15 + num(Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) * 5 + MultiUnits:GetByRangeInCombat(5, 5, 10) * num(A.Heartbreaker:IsSpellLearned()) * 2) or target.1.time_to_die < 10) then
                return A.DeathStrike:Show(icon)
            end
            -- death_and_decay,if=spell_targets.death_and_decay>=3
            if A.DeathandDecay:IsReady(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3) then
                return A.DeathandDecay:Show(icon)
            end
            -- rune_strike,if=(charges_fractional>=1.8|buff.dancing_rune_weapon.up)&rune.time_to_3>=gcd
            if A.RuneStrike:IsReady(unit) and ((A.RuneStrike:ChargesFractionalP() >= 1.8 or Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) and Player:RuneTimeToX(3) >= A.GetGCD()) then
                return A.RuneStrike:Show(icon)
            end
            -- heart_strike,if=buff.dancing_rune_weapon.up|rune.time_to_4<gcd
            if A.HeartStrike:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) or Player:RuneTimeToX(4) < A.GetGCD()) then
                return A.HeartStrike:Show(icon)
            end
            -- blood_boil,if=buff.dancing_rune_weapon.up
            if A.BloodBoil:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                return A.BloodBoil:Show(icon)
            end
            -- death_and_decay,if=buff.crimson_scourge.up|talent.rapid_decomposition.enabled|spell_targets.death_and_decay>=2
            if A.DeathandDecay:IsReady(unit) and (Unit("player"):HasBuffs(A.CrimsonScourgeBuff.ID, true) or A.RapidDecomposition:IsSpellLearned() or MultiUnits:GetByRangeInCombat(5, 5, 10) >= 2) then
                return A.DeathandDecay:Show(icon)
            end
            -- consumption
            if A.Consumption:IsReady(unit) then
                return A.Consumption:Show(icon)
            end
            -- blood_boil
            if A.BloodBoil:IsReady(unit) then
                return A.BloodBoil:Show(icon)
            end
            -- heart_strike,if=rune.time_to_3<gcd|buff.bone_shield.stack>6
            if A.HeartStrike:IsReady(unit) and (Player:RuneTimeToX(3) < A.GetGCD() or Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) > 6) then
                return A.HeartStrike:Show(icon)
            end
            -- use_item,name=grongs_primal_rage
            if A.GrongsPrimalRage:IsReady(unit) then
                A.GrongsPrimalRage:Show(icon)
            end
            -- rune_strike
            if A.RuneStrike:IsReady(unit) then
                return A.RuneStrike:Show(icon)
            end
            -- arcane_torrent,if=runic_power.deficit>20
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:RunicPowerDeficit() > 20) then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- blood_fury,if=cooldown.dancing_rune_weapon.ready&(!cooldown.blooddrinker.ready|!talent.blooddrinker.enabled)
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.DancingRuneWeapon:GetCooldown() == 0 and (not A.BloodDrinker:GetCooldown() == 0 or not A.BloodDrinker:IsSpellLearned())) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- arcane_pulse,if=active_enemies>=2|rune<1&runic_power.deficit>60
            if A.ArcanePulse:AutoRacial(unit) and Action.GetToggle(1, "Racial") and (MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 or Player:Rune() < 1 and Player:RunicPowerDeficit() > 60) then
                return A.ArcanePulse:Show(icon)
            end
            -- lights_judgment,if=buff.unholy_strength.up
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.UnholyStrengthBuff.ID, true)) then
                return A.LightsJudgment:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- bag_of_tricks
            if A.BagofTricks:IsReady(unit) then
                return A.BagofTricks:Show(icon)
            end
            -- use_items,if=cooldown.dancing_rune_weapon.remains>90
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                A.RazdunksBigRedButton:Show(icon)
            end
            -- use_item,name=merekthas_fang
            if A.MerekthasFang:IsReady(unit) then
                A.MerekthasFang:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true))) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=target.health.pct<31&equipped.dribbling_inkpod
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HealthPercent() < 31 and A.DribblingInkpod:IsExists()) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=buff.dancing_rune_weapon.up&debuff.razor_coral_debuff.up&!equipped.dribbling_inkpod
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true) and Unit(unit):HasDeBuffs(A.RazorCoralDebuff.ID, true) and not A.DribblingInkpod:IsExists()) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- potion,if=buff.dancing_rune_weapon.up
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.DancingRuneWeaponBuff.ID, true)) then
                A.BattlePotionofStrength:Show(icon)
            end
            -- dancing_rune_weapon,if=!talent.blooddrinker.enabled|!cooldown.blooddrinker.ready
            if A.DancingRuneWeapon:IsReady(unit) and A.BurstIsON(unit) and (not A.BloodDrinker:IsSpellLearned() or not A.BloodDrinker:GetCooldown() == 0) then
                return A.DancingRuneWeapon:Show(icon)
            end
            -- tombstone,if=buff.bone_shield.stack>=7
            if A.Tombstone:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.BoneShieldBuff.ID, true) >= 7) then
                return A.Tombstone:Show(icon)
            end
            -- call_action_list,name=standard
            if (true) then
                local ShouldReturn = Standard(unit); if ShouldReturn then return ShouldReturn; end
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

