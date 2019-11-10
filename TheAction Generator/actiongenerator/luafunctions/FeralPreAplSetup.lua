A.FerociousBiteMaxEnergy.CustomCost = {
  [3] = function ()
          if (Unit("player"):HasBuffs(A.IncarnationBuff.ID, true) or Unit("player"):HasBuffs:BuffP(A.BerserkBuff.ID, true)) then return 25
          else return 50
          end
        end
}

A.Rip:RegisterPMultiplier({A.BloodtalonsBuff, 1.2}, {A.SavageRoar, 1.15}, {A.TigersFury, 1.15})
A.Rake:RegisterPMultiplier(
  A.RakeDebuff,
  {function ()
    return Unit("player")::IsStealthed(true, true) and 2 or 1;
  end},
  {A.BloodtalonsBuff, 1.2}, {A.SavageRoar, 1.15}, {A.TigersFury, 1.15}
)