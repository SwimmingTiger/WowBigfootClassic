local pairs = pairs
local select = select

local CreateFrame = CreateFrame
local GetSpellInfo = GetSpellInfo
local UnitChannelInfo = UnitChannelInfo
local UnitCastingInfo = UnitCastingInfo
local GetTime = GetTime
local CASTING_BAR_ALPHA_STEP = CASTING_BAR_ALPHA_STEP
local BackdropTemplateMixin = BackdropTemplateMixin

---------------------------

-- CORE

---------------------------

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local AceGUIWidgetLSMlists = AceGUIWidgetLSMlists
local Castbar = Gladdy:NewModule("Cast Bar", 70, {
    castBarEnabled = true,
    castBarHeight = 20,
    castBarWidth = 160,
    castBarIconSize = 22,
    castBarIconZoomed = false,
    castBarBorderSize = 8,
    castBarFontSize = 12,
    castBarFontOutline = false,
    castBarTexture = "Smooth",
    castBarIconStyle = "Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp",
    castBarBorderStyle = "Gladdy Tooltip round",
    castBarColor = { r = 1, g = 0.8, b = 0.2, a = 1 },
    castBarBgColor = { r = 0, g = 0, b = 0, a = 0.4 },
    castBarIconColor = { r = 0, g = 0, b = 0, a = 1 },
    castBarBorderColor = { r = 0, g = 0, b = 0, a = 1 },
    castBarFontColor = { r = 1, g = 1, b = 1, a = 1 },
    castBarIconEnabled = true,
    castBarGuesses = true,
    castBarXOffset = 0,
    castBarYOffset = 0,
    castBarIconPos = "LEFT",
    castBarFont = "DorisPP",
    castBarTimerFormat = "LEFT",
    castBarSparkEnabled = true,
    castBarSparkColor = { r = 1, g = 1, b = 1, a = 1 },
    castBarFrameStrata = "MEDIUM",
    castBarFrameLevel = 5,
})

function Castbar:Initialize()
    self.frames = {}
    if Gladdy.db.castBarEnabled then
        self:RegisterMessage("UNIT_DEATH")
        self:RegisterMessage("JOINED_ARENA")
    end
end

---------------------------

-- FRAME SETUP

---------------------------

function Castbar:CreateFrame(unit)
    local castBar = CreateFrame("Frame", nil, Gladdy.buttons[unit])
    castBar:EnableMouse(false)
    castBar:SetMovable(true)
    castBar.unit = unit
    castBar:SetFrameStrata(Gladdy.db.castBarFrameStrata)
    castBar:SetFrameLevel(Gladdy.db.castBarFrameLevel)

    castBar.backdrop = CreateFrame("Frame", nil, castBar, BackdropTemplateMixin and "BackdropTemplate")
    castBar.backdrop:SetAllPoints(castBar)
    castBar.backdrop:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "castBarBorderStyle"),
                                 edgeSize = Gladdy.db.castBarBorderSize })
    castBar.backdrop:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.castBarBorderColor))
    castBar.backdrop:SetFrameStrata(Gladdy.db.castBarFrameStrata)
    castBar.backdrop:SetFrameLevel(Gladdy.db.castBarFrameLevel - 1)

    castBar.bar = CreateFrame("StatusBar", nil, castBar)
    castBar.bar:SetStatusBarTexture(Gladdy:SMFetch("statusbar", "castBarTexture"))
    castBar.bar:SetStatusBarColor(Gladdy:SetColor(Gladdy.db.castBarColor))
    castBar.bar:SetMinMaxValues(0, 100)
    castBar.bar:SetFrameLevel(0)
    castBar.bar:SetFrameStrata(Gladdy.db.castBarFrameStrata)
    castBar.bar:SetFrameLevel(Gladdy.db.castBarFrameLevel)

    castBar.spark = castBar:CreateTexture(nil, "OVERLAY")
    castBar.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    castBar.spark:SetBlendMode("ADD")
    castBar.spark:SetWidth(16)
    castBar.spark:SetHeight(Gladdy.db.castBarHeight * 1.8)
    castBar.spark.position = 0

    castBar.bg = castBar.bar:CreateTexture(nil, "BACKGROUND")
    castBar.bg:SetAlpha(1)
    castBar.bg:SetTexture(Gladdy:SMFetch("statusbar", "castBarTexture"))
    castBar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.castBarBgColor))
    castBar.bg:SetAllPoints(castBar.bar)

    castBar.icon = CreateFrame("Frame", nil, castBar)
    castBar.icon:SetFrameStrata(Gladdy.db.castBarFrameStrata)
    castBar.icon:SetFrameLevel(Gladdy.db.castBarFrameLevel)
    castBar.icon.texture = castBar.icon:CreateTexture(nil, "BACKGROUND")
    castBar.icon.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
    castBar.icon.texture:SetAllPoints(castBar.icon)
    castBar.icon.texture.masked = true
    castBar.icon.texture.overlay = castBar.icon:CreateTexture(nil, "BORDER")
    castBar.icon.texture.overlay:SetAllPoints(castBar.icon.texture)
    castBar.icon.texture.overlay:SetTexture(Gladdy.db.castBarIconStyle)

    castBar.shield = castBar.icon:CreateTexture(nil, "OVERLAY")
    castBar.shield:SetTexture("Interface\\AddOns\\Gladdy\\Images\\castbar-shield")
    castBar.shield:SetHeight(80)
    castBar.shield:SetWidth(80)
    castBar.shield:SetPoint("CENTER", castBar.icon, "CENTER", 0, -1.5)

    castBar.icon:ClearAllPoints()
    if (Gladdy.db.castBarIconPos == "LEFT") then
        castBar.icon:SetPoint("RIGHT", castBar, "LEFT", -3, 0) -- Icon of castbar
    else
        castBar.icon:SetPoint("LEFT", castBar, "RIGHT", 3, 0) -- Icon of castbar
    end

    castBar.spellText = castBar:CreateFontString(nil, "LOW")
    castBar.spellText:SetFont(Gladdy:SMFetch("font", "auraFont"), Gladdy.db.castBarFontSize, Gladdy.db.castBarFontOutline and "OUTLINE")
    castBar.spellText:SetTextColor(Gladdy:SetColor(Gladdy.db.castBarFontColor))
    castBar.spellText:SetShadowOffset(1, -1)
    castBar.spellText:SetShadowColor(0, 0, 0, 1)
    castBar.spellText:SetJustifyH("CENTER")
    castBar.spellText:SetPoint("LEFT", 10, 0) -- Text of the spell

    castBar.timeText = castBar:CreateFontString(nil, "LOW")
    castBar.timeText:SetFont(Gladdy:SMFetch("font", "auraFont"), Gladdy.db.castBarFontSize, Gladdy.db.castBarFontOutline and "OUTLINE")
    castBar.timeText:SetTextColor(Gladdy:SetColor(Gladdy.db.castBarFontColor))
    castBar.timeText:SetShadowOffset(1, -1)
    castBar.timeText:SetShadowColor(0, 0, 0, 1)
    castBar.timeText:SetJustifyH("CENTER")
    castBar.timeText:SetPoint("RIGHT", -4, 0) -- text of cast timer

    Gladdy.buttons[unit].castBar = castBar
    self.frames[unit] = castBar
    self:ResetUnit(unit)
end

function Castbar:UpdateFrameOnce()
    if Gladdy.db.castBarEnabled then
        self:RegisterMessage("UNIT_DEATH")
        self:RegisterMessage("JOINED_ARENA")
    else
        self:UnregisterAllMessages()
    end
end

function Castbar:UpdateFrame(unit)
    local castBar = self.frames[unit]
    if (not castBar) then
        return
    end

    local testAgain = false

    castBar:SetFrameStrata(Gladdy.db.castBarFrameStrata)
    castBar:SetFrameLevel(Gladdy.db.castBarFrameLevel)
    castBar.backdrop:SetFrameStrata(Gladdy.db.castBarFrameStrata)
    castBar.backdrop:SetFrameLevel(Gladdy.db.castBarFrameLevel - 1)
    castBar.bar:SetFrameStrata(Gladdy.db.castBarFrameStrata)
    castBar.bar:SetFrameLevel(Gladdy.db.castBarFrameLevel)
    castBar.icon:SetFrameStrata(Gladdy.db.castBarFrameStrata)
    castBar.icon:SetFrameLevel(Gladdy.db.castBarFrameLevel)

    castBar:SetWidth(Gladdy.db.castBarWidth)
    castBar:SetHeight(Gladdy.db.castBarHeight)
    castBar.backdrop:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "castBarBorderStyle"),
                                 edgeSize = Gladdy.db.castBarBorderSize })
    castBar.backdrop:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.castBarBorderColor))

    castBar.bar:SetStatusBarTexture(Gladdy:SMFetch("statusbar", "castBarTexture"))
    castBar.bar:ClearAllPoints()
    castBar.bar:SetStatusBarColor(Gladdy:SetColor(Gladdy.db.castBarColor))
    castBar.bar:SetPoint("TOPLEFT", castBar, "TOPLEFT", (Gladdy.db.castBarBorderSize/Gladdy.db.statusbarBorderOffset), -(Gladdy.db.castBarBorderSize/Gladdy.db.statusbarBorderOffset))
    castBar.bar:SetPoint("BOTTOMRIGHT", castBar, "BOTTOMRIGHT", -(Gladdy.db.castBarBorderSize/Gladdy.db.statusbarBorderOffset), (Gladdy.db.castBarBorderSize/Gladdy.db.statusbarBorderOffset))

    castBar.bg:SetTexture(Gladdy:SMFetch("statusbar", "castBarTexture"))
    castBar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.castBarBgColor))

    if Gladdy.db.castBarSparkEnabled then
        castBar.spark:SetHeight(Gladdy.db.castBarHeight * 1.8)
        castBar.spark:SetVertexColor(Gladdy:SetColor(Gladdy.db.castBarSparkColor))
    else
        castBar.spark:SetAlpha(0)
    end

    castBar.icon:SetWidth(Gladdy.db.castBarIconSize)
    castBar.icon:SetHeight(Gladdy.db.castBarIconSize)
    castBar.icon.texture:SetAllPoints(castBar.icon)
    if Gladdy.db.castBarIconZoomed then
        if castBar.icon.texture.masked then
            castBar.icon.texture:SetMask(nil)
            castBar.icon.texture:SetTexCoord(0.1,0.9,0.1,0.9)
            castBar.icon.texture.masked = nil
        end
    else
        if not castBar.icon.texture.masked then
            castBar.icon.texture:SetMask(nil)
            castBar.icon.texture:SetTexCoord(0,1,0,1)
            castBar.icon.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
            castBar.icon.texture.masked = true
            if Gladdy.frame.testing then
                testAgain = true
            end
        end
    end
    castBar.icon:ClearAllPoints()

    castBar.shield:SetWidth(Gladdy.db.castBarIconSize * 3.2)
    castBar.shield:SetHeight(Gladdy.db.castBarIconSize * 3.2)

    local rightMargin = 0
    local leftMargin = 0
    if (Gladdy.db.castBarIconPos == "LEFT") then
        castBar.icon:SetPoint("RIGHT", castBar, "LEFT", -1, 0) -- Icon of castbar
        rightMargin = Gladdy.db.castBarIconSize + 1
    else
        castBar.icon:SetPoint("LEFT", castBar, "RIGHT", 1, 0) -- Icon of castbar
        leftMargin = Gladdy.db.castBarIconSize + 1
    end

    Gladdy:SetPosition(castBar, unit, "castBarXOffset", "castBarYOffset", Castbar:LegacySetPosition(castBar, unit, leftMargin, rightMargin), Castbar)

    castBar.spellText:SetFont(Gladdy:SMFetch("font", "castBarFont"), Gladdy.db.castBarFontSize, Gladdy.db.castBarFontOutline and "OUTLINE")
    castBar.spellText:SetTextColor(Gladdy:SetColor(Gladdy.db.castBarFontColor))

    castBar.timeText:SetFont(Gladdy:SMFetch("font", "castBarFont"), Gladdy.db.castBarFontSize, Gladdy.db.castBarFontOutline and "OUTLINE")
    castBar.timeText:SetTextColor(Gladdy:SetColor(Gladdy.db.castBarFontColor))

    castBar.icon.texture.overlay:SetTexture(Gladdy.db.castBarIconStyle)
    castBar.icon.texture.overlay:SetVertexColor(Gladdy:SetColor(Gladdy.db.castBarIconColor))

    if (unit == "arena1") then
        Gladdy:CreateMover(castBar, "castBarXOffset", "castBarYOffset", L["Cast Bar"],
                {"TOPLEFT", "TOPLEFT"}, Gladdy.db.castBarWidth, Gladdy.db.castBarHeight,
                0, 0, "castBarEnabled")
    end
    if not Gladdy.db.castBarEnabled then
        self:CAST_STOP(unit)
    end

    if Gladdy.db.castBarIconEnabled then
        castBar.icon:Show()
        if testAgain then
            self:ResetUnit(unit)
            self:Test(unit)
        end
    else
        castBar.icon:Hide()
    end
end

---------------------------

-- EVENT HANDLING

---------------------------

Castbar.TimerFormatFunc = {}
Castbar.TimerFormatFunc.LEFT = function(castBar)
    castBar.timeText:SetFormattedText("%.1f", castBar.casting and (castBar.maxValue - castBar.value) or castBar.value)
end
Castbar.TimerFormatFunc.TOTAL = function(castBar)
    castBar.timeText:SetFormattedText("%.1f", castBar.maxValue)
end
Castbar.TimerFormatFunc.BOTH = function(castBar)
    castBar.timeText:SetFormattedText("%.1f / %.1f", castBar.casting and (castBar.maxValue - castBar.value) or castBar.value, castBar.maxValue)
end

function Castbar.OnUpdate(castBar, elapsed)
    if castBar.channeling or castBar.casting then
        if ((castBar.casting and castBar.value >= castBar.maxValue) or (castBar.channeling and castBar.value <= 0)) then
            -- cast timed out
            castBar.holdTime = castBar.casting and (GetTime() + 0.25) or 0
            castBar.fadeOut = castBar.casting
            castBar.channeling = nil
            castBar.casting = nil
            Castbar:CAST_STOP(castBar.unit, 0, 1, 0, 1)
        else
            --cast active
            castBar.value = castBar.value + (castBar.casting and elapsed or -elapsed)
            castBar.bar:SetValue(castBar.value)
            Castbar.TimerFormatFunc[Gladdy.db.castBarTimerFormat](castBar)
            castBar.spark.position = ((castBar.value) / castBar.maxValue) * (castBar.bar:GetWidth() - (Gladdy.db.castBarBorderSize/Gladdy.db.statusbarBorderOffset)*2)
            if ( castBar.spark.position < 0 ) then
                castBar.spark.position = 0
            end
            castBar.spark:SetPoint("CENTER", castBar.bar, "LEFT", castBar.spark.position, 0)
            castBar.spark:Show()
        end
    elseif ( castBar.holdTime and GetTime() < castBar.holdTime ) then
        castBar.timeText:Hide()
        castBar.spark:Hide()
        return
    elseif castBar.fadeOut then
        local alpha = castBar:GetAlpha() - CASTING_BAR_ALPHA_STEP;
        if ( alpha > 0 ) then
            castBar:SetAlpha(alpha)
        else
            castBar.fadeOut = nil;
            castBar.timeText:Show()
            castBar.spark:Show()
            castBar:SetAlpha(0)
        end
    end
end

Castbar.CastEventsFunc = {}
Castbar.CastEventsFunc["UNIT_SPELLCAST_START"] = function(castBar, event, ...)
    local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(castBar.unit)
    if ( not name or (not castBar.showTradeSkills and isTradeSkill)) then
        castBar:SetAlpha(0)
        return
    end

    if ( castBar.spark ) then
        castBar.spark:Show()
    end
    castBar.value = (GetTime() - (startTime / 1000));
    castBar.maxValue = (endTime - startTime) / 1000;
    castBar.holdTime = 0
    castBar.casting = true
    castBar.castID = castID
    castBar.channeling = nil
    castBar.fadeOut = nil
    Castbar:CAST_START(castBar.unit, name, texture, castBar.value, castBar.maxValue)
end
Castbar.CastEventsFunc["UNIT_SPELLCAST_SUCCEEDED"] = function(castBar, event, ...)
    if (castBar.casting and event == "UNIT_SPELLCAST_SUCCEEDED" and select(2, ...) == castBar.castID) then
        if ( castBar.spark ) then
            castBar.spark:Hide()
        end
        castBar.casting = nil
        --castBar.spellText:SetText("Stopped")
        castBar.flash = true
        castBar.fadeOut = true
        castBar.holdTime = GetTime() + 0.25
        Castbar:CAST_STOP(castBar.unit, 0, 1, 0, 1)
    end
end
Castbar.CastEventsFunc["UNIT_SPELLCAST_STOP"] = function(castBar, event, ...)
    if ( not castBar:IsVisible() ) then
        castBar:SetAlpha(0)
    end
    if ( (castBar.casting and event == "UNIT_SPELLCAST_STOP" and select(2, ...) == castBar.castID) or
            (castBar.channeling and event == "UNIT_SPELLCAST_CHANNEL_STOP") ) then
        if ( castBar.spark ) then
            castBar.spark:Hide()
        end
        if ( event == "UNIT_SPELLCAST_STOP" ) then
            castBar.casting = nil
        else
            castBar.channeling = nil
        end
        castBar.spellText:SetText("Stopped")
        castBar.flash = true
        castBar.fadeOut = true
        castBar.holdTime = GetTime() + 0.25
        Castbar:CAST_STOP(castBar.unit, 1, 0, 0, 1)
    end
end
Castbar.CastEventsFunc["UNIT_SPELLCAST_CHANNEL_STOP"] = Castbar.CastEventsFunc["UNIT_SPELLCAST_STOP"]
Castbar.CastEventsFunc["UNIT_SPELLCAST_FAILED"] = function(castBar, event, ...)
    if ( castBar:IsShown() and
            (castBar.casting and select(2, ...) == castBar.castID) and not castBar.fadeOut ) then
        if ( castBar.spark ) then
            castBar.spark:Hide()
        end
        if ( castBar.spellText ) then
            if ( event == "UNIT_SPELLCAST_FAILED" ) then
                castBar.spellText:SetText("Failed")
            else
                castBar.spellText:SetText("Interrupted")
            end
        end
        castBar.bar:SetValue(castBar.maxValue)
        castBar.casting = nil
        castBar.channeling = nil
        castBar.fadeOut = true
        castBar.holdTime = GetTime() + 1
        Castbar:CAST_STOP(castBar.unit, 1, 0, 0, 1)
    end
end
Castbar.CastEventsFunc["UNIT_SPELLCAST_INTERRUPTED"] = Castbar.CastEventsFunc["UNIT_SPELLCAST_FAILED"]
Castbar.CastEventsFunc["UNIT_SPELLCAST_DELAYED"] = function(castBar, event, ...)
    if ( castBar:IsShown() ) then
        local name, text, texture, startTime, endTime, isTradeSkill, castID = UnitCastingInfo(castBar.unit)

        if ( not name or (not castBar.showTradeSkills and isTradeSkill)) then
            -- if there is no name, there is no bar
            castBar:SetAlpha(0)
            return
        end
        castBar.value = (GetTime() - (startTime / 1000))
        castBar.maxValue = (endTime - startTime) / 1000
        castBar.bar:SetMinMaxValues(0, castBar.maxValue)
        if ( not castBar.casting ) then
            castBar.casting = true
            castBar.channeling = nil
            castBar.flash = nil
            castBar.fadeOut = nil
        end
    end
end
Castbar.CastEventsFunc["UNIT_SPELLCAST_CHANNEL_START"] = function(castBar, event, ...)
    local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellId = UnitChannelInfo(castBar.unit)

    if ( not name or (not castBar.showTradeSkills and isTradeSkill)) then
        castBar:SetAlpha(0)
        return
    end
    if ( castBar.spark ) then
        castBar.spark:Show()
    end
    castBar.value = (endTime / 1000) - GetTime()
    castBar.maxValue = (endTime - startTime) / 1000
    castBar.holdTime = 0
    castBar.casting = nil
    castBar.channeling = true
    castBar.fadeOut = nil
    Castbar:CAST_START(castBar.unit, name, texture, castBar.value, castBar.maxValue)
end
Castbar.CastEventsFunc["UNIT_SPELLCAST_CHANNEL_UPDATE"] = function(castBar, event, ...)
    if ( castBar:IsShown() ) then
        local name, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(castBar.unit)
        if ( not name or (not castBar.showTradeSkills and isTradeSkill)) then
            castBar:SetAlpha(0)
            return
        end
        castBar.value = ((endTime / 1000) - GetTime())
        castBar.maxValue = (endTime - startTime) / 1000
        Castbar:CAST_START(castBar.unit, name, texture, castBar.value, castBar.maxValue)
    end
end

function Castbar.OnEvent(self, event, ...)
    local unit = ...
    if ( unit ~= self.unit ) then
        return
    end
    Castbar.CastEventsFunc[event](self, event, ...)
end

function Castbar:CAST_START(unit, spell, icon, value, maxValue, notInterruptible, test)
    local castBar = self.frames[unit]
    if (not castBar) then
        return
    end
    Gladdy:SendMessage("CAST_START", unit, spell)
    if test then
        castBar:SetScript("OnUpdate", Castbar.OnUpdate)
        castBar.casting = test == "cast"
        castBar.channeling = test == "channel"
    end

    if notInterruptible then
        castBar.bar:SetStatusBarColor(.8,.8,.8,1)
    else
        castBar.bar:SetStatusBarColor(Gladdy:SetColor(Gladdy.db.castBarColor))
    end

    castBar.value = value
    castBar.maxValue = maxValue
    castBar.bar:SetMinMaxValues(0, maxValue)
    castBar.bar:SetValue(value)
    castBar.icon:SetAlpha(1)
    castBar.icon.texture:SetTexture(icon)
    castBar.spellText:SetText(spell)
    castBar.timeText:SetText(maxValue)
    castBar.bg:Show()
    castBar.backdrop:Show()
    if Gladdy.db.castBarSparkEnabled then
        castBar.spark:Show()
    end
    if notInterruptible then
        castBar.shield:Show()
    else
        castBar.shield:Hide()
    end
    castBar:SetAlpha(1)
    if Gladdy.db.castBarIconEnabled then
        castBar.icon:Show()
    else
        castBar.icon:Hide()
    end
end

function Castbar:CAST_STOP(unit, ...)
    local castBar = self.frames[unit]
    if (not castBar) then
        return
    end
    if not castBar.fadeOut then
        castBar.casting = nil
        castBar.channeling = nil
        castBar.value = 0
        castBar.maxValue = 0
        castBar.icon:SetAlpha(0)
        castBar.icon.texture:SetTexture("")
        castBar.spellText:SetText("")
        castBar.timeText:SetText("")
        castBar.bar:SetValue(0)
        castBar.bg:Hide()
        castBar.backdrop:Hide()
        castBar.spark:Hide()
        castBar.icon:Hide()
        castBar.shield:Hide()
    else
        castBar.bar:SetStatusBarColor(...)
    end
end

---------------------------

-- Gladdy Messages JOINED_ARENA / ResetUnit

---------------------------

function Castbar:JOINED_ARENA()
    if Gladdy.db.castBarEnabled then
        for i=1, Gladdy.curBracket do
            local unit = "arena" .. i
            local castBar = self.frames[unit]
            castBar:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
            castBar:RegisterEvent("UNIT_SPELLCAST_DELAYED")
            castBar:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
            castBar:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
            castBar:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
            castBar:RegisterUnitEvent("UNIT_SPELLCAST_START", unit)
            castBar:RegisterUnitEvent("UNIT_SPELLCAST_STOP", unit)
            castBar:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", unit)
            castBar:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", unit)
            castBar:SetScript("OnEvent", Castbar.OnEvent)
            castBar:SetScript("OnUpdate", Castbar.OnUpdate)
            castBar.fadeOut = nil
            self:CAST_STOP(unit)
            --Castbar.OnEvent(castBar, "PLAYER_ENTERING_WORLD")
        end
    end
end

function Castbar:ResetUnit(unit)
    local castBar = self.frames[unit]
    castBar:UnregisterAllEvents()
    castBar:SetScript("OnEvent", nil)
    castBar:SetScript("OnUpdate", nil)
    castBar.fadeOut = nil
    self:CAST_STOP(unit)
end

function Castbar:Reset()
    self.test = nil
end

---------------------------

-- TEST

---------------------------

function Castbar:Test(unit)
    self.test = true
    if Gladdy.db.castBarEnabled then
        local spell, _, icon, value, maxValue, event, endTime, startTime

        if (unit == "arena2") then
            spell, _, icon = GetSpellInfo(27072)
            value, maxValue, event = 0, 40, "cast"
        elseif (unit == "arena1") then
            spell, _, icon = GetSpellInfo(27220)
            endTime = GetTime() * 1000 + 60*1000
            startTime = GetTime() * 1000
            value = (endTime / 1000) - GetTime()
            maxValue = (endTime - startTime) / 1000
            event = "channel"
        else
            spell, _, icon = GetSpellInfo(20770)
            value, maxValue, event = 0, 60, "cast"
        end

        if (spell) then
            local nonInterruptable = unit == "arena1" and Gladdy.expansion == "Wrath"
            self:CAST_START(unit, spell, icon, value, maxValue, nonInterruptable, event)
        end
    else
        self:CAST_STOP(unit)
    end
end

---------------------------

-- OPTIONS

---------------------------

local function option(params)
    local defaults = {
        get = function(info)
            local key = info.arg or info[#info]
            return Gladdy.dbi.profile[key]
        end,
        set = function(info, value)
            local key = info.arg or info[#info]
            Gladdy.dbi.profile[key] = value
            Gladdy.options.args["Cast Bar"].args.group.args.barFrame.args.castBarBorderSize.max = Gladdy.db.castBarHeight/2
            if Gladdy.db.castBarBorderSize > Gladdy.db.castBarHeight/2 then
                Gladdy.db.castBarBorderSize = Gladdy.db.castBarHeight/2
            end
            Gladdy:UpdateFrame()
        end,
    }

    for k, v in pairs(params) do
        defaults[k] = v
    end

    return defaults
end

function Castbar:GetOptions()
    return {
        header = {
            type = "header",
            name = L["Cast Bar"],
            order = 2,
        },
        castBarEnabled = option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["If test is running, type \"/gladdy test\" again"],
            order = 3,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 4,
            disabled = function() return not Gladdy.db.castBarEnabled end,
            args = {
                barFrame = {
                    type = "group",
                    name = L["Bar"],
                    order = 1,
                    args = {
                        headerSize = {
                            type = "header",
                            name = L["Bar Size"],
                            order = 1,
                        },
                        castBarHeight = option({
                            type = "range",
                            name = L["Bar height"],
                            desc = L["Height of the bar"],
                            order = 3,
                            min = 0,
                            max = 200,
                            step = 1,
                            width = "full",
                        }),
                        castBarWidth = option({
                            type = "range",
                            name = L["Bar width"],
                            desc = L["Width of the bars"],
                            order = 4,
                            min = 0,
                            max = 600,
                            step = 1,
                            width = "full",
                        }),
                        headerTexture = {
                            type = "header",
                            name = L["Texture"],
                            order = 5,
                        },
                        castBarTexture = option({
                            type = "select",
                            name = L["Bar texture"],
                            desc = L["Texture of the bar"],
                            order = 9,
                            dialogControl = "LSM30_Statusbar",
                            values = AceGUIWidgetLSMlists.statusbar,
                        }),
                        castBarColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Bar color"],
                            desc = L["Color of the cast bar"],
                            order = 10,
                            hasAlpha = true,
                        }),
                        castBarBgColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Background color"],
                            desc = L["Color of the cast bar background"],
                            order = 11,
                            hasAlpha = true,
                        }),
                        headerBorder = {
                            type = "header",
                            name = L["Border"],
                            order = 12,
                        },
                        castBarBorderSize = option({
                            type = "range",
                            name = L["Border size"],
                            order = 13,
                            min = 0.5,
                            max = Gladdy.db.castBarHeight/2,
                            step = 0.5,
                            width = "full",
                        }),
                        castBarBorderStyle = option({
                            type = "select",
                            name = L["Status Bar border"],
                            order = 51,
                            dialogControl = "LSM30_Border",
                            values = AceGUIWidgetLSMlists.border,
                        }),
                        castBarBorderColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Status Bar border color"],
                            order = 52,
                            hasAlpha = true,
                        }),
                    },
                },
                icon = {
                    type = "group",
                    name = L["Icon"],
                    order = 2,
                    args = {
                        headerSize = {
                            type = "header",
                            name = L["Icon"],
                            order = 1,
                        },
                        castBarIconEnabled = option({
                            type = "toggle",
                            name = L["Icon Enabled"],
                            order = 2,
                            width = "full",
                        }),
                        castBarIconZoomed = Gladdy:option({
                            type = "toggle",
                            name = L["Zoomed Icon"],
                            desc = L["Zoomes the icon to remove borders"],
                            order = 3,
                            width = "full",
                        }),
                        castBarIconSize = option({
                            type = "range",
                            name = L["Icon size"],
                            order = 21,
                            min = 0,
                            max = 100,
                            step = 1,
                            width = "full",
                        }),
                        headerBorder = {
                            type = "header",
                            name = L["Border"],
                            order = 30,
                        },
                        castBarIconStyle = option({
                            type = "select",
                            name = L["Icon border"],
                            order = 53,
                            values = Gladdy:GetIconStyles(),
                        }),
                        castBarIconColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Icon border color"],
                            order = 54,
                            hasAlpha = true,
                        }),
                    },
                },
                spark = {
                    type = "group",
                    name = L["Spark"],
                    order = 3,
                    args = {
                        header = {
                            type = "header",
                            name = L["Spark"],
                            order = 1,
                        },
                        castBarSparkEnabled = option({
                            type = "toggle",
                            name = L["Spark enabled"],
                            order = 26,
                        }),
                        castBarSparkColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Spark color"],
                            desc = L["Color of the cast bar spark"],
                            order = 27,
                            hasAlpha = true,
                        }),
                    },
                },
                font = {
                    type = "group",
                    name = L["Font"],
                    order = 4,
                    args = {
                        header = {
                            type = "header",
                            name = L["Font"],
                            order = 1,
                        },
                        castBarFont = option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the castbar"],
                            order = 2,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        castBarFontColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Font color"],
                            desc = L["Color of the text"],
                            order = 3,
                            hasAlpha = true,
                        }),
                        castBarFontSize = option({
                            type = "range",
                            name = L["Font size"],
                            desc = L["Size of the text"],
                            order = 4,
                            min = 1,
                            max = 20,
                            width = "full",
                        }),
                        castBarFontOutline = option({
                            type = "toggle",
                            name = L["Outline"],
                            order = 5,
                            width = "full",
                        }),
                        headerFormat = {
                            type = "header",
                            name = L["Format"],
                            order = 10,
                        },
                        castBarTimerFormat = option({
                            type = "select",
                            name = L["Timer Format"],
                            order = 11,
                            values = {
                                ["LEFT"] = L["Remaining"],
                                ["TOTAL"] = L["Total"],
                                ["BOTH"] = L["Both"],
                            },
                        }),
                    }
                },
                position = {
                    type = "group",
                    name = L["Position"],
                    order = 5,
                    args = {
                        header = {
                            type = "header",
                            name = L["Position"],
                            order = 1,
                        },
                        castBarIconPos = option( {
                            type = "select",
                            name = L["Icon position"],
                            order = 3,
                            values = {
                                ["LEFT"] = L["Left"],
                                ["RIGHT"] = L["Right"],
                            },
                        }),
                        headerOffset = {
                            type = "header",
                            name = L["Offsets"],
                            order = 10,
                        },
                        castBarXOffset = option({
                            type = "range",
                            name = L["Horizontal offset"],
                            order = 11,
                            min = -400,
                            max = 400,
                            step = 0.1,
                            width = "full",
                        }),
                        castBarYOffset = option({
                            type = "range",
                            name = L["Vertical offset"],
                            order = 12,
                            min = -400,
                            max = 400,
                            step = 0.1,
                            width = "full",
                        }),
                    }
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
                        castBarFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        castBarFrameLevel = Gladdy:option({
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

---------------------------

-- LAGACY HANDLER

---------------------------

function Castbar:LegacySetPosition(castBar, unit, leftMargin, rightMargin)
    if Gladdy.db.newLayout then
        return Gladdy.db.newLayout
    end
    castBar:ClearAllPoints()
    if Gladdy.db.castBarWidth <= 0 then
        castBar:SetWidth(0.1)
    end
    if Gladdy.db.castBarHeight <= 0 then
        castBar:SetHeight(0.1)
    end
    local horizontalMargin = (Gladdy.db.highlightInset and 0 or Gladdy.db.highlightBorderSize) + Gladdy.db.padding
    if (Gladdy.db.castBarPos == "LEFT") then
        local anchor = Gladdy:GetAnchor(unit, "LEFT")
        if anchor == Gladdy.buttons[unit].healthBar then
            castBar:SetPoint("RIGHT", anchor, "LEFT", -horizontalMargin - leftMargin + Gladdy.db.castBarXOffset, Gladdy.db.castBarYOffset)
        else
            castBar:SetPoint("RIGHT", anchor, "LEFT", -Gladdy.db.padding - leftMargin + Gladdy.db.castBarXOffset, Gladdy.db.castBarYOffset)
        end
    end
    if (Gladdy.db.castBarPos == "RIGHT") then
        local anchor = Gladdy:GetAnchor(unit, "RIGHT")
        if anchor == Gladdy.buttons[unit].healthBar then
            castBar:SetPoint("LEFT", anchor, "RIGHT", horizontalMargin + rightMargin + Gladdy.db.castBarXOffset, Gladdy.db.castBarYOffset)
        else
            castBar:SetPoint("LEFT", anchor, "RIGHT", Gladdy.db.padding + rightMargin + Gladdy.db.castBarXOffset, Gladdy.db.castBarYOffset)
        end
    end
    return Gladdy.db.newLayout
end