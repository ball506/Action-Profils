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
local error                                 = error
local setmetatable                          = setmetatable
local stringformat                          = string.format
local tableinsert                           = table.insert


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