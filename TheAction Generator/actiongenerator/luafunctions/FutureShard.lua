local function FutureShard ()
  local Shard = Player:SoulShards()
  if not Player:IsCasting() then
    return Shard
  else
    if Player:IsCasting(A.UnstableAffliction) 
        or Player:IsCasting(A.SeedOfCorruption) then
      return Shard - 1
    elseif Player:IsCasting(A.SummonDoomGuard) 
        or Player:IsCasting(A.SummonDoomGuardSuppremacy) 
        or Player:IsCasting(A.SummonInfernal) 
        or Player:IsCasting(A.SummonInfernalSuppremacy) 
        or Player:IsCasting(A.GrimoireFelhunter) 
        or Player:IsCasting(A.SummonFelhunter) then
      return Shard - 1
    else
      return Shard
    end
  end
end
