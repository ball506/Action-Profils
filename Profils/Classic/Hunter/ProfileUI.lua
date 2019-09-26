-------------------------------------------------------------------------------
-- Introduction 
-------------------------------------------------------------------------------
--[[
If you plan to build profile without use lua then you can skip this guide
]]

-------------------------------------------------------------------------------
-- ?1: Create snippet 
-------------------------------------------------------------------------------
--[[
Write in chat /tmw > LUA Snippets > Profile (left side) > "+" > Write name "ProfileUI" in title of the snippet
]]

-------------------------------------------------------------------------------
-- ?2: Set profile defaults 
-------------------------------------------------------------------------------
-- Constances (wrriten in Constans.lua)

-- Map
local TMW = TMW 
local CNDT = TMW.CNDT 
local Env = CNDT.Env
local A = Action

-- This indicates to use 'The Action's all components and make it initializated for current profile 
A.Data.ProfileEnabled[TMW.db:GetCurrentProfile()] = true 

-------------------------------------------------------------------------------
-- ?3: Create UI on 'The Action' for current profile 
-------------------------------------------------------------------------------
A.Data.ProfileUI = {	
	DateTime = "v1.2a (01.01.2850)",
	 -- Profile UI
	[2] = { 
	    [Action.HUNTER] = {					
			{
				{	
					E = "Header",
					L = { 
						enUS = "HEADER", 
						ruRU = "?????????", 
					}, 
					S = 14,
				},
			},					
			{	-- FeignDeathHP slider						
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FeignDeathHP",
                    DBV = 20, -- Set default healthpercentage @20% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(109304) .. " (%)", -- Feign Deaht spell id
                    }, 
                    M = {},
                },
				-- A Checkbox
				{
					E = "Checkbox", 
					DB = "Shiv",
					DBV = false,
					L = { 
						enUS = "Enable Shiv", 
						ruRU = "?????????????? ?????", 
					}, 
					TT = { 
						enUS = "Enable to use", 
						ruRU = "???????? ??? ?????????????", 
					}, 
					M = {},
				},
			},
			{
				{
					E = "Dropdown", 														
					H = 20,
					OT = {
						{ text = "Leap", value = 1 },
						{ text = "Blink", value = 2 },
						{ text = "Portal", value = 3 }
					},
					MULT = true,
					--isNotEqualVal = *any*, -- only if MULT is false or omited 
					DB = "DropdownMult",
					DBV = {
						[1] = true,
						[2] = true,
						[3] = true,
					}, 
					SetPlaceholder = { 
						enUS = "-- DropdownMult --", 
						ruRU = "-- ?????????? ?????? --", 
					}, 
					L = { 
						enUS = "DropdownMult Config", 
						ruRU = "???????????????? ??????", 
					}, 
					TT = { 
						enUS = "ToolTip Mult", 
						ruRU = "??????? ??????", 
					}, 
					M = {},									
				},
				{
					E = "Checkbox", 
					DB = "CKnoMacro",
					DBV = true,
					L = { 
						enUS = "CKnoMacro", 
						ruRU = "??????? ??? ?????", 
					}, 
					TT = { 
						enUS = "English ToolTip", 
						ruRU = "??????? ??????", 
					}, 
				},
			},
			{
				{
					E = "Checkbox", 
					DB = "ShortCK",
					DBV = true,
					L = { 
						enUS = "Short checkBox", 
						ruRU = "???????? ????", 
					}, 
				},
				{
					E = "Dropdown", 														
					H = 20,
					OT = {
						{ text = "Simcraft", value = "Simcraft" },
						{ text = "Custom", value = "Custom" },
						{ text = "Off", value = "Off" }
					},
					MULT = false,
					--isNotEqualVal = *any*, -- only if MULT is false or omited 
					DB = "DropdownSingle",
					DBV = "Simcraft",
					L = { 
						enUS = "Dropdown SINGLE", 
						ruRU = "?????????? ??????.", 
					}, 
					TT = { 
						enUS = "ToolTip SINGLE", 
						ruRU = "??????? ??????.", 
					}, 
					M = {
						Custom = [[/run Toggle()]],
					},
				},
			},

	    },
	},
	 -- MSG Actions UI
	[7] = {
	    [Action.HUNTER] = {
			["shield"] = { Enabled = true, Key = "POWS", LUAVER = 1, LUA = [[
				-- thisunit is a special thing which will be replaced by string of unitID. Example: some one said phrase "shield party1" then thisunit will be replaced by "party1" and for this MSG will be used meta [7] which is Party1 Rotation which is A[7]()
				-- Confused? huh yeah but that's how it works, to make it easier you can simply set "target" right into this code as example if you want only "target", then SpellInRange("target", Action[Action.PlayerClass].POWS.ID) 
				-- More info in Action.lua 
				-- You have to keep in mind what once written in DataBase this code can't be changed if you made changes in ProfileUI, you have to use 'Reset Settings' and other people too if you failed here with code, so take attention on it. That's probably one lack of 'The Action' 
				return 	Action[PlayerClass].POWS:IsInRange(thisunit) and 											
						Action[PlayerClass].POWS:AbsentImun(thisunit) and 
						Action.LossOfControl:IsMissed("SILENCE") and 
						Action.LossOfControl:Get("SCHOOL_INTERRUPT", "HOLY") == 0
			]] },
	    },
	},  
}

-------------------------------------------------------------------------------
-- ?4: Use remain space for shared code between all specializations in profile 
-------------------------------------------------------------------------------
-- I prefer use here configuration for "Shown Cast Bars" because it's shared 
-- Example:
function A.Main_CastBars(unit, list)
	-- Is [1] -> [3] meta icons in "Shown CastBars", green (Heals) / red (PvP)
	if not A.IsInitialized or A.IamHealer or not A.IsInPvP then 
		return false 
	end 
	
	if A[A.PlayerClass] and A[A.PlayerClass].SpearHandStrike and A[A.PlayerClass].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerClass].SpearHandStrike:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
		return true 		
	end 
end 

function A.Second_CastBars(unit)
	-- Is [1] -> [3] meta icons in "Shown CastBars", yellow
	if not A.IsInitialized or not A.IsInPvP then 
		return false 
	end 
	
	local Toggle = A.GetToggle(2, "ParalysisPvP")	
	if Toggle and Toggle ~= "OFF" and A[A.PlayerClass] and A[A.PlayerClass].Paralysis and A[A.PlayerClass].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerClass].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and A.Unit(unit):IsControlAble("incapacitate", 0) then 
		if Toggle == "BOTH" then 
			return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
		else
			return select(2, A.InterruptIsValid(unit, Toggle, true)) 		
		end 
	end 
end 
-- Now add these functions in "Shown Cast Bars" group in /tmw by right click on each icon > Conditions > "+" > LUA > YOUR FUNCTION
-- return Action.Second_CastBars(thisobj.Unit) --or return Action.Second_CastBars("arena1")