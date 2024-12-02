local left = {}
local right = {}

local function parseLine(line)
    local result = {}

    for word in line:gmatch("%S+") do
        result[#result+1] = word
    end

    return tonumber(result[1]), tonumber(result[2])
end

for line in io.lines('input.txt') do
    local lhs, rhs = parseLine(line)
    left[#left + 1] = lhs
    right[#right + 1] = rhs
end

table.sort(left)
table.sort(right)

local function countOccurences(array)
    local counts = {}

    for _, v in ipairs(array) do
        if counts[v] then
            counts[v] = counts[v] + 1
        else
            counts[v] = 1
        end
    end

    return counts
end

local left_counts = countOccurences(left)
local right_counts = countOccurences(right)

local sum = 0

for i, v in pairs(left_counts) do
    if right_counts[i] then
        sum = sum + right_counts[i] * i * v
    end
end

print(sum)
