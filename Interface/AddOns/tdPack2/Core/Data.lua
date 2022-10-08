-- Data.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/21/2019, 2:00:49 AM
---@type ns
local ns = select(2, ...)

---- NS
local L = ns.L

---- LUA
local pairs, ipairs = pairs, ipairs

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

ns.ITEM_TAGS = {}

local function NewTag(tag, ids)
    ns.ITEM_TAGS[tag] = ids
    ids.locale = true
end

local function NewTag2(tag, ids)
    ns.ITEM_TAGS[tag] = ids
end

--[=[@build<2@
---- TradeGoods
NewTag('Cloth', {
    14342, 14256, 14341, 14227, 14048, 14047, 4338, 3182, 2592, 4306, 2589, 10285, 4339, 4337, 2320, 4305, 2321, 2997,
    8343, 2996, 4291,
})
NewTag('Leather', {
    12810, 15416, 15407, 15409, 8170, 15417, 17012, 8150, 8167, 4234, 4304, 8165, 7392, 2319, 4461, 5784, 15410, 8154,
    2318, 15419, 4235, 15414, 783, 15415, 15412, 5785, 8171, 5082, 4232, 7286, 15408, 8172, 4289, 20381, 4233, 4236,
    2934, 4231, 19767, 8169, 17967, 19768, --
    --
    7428, 8368, 15423, 15422, 15423,
})
NewTag('Metal & Stone', {
    12360, 17771, 11371, 18562, 12809, 10620, 12655, 7912, 2836, 11370, 18567, 12359, 3858, 17203, 12644, 3859, 12365,
    3857, 2838, 2772, 2841, 2775, 2835, 3860, 7911, 2771, 3486, 6037, 2840, 3478, 3575, 2770, 2842, 7966, 3577, 3470,
    2776, 3576, 22203, 22202, 11099, 3861,
})
NewTag('Cooking', {
    13759, 7974, 12207, 12208, 13888, 21153, 5504, 12203, 6308, 21071, 13889, 12037, 4603, 8365, 12205, 13754, 13760,
    5503, 20424, 13756, 3731, 2677, 3685, 2674, 13758, 12202, 3173, 3712, 3174, 3404, 769, 2673, 12184, 3667, 2672,
    6361, 1015, 730, 5465, 6289, 6291, 21024, 6889, 6362, 2251, 5471, 1468, 12206, 3172, 2675, 3730, 8959, 5469, 5470,
    5466, 729, 6303, 1080, 4655, 723, 5468, 2886, 2924, 731, 12223, 12204, 5467, 6317, --
    --
    1081,
})
NewTag('Herb', {
    13468, 13463, 13465, 3819, 8845, 13466, 8846, 8838, 8831, 8839, 4625, 3821, 3818, 13467, 2452, 13464, 3369, 8153,
    3820, 3355, 8836, 19726, 3357, 3358, 3356, 2450, 2453, 785, 2449, 2447, 19727, 765,
})
NewTag('Elemental', {7068, 7067, 7080, 7082, 12803, 7078, 7076, 7070, 7077, 10286, 7069, 7972, 12808, 7079, 7075, 7081})
NewTag('Enchanting', {
    16203, 16206, 14344, 6338, 16204, 14343, 16202, 11128, 16207, 10940, 6217, 11144, 10938, 6218, 10939, 6339, 11145,
    11130, 6374, 6216, 20725, 11177, 11176, 11175, 11174, 11178, 11083, 11137, 10998, 11082, 11135, 11134, 10978, 11139,
    11084, 11138,
})
NewTag('Jewelry', {12363, 11382, 12361, 12800, 7910, 12364, 12799, 1206, 1529, 1210, 7909, 1705, 3864, 818, 774})
---- Others
NewTag('Mount', {
    1041, 1132, 1133, 1134, 12302, 12303, 12325, 12326, 12327, 12330, 12351, 12353, 12354, 13086, 13317, 13321, 13322,
    13323, 13324, 13325, 13326, 13327, 13328, 13329, 13331, 13332, 13333, 13334, 13335, 14062, 15277, 15290, 15292,
    15293, 16338, 16339, 16343, 16344, 18241, 18242, 18243, 18244, 18245, 18246, 18247, 18248, 18766, 18767, 18768,
    18772, 18773, 18774, 18776, 18777, 18778, 18785, 18786, 18787, 18788, 18789, 18790, 18791, 18793, 18794, 18795,
    18796, 18797, 18798, 18902, 19029, 19030, 19872, 19902, 20221, 21176, 21218, 21321, 21323, 21324, 21736, 23193,
    23720, 2411, 2413, 2414, 2415, 5655, 5656, 5663, 5665, 5668, 5864, 5872, 5873, 5874, 5875, 8563, 8583, 8586, 8588,
    8589, 8590, 8591, 8592, 8595, 8627, 8628, 8629, 8630, 8631, 8632, 8633, 875, 901,
})
NewTag('Pet', {
    20769, 8499, 10822, 8494, 8498, 8491, 8492, 11474, 10398, 8489, 8490, 13584, 8485, 19450, 13583, 11023, 22235,
    23713, 22780, 8497, 12264, 8500, 10394, 8501, 8495, 13582, 8496, 8488, 12529, 8486, 21308, 12565, 23007, 8487,
    11026, 11110, 10360, 10392, 11027, 21309, 23015, 10393, 23002, 20371, 23083, 21305, 11903, 21168, 19054, 21301,
    19055, 23712, 22114, 10361, 20651, 18964, 22781, 18963, 18966, 18965, 18967,
})
--@end-build<2@]=]
-- @build>2@

NewTag2(GetItemSubClassInfo(LE_ITEM_CLASS_MISCELLANEOUS, LE_ITEM_MISCELLANEOUS_MOUNT), {
    34061, -- [涡轮加速飞行器控制台]
    34060, -- [飞行器控制台]
    33189, -- [摇摇晃晃的魔法扫帚]
    21176, -- [黑色其拉共鸣水晶]
    23720, -- [乌龟坐骑]
})
NewTag2(GetItemSubClassInfo(LE_ITEM_CLASS_MISCELLANEOUS, LE_ITEM_MISCELLANEOUS_COMPANION_PET), {
    11110, 11474, 11825, 11826, 12264, 12529, 13582, 13583, 13584, 180089, 19054, 19055, 20371, 20651, 21026, 21301,
    21305, 21308, 21309, 22114, 22235, 22780, 22781, 23002, 23007, 23015, 23083, 23712, 23713, 25535, 27445, 30360,
    31665, 31760, 32233, 32465, 32498, 32588, 32616, 32617, 32622, 33154, 33993, 34425, 34518, 34519, 34955, 37297,
    37298, 39656, 5332,
})
-- @end-build>2@

ns.ITEM_TAG_SETS = {}
do
    for tag, items in pairs(ns.ITEM_TAGS) do
        for _, id in ipairs(items) do
            if items.locale then
                ns.ITEM_TAG_SETS[id] = L['ITEM_TAG: ' .. tag]
            else
                ns.ITEM_TAG_SETS[id] = tag
            end
        end
    end
end
