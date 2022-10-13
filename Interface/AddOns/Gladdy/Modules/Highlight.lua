local CreateFrame, UnitIsUnit = CreateFrame, UnitIsUnit

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local Highlight = Gladdy:NewModule("Highlight", nil, {
    highlightBorderSize = 1,
    highlightInset = false,
    targetBorderColor = { r = 1, g = 0.8, b = 0, a = 1 },
    focusBorderColor = { r = 1, g = 0, b = 0, a = 1 },
    leaderBorderColor = { r = 0, g = 1, b = 0, a = 1 },
    highlightBorderStyle = "Square Full White",
    highlight = true,
    targetBorder = true,
    focusBorder = true,
    leaderBorder = true,
    highlightFrameStrata = "MEDIUM",
    highlightFrameLevel = 20,
})

function Highlight:Initialize()
    self:RegisterMessage("JOINED_ARENA")
end

function Highlight:JOINED_ARENA()
    self:RegisterEvent("PLAYER_FOCUS_CHANGED")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:SetScript("OnEvent", function(self, event, ...)
        if self[event] then
            self[event](self, ...)
        end
    end)
end

function Highlight:Reset()
    self:UnregisterAllEvents()
    self:SetScript("OnEvent", nil)
end

function Highlight:PLAYER_TARGET_CHANGED()
    for i=1, Gladdy.curBracket do
        self:Toggle("arena" .. i, "target", UnitIsUnit("target", "arena" .. i))
    end
end

function Highlight:PLAYER_FOCUS_CHANGED()
    for i=1, Gladdy.curBracket do
        self:Toggle("arena" .. i, "focus", UnitIsUnit("focus", "arena" .. i))
    end
end

function Highlight:CreateFrame(unit)
    local button = Gladdy.buttons[unit]
    if (not button) then
        return
    end

    local healthBar = Gladdy.modules["Health Bar"].frames[unit]

    local targetBorder = CreateFrame("Frame", nil, button, BackdropTemplateMixin and "BackdropTemplate")
    targetBorder:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "highlightBorderStyle"), edgeSize = Gladdy.db.highlightBorderSize })
    targetBorder:SetFrameStrata(Gladdy.db.highlightFrameStrata)
    targetBorder:SetFrameLevel(Gladdy.db.highlightFrameLevel)
    targetBorder:Hide()

    local focusBorder = CreateFrame("Frame", nil, button, BackdropTemplateMixin and "BackdropTemplate")
    focusBorder:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "highlightBorderStyle"), edgeSize = Gladdy.db.highlightBorderSize })
    focusBorder:SetFrameStrata(Gladdy.db.highlightFrameStrata)
    focusBorder:SetFrameLevel(Gladdy.db.highlightFrameLevel)
    focusBorder:Hide()

    local leaderBorder = CreateFrame("Frame", nil, button, BackdropTemplateMixin and "BackdropTemplate")
    leaderBorder:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "highlightBorderStyle"), edgeSize = Gladdy.db.highlightBorderSize })
    leaderBorder:SetFrameStrata(Gladdy.db.highlightFrameStrata)
    leaderBorder:SetFrameLevel(Gladdy.db.highlightFrameLevel)
    leaderBorder:Hide()

    local highlight = healthBar:CreateTexture(nil, "OVERLAY")
    highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    highlight:SetBlendMode("ADD")
    highlight:SetAlpha(0.5)
    highlight:ClearAllPoints()
    highlight:SetAllPoints(healthBar)
    highlight:Hide()

    button.targetBorder = targetBorder
    button.focusBorder = focusBorder
    button.leaderBorder = leaderBorder
    button.highlight = highlight
end

function Highlight:UpdateFrame(unit)
    local button = Gladdy.buttons[unit]
    if (not button) then
        return
    end

    local powerBarHeight = Gladdy.db.powerBarEnabled and (Gladdy.db.powerBarHeight + 1) or 0
    local borderSize = Gladdy.db.highlightBorderSize
    local borderOffset = borderSize
    local hpAndPowerHeight = Gladdy.db.healthBarHeight + powerBarHeight
    local width = Gladdy.db.barWidth + (Gladdy.db.highlightInset and 0 or borderSize * 2)
    local height = hpAndPowerHeight + (Gladdy.db.highlightInset and 0 or borderSize * 2)

    button.targetBorder:SetFrameStrata(Gladdy.db.highlightFrameStrata)
    button.targetBorder:SetFrameLevel(Gladdy.db.highlightFrameLevel)
    button.focusBorder:SetFrameStrata(Gladdy.db.highlightFrameStrata)
    button.focusBorder:SetFrameLevel(Gladdy.db.highlightFrameLevel)
    button.leaderBorder:SetFrameStrata(Gladdy.db.highlightFrameStrata)
    button.leaderBorder:SetFrameLevel(Gladdy.db.highlightFrameLevel)

    button.targetBorder:SetWidth(width)
    button.targetBorder:SetHeight(height)
    button.targetBorder:ClearAllPoints()
    if Gladdy.db.highlightInset then
        button.targetBorder:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT", -(borderOffset/Gladdy.db.statusbarBorderOffset), (borderOffset/Gladdy.db.statusbarBorderOffset))
        button.targetBorder:SetPoint("BOTTOMRIGHT",  Gladdy.db.powerBarEnabled and button.powerBar or button.healthBar, "BOTTOMRIGHT", (borderOffset/Gladdy.db.statusbarBorderOffset), -(borderOffset/Gladdy.db.statusbarBorderOffset))
    else
        button.targetBorder:SetPoint("TOP", button.healthBar, "TOP", 0, (Gladdy.db.highlightInset and 0 or borderSize))
    end

    button.targetBorder:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "highlightBorderStyle"), edgeSize = borderSize })
    button.targetBorder:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.targetBorderColor))

    button.focusBorder:SetWidth(width)
    button.focusBorder:SetHeight(height)
    button.focusBorder:ClearAllPoints()
    if Gladdy.db.highlightInset then
        button.focusBorder:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT", -(borderOffset/Gladdy.db.statusbarBorderOffset), (borderOffset/Gladdy.db.statusbarBorderOffset))
        button.focusBorder:SetPoint("BOTTOMRIGHT", Gladdy.db.powerBarEnabled and button.powerBar or button.healthBar, "BOTTOMRIGHT", (borderOffset/Gladdy.db.statusbarBorderOffset), -(borderOffset/Gladdy.db.statusbarBorderOffset))
    else
        button.focusBorder:SetPoint("TOP", button.healthBar, "TOP", 0, (Gladdy.db.highlightInset and 0 or borderSize))
    end

    button.focusBorder:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "highlightBorderStyle"), edgeSize = borderSize })
    button.focusBorder:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.focusBorderColor))

    button.leaderBorder:SetWidth(width)
    button.leaderBorder:SetHeight(height)
    button.leaderBorder:ClearAllPoints()
    if Gladdy.db.highlightInset then
        button.leaderBorder:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT", -(borderOffset/Gladdy.db.statusbarBorderOffset), (borderOffset/Gladdy.db.statusbarBorderOffset))
        button.leaderBorder:SetPoint("BOTTOMRIGHT", button.powerBar, "BOTTOMRIGHT", (borderOffset/Gladdy.db.statusbarBorderOffset), -(borderOffset/Gladdy.db.statusbarBorderOffset))
    else
        button.leaderBorder:SetPoint("TOP", button.healthBar, "TOP", 0, (Gladdy.db.highlightInset and 0 or borderSize))
    end

    button.leaderBorder:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "highlightBorderStyle"), edgeSize = borderSize })
    button.leaderBorder:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.leaderBorderColor))
    if Gladdy.frame.testing then
        Highlight:Test(unit)
    end
end

function Highlight:ResetUnit(unit)
    local button = Gladdy.buttons[unit]
    if (not button) then
        return
    end

    button.targetBorder:Hide()
    button.focusBorder:Hide()
    button.leaderBorder:Hide()
    button.highlight:Hide()
end

function Highlight:Test(unit)
    if (unit == "arena1") then
        self:Toggle(unit, "focus", true)
    elseif (unit == "arena2") then
        self:Toggle(unit, "target", true)
    elseif (unit == "arena3") then
        --self:Toggle(unit, "leader", true)
    end
end

function Highlight:Toggle(unit, frame, show)
    local button = Gladdy.buttons[unit]
    if (not button) then
        return
    end

    if (frame == "target") then
        if (Gladdy.db.targetBorder and show) then
            button.targetBorder:Show()
        else
            button.targetBorder:Hide()
        end

        if (Gladdy.db.highlight and show) then
            button.highlight:Show()
        else
            button.highlight:Hide()
        end
    elseif (frame == "focus") then
        if (Gladdy.db.focusBorder and show) then
            button.focusBorder:Show()
        else
            button.focusBorder:Hide()
        end
    elseif (frame == "leader") then
        if (Gladdy.db.leaderBorder and show) then
            button.leaderBorder:Show()
        else
            button.leaderBorder:Hide()
        end
    end
end

function Highlight:GetOptions()
    return {
        headerHighlight = {
            type = "header",
            name = L["Highlight"],
            order = 2,
        },
        highlightInset = Gladdy:option({
            type = "toggle",
            name = L["Show Inside"],
            desc = L["Show Highlight border inside of frame"],
            order = 3,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 3,
            args = {
                enabled = {
                    type = "group",
                    name = L["Enabled"],
                    order = 1,
                    args = {
                        headerEnable = {
                            type = "header",
                            name = L["Enabled"],
                            order = 10,
                        },
                        highlight = Gladdy:option({
                            type = "toggle",
                            name = L["Highlight target"],
                            desc = L["Toggle if the selected target should be highlighted"],
                            order = 11,
                            width = "full",
                        }),
                        targetBorder = Gladdy:option({
                            type = "toggle",
                            name = L["Show border around target"],
                            desc = L["Toggle if a border should be shown around the selected target"],
                            order = 12,
                            width = "full",
                        }),
                        focusBorder = Gladdy:option({
                            type = "toggle",
                            name = L["Show border around focus"],
                            desc = L["Toggle of a border should be shown around the current focus"],
                            order = 13,
                            width = "full",
                        }),
                    },
                },
                border = {
                    type = "group",
                    name = L["Border"],
                    order = 2,
                    args = {
                        headerHighlight = {
                            type = "header",
                            name = L["Border"],
                            order = 2,
                        },
                        highlightBorderSize = Gladdy:option({
                            type = "range",
                            name = L["Border size"],
                            desc = L["Border size"],
                            order = 4,
                            min = 1,
                            max = 20,
                            step = 1,
                            width = "full",
                        }),
                        highlightBorderStyle = Gladdy:option({
                            type = "select",
                            name = L["Border style"],
                            order = 5,
                            dialogControl = "LSM30_Border",
                            values = AceGUIWidgetLSMlists.border,
                        }),
                    },
                },
                color = {
                    type = "group",
                    name = L["Color"],
                    order = 3,
                    args = {
                        headerColor = {
                            type = "header",
                            name = L["Colors"],
                            order = 6,
                        },
                        targetBorderColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Target border color"],
                            desc = L["Color of the selected targets border"],
                            order = 7,
                            hasAlpha = true,
                        }),
                        focusBorderColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Focus border color"],
                            desc = L["Color of the focus border"],
                            order = 8,
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
                        highlightFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        highlightFrameLevel = Gladdy:option({
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
            },
        },
    }
end