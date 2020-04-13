local TMW = TMW
local CNDT = TMW.CNDT
local Env = CNDT.Env

local UnitHealthMax, UnitHealth, UnitGetIncomingHeals =
UnitHealthMax, UnitHealth, UnitGetIncomingHeals

local AtonementBuff = 0

function Env.PredictHeal(SPELLID, UNIT, VARIATION, ENEMIES)   
    -- Exception penalty for low level units / friendly boss
    local UnitLvL = Env.UNITLevel(UNIT)
    if UnitLvL > 0 and UnitLvL < Env.UNITLevel("player") - 10 then
        return true, 0
    end     
    
    -- Header
    local variation = (VARIATION and (VARIATION / 100)) or 1
    local enemies = ENEMIES or 0    
    
    local total = 0
    local DMG, HPS = incdmg(UNIT), getHEAL(UNIT)      
    local DifficultHP = UnitHealthMax(UNIT) - UnitHealth(UNIT)  
    
    -- Class things
    -- Discipline
    if Env.UNITSpec("player", 256) then 
        AtonementBuff = Env.PvP.Unit(UNIT):HasBuffs(81749, "player")
        AtonementBuff = (AtonementBuff > Env.GCD() + Env.CurrentTimeGCD() and AtonementBuff) or 0
    elseif AtonementBuff ~= 0 then 
        AtonementBuff = 0
    end 
    
    -- Spells
    if SPELLID == "PenanceHeal" then
        if CombatTime("player") == 0 then
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0            
            local Penance = Env.GetDescription(47540)[1] * variation
            total = Penance + pre_heal
        else
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0
            local cast = Env.CastTime(47540) + Env.CurrentTimeGCD()
            local Penance = Env.GetDescription(47540)[1] * variation
            total = Penance + pre_heal + (HPS * cast) - (DMG * cast) 
        end        
    end 
    
    if SPELLID == "PenanceDMG" then
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        local cast = Env.CastTime(47540) + Env.CurrentTimeGCD()
        local Penance = Env.GetDescription(47540)[1] * 0.55 * variation
        total = Penance + pre_heal + (HPS * cast) - (DMG * cast)                
    end 
    
    -- Power Word: Shield
    if SPELLID == "PW:S" then   
        if CombatTime("player") == 0 then
            total = 0
        else
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0        
            local PWS = Env.GetDescription(17)[1] * variation
            -- Should be without HE_Absorb toggle 
            total = PWS + pre_heal + getAbsorb(UNIT, 17) + (HPS * 15) - (DMG * 15)
        end 
    end 
    
    -- Power Word: Radiance
    if SPELLID == "PW:R" then  
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Env.CastTime(194509) + Env.CurrentTimeGCD()
        local PWR = Env.GetDescription(194509)[1] * variation
        total = PWR + pre_heal + (HPS * cast) - (DMG * cast)                    
    end 
    
    if SPELLID == "ShadowMend" then  
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Env.CastTime(186263) + Env.CurrentTimeGCD()
        local ShadowMend = Env.GetDescription(186263)[1] * variation
        total = ShadowMend + pre_heal + (HPS * cast) - (DMG * cast)               
    end 
    
    if SPELLID == "DivineStar" then               
        total = Env.GetDescription(110744)[1] * variation - (DMG * Env.GCD())         
    end    
    
    if SPELLID == "Halo" then  
        if CombatTime("player") == 0 then
            -- Exception to don't hit nearest mobs 
            if Env.oPR["AoE30"] and Env.oPR["AoE30"] > 0 then 
                total = 88888888888888
            else 
                local pre_heal = UnitGetIncomingHeals(UNIT) or 0                   
                local Halo = Env.GetDescription(120517)[1] * variation
                total = Halo + pre_heal
            end 
        else
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
            local cast = Env.CastTime(120517) + Env.CurrentTimeGCD()
            local Halo = Env.GetDescription(120517)[1] 
            total = (Halo * variation) + pre_heal + ((AtonementBuff > cast and Halo * 0.55 * enemies) or 0) + (HPS * cast) -- - (DMG * cast)
        end 
    end 
    
    if SPELLID == "HolyNova" then   
        local HolyNova = Env.GetDescription(132157)        
        total = (HolyNova[2] * variation) + ((AtonementBuff > 0 and HolyNova[1] * 0.55 * enemies) or 0)           
    end 
    
    if SPELLID == "ShadowCovenant" then
        local ShadowCovenant = Env.GetDescription(204065)
        total = ShadowCovenant[1] * variation + ShadowCovenant[2]  
    end 
    
    -- Holy 
    -- Note about Mastery: Regarding overwrite previous effect by any next spell here is no reason to add that 
    -- Holy Word: Sanctify 
    if SPELLID == "HW:Sanctify" then       
        total = Env.GetDescription(34861)[1] * variation 
    end 
    
    -- Holy Word: Serenity 
    if SPELLID == "HW:Serenity" then       
        total = Env.GetDescription(2050)[1] * variation 
    end 
    
    -- Circle of Healing 
    if SPELLID == "CircleOfHealing" then       
        total = Env.GetDescription(204883)[1] * variation 
    end 
    
    -- Prayer Of Mending    
    if SPELLID == "PrayerOfMending" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Env.CastTime(120517) + Env.CurrentTimeGCD()
        total = Env.GetDescription(33076)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Prayer Of Mending HoT   
    if SPELLID == "PrayerOfMendingHoT" then   
        total = Env.GetDescription(33076)[1] * variation 
    end 
    
    -- Prayer of Healing
    if SPELLID == "PrayerOfHealing" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Env.CastTime(596) + Env.CurrentTimeGCD()
        total = Env.GetDescription(596)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Binding Heal
    if SPELLID == "BindingHeal" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Env.CastTime(32546) + Env.CurrentTimeGCD()
        total = Env.GetDescription(32546)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Renew 
    if SPELLID == "Renew" then   
        if CombatTime("player") == 0 then 
            total = 0
        else 
            local pre_heal = UnitGetIncomingHeals(UNIT) or 0               
            total = Env.GetDescription(139)[2] * variation + pre_heal + (Env.GetDescription(139)[1] * 15) -- - (DMG * 15) 
        end 
    end 
    
    -- Flash Heal
    if SPELLID == "FlashHeal" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Env.CastTime(2061) + Env.CurrentTimeGCD()
        total = Env.GetDescription(2061)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Heal 
    if SPELLID == "Heal" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local cast = Env.CastTime(2060) + Env.CurrentTimeGCD()
        total = Env.GetDescription(2060)[1] * variation + pre_heal + (HPS * cast) -- - (DMG * cast) 
    end 
    
    -- Apotheosis
    if SPELLID == "Apotheosis" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0   
        local Serenity = Env.GetDescription(2050)[1] * variation 
        local Sancify = Env.GetDescription(34861)[1] * variation
        total = Serenity + Sancify + pre_heal + (HPS * (Env.GCD() + Env.CurrentTimeGCD())) -- - (DMG * cast) 
    end 
    
    -- PvP: Greater Heal 
    if SPELLID == "GreaterHeal" then   
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0  
        local cast = Env.CastTime(289666) + Env.CurrentTimeGCD()
        total = UnitHealthMax(UNIT) * variation + pre_heal + (HPS * cast) - (DMG * cast) 
    end 
    
    -- All 
    -- These spells doesn't relative for increasing heal buffs  
    -- Racials
    if SPELLID == "GiftofNaaru" then
        local pre_heal = UnitGetIncomingHeals(UNIT) or 0
        total = UnitHealthMax("player") * 0.2 * variation + (HPS * 5) + pre_heal - (DMG * 5)
    end 
    
    return DifficultHP >= total, total 
end

