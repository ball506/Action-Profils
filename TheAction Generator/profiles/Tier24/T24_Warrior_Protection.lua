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
Action[ACTION_CONST_WARRIOR_PROTECTION] = {
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
    ThunderClap                            = Action.Create({ Type = "Spell", ID = 6343 }),
    AvatarBuff                             = Action.Create({ Type = "Spell", ID = 107574 }),
    DemoralizingShout                      = Action.Create({ Type = "Spell", ID = 1160 }),
    BoomingVoice                           = Action.Create({ Type = "Spell", ID = 202743 }),
    AnimaofDeath                           = Action.Create({ Type = "Spell", ID =  }),
    LastStandBuff                          = Action.Create({ Type = "Spell", ID =  }),
    DragonRoar                             = Action.Create({ Type = "Spell", ID = 118000 }),
    Revenge                                = Action.Create({ Type = "Spell", ID = 6572 }),
    Ravager                                = Action.Create({ Type = "Spell", ID = 228920 }),
    ShieldBlock                            = Action.Create({ Type = "Spell", ID = 2565 }),
    ShieldSlam                             = Action.Create({ Type = "Spell", ID = 23922 }),
    ShieldBlockBuff                        = Action.Create({ Type = "Spell", ID = 132404 }),
    UnstoppableForce                       = Action.Create({ Type = "Spell", ID = 275336 }),
    Avatar                                 = Action.Create({ Type = "Spell", ID = 107574 }),
    Devastate                              = Action.Create({ Type = "Spell", ID = 20243 }),
    Intercept                              = Action.Create({ Type = "Spell", ID = 198304 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    IgnorePain                             = Action.Create({ Type = "Spell", ID = 190456 }),
    TheCrucibleofFlame                     = Action.Create({ Type = "Spell", ID =  }),
    LastStand                              = Action.Create({ Type = "Spell", ID =  })
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
Action:CreateEssencesFor(ACTION_CONST_WARRIOR_PROTECTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_PROTECTION], { __index = Action })





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


local function EvaluateCycleAshvanesRazorCoral82(unit)
    return Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0
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
        local Precombat, Aoe, St
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
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- potion
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofStrength:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
            -- thunder_clap
            if A.ThunderClap:IsReady(unit) then
                return A.ThunderClap:Show(icon)
            end
            -- memory_of_lucid_dreams,if=buff.avatar.down
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (bool(Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true))) then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- demoralizing_shout,if=talent.booming_voice.enabled
            if A.DemoralizingShout:IsReady(unit) and (A.BoomingVoice:IsSpellLearned()) then
                return A.DemoralizingShout:Show(icon)
            end
            -- anima_of_death,if=buff.last_stand.up
            if A.AnimaofDeath:IsReady(unit) and (Unit("player"):HasBuffs(A.LastStandBuff.ID, true)) then
                return A.AnimaofDeath:Show(icon)
            end
            -- dragon_roar
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
                return A.DragonRoar:Show(icon)
            end
            -- revenge
            if A.Revenge:IsReady(unit) then
                return A.Revenge:Show(icon)
            end
            -- use_item,name=grongs_primal_rage,if=buff.avatar.down|cooldown.thunder_clap.remains>=4
            if A.GrongsPrimalRage:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true)) or A.ThunderClap:GetCooldown() >= 4) then
                A.GrongsPrimalRage:Show(icon)
            end
            -- ravager
            if A.Ravager:IsReady(unit) then
                return A.Ravager:Show(icon)
            end
            -- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down
            if A.ShieldBlock:IsReady(unit) and (A.ShieldSlam:GetCooldown() == 0 and bool(Unit("player"):HasBuffsDown(A.ShieldBlockBuff.ID, true))) then
                return A.ShieldBlock:Show(icon)
            end
            -- shield_slam
            if A.ShieldSlam:IsReady(unit) then
                return A.ShieldSlam:Show(icon)
            end
        end
        
        --St
        local function St(unit)
            -- thunder_clap,if=spell_targets.thunder_clap=2&talent.unstoppable_force.enabled&buff.avatar.up
            if A.ThunderClap:IsReady(unit) and (MultiUnits:GetByRangeInCombat(5, 5, 10) == 2 and A.UnstoppableForce:IsSpellLearned() and Unit("player"):HasBuffs(A.AvatarBuff.ID, true)) then
                return A.ThunderClap:Show(icon)
            end
            -- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down
            if A.ShieldBlock:IsReady(unit) and (A.ShieldSlam:GetCooldown() == 0 and bool(Unit("player"):HasBuffsDown(A.ShieldBlockBuff.ID, true))) then
                return A.ShieldBlock:Show(icon)
            end
            -- shield_slam,if=buff.shield_block.up
            if A.ShieldSlam:IsReady(unit) and (Unit("player"):HasBuffs(A.ShieldBlockBuff.ID, true)) then
                return A.ShieldSlam:Show(icon)
            end
            -- thunder_clap,if=(talent.unstoppable_force.enabled&buff.avatar.up)
            if A.ThunderClap:IsReady(unit) and ((A.UnstoppableForce:IsSpellLearned() and Unit("player"):HasBuffs(A.AvatarBuff.ID, true))) then
                return A.ThunderClap:Show(icon)
            end
            -- demoralizing_shout,if=talent.booming_voice.enabled
            if A.DemoralizingShout:IsReady(unit) and (A.BoomingVoice:IsSpellLearned()) then
                return A.DemoralizingShout:Show(icon)
            end
            -- anima_of_death,if=buff.last_stand.up
            if A.AnimaofDeath:IsReady(unit) and (Unit("player"):HasBuffs(A.LastStandBuff.ID, true)) then
                return A.AnimaofDeath:Show(icon)
            end
            -- shield_slam
            if A.ShieldSlam:IsReady(unit) then
                return A.ShieldSlam:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,target_if=debuff.razor_coral_debuff.stack=0
            if A.AshvanesRazorCoral:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.AshvanesRazorCoral, 40, "min", EvaluateCycleAshvanesRazorCoral82) then
                    return A.AshvanesRazorCoral:Show(icon) 
                end
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.stack>7&(cooldown.avatar.remains<5|buff.avatar.up)
            if A.AshvanesRazorCoral:IsReady(unit) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 7 and (A.Avatar:GetCooldown() < 5 or Unit("player"):HasBuffs(A.AvatarBuff.ID, true))) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- dragon_roar
            if A.DragonRoar:IsReady(unit) and A.BurstIsON(unit) then
                return A.DragonRoar:Show(icon)
            end
            -- thunder_clap
            if A.ThunderClap:IsReady(unit) then
                return A.ThunderClap:Show(icon)
            end
            -- revenge
            if A.Revenge:IsReady(unit) then
                return A.Revenge:Show(icon)
            end
            -- use_item,name=grongs_primal_rage,if=buff.avatar.down|cooldown.shield_slam.remains>=4
            if A.GrongsPrimalRage:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true)) or A.ShieldSlam:GetCooldown() >= 4) then
                A.GrongsPrimalRage:Show(icon)
            end
            -- ravager
            if A.Ravager:IsReady(unit) then
                return A.Ravager:Show(icon)
            end
            -- devastate
            if A.Devastate:IsReady(unit) then
                return A.Devastate:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- auto_attack
            -- intercept,if=time=0
            if A.Intercept:IsReady(unit) and (Unit("player"):CombatTime() == 0) then
                return A.Intercept:Show(icon)
            end
            -- use_items,if=cooldown.avatar.remains<=gcd|buff.avatar.up
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- arcane_torrent
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
            -- potion,if=buff.avatar.up|target.time_to_die<25
            if A.BattlePotionofStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.AvatarBuff.ID, true) or Unit(unit):TimeToDie() < 25) then
                A.BattlePotionofStrength:Show(icon)
            end
            -- ignore_pain,if=rage.deficit<25+20*talent.booming_voice.enabled*cooldown.demoralizing_shout.ready
            if A.IgnorePain:IsReady(unit) and (Player:RageDeficit() < 25 + 20 * num(A.BoomingVoice:IsSpellLearned()) * num(A.DemoralizingShout:GetCooldown() == 0)) then
                return A.IgnorePain:Show(icon)
            end
            -- worldvein_resonance,if=cooldown.avatar.remains<=2
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (A.Avatar:GetCooldown() <= 2) then
                return A.WorldveinResonance:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
            -- concentrated_flame,if=buff.avatar.down&!dot.concentrated_flame_burn.remains>0|essence.the_crucible_of_flame.rank<3
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (bool(Unit("player"):HasBuffsDown(A.AvatarBuff.ID, true)) and num(not bool(Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true))) > 0 or A.TheCrucibleofFlame:GetRank() < 3) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- last_stand,if=cooldown.anima_of_death.remains<=2
            if A.LastStand:IsReady(unit) and (A.AnimaofDeath:GetCooldown() <= 2) then
                return A.LastStand:Show(icon)
            end
            -- avatar
            if A.Avatar:IsReady(unit) and A.BurstIsON(unit) then
                return A.Avatar:Show(icon)
            end
            -- run_action_list,name=aoe,if=spell_targets.thunder_clap>=3
            if (MultiUnits:GetByRangeInCombat(5, 5, 10) >= 3) then
                return Aoe(unit);
            end
            -- call_action_list,name=st
            if (true) then
                local ShouldReturn = St(unit); if ShouldReturn then return ShouldReturn; end
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

