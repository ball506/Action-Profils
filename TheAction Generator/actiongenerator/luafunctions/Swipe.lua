local function Swipe()
  if Unit("player"):HasBuffs(A.CatForm) then
    return A.SwipeCat;
  else
    return A.SwipeBear;
  end
end
