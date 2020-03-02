local TMW                                   = TMW
local A     								= Action
local TeamCache								= Action.TeamCache
local EnemyTeam								= Action.EnemyTeam
local FriendlyTeam							= Action.FriendlyTeam
local LoC									= Action.LossOfControl
local Player								= Action.Player 
local MultiUnits							= Action.MultiUnits
local UnitCooldown							= Action.UnitCooldown
local ActiveUnitPlates						= MultiUnits:GetActiveUnitPlates()
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
local PetLib                                = LibStub("PetLibrary")
local Unit                                  = Action.Unit 
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local EventFrame                            = CreateFrame("Frame", "Taste_EventFrame", UIParent)
local UnitIsUnit                            = UnitIsUnit
local StdUi 														= LibStub("StdUi")
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
	[4] = 174044, -- Humming Black Dragonscale

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

------------------------------------
--- RubimRH Area Time To Die
------------------------------------
--@return current average AoE time to die 
function Player:AreaTTD(range)
    local ttdtotal = 0
    local totalunits = 0
	local r = range
	
	for _, unitID in pairs(ActiveUnitPlates) do 
	    if Unit(unitID):GetRange() <= r then 
            local ttd = Unit(unitID):TimeToDie()
            totalunits = totalunits + 1
            ttdtotal = ttd + ttdtotal
		end
    end
	
    if totalunits == 0 then
        return 0
    end

    return ttdtotal / totalunits
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



------------------------------------
--------- COLOR PICKER API ---------
------------------------------------

-- Colors
local cPurple    = "|cffC942FD"
local cBlue      = "|cff00CCFF"
local cGreen     = "|cff00FF00"
local cRed       = "|cffFF0000"
local cWhite     = "|cffFFFFFF"
local cGold      = "|cffFFDD11"
local cLegendary = "|cffff8000"
--[[
-- Color Picker mainframe
local colortitle = StdUi:FontString(tab.frame, 'Main UI color :')
StdUi:GlueTop(colortitle, system1_2, 0, -100, 'LEFT');			
            
local r, g, b, a = RubimRH.db.profile.mainOption.mainframeColor_r, RubimRH.db.profile.mainOption.mainframeColor_g, RubimRH.db.profile.mainOption.mainframeColor_b, RubimRH.db.profile.mainOption.mainframeColor_a                         
            			
window:SetBackdropColor(r, g, b, a)    
local colorInput = StdUi:ColorInput(tab.frame, '', 40, 40, r, g, b, a);
StdUi:FrameTooltip(colorInput, 'Click to open the color picker', 'TOPLEFT', 'TOPRIGHT', true);                
StdUi:GlueTop(colorInput, system1_2, 100, -85, 'LEFT');
function colorInput:OnValueChanged(r, g, b, a)
    window:SetBackdropColor(r, g, b, a)                
    RubimRH.db.profile.mainOption.mainframeColor_r = r 
    RubimRH.db.profile.mainOption.mainframeColor_g = g 
    RubimRH.db.profile.mainOption.mainframeColor_b = b 
    RubimRH.db.profile.mainOption.mainframeColor_a = a 
end	
  ]]-- 

-- Color Picker mainframe action
--local colortitle = StdUi:FontString(tab.frame, 'Main UI color :')
--StdUi:GlueTop(colortitle, anchor, 0, -10, 'LEFT');	
--[[	    
local R, G, B, A = Action.GetToggle(2, "colorpicker").R, Action.GetToggle(2, "colorpicker").G, Action.GetToggle(2, "colorpicker").B, Action.GetToggle(2, "colorpicker").A                       
local color = {r = R, g = G, b = B, a = A}
			

--StdUi:ColorInput(parent, label, width, height, color)
local TastecolorInput = StdUi:ColorInput(anchor, 'colorpicker', 150, 50, color);
StdUi:FrameTooltip(TastecolorInput, 'Click to open the color picker', 'TOPLEFT', 'TOPRIGHT', true);                
StdUi:GlueTop(TastecolorInput, colortitle, 20, -10, 'RIGHT');
function TastecolorInput:OnValueChanged(color)
    TMW.db.global.ActionDB.mainframeColor_r = color.r
    TMW.db.global.ActionDB.mainframeColor_g = color.g
    TMW.db.global.ActionDB.mainframeColor_b = color.b
    TMW.db.global.ActionDB.mainframeColor_a = color.a
	ColorizeUI('Panel', color.r, color.g, color.b, color.a)
    StdUi.config.backdrop.panel = { r = color.r, g = color.g, b = color.b, a = color.a }
    Action.MainUI:SetBackdropColor(color.r, color.g, color.b, color.a   )     
	
    print(color.r)
	print(color.g)
	print(color.b)
	print(color.a)
end	

]]--

--local StdUi = LibStub('StdUi'):NewInstance();



function Action.ColorizeUI(elementType, R, G, B, A)
local L = Action.GetLocalization()
local colorpickertoggle = Action.GetToggle(2, "colorpicker")
--print(colorpickertoggle.R)
--print(colorpickertoggle.G)
--print(colorpickertoggle.B)
--print(colorpickertoggle.A)



    local currentElement = elementType
	
    local PanelCustom =  { r = colorpickertoggle.R, g = colorpickertoggle.G, b = colorpickertoggle.B, a = colorpickertoggle.A }
    local PanelDefault = { r = 0.0588, g = 0.0588, b = 0, a = 0.8 }

	local SlidersCustom = { r = R, g = G, b = B, a = A }
	local SlidersDefault = { r = 0.15, g = 0.15, b = 0.15, a = 1 }

	local BordersCustom = { r = R, g = G, b = B, a = A }
	local BordersDefault = { r = 0.00, g = 0.00, b = 0.00, a = 1 }
	
	local HighlightCustom = { r = R, g = G, b = B, a = A }
	local HighlightDefault = { r = 0.40, g = 0.40, b = 0, a = 0.5 }	
	
	-- Panel
    -- Seems to contain all window, tooltips, widget including ScrollFrame and ScrollChilds		
	if currentElement == 'Panel' then
        PanelSettings = PanelCustom
	else
	    PanelSettings = PanelDefault
	end
	
	-- Sliders
	if currentElement == 'Sliders' then	
        SlidersSettings = SlidersCustom
	else
	    SlidersSettings = SlidersDefault
	end
	
	-- Borders
	if currentElement == 'Borders' then	
        BordersSettings = BordersCustom
	else
	    BordersSettings = BordersDefault
	end
	
	-- Highlight
	if currentElement == 'Highlight' then	
        HighlightSettings = HighlightCustom
	else
	    HighlightSettings = HighlightDefault
	end
	
	-- Font Size
	local fontSize = 8
	
-- Customizations from UI settings
--StdUi.config.backdrop.panel = { r = R, g = G, b = B, a = A }
StdUi.config = {

	font        = {
		family    = font,
		size      = fontSize,
		titleSize = largeFontSize,
		effect    = 'NONE',
		strata    = 'OVERLAY',
		color     = {
			normal   = { r = 1, g = 1, b = 1, a = 1 },
			custom   = { r = 1, g = 0.9, b = 0, a = 1 },
			disabled = { r = 0.55, g = 0.55, b = 0.55, a = 1 },
			header   = { r = 1, g = 0.9, b = 0, a = 1 },
		}
	},

	backdrop    = {
		texture        = [[Interface\Buttons\WHITE8X8]],
		panel          = PanelSettings,
		slider         = SlidersSettings,

		highlight      = HighlightSettings,
		button         = { r = 0.20, g = 0.20, b = 0.20, a = 1 },
		buttonDisabled = { r = 0.15, g = 0.15, b = 0.15, a = 1 },

		border         = BordersSettings,
		borderDisabled = { r = 0.40, g = 0.40, b = 0.40, a = 1 }
	},
	
	progressBar = {
		color = { r = 1, g = 0.9, b = 0, a = 0.5 },
	},

	highlight   = {
		color = { r = 1, g = 0.9, b = 0, a = 0.4 },
		blank = { r = 0, g = 0, b = 0, a = 0 }
	},

	dialog      = {
		width  = 400,
		height = 100,
		button = {
			width  = 100,
			height = 20,
			margin = 5
		}
	},

	tooltip     = {
		padding = 10
	}
};	
	--StdUi:ApplyBackdrop(frame, type, border, insets)
end

-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
    
    local colorpickerPanel = Action.GetToggle(2, "colorpickerPanel")
	local colorpickerHighlight = Action.GetToggle(2, "colorpickerHighlight")
	local colorpickerBorder = Action.GetToggle(2, "colorpickerBorder")
	local colorpickerMain = Action.GetToggle(2, "colorpickerMain")
	local colorpickerFontNormal = Action.GetToggle(2, "colorpickerFontNormal")
	local colorpickerFontHeader = Action.GetToggle(2, "colorpickerFontHeader")
    --print(colorpickertoggle.R)
    --print(colorpickertoggle.G)
    --print(colorpickertoggle.B)
    --print(colorpickertoggle.A)
    if colorpickerFontNormal then
	    -- Font normal
	    StdUi.config.font.color.normal = { r = colorpickerFontNormal.R, g = colorpickerFontNormal.G, b = colorpickerFontNormal.B, a = colorpickerFontNormal.A }
	end
	
    if colorpickerFontHeader then	
	    -- Font header
	    StdUi.config.font.color.header = { r = colorpickerFontHeader.R, g = colorpickerFontHeader.G, b = colorpickerFontHeader.B, a = colorpickerFontHeader.A }
	end
	
	if colorpickerPanel then
	    -- Panel
	    -- This one seems to override all other settings in StdUi.config
	    --ColorizeUI('Panel', colorpickerPanel.R, colorpickerPanel.G, colorpickerPanel.B, colorpickerPanel.A)	
	    StdUi.config.backdrop.panel = { r = colorpickerPanel.R, g = colorpickerPanel.G, b = colorpickerPanel.B, a = colorpickerPanel.A }
	end
	
	if colorpickerHighlight then
	    -- highlight
	    --ColorizeUI('Highlight', colorpickerHighlight.R, colorpickerHighlight.G, colorpickerHighlight.B, colorpickerHighlight.A)	
	    StdUi.config.backdrop.highlight = { r = colorpickerHighlight.R, g = colorpickerHighlight.G, b = colorpickerHighlight.B, a = colorpickerHighlight.A }
	end
	
	if colorpickerBorder then
	    -- border
	    --ColorizeUI('Border', colorpickerBorder.R, colorpickerBorder.G, colorpickerBorder.B, colorpickerBorder.A)	
	    StdUi.config.backdrop.border = { r = colorpickerBorder.R, g = colorpickerBorder.G, b = colorpickerBorder.B, a = colorpickerBorder.A }
	end
		
	-- Main
	--ColorizeUI('Panel', colorpickerMain.R, colorpickerMain.G, colorpickerMain.B, colorpickerMain.A)	
	--StdUi.config.backdrop.panel = { r = colorpickerMain.R, g = colorpickerMain.G, b = colorpickerMain.B, a = colorpickerMain.A }
	--if Action.MainUI:IsShown() then 
	--	Action.MainUI:SetBackdropColor(colorpickerMain.R, colorpickerMain.G, colorpickerMain.B, colorpickerMain.A   )
	--end 
	
		
	
end)

--/dump TMW.db.global.ActionDB.mainframeColor_r
--local mainframeColor_r = TMW.db.profile.ActionDB[tab.name][specID][config.DB].mainframeColor_r --TMW.db.global.ActionDB.mainframeColor_r
--local mainframeColor_g = TMW.db.profile.ActionDB[tab.name][specID][config.DB].mainframeColor_g --TMW.db.global.ActionDB.mainframeColor_g
---local mainframeColor_b = TMW.db.profile.ActionDB[tab.name][specID][config.DB].mainframeColor_b --TMW.db.global.ActionDB.mainframeColor_b
--local mainframeColor_a = TMW.db.profile.ActionDB[tab.name][specID][config.DB].mainframeColor_a --TMW.db.global.ActionDB.mainframeColor_a
--ColorizeUI('Panel', mainframeColor_r, mainframeColor_g, mainframeColor_b, mainframeColor_a)
--ColorizeUI("Borders", 1, 0, 0.5, 0.6)
--[[
-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
TMW:RegisterCallback("TMW_ACTION_UI_COLOR_PICKER", function()
    local colorpickertoggle = Action.GetToggle(2, "colorpicker")
    --print(colorpickertoggle.R)
    --print(colorpickertoggle.G)
    --print(colorpickertoggle.B)
    --print(colorpickertoggle.A)
	ColorizeUI('Panel', colorpickertoggle.R, colorpickertoggle.G, colorpickertoggle.B, colorpickertoggle.A)	
	StdUi.config.backdrop.panel = { r = colorpickertoggle.R, g = colorpickertoggle.G, b = colorpickertoggle.B, a = colorpickertoggle.A }
end)

-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
    local colorpickertoggle = Action.GetToggle(2, "colorpicker")
    --print(colorpickertoggle.R)
    --print(colorpickertoggle.G)
    --print(colorpickertoggle.B)
    --print(colorpickertoggle.A)
	ColorizeUI('Panel', colorpickertoggle.R, colorpickertoggle.G, colorpickertoggle.B, colorpickertoggle.A)	
	StdUi.config.backdrop.panel = { r = colorpickertoggle.R, g = colorpickertoggle.G, b = colorpickertoggle.B, a = colorpickertoggle.A }
	
end)

-- Hook on Action initilization
hooksecurefunc(Action, "OnInitialize", function()
    local colorpickertoggle = Action.GetToggle(2, "colorpicker")
    --print(colorpickertoggle.R)
    --print(colorpickertoggle.G)
    --print(colorpickertoggle.B)
    --print(colorpickertoggle.A)
	ColorizeUI('Panel', colorpickertoggle.R, colorpickertoggle.G, colorpickertoggle.B, colorpickertoggle.A)	
	StdUi.config.backdrop.panel = { r = colorpickertoggle.R, g = colorpickertoggle.G, b = colorpickertoggle.B, a = colorpickertoggle.A }
	
end)

-- Hook on Action initilization
--hooksecurefunc(Action, "ToggleMainUI", function()

	
--end)
]]--
--[[]]--
-- Hook on Action initilization
hooksecurefunc(Action, "ToggleMainUI", function()
    local colorpickerMain = Action.GetToggle(2, "colorpickerMain")
	if Action.MainUI:IsShown() and colorpickerMain then 
		Action.MainUI:SetBackdropColor(colorpickerMain.R, colorpickerMain.G, colorpickerMain.B, colorpickerMain.A   )
    end 
	
end)

-- Disable DBM option by default
--if A.GetToggle(1, "DBM") then
--	Action.SetToggle({1, "DBM", L["TAB"][1]["DBM"] .. ": "}, false)
--	/run Action.SetToggle({1, "DBM", "Timeur DBM: "}, false)

--end


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

local function removeLastChar(text)
	return text:sub(1, -2)
end

local tabFrame, strOnlyBuilder
local function GetTableKeyIdentify(action)
	-- Using to link key in DB
	if not action.TableKeyIdentify then 
		action.TableKeyIdentify = strOnlyBuilder(action.SubType, action.ID, action.Desc, action.Color)
	end 
	return action.TableKeyIdentify
end

--- Draw a dynamic list based on current Blocked and Queued spells
--- Future will add some other functions
local function GetActionSpellStatus()
    local BlockedSpell = {
    
    }
		
    --for i = 1, #Action[Action.PlayerSpec] do
	---    if TMWdb.profile.ActionDB[3][Action.PlayerSpec].disabledActions[i] then
	--	    return    
	--end 
	local PlayerSpec = Action[Action.PlayerSpec]
	local Error = "Error during initilization of Taste Status Frame"
	
	if PlayerSpec then
	
	    for k, v in pairs(PlayerSpec) do 
			if type(v) == "table" and v.Type == "Spell" then 	
                local currentSpell = Action[Action.PlayerSpec][k]	
                print(v.ID)
                print(Action[Action.PlayerSpec][k])				
				if currentSpell then 
			        --tableinsert(BlockedList, )
			        BlockedSpell = v.ID .. " Blocked"				
			    else
			        BlockedSpell = v.ID .. " Unlocked"
			    end
			end 
			--return BlockedSpell
		end 
    end
	
--	for i = 1, #TMWdb.profile.ActionDB[3][Action.PlayerSpec].disabledActions
	    
	
--[[		for k, v in pairs(PlayerSpec) do
		--Action[Action.PlayerSpec].WordofGlory
		    local currentSpell = k
	  	    if currentSpell:IsBlocked() then
			    --tableinsert(BlockedList, )
			    BlockedSpell = currentSpell .. " Blocked"
				
			else
			    BlockedSpell = currentSpell .. " Unlocked"
			end
		end]]--
		
	
--[[	
    local tabFrame
    local CL, L = "enUS"
	local BlockedSpell = ""
	local spec = Action.PlayerSpec .. CL	
    local ScrollTable = tabFrame.tabs[3].childs[spec].ScrollTable
    for i = 1, #data do 
	    if Identify == GetTableKeyIdentify(ScrollTable.data[i]) then 
	    	if self:IsBlocked() then 
		    	BlockedSpell = " Blocked"
		    else 
		    	BlockedSpell = " Unblocked"
		    end								 			
	    end 
    end
	]]--
	return BlockedSpell or Error
end

------------------------------------
-- DogTags
------------------------------------
local DogTag = LibStub("LibDogTag-3.0", true)
-- Taste's 
TMW:RegisterCallback("TMW_ACTION_NOTIFICATION", DogTag.FireEvent, DogTag)

------------------------------------
--------- NOTIFICATIONS API -------
------------------------------------
-- Return a tost notification directly in game with status information from rotation. Useful for custom events announcer    
-- @Parameters : Message and Spell are mandatory settings. 
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



if DogTag then
	-- Custom Icon
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

	-- Status Frame Blocked Spells
	DogTag:AddTag("TMW", "ActionStatusBlocked", {
        code = function()
		    local GetActionSpellStatus = GetActionSpellStatus()
            if GetActionSpellStatus then
			    return GetActionSpellStatus
			end
        end,
        ret = "string",
        doc = "Displays Blocked Spells",
		example = '[ActionStatusFrame] => "GetActionSpellStatus()"',
        events = "TMW_ACTION_STATUS_BLOCKED",
        category = "Action",
    })		
	
	-- The biggest problem of TellMeWhen what he using :setup on frames which use DogTag and it's bring an error
	TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()
		TMW:Fire("TMW_ACTION_NOTIFICATION")
	end)
end
