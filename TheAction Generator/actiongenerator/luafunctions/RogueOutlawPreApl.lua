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
