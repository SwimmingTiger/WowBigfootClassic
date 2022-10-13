local tbl_sort, select, string_lower = table.sort, select, string.lower
local GetLocale = GetLocale
local GetSpellInfo = GetSpellInfo

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L

Gladdy.RACES = {"Scourge", "BloodElf", "Tauren", "Orc", "Troll", "NightElf", "Draenei", "Human", "Gnome", "Dwarf"}
tbl_sort(Gladdy.RACES)

local RACE_ICON_TCOORDS = {
    ["HUMAN_MALE"] = { 0, 0.125, 0, 0.25 },
    ["DWARF_MALE"] = { 0.125, 0.25, 0, 0.25 },
    ["GNOME_MALE"] = { 0.25, 0.375, 0, 0.25 },
    ["NIGHTELF_MALE"] = { 0.375, 0.5, 0, 0.25 },

    ["TAUREN_MALE"] = { 0, 0.125, 0.25, 0.5 },
    ["SCOURGE_MALE"] = { 0.125, 0.25, 0.25, 0.5 },
    ["TROLL_MALE"] = { 0.25, 0.375, 0.25, 0.5 },
    ["ORC_MALE"] = { 0.375, 0.5, 0.25, 0.5 },

    ["HUMAN_FEMALE"] = { 0, 0.125, 0.5, 0.75 },
    ["DWARF_FEMALE"] = { 0.125, 0.25, 0.5, 0.75 },
    ["GNOME_FEMALE"] = { 0.25, 0.375, 0.5, 0.75 },
    ["NIGHTELF_FEMALE"] = { 0.375, 0.5, 0.5, 0.75 },

    ["TAUREN_FEMALE"] = { 0, 0.125, 0.75, 1.0 },
    ["SCOURGE_FEMALE"] = { 0.125, 0.25, 0.75, 1.0 },
    ["TROLL_FEMALE"] = { 0.25, 0.375, 0.75, 1.0 },
    ["ORC_FEMALE"] = { 0.375, 0.5, 0.75, 1.0 },

    ["BLOODELF_MALE"] = { 0.5, 0.625, 0.25, 0.5 },
    ["BLOODELF_FEMALE"] = { 0.5, 0.625, 0.75, 1.0 },

    ["DRAENEI_MALE"] = { 0.5, 0.625, 0, 0.25 },
    ["DRAENEI_FEMALE"] = { 0.5, 0.625, 0.5, 0.75 },
}

local arenaTimer = {
    ["default"] = {
        [60] = "One minute until the Arena battle begins!",
        [30] = "Thirty seconds until the Arena battle begins!",
        [15] = "Fifteen seconds until the Arena battle begins!",
        [0] = "The Arena battle has begun!",
    },
    ["esES"] = {
        [60] = "¡Un minuto hasta que dé comienzo la batalla en arena!",
        [30] = "¡Treinta segundos hasta que comience la batalla en arena!",
        [15] = "¡Quince segundos hasta que comience la batalla en arena!",
        [0] = "¡La batalla en arena ha comenzado!",
    },
    ["ptBR"] = {
        [60] = "Um minuto até a batalha na Arena começar!",
        [30] = "Trinta segundos até a batalha na Arena começar!",
        [15] = "Quinze segundos até a batalha na Arena começar!",
        [0] = "A batalha na Arena começou!",
    },
    ["deDE"] = {
        [60] = "Noch eine Minute bis der Arenakampf beginnt!",
        [30] = "Noch dreißig Sekunden bis der Arenakampf beginnt!",
        [15] = "Noch fünfzehn Sekunden bis der Arenakampf beginnt!",
        [0] = "Der Arenakampf hat begonnen!",
    },
    ["frFR"] = {
        [60] = "Le combat d'arène commence dans une minute\194\160!",
        [30] = "Le combat d'arène commence dans trente secondes\194\160!",
        [15] = "Le combat d'arène commence dans quinze secondes\194\160!",
        [0] = "Le combat d'arène commence\194\160!",
    },
    ["ruRU"] = {
        [60] = "Одна минута до начала боя на арене!",
        [30] = "Тридцать секунд до начала боя на арене!",
        [15] = "До начала боя на арене осталось 15 секунд.",
        [0] = "Бой начался!",
    },
    ["itIT"] = { -- TODO
        -- Beta has no itIT version available?
    },
    ["koKR"] = {
        [60] = "투기장 전투 시작 1분 전입니다!",
        [30] = "투기장 전투 시작 30초 전입니다!",
        [15] = "투기장 전투 시작 15초 전입니다!",
        [0] = "투기장 전투가 시작되었습니다!",
    },
    ["zhCN"] = {
        [60] = "竞技场战斗将在一分钟后开始！",
        [30] = "竞技场战斗将在三十秒后开始！",
        [15] = "竞技场战斗将在十五秒后开始！",
        [0] = "竞技场的战斗开始了！",
    },
    ["zhTW"] = {
        [60] = "1分鐘後競技場戰鬥開始!",
        [30] = "30秒後競技場戰鬥開始!",
        [15] = "15秒後競技場戰鬥開始!",
        [0] = "競技場戰鬥開始了!",
    },
}
arenaTimer["esMX"] = arenaTimer["esES"]
arenaTimer["ptPT"] = arenaTimer["ptBR"]

function Gladdy:GetArenaTimer()
    if arenaTimer[GetLocale()] then
        return arenaTimer[GetLocale()]
    else
        return arenaTimer["default"]
    end
end

Gladdy.legacy = {
    castBarPos = "LEFT",
    buffsCooldownPos = "TOP",
    buffsBuffsCooldownPos = "BOTTOM",
    classIconPos = "LEFT",
    ciAnchor = "healthBar",
    ciPos = "TOP",
    cooldownYPos = "TOP",
    cooldownXPos = "LEFT",
    drCooldownPos = "RIGHT",
    racialAnchor = "trinket",
    racialPos = "RIGHT",
    trinketPos = "RIGHT",
    padding = 1,
    growUp = false,
}

Gladdy.newDefaults = {
    ["bottomMargin"] = 94.99996948242188,
    ["newLayout"] = true,
    Pets = {
        ["petYOffset"] = -81.99993896484375,
        ["petXOffset"] = 181,
    },
    ClassIcon = {
        ["classIconXOffset"] = -74.90008544921875,
    },
    Racial = {
        ["racialXOffset"] = 255.9000244140625,
    },
    Trinket = {
        ["trinketXOffset"] = 182,
    },
    ["Combat Indicator"] = {
        ["ciXOffset"] = 79.99993896484375,
        ["ciYOffset"] = -10.99993896484375,
    },
    Cooldowns = {
        ["cooldownYOffset"] = 31,
    },
    ["Buffs and Debuffs"] = {
        ["buffsBuffsXOffset"] = 29,
        ["buffsBuffsYOffset"] = -82.99993896484375,
        ["buffsXOffset"] = 29,
        ["buffsYOffset"] = 62.00006103515625,
    },
    Diminishings = {
        ["drXOffset"] = 329.7999877929688,
        ["drYOffset"] = -22.5,
    },
    ["Cast Bar"] = {
        ["castBarXOffset"] = -235.900146484375,
        ["castBarYOffset"] = -30.5,
    },
}

Gladdy.frameStrata = {
    BACKGROUND = L["Background"] .. "(0)",
    LOW = L["Low"] .. "(1)",
    MEDIUM = L["Medium"] .. "(2)",
    HIGH = L["High"] .. "(3)",
    DIALOG = L["Dialog"] .. "(4)",
    FULLSCREEN = L["Fullscreen"] .. "(5)",
    FULLSCREEN_DIALOG = L["Fullscreen Dialog"] .. "(6)",
    TOOLTIP = L["Tooltip"] .. "(7)",
}

Gladdy.frameStrataSorting = {
    [1] = "BACKGROUND",
    [2] = "LOW",
    [3] = "MEDIUM",
    [4] = "HIGH",
    [5] = "DIALOG",
    [6] = "FULLSCREEN",
    [7] = "FULLSCREEN_DIALOG",
    [8] = "TOOLTIP",
}

Gladdy.exceptionNames = {
    [50334] = (GetSpellInfo(50334) or "...") .. " Feral", -- Berserk
    [30151] = select(1, GetSpellInfo(30151)) .. " Felguard", -- Intercept
    [30194] = select(1, GetSpellInfo(30151)) .. " Felguard", -- Intercept
    [30198] = select(1, GetSpellInfo(30151)) .. " Felguard", -- Intercept
    [47996] = select(1, GetSpellInfo(30151)) .. " Felguard", -- Intercept
    [31117] = select(1, GetSpellInfo(30405)) .. " Silence", -- Unstable Affliction Silence
    [43523] = select(1, GetSpellInfo(30405)) .. " Silence",
    [24131] = select(1, GetSpellInfo(19386)) .. " Dot", -- Wyvern Sting Dot
    [24134] = select(1, GetSpellInfo(19386)) .. " Dot",
    [24135] = select(1, GetSpellInfo(19386)) .. " Dot",
    [27069] = select(1, GetSpellInfo(19386)) .. " Dot",
    [49009] = select(1, GetSpellInfo(19386)) .. " Dot",
    [49010] = select(1, GetSpellInfo(19386)) .. " Dot",
    [19975] = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)), -- Entangling Roots Nature's Grasp
    [19974] = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)),
    [19973] = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)),
    [19972] = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)),
    [19971] = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)),
    [19971] = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)),
    [27010] = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)),
    [53312] = select(1, GetSpellInfo(27010)) .. " " .. select(1, GetSpellInfo(16689)),
}

local dispelTypeColors = {}
dispelTypeColors["none"] = { r = 0.80, g = 0, b = 0, a = 1 }
dispelTypeColors["magic"] = { r = 0.20, g = 0.60, b = 1.00, a = 1 }
dispelTypeColors["curse"] = { r = 0.60, g = 0.00, b = 1.00, a = 1 }
dispelTypeColors["disease"] = { r = 0.60, g = 0.40, b = 0, a = 1 }
dispelTypeColors["poison"] = { r = 0.00, g = 0.60, b = 0, a = 1 }
dispelTypeColors["immune"] = { r = 1.00, g = 0.02, b = 0.99, a = 1 }
dispelTypeColors["enrage"] = dispelTypeColors["none"]
dispelTypeColors["form"] = dispelTypeColors["none"]
dispelTypeColors["aura"] = dispelTypeColors["none"]
dispelTypeColors[""] = dispelTypeColors["none"]

function Gladdy:GetDispelTypeColors()
    return dispelTypeColors
end


--[[schoolColoring = {
    [SCHOOL_MASK_NONE]	= {a=1.0,r=1.00,g=1.00,b=1.00};
    [SCHOOL_MASK_PHYSICAL]	= {a=1.0,r=1.00,g=1.00,b=0.00};
    [SCHOOL_MASK_HOLY] 	= {a=1.0,r=1.00,g=0.90,b=0.50};
    [SCHOOL_MASK_FIRE] 	= {a=1.0,r=1.00,g=0.50,b=0.00};
    [SCHOOL_MASK_NATURE] 	= {a=1.0,r=0.30,g=1.00,b=0.30};
    [SCHOOL_MASK_FROST] 	= {a=1.0,r=0.50,g=1.00,b=1.00};
    [SCHOOL_MASK_SHADOW] 	= {a=1.0,r=0.50,g=0.50,b=1.00};
    [SCHOOL_MASK_ARCANE] 	= {a=1.0,r=1.00,g=0.50,b=1.00};

SCHOOL_MASK_NONE		= 0x00;
SCHOOL_MASK_PHYSICAL	= 0x01;
SCHOOL_MASK_HOLY		= 0x02;
SCHOOL_MASK_FIRE		= 0x04;
SCHOOL_MASK_NATURE		= 0x08;
SCHOOL_MASK_FROST		= 0x10;
SCHOOL_MASK_SHADOW		= 0x20;
SCHOOL_MASK_ARCANE		= 0x40;
--]]
local spellSchoolColors = {}
spellSchoolColors[1] = { r = 1, g = 1, b = 0, a = 1, type = "Physical" } -- "physical" 255, 255, 0
spellSchoolColors[2] = { r = 1, g = 0.901, b = 0.501, a = 1, type = "Holy" } --"holy" -- 255, 230, 128
spellSchoolColors[4] = { r = 1, g = 0.501, b = 0, a = 1, type = "Fire" } --"fire" --  255, 128, 0
spellSchoolColors[8] = { r = 0.302, g = 1, b = 0.302, a = 1, type = "Nature" } --"nature" --  77, 255, 77
spellSchoolColors[16] = { r = 0.501, g = 1, b = 1, a = 1, type = "Frost" } --"frost" -- 128, 255, 255
spellSchoolColors[32] = { r = 0.501, g = 0.501, b = 1, a = 1, type = "Shadow" } --"shadow" --128, 128, 255
spellSchoolColors[64] = { r = 1, g = 0.501, b = 1, a = 1, type = "Arcane" } --"arcane" -- 255, 128, 255
spellSchoolColors["unknown"] = { r = 0, g = 0, b = 0, a = 1, type = "Unknown" } --"unknown spell school"

function Gladdy:GetSpellSchoolColors()
    return spellSchoolColors
end

---------------------
-- TRINKET STUFF
---------------------

local pvpTrinkets = { -- [itemID] = cd in ms
    --wotlk
    [59752] = 120000,
    [51377] = 120000,
    [51378] = 120000,
    [46083] = 120000,
    [46085] = 120000,
    [46081] = 120000,
    [46084] = 120000,
    [46082] = 120000,
    [42122] = 120000,
    [42123] = 120000,
    --tbc
    [37864] = 120000,
    [37865] = 120000,
    [28235] = 120000,
    [30348] = 120000,
    [28238] = 120000,
    [30351] = 120000,
    [28236] = 120000,
    [30349] = 120000,
    [28234] = 120000,
    [28237] = 120000,
    [30350] = 120000,
    [28240] = 120000,
    [28243] = 120000,
    [30345] = 120000,
    [28241] = 120000,
    [30343] = 120000,
    [28239] = 120000,
    [30346] = 120000,
    [28242] = 120000,
    [30344] = 120000,
    [29593] = 120000,
    [29593] = 300000,
    [18859] = 300000,
    [18857] = 300000,
    [18864] = 300000,
    [18854] = 300000,
    [18862] = 300000,
    [18858] = 300000,
    [18856] = 300000,
    [18863] = 300000,
    [18834] = 300000,
    [18851] = 300000,
    [18845] = 300000,
    [18852] = 300000,
    [29592] = 300000,
    [18850] = 300000,
    [18846] = 300000,
    [18853] = 300000,
}

function Gladdy:GetPvpTrinkets()
    return pvpTrinkets
end

---------------------
-- TOTEM STUFF
---------------------

local totemData = {
    -- Fire
    [string_lower("Searing Totem")] = {id = 3599,texture = select(3, GetSpellInfo(3599)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Flametongue Totem")] = {id = 8227,texture = select(3, GetSpellInfo(8227)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Magma Totem")] = {id = 8190,texture = select(3, GetSpellInfo(8190)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    [string_lower("Fire Nova Totem")] = {id = 1535,texture = select(3, GetSpellInfo(1535)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = { cd = 4, once = true }},
    [string_lower("Totem of Wrath")] = {id = 30706,texture = select(3, GetSpellInfo(30706)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Fire Elemental Totem")] = {id = 32982,texture = select(3, GetSpellInfo(32982)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Frost Resistance Totem")] = {id = 8181,texture = select(3, GetSpellInfo(8181)), color = {r = 0, g = 0, b = 0, a = 1}},
    -- Water
    [string_lower("Fire Resistance Totem")] = {id = 8184,texture = select(3, GetSpellInfo(8184)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Disease Cleansing Totem")] = {id = 8170,texture = select(3, GetSpellInfo(8170)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 5},
    [string_lower("Healing Stream Totem")] = {id = 5394,texture = select(3, GetSpellInfo(5394)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    [string_lower("Mana Tide Totem")] = {id = 16190,texture = select(3, GetSpellInfo(16190)), color = {r = 0.078, g = 0.9, b = 0.16, a = 1}, pulse = 3 },
    [string_lower("Mana Spring Totem")] = {id = 5675,texture = select(3, GetSpellInfo(5675)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    -- Earth
    [string_lower("Earthbind Totem")] = {id = 2484,texture = select(3, GetSpellInfo(2484)), color = {r = 0.5, g = 0.5, b = 0.5, a = 1}, pulse = 3},
    [string_lower("Stoneclaw Totem")] = {id = 5730,texture = select(3, GetSpellInfo(5730)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    [string_lower("Stoneskin Totem")] = {id = 8071,texture = select(3, GetSpellInfo(8071)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Strength of Earth Totem")] = {id = 8075,texture = select(3, GetSpellInfo(8075)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Earth Elemental Totem")] = {id = 33663,texture = select(3, GetSpellInfo(33663)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Tremor Totem")] = {id = 8143,texture = select(3, GetSpellInfo(8143)), color = {r = 1, g = 0.9, b = 0.1, a = 1}, pulse = 3},
    -- Air
    [string_lower("Grounding Totem")] = {id = 8177,texture = select(3, GetSpellInfo(8177)), color = {r = 0, g = 0.53, b = 0.92, a = 1}},
    [string_lower("Nature Resistance Totem")] = {id = 10595,texture = select(3, GetSpellInfo(10595)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Windfury Totem")] = {id = 8512,texture = select(3, GetSpellInfo(8512)), color = {r = 0.96, g = 0, b = 0.07, a = 1}},
    [string_lower("Sentry Totem")] = {id = 6495, texture = select(3, GetSpellInfo(6495)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Wrath of Air Totem")] = {id = 3738,texture = select(3, GetSpellInfo(3738)), color = {r = 0, g = 0, b = 0, a = 1}},
}

local totemSpellIdToPulse = {
    [GetSpellInfo(totemData[string_lower("Earthbind Totem")].id)] = totemData[string_lower("Earthbind Totem")].pulse,
    [2484] = totemData[string_lower("Earthbind Totem")].pulse,
    [GetSpellInfo(totemData[string_lower("Tremor Totem")].id)] = totemData[string_lower("Tremor Totem")].pulse,
    [8143] = totemData[string_lower("Tremor Totem")].pulse,
    [GetSpellInfo(totemData[string_lower("Disease Cleansing Totem")].id)] = totemData[string_lower("Disease Cleansing Totem")].pulse,
    [8170] = totemData[string_lower("Disease Cleansing Totem")].pulse,
    [GetSpellInfo(totemData[string_lower("Fire Nova Totem")].id)] = totemData[string_lower("Fire Nova Totem")].pulse,
    [1535] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 1
    [8498] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 2
    [8499] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 3
    [11314] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 4
    [11315] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 5
    [25546] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 6
    [25547] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 7
    [GetSpellInfo(totemData[string_lower("Magma Totem")].id)] = totemData[string_lower("Magma Totem")].pulse,
    [8190] = totemData[string_lower("Magma Totem")].pulse, -- Rank 1
    [10585] = totemData[string_lower("Magma Totem")].pulse, -- Rank 2
    [10586] = totemData[string_lower("Magma Totem")].pulse, -- Rank 3
    [10587] = totemData[string_lower("Magma Totem")].pulse, -- Rank 4
    [25552] = totemData[string_lower("Magma Totem")].pulse, -- Rank 5
    [58731] = totemData[string_lower("Magma Totem")].pulse, -- Rank 6
    [58734] = totemData[string_lower("Magma Totem")].pulse, -- Rank 7
    [GetSpellInfo(totemData[string_lower("Healing Stream Totem")].id)] = totemData[string_lower("Healing Stream Totem")].pulse,
    [5394] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 1
    [6375] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 2
    [6377] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 3
    [10462] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 4
    [10463] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 5
    [25567] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 6
    [58755] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 7
    [58756] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 8
    [58757] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 9
    [GetSpellInfo(totemData[string_lower("Mana Tide Totem")].id)] = totemData[string_lower("Mana Tide Totem")].pulse,
    [16190] = totemData[string_lower("Mana Tide Totem")].pulse, -- Rank 1
    [GetSpellInfo(totemData[string_lower("Stoneclaw Totem")].id)] = totemData[string_lower("Stoneclaw Totem")].pulse,
    [5730] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 1
    [6390] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 2
    [6391] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 3
    [6392] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 4
    [10427] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 5
    [10428] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 6
    [25525] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 7
    [58580] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 8
    [58581] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 9
    [58582] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 10
}

local totemNpcIdsToTotemData = {
    --fire
    [2523] = totemData[string_lower("Searing Totem")],
    [3902] = totemData[string_lower("Searing Totem")],
    [3903] = totemData[string_lower("Searing Totem")],
    [3904] = totemData[string_lower("Searing Totem")],
    [7400] = totemData[string_lower("Searing Totem")],
    [7402] = totemData[string_lower("Searing Totem")],
    [15480] = totemData[string_lower("Searing Totem")],
    [31162] = totemData[string_lower("Searing Totem")],
    [31164] = totemData[string_lower("Searing Totem")],
    [31165] = totemData[string_lower("Searing Totem")],
    [21995] = totemData[string_lower("Searing Totem")],
    [22209] = totemData[string_lower("Searing Totem")],
    [22895] = totemData[string_lower("Searing Totem")],
    [22896] = totemData[string_lower("Searing Totem")],
    [34687] = totemData[string_lower("Searing Totem")],
    [36532] = totemData[string_lower("Searing Totem")],
    [43423] = totemData[string_lower("Searing Totem")],
    [67380] = totemData[string_lower("Searing Totem")],
    [73477] = totemData[string_lower("Searing Totem")],
    [79238] = totemData[string_lower("Searing Totem")],
    [22896] = totemData[string_lower("Searing Totem")],
    [84519] = totemData[string_lower("Searing Totem")],
    [110730] = totemData[string_lower("Searing Totem")],
    [132178] = totemData[string_lower("Searing Totem")],
    [9637] = totemData[string_lower("Searing Totem")],

    [5950] = totemData[string_lower("Flametongue Totem")],
    [6012] = totemData[string_lower("Flametongue Totem")],
    [7423] = totemData[string_lower("Flametongue Totem")],
    [10557] = totemData[string_lower("Flametongue Totem")],
    [15485] = totemData[string_lower("Flametongue Totem")],
    [31132] = totemData[string_lower("Flametongue Totem")],
    [31133] = totemData[string_lower("Flametongue Totem")],
    [31158] = totemData[string_lower("Flametongue Totem")],
    [42605] = totemData[string_lower("Flametongue Totem")],

    [5929] = totemData[string_lower("Magma Totem")],
    [7464] = totemData[string_lower("Magma Totem")],
    [7465] = totemData[string_lower("Magma Totem")],
    [7466] = totemData[string_lower("Magma Totem")],
    [15484] = totemData[string_lower("Magma Totem")],
    [31166] = totemData[string_lower("Magma Totem")],
    [31167] = totemData[string_lower("Magma Totem")],
    [32887] = totemData[string_lower("Magma Totem")],
    [42211] = totemData[string_lower("Magma Totem")],
    [71335] = totemData[string_lower("Magma Totem")],
    [71925] = totemData[string_lower("Magma Totem")],
    [73085] = totemData[string_lower("Magma Totem")],
    [73093] = totemData[string_lower("Magma Totem")],
    [73268] = totemData[string_lower("Magma Totem")],
    [88971] = totemData[string_lower("Magma Totem")],
    [97369] = totemData[string_lower("Magma Totem")],
    [98676] = totemData[string_lower("Magma Totem")],

    [5879] = totemData[string_lower("Fire Nova Totem")],
    [6110] = totemData[string_lower("Fire Nova Totem")],
    [6111] = totemData[string_lower("Fire Nova Totem")],
    [7844] = totemData[string_lower("Fire Nova Totem")],
    [7845] = totemData[string_lower("Fire Nova Totem")],
    [14662] = totemData[string_lower("Fire Nova Totem")],
    [15482] = totemData[string_lower("Fire Nova Totem")],
    [15483] = totemData[string_lower("Fire Nova Totem")],
    [24320] = totemData[string_lower("Fire Nova Totem")],
    [32775] = totemData[string_lower("Fire Nova Totem")],
    [32776] = totemData[string_lower("Fire Nova Totem")],

    [17539] = totemData[string_lower("Totem of Wrath")],
    [22970] = totemData[string_lower("Totem of Wrath")],
    [22971] = totemData[string_lower("Totem of Wrath")],
    [30652] = totemData[string_lower("Totem of Wrath")],
    [30653] = totemData[string_lower("Totem of Wrath")],
    [30654] = totemData[string_lower("Totem of Wrath")],

    [15439] = totemData[string_lower("Fire Elemental Totem")],
    [40830] = totemData[string_lower("Fire Elemental Totem")],
    [41337] = totemData[string_lower("Fire Elemental Totem")],
    [41346] = totemData[string_lower("Fire Elemental Totem")],
    [72301] = totemData[string_lower("Fire Elemental Totem")],

    [5926] = totemData[string_lower("Frost Resistance Totem")],
    [7412] = totemData[string_lower("Frost Resistance Totem")],
    [7413] = totemData[string_lower("Frost Resistance Totem")],
    [15486] = totemData[string_lower("Frost Resistance Totem")],
    [31171] = totemData[string_lower("Frost Resistance Totem")],
    [31172] = totemData[string_lower("Frost Resistance Totem")],

    -- Water
    [5927] = totemData[string_lower("Fire Resistance Totem")],
    [7424] = totemData[string_lower("Fire Resistance Totem")],
    [7425] = totemData[string_lower("Fire Resistance Totem")],
    [15487] = totemData[string_lower("Fire Resistance Totem")],
    [31169] = totemData[string_lower("Fire Resistance Totem")],
    [31170] = totemData[string_lower("Fire Resistance Totem")],

    [5924] = totemData[string_lower("Disease Cleansing Totem")],

    [3527] = totemData[string_lower("Healing Stream Totem")],
    [3906] = totemData[string_lower("Healing Stream Totem")],
    [3907] = totemData[string_lower("Healing Stream Totem")],
    [3908] = totemData[string_lower("Healing Stream Totem")],
    [3909] = totemData[string_lower("Healing Stream Totem")],
    [14664] = totemData[string_lower("Healing Stream Totem")],
    [15488] = totemData[string_lower("Healing Stream Totem")],
    [18235] = totemData[string_lower("Healing Stream Totem")],
    [31181] = totemData[string_lower("Healing Stream Totem")],
    [31182] = totemData[string_lower("Healing Stream Totem")],
    [31185] = totemData[string_lower("Healing Stream Totem")],
    [34686] = totemData[string_lower("Healing Stream Totem")],
    [36542] = totemData[string_lower("Healing Stream Totem")],
    [37810] = totemData[string_lower("Healing Stream Totem")],
    [38428] = totemData[string_lower("Healing Stream Totem")],
    [47077] = totemData[string_lower("Healing Stream Totem")],
    [72309] = totemData[string_lower("Healing Stream Totem")],
    [72457] = totemData[string_lower("Healing Stream Totem")],
    [73890] = totemData[string_lower("Healing Stream Totem")],
    [74433] = totemData[string_lower("Healing Stream Totem")],
    [97508] = totemData[string_lower("Healing Stream Totem")],
    [112567] = totemData[string_lower("Healing Stream Totem")],
    [120357] = totemData[string_lower("Healing Stream Totem")],
    [128539] = totemData[string_lower("Healing Stream Totem")],
    [132049] = totemData[string_lower("Healing Stream Totem")],

    [10467] = totemData[string_lower("Mana Tide Totem")],
    [11100] = totemData[string_lower("Mana Tide Totem")],
    [11101] = totemData[string_lower("Mana Tide Totem")],
    [17061] = totemData[string_lower("Mana Tide Totem")],

    [3573] = totemData[string_lower("Mana Spring Totem")],
    [7414] = totemData[string_lower("Mana Spring Totem")],
    [7415] = totemData[string_lower("Mana Spring Totem")],
    [7416] = totemData[string_lower("Mana Spring Totem")],
    [15304] = totemData[string_lower("Mana Spring Totem")],
    [15489] = totemData[string_lower("Mana Spring Totem")],
    [31186] = totemData[string_lower("Mana Spring Totem")],
    [31189] = totemData[string_lower("Mana Spring Totem")],
    [31190] = totemData[string_lower("Mana Spring Totem")],

    -- Earth
    [2630] = totemData[string_lower("Earthbind Totem")],
    [22486] = totemData[string_lower("Earthbind Totem")],
    [40233] = totemData[string_lower("Earthbind Totem")],
    [74737] = totemData[string_lower("Earthbind Totem")],
    [79155] = totemData[string_lower("Earthbind Totem")],

    [3579] = totemData[string_lower("Stoneclaw Totem")],
    [3911] = totemData[string_lower("Stoneclaw Totem")],
    [3912] = totemData[string_lower("Stoneclaw Totem")],
    [3913] = totemData[string_lower("Stoneclaw Totem")],
    [7398] = totemData[string_lower("Stoneclaw Totem")],
    [7399] = totemData[string_lower("Stoneclaw Totem")],
    [14870] = totemData[string_lower("Stoneclaw Totem")],
    [15478] = totemData[string_lower("Stoneclaw Totem")],
    [31120] = totemData[string_lower("Stoneclaw Totem")],
    [31121] = totemData[string_lower("Stoneclaw Totem")],
    [31122] = totemData[string_lower("Stoneclaw Totem")],
    [40258] = totemData[string_lower("Stoneclaw Totem")],
    [102402] = totemData[string_lower("Stoneclaw Totem")],

    [5873] = totemData[string_lower("Stoneskin Totem")],
    [5919] = totemData[string_lower("Stoneskin Totem")],
    [5920] = totemData[string_lower("Stoneskin Totem")],
    [7366] = totemData[string_lower("Stoneskin Totem")],
    [7367] = totemData[string_lower("Stoneskin Totem")],
    [7368] = totemData[string_lower("Stoneskin Totem")],
    [14663] = totemData[string_lower("Stoneskin Totem")],
    [15470] = totemData[string_lower("Stoneskin Totem")],
    [15474] = totemData[string_lower("Stoneskin Totem")],
    [18177] = totemData[string_lower("Stoneskin Totem")],
    [21994] = totemData[string_lower("Stoneskin Totem")],
    [31175] = totemData[string_lower("Stoneskin Totem")],
    [31176] = totemData[string_lower("Stoneskin Totem")],
    [36550] = totemData[string_lower("Stoneskin Totem")],
    [40267] = totemData[string_lower("Stoneskin Totem")],
    [41967] = totemData[string_lower("Stoneskin Totem")],

    [5874] = totemData[string_lower("Strength of Earth Totem")],
    [5921] = totemData[string_lower("Strength of Earth Totem")],
    [5922] = totemData[string_lower("Strength of Earth Totem")],
    [7403] = totemData[string_lower("Strength of Earth Totem")],
    [15464] = totemData[string_lower("Strength of Earth Totem")],
    [15479] = totemData[string_lower("Strength of Earth Totem")],
    [21992] = totemData[string_lower("Strength of Earth Totem")],
    [30647] = totemData[string_lower("Strength of Earth Totem")],
    [31129] = totemData[string_lower("Strength of Earth Totem")],
    [40266] = totemData[string_lower("Strength of Earth Totem")],

    [15430] = totemData[string_lower("Earth Elemental Totem")],
    [24649] = totemData[string_lower("Earth Elemental Totem")],
    [39387] = totemData[string_lower("Earth Elemental Totem")],
    [40247] = totemData[string_lower("Earth Elemental Totem")],
    [72307] = totemData[string_lower("Earth Elemental Totem")],

    [5913] = totemData[string_lower("Tremor Totem")],
    [41938] = totemData[string_lower("Tremor Totem")],
    [41939] = totemData[string_lower("Tremor Totem")],

    -- Air
    [5925] = totemData[string_lower("Grounding Totem")],
    [128537] = totemData[string_lower("Grounding Totem")],
    [136251] = totemData[string_lower("Grounding Totem")],

    [7467] = totemData[string_lower("Nature Resistance Totem")],
    [7468] = totemData[string_lower("Nature Resistance Totem")],
    [7469] = totemData[string_lower("Nature Resistance Totem")],
    [15490] = totemData[string_lower("Nature Resistance Totem")],
    [31173] = totemData[string_lower("Nature Resistance Totem")],
    [31174] = totemData[string_lower("Nature Resistance Totem")],

    [6112] = totemData[string_lower("Windfury Totem")],
    [7483] = totemData[string_lower("Windfury Totem")],
    [7484] = totemData[string_lower("Windfury Totem")],
    [14666] = totemData[string_lower("Windfury Totem")],
    [15496] = totemData[string_lower("Windfury Totem")],
    [15497] = totemData[string_lower("Windfury Totem")],
    [22897] = totemData[string_lower("Windfury Totem")],
    [41940] = totemData[string_lower("Windfury Totem")],
    [41941] = totemData[string_lower("Windfury Totem")],
    [80703] = totemData[string_lower("Windfury Totem")],
    [105690] = totemData[string_lower("Windfury Totem")],
    [133684] = totemData[string_lower("Windfury Totem")],

    [3968] = totemData[string_lower("Sentry Totem")],
    [28938] = totemData[string_lower("Sentry Totem")],
    [40187] = totemData[string_lower("Sentry Totem")],
    [69505] = totemData[string_lower("Sentry Totem")],
    [70413] = totemData[string_lower("Sentry Totem")],
    [71145] = totemData[string_lower("Sentry Totem")],
    [147410] = totemData[string_lower("Sentry Totem")],

    [15447] = totemData[string_lower("Wrath of Air Totem")],
    [36556] = totemData[string_lower("Wrath of Air Totem")],
}

function Gladdy:GetSharedTotemData()
    return totemData, totemNpcIdsToTotemData, totemSpellIdToPulse
end