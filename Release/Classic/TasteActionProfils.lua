TellMeWhenDB = {
	["global"] = {
		["TextLayouts"] = {
			["icon1"] = {
				{
				}, -- [1]
				{
				}, -- [2]
			},
			["bar2"] = {
				{
				}, -- [1]
				{
				}, -- [2]
			},
			["TMW:textlayout:1TMvg5InaYOw"] = {
				{
					["Anchors"] = {
						{
							["y"] = -1.5,
							["x"] = 1.5,
							["point"] = "TOPLEFT",
							["relativePoint"] = "TOPLEFT",
						}, -- [1]
					},
					["DefaultText"] = "[ActionBurst]",
					["Size"] = 6,
				}, -- [1]
				{
					["Anchors"] = {
						{
							["y"] = 1,
							["point"] = "BOTTOMRIGHT",
							["relativePoint"] = "BOTTOMRIGHT",
						}, -- [1]
					},
					["Name"] = "Morpheus",
					["DefaultText"] = "[ActionAoE]",
					["Size"] = 6,
				}, -- [2]
				{
					["Anchors"] = {
						{
							["y"] = 1,
							["x"] = 1.5,
							["point"] = "BOTTOMLEFT",
							["relativePoint"] = "BOTTOMLEFT",
						}, -- [1]
					},
					["Name"] = "Morpheus",
					["DefaultText"] = "[ActionMode]",
					["Size"] = 6,
				}, -- [3]
				{
					["Anchors"] = {
						{
							["y"] = -1.5,
							["x"] = -0.5,
							["point"] = "TOPRIGHT",
							["relativePoint"] = "TOPRIGHT",
						}, -- [1]
					},
					["Name"] = "2002 Bold",
					["DefaultText"] = "[ActionRank]",
					["Size"] = 6,
				}, -- [4]
				["GUID"] = "TMW:textlayout:1TMvg5InaYOw",
				["Name"] = "ActionLayout",
				["n"] = 4,
			},
		},
		["Groups"] = {
			{
				["BackdropColor"] = "cb000000",
				["Point"] = {
					["y"] = -30,
					["relativeTo"] = "TargetFrame",
					["point"] = "BOTTOMLEFT",
					["relativePoint"] = "BOTTOMLEFT",
					["x"] = -5,
				},
				["Scale"] = 1.18,
				["TextureName"] = "Blizzard Raid Bar",
				["Locked"] = true,
				["Columns"] = 1,
				["BackdropColor_Enable"] = true,
				["Icons"] = {
					{
						["Unit"] = "target",
						["Type"] = "TheAction - UnitCasting",
						["Enabled"] = true,
						["BarDisplay_Invert"] = true,
						["BackdropColor"] = "7f330c0a",
						["TimerBar_MiddleColor"] = "ffff0000",
						["TimerBar_CompleteColor"] = "ffff0000",
						["NoPocketwatch"] = true,
					}, -- [1]
				},
				["Name"] = "Target Castbar",
				["SettingsPerView"] = {
					["bar"] = {
						["SizeX"] = 170,
						["BorderInset"] = true,
						["BorderIcon"] = 0.5,
					},
				},
				["Conditions"] = {
					{
						["Type"] = "LUA",
						["Name"] = "return Action and Action.IsInitialized and Action.GetToggle(1, \"TargetCastBar\")",
					}, -- [1]
					["n"] = 1,
				},
				["GUID"] = "TMW:group:1TQgp5sK81OZ",
				["View"] = "bar",
			}, -- [1]
		},
		["HelpSettings"] = {
			["CNDT_ANDOR_FIRSTSEE"] = true,
			["SUG_FIRSTHELP"] = true,
			["SCROLLBAR_DROPDOWN"] = true,
			["ICON_DURS_FIRSTSEE"] = true,
			["ICON_POCKETWATCH_FIRSTSEE"] = true,
			["CNDT_PARENTHESES_FIRSTSEE"] = true,
			["ICON_EXPORT_DOCOPY"] = true,
		},
	},
	["Version"] = 87101,
	["profiles"] = {
		["[Taste]Classic - Hunter by Wolftech"] = {
			["CodeSnippets"] = {
				{
					["Order"] = 2,
					["Name"] = "HUNTER",
					["Code"] = "------------------------------------------------------------\n---------------- Wolftech Action Hunter Classic -------------\n------------------------------------------------------------\n-- locals\nlocal Action                                = Action\nlocal TeamCache                                = Action.TeamCache\nlocal EnemyTeam                                = Action.EnemyTeam\nlocal FriendlyTeam                            = Action.FriendlyTeam\nlocal LoC                                     = Action.LossOfControl\nlocal Player                                = Action.Player \nlocal MultiUnits                            = Action.MultiUnits\nlocal UnitCooldown                            = Action.UnitCooldown\nlocal Unit                                    = Action.Unit \nlocal Pet                                    = LibStub(\"PetLibrary\")\nlocal setmetatable, pairs, select, wipe        = setmetatable, pairs, select, wipe\nlocal UnitPowerType                         = UnitPowerType \nlocal UnitIsUnit                            = UnitIsUnit\nlocal IsUsableSpell                            = IsUsableSpell\n\n-- All spells and action\nAction[Action.PlayerClass] = {\n    -- Night elf \n    Shadowmeld = Action.Create({ Type = \"Spell\", ID = 20580 }),\n    -- Dwarf     \n    Stoneform = Action.Create({ Type = \"Spell\", ID = 20594 }),     \n    -- Troll \n    Berserking = Action.Create({ Type = \"Spell\", ID = 20554 }), \n    \n    -- Damager \n    Aimedshot = Action.Create({ Type = \"Spell\", ID = 19434, useMaxRank = false, isTalent = true }), \n    Multishot = Action.Create({ Type = \"Spell\", ID = 2643, useMaxRank = false }), \n    Autoshot = Action.Create({ Type = \"Spell\", ID = 75 }),\n    Volley = Action.Create({ Type = \"Spell\", ID = 14295, useMaxRank = false }),\n    --Serpentsting = Action.Create({ Type = \"Spell\", ID = 1976, useMaxRank = false }),    \n    \n    -- DropCombat\n    Disengage = Action.Create({ Type = \"Spell\", ID = 781, useMaxRank = false }),\n    FeignDeath = Action.Create({ Type = \"Spell\", ID = 5384 }),\n    \n    -- Buff\n    Trueshot = Action.Create({ Type = \"Spell\", ID = 19506, useMaxRank = false, isTalent = true }),\n    Hawk = Action.Create({ Type = \"Spell\", ID = 13165, useMaxRank = false }),\n    Mark = Action.Create({ Type = \"Spell\", ID = 1130, useMaxRank = false }),\n    \n    -- Slow\n    Wingclip = Action.Create({ Type = \"Spell\", ID = 2974, useMaxRank = false }),\n    \n    -- Healpet\n    Mendpet = Action.Create({ Type = \"Spell\", ID = 136, useMaxRank = false }),\n    \n    -- Melee\n    Raptorstrike = Action.Create({ Type = \"Spell\", ID = 2973, useMaxRank = false }),\n    \n    -- Potions\n    MajorManaPotion = Action.Create({ Type = \"Potion\", ID = 13444 }),\n    MajorHealingPotion = Action.Create({ Type = \"Potion\", ID = 13446 }),\n    \n    -- Trinkets \n    -- TalismanofEphemeralPower                = Action.Create({ Type = \"Trinket\",          ID = 18820                                                                }), -- not used in APL but can Queue \n    -- ZandalarianHeroCharm                    = Action.Create({ Type = \"Trinket\",          ID = 19950                                                                }), -- not used in APL but can Queue \n    \n}    \nlocal A = setmetatable(Action[Action.PlayerClass], { __index = Action })\n\n-- For racials use following values as Key from racial key:\nlocal RacialKeys = {\n    NightElf = \"Shadowmeld\",\n    Human = \"Perception\",\n    Gnome = \"EscapeArtist\",\n    Dwarf = \"Stoneform\",\n    Scourge = \"WilloftheForsaken\",\n    Troll = \"Berserking\",\n    Tauren = \"WarStomp\",\n    Orc = \"BloodFury\",\n}\n\n-- Local used to check immunities\nlocal Temp                                  = {\n    TotalAndPhys                            = {\"TotalImun\", \"DamagePhysImun\"},\n    TotalAndPhysKick                        = {\"TotalImun\", \"DamagePhysImun\", \"KickImun\"},\n    TotalAndPhysAndCC                       = {\"TotalImun\", \"DamagePhysImun\", \"CCTotalImun\"},\n    TotalAndPhysAndStun                     = {\"TotalImun\", \"DamagePhysImun\", \"StunImun\"},\n    TotalAndPhysAndCCAndStun                = {\"TotalImun\", \"DamagePhysImun\", \"CCTotalImun\", \"StunImun\"},\n    TotalAndMag                             = {\"TotalImun\", \"DamageMagicImun\"},\n}\n\n-- Defensives abilities\nlocal function SelfDefensives()\n    if Unit(\"player\"):CombatTime() == 0 then \n        return \n    end \n    \n    -- FeignDeath on large burst damage\n    \n    -- Get the FeignDeath setting from ProfileUI : FeignDeathHP\n    local FeignDeath = A.GetToggle(2, \"FeignDeathHP\")\n    if     FeignDeath >= 0 and A.FeignDeath:IsReady(\"player\") and\n    (\n        (     -- Auto \n            FeignDeath >= 100 and \n            (\n                -- HP lose per sec >= 20\n                Unit(\"player\"):GetDMG() * 100 / Unit(\"player\"):HealthMax() >= 20 or \n                Unit(\"player\"):GetRealTimeDMG() >= Unit(\"player\"):HealthMax() * 0.25 or \n                -- TTD \n                Unit(\"player\"):TimeToDieX(25) < 3 or \n                (\n                    A.IsInPvP and \n                    (\n                        Unit(\"player\"):UseDeff() or \n                        (\n                            Unit(\"player\", 5):HasFlags() and \n                            Unit(\"player\"):GetRealTimeDMG() > 0 and \n                            Unit(\"player\"):IsFocused() \n                        )\n                    )\n                )\n            ) and \n            Unit(\"player\"):HasBuffs(\"DeffBuffs\", true) == 0\n        ) or \n        (    -- Custom\n            FeignDeath < 100 and \n            Unit(\"player\"):HealthPercent() <= FeignDeath\n        )\n    ) \n    then \n        return A.FeignDeath\n    end \n    \n    \nend \n\n-- Interrupts\nlocal function Interrupts(unit, isSoothingMistCasting)\n    local useKick, useCC, useRacial = A.InterruptIsValid(unit, \"TargetMouseover\")\n    -- Your interrupt\n    if useKick and A.YourInterruptSpell:IsReady(unit) and A.YourInterruptSpell:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then \n        if ActionUnit(unit):CanInterrupt(true) then \n            return A.YourInterruptSpel\n        end            \n    end \n    -- Your CC\n    if useCC and A.YourCCSpell:IsReady(unit) and A.YourCCSpell:AbsentImun(unit, Temp.TotalAndPhysAndCC, true) then \n        if ActionUnit(unit):CanInterrupt(true) then \n            return A.YourCCSpell\n        end            \n    end     \n    \n    if useRacial and A.QuakingPalm:AutoRacial(unit, nil, nil, isSoothingMistCasting) then \n        return A.QuakingPalm\n    end \n    \n    if useRacial and A.Haymaker:AutoRacial(unit, nil, nil, isSoothingMistCasting) then \n        return A.Haymaker\n    end \n    \n    if useRacial and A.WarStomp:AutoRacial(unit, nil, nil, isSoothingMistCasting) then \n        return A.WarStomp\n    end \n    \n    if useRacial and A.BullRush:AutoRacial(unit, nil, nil, isSoothingMistCasting) then \n        return A.BullRush\n    end      \n    \nend \nInterrupts = A.MakeFunctionCachedDynamic(Interrupts)\n\n\n-- [3] Rotation \nA[3] = function(icon)\n    local combatTime       = Unit(\"player\"):CombatTime()\n    local inCombat         = combatTime > 0\n    local inRaidPvE        = TeamCache.Friendly.Type == \"raid\" and not A.IsInPvP\n    \n    -- DPS Rotation\n    local function DamageRotation(unit)\n        \n        -- Interrupts\n        local Interrupt = Interrupts(unit, isSoothingMistCasting)\n        if Interrupt then \n            return Interrupt:Show(icon)\n        end\n        \n        -- Test lvl 1 Raptorstrike\n        if A.Raptorstrike:IsReady(unit) and Unit(unit):InRange() then \n            return A.Raptorstrike:Show(icon)\n        end         \n        \n        -- Trueshot Aura \n        if A.Trueshot:IsReady(unit) and (Unit(\"player\"):HasBuffs(A.Trueshot.ID, false) <= A.GetGCD() or Unit(\"player\"):HasBuffsStacks(A.InnerFire.ID, true) <= 1) then \n            return A.Trueshot:Show(icon)\n        end \n        \n        -- Autoshot\n        if A.Autoshot:IsReady(unit) and A.Autoshot:AbsentImun(unit, Temp.AttackTypes) then \n            return A.Autoshot:Show(icon)\n        end \n        \n        -- Aimedshot\n        if A.Aimedshot:IsReady(unit) and A.Aimedshot:AbsentImun(unit, Temp.AttackTypes) and Player:IsStaying() then \n            return A.Aimedshot:Show(icon)\n        end \n        \n        -- CD's\n        if A.BurstIsON(unit) and A.AbsentImun(nil, unit) then \n            -- Racials \n            if A.Berserking:AutoRacial(unit) and Unit(unit):InRange() then \n                \n                return A.Berserking:Show(icon)\n            end                 \n        end     \n        \n        \n        \n        -- PvE: Stoneform (self dispel)\n        if A.Stoneform:IsRacialReady(\"player\", true) and not A.IsInPvP and (A.AuraIsValid(\"player\", \"UseDispel\", \"Poison\") or A.AuraIsValid(\"player\", \"UseDispel\", \"Bleed\") or A.AuraIsValid(\"player\", \"UseDispel\", \"Disease\")) then \n            return A.Stoneform:Show(icon)\n        end     \n        \n        \n        -- PvE: FeignDeath (agro dump)\n        if inCombat and not A.IsInPvP and A.Zone ~= \"none\" and TeamCache.Friendly.Type and A.FeignDeath:IsReady(\"player\") and (Unit(\"player\"):IsTankingAoE()) then \n            return A.FeignDeath:Show(icon)\n        end \n        \n        -- PvE: Shadowmeld (agro dump)\n        if inCombat and not A.IsInPvP and A.Zone ~= \"none\" and TeamCache.Friendly.Type and A.PlayerRace == \"NightElf\" and A.Shadowmeld:IsRacialReady(\"player\") and Unit(\"player\"):IsTankingAoE() then \n            return A.Shadowmeld:Show(icon)\n        end \n        \n        \n        -- Out of combat: Self Buffer \n        --if not inCombat and PlayerRebuff() then \n        --    return true \n        --end \n        \n        -- Runes \n        --if inCombat and A.CanUseManaRune(icon) then \n        --    return true \n        --end \n        \n        -- Mana Potion \n        --if inCombat and A.MajorManaPotion:IsReady(\"player\") and Unit(\"player\"):PowerPercent() <= A.GetToggle(2, \"ManaPotion\") then \n        --    return A.MajorManaPotion:Show(icon)\n        --end         \n    end \n    \n    -- Defensive\n    local SelfDefensive = SelfDefensives()\n    if SelfDefensive then \n        return SelfDefensive:Show(icon)\n    end \n    \n    -- Function to execute if our mouseover is hostile\n    if A.IsUnitEnemy(\"mouseover\") then \n        unit = \"mouseover\"\n        \n        if DamageRotation(unit) then \n            return true \n        end \n    end \n    \n    -- Function to execute if our target is hostile\n    if A.IsUnitEnemy(\"target\") then \n        unit = \"target\"\n        \n        if DamageRotation(unit) then \n            return true \n        end \n    end \nend \n\n",
				}, -- [1]
				{
					["Name"] = "Profile UI",
					["Code"] = "-- Map\nlocal TMW = TMW \nlocal CNDT = TMW.CNDT \nlocal Env = CNDT.Env\nlocal A = Action\n\nA.Data.ProfileEnabled[TMW.db:GetCurrentProfile()]   = true\nA.Data.ProfileUI                                     = {\n    DateTime = \"v7 (23.09.2019)\",\n    [2]                                             = { LayoutOptions = { gutter = 6, padding = { left = 10, right = 10 } } },\n    [7]                                                = {\n        [\"kick\"] = { Enabled = true, Key = \"Silence\", LUAVER = 1, LUA = [[\n                local Obj     = Action[Action.PlayerClass]\n                local Temp     = {\"TotalImun\", \"KickImun\", \"DamageMagicImun\", \"CCTotalImun\", \"CCMagicImun\"}\n                return     Obj.Silence and \n                        Obj.Silence:IsReadyM(thisunit) and \n                        Obj.Silence:AbsentImun(thisunit, Temp) and \n                        Unit(thisunit):IsCastingRemains() > 0 and \n                        Unit(thisunit):IsControlAble(\"silence\") and \n                        LossOfControl:IsMissed(\"SILENCE\") and \n                        LossOfControl:Get(\"SCHOOL_INTERRUPT\", \"SHADOW\") == 0\n            ]] },\n        [\"fear\"] = { Enabled = true, Key = \"PsychicScream\", LUAVER = 3, LUA = [[\n                local Obj     = Action[Action.PlayerClass]\n                local Temp     = {\"TotalImun\", \"FearImun\"}\n                return     Obj.PsychicScream and \n                        Obj.PsychicScream:IsReadyM() and \n                        (\n                            MultiUnits:GetByRange(8, 1) >= 1 or \n                            (\n                                Obj.PsychicScream:IsReadyM(thisunit, true) and \n                                Obj.PsychicScream:AbsentImun(thisunit, Temp) and \n                                Unit(thisunit):IsControlAble(\"fear\") and \n                                Unit(thisunit):GetRange() <= 8 and \n                                LossOfControl:IsMissed(\"SILENCE\") and \n                                LossOfControl:Get(\"SCHOOL_INTERRUPT\", \"SHADOW\") == 0\n                            )\n                        )\n            ]] },\n    },\n}\nA.Data.ProfileUI[2]                                = {\n    {\n        {    \n            E = \"Header\",\n            L = { \n                enUS = \"--- Rotation ---\", \n            }, \n            S = 14,\n        },\n    },                    \n    {    -- FeignDeathHP slider                        \n        {\n            E = \"Slider\",                                                     \n            MIN = -1, \n            MAX = 100,                            \n            DB = \"FeignDeathHP\",\n            DBV = 20, -- Set default healthpercentage @20% life. \n            ONOFF = true,\n            L = { \n                ANY = \"Feign Death  HP (%)\", -- Feign Deaht spell id\n            }, \n            M = {},\n        },\n        -- Mend Pet\n        {\n            E = \"Slider\",                                                     \n            MIN = -1, \n            MAX = 100,                            \n            DB = \"MendPetHP\",\n            DBV = 20, -- Set default healthpercentage @20% life. \n            ONOFF = true,\n            L = { \n                ANY = \"Mend Pet HP (%)\", -- MendPet spell id\n            }, \n            M = {},\n        },\n    },\n    {\n        -- A Checkbox\n        {\n            E = \"Checkbox\", \n            DB = \"Shiv\",\n            DBV = false,\n            L = { \n                enUS = \"Enable Shiv\", \n                ruRU = \"?????????????? ?????\", \n            }, \n            TT = { \n                enUS = \"Enable to use\", \n                ruRU = \"???????? ??? ?????????????\", \n            }, \n            M = {},\n        },\n    },    \n}\n\n\n\n-----------------------------------------\n--                   PvP  \n-----------------------------------------\n\nfunction A.Main_CastBars(unit, list)\n    if not A.IsInitialized or A.IamHealer or (A.Zone ~= \"arena\" and A.Zone ~= \"pvp\") then \n        return false \n    end \n    \n    -- if A[A.PlayerSpec] and A[A.PlayerSpec].SpearHandStrike and A[A.PlayerSpec].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerSpec].SpearHandStrike:AbsentImun(unit, {\"KickImun\", \"TotalImun\", \"DamagePhysImun\"}, true) and A.InterruptIsValid(unit, list) then \n    --     return true         \n    -- end \nend \n\nfunction A.Second_CastBars(unit)\n    if not A.IsInitialized or (A.Zone ~= \"arena\" and A.Zone ~= \"pvp\") then \n        return false \n    end \n    \n    --local Toggle = A.GetToggle(2, \"ParalysisPvP\")    \n    --if Toggle and Toggle ~= \"OFF\" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {\"CCTotalImun\", \"TotalImun\", \"DamagePhysImun\"}, true) and Unit(unit):IsControlAble(\"incapacitate\", 0) then \n    --   if Toggle == \"BOTH\" then \n    --       return select(2, A.InterruptIsValid(unit, \"Heal\", true)) or select(2, A.InterruptIsValid(unit, \"PvP\", true)) \n    --    else\n    --        return select(2, A.InterruptIsValid(unit, Toggle, true))         \n    --    end \n    --end \nend \n\n",
				}, -- [2]
				["n"] = 2,
			},
			["Version"] = 87101,
			["Groups"] = {
				{
					["TimerBar_MiddleColor"] = "ff000000",
					["Scale"] = 0.600000023841858,
					["TimerBar_CompleteColor"] = "ff000000",
					["TimerBar_StartColor"] = "ff000000",
					["Locked"] = true,
					["GUID"] = "TMW:group:1Rhh0xLqd4g8",
					["Columns"] = 8,
					["Name"] = "Shown Main",
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0KeNg=IDQd", -- [1]
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0KeNh2uwMT", -- [1]
							},
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0Kg0ZzHksM", -- [1]
							},
							["GUID"] = "TMW:icon:1T0MjrGnynSL",
							["Enabled"] = true,
						}, -- [3]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0Kg0a1tFci", -- [1]
							},
							["GUID"] = "TMW:icon:1T0NdouSxYDb",
							["Enabled"] = true,
						}, -- [4]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0Kg0a6eYf9", -- [1]
							},
							["Enabled"] = true,
						}, -- [5]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0Kg0aBPYen", -- [1]
							},
							["Enabled"] = true,
						}, -- [6]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0Kg0aG1oeM", -- [1]
							},
							["Enabled"] = true,
						}, -- [7]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0Kg0aKbPUI", -- [1]
							},
							["Enabled"] = true,
						}, -- [8]
						{
							["ShowTimerText"] = true,
						}, -- [9]
						{
							["ShowTimerText"] = true,
						}, -- [10]
						{
							["ShowTimerText"] = true,
						}, -- [11]
						{
							["ShowTimerText"] = true,
						}, -- [12]
						{
							["ShowTimerText"] = true,
						}, -- [13]
						{
							["ShowTimerText"] = true,
						}, -- [14]
						{
							["ShowTimerText"] = true,
						}, -- [15]
						{
							["ShowTimerText"] = true,
						}, -- [16]
						{
							["ShowTimerText"] = true,
						}, -- [17]
						{
							["ShowTimerText"] = true,
						}, -- [18]
						{
							["ShowTimerText"] = true,
						}, -- [19]
						{
							["ShowTimerText"] = true,
						}, -- [20]
						{
							["ShowTimerText"] = true,
						}, -- [21]
						{
							["ShowTimerText"] = true,
						}, -- [22]
						{
							["ShowTimerText"] = true,
						}, -- [23]
						{
							["ShowTimerText"] = true,
						}, -- [24]
						{
							["ShowTimerText"] = true,
						}, -- [25]
						{
							["ShowTimerText"] = true,
						}, -- [26]
						{
							["ShowTimerText"] = true,
						}, -- [27]
						{
							["ShowTimerText"] = true,
						}, -- [28]
						{
							["ShowTimerText"] = true,
						}, -- [29]
						{
							["ShowTimerText"] = true,
						}, -- [30]
						{
							["ShowTimerText"] = true,
						}, -- [31]
						{
							["ShowTimerText"] = true,
						}, -- [32]
						{
							["ShowTimerText"] = true,
						}, -- [33]
						{
							["ShowTimerText"] = true,
						}, -- [34]
						{
							["ShowTimerText"] = true,
						}, -- [35]
						{
							["ShowTimerText"] = true,
						}, -- [36]
						{
							["ShowTimerText"] = true,
						}, -- [37]
						{
							["ShowTimerText"] = true,
						}, -- [38]
						{
							["ShowTimerText"] = true,
						}, -- [39]
						{
							["ShowTimerText"] = true,
						}, -- [40]
						{
							["ShowTimerText"] = true,
						}, -- [41]
						{
							["ShowTimerText"] = true,
						}, -- [42]
						{
							["ShowTimerText"] = true,
						}, -- [43]
						{
							["ShowTimerText"] = true,
						}, -- [44]
						{
							["ShowTimerText"] = true,
						}, -- [45]
						{
							["ShowTimerText"] = true,
						}, -- [46]
						{
							["ShowTimerText"] = true,
						}, -- [47]
						{
							["ShowTimerText"] = true,
						}, -- [48]
						{
							["ShowTimerText"] = true,
						}, -- [49]
						{
							["ShowTimerText"] = true,
						}, -- [50]
						{
							["ShowTimerText"] = true,
						}, -- [51]
						{
							["ShowTimerText"] = true,
						}, -- [52]
						{
							["ShowTimerText"] = true,
						}, -- [53]
						{
							["ShowTimerText"] = true,
						}, -- [54]
						{
							["ShowTimerText"] = true,
						}, -- [55]
						{
							["ShowTimerText"] = true,
						}, -- [56]
						{
							["ShowTimerText"] = true,
						}, -- [57]
						{
							["ShowTimerText"] = true,
						}, -- [58]
						{
							["ShowTimerText"] = true,
						}, -- [59]
						{
							["ShowTimerText"] = true,
						}, -- [60]
						{
							["ShowTimerText"] = true,
						}, -- [61]
						{
							["ShowTimerText"] = true,
						}, -- [62]
						{
							["ShowTimerText"] = true,
						}, -- [63]
						{
							["ShowTimerText"] = true,
						}, -- [64]
						{
							["ShowTimerText"] = true,
						}, -- [65]
						{
							["ShowTimerText"] = true,
						}, -- [66]
						{
							["ShowTimerText"] = true,
						}, -- [67]
						{
							["ShowTimerText"] = true,
						}, -- [68]
						{
							["ShowTimerText"] = true,
						}, -- [69]
						{
							["ShowTimerText"] = true,
						}, -- [70]
						{
							["ShowTimerText"] = true,
						}, -- [71]
						{
							["ShowTimerText"] = true,
						}, -- [72]
						{
							["ShowTimerText"] = true,
						}, -- [73]
						{
							["ShowTimerText"] = true,
						}, -- [74]
						{
							["ShowTimerText"] = true,
						}, -- [75]
						{
							["ShowTimerText"] = true,
						}, -- [76]
						{
							["ShowTimerText"] = true,
						}, -- [77]
						{
							["ShowTimerText"] = true,
						}, -- [78]
						{
							["ShowTimerText"] = true,
						}, -- [79]
						{
							["ShowTimerText"] = true,
						}, -- [80]
						{
							["ShowTimerText"] = true,
						}, -- [81]
						{
							["ShowTimerText"] = true,
						}, -- [82]
						{
							["ShowTimerText"] = true,
						}, -- [83]
						{
							["ShowTimerText"] = true,
						}, -- [84]
						{
							["ShowTimerText"] = true,
						}, -- [85]
						{
							["ShowTimerText"] = true,
						}, -- [86]
						{
							["ShowTimerText"] = true,
						}, -- [87]
						{
							["ShowTimerText"] = true,
						}, -- [88]
						{
							["ShowTimerText"] = true,
						}, -- [89]
						{
							["ShowTimerText"] = true,
						}, -- [90]
						{
							["ShowTimerText"] = true,
						}, -- [91]
						{
							["ShowTimerText"] = true,
						}, -- [92]
						{
							["ShowTimerText"] = true,
						}, -- [93]
						{
							["ShowTimerText"] = true,
						}, -- [94]
						{
							["ShowTimerText"] = true,
						}, -- [95]
						{
							["ShowTimerText"] = true,
						}, -- [96]
						{
							["ShowTimerText"] = true,
						}, -- [97]
						{
							["ShowTimerText"] = true,
						}, -- [98]
						{
							["ShowTimerText"] = true,
						}, -- [99]
						{
							["ShowTimerText"] = true,
						}, -- [100]
						{
							["ShowTimerText"] = true,
						}, -- [101]
						{
							["ShowTimerText"] = true,
						}, -- [102]
						{
							["ShowTimerText"] = true,
						}, -- [103]
						{
							["ShowTimerText"] = true,
						}, -- [104]
						{
							["ShowTimerText"] = true,
						}, -- [105]
						{
							["ShowTimerText"] = true,
						}, -- [106]
						{
							["ShowTimerText"] = true,
						}, -- [107]
						{
							["ShowTimerText"] = true,
						}, -- [108]
						{
							["ShowTimerText"] = true,
						}, -- [109]
						{
							["ShowTimerText"] = true,
						}, -- [110]
						{
							["ShowTimerText"] = true,
						}, -- [111]
						{
							["ShowTimerText"] = true,
						}, -- [112]
						{
							["ShowTimerText"] = true,
						}, -- [113]
						{
							["ShowTimerText"] = true,
						}, -- [114]
						{
							["ShowTimerText"] = true,
						}, -- [115]
						{
							["ShowTimerText"] = true,
						}, -- [116]
						{
							["ShowTimerText"] = true,
						}, -- [117]
						{
							["ShowTimerText"] = true,
						}, -- [118]
						{
							["ShowTimerText"] = true,
						}, -- [119]
						{
							["ShowTimerText"] = true,
						}, -- [120]
					},
					["Point"] = {
						["y"] = 12,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
						["x"] = -29,
					},
				}, -- [1]
				{
					["View"] = "bar",
					["TimerBar_MiddleColor"] = "ff00ff00",
					["Scale"] = 0.25,
					["Rows"] = 2,
					["TextureName"] = "Flat",
					["TimerBar_StartColor"] = "ff00ff00",
					["Locked"] = true,
					["GUID"] = "TMW:group:1Rhh36arfTf9",
					["Columns"] = 3,
					["BackdropColor_Enable"] = true,
					["Name"] = "Shown Cast Bars",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 420.333292643229,
						},
					},
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TU4r3gTq44v", -- [1]
								"TMW:icon:1TU4r3gT=Wq3", -- [2]
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TU4r3gTvDmY", -- [1]
								"TMW:icon:1TU4r3gU1EG0", -- [2]
							},
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1TU4r3gTxbKc", -- [1]
								"TMW:icon:1TU4r3gU3zGQ", -- [2]
							},
							["Enabled"] = true,
						}, -- [3]
						{
							["Unit"] = "arena1",
							["Type"] = "meta",
							["TimerBar_StartColor"] = "ff00ff00",
							["Icons"] = {
								"TMW:icon:1Rhh2tW=TZ4A", -- [1]
								"TMW:icon:1Rhh2tW=dzl2", -- [2]
							},
							["ShowTimerText"] = true,
							["TimerBar_EnableColors"] = true,
							["BackdropColor"] = "ffff0000",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
						}, -- [4]
						{
							["Unit"] = "arena2",
							["Type"] = "meta",
							["TimerBar_StartColor"] = "ff00ff00",
							["Icons"] = {
								"TMW:icon:1T1fyEs_KnQR", -- [1]
								"TMW:icon:1T1fyloYtkcH", -- [2]
							},
							["ShowTimerText"] = true,
							["TimerBar_EnableColors"] = true,
							["BackdropColor"] = "ffff0000",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
						}, -- [5]
						{
							["Unit"] = "arena3",
							["Type"] = "meta",
							["TimerBar_StartColor"] = "ff00ff00",
							["Icons"] = {
								"TMW:icon:1T1fyLZpCvXj", -- [1]
								"TMW:icon:1T1fymGiIBW=", -- [2]
							},
							["ShowTimerText"] = true,
							["TimerBar_EnableColors"] = true,
							["BackdropColor"] = "ffff0000",
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
						}, -- [6]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1P49HQSuJ84i", -- [1]
							},
							["ShowTimerText"] = true,
							["BackdropColor"] = "ff00ff00",
							["Enabled"] = true,
						}, -- [7]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1P49ADlOY9KP", -- [1]
							},
							["ShowTimerText"] = true,
							["BackdropColor"] = "ff00ff00",
							["Enabled"] = true,
						}, -- [8]
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1P49ADlT6NRd", -- [1]
							},
							["ShowTimerText"] = true,
							["BackdropColor"] = "ff00ff00",
							["Enabled"] = true,
						}, -- [9]
						{
							["ShowTimerText"] = true,
						}, -- [10]
						{
							["ShowTimerText"] = true,
						}, -- [11]
						{
							["ShowTimerText"] = true,
						}, -- [12]
						{
							["ShowTimerText"] = true,
						}, -- [13]
						{
							["ShowTimerText"] = true,
						}, -- [14]
						{
							["ShowTimerText"] = true,
						}, -- [15]
						{
							["ShowTimerText"] = true,
						}, -- [16]
						{
							["ShowTimerText"] = true,
						}, -- [17]
						{
							["ShowTimerText"] = true,
						}, -- [18]
						{
							["ShowTimerText"] = true,
						}, -- [19]
						{
							["ShowTimerText"] = true,
						}, -- [20]
						{
							["ShowTimerText"] = true,
						}, -- [21]
						{
							["ShowTimerText"] = true,
						}, -- [22]
						{
							["ShowTimerText"] = true,
						}, -- [23]
						{
							["ShowTimerText"] = true,
						}, -- [24]
						{
							["ShowTimerText"] = true,
						}, -- [25]
						{
							["ShowTimerText"] = true,
						}, -- [26]
						{
							["ShowTimerText"] = true,
						}, -- [27]
						{
							["ShowTimerText"] = true,
						}, -- [28]
						{
							["ShowTimerText"] = true,
						}, -- [29]
						{
							["ShowTimerText"] = true,
						}, -- [30]
						{
							["ShowTimerText"] = true,
						}, -- [31]
						{
							["ShowTimerText"] = true,
						}, -- [32]
						{
							["ShowTimerText"] = true,
						}, -- [33]
						{
							["ShowTimerText"] = true,
						}, -- [34]
						{
							["ShowTimerText"] = true,
						}, -- [35]
						{
							["ShowTimerText"] = true,
						}, -- [36]
						{
							["ShowTimerText"] = true,
						}, -- [37]
						{
							["ShowTimerText"] = true,
						}, -- [38]
						{
							["ShowTimerText"] = true,
						}, -- [39]
						{
							["ShowTimerText"] = true,
						}, -- [40]
						{
							["ShowTimerText"] = true,
						}, -- [41]
						{
							["ShowTimerText"] = true,
						}, -- [42]
						{
							["ShowTimerText"] = true,
						}, -- [43]
						{
							["ShowTimerText"] = true,
						}, -- [44]
						{
							["ShowTimerText"] = true,
						}, -- [45]
						{
							["ShowTimerText"] = true,
						}, -- [46]
						{
							["ShowTimerText"] = true,
						}, -- [47]
						{
							["ShowTimerText"] = true,
						}, -- [48]
						{
							["ShowTimerText"] = true,
						}, -- [49]
						{
							["ShowTimerText"] = true,
						}, -- [50]
						{
							["ShowTimerText"] = true,
						}, -- [51]
						{
							["ShowTimerText"] = true,
						}, -- [52]
						{
							["ShowTimerText"] = true,
						}, -- [53]
						{
							["ShowTimerText"] = true,
						}, -- [54]
						{
							["ShowTimerText"] = true,
						}, -- [55]
						{
							["ShowTimerText"] = true,
						}, -- [56]
						{
							["ShowTimerText"] = true,
						}, -- [57]
						{
							["ShowTimerText"] = true,
						}, -- [58]
						{
							["ShowTimerText"] = true,
						}, -- [59]
						{
							["ShowTimerText"] = true,
						}, -- [60]
						{
							["ShowTimerText"] = true,
						}, -- [61]
						{
							["ShowTimerText"] = true,
						}, -- [62]
						{
							["ShowTimerText"] = true,
						}, -- [63]
						{
							["ShowTimerText"] = true,
						}, -- [64]
						{
							["ShowTimerText"] = true,
						}, -- [65]
						{
							["ShowTimerText"] = true,
						}, -- [66]
						{
							["ShowTimerText"] = true,
						}, -- [67]
						{
							["ShowTimerText"] = true,
						}, -- [68]
						{
							["ShowTimerText"] = true,
						}, -- [69]
						{
							["ShowTimerText"] = true,
						}, -- [70]
						{
							["ShowTimerText"] = true,
						}, -- [71]
						{
							["ShowTimerText"] = true,
						}, -- [72]
						{
							["ShowTimerText"] = true,
						}, -- [73]
						{
							["ShowTimerText"] = true,
						}, -- [74]
						{
							["ShowTimerText"] = true,
						}, -- [75]
						{
							["ShowTimerText"] = true,
						}, -- [76]
						{
							["ShowTimerText"] = true,
						}, -- [77]
						{
							["ShowTimerText"] = true,
						}, -- [78]
						{
							["ShowTimerText"] = true,
						}, -- [79]
						{
							["ShowTimerText"] = true,
						}, -- [80]
						{
							["ShowTimerText"] = true,
						}, -- [81]
						{
							["ShowTimerText"] = true,
						}, -- [82]
						{
							["ShowTimerText"] = true,
						}, -- [83]
						{
							["ShowTimerText"] = true,
						}, -- [84]
						{
							["ShowTimerText"] = true,
						}, -- [85]
						{
							["ShowTimerText"] = true,
						}, -- [86]
						{
							["ShowTimerText"] = true,
						}, -- [87]
						{
							["ShowTimerText"] = true,
						}, -- [88]
						{
							["ShowTimerText"] = true,
						}, -- [89]
						{
							["ShowTimerText"] = true,
						}, -- [90]
						{
							["ShowTimerText"] = true,
						}, -- [91]
						{
							["ShowTimerText"] = true,
						}, -- [92]
						{
							["ShowTimerText"] = true,
						}, -- [93]
						{
							["ShowTimerText"] = true,
						}, -- [94]
						{
							["ShowTimerText"] = true,
						}, -- [95]
						{
							["ShowTimerText"] = true,
						}, -- [96]
						{
							["ShowTimerText"] = true,
						}, -- [97]
						{
							["ShowTimerText"] = true,
						}, -- [98]
						{
							["ShowTimerText"] = true,
						}, -- [99]
						{
							["ShowTimerText"] = true,
						}, -- [100]
						{
							["ShowTimerText"] = true,
						}, -- [101]
						{
							["ShowTimerText"] = true,
						}, -- [102]
						{
							["ShowTimerText"] = true,
						}, -- [103]
						{
							["ShowTimerText"] = true,
						}, -- [104]
						{
							["ShowTimerText"] = true,
						}, -- [105]
						{
							["ShowTimerText"] = true,
						}, -- [106]
						{
							["ShowTimerText"] = true,
						}, -- [107]
						{
							["ShowTimerText"] = true,
						}, -- [108]
						{
							["ShowTimerText"] = true,
						}, -- [109]
						{
							["ShowTimerText"] = true,
						}, -- [110]
						{
							["ShowTimerText"] = true,
						}, -- [111]
						{
							["ShowTimerText"] = true,
						}, -- [112]
						{
							["ShowTimerText"] = true,
						}, -- [113]
						{
							["ShowTimerText"] = true,
						}, -- [114]
						{
							["ShowTimerText"] = true,
						}, -- [115]
						{
							["ShowTimerText"] = true,
						}, -- [116]
						{
							["ShowTimerText"] = true,
						}, -- [117]
						{
							["ShowTimerText"] = true,
						}, -- [118]
						{
							["ShowTimerText"] = true,
						}, -- [119]
						{
							["ShowTimerText"] = true,
						}, -- [120]
						{
							["ShowTimerText"] = true,
						}, -- [121]
						{
							["ShowTimerText"] = true,
						}, -- [122]
						{
							["ShowTimerText"] = true,
						}, -- [123]
						{
							["ShowTimerText"] = true,
						}, -- [124]
						{
							["ShowTimerText"] = true,
						}, -- [125]
						{
							["ShowTimerText"] = true,
						}, -- [126]
						{
							["ShowTimerText"] = true,
						}, -- [127]
						{
							["ShowTimerText"] = true,
						}, -- [128]
						{
							["ShowTimerText"] = true,
						}, -- [129]
						{
							["ShowTimerText"] = true,
						}, -- [130]
						{
							["ShowTimerText"] = true,
						}, -- [131]
						{
							["ShowTimerText"] = true,
						}, -- [132]
						{
							["ShowTimerText"] = true,
						}, -- [133]
						{
							["ShowTimerText"] = true,
						}, -- [134]
						{
							["ShowTimerText"] = true,
						}, -- [135]
						{
							["ShowTimerText"] = true,
						}, -- [136]
						{
							["ShowTimerText"] = true,
						}, -- [137]
						{
							["ShowTimerText"] = true,
						}, -- [138]
						{
							["ShowTimerText"] = true,
						}, -- [139]
						{
							["ShowTimerText"] = true,
						}, -- [140]
						{
							["ShowTimerText"] = true,
						}, -- [141]
						{
							["ShowTimerText"] = true,
						}, -- [142]
						{
							["ShowTimerText"] = true,
						}, -- [143]
						{
							["ShowTimerText"] = true,
						}, -- [144]
						{
							["ShowTimerText"] = true,
						}, -- [145]
						{
							["ShowTimerText"] = true,
						}, -- [146]
						{
							["ShowTimerText"] = true,
						}, -- [147]
						{
							["ShowTimerText"] = true,
						}, -- [148]
						{
							["ShowTimerText"] = true,
						}, -- [149]
						{
							["ShowTimerText"] = true,
						}, -- [150]
						{
							["ShowTimerText"] = true,
						}, -- [151]
						{
							["ShowTimerText"] = true,
						}, -- [152]
						{
							["ShowTimerText"] = true,
						}, -- [153]
						{
							["ShowTimerText"] = true,
						}, -- [154]
						{
							["ShowTimerText"] = true,
						}, -- [155]
						{
							["ShowTimerText"] = true,
						}, -- [156]
						{
							["ShowTimerText"] = true,
						}, -- [157]
						{
							["ShowTimerText"] = true,
						}, -- [158]
						{
							["ShowTimerText"] = true,
						}, -- [159]
						{
							["ShowTimerText"] = true,
						}, -- [160]
						{
							["ShowTimerText"] = true,
						}, -- [161]
						{
							["ShowTimerText"] = true,
						}, -- [162]
						{
							["ShowTimerText"] = true,
						}, -- [163]
						{
							["ShowTimerText"] = true,
						}, -- [164]
						{
							["ShowTimerText"] = true,
						}, -- [165]
						{
							["ShowTimerText"] = true,
						}, -- [166]
						{
							["ShowTimerText"] = true,
						}, -- [167]
						{
							["ShowTimerText"] = true,
						}, -- [168]
						{
							["ShowTimerText"] = true,
						}, -- [169]
						{
							["ShowTimerText"] = true,
						}, -- [170]
						{
							["ShowTimerText"] = true,
						}, -- [171]
						{
							["ShowTimerText"] = true,
						}, -- [172]
						{
							["ShowTimerText"] = true,
						}, -- [173]
						{
							["ShowTimerText"] = true,
						}, -- [174]
						{
							["ShowTimerText"] = true,
						}, -- [175]
						{
							["ShowTimerText"] = true,
						}, -- [176]
						{
							["ShowTimerText"] = true,
						}, -- [177]
						{
							["ShowTimerText"] = true,
						}, -- [178]
						{
							["ShowTimerText"] = true,
						}, -- [179]
						{
							["ShowTimerText"] = true,
						}, -- [180]
						{
							["ShowTimerText"] = true,
						}, -- [181]
						{
							["ShowTimerText"] = true,
						}, -- [182]
						{
							["ShowTimerText"] = true,
						}, -- [183]
						{
							["ShowTimerText"] = true,
						}, -- [184]
						{
							["ShowTimerText"] = true,
						}, -- [185]
						{
							["ShowTimerText"] = true,
						}, -- [186]
						{
							["ShowTimerText"] = true,
						}, -- [187]
						{
							["ShowTimerText"] = true,
						}, -- [188]
						{
							["ShowTimerText"] = true,
						}, -- [189]
						{
							["ShowTimerText"] = true,
						}, -- [190]
						{
							["ShowTimerText"] = true,
						}, -- [191]
						{
							["ShowTimerText"] = true,
						}, -- [192]
						{
							["ShowTimerText"] = true,
						}, -- [193]
						{
							["ShowTimerText"] = true,
						}, -- [194]
						{
							["ShowTimerText"] = true,
						}, -- [195]
						{
							["ShowTimerText"] = true,
						}, -- [196]
						{
							["ShowTimerText"] = true,
						}, -- [197]
						{
							["ShowTimerText"] = true,
						}, -- [198]
						{
							["ShowTimerText"] = true,
						}, -- [199]
						{
							["ShowTimerText"] = true,
						}, -- [200]
						{
							["ShowTimerText"] = true,
						}, -- [201]
						{
							["ShowTimerText"] = true,
						}, -- [202]
						{
							["ShowTimerText"] = true,
						}, -- [203]
						{
							["ShowTimerText"] = true,
						}, -- [204]
						{
							["ShowTimerText"] = true,
						}, -- [205]
						{
							["ShowTimerText"] = true,
						}, -- [206]
						{
							["ShowTimerText"] = true,
						}, -- [207]
						{
							["ShowTimerText"] = true,
						}, -- [208]
						{
							["ShowTimerText"] = true,
						}, -- [209]
						{
							["ShowTimerText"] = true,
						}, -- [210]
						{
							["ShowTimerText"] = true,
						}, -- [211]
						{
							["ShowTimerText"] = true,
						}, -- [212]
						{
							["ShowTimerText"] = true,
						}, -- [213]
						{
							["ShowTimerText"] = true,
						}, -- [214]
						{
							["ShowTimerText"] = true,
						}, -- [215]
						{
							["ShowTimerText"] = true,
						}, -- [216]
						{
							["ShowTimerText"] = true,
						}, -- [217]
						{
							["ShowTimerText"] = true,
						}, -- [218]
						{
							["ShowTimerText"] = true,
						}, -- [219]
						{
							["ShowTimerText"] = true,
						}, -- [220]
						{
							["ShowTimerText"] = true,
						}, -- [221]
						{
							["ShowTimerText"] = true,
						}, -- [222]
						{
							["ShowTimerText"] = true,
						}, -- [223]
						{
							["ShowTimerText"] = true,
						}, -- [224]
						{
							["ShowTimerText"] = true,
						}, -- [225]
						{
							["ShowTimerText"] = true,
						}, -- [226]
						{
							["ShowTimerText"] = true,
						}, -- [227]
						{
							["ShowTimerText"] = true,
						}, -- [228]
						{
							["ShowTimerText"] = true,
						}, -- [229]
						{
							["ShowTimerText"] = true,
						}, -- [230]
						{
							["ShowTimerText"] = true,
						}, -- [231]
						{
							["ShowTimerText"] = true,
						}, -- [232]
						{
							["ShowTimerText"] = true,
						}, -- [233]
						{
							["ShowTimerText"] = true,
						}, -- [234]
						{
							["ShowTimerText"] = true,
						}, -- [235]
						{
							["ShowTimerText"] = true,
						}, -- [236]
						{
							["ShowTimerText"] = true,
						}, -- [237]
						{
							["ShowTimerText"] = true,
						}, -- [238]
						{
							["ShowTimerText"] = true,
						}, -- [239]
						{
							["ShowTimerText"] = true,
						}, -- [240]
						{
							["ShowTimerText"] = true,
						}, -- [241]
						{
							["ShowTimerText"] = true,
						}, -- [242]
						{
							["ShowTimerText"] = true,
						}, -- [243]
						{
							["ShowTimerText"] = true,
						}, -- [244]
						{
							["ShowTimerText"] = true,
						}, -- [245]
						{
							["ShowTimerText"] = true,
						}, -- [246]
						{
							["ShowTimerText"] = true,
						}, -- [247]
						{
							["ShowTimerText"] = true,
						}, -- [248]
						{
							["ShowTimerText"] = true,
						}, -- [249]
						{
							["ShowTimerText"] = true,
						}, -- [250]
						{
							["ShowTimerText"] = true,
						}, -- [251]
						{
							["ShowTimerText"] = true,
						}, -- [252]
						{
							["ShowTimerText"] = true,
						}, -- [253]
						{
							["ShowTimerText"] = true,
						}, -- [254]
						{
							["ShowTimerText"] = true,
						}, -- [255]
						{
							["ShowTimerText"] = true,
						}, -- [256]
						{
							["ShowTimerText"] = true,
						}, -- [257]
						{
							["ShowTimerText"] = true,
						}, -- [258]
						{
							["ShowTimerText"] = true,
						}, -- [259]
						{
							["ShowTimerText"] = true,
						}, -- [260]
						{
							["ShowTimerText"] = true,
						}, -- [261]
						{
							["ShowTimerText"] = true,
						}, -- [262]
						{
							["ShowTimerText"] = true,
						}, -- [263]
						{
							["ShowTimerText"] = true,
						}, -- [264]
						{
							["ShowTimerText"] = true,
						}, -- [265]
						{
							["ShowTimerText"] = true,
						}, -- [266]
						{
							["ShowTimerText"] = true,
						}, -- [267]
						{
							["ShowTimerText"] = true,
						}, -- [268]
						{
							["ShowTimerText"] = true,
						}, -- [269]
						{
							["ShowTimerText"] = true,
						}, -- [270]
						{
							["ShowTimerText"] = true,
						}, -- [271]
						{
							["ShowTimerText"] = true,
						}, -- [272]
						{
							["ShowTimerText"] = true,
						}, -- [273]
						{
							["ShowTimerText"] = true,
						}, -- [274]
						{
							["ShowTimerText"] = true,
						}, -- [275]
						{
							["ShowTimerText"] = true,
						}, -- [276]
						{
							["ShowTimerText"] = true,
						}, -- [277]
						{
							["ShowTimerText"] = true,
						}, -- [278]
						{
							["ShowTimerText"] = true,
						}, -- [279]
						{
							["ShowTimerText"] = true,
						}, -- [280]
						{
							["ShowTimerText"] = true,
						}, -- [281]
						{
							["ShowTimerText"] = true,
						}, -- [282]
						{
							["ShowTimerText"] = true,
						}, -- [283]
						{
							["ShowTimerText"] = true,
						}, -- [284]
						{
							["ShowTimerText"] = true,
						}, -- [285]
						{
							["ShowTimerText"] = true,
						}, -- [286]
						{
							["ShowTimerText"] = true,
						}, -- [287]
						{
							["ShowTimerText"] = true,
						}, -- [288]
						{
							["ShowTimerText"] = true,
						}, -- [289]
						{
							["ShowTimerText"] = true,
						}, -- [290]
						{
							["ShowTimerText"] = true,
						}, -- [291]
						{
							["ShowTimerText"] = true,
						}, -- [292]
						{
							["ShowTimerText"] = true,
						}, -- [293]
						{
							["ShowTimerText"] = true,
						}, -- [294]
						{
							["ShowTimerText"] = true,
						}, -- [295]
						{
							["ShowTimerText"] = true,
						}, -- [296]
						{
							["ShowTimerText"] = true,
						}, -- [297]
						{
							["ShowTimerText"] = true,
						}, -- [298]
						{
							["ShowTimerText"] = true,
						}, -- [299]
						{
							["ShowTimerText"] = true,
						}, -- [300]
						{
							["ShowTimerText"] = true,
						}, -- [301]
						{
							["ShowTimerText"] = true,
						}, -- [302]
						{
							["ShowTimerText"] = true,
						}, -- [303]
						{
							["ShowTimerText"] = true,
						}, -- [304]
						{
							["ShowTimerText"] = true,
						}, -- [305]
						{
							["ShowTimerText"] = true,
						}, -- [306]
						{
							["ShowTimerText"] = true,
						}, -- [307]
						{
							["ShowTimerText"] = true,
						}, -- [308]
						{
							["ShowTimerText"] = true,
						}, -- [309]
						{
							["ShowTimerText"] = true,
						}, -- [310]
						{
							["ShowTimerText"] = true,
						}, -- [311]
						{
							["ShowTimerText"] = true,
						}, -- [312]
						{
							["ShowTimerText"] = true,
						}, -- [313]
						{
							["ShowTimerText"] = true,
						}, -- [314]
						{
							["ShowTimerText"] = true,
						}, -- [315]
						{
							["ShowTimerText"] = true,
						}, -- [316]
						{
							["ShowTimerText"] = true,
						}, -- [317]
						{
							["ShowTimerText"] = true,
						}, -- [318]
						{
							["ShowTimerText"] = true,
						}, -- [319]
						{
							["ShowTimerText"] = true,
						}, -- [320]
					},
					["Point"] = {
						["y"] = 17.0009765625,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
						["x"] = 507.000061035156,
					},
					["TimerBar_EnableColors"] = true,
				}, -- [2]
				{
					["View"] = "bar",
					["Rows"] = 2,
					["TextureName"] = "Flat",
					["Locked"] = true,
					["GUID"] = "TMW:group:1Rhh2tX4EUTk",
					["Columns"] = 3,
					["Name"] = "Hidden Cast Bars Config Pet",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 20.3040440877279,
							["BorderColor"] = "00000000",
						},
					},
					["Icons"] = {
						{
							["Unit"] = "arena1",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ff00ff00",
							["FakeHidden"] = true,
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"Heal\", true)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1Rhh2tW=TZ4A",
							["CustomTex"] = "16561",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
						{
							["Unit"] = "arena2",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ff00ff00",
							["FakeHidden"] = true,
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"Heal\", true)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1T1fyEs_KnQR",
							["CustomTex"] = "16561",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [2]
						{
							["Unit"] = "arena3",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ff00ff00",
							["FakeHidden"] = true,
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"Heal\", true)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1T1fyLZpCvXj",
							["CustomTex"] = "16561",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [3]
						{
							["Unit"] = "arena1",
							["Type"] = "TheAction - UnitCasting",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffff0000",
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"PvP\", true)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1Rhh2tW=dzl2",
							["CustomTex"] = "5199",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ffff0000",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [4]
						{
							["Unit"] = "arena2",
							["Type"] = "TheAction - UnitCasting",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffff0000",
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"PvP\", true)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1T1fyloYtkcH",
							["CustomTex"] = "5199",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ffff0000",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [5]
						{
							["Unit"] = "arena3",
							["Type"] = "TheAction - UnitCasting",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffff0000",
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"PvP\", true)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1T1fymGiIBW=",
							["CustomTex"] = "5199",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ffff0000",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [6]
						nil, -- [7]
						nil, -- [8]
						nil, -- [9]
						{
							["ShowTimerText"] = true,
						}, -- [10]
						{
							["ShowTimerText"] = true,
						}, -- [11]
						{
							["ShowTimerText"] = true,
						}, -- [12]
						{
							["ShowTimerText"] = true,
						}, -- [13]
						{
							["ShowTimerText"] = true,
						}, -- [14]
						{
							["ShowTimerText"] = true,
						}, -- [15]
						{
							["ShowTimerText"] = true,
						}, -- [16]
						{
							["ShowTimerText"] = true,
						}, -- [17]
						{
							["ShowTimerText"] = true,
						}, -- [18]
						{
							["ShowTimerText"] = true,
						}, -- [19]
						{
							["ShowTimerText"] = true,
						}, -- [20]
						{
							["ShowTimerText"] = true,
						}, -- [21]
						{
							["ShowTimerText"] = true,
						}, -- [22]
						{
							["ShowTimerText"] = true,
						}, -- [23]
						{
							["ShowTimerText"] = true,
						}, -- [24]
						{
							["ShowTimerText"] = true,
						}, -- [25]
						{
							["ShowTimerText"] = true,
						}, -- [26]
						{
							["ShowTimerText"] = true,
						}, -- [27]
						{
							["ShowTimerText"] = true,
						}, -- [28]
						{
							["ShowTimerText"] = true,
						}, -- [29]
						{
							["ShowTimerText"] = true,
						}, -- [30]
						{
							["ShowTimerText"] = true,
						}, -- [31]
						{
							["ShowTimerText"] = true,
						}, -- [32]
						{
							["ShowTimerText"] = true,
						}, -- [33]
						{
							["ShowTimerText"] = true,
						}, -- [34]
						{
							["ShowTimerText"] = true,
						}, -- [35]
						{
							["ShowTimerText"] = true,
						}, -- [36]
						{
							["ShowTimerText"] = true,
						}, -- [37]
						{
							["ShowTimerText"] = true,
						}, -- [38]
						{
							["ShowTimerText"] = true,
						}, -- [39]
						{
							["ShowTimerText"] = true,
						}, -- [40]
						{
							["ShowTimerText"] = true,
						}, -- [41]
						{
							["ShowTimerText"] = true,
						}, -- [42]
						{
							["ShowTimerText"] = true,
						}, -- [43]
						{
							["ShowTimerText"] = true,
						}, -- [44]
						{
							["ShowTimerText"] = true,
						}, -- [45]
						{
							["ShowTimerText"] = true,
						}, -- [46]
						{
							["ShowTimerText"] = true,
						}, -- [47]
						{
							["ShowTimerText"] = true,
						}, -- [48]
						{
							["ShowTimerText"] = true,
						}, -- [49]
						{
							["ShowTimerText"] = true,
						}, -- [50]
						{
							["ShowTimerText"] = true,
						}, -- [51]
						{
							["ShowTimerText"] = true,
						}, -- [52]
						{
							["ShowTimerText"] = true,
						}, -- [53]
						{
							["ShowTimerText"] = true,
						}, -- [54]
						{
							["ShowTimerText"] = true,
						}, -- [55]
						{
							["ShowTimerText"] = true,
						}, -- [56]
						{
							["ShowTimerText"] = true,
						}, -- [57]
						{
							["ShowTimerText"] = true,
						}, -- [58]
						{
							["ShowTimerText"] = true,
						}, -- [59]
						{
							["ShowTimerText"] = true,
						}, -- [60]
						{
							["ShowTimerText"] = true,
						}, -- [61]
						{
							["ShowTimerText"] = true,
						}, -- [62]
						{
							["ShowTimerText"] = true,
						}, -- [63]
						{
							["ShowTimerText"] = true,
						}, -- [64]
						{
							["ShowTimerText"] = true,
						}, -- [65]
						{
							["ShowTimerText"] = true,
						}, -- [66]
						{
							["ShowTimerText"] = true,
						}, -- [67]
						{
							["ShowTimerText"] = true,
						}, -- [68]
						{
							["ShowTimerText"] = true,
						}, -- [69]
						{
							["ShowTimerText"] = true,
						}, -- [70]
						{
							["ShowTimerText"] = true,
						}, -- [71]
						{
							["ShowTimerText"] = true,
						}, -- [72]
						{
							["ShowTimerText"] = true,
						}, -- [73]
						{
							["ShowTimerText"] = true,
						}, -- [74]
						{
							["ShowTimerText"] = true,
						}, -- [75]
						{
							["ShowTimerText"] = true,
						}, -- [76]
						{
							["ShowTimerText"] = true,
						}, -- [77]
						{
							["ShowTimerText"] = true,
						}, -- [78]
						{
							["ShowTimerText"] = true,
						}, -- [79]
						{
							["ShowTimerText"] = true,
						}, -- [80]
						{
							["ShowTimerText"] = true,
						}, -- [81]
						{
							["ShowTimerText"] = true,
						}, -- [82]
						{
							["ShowTimerText"] = true,
						}, -- [83]
						{
							["ShowTimerText"] = true,
						}, -- [84]
						{
							["ShowTimerText"] = true,
						}, -- [85]
						{
							["ShowTimerText"] = true,
						}, -- [86]
						{
							["ShowTimerText"] = true,
						}, -- [87]
						{
							["ShowTimerText"] = true,
						}, -- [88]
						{
							["ShowTimerText"] = true,
						}, -- [89]
						{
							["ShowTimerText"] = true,
						}, -- [90]
						{
							["ShowTimerText"] = true,
						}, -- [91]
						{
							["ShowTimerText"] = true,
						}, -- [92]
						{
							["ShowTimerText"] = true,
						}, -- [93]
						{
							["ShowTimerText"] = true,
						}, -- [94]
						{
							["ShowTimerText"] = true,
						}, -- [95]
						{
							["ShowTimerText"] = true,
						}, -- [96]
						{
							["ShowTimerText"] = true,
						}, -- [97]
						{
							["ShowTimerText"] = true,
						}, -- [98]
						{
							["ShowTimerText"] = true,
						}, -- [99]
						{
							["ShowTimerText"] = true,
						}, -- [100]
						{
							["ShowTimerText"] = true,
						}, -- [101]
						{
							["ShowTimerText"] = true,
						}, -- [102]
						{
							["ShowTimerText"] = true,
						}, -- [103]
						{
							["ShowTimerText"] = true,
						}, -- [104]
						{
							["ShowTimerText"] = true,
						}, -- [105]
						{
							["ShowTimerText"] = true,
						}, -- [106]
						{
							["ShowTimerText"] = true,
						}, -- [107]
						{
							["ShowTimerText"] = true,
						}, -- [108]
						{
							["ShowTimerText"] = true,
						}, -- [109]
						{
							["ShowTimerText"] = true,
						}, -- [110]
						{
							["ShowTimerText"] = true,
						}, -- [111]
						{
							["ShowTimerText"] = true,
						}, -- [112]
						{
							["ShowTimerText"] = true,
						}, -- [113]
						{
							["ShowTimerText"] = true,
						}, -- [114]
						{
							["ShowTimerText"] = true,
						}, -- [115]
						{
							["ShowTimerText"] = true,
						}, -- [116]
						{
							["ShowTimerText"] = true,
						}, -- [117]
						{
							["ShowTimerText"] = true,
						}, -- [118]
						{
							["ShowTimerText"] = true,
						}, -- [119]
						{
							["ShowTimerText"] = true,
						}, -- [120]
						{
							["ShowTimerText"] = true,
						}, -- [121]
						{
							["ShowTimerText"] = true,
						}, -- [122]
						{
							["ShowTimerText"] = true,
						}, -- [123]
						{
							["ShowTimerText"] = true,
						}, -- [124]
						{
							["ShowTimerText"] = true,
						}, -- [125]
						{
							["ShowTimerText"] = true,
						}, -- [126]
						{
							["ShowTimerText"] = true,
						}, -- [127]
						{
							["ShowTimerText"] = true,
						}, -- [128]
						{
							["ShowTimerText"] = true,
						}, -- [129]
						{
							["ShowTimerText"] = true,
						}, -- [130]
						{
							["ShowTimerText"] = true,
						}, -- [131]
						{
							["ShowTimerText"] = true,
						}, -- [132]
						{
							["ShowTimerText"] = true,
						}, -- [133]
						{
							["ShowTimerText"] = true,
						}, -- [134]
						{
							["ShowTimerText"] = true,
						}, -- [135]
						{
							["ShowTimerText"] = true,
						}, -- [136]
						{
							["ShowTimerText"] = true,
						}, -- [137]
						{
							["ShowTimerText"] = true,
						}, -- [138]
						{
							["ShowTimerText"] = true,
						}, -- [139]
						{
							["ShowTimerText"] = true,
						}, -- [140]
						{
							["ShowTimerText"] = true,
						}, -- [141]
						{
							["ShowTimerText"] = true,
						}, -- [142]
						{
							["ShowTimerText"] = true,
						}, -- [143]
						{
							["ShowTimerText"] = true,
						}, -- [144]
						{
							["ShowTimerText"] = true,
						}, -- [145]
						{
							["ShowTimerText"] = true,
						}, -- [146]
						{
							["ShowTimerText"] = true,
						}, -- [147]
						{
							["ShowTimerText"] = true,
						}, -- [148]
						{
							["ShowTimerText"] = true,
						}, -- [149]
						{
							["ShowTimerText"] = true,
						}, -- [150]
						{
							["ShowTimerText"] = true,
						}, -- [151]
						{
							["ShowTimerText"] = true,
						}, -- [152]
						{
							["ShowTimerText"] = true,
						}, -- [153]
						{
							["ShowTimerText"] = true,
						}, -- [154]
						{
							["ShowTimerText"] = true,
						}, -- [155]
						{
							["ShowTimerText"] = true,
						}, -- [156]
						{
							["ShowTimerText"] = true,
						}, -- [157]
						{
							["ShowTimerText"] = true,
						}, -- [158]
						{
							["ShowTimerText"] = true,
						}, -- [159]
						{
							["ShowTimerText"] = true,
						}, -- [160]
						{
							["ShowTimerText"] = true,
						}, -- [161]
						{
							["ShowTimerText"] = true,
						}, -- [162]
						{
							["ShowTimerText"] = true,
						}, -- [163]
						{
							["ShowTimerText"] = true,
						}, -- [164]
						{
							["ShowTimerText"] = true,
						}, -- [165]
						{
							["ShowTimerText"] = true,
						}, -- [166]
						{
							["ShowTimerText"] = true,
						}, -- [167]
						{
							["ShowTimerText"] = true,
						}, -- [168]
						{
							["ShowTimerText"] = true,
						}, -- [169]
						{
							["ShowTimerText"] = true,
						}, -- [170]
						{
							["ShowTimerText"] = true,
						}, -- [171]
						{
							["ShowTimerText"] = true,
						}, -- [172]
						{
							["ShowTimerText"] = true,
						}, -- [173]
						{
							["ShowTimerText"] = true,
						}, -- [174]
						{
							["ShowTimerText"] = true,
						}, -- [175]
						{
							["ShowTimerText"] = true,
						}, -- [176]
						{
							["ShowTimerText"] = true,
						}, -- [177]
						{
							["ShowTimerText"] = true,
						}, -- [178]
						{
							["ShowTimerText"] = true,
						}, -- [179]
						{
							["ShowTimerText"] = true,
						}, -- [180]
						{
							["ShowTimerText"] = true,
						}, -- [181]
						{
							["ShowTimerText"] = true,
						}, -- [182]
						{
							["ShowTimerText"] = true,
						}, -- [183]
						{
							["ShowTimerText"] = true,
						}, -- [184]
						{
							["ShowTimerText"] = true,
						}, -- [185]
						{
							["ShowTimerText"] = true,
						}, -- [186]
						{
							["ShowTimerText"] = true,
						}, -- [187]
						{
							["ShowTimerText"] = true,
						}, -- [188]
						{
							["ShowTimerText"] = true,
						}, -- [189]
						{
							["ShowTimerText"] = true,
						}, -- [190]
						{
							["ShowTimerText"] = true,
						}, -- [191]
						{
							["ShowTimerText"] = true,
						}, -- [192]
						{
							["ShowTimerText"] = true,
						}, -- [193]
						{
							["ShowTimerText"] = true,
						}, -- [194]
						{
							["ShowTimerText"] = true,
						}, -- [195]
						{
							["ShowTimerText"] = true,
						}, -- [196]
						{
							["ShowTimerText"] = true,
						}, -- [197]
						{
							["ShowTimerText"] = true,
						}, -- [198]
						{
							["ShowTimerText"] = true,
						}, -- [199]
						{
							["ShowTimerText"] = true,
						}, -- [200]
						{
							["ShowTimerText"] = true,
						}, -- [201]
						{
							["ShowTimerText"] = true,
						}, -- [202]
						{
							["ShowTimerText"] = true,
						}, -- [203]
						{
							["ShowTimerText"] = true,
						}, -- [204]
						{
							["ShowTimerText"] = true,
						}, -- [205]
						{
							["ShowTimerText"] = true,
						}, -- [206]
						{
							["ShowTimerText"] = true,
						}, -- [207]
						{
							["ShowTimerText"] = true,
						}, -- [208]
						{
							["ShowTimerText"] = true,
						}, -- [209]
						{
							["ShowTimerText"] = true,
						}, -- [210]
						{
							["ShowTimerText"] = true,
						}, -- [211]
						{
							["ShowTimerText"] = true,
						}, -- [212]
						{
							["ShowTimerText"] = true,
						}, -- [213]
						{
							["ShowTimerText"] = true,
						}, -- [214]
						{
							["ShowTimerText"] = true,
						}, -- [215]
						{
							["ShowTimerText"] = true,
						}, -- [216]
						{
							["ShowTimerText"] = true,
						}, -- [217]
						{
							["ShowTimerText"] = true,
						}, -- [218]
						{
							["ShowTimerText"] = true,
						}, -- [219]
						{
							["ShowTimerText"] = true,
						}, -- [220]
						{
							["ShowTimerText"] = true,
						}, -- [221]
						{
							["ShowTimerText"] = true,
						}, -- [222]
						{
							["ShowTimerText"] = true,
						}, -- [223]
						{
							["ShowTimerText"] = true,
						}, -- [224]
						{
							["ShowTimerText"] = true,
						}, -- [225]
						{
							["ShowTimerText"] = true,
						}, -- [226]
						{
							["ShowTimerText"] = true,
						}, -- [227]
						{
							["ShowTimerText"] = true,
						}, -- [228]
						{
							["ShowTimerText"] = true,
						}, -- [229]
						{
							["ShowTimerText"] = true,
						}, -- [230]
						{
							["ShowTimerText"] = true,
						}, -- [231]
						{
							["ShowTimerText"] = true,
						}, -- [232]
						{
							["ShowTimerText"] = true,
						}, -- [233]
						{
							["ShowTimerText"] = true,
						}, -- [234]
						{
							["ShowTimerText"] = true,
						}, -- [235]
						{
							["ShowTimerText"] = true,
						}, -- [236]
						{
							["ShowTimerText"] = true,
						}, -- [237]
						{
							["ShowTimerText"] = true,
						}, -- [238]
						{
							["ShowTimerText"] = true,
						}, -- [239]
						{
							["ShowTimerText"] = true,
						}, -- [240]
						{
							["ShowTimerText"] = true,
						}, -- [241]
						{
							["ShowTimerText"] = true,
						}, -- [242]
						{
							["ShowTimerText"] = true,
						}, -- [243]
						{
							["ShowTimerText"] = true,
						}, -- [244]
						{
							["ShowTimerText"] = true,
						}, -- [245]
						{
							["ShowTimerText"] = true,
						}, -- [246]
						{
							["ShowTimerText"] = true,
						}, -- [247]
						{
							["ShowTimerText"] = true,
						}, -- [248]
						{
							["ShowTimerText"] = true,
						}, -- [249]
						{
							["ShowTimerText"] = true,
						}, -- [250]
						{
							["ShowTimerText"] = true,
						}, -- [251]
						{
							["ShowTimerText"] = true,
						}, -- [252]
						{
							["ShowTimerText"] = true,
						}, -- [253]
						{
							["ShowTimerText"] = true,
						}, -- [254]
						{
							["ShowTimerText"] = true,
						}, -- [255]
						{
							["ShowTimerText"] = true,
						}, -- [256]
						{
							["ShowTimerText"] = true,
						}, -- [257]
						{
							["ShowTimerText"] = true,
						}, -- [258]
						{
							["ShowTimerText"] = true,
						}, -- [259]
						{
							["ShowTimerText"] = true,
						}, -- [260]
						{
							["ShowTimerText"] = true,
						}, -- [261]
						{
							["ShowTimerText"] = true,
						}, -- [262]
						{
							["ShowTimerText"] = true,
						}, -- [263]
						{
							["ShowTimerText"] = true,
						}, -- [264]
						{
							["ShowTimerText"] = true,
						}, -- [265]
						{
							["ShowTimerText"] = true,
						}, -- [266]
						{
							["ShowTimerText"] = true,
						}, -- [267]
						{
							["ShowTimerText"] = true,
						}, -- [268]
						{
							["ShowTimerText"] = true,
						}, -- [269]
						{
							["ShowTimerText"] = true,
						}, -- [270]
						{
							["ShowTimerText"] = true,
						}, -- [271]
						{
							["ShowTimerText"] = true,
						}, -- [272]
						{
							["ShowTimerText"] = true,
						}, -- [273]
						{
							["ShowTimerText"] = true,
						}, -- [274]
						{
							["ShowTimerText"] = true,
						}, -- [275]
						{
							["ShowTimerText"] = true,
						}, -- [276]
						{
							["ShowTimerText"] = true,
						}, -- [277]
						{
							["ShowTimerText"] = true,
						}, -- [278]
						{
							["ShowTimerText"] = true,
						}, -- [279]
						{
							["ShowTimerText"] = true,
						}, -- [280]
						{
							["ShowTimerText"] = true,
						}, -- [281]
						{
							["ShowTimerText"] = true,
						}, -- [282]
						{
							["ShowTimerText"] = true,
						}, -- [283]
						{
							["ShowTimerText"] = true,
						}, -- [284]
						{
							["ShowTimerText"] = true,
						}, -- [285]
						{
							["ShowTimerText"] = true,
						}, -- [286]
						{
							["ShowTimerText"] = true,
						}, -- [287]
						{
							["ShowTimerText"] = true,
						}, -- [288]
						{
							["ShowTimerText"] = true,
						}, -- [289]
						{
							["ShowTimerText"] = true,
						}, -- [290]
						{
							["ShowTimerText"] = true,
						}, -- [291]
						{
							["ShowTimerText"] = true,
						}, -- [292]
						{
							["ShowTimerText"] = true,
						}, -- [293]
						{
							["ShowTimerText"] = true,
						}, -- [294]
						{
							["ShowTimerText"] = true,
						}, -- [295]
						{
							["ShowTimerText"] = true,
						}, -- [296]
						{
							["ShowTimerText"] = true,
						}, -- [297]
						{
							["ShowTimerText"] = true,
						}, -- [298]
						{
							["ShowTimerText"] = true,
						}, -- [299]
						{
							["ShowTimerText"] = true,
						}, -- [300]
					},
					["Conditions"] = {
						{
							["Type"] = "LUA",
							["Name"] = "return Action.Zone == \"pvp\"",
						}, -- [1]
						["n"] = 1,
					},
					["Point"] = {
						["y"] = -8.10552978515625,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
						["x"] = 70,
					},
				}, -- [3]
				{
					["TimerBar_MiddleColor"] = "ff000000",
					["Scale"] = 0.600000023841858,
					["TimerBar_CompleteColor"] = "ff000000",
					["TimerBar_StartColor"] = "ff000000",
					["Locked"] = true,
					["GUID"] = "TMW:group:1T0KXe2TsCkW",
					["Columns"] = 8,
					["Name"] = "Hidden APL",
					["Icons"] = {
						{
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "Action.Rotation(thisobj)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1T0KeNg=IDQd",
							["Enabled"] = true,
						}, -- [1]
						{
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "Action.Rotation(thisobj)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1T0KeNh2uwMT",
							["Enabled"] = true,
						}, -- [2]
						{
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "Action.Rotation(thisobj)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1T0Kg0ZzHksM",
							["Enabled"] = true,
						}, -- [3]
						{
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "Action.Rotation(thisobj)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1T0Kg0a1tFci",
							["Enabled"] = true,
						}, -- [4]
						{
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "Action.Rotation(thisobj)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1T0Kg0a6eYf9",
							["Enabled"] = true,
						}, -- [5]
						{
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "Action.Rotation(thisobj)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1T0Kg0aBPYen",
							["Enabled"] = true,
						}, -- [6]
						{
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "Action.Rotation(thisobj)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1T0Kg0aG1oeM",
							["Enabled"] = true,
						}, -- [7]
						{
							["Type"] = "conditionicon",
							["FakeHidden"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "Action.Rotation(thisobj)",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1T0Kg0aKbPUI",
							["Enabled"] = true,
						}, -- [8]
						{
							["ShowTimerText"] = true,
						}, -- [9]
						{
							["ShowTimerText"] = true,
						}, -- [10]
						{
							["ShowTimerText"] = true,
						}, -- [11]
						{
							["ShowTimerText"] = true,
						}, -- [12]
						{
							["ShowTimerText"] = true,
						}, -- [13]
						{
							["ShowTimerText"] = true,
						}, -- [14]
						{
							["ShowTimerText"] = true,
						}, -- [15]
						{
							["ShowTimerText"] = true,
						}, -- [16]
						{
							["ShowTimerText"] = true,
						}, -- [17]
						{
							["ShowTimerText"] = true,
						}, -- [18]
						{
							["ShowTimerText"] = true,
						}, -- [19]
						{
							["ShowTimerText"] = true,
						}, -- [20]
						{
							["ShowTimerText"] = true,
						}, -- [21]
						{
							["ShowTimerText"] = true,
						}, -- [22]
						{
							["ShowTimerText"] = true,
						}, -- [23]
						{
							["ShowTimerText"] = true,
						}, -- [24]
						{
							["ShowTimerText"] = true,
						}, -- [25]
						{
							["ShowTimerText"] = true,
						}, -- [26]
						{
							["ShowTimerText"] = true,
						}, -- [27]
						{
							["ShowTimerText"] = true,
						}, -- [28]
						{
							["ShowTimerText"] = true,
						}, -- [29]
						{
							["ShowTimerText"] = true,
						}, -- [30]
						{
							["ShowTimerText"] = true,
						}, -- [31]
						{
							["ShowTimerText"] = true,
						}, -- [32]
						{
							["ShowTimerText"] = true,
						}, -- [33]
						{
							["ShowTimerText"] = true,
						}, -- [34]
						{
							["ShowTimerText"] = true,
						}, -- [35]
						{
							["ShowTimerText"] = true,
						}, -- [36]
						{
							["ShowTimerText"] = true,
						}, -- [37]
						{
							["ShowTimerText"] = true,
						}, -- [38]
						{
							["ShowTimerText"] = true,
						}, -- [39]
						{
							["ShowTimerText"] = true,
						}, -- [40]
						{
							["ShowTimerText"] = true,
						}, -- [41]
						{
							["ShowTimerText"] = true,
						}, -- [42]
						{
							["ShowTimerText"] = true,
						}, -- [43]
						{
							["ShowTimerText"] = true,
						}, -- [44]
						{
							["ShowTimerText"] = true,
						}, -- [45]
						{
							["ShowTimerText"] = true,
						}, -- [46]
						{
							["ShowTimerText"] = true,
						}, -- [47]
						{
							["ShowTimerText"] = true,
						}, -- [48]
						{
							["ShowTimerText"] = true,
						}, -- [49]
						{
							["ShowTimerText"] = true,
						}, -- [50]
						{
							["ShowTimerText"] = true,
						}, -- [51]
						{
							["ShowTimerText"] = true,
						}, -- [52]
						{
							["ShowTimerText"] = true,
						}, -- [53]
						{
							["ShowTimerText"] = true,
						}, -- [54]
						{
							["ShowTimerText"] = true,
						}, -- [55]
						{
							["ShowTimerText"] = true,
						}, -- [56]
						{
							["ShowTimerText"] = true,
						}, -- [57]
						{
							["ShowTimerText"] = true,
						}, -- [58]
						{
							["ShowTimerText"] = true,
						}, -- [59]
						{
							["ShowTimerText"] = true,
						}, -- [60]
						{
							["ShowTimerText"] = true,
						}, -- [61]
						{
							["ShowTimerText"] = true,
						}, -- [62]
						{
							["ShowTimerText"] = true,
						}, -- [63]
						{
							["ShowTimerText"] = true,
						}, -- [64]
						{
							["ShowTimerText"] = true,
						}, -- [65]
						{
							["ShowTimerText"] = true,
						}, -- [66]
						{
							["ShowTimerText"] = true,
						}, -- [67]
						{
							["ShowTimerText"] = true,
						}, -- [68]
						{
							["ShowTimerText"] = true,
						}, -- [69]
						{
							["ShowTimerText"] = true,
						}, -- [70]
						{
							["ShowTimerText"] = true,
						}, -- [71]
						{
							["ShowTimerText"] = true,
						}, -- [72]
						{
							["ShowTimerText"] = true,
						}, -- [73]
						{
							["ShowTimerText"] = true,
						}, -- [74]
						{
							["ShowTimerText"] = true,
						}, -- [75]
						{
							["ShowTimerText"] = true,
						}, -- [76]
						{
							["ShowTimerText"] = true,
						}, -- [77]
						{
							["ShowTimerText"] = true,
						}, -- [78]
						{
							["ShowTimerText"] = true,
						}, -- [79]
						{
							["ShowTimerText"] = true,
						}, -- [80]
						{
							["ShowTimerText"] = true,
						}, -- [81]
						{
							["ShowTimerText"] = true,
						}, -- [82]
						{
							["ShowTimerText"] = true,
						}, -- [83]
						{
							["ShowTimerText"] = true,
						}, -- [84]
						{
							["ShowTimerText"] = true,
						}, -- [85]
						{
							["ShowTimerText"] = true,
						}, -- [86]
						{
							["ShowTimerText"] = true,
						}, -- [87]
						{
							["ShowTimerText"] = true,
						}, -- [88]
						{
							["ShowTimerText"] = true,
						}, -- [89]
						{
							["ShowTimerText"] = true,
						}, -- [90]
						{
							["ShowTimerText"] = true,
						}, -- [91]
						{
							["ShowTimerText"] = true,
						}, -- [92]
						{
							["ShowTimerText"] = true,
						}, -- [93]
						{
							["ShowTimerText"] = true,
						}, -- [94]
						{
							["ShowTimerText"] = true,
						}, -- [95]
						{
							["ShowTimerText"] = true,
						}, -- [96]
						{
							["ShowTimerText"] = true,
						}, -- [97]
						{
							["ShowTimerText"] = true,
						}, -- [98]
						{
							["ShowTimerText"] = true,
						}, -- [99]
						{
							["ShowTimerText"] = true,
						}, -- [100]
						{
							["ShowTimerText"] = true,
						}, -- [101]
						{
							["ShowTimerText"] = true,
						}, -- [102]
						{
							["ShowTimerText"] = true,
						}, -- [103]
						{
							["ShowTimerText"] = true,
						}, -- [104]
						{
							["ShowTimerText"] = true,
						}, -- [105]
						{
							["ShowTimerText"] = true,
						}, -- [106]
						{
							["ShowTimerText"] = true,
						}, -- [107]
						{
							["ShowTimerText"] = true,
						}, -- [108]
						{
							["ShowTimerText"] = true,
						}, -- [109]
						{
							["ShowTimerText"] = true,
						}, -- [110]
						{
							["ShowTimerText"] = true,
						}, -- [111]
						{
							["ShowTimerText"] = true,
						}, -- [112]
						{
							["ShowTimerText"] = true,
						}, -- [113]
						{
							["ShowTimerText"] = true,
						}, -- [114]
						{
							["ShowTimerText"] = true,
						}, -- [115]
						{
							["ShowTimerText"] = true,
						}, -- [116]
						{
							["ShowTimerText"] = true,
						}, -- [117]
						{
							["ShowTimerText"] = true,
						}, -- [118]
						{
							["ShowTimerText"] = true,
						}, -- [119]
						{
							["ShowTimerText"] = true,
						}, -- [120]
					},
					["Point"] = {
						["y"] = 50,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
						["x"] = -29.0000038146973,
					},
				}, -- [4]
				{
					["Scale"] = 2.22222137451172,
					["GUID"] = "TMW:group:1P3cu8AAtSYM",
					["Columns"] = 1,
					["Name"] = "Visible APL",
					["Icons"] = {
						{
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1T0MjrGnynSL", -- [1]
							},
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "Action.ToggleMainUI()",
									["OnlyShown"] = true,
									["Event"] = "OnRightClick",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1T0MjsTsMtq6",
							["Enabled"] = true,
						}, -- [1]
					},
					["Conditions"] = {
						{
							["Type"] = "LUA",
							["Name"] = "return Action.IsInitialized and not Action.GetToggle(1, \"DisableRotationDisplay\")",
						}, -- [1]
						["n"] = 1,
					},
					["Point"] = {
						["y"] = -67.3366961670121,
						["x"] = -155.158953182301,
					},
				}, -- [5]
				{
					["Locked"] = true,
					["Level"] = 11,
					["GUID"] = "TMW:group:1TMvhh5X05mC",
					["Columns"] = 1,
					["Name"] = "Visible APL Layout",
					["Icons"] = {
						{
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Lua",
									["Lua"] = "if IsShiftKeyDown() then\n    Action.ToggleBurst()\nelseif IsControlKeyDown() then\n    Action.ToggleMode()\nelseif IsAltKeyDown() then\n    Action.ToggleAoE()\nelse\n    --[[\n    if not Action.GetToggle(1, \"DisableSounds\") then\n        PlaySound(416)\n    end\n]]\n    \n    Action.PrintHelpToggle()\nend",
									["OnlyShown"] = true,
									["Event"] = "OnLeftClick",
								}, -- [1]
								{
									["Type"] = "Lua",
									["Lua"] = "Action.ToggleMainUI()",
									["OnlyShown"] = true,
									["Event"] = "OnRightClick",
								}, -- [2]
								["n"] = 2,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "TMW:textlayout:1TMvg5InaYOw",
									["Texts"] = {
										"[ActionBurst]", -- [1]
									},
								},
							},
							["CustomTex"] = "NONE",
							["States"] = {
								nil, -- [1]
								{
									["Alpha"] = 1,
								}, -- [2]
							},
							["Enabled"] = true,
						}, -- [1]
					},
					["Conditions"] = {
						{
							["Type"] = "LUA",
							["Name"] = "return Action.IsInitialized and not Action.GetToggle(1, \"DisableRotationDisplay\") and not Action.GetToggle(1, \"DisableRotationModes\")",
						}, -- [1]
						["n"] = 1,
					},
					["Point"] = {
						["y"] = -0.199651536357123,
						["relativeTo"] = "TMW:group:1P3cu8AAtSYM",
						["x"] = 4.781340248882770e-05,
					},
				}, -- [6]
				{
					["View"] = "bar",
					["Rows"] = 3,
					["TextureName"] = "Flat",
					["Locked"] = true,
					["GUID"] = "TMW:group:1TU4r3gUgkWv",
					["Columns"] = 3,
					["Name"] = "Hidden Cast Bars Config Player",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 20.3040440877279,
							["BorderColor"] = "00000000",
						},
					},
					["Icons"] = {
						{
							["Unit"] = "arena1",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ff00ff00",
							["FakeHidden"] = true,
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"Heal\")",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gTq44v",
							["CustomTex"] = "16561",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
						{
							["Unit"] = "arena2",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ff00ff00",
							["FakeHidden"] = true,
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"Heal\")",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gTvDmY",
							["CustomTex"] = "16561",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [2]
						{
							["Unit"] = "arena3",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ff00ff00",
							["FakeHidden"] = true,
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"Heal\")",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gTxbKc",
							["CustomTex"] = "16561",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ff00ff00",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [3]
						{
							["Unit"] = "arena1",
							["Type"] = "TheAction - UnitCasting",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffff0000",
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"PvP\")",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gT=Wq3",
							["CustomTex"] = "5199",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ffff0000",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [4]
						{
							["Unit"] = "arena2",
							["Type"] = "TheAction - UnitCasting",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffff0000",
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"PvP\")",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gU1EG0",
							["CustomTex"] = "5199",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ffff0000",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [5]
						{
							["Unit"] = "arena3",
							["Type"] = "TheAction - UnitCasting",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffff0000",
							["TimerBar_EnableColors"] = true,
							["Conditions"] = {
								{
									["Type"] = "LUA",
									["Name"] = "return Action.Main_CastBars(thisobj.Unit, \"PvP\")",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gU3zGQ",
							["CustomTex"] = "5199",
							["Enabled"] = true,
							["TimerBar_MiddleColor"] = "ffff0000",
							["BarDisplay_Invert"] = true,
							["Interruptible"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [6]
						{
							["Unit"] = "arena1",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ffffff00",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffffff00",
							["TimerBar_EnableColors"] = true,
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gU5t86",
							["CustomTex"] = "5967",
							["BarDisplay_Invert"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [7]
						{
							["Unit"] = "arena2",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ffffff00",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffffff00",
							["TimerBar_EnableColors"] = true,
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gU9GKh",
							["CustomTex"] = "5967",
							["BarDisplay_Invert"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [8]
						{
							["Unit"] = "arena3",
							["Type"] = "TheAction - UnitCasting",
							["TimerBar_StartColor"] = "ffffff00",
							["FakeHidden"] = true,
							["TimerBar_CompleteColor"] = "ffffff00",
							["TimerBar_EnableColors"] = true,
							["SettingsPerView"] = {
								["bar"] = {
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1TU4r3gUBk8o",
							["CustomTex"] = "5967",
							["BarDisplay_Invert"] = true,
							["UnitConditions"] = {
								{
									["Type"] = "UNITISUNIT",
									["Level"] = 1,
									["Name"] = "target",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [9]
						{
							["ShowTimerText"] = true,
						}, -- [10]
						{
							["ShowTimerText"] = true,
						}, -- [11]
						{
							["ShowTimerText"] = true,
						}, -- [12]
						{
							["ShowTimerText"] = true,
						}, -- [13]
						{
							["ShowTimerText"] = true,
						}, -- [14]
						{
							["ShowTimerText"] = true,
						}, -- [15]
						{
							["ShowTimerText"] = true,
						}, -- [16]
						{
							["ShowTimerText"] = true,
						}, -- [17]
						{
							["ShowTimerText"] = true,
						}, -- [18]
						{
							["ShowTimerText"] = true,
						}, -- [19]
						{
							["ShowTimerText"] = true,
						}, -- [20]
						{
							["ShowTimerText"] = true,
						}, -- [21]
						{
							["ShowTimerText"] = true,
						}, -- [22]
						{
							["ShowTimerText"] = true,
						}, -- [23]
						{
							["ShowTimerText"] = true,
						}, -- [24]
						{
							["ShowTimerText"] = true,
						}, -- [25]
						{
							["ShowTimerText"] = true,
						}, -- [26]
						{
							["ShowTimerText"] = true,
						}, -- [27]
						{
							["ShowTimerText"] = true,
						}, -- [28]
						{
							["ShowTimerText"] = true,
						}, -- [29]
						{
							["ShowTimerText"] = true,
						}, -- [30]
						{
							["ShowTimerText"] = true,
						}, -- [31]
						{
							["ShowTimerText"] = true,
						}, -- [32]
						{
							["ShowTimerText"] = true,
						}, -- [33]
						{
							["ShowTimerText"] = true,
						}, -- [34]
						{
							["ShowTimerText"] = true,
						}, -- [35]
						{
							["ShowTimerText"] = true,
						}, -- [36]
						{
							["ShowTimerText"] = true,
						}, -- [37]
						{
							["ShowTimerText"] = true,
						}, -- [38]
						{
							["ShowTimerText"] = true,
						}, -- [39]
						{
							["ShowTimerText"] = true,
						}, -- [40]
						{
							["ShowTimerText"] = true,
						}, -- [41]
						{
							["ShowTimerText"] = true,
						}, -- [42]
						{
							["ShowTimerText"] = true,
						}, -- [43]
						{
							["ShowTimerText"] = true,
						}, -- [44]
						{
							["ShowTimerText"] = true,
						}, -- [45]
						{
							["ShowTimerText"] = true,
						}, -- [46]
						{
							["ShowTimerText"] = true,
						}, -- [47]
						{
							["ShowTimerText"] = true,
						}, -- [48]
						{
							["ShowTimerText"] = true,
						}, -- [49]
						{
							["ShowTimerText"] = true,
						}, -- [50]
						{
							["ShowTimerText"] = true,
						}, -- [51]
						{
							["ShowTimerText"] = true,
						}, -- [52]
						{
							["ShowTimerText"] = true,
						}, -- [53]
						{
							["ShowTimerText"] = true,
						}, -- [54]
						{
							["ShowTimerText"] = true,
						}, -- [55]
						{
							["ShowTimerText"] = true,
						}, -- [56]
						{
							["ShowTimerText"] = true,
						}, -- [57]
						{
							["ShowTimerText"] = true,
						}, -- [58]
						{
							["ShowTimerText"] = true,
						}, -- [59]
						{
							["ShowTimerText"] = true,
						}, -- [60]
						{
							["ShowTimerText"] = true,
						}, -- [61]
						{
							["ShowTimerText"] = true,
						}, -- [62]
						{
							["ShowTimerText"] = true,
						}, -- [63]
						{
							["ShowTimerText"] = true,
						}, -- [64]
						{
							["ShowTimerText"] = true,
						}, -- [65]
						{
							["ShowTimerText"] = true,
						}, -- [66]
						{
							["ShowTimerText"] = true,
						}, -- [67]
						{
							["ShowTimerText"] = true,
						}, -- [68]
						{
							["ShowTimerText"] = true,
						}, -- [69]
						{
							["ShowTimerText"] = true,
						}, -- [70]
						{
							["ShowTimerText"] = true,
						}, -- [71]
						{
							["ShowTimerText"] = true,
						}, -- [72]
						{
							["ShowTimerText"] = true,
						}, -- [73]
						{
							["ShowTimerText"] = true,
						}, -- [74]
						{
							["ShowTimerText"] = true,
						}, -- [75]
						{
							["ShowTimerText"] = true,
						}, -- [76]
						{
							["ShowTimerText"] = true,
						}, -- [77]
						{
							["ShowTimerText"] = true,
						}, -- [78]
						{
							["ShowTimerText"] = true,
						}, -- [79]
						{
							["ShowTimerText"] = true,
						}, -- [80]
						{
							["ShowTimerText"] = true,
						}, -- [81]
						{
							["ShowTimerText"] = true,
						}, -- [82]
						{
							["ShowTimerText"] = true,
						}, -- [83]
						{
							["ShowTimerText"] = true,
						}, -- [84]
						{
							["ShowTimerText"] = true,
						}, -- [85]
						{
							["ShowTimerText"] = true,
						}, -- [86]
						{
							["ShowTimerText"] = true,
						}, -- [87]
						{
							["ShowTimerText"] = true,
						}, -- [88]
						{
							["ShowTimerText"] = true,
						}, -- [89]
						{
							["ShowTimerText"] = true,
						}, -- [90]
						{
							["ShowTimerText"] = true,
						}, -- [91]
						{
							["ShowTimerText"] = true,
						}, -- [92]
						{
							["ShowTimerText"] = true,
						}, -- [93]
						{
							["ShowTimerText"] = true,
						}, -- [94]
						{
							["ShowTimerText"] = true,
						}, -- [95]
						{
							["ShowTimerText"] = true,
						}, -- [96]
						{
							["ShowTimerText"] = true,
						}, -- [97]
						{
							["ShowTimerText"] = true,
						}, -- [98]
						{
							["ShowTimerText"] = true,
						}, -- [99]
						{
							["ShowTimerText"] = true,
						}, -- [100]
						{
							["ShowTimerText"] = true,
						}, -- [101]
						{
							["ShowTimerText"] = true,
						}, -- [102]
						{
							["ShowTimerText"] = true,
						}, -- [103]
						{
							["ShowTimerText"] = true,
						}, -- [104]
						{
							["ShowTimerText"] = true,
						}, -- [105]
						{
							["ShowTimerText"] = true,
						}, -- [106]
						{
							["ShowTimerText"] = true,
						}, -- [107]
						{
							["ShowTimerText"] = true,
						}, -- [108]
						{
							["ShowTimerText"] = true,
						}, -- [109]
						{
							["ShowTimerText"] = true,
						}, -- [110]
						{
							["ShowTimerText"] = true,
						}, -- [111]
						{
							["ShowTimerText"] = true,
						}, -- [112]
						{
							["ShowTimerText"] = true,
						}, -- [113]
						{
							["ShowTimerText"] = true,
						}, -- [114]
						{
							["ShowTimerText"] = true,
						}, -- [115]
						{
							["ShowTimerText"] = true,
						}, -- [116]
						{
							["ShowTimerText"] = true,
						}, -- [117]
						{
							["ShowTimerText"] = true,
						}, -- [118]
						{
							["ShowTimerText"] = true,
						}, -- [119]
						{
							["ShowTimerText"] = true,
						}, -- [120]
						{
							["ShowTimerText"] = true,
						}, -- [121]
						{
							["ShowTimerText"] = true,
						}, -- [122]
						{
							["ShowTimerText"] = true,
						}, -- [123]
						{
							["ShowTimerText"] = true,
						}, -- [124]
						{
							["ShowTimerText"] = true,
						}, -- [125]
						{
							["ShowTimerText"] = true,
						}, -- [126]
						{
							["ShowTimerText"] = true,
						}, -- [127]
						{
							["ShowTimerText"] = true,
						}, -- [128]
						{
							["ShowTimerText"] = true,
						}, -- [129]
						{
							["ShowTimerText"] = true,
						}, -- [130]
						{
							["ShowTimerText"] = true,
						}, -- [131]
						{
							["ShowTimerText"] = true,
						}, -- [132]
						{
							["ShowTimerText"] = true,
						}, -- [133]
						{
							["ShowTimerText"] = true,
						}, -- [134]
						{
							["ShowTimerText"] = true,
						}, -- [135]
						{
							["ShowTimerText"] = true,
						}, -- [136]
						{
							["ShowTimerText"] = true,
						}, -- [137]
						{
							["ShowTimerText"] = true,
						}, -- [138]
						{
							["ShowTimerText"] = true,
						}, -- [139]
						{
							["ShowTimerText"] = true,
						}, -- [140]
						{
							["ShowTimerText"] = true,
						}, -- [141]
						{
							["ShowTimerText"] = true,
						}, -- [142]
						{
							["ShowTimerText"] = true,
						}, -- [143]
						{
							["ShowTimerText"] = true,
						}, -- [144]
						{
							["ShowTimerText"] = true,
						}, -- [145]
						{
							["ShowTimerText"] = true,
						}, -- [146]
						{
							["ShowTimerText"] = true,
						}, -- [147]
						{
							["ShowTimerText"] = true,
						}, -- [148]
						{
							["ShowTimerText"] = true,
						}, -- [149]
						{
							["ShowTimerText"] = true,
						}, -- [150]
						{
							["ShowTimerText"] = true,
						}, -- [151]
						{
							["ShowTimerText"] = true,
						}, -- [152]
						{
							["ShowTimerText"] = true,
						}, -- [153]
						{
							["ShowTimerText"] = true,
						}, -- [154]
						{
							["ShowTimerText"] = true,
						}, -- [155]
						{
							["ShowTimerText"] = true,
						}, -- [156]
						{
							["ShowTimerText"] = true,
						}, -- [157]
						{
							["ShowTimerText"] = true,
						}, -- [158]
						{
							["ShowTimerText"] = true,
						}, -- [159]
						{
							["ShowTimerText"] = true,
						}, -- [160]
						{
							["ShowTimerText"] = true,
						}, -- [161]
						{
							["ShowTimerText"] = true,
						}, -- [162]
						{
							["ShowTimerText"] = true,
						}, -- [163]
						{
							["ShowTimerText"] = true,
						}, -- [164]
						{
							["ShowTimerText"] = true,
						}, -- [165]
						{
							["ShowTimerText"] = true,
						}, -- [166]
						{
							["ShowTimerText"] = true,
						}, -- [167]
						{
							["ShowTimerText"] = true,
						}, -- [168]
						{
							["ShowTimerText"] = true,
						}, -- [169]
						{
							["ShowTimerText"] = true,
						}, -- [170]
						{
							["ShowTimerText"] = true,
						}, -- [171]
						{
							["ShowTimerText"] = true,
						}, -- [172]
						{
							["ShowTimerText"] = true,
						}, -- [173]
						{
							["ShowTimerText"] = true,
						}, -- [174]
						{
							["ShowTimerText"] = true,
						}, -- [175]
						{
							["ShowTimerText"] = true,
						}, -- [176]
						{
							["ShowTimerText"] = true,
						}, -- [177]
						{
							["ShowTimerText"] = true,
						}, -- [178]
						{
							["ShowTimerText"] = true,
						}, -- [179]
						{
							["ShowTimerText"] = true,
						}, -- [180]
						{
							["ShowTimerText"] = true,
						}, -- [181]
						{
							["ShowTimerText"] = true,
						}, -- [182]
						{
							["ShowTimerText"] = true,
						}, -- [183]
						{
							["ShowTimerText"] = true,
						}, -- [184]
						{
							["ShowTimerText"] = true,
						}, -- [185]
						{
							["ShowTimerText"] = true,
						}, -- [186]
						{
							["ShowTimerText"] = true,
						}, -- [187]
						{
							["ShowTimerText"] = true,
						}, -- [188]
						{
							["ShowTimerText"] = true,
						}, -- [189]
						{
							["ShowTimerText"] = true,
						}, -- [190]
						{
							["ShowTimerText"] = true,
						}, -- [191]
						{
							["ShowTimerText"] = true,
						}, -- [192]
						{
							["ShowTimerText"] = true,
						}, -- [193]
						{
							["ShowTimerText"] = true,
						}, -- [194]
						{
							["ShowTimerText"] = true,
						}, -- [195]
						{
							["ShowTimerText"] = true,
						}, -- [196]
						{
							["ShowTimerText"] = true,
						}, -- [197]
						{
							["ShowTimerText"] = true,
						}, -- [198]
						{
							["ShowTimerText"] = true,
						}, -- [199]
						{
							["ShowTimerText"] = true,
						}, -- [200]
						{
							["ShowTimerText"] = true,
						}, -- [201]
						{
							["ShowTimerText"] = true,
						}, -- [202]
						{
							["ShowTimerText"] = true,
						}, -- [203]
						{
							["ShowTimerText"] = true,
						}, -- [204]
						{
							["ShowTimerText"] = true,
						}, -- [205]
						{
							["ShowTimerText"] = true,
						}, -- [206]
						{
							["ShowTimerText"] = true,
						}, -- [207]
						{
							["ShowTimerText"] = true,
						}, -- [208]
						{
							["ShowTimerText"] = true,
						}, -- [209]
						{
							["ShowTimerText"] = true,
						}, -- [210]
						{
							["ShowTimerText"] = true,
						}, -- [211]
						{
							["ShowTimerText"] = true,
						}, -- [212]
						{
							["ShowTimerText"] = true,
						}, -- [213]
						{
							["ShowTimerText"] = true,
						}, -- [214]
						{
							["ShowTimerText"] = true,
						}, -- [215]
						{
							["ShowTimerText"] = true,
						}, -- [216]
						{
							["ShowTimerText"] = true,
						}, -- [217]
						{
							["ShowTimerText"] = true,
						}, -- [218]
						{
							["ShowTimerText"] = true,
						}, -- [219]
						{
							["ShowTimerText"] = true,
						}, -- [220]
						{
							["ShowTimerText"] = true,
						}, -- [221]
						{
							["ShowTimerText"] = true,
						}, -- [222]
						{
							["ShowTimerText"] = true,
						}, -- [223]
						{
							["ShowTimerText"] = true,
						}, -- [224]
						{
							["ShowTimerText"] = true,
						}, -- [225]
						{
							["ShowTimerText"] = true,
						}, -- [226]
						{
							["ShowTimerText"] = true,
						}, -- [227]
						{
							["ShowTimerText"] = true,
						}, -- [228]
						{
							["ShowTimerText"] = true,
						}, -- [229]
						{
							["ShowTimerText"] = true,
						}, -- [230]
						{
							["ShowTimerText"] = true,
						}, -- [231]
						{
							["ShowTimerText"] = true,
						}, -- [232]
						{
							["ShowTimerText"] = true,
						}, -- [233]
						{
							["ShowTimerText"] = true,
						}, -- [234]
						{
							["ShowTimerText"] = true,
						}, -- [235]
						{
							["ShowTimerText"] = true,
						}, -- [236]
						{
							["ShowTimerText"] = true,
						}, -- [237]
						{
							["ShowTimerText"] = true,
						}, -- [238]
						{
							["ShowTimerText"] = true,
						}, -- [239]
						{
							["ShowTimerText"] = true,
						}, -- [240]
						{
							["ShowTimerText"] = true,
						}, -- [241]
						{
							["ShowTimerText"] = true,
						}, -- [242]
						{
							["ShowTimerText"] = true,
						}, -- [243]
						{
							["ShowTimerText"] = true,
						}, -- [244]
						{
							["ShowTimerText"] = true,
						}, -- [245]
						{
							["ShowTimerText"] = true,
						}, -- [246]
						{
							["ShowTimerText"] = true,
						}, -- [247]
						{
							["ShowTimerText"] = true,
						}, -- [248]
						{
							["ShowTimerText"] = true,
						}, -- [249]
						{
							["ShowTimerText"] = true,
						}, -- [250]
						{
							["ShowTimerText"] = true,
						}, -- [251]
						{
							["ShowTimerText"] = true,
						}, -- [252]
						{
							["ShowTimerText"] = true,
						}, -- [253]
						{
							["ShowTimerText"] = true,
						}, -- [254]
						{
							["ShowTimerText"] = true,
						}, -- [255]
						{
							["ShowTimerText"] = true,
						}, -- [256]
						{
							["ShowTimerText"] = true,
						}, -- [257]
						{
							["ShowTimerText"] = true,
						}, -- [258]
						{
							["ShowTimerText"] = true,
						}, -- [259]
						{
							["ShowTimerText"] = true,
						}, -- [260]
						{
							["ShowTimerText"] = true,
						}, -- [261]
						{
							["ShowTimerText"] = true,
						}, -- [262]
						{
							["ShowTimerText"] = true,
						}, -- [263]
						{
							["ShowTimerText"] = true,
						}, -- [264]
						{
							["ShowTimerText"] = true,
						}, -- [265]
						{
							["ShowTimerText"] = true,
						}, -- [266]
						{
							["ShowTimerText"] = true,
						}, -- [267]
						{
							["ShowTimerText"] = true,
						}, -- [268]
						{
							["ShowTimerText"] = true,
						}, -- [269]
						{
							["ShowTimerText"] = true,
						}, -- [270]
						{
							["ShowTimerText"] = true,
						}, -- [271]
						{
							["ShowTimerText"] = true,
						}, -- [272]
						{
							["ShowTimerText"] = true,
						}, -- [273]
						{
							["ShowTimerText"] = true,
						}, -- [274]
						{
							["ShowTimerText"] = true,
						}, -- [275]
						{
							["ShowTimerText"] = true,
						}, -- [276]
						{
							["ShowTimerText"] = true,
						}, -- [277]
						{
							["ShowTimerText"] = true,
						}, -- [278]
						{
							["ShowTimerText"] = true,
						}, -- [279]
						{
							["ShowTimerText"] = true,
						}, -- [280]
						{
							["ShowTimerText"] = true,
						}, -- [281]
						{
							["ShowTimerText"] = true,
						}, -- [282]
						{
							["ShowTimerText"] = true,
						}, -- [283]
						{
							["ShowTimerText"] = true,
						}, -- [284]
						{
							["ShowTimerText"] = true,
						}, -- [285]
						{
							["ShowTimerText"] = true,
						}, -- [286]
						{
							["ShowTimerText"] = true,
						}, -- [287]
						{
							["ShowTimerText"] = true,
						}, -- [288]
						{
							["ShowTimerText"] = true,
						}, -- [289]
						{
							["ShowTimerText"] = true,
						}, -- [290]
						{
							["ShowTimerText"] = true,
						}, -- [291]
						{
							["ShowTimerText"] = true,
						}, -- [292]
						{
							["ShowTimerText"] = true,
						}, -- [293]
						{
							["ShowTimerText"] = true,
						}, -- [294]
						{
							["ShowTimerText"] = true,
						}, -- [295]
						{
							["ShowTimerText"] = true,
						}, -- [296]
						{
							["ShowTimerText"] = true,
						}, -- [297]
						{
							["ShowTimerText"] = true,
						}, -- [298]
						{
							["ShowTimerText"] = true,
						}, -- [299]
						{
							["ShowTimerText"] = true,
						}, -- [300]
					},
					["Conditions"] = {
						{
							["Type"] = "LUA",
							["Name"] = "return Action.Zone == \"pvp\"",
						}, -- [1]
						["n"] = 1,
					},
					["Point"] = {
						["y"] = -8.10552978515625,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
						["x"] = 3.52900862693787,
					},
				}, -- [7]
			},
			["NumGroups"] = 7,
			["TextureName"] = "Flat",
			["HideBlizzCDBling"] = false,
			["Locked"] = true,
			["WarnInvalids"] = false,
		},
	},
}