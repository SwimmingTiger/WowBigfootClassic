local pairs, ipairs, select, tinsert, tbl_sort, tostring, tonumber, rand = pairs, ipairs, select, tinsert, table.sort, tostring, tonumber, math.random
local str_gsub = string.gsub
local GetSpellInfo = GetSpellInfo
local GetSpellDescription = GetSpellDescription
local CreateFrame, GetTime = CreateFrame, GetTime
local AURA_TYPE_DEBUFF, AURA_TYPE_BUFF = AURA_TYPE_DEBUFF, AURA_TYPE_BUFF

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local function defaultSpells(auraType)
    local spells = {}
    for _,v in pairs(Gladdy:GetImportantAuras()) do
        if not auraType or auraType == v.track then
            spells[tostring(v.spellID)] = {}
            spells[tostring(v.spellID)].enabled = true
            spells[tostring(v.spellID)].priority = v.priority
            spells[tostring(v.spellID)].track = v.track
        end
    end
    return spells
end
local function defaultInterrupts()
    local spells = {}
    for _,v in pairs(Gladdy:GetInterrupts()) do
        spells[tostring(v.spellID)] = {}
        spells[tostring(v.spellID)].enabled = true
        spells[tostring(v.spellID)].priority = v.priority
    end
    return spells
end

local Auras = Gladdy:NewModule("Auras", nil, {
    auraFont = "DorisPP",
    auraFontSizeScale = 1,
    auraFontColor = { r = 1, g = 1, b = 0, a = 1 },
    auraBorderStyle = "Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp",
    auraBuffBorderColor = { r = 1, g = 0, b = 0, a = 1 },
    auraDebuffBorderColor = { r = 0, g = 1, b = 0, a = 1 },
    auraDisableCircle = false,
    auraCooldownAlpha = 1,
    auraListDefault = defaultSpells(),
    auraListInterrupts = defaultInterrupts(),
    auraInterruptColorsEnabled = true,
    auraInterruptColors = Gladdy:GetSpellSchoolColors(),
    auraDetached = false,
    auraXOffset = 0,
    auraYOffset = 0,
    auraSize = 60 + 20 + 1,
    auraWidthFactor = 0.9,
    auraIconZoomed = false,
    auraInterruptDetached = false,
    auraInterruptXOffset = 0,
    auraInterruptYOffset = 0,
    auraInterruptSize = 60 + 20 + 1,
    auraInterruptWidthFactor = 0.9,
    auraInterruptIconZoomed = false,
    auraFrameStrata = "MEDIUM",
    auraFrameLevel = 5,
    auraInterruptFrameStrata = "MEDIUM",
    auraInterruptFrameLevel = 5,
    auraGroup = false,
    auraGroupDirection = "DOWN",
    auraInterruptGroup = false,
    auraInterruptGroupDirection = "DOWN",
})

function Auras:Initialize()
    self.frames = {}

    self.auras = Gladdy:GetImportantAuras()

    self:RegisterMessage("JOINED_ARENA")
    self:RegisterMessage("UNIT_DEATH")
    self:RegisterMessage("AURA_GAIN")
    self:RegisterMessage("AURA_FADE")
    self:RegisterMessage("SPELL_INTERRUPT")
end

function Auras:CreateFrame(unit)
    local auraFrame = CreateFrame("Frame", nil, Gladdy.buttons[unit])
    auraFrame:EnableMouse(false)
    auraFrame:SetFrameStrata("MEDIUM")
    auraFrame:SetFrameLevel(3)
    auraFrame.frame = CreateFrame("Frame", nil, auraFrame)
    auraFrame.frame:SetPoint("TOPLEFT", auraFrame, "TOPLEFT")
    auraFrame.frame:EnableMouse(false)
    auraFrame.frame:SetFrameStrata("MEDIUM")
    auraFrame.frame:SetFrameLevel(3)

    auraFrame.cooldown = CreateFrame("Cooldown", nil, auraFrame.frame, "CooldownFrameTemplate")
    auraFrame.cooldown.noCooldownCount = true
    auraFrame.cooldown:SetFrameStrata("MEDIUM")
    auraFrame.cooldown:SetFrameLevel(4)
    auraFrame.cooldown:SetReverse(true)
    auraFrame.cooldown:SetHideCountdownNumbers(true)

    auraFrame.cooldownFrame = CreateFrame("Frame", nil, auraFrame.frame)
    auraFrame.cooldownFrame:ClearAllPoints()
    auraFrame.cooldownFrame:SetAllPoints(auraFrame.frame)
    auraFrame.cooldownFrame:SetFrameStrata("MEDIUM")
    auraFrame.cooldownFrame:SetFrameLevel(5)

    auraFrame.icon = auraFrame.frame:CreateTexture(nil, "BACKGROUND")
    auraFrame.icon:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
    auraFrame.icon:SetAllPoints(auraFrame)
    auraFrame.icon.masked = true

    auraFrame.icon.overlay = auraFrame.cooldownFrame:CreateTexture(nil, "OVERLAY")
    auraFrame.icon.overlay:SetAllPoints(auraFrame)
    auraFrame.icon.overlay:SetTexture(Gladdy.db.buttonBorderStyle)

    local classIcon = Gladdy.modules["Class Icon"].frames[unit]
    auraFrame:ClearAllPoints()
    auraFrame:SetAllPoints(classIcon)

    auraFrame.text = auraFrame.cooldownFrame:CreateFontString(nil, "OVERLAY")
    auraFrame.text:SetFont(Gladdy:SMFetch("font", "auraFont"), 10, "OUTLINE")
    auraFrame.text:SetTextColor(Gladdy:SetColor(Gladdy.db.auraFontColor))
    --auraFrame.text:SetShadowOffset(1, -1)
    --auraFrame.text:SetShadowColor(0, 0, 0, 1)
    auraFrame.text:SetJustifyH("CENTER")
    auraFrame.text:SetPoint("CENTER")
    auraFrame.unit = unit

    auraFrame:SetScript("OnUpdate", function(self, elapsed)
        if (self.active) then
            if (not Gladdy.db.auraInterruptDetached and not Gladdy.db.auraDetached and self.interruptFrame.priority and self.priority < self.interruptFrame.priority) then
                self.frame:SetAlpha(0.001)
            else
                self.frame:SetAlpha(1)
            end
            if (self.timeLeft <= 0) then
                Auras:AURA_FADE(self.unit, self.track, true)
            else
                if self.spellID == 8178 then
                    self.text:SetText("")
                else
                    Gladdy:FormatTimer(self.text, self.timeLeft, self.timeLeft < 10)
                end
                self.timeLeft = self.timeLeft - elapsed
            end
        else
            self.frame:SetAlpha(0.001)
        end
    end)

    Gladdy.buttons[unit].aura = auraFrame
    self.frames[unit] = auraFrame
    self:CreateInterrupt(unit)
    self:ResetUnit(unit)
end

function Auras:CreateInterrupt(unit)
    local interruptFrame = CreateFrame("Frame", nil, Gladdy.buttons[unit])
    interruptFrame:EnableMouse(false)
    interruptFrame:SetFrameStrata("MEDIUM")
    interruptFrame:SetFrameLevel(3)
    interruptFrame.frame = CreateFrame("Frame", nil, interruptFrame)
    interruptFrame.frame:SetPoint("TOPLEFT", interruptFrame, "TOPLEFT")
    interruptFrame.frame:EnableMouse(false)
    interruptFrame.frame:SetFrameStrata("MEDIUM")
    interruptFrame.frame:SetFrameLevel(3)

    interruptFrame.cooldown = CreateFrame("Cooldown", nil, interruptFrame.frame, "CooldownFrameTemplate")
    interruptFrame.cooldown.noCooldownCount = true
    interruptFrame.cooldown:SetFrameStrata("MEDIUM")
    interruptFrame.cooldown:SetFrameLevel(4)
    interruptFrame.cooldown:SetReverse(true)
    interruptFrame.cooldown:SetHideCountdownNumbers(true)

    interruptFrame.cooldownFrame = CreateFrame("Frame", nil, interruptFrame.frame)
    interruptFrame.cooldownFrame:ClearAllPoints()
    interruptFrame.cooldownFrame:SetAllPoints(interruptFrame.frame)
    interruptFrame.cooldownFrame:SetFrameStrata("MEDIUM")
    interruptFrame.cooldownFrame:SetFrameLevel(5)

    interruptFrame.icon = interruptFrame.frame:CreateTexture(nil, "BACKGROUND")
    interruptFrame.icon:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
    interruptFrame.icon:SetAllPoints(interruptFrame.frame)
    interruptFrame.icon.masked = true

    interruptFrame.icon.overlay = interruptFrame.cooldownFrame:CreateTexture(nil, "OVERLAY")
    interruptFrame.icon.overlay:SetAllPoints(interruptFrame.frame)
    interruptFrame.icon.overlay:SetTexture(Gladdy.db.buttonBorderStyle)

    local classIcon = Gladdy.modules["Class Icon"].frames[unit]
    interruptFrame:ClearAllPoints()
    interruptFrame:SetAllPoints(classIcon)

    interruptFrame.text = interruptFrame.cooldownFrame:CreateFontString(nil, "OVERLAY")
    interruptFrame.text:SetFont(Gladdy:SMFetch("font", "auraFont"), 10, "OUTLINE")
    interruptFrame.text:SetTextColor(Gladdy:SetColor(Gladdy.db.auraFontColor))
    --auraFrame.text:SetShadowOffset(1, -1)
    --auraFrame.text:SetShadowColor(0, 0, 0, 1)
    interruptFrame.text:SetJustifyH("CENTER")
    interruptFrame.text:SetPoint("CENTER")
    interruptFrame.unit = unit

    interruptFrame:SetScript("OnUpdate", function(self, elapsed)
        if (self.active) then
            if (not Gladdy.db.auraInterruptDetached and Auras.frames[self.unit].priority and self.priority <= Auras.frames[self.unit].priority) then
                self.frame:SetAlpha(0.001)
            else
                self.frame:SetAlpha(1)
            end
            if (self.timeLeft <= 0) then
                self.active = false
                self.priority = nil
                self.spellSchool = nil
                self.cooldown:Clear()
                self.frame:SetAlpha(0.001)
            else
                self.timeLeft = self.timeLeft - elapsed
                Gladdy:FormatTimer(self.text, self.timeLeft, self.timeLeft < 10)
            end
        else
            self.priority = nil
            self.spellSchool = nil
            self.frame:SetAlpha(0.001)
        end
    end)

    Gladdy.buttons[unit].interruptFrame = interruptFrame
    self.frames[unit].interruptFrame = interruptFrame
    self:ResetUnit(unit)
end

function Auras:UpdateFrame(unit)
    local auraFrame = self.frames[unit]
    if (not auraFrame) then
        return
    end

    local width, height

    if Gladdy.db.auraDetached then
        width, height = Gladdy.db.auraSize * Gladdy.db.auraWidthFactor, Gladdy.db.auraSize

        auraFrame:SetFrameStrata(Gladdy.db.auraFrameStrata)
        auraFrame:SetFrameLevel(Gladdy.db.auraFrameLevel)
        auraFrame.frame:SetFrameStrata(Gladdy.db.auraFrameStrata)
        auraFrame.frame:SetFrameLevel(Gladdy.db.auraFrameLevel)
        auraFrame.cooldown:SetFrameStrata(Gladdy.db.auraFrameStrata)
        auraFrame.cooldown:SetFrameLevel(Gladdy.db.auraFrameLevel + 1)
        auraFrame.cooldownFrame:SetFrameStrata(Gladdy.db.auraFrameStrata)
        auraFrame.cooldownFrame:SetFrameLevel(Gladdy.db.auraFrameLevel + 2)

        auraFrame:ClearAllPoints()
        Gladdy:SetPosition(auraFrame, unit, "auraXOffset", "auraYOffset", true, Auras)

        if (Gladdy.db.auraGroup) then
            if (unit ~= "arena1") then
                local previousUnit = "arena" .. str_gsub(unit, "arena", "") - 1
                self.frames[unit]:ClearAllPoints()
                if Gladdy.db.auraGroupDirection == "RIGHT" then
                    self.frames[unit]:SetPoint("LEFT", self.frames[previousUnit], "RIGHT", 0, 0)
                elseif Gladdy.db.auraGroupDirection == "LEFT" then
                    self.frames[unit]:SetPoint("RIGHT", self.frames[previousUnit], "LEFT", 0, 0)
                elseif Gladdy.db.auraGroupDirection == "UP" then
                    self.frames[unit]:SetPoint("BOTTOM", self.frames[previousUnit], "TOP", 0, 0)
                elseif Gladdy.db.auraGroupDirection == "DOWN" then
                    self.frames[unit]:SetPoint("TOP", self.frames[previousUnit], "BOTTOM", 0, 0)
                end
            end
        end

        if (unit == "arena1") then
            Gladdy:CreateMover(auraFrame, "auraXOffset", "auraYOffset", L["Auras"],
                    {"TOPLEFT", "TOPLEFT"},
                    width,
                    height,
                    0,
                    0)
        end
    else
        width, height = Gladdy.db.classIconSize * Gladdy.db.classIconWidthFactor, Gladdy.db.classIconSize

        auraFrame:SetFrameStrata(Gladdy.db.classIconFrameStrata)
        auraFrame:SetFrameLevel(Gladdy.db.classIconFrameLevel + 1)
        auraFrame.frame:SetFrameStrata(Gladdy.db.classIconFrameStrata)
        auraFrame.frame:SetFrameLevel(Gladdy.db.classIconFrameLevel + 1)
        auraFrame.cooldown:SetFrameStrata(Gladdy.db.classIconFrameStrata)
        auraFrame.cooldown:SetFrameLevel(Gladdy.db.classIconFrameLevel + 2)
        auraFrame.cooldownFrame:SetFrameStrata(Gladdy.db.classIconFrameStrata)
        auraFrame.cooldownFrame:SetFrameLevel(Gladdy.db.classIconFrameLevel + 3)

        auraFrame:ClearAllPoints()
        auraFrame:SetPoint("TOPLEFT", Gladdy.modules["Class Icon"].frames[unit], "TOPLEFT")
        if auraFrame.mover then
            auraFrame.mover:Hide()
        end
    end

    local testAgain = false

    auraFrame:SetWidth(width)
    auraFrame:SetHeight(height)
    auraFrame.frame:SetWidth(height)
    auraFrame.frame:SetHeight(height)
    auraFrame.cooldownFrame:ClearAllPoints()
    auraFrame.cooldownFrame:SetAllPoints(auraFrame)

    auraFrame.cooldown:ClearAllPoints()
    auraFrame.cooldown:SetPoint("CENTER", auraFrame, "CENTER")
    if Gladdy.db.auraIconZoomed then
        auraFrame.cooldown:SetWidth(width)
        auraFrame.cooldown:SetHeight(height)
    else
        auraFrame.cooldown:SetWidth(width - width/16)
        auraFrame.cooldown:SetHeight(height - height/16)
    end
    auraFrame.cooldown:SetAlpha(Gladdy.db.auraCooldownAlpha)

    auraFrame.text:SetFont(Gladdy:SMFetch("font", "auraFont"), (width/2 - 1) * Gladdy.db.auraFontSizeScale, "OUTLINE")
    auraFrame.text:SetTextColor(Gladdy:SetColor(Gladdy.db.auraFontColor))

    auraFrame.icon.overlay:SetTexture(Gladdy.db.auraBorderStyle)
    if auraFrame.track and auraFrame.track == AURA_TYPE_DEBUFF then
        auraFrame.icon.overlay:SetVertexColor(Gladdy:SetColor(Gladdy.db.auraDebuffBorderColor))
    elseif auraFrame.track and auraFrame.track == AURA_TYPE_BUFF then
        auraFrame.icon.overlay:SetVertexColor(Gladdy:SetColor(Gladdy.db.auraBuffBorderColor))
    else
        auraFrame.icon.overlay:SetVertexColor(0, 0, 0, 1)
    end
    if not auraFrame.active then
        auraFrame.icon.overlay:Hide()
    end
    if Gladdy.db.auraDisableCircle then
        auraFrame.cooldown:SetAlpha(0)
    end

    if Gladdy.db.auraIconZoomed then
        if auraFrame.icon.masked then
            auraFrame.icon:SetMask(nil)
            auraFrame.icon:SetTexCoord(0.1,0.9,0.1,0.9)
            auraFrame.icon.masked = nil
        end
    else
        if not auraFrame.icon.masked then
            auraFrame.icon:SetMask(nil)
            auraFrame.icon:SetTexCoord(0,1,0,1)
            auraFrame.icon:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
            auraFrame.icon.masked = true
            if Gladdy.frame.testing then
                testAgain = true
            end
        end
    end

    testAgain = testAgain or self:UpdateInterruptFrame(unit)

    if testAgain then
        Auras:ResetUnit(unit)
        Auras:Test(unit)
    end
end

function Auras:UpdateInterruptFrame(unit)
    local interruptFrame = self.frames[unit] and self.frames[unit].interruptFrame
    if (not interruptFrame) then
        return
    end

    local width, height

    if Gladdy.db.auraInterruptDetached then
        width, height = Gladdy.db.auraInterruptSize * Gladdy.db.auraInterruptWidthFactor, Gladdy.db.auraInterruptSize

        interruptFrame:SetFrameStrata(Gladdy.db.auraInterruptFrameStrata)
        interruptFrame:SetFrameLevel(Gladdy.db.auraInterruptFrameLevel)
        interruptFrame.frame:SetFrameStrata(Gladdy.db.auraInterruptFrameStrata)
        interruptFrame.frame:SetFrameLevel(Gladdy.db.auraInterruptFrameLevel)
        interruptFrame.cooldown:SetFrameStrata(Gladdy.db.auraInterruptFrameStrata)
        interruptFrame.cooldown:SetFrameLevel(Gladdy.db.auraInterruptFrameLevel + 1)
        interruptFrame.cooldownFrame:SetFrameStrata(Gladdy.db.auraInterruptFrameStrata)
        interruptFrame.cooldownFrame:SetFrameLevel(Gladdy.db.auraInterruptFrameLevel + 2)

        interruptFrame:ClearAllPoints()
        Gladdy:SetPosition(interruptFrame, unit, "auraInterruptXOffset", "auraInterruptYOffset", true, Auras)

        if (Gladdy.db.auraInterruptGroup) then
            if (unit ~= "arena1") then
                local previousUnit = "arena" .. str_gsub(unit, "arena", "") - 1
                self.frames[unit].interruptFrame:ClearAllPoints()
                if Gladdy.db.auraInterruptGroupDirection == "RIGHT" then
                    self.frames[unit].interruptFrame:SetPoint("LEFT", self.frames[previousUnit].interruptFrame, "RIGHT", 0, 0)
                elseif Gladdy.db.auraInterruptGroupDirection == "LEFT" then
                    self.frames[unit].interruptFrame:SetPoint("RIGHT", self.frames[previousUnit].interruptFrame, "LEFT", 0, 0)
                elseif Gladdy.db.auraInterruptGroupDirection == "UP" then
                    self.frames[unit].interruptFrame:SetPoint("BOTTOM", self.frames[previousUnit].interruptFrame, "TOP", 0, 0)
                elseif Gladdy.db.auraInterruptGroupDirection == "DOWN" then
                    self.frames[unit].interruptFrame:SetPoint("TOP", self.frames[previousUnit].interruptFrame, "BOTTOM", 0, 0)
                end
            end
        end

        if (unit == "arena1") then
            Gladdy:CreateMover(interruptFrame, "auraInterruptXOffset", "auraInterruptYOffset", L["Interrupts"],
                    {"TOPLEFT", "TOPLEFT"},
                    width,
                    height,
                    0,
                    0)
        end
    else
        if Gladdy.db.auraDetached then
            width, height = Gladdy.db.auraSize * Gladdy.db.auraWidthFactor, Gladdy.db.auraSize

            interruptFrame:SetFrameStrata(Gladdy.db.auraFrameStrata)
            interruptFrame:SetFrameLevel(Gladdy.db.auraFrameLevel)
            interruptFrame.frame:SetFrameStrata(Gladdy.db.auraFrameStrata)
            interruptFrame.frame:SetFrameLevel(Gladdy.db.auraFrameLevel)
            interruptFrame.cooldown:SetFrameStrata(Gladdy.db.auraFrameStrata)
            interruptFrame.cooldown:SetFrameLevel(Gladdy.db.auraFrameLevel + 1)
            interruptFrame.cooldownFrame:SetFrameStrata(Gladdy.db.auraFrameStrata)
            interruptFrame.cooldownFrame:SetFrameLevel(Gladdy.db.auraFrameLevel + 2)

            interruptFrame:ClearAllPoints()
            interruptFrame:SetAllPoints(self.frames[unit])
            if interruptFrame.mover then
                interruptFrame.mover:Hide()
            end
        else
            width, height = Gladdy.db.classIconSize * Gladdy.db.classIconWidthFactor, Gladdy.db.classIconSize

            interruptFrame:SetFrameStrata(Gladdy.db.classIconFrameStrata)
            interruptFrame:SetFrameLevel(Gladdy.db.classIconFrameLevel + 1)
            interruptFrame.frame:SetFrameStrata(Gladdy.db.classIconFrameStrata)
            interruptFrame.frame:SetFrameLevel(Gladdy.db.classIconFrameLevel + 1)
            interruptFrame.cooldown:SetFrameStrata(Gladdy.db.classIconFrameStrata)
            interruptFrame.cooldown:SetFrameLevel(Gladdy.db.classIconFrameLevel + 2)
            interruptFrame.cooldownFrame:SetFrameStrata(Gladdy.db.classIconFrameStrata)
            interruptFrame.cooldownFrame:SetFrameLevel(Gladdy.db.classIconFrameLevel + 3)

            interruptFrame:ClearAllPoints()
            interruptFrame:SetPoint("TOPLEFT", Gladdy.modules["Class Icon"].frames[unit], "TOPLEFT")
            if interruptFrame.mover then
                interruptFrame.mover:Hide()
            end
        end
    end

    local testAgain = false

    interruptFrame:SetWidth(width)
    interruptFrame:SetHeight(height)
    interruptFrame.frame:SetWidth(width)
    interruptFrame.frame:SetHeight(height)
    interruptFrame.cooldownFrame:ClearAllPoints()
    interruptFrame.cooldownFrame:SetAllPoints(interruptFrame.frame)

    interruptFrame.cooldown:ClearAllPoints()
    interruptFrame.cooldown:SetPoint("CENTER", interruptFrame, "CENTER")
    if Gladdy.db.auraInterruptIconZoomed then
        interruptFrame.cooldown:SetWidth(width)
        interruptFrame.cooldown:SetHeight(height)

    else
        interruptFrame.cooldown:SetWidth(width - width/16)
        interruptFrame.cooldown:SetHeight(height - height/16)
    end
    interruptFrame.cooldown:SetAlpha(Gladdy.db.auraCooldownAlpha)

    interruptFrame.text:SetFont(Gladdy:SMFetch("font", "auraFont"), (width/2 - 1) * Gladdy.db.auraFontSizeScale, "OUTLINE")
    interruptFrame.text:SetTextColor(Gladdy:SetColor(Gladdy.db.auraFontColor))

    interruptFrame.icon.overlay:SetTexture(Gladdy.db.auraBorderStyle)
    if interruptFrame.spellSchool then
        interruptFrame.icon.overlay:SetVertexColor(self:GetInterruptColor(interruptFrame.spellSchool))
    else
        interruptFrame.icon.overlay:SetVertexColor(0, 0, 0, 1)
    end
    if not interruptFrame.active then
        interruptFrame.icon.overlay:Hide()
    end
    if Gladdy.db.auraDisableCircle then
        interruptFrame.cooldown:SetAlpha(0)
    end

    if Gladdy.db.auraInterruptIconZoomed then
        if interruptFrame.icon.masked then
            interruptFrame.icon:SetMask(nil)
            interruptFrame.icon:SetTexCoord(0.1,0.9,0.1,0.9)
            interruptFrame.icon.masked = nil
        end
    else
        if not interruptFrame.icon.masked then
            interruptFrame.icon:SetMask(nil)
            interruptFrame.icon:SetTexCoord(0,1,0,1)
            interruptFrame.icon:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
            interruptFrame.icon.masked = true
            if Gladdy.frame.testing then
                testAgain = true
            end
        end
    end
    return testAgain
end

function Auras:ResetUnit(unit)
    self.frames[unit].interruptFrame.active = false
    self.frames[unit].active = false
    self:AURA_FADE(unit, AURA_TYPE_DEBUFF)
    self:AURA_FADE(unit, AURA_TYPE_BUFF)
    self.frames[unit]:UnregisterAllEvents()
    self.frames[unit]:Hide()
    self.frames[unit].interruptFrame:Hide()
    self.frames[unit].interruptFrame.priority = nil
    self.frames[unit].interruptFrame.spellSchool = nil
end

function Auras:Test(unit)
    local spellName, spellid, icon, limit

    self:AURA_FADE(unit, AURA_TYPE_BUFF)
    self:AURA_FADE(unit, AURA_TYPE_DEBUFF)
    if not self.frames[unit]:IsShown() then
        self.frames[unit]:Show()
        self.frames[unit].interruptFrame:Show()
    end

    --Auras
    local enabledDebuffs, enabledBuffs, testauras = {}, {}
    for spellIdStr,value in pairs(Gladdy.db.auraListDefault) do
        if value.enabled then
            if value.track == AURA_TYPE_BUFF then
                tinsert(enabledBuffs, {value = value, spellIdStr = spellIdStr})
            else
                tinsert(enabledDebuffs, {value = value, spellIdStr = spellIdStr})
            end
        end
    end
    if unit == "arena2" then
        testauras = enabledBuffs
    else
        testauras = enabledDebuffs
    end

    if #testauras > 0 then
        limit = rand(1, #testauras)
        local v = testauras[rand(1, #testauras)]
        spellid = tonumber(v.spellIdStr)
        spellName = select(1, GetSpellInfo(tonumber(v.spellIdStr)))
        icon = select(3, GetSpellInfo(tonumber(v.spellIdStr)))
        if Gladdy.exceptionNames[spellid] then
            spellName = Gladdy.exceptionNames[spellid]
        end
        local duration = math.random(2,10)
        if (unit == "arena2") then
            if (v.value.track == AURA_TYPE_BUFF) then
                self:AURA_GAIN(unit,v.value.track, spellid, spellName, icon, duration, GetTime() + duration)
            end
        else
            self:AURA_GAIN(unit,v.value.track, spellid, spellName, icon, duration, GetTime() + duration)
        end
    end

    --Interrupts
    if (unit == "arena1" or unit == "arena3") then
        local enabledInterrupts = {}
        local spellSchools = {}
        for k,_ in pairs(Gladdy:GetSpellSchoolColors()) do
            tinsert(spellSchools, k)
        end
        for spellIdStr, value in pairs(Gladdy.db.auraListInterrupts) do
            if value.enabled then
                tinsert(enabledInterrupts, spellIdStr)
            end
        end
        if #enabledInterrupts > 0 then
            local extraSpellSchool = spellSchools[rand(1, #spellSchools)]
            spellid = tonumber(enabledInterrupts[rand(1, #enabledInterrupts)])
            spellName = select(1, GetSpellInfo(spellid))
            Gladdy:SendMessage("SPELL_INTERRUPT", unit,spellid, spellName, "physical", spellid, spellName, extraSpellSchool)
        end
    end
end

function Auras:JOINED_ARENA()
    for i=1, Gladdy.curBracket do
        local unit = "arena" .. i
        self.frames[unit].interruptFrame.active = false
        self.frames[unit].active = false
        self:AURA_FADE(unit, AURA_TYPE_DEBUFF)
        self:AURA_FADE(unit, AURA_TYPE_BUFF)
        self.frames[unit]:Show()
        self.frames[unit].interruptFrame:Show()
    end
end

function Auras:AURA_GAIN(unit, auraType, spellID, spellName, icon, duration, expirationTime, count, debuffType)
    local auraFrame = self.frames[unit]
    if (not auraFrame) then
        return
    end

    if not self.auras[spellName] then
        return
    end
    -- don't use spellId from combatlog, in case of different spellrank
    if not Gladdy.db.auraListDefault[tostring(self.auras[spellName].spellID)]
            or not Gladdy.db.auraListDefault[tostring(self.auras[spellName].spellID)].enabled
            or Gladdy.db.auraListDefault[tostring(self.auras[spellName].spellID)].track ~= auraType then
        return
    end

    if (auraFrame.priority and auraFrame.priority > Gladdy.db.auraListDefault[tostring(self.auras[spellName].spellID)].priority) then
        return
    end
    auraFrame.startTime = expirationTime - duration
    auraFrame.endTime = expirationTime
    auraFrame.name = spellName
    auraFrame.spellID = spellID
    auraFrame.timeLeft = spellID == 8178 and 45 or expirationTime - GetTime()
    auraFrame.priority = Gladdy.db.auraListDefault[tostring(self.auras[spellName].spellID)].priority
    auraFrame.icon:SetTexture(Gladdy:GetImportantAuras()[GetSpellInfo(self.auras[spellName].spellID)] and Gladdy:GetImportantAuras()[GetSpellInfo(self.auras[spellName].spellID)].texture or icon)
    auraFrame.track = auraType
    auraFrame.active = true
    auraFrame.icon.overlay:Show()
    auraFrame.cooldownFrame:Show()
    if auraType == AURA_TYPE_DEBUFF then
        auraFrame.icon.overlay:SetVertexColor(Gladdy:SetColor(Gladdy.db.auraDebuffBorderColor))
    elseif auraType == AURA_TYPE_BUFF then
        auraFrame.icon.overlay:SetVertexColor(Gladdy:SetColor(Gladdy.db.auraBuffBorderColor))
    else
        auraFrame.icon.overlay:SetVertexColor(Gladdy.db.frameBorderColor.r, Gladdy.db.frameBorderColor.g, Gladdy.db.frameBorderColor.b, Gladdy.db.frameBorderColor.a)
    end
    if not Gladdy.db.auraDisableCircle and spellID ~= 8178 then
        auraFrame.cooldown:Show()
        auraFrame.cooldown:SetCooldown(auraFrame.startTime, duration)
    else
        auraFrame.cooldown:Hide()
    end
end

function Auras:AURA_FADE(unit, auraType, force)
    local auraFrame = self.frames[unit]
    if (not auraFrame or auraFrame.track ~= auraType or not Gladdy.buttons[unit] or (not force and Gladdy.buttons[unit].stealthed)) then
        return
    end
    if auraFrame.active then
        auraFrame.cooldown:Clear()
    end
    --auraFrame.cooldown:Hide()
    auraFrame.active = false
    auraFrame.name = nil
    auraFrame.timeLeft = 0
    auraFrame.priority = nil
    auraFrame.startTime = nil
    auraFrame.endTime = nil
    auraFrame.icon:SetTexture("")
    auraFrame.text:SetText("")
    --auraFrame.icon.overlay:Hide()
    --auraFrame.cooldownFrame:Hide()
end

function Auras:GetInterruptColor(extraSpellSchool)
    if not Gladdy.db.auraInterruptColorsEnabled then
        return Gladdy:SetColor(Gladdy.db.auraDebuffBorderColor)
    else
        local color = Gladdy.db.auraInterruptColors[extraSpellSchool] or Gladdy.db.auraInterruptColors["unknown"]
        return color.r, color.g, color.b, color.a
    end
end

function Auras:SPELL_INTERRUPT(unit,spellID,spellName,spellSchool,extraSpellId,extraSpellName,extraSpellSchool)
    local auraFrame = self.frames[unit]
    local interruptFrame = auraFrame ~= nil and auraFrame.interruptFrame
    local button = Gladdy.buttons[unit]
    if (not interruptFrame) then
        return
    end
    if not Gladdy.db.auraListInterrupts[tostring(Gladdy:GetInterrupts()[spellName].spellID)] or not Gladdy.db.auraListInterrupts[tostring(Gladdy:GetInterrupts()[spellName].spellID)].enabled then
        return
    end
    if (interruptFrame.priority and interruptFrame.priority > Gladdy.db.auraListInterrupts[tostring(Gladdy:GetInterrupts()[spellName].spellID)].priority) then
        return
    end
    local multiplier = ((button.spec == L["Restoration"] and button.class == "SHAMAN") or (button.spec == L["Holy"] and button.class == "PALADIN")) and 0.7 or 1

    local duration = Gladdy:GetInterrupts()[spellName].duration * multiplier

    interruptFrame.startTime = GetTime()
    interruptFrame.endTime = GetTime() + duration
    interruptFrame.name = spellName
    interruptFrame.timeLeft = duration
    interruptFrame.priority = Gladdy.db.auraListInterrupts[tostring(Gladdy:GetInterrupts()[spellName].spellID)].priority
    interruptFrame.icon:SetTexture(Gladdy:GetInterrupts()[spellName].texture)
    interruptFrame.spellSchool = extraSpellSchool
    interruptFrame.active = true
    interruptFrame.icon.overlay:Show()
    interruptFrame.cooldownFrame:Show()

    interruptFrame.icon.overlay:SetVertexColor(self:GetInterruptColor(extraSpellSchool))

    if not Gladdy.db.auraDisableCircle then
        interruptFrame.cooldown:Show()
        interruptFrame.cooldown:SetCooldown(interruptFrame.startTime, duration)
    end
    --interruptFrame:SetAlpha(1)
end

function Auras:GetOptions()
    local borderArgs = {
        headerAuras = {
            type = "header",
            name = L["Border"],
            order = 2,
        },
        auraBorderStyle = Gladdy:option({
            type = "select",
            name = L["Border style"],
            order = 9,
            values = Gladdy:GetIconStyles(),
        }),
        auraBuffBorderColor = Gladdy:colorOption({
            type = "color",
            name = L["Buff color"],
            desc = L["Color of the text"],
            order = 10,
            hasAlpha = true,
            width = "0.8",
        }),
        auraDebuffBorderColor = Gladdy:colorOption({
            type = "color",
            name = L["Debuff color"],
            desc = L["Color of the text"],
            order = 11,
            hasAlpha = true,
            width = "0.8",
        }),
        headerColors = {
            type = "header",
            name = L["Interrupt Spells School Colors"],
            order = 12,
        },
        auraInterruptColorsEnabled = Gladdy:option({
            type = "toggle",
            name = L["Enable Interrupt Spell School Colors"],
            width = "full",
            desc = L["Will use Debuff Color if disabled"],
            order = 13,
        }),
    }
    local list = {}
    for k,v in pairs(Gladdy:GetSpellSchoolColors()) do
        tinsert(list, { key = k, val = v})
    end
    tbl_sort(list, function(a, b) return a.val.type < b.val.type end)
    for i,v in ipairs(list) do
        borderArgs["auraSpellSchool" .. v.key] = {
            type = "color",
            name = L[v.val.type],
            order = i + 13,
            hasAlpha = true,
            width = "0.8",
            set = function(_, r, g, b, a)
                Gladdy.db.auraInterruptColors[v.key].r = r
                Gladdy.db.auraInterruptColors[v.key].g = g
                Gladdy.db.auraInterruptColors[v.key].b = b
                Gladdy.db.auraInterruptColors[v.key].a = a
            end,
            get = function()
                local color = Gladdy.db.auraInterruptColors[v.key]
                return color.r, color.g, color.b, color.a
            end
        }
    end

    return {
        header = {
            type = "header",
            name = L["Auras"],
            order = 2,
        },
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 3,
            args = {
                groupOptions = {
                    type = "group",
                    name = L["Group"],
                    order = 4,
                    args = {
                        headerAuras = {
                            type = "header",
                            name = L["Auras"],
                            order = 1,
                        },
                        auraGroup = Gladdy:option({
                            type = "toggle",
                            name = L["Group"] .. " " .. L["Auras"],
                            order = 2,
                            disabled = function() return not Gladdy.db.auraDetached end,
                        }),
                        auraGroupDirection = Gladdy:option({
                            type = "select",
                            name = L["Group direction"],
                            order = 3,
                            values = {
                                ["RIGHT"] = L["Right"],
                                ["LEFT"] = L["Left"],
                                ["UP"] = L["Up"],
                                ["DOWN"] = L["Down"],
                            },
                            disabled = function() return not Gladdy.db.auraGroup or not Gladdy.db.auraDetached end,
                        }),
                        headerInterrupts = {
                            type = "header",
                            name = L["Interrupts"],
                            order = 4,
                        },
                        auraInterruptGroup = Gladdy:option({
                            type = "toggle",
                            name = L["Group"] .. " " .. L["Interrupts"],
                            order = 5,
                            disabled = function() return not Gladdy.db.auraInterruptDetached end,
                        }),
                        auraInterruptGroupDirection = Gladdy:option({
                            type = "select",
                            name = L["Group direction"],
                            order = 6,
                            values = {
                                ["RIGHT"] = L["Right"],
                                ["LEFT"] = L["Left"],
                                ["UP"] = L["Up"],
                                ["DOWN"] = L["Down"],
                            },
                            disabled = function() return not Gladdy.db.auraInterruptGroup or not Gladdy.db.auraInterruptDetached end,
                        }),
                    }
                },
                detachedAuraMode = {
                    type = "group",
                    name = L["Detached Aura"],
                    order = 5,
                    args = {
                        headerDetachedMode = {
                            type = "header",
                            name = L["Detached Mode"],
                            order = 1,
                        },
                        auraDetached = Gladdy:option({
                            type = "toggle",
                            name = L["Aura Detached"],
                            order = 2,
                            width = "full"
                        }),
                        headerIcon = {
                            type = "header",
                            name = L["Icon"],
                            order = 5,
                        },
                        auraIconZoomed = Gladdy:option({
                            type = "toggle",
                            name = L["Zoomed Icon"],
                            desc = L["Zoomes the icon to remove borders"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            order = 6,
                            width = "full",
                        }),
                        headerAuraSize = {
                            type = "header",
                            name = L["Size"],
                            order = 10,
                        },
                        auraSize = Gladdy:option({
                            type = "range",
                            name = L["Aura size"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            min = 3,
                            max = 100,
                            step = 0.1,
                            order = 11,
                            width = "full",
                        }),
                        auraWidthFactor = Gladdy:option({
                            type = "range",
                            name = L["Aura width factor"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            min = 0.5,
                            max = 2,
                            step = 0.05,
                            order = 12,
                            width = "full",
                        }),
                        headerAuraPosition = {
                            type = "header",
                            name = L["Position"],
                            order = 20,
                        },
                        auraXOffset = Gladdy:option({
                            type = "range",
                            name = L["Aura X Offset"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            min = -1000,
                            max = 1000,
                            step = 0.01,
                            order = 21,
                            width = "full",
                        }),
                        auraYOffset = Gladdy:option({
                            type = "range",
                            name = L["Aura Y Offset"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            min = -1000,
                            max = 1000,
                            step = 0.01,
                            order = 22,
                            width = "full",
                        }),
                        headerAuraLevel = {
                            type = "header",
                            name = L["Frame Strata and Level"],
                            order = 30,
                        },
                        auraFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            order = 32,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        auraFrameLevel = Gladdy:option({
                            type = "range",
                            name = L["Frame Level"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            min = 0,
                            max = 500,
                            step = 1,
                            order = 33,
                            width = "full",
                        }),
                    }
                },
                detachedInterruptMode = {
                    type = "group",
                    name = L["Detached Interrupt"],
                    order = 6,
                    args = {
                        headerDetachedMode = {
                            type = "header",
                            name = L["Detached Mode"],
                            order = 1,
                        },
                        auraInterruptDetached = Gladdy:option({
                            type = "toggle",
                            name = L["Interrupt Detached"],
                            order = 2,
                            width = "full"
                        }),
                        headerIcon = {
                            type = "header",
                            name = L["Icon"],
                            order = 5,
                        },
                        auraInterruptIconZoomed = Gladdy:option({
                            type = "toggle",
                            name = L["Zoomed Icon"],
                            desc = L["Zoomes the icon to remove borders"],
                            disabled = function()
                                return not Gladdy.db.auraInterruptDetached
                            end,
                            order = 6,
                            width = "full",
                        }),
                        headerAuraSize = {
                            type = "header",
                            name = L["Size"],
                            order = 10,
                        },
                        auraInterruptSize = Gladdy:option({
                            type = "range",
                            name = L["Interrupt size"],
                            disabled = function()
                                return not Gladdy.db.auraInterruptDetached
                            end,
                            min = 3,
                            max = 100,
                            step = 0.1,
                            order = 11,
                            width = "full",
                        }),
                        auraInterruptWidthFactor = Gladdy:option({
                            type = "range",
                            name = L["Interrupt width factor"],
                            disabled = function()
                                return not Gladdy.db.auraInterruptDetached
                            end,
                            min = 0.5,
                            max = 2,
                            step = 0.05,
                            order = 12,
                            width = "full",
                        }),
                        headerAuraPosition = {
                            type = "header",
                            name = L["Position"],
                            order = 20,
                        },
                        auraInterruptXOffset = Gladdy:option({
                            type = "range",
                            name = L["Interrupt X Offset"],
                            disabled = function()
                                return not Gladdy.db.auraInterruptDetached
                            end,
                            min = -1000,
                            max = 1000,
                            step = 0.01,
                            order = 21,
                            width = "full",
                        }),
                        auraInterruptYOffset = Gladdy:option({
                            type = "range",
                            name = L["Interrupt Y Offset"],
                            disabled = function()
                                return not Gladdy.db.auraInterruptDetached
                            end,
                            min = -1000,
                            max = 1000,
                            step = 0.01,
                            order = 22,
                            width = "full",
                        }),
                        headerAuraLevel = {
                            type = "header",
                            name = L["Frame Strata and Level"],
                            order = 30,
                        },
                        auraInterruptFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            order = 32,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        auraInterruptFrameLevel = Gladdy:option({
                            type = "range",
                            name = L["Frame Level"],
                            disabled = function()
                                return not Gladdy.db.auraDetached
                            end,
                            min = 0,
                            max = 500,
                            step = 1,
                            order = 33,
                            width = "full",
                        }),
                    }
                },
                icon = {
                    type = "group",
                    name = L["Icon"],
                    order = 1,
                    args = {
                        headerIcon = {
                            type = "header",
                            name = L["Icon"],
                            order = 1,
                        },
                        auraIconZoomed = Gladdy:option({
                            type = "toggle",
                            name = L["Zoomed Icon"],
                            desc = L["Zoomes the icon to remove borders"],
                            order = 2,
                            width = "full",
                        }),
                    },
                },
                cooldown = {
                    type = "group",
                    name = L["Cooldown"],
                    order = 2,
                    args = {
                        headerAuras = {
                            type = "header",
                            name = L["Cooldown"],
                            order = 2,
                        },
                        auraDisableCircle = Gladdy:option({
                            type = "toggle",
                            name = L["No Cooldown Circle"],
                            order = 3,
                            width = "full"
                        }),
                        auraCooldownAlpha = Gladdy:option({
                            type = "range",
                            name = L["Cooldown circle alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 4,
                            width = "full",
                        }),
                        auraCooldownNumberAlpha = {
                            type = "range",
                            name = L["Cooldown number alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 5,
                            width = "full",
                            set = function(info, value)
                                Gladdy.db.auraFontColor.a = value
                                Gladdy:UpdateFrame()
                            end,
                            get = function(info)
                                return Gladdy.db.auraFontColor.a
                            end,
                        },
                    }
                },
                font = {
                    type = "group",
                    name = L["Font"],
                    order = 3,
                    args = {
                        headerAuras = {
                            type = "header",
                            name = L["Font"],
                            order = 1,
                        },
                        auraFont = Gladdy:option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the cooldown"],
                            order = 5,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        auraFontSizeScale = Gladdy:option({
                            type = "range",
                            name = L["Font scale"],
                            desc = L["Scale of the text"],
                            order = 6,
                            min = 0.1,
                            max = 2,
                            step = 0.1,
                            width = "full",
                        }),
                        auraFontColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Font color"],
                            desc = L["Color of the text"],
                            order = 7,
                            hasAlpha = true,
                        }),
                    },
                },
                border = {
                    type = "group",
                    name = L["Border"],
                    order = 4,
                    args = borderArgs
                }
            }
        },
        debuffList = {
            type = "group",
            childGroups = "tree",
            name = L["Debuffs"],
            order = 4,
            args = Auras:GetAuraOptions(AURA_TYPE_DEBUFF)
        },
        buffList = {
            type = "group",
            childGroups = "tree",
            name = L["Buffs"],
            order = 5,
            args = Auras:GetAuraOptions(AURA_TYPE_BUFF)
        },
        interruptList = {
            type = "group",
            childGroups = "tree",
            name = L["Interrupts"],
            order = 6,
            args = Auras:GetInterruptOptions()
        }
    }
end

function Auras:GetAuraOptions(auraType)
    local options = {
        ckeckAll = {
            order = 1,
            width = "0.7",
            name = L["Check All"],
            type = "execute",
            func = function()
                for k,_ in pairs(defaultSpells(auraType)) do
                    Gladdy.db.auraListDefault[k].enabled = true
                end
            end,
        },
        uncheckAll = {
            order = 2,
            width = "0.7",
            name = L["Uncheck All"],
            type = "execute",
            func = function()
                for k,_ in pairs(defaultSpells(auraType)) do
                    Gladdy.db.auraListDefault[k].enabled = false
                end
            end,
        },
    }
    local auras = {}
    for _,v in pairs(Gladdy:GetImportantAuras()) do
        if v.track == auraType then
            tinsert(auras, v.spellID)
        end
    end
    tbl_sort(auras, function(a, b) return GetSpellInfo(a) < GetSpellInfo(b) end)
    for i,k in ipairs(auras) do
        options[tostring(k)] = {
            type = "group",
            name = Gladdy:GetExceptionSpellName(k),
            order = i+2,
            icon = Gladdy:GetImportantAuras()[GetSpellInfo(k)] and Gladdy:GetImportantAuras()[GetSpellInfo(k)].texture or select(3, GetSpellInfo(k)),
            args = {
                enabled = {
                    order = 1,
                    name = L["Enabled"],
                    desc = GetSpellDescription(k),
                    type = "toggle",
                    image = Gladdy:GetImportantAuras()[GetSpellInfo(k)] and Gladdy:GetImportantAuras()[GetSpellInfo(k)].texture or select(3, GetSpellInfo(k)),
                    width = "2",
                    set = function(_, value)
                        Gladdy.db.auraListDefault[tostring(k)].enabled = value
                    end,
                    get = function()
                        return Gladdy.db.auraListDefault[tostring(k)].enabled
                    end
                },
                priority = {
                    order = 2,
                    name = L["Priority"],
                    type = "range",
                    min = 0,
                    max = 50,
                    width = "2",
                    step = 1,
                    get = function()
                        return Gladdy.db.auraListDefault[tostring(k)].priority
                    end,
                    set = function(_, value)
                        Gladdy.db.auraListDefault[tostring(k)].priority = value
                    end,
                    width = "full",
                }
            }
        }
    end
    return options
end

function Auras:GetInterruptOptions()
    local options = {
        checkAll = {
            order = 1,
            width = "0.7",
            name = L["Check All"],
            type = "execute",
            func = function()
                for k,_ in pairs(defaultInterrupts()) do
                    Gladdy.db.auraListInterrupts[k].enabled = true
                end
            end,
        },
        uncheckAll = {
            order = 2,
            width = "0.7",
            name = L["Uncheck All"],
            type = "execute",
            func = function()
                for k,_ in pairs(defaultInterrupts()) do
                    Gladdy.db.auraListInterrupts[k].enabled = false
                end
            end,
        },
    }
    local auras = {}
    for _,v in pairs(Gladdy:GetInterrupts()) do
        tinsert(auras, v.spellID)
    end
    tbl_sort(auras, function(a, b) return GetSpellInfo(a) < GetSpellInfo(b) end)
    for i,k in ipairs(auras) do
        options[tostring(k)] = {
            type = "group",
            name = GetSpellInfo(k),
            order = i+2,
            icon = Gladdy:GetInterrupts()[GetSpellInfo(k)] and Gladdy:GetInterrupts()[GetSpellInfo(k)].texture or select(3, GetSpellInfo(k)),
            args = {
                enabled = {
                    order = 1,
                    name = L["Enabled"],
                    type = "toggle",
                    image = Gladdy:GetInterrupts()[GetSpellInfo(k)] and Gladdy:GetInterrupts()[GetSpellInfo(k)].texture or select(3, GetSpellInfo(k)),
                    width = "2",
                    set = function(_, value)
                        Gladdy.db.auraListInterrupts[tostring(k)].enabled = value
                    end,
                    get = function()
                        return Gladdy.db.auraListInterrupts[tostring(k)].enabled
                    end
                },
                priority = {
                    order = 2,
                    name = L["Priority"],
                    type = "range",
                    min = 0,
                    max = 50,
                    width = "2",
                    step = 1,
                    get = function()
                        return Gladdy.db.auraListInterrupts[tostring(k)].priority
                    end,
                    set = function(_, value)
                        Gladdy.db.auraListInterrupts[tostring(k)].priority = value
                    end,
                    width = "full",
                }
            }
        }
    end
    return options
end