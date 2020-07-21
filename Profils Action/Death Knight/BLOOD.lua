-------------------------------
-- Taste TMW Action Rotation --
-------------------------------
local Action									= Action
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell								= Action.FrameHasSpell
local Azerite									= LibStub("AzeriteTraits")
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates							= MultiUnits:GetActiveUnitPlates()
local _G, setmetatable							= _G, setmetatable
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local pairs                                     = pairs
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_DEATHKNIGHT_BLOOD] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                            = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    DeathStrike                            = Action.Create({ Type = "Spell", ID = 49998 }),
    BloodDrinker                           = Action.Create({ Type = "Spell", ID = 206931 }),
    DancingRuneWeaponBuff                  = Action.Create({ Type = "Spell", ID = 81256, Hidden = true }),
    Marrowrend                             = Action.Create({ Type = "Spell", ID = 195182 }),
    BoneShieldBuff                         = Action.Create({ Type = "Spell", ID = 195181 }),
    HeartEssence                           = Action.Create({ Type = "Spell", ID = 298554 }),
    BloodBoil                              = Action.Create({ Type = "Spell", ID = 50842 }),
    HemostasisBuff                         = Action.Create({ Type = "Spell", ID = 273947, Hidden = true }),
    Hemostasis                             = Action.Create({ Type = "Spell", ID = 273946 }),
    Ossuary                                = Action.Create({ Type = "Spell", ID = 219786 }),
    Bonestorm                              = Action.Create({ Type = "Spell", ID = 194844 }),
    Heartbreaker                           = Action.Create({ Type = "Spell", ID = 221536 }),
    DeathandDecay                          = Action.Create({ Type = "Spell", ID = 43265 }),
    RuneStrike                             = Action.Create({ Type = "Spell", ID = 210764 }),
    HeartStrike                            = Action.Create({ Type = "Spell", ID = 206930 }),
    CrimsonScourgeBuff                     = Action.Create({ Type = "Spell", ID = 81141, Hidden = true }),
    RapidDecomposition                     = Action.Create({ Type = "Spell", ID = 194662 }),
    Consumption                            = Action.Create({ Type = "Spell", ID = 205223 }),
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    Tombstone                              = Action.Create({ Type = "Spell", ID = 219809 }),
    -- Trinkets  
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, Hidden = true, QueueForbidden = true }),
    DribblingInkpod                        = Action.Create({ Type = "Trinket", ID = 169319, Hidden = true, QueueForbidden = true }),
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, Hidden = true, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, Hidden = true, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, Hidden = true, QueueForbidden = true }),
    RazdunksBigRedButton                   = Action.Create({ Type = "Trinket", ID = 159611, Hidden = true, QueueForbidden = true }),
    MerekthasFang                          = Action.Create({ Type = "Trinket", ID = 158367, Hidden = true, QueueForbidden = true }),
    KnotofAncientFuryAlliance              = Action.Create({ Type = "Trinket", ID = 161413, Hidden = true, QueueForbidden = true }),
    KnotofAncientFuryHorde                 = Action.Create({ Type = "Trinket", ID = 166795, Hidden = true, QueueForbidden = true }),
    FirstMatesSpyglass                     = Action.Create({ Type = "Trinket", ID = 158163, Hidden = true, QueueForbidden = true }),
    GrongsPrimalRage                       = Action.Create({ Type = "Trinket", ID = 165574, Hidden = true, QueueForbidden = true }),
    LurkersInsidiousGift                   = Action.Create({ Type = "Trinket", ID = 167866, Hidden = true, QueueForbidden = true }),
    NotoriousGladiatorsBadge               = Action.Create({ Type = "Trinket", ID = 167380, Hidden = true, QueueForbidden = true }),
    NotoriousGladiatorsMedallion           = Action.Create({ Type = "Trinket", ID = 167377, Hidden = true, QueueForbidden = true }),
    SinisterGladiatorsBadge                = Action.Create({ Type = "Trinket", ID = 165058, Hidden = true, QueueForbidden = true }),
    SinisterGladiatorsMedallion            = Action.Create({ Type = "Trinket", ID = 165055, Hidden = true, QueueForbidden = true }),
    VialofAnimatedBlood                    = Action.Create({ Type = "Trinket", ID = 159625, Hidden = true, QueueForbidden = true }),
    JesHowler                              = Action.Create({ Type = "Trinket", ID = 159627, Hidden = true, QueueForbidden = true }),
	-- Defensives
    IceboundFortitude                      = Action.Create({ Type = "Spell", ID = 48792 }),
    AntiMagicShell                         = Action.Create({ Type = "Spell", ID = 48707 }),
    DancingRuneWeapon                      = Action.Create({ Type = "Spell", ID = 49028 }),
    VampiricBlood                          = Action.Create({ Type = "Spell", ID = 55233 }),
    DeathPact                              = Action.Create({ Type = "Spell", ID = 48743 }),	-- Talent
    GorefiendsGrasp                        = Action.Create({ Type = "Spell", ID = 108199 }),	-- Mass Grip
	MarkofBlood                            = Action.Create({ Type = "Spell", ID = 206940 }),
	RuneTap                                = Action.Create({ Type = "Spell", ID = 194679 }),
	-- Utilities
	DarkCommand                            = Action.Create({ Type = "Spell", ID = 56222     }), 
	WraithWalk                             = Action.Create({ Type = "Spell", ID = 212552     }), 
	MindFreeze                             = Action.Create({ Type = "Spell", ID = 47528     }),
	Asphyxiate                             = Action.Create({ Type = "Spell", ID = 108194     }),
	DeathsAdvance                          = Action.Create({ Type = "Spell", ID = 48265     }), -- 30% Speed & immune to 100% normal speed
	DeathGrip                              = Action.Create({ Type = "Spell", ID = 49576     }),
    ChainsofIce                            = Action.Create({ Type = "Spell", ID = 45524     }), -- 70% snare, 8sec
    RaiseAlly                              = Action.Create({ Type = "Spell", ID = 61999     }),	 -- Battle rez
	DeathCaress                            = Action.Create({ Type = "Spell", ID = 195292 }),
    -- Potions
    PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, Hidden = true, QueueForbidden = true }), 
    BattlePotionofAgility                  = Action.Create({ Type = "Potion", ID = 163223, Hidden = true, QueueForbidden = true }),
    SuperiorPotionofUnbridledFury          = Action.Create({ Type = "Potion", ID = 168489, Hidden = true, QueueForbidden = true }), 
	SuperiorSteelskinPotion                = Action.Create({ Type = "Potion", ID = 168501, Hidden = true, QueueForbidden = true }), 
	AbyssalHealingPotion                   = Action.Create({ Type = "Potion", ID = 169451, Hidden = true, QueueForbidden = true }), 
    PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, Hidden = true, QueueForbidden = true }), 
    -- Trinkets
    GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, Hidden = true, QueueForbidden = true }),
    GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, Hidden = true, QueueForbidden = true }),
    TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, Hidden = true, QueueForbidden = true }),
    TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, Hidden = true, QueueForbidden = true }), 
    AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, Hidden = true, QueueForbidden = true }),
    PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, Hidden = true, QueueForbidden = true }),
    RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, Hidden = true, QueueForbidden = true }),
    ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, Hidden = true, QueueForbidden = true }),
    AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, Hidden = true, QueueForbidden = true }),
    TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, Hidden = true, QueueForbidden = true }),
    VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, Hidden = true, QueueForbidden = true }),
    GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, Hidden = true, QueueForbidden = true }),
    InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, Hidden = true, QueueForbidden = true }),
    LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, Hidden = true, QueueForbidden = true }),
    ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, Hidden = true, QueueForbidden = true }),
    VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, Hidden = true, QueueForbidden = true }),
    FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, Hidden = true, QueueForbidden = true }),
    RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, Hidden = true, QueueForbidden = true }),
    AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, Hidden = true, QueueForbidden = true }),
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
	BonesoftheDamned                       = Action.Create({ Type = "Spell", ID = 279503, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_BLOOD)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_BLOOD], { __index = Action })


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
	BigDeff                                 = {A.DancingRuneWeapon.ID, A.IceboundFortitude.ID},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit
local player = "player"

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function InMelee(unit)
	-- @return boolean 
	return A.HeartStrike:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
	-- @return boolean 
	local c = 0 
	for unit in pairs(ActiveUnitPlates) do 
		if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
			if InMelee(unit) then 
				c = c + 1
			elseif range then 
				local r = Unit(unit):GetRange()
				if r > 0 and r <= range then 
					c = c + 1
				end 
			end 
			
			if c >= count then 
				return true 
			end 
		end 
	end
end 
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

-- SelfDefensives
local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
		
    if Unit(player):CombatTime() == 0 then 
        return 
    end 

    -- RuneTap	
    if A.RuneTap:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "RuneTapIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local RT_HP                 = A.GetToggle(2, "RuneTapHP")
        local RT_TTD                = A.GetToggle(2, "RuneTapTTD")
        local RT_UNITS              = A.GetToggle(2, "RuneTapUnits")
        if  (    
                ( RT_HP     >= 0     or RT_TTD                              >= 0                                     ) and 
                ( RT_HP     <= 0     or Unit(player):HealthPercent()     <= RT_HP                                    ) and 
                ( RT_TTD     <= 0     or Unit(player):TimeToDie()         <= RT_TTD                                  ) and
				( RT_UNITS   >= 0 and MultiUnits:GetByRange(8) >= RT_UNITS and Player:AreaTTD(8) > 3 and (Unit(player):HealthPercent() <= RT_HP or Unit(player):TimeToDie() <= RT_TTD) )
            ) 
		    or 
            (
                A.GetToggle(2, "RuneTapCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.RuneTap
        end 
    end 
		
    -- Emergency AntiMagicShell
    local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellHP")
	local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellTTDMagic")
    local AntiMagicShell = Action.GetToggle(2, "AntiMagicShellTTDMagicHP")
	local total, Hits, phys, magic = Unit(player):GetDMG()
	local RTtotal, RTHits, RTphys, RTmagic = Unit(player):GetRealTimeDMG()
		
    if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady(player) and 
    (
        (   -- Auto 
            AntiMagicShell >= 100 and 
            (
                -- HP lose per sec >= 10
                magic * 100 / Unit(player):HealthMax() >= 10 or 
                RTmagic >= Unit(player):HealthMax() * 0.10 or 
                -- TTD Magic
                Unit(player):TimeToDieMagicX(AntiMagicShellTTDMagicHP) < AntiMagicShellTTDMagic or 
				-- GGL logic by Ayni on magic inc damage
				Unit(player):GetDMG(4) > Unit(player):GetDMG() / 2 or
				Unit(player):GetDMG(4) * 5 >= A.AntiMagicShell:GetSpellDescription()[1] or
					
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AntiMagicShell < 100 and 
            Unit(player):HealthPercent() <= AntiMagicShell
        )
    ) 
    then 
        return A.AntiMagicShell
    end 
		
    -- Icebound Fortitude	
    if A.IceboundFortitude:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "IceboundFortitudeIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local IF_HP                 = A.GetToggle(2, "IceboundFortitudeHP")
        local IF_TTD                = A.GetToggle(2, "IceboundFortitudeTTD")
            
        if  (    
                ( IF_HP     >= 0     or IF_TTD                              >= 0                                     ) and 
                ( IF_HP     <= 0     or Unit(player):HealthPercent()     <= IF_HP                                    ) and 
                ( IF_TTD    <= 0     or Unit(player):TimeToDie()         <= IF_TTD                                   ) 
            ) 
		    or 
            (
                A.GetToggle(2, "IceboundFortitudeCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD()
                )
            )                
        then                
            return A.IceboundFortitude
        end 
    end 
	
    -- Vampiric Blood
    if A.VampiricBlood:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "VampiricBloodIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local VB_HP                 = A.GetToggle(2, "VampiricBloodHP")
        local VB_TTD                = A.GetToggle(2, "VampiricBloodTTD")
            
        if  (    
                ( VB_HP     >= 0     or VB_TTD                           >= 0                                     ) and 
                ( VB_HP     <= 0     or Unit(player):HealthPercent()     <= VB_HP                                 ) and 
                ( VB_TTD    <= 0     or Unit(player):TimeToDie()         <= VB_TTD                                )  
            ) 
			or 
            (
                A.GetToggle(2, "VampiricBloodCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 30 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then                
            -- VampiricBlood
            return A.VampiricBlood         -- #3                  
             
        end 
    end
	
    -- Dancing Rune Weapon
    if A.DancingRuneWeapon:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "DancingRuneWeaponIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff, true) == 0) then 
        local DRW_HP                 = A.GetToggle(2, "DancingRuneWeaponHP")
        local DRW_TTD                = A.GetToggle(2, "DancingRuneWeaponTTD")
            
        if  (    
                ( DRW_HP     >= 0     or DRW_TTD                          >= 0                                     ) and 
                ( DRW_HP     <= 0     or Unit(player):HealthPercent()     <= DRW_HP                                ) and 
                ( DRW_TTD    <= 0     or Unit(player):TimeToDie()         <= DRW_TTD                               )  
            ) 
			or 
            (
                A.GetToggle(2, "DancingRuneWeaponCatchKillStrike") and 
                (
                    ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 25 ) or 
                    Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                    Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD()
                )
            )                
        then
            -- Marrowrend
            if A.Marrowrend:IsReadyByPassCastGCD(player, nil, nil, true) and Player:RunicPower() >= A.Marrowrend:GetSpellPowerCostCache() and Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0 then  
                return A.Marrowrend        -- #4
            end 
                
            -- DancingRuneWeapon
            return A.DancingRuneWeapon         -- #3                  
             
        end 
    end		

    -- Emergency Death Pact
    local DeathPact = Action.GetToggle(2, "DeathPactHP")
    if     DeathPact >= 0 and A.DeathPact:IsReady(player) and A.DeathPact:IsSpellLearned() and 
    (
        (   -- Auto 
            DeathPact >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(10) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            DeathPact < 100 and 
            Unit(player):HealthPercent() <= DeathPact
        )
    ) 
    then 
        return A.DeathPact
    end  		

	-- SuperiorSteelskinPotion
    local SuperiorSteelskinPotion = A.GetToggle(2, "SuperiorSteelskinPotionHP")
    if     SuperiorSteelskinPotion >= 0 and A.SuperiorSteelskinPotion:IsReady(player) and 
    (
        (     -- Auto 
            SuperiorSteelskinPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 3 or 
				GetByRange(5, 15) and Unit(player):HealthPercent() <= 25 and Player:AreaTTD(15) > 20 or
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            SuperiorSteelskinPotion < 100 and 
            Unit(player):HealthPercent() <= SuperiorSteelskinPotion
        )
    ) 
    then 
        return A.SuperiorSteelskinPotion
    end

	-- HealingPotion
    local AbyssalHealingPotion = A.GetToggle(2, "AbyssalHealingPotionHP")
    if     AbyssalHealingPotion >= 0 and A.AbyssalHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            AbyssalHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(15) < 3 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AbyssalHealingPotion < 100 and 
            Unit(player):HealthPercent() <= AbyssalHealingPotion
        )
    ) 
    then 
        return A.AbyssalHealingPotion
    end 
end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

-- TO USE AFTER NEXT ACTION UPDATE
local function Interrupts(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, not A.MindFreeze:IsReady(unit)) -- A.Kick non GCD spell
    
	if castDoneTime > 0 then
        -- MindFreeze
        if useKick and not notInterruptable and A.MindFreeze:IsReady(unit) then 
            return A.MindFreeze
        end
	
        -- DeathGrip
        if useCC and A.DeathGrip:IsReady(unit) and DeathGripInterrupt then 
            return A.DeathGrip
   	    end 
	
   	    -- Asphyxiate
   	    if useCC and A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) then 
   	        return A.Asphyxiate
   	    end 
		    
   	    if useRacial and A.QuakingPalm:AutoRacial(unit) then 
   	        return A.QuakingPalm
   	    end 
    
   	    if useRacial and A.Haymaker:AutoRacial(unit) then 
            return A.Haymaker
   	    end 
    
   	    if useRacial and A.WarStomp:AutoRacial(unit) then 
            return A.WarStomp
   	    end 
    
   	    if useRacial and A.BullRush:AutoRacial(unit) then 
            return A.BullRush
   	    end 
    end
end

local function PredictDS() 
    local ReceivedLast5sec, HP7 = Unit(player):GetLastTimeDMGX(5) * 0.25, Unit(player):HealthMax() * 0.07  
    -- if this value lower than 7% then set fixed 7% heal    
    if ReceivedLast5sec <= HP7 then         
        ReceivedLast5sec = HP7    
    end 
    -- Extra buff which adding additional +10% heal 
    --[[
    if Env.Buffs("player", 101568, "player") > 0 then 
        ReceivedLast5sec = ReceivedLast5sec + HP10
    end ]]
    return Unit(player):HealthMax() - Unit(player):HealthPercent() >= ReceivedLast5sec or ReceivedLast5sec >= Unit(player):HealthMax() * 0.25
end 

local function TargetWithAgroExsist()

        local agroLevels = {}
        agroLevels[0] = false
        agroLevels[1] = false
        agroLevels[2] = false
        agroLevels[3] = false

        local DarkCommand_Nameplates = MultiUnits:GetActiveUnitPlates()
        if DarkCommand_Nameplates then
            for DarkCommand_UnitID in pairs(DarkCommand_Nameplates) do
                if Unit(DarkCommand_UnitID):CombatTime() > 0
                        and Unit(DarkCommand_UnitID):GetRange() <= 30
                        and not Unit(DarkCommand_UnitID):IsTotem()
                        and not Unit(DarkCommand_UnitID):IsPlayer()
                        and not Unit(DarkCommand_UnitID):IsExplosives()
                        and not Unit(DarkCommand_UnitID):IsDummy()
                then
                    if Unit(player):ThreatSituation(DarkCommand_UnitID) ~= nil then
                        agroLevels[Unit(player):ThreatSituation(DarkCommand_UnitID)] = true
                    end
                end
            end
        end

        return agroLevels
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
	local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local ActiveMitigationNeeded = Player:ActiveMitigationNeeded()
	local IsTanking = Unit(player):IsTanking("target", 8) or Unit(player):IsTankingAoE(8)
	local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
	local targetThreatSituation, targetThreatPercent = Unit(player):ThreatSituation()
	local threatDamagerLimit = (A.Role == "DAMAGER" and A.GetToggle(2, "ThreatDamagerLimit")) or -1
    local isSafestThreatRotation = not A.IsInPvP and A.Zone ~= "none" and A.TeamCache.Friendly.Size > 1 and threatDamagerLimit ~= -1 and targetThreatPercent >= threatDamagerLimit
	local BonestormHP = A.GetToggle(2, "BonestormHP")
	local BonestormRunicPower = A.GetToggle(2, "BonestormRunicPower")
	local BonestormRunicPowerWithVampiricBlood = A.GetToggle(2, "BonestormRunicPowerWithVampiricBlood")
	
    
	local PredictDS = PredictDS()
	-- Trinkets vars
    local Trinket1IsAllowed, Trinket2IsAllowed = TR:TrinketIsAllowed()
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)

        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- snapshot_stats
            -- potion
            if A.SuperiorSteelskinPotion:IsReady(unit) and Action.GetToggle(1, "Potion") then
                return A.SuperiorSteelskinPotion:Show(icon)
            end
        end
        Precombat = A.MakeFunctionCachedDynamic(Precombat)
		
        --Standard
        local function Standard(unit)	
					
            -- blooddrinker,if=!buff.dancing_rune_weapon.up
            if A.BloodDrinker:IsReady(unit) and 
			(
			    Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) == 0 
				or 
				Unit(player):HasBuffs(A.VampiricBlood.ID, true) > 0
			)
			then
                return A.BloodDrinker:Show(icon)
            end
			
            -- marrowrend,if=(buff.bone_shield.remains<=rune.time_to_3|buff.bone_shield.remains<=(gcd+cooldown.blooddrinker.ready*talent.blooddrinker.enabled*2)|buff.bone_shield.stack<3)&runic_power.deficit>=20
            if A.Marrowrend:IsReady(unit) and 
			    (
				    (
					    Unit(player):HasBuffs(A.BoneShieldBuff.ID, true) <= Player:RuneTimeToX(3) 
						or 
						Unit(player):HasBuffs(A.BoneShieldBuff.ID, true) <= (A.GetGCD() + num(A.BloodDrinker:GetCooldown() == 0) * num(A.BloodDrinker:IsSpellLearned()) * 2) 
						or 
						Unit(player):HasBuffsStacks(A.BoneShieldBuff.ID, true) < 5
					) 
					--and Player:RunicPowerDeficit() >= 20
				) 
			then
                return A.Marrowrend:Show(icon)
            end
			
            -- bonestorm,if=runic_power>=100&!buff.dancing_rune_weapon.up
            if A.Bonestorm:IsReadyByPassCastGCD(player) and A.Bonestorm:IsSpellLearned() and 
			(
			    Unit(player):HealthPercent() <= BonestormHP and Player:RunicPower() >= BonestormRunicPower
			    or 
			    (Player:RunicPower() >= BonestormRunicPowerWithVampiricBlood and Unit(player):HasBuffs(A.VampiricBlood.ID, true) > 2)
                or 
               	-- Ultra emergency
                Player:RunicPower() >= 50 and GetByRange(4, 15)	and Unit(player):TimeToDie() < 5	
			) 
			then
                return A.Bonestorm:Show(icon)
            end
			
            -- death_and_decay,if=spell_targets.death_and_decay>=3
            if A.DeathandDecay:IsReadyByPassCastGCD(player) and Unit(player):HasBuffs(A.CrimsonScourgeBuff.ID, true) > 0 then
                return A.DeathandDecay:Show(icon)
            end
			            
			-- death_strike
			local DeathStrike = Action.GetToggle(2, "DeathStrikeHP")
            if DeathStrike >= 0 and A.DeathStrike:IsReadyByPassCastGCD(unit) and 
			(
   			    -- POOLING
    			(
        		    Player:RunicPower() >= 90 
					and
        		    -- Bonestorm
        		    A.Bonestorm:IsSpellLearned() 
					and
        		    A.Bonestorm:GetCooldown() <= 5
    			) 
				or 
				Unit(player):HasBuffsStacks(A.HemostasisBuff.ID, true) >= 4 and A.Hemostasis:IsSpellLearned()
				or
				-- Enough Runic Power pooled
				Player:RunicPower() >= 105 
				or
    			-- HEALING
    			(
				    -- AUTO
        			DeathStrike >= 100 and
        			(
            			Unit(player):TimeToDie() <= 5 or
            			(       
               		 		Unit(player):HealthPercent() <= 93 and
                			PredictDS and
                			-- Bonestorm
                			(            
                   		 		not A.Bonestorm:IsSpellLearned() or
                    			A.Bonestorm:GetCooldown() > 5
                			) and
                			-- Mark of Blood
                			(
                    			not A.MarkofBlood:IsSpellLearned() or
                    			Unit(unit):HasBuffs(A.MarkofBlood.ID, true) > 0            
                			)        
            			)
        			)
					or
					-- CUSTOM
					DeathStrike < 100 and 
               		(    
                    	Unit(player):HealthPercent() <= DeathStrike and Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.07
                	)
    			)  
			)
			then
                return A.DeathStrike:Show(icon)
            end	
			
            -- blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
            if A.BloodBoil:IsReady(unit) and A.LastPlayerCastName ~= A.BloodBoil:Info() and 
			    (
				    A.BloodBoil:GetSpellChargesFrac() >= 1.8 and 
					(
					    (Unit(player):HasBuffsStacks(A.HemostasisBuff.ID, true) == 0 or not A.Hemostasis:IsSpellLearned()) 
						or 
						GetByRange(3, 15)
					)
				) 
			then
                return A.BloodBoil:Show(icon)
            end
			
            -- marrowrend,if=buff.bone_shield.stack<5&talent.ossuary.enabled&runic_power.deficit>=15
            if A.Marrowrend:IsReady(unit) and 
			    (
			        Unit(player):HasBuffsStacks(A.BoneShieldBuff.ID, true) < 5 and A.Ossuary:IsSpellLearned() and Player:RunicPowerDeficit() >= 15
			    ) 
			then
                return A.Marrowrend:Show(icon)
            end
			
            -- death_strike,if=runic_power.deficit<=(15+buff.dancing_rune_weapon.up*5+spell_targets.heart_strike*talent.heartbreaker.enabled*2)|Unit(unit):TimeToDie()<10
            if A.DeathStrike:IsReadyByPassCastGCD(unit) and 
			(
			    Player:RunicPowerDeficit() <= (15 + num(Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0) * 5 + MultiUnits:GetByRange(15) * num(A.Heartbreaker:IsSpellLearned()) * 2) 
				or 
				Unit(unit):TimeToDie() < 10
			)
			then
                return A.DeathStrike:Show(icon)
            end
			
            -- rune_strike,if=(charges_fractional>=1.8|buff.dancing_rune_weapon.up)&rune.time_to_3>=gcd
            if A.RuneStrike:IsReady(unit) and 
			(
			    (
				    A.RuneStrike:GetSpellChargesFrac() >= 1.8 
				    or 
				    Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0
				) 
				and Player:RuneTimeToX(3) >= A.GetGCD()
			)
			then
                return A.RuneStrike:Show(icon)
            end
			
            -- heart_strike,if=buff.dancing_rune_weapon.up|rune.time_to_4<gcd
            if A.HeartStrike:IsReady(unit) and Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0 and Player:RuneTimeToX(4) < A.GetGCD()  then
                return A.HeartStrike:Show(icon)
            end
			
            -- blood_boil,if=buff.dancing_rune_weapon.up
            if A.BloodBoil:IsReady(unit) and A.LastPlayerCastName ~= A.BloodBoil:Info() and Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0 then
                return A.BloodBoil:Show(icon)
            end
			
            -- death_and_decay,if=buff.crimson_scourge.up|talent.rapid_decomposition.enabled|spell_targets.death_and_decay>=2
            if A.DeathandDecay:IsReadyByPassCastGCD(player) and Player:IsStayingTime() >= 1.5 and 
			(
			    Unit(player):HasBuffs(A.CrimsonScourgeBuff.ID, true) > 0 
				or
				A.RapidDecomposition:IsSpellLearned() 
				or 
				GetByRange(2, 15)
			) 
			then
                return A.DeathandDecay:Show(icon)
            end
			
            -- consumption
            if A.Consumption:IsReady(unit) then
                return A.Consumption:Show(icon)
            end
			
            -- blood_boil
            if A.BloodBoil:IsReady(unit) and (Unit(player):HasBuffsStacks(A.HemostasisBuff.ID, true) == 0 or not A.Hemostasis:IsSpellLearned()) and A.LastPlayerCastName ~= A.BloodBoil:Info() then
                return A.BloodBoil:Show(icon)
            end
			
            -- heart_strike,if=rune.time_to_3<gcd|buff.bone_shield.stack>6
            if A.HeartStrike:IsReady(unit) and 
			(
			    Player:RuneTimeToX(3) < A.GetGCD() 
				or 
				Unit(player):HasBuffsStacks(A.BoneShieldBuff.ID, true) > 5
			)
			then
                return A.HeartStrike:Show(icon)
            end
			
            -- use_item,name=grongs_primal_rage
            if A.GrongsPrimalRage:IsReady(unit) then
                return A.GrongsPrimalRage:Show(icon)
            end
			
            -- rune_strike
            if A.RuneStrike:IsReady(unit) then
                return A.RuneStrike:Show(icon)
            end
						
        end
        Standard = A.MakeFunctionCachedDynamic(Standard)
        
        -- call precombat
        if not inCombat and Precombat(unit) and Unit(unit):IsExists() and unit ~= "mouseover" then 
            return true
        end

        -- In Combat
        if inCombat and Unit(unit):IsExists() then
            
			-- Auto taunt logic by KhalDrogo1988  (THANKS MATE)
			if A.GetToggle(2, "AutoTaunt") and combatTime > 0 then
                if not Unit(unit):IsBoss() and
                    A.DarkCommand:IsReady(unit) or
                    A.DeathGrip:IsReady(unit) or
                    A.Asphyxiate:IsReady(unit) or
                    A.DeathCaress:IsReady(unit)
                then
                    local agroLevels = TargetWithAgroExsist()
                    if agroLevels[0] and Unit(player):ThreatSituation(unit) ~= 0 then
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end
                    if agroLevels[1] and Unit(player):ThreatSituation(unit) > 1 then
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end
                    if agroLevels[2] and Unit(player):ThreatSituation(unit) > 2 then
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end
                end
 			end
			
			-- Interrupt
            local Interrupt = Interrupts(unit)
            if Interrupt then 
                return Interrupt:Show(icon)
            end	

            -- Defensive
            local SelfDefensive = SelfDefensives()
            if SelfDefensive then 
                return SelfDefensive:Show(icon)
            end 

            -- Custom logic by KhalDrogo1988
            if Unit(unit):GetRange() <= 30
            and Unit(player):ThreatSituation(unit) ~= 3
            and not Unit(unit):IsExplosives()
            and not Unit(unit):IsDummy()
            and not Unit(unit):IsPlayer()
			and not Unit(unit):NPCID() == 160966 -- Thing From Beyong
			and not Unit(unit):NPCID() == 161895 -- Thing From Beyong
            and not Unit(unit):IsTotem() then
                --  Try taunt enemy if no agro
                if A.DarkCommand:IsReady(unit) then
                    return A.DarkCommand:Show(icon)
                end
                -- Try grip emeny if no agro
                if A.DeathGrip:IsReady(unit) then
                    return A.DeathGrip:Show(icon)
                end
                -- Try CC Enemy if no agro
                if A.Asphyxiate:IsReady(unit) then
                    return A.Asphyxiate:Show(icon)
                end

                if A.DeathCaress:IsReady(unit) and Unit(unit):GetRange() > 5 then
                    return A.DeathCaress:Show(icon)
                end
            end
			
			-- VigilantProtector
            if A.VigilantProtector:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.VigilantProtector:Show(icon)
            end

			-- EmpoweredNullBarrier
            if A.EmpoweredNullBarrier:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.EmpoweredNullBarrier:Show(icon)
            end

			-- AnimaofDeath
            if A.AnimaofDeath:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.AnimaofDeath:Show(icon)
            end

			-- AzerothsUndyingGift
            if A.AzerothsUndyingGift:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.AzerothsUndyingGift:Show(icon)
            end

			-- RippleinSpace
            if A.RippleinSpace:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.RippleinSpace:Show(icon)
            end

			-- AegisoftheDeep
            if A.AegisoftheDeep:AutoHeartOfAzeroth(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.AegisoftheDeep:Show(icon)
            end

            -- memory_of_lucid_dreams
            if A.MemoryofLucidDreams:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") then
                return A.MemoryofLucidDreams:Show(icon)
            end
			
            -- concentrated_flame,if=buff.avatar.down&!dot.concentrated_flame_burn.remains>0|essence.the_crucible_of_flame.rank<3
            if A.ConcentratedFlame:AutoHeartOfAzerothP(unit, true) and Action.GetToggle(1, "HeartOfAzeroth") and Unit(unit):HasDeBuffs(A.ConcentratedFlameBurn.ID, true) == 0 then
                return A.ConcentratedFlame:Show(icon)
            end
						
        -- Taunt (Updated by KhalDrogo1988)
        if A.GetToggle(2, "AutoTaunt") and combatTime > 0
		then
		    -- if not fully aggroed or we are not current target then use taunt
		    if not Unit(unit):IsExplosives() and not Unit(unit):IsDummy() and not Unit(unit):IsPlayer() and not Unit(unit):IsTotem() and Unit(unit):GetRange() <= 30 and Unit(player):ThreatSituation(unit) ~= 3 then

				if A.DarkCommand:IsReady(unit) then
					return A.DarkCommand:Show(icon)
				end

				if A.VigilantProtector:AutoHeartOfAzeroth(unit) then 
					return A.VigilantProtector:Show(icon)
				end 
	
				if A.DeathGrip:IsReady(unit) and not Unit(unit):IsBoss() then
					return A.DeathGrip:Show(icon)
				end
				
				if A.DeathCaress:IsReady(unit) then
					return A.DeathCaress:Show(icon)
				end
			-- else if all good on current target, switch to another one we know we dont currently tank
            else
                local DarkCommand_Nameplates = MultiUnits:GetActiveUnitPlates()
                if DarkCommand_Nameplates then
                    for DarkCommand_UnitID in pairs(DarkCommand_Nameplates) do
                        if not Unit(DarkCommand_UnitID):IsPlayer() 
						and not Unit(unit):IsExplosives()
						and Unit(DarkCommand_UnitID):CombatTime() > 0
						and not UnitIsUnit("target", DarkCommand_UnitID) 
						and not Unit(DarkCommand_UnitID):IsDummy() 
						and not Unit(DarkCommand_UnitID):IsTotem() 
						and Unit(DarkCommand_UnitID):GetRange() <= 30 
						and Unit(player):ThreatSituation(DarkCommand_UnitID) ~= 3 then
							if A.DarkCommand:IsReady(unit) or A.VigilantProtector:AutoHeartOfAzeroth(unit) or A.DeathGrip:IsReady(unit) or A.DeathCaress:IsReady(unit) then
								return A:Show(icon, ACTION_CONST_AUTOTARGET)
							end
						end
                    end
                end
			end
        end
			
            -- GorefiendsGrasp
			local currentEnemiesInMelee = MultiUnits:GetByRange(5)
			local currentEnemiesInMeleeAndNotInMelee = MultiUnits:GetByRange(15)
			local currentEnemiesNotInMelee = currentEnemiesInMeleeAndNotInMelee - currentEnemiesInMelee
			
            if A.GorefiendsGrasp:AbsentImun(unit, Temp.TotalAndCC, true) and Unit(player):CombatTime() >= 2 and A.GorefiendsGrasp:IsReady(player) then 
     	        if currentEnemiesNotInMelee >= 3 then
       	            return A.GorefiendsGrasp
       	        end 
           	end
			
            -- blood_fury,if=cooldown.dancing_rune_weapon.ready&(!cooldown.blooddrinker.ready|!talent.blooddrinker.enabled)
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) and (A.DancingRuneWeapon:GetCooldown() == 0 and (not A.BloodDrinker:GetCooldown() == 0 or not A.BloodDrinker:IsSpellLearned())) then
                return A.BloodFury:Show(icon)
            end

            -- arcane_torrent,if=runic_power.deficit>20
            if A.ArcaneTorrent:IsRacialReady(unit) and Action.AuraIsValid(unit, "UseDispel", "Magic") and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.ArcaneTorrent:Show(icon)
            end
			
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
			
            -- Defensives trinkets
            if Unit(player):CombatTime() > 0 and (Unit(player):HealthPercent() < 50 or Unit(player):TimeToDie() < 5) then 
                if A.Trinket1:IsReady(player) and Trinket1IsAllowed and A.Trinket1:GetItemCategory() ~= "DPS" then 
                    return A.Trinket1:Show(icon)
               end 
        
                if A.Trinket2:IsReady(player) and Trinket2IsAllowed and A.Trinket2:GetItemCategory() ~= "DPS" then 
                   return A.Trinket2:Show(icon)
                end
            end 
	
            -- Offensive Trinkets
            if A.Trinket1:IsReady(unit) and Trinket1IsAllowed and A.Trinket1:GetItemCategory() ~= "DEFF" then 
                return A.Trinket1:Show(icon)
            end 
            
            if A.Trinket2:IsReady(unit) and Trinket2IsAllowed and A.Trinket2:GetItemCategory() ~= "DEFF" then 
                return A.Trinket2:Show(icon)
            end 
			
            -- use_item,name=razdunks_big_red_button
            if A.RazdunksBigRedButton:IsReady(unit) then
                return A.RazdunksBigRedButton:Show(icon)
            end
			
            -- use_item,name=merekthas_fang
            if A.MerekthasFang:IsReady(unit) then
                return A.MerekthasFang:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
            if A.AshvanesRazorCoral:IsReady(unit) and Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) == 0 then
                return A.AshvanesRazorCoral:Show(icon)
            end
			
            -- use_item,name=ashvanes_razor_coral,if=buff.dancing_rune_weapon.up&debuff.razor_coral_debuff.up
            if A.AshvanesRazorCoral:IsReady(unit) and Unit(player):HasBuffs(A.DancingRuneWeaponBuff.ID, true) > 0 and Unit(unit):HasDeBuffsStacks(A.RazorCoralDebuff.ID, true) > 0 then
                return A.AshvanesRazorCoral:Show(icon)
            end
						
            -- tombstone,if=buff.bone_shield.stack>=7
            if A.Tombstone:IsReady(unit) and A.Tombstone:IsSpellLearned() and Unit(player):HasBuffsStacks(A.BoneShieldBuff.ID, true) >= 7 then
                return A.Tombstone:Show(icon)
            end
			
            -- call_action_list,name=standard
            if Standard(unit) then
                return true
            end
			
        end
    end

    -- End on EnemyRotation()


    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 

    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 

    end
end
-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit(player):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    local DeathGripLowHealth = GetToggle(2, "DeathGripLowHealth")
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" or unit == "arena2" or unit == "arena3" --and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) 
		then 	
			-- Interrupt
   		    local Interrupt = Interrupts(unit)
  		    if Interrupt then 
  		        return Interrupt:Show(icon)
  		    end	

			-- Death Grip
			if UseDeathGrip and A.DeathGrip:IsReady(unit) and Unit(unit):GetRange() > 8 and Unit(unit):GetRange() <= 30 and Unit(unit):IsMovingOut() and Unit(unit):HealthPercent() < DeathGripLowHealth
			then
			    return A.DeathGrip:Show(icon) 
			end
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end
  	
	-- RaiseAlly
    if A.RaiseAlly:IsReady(unit) and Unit(player):CombatTime() > 0 and Unit(unit):IsDead() and not Unit(unit):InLOS() and
	(
	    -- Tank
	    GetToggle(2, "RaiseAllyUnits")[1] and Unit(unit):IsTank() and Unit(unit):IsPlayer()
		or
		-- Healer
		GetToggle(2, "RaiseAllyUnits")[2] and Unit(unit):IsHealer() and Unit(unit):IsPlayer()
		or
		-- Damager
		GetToggle(2, "RaiseAllyUnits")[3] and Unit(unit):IsDamager() and Unit(unit):IsPlayer() 
		or
		-- Mouseover
		GetToggle(2, "RaiseAllyUnits")[4] and Unit("mouseover"):IsExists() and Unit(unit):IsPlayer()
	)	
	then
        return A.RaiseAlly
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end

