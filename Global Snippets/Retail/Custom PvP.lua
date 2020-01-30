---------------------------------------------------
---------------- CUSTOM PVP FUNCTIONS -------------
---------------------------------------------------

local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env
local Action = Action
local MultiUnits = Action.MultiUnits
local next, pairs, type, print  = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID = UnitIsPlayer, UnitExists, UnitGUID
local PetLib = LibStub("PetLibrary")
local Unit = Action.Unit 
local huge                                  = math.huge
---------------------------------------------------
-------------------- CONSTANTS --------------------
---------------------------------------------------

--- Reflect Spells List

local pvpReflect = { 
    [161372] = true, -- Poly
    [190319] = true, -- Combustion
    [161372] = true, -- Polymorph
    [203286] = true, -- Greater Pyroblast
    [199786] = true, -- Glacial Spike
    [257537] = true, -- Ebonbolt
    [210714] = true, -- Icefury
    [191634] = true, -- Stormkeeper
    [116858] = true, -- Chaos Bolt
	[118] = true, -- Poly
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
	-- Protect if nil parameter 
	if not unit or unit == nil then 
		unit = "target"
	end

    for i = 1, huge do 
		-- Current Cast SpellID
		local castName, castStartTime, castEndTime, notInterruptable, spellID, isChannel = Unit(unit):IsCasting()
		-- [1] Total Casting Time (@number)
		-- [2] Currect Casting Left (X -> 0) Time (seconds) (@number)
		-- [3] Current Casting Done (0 -> 100) Time (percent) (@number)
		local castingTime, castingLeftSec, castingDonePer  = Unit(unit):CastTime()
		
        if not spellID then 
            break 
        elseif pvpReflect[spellID] then 
            if  castingDonePer >= randomReflect then
                GoodToReflect = true
            else
		        GoodToReflect = false
			end
        end 
    end 
	
	return GoodToReflect
end 