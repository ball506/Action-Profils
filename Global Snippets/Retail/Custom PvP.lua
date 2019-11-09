---------------------------------------------------
---------------- CUSTOM PVP FUNCTIONS -------------
---------------------------------------------------

local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env
local Action = Action
local MultiUnits = Action.MultiUnits
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Pet = Unit.Pet;
local Target = Unit.Target;
local Arena = Unit.Arena;
local Spell = HL.Spell;
local Item = HL.Item;
local next, pairs, type, print  = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID = UnitIsPlayer, UnitExists, UnitGUID
local PetLib = LibStub("PetLibrary")
local ActionUnit = Action.Unit 

---------------------------------------------------
-------------------- CONSTANTS --------------------
---------------------------------------------------

--- Reflect Spells List
local pvpReflect = {
    161372, -- Poly
    190319, -- Combustion
    161372, -- Polymorph
    203286, -- Greater Pyroblast
    199786, --  Glacial Spike
    257537, -- Ebonbolt
    210714, -- Icefury
    191634, -- Stormkeeper
    116858, -- Chaos Bolt
	118, -- Poly
}

---------------------------------------------------
-------------------- FUNCTIONS --------------------
---------------------------------------------------

-- Local Randomizer
local randomReflect = math.random(90, 100)

-- Should Reflect behavior
-- Parameter "unit" is mandatory
-- @ return Boolean
function Action.ShouldReflect(unit)	
	local GoodToReflect = false
	for p = 1, #pvpReflect do
	    -- Protect if nil parameter 
		if not unit or unit == nil then 
		    unit = "target"
		end
		-- Current Cast SpellID
		local currentCast = ActionUnit(unit):IsCasting()
		-- [1] Total Casting Time (@number)
		-- [2] Currect Casting Left (X -> 0) Time (seconds) (@number)
		-- [3] Current Casting Done (0 -> 100) Time (percent) (@number)
		local castingTime, castingLeftSec, castingDonePer  = ActionUnit(unit):CastTime()
		
		-- Current casted spell is in list
        if currentCast == GetSpellInfo(pvpReflect[p]) then
		    if  castingDonePer >= randomReflect then
                GoodToReflect = true
            else
		        GoodToReflect = false
			end
        end
    end
    return GoodToReflect
end

-- Enemy Gladiator Medallion tracker
-- Parameter "unit" is mandatory
-- @ return [1] Boolean (Is Gladiator Medallion up for unit)
-- @ return [2] Number (Remaining cooldown time)
function Action.UpdateGladiatorTrinket(unit)

	C_PvP.RequestCrowdControlSpell(unit)
	
	local spellID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(unit)
	local EnemyTrinketIsReady = true
	local RemainingCD = 0
	
	if spellID == ACTION_CONST_SPELLID_GLADIATORS_MEDALLION then 
	    if duration < 0 then 
	        EnemyTrinketIsReady = true
	    else
	        EnemyTrinketIsReady = false
			RemainingCD = duration
	    end	
	elseif spellID == ACTION_CONST_SPELLID_HONOR_MEDALLION then
	    if duration < 0 then 
	        EnemyTrinketIsReady = true
	    else
	        EnemyTrinketIsReady = false
			RemainingCD = duration
	    end	
	end
	
	return EnemyTrinketIsReady, RemainingCD 
end