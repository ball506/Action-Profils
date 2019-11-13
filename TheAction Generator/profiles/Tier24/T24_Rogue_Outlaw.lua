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
Action[ACTION_CONST_ROGUE_OUTLAW] = {
    MarkedForDeath                         = Action.Create({Type = "Spell", ID = 137619 }),
    RolltheBones                           = Action.Create({Type = "Spell", ID = 193316 }),
    SliceandDiceBuff                       = Action.Create({Type = "Spell", ID = 5171 }),
    SliceandDice                           = Action.Create({Type = "Spell", ID = 5171 }),
    AdrenalineRushBuff                     = Action.Create({Type = "Spell", ID = 13750 }),
    AdrenalineRush                         = Action.Create({Type = "Spell", ID = 13750 }),
    PistolShot                             = Action.Create({Type = "Spell", ID = 185763 }),
    OpportunityBuff                        = Action.Create({Type = "Spell", ID = 195627 }),
    KeepYourWitsAboutYouBuff               = Action.Create({Type = "Spell", ID = 202895 }),
    DeadshotBuff                           = Action.Create({Type = "Spell", ID = 272940 }),
    SinisterStrike                         = Action.Create({Type = "Spell", ID = 193315 }),
    LatentArcana                           = Action.Create({Type = "Spell", ID = 296962 }),
    BladeFlurry                            = Action.Create({Type = "Spell", ID = 13877 }),
    BladeFlurryBuff                        = Action.Create({Type = "Spell", ID = 13877 }),
    GhostlyStrike                          = Action.Create({Type = "Spell", ID = 196937 }),
    BroadsideBuff                          = Action.Create({Type = "Spell", ID = 193356 }),
    KillingSpree                           = Action.Create({Type = "Spell", ID = 51690 }),
    BladeRush                              = Action.Create({Type = "Spell", ID = 271877 }),
    Vanish                                 = Action.Create({Type = "Spell", ID = 1856 }),
    Shadowmeld                             = Action.Create({Type = "Spell", ID = 58984 }),
    BloodFury                              = Action.Create({Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
    Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({Type = "Spell", ID = 274738 }),
    MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
    BetweentheEyes                         = Action.Create({Type = "Spell", ID = 199804 }),
    LifebloodBuff                          = Action.Create({Type = "Spell", ID = 295078 }),
    RolltheBonesBuff                       = Action.Create({Type = "Spell", ID =  }),
    AceUpYourSleeve                        = Action.Create({Type = "Spell", ID =  }),
    Deadshot                               = Action.Create({Type = "Spell", ID = 272936 }),
    Dispatch                               = Action.Create({Type = "Spell", ID =  }),
    Ambush                                 = Action.Create({Type = "Spell", ID = 8676 }),
    LoadedDiceBuff                         = Action.Create({Type = "Spell", ID = 240837 }),
    GrandMeleeBuff                         = Action.Create({Type = "Spell", ID =  }),
    RuthlessPrecisionBuff                  = Action.Create({Type = "Spell", ID =  }),
    SnakeEyes                              = Action.Create({Type = "Spell", ID =  }),
    SnakeEyesBuff                          = Action.Create({Type = "Spell", ID =  }),
    SkullandCrossbonesBuff                 = Action.Create({Type = "Spell", ID =  }),
    QuickDraw                              = Action.Create({Type = "Spell", ID = 196938 }),
    ArcaneTorrent                          = Action.Create({Type = "Spell", ID = 50613 }),
    ArcanePulse                            = Action.Create({Type = "Spell", ID =  }),
    LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 })
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
Action:CreateEssencesFor(ACTION_CONST_ROGUE_OUTLAW)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_ROGUE_OUTLAW], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarBladeFlurrySync = 0;
local VarAmbushCondition = 0;
local VarBteCondition = 0;
local VarRtbReroll = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarBladeFlurrySync = 0
  VarAmbushCondition = 0
  VarBteCondition = 0
  VarRtbReroll = 0
end)



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

-- cp_max_spend
local function CPMaxSpend()
    -- Should work for all 3 specs since they have same Deeper Stratagem Spell ID.
    return A.DeeperStratagem:IsAvailable() and 6 or 5;
end

-- "cp_spend"
local function CPSpend()
    return mathmin(Unit("player"):ComboPoints(), CPMaxSpend());
end

-- Crimson Vial
function CrimsonVial(CrimsonVial)
    if CrimsonVial:IsCastable() and Unit("player"):HealthPercentage() <= Action.GetToggle(2, "CrimsonVialHP") then
        if HR.Cast(CrimsonVial, Action.GetToggle(2, "GCDasOffGCD"):Show(icon)Cast Crimson Vial (Defensives)"; end
    end
    return false;
end

-- Feint
function Feint(Feint)
    if Feint:IsCastable() and not Unit("player"):Buff(Feint) and Unit("player"):HealthPercentage() <= Action.GetToggle(2, "FeintHP") then
        if HR.Cast(Feint, Action.GetToggle(2, "GCDasOffGCD"):Show(icon)Cast Feint (Defensives)"; end
    end
end

-- APL Action Lists (and Variables)
local SappedSoulSpells = {
    {A.Kick, "Cast Kick (Sapped Soul)", function () return Unit(unit):IsInRange(A.SinisterStrike); end},
    {A.Feint, "Cast Feint (Sapped Soul)", function () return true; end},
    {A.CrimsonVial, "Cast Crimson Vial (Sapped Soul)", function () return true; end}
};
local RtB_BuffsList = {
    A.Broadside,
    A.BuriedTreasure,
    A.GrandMelee,
    A.RuthlessPrecision,
    A.SkullandCrossbones,
    A.TrueBearing
};
local function RtB_List (Type, List)
    if not Cache.APLVar.RtB_List then Cache.APLVar.RtB_List = {}; end
    if not Cache.APLVar.RtB_List[Type] then Cache.APLVar.RtB_List[Type] = {}; end
    local Sequence = table.concat(List);
    -- All
    if Type == "All" then
        if not Cache.APLVar.RtB_List[Type][Sequence] then
            local Count = 0;
            for i = 1, #List do
                if Unit("player"):Buff(RtB_BuffsList[List[i]]) then
                    Count = Count + 1;
                end
            end
            Cache.APLVar.RtB_List[Type][Sequence] = Count == #List and true or false;
        end
    -- Any
    else
        if not Cache.APLVar.RtB_List[Type][Sequence] then
            Cache.APLVar.RtB_List[Type][Sequence] = false;
            for i = 1, #List do
                if Unit("player"):Buff(RtB_BuffsList[List[i]]) then
                    Cache.APLVar.RtB_List[Type][Sequence] = true;
                break;
                end
            end
        end
    end
    return Cache.APLVar.RtB_List[Type][Sequence];
end
local function RtB_BuffRemains()
    if not Cache.APLVar.RtB_BuffRemains then
        Cache.APLVar.RtB_BuffRemains = 0;
        for i = 1, #RtB_BuffsList do
            if Unit("player"):Buff(RtB_BuffsList[i]) then
                Cache.APLVar.RtB_BuffRemains = Unit("player"):BuffRemainsP(RtB_BuffsList[i]);
                break;
            end
        end
    end
    return Cache.APLVar.RtB_BuffRemains;
end
-- Get the number of Roll the Bones buffs currently on
local function RtB_Buffs()
    if not Cache.APLVar.RtB_Buffs then
        Cache.APLVar.RtB_Buffs = 0;
        for i = 1, #RtB_BuffsList do
            if Unit("player"):HasBuffs(RtB_BuffsList[i]) then
                Cache.APLVar.RtB_Buffs = Cache.APLVar.RtB_Buffs + 1;
            end
        end
    end
    return Cache.APLVar.RtB_Buffs;
end

local function CheckGoodBuffs()
    local choice = Action.GetToggle(2, "RolltheBonesLogic")
    local GotGoodBuff = false
	
    if choice == "1BUFF" then
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and RtB_Buffs() <= 0) and true or false;
    elseif choice == "MYTHICPLUS" then
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and (not Unit("player"):HasBuffs(A.RuthlessPrecision) and not Unit("player"):HasBuffs(A.GrandMelee) and not Unit("player"):HasBuffs(A.Broadside)) and not (RtB_Buffs() >= 2)) and true or false
    elseif choice == "AOESTRAT" then   
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and (not Unit("player"):HasBuffs(A.RuthlessPrecision) and not Unit("player"):HasBuffs(A.GrandMelee) and not Unit("player"):HasBuffs(A.Broadside)) and not (RtB_Buffs() >= 2)) and true or false
    elseif choice == "BROADSIDE" then  
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and not Unit("player"):HasBuffs(A.Broadside) and true) or false;
    elseif choice == "BURIEDTREASURE" then  
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and not Unit("player"):HasBuffs(A.BuriedTreasure) and true) or false;
    elseif choice == "GRANDMELEE" then  
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and not Unit("player"):HasBuffs(A.GrandMelee) and true) or false;
    elseif choice == "SKULLANDCROSS" then  
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and not Unit("player"):HasBuffs(A.SkullandCrossbones) and true) or false;
    elseif choice == "RUTHLESSPRECISION" then  
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and not Unit("player"):HasBuffs(A.RuthlessPrecision) and true) or false;
    elseif choice == "TRUEBEARING" then  
        GotGoodBuff = (not A.SliceandDice:IsAvailable() and not Unit("player"):HasBuffs(A.TrueBearing) and true) or false;
	else
        return
    end
    return GotGoodBuff
end

-- RtB rerolling strategy, return true if we should reroll
local function RtB_Reroll()

    if not Cache.APLVar.RtB_Reroll then
	
        -- Defensive Override : Grand Melee if HP < 60
        if Action.GetToggle(2, "SoloMode") and Unit("player"):HealthPercentage() < Action.GetToggle(2, "RolltheBonesLeechHP") then
            Cache.APLVar.RtB_Reroll = (not A.SliceandDice:IsAvailable() and not Unit("player"):HasBuffs(A.GrandMelee)) and true or false;
        -- 1+ Buff
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "1BUFF" then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- Mythic+
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "MYTHICPLUS" then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- Broadside
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "AOESTRAT" and Cache.EnemiesCount[BladeFlurryRange] >= 2 or (not Unit(unit):IsInBossList()) then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- Broadside
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "BROADSIDE" then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- Buried Treasure
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "BURIEDTREASURE" then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- Grand Melee
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "GRANDMELEE" then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- Skull and Crossbones
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "SKULLANDCROSS" then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- Ruthless Precision
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "RUTHLESSPRECISION" then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- True Bearing
        elseif Action.GetToggle(2, "RolltheBonesLogic") == "TRUEBEARING" then
            Cache.APLVar.RtB_Reroll = CheckGoodBuffs()
        -- SimC Default
        else
        -- # Reroll for 2+ buffs with Loaded Dice up. Otherwise reroll for 2+ or Grand Melee or Ruthless Precision.
        -- actions=variable,name=rtb_reroll,value=rtb_buffs<2&(buff.loaded_dice.up|!buff.grand_melee.up&!buff.ruthless_precision.up)
        -- # Reroll for 2+ buffs or Ruthless Precision with Deadshot Rank 2+.
        -- actions+=/variable,name=rtb_reroll,op=set,if=azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled,value=rtb_buffs<2&(buff.loaded_dice.up|buff.ruthless_precision.remains<=cooldown.between_the_eyeA.remains)
        -- # Always reroll for 2+ buffs with Snake EyeA.
        -- actions+=/variable,name=rtb_reroll,op=set,if=azerite.snake_eyeA.rank>=2,value=rtb_buffs<2
        -- actions+=/variable,name=rtb_reroll,op=set,if=buff.blade_flurry.up,value=rtb_buffs-buff.skull_and_crossboneA.up<2&(buff.loaded_dice.up|!buff.grand_melee.up&!buff.ruthless_precision.up&!buff.broadside.up)
            if Unit("player"):HasBuffs(A.BladeFlurry) then
                Cache.APLVar.RtB_Reroll = (RtB_Buffs() - num(Unit("player"):HasBuffs(A.SkullandCrossbones)) < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff) or
                (not Unit("player"):HasBuffs(A.GrandMelee) and not Unit("player"):HasBuffs(A.RuthlessPrecision) and not Unit("player"):HasBuffs(A.Broadside)))) and true or false;
            elseif A.SnakeEyesPower:AzeriteRank() >= 2 then
                Cache.APLVar.RtB_Reroll = (RtB_Buffs() < 2) and true or false;
                -- # Do not reroll if Snake Eyes is at 2+ stacks of the buff (1+ stack with Broadside up)
                -- actions+=/variable,name=rtb_reroll,op=reset,if=azerite.snake_eyeA.rank>=2&buff.snake_eyeA.stack>=2-buff.broadside.up
                if Unit("player"):BuffStackP(A.SnakeEyesBuff) >= 2 - num(Unit("player"):HasBuffs(A.Broadside)) then
                    Cache.APLVar.RtB_Reroll = false;
                end
            elseif A.Deadshot:AzeriteEnabled() or A.AceUpYourSleeve:AzeriteEnabled() then
                Cache.APLVar.RtB_Reroll = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff) or
                Unit("player"):BuffRemainsP(A.RuthlessPrecision) <= A.BetweentheEyes:CooldownRemainsP())) and true or false;
            else
                Cache.APLVar.RtB_Reroll = (RtB_Buffs() < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff) or
               (not Unit("player"):HasBuffs(A.GrandMelee) and not Unit("player"):HasBuffs(A.RuthlessPrecision)))) and true or false;
            end
			return false
        end
    end
    return Cache.APLVar.RtB_Reroll;
end
-- # Condition to use Stealth cooldowns for Ambush
local function Ambush_Condition ()
    -- actions+=/variable,name=ambush_condition,value=combo_pointA.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossboneA.up&!buff.keep_your_wits_about_you.up
    return Unit("player"):ComboPointsDeficit() >= 2 + 2 * ((A.GhostlyStrike:IsAvailable() and A.GhostlyStrike:CooldownRemainsP() < 1) and 1 or 0)
    + (Unit("player"):Buff(A.Broadside) and 1 or 0) and Unit("player"):EnergyPredicted() > 60 and not Unit("player"):Buff(A.SkullandCrossbones) and not Unit("player"):HasBuffs(A.KeepYourWitsBuff);
end
-- actions+=/variable,name=bte_condition,value=buff.ruthless_precision.up|(azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled)&buff.roll_the_boneA.up
local function BtECondition ()
    return Unit("player"):HasBuffs(A.RuthlessPrecision) or (A.Deadshot:AzeriteEnabled() or A.AceUpYourSleeve:AzeriteEnabled()) and RtB_Buffs() >= 1;
end
-- # With multiple targets, this variable is checked to decide whether some CDs should be synced with Blade Flurry
-- actions+=/variable,name=blade_flurry_sync,value=spell_targetA.blade_flurry<2&raid_event.addA.in>20|buff.blade_flurry.up
local function Blade_Flurry_Sync ()
    return not Action.GetToggle(2,"AoE") or Cache.EnemiesCount[BladeFlurryRange] < 2 or Unit("player"):HasBuffs(A.BladeFlurry)
end

local function EnergyTimeToMaxRounded ()
    -- Round to the nearesth 10th to reduce prediction instability on very high regen rates
    return math.floor(Unit("player"):EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end

-- Marked for Death Sniping
local BestUnit, BestUnitTTD;
local function MfDSniping (MarkedforDeath)
    if MarkedforDeath:IsCastable() then
        -- Get Units up to 30y for MfD.
        HL.GetEnemies(30);

        BestUnit, BestUnitTTD = nil, 60;
        local MOTTD = MouseOver:IsInRange(30) and MouseOver:TimeToDie() or 11111;
        local TTD;
        for _, Unit in pairs(Cache.Enemies[30]) do
            TTD = Unit:TimeToDie();
            -- Note: Increased the SimC condition by 50% since we are slower.
            if not Unit:IsMfdBlacklisted() and TTD < Unit("player"):ComboPointsDeficit()*1.5 and TTD < BestUnitTTD then
                if MOTTD - TTD > 1 then
                    BestUnit, BestUnitTTD = Unit, TTD;
                else
                   BestUnit, BestUnitTTD = MouseOver, MOTTD;
                end
            end
        end
        if BestUnit and BestUnit:GUID() ~= Unit(unit):GUID() then
            HR.CastLeftNameplate(BestUnit, MarkedforDeath);
        end
    end
end


local function EvaluateTargetIfFilterMarkedForDeath55(unit)
  return Unit(unit):TimeToDie()
end

local function EvaluateTargetIfMarkedForDeath60(unit)
  return (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1) and (Unit(unit):TimeToDie() < Player:ComboPointsDeficit() or not Unit("player"):IsStealthed(true, false) and Player:ComboPointsDeficit() >= CPMaxSpend() - 1)
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
        local Precombat, Build, Cds, Essences, Finish, Stealth
        --Precombat
        local function Precombat(unit)
            -- flask
            -- augmentation
            -- food
            -- snapshot_stats
            -- potion
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.ProlongedPower:Show(icon)
            end
            -- marked_for_death,precombat_seconds=5,if=raid_event.adds.in>40
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 40) then
                return A.MarkedForDeath:Show(icon)
            end
            -- stealth,if=(!equipped.pocketsized_computation_device|!cooldown.cyclotronic_blast.duration|raid_event.invulnerable.exists)
            if A.Stealth:IsReady(unit) and ((not A.PocketsizedComputationDevice:IsExists() or not bool(A.CyclotronicBlast:BaseDuration()) or bool(raid_event.invulnerable.exists))) then
                return A.Stealth:Show(icon)
            end
            -- roll_the_bones,precombat_seconds=2
            if A.RolltheBones:IsReady(unit) then
                return A.RolltheBones:Show(icon)
            end
            -- slice_and_dice,precombat_seconds=2
            if A.SliceandDice:IsReady(unit) and Unit("player"):HasBuffsDown(A.SliceandDiceBuff.ID, true) then
                return A.SliceandDice:Show(icon)
            end
            -- adrenaline_rush,precombat_seconds=1,if=(!equipped.pocketsized_computation_device|!cooldown.cyclotronic_blast.duration|raid_event.invulnerable.exists)
            if A.AdrenalineRush:IsReady(unit) and Unit("player"):HasBuffsDown(A.AdrenalineRushBuff.ID, true) and ((not A.PocketsizedComputationDevice:IsExists() or not bool(A.CyclotronicBlast:BaseDuration()) or bool(raid_event.invulnerable.exists))) then
                return A.AdrenalineRush:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power
            if A.AzsharasFontofPower:IsReady(unit) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,effect_name=cyclotronic_blast,if=!raid_event.invulnerable.exists
            if A.CyclotronicBlast:IsReady(unit) and (not bool(raid_event.invulnerable.exists)) then
                A.CyclotronicBlast:Show(icon)
            end
        end
        
        --Build
        local function Build(unit)
            -- pistol_shot,if=buff.opportunity.up&(buff.keep_your_wits_about_you.stack<14|buff.deadshot.up|energy<45)
            if A.PistolShot:IsReady(unit) and (Unit("player"):HasBuffs(A.OpportunityBuff.ID, true) and (Unit("player"):HasBuffsStacks(A.KeepYourWitsAboutYouBuff.ID, true) < 14 or Unit("player"):HasBuffs(A.DeadshotBuff.ID, true) or Player:EnergyPredicted() < 45)) then
                return A.PistolShot:Show(icon)
            end
            -- sinister_strike
            if A.SinisterStrike:IsReady(unit) then
                return A.SinisterStrike:Show(icon)
            end
        end
        
        --Cds
        local function Cds(unit)
            -- call_action_list,name=essences,if=!stealthed.all
            if (not Unit("player"):IsStealthed(true, true)) then
                local ShouldReturn = Essences(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- adrenaline_rush,if=!buff.adrenaline_rush.up&energy.time_to_max>1&(!equipped.azsharas_font_of_power|cooldown.latent_arcana.remains>20)
            if A.AdrenalineRush:IsReady(unit) and (not Unit("player"):HasBuffs(A.AdrenalineRushBuff.ID, true) and Player:EnergyTimeToMaxPredicted() > 1 and (not A.AzsharasFontofPower:IsExists() or A.LatentArcana:GetCooldown() > 20)) then
                return A.AdrenalineRush:Show(icon)
            end
            -- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.rogue&combo_points.deficit>=cp_max_spend-1)
            if A.MarkedForDeath:IsReady(unit) then
                if Action.Utils.CastTargetIf(A.MarkedForDeath, 40, "min", EvaluateTargetIfFilterMarkedForDeath55, EvaluateTargetIfMarkedForDeath60) then 
                    return A.MarkedForDeath:Show(icon) 
                end
            end
            -- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&!stealthed.rogue&combo_points.deficit>=cp_max_spend-1
            if A.MarkedForDeath:IsReady(unit) and (10000000000 > 30 - raid_event.adds.duration and not Unit("player"):IsStealthed(true, false) and Player:ComboPointsDeficit() >= CPMaxSpend() - 1) then
                return A.MarkedForDeath:Show(icon)
            end
            -- blade_flurry,if=spell_targets>=2&!buff.blade_flurry.up&(!raid_event.adds.exists|raid_event.adds.remains>8|raid_event.adds.in>(2-cooldown.blade_flurry.charges_fractional)*25)
            if A.BladeFlurry:IsReady(unit) and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 and not Unit("player"):HasBuffs(A.BladeFlurryBuff.ID, true) and (not (MultiUnits:GetByRangeInCombat(8, 5, 10) > 1) or 0 > 8 or 10000000000 > (2 - A.BladeFlurry:ChargesFractionalP()) * 25)) then
                return A.BladeFlurry:Show(icon)
            end
            -- ghostly_strike,if=variable.blade_flurry_sync&combo_points.deficit>=1+buff.broadside.up
            if A.GhostlyStrike:IsReady(unit) and (bool(VarBladeFlurrySync) and Player:ComboPointsDeficit() >= 1 + num(Unit("player"):HasBuffs(A.BroadsideBuff.ID, true))) then
                return A.GhostlyStrike:Show(icon)
            end
            -- killing_spree,if=variable.blade_flurry_sync&(energy.time_to_max>5|energy<15)
            if A.KillingSpree:IsReady(unit) and (bool(VarBladeFlurrySync) and (Player:EnergyTimeToMaxPredicted() > 5 or Player:EnergyPredicted() < 15)) then
                return A.KillingSpree:Show(icon)
            end
            -- blade_rush,if=variable.blade_flurry_sync&energy.time_to_max>1
            if A.BladeRush:IsReady(unit) and (bool(VarBladeFlurrySync) and Player:EnergyTimeToMaxPredicted() > 1) then
                return A.BladeRush:Show(icon)
            end
            -- vanish,if=!stealthed.all&variable.ambush_condition
            if A.Vanish:IsReady(unit) and (not Unit("player"):IsStealthed(true, true) and bool(VarAmbushCondition)) then
                return A.Vanish:Show(icon)
            end
            -- shadowmeld,if=!stealthed.all&variable.ambush_condition
            if A.Shadowmeld:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (not Unit("player"):IsStealthed(true, true) and bool(VarAmbushCondition)) then
                return A.Shadowmeld:Show(icon)
            end
            -- potion,if=buff.bloodlust.react|buff.adrenaline_rush.up
            if A.ProlongedPower:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasHeroism or Unit("player"):HasBuffs(A.AdrenalineRushBuff.ID, true)) then
                A.ProlongedPower:Show(icon)
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
            -- use_item,effect_name=cyclotronic_blast,if=!stealthed.all&buff.adrenaline_rush.down&buff.memory_of_lucid_dreams.down&energy.time_to_max>4&rtb_buffs<5
            if A.CyclotronicBlast:IsReady(unit) and (not Unit("player"):IsStealthed(true, true) and bool(Unit("player"):HasBuffsDown(A.AdrenalineRushBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.MemoryofLucidDreamsBuff.ID, true)) and Player:EnergyTimeToMaxPredicted() > 4 and RtB_Buffs < 5) then
                A.CyclotronicBlast:Show(icon)
            end
            -- use_item,name=azsharas_font_of_power,if=!buff.adrenaline_rush.up&!buff.blade_flurry.up&cooldown.adrenaline_rush.remains<15
            if A.AzsharasFontofPower:IsReady(unit) and (not Unit("player"):HasBuffs(A.AdrenalineRushBuff.ID, true) and not Unit("player"):HasBuffs(A.BladeFlurryBuff.ID, true) and A.AdrenalineRush:GetCooldown() < 15) then
                A.AzsharasFontofPower:Show(icon)
            end
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<32&target.health.pct>=30|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=20-10*debuff.blood_of_the_enemy.up|target.time_to_die<60)&buff.adrenaline_rush.remains>18
            if A.AshvanesRazorCoral:IsReady(unit) and (bool(Unit(unit):HasDeBuffsDown(A.RazorCoralDebuff.ID, true)) or Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and Unit(unit):HealthPercent() < 32 and Unit(unit):HealthPercent() >= 30 or not Unit(unit):HasDeBuffs(A.ConductiveInkDebuff.ID, true) and (Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) >= 20 - 10 * num(Unit(unit):HasDeBuffs(A.BloodoftheEnemyDebuff.ID, true)) or Unit(unit):TimeToDie() < 60) and Unit("player"):HasBuffs(A.AdrenalineRushBuff.ID, true) > 18) then
                A.AshvanesRazorCoral:Show(icon)
            end
            -- use_items,if=buff.bloodlust.react|target.time_to_die<=20|combo_points.deficit<=2
        end
        
        --Essences
        local function Essences(unit)
            -- concentrated_flame,if=energy.time_to_max>1&!buff.blade_flurry.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyTimeToMaxPredicted() > 1 and not Unit("player"):HasBuffs(A.BladeFlurryBuff.ID, true) and (not Unit(unit):HasDeBuffs(A.ConcentratedFlameBurnDebuff.ID, true) and not A.ConcentratedFlame:IsSpellInFlight() or A.ConcentratedFlame:FullRechargeTimeP() < A.GetGCD())) then
                return A.ConcentratedFlame:Show(icon)
            end
            -- blood_of_the_enemy,if=variable.blade_flurry_sync&cooldown.between_the_eyes.up&variable.bte_condition
            if A.BloodoftheEnemy:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (bool(VarBladeFlurrySync) and A.BetweentheEyes:GetCooldown() == 0 and bool(VarBteCondition)) then
                return A.BloodoftheEnemy:Show(icon)
            end
            -- guardian_of_azeroth
            if A.GuardianofAzeroth:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.GuardianofAzeroth:Show(icon)
            end
            -- focused_azerite_beam,if=spell_targets.blade_flurry>=2|raid_event.adds.in>60&!buff.adrenaline_rush.up
            if A.FocusedAzeriteBeam:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 or 10000000000 > 60 and not Unit("player"):HasBuffs(A.AdrenalineRushBuff.ID, true)) then
                return A.FocusedAzeriteBeam:Show(icon)
            end
            -- purifying_blast,if=spell_targets.blade_flurry>=2|raid_event.adds.in>60
            if A.PurifyingBlast:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (MultiUnits:GetByRangeInCombat(8, 5, 10) >= 2 or 10000000000 > 60) then
                return A.PurifyingBlast:Show(icon)
            end
            -- the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
            if A.TheUnboundForce:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffs(A.RecklessForceBuff.ID, true) or Unit("player"):HasBuffsStacks(A.RecklessForceCounterBuff.ID, true) < 10) then
                return A.TheUnboundForce:Show(icon)
            end
            -- ripple_in_space
            if A.RippleInSpace:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleInSpace:Show(icon)
            end
            -- worldvein_resonance,if=buff.lifeblood.stack<3
            if A.WorldveinResonance:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Unit("player"):HasBuffsStacks(A.LifebloodBuff.ID, true) < 3) then
                return A.WorldveinResonance:Show(icon)
            end
            -- memory_of_lucid_dreams,if=energy<45
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and (Player:EnergyPredicted() < 45) then
                return A.MemoryofLucidDreams:Show(icon)
            end
        end
        
        --Finish
        local function Finish(unit)
            -- between_the_eyes,if=variable.bte_condition
            if A.BetweentheEyes:IsReady(unit) and (bool(VarBteCondition)) then
                return A.BetweentheEyes:Show(icon)
            end
            -- slice_and_dice,if=buff.slice_and_dice.remains<target.time_to_die&buff.slice_and_dice.remains<(1+combo_points)*1.8
            if A.SliceandDice:IsReady(unit) and (Unit("player"):HasBuffs(A.SliceandDiceBuff.ID, true) < Unit(unit):TimeToDie() and Unit("player"):HasBuffs(A.SliceandDiceBuff.ID, true) < (1 + Player:ComboPoints()) * 1.8) then
                return A.SliceandDice:Show(icon)
            end
            -- roll_the_bones,if=buff.roll_the_bones.remains<=3|variable.rtb_reroll
            if A.RolltheBones:IsReady(unit) and (Unit("player"):HasBuffs(A.RolltheBonesBuff.ID, true) <= 3 or bool(VarRtbReroll)) then
                return A.RolltheBones:Show(icon)
            end
            -- between_the_eyes,if=azerite.ace_up_your_sleeve.enabled|azerite.deadshot.enabled
            if A.BetweentheEyes:IsReady(unit) and (bool(A.AceUpYourSleeve:GetAzeriteRank()) or bool(A.Deadshot:GetAzeriteRank())) then
                return A.BetweentheEyes:Show(icon)
            end
            -- dispatch
            if A.Dispatch:IsReady(unit) then
                return A.Dispatch:Show(icon)
            end
        end
        
        --Stealth
        local function Stealth(unit)
            -- ambush
            if A.Ambush:IsReady(unit) then
                return A.Ambush:Show(icon)
            end
        end
        
        
        -- call precombat
        if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
            local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- stealth
            if A.Stealth:IsReady(unit) then
                return A.Stealth:Show(icon)
            end
            -- variable,name=rtb_reroll,value=rtb_buffs<2&(buff.loaded_dice.up|!buff.grand_melee.up&!buff.ruthless_precision.up)
            if (true) then
                VarRtbReroll = num(RtB_Buffs < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) or not Unit("player"):HasBuffs(A.GrandMeleeBuff.ID, true) and not Unit("player"):HasBuffs(A.RuthlessPrecisionBuff.ID, true)))
            end
            -- variable,name=rtb_reroll,op=set,if=azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled,value=rtb_buffs<2&(buff.loaded_dice.up|buff.ruthless_precision.remains<=cooldown.between_the_eyes.remains)
            if (bool(A.Deadshot:GetAzeriteRank()) or bool(A.AceUpYourSleeve:GetAzeriteRank())) then
                VarRtbReroll = num(RtB_Buffs < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) or Unit("player"):HasBuffs(A.RuthlessPrecisionBuff.ID, true) <= A.BetweentheEyes:GetCooldown()))
            end
            -- variable,name=rtb_reroll,op=set,if=azerite.snake_eyes.rank>=2,value=rtb_buffs<2
            if (A.SnakeEyes:GetAzeriteRank() >= 2) then
                VarRtbReroll = num(RtB_Buffs < 2)
            end
            -- variable,name=rtb_reroll,op=reset,if=azerite.snake_eyes.rank>=2&buff.snake_eyes.stack>=2-buff.broadside.up
            if (A.SnakeEyes:GetAzeriteRank() >= 2 and Unit("player"):HasBuffsStacks(A.SnakeEyesBuff.ID, true) >= 2 - num(Unit("player"):HasBuffs(A.BroadsideBuff.ID, true))) then
                VarRtbReroll = 0
            end
            -- variable,name=rtb_reroll,op=set,if=buff.blade_flurry.up,value=rtb_buffs-buff.skull_and_crossbones.up<2&(buff.loaded_dice.up|!buff.grand_melee.up&!buff.ruthless_precision.up&!buff.broadside.up)
            if (Unit("player"):HasBuffs(A.BladeFlurryBuff.ID, true)) then
                VarRtbReroll = num(RtB_Buffs - num(Unit("player"):HasBuffs(A.SkullandCrossbonesBuff.ID, true)) < 2 and (Unit("player"):HasBuffs(A.LoadedDiceBuff.ID, true) or not Unit("player"):HasBuffs(A.GrandMeleeBuff.ID, true) and not Unit("player"):HasBuffs(A.RuthlessPrecisionBuff.ID, true) and not Unit("player"):HasBuffs(A.BroadsideBuff.ID, true)))
            end
            -- variable,name=ambush_condition,value=combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&cooldown.ghostly_strike.remains<1)+buff.broadside.up&energy>60&!buff.skull_and_crossbones.up&!buff.keep_your_wits_about_you.up
            if (true) then
                VarAmbushCondition = num(Player:ComboPointsDeficit() >= 2 + 2 * num((A.GhostlyStrike:IsSpellLearned() and A.GhostlyStrike:GetCooldown() < 1)) + num(Unit("player"):HasBuffs(A.BroadsideBuff.ID, true)) and Player:EnergyPredicted() > 60 and not Unit("player"):HasBuffs(A.SkullandCrossbonesBuff.ID, true) and not Unit("player"):HasBuffs(A.KeepYourWitsAboutYouBuff.ID, true))
            end
            -- variable,name=bte_condition,value=buff.ruthless_precision.up|(azerite.deadshot.enabled|azerite.ace_up_your_sleeve.enabled)&buff.roll_the_bones.up
            if (true) then
                VarBteCondition = num(Unit("player"):HasBuffs(A.RuthlessPrecisionBuff.ID, true) or (bool(A.Deadshot:GetAzeriteRank()) or bool(A.AceUpYourSleeve:GetAzeriteRank())) and Unit("player"):HasBuffs(A.RolltheBonesBuff.ID, true))
            end
            -- variable,name=blade_flurry_sync,value=spell_targets.blade_flurry<2&raid_event.adds.in>20|buff.blade_flurry.up
            if (true) then
                VarBladeFlurrySync = num(MultiUnits:GetByRangeInCombat(8, 5, 10) < 2 and 10000000000 > 20 or Unit("player"):HasBuffs(A.BladeFlurryBuff.ID, true))
            end
            -- call_action_list,name=stealth,if=stealthed.all
            if (Unit("player"):IsStealthed(true, true)) then
                local ShouldReturn = Stealth(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=cds
            if (true) then
                local ShouldReturn = Cds(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- run_action_list,name=finish,if=combo_points>=cp_max_spend-(buff.broadside.up+buff.opportunity.up)*(talent.quick_draw.enabled&(!talent.marked_for_death.enabled|cooldown.marked_for_death.remains>1))*(azerite.ace_up_your_sleeve.rank<2|!cooldown.between_the_eyes.up|!buff.roll_the_bones.up)
            if (Player:ComboPoints() >= CPMaxSpend() - (num(Unit("player"):HasBuffs(A.BroadsideBuff.ID, true)) + num(Unit("player"):HasBuffs(A.OpportunityBuff.ID, true))) * num((A.QuickDraw:IsSpellLearned() and (not A.MarkedForDeath:IsSpellLearned() or A.MarkedForDeath:GetCooldown() > 1))) * num((A.AceUpYourSleeve:GetAzeriteRank() < 2 or not A.BetweentheEyes:GetCooldown() == 0 or not Unit("player"):HasBuffs(A.RolltheBonesBuff.ID, true)))) then
                return Finish(unit);
            end
            -- call_action_list,name=build
            if (true) then
                local ShouldReturn = Build(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- arcane_torrent,if=energy.deficit>=15+energy.regen
            if A.ArcaneTorrent:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (Player:EnergyDeficitPredicted() >= 15 + Player:EnergyRegen()) then
                return A.ArcaneTorrent:Show(icon)
            end
            -- arcane_pulse
            if A.ArcanePulse:AutoRacial(unit) and Action.GetToggle(1, "Racial") then
                return A.ArcanePulse:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
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

