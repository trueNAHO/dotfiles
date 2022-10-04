-- Merge two tables by inserting the elements from the second table at the end
-- of the first one.
return function(t1, t2)
    for _, v in pairs(t2) do table.insert(t1, v) end
    return t1
end
