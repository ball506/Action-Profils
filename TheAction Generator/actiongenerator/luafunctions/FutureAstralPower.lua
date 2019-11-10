local function FutureAstralPower()
  local AstralPower=Player:AstralPower()
  if not Player:IsCasting() then
    return AstralPower
  else
    if Player:IsCasting(A.NewnMoon) then
      return AstralPower + 10
    elseif Player:IsCasting(A.HalfMoon) then
      return AstralPower + 20
    elseif Player:IsCasting(A.FullMoon) then
      return AstralPower + 40
    elseif Player:IsCasting(A.StellarFlare) then
      return AstralPower + 8
    elseif Player:IsCasting(A.SolarWrath) then
      return AstralPower + 8
    elseif Player:IsCasting(A.LunarStrike) then
      return AstralPower + 12
    else
      return AstralPower
    end
  end
end
