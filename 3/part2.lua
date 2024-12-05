STATE_NEW_TOKEN = 1
STATE_PARSE_INT = 2
STATE_PARSE_MUL = 3
STATE_PARSE_DO = 4

local file = io.open('input.txt', 'r')

if file == nil then
    print('can not open the input.txt file')
    return
end

local input = file:read('a')

local buffer = ''
local currentState = STATE_NEW_TOKEN
local nextState = currentState
local numbers = {}
local sum = 0
local canMultiply = true

for i=0, #input do
    local c = string.sub(input, i, i)

    if currentState == STATE_NEW_TOKEN then
        if c == 'm' and canMultiply then
            nextState = STATE_PARSE_MUL
        elseif c == 'd' then
            nextState = STATE_PARSE_DO
        end

        buffer = c
    else
        if currentState == STATE_PARSE_MUL then
            if c == 'u' or c == 'l' or c == '(' then
                buffer = buffer .. c
            else
                nextState = STATE_NEW_TOKEN
            end

            if buffer == 'mul(' then
                buffer = ''
                nextState = STATE_PARSE_INT
            end
        elseif currentState == STATE_PARSE_INT then
            local digit = tonumber(c, 10)
            
            if digit == nil then
                if c == ',' then
                    if #numbers == 2 then
                        nextState = STATE_NEW_TOKEN
                    else
                        numbers[#numbers+1] = tonumber(buffer, 10)
                        buffer = ''
                        nextState = STATE_PARSE_INT
                    end
                elseif c == ')' then
                    local n = tonumber(buffer, 10)

                    if n ~= nil then
                        sum = sum + numbers[1] * n
                    end
                    
                    numbers = {}
                    nextState = STATE_NEW_TOKEN
                else
                    numbers = {}
                    nextState = STATE_NEW_TOKEN
                end
            else
                buffer = buffer .. c
            end
        elseif currentState == STATE_PARSE_DO then
            if c == 'o' or c == 'n' or c == '\'' or c == 't' or c == '(' or c == ')' then
                buffer = buffer .. c
            else
                nextState = STATE_NEW_TOKEN
            end

            if buffer == 'do()' then
                canMultiply = true
                nextState = STATE_NEW_TOKEN
            elseif buffer == 'don\'t()' then
                canMultiply = false
                nextState = STATE_NEW_TOKEN
            end
        end
    end

    currentState = nextState
end

print(sum)
