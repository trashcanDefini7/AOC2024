local input = {}

for line in io.lines('input.txt') do
    input[#input + 1] = line
end

local width = #input[1]
local height = #input

local function get_cell(x, y)
    return string.sub(input[y], x, x)
end

local function check_xmas(x, y)
    if get_cell(x, y) ~= 'A' then
        return false
    end

    local directions = { -1, 1 }
    
    for _, dx in ipairs(directions) do
        local c1 = get_cell(x + dx, y - 1)
        local c2 = get_cell(x - dx, y + 1)

        if not(c1 == 'M' and c2 == 'S' or c1 == 'S' and c2 == 'M') then
            return false
        end
    end

    return true
end

local xmas_count = 0

for y=2, height - 1 do
    for x=2, width - 1 do
        if check_xmas(x, y) then
            xmas_count = xmas_count + 1
        end
    end
end

print(xmas_count)
