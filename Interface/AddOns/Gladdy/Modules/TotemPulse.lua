local select, pairs, tremove, tinsert, format, strsplit, tonumber = select, pairs, tremove, tinsert, format, strsplit, tonumber
local type = type
local C_NamePlate = C_NamePlate
local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local GetSpellInfo, CreateFrame = GetSpellInfo, CreateFrame
local GetTime, UnitIsEnemy, UnitGUID = GetTime, UnitIsEnemy, UnitGUID
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UIParent = UIParent

---------------------------------------------------

-- Helper

---------------------------------------------------

local totemData, npcIdToTotemData, cooldowns = Gladdy:GetTotemData()
local ninetyDegreeInRad = 90 * math.pi / 180

local function TotemOptions()
    local defaultDB = {}
    local options = {}
    local indexedList = {}
    for k,v in pairs(totemData) do
        if v.pulse then
            tinsert(indexedList, {name = k, id = v.id, color = v.color, texture = v.texture})
        end
    end
    table.sort(indexedList, function (a, b)
        return a.name < b.name
    end)
    for i=1,#indexedList do
        defaultDB["totem" .. indexedList[i].id] = {enabled = true, attachToGladdyTotemFrame = true, style = "COOLDOWN", reverse = false}
        options["totem" .. indexedList[i].id] = {
            order = i+1,
            name = select(1, GetSpellInfo(indexedList[i].id)),
            --inline = true,
            width  = "3.0",
            type = "group",
            icon = indexedList[i].texture,
            args = {
                headerTotemConfig = {
                    type = "header",
                    name = format("|T%s:20|t %s", indexedList[i].texture, select(1, GetSpellInfo(indexedList[i].id))),
                    order = 1,
                },
                enabled = {
                    order = 2,
                    name = L["Enabled"],
                    desc = "Enable " .. format("|T%s:20|t %s", indexedList[i].texture, select(1, GetSpellInfo(indexedList[i].id))),
                    type = "toggle",
                    width = "full",
                    get = function() return Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].enabled end,
                    set = function(_, value)
                        Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].enabled = value
                        Gladdy:UpdateFrame()
                    end
                },
                attachToGladdyTotemFrame = {
                    order = 3,
                    disabled = function() return not Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].enabled end,
                    name = L["Attach To TotemPlate"],
                    desc = "Attach " .. format("|T%s:20|t %s", indexedList[i].texture, select(1, GetSpellInfo(indexedList[i].id))) .. "  To TotemPlate",
                    type = "toggle",
                    width = "full",
                    get = function() return Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].attachToGladdyTotemFrame end,
                    set = function(_, value)
                        Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].attachToGladdyTotemFrame = value
                        Gladdy:UpdateFrame()
                    end
                },
                style = {
                    type = "select",
                    name = L["Style"],
                    order = 4,
                    values = {
                        COOLDOWN = L["Cooldown"],
                        Vertical = L["Bar vertical"],
                        Horizontal = L["Bar horizontal"]
                    },
                    get = function() return Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].style end,
                    set = function(_, value)
                        Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].style = value
                        Gladdy:UpdateFrame()
                    end
                },
                reverse = {
                    order = 5,
                    disabled = function() return not Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].enabled end,
                    name = L["Reverse"],
                    type = "toggle",
                    width = "full",
                    get = function() return Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].reverse end,
                    set = function(_, value)
                        Gladdy.dbi.profile.totemPulseTotems["totem" .. indexedList[i].id].reverse = value
                        Gladdy:UpdateFrame()
                    end
                },
            }
        }
    end
    return options,defaultDB
end

---------------------------------------------------

-- Core

---------------------------------------------------

local TotemPulse = Gladdy:NewModule("Totem Pulse", 1, {
    totemPulseEnabled = true,
    totemPulseEnabledShowFriendly = true,
    totemPulseEnabledShowEnemy = true,
    totemPulseStyle = "", -- "COOLDOWN", "COOLDOWNREVERSE", "BARVERTICAL", "BARHORIZONTAL"
    --text
    totemPulseTextColor = { r = 1, g = 1, b = 1, a = 1 },
    totemPulseTextSize = 14,
    totemPulseTextFont = "DorisPP",
    --bar
    totemPulseBarWidth = 40,
    totemPulseBarHeight = 20,
    totemPulseBarColor =  { r = 1, g = 0, b = 0, a = .5 },
    totemPulseBarBgColor =  { r = 0, g = 1, b = 0, a = .5 },
    totemPulseBarBorderColor = { r = 0, g = 0, b = 0, a = 1 },
    totemPulseBarBorderSize = 4,
    totemPulseBarBorderStyle = "Gladdy Tooltip squared",
    totemPulseBarTexture = "Flat",
    totemPulseBarReverse = false,
    --cooldown
    totemPulseCooldownWidth = 40,
    totemPulseCooldownHeight = 20,
    totemPulseCooldownAlpha = 1,
    totemPulseCooldownReverse = true,
    --totems
    totemPulseTotems = select(2, TotemOptions())
})

function TotemPulse.OnEvent(self, event, ...)
    TotemPulse[event](self, ...)
end

function TotemPulse:Initialize()
    self.timeStamps = {}
    self.cooldownCache = {}
    self.barCache = {}
    self.activeFrames = { bars = {}, cooldowns = {} }
    if Gladdy.db.totemPulseEnabled then
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
        self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
        self:RegisterEvent("UNIT_NAME_UPDATE")
        self:SetScript("OnEvent", self.OnEvent)
    end
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

---------------------------------------------------

-- EVENTS

---------------------------------------------------

function TotemPulse:PLAYER_ENTERING_WORLD()
    self.timeStamps = {}
end

function TotemPulse:COMBAT_LOG_EVENT_UNFILTERED()
    local _,eventType,_,sourceGUID,_,_,_,destGUID,_,_,_,spellID,spellName = CombatLogGetCurrentEventInfo()
    local pulse = cooldowns[spellID] or cooldowns[spellName]
    local npcId = tonumber(select(6, strsplit("-", destGUID)), 10)
    if eventType == "UNIT_DESTROYED" and self.timeStamps[destGUID] then
        self.timeStamps[destGUID] = nil
    end
    if (eventType == "SWING_DAMAGE" or eventType == "SPELL_DAMAGE") and self.timeStamps[destGUID] and npcIdToTotemData[npcId] then
        self.timeStamps[destGUID] = nil
    end
    if not pulse then
        return
    end
    if eventType == "SPELL_CAST_SUCCESS" then
        self.timeStamps[sourceGUID] = { timeStamp = GetTime(), pulse = pulse }
    end
    if eventType == "SPELL_SUMMON" then
        if not npcIdToTotemData[npcId] then
            return
        end
        if not Gladdy.dbi.profile.totemPulseTotems["totem" .. npcIdToTotemData[npcId].id].enabled then
            return
        end
        if self.timeStamps[sourceGUID] then
            self.timeStamps[destGUID] = self.timeStamps[sourceGUID]
            self.timeStamps[destGUID].id = npcIdToTotemData[npcId].id
            self.timeStamps[sourceGUID] = nil
        else
            self.timeStamps[destGUID] = { timeStamp = GetTime(), pulse = pulse, id = npcIdToTotemData[npcId].id }
        end
    end
end

function TotemPulse:NAME_PLATE_UNIT_REMOVED(unitId)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitId)
    if nameplate.totemTick then
        nameplate.totemTick:SetScript("OnUpdate", nil)
        nameplate.totemTick:Hide()
        nameplate.totemTick:SetParent(nil)
        tinsert(nameplate.totemTick.bar and self.barCache or self.cooldownCache, nameplate.totemTick)
        self.activeFrames.bars[nameplate.totemTick] = nil
        self.activeFrames.cooldowns[nameplate.totemTick] = nil
        nameplate.totemTick = nil
    end
end

function TotemPulse:NAME_PLATE_UNIT_ADDED(unitId)
    self:OnUnitAdded(unitId, "NAME_PLATE_UNIT_ADDED")
end

function TotemPulse:UNIT_NAME_UPDATE(unitId)
    self:OnUnitAdded(unitId, "UNIT_NAME_UPDATE")
end

function TotemPulse:OnUnitAdded(unitId)
    local isEnemy = UnitIsEnemy("player", unitId)
    local guid = UnitGUID(unitId)
    if strsplit("-", guid) ~= "Creature" then
        return
    end

    local nameplate = C_NamePlate.GetNamePlateForUnit(unitId)

    if nameplate and (isEnemy and Gladdy.db.totemPulseEnabledShowEnemy or not isEnemy and Gladdy.db.totemPulseEnabledShowFriendly) then
        if self.timeStamps[guid] and strsplit("-", guid) then
            self:AddTimerFrame(nameplate, self.timeStamps[guid])
        else
            if nameplate.totemTick then
                nameplate.totemTick:SetScript("OnUpdate", nil)
                nameplate.totemTick:Hide()
                nameplate.totemTick:SetParent(nil)
                tinsert(nameplate.totemTick.bar and self.barCache or self.cooldownCache, nameplate.totemTick)
                self.activeFrames.bars[nameplate.totemTick] = nil
                self.activeFrames.cooldowns[nameplate.totemTick] = nil
                nameplate.totemTick = nil
            end
        end
    end
end

---------------------------------------------------

-- FRAMES

---------------------------------------------------

function TotemPulse:CreateCooldownFrame(style)
    local totemTick

    if style == "COOLDOWN" then
        if #self.cooldownCache > 0 then
            totemTick = tremove(self.cooldownCache, #self.cooldownCache)
        else
            totemTick = CreateFrame("Frame")
            totemTick:SetWidth(Gladdy.db.totemPulseCooldownWidth)
            totemTick:SetHeight(Gladdy.db.totemPulseCooldownHeight)
            totemTick.cd = CreateFrame("Cooldown", nil, totemTick, "CooldownFrameTemplate")
            totemTick.cd:SetAllPoints(totemTick)
            totemTick.cd.noCooldownCount = true
            totemTick:SetFrameStrata("MEDIUM")
            totemTick:SetFrameLevel(4)
            totemTick.cd:SetReverse(Gladdy.db.totemPulseCooldownReverse)
            totemTick.cd:SetHideCountdownNumbers(true)
            totemTick.cd:SetAlpha(Gladdy.db.totemPulseCooldownAlpha)

            totemTick.textFrame = CreateFrame("Frame", nil, totemTick)
            totemTick.textFrame:SetAllPoints(totemTick)
            totemTick.text = totemTick.textFrame:CreateFontString(nil, "OVERLAY")
            totemTick.text:SetPoint("CENTER", totemTick.textFrame, "CENTER")
            totemTick.text:SetFont(Gladdy:SMFetch("font", "totemPulseTextFont"), Gladdy.db.totemPulseTextSize, "OUTLINE")
            totemTick.text:SetJustifyH("CENTER")
            totemTick.text:SetShadowOffset(1, -1)
            totemTick.text:SetTextColor(Gladdy:SetColor(Gladdy.db.totemPulseTextColor))
        end
    else
        if #self.barCache > 0 then
            totemTick = tremove(self.barCache, #self.barCache)
            totemTick.bar:SetOrientation(style)
            totemTick.spark:SetRotation(style == "Vertical" and ninetyDegreeInRad or 0)
            totemTick.spark:SetHeight(style == "Vertical" and Gladdy.db.totemPulseBarWidth or Gladdy.db.totemPulseBarHeight)
        else
            totemTick = CreateFrame("Frame", nil)

            totemTick:SetWidth(Gladdy.db.totemPulseBarWidth)
            totemTick:SetHeight(Gladdy.db.totemPulseBarHeight)

            totemTick.backdrop = CreateFrame("Frame", nil, totemTick, BackdropTemplateMixin and "BackdropTemplate")
            totemTick.backdrop:SetAllPoints(totemTick)
            totemTick.backdrop:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "totemPulseBarBorderStyle"),
                                             edgeSize = Gladdy.db.totemPulseBarBorderSize })
            totemTick.backdrop:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.totemPulseBarBorderColor))
            totemTick.backdrop:SetFrameLevel(1)

            totemTick.bar = CreateFrame("StatusBar", nil, totemTick)
            totemTick.bar:SetStatusBarTexture(Gladdy:SMFetch("statusbar", "totemPulseBarTexture"))
            totemTick.bar:SetStatusBarColor(Gladdy:SetColor(Gladdy.db.totemPulseBarColor))
            totemTick.bar:SetOrientation(style)
            totemTick.bar:SetFrameLevel(0)
            totemTick.bar:SetAllPoints(totemTick)

            totemTick.spark = totemTick.bar:CreateTexture(nil, "OVERLAY")
            totemTick.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
            totemTick.spark:SetBlendMode("ADD")
            totemTick.spark:SetWidth(8)
            totemTick.spark:SetHeight(style == "Vertical" and Gladdy.db.totemPulseBarWidth or Gladdy.db.totemPulseBarHeight)
            totemTick.spark.position = 0
            totemTick.spark:SetRotation(style == "Vertical" and ninetyDegreeInRad or 0)

            totemTick.bg = totemTick:CreateTexture(nil, "ARTWORK")
            totemTick.bg:SetTexture(Gladdy:SMFetch("statusbar", "totemPulseBarTexture"))
            totemTick.bg:SetAllPoints(totemTick.bar)
            totemTick.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.totemPulseBarBgColor))

            totemTick.text = totemTick.bar:CreateFontString(nil, "OVERLAY")
            totemTick.text:SetPoint("CENTER", totemTick, "CENTER", 0, 0)
            totemTick.text:SetFont(Gladdy:SMFetch("font", "totemPulseTextFont"), Gladdy.db.totemPulseTextSize, "OUTLINE")
            totemTick.text:SetJustifyH("CENTER")
            totemTick.text:SetShadowOffset(1, -1)
            totemTick.text:SetTextColor(Gladdy:SetColor(Gladdy.db.totemPulseTextColor))
        end
    end
    return totemTick
end

function TotemPulse:AddTimerFrame(nameplate, timestamp, test)
    if (nameplate:IsShown() or test) and timestamp and timestamp.id then
        if not nameplate.totemTick then
            nameplate.totemTick = TotemPulse:CreateCooldownFrame(Gladdy.db.totemPulseTotems["totem" .. timestamp.id].style)
        end
        nameplate.totemTick:SetParent(nameplate)

        local cd = type(timestamp.pulse) == "table" and timestamp.pulse.cd or timestamp.pulse
        local once = type(timestamp.pulse) == "table"
        local cooldown = (timestamp.timeStamp - GetTime()) % cd

        nameplate.totemTick.timestamp = timestamp.timeStamp
        nameplate.totemTick.maxValue = cd
        nameplate.totemTick.value = cooldown
        nameplate.totemTick.once = once
        nameplate.totemTick.id = timestamp.id

        if nameplate.totemTick.bar then
            self:UpdateBarPartial(nameplate.totemTick)
            nameplate.totemTick.bar:SetMinMaxValues(0, cd)
            nameplate.totemTick.bar:SetValue(cooldown)
            self.activeFrames.bars[nameplate.totemTick] = nameplate.totemTick
        else
            self:UpdateCooldown(nameplate.totemTick)
            self.activeFrames.cooldowns[nameplate.totemTick] = nameplate.totemTick
        end

        if once and GetTime() - timestamp.timeStamp > cd then
            nameplate.totemTick:SetScript("OnUpdate", nil)
            nameplate.totemTick:Hide()
        else
            nameplate.totemTick:SetScript("OnUpdate", TotemPulse.TotemPulseOnUpdate)
            nameplate.totemTick:Show()
        end
    else
        if nameplate.totemTick then
            nameplate.totemTick:SetScript("OnUpdate", nil)
            nameplate.totemTick:Hide()
            nameplate.totemTick:SetParent(nil)
            tinsert(nameplate.totemTick.bar and self.barCache or self.cooldownCache, nameplate.totemTick)
            self.activeFrames.bars[nameplate.totemTick] = nil
            self.activeFrames.cooldowns[nameplate.totemTick] = nil
            nameplate.totemTick = nil
        end
    end
end

function TotemPulse:SetSparkPosition(totemTick, referenceSize, vertical)
    if not Gladdy.db.totemPulseTotems["totem" .. totemTick.id].reverse then
        totemTick.bar:SetValue(totemTick.maxValue - totemTick.value)
        totemTick.spark.position = referenceSize / 2 - (totemTick.value / totemTick.maxValue) * referenceSize
        if ( totemTick.spark.position < -referenceSize / 2 ) then
            totemTick.spark.position = -referenceSize / 2
        end
    else
        totemTick.bar:SetValue(totemTick.value)
        totemTick.spark.position = referenceSize / 2 - ((totemTick.maxValue - totemTick.value) / totemTick.maxValue) * referenceSize
        if ( totemTick.spark.position > referenceSize / 2 ) then
            totemTick.spark.position = referenceSize / 2
        end
    end
    totemTick.spark:SetPoint("CENTER", totemTick.bar, "CENTER", vertical and 0 or totemTick.spark.position, vertical and totemTick.spark.position or 0)
end

function TotemPulse.TotemPulseOnUpdate(totemTick)
    totemTick.now = GetTime()
    totemTick.value = (totemTick.timestamp - totemTick.now) % totemTick.maxValue
    if totemTick.once and totemTick.now - totemTick.timestamp >= totemTick.maxValue then
        totemTick:SetScript("OnUpdate", nil)
        totemTick:Hide()
    end
    if not totemTick.bar and not (totemTick.once and totemTick.now - totemTick.timestamp >= totemTick.maxValue) then
        if Gladdy.db.totemPulseTotems["totem" .. totemTick.id].reverse then
            totemTick.cd:SetCooldown(totemTick.now - totemTick.value, totemTick.maxValue)
        else
            totemTick.cd:SetCooldown(totemTick.now - (totemTick.maxValue - totemTick.value), totemTick.maxValue)
        end
    elseif totemTick.bar then
        if Gladdy.db.totemPulseTotems["totem" .. totemTick.id].style == "Vertical" then
            TotemPulse:SetSparkPosition(totemTick, totemTick.bar:GetHeight(), true)
        else
            TotemPulse:SetSparkPosition(totemTick, totemTick.bar:GetWidth(), false)
        end
    end
    totemTick.text:SetFormattedText("%.1f", totemTick.value)
end

---------------------------------------------------

-- Update Styles

---------------------------------------------------

function TotemPulse:UpdateBarPartial(bar)
    local style = bar.id and Gladdy.db.totemPulseTotems["totem" .. bar.id].style

    bar:SetWidth(Gladdy.db.totemPulseBarWidth)
    bar:SetHeight(Gladdy.db.totemPulseBarHeight)

    bar.spark:SetWidth(8)
    bar.spark:SetHeight(style == "Vertical" and Gladdy.db.totemPulseBarWidth or Gladdy.db.totemPulseBarHeight)
    bar.spark:SetRotation(style == "Vertical" and ninetyDegreeInRad or 0)


    if bar:GetParent() and bar:GetParent() ~= UIParent then
        local gladdyTotemFrame = bar:GetParent().gladdyTotemFrame and bar:GetParent().gladdyTotemFrame
        local nameplate = bar:GetParent()
        bar:ClearAllPoints()
        if bar.id and gladdyTotemFrame and gladdyTotemFrame:IsShown() and Gladdy.db.totemPulseTotems["totem" .. bar.id].attachToGladdyTotemFrame then
            bar:SetPoint("TOPLEFT", gladdyTotemFrame, "TOPLEFT", Gladdy.db.npTotemPlatesSize/16, -Gladdy.db.npTotemPlatesSize/16)
            bar:SetPoint("BOTTOMRIGHT", gladdyTotemFrame, "BOTTOMRIGHT", -Gladdy.db.npTotemPlatesSize/16, Gladdy.db.npTotemPlatesSize/16)
            if style then
                bar.spark:SetHeight(style == "Vertical" and gladdyTotemFrame:GetWidth() or gladdyTotemFrame:GetHeight())
            end
        elseif bar.id and gladdyTotemFrame and gladdyTotemFrame:IsShown() and not Gladdy.db.totemPulseTotems["totem" .. bar.id].attachToGladdyTotemFrame then
            bar:SetPoint("TOP", gladdyTotemFrame, "BOTTOM", 0, -0.5)
        else
            bar:SetPoint("TOP", nameplate, "BOTTOM", 0, -0.5)
        end
    end
    bar.bar:SetOrientation(style ~= "COOLDOWN" and style or bar.bar:GetOrientation())
end

function TotemPulse:UpdateBar(bar)
    self:UpdateBarPartial(bar)

    bar.backdrop:SetBackdrop({ edgeFile = Gladdy:SMFetch("border", "totemPulseBarBorderStyle"),
                               edgeSize = Gladdy.db.totemPulseBarBorderSize })
    bar.backdrop:SetBackdropBorderColor(Gladdy:SetColor(Gladdy.db.totemPulseBarBorderColor))

    bar.bar:SetStatusBarTexture(Gladdy:SMFetch("statusbar", "totemPulseBarTexture"))
    bar.bar:SetStatusBarColor(Gladdy:SetColor(Gladdy.db.totemPulseBarColor))

    bar.bg:SetTexture(Gladdy:SMFetch("statusbar", "totemPulseBarTexture"))
    bar.bg:SetVertexColor(Gladdy:SetColor(Gladdy.db.totemPulseBarBgColor))

    bar.text:SetFont(Gladdy:SMFetch("font", "totemPulseTextFont"), Gladdy.db.totemPulseTextSize, "OUTLINE")
    bar.text:SetTextColor(Gladdy:SetColor(Gladdy.db.totemPulseTextColor))
end

function TotemPulse:UpdateCooldown(cooldown)
    cooldown:SetWidth(Gladdy.db.totemPulseCooldownWidth)
    cooldown:SetHeight(Gladdy.db.totemPulseCooldownHeight)

    cooldown.cd:SetCooldown(0,0)
    cooldown.cd:SetReverse(Gladdy.db.totemPulseCooldownReverse)
    cooldown.cd:SetAlpha(Gladdy.db.totemPulseCooldownAlpha)

    cooldown.text:SetFont(Gladdy:SMFetch("font", "totemPulseTextFont"), Gladdy.db.totemPulseTextSize, "OUTLINE")
    cooldown.text:SetTextColor(Gladdy:SetColor(Gladdy.db.totemPulseTextColor))

    if cooldown:GetParent() and cooldown:GetParent() ~= UIParent then
        local gladdyTotemFrame = cooldown:GetParent().gladdyTotemFrame and cooldown:GetParent().gladdyTotemFrame
        local nameplate = cooldown:GetParent()
        cooldown:ClearAllPoints()
        if cooldown.id and gladdyTotemFrame and gladdyTotemFrame:IsShown() and Gladdy.db.totemPulseTotems["totem" .. cooldown.id].attachToGladdyTotemFrame then
            cooldown:SetPoint("TOPLEFT", gladdyTotemFrame, "TOPLEFT", Gladdy.db.npTotemPlatesSize/16, -Gladdy.db.npTotemPlatesSize/16)
            cooldown:SetPoint("BOTTOMRIGHT", gladdyTotemFrame, "BOTTOMRIGHT", -Gladdy.db.npTotemPlatesSize/16, Gladdy.db.npTotemPlatesSize/16)
        elseif cooldown.id and gladdyTotemFrame and gladdyTotemFrame:IsShown() and not Gladdy.db.totemPulseTotems["totem" .. cooldown.id].attachToGladdyTotemFrame then
            cooldown:SetPoint("TOP", gladdyTotemFrame, "BOTTOM", 0, -0.5)
        else
            cooldown:SetPoint("TOP", nameplate, "BOTTOM", 0, -0.5)
        end
    end
end

function TotemPulse:UpdateFrameOnce()
    if Gladdy.frame.testing then
        TotemPulse:TestOnce()
    end
    if Gladdy.db.totemPulseEnabled then
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
        self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
        self:RegisterEvent("UNIT_NAME_UPDATE")
        self:SetScript("OnEvent", self.OnEvent)
    else
        for _,bar in pairs(self.activeFrames.bars) do
            bar:SetScript("OnUpdate", nil)
            bar:Hide()
            bar:SetParent(nil)
            tinsert(self.barCache, bar)
            self.activeFrames.bars[bar] = nil
        end
        for _,cooldown in pairs(self.activeFrames.cooldowns) do
            cooldown:SetScript("OnUpdate", nil)
            cooldown:Hide()
            cooldown:SetParent(nil)
            tinsert(self.cooldownCache, cooldown)
            self.activeFrames.cooldowns[cooldown] = nil
        end
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
        self:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
        self:UnregisterEvent("UNIT_NAME_UPDATE")
        self:SetScript("OnEvent", nil)
    end
    for _,bar in pairs(self.activeFrames.bars) do
        self:UpdateBar(bar)
    end
    for _,cooldown in pairs(self.activeFrames.cooldowns) do
        self:UpdateCooldown(cooldown)
    end
    for _,bar in pairs(self.barCache) do
        self:UpdateBar(bar)
    end
    for _,cooldown in pairs(self.cooldownCache) do
        self:UpdateCooldown(cooldown)
    end
end

---------------------------------------------------

-- TEST

---------------------------------------------------

function TotemPulse:TestOnce()
    local totemPlatesTestFrame = Gladdy.modules["Totem Plates"].testFrame
    if totemPlatesTestFrame then
        if totemPlatesTestFrame.totemTick
                and (Gladdy.db.totemPulseTotems["totem" .. npcIdToTotemData[5913].id].style == "COOLDOWN" and totemPlatesTestFrame.totemTick.bar
                or Gladdy.db.totemPulseTotems["totem" .. npcIdToTotemData[5913].id].style ~= "COOLDOWN" and not totemPlatesTestFrame.totemTick.bar) then
            totemPlatesTestFrame.totemTick:SetScript("OnUpdate", nil)
            totemPlatesTestFrame.totemTick:Hide()
            totemPlatesTestFrame.totemTick:SetParent(nil)
            totemPlatesTestFrame.totemTick.id = nil
            tinsert(totemPlatesTestFrame.totemTick.bar and self.barCache or self.cooldownCache, totemPlatesTestFrame.totemTick)
            self.activeFrames.bars[totemPlatesTestFrame.totemTick] = nil
            self.activeFrames.cooldowns[totemPlatesTestFrame.totemTick] = nil
            totemPlatesTestFrame.totemTick = nil
        end

        local timestamp = { timeStamp = GetTime(), pulse = npcIdToTotemData[5913].pulse, id = npcIdToTotemData[5913].id }
        TotemPulse:AddTimerFrame(totemPlatesTestFrame, timestamp, true)
        self.testFrame = totemPlatesTestFrame.totemTick
    end
end

function TotemPulse:Reset()
    if self.testFrame then
        self.testFrame:SetScript("OnUpdate", nil)
        self.testFrame:Hide()
        self.testFrame:SetParent(nil)
        tinsert(self.testFrame.bar and self.barCache or self.cooldownCache, self.testFrame)
        self.activeFrames.bars[self.testFrame] = nil
        self.activeFrames.cooldowns[self.testFrame] = nil
        self.testFrame = nil
        Gladdy.modules["Totem Plates"].testFrame.totemTick = nil
    end
end

---------------------------------------------------

-- OPTIONS

---------------------------------------------------

function TotemPulse:GetOptions()
    return {
        headerClassicon = {
            type = "header",
            name = L["Totem Pulse"],
            order = 2,
        },
        totemPulseEnabled = Gladdy:option({
            type = "toggle",
            name = L["Totem Pulse Enabled"],
            order = 3,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            order = 4,
            disabled = function() return not Gladdy.db.totemPulseEnabled end,
            args = {
                barFrame = {
                    type = "group",
                    name = L["Bar"],
                    order = 2,
                    args = {
                        headerSize = {
                            type = "header",
                            name = L["Size"],
                            order = 10,
                        },
                        totemPulseBarHeight = Gladdy:option({
                            type = "range",
                            name = L["Bar height"],
                            desc = L["Height of the bar"],
                            order = 11,
                            min = 0.1,
                            max = 200,
                            step = .1,
                            width = "full",
                        }),
                        totemPulseBarWidth = Gladdy:option({
                            type = "range",
                            name = L["Bar width"],
                            desc = L["Width of the bar"],
                            order = 12,
                            min = 0.1,
                            max = 600,
                            step = .1,
                            width = "full",
                        }),
                        headerTexture = {
                            type = "header",
                            name = L["Texture"],
                            order = 20,
                        },
                        totemPulseBarTexture = Gladdy:option({
                            type = "select",
                            name = L["Bar texture"],
                            desc = L["Texture of the bar"],
                            order = 21,
                            dialogControl = "LSM30_Statusbar",
                            values = AceGUIWidgetLSMlists.statusbar,
                        }),
                        totemPulseBarColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Bar color"],
                            desc = L["Color of the cast bar"],
                            order = 22,
                            hasAlpha = true,
                        }),
                        totemPulseBarBgColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Background color"],
                            desc = L["Color of the cast bar background"],
                            order = 23,
                            hasAlpha = true,
                        }),
                        headerBorder = {
                            type = "header",
                            name = L["Border"],
                            order = 30,
                        },
                        totemPulseBarBorderSize = Gladdy:option({
                            type = "range",
                            name = L["Border size"],
                            order = 31,
                            min = 0.5,
                            max = Gladdy.db.castBarHeight/2,
                            step = 0.5,
                            width = "full",
                        }),
                        totemPulseBarBorderStyle = Gladdy:option({
                            type = "select",
                            name = L["Status Bar border"],
                            order = 32,
                            dialogControl = "LSM30_Border",
                            values = AceGUIWidgetLSMlists.border,
                        }),
                        totemPulseBarBorderColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Status Bar border color"],
                            order = 33,
                            hasAlpha = true,
                        }),
                    },
                },
                cooldownFrame = {
                    type = "group",
                    name = L["Cooldown"],
                    order = 3,
                    args = {
                        headerSize = {
                            type = "header",
                            name = L["Frame"],
                            order = 10,
                        },
                        totemPulseCooldownHeight = Gladdy:option({
                            type = "range",
                            name = L["Height"],
                            order = 11,
                            min = 0.1,
                            max = 200,
                            step = .1,
                            width = "full",
                        }),
                        totemPulseCooldownWidth = Gladdy:option({
                            type = "range",
                            name = L["Width"],
                            order = 12,
                            min = 0.1,
                            max = 600,
                            step = .1,
                            width = "full",
                        }),
                        totemPulseCooldownAlpha = Gladdy:option({
                            type = "range",
                            name = L["Alpha"],
                            order = 21,
                            min = 0.1,
                            max = 1,
                            step = .1,
                            width = "full",
                        }),

                    },
                },
                text = {
                    type = "group",
                    name = L["Text"],
                    order = 4,
                    args = {
                        headerSize = {
                            type = "header",
                            name = L["Text"],
                            order = 10,
                        },
                        totemPulseTextSize = Gladdy:option({
                            type = "range",
                            name = L["Size"],
                            order = 11,
                            min = 0.5,
                            max = 30,
                            step = 0.5,
                            width = "full",
                        }),
                        totemPulseTextFont = Gladdy:option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the bar"],
                            order = 12,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        totemPulseTextColor = Gladdy:colorOption({
                            type = "color",
                            name = L["Font color"],
                            desc = L["Color of the text"],
                            order = 13,
                            hasAlpha = true,
                        }),
                    },
                },
            },
        },
        customizeTotems = {
            order = 50,
            name = L["Customize Totems"],
            type = "group",
            childGroups = "tree",
            disabled = function() return not Gladdy.db.totemPulseEnabled end,
            args = select(1, TotemOptions())
        },
    }
end