local pairs, ipairs = pairs, ipairs
local floor, abs = math.floor, math.abs
local str_find, str_gsub, str_sub, tinsert = string.find, string.gsub, string.sub, table.insert
local UnitHealth, UnitHealthMax, UnitName, UnitExists, UnitIsDeadOrGhost = UnitHealth, UnitHealthMax, UnitName, UnitExists, UnitIsDeadOrGhost

local CreateFrame = CreateFrame
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local AceGUIWidgetLSMlists = AceGUIWidgetLSMlists
local Healthbar = Gladdy:NewModule("Health Bar", 100, {
    healthBarFont = "DorisPP",
    healthBarHeight = 60,
    healthBarTexture = "Smooth",
    healthBarBorderStyle = "Gladdy Tooltip round",
    healthBarBorderSize = 9,
    healthBarBorderColor = { r = 0, g = 0, b = 0, a = 1 },
    healthBarBgColor = { r = 0, g = 0, b = 0, a = 0.4 },
    healthBarClassColored = true,
    healthBarColoredByCurrentHp = false,
    healthBarStatusBarColorMax = { r = 0, g = 1, b = 0, a = 1 },
    healthBarStatusBarColorMid = { r = 1, g = 1, b = 0, a = 1 },
    healthBarStatusBarColorMin = { r = 1, g = 0, b = 0, a = 1 },
    healthFrameStrata = "MEDIUM",
    healthFrameLevel = 1,
    healthBarStealthColor = { r = 0.66, g = 0.66, b = 0.66, a = 1 },
    --font
    healthBarFontColor = { r = 1, g = 1, b = 1, a = 1 },
    healthBarNameFontSize = 12,
    healthBarHealthFontSize = 12,
    healthNameToArenaId = false,
    healthName = true,
    healthActual = false,
    healthMax = true,
    healthPercentage = true,
    healthCustomTagsEnabled = false,
    healthTextLeft = "[name]",
    healthTextRight = "[percent|status]",
    healthTextLeftOutline = false,
    healthTextRightOutline = false,
    healthTextLeftVOffset = 0,
    healthTextLeftHOffset = 5,
    healthTextRightVOffset = 0,
    healthTextRightHOffset = -5,
})

function Healthbar:Initialize()
    self.frames = {}
    self:RegisterMessage("JOINED_ARENA")
    self:RegisterMessage("ENEMY_SPOTTED")
    self:RegisterMessage("ENEMY_STEALTH")
    self:RegisterMessage("UNIT_SPEC")
    self:RegisterMessage("UNIT_DESTROYED")
    self:RegisterMessage("UNIT_DEATH")
end

function Healthbar:CreateFrame(unit)
    local button = Gladdy.buttons[unit]

    local healthBar = CreateFrame("Frame", nil, Gladdy.buttons[unit], BackdropTemplateMixin and "BackdropTemplate")
    healthBar:EnableMouse(false)
    healthBar:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "healthBarBorderStyle"),
                                   edgeSize = Gladdy.db.healthBarBorderSize })
    healthBar:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.healthBarBorderColor))
    healthBar:SetFrameStrata(Gladdy.db.healthFrameStrata)
    healthBar:SetFrameLevel(Gladdy.db.healthFrameLevel)

    healthBar.hp = CreateFrame("StatusBar", nil, healthBar)
    healthBar.hp:SetStatusBarTexture(Gladdy:SMFetch("statusbar", "healthBarTexture"))
    healthBar.hp:SetMinMaxValues(0, 100)
    healthBar.hp:SetFrameStrata(Gladdy.db.healthFrameStrata)
    healthBar.hp:SetFrameLevel(Gladdy.db.healthFrameLevel - 1)

    healthBar.bg = healthBar.hp:CreateTexture(nil, "BACKGROUND")
    healthBar.bg:SetTexture(Gladdy:SMFetch("statusbar", "healthBarTexture"))
    healthBar.bg:ClearAllPoints()
    healthBar.bg:SetAllPoints(healthBar.hp)
    healthBar.bg:SetAlpha(1)
    healthBar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.healthBarBgColor))

    healthBar.nameText = healthBar:CreateFontString(nil, "LOW", "GameFontNormalSmall")
    if (Gladdy.db.healthBarNameFontSize < 1) then
        healthBar.nameText:SetFont(Gladdy:SMFetch("font", "healthBarNameFont"), 1)
        healthBar.nameText:Hide()
    else
        healthBar.nameText:SetFont(Gladdy:SMFetch("font", "healthBarFont"), Gladdy.db.healthBarNameFontSize, Gladdy.db.healthTextLeftOutline and "OUTLINE")
        healthBar.nameText:Show()
    end
    healthBar.nameText:SetTextColor(Gladdy:SetColor(Gladdy.db.healthBarFontColor))
    healthBar.nameText:SetShadowOffset(1, -1)
    healthBar.nameText:SetShadowColor(0, 0, 0, 1)
    healthBar.nameText:SetJustifyH("CENTER")
    healthBar.nameText:SetPoint("LEFT", Gladdy.db.healthTextLeftHOffset, Gladdy.db.healthTextLeftVOffset)

    healthBar.healthText = healthBar:CreateFontString(nil, "LOW")
    if (Gladdy.db.healthBarHealthFontSize < 1) then
        healthBar.healthText:SetFont(Gladdy:SMFetch("font", "healthBarFont"), 1)
        healthBar.healthText:Hide()
    else
        healthBar.healthText:SetFont(Gladdy:SMFetch("font", "healthBarFont"), Gladdy.db.healthBarHealthFontSize, Gladdy.db.healthTextRightOutline and "OUTLINE")
        healthBar.healthText:Hide()
    end
    healthBar.healthText:SetTextColor(Gladdy:SetColor(Gladdy.db.healthBarFontColor))
    healthBar.healthText:SetShadowOffset(1, -1)
    healthBar.healthText:SetShadowColor(0, 0, 0, 1)
    healthBar.healthText:SetJustifyH("CENTER")
    healthBar.healthText:SetPoint("RIGHT", Gladdy.db.healthTextRightHOffset, Gladdy.db.healthTextRightVOffset)

    healthBar.unit = unit
    self.frames[unit] = healthBar
    button.healthBar = healthBar
    self:ResetUnit(unit)
    healthBar:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
    healthBar:RegisterUnitEvent("UNIT_MAXHEALTH", unit)
    healthBar:RegisterUnitEvent("UNIT_NAME_UPDATE", unit)
    healthBar:SetScript("OnEvent", Healthbar.OnEvent)
end

function Healthbar.OnEvent(self, event, unit)
    local isDead = UnitExists(unit) and UnitIsDeadOrGhost(unit) and not Gladdy:isFeignDeath(unit)
    if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
        if isDead then
            Gladdy:SendMessage("UNIT_DEATH", unit)
            return
        end
        local health = UnitHealth(unit)
        local healthMax = UnitHealthMax(unit)
        self.hp:SetMinMaxValues(0, healthMax)
        self.hp:SetValue(health)
        self.hp.current = health
        self.hp.max = healthMax
        Healthbar:SetText(unit, health, healthMax)
        Healthbar:SetHealthStatusBarColor(unit, self.hp.current, self.hp.max)
    elseif event == "UNIT_NAME_UPDATE" then
        local name = UnitName(unit)
        Gladdy.buttons[unit].name = name
        Healthbar:SetText(unit, self.hp.current, self.hp.max)
    end
    if not Gladdy.buttons[unit].class then
        Gladdy:SpotEnemy(unit, true)
    end
end

local function getGradient(start, ending, percentage, factor)
    return start * abs(-2 * percentage + 1) + ending * factor
end

local rMax, gMax, bMax, rMid, gMid, bMid, rMin, gMin, bMin, rNow, gNow, bNow, percentage, factor, stealthAlpha
function Healthbar:SetHealthStatusBarColor(unit, health, healthMax)
    local button = Gladdy.buttons[unit]
    if not button or not health or not healthMax then
        return
    end

    local healthBar = Gladdy.buttons[unit].healthBar
    if not healthBar.hp.oorFactor then
        healthBar.hp.oorFactor = 1
    end

    healthBar.hp:SetMinMaxValues(0, healthMax)
    healthBar.hp:SetValue(health)

    if healthBar.hp.stealth then
        stealthAlpha = Gladdy.db.healthBarStealthColor.a < Gladdy.db.healthBarBgColor.a and Gladdy.db.healthBarStealthColor.a or Gladdy.db.healthBarBgColor.a
        healthBar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.healthBarBgColor, nil, stealthAlpha))
        healthBar.hp:SetStatusBarColor(Gladdy:SetColor(Gladdy.db.healthBarStealthColor))
        return
    else
        healthBar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.healthBarBgColor))
    end

    if not Gladdy.db.healthBarClassColored then
        if Gladdy.db.healthBarColoredByCurrentHp then
            rMax, gMax, bMax = Gladdy:SetColor(Gladdy.db.healthBarStatusBarColorMax)
            rMid, gMid, bMid = Gladdy:SetColor(Gladdy.db.healthBarStatusBarColorMid)
            rMin, gMin, bMin = Gladdy:SetColor(Gladdy.db.healthBarStatusBarColorMin)
            percentage = health / healthMax
            if percentage == 0.5 then
                rNow, gNow, bNow = Gladdy:SetColor(Gladdy.db.healthBarStatusBarColorMid, healthBar.hp.oorFactor)
            elseif percentage < 0.5 then
                factor = percentage * 2
                rNow = getGradient(rMin, rMid, percentage, factor)
                gNow = getGradient(gMin, gMid, percentage, factor)
                bNow = getGradient(bMin, bMid, percentage, factor)
            elseif percentage > 0.5 then
                factor = ((healthMax - health) / healthMax) * 2
                rNow = getGradient(rMax, rMid, percentage, factor)
                gNow = getGradient(gMax, gMid, percentage, factor)
                bNow = getGradient(bMax, bMid, percentage, factor)
            end
            healthBar.hp:SetStatusBarColor(rNow / healthBar.hp.oorFactor, gNow / healthBar.hp.oorFactor, bNow / healthBar.hp.oorFactor, 1)
        else
            healthBar.hp:SetStatusBarColor(Gladdy:SetColor(Gladdy.db.healthBarStatusBarColorMax, healthBar.hp.oorFactor))
        end
    end
    if button.class and Gladdy.db.healthBarClassColored then
        healthBar.hp:SetStatusBarColor(
                RAID_CLASS_COLORS[button.class].r / healthBar.hp.oorFactor,
                RAID_CLASS_COLORS[button.class].g / healthBar.hp.oorFactor,
                RAID_CLASS_COLORS[button.class].b / healthBar.hp.oorFactor, 1)
    end
end

function Healthbar:SetHealthText(healthBar, health, healthMax)
    local healthText = ""
    local healthPercentage = health and healthMax and floor(health * 100 / healthMax)

    if health == 0 and UnitExists(healthBar.unit) and UnitIsDeadOrGhost(healthBar.unit) and not Gladdy:isFeignDeath(healthBar.unit) then
        self:UNIT_DEATH(healthBar.unit)
        return
    end
    if (Gladdy.db.healthPercentage and healthPercentage) then
        healthText = ("%d%%"):format(healthPercentage)
    end
    healthBar.healthText:SetText(healthText)
end

function Healthbar:SetText(unit, health, healthMax, status)
    local button = Gladdy.buttons[unit]
    if not Gladdy.buttons[unit] then
        return
    end
    if Gladdy.db.healthCustomTagsEnabled then
        button.healthBar.nameText:SetText(Gladdy:SetTag(unit, Gladdy.db.healthTextLeft, health, healthMax, status))
        button.healthBar.healthText:SetText(Gladdy:SetTag(unit, Gladdy.db.healthTextRight, health, healthMax, status))
    else
        if Gladdy.db.healthName then
            if Gladdy.db.healthNameToArenaId then
                button.healthBar.nameText:SetText(str_gsub(unit, "arena", ""))
            else
                button.healthBar.nameText:SetText(Gladdy.buttons[unit].name)
            end
        end
        if status then
            button.healthBar.healthText:SetText(status)
        else
            Healthbar:SetHealthText(button.healthBar, health, healthMax)
        end
    end
end

function Healthbar:UpdateFrame(unit)
    local healthBar = self.frames[unit]
    if (not healthBar) then
        return
    end

    healthBar:SetFrameStrata(Gladdy.db.healthFrameStrata)
    healthBar:SetFrameLevel(Gladdy.db.healthFrameLevel)
    healthBar.hp:SetFrameStrata(Gladdy.db.healthFrameStrata)
    healthBar.hp:SetFrameLevel(Gladdy.db.healthFrameLevel - 1)

    healthBar.bg:SetTexture(Gladdy:SMFetch("statusbar", "healthBarTexture"))
    healthBar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.healthBarBgColor))

    healthBar:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "healthBarBorderStyle"),
                            edgeSize = Gladdy.db.healthBarBorderSize })
    healthBar:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.healthBarBorderColor))
    healthBar:ClearAllPoints()
    healthBar:SetPoint("TOPLEFT", Gladdy.buttons[unit], "TOPLEFT", 0, 0)
    healthBar:SetPoint("BOTTOMRIGHT", Gladdy.buttons[unit], "BOTTOMRIGHT")

    healthBar.hp:SetStatusBarTexture(Gladdy:SMFetch("statusbar", "healthBarTexture"))
    healthBar.hp:ClearAllPoints()
    healthBar.hp:SetPoint("TOPLEFT", healthBar, "TOPLEFT", (Gladdy.db.healthBarBorderSize/Gladdy.db.statusbarBorderOffset), -(Gladdy.db.healthBarBorderSize/Gladdy.db.statusbarBorderOffset))
    healthBar.hp:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", -(Gladdy.db.healthBarBorderSize/Gladdy.db.statusbarBorderOffset), (Gladdy.db.healthBarBorderSize/Gladdy.db.statusbarBorderOffset))

    if (Gladdy.db.healthBarHealthFontSize < 1) then
        healthBar.healthText:SetFont(Gladdy:SMFetch("font", "healthBarFont"), 1)
        healthBar.healthText:Hide()
    else
        healthBar.healthText:SetFont(Gladdy:SMFetch("font", "healthBarFont"), Gladdy.db.healthBarHealthFontSize, Gladdy.db.healthTextRightOutline and "OUTLINE")
        healthBar.healthText:Show()
    end
    if (Gladdy.db.healthBarNameFontSize < 1) then
        healthBar.nameText:SetFont(Gladdy:SMFetch("font", "healthBarNameFont"), 1)
        healthBar.nameText:Hide()
    else
        healthBar.nameText:SetFont(Gladdy:SMFetch("font", "healthBarFont"), Gladdy.db.healthBarNameFontSize, Gladdy.db.healthTextLeftOutline and "OUTLINE")
        if Gladdy.db.healthName or Gladdy.db.healthCustomTagsEnabled then
            healthBar.nameText:Show()
        else
            healthBar.nameText:Hide()
        end
    end
    healthBar.nameText:SetTextColor(Gladdy:SetColor(Gladdy.db.healthBarFontColor))
    healthBar.healthText:SetTextColor(Gladdy:SetColor(Gladdy.db.healthBarFontColor))
    healthBar.nameText:SetPoint("LEFT", Gladdy.db.healthTextLeftHOffset, Gladdy.db.healthTextLeftVOffset)
    healthBar.healthText:SetPoint("RIGHT", Gladdy.db.healthTextRightHOffset, Gladdy.db.healthTextRightVOffset)

    Healthbar:SetHealthStatusBarColor(unit, healthBar.hp.current, healthBar.hp.max)
end

function Healthbar:ResetUnit(unit)
    local healthBar = self.frames[unit]
    if (not healthBar) then
        return
    end

    healthBar.hp:SetStatusBarColor(1, 1, 1, 1)
    healthBar.nameText:SetText("")
    healthBar.healthText:SetText("")
    healthBar.hp:SetValue(0)
    healthBar.hp.current = nil
    healthBar.hp.max = nil
end

function Healthbar:Test(unit)
    local healthBar = self.frames[unit]
    local button = Gladdy.buttons[unit]
    if (not healthBar or not button) then
        return
    end

    Gladdy:SendMessage("UNIT_HEALTH", unit, button.health, button.healthMax)
    healthBar.hp.current = button.health
    healthBar.hp.max = button.healthMax
    self:ENEMY_SPOTTED(unit)
    self:SetText(unit, button.health, button.healthMax)
    healthBar.hp:SetValue(button.health)
    if unit == "arena1" then
        self:UNIT_DEATH(unit)
    end
end

function Healthbar:UNIT_SPEC(unit)
    local button = Gladdy.buttons[unit]
    if not button then
        return
    end
    self:SetText(unit, button.healthBar.hp.current, button.healthBar.hp.max)
    --button.healthBar.nameText:SetText(Gladdy:SetTag(unit, Gladdy.db.healthTextLeft, button.health, button.healthMax))
end

function Healthbar:JOINED_ARENA()
    for i=1,Gladdy.curBracket do
        local unit = "arena" .. i
        self:SetText(unit, self.frames[unit].hp.current, self.frames[unit].hp.max)
    end
end

function Healthbar:ENEMY_SPOTTED(unit)
    local healthBar = self.frames[unit]
    local button = Gladdy.buttons[unit]
    if (not healthBar or not button) then
        return
    end

    if UnitExists(unit) then
        local health = UnitHealth(unit)
        local healthMax = UnitHealthMax(unit)
        healthBar.hp:SetMinMaxValues(0, healthMax)
        healthBar.hp:SetValue(health)
        healthBar.hp.current = health
        healthBar.hp.max = healthMax
    end
    Healthbar:SetText(unit, healthBar.hp.current, healthBar.hp.max)
    Healthbar:SetHealthStatusBarColor(unit, healthBar.hp.current, healthBar.hp.max)
end

function Healthbar:ENEMY_STEALTH(unit, stealth)
    local healthBar = self.frames[unit]
    local button = Gladdy.buttons[unit]
    if (not healthBar or not button) then
        return
    end

    healthBar.hp.stealth = stealth

    Healthbar:SetHealthStatusBarColor(unit, healthBar.hp.current, healthBar.hp.max)
end

function Healthbar:UNIT_DEATH(unit)
    local healthBar = self.frames[unit]
    if (not healthBar) then
        return
    end

    healthBar.hp:SetValue(0)
    healthBar.hp.current = 0
    Healthbar:SetText(unit, 0, 100, L["DEAD"])
end

function Healthbar:UNIT_DESTROYED(unit)
    local healthBar = self.frames[unit]
    if (not healthBar) then
        return
    end

    healthBar.hp:SetValue(0)
    healthBar.hp.current = 0
    Healthbar:SetText(unit, 0, 100, L["LEAVE"])
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
            Gladdy.options.args["Health Bar"].args.group.args.border.args.healthBarBorderSize.max = Gladdy.db.healthBarHeight/2
            if Gladdy.db.healthBarBorderSize > Gladdy.db.healthBarHeight/2 then
                Gladdy.db.healthBarBorderSize = Gladdy.db.healthBarHeight/2
            end
            if Gladdy.frame.testing then
                for i=1,Gladdy.curBracket do
                    Healthbar:Test("arena" .. i)
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

function Healthbar:GetOptions()
    return {
        headerHealthbar = {
            type = "header",
            name = L["Health Bar"],
            order = 2,
        },
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 3,
            args = {
                general = {
                    type = "group",
                    name = L["General"],
                    order = 1,
                    args = {
                        headerAuras = {
                            type = "header",
                            name = L["General"],
                            order = 1,
                        },
                        healthBarHeight = option({
                            type = "range",
                            name = L["Bar height"],
                            desc = L["Height of the bar"],
                            order = 3,
                            min = 10,
                            max = 100,
                            step = 1,
                            width = "full",
                        }),
                        healthBarTexture = option({
                            type = "select",
                            name = L["Bar texture"],
                            desc = L["Texture of the bar"],
                            order = 4,
                            dialogControl = "LSM30_Statusbar",
                            values = AceGUIWidgetLSMlists.statusbar,
                        }),
                    },
                },
                barColor = {
                    type = "group",
                    name = L["Bar Color"],
                    order = 2,
                    args = {
                        headerAuras = {
                            type = "header",
                            name = L["Color"],
                            order = 1,
                        },
                        healthBarClassColored = Gladdy:option({
                            type = "toggle",
                            name = L["Class colored"] .. " " .. L["Health Bar"],
                            order = 2,
                            width = "full",
                        }),
                        healthBarStealthColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Stealth Color"],
                            order = 3,
                            hasAlpha = true,
                        }),
                        healthBarBgColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Background color"],
                            desc = L["Color of the status bar background"],
                            order = 4,
                            hasAlpha = true,
                        }),
                        headerAuras = {
                            type = "header",
                            name = L["Custom Colors"],
                            order = 10,
                        },
                        healthBarColoredByCurrentHp = Gladdy:option({
                            type = "toggle",
                            name = L["Enable Custom Colors"],
                            order = 11,
                            width = "full",
                            disabled = function() return Gladdy.db.healthBarClassColored end,
                        }),
                        healthBarStatusBarColorMax = Gladdy:colorOption({
                            type = "color",
                            name = L["100%"],
                            order = 12,
                            hasAlpha = false,
                            disabled = function() return Gladdy.db.healthBarClassColored end,
                        }),
                        healthBarStatusBarColorMid = Gladdy:colorOption({
                            type = "color",
                            name = L["50%"],
                            order = 13,
                            hasAlpha = false,
                            disabled = function() return Gladdy.db.healthBarClassColored end,
                        }),
                        healthBarStatusBarColorMin = Gladdy:colorOption({
                            type = "color",
                            name = L["0%"],
                            order = 14,
                            hasAlpha = false,
                            disabled = function() return Gladdy.db.healthBarClassColored end,
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
                        healthBarFont = option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the bar"],
                            order = 11,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        healthBarFontColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Font color"],
                            desc = L["Color of the text"],
                            order = 12,
                            hasAlpha = true,
                        }),
                        healthTextLeftOutline = option({
                            type = "toggle",
                            name = L["Left Font Outline"],
                            order = 13,
                            width = "full",
                        }),
                        healthTextRightOutline = option({
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
                        healthBarNameFontSize = option({
                            type = "range",
                            name = L["Name font size"],
                            desc = L["Size of the name text"],
                            order = 21,
                            step = 0.1,
                            min = 0,
                            max = 20,
                            width = "full",
                        }),
                        healthBarHealthFontSize = option({
                            type = "range",
                            name = L["Health font size"],
                            desc = L["Size of the health text"],
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
                        healthTextLeftVOffset = option({
                            type = "range",
                            name = L["Left Text Vertical Offset"],
                            order = 31,
                            step = 0.1,
                            min = -200,
                            max = 200,
                            width = "full",
                        }),
                        healthTextLeftHOffset = option({
                            type = "range",
                            name = L["Left Text Horizontal Offset"],
                            order = 32,
                            step = 0.1,
                            min = -200,
                            max = 200,
                            width = "full",
                        }),
                        healthTextRightVOffset = option({
                            type = "range",
                            name = L["Right Text Vertical Offset"],
                            order = 33,
                            step = 0.1,
                            min = -200,
                            max = 200,
                            width = "full",
                        }),
                        healthTextRightHOffset = option({
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
                    order = 4,
                    args = {
                        header = {
                            type = "header",
                            name = L["Border"],
                            order = 1,
                        },
                        healthBarBorderStyle = option({
                            type = "select",
                            name = L["Border style"],
                            order = 21,
                            dialogControl = "LSM30_Border",
                            values = AceGUIWidgetLSMlists.border,
                        }),
                        healthBarBorderSize = option({
                            type = "range",
                            name = L["Border size"],
                            desc = L["Size of the border"],
                            order = 22,
                            min = 0.5,
                            max = Gladdy.db.healthBarHeight/2,
                            step = 0.5,
                            width = "full",
                        }),
                        healthBarBorderColor = Gladdy:colorOption({
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
                    order = 5,
                    args = {
                        headerAuraLevel = {
                            type = "header",
                            name = L["Frame Strata and Level"],
                            order = 1,
                        },
                        healthFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        healthFrameLevel = Gladdy:option({
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
                healthValues = {
                    type = "group",
                    name = L["Health Bar Text"],
                    order = 6,
                    args = {
                        header = {
                            type = "header",
                            name = L["Health Bar Text"],
                            order = 1,
                        },
                        healthName = option({
                            type = "toggle",
                            name = L["Show name text"],
                            desc = L["Show the units name"],
                            order = 2,
                            width = "full",
                            disabled = function() return Gladdy.db.healthCustomTagsEnabled end,
                        }),
                        healthNameToArenaId = option({
                            type = "toggle",
                            name = L["Show ArenaX"],
                            desc = L["Show 1-5 as name instead"],
                            order = 3,
                            width = "full",
                            disabled = function() return not Gladdy.db.healthName or Gladdy.db.healthCustomTagsEnabled end,
                        }),
                        healthPercentage = option({
                            type = "toggle",
                            name = L["Show health percentage"],
                            desc = L["Show health percentage on the health bar"],
                            order = 6,
                            width = "full",
                            disabled = function() return Gladdy.db.healthCustomTagsEnabled end,
                        }),
                        header = {
                            type = "header",
                            name = L["Custom Tags"],
                            order = 10,
                        },
                        healthCustomTagsEnabled = Gladdy:GetTagOption(L["Custom Tags Enabled"], 11, nil, option, true),
                        healthTextLeft = Gladdy:GetTagOption(L["Left Text"], 12, "healthCustomTagsEnabled", option),
                        healthTextRight = Gladdy:GetTagOption(L["Right Text"], 13, "healthCustomTagsEnabled", option),
                    },
                },
            },
        },
    }
end