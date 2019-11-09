local function Thrash()
  if Unit("player"):HasBuffs(A.CatForm) then
    return A.ThrashCat;
  else
    return A.ThrashBear;
  end
end
