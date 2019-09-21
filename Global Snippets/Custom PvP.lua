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
PvPReflect = {
    Spell(161372), -- Poly
    Spell(190319), -- Combustion
    Spell(161372), -- Polymorph
    Spell(203286), -- Greater Pyroblast
    Spell(199786), --  Glacial Spike
    Spell(257537), -- Ebonbolt
    Spell(161372), -- Polymorph
    Spell(210714), -- Icefury
    Spell(191634), -- Stormkeeper
    Spell(116858) -- Chaos Bolt
}


---------------------------------------------------
-------------------- FUNCTIONS --------------------
---------------------------------------------------

-- Used to check spells to reflect
function ActionUnit:IsCastingDangerousSpell()
    local importantCast = false
    local spellName = Action.Unit(unitID):IsCasting()
	
    for _, key in pairs(PvPReflect) do
        if self:IsCasting(key) then
            importantCast = true
            break
        end
    end

    if importantCast then
        return true
    end
    return false
end