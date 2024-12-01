local file = io.open('input.txt', 'r')
local left = {}
local right = {}

function parseLine(line)
    local result = {}

    for word in line:gmatch("%S+") do
        result[#result+1] = word
    end

    return tonumber(result[1]), tonumber(result[2])
end

for line in file.lines(file) do
    local lhs, rhs = parseLine(line)
    left[#left + 1] = lhs
    right[#right + 1] = rhs
end

table.sort(left)
table.sort(right)

function count_occurences(array)
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

local left_counts = count_occurences(left)
local right_counts = count_occurences(right)

local sum = 0

for i, v in pairs(left_counts) do
    if right_counts[i] then
        sum = sum + right_counts[i] * i * v
    end
end

print(sum)
