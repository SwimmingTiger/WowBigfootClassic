local ceil, str_gsub = ceil, string.gsub

local CreateFrame = CreateFrame
local GetTime = GetTime

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local Racial = Gladdy:NewModule("Racial", 79, {
    racialFont = "DorisPP",
    racialFontScale = 1,
    racialEnabled = true,
    racialSize = 60 + 20 + 1,
    racialWidthFactor = 0.9,
    racialIconZoomed = false,
    racialXOffset = 0,
    racialYOffset = 0,
    racialBorderStyle = "Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp",
    racialBorderColor = { r = 0, g = 0, b = 0, a = 1 },
    racialDisableCircle = false,
    racialCooldownAlpha = 1,
    racialCooldownNumberAlpha = 1,
    racialFrameStrata = "MEDIUM",
    racialFrameLevel = 5,
    racialGroup = false,
    racialGroupDirection = "DOWN",
})


function Racial:Initialize()
    self.frames = {}

    if Gladdy.db.racialEnabled then
        self:RegisterMessage("JOINED_ARENA")
        self:RegisterMessage("ENEMY_SPOTTED")
        self:RegisterMessage("RACIAL_USED")
        if Gladdy.expansion == "Wrath" then
            self:RegisterMessage("TRINKET_USED")
        end
    end
end

function Racial:UpdateFrameOnce()
    if Gladdy.db.racialEnabled then
        self:RegisterMessage("JOINED_ARENA")
        self:RegisterMessage("ENEMY_SPOTTED")
        self:RegisterMessage("RACIAL_USED")
        if Gladdy.expansion == "Wrath" then
            self:RegisterMessage("TRINKET_USED")
        end
    else
        self:UnregisterAllMessages()
    end
end

local function iconTimer(self,elapsed)
    if (self.active) then
        if (self.timeLeft <= 0) then
            self.active = false
            self.cooldown:Clear()
        else
            self.timeLeft = self.timeLeft - elapsed
        end

        local timeLeft = ceil(self.timeLeft)

        if timeLeft >= 60 then
            self.cooldownFont:SetTextColor(1, 1, 0, Gladdy.db.racialCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "racialFont"), (self:GetWidth()/2 - 0.15* self:GetWidth()) * Gladdy.db.racialFontScale, "OUTLINE")
        elseif timeLeft < 60 and timeLeft >= 30 then
            self.cooldownFont:SetTextColor(1, 1, 0, Gladdy.db.racialCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "racialFont"), (self:GetWidth()/2 - 1) * Gladdy.db.racialFontScale, "OUTLINE")
        elseif timeLeft < 30 and timeLeft >= 11 then
            self.cooldownFont:SetTextColor(1, 0.7, 0, Gladdy.db.racialCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "racialFont"), (self:GetWidth()/2 - 1) * Gladdy.db.racialFontScale, "OUTLINE")
        elseif timeLeft < 10 and timeLeft >= 5 then
            self.cooldownFont:SetTextColor(1, 0.7, 0, Gladdy.db.racialCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "racialFont"), (self:GetWidth()/2 - 1) * Gladdy.db.racialFontScale, "OUTLINE")
        elseif timeLeft < 5 and timeLeft > 0 then
            self.cooldownFont:SetTextColor(1, 0, 0, Gladdy.db.racialCooldownNumberAlpha)
            self.cooldownFont:SetFont(Gladdy:SMFetch("font", "racialFont"), (self:GetWidth()/2 - 1) * Gladdy.db.racialFontScale, "OUTLINE")
        end
        Gladdy:FormatTimer(self.cooldownFont, self.timeLeft, self.timeLeft < 10, true)
    end
end

function Racial:CreateFrame(unit)
    local racial = CreateFrame("Button", "GladdyTrinketButton" .. unit, Gladdy.buttons[unit])
    racial:EnableMouse(false)
    racial:SetFrameStrata(Gladdy.db.racialFrameStrata)
    racial:SetFrameLevel(Gladdy.db.racialFrameLevel)

    racial.texture = racial:CreateTexture(nil, "BACKGROUND")
    racial.texture:SetAllPoints(racial)
    racial.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
    racial.texture.masked = true
    --racial.texture:SetTexture("Interface\\Icons\\INV_Jewelry_TrinketPVP_02")

    racial.cooldown = CreateFrame("Cooldown", nil, racial, "CooldownFrameTemplate")
    racial.cooldown.noCooldownCount = true --Gladdy.db.racialDisableOmniCC
    racial.cooldown:SetHideCountdownNumbers(true)
    racial.cooldown:SetFrameStrata(Gladdy.db.racialFrameStrata)
    racial.cooldown:SetFrameLevel(Gladdy.db.racialFrameLevel + 1)

    racial.cooldownFrame = CreateFrame("Frame", nil, racial)
    racial.cooldownFrame:ClearAllPoints()
    racial.cooldownFrame:SetPoint("TOPLEFT", racial, "TOPLEFT")
    racial.cooldownFrame:SetPoint("BOTTOMRIGHT", racial, "BOTTOMRIGHT")
    racial.cooldownFrame:SetFrameStrata(Gladdy.db.racialFrameStrata)
    racial.cooldownFrame:SetFrameLevel(Gladdy.db.racialFrameLevel + 2)

    racial.cooldownFont = racial.cooldownFrame:CreateFontString(nil, "OVERLAY")
    racial.cooldownFont:SetFont(Gladdy:SMFetch("font", "racialFont"), 20, "OUTLINE")
    --trinket.cooldownFont:SetAllPoints(trinket.cooldown)
    racial.cooldownFont:SetJustifyH("CENTER")
    racial.cooldownFont:SetPoint("CENTER")

    racial.borderFrame = CreateFrame("Frame", nil, racial)
    racial.borderFrame:SetAllPoints(racial)
    racial.borderFrame:SetFrameStrata(Gladdy.db.racialFrameStrata)
    racial.borderFrame:SetFrameLevel(Gladdy.db.racialFrameLevel + 3)

    racial.texture.overlay = racial.borderFrame:CreateTexture(nil, "OVERLAY")
    racial.texture.overlay:SetAllPoints(racial)
    racial.texture.overlay:SetTexture(Gladdy.db.racialBorderStyle)

    racial:SetScript("OnUpdate", iconTimer)

    Gladdy.buttons[unit].racial = racial
    self.frames[unit] = racial
end

function Racial:UpdateFrame(unit)
    local racial = self.frames[unit]
    if (not racial) then
        return
    end

    local testAgain = false
    local width, height = Gladdy.db.racialSize * Gladdy.db.racialWidthFactor, Gladdy.db.racialSize

    racial:SetFrameStrata(Gladdy.db.racialFrameStrata)
    racial:SetFrameLevel(Gladdy.db.racialFrameLevel)
    racial.cooldown:SetFrameStrata(Gladdy.db.racialFrameStrata)
    racial.cooldown:SetFrameLevel(Gladdy.db.racialFrameLevel + 1)
    racial.cooldownFrame:SetFrameStrata(Gladdy.db.racialFrameStrata)
    racial.cooldownFrame:SetFrameLevel(Gladdy.db.racialFrameLevel + 2)
    racial.borderFrame:SetFrameStrata(Gladdy.db.racialFrameStrata)
    racial.borderFrame:SetFrameLevel(Gladdy.db.racialFrameLevel + 3)

    racial:SetWidth(width)
    racial:SetHeight(height)
    if Gladdy.db.racialIconZoomed then
        racial.cooldown:SetWidth(width)
        racial.cooldown:SetHeight(height)
    else
        racial.cooldown:SetWidth(width - width/16)
        racial.cooldown:SetHeight(height - height/16)
    end
    racial.cooldown:ClearAllPoints()
    racial.cooldown:SetPoint("CENTER", racial, "CENTER")
    racial.cooldown.noCooldownCount = true -- Gladdy.db.racialDisableOmniCC
    racial.cooldown:SetAlpha(Gladdy.db.racialCooldownAlpha)

    racial.texture:ClearAllPoints()
    racial.texture:SetAllPoints(racial)

    racial.texture.overlay:SetTexture(Gladdy.db.racialBorderStyle)
    racial.texture.overlay:SetVertexColor(Gladdy:SetColor(Gladdy.db.racialBorderColor))

    if Gladdy.db.racialIconZoomed then
        if racial.texture.masked then
            racial.texture:SetMask(nil)
            racial.texture:SetTexCoord(0.1,0.9,0.1,0.9)
            racial.texture.masked = nil
        end
    else
        if not racial.texture.masked then
            racial.texture:SetMask(nil)
            racial.texture:SetTexCoord(0,1,0,1)
            racial.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
            racial.texture.masked = true
            if Gladdy.frame.testing then
                testAgain = true
            end
        end
    end

    Gladdy:SetPosition(racial, unit, "racialXOffset", "racialYOffset", Racial:LegacySetPosition(racial, unit), Racial)

    if (Gladdy.db.racialGroup) then
        if (unit ~= "arena1") then
            local previousUnit = "arena" .. str_gsub(unit, "arena", "") - 1
            self.frames[unit]:ClearAllPoints()
            if Gladdy.db.racialGroupDirection == "RIGHT" then
                self.frames[unit]:SetPoint("LEFT", self.frames[previousUnit], "RIGHT", 0, 0)
            elseif Gladdy.db.racialGroupDirection == "LEFT" then
                self.frames[unit]:SetPoint("RIGHT", self.frames[previousUnit], "LEFT", 0, 0)
            elseif Gladdy.db.racialGroupDirection == "UP" then
                self.frames[unit]:SetPoint("BOTTOM", self.frames[previousUnit], "TOP", 0, 0)
            elseif Gladdy.db.racialGroupDirection == "DOWN" then
                self.frames[unit]:SetPoint("TOP", self.frames[previousUnit], "BOTTOM", 0, 0)
            end
        end
    end

    if (unit == "arena1") then
        Gladdy:CreateMover(racial,"racialXOffset", "racialYOffset", L["Racial"],
                {"TOPLEFT", "TOPLEFT"},
                Gladdy.db.racialSize * Gladdy.db.racialWidthFactor,
                Gladdy.db.racialSize,
                0, 0, "racialEnabled")
    end

    if (Gladdy.db.racialEnabled == false) then
        racial:Hide()
    else
        racial:Show()
        if testAgain then
            Racial:ResetUnit(unit)
            Racial:Test(unit)
        end
    end
end

function Racial:JOINED_ARENA()
    self:SetScript("OnEvent", function(self, event, ...)
        if self[event] then
            self[event](self, ...)
        end
    end)
end

function Racial:RACIAL_USED(unit, expirationTime, spellName)
    local racial = self.frames[unit]
    local button = Gladdy.buttons[unit]
    if (not racial or not button or not button.race or not Gladdy.db.racialEnabled) then
        return
    end
    if expirationTime and Gladdy:Racials()[button.race].spellName ~= spellName then
        return
    end
    local startTime = expirationTime or GetTime()
    Racial:Used(unit, startTime, Gladdy:Racials()[button.race].duration)
end

function Racial:TRINKET_USED(unit) -- Wrath only
    local racial = self.frames[unit]
    local button = Gladdy.buttons[unit]
    if (not racial or not button or not button.race) then
        return
    end
    if button.race == "Scourge" then
        if racial.active and racial.timeLeft >= 45 then
            -- do nothing
        else
            self:Used(unit, GetTime(), 45)
        end
    elseif button.race == "Human" then
        self:Used(unit, GetTime(), 120)
    end
end

function Racial:Used(unit, startTime, duration)
    local racial = self.frames[unit]
    if (not racial) then
        return
    end
    if not racial.active then
        racial.timeLeft = duration
        if not Gladdy.db.racialDisableCircle then racial.cooldown:SetCooldown(startTime, duration) end
        racial.active = true
    end
end

function Racial:ENEMY_SPOTTED(unit)
    local racial = self.frames[unit]
    if (not racial or not Gladdy.buttons[unit].race) then
        return
    end
    racial.texture:SetTexture(Gladdy:Racials()[Gladdy.buttons[unit].race].texture)
end

function Racial:ResetUnit(unit)
    local racial = self.frames[unit]
    if (not racial) then
        return
    end
    racial.texture:SetTexture(nil)
    racial.timeLeft = nil
    racial.active = false
    racial.cooldown:Clear()
    racial.cooldownFont:SetText("")
end

function Racial:Test(unit)
    Racial:ENEMY_SPOTTED(unit)
    if (unit == "arena2" or unit == "arena3") then
        Gladdy:SendMessage("RACIAL_USED", unit)
    end
end

function Racial:GetOptions()
    return {
        headerTrinket = {
            type = "header",
            name = L["Racial"],
            order = 2,
        },
        racialEnabled = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["Enable racial icon"],
            order = 3,
        }),
        racialGroup = Gladdy:option({
            type = "toggle",
            name = L["Group"] .. " " .. L["Racial"],
            order = 4,
            disabled = function() return not Gladdy.db.racialEnabled end,
        }),
        racialGroupDirection = Gladdy:option({
            type = "select",
            name = L["Group direction"],
            order = 5,
            values = {
                ["RIGHT"] = L["Right"],
                ["LEFT"] = L["Left"],
                ["UP"] = L["Up"],
                ["DOWN"] = L["Down"],
            },
            disabled = function()
                return not Gladdy.db.racialGroup or not Gladdy.db.racialEnabled
            end,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 6,
            disabled = function() return not Gladdy.db.racialEnabled end,
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
                        racialIconZoomed = Gladdy:option({
                            type = "toggle",
                            name = L["Zoomed Icon"],
                            desc = L["Zoomes the icon to remove borders"],
                            order = 2,
                            width = "full",
                        }),
                        racialSize = Gladdy:option({
                            type = "range",
                            name = L["Icon size"],
                            min = 5,
                            max = 100,
                            step = 1,
                            order = 3,
                            width = "full",
                        }),
                        racialWidthFactor = Gladdy:option({
                            type = "range",
                            name = L["Icon width factor"],
                            min = 0.5,
                            max = 2,
                            step = 0.05,
                            order = 4,
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
                        racialDisableCircle = Gladdy:option({
                            type = "toggle",
                            name = L["No Cooldown Circle"],
                            order = 7,
                            width = "full",
                        }),
                        racialCooldownAlpha = Gladdy:option({
                            type = "range",
                            name = L["Cooldown circle alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 8,
                            width = "full",
                        }),
                        racialCooldownNumberAlpha = Gladdy:option({
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
                            order = 4,
                        },
                        racialFont = Gladdy:option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the cooldown"],
                            order = 11,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        racialFontScale = Gladdy:option({
                            type = "range",
                            name = L["Font scale"],
                            desc = L["Scale of the font"],
                            order = 12,
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
                        racialXOffset = Gladdy:option({
                            type = "range",
                            name = L["Horizontal offset"],
                            order = 23,
                            min = -400,
                            max = 400,
                            step = 0.1,
                            width = "full",
                        }),
                        racialYOffset = Gladdy:option({
                            type = "range",
                            name = L["Vertical offset"],
                            order = 24,
                            min = -400,
                            max = 400,
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
                        racialBorderStyle = Gladdy:option({
                            type = "select",
                            name = L["Border style"],
                            order = 31,
                            values = Gladdy:GetIconStyles()
                        }),
                        racialBorderColor = Gladdy:colorOption({
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
                        racialFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        racialFrameLevel = Gladdy:option({
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

function Racial:LegacySetPosition(racial, unit)
    if Gladdy.db.newLayout then
        return Gladdy.db.newLayout
    end

    local ANCHORS = { ["LEFT"] = "RIGHT", ["RIGHT"] = "LEFT", ["BOTTOM"] = "TOP", ["TOP"] = "BOTTOM"}
    racial:ClearAllPoints()
    local parent = Gladdy.buttons[unit][Gladdy.db.racialAnchor]
    if (Gladdy.db.racialPos == "RIGHT") then
        racial:SetPoint(ANCHORS[Gladdy.db.racialPos], parent, Gladdy.db.racialPos, Gladdy.db.padding + Gladdy.db.racialXOffset, Gladdy.db.racialYOffset)
    elseif (Gladdy.db.racialPos == "LEFT") then
        racial:SetPoint(ANCHORS[Gladdy.db.racialPos], parent, Gladdy.db.racialPos, -Gladdy.db.padding + Gladdy.db.racialXOffset, Gladdy.db.racialYOffset)
    elseif (Gladdy.db.racialPos == "TOP") then
        racial:SetPoint(ANCHORS[Gladdy.db.racialPos], parent, Gladdy.db.racialPos, Gladdy.db.racialXOffset, Gladdy.db.padding + Gladdy.db.racialYOffset)
    elseif (Gladdy.db.racialPos == "BOTTOM") then
        racial:SetPoint(ANCHORS[Gladdy.db.racialPos], parent, Gladdy.db.racialPos, Gladdy.db.racialXOffset, -Gladdy.db.padding + Gladdy.db.racialYOffset)
    end
    return Gladdy.db.newLayout
end