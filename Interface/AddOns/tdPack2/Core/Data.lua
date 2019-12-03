-- Data.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/21/2019, 2:00:49 AM

---@type ns
local ns = select(2, ...)

---- NS
local L = ns.L

---- WOW
local tinsert, tconcat = table.insert, table.concat

local function GenerateClickData(button, control, shift, alt)
    local sb = {}
    if control then
        tinsert(sb, 'Ctrl')
    end
    if shift then
        tinsert(sb, 'Shift')
    end
    if alt then
        tinsert(sb, 'Alt')
    end

    if button == 'LeftButton' then
        tinsert(sb, L['Left Click'])
    elseif button == 'RightButton' then
        tinsert(sb, L['Right Click'])
    end

    local name = tconcat(sb, '-')
    return {name = name, token = ns.GetClickToken(button, control, shift, alt)}
end

ns.CLICK_TOKENS = {
    LEFT = ns.GetClickToken('LeftButton'),
    RIGHT = ns.GetClickToken('RightButton'),
    CONTROL_LEFT = ns.GetClickToken('LeftButton', 1),
    SHIFT_LEFT = ns.GetClickToken('LeftButton', nil, 1),
    ALT_LEFT = ns.GetClickToken('LeftButton', nil, nil, 1),
    CONTROL_RIGHT = ns.GetClickToken('RightButton', 1),
    SHIFT_RIGHT = ns.GetClickToken('RightButton', nil, 1),
    ALT_RIGHT = ns.GetClickToken('RightButton', nil, nil, 1),
    CONTROL_SHIFT_LEFT = ns.GetClickToken('LeftButton', 1, 1),
    CONTROL_ALT_LEFT = ns.GetClickToken('LeftButton', 1, nil, 1),
    SHIFT_ALT_LEFT = ns.GetClickToken('LeftButton', nil, 1, 1),
    CONTROL_SHIFT_RIGHT = ns.GetClickToken('RightButton', 1, 1),
    CONTROL_ALT_RIGHT = ns.GetClickToken('RightButton', 1, nil, 1),
    SHIFT_ALT_RIGHT = ns.GetClickToken('RightButton', nil, 1, 1),
    CONTROL_SHIFT_ALT_LEFT = ns.GetClickToken('LeftButton', 1, 1, 1),
    CONTROL_SHIFT_ALT_RIGHT = ns.GetClickToken('RightButton', 1, 1, 1),
}

ns.CLICK_LIST = {
    GenerateClickData('LeftButton'), --
    GenerateClickData('RightButton'), --
    GenerateClickData('LeftButton', 1), --
    GenerateClickData('RightButton', 1), --
    GenerateClickData('LeftButton', nil, 1), --
    GenerateClickData('RightButton', nil, 1), --
    GenerateClickData('LeftButton', nil, nil, 1), --
    GenerateClickData('RightButton', nil, nil, 1), --
    GenerateClickData('LeftButton', 1, 1), --
    GenerateClickData('RightButton', 1, 1), --
    GenerateClickData('LeftButton', 1, nil, 1), --
    GenerateClickData('RightButton', 1, nil, 1), --
    GenerateClickData('LeftButton', nil, 1, 1), --
    GenerateClickData('RightButton', nil, 1, 1), --
    GenerateClickData('LeftButton', 1, 1, 1), --
    GenerateClickData('RightButton', 1, 1, 1), --
}
