local CreateFrame = CreateFrame
local UIParent = UIParent
local InCombatLockdown = InCombatLockdown
local math_abs = math.abs
local pairs = pairs
local LibStub = LibStub

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L

Gladdy.BUTTON_DEFAULTS = {
    name = "",
    guid = "",
    raceLoc = "",
    classLoc = "",
    class = "",
    health = "",
    healthMax = 0,
    power = 0,
    powerMax = 0,
    powerType = 0,
    spec = "",
    testSpec = "",
    spells = {},
    ns = false,
    nf = false,
    pom = false,
    fd = false,
    damaged = 0,
    click = false,
    stealthed = false,
    classColors = {},
    lastState = 0,
    auras = {},
    lastAuras = {}
}

function Gladdy:CreateFrame()
    self.frame = CreateFrame("Frame", "GladdyFrame", UIParent)

    self.frame.background = CreateFrame("Frame", nil, self.frame, BackdropTemplateMixin and "BackdropTemplate")
    self.frame.background:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = false, tileSize = 16})
    self.frame.background:SetFrameStrata("BACKGROUND")
    self.frame.background:SetBackdropColor(Gladdy:SetColor(self.db.backgroundColor))
    self.frame.background:SetAllPoints(self.frame)
    --self.frame.texture = self.frame:CreateTexture(nil, "OVERLAY")
    --self.frame.texture:SetAllPoints(self.frame)
    --self.frame.texture:SetTexture("Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp")

    self.frame:SetClampedToScreen(true)
    self.frame:EnableMouse(false)
    self.frame:SetMovable(true)
    --self.frame:RegisterForDrag("LeftButton")

    self.frame:SetScript("OnDragStart", function(f)
        if (not InCombatLockdown() and not self.db.locked) then
            f:StartMoving()
        end
    end)
    self.frame:SetScript("OnDragStop", function(f)
        if (not InCombatLockdown()) then
            f:StopMovingOrSizing()

            local scale = f:GetEffectiveScale()
            self.db.x = f:GetLeft() * scale
            self.db.y = (self.db.growDirection == "TOP" and f:GetBottom() or f:GetTop()) * scale
        end
    end)

    self.anchor = CreateFrame("Button", "GladdyAnchor", self.frame, BackdropTemplateMixin and "BackdropTemplate")
    self.anchor:SetHeight(20)
    self.anchor:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16 })
    self.anchor:SetBackdropColor(0, 0, 0, 1)
    self.anchor:SetClampedToScreen(true)
    self.anchor:EnableMouse(true)
    self.anchor:SetMovable(true)
    self.anchor:RegisterForDrag("LeftButton")
    self.anchor:RegisterForClicks("RightButtonUp")
    self.anchor:SetScript("OnDragStart", function()
        if (not InCombatLockdown() and not self.db.locked) then
            self.frame:StartMoving()
        end
    end)
    self.anchor:SetScript("OnDragStop", function()
        if (not InCombatLockdown()) then
            self.frame:StopMovingOrSizing()

            local scale = self.frame:GetEffectiveScale()
            self.db.x = self.frame:GetLeft() * scale
            self.db.y = (self.db.growDirection == "TOP" and self.frame:GetBottom() or self.frame:GetTop()) * scale
        end
    end)
    self.anchor:SetScript("OnClick", function()
        if (not InCombatLockdown()) then
            self:ShowOptions()
        end
    end)

    self.anchor.text = self.anchor:CreateFontString("GladdyAnchorText", "ARTWORK", "GameFontHighlightSmall")
    self.anchor.text:SetText(L["Gladdy - drag to move"])
    self.anchor.text:SetPoint("CENTER")

    self.anchor.button = CreateFrame("Button", "GladdyAnchorButton", self.anchor, "UIPanelCloseButton")
    self.anchor.button:SetWidth(20)
    self.anchor.button:SetHeight(20)
    self.anchor.button:SetPoint("RIGHT", self.anchor, "RIGHT", 2, 0)
    self.anchor.button:SetScript("OnClick", function(_, _, down)
        if (not down) then
            self.db.locked = true
            self:UpdateFrame()
        end
    end)

    if (self.db.locked) then
        self.anchor:Hide()
    end

    self.frame:Hide()
end

function Gladdy:UpdateFrame()

    if (InCombatLockdown()) then
        return
    end

    if (not self.frame) then
        self:CreateFrame()
    end
    local teamSize = self.curBracket or 0

    local highlightBorderSize = (self.db.highlightInset and 0 or self.db.highlightBorderSize * 2)
    local powerBarHeight = self.db.powerBarEnabled and (self.db.powerBarHeight + 1) or 0

    local margin = powerBarHeight
    local height = (self.db.healthBarHeight + powerBarHeight) * teamSize
            + (self.db.highlightInset and 0 or self.db.highlightBorderSize * 2 * teamSize)
            + self.db.bottomMargin * (teamSize - 1)
    local singleFrameHeight = self.db.healthBarHeight + powerBarHeight +
            (self.db.highlightInset and 0 or self.db.highlightBorderSize * 2) + self.db.bottomMargin

    -- Highlight
    margin = margin + highlightBorderSize
    margin, height = Gladdy:LegacyPositioning(margin, height, teamSize)

    -- GrowDirection
    if (self.db.growDirection == "LEFT" or self.db.growDirection == "RIGHT") then
        height = self.db.healthBarHeight + powerBarHeight
    end

    self.frame:SetScale(self.db.frameScale)
    self:PixelPerfectScale(false)
    self.frame:SetWidth(self.db.barWidth + highlightBorderSize)
    self.frame:SetHeight(height)
    self.frame:ClearAllPoints()
    self.frame.background:SetBackdropColor(Gladdy:SetColor(self.db.backgroundColor))
    self.frame:ClearAllPoints()
    if (self.db.x == 0 and self.db.y == 0) then
        self.frame:SetPoint("CENTER")
    else
        local scale = self.frame:GetEffectiveScale()
        local growMiddle = self.db.growMiddle and teamSize > 0 and teamSize / 2 >= 1 and (teamSize - 1) * (singleFrameHeight / 2) or 0
        if (self.db.growDirection == "TOP") then
            self.frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self.db.x / scale, (self.db.y / scale) - growMiddle)
        elseif self.db.growDirection == "BOTTOM" then
            self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.x / scale, (self.db.y / scale) + growMiddle)
        else
            self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.x / scale, (self.db.y / scale))
        end
    end

    --Anchor
    self.anchor:SetWidth(self.db.barWidth * 2 + highlightBorderSize)
    self.anchor:ClearAllPoints()
    if (self.db.growDirection == "TOP") then
        self.anchor:SetPoint("TOP", self.frame, "BOTTOM")
    elseif self.growDirection == "BOTTOM" or self.growDirection == "RIGHT" then
        self.anchor:SetPoint("BOTTOM", self.frame, "TOP")
    else
        self.anchor:SetPoint("BOTTOM", self.frame, "TOP")
    end

    if (self.db.locked) then
        self.anchor:Hide()
    else
        self.anchor:Show()
    end

    for i = 1, teamSize do
        local button = self.buttons["arena" .. i]
        button:SetWidth(self.db.barWidth)
        button:SetHeight(self.db.healthBarHeight)
        button.secure:SetWidth(self.db.barWidth)
        button.secure:SetHeight(self.db.healthBarHeight + powerBarHeight)

        button:ClearAllPoints()
        button.secure:ClearAllPoints()
        if (self.db.growDirection == "TOP") then
            if (i == 1) then
                button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 0, powerBarHeight)
                button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
            else
                button:SetPoint("BOTTOMLEFT", self.buttons["arena" .. (i - 1)], "TOPLEFT", 0, margin + self.db.bottomMargin)
                button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
            end
        elseif (self.db.growDirection == "BOTTOM") then
            if (i == 1) then
                button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
                button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
            else
                button:SetPoint("TOPLEFT", self.buttons["arena" .. (i - 1)], "BOTTOMLEFT", 0, -margin - self.db.bottomMargin)
                button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
            end
        elseif (self.db.growDirection == "LEFT") then
            if (i == 1) then
                button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -0, 0)
                button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
            else
                button:SetPoint("TOPRIGHT", self.buttons["arena" .. (i - 1)], "TOPLEFT", - self.db.bottomMargin, 0)
                button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
            end
        elseif (self.db.growDirection == "RIGHT") then
            if (i == 1) then
                button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
                button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
            else
                button:SetPoint("TOPLEFT", self.buttons["arena" .. (i - 1)], "TOPRIGHT", self.db.bottomMargin, 0)
                button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
            end
        end


        for _, v in self:IterModules() do
            self:Call(v, "UpdateFrame", "arena" .. i)
        end
    end
    for _, v in self:IterModules() do
        self:Call(v, "UpdateFrameOnce")
    end
    if Gladdy.db.hideBlizzard == "always" then
        Gladdy:BlizzArenaSetAlpha(0)
    elseif Gladdy.db.hideBlizzard == "arena" then
        if Gladdy.curBracket then
            Gladdy:BlizzArenaSetAlpha(0)
        else
            Gladdy:BlizzArenaSetAlpha(1)
        end
    elseif Gladdy.db.hideBlizzard == "never" then
        Gladdy:BlizzArenaSetAlpha(1)
    end
    if (not Gladdy.db.newLayout) then
        Gladdy.db.newLayout = true
        --get margin
        local arena1Bottom
        local arena2Top
        if (self.db.growDirection == "BOTTOM") then
            arena1Bottom = self.buttons["arena1"].secure:GetBottom()
            arena2Top = self.buttons["arena2"].secure:GetTop()
        elseif (self.db.growDirection == "TOP") then
            arena1Bottom = self.buttons["arena1"].secure:GetTop()
            arena2Top = self.buttons["arena2"].secure:GetBottom()
        elseif (self.db.growDirection == "LEFT") then
            arena1Bottom = self.buttons["arena1"].secure:GetLeft()
            arena2Top = self.buttons["arena2"].secure:GetRight()
        elseif (self.db.growDirection == "RIGHT") then
            arena1Bottom = self.buttons["arena1"].secure:GetRight()
            arena2Top = self.buttons["arena2"].secure:GetLeft()
        end
        Gladdy.db.bottomMargin = math_abs(arena1Bottom - arena2Top)
        Gladdy:UpdateFrame()
    end
end

function Gladdy:HideFrame()
    if (self.frame) then
        if InCombatLockdown() then
            self.startTest = nil
            self.hideFrame = true
        else
            self:Reset()
            self.frame:Hide()
        end

        self.frame.testing = nil
    end
end

function Gladdy:ToggleFrame(i)
    self:Reset()
    if (self.frame and self.frame:IsShown() and i == self.curBracket) then
        self.frame.testing = nil
        self:HideFrame()
    else
        self.curBracket = i

        if (not self.frame) then
            self:CreateFrame()
        end
        self.frame.testing = true

        for o = 1, self.curBracket do
            local unit = "arena" .. o
            if (not self.buttons[unit]) then
                self:CreateButton(o)
            end
        end
        self:Reset()
        self.curBracket = i
        self:UpdateFrame()
        if InCombatLockdown() then
            Gladdy:Print("Gladdy frames show as soon as you leave combat")
            self.showFrame = true
            self.startTest = true
        else
            self:Test()
            self.frame:Show()
        end
    end
end

function Gladdy:CreateButton(i)
    if (not self.frame) then
        self:CreateFrame()
    end

    local button = CreateFrame("Frame", "GladdyButtonFrame" .. i, self.frame)
    button:EnableMouse(false)
    --button:SetAlpha(0)
    --button.texture = button:CreateTexture(nil, "OVERLAY")
    --button.texture:SetAllPoints(button)
    --button.texture:SetTexture("Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp")

    local secure = CreateFrame("Button", "GladdyButton" .. i, button, "SecureActionButtonTemplate, SecureHandlerEnterLeaveTemplate")
    secure:RegisterForClicks("AnyUp")
    secure:RegisterForClicks("AnyDown")

    secure:SetAttribute("target", "arena" .. i)
    secure:SetAttribute("focus", "arena" .. i)
    secure:SetAttribute("unit", "arena" .. i)

    --[[
    secure:SetAttribute("target", i == 1 and "player" or "focus")
    secure:SetAttribute("focus", i == 1 and "player" or "focus")
    secure:SetAttribute("unit", i == 1 and "player" or "focus")
    --]]

    --secure.texture = secure:CreateTexture(nil, "OVERLAY")
    --secure.texture:SetAllPoints(secure)
    --secure.texture:SetTexture("Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp")

    button.id = i
    --button.unit = i == 1 and "player" or "focus"
    button.unit = "arena" .. i
    button.secure = secure


    self:ResetButton("arena" .. i)

    self.buttons["arena" .. i] = button

    for _, v in self:IterModules() do
        self:Call(v, "CreateFrame", "arena" .. i)
    end
    self:ResetButton("arena" .. i)
end



function Gladdy:SetPosition(frame, unit, xOffsetDB, yOffsetDB, newLayout, module)
    local button = self.buttons[unit]
    if not button or not frame or not xOffsetDB or not yOffsetDB then
        return
    end

    if (not newLayout) then
        --Gladdy:Debug("INFO", name, "old X/Y:", frame:GetCenter())
        local xOffset, yOffset = frame:GetLeft(), frame:GetTop()
        if not xOffset or not yOffset then
            xOffset = frame:GetCenter()-- - frame:GetWidth()/2
            yOffset = select(2, frame:GetCenter())-- + frame:GetHeight()/2
        end
        local x,y = button.healthBar:GetLeft(), button.healthBar:GetTop()
        local newXOffset = math_abs(x - xOffset) * (x > xOffset and -1 or 1)
        local newYOffset = math_abs(y - yOffset) * (y > yOffset and -1 or 1)
        frame:ClearAllPoints()
        frame:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT", newXOffset, newYOffset)
        --Gladdy:Debug("INFO", name, "new X/Y:", frame:GetCenter())
        if unit == "arena1" then
            Gladdy.db[xOffsetDB] = newXOffset
            Gladdy.db[yOffsetDB] = newYOffset
            LibStub("AceConfigRegistry-3.0"):NotifyChange("Gladdy")
        end
    else
        frame:ClearAllPoints()
        frame:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT", Gladdy.db[xOffsetDB], Gladdy.db[yOffsetDB])
    end
    if (self.newDefaults[module.name]) then
        for k,v in pairs(self.newDefaults[module.name]) do
            module.defaults[k] = v
        end
    end
end

function Gladdy:CreateMover(frame, xConfig, yConfig, name, points, width, height, xOffset, yOffset, activated)
    if not frame.mover then
        frame:EnableMouse(false)
        frame:SetMovable(true)
        frame.mover = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
        frame.mover:SetFrameStrata("TOOLTIP")
        frame.mover:SetPoint(points[1], frame, points[2], xOffset or 0, yOffset or 0)
        frame.mover:SetHeight(height or frame:GetHeight())
        frame.mover:SetWidth(width or frame:GetWidth())

        local backdrop = {
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "",
            tile = true, tileSize = 16, edgeSize = 10,
            insets = {left = 0, right = 0, top = 0, bottom = 0}
        }
        frame.mover:SetBackdrop(backdrop)
        frame.mover:SetBackdropColor(0,1,0,0.5)
        frame.mover.border = CreateFrame("Frame", nil, frame.mover, BackdropTemplateMixin and "BackdropTemplate")
        frame.mover.border:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "highlightBorderStyle"), edgeSize = 2 })
        frame.mover.border:SetAllPoints(frame.mover)
        frame.mover.border:SetBackdropBorderColor(0,1,0,1)
        frame.mover.border:SetFrameStrata("TOOLTIP")

        frame.mover.text = frame.mover.border:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        frame.mover.text:SetText(name)
        frame.mover.text:SetPoint("CENTER")

        frame.mover:SetMovable(true)
        frame.mover:EnableMouse(true)

        frame.mover:SetScript("OnMouseDown", function(self)
            self.point = { frame:GetPoint() }
            self.start = { frame:GetCenter() }
            frame:StartMoving()
            self:StartMoving()
        end)
        frame.mover:SetScript("OnMouseUp", function(self)
            frame:StopMovingOrSizing()
            self:StopMovingOrSizing()
            self.stop = { frame:GetCenter() }
            local diffX = math_abs(self.start[1] - self.stop[1])
            diffX = self.start[1] > self.stop[1] and -diffX or diffX
            local diffY = math_abs(self.start[2] - self.stop[2])
            diffY = self.start[2] > self.stop[2] and -diffY or diffY
            frame:ClearAllPoints()
            frame:SetPoint(self.point[1], self.point[2], self.point[3], self.point[4] + diffX, self.point[5] + diffY)
            Gladdy.db[xConfig] = self.point[4] + diffX
            Gladdy.db[yConfig] = self.point[5] + diffY
            LibStub("AceConfigRegistry-3.0"):NotifyChange("Gladdy")
            Gladdy:UpdateFrame()
        end)
    else
        frame.mover:ClearAllPoints()
        frame.mover:SetPoint(points[1], frame, points[2], xOffset or 0, yOffset or 0)
        frame.mover:SetHeight(height or frame:GetHeight())
        frame.mover:SetWidth(width or frame:GetWidth())
    end
    if self.frame and self.frame.testing and self.db.showMover then
        if (activated ~= nil and not Gladdy.db[activated]) then
            frame.mover:Hide()
        else
            frame.mover:Show()
        end
    else
        frame.mover:Hide()
    end
end

---------------------------

-- LAGACY SUPPORT

---------------------------

function Gladdy:LegacyPositioning(margin, height, teamSize)
    if not Gladdy.db.newLayout then
        for k,v in pairs(Gladdy.legacy) do
            if Gladdy.db[k] == nil then
                Gladdy:Debug("INFO", "Gladdy:LegacyPositioning write", k,v)
                Gladdy.db[k] = v
            else
                Gladdy:Debug("INFO", "Gladdy:LegacyPositioning found", k,v)
            end
        end
        if (self.db.cooldownYPos == "TOP" or self.db.cooldownYPos == "BOTTOM") and self.db.cooldown then
            margin = margin + self.db.cooldownSize
            height = height + self.db.cooldownSize * (teamSize - 1)
        end
        if (self.db.buffsCooldownPos == "TOP" or self.db.buffsCooldownPos == "BOTTOM") and self.db.buffsEnabled then
            margin = margin + self.db.buffsIconSize
            height = height + self.db.buffsIconSize * (teamSize - 1)
        end
        if (self.db.buffsBuffsCooldownPos == "TOP" or self.db.buffsBuffsCooldownPos == "BOTTOM") and self.db.buffsEnabled then
            margin = margin + self.db.buffsBuffsIconSize
            height = height + self.db.buffsBuffsIconSize * (teamSize - 1)
        end
        if self.db.buffsCooldownPos == "TOP" and self.db.cooldownYPos == "TOP" and self.db.cooldown and self.db.buffsEnabled then
            margin = margin + 1
            height = height + (teamSize - 1)
        end
        if self.db.buffsCooldownPos == "BOTTOM" and self.db.cooldownYPos == "BOTTOM" and self.db.cooldown and self.db.buffsEnabled then
            margin = margin + 1
            height = height + (teamSize - 1)
        end
    end
    return margin, height
end

function Gladdy:PositionButton(button, i, leftSize, rightSize, powerBarHeight, margin)
    if (self.db.growDirection == "TOP") then
        if (i == 1) then
            button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", leftSize, powerBarHeight)
            button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
        else
            button:SetPoint("BOTTOMLEFT", self.buttons["arena" .. (i - 1)], "TOPLEFT", 0, margin + self.db.bottomMargin)
            button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
        end
    elseif (self.db.growDirection == "BOTTOM") then
        if (i == 1) then
            button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", leftSize, 0)
            button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
        else
            button:SetPoint("TOPLEFT", self.buttons["arena" .. (i - 1)], "BOTTOMLEFT", 0, -margin - self.db.bottomMargin)
            button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
        end
    elseif (self.db.growDirection == "LEFT") then
        if (i == 1) then
            button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -rightSize, 0)
            button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
        else
            button:SetPoint("TOPRIGHT", self.buttons["arena" .. (i - 1)], "TOPLEFT", -rightSize - leftSize - self.db.bottomMargin, 0)
            button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
        end
    elseif (self.db.growDirection == "RIGHT") then
        if (i == 1) then
            button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", leftSize, 0)
            button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
        else
            button:SetPoint("TOPLEFT", self.buttons["arena" .. (i - 1)], "TOPRIGHT", leftSize + rightSize + self.db.bottomMargin, 0)
            button.secure:SetPoint("TOPLEFT", button.healthBar, "TOPLEFT")
        end
    end
end

function Gladdy:GetAnchor(unit, position)
    local anchor = "healthBar"
    if Gladdy.db.classIconPos == position then
        anchor = "classIcon"
    end
    if Gladdy.db.trinketPos == position then
        anchor = "trinket"
    end
    if anchor == Gladdy.db.racialAnchor and Gladdy.db.racialPos == position then
        anchor = "racial"
    end
    return Gladdy.buttons[unit][anchor]
end