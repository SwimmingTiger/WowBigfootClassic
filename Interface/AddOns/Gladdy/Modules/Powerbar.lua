local pairs = pairs
local floor = math.floor

local CreateFrame, UnitPower, UnitPowerType, UnitPowerMax, UnitExists = CreateFrame, UnitPower, UnitPowerType, UnitPowerMax, UnitExists

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local AceGUIWidgetLSMlists = AceGUIWidgetLSMlists
local Powerbar = Gladdy:NewModule("Power Bar", 90, {
    powerBarEnabled = true,
    powerBarFont = "DorisPP",
    powerBarHeight = 20,
    powerBarTexture = "Smooth",
    powerBarBorderStyle = "Gladdy Tooltip round",
    powerBarBorderSize = 9,
    powerBarBorderColor = { r = 0, g = 0, b = 0, a = 1 },
    powerBarFontColor = { r = 1, g = 1, b = 1, a = 1 },
    powerBarBgColor = { r = 0.3, g = 0.3, b = 0.3, a = 0.7 },
    powerBarRaceFontSize = 10,
    powerBarPowerFontSize = 10,
    powerShowSpec = true,
    powerShowRace = true,
    powerActual = true,
    powerMax = true,
    powerPercentage = false,
    powerFrameStrata = "MEDIUM",
    powerFrameLevel = 1,
    powerCustomTagsEnabled = false,
    powerTextLeft = "[spec] [race]",
    powerTextRight = "[current]/[max]",
    powerTextLeftOutline = false,
    powerTextRightOutline = false,
    powerTextLeftVOffset = 1,
    powerTextLeftHOffset = 5,
    powerTextRightVOffset = 1,
    powerTextRightHOffset = -5,
})

function Powerbar:Initialize()
    self.frames = {}

    if Gladdy.db.powerBarEnabled then
        self:RegisterMessage("ENEMY_SPOTTED")
        self:RegisterMessage("UNIT_SPEC")
        self:RegisterMessage("UNIT_DEATH")
        self:RegisterMessage("UNIT_DESTROYED")
    end
end

function Powerbar:UpdateFrameOnce()
    if Gladdy.db.powerBarEnabled then
        self:RegisterMessage("ENEMY_SPOTTED")
        self:RegisterMessage("UNIT_SPEC")
        self:RegisterMessage("UNIT_DEATH")
        self:RegisterMessage("UNIT_DESTROYED")
    else
        self:UnregisterAllMessages()
    end
end

function Powerbar:CreateFrame(unit)
    local button = Gladdy.buttons[unit]

    local powerBar = CreateFrame("Frame", nil, Gladdy.buttons[unit], BackdropTemplateMixin and "BackdropTemplate")
    powerBar:EnableMouse(false)
    powerBar:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "powerBarBorderStyle"),
                                  edgeSize = Gladdy.db.powerBarBorderSize })
    powerBar:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.powerBarBorderColor))
    powerBar:SetFrameStrata(Gladdy.db.powerFrameStrata)
    powerBar:SetFrameLevel(Gladdy.db.powerFrameLevel)

    powerBar.energy = CreateFrame("StatusBar", nil, powerBar)
    powerBar.energy:SetStatusBarTexture(Gladdy:SMFetch("statusbar", "powerBarTexture"))
    powerBar.energy:SetMinMaxValues(0, 100)
    powerBar.energy:SetFrameStrata(Gladdy.db.powerFrameStrata)
    powerBar.energy:SetFrameLevel(Gladdy.db.powerFrameLevel - 1)

    powerBar.bg = powerBar.energy:CreateTexture(nil, "BACKGROUND")
    powerBar.bg:SetTexture(Gladdy:SMFetch("statusbar", "powerBarTexture"))
    powerBar.bg:ClearAllPoints()
    powerBar.bg:SetAllPoints(powerBar.energy)
    powerBar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.powerBarBgColor))

    powerBar.raceText = powerBar:CreateFontString(nil, "LOW")
    powerBar.raceText:SetFont(Gladdy:SMFetch("font", "powerBarFont"), Gladdy.db.powerBarRaceFontSize, Gladdy.db.powerTextLeftOutline and "OUTLINE")
    powerBar.raceText:SetTextColor(Gladdy:SetColor(Gladdy.db.powerBarFontColor))
    powerBar.raceText:SetShadowOffset(1, -1)
    powerBar.raceText:SetShadowColor(0, 0, 0, 1)
    powerBar.raceText:SetJustifyH("CENTER")
    powerBar.raceText:SetPoint("LEFT", Gladdy.db.powerTextLeftHOffset, Gladdy.db.powerTextLeftVOffset)

    powerBar.powerText = powerBar:CreateFontString(nil, "LOW")
    powerBar.powerText:SetFont(Gladdy:SMFetch("font", "powerBarFont"), Gladdy.db.powerBarPowerFontSize, Gladdy.db.powerTextRightOutline and "OUTLINE")
    powerBar.powerText:SetTextColor(Gladdy:SetColor(Gladdy.db.powerBarFontColor))
    powerBar.powerText:SetShadowOffset(1, -1)
    powerBar.powerText:SetShadowColor(0, 0, 0, 1)
    powerBar.powerText:SetJustifyH("CENTER")
    powerBar.powerText:SetPoint("RIGHT", Gladdy.db.powerTextRightHOffset, Gladdy.db.powerTextRightVOffset)

    button.powerBar = powerBar
    self.frames[unit] = powerBar
    self:ResetUnit(unit)
    powerBar.unit = unit
    powerBar:RegisterUnitEvent("UNIT_POWER_UPDATE", unit)
    powerBar:RegisterUnitEvent("UNIT_MAXPOWER", unit)
    powerBar:RegisterUnitEvent("UNIT_DISPLAYPOWER", unit)
    powerBar:SetScript("OnEvent", Powerbar.OnEvent)
end

function Powerbar:UpdateFrame(unit)
    local powerBar = self.frames[unit]
    if (not powerBar) then
        return
    end
    local healthBar = Gladdy.modules["Health Bar"].frames[unit]

    if not Gladdy.db.powerBarEnabled then
        powerBar:Hide()
        powerBar:UnregisterEvent("UNIT_POWER_UPDATE")
        powerBar:UnregisterEvent("UNIT_MAXPOWER")
        powerBar:UnregisterEvent("UNIT_DISPLAYPOWER")
        powerBar:SetScript("OnEvent", nil)
        return
    else
        powerBar:RegisterUnitEvent("UNIT_POWER_UPDATE", unit)
        powerBar:RegisterUnitEvent("UNIT_MAXPOWER", unit)
        powerBar:RegisterUnitEvent("UNIT_DISPLAYPOWER", unit)
        powerBar:SetScript("OnEvent", Powerbar.OnEvent)
        powerBar:Show()
    end
    powerBar.bg:SetTexture(Gladdy:SMFetch("statusbar", "powerBarTexture"))
    powerBar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.powerBarBgColor))

    powerBar:SetWidth(healthBar:GetWidth())
    powerBar:SetHeight(Gladdy.db.powerBarHeight)

    powerBar:ClearAllPoints()
    powerBar:SetPoint("TOPLEFT", healthBar, "BOTTOMLEFT", 0, -1)

    powerBar:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "powerBarBorderStyle"),
                           edgeSize = Gladdy.db.powerBarBorderSize })
    powerBar:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.powerBarBorderColor))

    powerBar.energy:SetStatusBarTexture(Gladdy:SMFetch("statusbar", "powerBarTexture"))
    powerBar.energy:ClearAllPoints()
    powerBar.energy:SetPoint("TOPLEFT", powerBar, "TOPLEFT", (Gladdy.db.powerBarBorderSize/Gladdy.db.statusbarBorderOffset), -(Gladdy.db.powerBarBorderSize/Gladdy.db.statusbarBorderOffset))
    powerBar.energy:SetPoint("BOTTOMRIGHT", powerBar, "BOTTOMRIGHT", -(Gladdy.db.powerBarBorderSize/Gladdy.db.statusbarBorderOffset), (Gladdy.db.powerBarBorderSize/Gladdy.db.statusbarBorderOffset))

    powerBar.raceText:SetFont(Gladdy:SMFetch("font", "powerBarFont"), Gladdy.db.powerBarRaceFontSize, Gladdy.db.powerTextLeftOutline and "OUTLINE")
    powerBar.raceText:SetTextColor(Gladdy:SetColor(Gladdy.db.powerBarFontColor))
    powerBar.raceText:SetPoint("LEFT", Gladdy.db.powerTextLeftHOffset, Gladdy.db.powerTextLeftVOffset)

    powerBar.powerText:SetFont(Gladdy:SMFetch("font", "powerBarFont"), Gladdy.db.powerBarPowerFontSize, Gladdy.db.powerTextRightOutline and "OUTLINE")
    powerBar.powerText:SetTextColor(Gladdy:SetColor(Gladdy.db.powerBarFontColor))
    powerBar.powerText:SetPoint("RIGHT", Gladdy.db.powerTextRightHOffset, Gladdy.db.powerTextRightVOffset)

    powerBar:SetFrameStrata(Gladdy.db.powerFrameStrata)
    powerBar:SetFrameLevel(Gladdy.db.powerFrameLevel)
    powerBar.energy:SetFrameStrata(Gladdy.db.powerFrameStrata)
    powerBar.energy:SetFrameLevel(Gladdy.db.powerFrameLevel - 1)
end

function Powerbar.OnEvent(powerBar, event, unit)
    powerBar.energy.powerType = select(1, UnitPowerType(unit))
    powerBar.energy.current, powerBar.energy.max = UnitPower(unit, powerBar.energy.powerType, true), UnitPowerMax(unit, powerBar.energy.powerType, true)
    Powerbar:SetPower(powerBar, unit, powerBar.energy.current, powerBar.energy.max, powerBar.energy.powerType)
end

function Powerbar:SetText(unit, power, powerMax, status)
    local button = Gladdy.buttons[unit]
    if not Gladdy.buttons[unit] then
        return
    end
    local powerBar = button.powerBar
    if Gladdy.db.powerCustomTagsEnabled then
        powerBar.powerText:SetText(Gladdy:SetTag(unit, Gladdy.db.powerTextRight, power, powerMax, status))
        powerBar.raceText:SetText(Gladdy:SetTag(unit, Gladdy.db.powerTextLeft, power, powerMax, status))
    else
        if power then
            local powerPercentage = floor(power * 100 / powerMax)
            local powerText
            if (Gladdy.db.powerActual) then
                powerText = powerMax > 999 and ("%.1fk"):format(power / 1000) or power
            end
            if (Gladdy.db.powerMax) then
                local text = powerMax > 999 and ("%.1fk"):format(powerMax / 1000) or powerMax
                if (powerText) then
                    powerText = ("%s/%s"):format(powerText, text)
                else
                    powerText = text
                end
            end
            if (Gladdy.db.powerPercentage) then
                if (powerText) then
                    powerText = ("%s (%d%%)"):format(powerText, powerPercentage)
                else
                    powerText = ("%d%%"):format(powerPercentage)
                end
            end
            powerBar.powerText:SetText(powerText)
        end

        local raceText = Gladdy.db.powerShowRace and button.raceLoc or ""
        if (button.spec and Gladdy.db.powerShowSpec) then
            raceText = button.spec .. " " .. raceText
        end
        powerBar.raceText:SetText(raceText)
    end
end

function Powerbar:SetPower(powerBar, unit, power, powerMax, powerType, status)
    Powerbar:SetText(unit, power, powerMax, status)
    powerBar.energy.current = power
    powerBar.energy.max = powerMax
    powerBar.energy.powerType = powerType

    if (powerType == 1 and powerBar.powerType ~= powerType) then
        powerBar.energy:SetStatusBarColor(1, 0, 0, 1)
        powerBar.powerColor = {r = 1, g = 0, b = 0}
        powerBar.powerType = powerType
    elseif (powerType == 3 and powerBar.powerType ~= powerType) then
        powerBar.energy:SetStatusBarColor(1, 1, 0, 1)
        powerBar.powerColor = {r = 1, g = 1, b = 0}
        powerBar.powerType = powerType
    elseif powerBar.powerType ~= powerType then
        powerBar.energy:SetStatusBarColor(.18, .44, .75, 1)
        powerBar.powerColor = {r = .18, g = .44, b = .75}
        powerBar.powerType = powerType
    end

    powerBar.energy:SetMinMaxValues(0, powerMax)
    powerBar.energy:SetValue(power)

end

function Powerbar:ResetUnit(unit)
    local powerBar = self.frames[unit]
    if (not powerBar) then
        return
    end

    powerBar.energy:SetStatusBarColor(1, 1, 1, 1)
    powerBar.raceText:SetText("")
    powerBar.powerText:SetText("")
    powerBar.energy:SetValue(0)
    powerBar.powerType = ""
    powerBar.powerColor = {r = 1, g = 1, b = 1}
end

function Powerbar:Test(unit)
    local powerBar = self.frames[unit]
    local button = Gladdy.buttons[unit]
    if (not powerBar or not button) then
        return
    end

    powerBar.energy.current = button.power
    powerBar.energy.max = button.powerMax
    powerBar.energy.powerType = button.powerType
    self:ENEMY_SPOTTED(unit)
    self:UNIT_POWER(unit, button.power, button.powerMax, button.powerType)
    if unit == "arena1" then
        self:UNIT_DEATH(unit)
    end
end

function Powerbar:ENEMY_SPOTTED(unit)
    local powerBar = self.frames[unit]
    local button = Gladdy.buttons[unit]
    if (not powerBar or not button) then
        return
    end

    if UnitExists(unit) then
        powerBar.energy.powerType = select(1, UnitPowerType(unit))
        powerBar.energy.current, powerBar.energy.max = UnitPower(unit, powerBar.energy.powerType, true), UnitPowerMax(unit, powerBar.energy.powerType, true)
        Powerbar:SetPower(powerBar, unit, powerBar.energy.current, powerBar.energy.max, powerBar.energy.powerType)
    end
end

function Powerbar:UNIT_SPEC(unit, spec)
    local powerBar = self.frames[unit]
    local button = Gladdy.buttons[unit]
    if (not powerBar or not button) then
        return
    end

    if UnitExists(unit) then
        Powerbar:SetPower(powerBar, unit, powerBar.energy.current, powerBar.energy.max, powerBar.energy.powerType)
    end
end

function Powerbar:UNIT_POWER(unit, power, powerMax, powerType)
    local powerBar = self.frames[unit]
    if (not powerBar) then
        return
    end

    if not Gladdy.buttons[unit].class then
        Gladdy:SpotEnemy(unit, true)
    end
    Powerbar:SetPower(powerBar, unit, power, powerMax, powerType)
end

function Powerbar:UNIT_DEATH(unit)
    local powerBar = self.frames[unit]
    if (not powerBar) then
        return
    end
    Powerbar:SetPower(powerBar, unit, 0, powerBar.energy.max, powerBar.energy.powerType, L["DEAD"])
end

function Powerbar:UNIT_DESTROYED(unit)
    local powerBar = self.frames[unit]
    if (not powerBar) then
        return
    end
    Powerbar:SetPower(powerBar, unit, 0, powerBar.energy.max, powerBar.energy.powerType, L["LEAVE"])
end

local function option(params)
    local defaults = {
        get = function(info)
            local key = info.arg or info[#info]
            return Gladdy.dbi.profile[key]
        end,
        set = function(info, value)
            local key = info.arg or info[#info]
            Gladdy.dbi.profile[key] = value
            Gladdy.options.args["Power Bar"].args.group.args.border.args.powerBarBorderSize.max = Gladdy.db.powerBarHeight/2
            if Gladdy.db.powerBarBorderSize > Gladdy.db.powerBarHeight/2 then
                Gladdy.db.powerBarBorderSize = Gladdy.db.powerBarHeight/2
            end
            if Gladdy.frame.testing then
                for i=1,Gladdy.curBracket do
                    Powerbar:Test("arena" .. i)
                end
            end
            Gladdy:UpdateFrame()
        end,
    }

    for k, v in pairs(params) do
        defaults[k] = v
    end

    return defaults
end

function Powerbar:GetOptions()
    return {
        headerPowerbar = {
            type = "header",
            name = L["Power Bar"],
            order = 2,
        },
        powerBarEnabled = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            order = 3,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 4,
            disabled = function() return not Gladdy.db.powerBarEnabled end,
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
                        powerBarHeight = option({
                            type = "range",
                            name = L["Bar height"],
                            desc = L["Height of the bar"],
                            order = 3,
                            min = 0,
                            max = 50,
                            step = 1,
                            width = "full",
                        }),
                        powerBarTexture = option({
                            type = "select",
                            name = L["Bar texture"],
                            desc = L["Texture of the bar"],
                            order = 4,
                            dialogControl = "LSM30_Statusbar",
                            values = AceGUIWidgetLSMlists.statusbar,
                        }),
                        powerBarBgColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Background color"],
                            desc = L["Color of the status bar background"],
                            order = 5,
                            hasAlpha = true,
                        }),
                    },
                },
                font = {
                    type = "group",
                    name = L["Font"],
                    order = 2,
                    args = {
                        header = {
                            type = "header",
                            name = L["Font"],
                            order = 1,
                        },
                        powerBarFont = option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the bar"],
                            order = 11,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        powerBarFontColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Font color"],
                            desc = L["Color of the text"],
                            order = 12,
                            hasAlpha = true,
                        }),
                        powerTextLeftOutline = option({
                            type = "toggle",
                            name = L["Left Font Outline"],
                            order = 13,
                            width = "full",
                        }),
                        powerTextRightOutline = option({
                            type = "toggle",
                            name = L["Right Font Outline"],
                            order = 14,
                            width = "full",
                        }),
                        headerSize = {
                            type = "header",
                            name = L["Size"],
                            order = 20,
                        },
                        powerBarRaceFontSize = option({
                            type = "range",
                            name = L["Race font size"],
                            desc = L["Size of the race text"],
                            order = 21,
                            step = 0.1,
                            min = 0,
                            max = 20,
                            width = "full",
                        }),
                        powerBarPowerFontSize = option({
                            type = "range",
                            name = L["Power font size"],
                            desc = L["Size of the power text"],
                            order = 22,
                            step = 0.1,
                            min = 0,
                            max = 20,
                            width = "full",
                        }),
                        headerOffsets = {
                            type = "header",
                            name = L["Offsets"],
                            order = 30,
                        },
                        powerTextLeftVOffset = option({
                            type = "range",
                            name = L["Left Text Vertical Offset"],
                            order = 31,
                            step = 0.1,
                            min = -200,
                            max = 200,
                            width = "full",
                        }),
                        powerTextLeftHOffset = option({
                            type = "range",
                            name = L["Left Text Horizontal Offset"],
                            order = 32,
                            step = 0.1,
                            min = -200,
                            max = 200,
                            width = "full",
                        }),
                        powerTextRightVOffset = option({
                            type = "range",
                            name = L["Right Text Vertical Offset"],
                            order = 33,
                            step = 0.1,
                            min = -200,
                            max = 200,
                            width = "full",
                        }),
                        powerTextRightHOffset = option({
                            type = "range",
                            name = L["Right Text Horizontal Offset"],
                            order = 34,
                            step = 0.1,
                            min = -200,
                            max = 200,
                            width = "full",
                        }),
                    },
                },
                border = {
                    type = "group",
                    name = L["Border"],
                    order = 3,
                    args = {
                        header = {
                            type = "header",
                            name = L["Border"],
                            order = 1,
                        },
                        powerBarBorderStyle = option({
                            type = "select",
                            name = L["Border style"],
                            order = 21,
                            dialogControl = "LSM30_Border",
                            values = AceGUIWidgetLSMlists.border,
                        }),
                        powerBarBorderSize = option({
                            type = "range",
                            name = L["Border size"],
                            desc = L["Size of the border"],
                            order = 22,
                            min = 0.5,
                            max = Gladdy.db.powerBarHeight/2,
                            step = 0.5,
                            width = "full",
                        }),
                        powerBarBorderColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Border color"],
                            desc = L["Color of the border"],
                            order = 23,
                            hasAlpha = true,
                        }),
                    },
                },
                frameStrata = {
                    type = "group",
                    name = L["Frame Strata and Level"],
                    order = 4,
                    args = {
                        headerAuraLevel = {
                            type = "header",
                            name = L["Frame Strata and Level"],
                            order = 1,
                        },
                        powerFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        powerFrameLevel = Gladdy:option({
                            type = "range",
                            name = L["Frame Level"],
                            min = 1,
                            max = 500,
                            step = 1,
                            order = 3,
                            width = "full",
                        }),
                    },
                },
                powerValues = {
                    type = "group",
                    name = L["Power Bar Text"],
                    order = 5,
                    args = {
                        header = {
                            type = "header",
                            name = L["Power Texts"],
                            order = 1,
                        },
                        powerShowRace = option({
                            type = "toggle",
                            name = L["Show race"],
                            desc = L["Show race"],
                            order = 2,
                            disabled = function() return Gladdy.db.powerCustomTagsEnabled end,
                        }),
                        powerShowSpec= option({
                            type = "toggle",
                            name = L["Show spec"],
                            desc = L["Show spec"],
                            order = 3,
                            disabled = function() return Gladdy.db.powerCustomTagsEnabled end,
                        }),
                        powerActual = option({
                            type = "toggle",
                            name = L["Show the actual power"],
                            desc = L["Show the actual power on the power bar"],
                            order = 4,
                            disabled = function() return Gladdy.db.powerCustomTagsEnabled end,
                        }),
                        powerMax = option({
                            type = "toggle",
                            name = L["Show max power"],
                            desc = L["Show max power on the power bar"],
                            order = 5,
                            disabled = function() return Gladdy.db.powerCustomTagsEnabled end,
                        }),
                        powerPercentage = option({
                            type = "toggle",
                            name = L["Show power percentage"],
                            desc = L["Show power percentage on the power bar"],
                            order = 6,
                            disabled = function() return Gladdy.db.powerCustomTagsEnabled end,
                        }),
                        header = {
                            type = "header",
                            name = L["Custom Tags"],
                            order = 10,
                        },
                        powerCustomTagsEnabled = Gladdy:GetTagOption(L["Custom Tags Enabled"], 11, nil, option, true),
                        powerTextLeft = Gladdy:GetTagOption(L["Left Text"], 12, "powerCustomTagsEnabled", option),
                        powerTextRight = Gladdy:GetTagOption(L["Right Text"], 13, "powerCustomTagsEnabled", option),
                    },
                },
            },
        },
    }
end