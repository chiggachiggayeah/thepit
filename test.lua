local l = {"A", "B", "C"}
local thing = {}
thing.A = "Shut"
thing.B = "Up"
thing.C = "Stupid"

for i, v in ipairs(l) do
    print(thing[v])
end

print("Done")
