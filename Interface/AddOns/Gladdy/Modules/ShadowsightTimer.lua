local floor, str_find, pairs = math.floor, string.find, pairs
local CreateFrame = CreateFrame

---------------------------

-- CORE

---------------------------

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local ShadowsightTimer = Gladdy:NewModule("Shadowsight Timer", nil, {
    shadowsightTimerEnabled = true,
    shadowsightTimerLocked = false,
    shadowsightTimerScale = 1,
    shadowsightTimerRelPoint1 = "CENTER",
    shadowsightTimerRelPoint2 = "CENTER",
    shadowsightTimerX = 0,
    shadowsightTimerY = 0,
    shadowsightAnnounce = true,
    shadowsightTimerStartTime = 91,
    shadowsightTimerResetTime = 120,
    shadowsightTimerShowTwoTimer = false,
    shadowsightTimerFrameStrata = "HIGH",
    shadowsightTimerFrameLevel = 20,
})

function ShadowsightTimer:OnEvent(event, ...)
    self[event](self, ...)
end

function ShadowsightTimer:Initialize()
    self.locale = Gladdy:GetArenaTimer()
    self:CreateAnchor()
    if Gladdy.db.shadowsightTimerEnabled then
        self:RegisterMessage("JOINED_ARENA")
    end
end

function ShadowsightTimer:Reset()
    self.anchor:Hide()
    for i=1,2 do
        self["timerFrame" .. i].active = false
        self["timerFrame" .. i]:SetScript("OnUpdate", nil)
        self["timerFrame" .. i].font:SetTextColor(1, 0.8, 0)
    end
    self:UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
    self:SetScript("OnEvent", nil)
end

---------------------------

-- FRAME SETUP

---------------------------

function ShadowsightTimer:CreateTimerFrame(anchor, name, points)
    local backdrop = {
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "",
        tile = true, tileSize = 16, edgeSize = 10,
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
    self[name] = CreateFrame("Frame", nil, anchor, BackdropTemplateMixin and "BackdropTemplate")
    self[name]:SetPoint(points[1], anchor, points[2])
    self[name]:SetBackdrop(backdrop)
    self[name]:SetBackdropColor(0,0,0,0.8)
    self[name]:SetHeight(17)
    self[name]:SetWidth(35)

    self[name].texture = self[name]:CreateTexture(nil,"OVERLAY")
    self[name].texture:SetWidth(16)
    self[name].texture:SetHeight(16)
    self[name].texture:SetTexture("Interface\\Icons\\Spell_Shadow_EvilEye")
    self[name].texture:SetTexCoord(0.125,0.875,0.125,0.875)
    self[name].texture:SetPoint("RIGHT", self[name], "LEFT")

    self[name].font = self[name]:CreateFontString(nil,"OVERLAY","GameFontNormal")
    self[name].font:SetPoint("LEFT", 5, 0)
    self[name].font:SetJustifyH("LEFT")
    self[name].font:SetTextColor(1, 0.8, 0)

    self[name]:SetFrameStrata(Gladdy.db.shadowsightTimerFrameStrata)
    self[name]:SetFrameLevel(Gladdy.db.shadowsightTimerFrameLevel)
end

function ShadowsightTimer:CreateAnchor()
    self.anchor = CreateFrame("Frame")
    self.anchor:SetMovable(true)
    self.anchor:EnableMouse(true)
    self.anchor:SetWidth(35)
    self.anchor:SetHeight(17)
    self.anchor:SetPoint(Gladdy.db.shadowsightTimerRelPoint1, nil, Gladdy.db.shadowsightTimerRelPoint, Gladdy.db.shadowsightTimerX, Gladdy.db.shadowsightTimerY)
    self.anchor:SetScript("OnMouseDown",function(self) self:StartMoving() end)
    self.anchor:SetScript("OnMouseUp",function(self)
        self:StopMovingOrSizing()
        Gladdy.db.shadowsightTimerRelPoint1,_,Gladdy.db.shadowsightTimerRelPoint2,Gladdy.db.shadowsightTimerX,Gladdy.db.shadowsightTimerY = self:GetPoint()
    end)
    self.anchor:SetScale(Gladdy.db.shadowsightTimerScale)
    self.anchor:Hide()

    self:CreateTimerFrame(self.anchor, "timerFrame1", {"TOP", "TOP"})
    local show = Gladdy.db.shadowsightTimerShowTwoTimer
    self:CreateTimerFrame(show and self.timerFrame1 or self.anchor, "timerFrame2", show and {"TOP", "BOTTOM"} or {"TOP", "TOP"})
end

function ShadowsightTimer:UpdateFrameOnce()
    if Gladdy.db.shadowsightTimerEnabled then
        self:RegisterMessage("JOINED_ARENA")
    else
        self:UnregisterAllMessages()
    end

    self.anchor:EnableMouse(not Gladdy.db.shadowsightTimerLocked)

    self.anchor:SetFrameStrata(Gladdy.db.shadowsightTimerFrameStrata)
    self.anchor:SetFrameLevel(Gladdy.db.shadowsightTimerFrameLevel)
    self.timerFrame1:SetFrameStrata(Gladdy.db.shadowsightTimerFrameStrata)
    self.timerFrame1:SetFrameLevel(Gladdy.db.shadowsightTimerFrameLevel)
    self.timerFrame2:SetFrameStrata(Gladdy.db.shadowsightTimerFrameStrata)
    self.timerFrame2:SetFrameLevel(Gladdy.db.shadowsightTimerFrameLevel)

    if Gladdy.db.shadowsightTimerEnabled then
        self.anchor:SetScale(Gladdy.db.shadowsightTimerScale)
        self.anchor:ClearAllPoints()
        self.anchor:SetPoint(Gladdy.db.shadowsightTimerRelPoint1, nil, Gladdy.db.shadowsightTimerRelPoint2, Gladdy.db.shadowsightTimerX, Gladdy.db.shadowsightTimerY)
        if Gladdy.frame.testing or Gladdy.curBracket then
            self.anchor:Show()
        end
        if Gladdy.db.shadowsightTimerShowTwoTimer then
            self.anchor:SetHeight(34)
            self.timerFrame2:ClearAllPoints()
            self.timerFrame2:SetPoint("TOP", self.timerFrame1, "BOTTOM")
            ShadowsightTimer:NotifyStart()
        else
            self.anchor:SetHeight(17)
            self.timerFrame2:ClearAllPoints()
            self.timerFrame2:SetPoint("TOP", self.anchor, "TOP")
            ShadowsightTimer:NotifyStart()
        end
    else
        self.anchor:SetScale(Gladdy.db.shadowsightTimerScale)
        self.anchor:ClearAllPoints()
        self.anchor:SetPoint(Gladdy.db.shadowsightTimerRelPoint1, nil, Gladdy.db.shadowsightTimerRelPoint2, Gladdy.db.shadowsightTimerX, Gladdy.db.shadowsightTimerY)
        self.anchor:Hide()
    end
end

---------------------------

-- EVENT HANDLING

---------------------------

function ShadowsightTimer:JOINED_ARENA()
    if Gladdy.db.shadowsightTimerEnabled then
        self:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
        self:SetScript("OnEvent", ShadowsightTimer.OnEvent)
        for i=1,2 do
            self["timerFrame" .. i].font:SetText("1:30")
            self["timerFrame" .. i].font:SetTextColor(1, 0.8, 0)
        end
        self.anchor:Show()
    end
end

function ShadowsightTimer:AURA_GAIN(unit, auraType, spellID)
    if (spellID == 34709 and Gladdy.db.shadowsightTimerEnabled) then
        self:Start(Gladdy.db.shadowsightTimerResetTime, self:GetHiddenTimer())
    end
end

function ShadowsightTimer:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
    for k,v in pairs(self.locale) do
        if str_find(msg, v) then
            if k == 0 then
                self:Start(nil, self.timerFrame1)
                self:Start(nil, self.timerFrame2)
            end
        end
    end
end

---------------------------

-- TEST

---------------------------

function ShadowsightTimer:Test()
    if Gladdy.db.shadowsightTimerEnabled then
        self.anchor:Show()
        ShadowsightTimer:JOINED_ARENA()
        self:Start(20, self.timerFrame1)
        self:Start(25, self.timerFrame2)
    end
end

---------------------------

-- TIMER

---------------------------

function ShadowsightTimer:Start(time, frame)
    frame.endTime = time or Gladdy.db.shadowsightTimerStartTime
    frame.active = true
    ShadowsightTimer:NotifyStart()
    frame.announced = nil
    frame.timeSinceLastUpdate = 0
    frame.font:SetTextColor(1, 0.8, 0)
    frame:SetScript("OnUpdate", ShadowsightTimer.OnUpdate)
end

function ShadowsightTimer.OnUpdate(self, elapsed)
    self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed;
    self.endTime = self.endTime - elapsed

    if (self.timeSinceLastUpdate > 0.01) then
        self.font:SetFormattedText(floor(self.endTime / 60) .. ":" ..  "%02d", self.endTime - floor(self.endTime / 60) * 60)
        self.timeSinceLastUpdate = 0;
        if floor(self.endTime) == 15 and Gladdy.db.shadowsightAnnounce and not self.announced then
            self.announced = true
            Gladdy:SendMessage("SHADOWSIGHT", L["Shadowsight up in %ds"]:format(15))
        end
    end
    if self.endTime <= 0 then
        if Gladdy.db.shadowsightAnnounce then
            Gladdy:SendMessage("SHADOWSIGHT", L["Shadowsight up!"])
        end
        self:SetScript("OnUpdate", nil)
        self.font:SetText("0:00")
        self.font:SetTextColor(0, 1, 0)
        self.active = false
        ShadowsightTimer:NotifyEnd()
    end
end

function ShadowsightTimer:NotifyStart()
    local show = Gladdy.db.shadowsightTimerShowTwoTimer
    if self.timerFrame1.active and self.timerFrame2.active then
        if self.timerFrame1.endTime < self.timerFrame2.endTime then
            self.timerFrame1:SetAlpha(1)
            self.timerFrame2:SetAlpha(show and 1 or 0)
        else
            self.timerFrame1:SetAlpha(show and 1 or 0)
            self.timerFrame2:SetAlpha(1)
        end
    else
        if self.timerFrame1.active then
            self.timerFrame1:SetAlpha(1)
            self.timerFrame2:SetAlpha(show and 1 or 0)
        elseif self.timerFrame2.active then
            self.timerFrame1:SetAlpha(show and 1 or 0)
            self.timerFrame2:SetAlpha(1)
        else
            self.timerFrame1:SetAlpha(1)
            self.timerFrame2:SetAlpha(show and 1 or 0)
        end
    end
end
function ShadowsightTimer:NotifyEnd()
    local show = Gladdy.db.shadowsightTimerShowTwoTimer
    if self.timerFrame1.active then
        self.timerFrame1:SetAlpha(1)
        self.timerFrame2:SetAlpha(show and 1 or 0)
    elseif self.timerFrame2.active then
        self.timerFrame1:SetAlpha(show and 1 or 0)
        self.timerFrame2:SetAlpha(1)
    else
        self.timerFrame1:SetAlpha(1)
        self.timerFrame2:SetAlpha(show and 1 or 0)
    end
end
function ShadowsightTimer:GetHiddenTimer()
    if self.timerFrame1.active and self.timerFrame2.active then
        return self.timerFrame1.endTime < self.timerFrame2.endTime and self.timerFrame1 or self.timerFrame2
    else
        return self.timerFrame1.active and self.timerFrame2 or self.timerFrame1
    end
end

---------------------------

-- OPTIONS

---------------------------

function ShadowsightTimer:GetOptions()
    return {
        headerShadowsight = {
            type = "header",
            name = L["Shadowsight Timer"],
            order = 2,
        },
        shadowsightTimerEnabled = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            --desc = L["Turns countdown before the start of an arena match on/off."],
            order = 3,
        }),
        shadowsightTimerLocked = Gladdy:option({
            type = "toggle",
            name = L["Locked"],
            --desc = L["Turns countdown before the start of an arena match on/off."],
            order = 4,
            disabled = function() return not Gladdy.db.shadowsightTimerEnabled end,
        }),
        shadowsightTimerShowTwoTimer = Gladdy:option({
            type = "toggle",
            name = L["Show two timers"],
            order = 5,
            disabled = function() return not Gladdy.db.shadowsightTimerEnabled end,
        }),
        shadowsightAnnounce = Gladdy:option({
            type = "toggle",
            name = L["Announce"],
            --desc = L["Turns countdown before the start of an arena match on/off."],
            order = 6,
            disabled = function() return not Gladdy.db.shadowsightTimerEnabled end,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 7,
            disabled = function() return not Gladdy.db.shadowsightTimerEnabled end,
            args = {
                general = {
                    type = "group",
                    name = L["Scale"],
                    order = 1,
                    args = {
                        header = {
                            type = "header",
                            name = L["Scale"],
                            order = 1,
                        },
                        shadowsightTimerScale = Gladdy:option({
                            type = "range",
                            name = L["Scale"],
                            order = 2,
                            min = 0.1,
                            max = 5,
                            step = 0.1,
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
                            name = L["Shadowsight CDs"],
                            order = 1,
                        },
                        shadowsightTimerStartTime = Gladdy:option({
                            type = "range",
                            name = L["Start Time"],
                            desc = L["Start time in seconds"],
                            min = 80,
                            max = 100,
                            order = 2,
                            step = 0.1,
                            width = "full",
                        }),
                        shadowsightTimerResetTime = Gladdy:option({
                            type = "range",
                            name = L["Reset Time"],
                            desc = L["Reset time in seconds"],
                            min = 110,
                            max = 130,
                            order = 3,
                            step = 0.1,
                            width = "full",
                        }),
                    },
                },
                --[[font = {
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
                },--]]
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
                        shadowsightTimerFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        shadowsightTimerFrameLevel = Gladdy:option({
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