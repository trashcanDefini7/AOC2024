local input = {}

for line in io.lines('input.txt') do
    input[#input+1] = line
end

local word = 'XMAS'
local width = #input[1]
local height = #input

local function check_direction(x, y, dx, dy)
    local end_x = x + dx * #word
    local end_y = y + dy * #word

    if end_x < 0 or end_y < 0 or end_x > width + 1 or end_y > height + 1 then
        return false
    end

    local index = 1

    while x ~= end_x or y ~= end_y do
        if string.sub(word, index, index) ~= string.sub(input[y], x, x) then
            return false
        end
    
        x = x + dx
        y = y + dy

        index = index + 1
    end

    return true
end

local xmas_count = 0

for y=1, height do
    for x=1, width do
        for i=-1, 1 do
            for j=-1, 1 do
                if (i ~= 0 or j ~= 0) and check_direction(x, y, i, j) then
                    xmas_count = xmas_count + 1
                end
            end
        end
    end
end

print(xmas_count)
