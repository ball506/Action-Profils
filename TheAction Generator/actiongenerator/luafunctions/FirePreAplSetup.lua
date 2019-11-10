A.PhoenixFlames:RegisterInFlight();
A.Pyroblast:RegisterInFlight(A.CombustionBuff);
A.Fireball:RegisterInFlight(A.CombustionBuff);

function A.Firestarter:ActiveStatus()
    return (A.Firestarter:IsSpellLearned() and (Unit(unit):HealthPercent() > 90)) and 1 or 0
end

function A.Firestarter:ActiveRemains()
    return A.Firestarter:IsSpellLearned() and ((Unit(unit):HealthPercent() > 90) and Unit(unit):TimeToDieX(90, 3) or 0)
end