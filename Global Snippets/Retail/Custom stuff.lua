local TMW                                   = TMW
local A     								= Action
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
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local EventFrame                            = CreateFrame("Frame", "Taste_EventFrame", UIParent)
local UnitIsUnit                            = UnitIsUnit
-- Lua
local error = error
local setmetatable = setmetatable
local stringformat = string.format
local tableinsert = table.insert
-- File Locals
local Events = {} -- All Events
local CombatEvents = {} -- Combat Log Unfiltered
local SelfCombatEvents = {} -- Combat Log Unfiltered with SourceGUID == PlayerGUID filter
local PetCombatEvents = {} -- Combat Log Unfiltered with SourceGUID == PetGUID filter
local PrefixCombatEvents = {}
local SuffixCombatEvents = {}
Action.TasteRotation = {}

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
local currentSpec = GetSpecialization()
local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
print(currentSpec)

-- Druid
if currentClass == "WARRIOR" then
    Action.Data.DefaultProfile[currentClass] = "[ZakLL]Action - Warrior"
end

if currentClass == "WARLOCK" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warlock"
end

if currentClass == "ROGUE" then
    Action.Data.DefaultProfile[currentClass] = "[ZakLL]Action - Rogue"
end

if currentClass == "SHAMAN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Shaman"
end

if currentClass == "DEATHKNIGHT" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Death Knight"
end

if currentClass == "PRIEST" then
    Action.Data.DefaultProfile[currentClass] = "[ZakLL]Action - Priest"
end

if currentClass == "PALADIN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Paladin"
end

if currentClass == "MAGE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste&ZakLL]Action - Mage"
end

if currentClass == "HUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Hunter"
end

if currentClass == "DEMONHUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Demon Hunter"
end

if currentClass == "DRUID" then
    Action.Data.DefaultProfile[currentClass] = "[Taste&ZakLL]Action - Druid"
end


--[[CheckProfilePerSpecialization = function()
	-- Druid
	if currentClass == "DRUID" then
	    if currentSpec == 2 then 
            Action.Data.DefaultProfile[currentClass] = "[ZakLL]Druid - Feral"
	    else
	        Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Druid"
	    end
	end
end


--A.Listener:Add("TASTE_EVENTS_SPEC_PROFILE", "PLAYER_SPECIALIZATION_CHANGED", 	CheckProfilePerSpecialization)
--TMW:RegisterCallback("TMW_ACTION_PLAYER_SPECIALIZATION_CHANGED", 					CheckProfilePerSpecialization)

TMW:RegisterCallback("TMW_ACTION_PLAYER_SPECIALIZATION_CHANGED", function()
    local currentClass = select(2, UnitClass("player"))
    local currentSpec = GetSpecialization()
	-- Druid
	if currentClass == "DRUID" then
	    if currentSpec == 2 then 
            Action.Data.DefaultProfile[currentClass] = "[ZakLL]Druid - Feral"
	    else
	        Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Druid"
	    end
	end
end)
]]--

TMW:RegisterCallback("TMW_ON_PROFILE", function(event, profileEvent, arg2, arg3)
local profileName = TMW.db:GetCurrentProfile()
if profileName:match("Taste") then
    if currentClass == "DRUID" then
	    if currentSpec == 2 then
            A.Print("Loaded ZakLL - Feral")
		else
		    A.Print("Loaded " .. profileName)
		end
	end
elseif profileName:match("ZakLL") then
    A.Print("Loaded " .. profileName)
else
    A.Print("No Profile compatible with current spec")
end
end)


-------------------------------------------------------------------------------
-- Trinkets
-------------------------------------------------------------------------------


-- List all BlackListed Trinkets we dont want to use on cooldown but with some specific APLs.
local BlackListedTrinkets = {

    [1] = 168905, -- Shiver Venom Relic
	[2] = 169314, -- Azsharas Font of Power
    [3] = 169311, -- AshvanesRazorCoral
}

function Action.TasteRotation:TrinketIsAllowed()
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
function Action.TasteRotation:TrinketON()
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
    return UnitAttackPower("player")
end

------------------------------------
--- HasHeroism simc reference
------------------------------------

local HeroismBuff = { 
    [2825] =  true, -- Bloodlust Horde 
    [32182] =  true, -- Heroism Ally  		
    [90355] =  true, -- Ancient Hysteria
    [160452] =  true, -- Netherwinds
    [80353] =  true, -- Time Warp
    [178207] =  true, -- Drums of Fury
    [35475] =  true, -- Drums of War
    [230935] =  true, -- Drums of Montain
    [256740] =  true, -- Drums of Maelstrom
    --[974] =  true, -- Test Earth Shield
}

function Unit:HasHeroism()
    local unitID = self.UnitID
	--print(unitID)
    -- @return boolean 
    local spellId 
    for i = 1, huge do 
        name,_,_,_,_,_,_,_,_,spellId = UnitBuff(unitID, i, "HELPFUL")
        if not spellId  then 
            break 
        elseif HeroismBuff[spellId] then 
            return true 
        end 
    end 
	return false
end 

------------------------------------
--- HasDeBuffsDown simc reference
------------------------------------
function Unit:HasDeBuffsDown(spell, byID)
	local unitID = self.UnitID
	
    local ID = byID
	if not ID then
	    ID = true
	end
	
    return (self(unitID):HasDeBuffs(spell, ID) == 0 and true) or false
end

------------------------------------
--- HasBuffsDown simc reference
------------------------------------
function Unit:HasBuffsDown(spell, byID)
    local unitID = self.UnitID
    local ID = byID
	if not ID then
	    ID = true
	end
	
    return (self(unitID):HasBuffs(spell, ID) == 0 and true) or false
end

------------------------------------
--- HasDeBuffsRefreshable simc reference
------------------------------------
function Unit:HasDeBuffsRefreshable(spell, byID)
    local unitID = self.UnitID
    local ID = byID
	if not ID then
	    ID = true
	end
	
    return (self(unitID):HasDeBuffs(spell, ID) < 5 or self(unitID):HasDeBuffsDown(spell, ID) and true) or false
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
-- Event register
-------------------------------------------------------------------------------
-- Register a handler for an event.
-- @param Handler The handler function.
-- @param Events The events name.
function Action:RegisterForEvent(Handler, ...)
    local EventsTable = { ... }
    for i = 1, #EventsTable do
        local Event = EventsTable[i]
        if not Events[Event] then
            Events[Event] = { Handler }
            EventFrame:RegisterEvent(Event)
        else
            tableinsert(Events[Event], Handler)
        end
    end
end

-- Register a handler for a combat event.
-- @param Handler The handler function.
-- @param Events The events name.
function Action:RegisterForCombatEvent(Handler, ...)
    local EventsTable = { ... }
    for i = 1, #EventsTable do
        local Event = EventsTable[i]
        if not CombatEvents[Event] then
            CombatEvents[Event] = { Handler }
        else
            tableinsert(CombatEvents[Event], Handler)
        end
    end
end

-- Register a handler for a self combat event.
-- @param Handler The handler function.
-- @param Events The events name.
function Action:RegisterForSelfCombatEvent(Handler, ...)
    local EventsTable = { ... }
    for i = 1, #EventsTable do
        local Event = EventsTable[i]
        if not SelfCombatEvents[Event] then
            SelfCombatEvents[Event] = { Handler }
        else
            tableinsert(SelfCombatEvents[Event], Handler)
        end
    end
end

-------------------------------------------------------------------------------
-- Tanks specifics functions
-------------------------------------------------------------------------------

-- To update for BFA
local ActiveMitigationSpells = {
    Buff = {
        -- PR Legion
        191941, -- Darkstrikes (VotW - 1st)
        204151, -- Darkstrikes (VotW - 1st)
        -- T20 ToS
        239932 -- Felclaws (KJ)
    },
    Debuff = {},
    Cast = {
        -- PR Legion
        197810, -- Wicked Slam (ARC - 3rd)
        197418, -- Vengeful Shear (BRH - 2nd)
        198079, -- Hateful Gaze (BRH - 3rd)
        214003, -- Coup de Grace (BRH - Trash)
        235751, -- Timber Smash (CotEN - 1st)
        193668, -- Savage Blade (HoV - 4th)
        227493, -- Mortal Strike (LOWR - 4th)
        228852, -- Shared Suffering (LOWR - 4th)
        193211, -- Dark Slash (MoS - 1st)
        200732, -- Molten Crash (NL - 4th)
        -- T20 ToS
        241635, -- Hammer of Creation (Maiden)
        241636, -- Hammer of Obliteration (Maiden)
        236494, -- Desolate (Avatar)
        239932, -- Felclaws (KJ)
        -- T21 Antorus
        254919, -- Forging Strike (Kin'garoth)
        244899, -- Fiery Strike (Coven)
        245458, -- Foe Breaker (Aggramar)
        248499, -- Sweeping Scythe (Argus)
        258039 -- Deadly Scythe (Argus)
    },
    Channel = {}
}

-- Active Mitigation checks
-- Predict dangerous attacks and use defensives if needed
function Player:ActiveMitigationNeeded()
    -- Specials Dungeon behavior
	local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit("target"):IsCastingRemains()
		
    if Unit("player"):IsTanking("target") then
        if ActiveMitigationSpells.Cast[spellID] then
            return true
        end
        for _, Buff in pairs(ActiveMitigationSpells.Buff) do
            if Unit("target"):HasBuffs(Buff, true) > 0 then
                return true
            end
        end
    end
    return false
end

-------------------------------------------------------------------------------
-- Rogue Marked for death special functions
-------------------------------------------------------------------------------
-- Check if the unit is coded as blacklisted for Marked for Death (Rogue) or not.
-- Most of the time if the unit doesn't really die and isn't the last unit of an instance.

-- Not Facing Unit Blacklist
A.UnitNotInFront = Player
A.UnitNotInFrontTime = 0
A.LastUnitCycled = Player
A.LastUnitCycledTime = 0

Action:RegisterForEvent(function(Event, MessageType, Message)
    if MessageType == 50 and Message == SPELL_FAILED_UNIT_NOT_INFRONT then
        A.UnitNotInFront = A.LastUnitCycled
        A.UnitNotInFrontTime = A.LastUnitCycledTime
    end
end, "UI_ERROR_MESSAGE")

local SpecialMfdBlacklistData = {
  --- Legion
  ----- Dungeons (7.0 Patch) -----
  --- Halls of Valor
  -- Hymdall leaves the fight at 10%.
  [94960] = true,
  -- Solsten and Olmyr doesn't "really" die
  [102558] = true,
  [97202] = true,
  -- Fenryr leaves the fight at 60%. We take 50% as check value since it doesn't get immune at 60%.
  [95674] = function(self) return self:HealthPercentage() > 50 and true or false end,

  ----- Trial of Valor (T19 - 7.1 Patch) -----
  --- Odyn
  -- Hyrja & Hymdall leaves the fight at 25% during first stage and 85%/90% during second stage (HM/MM)
  [114360] = true,
  [114361] = true,

  --- Warlord of Draenor (WoD)
  ----- HellFire Citadel (T18 - 6.2 Patch) -----
  --- Hellfire Assault
  -- Mar'Tak doesn't die and leave fight at 50% (blocked at 1hp anyway).
  [93023] = true,

  ----- Dungeons (6.0 Patch) -----
  --- Shadowmoon Burial Grounds
  -- Carrion Worm : They doesn't die but leave the area at 10%.
  [88769] = true,
  [76057] = true
}

-- Get the unit GUID.
function Unit:GUID()
    return UnitGUID(self.UnitID)
end

-- Get the unit NPC ID.
function Unit:NPCID(BypassCache)
    if not BypassCache and self.UseCache and self.UnitNPCID then
        return self.UnitNPCID
    end

    local GUID = self:GUID()
    if GUID then
        local UnitInfo = {}

        if not UnitInfo.NPCID then
            local type, _, _, _, _, npcid = strsplit('-', GUID)
            if type == "Creature" or type == "Pet" or type == "Vehicle" then
                UnitInfo.NPCID = tonumber(npcid)
            else
                UnitInfo.NPCID = -2
            end
        end
        return UnitInfo.NPCID
    end
    return -1
end

-- IsMfdBlacklisted function
function Unit:IsMfdBlacklisted()
    local npcid = self:NPCID()
    if SpecialMfdBlacklistData[npcid] then
        if type(SpecialMfdBlacklistData[npcid]) == "boolean" then
            return true
        else
            return SpecialMfdBlacklistData[npcid](self)
        end
    end
    return false
end

-- Get if two unit are the same.
function Unit:IsUnit(Other)
    return UnitIsUnit(self.UnitID, Other.UnitID)
end

-------------------------------------------------------------------------------
-- Facing blacklisted check
-------------------------------------------------------------------------------
function Unit:IsFacingBlacklisted()
    if self:IsUnit(A.UnitNotInFront) and TMW.time - A.UnitNotInFrontTime <= A.GetGCD() * A.GetToggle(2, "BlacklistNotFacingExpireMultiplier") then
        return true
    end
    return false
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
	        if (TMW.time <= endtimer) and Unit("player"):CombatTime() > 1 then 
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