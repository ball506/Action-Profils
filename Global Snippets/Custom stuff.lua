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

-------------------------------------------------------------------------------
-- UI Toggles
-------------------------------------------------------------------------------
-- AoE Status on Main Icon
function Action.AoEToggleMode()
    Action.UseAoE = Action.GetToggle(2, "AoE")    
    if Action.UseAoE == false then 
        Action.UseAoE = true
    else
        Action.UseAoE = false
    end
    Action.SetToggle({2, "AoE"})        
    Action.Print(Action.UseAoE and "Mode AoE: On" or not Action.UseAoE and "Mode AoE: Off")
    TMW:Fire("TMW_ACTION_AOE_MODE_CHANGED")
end 

-------------------------------------------------------------------------------
-- Profil Loader
-------------------------------------------------------------------------------
-- Load default profils for each class
local currentClass = select(2, UnitClass("player"))

if currentClass == "WARRIOR" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warrior"
    Action.Print("Automatically loaded profile : [Taste]Action - Warrior")
end

if currentClass == "WARLOCK" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warlock"
    Action.Print("Automatically loaded profile : [Taste]Action - Warlock")
end

if currentClass == "ROGUE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Rogue"
    Action.Print("Automatically loaded profile : [Taste]Action - Rogue")
end

if currentClass == "SHAMAN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Shaman"
    Action.Print("Automatically loaded profile : [Taste]Action - Shaman")
end

if currentClass == "DEATHKNIGHT" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Death Knight"
    Action.Print("Automatically loaded profile : [Taste]Action - Death Knight")
end

if currentClass == "PRIEST" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Priest"
    Action.Print("Automatically loaded profile : [Taste]Action - Priest")
end

if currentClass == "PALADIN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Paladin"
    Action.Print("Automatically loaded profile : [Taste]Action - Paladin")
end

if currentClass == "MAGE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Mage"
    Action.Print("Automatically loaded profile : [Taste]Action - Mage")
end

if currentClass == "HUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Hunter"
    Action.Print("Automatically loaded profile : [Taste]Action - Hunter")
end

if currentClass == "DRUID" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Druid"
    Action.Print("Automatically loaded profile : [Taste]Action - Druid")
end

if currentClass == "DEMONHUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Demon Hunter"
    Action.Print("Automatically loaded profile : [Taste]Action - Demon Hunter")
end

-------------------------------------------------------------------------------
-- Movement checker
-------------------------------------------------------------------------------
-- @return number
local movedTimer = 0
function Unit:MovingFor()
    if not self:IsMoving() then
        movedTimer = GetTime()
    end
    return GetTime() - movedTimer
end

-------------------------------------------------------------------------------
-- Instance checker
-------------------------------------------------------------------------------
-- @return boolean
function Player:InArena()
    return select(2, IsInInstance()) == "arena"
end

function Player:InBattlegrounds()
    return select(2, IsInInstance()) == "pvp"
end

function Player:InPvP()
    return select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "arena"
end
 
function Player:InDungeon()
    return select(2, IsInInstance()) == "party" or C_Map.GetBestMapForUnit("Player") == 480
end

function Player:InRaid()
    return select(2, IsInInstance()) == "raid" or C_Map.GetBestMapForUnit("Player") == 480
end

-------------------------------------------------------------------------------
-- Multiunits
-------------------------------------------------------------------------------
function Action.MultiUnits.GetByRangeDoTsToRefresh(self, range, count, deBuffs, refreshTime, upTTD)
	-- @return number
	-- @usage A.MultiUnits:GetByRangeDoTsToRefresh(@number, @number, @table or @number, @number, @number)
	-- deBuffs is required, refreshTime too, rest options are optimal
	local total = 0
	local nameplates = self:GetActiveUnitPlates()
	
	if nameplates then 
		for unitID in pairs(nameplates) do 
			if Action.Unit(unitID):CombatTime() > 0 and (not range or Action.Unit(unitID):CanInterract(range)) and (not upTTD or Action.Unit(unitID):TimeToDie() >= upTTD) and Action.Unit(unitID):HasDeBuffs(deBuffs, true) <= refreshTime then 
				total = total + 1
			end 
			
			if count and total >= count then 
				break 
			end 
		end 
	end 
	
	return total 
end 
Action.MultiUnits.GetByRangeDoTsToRefresh = Action.MakeFunctionCachedDynamic(Action.MultiUnits.GetByRangeDoTsToRefresh)

-------------------------------------------------------------------------------
-- PetLib
-------------------------------------------------------------------------------
local petClass = select(2, UnitClass("player"))

if petClass == "WARLOCK" then 
	PetLib:Add(266, { -- Demono Warlock 
	    30213, -- Legion Strike
	    89751, --Felstorm
	})
end