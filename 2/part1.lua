local function parseLine(line)
    local result = {}

    for word in line:gmatch('%S+') do
        result[#result+1] = tonumber(word)
    end

    return result
end

local reports = {}

for line in io.lines('input.txt') do
    reports[#reports + 1] = parseLine(line)
end

local function isSafe(report)
    local increasing = report[1] < report[2]

    for j=1,#report-1 do
        if (report[j] < report[j + 1]) ~= increasing then
            return false
        end

        local diff = math.abs(report[j + 1] - report[j])

        if diff < 1 or diff > 3 then
            return false
        end
    end

    return true
end

local safe_count = 0

for _, report in ipairs(reports) do
    if isSafe(report) then
        safe_count = safe_count + 1
    end
end

print(safe_count)
