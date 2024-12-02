local left = {}
local right = {}

local function parseLine(line)
    local result = {}

    for word in line:gmatch('%S+') do
        result[#result+1] = word
    end

    return tonumber(result[1]), tonumber(result[2])
end

for line in io.lines('input.txt') do
    local lhs, rhs = parseLine(line)
    left[#left + 1] = lhs
    right[#right + 1] = rhs
end

function table.reverseSort(tbl)
    table.sort(tbl, function(lhs, rhs) return lhs > rhs end)
end

table.reverseSort(left)
table.reverseSort(right)

local sum = 0

for i, v in ipairs(left) do
    sum = sum + math.abs(v - right[i])
end

print(sum)
