local TMW                                   = TMW
local Action								= Action
local TeamCache								= Action.TeamCache
local EnemyTeam								= Action.EnemyTeam
local FriendlyTeam							= Action.FriendlyTeam
local LoC									= Action.LossOfControl
local Player								= Action.Player 
local MultiUnits							= Action.MultiUnits
local UnitCooldown							= Action.UnitCooldown
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
local PetLib                                = LibStub("PetLibrary")
local Unit                                  = Action.Unit 
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
-- Trinkets
-------------------------------------------------------------------------------

-- List all BlackListed Trinkets we dont want to use on cooldown but with some specific APLs.
local BlackListedTrinkets = {

    [1] = 168905, -- Shiver Venom Relic
	[2] = 169314, -- Azsharas Font of Power
    [3] = 169311, -- AshvanesRazorCoral
}

function TrinketIsAllowed()
    local Trinket1IsAllowed = true
	local Trinket2IsAllowed = true
     
   	    for i = 1, #BlackListedTrinkets do
            if Action.Trinket1.ID == BlackListedTrinkets[i] then
                Trinket1IsAllowed = false				
			end
            if Action.Trinket2.ID == BlackListedTrinkets[i] then
                Trinket2IsAllowed = false					
            end
        end
	return Trinket1IsAllowed, Trinket2IsAllowed
end
    
-- Trinkets checker
function TrinketON()
  return ( (Action.GetToggle(1, "Trinkets")[1]) or (Action.GetToggle(1, "Trinkets")[2]) )
end

------------------------------------
--- RegisterDamage simc reference
------------------------------------
-- Register the spell damage formula.
function A:RegisterDamage(Function)
  self.DamageFormula = Function
end

-- Get the spell damage formula if it exists.
function A:Damage()
  return self.DamageFormula and self.DamageFormula() or 0
end

-- attack_power
function A.Player:AttackPower()
    return UnitAttackPower(self.UnitID)
end

------------------------------------
--- HasDeBuffsDown simc reference
------------------------------------
function HasDeBuffsDown(spell, byID)
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end 
	
    ID = byID
	if not ID then
	    ID = true
	end
	
    return (Unit(unit):HasDeBuffs(spell, ID) > 0 and true) or false
end

------------------------------------
--- HasBuffsDown simc reference
------------------------------------
function HasBuffsDown(spell, byID)
    ID = byID
	if not ID then
	    ID = true
	end
	
    return (Unit("player"):HasBuffs(spell, ID) > 0 and true) or false
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
			if Unit(unitID):CombatTime() > 0 and (not range or Unit(unitID):CanInterract(range)) and (not upTTD or Unit(unitID):TimeToDie() >= upTTD) and Unit(unitID):HasDeBuffs(deBuffs, true) <= refreshTime then 
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
-- Return a tost notification directly in game with status information from rotation. Useful for custom events announcer	
-- @Parameters : Message and Spell are mandaroty settings. 
-- @optional Parameters : Delay and incombat can be nil 
-- Usage : /run Action.SendNotification("test", 22812, 2, false)	
function Action.SendNotification(message, spell, delay, incombat)
   	local DelaySetting = Action.GetToggle(2, "AnnouncerDelay")
	local InCombatSetting = Action.GetToggle(2, "AnnouncerInCombatOnly")
	local Enabled = Action.GetToggle(2, "UseAnnouncer")
	
	if not message then
	    Action.Print("You didn't set any message for Notification.")
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
	local timer = TMW.time
	local endtimer = timer + delay	
	Action.NotificationMessage = ""
	Action.NotificationIsValid = false
    Action.NotificationIsValidUntil = endtimer
	Action.CurrentNotificationIcon = GetSpellTexture(spell)
	-- Check if enabled
	if Enabled then
	    -- Option 1 : Combat only		
	    if message and spell and incombat then 
	        if (TMW.time <= endtimer) and ActionUnit("player"):CombatTime() > 1 then 
	            Action.NotificationIsValid = true
	            Action.NotificationMessage = message 				
            else
		        Action.NotificationIsValid = false
		    end
	    -- Option 2 : Everytime
        elseif message and spell and not incombat then 	
	        if TMW.time <= endtimer then 
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