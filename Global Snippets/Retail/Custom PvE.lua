---------------------------------------------------
---------------- CUSTOM PVE FUNCTIONS -------------
---------------------------------------------------
local TMW                                   = _G.TMW
local A                                     = _G.Action
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
local error                                 = error
local setmetatable                          = setmetatable
local stringformat                          = string.format
local tableinsert                           = table.insert
local TR                                    = Action.TasteRotation
local _G, math, setmetatable                = _G, math, setmetatable
local GameLocale                            = A.FormatGameLocale(_G.GetLocale())
local StdUi                                 = A.StdUi -- Custom StdUI with Action shared settings
local Factory                               = StdUi.Factory
local math_random                           = math.random

-------------------------------------------------------------------------------
-- Tanks specifics functions
-------------------------------------------------------------------------------
-- To do: update for BFA !!
local ActiveMitigationSpells = {
    Buff = {
        -- PR Legion
        191941, -- Darkstrikes (VotW - 1st)
        204151, -- Darkstrikes (VotW - 1st)
        -- T20 ToS
        239932 -- Felclaws (KJ)
    },
    Debuff = {	
	    255434,
		265881,
		264556,
		270487,
		274358,
		270447,
	},
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
        258039, -- Deadly Scythe (Argus)
        -- BFA
		267899, -- Shrine of the Storm
		272457, -- Underrot
		260508, -- Waycrest Manor
		249919, -- Atal'Dazar
		265910, -- King's Rest
		268586, -- King's Rest
		262277, -- Fetid Devourer
		265248, -- Zek'voz
		273316, -- Zul, Reborn
		273282, -- Mythrax the Unraveler
	
	},
    Channel = {}
}

-------------------------------------------------------------------------------
-- Active mitigation 
-------------------------------------------------------------------------------
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
        for _, Debuff in pairs(ActiveMitigationSpells.Debuff) do
            if Unit("player"):HasDeBuffs(Debuff, true) > 0 then
                return true
            end
        end
    end
    return false
end

-------------------------------------------------------------------------------
-- Smart Reflect Mythic+
-------------------------------------------------------------------------------
-- @Use with inside rotation function

TR.Lists.ReflectID = {
    --Battle of Dazar'alor
    [283572] = "Sacred Blade",
    [284449] = "Reckoning",
    [286988] = "Divine Burst",
    [282036] = "Fireball",
    [286988] = "Searing Embers",
    [286646] = "Gigavolt Charge",
    [282182] = "Buster Cannon",
    --Uldir
    [279669] = "Bacterial Outbreak",
    [279660] = "Endemic Virus",
    [274262] = "Explosive Corruption",
    --Reaping
    [288693] = "Grave Bolt",
    --Atal'Dazar
    [250096] = "Wracking Pain",
    [253562] = "Wildfire",
    [252923] = "Venom Blast",
    --Kings Rest
    [267618] = "Drain Fluids",
    [267308] = "Lighting Bolt",
    [270493] = "Spectral Bolt",
    [269973] = "Deathly Chill",
    [270923] = "Shadow Bolt",
    --Free Hold
    [259092] = "Lightning Bolt",
    [281420] = "Water Bolt",
    --Siege of Boralus
    [272588] = "Rotting Wounds",
    [272581] = "Water Spray",
    [257063] = "Brackish Bolt",
    [272571] = "Choking Waters",
    -- Temple of Sethraliss
    [263318] = "Jolt",
    [263775] = "Gust",
    [268061] = "Chain Lightning",
    [272820] = "Shock",
    [268013] = "Flame Shock",
    [274642] = "Lava Burst",
    [268703] = "Lightning Bolt",
    [272699] = "Venomous Spit",
    --Shrine of the Storm
    [265001] = "Sea Blast",
    [264560] = "Choking Brine",
    [264144] = "Undertow",
    [268347] = "Void Bolt",
    [267969] = "Water Blast",
    [268233] = "Electrifying Shock",
    [268315] = "Lash",
    [268177] = "Windblast",
    [268273] = "Deep Smash",
    [268317] = "Rip Mind",
    [265001] = "Sea Blast",
    [274703] = "Void Bolt",
    [268214] = "Carve Flesh",
    --Motherlode
    [259856] = "Chemical Burn",
    [260318] = "Alpha Cannon",
    [262794] = "Energy Lash",
    [263202] = "Rock Lance",
    [262268] = "Caustic Compound",
    [263262] = "Shale Spit",
    [263628] = "Charged Claw",
    --Underrot
    [260879] = "Blood Bolt",
    [265084] = "Blood Bolt",
    --Tol Dagor
    [257777] = "Crippling Shiv",
    [257033] = "Fuselighter",
    [258150] = "Salt Blast",
    [258869] = "Blaze",
    --Waycrest Manor
    [260701] = "Bramble Bolt",
    [260700] = "Ruinous Bolt",
    [260699] = "Soul Bolt",
    [268271] = "Wracking Chord",
    [261438] = "Wasting Strike",
    [261440] = "Virulent Pathogen",
    [266225] = "Darkened Lightning",
    [273653] = "Shadow Claw",
    [265881] = "Decaying Touch",
    [264153] = "Spit",
    [278444] = "Infest",
    --Operation: Mechagn
    [298669] = "Taze",
    [300764] = "slimebolt",
    [300650] = "suffocating smog",
    [294195] = "arcing zap",
    [291878] = "pulse blast"
}
-- Stormbolt Warrior Protection
-- Specifics NPC
TR.Lists.Storm_Unit_List = {
    [131009] = "Spirit of Gold",
    [134388] = "A Knot of Snakes",
    [129758] = "Irontide Grenadier"
}  

-- Dangerous NPC Abilities that we can Stormbolt
TR.Lists.Storm_Spells_List = {
    274400,
    274383,
    257756,
    276292,
    268273,
    256897,
    272542,
    272888,
    269266,
    258317,
    258864,
    259711,
    258917,
    264038,
    253239,
    269931,
    270084,
    270482,
    270506,
    270507,
    267433,
    267354,
    268702,
    268846,
    268865,
    258908,
    264574,
    272659,
    272655,
    267237,
    265568,
    277567,
    265540,
    268202,
    258058,
    257739
}

-- All units that we know we can't stun     
TR.Lists.StunsBlackList = {
	-- Atal'Dazar
	[87318] = "Dazar'ai Colossus",
	[122984] = "Dazar'ai Colossus",
	[128455] = "T'lonja",
	[129553] = "Dinomancer Kish'o",
	[129552] = "Monzumi",
	-- Freehold
	[129602] = "Irontide Enforcer",
	[130400] = "Irontide Crusher",
	-- King's Rest
	[133935] = "Animated Guardian",
	[134174] = "Shadow-Borne Witch Doctor",
	[134158] = "Shadow-Borne Champion",
	[137474] = "King Timalji",
	[137478] = "Queen Wasi",
	[137486] = "Queen Patlaa",
	[137487] = "Skeletal Hunting Raptor",
	[134251] = "Seneschal M'bara",
	[134331] = "King Rahu'ai",
	[137484] = "King A'akul",
	[134739] = "Purification Construct",
	[137969] = "Interment Construct",
	[135231] = "Spectral Brute",
	[138489] = "Shadow of Zul",
	-- Shrine of the Storm
	[134144] = "Living Current",
	[136214] = "Windspeaker Heldis",
	[134150] = "Runecarver Sorn",
	[136249] = "Guardian Elemental",
	[134417] = "Deepsea Ritualist",
	[136353] = "Colossal Tentacle",
	[136295] = "Sunken Denizen",
	[136297] = "Forgotten Denizen",
	-- Siege of Boralus
	[129369] = "Irontide Raider",
	[129373] = "Dockhound Packmaster",
	[128969] = "Ashvane Commander",
	[138255] = "Ashvane Spotter",
	[138465] = "Ashvane Cannoneer",
	[135245] = "Bilge Rat Demolisher",
	-- Temple of Sethraliss
	[134991] = "Sandfury Stonefist",
	[139422] = "Scaled Krolusk Tamer",
	[136076] = "Agitated Nimbus",
	[134691] = "Static-charged Dervish",
	[139110] = "Spark Channeler",
	[136250] = "Hoodoo Hexer",
	[139946] = "Heart Guardian",
	-- MOTHERLODE!!
	[130485] = "Mechanized Peacekeeper",
	[136139] = "Mechanized Peacekeeper",
	[136643] = "Azerite Extractor",
	[134012] = "Taskmaster Askari",
	[133430] = "Venture Co. Mastermind",
	[133463] = "Venture Co. War Machine",
	[133436] = "Venture Co. Skyscorcher",
	[133482] = "Crawler Mine",
	-- Underrot
	[131436] = "Chosen Blood Matron",
	[133912] = "Bloodsworn Defiler",
	[138281] = "Faceless Corruptor",
	-- Tol Dagor
	[130025] = "Irontide Thug",
	-- Waycrest Manor
	[131677] = "Heartsbane Runeweaver",
	[135329] = "Matron Bryndle",
	[131812] = "Heartsbane Soulcharmer",
	[131670] = "Heartsbane Vinetwister",
	[135365] = "Matron Alma",
}

-- Protection Paladin Hand of Justice
TR.Lists.HOJ_Unit_List = {
	[131009] = "Spirit of Gold",
	[134388] = "A Knot of Snakes",
	[129758] = "Irontide Grenadier",
}

-- Death Knight Asphyxiate
TR.Lists.Asphyxiate_List = {
    274400,
    274383,
    257756,
    276292,
    268273,
    256897,
    272542,
    272888,
    269266,
    258317,
    258864,
    259711,
    258917,
    264038,
    253239,
    269931,
    270084,
    270482,
    270506,
    270507,
    267433,
    267354,
    268702,
    268846,
    268865,
    258908,
    264574,
    272659,
    272655,
    267237,
    265568,
    277567,
    265540,
    268202,
    258058,
    257739
}

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

------------------------------------
--- MythicPlus system
------------------------------------
-- MythicPlus specific logic by class and specialisation
-- @Return boolean
-- @Usage: spec parameter is mandatory, latency is optional

function TR:MythicPlus(spec, latency)
    local secondsLeft, percentLeft, spellID, spellName, notInterruptable, isChannel = Unit(unit):IsCastingRemains()
	local ExtraordinaryShouldPool = false
	local LatencyModifier = 0
	local PoolTimeValue = 0
	
	-- LatencyModifier
	if latency then
	    LatencyModifier = LatencyModifier + Action.GetPing()
	end	
	
	-- Check for nil
	if spec then 
	
	    -- Havoc DH
		if spec == "havoc" then	
		    PoolTimeValue = 5
			
            -- Tol Dagor
            if A.ZoneID == 9327 and InstanceInfo.KeyStone and InstanceInfo.KeyStone > 1 then
			    -- Overseer Korgus - 1sec before his Dead Eye is ready
			    if Unit("boss1"):GetUnitID() == 127503 and UnitCooldown:GetCooldown("boss1", 256039) > UnitCooldown:GetMaxDuration("boss1", 256039) - (1 + LatencyModifier) then
			       
				   --Pool for BladeDance				   
				   ExtraordinaryShouldPool = true
				   --TMW:Fire("TR_MYTHIC_PLUS_HAVOC_BLADEDANCE_TD1")

                end	
			end
            
			-- King Rest 
            if A.ZoneID == 9526 and InstanceInfo.KeyStone and InstanceInfo.KeyStone > 1 then			
			    -- Aka'ali the Conqueror -  if it’s targeted on you to reduce group-wide damage to zero.
			    if Unit("boss1"):GetUnitID() == 135470 and UnitIsUnit("targettarget", "player") and UnitCooldown:GetCooldown("boss1", 266951) > UnitCooldown:GetMaxDuration("boss1", 266951) - (1 + LatencyModifier) then
			       
				   --Pool for BladeDance
				   ExtraordinaryShouldPool = true
				   --TMW:Fire("TR_MYTHIC_PLUS_HAVOC_BLADEDANCE_KR1")
				   
                end	
			end

			-- Freehold 
            if A.ZoneID == 9164 and InstanceInfo.KeyStone and InstanceInfo.KeyStone > 1 then			
			    -- Captain Eudora - Powder Shot deal high damage
			    if Unit("boss1"):GetUnitID() == 126848 and Unit("boss1"):GetSpellLastCast(A.HowlingBlast) and UnitCooldown:GetCooldown("boss1", 266951) > UnitCooldown:GetMaxDuration("boss1", 266951) - (1 + LatencyModifier) then
			       
				   --Pool for BladeDance
				   ExtraordinaryShouldPool = true
				   --TMW:Fire("TR_MYTHIC_PLUS_HAVOC_BLADEDANCE_FH1")
				   
                end				
            end
			
        end			
	end
	return ExtraordinaryShouldPool
end

--------------------------------------
------- Taste Custom Functions -------
--------------------------------------
-- Since they need some CustomStuff snippets that load in 0.6, these function only work in this CustomPvE snippets that load in 1
-- Only checks IsUsableP against the primary resource for pooling
-- /dump Action[Action.PlayerSpec].WarStomp:IsUsablePPool()
-- /dump Action[Action.PlayerSpec].WarStomp.ID:IsUsablePPool()
function A:IsUsablePPool(Offset)
    local CostInfo, TypeInfo = self:GetSpellPowerCost() 	
	--print(CostInfo)
	--print(TypeInfo)
    if CostInfo and TypeInfo then
        return ( Player.PredictedResourceMap[TypeInfo]() >= ( CostInfo + ( Offset and Offset or 0 ) ) )
    else
        return true
    end
end

-- Base Duration of a dot/hot/channel...
local SpellDuration = TR.Enum.SpellDuration
function A:BaseDuration()
    local Duration = SpellDuration[self.ID]
    if not Duration or Duration == 0 then 
	    return 0 
	end
    local BaseDuration = Duration[1]
    return BaseDuration / 1000
end

-- Max Duration of a dot/hot/channel...
function A:MaxDuration()
    local Duration = SpellDuration[self.ID]
    if not Duration or Duration == 0 then 
	    return 0 
	end
    local BaseDuration = Duration[2]
    return BaseDuration / 1000
end

-- action.foo.travel_time
local ProjectileSpeed = TR.Enum.ProjectileSpeed
function A:FilterProjectileSpeed(SpecID)
    local RegisteredSpells = {}
    local BaseProjectileSpeed = TR.Enum.ProjectileSpeed -- In case FilterTravelTime is called multiple time, we take the Enum table as base.
    -- Fetch registered spells during the init
	for Spec, Spells in pairs(Action[Action.PlayerSpec]) do
    for _, Spell in pairs(Spells) do
        local SpellID = Spell.ID
        local ProjectileSpeedInfo = BaseProjectileSpeed[SpellID]
        if ProjectileSpeedInfo ~= nil then
                RegisteredSpells[SpellID] = ProjectileSpeedInfo
            end
        end
    end
    ProjectileSpeed = RegisteredSpells
end

function A:TravelTime()
    local Speed = ProjectileSpeed[self.ID]
    if not Speed or Speed == 0 then 
	    return 0 
	end
    return ACTION_CONST_CACHE_DEFAULT_NAMEPLATE_MAX_DISTANCE / (ProjectileSpeed[self.ID] or 22)
end

local L                                     = setmetatable({
        ruRU = {
            TasteInterruptName = "BFA Mythic+ & Raid (by Dizzy)",
        },    
        enUS = {
            TasteInterruptName = "BFA Mythic+ & Raid (by Dizzy)",
        },    
    }, { __index = function(t) return t.enUS end })

TMW:RegisterCallback("TMW_ACTION_INTERRUPTS_UI_CREATE_CATEGORY", function(callbackEvent, Category)
        Category.options[#Category.options + 1] = { text = L[GameLocale].TasteInterruptName, value = "PvEContent" }
        Category:SetOptions(Category.options)
end)

-- Custom BFA Interrupt list
-- Factory[4].PvEContent
-- /dump Action.StdUi.Factory[4].PvEContent[Action.FormatGameLocale(_G.GetLocale())][256060].useCC
Factory[4].PvEContent = StdUi:tGenerateMinMax({
        [GameLocale] = {    
            ISINTERRUPT = true,
            -- Freehold
            [256060] = { useKick = true, useCC = false, useRacial = false }, -- Kick
            [257397] = { useKick = true, useCC = true, useRacial = true }, -- All
            [257899] = { useKick = false, useCC = false, useRacial = false }, -- Block
            [257736] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [257739] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [257756] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [257784] = { useKick = true, useCC = true, useRacial = true }, -- All
            [257870] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [258779] = { useKick = true, useCC = true, useRacial = true }, -- All
            [274383] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [274400] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [274507] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [281420] = { useKick = false, useCC = true, useRacial = true }, -- CC
			-- Atal'Dazar
            [250096] = { useKick = true, useCC = false, useRacial = false }, -- Kick
            [252781] = { useKick = true, useCC = true, useRacial = true }, -- All
            [252923] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [253562] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [253583] = { useKick = true, useCC = true, useRacial = true }, -- All
            [253666] = { useKick = true, useCC = true, useRacial = true }, -- All
            [254959] = { useKick = true, useCC = false, useRacial = false }, -- Kick
            [255041] = { useKick = true, useCC = true, useRacial = true }, -- All
            [255824] = { useKick = true, useCC = true, useRacial = true }, -- All
            [256849] = { useKick = true, useCC = false, useRacial = false }, -- Kick
            [258653] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [259572] = { useKick = true, useCC = false, useRacial = false }, -- Kick
            [260668] = { useKick = false, useCC = true, useRacial = true }, -- CC		
			-- King's Rest
            [269931] = { useKick = false, useCC = true, useRacial = true }, -- CC	
            [269972] = { useKick = true, useCC = false, useRacial = false }, -- Kick
            [269973] = { useKick = false, useCC = false, useRacial = false }, -- Block
            [270084] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [270482] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [270492] = { useKick = true, useCC = true, useRacial = true }, -- All
            [270493] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [270507] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [270872] = { useKick = false, useCC = true, useRacial = true }, -- CC
            [270901] = { useKick = true, useCC = false, useRacial = false }, -- Kick
            [270920] = { useKick = true, useCC = true, useRacial = true }, -- All
            [270923] = { useKick = false, useCC = false, useRacial = false }, -- Block	
			-- Shrine of the Storm
[267809] = { useKick = false, useCC = false, useRacial = false }, -- Block
[267969] = { useKick = true, useCC = true, useRacial = true }, -- All
[267973] = { useKick = false, useCC = false, useRacial = false }, -- Block
[267977] = { useKick = false, useCC = true, useRacial = true }, -- CC
[267981] = { useKick = true, useCC = true, useRacial = true }, -- All
[268030] = { useKick = true, useCC = true, useRacial = true }, -- All
[268050] = { useKick = false, useCC = false, useRacial = false }, -- Block
[268177] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[268273] = { useKick = true, useCC = true, useRacial = true }, -- All
[268309] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[268317] = { useKick = true, useCC = true, useRacial = true }, -- All
[268322] = { useKick = true, useCC = true, useRacial = true }, -- All
[268375] = { useKick = true, useCC = true, useRacial = true }, -- All
[274437] = { useKick = true, useCC = true, useRacial = true }, -- All
[274703] = { useKick = true, useCC = true, useRacial = true }, -- All
[276297] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[276292] = { useKick = false, useCC = true, useRacial = true }, -- CC
[274631] = { useKick = true, useCC = true, useRacial = true }, -- All
[268315] = { useKick = false, useCC = true, useRacial = true }, -- CC
[268347] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[267818] = { useKick = true, useCC = false, useRacial = false }, -- Kick
--[276266]	Purge	

        -- Siege of Boralus	
[256957] = { useKick = true, useCC = true, useRacial = true }, -- All
[272571] = { useKick = false, useCC = true, useRacial = true }, -- CC
[272581] = { useKick = true, useCC = true, useRacial = true }, -- All
[272588] = { useKick = true, useCC = true, useRacial = true }, -- All
[274569] = { useKick = true, useCC = true, useRacial = true }, -- All
[274941] = { useKick = false, useCC = true, useRacial = true }, -- CC
[256627] = { useKick = false, useCC = true, useRacial = true }, -- CC
[257641] = { useKick = false, useCC = true, useRacial = true }, -- CC
[257292] = { useKick = false, useCC = true, useRacial = true }, -- CC
[256866] = { useKick = false, useCC = true, useRacial = true }, -- CC
        -- Temple of Seth
[255741] = { useKick = false, useCC = true, useRacial = true }, -- CC
[263318] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[263775] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[264574] = { useKick = false, useCC = true, useRacial = true }, -- CC
[265912] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[265968] = { useKick = true, useCC = true, useRacial = true }, -- All
[267237] = { useKick = false, useCC = true, useRacial = true }, -- CC
[268008] = { useKick = false, useCC = true, useRacial = true }, -- CC
[268061] = { useKick = true, useCC = true, useRacial = true }, -- All
[268703] = { useKick = false, useCC = true, useRacial = true }, -- CC
[269116] = { useKick = false, useCC = true, useRacial = true }, -- CC
[272657] = { useKick = false, useCC = true, useRacial = true }, -- CC
[272659] = { useKick = true, useCC = true, useRacial = true }, -- All
[272696] = { useKick = false, useCC = false, useRacial = false }, -- Block
[272700] = { useKick = true, useCC = true, useRacial = true }, -- All
[272820] = { useKick = false, useCC = true, useRacial = true }, -- CC
[274642] = { useKick = true, useCC = false, useRacial = false }, -- Kick

-- Motherload
[258627] = { useKick = false, useCC = true, useRacial = true }, -- CC
[262092] = { useKick = true, useCC = true, useRacial = true }, -- All
[262377] = { useKick = false, useCC = true, useRacial = true }, -- CC
[262540] = { useKick = false, useCC = true, useRacial = true }, -- CC
[262554] = { useKick = true, useCC = true, useRacial = true }, -- All
[262794] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[262947] = { useKick = true, useCC = true, useRacial = true }, -- All
[263066] = { useKick = true, useCC = true, useRacial = true }, -- All
[263103] = { useKick = false, useCC = true, useRacial = true }, -- CC
[263202] = { useKick = true, useCC = true, useRacial = true }, -- All
[263215] = { useKick = false, useCC = true, useRacial = true }, -- CC
[267354] = { useKick = false, useCC = true, useRacial = true }, -- CC
[268129] = { useKick = false, useCC = true, useRacial = true }, -- CC
[268702] = { useKick = true, useCC = true, useRacial = true }, -- All
[268709] = { useKick = false, useCC = true, useRacial = true }, -- CC
[268797] = { useKick = true, useCC = true, useRacial = true }, -- All
[268865] = { useKick = false, useCC = true, useRacial = true }, -- CC
[269302] = { useKick = true, useCC = true, useRacial = true }, -- All
[280604] = { useKick = true, useCC = true, useRacial = true }, -- All

 -- Underrot
[260879] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[265081] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[265084] = { useKick = false, useCC = true, useRacial = true }, -- CC
[265089] = { useKick = true, useCC = true, useRacial = true }, -- All
[265091] = { useKick = false, useCC = true, useRacial = true }, -- CC
[265376] = { useKick = false, useCC = true, useRacial = true }, -- CC
[265377] = { useKick = false, useCC = true, useRacial = true }, -- CC
[265433] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[265487] = { useKick = true, useCC = true, useRacial = true }, -- All
[265523] = { useKick = false, useCC = false, useRacial = false }, -- Block
[265540] = { useKick = false, useCC = true, useRacial = true }, -- CC
[265568] = { useKick = false, useCC = true, useRacial = true }, -- CC
[265668] = { useKick = false, useCC = false, useRacial = false }, -- Block
[266106] = { useKick = true, useCC = true, useRacial = true }, -- All
[266107] = { useKick = false, useCC = true, useRacial = true }, -- CC
[266201] = { useKick = false, useCC = true, useRacial = true }, -- CC
[266209] = { useKick = false, useCC = true, useRacial = true }, -- CC
[272180] = { useKick = true, useCC = true, useRacial = true }, -- All
[272183] = { useKick = true, useCC = true, useRacial = true }, -- All
[278755] = { useKick = true, useCC = true, useRacial = true }, -- All
[278961] = { useKick = true, useCC = true, useRacial = true }, -- All

-- Tol Dagor	
[258128] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[258150] = { useKick = false, useCC = true, useRacial = true }, -- CC
[258153] = { useKick = true, useCC = true, useRacial = true }, -- All
[258313] = { useKick = true, useCC = true, useRacial = true }, -- All
[258317] = { useKick = false, useCC = true, useRacial = true }, -- CC
[258634] = { useKick = false, useCC = false, useRacial = false }, -- Block
[258864] = { useKick = false, useCC = true, useRacial = true }, -- CC
[258869] = { useKick = true, useCC = true, useRacial = true }, -- All
[258917] = { useKick = false, useCC = true, useRacial = true }, -- CC
[258935] = { useKick = true, useCC = true, useRacial = true }, -- All

-- Waycrest	
[260699] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[260700] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[260701] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[263891] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[263943] = { useKick = true, useCC = true, useRacial = true }, -- All
[263959] = { useKick = true, useCC = true, useRacial = true }, -- All
[264024] = { useKick = false, useCC = false, useRacial = false }, -- Block
[264050] = { useKick = true, useCC = true, useRacial = true }, -- All
[264105] = { useKick = false, useCC = true, useRacial = true }, -- CC
[264153] = { useKick = false, useCC = true, useRacial = true }, -- CC
[264390] = { useKick = false, useCC = true, useRacial = true }, -- CC
[264396] = { useKick = false, useCC = true, useRacial = true }, -- CC
[264520] = { useKick = true, useCC = true, useRacial = true }, -- All
[264525] = { useKick = true, useCC = true, useRacial = true }, -- All
[265346] = { useKick = true, useCC = true, useRacial = true }, -- All
[265368] = { useKick = true, useCC = true, useRacial = true }, -- All
[265407] = { useKick = true, useCC = true, useRacial = true }, -- All
[265876] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[266035] = { useKick = true, useCC = true, useRacial = true }, -- All
[266036] = { useKick = true, useCC = true, useRacial = true }, -- All
[266225] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[267824] = { useKick = true, useCC = true, useRacial = true }, -- All
[268202] = { useKick = false, useCC = true, useRacial = true }, -- CC
[268278] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[271174] = { useKick = false, useCC = true, useRacial = true }, -- CC
[278444] = { useKick = true, useCC = true, useRacial = true }, -- All
[278463] = { useKick = true, useCC = true, useRacial = true }, -- All
[278474] = { useKick = false, useCC = true, useRacial = true }, -- CC
[278504] = { useKick = true, useCC = true, useRacial = true }, -- All
[278551] = { useKick = true, useCC = true, useRacial = true }, -- All

-- Workshop	
[293729] = { useKick = false, useCC = true, useRacial = true }, -- CC
[293827] = { useKick = true, useCC = true, useRacial = true }, -- All
[293930] = { useKick = true, useCC = true, useRacial = true }, -- All
[293986] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[294195] = { useKick = true, useCC = true, useRacial = true }, -- All
[294290] = { useKick = true, useCC = true, useRacial = true }, -- All
[294324] = { useKick = false, useCC = true, useRacial = true }, -- CC

-- Junkyard	
[7289] = { useKick = true, useCC = true, useRacial = true }, -- All
[299475] = { useKick = false, useCC = true, useRacial = true }, -- CC
[31532] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[158338] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[284507] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[48604] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[8365] = { useKick = true, useCC = false, useRacial = false }, -- Kick/Purge
[299415] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[300650] = { useKick = true, useCC = true, useRacial = true }, -- All
[28995] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[300436] = { useKick = true, useCC = false, useRacial = false }, -- Kick

-- Nyalotha 	
[316211] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[313652] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[15407] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[310788] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[29184] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[136993] = { useKick = true, useCC = false, useRacial = false }, -- Kick

-- Awakened	
[314592] = { useKick = true, useCC = true, useRacial = true }, -- All
[314406] = { useKick = true, useCC = false, useRacial = false }, -- Kick
[314411] = { useKick = true, useCC = false, useRacial = false }, -- Kick

        },            
    }, 43, 70, math_random(87, 95), true)