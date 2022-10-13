local UnitIsConnected = UnitIsConnected
local UnitInPhase = UnitInPhase
local UnitInRaid = UnitInRaid
local UnitInParty = UnitInParty
local UnitInRange = UnitInRange
local CheckInteractDistance = CheckInteractDistance
local C_Timer = C_Timer
local UnitIsUnit = UnitIsUnit
local UnitClass = UnitClass
local GetSpellInfo = GetSpellInfo
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local LOCALIZED_CLASS_NAMES_MALE = LOCALIZED_CLASS_NAMES_MALE
local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS
local select, ipairs, type, tonumber, tostring, format = select, ipairs, type, tonumber, tostring, format

local LibStub = LibStub
local Gladdy = LibStub("Gladdy")
local LSR = LibStub("SpellRange-1.0")
local L = Gladdy.L
local HealthBar = Gladdy.modules["Health Bar"]

local classSpells = {
    ["MAGE"] =  118,
    ["PRIEST"] = 32379,
    ["DRUID"] = 33786,
    ["SHAMAN"] = 10414,
    ["PALADIN"] = 10308,
    ["WARLOCK"] = 5782,
    ["WARRIOR"] = 25275,
    ["HUNTER"] = 27018,
    ["ROGUE"] = 36554,
}

local function defaultSpells()
    local defaults = {}
    for _,class in ipairs(Gladdy.CLASSES) do
        defaults[class] = { min = classSpells[class] }
    end
    return defaults
end

local RangeCheck = Gladdy:NewModule("Range Check", nil, {
    rangeCheckEnabled = true,
    rangeCheckDefaultSpells = defaultSpells(),
    rangeCheckOorFactor = 1.5,
    rangeCheckHealthBar = true,
    rangeCheckHealthBarText = true,
    rangeCheckPowerBar = true,
    rangeCheckPowerBarText = true,
    rangeCheckClassIcon = false,
    rangeCheckTrinket = false,
    rangeCheckRacial = false,
})

function RangeCheck:Initialize()
    if Gladdy.db.rangeCheckEnabled then
        self:RegisterMessage("JOINED_ARENA")
    end
    self.playerClass = select(2, UnitClass("player"))
end

function RangeCheck:UpdateFrameOnce()
    if Gladdy.db.rangeCheckEnabled then
        self:RegisterMessage("JOINED_ARENA")
    else
        self:UnregisterAllMessages()
    end
end

function RangeCheck:Reset()
    self.test = nil
end

function RangeCheck:ResetUnit(unit)
    local button = Gladdy.buttons[unit]
    self:CancelTimer(button)
    self:SetColor(button, 1)
end

function RangeCheck:Test(unit)
    local button = Gladdy.buttons[unit]
    if not button then
        return
    end
    self.test = true
    button.lastState = 0
    if Gladdy.db.rangeCheckEnabled then
        if unit == "arena2" or unit == "arena4" then
            --button.unit = "target"
            --self:CreateTimer(button)
            self:SetRangeAlpha(button, nil)
        else
            self:SetRangeAlpha(button, true)
        end
    else
        self:SetRangeAlpha(button, true)
    end
end

function RangeCheck:UpdateFrame(unit)
    if self.test then
        self:Test(unit)
    end
end

function RangeCheck:SetColor(button, oorFac)
    if button.lastState == oorFac then
        return
    end

    if Gladdy.db.rangeCheckHealthBar then
        button.healthBar.hp.oorFactor = oorFac
        HealthBar:SetHealthStatusBarColor(button.unit, button.healthBar.hp.current, button.healthBar.hp.max)
    else
        button.healthBar.hp.oorFactor = 1
        HealthBar:SetHealthStatusBarColor(button.unit, button.healthBar.hp.current, button.healthBar.hp.max)
    end

    if Gladdy.db.rangeCheckHealthBarText then
        button.healthBar.nameText:SetTextColor(Gladdy.db.healthBarFontColor.r/oorFac, Gladdy.db.healthBarFontColor.g/oorFac, Gladdy.db.healthBarFontColor.b/oorFac, Gladdy.db.healthBarFontColor.a)
        button.healthBar.healthText:SetTextColor(Gladdy.db.healthBarFontColor.r/oorFac, Gladdy.db.healthBarFontColor.g/oorFac, Gladdy.db.healthBarFontColor.b/oorFac, Gladdy.db.healthBarFontColor.a)
    else
        button.healthBar.nameText:SetTextColor(Gladdy.db.healthBarFontColor.r, Gladdy.db.healthBarFontColor.g, Gladdy.db.healthBarFontColor.b, Gladdy.db.healthBarFontColor.a)
        button.healthBar.healthText:SetTextColor(Gladdy.db.healthBarFontColor.r, Gladdy.db.healthBarFontColor.g, Gladdy.db.healthBarFontColor.b, Gladdy.db.healthBarFontColor.a)
    end

    if Gladdy.db.rangeCheckPowerBar then
        button.powerBar.energy:SetStatusBarColor(button.powerBar.powerColor.r/oorFac, button.powerBar.powerColor.g/oorFac, button.powerBar.powerColor.b/oorFac, 1)
    else
        button.powerBar.energy:SetStatusBarColor(button.powerBar.powerColor.r, button.powerBar.powerColor.g, button.powerBar.powerColor.b, 1)
    end

    if Gladdy.db.rangeCheckPowerBarText then
        button.powerBar.raceText:SetTextColor(Gladdy.db.powerBarFontColor.r/oorFac, Gladdy.db.powerBarFontColor.g/oorFac, Gladdy.db.powerBarFontColor.b/oorFac, Gladdy.db.powerBarFontColor.a)
        button.powerBar.powerText:SetTextColor(Gladdy.db.powerBarFontColor.r/oorFac, Gladdy.db.powerBarFontColor.g/oorFac, Gladdy.db.powerBarFontColor.b/oorFac, Gladdy.db.powerBarFontColor.a)
    else
        button.powerBar.raceText:SetTextColor(Gladdy.db.powerBarFontColor.r, Gladdy.db.powerBarFontColor.g, Gladdy.db.powerBarFontColor.b, Gladdy.db.powerBarFontColor.a)
        button.powerBar.powerText:SetTextColor(Gladdy.db.powerBarFontColor.r, Gladdy.db.powerBarFontColor.g, Gladdy.db.powerBarFontColor.b, Gladdy.db.powerBarFontColor.a)
    end

    if Gladdy.db.rangeCheckTrinket then
        button.trinket.texture:SetVertexColor(1/oorFac, 1/oorFac, 1/oorFac)
    else
        button.trinket.texture:SetVertexColor(1, 1, 1)
    end
    if Gladdy.db.rangeCheckClassIcon then
        button.classIcon.texture:SetVertexColor(1/oorFac, 1/oorFac, 1/oorFac)
        button.aura.icon:SetVertexColor(1/oorFac, 1/oorFac, 1/oorFac)
    else
        button.classIcon.texture:SetVertexColor(1, 1, 1)
        button.aura.icon:SetVertexColor(1, 1, 1)
    end
    if Gladdy.db.rangeCheckRacial then
        button.racial.texture:SetVertexColor(1/oorFac, 1/oorFac, 1/oorFac)
    else
        button.racial.texture:SetVertexColor(1, 1, 1)
    end
    button.lastState = oorFac
end

function RangeCheck:SetRangeAlpha(button, inRange)
    local oorFac = Gladdy.db.rangeCheckOorFactor
    if inRange then
        RangeCheck:SetColor(button, 1)
    else
        RangeCheck:SetColor(button, oorFac)
    end
end

function RangeCheck:JOINED_ARENA()
    self.test = nil
    if Gladdy.db.rangeCheckEnabled then
        for i = 1, Gladdy.curBracket do
            local button = Gladdy.buttons["arena"..i]
            --if i == 1 then button.unit = "focus" end
            self:CreateTimer(button)
        end
    end
end

function RangeCheck.CheckRange(self)
    local button = self.parent

    local spell = Gladdy.db.rangeCheckDefaultSpells[RangeCheck.playerClass].min

    if (not UnitIsConnected(button.unit) or not UnitInPhase(button.unit)) then
        RangeCheck:SetRangeAlpha(button, false)
    elseif (spell) then
        RangeCheck:SetRangeAlpha(button, LSR.IsSpellInRange(spell, button.unit) == 1)
        -- That didn't work, but they are grouped lets try the actual API for this, it's a bit flaky though and not that useful generally
    elseif (UnitInRaid(button.unit) or UnitInParty(button.unit)) then
        RangeCheck:SetRangeAlpha(button, UnitInRange(button.unit, "player"))
        -- Nope, fall back to interaction :(
    else
        RangeCheck:SetRangeAlpha(button, CheckInteractDistance(button.unit, 4))
    end
end

function RangeCheck:CreateTimer(frame)
    if not frame.range then
        frame.range = C_Timer.NewTicker(0.05, RangeCheck.CheckRange)
        frame.range.parent = frame
    end
end

function RangeCheck:CancelTimer(frame)
    if frame.range then
        frame.range:Cancel()
        frame.range = nil
    end
end

function RangeCheck:ForceUpdate(frame)
    if( UnitIsUnit(frame.unit, "player") ) then
        frame.healthBar:SetAlpha(1)
        frame.powerBar:SetAlpha(1)
        self:CancelTimer(frame)
    else
        self:CreateTimer(frame)
        self.CheckRange(frame.parent)
    end
end

function RangeCheck:GetOptions()
    return {
        header = {
            type = "header",
            name = L["Range Check"],
            order = 2,
        },

        rangeCheckEnabled = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["Enable racial icon"],
            order = 3,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["General"],
            order = 5,
            disabled = function() return not Gladdy.db.rangeCheckEnabled end,
            args = {
                general = {
                    type = "group",
                    name = L["General"],
                    order = 1,
                    args = {
                        header = {
                            type = "header",
                            name = L["General"],
                            order = 1,
                        },
                        rangeCheckOorFactor = Gladdy:option({
                            type = "range",
                            name = L["Out of Range Darkening Level"],
                            desc = L["Higher is darker"],
                            min = 1.1,
                            max = 5,
                            step = 0.1,
                            width = "full",
                            order = 2,
                        }),
                        rangeCheckHealthBar = Gladdy:option({
                            type = "toggle",
                            name = L["Fade"] .. " " .. L["Health Bar"],
                            width = "full",
                            order = 3,
                        }),
                        rangeCheckHealthBarText = Gladdy:option({
                            type = "toggle",
                            name = L["Fade"] .. " " ..  L["Health Bar Text"],
                            width = "full",
                            order = 4,
                        }),
                        rangeCheckPowerBar = Gladdy:option({
                            type = "toggle",
                            name = L["Fade"] .. " " ..  L["Power Bar"],
                            width = "full",
                            order = 5,
                        }),
                        rangeCheckPowerBarText = Gladdy:option({
                            type = "toggle",
                            name = L["Fade"] .. " " ..  L["Power Bar Text"],
                            width = "full",
                            order = 6,
                        }),
                        rangeCheckClassIcon = Gladdy:option({
                            type = "toggle",
                            name = L["Fade"] .. " " ..  L["Class Icon"],
                            width = "full",
                            order = 7,
                        }),
                        rangeCheckTrinket = Gladdy:option({
                            type = "toggle",
                            name = L["Fade"] .. " " ..  L["Trinket"],
                            width = "full",
                            order = 8,
                        }),
                        rangeCheckRacial = Gladdy:option({
                            type = "toggle",
                            name = L["Fade"] .. " " ..  L["Racial"],
                            width = "full",
                            order = 9,
                        }),
                    },
                },
            },
        },
        oorSpells = {
            type = "group",
            childGroups = "tree",
            name = L["Spells"],
            order = 5,
            disabled = function() return not Gladdy.db.rangeCheckEnabled end,
            args = RangeCheck:GetSpells(),
        },
    }
end

function RangeCheck:GetSpells()
    local group = {
        description = {
            type = "description",
            name = L["Changing the spellID only applies to your player class!\n\nExample: If you are a Paladin and wish to change your range check spell to Repentance, edit the Paladin spellID to 20066."],
            order = 1,
        },
    }
    for i,class in ipairs(Gladdy.CLASSES) do
        group[class] = {
            type = "group",
            name = LOCALIZED_CLASS_NAMES_MALE[class],
            order = i + 1,
            icon = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",
            iconCoords = CLASS_ICON_TCOORDS[class],
            args = {
                headerMin = {
                    type = "header",
                    name = GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].min) and format("|T%s:20|t %s - %d" .. L["yds"], select(3, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].min)), select(1, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].min)), select(6, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].min)))
                            or "nil",
                    order = 1,
                },
                min = {
                    type = "input",
                    name = "Spell ID", --format("|T%s:20|t %s", select(3, GetSpellInfo(k)), select(1, GetSpellInfo(k)))
                    order = 2,
                    width = "full",
                    pattern = "%d+",
                    validate = function(_, value)
                        LibStub("AceConfigRegistry-3.0"):NotifyChange("Gladdy")
                        return type(tonumber(value)) == "number"
                    end,
                    --image = select(3, GetSpellInfo(defaultSpells()[class].min)),
                    get = function(_)
                        return tostring(Gladdy.db.rangeCheckDefaultSpells[class].min)
                        end,
                    set = function(_, value)
                        Gladdy.db.rangeCheckDefaultSpells[class].min = tonumber(value)
                        Gladdy.options.args["Range Check"].args.oorSpells.args[class].args.headerMin.name = GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].min) and format("|T%s:20|t %s - %d" .. L["yds"], select(3, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].min)), select(1, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].min)), select(6, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].min)))
                                or "nil"
                    end
                },
                --[[headerMax = {
                    type = "header",
                    name = L["Max"],
                    order = 3,
                },
                max = {
                    type = "input",
                    name = GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].max) and format("|T%s:20|t %s", select(3, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].max)), select(1, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].max)))
                            or "nil",
                    order = 4,
                    width = "full",
                    pattern = "%d+",
                    validate = function(_, value)
                        return type(tonumber(value)) == "number"
                    end,
                    --image = select(3, GetSpellInfo(defaultSpells()[class].max)),
                    get = function(_)
                        return tostring(Gladdy.db.rangeCheckDefaultSpells[class].max)
                    end,
                    set = function(_, value)
                        Gladdy.db.rangeCheckDefaultSpells[class].max = tonumber(value)
                        Gladdy.options.args["Range Check"].args.oorSpells.args[class].args.max.name = GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].max) and format("|T%s:20|t %s", select(3, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].max)), select(1, GetSpellInfo(Gladdy.db.rangeCheckDefaultSpells[class].max)))
                                or "nil"
                    end
                }--]]
            }
        }
    end
    return group
end