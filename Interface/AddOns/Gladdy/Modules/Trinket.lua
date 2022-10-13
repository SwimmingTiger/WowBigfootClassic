local ceil, str_gsub = ceil, string.gsub
local C_PvP = C_PvP

local CreateFrame = CreateFrame
local GetTime = GetTime

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local Trinket = Gladdy:NewModule("Trinket", 80, {
    trinketFont = "DorisPP",
    trinketFontScale = 1,
    trinketFontEnabled = true,
    trinketEnabled = true,
    trinketSize = 60 + 20 + 1,
    trinketWidthFactor = 0.9,
    trinketIconZoomed = false,
    trinketBorderStyle = "Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp",
    trinketBorderColor = { r = 0, g = 0, b = 0, a = 1 },
    trinketDisableCircle = false,
    trinketCooldownAlpha = 1,
    trinketCooldownNumberAlpha = 1,
    trinketXOffset = 0,
    trinketYOffset = 0,
    trinketFrameStrata = "MEDIUM",
    trinketFrameLevel = 5,
    trinketColored = false,
    trinketColoredCd = { r = 1, g = 0, b = 0, a = 1 },
    trinketColoredNoCd = { r = 0, g = 1, b = 0, a = 1 },
    trinketGroup = false,
    trinketGroupDirection = "DOWN",
})

function Trinket:Initialize()
    self.frames = {}
    if Gladdy.db.trinketEnabled then
        self:RegisterMessage("JOINED_ARENA")
        self:RegisterMessage("TRINKET_USED")
        if Gladdy.expansion == "Wrath" then
            self:RegisterMessage("RACIAL_USED")
        end
    end
end

function Trinket:UpdateFrameOnce()
    if Gladdy.db.trinketEnabled then
        self:RegisterMessage("JOINED_ARENA")
        if Gladdy.expansion == "Wrath" then
            self:RegisterMessage("RACIAL_USED")
        end
    else
        self:UnregisterAllMessages()
    end
end

local function iconTimer(self, elapsed)
    if (self.active) then
        if (self.timeLeft <= 0) then
            self.active = false
            self.cooldown:Clear()
            Gladdy:SendMessage("TRINKET_READY", self.unit)
            if Gladdy.db.trinketColored then
                self:SetBackdropColor(Gladdy:SetColor(Gladdy.db.trinketColoredNoCd))
            end
        else
            self.timeLeft = self.timeLeft - elapsed
        end

        local timeLeft = ceil(self.timeLeft)

        if timeLeft >= 60 then
            self.cooldownFont:SetTextColor(1, 1, 0, Gladdy.db.trinketCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "trinketFont"), (self:GetWidth()/2 - 0.15*self:GetWidth()) * Gladdy.db.trinketFontScale, "OUTLINE")
        elseif timeLeft < 60 and timeLeft >= 30 then
            self.cooldownFont:SetTextColor(1, 1, 0, Gladdy.db.trinketCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "trinketFont"), (self:GetWidth()/2 - 1) * Gladdy.db.trinketFontScale, "OUTLINE")
        elseif timeLeft < 30 and timeLeft >= 11 then
            self.cooldownFont:SetTextColor(1, 0.7, 0, Gladdy.db.trinketCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "trinketFont"), (self:GetWidth()/2 - 1) * Gladdy.db.trinketFontScale, "OUTLINE")
        elseif timeLeft <= 10 and timeLeft >= 5 then
            self.cooldownFont:SetTextColor(1, 0.7, 0, Gladdy.db.trinketCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "trinketFont"), (self:GetWidth()/2 - 1) * Gladdy.db.trinketFontScale, "OUTLINE")
        elseif timeLeft < 5 and timeLeft > 0 then
            self.cooldownFont:SetTextColor(1, 0, 0, Gladdy.db.trinketCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "trinketFont"), (self:GetWidth()/2 - 1) * Gladdy.db.trinketFontScale, "OUTLINE")
        end
        if Gladdy.db.trinketFontEnabled then
            Gladdy:FormatTimer(self.cooldownFont, self.timeLeft, self.timeLeft < 10, true)
        else
            self.cooldownFont:SetText("")
        end
    end
end

function Trinket:CreateFrame(unit)
    local trinket = CreateFrame("Button", "GladdyTrinketButton" .. unit, Gladdy.buttons[unit], BackdropTemplateMixin and "BackdropTemplate")
    trinket:SetBackdrop({bgFile = "Interface\\AddOns\\Gladdy\\Images\\trinket" })
    trinket:EnableMouse(false)
    trinket:SetFrameStrata(Gladdy.db.trinketFrameStrata)
    trinket:SetFrameLevel(Gladdy.db.trinketFrameLevel)

    trinket.texture = trinket:CreateTexture(nil, "BACKGROUND")
    trinket.texture:SetAllPoints(trinket)
    trinket.texture:SetTexture("Interface\\Icons\\INV_Jewelry_TrinketPVP_02")
    trinket.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
    trinket.texture.masked = true

    trinket.cooldown = CreateFrame("Cooldown", nil, trinket, "CooldownFrameTemplate")
    trinket.cooldown.noCooldownCount = true --Gladdy.db.trinketDisableOmniCC
    trinket.cooldown:SetHideCountdownNumbers(true)
    trinket.cooldown:SetFrameStrata(Gladdy.db.trinketFrameStrata)
    trinket.cooldown:SetFrameLevel(Gladdy.db.trinketFrameLevel + 1)

    trinket.cooldownFrame = CreateFrame("Frame", nil, trinket)
    trinket.cooldownFrame:ClearAllPoints()
    trinket.cooldownFrame:SetPoint("TOPLEFT", trinket, "TOPLEFT")
    trinket.cooldownFrame:SetPoint("BOTTOMRIGHT", trinket, "BOTTOMRIGHT")
    trinket.cooldownFrame:SetFrameStrata(Gladdy.db.trinketFrameStrata)
    trinket.cooldownFrame:SetFrameLevel(Gladdy.db.trinketFrameLevel + 2)

    trinket.cooldownFont = trinket.cooldownFrame:CreateFontString(nil, "OVERLAY")
    trinket.cooldownFont:SetFont(Gladdy:SMFetch("font", "trinketFont"), 20, "OUTLINE")
    --trinket.cooldownFont:SetAllPoints(trinket.cooldown)
    trinket.cooldownFont:SetJustifyH("CENTER")
    trinket.cooldownFont:SetPoint("CENTER")

    trinket.borderFrame = CreateFrame("Frame", nil, trinket)
    trinket.borderFrame:SetAllPoints(trinket)
    trinket.borderFrame:SetFrameStrata(Gladdy.db.trinketFrameStrata)
    trinket.borderFrame:SetFrameLevel(Gladdy.db.trinketFrameLevel + 3)

    trinket.texture.overlay = trinket.borderFrame:CreateTexture(nil, "OVERLAY")
    trinket.texture.overlay:SetAllPoints(trinket)
    trinket.texture.overlay:SetTexture(Gladdy.db.trinketBorderStyle)

    trinket.unit = unit

    trinket:SetScript("OnUpdate", iconTimer)

    self.frames[unit] = trinket
    Gladdy.buttons[unit].trinket = trinket
end

function Trinket:UpdateFrame(unit)
    local trinket = self.frames[unit]
    if (not trinket) then
        return
    end

    local testAgain = false

    local width, height = Gladdy.db.trinketSize * Gladdy.db.trinketWidthFactor, Gladdy.db.trinketSize

    trinket:SetFrameStrata(Gladdy.db.trinketFrameStrata)
    trinket:SetFrameLevel(Gladdy.db.trinketFrameLevel)
    trinket.cooldown:SetFrameStrata(Gladdy.db.trinketFrameStrata)
    trinket.cooldown:SetFrameLevel(Gladdy.db.trinketFrameLevel + 1)
    trinket.cooldownFrame:SetFrameStrata(Gladdy.db.trinketFrameStrata)
    trinket.cooldownFrame:SetFrameLevel(Gladdy.db.trinketFrameLevel + 2)
    trinket.borderFrame:SetFrameStrata(Gladdy.db.trinketFrameStrata)
    trinket.borderFrame:SetFrameLevel(Gladdy.db.trinketFrameLevel + 3)

    trinket:SetWidth(width)
    trinket:SetHeight(height)
    if Gladdy.db.trinketIconZoomed then
        trinket.cooldown:SetWidth(width)
        trinket.cooldown:SetHeight(height)

    else
        trinket.cooldown:SetWidth(width - width/16)
        trinket.cooldown:SetHeight(height - height/16)
    end
    trinket.cooldown:ClearAllPoints()
    trinket.cooldown:SetPoint("CENTER", trinket, "CENTER")
    trinket.cooldown.noCooldownCount = true -- Gladdy.db.trinketDisableOmniCC
    trinket.cooldown:SetAlpha(Gladdy.db.trinketCooldownAlpha)

    trinket.texture:ClearAllPoints()
    trinket.texture:SetAllPoints(trinket)

    trinket.texture.overlay:SetTexture(Gladdy.db.trinketBorderStyle)
    trinket.texture.overlay:SetVertexColor(Gladdy:SetColor(Gladdy.db.trinketBorderColor))

    if Gladdy.db.trinketIconZoomed then
        if trinket.texture.masked then
            trinket.texture:SetMask(nil)
            trinket.texture:SetTexCoord(0.1,0.9,0.1,0.9)
            trinket.texture.masked = nil
        end
    else
        if not trinket.texture.masked then
            trinket.texture:SetMask(nil)
            trinket.texture:SetTexCoord(0,1,0,1)
            trinket.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
            trinket.texture.masked = true
            if Gladdy.frame.testing then
                testAgain = true
            end
        end
    end

    if Gladdy.db.trinketColored then
        if trinket.active then
            trinket:SetBackdropColor(Gladdy:SetColor(Gladdy.db.trinketColoredCd))
        else
            trinket:SetBackdropColor(Gladdy:SetColor(Gladdy.db.trinketColoredNoCd))
        end
        trinket.texture:SetTexture()
    else
        trinket:SetBackdropColor(0,0,0,0)
        trinket.texture:SetTexture("Interface\\Icons\\INV_Jewelry_TrinketPVP_02")
    end

    Gladdy:SetPosition(trinket, unit, "trinketXOffset", "trinketYOffset", Trinket:LegacySetPosition(trinket, unit), Trinket)

    if (Gladdy.db.trinketGroup) then
        if (unit ~= "arena1") then
            local previousUnit = "arena" .. str_gsub(unit, "arena", "") - 1
            self.frames[unit]:ClearAllPoints()
            if Gladdy.db.trinketGroupDirection == "RIGHT" then
                self.frames[unit]:SetPoint("LEFT", self.frames[previousUnit], "RIGHT", 0, 0)
            elseif Gladdy.db.trinketGroupDirection == "LEFT" then
                self.frames[unit]:SetPoint("RIGHT", self.frames[previousUnit], "LEFT", 0, 0)
            elseif Gladdy.db.trinketGroupDirection == "UP" then
                self.frames[unit]:SetPoint("BOTTOM", self.frames[previousUnit], "TOP", 0, 0)
            elseif Gladdy.db.trinketGroupDirection == "DOWN" then
                self.frames[unit]:SetPoint("TOP", self.frames[previousUnit], "BOTTOM", 0, 0)
            end
        end
    end

    if (unit == "arena1") then
        Gladdy:CreateMover(trinket,"trinketXOffset", "trinketYOffset", L["Trinket"],
                {"TOPLEFT", "TOPLEFT"},
                Gladdy.db.trinketSize * Gladdy.db.trinketWidthFactor,
                Gladdy.db.trinketSize,
                0,
                0, "trinketEnabled")
    end

    trinket.cooldown:SetAlpha(Gladdy.db.trinketCooldownAlpha)

    if Gladdy.db.trinketDisableCircle then
        trinket.cooldown:Hide()
    else
        trinket.cooldown:Show()
    end

    if (not Gladdy.db.trinketEnabled) then
        trinket:Hide()
    else
        trinket:Show()
        if testAgain then
            Trinket:ResetUnit(unit)
            Trinket:Test(unit)
        end
    end
end

function Trinket:Reset()
    self:UnregisterEvent("ARENA_COOLDOWNS_UPDATE")
    self:SetScript("OnEvent", nil)
end

function Trinket:ResetUnit(unit)
    local trinket = self.frames[unit]
    if (not trinket) then
        return
    end

    trinket.itemID = nil
    trinket.timeLeft = nil
    trinket.active = false
    trinket.cooldown:Clear()
    trinket.cooldownFont:SetText("")
end

function Trinket:Test(unit)
    local trinket = self.frames[unit]
    if (not trinket) then
        return
    end
    if (unit == "arena1" or unit == "arena2") then
        Gladdy:SendMessage("TRINKET_USED", unit)
    end
end

function Trinket:JOINED_ARENA()
    self:RegisterEvent("ARENA_COOLDOWNS_UPDATE")
    self:RegisterEvent("ARENA_CROWD_CONTROL_SPELL_UPDATE")
    self:SetScript("OnEvent", function(self, event, ...)
        if self[event] then
            self[event](self, ...)
        end
    end)
end

function Trinket:ARENA_CROWD_CONTROL_SPELL_UPDATE(...)
    local unitID, spellID, itemID = ...
    Gladdy:Debug("INFO", "Trinket:ARENA_CROWD_CONTROL_SPELL_UPDATE", unitID, spellID, itemID)
    if Gladdy.buttons[unitID] and Gladdy:GetPvpTrinkets()[itemID] then
        Gladdy.buttons[unitID].trinket.itemID = itemID
        if not Gladdy.db.trinketColored then
            self.frames[unitID].texture:SetTexture(GetItemIcon(itemID))
        end
    end
end

function Trinket:TRINKET_USED(unit)
    if Gladdy.buttons[unit] then
        self:Used(unit, GetTime() * 1000,
                Gladdy.buttons[unit].trinket.itemID and Gladdy:GetPvpTrinkets()[Gladdy.buttons[unit].trinket.itemID]
                        or 120000)
    end
end

function Trinket:RACIAL_USED(unit) -- Wrath only
    local trinket = self.frames[unit]
    if (not trinket) then
        return
    end
    if Gladdy.buttons[unit].race == "Scourge" then
        if trinket.active and trinket.timeLeft >= 45 then
            -- do nothing
        else
            self:Used(unit, GetTime() * 1000, 45000)
        end
    elseif Gladdy.buttons[unit].race == "Human" then
        self:Used(unit, GetTime() * 1000, 120000)
    end
end

function Trinket:ARENA_COOLDOWNS_UPDATE()
    for i=1, Gladdy.curBracket do
        local unitID = "arena" .. i
        local spellID, itemID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(unitID)
        if (spellID) then
            Gladdy:Debug("INFO", "Trinket:ARENA_COOLDOWNS_UPDATE", spellID, itemID, startTime, duration)
            if not Gladdy.db.trinketColored and Gladdy:GetPvpTrinkets()[itemID] then
                self.frames[unitID].texture:SetTexture(GetItemIcon(itemID))
            end
            if (startTime ~= 0 and duration ~= 0) then
                self:Used(unitID, startTime, duration)
            end
        end
    end
end

function Trinket:Used(unit, startTime, duration)
    local trinket = self.frames[unit]
    if (not trinket or not Gladdy.db.trinketEnabled) then
        return
    end
    --if not trinket.active then
        trinket.timeLeft = (startTime/1000.0 + duration/1000.0) - GetTime()
        if not Gladdy.db.trinketDisableCircle then trinket.cooldown:SetCooldown(startTime/1000.0, duration/1000.0) end
        trinket.active = true
        if Gladdy.db.trinketColored then
            trinket:SetBackdropColor(Gladdy:SetColor(Gladdy.db.trinketColoredCd))
        end
    --end
end

function Trinket:GetOptions()
    return {
        headerTrinket = {
            type = "header",
            name = L["Trinket"],
            order = 2,
        },
        trinketEnabled = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["Enable trinket icon"],
            order = 3,
        }),
        trinketColored = Gladdy:option({
            type = "toggle",
            name = L["Colored trinket"],
            desc = L["Shows a solid colored icon when off/off CD."],
            order = 4,
            disabled = function() return not Gladdy.db.trinketEnabled end,
        }),
        trinketColoredCd = Gladdy:colorOption({
            type = "color",
            name = L["Colored trinket CD"],
            desc = L["Color of the border"],
            order = 5,
            hasAlpha = true,
            disabled = function() return not Gladdy.db.trinketEnabled end,
        }),
        trinketColoredNoCd = Gladdy:colorOption({
            type = "color",
            name = L["Colored trinket No CD"],
            desc = L["Color of the border"],
            order = 6,
            hasAlpha = true,
            disabled = function() return not Gladdy.db.trinketEnabled end,
        }),
        trinketGroup = Gladdy:option({
            type = "toggle",
            name = L["Group Class Icons"],
            order = 7,
            disabled = function() return not Gladdy.db.trinketEnabled end,
        }),
        trinketGroupDirection = Gladdy:option({
            type = "select",
            name = L["Group direction"],
            order = 8,
            values = {
                ["RIGHT"] = L["Right"],
                ["LEFT"] = L["Left"],
                ["UP"] = L["Up"],
                ["DOWN"] = L["Down"],
            },
            disabled = function()
                return not Gladdy.db.trinketGroup or not Gladdy.db.trinketEnabled
            end,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 5,
            disabled = function() return not Gladdy.db.trinketEnabled end,
            args = {
                general = {
                    type = "group",
                    name = L["Icon"],
                    order = 1,
                    args = {
                        header = {
                            type = "header",
                            name = L["Icon"],
                            order = 1,
                        },
                        trinketIconZoomed = Gladdy:option({
                            type = "toggle",
                            name = L["Zoomed Icon"],
                            desc = L["Zoomes the icon to remove borders"],
                            order = 2,
                            width = "full",
                        }),
                        trinketSize = Gladdy:option({
                            type = "range",
                            name = L["Size"],
                            min = 5,
                            max = 100,
                            step = 1,
                            order = 4,
                            width = "full",
                        }),
                        trinketWidthFactor = Gladdy:option({
                            type = "range",
                            name = L["Icon width factor"],
                            min = 0.5,
                            max = 2,
                            step = 0.05,
                            order = 6,
                            width = "full",
                        }),
                    },
                },
                cooldown = {
                    type = "group",
                    name = L["Cooldown"],
                    order = 2,
                    args = {
                        header = {
                            type = "header",
                            name = L["Cooldown"],
                            order = 4,
                        },
                        trinketDisableCircle = Gladdy:option({
                            type = "toggle",
                            name = L["No Cooldown Circle"],
                            order = 7,
                            width = "full",
                        }),
                        trinketCooldownAlpha = Gladdy:option({
                            type = "range",
                            name = L["Cooldown circle alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 8,
                            width = "full",
                        }),
                        trinketCooldownNumberAlpha = Gladdy:option({
                            type = "range",
                            name = L["Cooldown number alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 9,
                            width = "full",
                        }),
                    },
                },
                font = {
                    type = "group",
                    name = L["Font"],
                    order = 3,
                    args = {
                        header = {
                            type = "header",
                            name = L["Font"],
                            order = 1,
                        },
                        trinketFontEnabled = Gladdy:option({
                            type = "toggle",
                            name = L["Font Enabled"],
                            order = 2,
                            width = "full",
                        }),
                        trinketFont = Gladdy:option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the cooldown"],
                            order = 3,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        trinketFontScale = Gladdy:option({
                            type = "range",
                            name = L["Font scale"],
                            desc = L["Scale of the font"],
                            order = 4,
                            min = 0.1,
                            max = 2,
                            step = 0.1,
                            width = "full",
                        }),
                    },
                },
                position = {
                    type = "group",
                    name = L["Position"],
                    order = 5,
                    args = {
                        header = {
                            type = "header",
                            name = L["Icon position"],
                            order = 4,
                        },
                        trinketXOffset = Gladdy:option({
                            type = "range",
                            name = L["Horizontal offset"],
                            order = 23,
                            min = -800,
                            max = 800,
                            step = 0.1,
                            width = "full",
                        }),
                        trinketYOffset = Gladdy:option({
                            type = "range",
                            name = L["Vertical offset"],
                            order = 24,
                            min = -800,
                            max = 800,
                            step = 0.1,
                            width = "full",
                        }),
                    },
                },
                border = {
                    type = "group",
                    name = L["Border"],
                    order = 4,
                    args = {
                        header = {
                            type = "header",
                            name = L["Border"],
                            order = 4,
                        },
                        trinketBorderStyle = Gladdy:option({
                            type = "select",
                            name = L["Border style"],
                            order = 31,
                            values = Gladdy:GetIconStyles()
                        }),
                        trinketBorderColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Border color"],
                            desc = L["Color of the border"],
                            order = 32,
                            hasAlpha = true,
                        }),
                    },
                },
                frameStrata = {
                    type = "group",
                    name = L["Frame Strata and Level"],
                    order = 6,
                    args = {
                        headerAuraLevel = {
                            type = "header",
                            name = L["Frame Strata and Level"],
                            order = 1,
                        },
                        trinketFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        trinketFrameLevel = Gladdy:option({
                            type = "range",
                            name = L["Frame Level"],
                            min = 0,
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

---------------------------

-- LAGACY HANDLER

---------------------------

function Trinket:LegacySetPosition(trinket, unit)
    if Gladdy.db.newLayout then
        return Gladdy.db.newLayout
    end
    trinket:ClearAllPoints()
    local margin = (Gladdy.db.highlightInset and 0 or Gladdy.db.highlightBorderSize) + Gladdy.db.padding
    if (Gladdy.db.classIconPos == "LEFT") then
        if (Gladdy.db.trinketPos == "RIGHT") then
            trinket:SetPoint("TOPLEFT", Gladdy.buttons[unit].healthBar, "TOPRIGHT", margin, 0)
        else
            trinket:SetPoint("TOPRIGHT", Gladdy.buttons[unit].classIcon, "TOPLEFT", -Gladdy.db.padding, 0)
        end
    else
        if (Gladdy.db.trinketPos == "RIGHT") then
            trinket:SetPoint("TOPLEFT", Gladdy.buttons[unit].classIcon, "TOPRIGHT", Gladdy.db.padding, 0)
        else
            trinket:SetPoint("TOPRIGHT", Gladdy.buttons[unit].healthBar, "TOPLEFT", -margin, 0)
        end
    end
end