--- ====================== ACTION HEADER ============================ ---
local TMW                                     = TMW 

local Action                                 = Action
local Listener                                 = Action.Listener
local Create                                 = Action.Create
local GetSpellInfo                            = Action.GetSpellInfo
local GetToggle                                = Action.GetToggle
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local ShouldStop                            = Action.ShouldStop
local AuraIsValid                            = Action.AuraIsValid
local InterruptIsValid                        = Action.InterruptIsValid
local BurstIsON                                = Action.BurstIsON
local BossMods_Pulling                        = Action.BossMods_Pulling

local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local HealingEngine                            = Action.HealingEngine
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local IsUnitEnemy                            = Action.IsUnitEnemy 
local IsUnitFriendly                        = Action.IsUnitFriendly 

local TeamCacheFriendly                        = TeamCache.Friendly
local HealingEngineMembersALL                = HealingEngine.GetMembersAll() -- function call!
local HealingEngineGetMinimumUnits            = HealingEngine.GetMinimumUnits
local HealingEngineGetIncomingDMGAVG        = HealingEngine.GetIncomingDMGAVG
local HealingEngineGetIncomingHPSAVG        = HealingEngine.GetIncomingHPSAVG

local _G, setmetatable, select, math        = _G, setmetatable, select, math 
local ACTION_CONST_STOPCAST                    = _G.ACTION_CONST_STOPCAST
local ACTION_CONST_SPELLID_FREEZING_TRAP    = _G.ACTION_CONST_SPELLID_FREEZING_TRAP
local huge                                     = math.huge

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_SHAMAN_RESTORATION] = {
    -- Racial
    ArcaneTorrent                    = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                        = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                        = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                    = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                       = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                      = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                      = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                         = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                         = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                         = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                      = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                       = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                        = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                     = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself               = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Main Spells
    Riptide                          = Action.Create({ Type = "Spell", ID = 61295   }),
	HealingSurge                     = Action.Create({ Type = "Spell", ID = 8004   }),
	HealingWave                      = Action.Create({ Type = "Spell", ID = 77472   }),	
	ChainHeal                        = Action.Create({ Type = "Spell", ID = 1064   }),
	HealingRain                      = Action.Create({ Type = "Spell", ID = 73920   }),
	HealingStreamTotem               = Action.Create({ Type = "Spell", ID = 5394   }),
	TidalWaveBuff                    = Action.Create({ Type = "Spell", ID = 53390   }),
	-- Offensive Abilities
	FlameShock                       = Action.Create({ Type = "Spell", ID = 188838   }),
	FlameShockDebuff                 = Action.Create({ Type = "Spell", ID = 188389   }),
	LavaBurst                        = Action.Create({ Type = "Spell", ID = 51505   }),
	LightningBolt                    = Action.Create({ Type = "Spell", ID = 403   }),
	ChainLightning                   = Action.Create({ Type = "Spell", ID = 421   }),
	-- Cooldowns
	HealingTideTotem                 = Action.Create({ Type = "Spell", ID = 108280   }),
	SpiritLinkTotem                  = Action.Create({ Type = "Spell", ID = 98008   }),
	SpiritWalkersGrace               = Action.Create({ Type = "Spell", ID = 79206   }),
	-- Defensives
	AstralShift                      = Action.Create({ Type = "Spell", ID = 108271   }),
	-- Utilities
	AncestralSpirit                  = Action.Create({ Type = "Spell", ID = 2008   }),
	AncestralVision                  = Action.Create({ Type = "Spell", ID = 212048   }),
	AstralRecall                     = Action.Create({ Type = "Spell", ID = 556   }),
	EarthbindTotem                   = Action.Create({ Type = "Spell", ID = 2484   }),
	FarSight                         = Action.Create({ Type = "Spell", ID = 6196   }),
	GhostWolf                        = Action.Create({ Type = "Spell", ID = 2645   }),
	Bloodlust                        = Action.Create({ Type = "Spell", ID = 2825   }),
	Heroism                          = Action.Create({ Type = "Spell", ID = 32182   }),
	Hex                              = Action.Create({ Type = "Spell", ID = 51514   }),
	Purge                            = Action.Create({ Type = "Spell", ID = 370   }),
	PurifySpirit                     = Action.Create({ Type = "Spell", ID = 77130   }),
	WaterWalking                     = Action.Create({ Type = "Spell", ID = 546   }),
	WindShear                        = Action.Create({ Type = "Spell", ID = 57994   }),
	TremorTotem                      = Action.Create({ Type = "Spell", ID = 8143   }),
	EarthElemental                   = Action.Create({ Type = "Spell", ID = 198103   }),
	CapacitorTotem                   = Action.Create({ Type = "Spell", ID = 192058   }),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	

};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_SHAMAN_RESTORATION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_RESTORATION], { __index = Action })


------------------------------------------
---------------- VARIABLES ---------------
------------------------------------------
local VarPoolSoulShards = 0;

A.Listener:Add("ROTATION_VARS", "PLAYER_REGEN_ENABLED", function()
  VarPoolSoulShards = 0
end)


local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

--------------
--- COLORS ---
--------------
    local colorBlue     = "|cff00CCFF"
    local colorGreen    = "|cff00FF00"
    local colorRed      = "|cffFF0000"
    local colorWhite    = "|cffFFFFFF"
    local colorGold     = "|cffFFDD11"


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"
    local buff                                          = br.player.buff
    local cast                                          = br.player.cast
    local charges                                       = br.player.charges
    local deadMouse, hasMouse, playerMouse              = UnitIsDeadOrGhost("mouseover"), GetObjectExists("mouseover"), UnitIsPlayer("mouseover")
    local deadtar, playertar                            = UnitIsDeadOrGhost("target"), UnitIsPlayer("target")
    local combatTime                                    = getCombatTime()
    local cd                                            = br.player.cd
    local debuff                                        = br.player.debuff
    local drinking                                      = UnitBuff("player",192001) ~= nil or UnitBuff("player",225737) ~= nil
    local essence                                       = br.player.essence
    local gcd                                           = br.player.gcd
    local gcdMax                                        = br.player.gcdMax
    local healPot                                       = getHealthPot()
    local inCombat                                      = br.player.inCombat
    local inInstance                                    = br.player.instance=="party"
    local inRaid                                        = br.player.instance=="raid"
    local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
    local lastSpell                                     = lastSpellCast
    local level                                         = br.player.level
    local mana                                          = br.player.power.mana.percent()
    local mode                                          = br.player.mode
    local perk                                          = br.player.perk        
    local php                                           = br.player.health
    local power, powmax, powgen                         = br.player.power.mana.amount(), br.player.power.mana.max(), br.player.power.mana.regen()
    local pullTimer                                     = br.DBM:getPulltimer()
    local race                                          = br.player.race
    local racial                                        = br.player.getRacial()
    local spell                                         = br.player.spell
    local talent                                        = br.player.talent
    local tanks                                         = getTanksTable()
    local wolf                                          = br.player.buff.ghostWolf.exists()
    local ttd                                           = getTTD
    local ttm                                           = br.player.power.mana.ttm()
    local units                                         = br.player.units
    local enemies                                       = br.player.enemies
    local friends                                       = friends or {}
    local burst = nil
	
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
        
        local lowest = {}
        lowest.unit = "player"
        lowest.hp = 100
        for i = 1, #br.friend do
            if br.friend[i].hp < lowest.hp then
                lowest = br.friend[i]
            end
        end

        if inInstance and select(3, GetInstanceInfo()) == 8 then
            for i = 1, #tanks do
                local ourtank = tanks[i].unit
                local Burststack = getDebuffStacks(ourtank, 240443)
                if Burststack >= getOptionValue("Bursting") then
                    burst = true
                    break
                else 
                    burst = false
                end
            end
        end

        local dpsSpells = {spell.lightningBolt, spell.chainLightning, spell.lavaBurst,spell.flameShock}
        local movingCheck = not isMoving("player") and not IsFalling() or (isMoving and buff.spiritwalkersGrace.exists("player"))
    --------------------
    --- Action Lists ---
    --------------------
        -- Action List - Extras
        local function Extras()
            -- Dummy Test
            if isChecked("DPS Testing") then
                if GetObjectExists("target") then
                    if getCombatTime() >= (tonumber(getOptionValue("DPS Testing"))*60) and isDummy() then
                        StopAttack()
                        ClearTarget()
                        Print(tonumber(getOptionValue("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
                        profileStop = true
                    end
                end
            end -- End Dummy Test
            
			-- Water Walking
            if falling > 1.5 and buff.waterWalking.exists() then
                CancelUnitBuffID("player", spell.waterWalking)
            end
            if isChecked("Water Walking") and not inCombat and IsSwimming() and not buff.waterWalking.exists() then
                if cast.waterWalking() then br.addonDebug("Casting Waterwalking") return end
            end
            
			-- Ancestral Spirit
            if isChecked("Ancestral Spirit") then
                if getOptionValue("Ancestral Spirit")==1 and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and GetUnitIsFriend("target","player") then
                    if cast.ancestralSpirit("target","dead") then br.addonDebug("Casting Ancestral Spirit") return true end
                end
                if getOptionValue("Ancestral Spirit")==2 and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and GetUnitIsFriend("mouseover","player") then
                    if cast.ancestralSpirit("mouseover","dead") then br.addonDebug("Casting Ancestral Spirit") return true end
                end
                if getOptionValue("Ancestral Spirit") == 3 then
                    for i =1, #br.friend do
                        if UnitIsPlayer(br.friend[i].unit) and UnitIsDeadOrGhost(br.friend[i].unit) then
                            if cast.ancestralSpirit(br.friend[i].unit) then return true end
                        end
                    end
                end
            end
			
        end -- End Action List - Extras	
		
        -- Action List - Defensive
        local function Defensive()
            -- Earth Shield
            if talent.earthShield then
                -- check if shield already exists
                local foundShield = false
                if isChecked("Earth Shield") then
                    for i = 1, #br.friend do
                        if buff.earthShield.exists(br.friend[i].unit) then
                            foundShield = true
                        end
                    end
                    -- if no shield found, apply to focus if exists
                    if foundShield == false then
                        if GetUnitExists("focus") == true then
                            if not buff.earthShield.exists("focus") then
                                if cast.earthShield("focus") then br.addonDebug("Casting Earth Shield") return end
                            end
                        else
                            for i = 1, #tanks do
                                if not buff.earthShield.exists(tanks[i].unit) and getDistance(tanks[i].unit) <= 40 then
                                    if cast.earthShield(tanks[i].unit) then br.addonDebug("Casting Earth Shield") return end
                                end
                            end
                        end
                    end
                end
            end
			
            -- Temple of Seth
            if inCombat and isChecked("Temple of Seth") and br.player.eID and br.player.eID == 2127 then
                for i = 1, GetObjectCount() do
                    local thisUnit = GetObjectWithIndex(i)
                    if GetObjectID(thisUnit) == 133392 then
                        sethObject = thisUnit
                        if getHP(sethObject) < 100 and getBuffRemain(sethObject,274148) == 0 and lowest.hp >= getValue("Temple of Seth") then
                            if not buff.riptide.exists(sethObject) then
                                CastSpellByName(GetSpellInfo(61295),sethObject)
                                br.addonDebug("Casting Riptide")
                                return
                        --cast.riptide("target") then return true end
                            end
                            if getHP(sethObject) < 50 and movingCheck then
                                CastSpellByName(GetSpellInfo(8004),sethObject)
                                br.addonDebug("Casting Healing Surge")
                                return
                        --if cast.healingSurge("target") then return true end
                            else
                                if movingCheck then
                                    CastSpellByName(GetSpellInfo(77472),sethObject)
                                    br.addonDebug("Casting Healing Wave")
                                    return
                                end
                        --if cast.healingWave("target") then return true end
                            end
                        end
                    end
                end
            end
			
            if useDefensive() then
            -- Healthstone
			if isChecked("Healthstone") and php <= getOptionValue("Healthstone") and (hasHealthPot() or hasItem(5512) or hasItem(166799)) then
				if canUseItem(5512) then
					br.addonDebug("Using Healthstone")
					useItem(5512)
				elseif canUseItem(healPot) then
					br.addonDebug("Using Health Pot")
					useItem(healPot)
				elseif hasItem(166799) and canUseItem(166799) then
					br.addonDebug("Using Emerald of Vigor")
					useItem(166799)
				end
			end
			
            -- Heirloom Neck
            if isChecked("Heirloom Neck") and php <= getOptionValue("Heirloom Neck") then
                if hasEquiped(122668) then
                    if GetItemCooldown(122668)==0 then
                        useItem(122668)
                        br.addonDebug("Using Heirloom Neck")
                        return
                    end
                end
            end
				
            -- Gift of the Naaru
            if isChecked("Gift of the Naaru") and php <= getOptionValue("Gift of the Naaru") and php > 0 and br.player.race == "Draenei" then
                if castSpell("player",racial,false,false,false) then br.addonDebug("Casting Gift of the Naaru") return end
            end
            -- Astral Shift
            if isChecked("Astral Shift") and php <= getOptionValue("Astral Shift") and inCombat then
                if cast.astralShift() then br.addonDebug("Casting Astral Shift") return end
            end
            -- Earthen Wall Totem
            if isChecked("Earthen Wall Totem") and talent.earthenWallTotem then
                if castWiseAoEHeal(br.friend,spell.earthenWallTotem,20,getValue("Earthen Wall Totem"),getValue("Earthen Wall Totem Targets"),6,false,true) then br.addonDebug("Casting Earthen Wall Totem") return end
            end
            -- Capacitor Totem
            if cd.capacitorTotem.remain() <= gcd then
                if isChecked("Capacitor Totem - HP") and php <= getOptionValue("Capacitor Totem - HP") and inCombat and lastSpell ~= spell.capacitorTotem and #enemies.yards5 > 0 then
                   if cast.capacitorTotem("player") then br.addonDebug("Casting Capacitor Totem") return end
                end
                if isChecked("Capacitor Totem - AoE") and #enemies.yards5 >= getOptionValue("Capacitor Totem - AoE") and inCombat and lastSpell ~= spell.capacitorTotem then
                    if cast.capacitorTotem("player") then br.addonDebug("Casting Capacitor Totem") return end
                 end
            end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
        
		-- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("Interrupt At")) then
        -- Wind Shear
                        if isChecked("Wind Shear") then
                            if cast.windShear(thisUnit) then br.addonDebug("Casting Wind Shear") return end
                        end
        -- Capacitor Totem
                        if isChecked("Capacitor Totem") then
                            if cast.capacitorTotem(thisUnit) then br.addonDebug("Casting Capacitor Totem") return end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
        
		local function ghostWolf()
            -- Ghost Wolf
            if not (IsMounted() or IsFlying()) and isChecked("Auto Ghost Wolf") then
               if mode.ghostWolf == 1 then
                   if ((#enemies.yards20 == 0 and not inCombat) or (#enemies.yards10 == 0 and inCombat)) and isMoving("player") and not buff.ghostWolf.exists() and not buff.spiritwalkersGrace.exists() then
                       if cast.ghostWolf() then br.addonDebug("Casting Ghost Wolf") end
                   elseif movingCheck and buff.ghostWolf.exists() and br.timer:useTimer("Delay",0.5) then
                       RunMacroText("/cancelAura Ghost Wolf")
                   end
               elseif mode.ghostWolf == 2 then
                   if not buff.ghostWolf.exists() and isMoving("player") then 
                       if SpecificToggle("Ghost Wolf Key")  and not GetCurrentKeyBoardFocus() then
                           if cast.ghostWolf() then br.addonDebug("Casting Ghost Wolf") end
                       end
                   elseif buff.ghostWolf.exists() then
                       if SpecificToggle("Ghost Wolf Key") then
                           return
                       else
                           if br.timer:useTimer("Delay",0.25) then
                               RunMacroText("/cancelAura Ghost Wolf")
                           end
                       end
                   end
               end        
           end
        end
        
		-- Action List - Pre-Combat
        local function PreCombat()
            if isChecked("Pig Catcher") then
                bossHelper()
            end
            prepullOpener = inRaid and isChecked("Pre-pull Opener") and pullTimer <= getOptionValue("Pre-pull Opener") 
            -- Sapphire of Brilliance
            if prepullOpener then
                if hasItem(166801) and canUseItem(166801) then
                    br.addonDebug("Using Sapphire of Brilliance")
                    useItem(166801)
                end
            end
            -- Healing Rain
            if movingCheck and cd.healingRain.remain() <= gcd then
                if (SpecificToggle("Healing Rain Key") and not GetCurrentKeyBoardFocus()) and isChecked("Healing Rain Key") then
                    if CastSpellByName(GetSpellInfo(spell.healingRain),"cursor") then br.addonDebug("Casting Healing Rain") return end 
                end
            end
        -- Riptide
            if isChecked("Riptide") then
                for i = 1, #br.friend do
                    if lowest.hp <= getValue("Riptide") and buff.riptide.remain(lowest.unit) < 5.4 then
                        if cast.riptide(lowest.unit) then br.addonDebug("Casting Riptide") return end     
                    end
                end
            end
        -- Healing Stream Totem
           if isChecked("Healing Stream Totem") and cd.healingStreamTotem.remain() <= gcd and not talent.cloudburstTotem then
               -- for i = 1, #br.friend do                           
                    if lowest.hp <= getValue("Healing Stream Totem") then
                        if cast.healingStreamTotem(lowest.unit) then br.addonDebug("Casting Healing Stream Totem") return end     
                    end
               -- end
            end
        -- Healing Surge
            if isChecked("Healing Surge") and movingCheck then
               -- for i = 1, #br.friend do                           
                    if lowest.hp <= getValue("Healing Surge") and (buff.tidalWaves.exists() or level < 34) then
                        if cast.healingSurge(lowest.unit) then br.addonDebug("Casting Healing Surge") return end     
                    end
              --  end
            end
        -- Healing Wave
            if isChecked("Healing Wave") and movingCheck then
             --   for i = 1, #br.friend do                           
                    if lowest.hp <= getValue("Healing Wave") and (buff.tidalWaves.exists() or level < 34) then
                        if cast.healingWave(lowest.unit) then br.addonDebug("Casting Healing Wave") return end     
                    end
             --   end
            end
        -- Chain Heal
            if isChecked("Chain Heal") and movingCheck then
                if getOptionValue("Chain Heal Logic") == 1 then
                    if chainHealUnits(spell.chainHeal,15,getValue("Chain Heal"),getValue("Chain Heal Targets")) then br.addonDebug("Casting Chain Heal") return true end
                elseif getOptionValue("Chain Heal Logic") == 2 then
                    if castWiseAoEHeal(br.friend,spell.chainHeal,15,getValue("Chain Heal"),getValue("Chain Heal Targets"),5,false,true) then br.addonDebug("Casting Chain Heal") return end
                end
            end
            -- Healing Surge
            if isChecked("Healing Surge") and movingCheck then
                if lowest.hp <= 50 then
                    if cast.healingSurge(lowest.unit) then br.addonDebug("Casting Healing Surge") return end     
                end
            end
            if isChecked("Healing Wave") and movingCheck and not burst then
                if lowest.hp <= 65 then
                    if cast.healingWave(lowest.unit) then br.addonDebug("Casting Healing Wave") return end     
                end
            end
        end  -- End Action List - Pre-Combat
        
		-- Action List - DPS
        local function DPS()
        -- Lava Burst - Lava Surge
            if buff.lavaSurge.exists() then
                if debuff.flameShock.exists("target") then
                    if cast.lavaBurst() then br.addonDebug("Casting Lava Burst") return true end
                else
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if debuff.flameShock.exists(thisUnit) then
                            if cast.lavaBurst(thisUnit) then br.addonDebug("Casting Lava Burst") return true end
                        end
                    end
                end
            end
        -- Flameshock
            for i = 1, #enemies.yards40 do
                local thisUnit = enemies.yards40[i]
                if not debuff.flameShock.exists(thisUnit) then
                    if cast.flameShock(thisUnit) then br.addonDebug("Casting Flame Shock") return end
                end
            end
        -- Lava Burst
            if debuff.flameShock.remain(units.dyn40) > getCastTime(spell.lavaBurst) or level < 20 and movingCheck then
                if cast.lavaBurst() then br.addonDebug("Casting Lava Burst") return end
            end
		-- Chain Lightning
			if #enemies.yards10t >= 2 and movingCheck then 		
                if cast.chainLightning() then br.addonDebug("Casting Chain Lightning") return end		
			end			
        -- Lightning Bolt
            if movingCheck then
                if cast.lightningBolt() then br.addonDebug("Casting Lightning Bolt") return end
            end
        end -- End Action List - DPS
        
		local function Explosive()
            --Flameshock
            if not debuff.flameShock.exists("target") then
                if cast.flameShock() then br.addonDebug("Casting Flame Shock") return end
            end
            --Lavaburst (Lava Surge Buff)
            if buff.lavaSurge.exists() and debuff.flameShock.exists("target") then
                if cast.Lavaburst then br.addonDebug("Casting Lava Burst") return end
            end
        end
        
		local function AMR()
             -- Healing Rain
             if movingCheck and cd.healingRain.remain() <= gcd then
                if (SpecificToggle("Healing Rain Key") and not GetCurrentKeyBoardFocus()) and isChecked("Healing Rain Key") then
                    if CastSpellByName(GetSpellInfo(spell.healingRain),"cursor") then br.addonDebug("Casting Healing Rain") return end 
                end
            end
            --Spirit Link Key
            if (SpecificToggle("Spirit Link Totem Key") and not GetCurrentKeyBoardFocus()) and isChecked("Spirit Link Totem Key") then
                if CastSpellByName(GetSpellInfo(spell.spiritLinkTotem),"cursor") then br.addonDebug("Casting Spirit Link Totem") return end 
            end
            -- Coastal Mana Potion
            if isChecked("Mana Pot") and power <= getOptionValue("Mana Pot")
                and inCombat and  hasItem(152495)
            then
                if canUseItem(152495) then
                    useItem(152495)
                    br.addonDebug("Using Coastal Mana Pot")
                    return
                end
            end
            -- Ascendance Key
            if (SpecificToggle("Ascendance Key") and not GetCurrentKeyBoardFocus()) and isChecked("Ascendance Key") then
                if cast.ascendance() then br.addonDebug("Casting Ascendance") return end
            end
            -- Tremor Totem Key
            if (SpecificToggle("Tremor Totem Key") and not GetCurrentKeyBoardFocus()) and isChecked("Tremor Totem Key") then
                if cast.tremorTotem("player") then br.addonDebug("Casting Tremor Totem") return end
            end
            -- Healing Tide Key
            if (SpecificToggle("Healing Tide Key") and not GetCurrentKeyBoardFocus()) and isChecked("Healing Tide Key") then
                if cast.healingTideTotem() then br.addonDebug("Casting Healing Tide Totem") return end
            end
            -- Spirit Link Totem
            if isChecked("Spirit Link Totem") and useCDs() and not moving and cd.spiritLinkTotem.remain() <= gcd then
                if raidBurstInc and (not isChecked("Burst Count") or (isChecked("Burst Count") and burstCount == getOptionValue("Burst Count"))) then
                    local nearHealer = getAllies("player",10)
                    -- get the best ground circle to encompass the most of them
                    local loc = nil
                    if #nearHealer >= getValue("Spirit Link Totem Targets") then
                        if #nearHealer < 12 then
                            loc = getBestGroundCircleLocation(nearHealer,getValue("Spirit Link Totem Targets"),40,10)
                            if loc ~= nil then
                                if castGroundAtLocation(loc, spell.spiritLinkTotem) then br.addonDebug("Casting Spirit Link Totem") return true end
                            end
                        else
                            if castWiseAoEHeal(nearHealer,spell.spiritLinkTotem,10,100,getValue("Spirit Link Targets"),40,true, true) then br.addonDebug("Casting Spirit Link Totem") return end
                        end
                    end
                else
                    if castWiseAoEHeal(br.friend,spell.spiritLinkTotem,12,getValue("Spirit Link Totem"),getValue("Spirit Link Totem Targets"),40,false,true) then br.addonDebug("Casting Spirit Link Totem") return end
                end
            end
        -- Ancestral Protection Totem
            if isChecked("Ancestral Protection Totem") and useCDs() and cd.ancestralProtectionTotem.remain() <= gcd then
                if castWiseAoEHeal(br.friend,spell.ancestralProtectionTotem,20,getValue("Ancestral Protection Totem"),getValue("Ancestral Protection Totem Targets"),10,false,false) then br.addonDebug("casting Ancestral Protection Totem") return end
            end
        -- Earthen Wall Totem
            if isChecked("Earthen Wall Totem") and talent.earthenWallTotem and cd.earthenWallTotem.remain() <= gcd then
                if castWiseAoEHeal(br.friend,spell.earthenWallTotem,20,getValue("Earthen Wall Totem"),getValue("Earthen Wall Totem Targets"),6,false,true) then br.addonDebug("Casting Earthen Wall Totem") return end
            end
        -- Purify Spirit
            if br.player.mode.decurse == 1 and cd.purifySpirit.remain() <= gcd then
                for i = 1, #friends.yards40 do
                    if canDispel(br.friend[i].unit,spell.purifySpirit) then
                        if cast.purifySpirit(br.friend[i].unit) then br.addonDebug("Casting Purify Spirit") return end
                    end
                end
            end
            -- Racial Buff
            if useCDs() then
                if (race == "Troll" or race == "Orc" or race == "MagharOrc" or race == "DarkIronDwarf" or race == "LightforgedDraenei") then
                    if race == "LightforgedDraenei" then
                    if cast.racial("target","ground") then br.addonDebug("Casting Racial") return true end
                    else
                    if cast.racial("player") then br.addonDebug("Casting Racial") return true end
                    end
                end
            end
        -- Trinkets
			if isChecked("Revitalizing Voodoo Totem") and hasEquiped(158320) and lowest.hp < getValue("Revitalizing Voodoo Totem") then
				if GetItemCooldown(158320) <= gcdMax then
					UseItemByName(158320, lowest.unit)
					br.addonDebug("Using Revitalizing Voodoo Totem")
				end
			end
			if isChecked("Inoculating Extract") and hasEquiped(160649) and lowest.hp < getValue("Inoculating Extract") then
				if GetItemCooldown(160649) <= gcdMax then
					UseItemByName(160649, lowest.unit)
					br.addonDebug("Using Inoculating Extract")
				end
			end
			if isChecked("Ward of Envelopment") and hasEquiped(165569) and GetItemCooldown(165569) <= gcdMax then
				-- get melee players
				for i = 1, #tanks do
					-- get the tank's target
					local tankTarget = UnitTarget(tanks[i].unit)
					if tankTarget ~= nil then
						-- get players in melee range of tank's target
						local meleeFriends = getAllies(tankTarget, 5)
						-- get the best ground circle to encompass the most of them
						local loc = nil
						if #meleeFriends >= 8 then
							loc = getBestGroundCircleLocation(meleeFriends, 4, 6, 10)
						else
							local meleeHurt = {}
							for j = 1, #meleeFriends do
								if meleeFriends[j].hp < 75 then
									tinsert(meleeHurt, meleeFriends[j])
								end
							end
							if #meleeHurt >= 2 then
								loc = getBestGroundCircleLocation(meleeHurt, 2, 6, 10)
							end
						end
						if loc ~= nil then
							useItem(165569)
							local px,py,pz = ObjectPosition("player")
							   loc.z = select(3,TraceLine(loc.x, loc.y, loc.z+5, loc.x, loc.y, loc.z-5, 0x110)) -- Raytrace correct z, Terrain and WMO hit
							   if loc.z ~= nil and TraceLine(px, py, pz+2, loc.x, loc.y, loc.z+1, 0x100010) == nil and TraceLine(loc.x, loc.y, loc.z+4, loc.x, loc.y, loc.z, 0x1) == nil then -- Check z and LoS, ignore terrain and m2 collisions 
								ClickPosition(loc.x, loc.y, loc.z)
								br.addonDebug("Using Ward of Envelopment")
								return
							end
						end
					end
				end
			end
			--Pillar of the Drowned Cabal
			if hasEquiped(167863) and canUseItem(16) then
				if not UnitBuffID(lowest.unit,295411) and lowest.hp < 75 then
					UseItemByName(167863,lowest.unit)
					br.addonDebug("Using Pillar of Drowned Cabal")
				end
			end
			if isChecked("Trinket 1") and canTrinket(13) and not hasEquiped(165569,13) and not hasEquiped(160649,13) and not hasEquiped(158320,13) and not hasEquiped(169314,13) then
				if getOptionValue("Trinket 1 Mode") == 1 then
					if getLowAllies(getValue("Trinket 1")) >= getValue("Min Trinket 1 Targets") or burst == true then
						useItem(13)
						br.addonDebug("Using Trinket 1")
						return true
					end
					elseif getOptionValue("Trinket 1 Mode") == 2 then
						if (lowest.hp <= getValue("Trinket 1") or burst == true) and lowest.hp ~= 250 then
						UseItemByName(GetInventoryItemID("player", 13), lowest.unit)
						br.addonDebug("Using Trinket 1 (Target)")
						return true
						end
					elseif getOptionValue("Trinket 1 Mode") == 3 and #tanks > 0 then
						for i = 1, #tanks do
							-- get the tank's target
							local tankTarget = UnitTarget(tanks[i].unit)
							if tankTarget ~= nil then
							-- get players in melee range of tank's target
							local meleeFriends = getAllies(tankTarget, 5)
							-- get the best ground circle to encompass the most of them
							local loc = nil
							if #meleeFriends < 12 then
								loc = getBestGroundCircleLocation(meleeFriends, 4, 6, 10)
							else
								local meleeHurt = {}
								for j = 1, #meleeFriends do
								if meleeFriends[j].hp < getValue("Trinket 1") then
									tinsert(meleeHurt, meleeFriends[j])
								end
								end
								if #meleeHurt >= getValue("Min Trinket 1 Targets") or burst == true then
								loc = getBestGroundCircleLocation(meleeHurt, 2, 6, 10)
								end
							end
							if loc ~= nil then
								useItem(13)
								br.addonDebug("Using Trinket 1 (Ground)")
								local px,py,pz = ObjectPosition("player")
								loc.z = select(3,TraceLine(loc.x, loc.y, loc.z+5, loc.x, loc.y, loc.z-5, 0x110)) -- Raytrace correct z, Terrain and WMO hit
								if loc.z ~= nil and TraceLine(px, py, pz+2, loc.x, loc.y, loc.z+1, 0x100010) == nil and TraceLine(loc.x, loc.y, loc.z+4, loc.x, loc.y, loc.z, 0x1) == nil then -- Check z and LoS, ignore terrain and m2 collisions
									ClickPosition(loc.x, loc.y, loc.z)
									return true
								end
							end
						end
					end
				end
			end
			if isChecked("Trinket 2") and canTrinket(14) and not hasEquiped(165569,14) and not hasEquiped(160649,14) and not hasEquiped(158320,14) and not hasEquiped(169314,13) then
				if getOptionValue("Trinket 2 Mode") == 1 then
					if getLowAllies(getValue("Trinket 2")) >= getValue("Min Trinket 2 Targets") or burst == true then
						useItem(14)
						br.addonDebug("Using Trinket 2")
						return true
					end
					elseif getOptionValue("Trinket 2 Mode") == 2 then
						if (lowest.hp <= getValue("Trinket 2") or burst == true) and lowest.hp ~= 250 then
						UseItemByName(GetInventoryItemID("player", 14), lowest.unit)
						br.addonDebug("Using Trinket 2 (Target)")
						return true
						end
					elseif getOptionValue("Trinket 2 Mode") == 3 and #tanks > 0 then
						for i = 1, #tanks do
							-- get the tank's target
							local tankTarget = UnitTarget(tanks[i].unit)
							if tankTarget ~= nil then
							-- get players in melee range of tank's target
							local meleeFriends = getAllies(tankTarget, 5)
							-- get the best ground circle to encompass the most of them
							local loc = nil
							if #meleeFriends < 12  then
								loc = getBestGroundCircleLocation(meleeFriends, 4, 6, 10)
							else
								local meleeHurt = {}
								for j = 1, #meleeFriends do
								if meleeFriends[j].hp < getValue("Trinket 2") then
									tinsert(meleeHurt, meleeFriends[j])
								end
								end
								if #meleeHurt >= getValue("Min Trinket 2 Targets") or burst == true then
								loc = getBestGroundCircleLocation(meleeHurt, 2, 6, 10)
								end
							end
							if loc ~= nil then
								useItem(14)
								br.addonDebug("Using Trinket 2 (Ground)")
								ClickPosition(loc.x, loc.y, loc.z)
								return true
							end
						end
					end
				end
            end
            if isChecked("Life-Binder's Invocation") and essence.lifeBindersInvocation.active and cd.lifeBindersInvocation.remain() <= gcd and getLowAllies(getOptionValue("Life-Binder's Invocation")) >= getOptionValue("Life-Binder's Invocation Targets") then
                if cast.lifeBindersInvocation() then
                    br.addonDebug("Casting Life-Binder's Invocation")
                    return true
                end
            end
            if isChecked("Ever-Rising Tide") and essence.overchargeMana.active and cd.overchargeMana.remain() <= gcd and getOptionValue("Ever-Rising Tide - Mana") <= mana then
                if getOptionValue("Ever-Rising Tide") == 1 then
                    if cast.overchargeMana() then
                        return
                    end
                end
                if getOptionValue("Ever-Rising Tide") == 2 then
                    if buff.ascendance.exists() or buff.cloudburstTotem.exists() or (HTTimer ~= nil or HTTimer ~= 0) or burst == true then
                        if cast.overchargeMana() then
                            return
                        end
                    end
                end
                if getOptionValue("Ever-Rising Tide") == 3 then
                    if lowest.hp < getOptionValue("Ever Rising Tide - Health") or burst == true then
                        if cast.overchargeMana() then
                            return
                        end
                    end
                end
            end
        -- Healing Tide Totem
            if isChecked("Healing Tide Totem") and useCDs() and not buff.ascendance.exists() and cd.healingTideTotem.remain() <= gcd then
                if getLowAllies(getValue("Healing Tide Totem")) >= getValue("Healing Tide Totem Targets") or burst == true or (raidBurstInc and (not isChecked("Burst Count") or (isChecked("Burst Count") and burstCount == getOptionValue("Burst Count")))) then    
                    if cast.healingTideTotem() then br.addonDebug("Casting Healing Tide Totem") HTTimer = GetTime() return end    
                end
            end
        -- Ascendance
            if isChecked("Ascendance") and useCDs() and talent.ascendance and cd.ascendance.remain() <= gcd and (not HTTimer or GetTime() - HTTimer > 10) then
                if getLowAllies(getValue("Ascendance")) >= getValue("Ascendance Targets") or burst == true or (raidBurstInc and (not isChecked("Burst Count") or (isChecked("Burst Count") and burstCount == getOptionValue("Burst Count")))) then    
                    if cast.ascendance() then br.addonDebug("Casting Ascendance") return end    
                end
            end
        --  Lucid Dream
            if isChecked("Lucid Dreams") and essence.memoryOfLucidDreams.active and mana <= 85 and getSpellCD(298357) <= gcd then
                if cast.memoryOfLucidDreams("player") then br.addonDebug("Casting Memory of Lucid Dreams") return end
            end
            -- Cloud Burst Totem
            if isChecked("Cloudburst Totem") and talent.cloudburstTotem and not buff.cloudburstTotem.exists() and cd.cloudburstTotem.remain() <= gcd and inCombat and #enemies.yards40 > 0 then
                if getLowAllies(getValue("Cloudburst Totem")) >= getValue("Cloudburst Totem Targets") then
                    if cast.cloudburstTotem("player") then
                        br.addonDebug("Casting Cloud Burst Totem")
                        ChatOverlay(colorGreen.."Cloudburst Totem!")
                        return
                    end
                end
            end
            -- Healing Rain
            if movingCheck and cd.healingRain.remain() <= gcd and br.timer:useTimer("HR Delay",5) then
                if isChecked("Healing Rain") and not buff.healingRain.exists() and mode.healingR == 1 then
                    if isChecked("Healing Rain on Melee") then
                        -- get melee players
                        for i=1, #tanks do
                            -- get the tank's target
                            local tankTarget = UnitTarget(tanks[i].unit)
                            if tankTarget ~= nil and getDistance(tankTarget,"player") < 40 then
                                -- get players in melee range of tank's target
                                local meleeFriends = getAllies(tankTarget,5)
                                -- get the best ground circle to encompass the most of them
                                local loc = nil
                                if isChecked("Healing Rain on CD") then
                                    -- CastGroundHeal(spell.healingRain, meleeFriends)
                                    -- return
                                    if #meleeFriends >= getValue("Healing Rain Targets") then
                                        if #meleeFriends < 12 then
                                            loc = getBestGroundCircleLocation(meleeFriends,getValue("Healing Rain Targets"),6,10)
                                        else
                                            if castWiseAoEHeal(meleeFriends,spell.healingRain,10,100,getValue("Healing Rain Targets"),6,true, true) then br.addonDebug("Casting Healing Rain") return end
                                        end
                                    end
                                else
                                    local meleeHurt = {}
                                    for j=1, #meleeFriends do
                                        if meleeFriends[j].hp < getValue("Healing Rain") then
                                            tinsert(meleeHurt,meleeFriends[j])
                                        end
                                    end
                                    if #meleeHurt >= getValue("Healing Rain Targets") then
                                        if #meleeHurt < 12 then
                                            loc = getBestGroundCircleLocation(meleeHurt,getValue("Healing Rain Targets"),6,10)
                                        else
                                            if castWiseAoEHeal(meleeHurt,spell.healingRain,10,getValue("Healing Rain"),getValue("Healing Rain Targets"),6,true, true) then br.addonDebug("Casting Healing Rain") return end
                                        end
                                    end
                                end
                                if loc ~= nil then
                                    if castGroundAtLocation(loc, spell.healingRain) then br.addonDebug("Casting Healing Rain (Cast Ground)") return true end
                                end
                            end
                        end
                    else
                        if castWiseAoEHeal(br.friend,spell.healingRain,10,getValue("Healing Rain"),getValue("Healing Rain Targets"),6,true, true) then br.addonDebug("Casting Healing Rain (Wise AoE)") return end
                    end
                end
            end	
            -- Wellspring
            if isChecked("Wellspring") and cd.wellspring.remain() <= gcd and movingCheck then
                if healConeAround(getValue("Wellspring Targets"), getValue("Wellspring"), 90, 30, 0) then br.addonDebug("Casting Wellspring") return end
                --if castWiseAoEHeal(br.friend,spell.wellspring,20,getValue("Wellspring"),getValue("Wellspring Targets"),6,true,true) then br.addonDebug("Casting Wellspring") return end
            end
            -- Downpour
            if cd.downpour.remain() <= gcd and movingCheck then
                if isChecked("Downpour") then
                    if isChecked("Downpour on Melee") then
                        -- get melee players
                        for i=1, #tanks do
                            -- get the tank's target
                            local tankTarget = UnitTarget(tanks[i].unit)
                            if tankTarget ~= nil and getDistance(tankTarget) <= 40 then
                                -- get players in melee range of tank's target
                                local meleeFriends = getAllies(tankTarget,5)
                                -- get the best ground circle to encompass the most of them
                                local loc = nil
                                local meleeHurt = {}
                                for j=1, #meleeFriends do
                                    if meleeFriends[j].hp < getValue("Downpour") then
                                        tinsert(meleeHurt,meleeFriends[j])
                                    end
                                end
                                if #meleeHurt >= getValue("Downpour Targets") then
                                    if #meleeHurt < 12 then
                                        loc = getBestGroundCircleLocation(meleeHurt,getValue("Downpour Targets"),6,10)
                                    else
                                        if castWiseAoEHeal(meleeHurt,spell.downpour,10,getValue("Downpour"),getValue("Downpour Targets"),6,true, true) then br.addonDebug("Casting Downpour") return end
                                    end            
                                end
                                if loc ~= nil then
                                    if castGroundAtLocation(loc, spell.downpour) then br.addonDebug("Casting Downpour") return true end
                                end
                            end
                        end
                    else
                        if castWiseAoEHeal(br.friend,spell.downpour,10,getValue("Downpour"),getValue("Downpour Targets"),6,true, true) then br.addonDebug("Casting Downpour") return end
                    end
                end 
            end
        -- Unleash Life
            if isChecked("Unleash Life") and talent.unleashLife and not hasEquiped(137051) and cd.unleashLife.remain() <= gcd then
              --  for i = 1, #br.friend do                           
                    if lowest.hp <= getValue("Unleash Life") then
                        if cast.unleashLife() then br.addonDebug("Casting Unleash Life") return end     
                    end
              --  end
            end
        -- Concentrated Flame
            if isChecked("Concentrated Flame") and essence.concentratedFlame.active and getSpellCD(295373) <= gcd then
                if lowest.hp <= getValue("Concentrated Flame") then
                    if cast.concentratedFlame(lowest.unit) then br.addonDebug("Casting Concentrated Flame") return end
                end
            end
            -- Refreshment
            if isChecked("Well of Existence") and essence.refreshment.active and cd.refreshment.remain() <= gcd and UnitBuffID("player",296138) and select(16,UnitBuffID("player",296138,"EXACT")) >= 15000 and lowest.hp <= getValue("Healing Wave") then
                if cast.refreshment(lowest.unit) then br.addonDebug("Casting Refreshment") return true end
            end
            -- Healing Surge (2 stacks)
            if isChecked("Healing Surge") and movingCheck then
                if lowest.hp <= getValue("Healing Surge") and buff.tidalWaves.stack() == 2 then
                    if cast.healingSurge(lowest.unit) then br.addonDebug("Casting Healing Surge") return end     
                end
            end
            -- Healing Wave
            if isChecked("Healing Wave") and movingCheck and not burst then
                if lowest.hp <= getValue("Healing Wave") and buff.tidalWaves.stack() == 2 then
                    if cast.healingWave(lowest.unit) then br.addonDebug("Casting Healing Wave") return end     
                end
            end
        -- Chain Heal
            if isChecked("Chain Heal") and movingCheck then
                if talent.unleashLife and talent.highTide then
                    if cast.unleashLife(lowest.unit) then return end
                    if buff.unleashLife.remain() > 2 then
                        if getOptionValue("Chain Heal Logic") == 1 then
                            if chainHealUnits(spell.chainHeal,15,getValue("Chain Heal"),getValue("Chain Heal Targets")+1) then br.addonDebug("Casting Chain Heal") return true end
                        elseif getOptionValue("Chain Heal Logic") == 2 then
                            if castWiseAoEHeal(br.friend,spell.chainHeal,15,getValue("Chain Heal"),getValue("Chain Heal Targets")+1,5,false,true) then br.addonDebug("Casting Chain Heal") return end
                        end
                    end
                elseif talent.highTide then
                    if getOptionValue("Chain Heal Logic") == 1 then
                        if chainHealUnits(spell.chainHeal,15,getValue("Chain Heal"),getValue("Chain Heal Targets")+1) then br.addonDebug("Casting Chain Heal") return true end
                    elseif getOptionValue("Chain Heal Logic") == 2 then
                        if castWiseAoEHeal(br.friend,spell.chainHeal,15,getValue("Chain Heal"),getValue("Chain Heal Targets")+1,5,false,true) then br.addonDebug("Casting Chain Heal") return end
                    end
                else
                    if getOptionValue("Chain Heal Logic") == 1 then
                        if chainHealUnits(spell.chainHeal,15,getValue("Chain Heal"),getValue("Chain Heal Targets")) then br.addonDebug("Casting Chain Heal") return true end
                    elseif getOptionValue("Chain Heal Logic") == 2 then
                        if castWiseAoEHeal(br.friend,spell.chainHeal,15,getValue("Chain Heal"),getValue("Chain Heal Targets"),5,false,true) then br.addonDebug("Casting Chain Heal") return end
                    end
                end
            end
        -- Healing Stream Totem
            if isChecked("Healing Stream Totem") and cd.healingStreamTotem.remain() <= gcd and movingCheck and not talent.cloudburstTotem then                        
                if lowest.hp <= getValue("Healing Stream Totem") then
                    if not talent.echoOfTheElements then
                        if cast.healingStreamTotem(lowest.unit) then br.addonDebug("Casting Healing Stream Totem") return end
                    elseif talent.echoOfTheElements and (not HSTime or GetTime() - HSTime > 15) then
                        if cast.healingStreamTotem(lowest.unit) then
                            br.addonDebug("Casting Healing Stream Totem")
                            HSTime = GetTime()
                            return true 
                        end
                    end 
                end
            end
        -- Riptide
            if isChecked("Riptide") then
                if not buff.tidalWaves.stack() == 2 and level >= 34 then
                    if cast.riptide(lowest.unit) then br.addonDebug("Casting Riptide") return end
                end
               for i = 1, #br.friend do
                    if lowest.hp <= getValue("Riptide") and buff.riptide.remain(lowest.unit) < 5.4 then
                        if cast.riptide(lowest.unit) then br.addonDebug("Casting Riptide") return end     
                    end
               end
            end
        -- Healing Wave
            if isChecked("Healing Wave") and movingCheck and not burst then
             --   for i = 1, #br.friend do                           
                    if lowest.hp <= getValue("Healing Wave") and (buff.tidalWaves.exists() or level < 100) then
                        if cast.healingWave(lowest.unit) then br.addonDebug("Casting Healing Wave") return end     
                    end
              --  end
            end
            -- Chain Heal
            if isChecked("Chain Heal") and movingCheck then
                if getOptionValue("Chain Heal Logic") == 1 then
                    if chainHealUnits(spell.chainHeal,15,getValue("Chain Heal"),2) then br.addonDebug("Casting Chain Heal") return true end
                elseif getOptionValue("Chain Heal Logic") == 2 then
                    if castWiseAoEHeal(br.friend,spell.chainHeal,15,getValue("Chain Heal"),2,5,false,true) then br.addonDebug("Casting Chain Heal") return end
                end
            end
            -- Healing Surge
            if isChecked("Healing Surge") and movingCheck then
                if lowest.hp <= 50 then
                    if cast.healingSurge(lowest.unit) then br.addonDebug("Casting Healing Surge") return end     
                end
            end
            if isChecked("Healing Wave") and movingCheck and not burst then
                if lowest.hp <= 65 then
                    if cast.healingWave(lowest.unit) then br.addonDebug("Casting Healing Wave") return end     
                end
            end
        end
-----------------
--- Rotations ---
-----------------
        if br.data.settings[br.selectedSpec][br.selectedProfile]['HE ActiveCheck'] == false and br.timer:useTimer("Error delay",0.5) then
            Print("Detecting Healing Engine is not turned on.  Please activate Healing Engine to use this profile.")
            return
        end
        ghostWolf()
        if inCombat then
           if IsAoEPending()then SpellStopTargeting() br.addonDebug(colorRed.."Canceling Spell") end
        end
        -- Dps Spell Cancel
        for i = 1, #dpsSpells do
            if isCastingSpell(dpsSpells[i]) and isChecked("Critical HP") and lowest.hp <= getValue("Critical HP") then
                SpellStopCasting()
                break
            end
        end
        -- Pause
        if pause() then
            return true
        else 
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
            if not inCombat and not IsMounted() and not drinking then
                if (buff.ghostWolf.exists() and mode.ghostWolf == 1) or not buff.ghostWolf.exists() then
                    actionList_Extras()
                    if isChecked("OOC Healing") then
                        actionList_PreCombat()
                    end
                    -- Purify Spirit
                    if br.player.mode.decurse == 1 and cd.purifySpirit.remain() <= gcd then
                        for i = 1, #friends.yards40 do
                            if canDispel(br.friend[i].unit,spell.purifySpirit) then
                                if cast.purifySpirit(br.friend[i].unit) then br.addonDebug("Casting Purify Spirit") return end
                            end
                        end
                    end
                end
            end -- End Out of Combat Rotation
-----------------------------
--- In Combat - Rotations --- 
-----------------------------
            if inCombat and not IsMounted() and not drinking then
                if (buff.ghostWolf.exists() and mode.ghostWolf == 1) or not buff.ghostWolf.exists() then
                    actionList_Defensive()
                    actionList_Interrupts()
                    actionList_AMR()
                    -- Purge
                    if isChecked("Purge") and lowest.hp > getOptionValue("DPS Threshold") and power >= getOptionValue("Purge Min Mana") then
                        if getOptionValue("Purge") == 1 then
                            if canDispel("target",spell.purge) and GetObjectExists("target") then
                                if cast.purge("target") then br.addonDebug("Casting Purge") return true end
                            end
                        elseif getOptionValue("Purge") == 2 then
                            for i = 1, #enemies.yards30 do
                                local thisUnit = enemies.yards30[i]
                                if canDispel(thisUnit,spell.purge) then
                                    if cast.purge(thisUnit) then br.addonDebug("Casting Purge") return true end
                                end
                            end
                        end
                    end
                    if hasItem(166801) and canUseItem(166801) then
                        br.addonDebug("Using Sapphire of Brilliance")
                        useItem(166801)
                    end
                    if br.player.mode.dPS == 1 and GetUnitExists("target") and UnitCanAttack("player","target") and getFacing("player","target") and lowest.hp > getOptionValue("DPS Threshold") then
                        if isExplosive("target") then
                            actionList_Explosive()
                        else
                            actionList_DPS()
                        end
                    end
                    if movingCheck and br.player.mode.dPS == 1 then
                        if cast.lightningBolt() then br.addonDebug("Casting Lightning Bolt") return end
                    end
                end
            end -- End In Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation 
--local id = 264
local id = 264
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})