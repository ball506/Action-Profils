A.ExecuteDefault    = 163201
A.ExecuteMassacre   = 281000

local function UpdateExecuteID()
    A.Execute = A.Massacre:IsSpellLearned() and A.ExecuteMassacre or A.ExecuteDefault
end
