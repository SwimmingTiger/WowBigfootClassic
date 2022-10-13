local GetSpellInfo = GetSpellInfo
local CreateFrame = CreateFrame
local GetTime = GetTime
local select, lower, ceil, tremove, tinsert, pairs, ipairs, tostring, random = select, string.lower, ceil, tremove, tinsert, pairs, ipairs, tostring, math.random
local AURA_TYPE_DEBUFF, AURA_TYPE_BUFF = AURA_TYPE_DEBUFF or "DEBUFF", AURA_TYPE_BUFF or "BUFF"		-- bf@178.com
local auraTypes = {AURA_TYPE_BUFF, AURA_TYPE_DEBUFF}

---------------------------
-- Module init
---------------------------

local Gladdy = LibStub("Gladdy")
local LibClassAuras = LibStub("LibClassAuras-1.0")
local L = Gladdy.L
local defaultTrackedDebuffs = select(2, Gladdy:GetAuras(AURA_TYPE_DEBUFF))
local defaultTrackedBuffs = select(2, Gladdy:GetAuras(AURA_TYPE_BUFF))
local BuffsDebuffs = Gladdy:NewModule("Buffs and Debuffs", nil, {
    buffsEnabled = true,
    buffsShowAuraDebuffs = false,
    buffsAlpha = 1,
    buffsIconSize = 30,
    buffsWidthFactor = 1,
    buffsIconZoomed = false,
    buffsIconPadding = 1,
    buffsBuffsAlpha = 1,
    buffsBuffsIconSize = 30,
    buffsBuffsWidthFactor = 1,
    buffsBuffsIconZoomed = false,
    buffsBuffsIconPadding = 1,
    buffsDisableCircle = false,
    buffsCooldownAlpha = 1,
    buffsFont = "DorisPP",
    buffsFontScale = 1,
    buffsFontColor = {r = 1, g = 1, b = 0, a = 1},
    buffsDynamicColor = true,
    buffsCooldownGrowDirection = "RIGHT",
    buffsXOffset = 0,
    buffsYOffset = 0,
    buffsBuffsCooldownGrowDirection = "RIGHT",
    buffsBuffsXOffset = 0,
    buffsBuffsYOffset = 0,
    buffsBorderStyle = "Interface\\AddOns\\Gladdy\\Images\\Border_squared_blp",
    buffsBorderColor = {r = 1, g = 1, b = 1, a = 1},
    buffsBorderColorsEnabled = true,
    trackedDebuffs = defaultTrackedDebuffs,
    trackedBuffs = defaultTrackedBuffs,
    buffsBorderColorEnrage = Gladdy:GetDispelTypeColors()["enrage"],
    buffsBorderColorCurse = Gladdy:GetDispelTypeColors()["curse"],
    buffsBorderColorMagic = Gladdy:GetDispelTypeColors()["magic"],
    buffsBorderColorPoison = Gladdy:GetDispelTypeColors()["poison"],
    buffsBorderColorPhysical = Gladdy:GetDispelTypeColors()["none"],
    buffsBorderColorImmune = Gladdy:GetDispelTypeColors()["immune"],
    buffsBorderColorDisease = Gladdy:GetDispelTypeColors()["disease"],
    buffsBorderColorForm = Gladdy:GetDispelTypeColors()["form"],
    buffsBorderColorAura = Gladdy:GetDispelTypeColors()["aura"],
    buffFrameStrata = "MEDIUM",
    buffsFrameLevel = 9,
})

local dispelTypeToOptionValueTable
local function dispelTypeToOptionValue(dispelType)
    if Gladdy.db.buffsBorderColorsEnabled then
        dispelType = dispelType and lower(dispelType) or "physical"
        if not dispelTypeToOptionValueTable[dispelType] then
            dispelType = "physical"
        end
        return dispelTypeToOptionValueTable[dispelType].r,
        dispelTypeToOptionValueTable[dispelType].g,
        dispelTypeToOptionValueTable[dispelType].b,
        dispelTypeToOptionValueTable[dispelType].a
    else
        return Gladdy:SetColor(Gladdy.db.buffsBorderColor)
    end
end

function BuffsDebuffs:OnEvent(event, ...)
    self[event](self, ...)
end

function BuffsDebuffs:Initialize()
    self.frames = {}
    self.spells = {}
    self.icons = {}
    self.trackedCC = {}
    self.framePool = {}
    if Gladdy.db.buffsEnabled then
        self:RegisterMessages(
                "JOINED_ARENA",
                "UNIT_DESTROYED",
                "UNIT_DEATH",
                "AURA_FADE",
                "AURA_GAIN",
                "AURA_GAIN_LIMIT")
        self:SetScript("OnEvent", BuffsDebuffs.OnEvent)
    end
    dispelTypeToOptionValueTable = {
        none = Gladdy.db.buffsBorderColorPhysical,
        magic = Gladdy.db.buffsBorderColorMagic,
        curse = Gladdy.db.buffsBorderColorCurse,
        disease = Gladdy.db.buffsBorderColorDisease,
        poison = Gladdy.db.buffsBorderColorPoison,
        stealth = Gladdy.db.buffsBorderColorPhysical,
        invisibility = Gladdy.db.buffsBorderColorPhysical,
        physical = Gladdy.db.buffsBorderColorPhysical,
        immune = Gladdy.db.buffsBorderColorImmune,
        form = Gladdy.db.buffsBorderColorForm,
        enrage = Gladdy.db.buffsBorderColorEnrage,
    }

end

function BuffsDebuffs:JOINED_ARENA()
    if Gladdy.db.buffsEnabled then
        for i=1, Gladdy.curBracket do
            local unit = "arena" .. i
            if not self.frames[unit].auras then
                self.frames[unit].auras = {[AURA_TYPE_DEBUFF] = {}, [AURA_TYPE_BUFF] = {}}
            end
        end
    end
end

function BuffsDebuffs:ResetUnit(unit)
    if not self.frames[unit] then return end
    for _, auraType in ipairs(auraTypes) do
        local i = #self.frames[unit].auras[auraType]
        while (#self.frames[unit].auras[auraType] > 0) do
            self.frames[unit].auras[auraType][i]:Hide()
            tinsert(self.framePool, tremove(self.frames[unit].auras[auraType], i))
            i = i - 1
        end
    end
end

function BuffsDebuffs:UNIT_DESTROYED(unit)
    BuffsDebuffs:ResetUnit(unit)
end

function BuffsDebuffs:UNIT_DEATH(unit)
    BuffsDebuffs:ResetUnit(unit)
end

function BuffsDebuffs:Reset()
    for i=1,#self.framePool do
        self.framePool[i]:Hide()
    end
end

function BuffsDebuffs:Test(unit)
    if Gladdy.db.buffsEnabled then
        local dispelTypes = { "physical", "magic", "curse", "poison", "disease", "immune", "enrage"}

        BuffsDebuffs:AURA_FADE(unit, AURA_TYPE_DEBUFF)
        BuffsDebuffs:AURA_FADE(unit, AURA_TYPE_BUFF)
        --BuffsDebuffs:AURA_GAIN(unit, AURA_TYPE_BUFF, 1243, select(1, GetSpellInfo(1243)), select(3, GetSpellInfo(1243)), 10, GetTime() + 10, 1, "physical")
        --self:AURA_GAIN(unit, AURA_TYPE_DEBUFF, 31117, select(1, GetSpellInfo(31117)), select(3, GetSpellInfo(31117)), 10, GetTime() + 10, 1, "physical")
        local i = 1
        for spellID, enabled in pairs(Gladdy.db.trackedDebuffs) do
            if i > 4 then
                break
            end
            if enabled then
                BuffsDebuffs:AddOrRefreshAura(unit, spellID, AURA_TYPE_DEBUFF, 15, 15, random(1,5), dispelTypes[random(1,#dispelTypes)], select(3, GetSpellInfo(spellID)), i)
                i = i + 1
            end
        end
        i = 1
        for spellID, enabled in pairs(Gladdy.db.trackedBuffs) do
            if i > 4 then
                break
            end
            if enabled then
                BuffsDebuffs:AddOrRefreshAura(unit, spellID, AURA_TYPE_BUFF, 15, 15, random(1,5), dispelTypes[random(1,#dispelTypes)], select(3, GetSpellInfo(spellID)), i)
                i = i + 1
            end
        end
    end
end

---------------------------
-- Aura handlers
---------------------------

function BuffsDebuffs:AURA_FADE(unit, auraType)
    if (not self.frames[unit] or not Gladdy.db.buffsEnabled) then
        return
    end
    if auraType == AURA_TYPE_DEBUFF then
        self.frames[unit].numDebuffs = 0
    else
        self.frames[unit].numBuffs = 0
    end
end

function BuffsDebuffs:AURA_GAIN_LIMIT(unit, auraType, limit)
    if (not self.frames[unit] or not Gladdy.db.buffsEnabled) then
        return
    end
    local numAura
    if auraType == AURA_TYPE_DEBUFF then
        numAura = self.frames[unit].numDebuffs
    else
        numAura = self.frames[unit].numBuffs
    end
    for i=numAura + 1, #self.frames[unit].auras[auraType] do
        self.frames[unit].auras[auraType][i]:Hide()
    end
end

function BuffsDebuffs:AURA_GAIN(unit, auraType, spellID, spellName, texture, duration, expirationTime, count, dispelType)
    if (not self.frames[unit] or not Gladdy.db.buffsEnabled) then
        return
    end
    local auraFrame = self.frames[unit]
    spellName = LibClassAuras.GetAltName(spellID) or spellName
    local aura = Gladdy:GetImportantAuras()[spellName] and Gladdy.db.auraListDefault[tostring(Gladdy:GetImportantAuras()[spellName].spellID)].enabled
    if aura and Gladdy.db.buffsShowAuraDebuffs then
        aura = false
    end
    local auraNames = LibClassAuras.GetSpellNameToId(auraType)
    local spellId
    local isTracked = false
    if auraNames[spellName] then
        for _, spellInfo in ipairs(auraNames[spellName]) do
            spellId = spellInfo.id[1]
            if (Gladdy.db.trackedBuffs[tostring(spellId)] or Gladdy.db.trackedDebuffs[tostring(spellId)]) then
                isTracked = true
                break
            end
        end
    end
    if not aura and spellID and expirationTime and isTracked then
        local index
        if auraType == AURA_TYPE_DEBUFF then
            auraFrame.numDebuffs = auraFrame.numDebuffs + 1
            index = auraFrame.numDebuffs
        else
            auraFrame.numBuffs = auraFrame.numBuffs + 1
            index = auraFrame.numBuffs
        end
        BuffsDebuffs:AddOrRefreshAura(unit,spellID, auraType, duration, expirationTime - GetTime(), count, dispelType, texture, index)
    end
end

---------------------------
-- Frame init
---------------------------

function BuffsDebuffs:CreateFrame(unit)
    local debuffFrame = CreateFrame("Frame", "GladdyDebuffs" .. unit, Gladdy.buttons[unit])
    debuffFrame:SetFrameStrata(Gladdy.db.buffFrameStrata)
    debuffFrame:SetFrameLevel(Gladdy.db.buffsFrameLevel)
    debuffFrame:SetMovable(true)
    debuffFrame:SetHeight(Gladdy.db.buffsIconSize)
    debuffFrame:SetWidth(1)
    debuffFrame.unit = unit
    local buffFrame = CreateFrame("Frame", "GladdyBuffs" .. unit, Gladdy.buttons[unit])
    buffFrame:SetFrameStrata(Gladdy.db.buffFrameStrata)
    buffFrame:SetFrameLevel(Gladdy.db.buffsFrameLevel)
    buffFrame:SetMovable(true)
    buffFrame:SetHeight(Gladdy.db.buffsIconSize)
    buffFrame:SetWidth(1)
    buffFrame.unit = unit
    self.frames[unit] = {}
    self.frames[unit].buffFrame = buffFrame
    self.frames[unit].debuffFrame = debuffFrame
    self.frames[unit].auras = {[AURA_TYPE_DEBUFF] = {}, [AURA_TYPE_BUFF] = {}}
end

local function setAuraSize(aura, auraType)
    if auraType == AURA_TYPE_DEBUFF then
        aura:SetWidth(Gladdy.db.buffsIconSize * Gladdy.db.buffsWidthFactor)
        aura:SetHeight(Gladdy.db.buffsIconSize)
        aura:SetAlpha(Gladdy.db.buffsAlpha)
    else
        aura:SetWidth(Gladdy.db.buffsBuffsIconSize * Gladdy.db.buffsBuffsWidthFactor)
        aura:SetHeight(Gladdy.db.buffsBuffsIconSize)
        aura:SetAlpha(Gladdy.db.buffsBuffsAlpha)
    end
    aura.cooldowncircle:SetWidth(aura:GetWidth() - aura:GetWidth()/16)
    aura.cooldowncircle:SetHeight(aura:GetHeight() - aura:GetHeight()/16)
    aura.cooldowncircle:ClearAllPoints()
    aura.cooldowncircle:SetPoint("CENTER", aura, "CENTER")
end

local function styleIcon(aura, auraType)
    setAuraSize(aura, auraType)
    if (Gladdy.db.buffsDisableCircle) then
        aura.cooldowncircle:SetAlpha(0)
    else
        aura.cooldowncircle:SetAlpha(Gladdy.db.buffsCooldownAlpha)
    end

    local zoomedOption, testAgain
    if auraType == AURA_TYPE_BUFF then
        zoomedOption = Gladdy.db.buffsBuffsIconZoomed
    else
        zoomedOption = Gladdy.db.buffsIconZoomed
    end

    if zoomedOption then
        if aura.texture.masked then
            aura.texture:SetMask(nil)
            aura.texture:SetTexCoord(0.1,0.9,0.1,0.9)
            aura.texture.masked = nil
        end
    else
        if not aura.texture.masked then
            aura.texture:SetMask(nil)
            aura.texture:SetTexCoord(0,1,0,1)
            aura.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
            aura.texture.masked = true
            if Gladdy.frame.testing then
                testAgain = true
            end
        end
    end

    aura:SetFrameStrata(Gladdy.db.buffFrameStrata)
    aura:SetFrameLevel(Gladdy.db.buffsFrameLevel)
    aura.cooldowncircle:SetFrameLevel(Gladdy.db.buffsFrameLevel + 1)
    aura.overlay:SetFrameLevel(Gladdy.db.buffsFrameLevel + 2)

    aura.border:SetTexture(Gladdy.db.buffsBorderStyle)
    aura.border:SetVertexColor(dispelTypeToOptionValue(aura.dispelType))
    aura.cooldown:SetFont(Gladdy:SMFetch("font", "buffsFont"), (Gladdy.db.buffsIconSize/2 - 1) * Gladdy.db.buffsFontScale, "OUTLINE")
    aura.cooldown:SetTextColor(Gladdy.db.buffsFontColor.r, Gladdy.db.buffsFontColor.g, Gladdy.db.buffsFontColor.b, Gladdy.db.buffsFontColor.a)
    aura.stacks:SetFont(Gladdy:SMFetch("font", "buffsFont"), (Gladdy.db.buffsIconSize/3 - 1) * Gladdy.db.buffsFontScale, "OUTLINE")
    aura.stacks:SetTextColor(Gladdy.db.buffsFontColor.r, Gladdy.db.buffsFontColor.g, Gladdy.db.buffsFontColor.b, 1)

    return testAgain
end

function BuffsDebuffs:UpdateFrameOnce()
    if Gladdy.db.buffsEnabled then
        self:RegisterMessages(
                "JOINED_ARENA",
                "UNIT_DESTROYED",
                "UNIT_DEATH",
                "AURA_FADE",
                "AURA_GAIN",
                "AURA_GAIN_LIMIT")
        self:SetScript("OnEvent", BuffsDebuffs.OnEvent)
    else
        self:UnregisterAllMessages()
        self:SetScript("OnEvent", nil)
    end
end

function BuffsDebuffs:UpdateFrame(unit)
    --DEBUFFS
    self.frames[unit].debuffFrame:SetHeight(Gladdy.db.buffsIconSize)
    Gladdy:SetPosition(self.frames[unit].debuffFrame, unit, "buffsXOffset", "buffsYOffset", BuffsDebuffs:LegacySetPositionDebuffs(unit), BuffsDebuffs)
    if (unit == "arena1") then
        Gladdy:CreateMover(self.frames[unit].debuffFrame, "buffsXOffset", "buffsYOffset", L["Debuffs"],
                {"TOPRIGHT", "TOPRIGHT"},
                Gladdy.db.buffsIconSize * Gladdy.db.buffsWidthFactor, Gladdy.db.buffsIconSize,
                0, 0, "buffsEnabled")
    end

    --BUFFS
    self.frames[unit].buffFrame:SetHeight(Gladdy.db.buffsBuffsIconSize)
    Gladdy:SetPosition(self.frames[unit].buffFrame, unit, "buffsBuffsXOffset", "buffsBuffsYOffset", BuffsDebuffs:LegacySetPositionBuffs(unit), BuffsDebuffs)
    if (unit == "arena1") then
        Gladdy:CreateMover(self.frames[unit].buffFrame, "buffsBuffsXOffset", "buffsBuffsYOffset", L["Buffs"],
                {"TOPRIGHT", "TOPRIGHT"},
                Gladdy.db.buffsBuffsIconSize * Gladdy.db.buffsBuffsWidthFactor, Gladdy.db.buffsBuffsIconSize,
                0, 0, "buffsEnabled")
    end

    local testBuffsAgain, testDebuffsAgain

    for i=1, #self.frames[unit].auras[AURA_TYPE_BUFF] do
        testBuffsAgain = styleIcon(self.frames[unit].auras[AURA_TYPE_BUFF][i], AURA_TYPE_BUFF)
    end
    for i=1, #self.frames[unit].auras[AURA_TYPE_DEBUFF] do
        testDebuffsAgain = styleIcon(self.frames[unit].auras[AURA_TYPE_DEBUFF][i], AURA_TYPE_DEBUFF)
    end
    for i=1, #self.framePool do
        styleIcon(self.framePool[i])
    end
    self:UpdateAurasOnUnit(unit)

    if Gladdy.frame.testing and (testBuffsAgain or testDebuffsAgain) then
        self:ResetUnit(unit)
        self:Test(unit)
    end
end

---------------------------
-- Frame handlers
---------------------------

function BuffsDebuffs:UpdateAurasOnUnit(unit)
    for i=1, #self.frames[unit].auras[AURA_TYPE_BUFF] do
        if i == 1 then
            self.frames[unit].auras[AURA_TYPE_BUFF][i]:ClearAllPoints()
            self.frames[unit].auras[AURA_TYPE_BUFF][i]:SetPoint("RIGHT", self.frames[unit].buffFrame, "LEFT")
        else
            if Gladdy.db.buffsBuffsCooldownGrowDirection == "LEFT" then
                self.frames[unit].auras[AURA_TYPE_BUFF][i]:ClearAllPoints()
                self.frames[unit].auras[AURA_TYPE_BUFF][i]:SetPoint("RIGHT", self.frames[unit].auras[AURA_TYPE_BUFF][i - 1], "LEFT", -Gladdy.db.buffsBuffsIconPadding, 0)
            else
                self.frames[unit].auras[AURA_TYPE_BUFF][i]:ClearAllPoints()
                self.frames[unit].auras[AURA_TYPE_BUFF][i]:SetPoint("LEFT", self.frames[unit].auras[AURA_TYPE_BUFF][i - 1], "RIGHT", Gladdy.db.buffsBuffsIconPadding, 0)
            end
        end
    end
    for i=1, #self.frames[unit].auras[AURA_TYPE_DEBUFF] do
        if i == 1 then
            self.frames[unit].auras[AURA_TYPE_DEBUFF][i]:ClearAllPoints()
            self.frames[unit].auras[AURA_TYPE_DEBUFF][i]:SetPoint("RIGHT", self.frames[unit].debuffFrame, "LEFT")
        else
            if Gladdy.db.buffsCooldownGrowDirection == "LEFT" then
                self.frames[unit].auras[AURA_TYPE_DEBUFF][i]:ClearAllPoints()
                self.frames[unit].auras[AURA_TYPE_DEBUFF][i]:SetPoint("RIGHT", self.frames[unit].auras[AURA_TYPE_DEBUFF][i - 1], "LEFT", -Gladdy.db.buffsIconPadding, 0)
            else
                self.frames[unit].auras[AURA_TYPE_DEBUFF][i]:ClearAllPoints()
                self.frames[unit].auras[AURA_TYPE_DEBUFF][i]:SetPoint("LEFT", self.frames[unit].auras[AURA_TYPE_DEBUFF][i - 1], "RIGHT", Gladdy.db.buffsIconPadding, 0)
            end
        end
    end
end

local function iconTimer(auraFrame, elapsed)
    if auraFrame.endtime ~= "undefined" then
        local timeLeftMilliSec = auraFrame.endtime - GetTime()
        local timeLeftSec = ceil(timeLeftMilliSec)
        auraFrame.timeLeft = timeLeftMilliSec
        if Gladdy.db.buffsDynamicColor then
            if timeLeftSec >= 60 then
                auraFrame.cooldown:SetTextColor(0.7, 1, 0, Gladdy.db.buffsFontColor.a)
            elseif timeLeftSec < 60 and timeLeftSec >= 11 then
                auraFrame.cooldown:SetTextColor(0.7, 1, 0, Gladdy.db.buffsFontColor.a)
            elseif timeLeftSec <= 10 and timeLeftSec >= 5 then
                auraFrame.cooldown:SetTextColor(1, 0.7, 0, Gladdy.db.buffsFontColor.a)
            elseif timeLeftSec <= 4 and timeLeftSec >= 3 then
                auraFrame.cooldown:SetTextColor(1, 0, 0, Gladdy.db.buffsFontColor.a)
            elseif timeLeftMilliSec <= 3 and timeLeftMilliSec > 0 then
                auraFrame.cooldown:SetTextColor(1, 0, 0, Gladdy.db.buffsFontColor.a)
            end
        end
        if timeLeftMilliSec < 0 then
            auraFrame:Hide()
        end
        Gladdy:FormatTimer(auraFrame.cooldown, timeLeftMilliSec, timeLeftMilliSec <= 3)
    else
        auraFrame.cooldown:SetText("")
    end
end

function BuffsDebuffs:AddAura(unit, spellID, auraType, duration, timeLeft, stacks, dispelType, icon, index)
    local aura
    if not self.frames[unit].auras[auraType][index] then
        if #self.framePool > 0 then
            aura = tremove(self.framePool, #self.framePool)
            styleIcon(aura)
        else
            aura = CreateFrame("Frame")
            aura:EnableMouse(false)
            aura:SetFrameStrata(Gladdy.db.buffFrameStrata)
            aura:SetFrameLevel(Gladdy.db.buffsFrameLevel)
            aura.texture = aura:CreateTexture(nil, "BACKGROUND")
            aura.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
            aura.texture.masked = true
            aura.texture:SetAllPoints(aura)
            aura.cooldowncircle = CreateFrame("Cooldown", nil, aura, "CooldownFrameTemplate")
            aura.cooldowncircle:SetFrameLevel(Gladdy.db.buffsFrameLevel + 1)
            aura.cooldowncircle.noCooldownCount = true -- disable OmniCC
            aura.cooldowncircle:SetAllPoints(aura)
            aura.cooldowncircle:SetReverse(true)
            aura.cooldowncircle:SetHideCountdownNumbers(true)
            aura.overlay = CreateFrame("Frame", nil, aura)
            aura.overlay:SetFrameLevel(Gladdy.db.buffsFrameLevel + 2)
            aura.overlay:SetAllPoints(aura)
            aura.border = aura.overlay:CreateTexture(nil, "OVERLAY")
            aura.border:SetAllPoints(aura)
            aura.cooldown = aura.overlay:CreateFontString(nil, "OVERLAY")
            aura.cooldown:SetAllPoints(aura)
            aura.stacks = aura.overlay:CreateFontString(nil, "OVERLAY")
            aura.stacks:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 0, 3)
            styleIcon(aura)
            aura:SetScript("OnUpdate", iconTimer)
        end
        self.frames[unit].auras[auraType][index] = aura
        self:UpdateAurasOnUnit(unit)
        aura:SetParent(auraType == AURA_TYPE_DEBUFF and self.frames[unit].debuffFrame or self.frames[unit].buffFrame)
    else
        aura = self.frames[unit].auras[auraType][index]
    end

    setAuraSize(aura, auraType)
    aura.stacks:SetText(stacks > 1 and stacks or "")
    aura.texture:SetTexture(icon)
    aura.startTime = GetTime() - (duration - timeLeft)
    if duration == 0 then
        aura.endtime = "undefined"
        aura.cooldowncircle:Hide()
    else
        aura.endtime = GetTime() + timeLeft
        aura.cooldowncircle:SetCooldown(GetTime() - (duration - timeLeft), duration)
        aura.cooldowncircle:Show()
    end
    aura.spellID = spellID
    aura.type = auraType
    aura.unit = unit
    aura.dispelType = dispelType
    aura.border:SetVertexColor(dispelTypeToOptionValue(dispelType))
    aura:Show()
end

function BuffsDebuffs:AddOrRefreshAura(unit, spellID, auraType, duration, timeLeft, stacks, dispelType, icon, index)
    if self.frames[unit].auras[auraType][index] and self.frames[unit].auras[auraType][index].spellID == spellID then -- refresh
        if duration == 0 then
            self.frames[unit].auras[auraType][index].endtime = "undefined"
            self.frames[unit].auras[auraType][index].cooldowncircle:Hide()
        else
            self.frames[unit].auras[auraType][index].endtime = GetTime() + timeLeft
            self.frames[unit].auras[auraType][index].cooldowncircle:SetCooldown(GetTime() - (duration - timeLeft), duration)
            self.frames[unit].auras[auraType][index].cooldowncircle:Show()
        end
        self.frames[unit].auras[auraType][index].stacks:SetText(stacks > 1 and stacks or "")
        self.frames[unit].auras[auraType][index]:Show()
        self:UpdateAurasOnUnit(unit)
        return
    end
    --add
    self:AddAura(unit, spellID, auraType, duration, timeLeft, stacks, dispelType, icon, index)
    self:UpdateAurasOnUnit(unit)
end

------------
-- OPTIONS
------------

function BuffsDebuffs:GetOptions()
    return {
        headerBuffs = {
            type = "header",
            name = L["Buffs and Debuffs"],
            order = 2,
        },
        buffsEnabled = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["Enabled Buffs and Debuffs module"],
            order = 3,
        }),
        buffsShowAuraDebuffs = Gladdy:option({
            type = "toggle",
            name = L["Show CC"],
            desc = L["Shows all debuffs, which are displayed on the ClassIcon as well"],
            order = 4,
            disabled = function() return not Gladdy.db.buffsEnabled end,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 5,
            disabled = function() return not Gladdy.db.buffsEnabled end,
            args = {
                buffs = {
                    type = "group",
                    name = L["Buffs"],
                    order = 1,
                    args = {
                        size = {
                            type = "group",
                            name = L["Icon"],
                            order = 1,
                            args = {
                                header = {
                                    type = "header",
                                    name = L["Icon"],
                                    order = 1,
                                },
                                buffsBuffsIconZoomed = Gladdy:option({
                                    type = "toggle",
                                    name = L["Zoomed Icon"],
                                    desc = L["Zoomes the icon to remove borders"],
                                    order = 2,
                                    width = "full",
                                }),
                                buffsBuffsIconSize = Gladdy:option({
                                    type = "range",
                                    name = L["Icon Size"],
                                    desc = L["Size of the DR Icons"],
                                    order = 6,
                                    min = 5,
                                    max = 50,
                                    step = 1,
                                    width = "full",
                                }),
                                buffsBuffsWidthFactor = Gladdy:option({
                                    type = "range",
                                    name = L["Icon Width Factor"],
                                    desc = L["Stretches the icon"],
                                    order = 7,
                                    min = 0.5,
                                    max = 2,
                                    step = 0.05,
                                    width = "full",
                                }),
                                buffsBuffsIconPadding = Gladdy:option({
                                    type = "range",
                                    name = L["Icon Padding"],
                                    desc = L["Space between Icons"],
                                    order = 8,
                                    min = 0,
                                    max = 10,
                                    step = 0.1,
                                    width = "full",
                                }),
                            },
                        },
                        position = {
                            type = "group",
                            name = L["Position"],
                            order = 3,
                            args = {
                                header = {
                                    type = "header",
                                    name = L["Position"],
                                    order = 5,
                                },
                                buffsBuffsCooldownGrowDirection = Gladdy:option({
                                    type = "select",
                                    name = L["Grow Direction"],
                                    desc = L["Grow Direction of the aura icons"],
                                    order = 21,
                                    values = {
                                        ["LEFT"] = L["Left"],
                                        ["RIGHT"] = L["Right"],
                                    },
                                }),
                                buffsBuffsXOffset = Gladdy:option({
                                    type = "range",
                                    name = L["Horizontal offset"],
                                    order = 22,
                                    min = -400,
                                    max = 400,
                                    step = 0.1,
                                    width = "full",
                                }),
                                buffsBuffsYOffset = Gladdy:option({
                                    type = "range",
                                    name = L["Vertical offset"],
                                    order = 23,
                                    min = -400,
                                    max = 400,
                                    step = 0.1,
                                    width = "full",
                                }),
                            },
                        },
                        alpha = {
                            type = "group",
                            name = L["Alpha"],
                            order = 2,
                            args = {
                                header = {
                                    type = "header",
                                    name = L["Alpha"],
                                    order = 1,
                                },
                                buffsBuffsAlpha =  Gladdy:option({
                                    type = "range",
                                    name = L["Alpha"],
                                    order = 2,
                                    min = 0,
                                    max = 1,
                                    step = 0.05,
                                    width = "full",
                                }),
                            }
                        }
                    }
                },
                debuffs = {
                    type = "group",
                    name = L["Debuffs"],
                    order = 2,
                    args = {
                        size = {
                            type = "group",
                            name = L["Icon"],
                            order = 1,
                            args = {
                                header = {
                                    type = "header",
                                    name = L["Icon"],
                                    order = 1,
                                },
                                buffsIconZoomed = Gladdy:option({
                                    type = "toggle",
                                    name = L["Zoomed Icon"],
                                    desc = L["Zoomes the icon to remove borders"],
                                    order = 2,
                                    width = "full",
                                }),
                                buffsIconSize = Gladdy:option({
                                    type = "range",
                                    name = L["Icon Size"],
                                    desc = L["Size of the DR Icons"],
                                    order = 6,
                                    min = 5,
                                    max = 50,
                                    step = 1,
                                    width = "full",
                                }),
                                buffsWidthFactor = Gladdy:option({
                                    type = "range",
                                    name = L["Icon Width Factor"],
                                    desc = L["Stretches the icon"],
                                    order = 7,
                                    min = 0.5,
                                    max = 2,
                                    step = 0.05,
                                    width = "full",
                                }),
                                buffsIconPadding = Gladdy:option({
                                    type = "range",
                                    name = L["Icon Padding"],
                                    desc = L["Space between Icons"],
                                    order = 8,
                                    min = 0,
                                    max = 10,
                                    step = 0.1,
                                    width = "full",
                                }),
                            },
                        },
                        position = {
                            type = "group",
                            name = L["Position"],
                            order = 3,
                            args = {
                                header = {
                                    type = "header",
                                    name = L["Position"],
                                    order = 5,
                                },
                                buffsCooldownGrowDirection = Gladdy:option({
                                    type = "select",
                                    name = L["Grow Direction"],
                                    desc = L["Grow Direction of the aura icons"],
                                    order = 21,
                                    values = {
                                        ["LEFT"] = L["Left"],
                                        ["RIGHT"] = L["Right"],
                                    },
                                }),
                                buffsXOffset = Gladdy:option({
                                    type = "range",
                                    name = L["Horizontal offset"],
                                    order = 22,
                                    min = -400,
                                    max = 400,
                                    step = 0.1,
                                    width = "full",
                                }),
                                buffsYOffset = Gladdy:option({
                                    type = "range",
                                    name = L["Vertical offset"],
                                    order = 23,
                                    min = -400,
                                    max = 400,
                                    step = 0.1,
                                    width = "full",
                                }),
                            },
                        },
                        alpha = {
                            type = "group",
                            name = L["Alpha"],
                            order = 2,
                            args = {
                                header = {
                                    type = "header",
                                    name = L["Alpha"],
                                    order = 1,
                                },
                                buffsAlpha =  Gladdy:option({
                                    type = "range",
                                    name = L["Alpha"],
                                    order = 2,
                                    min = 0,
                                    max = 1,
                                    step = 0.05,
                                    width = "full",
                                }),
                            }
                        }
                    },
                },
                cooldown = {
                    type = "group",
                    name = L["Cooldown"],
                    order = 3,
                    args = {
                        header = {
                            type = "header",
                            name = L["Cooldown"],
                            order = 5,
                        },
                        buffsDisableCircle = Gladdy:option({
                            type = "toggle",
                            name = L["No Cooldown Circle"],
                            order = 9,
                            width = "full",
                        }),
                        buffsCooldownAlpha = Gladdy:option({
                            type = "range",
                            name = L["Cooldown circle alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 10,
                            width = "full",
                        }),
                        buffsCooldownNumberAlpha = {
                            type = "range",
                            name = L["Cooldown number alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 11,
                            width = "full",
                            set = function(info, value)
                                Gladdy.db.buffsFontColor.a = value
                                Gladdy:UpdateFrame()
                            end,
                            get = function(info)
                                return Gladdy.db.buffsFontColor.a
                            end,
                        },
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
                            order = 5,
                        },
                        buffsFont = Gladdy:option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the cooldown"],
                            order = 12,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        buffsFontScale = Gladdy:option({
                            type = "range",
                            name = L["Font scale"],
                            desc = L["Scale of the text"],
                            order = 13,
                            min = 0.1,
                            max = 2,
                            step = 0.1,
                            width = "full",
                        }),
                        buffsDynamicColor = Gladdy:option({
                            type = "toggle",
                            name = L["Dynamic Timer Color"],
                            desc = L["Show dynamic color on cooldown numbers"],
                            order = 14,
                        }),
                        buffsFontColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Font color"],
                            desc = L["Color of the cooldown timer and stacks"],
                            order = 15,
                            hasAlpha = true,
                        }),
                    },
                },
                border = {
                    type = "group",
                    name = L["Border"],
                    order = 5,
                    args = {
                        header = {
                            type = "header",
                            name = L["Border"],
                            order = 5,
                        },
                        buffsBorderStyle = Gladdy:option({
                            type = "select",
                            name = L["Border style"],
                            order = 31,
                            values = Gladdy:GetIconStyles()
                        }),
                        headerBorder = {
                            type = "header",
                            name = L["Spell School Colors"],
                            order = 40,
                        },
                        buffsBorderColorsEnabled = Gladdy:option({
                            type = "toggle",
                            name = L["Spell School Colors Enabled"],
                            desc = L["Show border colors by spell school"],
                            order = 41,
                            width = "full",
                        }),
                        buffsBorderColorCurse = Gladdy:colorOption({
                            type = "color",
                            name = L["Curse"],
                            desc = L["Color of the border"],
                            order = 42,
                            hasAlpha = true,
                        }),
                        buffsBorderColorMagic = Gladdy:colorOption({
                            type = "color",
                            name = L["Magic"],
                            desc = L["Color of the border"],
                            order = 43,
                            hasAlpha = true,
                        }),
                        buffsBorderColorPoison = Gladdy:colorOption({
                            type = "color",
                            name = L["Poison"],
                            desc = L["Color of the border"],
                            order = 44,
                            hasAlpha = true,
                        }),
                        buffsBorderColorPhysical = Gladdy:colorOption({
                            type = "color",
                            name = L["Physical"],
                            desc = L["Color of the border"],
                            order = 45,
                            hasAlpha = true,
                        }),
                        buffsBorderColorImmune = Gladdy:colorOption({
                            type = "color",
                            name = L["Immune"],
                            desc = L["Color of the border"],
                            order = 46,
                            hasAlpha = true,
                        }),
                        buffsBorderColorDisease = Gladdy:colorOption({
                            type = "color",
                            name = L["Disease"],
                            desc = L["Color of the border"],
                            order = 47,
                            hasAlpha = true,
                        }),
                        buffsBorderColorAura = Gladdy:colorOption({
                            type = "color",
                            name = L["Aura"],
                            desc = L["Color of the border"],
                            order = 48,
                            hasAlpha = true,
                        }),
                        buffsBorderColorForm = Gladdy:colorOption({
                            type = "color",
                            name = L["Form"],
                            desc = L["Color of the border"],
                            order = 49,
                            hasAlpha = true,
                        }),
                        buffsBorderColorEnrage = Gladdy:colorOption({
                            type = "color",
                            name = L["Enrage"],
                            desc = L["Color of the border"],
                            order = 50,
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
                        buffFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        buffsFrameLevel = Gladdy:option({
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
        debuffList = {
            name = L["Debuff Lists"],
            type = "group",
            order = 11,
            disabled = function() return not Gladdy.db.buffsEnabled end,
            childGroups = "tree",
            args = select(1, Gladdy:GetAuras(AURA_TYPE_DEBUFF)),
            set = function(info, state)
                local optionKey = info[#info]
                Gladdy.dbi.profile.trackedDebuffs[optionKey] = state
            end,
            get = function(info)
                local optionKey = info[#info]
                return Gladdy.dbi.profile.trackedDebuffs[optionKey]
            end,
        },
        buffList = {
            name = L["Buff Lists"],
            type = "group",
            order = 12,
            disabled = function() return not Gladdy.db.buffsEnabled end,
            childGroups = "tree",
            args = select(1, Gladdy:GetAuras(AURA_TYPE_BUFF)),
            set = function(info, state)
                local optionKey = info[#info]
                Gladdy.dbi.profile.trackedBuffs[optionKey] = state
            end,
            get = function(info)
                local optionKey = info[#info]
                return Gladdy.dbi.profile.trackedBuffs[optionKey]
            end,
        },
    }
end

---------------------------

-- LAGACY HANDLER

---------------------------

function BuffsDebuffs:LegacySetPositionDebuffs(unit)
    if Gladdy.db.newLayout then
        return Gladdy.db.newLayout
    end
    self.frames[unit].debuffFrame:ClearAllPoints()
    local powerBarHeight = Gladdy.db.powerBarEnabled and (Gladdy.db.powerBarHeight + 1) or 0
    local horizontalMargin = (Gladdy.db.highlightInset and 0 or Gladdy.db.highlightBorderSize)
    local verticalMargin = -(Gladdy.db.powerBarHeight)/2
    local offset = 0
    if (Gladdy.db.buffsCooldownGrowDirection == "RIGHT") then
        offset = Gladdy.db.buffsIconSize * Gladdy.db.buffsWidthFactor
    end
    local pos = Gladdy.db.buffsCooldownPos

    if pos == "TOP" then
        verticalMargin = horizontalMargin + 1
        if Gladdy.db.cooldownYPos == "TOP" and Gladdy.db.cooldown then
            verticalMargin = verticalMargin + Gladdy.db.cooldownSize
        end
        if Gladdy.db.buffsCooldownGrowDirection == "LEFT" then
            self.frames[unit].debuffFrame:SetPoint("BOTTOMLEFT", Gladdy.buttons[unit].healthBar, "TOPRIGHT", Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsYOffset + verticalMargin)
        else
            self.frames[unit].debuffFrame:SetPoint("BOTTOMRIGHT", Gladdy.buttons[unit].healthBar, "TOPLEFT", Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsYOffset + verticalMargin)
        end
    elseif pos == "BOTTOM" then
        verticalMargin = horizontalMargin + 1
        if Gladdy.db.cooldownYPos == "BOTTOM" and Gladdy.db.cooldown then
            verticalMargin = verticalMargin + Gladdy.db.cooldownSize
        end
        if Gladdy.db.buffsCooldownGrowDirection == "LEFT" then
            self.frames[unit].debuffFrame:SetPoint("TOPLEFT", Gladdy.buttons[unit].healthBar, "BOTTOMRIGHT", Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsYOffset -verticalMargin - powerBarHeight)
        else
            self.frames[unit].debuffFrame:SetPoint("TOPRIGHT", Gladdy.buttons[unit].healthBar, "BOTTOMLEFT", Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsYOffset -verticalMargin - powerBarHeight)
        end
    elseif pos == "LEFT" then
        horizontalMargin = horizontalMargin - 1 + Gladdy.db.padding
        local anchor = Gladdy:GetAnchor(unit, "LEFT")
        if anchor == Gladdy.buttons[unit].healthBar then
            self.frames[unit].debuffFrame:SetPoint("RIGHT", anchor, "LEFT", -horizontalMargin + Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsYOffset)
        else
            self.frames[unit].debuffFrame:SetPoint("RIGHT", anchor, "LEFT", -Gladdy.db.padding + Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsYOffset)
        end
    elseif pos == "RIGHT" then
        horizontalMargin = horizontalMargin - 1 + Gladdy.db.padding
        local anchor = Gladdy:GetAnchor(unit, "RIGHT")
        if anchor == Gladdy.buttons[unit].healthBar then
            self.frames[unit].debuffFrame:SetPoint("LEFT", anchor, "RIGHT", horizontalMargin + Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsYOffset)
        else
            self.frames[unit].debuffFrame:SetPoint("LEFT", anchor, "RIGHT", horizontalMargin + Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsYOffset)
        end
    end
    return Gladdy.db.newLayout
end

function BuffsDebuffs:LegacySetPositionBuffs(unit)
    if Gladdy.db.newLayout then
        return Gladdy.db.newLayout
    end
    self.frames[unit].buffFrame:ClearAllPoints()
    local horizontalMargin = (Gladdy.db.highlightInset and 0 or Gladdy.db.highlightBorderSize)
    local verticalMargin = -(Gladdy.db.powerBarHeight)/2
    local powerBarHeight = Gladdy.db.powerBarEnabled and (Gladdy.db.powerBarHeight + 1) or 0
    local offset = 0
    if (Gladdy.db.buffsBuffsCooldownGrowDirection == "RIGHT") then
        offset = Gladdy.db.buffsBuffsIconSize * Gladdy.db.buffsBuffsWidthFactor
    end

    local pos = Gladdy.db.buffsBuffsCooldownPos

    if pos == "TOP" then
        verticalMargin = horizontalMargin + 1
        if Gladdy.db.cooldownYPos == "TOP" and Gladdy.db.cooldown then
            verticalMargin = verticalMargin + Gladdy.db.cooldownSize
        end
        if Gladdy.db.buffsBuffsCooldownGrowDirection == "LEFT" then
            self.frames[unit].buffFrame:SetPoint("BOTTOMLEFT", Gladdy.buttons[unit].healthBar, "TOPRIGHT", Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsBuffsYOffset + verticalMargin)
        else
            self.frames[unit].buffFrame:SetPoint("BOTTOMRIGHT", Gladdy.buttons[unit].healthBar, "TOPLEFT", Gladdy.db.buffsXOffset + offset, Gladdy.db.buffsBuffsYOffset + verticalMargin)
        end
    elseif pos == "BOTTOM" then
        verticalMargin = horizontalMargin + 1
        if Gladdy.db.cooldownYPos == "BOTTOM" and Gladdy.db.cooldown then
            verticalMargin = verticalMargin + Gladdy.db.cooldownSize
        end
        if Gladdy.db.buffsBuffsCooldownGrowDirection == "LEFT" then
            self.frames[unit].buffFrame:SetPoint("TOPLEFT", Gladdy.buttons[unit].healthBar, "BOTTOMRIGHT", Gladdy.db.buffsBuffsXOffset + offset, Gladdy.db.buffsBuffsYOffset -verticalMargin - powerBarHeight)
        else
            self.frames[unit].buffFrame:SetPoint("TOPRIGHT", Gladdy.buttons[unit].healthBar, "BOTTOMLEFT", Gladdy.db.buffsBuffsXOffset + offset, Gladdy.db.buffsBuffsYOffset -verticalMargin - powerBarHeight)
        end
    elseif pos == "LEFT" then
        horizontalMargin = horizontalMargin - 1 + Gladdy.db.padding
        if (Gladdy.db.trinketPos == "LEFT" and Gladdy.db.trinketEnabled) then
            horizontalMargin = horizontalMargin + (Gladdy.db.trinketSize * Gladdy.db.trinketWidthFactor) + Gladdy.db.padding
            if (Gladdy.db.classIconPos == "LEFT") then
                horizontalMargin = horizontalMargin + (Gladdy.db.classIconSize * Gladdy.db.classIconWidthFactor) + Gladdy.db.padding
            end
        elseif (Gladdy.db.classIconPos == "LEFT") then
            horizontalMargin = horizontalMargin + (Gladdy.db.classIconSize * Gladdy.db.classIconWidthFactor) + Gladdy.db.padding
            if (Gladdy.db.trinketPos == "LEFT" and Gladdy.db.trinketEnabled) then
                horizontalMargin = horizontalMargin + (Gladdy.db.trinketSize * Gladdy.db.trinketWidthFactor) + Gladdy.db.padding
            end
        end
        if (Gladdy.db.drCooldownPos == "LEFT" and Gladdy.db.drEnabled) then
            verticalMargin = verticalMargin + Gladdy.db.drIconSize/2 + Gladdy.db.padding/2
        end
        if (Gladdy.db.castBarPos == "LEFT") then
            verticalMargin = verticalMargin -
                    (((Gladdy.db.castBarHeight < Gladdy.db.castBarIconSize) and Gladdy.db.castBarIconSize
                            or Gladdy.db.castBarHeight)/2 + Gladdy.db.padding/2)
        end
        if (Gladdy.db.cooldownYPos == "LEFT" and Gladdy.db.cooldown) then
            verticalMargin = verticalMargin + (Gladdy.db.buffsBuffsIconSize/2 + Gladdy.db.padding/2)
        end
        --self.frames[unit].buffFrame:SetPoint("RIGHT", Gladdy.buttons[unit].healthBar, "LEFT", -horizontalMargin + Gladdy.db.buffsBuffsXOffset, Gladdy.db.buffsBuffsYOffset + verticalMargin)

        local anchor = Gladdy:GetAnchor(unit, "LEFT")
        horizontalMargin = (Gladdy.db.highlightInset and 0 or Gladdy.db.highlightBorderSize) - 1 + Gladdy.db.padding
        if anchor == Gladdy.buttons[unit].healthBar then
            self.frames[unit].buffFrame:SetPoint("RIGHT", anchor, "LEFT", -horizontalMargin + Gladdy.db.buffsBuffsXOffset + offset, Gladdy.db.buffsBuffsYOffset)
        else
            self.frames[unit].buffFrame:SetPoint("RIGHT", anchor, "LEFT", -Gladdy.db.padding + Gladdy.db.buffsBuffsXOffset + offset, Gladdy.db.buffsBuffsYOffset)
        end

    elseif pos == "RIGHT" then
        horizontalMargin = horizontalMargin - 1 + Gladdy.db.padding
        if (Gladdy.db.trinketPos == "RIGHT" and Gladdy.db.trinketEnabled) then
            horizontalMargin = horizontalMargin + (Gladdy.db.trinketSize * Gladdy.db.trinketWidthFactor) + Gladdy.db.padding
            if (Gladdy.db.classIconPos == "RIGHT") then
                horizontalMargin = horizontalMargin + (Gladdy.db.classIconSize * Gladdy.db.classIconWidthFactor) + Gladdy.db.padding
            end
        elseif (Gladdy.db.classIconPos == "RIGHT") then
            horizontalMargin = horizontalMargin + (Gladdy.db.classIconSize * Gladdy.db.classIconWidthFactor) + Gladdy.db.padding
            if (Gladdy.db.trinketPos == "RIGHT" and Gladdy.db.trinketEnabled) then
                horizontalMargin = horizontalMargin + (Gladdy.db.trinketSize * Gladdy.db.trinketWidthFactor) + Gladdy.db.padding
            end
        end
        if (Gladdy.db.drCooldownPos == "RIGHT" and Gladdy.db.drEnabled) then
            verticalMargin = verticalMargin + Gladdy.db.drIconSize/2 + Gladdy.db.padding/2
        end
        if (Gladdy.db.castBarPos == "RIGHT") then
            verticalMargin = verticalMargin -
                    (((Gladdy.db.castBarHeight < Gladdy.db.castBarIconSize) and Gladdy.db.castBarIconSize
                            or Gladdy.db.castBarHeight)/2 + Gladdy.db.padding/2)
        end
        if (Gladdy.db.cooldownYPos == "RIGHT" and Gladdy.db.cooldown) then
            verticalMargin = verticalMargin + (Gladdy.db.buffsBuffsIconSize/2 + Gladdy.db.padding/2)
        end
        --self.frames[unit].buffFrame:SetPoint("LEFT", Gladdy.buttons[unit].healthBar, "RIGHT", horizontalMargin + Gladdy.db.buffsBuffsXOffset, Gladdy.db.buffsBuffsYOffset + verticalMargin)

        local anchor = Gladdy:GetAnchor(unit, "RIGHT")
        horizontalMargin = (Gladdy.db.highlightInset and 0 or Gladdy.db.highlightBorderSize) - 1 + Gladdy.db.padding
        if anchor == Gladdy.buttons[unit].healthBar then
            self.frames[unit].buffFrame:SetPoint("LEFT", anchor, "RIGHT", horizontalMargin + Gladdy.db.buffsBuffsXOffset + offset, Gladdy.db.buffsBuffsYOffset)
        else
            self.frames[unit].buffFrame:SetPoint("LEFT", anchor, "RIGHT", Gladdy.db.padding + Gladdy.db.buffsBuffsXOffset + offset, Gladdy.db.buffsBuffsYOffset)
        end
    end
    return Gladdy.db.newLayout
end