local type, pairs, ipairs, ceil, tonumber, mod, tostring, upper, select, tinsert, tremove = type, pairs, ipairs, ceil, tonumber, mod, tostring, string.upper, select, tinsert, tremove
local tbl_sort = table.sort
local C_Timer = C_Timer
local GetTime = GetTime
local CreateFrame = CreateFrame
local GetSpellInfo = GetSpellInfo
local AURA_TYPE_BUFF = AURA_TYPE_BUFF

local Gladdy = LibStub("Gladdy")
local LCG = LibStub("LibCustomGlow-1.0")
local L = Gladdy.L

local function tableLength(tbl)
    local getN = 0
    for n in pairs(tbl) do
        getN = getN + 1
    end
    return getN
end

local function getDefaultCooldown()
    local cooldowns = {}
    local cooldownsOrder = {}
    for class,spellTable in pairs(Gladdy:GetCooldownList()) do
        if not spellTable.class and not cooldownsOrder[class] then
            cooldownsOrder[class] = {}
        end
        for spellId,val in pairs(spellTable) do
            local spellName = GetSpellInfo(spellId)
            if spellName then
                cooldowns[tostring(spellId)] = true
                if type(val) == "table" and val.class then
                    if val.class and not cooldownsOrder[val.class] then
                        cooldownsOrder[val.class] = {}
                    end
                    if not cooldownsOrder[val.class][tostring(spellId)] then
                        cooldownsOrder[val.class][tostring(spellId)] = tableLength(cooldownsOrder[val.class]) + 1
                    end
                else
                    if not cooldownsOrder[class][tostring(spellId)] then
                        cooldownsOrder[class][tostring(spellId)] = tableLength(cooldownsOrder[class]) + 1
                    end
                end
            else
                Gladdy:Debug("ERROR", "spellid does not exist  " .. spellId)
            end
        end
    end
    return cooldowns, cooldownsOrder
end

local Cooldowns = Gladdy:NewModule("Cooldowns", nil, {
    cooldownFont = "DorisPP",
    cooldownFontScale = 1,
    cooldownFontColor = { r = 1, g = 1, b = 0, a = 1 },
    cooldown = true,
    cooldownYGrowDirection = "UP",
    cooldownXGrowDirection = "RIGHT",
    cooldownYOffset = 0,
    cooldownXOffset = 0,
    cooldownSize = 30,
    cooldownIconGlow = true,
    cooldownIconGlowColor = {r = 0.95, g = 0.95, b = 0.32, a = 1},
    cooldownIconZoomed = false,
    cooldownIconDesaturateOnCooldown = false,
    cooldownIconAlphaOnCooldown = 1,
    cooldownWidthFactor = 1,
    cooldownIconPadding = 1,
    cooldownMaxIconsPerLine = 10,
    cooldownBorderStyle = "Interface\\AddOns\\Gladdy\\Images\\Border_Gloss",
    cooldownBorderColor = { r = 1, g = 1, b = 1, a = 1 },
    cooldownDisableCircle = false,
    cooldownCooldownAlpha = 1,
    cooldownCooldowns = getDefaultCooldown(),
    cooldownCooldownsOrder = select(2, getDefaultCooldown()),
    cooldownFrameStrata = "MEDIUM",
    cooldownFrameLevel = 3,
    cooldownGroup = false,
    cooldownGroupDirection = "DOWN"
})

function Cooldowns:Initialize()
    self.frames = {}
    self.cooldownSpellIds = {}
    self.spellTextures = {}
    self.iconCache = {}
    for _,spellTable in pairs(Gladdy:GetCooldownList()) do
        for spellId,val in pairs(spellTable) do
            local spellName, _, texture = GetSpellInfo(spellId)
            if type(val) == "table" then
                if val.icon then
                    texture = val.icon
                end
                if val.altName then
                    spellName = val.altName
                end
            end
            if spellName then
                self.cooldownSpellIds[spellName] = spellId
                self.spellTextures[spellId] = texture
            else
                Gladdy:Debug("ERROR", "spellid does not exist  " .. spellId)
            end
        end
    end
    self:RegisterMessage("ENEMY_SPOTTED")
    self:RegisterMessage("UNIT_SPEC")
    self:RegisterMessage("UNIT_DEATH")
    self:RegisterMessage("UNIT_DESTROYED")
    self:RegisterMessage("AURA_GAIN")
end

---------------------
-- Frame
---------------------

function Cooldowns:CreateFrame(unit)
    local button = Gladdy.buttons[unit]
    local spellCooldownFrame = CreateFrame("Frame", nil, button)
    spellCooldownFrame:EnableMouse(false)
    spellCooldownFrame:SetMovable(true)
    spellCooldownFrame:SetFrameStrata(Gladdy.db.cooldownFrameStrata)
    spellCooldownFrame:SetFrameLevel(Gladdy.db.cooldownFrameLevel)
    spellCooldownFrame.icons = {}
    button.spellCooldownFrame = spellCooldownFrame
    self.frames[unit] = spellCooldownFrame
end

function Cooldowns:CreateIcon()
    local icon
    if (#self.iconCache > 0) then
        icon = tremove(self.iconCache, #self.iconCache)
    else
        icon = CreateFrame("Frame")
        icon:EnableMouse(false)

        icon.texture = icon:CreateTexture(nil, "BACKGROUND")
        icon.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
        icon.texture.masked = true
        icon.texture:SetAllPoints(icon)

        icon.cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
        icon.cooldown.noCooldownCount = true
        icon.cooldown:SetReverse(false)
        icon.cooldown:SetHideCountdownNumbers(true)

        icon.cooldownFrame = CreateFrame("Frame", nil, icon)
        icon.cooldownFrame:ClearAllPoints()
        icon.cooldownFrame:SetAllPoints(icon)

        icon.border = icon.cooldownFrame:CreateTexture(nil, "OVERLAY")
        icon.border:SetAllPoints(icon)

        icon.cooldownFont = icon.cooldownFrame:CreateFontString(nil, "OVERLAY")
        icon.cooldownFont:SetAllPoints(icon)

        icon.glow = CreateFrame("Frame", nil, icon)
        icon.glow:SetAllPoints(icon)

        self:UpdateIcon(icon)
    end
    return icon
end

function Cooldowns:UpdateIcon(icon)
    icon:SetFrameStrata(Gladdy.db.cooldownFrameStrata)
    icon:SetFrameLevel(Gladdy.db.cooldownFrameLevel)
    icon.cooldown:SetFrameStrata(Gladdy.db.cooldownFrameStrata)
    icon.cooldown:SetFrameLevel(Gladdy.db.cooldownFrameLevel + 1)
    icon.cooldownFrame:SetFrameStrata(Gladdy.db.cooldownFrameStrata)
    icon.cooldownFrame:SetFrameLevel(Gladdy.db.cooldownFrameLevel + 2)
    icon.glow:SetFrameStrata(Gladdy.db.cooldownFrameStrata)
    icon.glow:SetFrameLevel(Gladdy.db.cooldownFrameLevel + 3)

    icon:SetHeight(Gladdy.db.cooldownSize)
    icon:SetWidth(Gladdy.db.cooldownSize * Gladdy.db.cooldownWidthFactor)
    icon.cooldownFont:SetFont(Gladdy:SMFetch("font", "cooldownFont"), Gladdy.db.cooldownSize / 2 * Gladdy.db.cooldownFontScale, "OUTLINE")
    icon.cooldownFont:SetTextColor(Gladdy:SetColor(Gladdy.db.cooldownFontColor))

    if Gladdy.db.cooldownIconZoomed then
        icon.cooldown:SetWidth(icon:GetWidth())
        icon.cooldown:SetHeight(icon:GetHeight())
    else
        icon.cooldown:SetWidth(icon:GetWidth() - icon:GetWidth()/16)
        icon.cooldown:SetHeight(icon:GetHeight() - icon:GetHeight()/16)
    end
    icon.cooldown:ClearAllPoints()
    icon.cooldown:SetPoint("CENTER", icon, "CENTER")
    icon.cooldown:SetAlpha(Gladdy.db.cooldownCooldownAlpha)

    icon.cooldownFont:SetFont(Gladdy:SMFetch("font", "cooldownFont"), (icon:GetWidth()/2 - 1) * Gladdy.db.cooldownFontScale, "OUTLINE")
    icon.cooldownFont:SetTextColor(Gladdy:SetColor(Gladdy.db.cooldownFontColor))

    icon.border:SetTexture(Gladdy.db.cooldownBorderStyle)
    icon.border:SetVertexColor(Gladdy:SetColor(Gladdy.db.cooldownBorderColor))

    if Gladdy.db.cooldownIconZoomed then
        if icon.texture.masked then
            icon.texture:SetMask(nil)
            icon.texture:SetTexCoord(0.1,0.9,0.1,0.9)
            icon.texture.masked = nil
        end
    else
        if not icon.texture.masked then
            icon.texture:SetMask(nil)
            icon.texture:SetTexCoord(0,1,0,1)
            icon.texture:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
            icon.texture.masked = true
        end
    end
    if Gladdy.db.cooldownIconDesaturateOnCooldown and icon.active then
        icon.texture:SetDesaturated(true)
    else
        icon.texture:SetDesaturated(false)
    end
    if Gladdy.db.cooldownIconAlphaOnCooldown < 1 and icon.active then
        icon.texture:SetAlpha(Gladdy.db.cooldownIconAlphaOnCooldown)
    else
        icon.texture:SetAlpha(1)
    end
    if icon.timer and not icon.timer:IsCancelled() then
        LCG.PixelGlow_Start(icon.glow, Gladdy:ColorAsArray(Gladdy.db.cooldownIconGlowColor), 12, 0.15, nil, 2)
    end
end

function Cooldowns:IconsSetPoint(button)
    local orderedIcons = {}
    for _,icon in pairs(button.spellCooldownFrame.icons) do
        tinsert(orderedIcons, icon)
    end
    tbl_sort(orderedIcons, function(a, b)
        return Gladdy.db.cooldownCooldownsOrder[button.class][tostring(a.spellId)] < Gladdy.db.cooldownCooldownsOrder[button.class][tostring(b.spellId)]
    end)

    for i,icon in ipairs(orderedIcons) do
        icon:SetParent(button.spellCooldownFrame)
        icon:ClearAllPoints()
        if (Gladdy.db.cooldownXGrowDirection == "LEFT") then
            if (i == 1) then
                icon:SetPoint("LEFT", button.spellCooldownFrame, "LEFT", 0, 0)
            elseif (mod(i-1,Gladdy.db.cooldownMaxIconsPerLine) == 0) then
                if (Gladdy.db.cooldownYGrowDirection == "DOWN") then
                    icon:SetPoint("TOP", orderedIcons[i-Gladdy.db.cooldownMaxIconsPerLine], "BOTTOM", 0, -Gladdy.db.cooldownIconPadding)
                else
                    icon:SetPoint("BOTTOM", orderedIcons[i-Gladdy.db.cooldownMaxIconsPerLine], "TOP", 0, Gladdy.db.cooldownIconPadding)
                end
            else
                icon:SetPoint("RIGHT", orderedIcons[i-1], "LEFT", -Gladdy.db.cooldownIconPadding, 0)
            end
        end
        if (Gladdy.db.cooldownXGrowDirection == "RIGHT") then
            if (i == 1) then
                icon:SetPoint("LEFT", button.spellCooldownFrame, "LEFT", 0, 0)
            elseif (mod(i-1,Gladdy.db.cooldownMaxIconsPerLine) == 0) then
                if (Gladdy.db.cooldownYGrowDirection == "DOWN") then
                    icon:SetPoint("TOP", orderedIcons[i-Gladdy.db.cooldownMaxIconsPerLine], "BOTTOM", 0, -Gladdy.db.cooldownIconPadding)
                else
                    icon:SetPoint("BOTTOM", orderedIcons[i-Gladdy.db.cooldownMaxIconsPerLine], "TOP", 0, Gladdy.db.cooldownIconPadding)
                end
            else
                icon:SetPoint("LEFT", orderedIcons[i-1], "RIGHT", Gladdy.db.cooldownIconPadding, 0)
            end
        end
    end
end

function Cooldowns:UpdateFrameOnce()
    for _,icon in ipairs(self.iconCache) do
        Cooldowns:UpdateIcon(icon)
    end
end

function Cooldowns:UpdateFrame(unit)
    local button = Gladdy.buttons[unit]
    local testAgain = false
    if (Gladdy.db.cooldown) then
        button.spellCooldownFrame:SetHeight(Gladdy.db.cooldownSize)
        button.spellCooldownFrame:SetWidth(1)
        button.spellCooldownFrame:SetFrameStrata(Gladdy.db.cooldownFrameStrata)
        button.spellCooldownFrame:SetFrameLevel(Gladdy.db.cooldownFrameLevel)

        Gladdy:SetPosition(button.spellCooldownFrame, unit, "cooldownXOffset", "cooldownYOffset", Cooldowns:LegacySetPosition(button, unit), Cooldowns)

        if (unit == "arena1") then
            Gladdy:CreateMover(button.spellCooldownFrame,"cooldownXOffset", "cooldownYOffset", L["Cooldown"],
                    {"TOPLEFT", "TOPLEFT"},
                    Gladdy.db.cooldownSize * Gladdy.db.cooldownWidthFactor, Gladdy.db.cooldownSize, 0, 0, "cooldown")
        end

        if (Gladdy.db.cooldownGroup) then
            --TODO fix overlapping
            if (unit ~= "arena1") then
                local previousUnit = "arena" .. string.gsub(unit, "arena", "") - 1
                self.frames[unit]:ClearAllPoints()
                self.frames[unit]:SetPoint("TOP", self.frames[previousUnit], "BOTTOM", 0, -Gladdy.db.cooldownIconPadding)
            end
        end

        -- Update each cooldown icon
        for _,icon in pairs(button.spellCooldownFrame.icons) do
            testAgain = icon.texture.masked
            self:UpdateIcon(icon)
            if icon.texture.masked ~= testAgain then
                testAgain = true
            else
                testAgain = false
            end
        end
        self:IconsSetPoint(button)
        button.spellCooldownFrame:Show()
    else
        button.spellCooldownFrame:Hide()
    end
    if testAgain and Gladdy.frame.testing then
        Cooldowns:ResetUnit(unit)
        Cooldowns:ENEMY_SPOTTED(unit)
        Cooldowns:UNIT_SPEC(unit)
        Cooldowns:Test(unit)
    end
end

function Cooldowns:ResetUnit(unit)
    local button = Gladdy.buttons[unit]
    if not button then
        return
    end
    for i=#button.spellCooldownFrame.icons,1,-1 do
        self:ClearIcon(button, i)
    end
end

function Cooldowns:ClearIcon(button, index, spellId, icon)
    if index then
        icon = tremove(button.spellCooldownFrame.icons, index)
    else
        for i=#button.spellCooldownFrame.icons,1,-1 do
            if icon then
                if button.spellCooldownFrame.icons[i] == icon then
                    icon = tremove(button.spellCooldownFrame.icons, index)
                end
            end
            if not icon and spellId then
                if button.spellCooldownFrame.icons[i].spellId == spellId then
                    icon = tremove(button.spellCooldownFrame.icons, index)
                end
            end
        end
    end
    icon:Show()
    LCG.PixelGlow_Stop(icon.glow)
    if icon.timer then
        icon.timer:Cancel()
    end
    icon:ClearAllPoints()
    icon:SetParent(nil)
    icon:Hide()
    icon.spellId = nil
    icon.active = false
    icon.cooldown:Hide()
    icon.cooldownFont:SetText("")
    icon:SetScript("OnUpdate", nil)
    tinsert(self.iconCache, icon)
end

---------------------
-- Test
---------------------

-- /run LibStub("Gladdy").modules["Cooldowns"]:AURA_GAIN(_, AURA_TYPE_BUFF, 22812, "Barkskin", _, 20, _, _, _, _, "arena1", true)
-- /run LibStub("Gladdy").modules["Cooldowns"]:AURA_FADE("arena1", 22812)
function Cooldowns:Test(unit)
    if Gladdy.frame.testing then
        self:UpdateTestCooldowns(unit)
    end
    Cooldowns:AURA_GAIN(_, AURA_TYPE_BUFF, 22812, "Barkskin", _, 20, _, _, _, _, unit, true)
end

function Cooldowns:UpdateTestCooldowns(unit)
    local button = Gladdy.buttons[unit]
    local orderedIcons = {}

    for _,icon in pairs(button.spellCooldownFrame.icons) do
        tinsert(orderedIcons, icon)
    end
    tbl_sort(orderedIcons, function(a, b)
        return Gladdy.db.cooldownCooldownsOrder[button.class][tostring(a.spellId)] < Gladdy.db.cooldownCooldownsOrder[button.class][tostring(b.spellId)]
    end)

    for _,icon in ipairs(orderedIcons) do
        if icon.timer then
            icon.timer:Cancel()
        end
        self:CooldownUsed(unit, button.class, icon.spellId)
    end
end

---------------------
-- Events
---------------------

function Cooldowns:ENEMY_SPOTTED(unit)
    if (not Gladdy.buttons[unit]) then
        return
    end
    self:UpdateCooldowns(Gladdy.buttons[unit])
end

function Cooldowns:UNIT_SPEC(unit)
    if (not Gladdy.buttons[unit]) then
        return
    end
    self:UpdateCooldowns(Gladdy.buttons[unit])
end

function Cooldowns:UNIT_DESTROYED(unit)
    self:ResetUnit(unit)
end

function Cooldowns:AURA_GAIN(_, auraType, spellID, spellName, _, duration, _, _, _, _, unitCaster, test)
    local arenaUnit = test and unitCaster or Gladdy:GetArenaUnit(unitCaster, true)
    if not Gladdy.db.cooldownIconGlow or not arenaUnit or not Gladdy.buttons[arenaUnit] or auraType ~= AURA_TYPE_BUFF or spellID == 26889 then
        return
    end
    local cooldownFrame = Gladdy.buttons[arenaUnit].spellCooldownFrame

    local spellId = Cooldowns.cooldownSpellIds[spellName] -- don't use spellId from combatlog, in case of different spellrank
    if spellID == 16188 or spellID == 17116 then -- Nature's Swiftness (same name for druid and shaman)
        spellId = spellID
    end

    for _,icon in pairs(cooldownFrame.icons) do
        if (icon.spellId == spellId) then
            Gladdy:Debug("INFO", "Cooldowns:AURA_GAIN", "PixelGlow_Start", spellID)
            LCG.PixelGlow_Start(icon.glow, Gladdy:ColorAsArray(Gladdy.db.cooldownIconGlowColor), 12, 0.15, nil, 2)
            if icon.timer then
                icon.timer:Cancel()
            end
            icon.timer = C_Timer.NewTimer(duration, function()
                LCG.PixelGlow_Stop(icon.glow)
                icon.timer:Cancel()
            end)
        end
    end
end

function Cooldowns:AURA_FADE(unit, spellID)
    if not Gladdy.buttons[unit] or Gladdy.buttons[unit].stealthed then
        return
    end
    local cooldownFrame = Gladdy.buttons[unit].spellCooldownFrame
    for _,icon in pairs(cooldownFrame.icons) do
        if (icon.spellId == spellID) then
            Gladdy:Debug("INFO", "Cooldowns:AURA_FADE", "LCG.ButtonGlow_Stop")
            if icon.timer then
                icon.timer:Cancel()
            end
            LCG.PixelGlow_Stop(icon.glow)
        end
    end
end

---------------------
-- Cooldown Start/Ready
---------------------

function Cooldowns:CooldownStart(button, spellId, duration, start)
    if not duration or duration == nil or type(duration) ~= "number" then
        return
    end
    local cooldown = Gladdy:GetCooldownList()[button.class][spellId]
    if type(cooldown) == "table" then
        if (button.spec ~= nil and cooldown[button.spec] ~= nil) then
            cooldown = cooldown[button.spec]
        else
            cooldown = cooldown.cd
        end
    end
    for _,icon in pairs(button.spellCooldownFrame.icons) do
        if (icon.spellId == spellId) then
            if not start and icon.active and icon.timeLeft > cooldown/2 then
                return -- do not trigger cooldown again
            end
            icon.active = true
            icon.timeLeft = start and start - GetTime() + duration or duration
            if (not Gladdy.db.cooldownDisableCircle) then icon.cooldown:SetCooldown(start or GetTime(), duration) end
            if Gladdy.db.cooldownIconDesaturateOnCooldown then
                icon.texture:SetDesaturated(true)
            end
            if Gladdy.db.cooldownIconAlphaOnCooldown < 1 then
                icon.texture:SetAlpha(Gladdy.db.cooldownIconAlphaOnCooldown)
            end
            icon:SetScript("OnUpdate", function(self, elapsed)
                self.timeLeft = self.timeLeft - elapsed
                local timeLeft = ceil(self.timeLeft)
                if timeLeft >= 540 then
                    self.cooldownFont:SetFont(Gladdy:SMFetch("font", "cooldownFont"), Gladdy.db.cooldownSize / 3.1 * Gladdy.db.cooldownFontScale, "OUTLINE")
                elseif timeLeft < 540 and timeLeft >= 60 then
                    self.cooldownFont:SetFont(Gladdy:SMFetch("font", "cooldownFont"), Gladdy.db.cooldownSize / 2.15 * Gladdy.db.cooldownFontScale, "OUTLINE")
                elseif timeLeft < 60 and timeLeft > 0 then
                    self.cooldownFont:SetFont(Gladdy:SMFetch("font", "cooldownFont"), Gladdy.db.cooldownSize / 2.15 * Gladdy.db.cooldownFontScale, "OUTLINE")
                end
                Gladdy:FormatTimer(self.cooldownFont, self.timeLeft, self.timeLeft < 0)
                if (self.timeLeft <= 0) then
                    Cooldowns:CooldownReady(button, spellId, icon)
                end
                if (self.timeLeft <= 0) then
                    Cooldowns:CooldownReady(button, spellId, icon)
                end
            end)
            break
            --C_VoiceChat.SpeakText(2, GetSpellInfo(spellId), 3, 4, 100)
        end
    end
end

local function resetIcon(icon)
    if Gladdy.db.cooldownIconDesaturateOnCooldown then
        icon.texture:SetDesaturated(false)
    end
    if Gladdy.db.cooldownIconAlphaOnCooldown < 1 then
        icon.texture:SetAlpha(1)
    end
    icon.active = false
    icon.cooldown:Hide()
    icon.cooldownFont:SetText("")
    icon:SetScript("OnUpdate", nil)
    if icon.timer then
        icon.timer:Cancel()
    end
    LCG.PixelGlow_Stop(icon.glow)
end

function Cooldowns:CooldownReady(button, spellId, frame)
    if (frame == false) then
        for _,icon in pairs(button.spellCooldownFrame.icons) do
            if (icon.spellId == spellId) then
                resetIcon(icon)
            end
        end
    else
        resetIcon(frame)
    end
end

function Cooldowns:CooldownUsed(unit, unitClass, spellId, expirationTimeInSeconds)
    local button = Gladdy.buttons[unit]
    if not button then
        return
    end

    local cooldown = Gladdy:GetCooldownList()[unitClass][spellId]
    local cd = cooldown
    if (type(cooldown) == "table") then
        -- return if the spec doesn't have a cooldown for this spell
        if (button.spec ~= nil and cooldown.notSpec ~= nil and button.spec == cooldown.notSpec) then
            return
        end

        -- check if we need to reset other cooldowns because of this spell
        if (cooldown.resetCD ~= nil) then
            for spellID,_ in pairs(cooldown.resetCD) do
                self:CooldownReady(button, spellID, false)
            end
        end

        -- check if there is a special cooldown for the units spec
        if (button.spec ~= nil and cooldown[button.spec] ~= nil) then
            cd = cooldown[button.spec]
        else
            cd = cooldown.cd
        end

        -- check if there is a shared cooldown with an other spell
        if (cooldown.sharedCD ~= nil) then
            local sharedCD = cooldown.sharedCD.cd and cooldown.sharedCD.cd or cd

            for spellID,_ in pairs(cooldown.sharedCD) do
                if (spellID ~= "cd") then
                    local skip = false
                    for _,icon in pairs(button.spellCooldownFrame.icons) do
                        if (icon.spellId == spellID and icon.active and icon.timeLeft > sharedCD) then
                            skip = true
                            break
                        end
                    end
                    if not skip then
                        self:CooldownStart(button, spellID, sharedCD)
                    end
                end
            end
        end
    end

    if (Gladdy.db.cooldown) then
        -- start cooldown
        self:CooldownStart(button, spellId, cd, expirationTimeInSeconds and (GetTime() + expirationTimeInSeconds - cd) or nil)
    end

    --[[ announcement
    if (self.db.cooldownAnnounce or self.db.cooldownAnnounceList[spellId] or self.db.cooldownAnnounceList[unitClass]) then
       self:SendAnnouncement(string.format(L["COOLDOWN USED: %s (%s) used %s - %s sec. cooldown"], UnitName(unit), UnitClass(unit), spellName, cd), RAID_CLASS_COLORS[UnitClass(unit)], self.db.cooldownAnnounceList[spellId] and self.db.cooldownAnnounceList[spellId] or self.db.announceType)
    end]]

    --[[ sound file
    if (db.cooldownSoundList[spellId] ~= nil and db.cooldownSoundList[spellId] ~= "disabled") then
       PlaySoundFile(LSM:Fetch(LSM.MediaType.SOUND, db.cooldownSoundList[spellId]))
    end  ]]
end

---------------------
-- Update Cooldowns
---------------------

function Cooldowns:AddCooldown(spellID, value, button)
    -- see if we have shared cooldowns without a cooldown defined
    -- e.g. hunter traps have shared cooldowns, so only display one trap instead all of them
    local sharedCD = false
    if (type(value) == "table" and value.sharedCD ~= nil and value.sharedCD.cd == nil) then
        for spellId, _ in pairs(value.sharedCD) do
            for _,icon in pairs(button.spellCooldownFrame.icons) do
                if (icon.spellId == spellId) then
                    sharedCD = true
                    break
                end
            end
        end
    end
    for _,icon in pairs(button.spellCooldownFrame.icons) do
        if (icon and icon.spellId == spellID) then
            sharedCD = true
            break
        end
    end
    if (not sharedCD) then
        local icon = self:CreateIcon()
        icon:Show()
        icon.spellId = spellID
        icon.texture:SetTexture(self.spellTextures[spellID])
        tinsert(button.spellCooldownFrame.icons, icon)
        self:IconsSetPoint(button)
    end
end

function Cooldowns:UpdateCooldowns(button)
    local class = button.class
    local race = button.race
    local spec = button.spec
    if not class or not race then
        return
    end

    for k, v in pairs(Gladdy:GetCooldownList()[class]) do
        if Gladdy.db.cooldownCooldowns[tostring(k)] then
            if (type(v) ~= "table" or (type(v) == "table" and v.spec == nil)) then
                Cooldowns:AddCooldown(k, v, button)
            end
            if (type(v) == "table" and v.spec ~= nil and v.spec == spec) then
                Cooldowns:AddCooldown(k, v, button)
            end
        end
    end
    for k, v in pairs(Gladdy:GetCooldownList()[race]) do
        if Gladdy.db.cooldownCooldowns[tostring(k)] then
            if (type(v) ~= "table" or (type(v) == "table" and v.spec == nil)) then
                Cooldowns:AddCooldown(k, v, button)
            end
            if (type(v) == "table" and v.spec ~= nil and v.spec == spec) then
                Cooldowns:AddCooldown(k, v, button)
            end
        end
    end
end

---------------------
-- Options
---------------------

function Cooldowns:GetOptions()
    return {
        headerCooldown = {
            type = "header",
            name = L["Cooldown"],
            order = 2,
        },
        cooldown = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["Enabled cooldown module"],
            order = 2,
        }),
        cooldownGroup = Gladdy:option({
            type = "toggle",
            name = L["Group"] .. " " .. L["Cooldown"],
            order = 3,
            disabled = function() return not Gladdy.db.cooldown end,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 3,
            disabled = function() return not Gladdy.db.cooldown end,
            args = {
                icon = {
                    type = "group",
                    name = L["Icon"],
                    order = 1,
                    args = {
                        headerIcon = {
                            type = "header",
                            name = L["Icon"],
                            order = 2,
                        },
                        cooldownIconZoomed = Gladdy:option({
                            type = "toggle",
                            name = L["Zoomed Icon"],
                            desc = L["Zoomes the icon to remove borders"],
                            order = 4,
                            width = "full",
                        }),
                        cooldownSize = Gladdy:option({
                            type = "range",
                            name = L["Cooldown size"],
                            desc = L["Size of each cd icon"],
                            order = 5,
                            min = 5,
                            max = 50,
                            width = "full",
                        }),
                        cooldownWidthFactor = Gladdy:option({
                            type = "range",
                            name = L["Icon Width Factor"],
                            desc = L["Stretches the icon"],
                            order = 6,
                            min = 0.5,
                            max = 2,
                            step = 0.05,
                            width = "full",
                        }),
                        cooldownIconPadding = Gladdy:option({
                            type = "range",
                            name = L["Icon Padding"],
                            desc = L["Space between Icons"],
                            order = 7,
                            min = 0,
                            max = 10,
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
                            name = L["Cooldown"],
                            order = 2,
                        },
                        cooldownIconDesaturateOnCooldown = Gladdy:option({
                            type = "toggle",
                            name = L["Desaturate Icon"],
                            order = 5,
                            width = "full",
                        }),
                        cooldownIconAlphaOnCooldown = Gladdy:option({
                            type = "range",
                            name = L["Cooldown alpha on CD"],
                            desc = L["Alpha of the icon when cooldown active"],
                            desc = L["changes "],
                            order = 6,
                            min = 0,
                            max = 1,
                            step = 0.1,
                            width = "full",
                        }),
                        headerCircle = {
                            type = "header",
                            name = L["Cooldowncircle"],
                            order = 10,
                        },
                        cooldownDisableCircle = Gladdy:option({
                            type = "toggle",
                            name = L["No Cooldown Circle"],
                            order = 11,
                            width = "full",
                        }),
                        cooldownCooldownAlpha = Gladdy:option({
                            type = "range",
                            name = L["Cooldown circle alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 12,
                            width = "full",
                        }),
                        cooldownCooldownNumberAlpha = {
                            type = "range",
                            name = L["Cooldown number alpha"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 13,
                            width = "full",
                            set = function(info, value)
                                Gladdy.db.cooldownFontColor.a = value
                                Gladdy:UpdateFrame()
                            end,
                            get = function(info)
                                return Gladdy.db.cooldownFontColor.a
                            end,
                        },
                    },
                },
                glow = {
                    type = "group",
                    name = L["Glow"],
                    order = 3,
                    args = {
                        header = {
                            type = "header",
                            name = L["Glow"],
                            order = 1,
                        },
                        cooldownIconGlow = Gladdy:option({
                            type = "toggle",
                            name = L["Glow Icon"],
                            desc = L["Glow the icon when cooldown active"],
                            order = 2,
                            width = "full",
                        }),
                        cooldownIconGlowColor = Gladdy:colorOption({
                            disabled = function() return not Gladdy.db.cooldownIconGlow end,
                            type = "color",
                            hasAlpha = true,
                            name = L["Glow color"],
                            desc = L["Color of the glow"],
                            order = 3,
                            width = "full",
                        }),
                        resetGlow = {
                            type = "execute",
                            name = L["Reset Glow"],
                            desc = L["Reset Glow Color"],
                            func = function()
                                Gladdy.db.cooldownIconGlowColor = {r = 0.95, g = 0.95, b = 0.32, a = 1}
                                Gladdy:UpdateFrame()
                            end,
                            order = 3,
                        }
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
                            order = 2,
                        },
                        cooldownFont = Gladdy:option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the cooldown"],
                            order = 11,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        cooldownFontScale = Gladdy:option({
                            type = "range",
                            name = L["Font scale"],
                            desc = L["Scale of the font"],
                            order = 12,
                            min = 0.1,
                            max = 2,
                            step = 0.1,
                            width = "full",
                        }),
                        cooldownFontColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Font color"],
                            desc = L["Color of the text"],
                            order = 13,
                            hasAlpha = true,
                        }),
                    },
                },
                position = {
                    type = "group",
                    name = L["Position"],
                    order = 6,
                    args = {
                        header = {
                            type = "header",
                            name = L["Position"],
                            order = 2,
                        },
                        cooldownYGrowDirection = Gladdy:option({
                            type = "select",
                            name = L["Vertical Grow Direction"],
                            desc = L["Vertical Grow Direction of the cooldown icons"],
                            order = 3,
                            values = {
                                ["UP"] = L["Up"],
                                ["DOWN"] = L["Down"],
                            },
                        }),
                        cooldownXGrowDirection = Gladdy:option({
                            type = "select",
                            name = L["Horizontal Grow Direction"],
                            desc = L["Horizontal Grow Direction of the cooldown icons"],
                            order = 4,
                            values = {
                                ["LEFT"] = L["Left"],
                                ["RIGHT"] = L["Right"],
                            },
                        }),
                        cooldownMaxIconsPerLine = Gladdy:option({
                            type = "range",
                            name = L["Max Icons per row"],
                            order = 5,
                            min = 3,
                            max = 14,
                            step = 1,
                            width = "full",
                        }),
                        headerOffset = {
                            type = "header",
                            name = L["Offset"],
                            order = 10,
                        },
                        cooldownXOffset = Gladdy:option({
                            type = "range",
                            name = L["Horizontal offset"],
                            order = 11,
                            min = -400,
                            max = 400,
                            step = 0.1,
                            width = "full",
                        }),
                        cooldownYOffset = Gladdy:option({
                            type = "range",
                            name = L["Vertical offset"],
                            order = 12,
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
                    order = 5,
                    args = {
                        header = {
                            type = "header",
                            name = L["Border"],
                            order = 2,
                        },
                        cooldownBorderStyle = Gladdy:option({
                            type = "select",
                            name = L["Border style"],
                            order = 31,
                            values = Gladdy:GetIconStyles()
                        }),
                        cooldownBorderColor = Gladdy:colorOption({
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
                    order = 7,
                    args = {
                        headerAuraLevel = {
                            type = "header",
                            name = L["Frame Strata and Level"],
                            order = 1,
                        },
                        cooldownFrameStrata = Gladdy:option({
                            type = "select",
                            name = L["Frame Strata"],
                            order = 2,
                            values = Gladdy.frameStrata,
                            sorting = Gladdy.frameStrataSorting,
                            width = "full",
                        }),
                        cooldownFrameLevel = Gladdy:option({
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
        cooldowns = {
            type = "group",
            childGroups = "tree",
            name = L["Cooldowns"],
            order = 4,
            disabled = function() return not Gladdy.db.cooldown end,
            args = Cooldowns:GetCooldownOptions(),
        },
    }
end



function Cooldowns:GetCooldownOptions()
    local group = {}

    local p = 1
    for i,class in ipairs(Gladdy.CLASSES) do
        group[class] = {
            type = "group",
            name = LOCALIZED_CLASS_NAMES_MALE[class],
            order = i,
            icon = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",
            iconCoords = CLASS_ICON_TCOORDS[class],
            args = {}
        }
        local tblLength = tableLength(Gladdy.db.cooldownCooldownsOrder[class])
        for spellId,cooldown in pairs(Gladdy:GetCooldownList()[class]) do
            group[class].args[tostring(spellId)] = {
                name = "",
                type = "group",
                inline = true,
                order = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)],
                args = {
                    toggle = {
                        type = "toggle",
                        name = select(1, GetSpellInfo(spellId)) .. (type(cooldown) == "table" and cooldown.spec and (" - " .. cooldown.spec) or ""),
                        order = 1,
                        width = 1.1,
                        image = select(3, GetSpellInfo(spellId)),
                        get = function()
                            return Gladdy.db.cooldownCooldowns[tostring(spellId)]
                        end,
                        set = function(_, value)
                            Gladdy.db.cooldownCooldowns[tostring(spellId)] = value
                            for unit in pairs(Gladdy.buttons) do
                                Cooldowns:ResetUnit(unit)
                                Cooldowns:UpdateCooldowns(Gladdy.buttons[unit])
                                Cooldowns:Test(unit)
                            end
                            Gladdy:UpdateFrame()
                        end
                    },
                    uparrow = {
                        type = "execute",
                        name = "",
                        order = 2,
                        width = 0.1,
                        image = "Interface\\Addons\\Gladdy\\Images\\uparrow",
                        imageWidth = 15,
                        imageHeight = 15,
                        func = function()
                            if (Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] > 1) then
                                local current = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)]
                                local next
                                for k,v in pairs(Gladdy.db.cooldownCooldownsOrder[class]) do
                                    if v == current - 1 then
                                        next = k
                                    end
                                end
                                Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] - 1
                                Gladdy.db.cooldownCooldownsOrder[class][next] = Gladdy.db.cooldownCooldownsOrder[class][next] + 1
                                Gladdy.options.args["Cooldowns"].args.cooldowns.args[class].args[tostring(spellId)].order = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)]
                                Gladdy.options.args["Cooldowns"].args.cooldowns.args[class].args[next].order = Gladdy.db.cooldownCooldownsOrder[class][next]
                                Gladdy:UpdateFrame()
                            end
                        end,
                    },
                    downarrow = {
                        type = "execute",
                        name = "",
                        order = 3,
                        width = 0.1,
                        image = "Interface\\Addons\\Gladdy\\Images\\downarrow",
                        imageWidth = 15,
                        imageHeight = 15,
                        func = function()
                            if (Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] < tblLength) then
                                local current = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)]
                                local next
                                for k,v in pairs(Gladdy.db.cooldownCooldownsOrder[class]) do
                                    if v == current + 1 then
                                        next = k
                                    end
                                end
                                Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] + 1
                                Gladdy.db.cooldownCooldownsOrder[class][next] = Gladdy.db.cooldownCooldownsOrder[class][next] - 1
                                Gladdy.options.args["Cooldowns"].args.cooldowns.args[class].args[tostring(spellId)].order = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)]
                                Gladdy.options.args["Cooldowns"].args.cooldowns.args[class].args[next].order = Gladdy.db.cooldownCooldownsOrder[class][next]
                                Gladdy:UpdateFrame()
                            end
                        end,
                    }
                }
            }
        end
        p = p + i
    end
    for i,race in ipairs(Gladdy.RACES) do
        for spellId,cooldown in pairs(Gladdy:GetCooldownList()[race]) do
            local tblLength = tableLength(Gladdy.db.cooldownCooldownsOrder[cooldown.class])
            local class = cooldown.class
            group[class].args[tostring(spellId)] = {
                name = "",
                type = "group",
                inline = true,
                order = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)],
                args = {
                    toggle = {
                        type = "toggle",
                        name = select(1, GetSpellInfo(spellId)) .. (type(cooldown) == "table" and cooldown.spec and (" - " .. cooldown.spec) or ""),
                        order = 1,
                        width = 1.1,
                        image = select(3, GetSpellInfo(spellId)),
                        get = function()
                            return Gladdy.db.cooldownCooldowns[tostring(spellId)]
                        end,
                        set = function(_, value)
                            Gladdy.db.cooldownCooldowns[tostring(spellId)] = value
                            Gladdy:UpdateFrame()
                        end
                    },
                    uparrow = {
                        type = "execute",
                        name = "",
                        order = 2,
                        width = 0.1,
                        image = "Interface\\Addons\\Gladdy\\Images\\uparrow",
                        imageWidth = 20,
                        imageHeight = 20,
                        func = function()
                            if (Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] > 1) then
                                local current = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)]
                                local next
                                for k,v in pairs(Gladdy.db.cooldownCooldownsOrder[class]) do
                                    if v == current - 1 then
                                        next = k
                                    end
                                end
                                Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] - 1
                                Gladdy.db.cooldownCooldownsOrder[class][next] = Gladdy.db.cooldownCooldownsOrder[class][next] + 1
                                Gladdy.options.args["Cooldowns"].args.cooldowns.args[class].args[tostring(spellId)].order = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)]
                                Gladdy.options.args["Cooldowns"].args.cooldowns.args[class].args[next].order = Gladdy.db.cooldownCooldownsOrder[class][next]
                                Gladdy:UpdateFrame()
                            end
                        end,
                    },
                    downarrow = {
                        type = "execute",
                        name = "",
                        order = 3,
                        width = 0.1,
                        image = "Interface\\Addons\\Gladdy\\Images\\downarrow",
                        imageWidth = 20,
                        imageHeight = 20,
                        func = function()
                            if (Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] < tblLength) then
                                local current = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)]
                                local next
                                for k,v in pairs(Gladdy.db.cooldownCooldownsOrder[class]) do
                                    if v == current + 1 then
                                        next = k
                                    end
                                end
                                Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)] + 1
                                Gladdy.db.cooldownCooldownsOrder[class][next] = Gladdy.db.cooldownCooldownsOrder[class][next] - 1
                                Gladdy.options.args["Cooldowns"].args.cooldowns.args[class].args[tostring(spellId)].order = Gladdy.db.cooldownCooldownsOrder[class][tostring(spellId)]
                                Gladdy.options.args["Cooldowns"].args.cooldowns.args[class].args[next].order = Gladdy.db.cooldownCooldownsOrder[class][next]
                                Gladdy:UpdateFrame()
                            end
                        end,
                    }
                }
            }
        end
    end
    return group
end

---------------------------

-- LAGACY HANDLER

---------------------------

function Cooldowns:LegacySetPosition(button, unit)
    if Gladdy.db.newLayout then
        return Gladdy.db.newLayout
    end
    button.spellCooldownFrame:ClearAllPoints()
    local powerBarHeight = Gladdy.db.powerBarEnabled and (Gladdy.db.powerBarHeight + 1) or 0
    local horizontalMargin = (Gladdy.db.highlightInset and 0 or Gladdy.db.highlightBorderSize)

    local offset = 0
    if (Gladdy.db.cooldownXPos == "RIGHT") then
        offset = -(Gladdy.db.cooldownSize * Gladdy.db.cooldownWidthFactor)
    end

    if Gladdy.db.cooldownYPos == "TOP" then
        Gladdy.db.cooldownYGrowDirection = "UP"
        if Gladdy.db.cooldownXPos == "RIGHT" then
            Gladdy.db.cooldownXGrowDirection = "LEFT"
            button.spellCooldownFrame:SetPoint("BOTTOMRIGHT", button.healthBar, "TOPRIGHT", Gladdy.db.cooldownXOffset + offset, horizontalMargin + Gladdy.db.cooldownYOffset)
        else
            Gladdy.db.cooldownXGrowDirection = "RIGHT"
            button.spellCooldownFrame:SetPoint("BOTTOMLEFT", button.healthBar, "TOPLEFT", Gladdy.db.cooldownXOffset + offset, horizontalMargin + Gladdy.db.cooldownYOffset)
        end
    elseif Gladdy.db.cooldownYPos == "BOTTOM" then
        Gladdy.db.cooldownYGrowDirection = "DOWN"
        if Gladdy.db.cooldownXPos == "RIGHT" then
            Gladdy.db.cooldownXGrowDirection = "LEFT"
            button.spellCooldownFrame:SetPoint("TOPRIGHT", button.healthBar, "BOTTOMRIGHT", Gladdy.db.cooldownXOffset + offset, -horizontalMargin + Gladdy.db.cooldownYOffset - powerBarHeight)
        else
            Gladdy.db.cooldownXGrowDirection = "RIGHT"
            button.spellCooldownFrame:SetPoint("TOPLEFT", button.healthBar, "BOTTOMLEFT", Gladdy.db.cooldownXOffset + offset, -horizontalMargin + Gladdy.db.cooldownYOffset - powerBarHeight)
        end
    elseif Gladdy.db.cooldownYPos == "LEFT" then
        Gladdy.db.cooldownYGrowDirection = "DOWN"
        local anchor = Gladdy:GetAnchor(unit, "LEFT")
        if anchor == Gladdy.buttons[unit].healthBar then
            Gladdy.db.cooldownXGrowDirection = "LEFT"
            button.spellCooldownFrame:SetPoint("RIGHT", anchor, "LEFT", -(horizontalMargin + Gladdy.db.padding) + Gladdy.db.cooldownXOffset + offset, Gladdy.db.cooldownYOffset)
        else
            Gladdy.db.cooldownXGrowDirection = "LEFT"
            button.spellCooldownFrame:SetPoint("RIGHT", anchor, "LEFT", -Gladdy.db.padding + Gladdy.db.cooldownXOffset + offset, Gladdy.db.cooldownYOffset)
        end
    elseif Gladdy.db.cooldownYPos == "RIGHT" then
        Gladdy.db.cooldownYGrowDirection = "DOWN"
        local anchor = Gladdy:GetAnchor(unit, "RIGHT")
        if anchor == Gladdy.buttons[unit].healthBar then
            Gladdy.db.cooldownXGrowDirection = "RIGHT"
            button.spellCooldownFrame:SetPoint("LEFT", anchor, "RIGHT", horizontalMargin + Gladdy.db.padding + Gladdy.db.cooldownXOffset + offset, Gladdy.db.cooldownYOffset)
        else
            Gladdy.db.cooldownXGrowDirection = "RIGHT"
            button.spellCooldownFrame:SetPoint("LEFT", anchor, "RIGHT", Gladdy.db.padding + Gladdy.db.cooldownXOffset + offset, Gladdy.db.cooldownYOffset)
        end
    end
    LibStub("AceConfigRegistry-3.0"):NotifyChange("Gladdy")

    return Gladdy.db.newLayout
end