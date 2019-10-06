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
local ActionUnit    = Action.Unit 
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
-- Trinkets
-------------------------------------------------------------------------------

-- List all BlackListed Trinkets we dont want to use on cooldown but with some specific APLs.
local BlackListedTrinkets = {
    -- Range Trinkets
    Range = {
        168905, -- Shiver Venom Relic
		169314, -- Azsharas Font of Power
    },
	-- Melee Trinkets
    Melee = {
        169311, -- AshvanesRazorCoral
		169314, -- Azsharas Font of Power
    },
}

function TrinketIsAllowed()
    local EquipedTrinket1 = Action.Trinket1.ID
    local EquipedTrinket2 = Action.Trinket2.ID
    Trinket1IsAllowed = false
	Trinket2IsAllowed = false
    
	-- Range
    if not ActionUnit("player"):IsMelee() then
        for i = 1, #BlackListedTrinkets.Range do 
            if EquipedTrinket1 == BlackListedTrinkets.Range[i] then
                Trinket1IsAllowed = false	
            else
                Trinket1IsAllowed = true				
            end
            if EquipedTrinket2 == BlackListedTrinkets.Range[i] then
                Trinket2IsAllowed = false		
            else
                Trinket2IsAllowed = true				
            end
        end
	else
	    -- Melee
    	for i = 1, #BlackListedTrinkets.Melee do 
            if EquipedTrinket1 == BlackListedTrinkets.Melee[i] then
                Trinket1IsAllowed = false	
            else
                Trinket1IsAllowed = true			
            end
            if EquipedTrinket2 == BlackListedTrinkets.Melee[i] then
                Trinket2IsAllowed = false
            else
                Trinket2IsAllowed = true				
            end
        end
	end
	return Trinket1IsAllowed, Trinket2IsAllowed
end

-- Trinkets checker
function TrinketON()
  local Trinket1Allowed, Trinket2IsAllowed = TrinketIsAllowed()
  return ((Action.GetToggle(1, "Trinkets")[1] and Trinket1IsAllowed) or (Action.GetToggle(1, "Trinkets")[2] and Trinket2IsAllowed)) or false
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

-------------------------------------------------------------------------------
-- DogTags
-------------------------------------------------------------------------------
local DogTag = LibStub("LibDogTag-3.0", true)
-- Taste's 
TMW:RegisterCallback("TMW_ACTION_NOTIFICATION", DogTag.FireEvent, DogTag)


------------------------------------
--------- NOTIFICATIONS API -------
------------------------------------
-- Return a tost notification directly in game with status information from rotation
-- Useful for custom events announcer	
-- @Parameters : Message and Spell are mandaroty settings. 
-- @optional Parameters : Delay and incombat can be nil 
-- Usage : /run Action.SendNotification("test", 22812, 2, false)	
function Action.SendNotification(message, spell, delay, incombat)
   	local DelaySetting = Action.GetToggle(2, "AnnouncerDelay")
	local InCombatSetting = Action.GetToggle(2, "AnnouncerInCombatOnly")
	local Enabled = Action.GetToggle(2, "UseAnnouncer")
	
	if not message then
	    return
	end
	if not delay then
	    if DelaySetting then 
		    delay = DelaySetting
		else
	        delay = 2
		end
	end
	if not incombat then
        if InCombatSetting then 
            incombat = InCombatSetting
		else		
	        incombat = false
		end
	else
	   incombat = true
	end
	-- Variables
	local timer = HL.GetTime()
	local endtimer = timer + delay	
	Action.NotificationMessage = ""
	Action.NotificationIsValid = false
    Action.NotificationIsValidUntil = endtimer
	Action.CurrentNotificationIcon = GetSpellTexture(spell)
	-- Check if enabled
	if Enabled then
	    -- Option 1 : Combat only		
	    if message and spell and incombat then 
	        if (HL.GetTime() <= endtimer) and ActionUnit("player"):CombatTime() > 1 then 
	            Action.NotificationIsValid = true
	            Action.NotificationMessage = message 				
            else
		        Action.NotificationIsValid = false
		    end
	    -- Option 2 : Everytime
        elseif message and spell and not incombat then 	
	        if HL.GetTime() <= endtimer then 
	            Action.NotificationIsValid = true
	            Action.NotificationMessage = message            
            else
		        Action.NotificationIsValid = false
	    	end
	    end
	end
	TMW:Fire("TMW_ACTION_NOTIFICATION")	
    return Action.NotificationMessage, Action.CurrentNotificationIcon, Action.NotificationIsValid, Action.NotificationIsValidUntil
	
end			

local function removeLastChar(text)
	return text:sub(1, -2)
end

if DogTag then
	-- Custom Notifications
	DogTag:AddTag("TMW", "ActionNotificationIcon", {
        code = function()
			if Action.CurrentNotificationIcon and Action.NotificationIsValid then
				return Action.CurrentNotificationIcon
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays Notification Icon",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })

	-- Custom Notifications
	DogTag:AddTag("TMW", "ActionNotificationMessage", {
        code = function()
			if Action.NotificationMessage and Action.NotificationIsValid then				
				return Action.NotificationMessage
			else 
				return ""
			end 
        end,
        ret = "string",
        doc = "Displays Notification Message",
		example = '[ActionNotification] => "Action.SendNotification(message, spell, delay)"',
        events = "TMW_ACTION_NOTIFICATION",
        category = "Action",
    })		
	
	-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
	TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
		TMW:Fire("TMW_ACTION_NOTIFICATION")
	end)
end