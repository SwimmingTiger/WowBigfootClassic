local TC2, C, L, _ = unpack(select(2, ...))

-----------------------------
-- VARIABLES
-----------------------------
-- upvalues
local _G        = _G
local select    = _G.select
local unpack    = _G.unpack
local type      = _G.type
local floor     = _G.math.floor
local min       = _G.math.min
local strbyte   = _G.string.byte
local format    = _G.string.format
local strlen    = _G.string.len
local strsub    = _G.string.sub
local strmatch  = _G.string.match

local pairs     = _G.pairs
local tinsert   = _G.table.insert
local sort      = _G.table.sort
local wipe      = _G.table.wipe

local GetTime               = _G.GetTime
local GetNumGroupMembers    = _G.GetNumGroupMembers
local GetNumSubgroupMembers = _G.GetNumSubgroupMembers
local GetInstanceInfo       = _G.GetInstanceInfo
local IsInRaid              = _G.IsInRaid
local UnitAffectingCombat   = _G.UnitAffectingCombat
local UnitClass             = _G.UnitClass
local UnitExists            = _G.UnitExists
local UnitIsFriend          = _G.UnitIsFriend
local UnitCanAssist         = _G.UnitCanAssist
local UnitIsPlayer          = _G.UnitIsPlayer
local UnitName              = _G.UnitName
local UnitReaction          = _G.UnitReaction
local UnitIsUnit            = _G.UnitIsUnit
local GetSpellInfo          = _G.GetSpellInfo
local GetShapeshiftForm     = _G.GetShapeshiftForm
local FindAuraByName        = AuraUtil.FindAuraByName

local screenWidth           = floor(GetScreenWidth())
local screenHeight          = floor(GetScreenHeight())

local lastCheckStatusTime   = 0
local callCheckStatus       = false

local announcedOutdated     = false
local announcedIncompatible = false

local lastWarnPercent       =  100

local FACTION_BAR_COLORS    = _G.FACTION_BAR_COLORS
local RAID_CLASS_COLORS     = (_G.CUSTOM_CLASS_COLORS or _G.RAID_CLASS_COLORS)


-- other
TC2.commPrefix = "TC2"
TC2.bars = {}
TC2.threatData = {}
TC2.colorFallback = {}
TC2.numGroupMembers = 0
TC2.playerName = ""
TC2.playerClass = ""
TC2.playerTarget = ""

local AceComm = LibStub("AceComm-3.0")
AceComm:Embed(TC2)

-- depreciation warning for ClassicThreatMeter
C_Timer.After(3,
  function()
    if IsAddOnLoaded("ClassicThreatMeter") then
      print("Please disable |cFFFBB709ClassicThreatMeter|cFFFF6060 to avoid unnecessary syncing that can negatively impact |cFFFBB709ThreatClassic2|cFFFF6060 and other addons.")
    end
  end
)

local LSM = LibStub("LibSharedMedia-3.0")
-- Register some media
LSM:Register("sound", "You Will Die!", [[Sound\Creature\CThun\CThunYouWillDie.ogg]])
LSM:Register("sound", "Omen: Aoogah!", [[Interface\AddOns\ThreatClassic2\aoogah.ogg]])
LSM:Register("sound", "TC2: Bell", [[Sound/Doodad/BellTollAlliance.ogg]])
LSM:Register("font", "NotoSans SemiCondensedBold", [[Interface\AddOns\ThreatClassic2\media\NotoSans-SemiCondensedBold.ttf]])
LSM:Register("font", "Standard Text Font", _G.STANDARD_TEXT_FONT) -- register so it's usable as a default in config
LSM:Register("statusbar", "TC2 Default", [[Interface\ChatFrame\ChatFrameBackground]]) -- register so it's usable as a default in config
LSM:Register("statusbar", "Minimalist", "Interface\\AddOns\\ThreatClassic2\\media\\Minimalist")
LSM:Register("border", "TC2 Default", [[Interface\ChatFrame\ChatFrameBackground]]) -- register so it's usable as a default in config


local SoundChannels = {
    ["Master"] = L.soundChannel_master,
    ["SFX"] =  L.soundChannel_sfx,
    ["Ambience"] =  L.soundChannel_ambience,
    ["Music"] = L.soundChannel_music
}

--local UnitThreatSituation = _G.UnitThreatSituation
local UnitDetailedThreatSituation = _G.UnitDetailedThreatSituation

-----------------------------
-- FUNCTIONS
-----------------------------

local function CreateEdgeBackdrop(parent, cfg)
    local f = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
    f:SetPoint("TOPLEFT", parent, "TOPLEFT", -cfg.inset, cfg.inset)
    f:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", cfg.inset, -cfg.inset)
    -- Backdrop Settings
    local edgeBackdrop = {
        edgeFile = LSM:Fetch("border", cfg.edgeTexture),
        edgeSize = cfg.edgeSize,
        insets = {
            left = cfg.inset,
            right = cfg.inset,
            top = cfg.inset,
            bottom = cfg.inset,
        },
    }
    f:SetBackdrop(edgeBackdrop)
    f:SetBackdropColor(0, 0, 0, 0) -- hide backdrop area. this is just for the edge
    f:SetBackdropBorderColor(unpack(cfg.edgeColor))

    parent.edgeBackdrop = f
end

local function CreateFS(parent)
    local fs = parent:CreateFontString(nil, "ARTWORK")
    fs:SetFont(LSM:Fetch("font", C.font.name), C.font.size, C.font.style)
    return fs
end

local function CreateStatusBar(parent, header)
    -- StatusBar
    local bar = CreateFrame("StatusBar", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
    bar:SetMinMaxValues(0, 100)
    -- Backdrop
    local backdrop = {
        bgFile = LSM:Fetch("statusbar", C.backdrop.bgTexture),
        tile = C.backdrop.tile,
        tileSize = C.backdrop.tileSize,
        insets = {
            left = C.backdrop.inset,
            right = C.backdrop.inset,
            top = C.backdrop.inset,
            bottom = C.backdrop.inset,
        },
    }
    bar:SetBackdrop(backdrop)
    bar:SetBackdropColor(unpack(C.backdrop.bgColor)) -- hide backdrop area. this backdrop is just for the edge
    bar:SetBackdropBorderColor(0, 0, 0, 0) -- no edge on regular backdrop
    -- Edge
    CreateEdgeBackdrop(bar, C.backdrop)

    if not header then
        -- BG
        bar.bg = bar:CreateTexture(nil, "BACKGROUND", nil, -6)
        bar.bg:SetAllPoints(bar)
        -- ignite indicator
        bar.ignite = bar:CreateTexture(nil, "OVERLAY")
        bar.ignite:SetPoint("LEFT", bar, 4, 0)
        bar.ignite:SetTexture("Interface\\Icons\\Spell_Fire_Incinerate")
        bar.ignite:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        if C.igniteIndicator.makeRound then
            local mask = bar:CreateMaskTexture()
            mask:SetTexture([[Interface\CHARACTERFRAME\TempPortraitAlphaMask]], "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            mask:SetAllPoints(bar.ignite)
            bar.ignite:AddMaskTexture(mask)
        end
        -- Name
        bar.name = CreateFS(bar)
        bar.name:SetJustifyH("LEFT")
        -- Perc
        bar.perc = CreateFS(bar)
        bar.perc:SetJustifyH("RIGHT")
        -- Value
        bar.val = CreateFS(bar)
        bar.val:SetJustifyH("RIGHT")

        bar:Hide()
    end
    return bar
end

local function Compare(a, b)
    return a.threatPercent > b.threatPercent
end

local function NumFormat(v)
    if v > 1e10 then
        return (floor(v / 1e9)) .. "b"
    elseif v > 1e9 then
        return (floor((v / 1e9) * 10) / 10) .. "b"
    elseif v > 1e7 then
        return (floor(v / 1e6)) .. "m"
    elseif v > 1e6 then
        return (floor((v / 1e6) * 10) / 10) .. "m"
    elseif v > 1e4 then
        return (floor(v / 1e3)) .. "k"
    elseif v > 1e3 then
        return (floor((v / 1e3) * 10) / 10) .. "k"
    else
        return v
    end
end

local function TruncateString(str, i, ellipsis)
    if not str then return end
    local bytes = strlen(str)
    if bytes <= i then
        return str
    else
        local length, pos = 0, 1
        while (pos <= bytes) do
            length = length + 1
            local c = strbyte(str, pos)
            if c > 0 and c <= 127 then
                pos = pos + 1
            elseif c >= 192 and c <= 223 then
                pos = pos + 2
            elseif c >= 224 and c <= 239 then
                pos = pos + 3
            elseif c >= 240 and c <= 247 then
                pos = pos + 4
            end
            if length == i then break end
        end
        if length == i and pos <= bytes then
            return strsub(str, 1, pos - 1) .. (ellipsis and "..." or "")
        else
            return str
        end
    end
end

local function DefaultUnitColor(unit)
    local colorUnit
    if UnitIsPlayer(unit) then
        colorUnit = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
    else
        colorUnit = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
    end
    -- safeguard, i.e. if requested unit is out of draw distance
    if colorUnit == nil then
        colorUnit = FACTION_BAR_COLORS[5]
    end
    colorUnit = {colorUnit.r, colorUnit.g, colorUnit.b, C.bar.alpha}
    return colorUnit
end

local function GetColor(unit, isTanking, hasActiveIgnite)
    if unit then
        if UnitIsUnit(unit, "player") then
            if C.customBarColors.playerEnabled then
                return C.customBarColors.playerColor
            elseif isTanking and C.customBarColors.activeTankEnabled then
                return C.customBarColors.activeTankColor
            elseif hasActiveIgnite and C.customBarColors.igniteEnabled then
                return C.customBarColors.igniteColor
            else
                return DefaultUnitColor(unit)
            end
        else
            if isTanking and C.customBarColors.activeTankEnabled then
                return C.customBarColors.activeTankColor
            elseif hasActiveIgnite and C.customBarColors.igniteEnabled then
                return C.customBarColors.igniteColor
            elseif C.customBarColors.otherUnitEnabled then
                return C.customBarColors.otherUnitColor
            else
                return DefaultUnitColor(unit)
            end
        end
    else
        return TC2.colorFallback
    end
end

function TC2:UpdateThreatBars()
    -- sort the threat table
    sort(self.threatData, Compare)
    local playerIncluded = false

    -- ignite
    local igniteOwner = nil
    local hasActiveIgnite = false
    if C.bar.showIgniteIndicator or C.customBarColors.igniteEnabled then
        igniteOwner = select(7, FindAuraByName(GetSpellInfo(12848), TC2.playerTarget, "HARMFUL"))
    end
    -- update view
    for i = 1, C.bar.count do
        -- get values out of table
        local data = self.threatData[i]
        local bar = self.bars[i]
        if data and data.threatValue > 0 then
            if UnitIsUnit(data.unit, "player") then
                playerIncluded = true
            end
            if igniteOwner and UnitIsUnit(igniteOwner, data.unit) then
                bar.ignite:Show()
                bar.name:SetPoint("LEFT", bar, 5+C.igniteIndicator.size, 0)
                hasActiveIgnite = true
            else
                bar.ignite:Hide()
                bar.name:SetPoint("LEFT", bar, 4, 0)
                hasActiveIgnite = false
            end
            bar.name:SetText(UnitName(data.unit) or UNKNOWN)
            bar.val:SetText(NumFormat(data.threatValue))
            bar.perc:SetText(floor(data.threatPercent).."%")
            bar:SetValue(data.threatPercent)
            local color = GetColor(data.unit, data.isTanking, hasActiveIgnite)
            bar:SetStatusBarColor(unpack(color))
            bar.bg:SetVertexColor(color[1] * C.bar.colorMod, color[2] * C.bar.colorMod, color[3] * C.bar.colorMod, C.bar.alpha)

            bar:Show()
        else
            bar:Hide()
        end
    end
    -- overwrite last bar if player wasn't included above
    if not playerIncluded then
        for _, data in pairs(self.threatData) do
            if data and UnitIsUnit(data.unit, "player") then
                if data.threatValue > 0 then
                    local bar = self.bars[C.bar.count]
                    if igniteOwner and UnitIsUnit(igniteOwner, data.unit) then
                        bar.ignite:Show()
                        bar.name:SetPoint("LEFT", bar, 5+C.igniteIndicator.size, 0)
                        hasActiveIgnite = true
                    else
                        bar.ignite:Hide()
                        bar.name:SetPoint("LEFT", bar, 4, 0)
                        hasActiveIgnite = false
                    end
                    bar.name:SetText(UnitName(data.unit) or UNKNOWN)
                    bar.val:SetText(NumFormat(data.threatValue))
                    bar.perc:SetText(floor(data.threatPercent).."%")
                    bar:SetValue(data.threatPercent)
                    local color = GetColor(data.unit, data.isTanking, hasActiveIgnite)
                    bar:SetStatusBarColor(unpack(color))
                    bar.bg:SetVertexColor(color[1] * C.bar.colorMod, color[2] * C.bar.colorMod, color[3] * C.bar.colorMod, C.bar.alpha)

                    bar:Show()
                    break
                end
            end
        end
    end
end

local function CheckVisibility()
    local instanceType = select(2, GetInstanceInfo())
    local hide = C.general.hideAlways or
        (C.general.hideOOC and not UnitAffectingCombat("player")) or
        (C.general.hideSolo and TC2.numGroupMembers == 0) or
        (C.general.hideInPVP and (instanceType == "arena" or instanceType == "pvp")) or
        (C.general.hideOpenWorld and instanceType == "none")

    if hide then
        return TC2.frame:Hide()
    else
        return TC2.frame:Show()
    end
end

local function UpdateThreatData(unit)
    if not UnitExists(unit) then return end
    local isTanking, _, threatPercent, rawThreatPercent, threatValue = UnitDetailedThreatSituation(unit, TC2.playerTarget)

    if isTanking then
        -- this fixes wonky returns from the API. regular threatPercent should be working correctly, but just in case...
        rawThreatPercent = 100
        threatPercent = 100
    end

    -- never filter player
    if not UnitIsUnit(unit, "player") then
        -- target list disabled or target in filter targetlist
        if not C.filter.useTargetList or C.filter.targetList[UnitName(TC2.playerTarget)] then
            -- melee range filter; threatPercent > 0 to avoid divison by zero on fucked up api response
            if C.filter.outOfMelee and rawThreatPercent and threatPercent > 0 and rawThreatPercent / threatPercent > 1.2 then
                return
            end
        end
    end

    if threatValue and C.general.downscaleThreat then
        threatValue = math.floor(threatValue / 100)
    end

    -- check for warnings. this always uses the scaled percentage to avoid conercases of over 100% raw threat and then aggro
    if UnitIsUnit(unit, "player") and threatPercent then
        TC2:CheckWarning(threatPercent, threatValue, rawThreatPercent)
    end

    if C.general.rawPercent then
        threatPercent = rawThreatPercent
    end

    tinsert(TC2.threatData, {
        unit            = unit,
        threatPercent   = threatPercent or 0,
        threatValue     = threatValue or 0,
        isTanking       = isTanking or false,
    })
end

local function UpdatePlayerTarget()
    if UnitExists("target") and (not UnitIsFriend("player", "target") or ((UnitReaction("player", "target") or 0) <= 4 and not UnitCanAssist("player", "target"))) then
        TC2.playerTarget = "target"
    elseif UnitExists("targettarget") and (not UnitIsFriend("player", "targettarget") or ((UnitReaction("player", "targettarget") or 0) <= 4 and not UnitCanAssist("player", "targettarget"))) then
        TC2.playerTarget = "targettarget"
    else
        TC2.playerTarget = "target"
    end
end

local function CheckStatus()
    lastCheckStatusTime = GetTime()
    callCheckStatus = false
    if C.frame.test then return end

    CheckVisibility()

    if UnitExists(TC2.playerTarget) then
        -- wipe
        wipe(TC2.threatData)

        if IsInRaid() then
            for i = 1, TC2.numGroupMembers do
                UpdateThreatData(TC2.raidUnits[i])
                UpdateThreatData(TC2.raidPetUnits[i])
            end
        else
            if TC2.numGroupMembers > 0 then
                for i = 1, TC2.numGroupMembers do
                    UpdateThreatData(TC2.partyUnits[i])
                    UpdateThreatData(TC2.partyPetUnits[i])
                end
            end
            -- solo / party player & pet units
            UpdateThreatData("player")
            UpdateThreatData("pet")
        end

        TC2:UpdateThreatBars()

        -- set header unit name
        local targetName = (": " .. UnitName(TC2.playerTarget)) or ""
        targetName = TruncateString(targetName, floor(TC2.frame.header:GetWidth() / (C.font.size * 0.85)), true)
        TC2.frame.header.text:SetText(format("%s%s", L.gui_threat, targetName))
    else
        -- clear header text of unit name
        TC2.frame.header.text:SetText(format("%s%s", L.gui_threat, ""))
        -- hide bars when no target
        for i = 1, 40 do
            TC2.bars[i]:Hide()
        end
    end
end

local function CheckStatusDeferred()
    callCheckStatus = true
end

function TC2:CheckWarning(threatPercent, threatValue, rawThreatPercent)

    if C.warnings.disableWhileTanking then
        if self.playerClass == "WARRIOR" then
            -- def stance
            if GetShapeshiftForm() == 2 then
                lastWarnPercent = 100
                return
            end
        elseif self.playerClass == "DRUID" then
            -- bear form
            if GetShapeshiftForm() == 1 then
                lastWarnPercent = 100
                return
            end
        elseif self.playerClass == "PALADIN" then
            -- righteous fury active
            if FindAuraByName(GetSpellInfo(25780), "player", "HELPFUL") then
                lastWarnPercent = 100
                return
            end
        end
    end

    -- percentage is now above threshold and was below threshold before
    if threatPercent >= C.warnings.threshold and lastWarnPercent < C.warnings.threshold and rawThreatPercent < 250 then
        lastWarnPercent = threatPercent
        if threatValue > C.warnings.minThreatAmount then
            if C.warnings.sound then PlaySoundFile(LSM:Fetch("sound", C.warnings.soundFile), C.warnings.soundChannel) end
            if C.warnings.flash then self:FlashScreen() end
        end
    -- percentage is below threshold -> reset lastWarnPercent
    elseif threatPercent < C.warnings.threshold then
        lastWarnPercent = threatPercent
    end
end

function TC2:FlashScreen()
    if not self.FlashFrame then
        local flasher = CreateFrame("Frame", "Tc2FlashFrame")
        flasher:SetToplevel(true)
        flasher:SetFrameStrata("FULLSCREEN_DIALOG")
        flasher:SetAllPoints(UIParent)
        flasher:EnableMouse(false)
        flasher:Hide()
        flasher.texture = flasher:CreateTexture(nil, "BACKGROUND")
        flasher.texture:SetTexture("Interface\\FullScreenTextures\\LowHealth")
        flasher.texture:SetAllPoints(UIParent)
        flasher.texture:SetBlendMode("ADD")
        flasher:SetScript("OnShow", function(self)
            self.elapsed = 0
            self:SetAlpha(0)
        end)
        flasher:SetScript("OnUpdate", function(self, elapsed)
            elapsed = self.elapsed + elapsed
            if elapsed < 2.6 then
                local alpha = elapsed % 1.3
                if alpha < 0.15 then
                    self:SetAlpha(alpha / 0.15)
                elseif alpha < 0.9 then
                    self:SetAlpha(1 - (alpha - 0.15) / 0.6)
                else
                    self:SetAlpha(0)
                end
            else
                self:Hide()
            end
            self.elapsed = elapsed
        end)
        self.FlashFrame = flasher
    end

    self.FlashFrame:Show()
end

-----------------------------
-- UPDATE FRAME
-----------------------------
local function SetPosition(f)
    local _, _, _, x, y = f:GetPoint()
    C.frame.position = {"TOPLEFT", "UIParent", "TOPLEFT", x, y}
end

local function OnDragStart(f)
    if not C.frame.locked then
        f = f:GetParent()
        f:StartMoving()
    end
end

local function OnDragStop(f)
    if not C.frame.locked then
        f = f:GetParent()
        -- make sure to call before StopMovingOrSizing, or frame anchors will be broken
        -- see https://wowwiki.fandom.com/wiki/API_Frame_StartMoving
        SetPosition(f)
        f:StopMovingOrSizing()

    end
end

local function UpdateSize(f)
    C.frame.width = f:GetWidth() - 2
    C.frame.height = f:GetHeight()

    TC2:SetBarCount()

    for i = 1, 40 do
        if i <= C.bar.count and TC2.threatData[i] then
            TC2.bars[i]:Show()
        else
            TC2.bars[i]:Hide()
        end
    end

    TC2:UpdateFrame()
end

local function OnResizeStart(f)
    TC2.frame.header:SetMovable(false)
    f = f:GetParent()
    f:SetMinResize(64, C.bar.height)
    f:SetMaxResize(512, 1024)
    TC2.sizing = true
    f:SetScript("OnSizeChanged", UpdateSize)
    f:StartSizing()
end

local function OnResizeStop(f)
    TC2.frame.header:SetMovable(true)
    f = f:GetParent()
    TC2.sizing = false
    f:SetScript("OnSizeChanged", nil)
    f:StopMovingOrSizing()
end

local function UpdateFont(fs)
    fs:SetFont(LSM:Fetch("font", C.font.name), C.font.size, C.font.style)
    fs:SetVertexColor(unpack(C.font.color))
    fs:SetShadowOffset(C.font.shadow and 1 or 0, C.font.shadow and -1 or 0)
end

function TC2:SetBarCount()
    C.bar.count = min(floor(C.frame.height / (C.bar.height + C.bar.padding - 1)), 40)
end

function TC2:UpdateFrame()
    local frame = self.frame

    if not TC2.sizing then
        frame:SetSize(C.frame.width + 2, C.frame.height)
    end
    frame:ClearAllPoints()
    frame:SetPoint(unpack(C.frame.position))
    frame:SetScale(C.frame.scale)
    frame:SetFrameStrata(strsub(C.frame.strata, 3))

    if not C.frame.locked then
        frame:SetMovable(true)
        frame:SetResizable(true)
        frame:SetClampedToScreen(true)

        frame.resize:Show()
        frame.resize:EnableMouse(true)
        frame.resize:SetMovable(true)
        frame.resize:RegisterForDrag("LeftButton")
        frame.resize:SetScript("OnDragStart", OnResizeStart)
        frame.resize:SetScript("OnDragStop", OnResizeStop)

        frame.header:SetMovable(true)
        frame.header:SetClampedToScreen(true)
        frame.header:RegisterForDrag("LeftButton")
        frame.header:SetScript("OnDragStart", OnDragStart)
        frame.header:SetScript("OnDragStop", OnDragStop)
    else
        frame:SetMovable(false)
        frame:SetResizable(false)
        frame.resize:Hide()
        frame.resize:SetMovable(false)
        frame.header:SetMovable(false)
    end

    -- Background
    frame.bg:SetAllPoints()
    frame.bg:SetVertexColor(unpack(C.frame.color))
    -- Header
    if C.frame.headerShow then
        frame.header:SetSize(C.frame.width + 2, C.bar.height)
        frame.header:SetStatusBarTexture(LSM:Fetch("statusbar", C.bar.texture))
        frame.header:ClearAllPoints()
        if C.frame.growUp then
            frame.header:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0)
        else
            frame.header:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
        end
        frame.header:SetStatusBarColor(unpack(C.frame.headerColor))

        frame.header:SetBackdropColor(0, 0, 0, 0)
        frame.header:SetBackdropBorderColor(0, 0, 0, 0)
        frame.header.edgeBackdrop:SetBackdropColor(0, 0, 0, 0)
        frame.header.edgeBackdrop:SetBackdropBorderColor(0, 0, 0, C.frame.headerColor[4]) -- adjust alpha for border

        frame.header.text:SetText(format("%s%s", L.gui_threat, ""))

        UpdateFont(frame.header.text)

        frame.header:Show()
    else
        frame.header:Hide()
    end

    self:UpdateBars()
end

function TC2:UpdateBars()
    -- get up-to-date backdrop and edgeBackdrop settings
    local backdrop = {
        bgFile = LSM:Fetch("statusbar", C.backdrop.bgTexture),
        tile = C.backdrop.tile,
        tileSize = C.backdrop.tileSize,
        insets = {
            left = C.backdrop.inset,
            right = C.backdrop.inset,
            top = C.backdrop.inset,
            bottom = C.backdrop.inset,
        },
    }
    local edgeBackdrop = {
        edgeFile = LSM:Fetch("border", C.backdrop.edgeTexture),
        edgeSize = C.backdrop.edgeSize,
        insets = {
            left = C.backdrop.inset,
            right = C.backdrop.inset,
            top = C.backdrop.inset,
            bottom = C.backdrop.inset,
        },
    }
    for i = 1, 40 do
        if not self.bars[i] then
            self.bars[i] = CreateStatusBar(self.frame)
        end

        local bar = self.bars[i]

        bar:SetBackdrop(backdrop)
        bar:SetBackdropColor(unpack(C.backdrop.bgColor))
        bar:SetBackdropBorderColor(0,0,0,0)
        bar.edgeBackdrop:SetBackdrop(edgeBackdrop)
        bar.edgeBackdrop:SetBackdropColor(0,0,0,0)
        bar.edgeBackdrop:SetBackdropBorderColor(unpack(C.backdrop.edgeColor))
        
        bar:ClearAllPoints()
        if i == 1 then
            if C.frame.growUp then
                bar:SetPoint("BOTTOM", self.frame, "BOTTOM", 0, 0)
            else
                bar:SetPoint("TOP", self.frame, "TOP", 0, 0)
            end
        else
            if C.frame.growUp then
                bar:SetPoint("BOTTOM", self.bars[i - 1], "TOP", 0, -C.bar.padding + 1)
            else
                bar:SetPoint("TOP", self.bars[i - 1], "BOTTOM", 0, -C.bar.padding + 1)
            end
        end
        bar:SetSize(C.frame.width + 2, C.bar.height)

        bar:SetStatusBarTexture(LSM:Fetch("statusbar", C.bar.texture))

        -- BG
        bar.bg:SetTexture(LSM:Fetch("statusbar", C.bar.texture))
        -- ignite
        bar.ignite:SetSize(C.igniteIndicator.size, C.igniteIndicator.size)
        bar.ignite:Hide()
        -- Name
        bar.name:SetPoint("LEFT", bar, 4, 0)
        UpdateFont(bar.name)
        -- Value
        -- bar.val:SetPoint("RIGHT", bar, -40, 0)
        bar.val:SetPoint("RIGHT", bar, -(C.font.size * 3.5), 0)
        UpdateFont(bar.val)
        if C.bar.showThreatValue then
            bar.val:Show()
        else
            bar.val:Hide()
        end
        -- Perc
        bar.perc:SetPoint("RIGHT", bar, -2, 0)
        UpdateFont(bar.perc)
        if C.bar.showThreatPercentage then
            bar.perc:Show()
        else
            bar.perc:Hide()
        end

        -- Adjust anchor points
        if C.bar.showThreatValue then
            -- move val to the right if percentage isn't shown
            if not C.bar.showThreatPercentage then
                bar.val:SetPoint("RIGHT", bar, -2, 0)
            end
             -- right point of name is left point of value
            bar.name:SetPoint("RIGHT", bar.val, "LEFT", -10, 0)
        else
            if C.bar.showThreatPercentage then
                 -- right point of name is left point of perc
                bar.name:SetPoint("RIGHT", bar.perc, "LEFT", -10, 0)
            else
                -- anchor to right of bar
                bar.name:SetPoint("RIGHT", bar, "RIGHT", -10, 0)
            end
        end
    end
    self:UpdateThreatBars()
end

-----------------------------
-- TEST MODE
-----------------------------
function TC2:TestMode()
    if UnitAffectingCombat("player") then return end

    C.frame.test = true
    wipe(TC2.threatData)
    for i = 1, C.bar.count do
        self.threatData[i] = {
            unit = self.playerName,
            threatPercent = i / C.bar.count * 100,
            threatValue = i * 1e4,
        }
        tinsert(self.bars, i)
    end
    self:UpdateThreatBars()
end

-----------------------------
-- VERSION CHECK
-----------------------------

function TC2:OnCommReceived(prefix, message, distribution, sender)
    if prefix == "TC2" then
        local cmd, value = strmatch(message, "^(.*)::(.*)$")
        if cmd == "VERSION" then
            if self.version < value and not announcedOutdated then
                announcedOutdated = true
                C_Timer.After(2, function() print(L.message_outdated) end)
            end
        elseif cmd == "INCOMPATIBLE" then
            if self.version < value and not announcedIncompatible then
                announcedIncompatible = true
                C_Timer.After(3, function() print(L.message_incompatible) end)
            end
        end
    end
end

function TC2:PublishVersion()
    if IsInGuild() then
        self:SendCommMessage(self.commPrefix, "VERSION::"..self.version, "GUILD")
    end
end

-----------------------------
-- EVENTS
-----------------------------
TC2.frame = CreateFrame("Frame", TC2.addonName.."BarFrame", UIParent)

TC2.frame:RegisterEvent("PLAYER_LOGIN")
TC2.frame:SetScript("OnEvent", function(self, event, ...)
    return TC2[event] and TC2[event](TC2, event, ...)
end)
TC2.frame:SetScript("OnUpdate", function(self, elapsed)
    if GetTime() > lastCheckStatusTime + C.general.updateFreq then
        -- always check status in interval if the playerTarget is set to targettarget (i.e. direct traget is friendly)
        -- because THREAT_LIST_UPDATE does not trigger for targettarget. Also the threat api only works in combat
        if callCheckStatus or (TC2.playerTarget == "targettarget" and UnitAffectingCombat("player")) then
            CheckStatus()
        end
    end
end)

function TC2:PLAYER_ENTERING_WORLD(...)
    self.playerName = UnitName("player")
    self.playerClass = select(2, _G.UnitClass("player"))
    self.numGroupMembers = IsInRaid() and GetNumGroupMembers() or GetNumSubgroupMembers()

    CheckStatus()
end

function TC2:PLAYER_TARGET_CHANGED(...)
    UpdatePlayerTarget()
    -- reset last warning on target change
    lastWarnPercent = 100

    C.frame.test = false
    CheckStatus()
end

TC2.UNIT_TARGET = TC2.PLAYER_TARGET_CHANGED

function TC2:GROUP_ROSTER_UPDATE(...)
    self.numGroupMembers = IsInRaid() and GetNumGroupMembers() or GetNumSubgroupMembers()

    CheckStatusDeferred()
end

function TC2:ZONE_CHANGED_NEW_AREA(...)
    CheckStatus()
end

function TC2:PLAYER_REGEN_DISABLED(...)
    UpdatePlayerTarget() -- for friendly mobs that turn hostile like vaelastrasz
    lastWarnPercent = 100
    C.frame.test = false
    CheckStatus()
end

function TC2:PLAYER_REGEN_ENABLED(...)
    -- collectgarbage()
    C.frame.test = false
    CheckStatus()
end

function TC2:UNIT_THREAT_LIST_UPDATE(event, unitTarget)
    C.frame.test = false
    if TC2.playerTarget == unitTarget then
        CheckStatusDeferred()
    end
end

function TC2:PLAYER_LOGIN()

    -- creates by default character specific profile, when 3rd argument is obmitted
    self.db = LibStub("AceDB-3.0"):New("ThreatClassic2DB", self.defaultConfig, true)

    C = self.db.profile

    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshProfile")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshProfile")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshProfile")

    self:SetBarCount()
    self:SetupUnits()
    self:SetupFrame()
    self:SetupMenu()

    -- Get Colors
    TC2.colorFallback = {0.8, 0, 0.8, C.bar.alpha}

    -- Test Mode
    C.frame.test = false

    if C.general.welcome then
        print("|c00FFAA00"..self.addonName.." v"..self.version.." - "..L.message_welcome.."|r")
    end
    self:RegisterComm(self.commPrefix)
    self:PublishVersion()

    self.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.frame:RegisterEvent("GROUP_ROSTER_UPDATE")
    self.frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self.frame:RegisterEvent("PLAYER_TARGET_CHANGED")
    self.frame:RegisterUnitEvent("UNIT_TARGET", "target")
    self.frame:RegisterEvent("PLAYER_REGEN_DISABLED")
    self.frame:RegisterEvent("PLAYER_REGEN_ENABLED")

    self.frame:RegisterEvent("UNIT_THREAT_LIST_UPDATE")

    -- Setup Config
    self:SetupConfig()

    self.frame:UnregisterEvent("PLAYER_LOGIN")
    self.PLAYER_LOGIN = nil
end

-----------------------------
-- SETUP
-----------------------------
function TC2:SetupUnits()
    self.partyUnits = {}
    self.partyPetUnits = {}
    self.raidUnits = {}
    self.raidPetUnits = {}
    for i = 1, 4 do
        self.partyUnits[i] = format("party%d", i)
        self.partyPetUnits[i] = format("partypet%d", i)
    end
    for i = 1, 40 do
        self.raidUnits[i] = format("raid%d", i)
        self.raidPetUnits[i] = format("raidpet%d", i)
    end
end

function TC2:SetupFrame()
    self.frame:SetFrameLevel(1)
    self.frame:ClearAllPoints()
    self.frame:SetPoint(unpack(C.frame.position))

    self.frame.bg = self.frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    self.frame.bg:SetColorTexture(1, 1, 1, 1)

    self.frame.resize = CreateFrame("Frame", self.addonName.."Resize", self.frame)
    self.frame.resize:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", 0, 0)
    self.frame.resize:SetSize(12, 12)
    self.frame.resizeTexture = self.frame.resize:CreateTexture()
    self.frame.resizeTexture:SetTexture([[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Up]])
    self.frame.resizeTexture:SetDesaturated(true)
    self.frame.resizeTexture:SetPoint("TOPLEFT", self.frame.resize)
    self.frame.resizeTexture:SetPoint("BOTTOMRIGHT", self.frame.resize, "BOTTOMRIGHT", 0, 0)

    -- Setup Header
    self.frame.header = CreateStatusBar(self.frame, true)
    self.frame.header:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" then
            EasyMenu(TC2.menuTable, TC2.menu, "cursor", 0, 0, "MENU")
        end
    end)
    self.frame.header:EnableMouse(true)

    self.frame.header.text = CreateFS(self.frame.header)
    self.frame.header.text:SetPoint("LEFT", self.frame.header, 4, -1)
    self.frame.header.text:SetJustifyH("LEFT")

    self:UpdateFrame()
end

function TC2:SetupMenu()
    self.menu = CreateFrame("Frame", self.addonName.."MenuFrame", UIParent, "UIDropDownMenuTemplate")

    TC2.menuTable = {
        {text = L.frame_lock, notCheckable = false, checked = function() return C.frame.locked end, func = function()
            C.frame.locked = not C.frame.locked
            TC2:UpdateFrame()
        end},
        {text = L.frame_test, notCheckable = false, checked = function() return C.frame.test end, func = function()
            C.frame.test = not C.frame.test
            if C.frame.test then
                TC2:TestMode()
            else
                CheckStatus()
            end
        end},
        {text = L.gui_config, notCheckable = true, func = function()
            LibStub("AceConfigDialog-3.0"):Open("ThreatClassic2")
        end},
    }
end

-----------------------------
-- CONFIG
-----------------------------
function TC2:SetupConfig()
    self.configTable.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(TC2.addonName, self.configTable)

    local ACD = LibStub("AceConfigDialog-3.0")
    self.config = {}
    self.config.general = ACD:AddToBlizOptions(TC2.addonName, TC2.addonName, nil, "general")
    self.config.appearance = ACD:AddToBlizOptions(TC2.addonName, L.appearance, TC2.addonName, "appearance")
    self.config.appearance = ACD:AddToBlizOptions(TC2.addonName, L.filter, TC2.addonName, "filter")
    self.config.warnings = ACD:AddToBlizOptions(TC2.addonName, L.warnings, TC2.addonName, "warnings")
    self.config.profiles = ACD:AddToBlizOptions(TC2.addonName, L.profiles, TC2.addonName, "profiles")
end

function TC2:RefreshProfile()
    C = self.db.profile
    CheckVisibility()
    TC2:UpdateFrame()
end

TC2.configTable = {
    type = "group",
    name = TC2.addonName,
    get = function(info)
        return C[info[1]][info[2]]
    end,
    set = function(info, value) C[info[1]][info[2]] = value end,
    args = {
        general = {
            order = 1,
            type = "group",
            name = L.general,
            args = {
                general = {
                    order = 1,
                    name = L.general,
                    type = "header",
                },
                welcome = {
                    order = 2,
                    name = L.general_welcome,
                    type = "toggle",
                    width = "full",
                },
                rawPercent = {
                    order = 3,
                    name = L.general_rawPercent,
                    type = "toggle",
                    width = "full",
                },
                downscaleThreat = {
                    order = 4,
                    name = L.general_downscaleThreat,
                    desc = L.general_downscaleThreatDesc,
                    type = "toggle",
                    width = "full",
                },
                updateFreq = {
                    order = 5,
                    name = L.general_updateFreq,
                    desc = L.general_updateFreq_desc,
                    type = "range",
                    width = "double",
                    min = 0.05,
                    max = 1,
                    step = 0.01,
                    bigStep = 0.05,
                },
                --[[
                minimap = {
                    order = 3,
                    name = L.general_test,
                    type = "toggle",
                    width = "full",
                },
                --]]
                --[[
                ignorePets = {
                    order = 4,
                    name = L.general_ignorePets,
                    type = "toggle",
                    width = "full",
                },
                --]]
                visibility = {
                    order = 5,
                    name = L.visibility,
                    type = "header",
                },
                hideOOC = {
                    order = 6,
                    name = L.visibility_hideOOC,
                    type = "toggle",
                    width = "full",
                    set = function(info, value)
                        C[info[1]][info[2]] = value
                        CheckStatus()
                    end,
                },
                hideSolo = {
                    order = 7,
                    name = L.visibility_hideSolo,
                    type = "toggle",
                    width = "full",
                    set = function(info, value)
                        C[info[1]][info[2]] = value
                        CheckStatus()
                    end,
                },
                hideInPVP = {
                    order = 8,
                    name = L.visibility_hideInPvP,
                    type = "toggle",
                    width = "full",
                    set = function(info, value)
                        C[info[1]][info[2]] = value
                        CheckStatus()
                    end,
                },
                hideOpenWorld = {
                    order = 9,
                    name = L.visibility_hideOpenWorld,
                    type = "toggle",
                    width = "full",
                    set = function(info, value)
                        C[info[1]][info[2]] = value
                        CheckStatus()
                    end,
                },
                hideAlways = {
                    order = 10,
                    name = L.visibility_hideAlways,
                    type = "toggle",
                    width = "full",
                    set = function(info, value)
                        C[info[1]][info[2]] = value
                        CheckStatus()
                    end,
                },
            },
        },
        appearance = {
            order = 2,
            type = "group",
            name = L.appearance,
            get = function(info)
                return C[info[2]][info[3]]
            end,
            set = function(info, value)
                C[info[2]][info[3]] = value
                TC2:UpdateFrame()
            end,
            args = {
                frame = {
                    order = 1,
                    name = L.frame,
                    type = "group",
                    inline = true,
                    args = {
                        test = {
                            order = 1,
                            name = L.frame_test,
                            type = "execute",
                            func = function(info, value)
                                C.frame.test = not C.frame.test
                                if C.frame.test then
                                    TC2:TestMode()
                                else
                                    wipe(TC2.threatData)
                                    CheckStatus()
                                end
                            end,
                        },
                        locked = {
                            order = 2,
                            name = L.frame_lock,
                            type = "toggle",
                        },
                        strata = {
                            order = 3,
                            name = L.frame_strata,
                            type = "select",
                            values = {
                                ["1-BACKGROUND"] = "BACKGROUND",
                                ["2-LOW"] = "LOW",
                                ["3-MEDIUM"] = "MEDIUM",
                                ["4-HIGH"] = "HIGH",
                                ["5-DIALOG"] = "DIALOG",
                                ["6-FULLSCREEN"] = "FULLSCREEN",
                                ["7-FULLSCREEN_DIALOG"] = "FULLSCREEN_DIALOG",
                                ["8-TOOLTIP"] = "TOOLTIP",
                            },
                            style = "dropdown",
                        },
                        -- width here
                        headerShow = {
                            order = 4,
                            name = L.frame_headerShow,
                            type = "toggle",
                        },
                        framePosition = {
                            order = 5,
                            name = L.frame_position,
                            type = "group",
                            inline = true,
                            args = {
                                width = {
                                    order = 3,
                                    name = L.frame_width,
                                    type = "range",
                                    min = 64,
                                    max = 1024,
                                    step = 0.01,
                                    bigStep = 1,
                                    get = function(info)
                                        return C[info[2]][info[4]]
                                    end,
                                    set = function(info, value)
                                        C[info[2]][info[4]] = value
                                        TC2:SetBarCount()
                                        TC2:UpdateFrame()
                                    end,
                                },
                                height = {
                                    order = 4,
                                    name = L.frame_height,
                                    type = "range",
                                    min = 10,
                                    max = 1024,
                                    step = 0.01,
                                    bigStep = 1,
                                    get = function(info)
                                        return C[info[2]][info[4]]
                                    end,
                                    set = function(info, value)
                                        C[info[2]][info[4]] = value
                                        TC2:SetBarCount()
                                        TC2:UpdateFrame()
                                    end,
                                },
                                xOffset = {
                                    order = 5,
                                    name = L.frame_xOffset,
                                    type = "range",
                                    softMin = 0,
                                    softMax = screenWidth,
                                    step = 0.01,
                                    bigStep = 1,
                                    get = function(info)
                                        return C[info[2]].position[4]
                                    end,
                                    set = function(info, value)
                                        C[info[2]].position[4] = value
                                        TC2:UpdateFrame()
                                    end,
                                },
                                yOffset = {
                                    order = 5,
                                    name = L.frame_yOffset,
                                    type = "range",
                                    softMin = -screenHeight,
                                    softMax = 0,
                                    step = 0.01,
                                    bigStep = 1,
                                    get = function(info)
                                        return C[info[2]].position[5]
                                    end,
                                    set = function(info, value)
                                        C[info[2]].position[5] = value
                                        TC2:UpdateFrame()
                                    end,
                                },
                            },
                        },
                        scale = {
                            order = 5,
                            name = L.frame_scale,
                            type = "range",
                            min = 50,
                            max = 300,
                            step = 1,
                            bigStep = 10,
                            get = function(info)
                                return C[info[2]][info[3]] * 100
                            end,
                            set = function(info, value)
                                C[info[2]][info[3]] = value / 100
                                TC2:UpdateFrame()
                            end,
                        },
                        growUp = {
                            order = 6,
                            name = L.frame_growup,
                            type = "toggle",
                        },
                        frameColors = {
                            order = 7,
                            name = L.color,
                            type = "group",
                            inline = true,
                            get = function(info)
                                return unpack(C[info[2]][info[4]])
                            end,
                            set = function(info, r, g, b, a)
                                local cfg = C[info[2]][info[4]]
                                cfg[1] = r
                                cfg[2] = g
                                cfg[3] = b
                                cfg[4] = a
                                TC2:UpdateFrame()
                            end,

                            args = {
                                color = {
                                    order = 1,
                                    name = L.frame_bg,
                                    type = "color",
                                    hasAlpha = true,
                                },
                                headerColor = {
                                    order = 2,
                                    name = L.frame_header,
                                    type = "color",
                                    hasAlpha = true,
                                },
                            },
                        },
                    },
                },
                bar = {
                    order = 2,
                    name = L.bar,
                    type = "group",
                    inline = true,
                    args = {
                        height = {
                            order = 3,
                            name = L.bar_height,
                            type = "range",
                            min = 6,
                            max = 64,
                            step = 1,
                        },
                        padding = {
                            order = 4,
                            name = L.bar_padding,
                            type = "range",
                            min = 0,
                            max = 16,
                            step = 1,
                        },
                        alpha = {
                            order = 5,
                            name = L.bar_alpha,
                            type = "range",
                            min = 0,
                            max = 1,
                            step = 0.01,
                        },
                        texture = {
                            order = 6,
                            name = L.bar_texture,
                            type = "select",
                            dialogControl = 'LSM30_Statusbar',
                            values = AceGUIWidgetLSMlists.statusbar,
                        },
                        border = {
                            order = 7,
                            name = L.backdrop_edge,
                            type = "header",
                        },
                        edgeColor = {
                            order = 8,
                            name = L.backdrop_edgeColor,
                            type = "color",
                            hasAlpha = true,
                            get = function(info)
                                return unpack(C.backdrop.edgeColor)
                            end,
                            set = function(info, r, g, b, a)
                                local cfg = C.backdrop.edgeColor
                                cfg[1] = r
                                cfg[2] = g
                                cfg[3] = b
                                cfg[4] = a
                                TC2:UpdateFrame()
                            end,
                        },
                        edgeTexture = {
                            order = 9,
                            name = L.backdrop_edgeTexture,
                            type = "select",
                            dialogControl = 'LSM30_Border',
                            values = AceGUIWidgetLSMlists.border,
                            get = function(info)
                                return C.backdrop.edgeTexture
                            end,
                            set = function(info, value)
                                C.backdrop.edgeTexture = value
                                TC2:UpdateFrame()
                            end,
                        },
                        edgeSize = {
                            order = 10,
                            name = L.backdrop_edgeSize,
                            type = "range",
                            min = 1,
                            max = 16,
                            step = 1,
                            get = function(info)
                                return C.backdrop.edgeSize
                            end,
                            set = function(info, value)
                                C.backdrop.edgeSize = value
                                TC2:UpdateFrame()
                            end,
                        },
                        backdrop = {
                            order = 11,
                            name = L.backdrop,
                            type = "header",
                        },
                        backdropBgColor = {
                            order = 12,
                            name = L.backdrop_bgColor,
                            type = "color",
                            hasAlpha = true,
                            get = function(info)
                                return unpack(C.backdrop.bgColor)
                            end,
                            set = function(info, r, g, b, a)
                                local cfg = C.backdrop.bgColor
                                cfg[1] = r
                                cfg[2] = g
                                cfg[3] = b
                                cfg[4] = a
                                TC2:UpdateFrame()
                            end,
                        },
                        backdropBgTexture = {
                            order = 13,
                            name = L.backdrop_bgTexture,
                            type = "select",
                            dialogControl = 'LSM30_Statusbar',
                            values = AceGUIWidgetLSMlists.statusbar,
                            get = function(info)
                                return C.backdrop.bgTexture
                            end,
                            set = function(info, value)
                                C.backdrop.bgTexture = value
                                TC2:UpdateFrame()
                            end,
                        },
                        textOptions = {
                            order = 14,
                            name = L.bar_textOptions,
                            type = "header",
                        },
                        showThreatValue = {
                            order = 15,
                            name = L.bar_showThreatValue,
                            type = "toggle",
                        },
                        showThreatPercentage = {
                            order = 16,
                            name = L.bar_showThreatPercentage,
                            type = "toggle",
                        },
                        showIgniteIndicator = {
                            order = 17,
                            name = L.bar_showIgniteIndicator,
                            desc = L.bar_showIgniteIndicator_desc,
                            type = "toggle",
                        },
                    },
                },
                igniteIndicator = {
                    order = 4,
                    name = L.igniteIndicator,
                    type = "group",
                    inline = true,
                    hidden = function() return not C.bar.showIgniteIndicator end,
                    args = {
                        size = {
                            order = 1,
                            name = L.igniteIndicator_size,
                            type = "range",
                            min = 6,
                            max = 64,
                            step = 0.1,
                        },
                        makeRound = {
                            order = 2,
                            name = L.igniteIndicator_makeRound,
                            desc = L.igniteIndicator_makeRound_desc,
                            type = "toggle",
                        }
                    }
                },
                customBarColors = {
                    order = 5,
                    name = L.customBarColors,
                    type = "group",
                    inline = true,
                    args = {
                        playerEnabled = {
                            order = 1,
                            name = L.customBarColorsPlayer_enabled,
                            desc = L.customBarColorsPlayer_desc,
                            type = "toggle",
                        },
                        activeTankEnabled = {
                            order = 2,
                            name = L.customBarColorsActiveTank_enabled,
                            type = "toggle",
                        },
                        otherUnitEnabled = {
                            order = 3,
                            name = L.customBarColorsOtherUnit_enabled,
                            type = "toggle",
                        },
                        igniteEnabled = {
                            order = 4,
                            name = L.customBarColorsIgnite_enabled,
                            desc = L.customBarColorsIgnite_desc,
                            type = "toggle",
                        },
                        colors = {
                            order = 5,
                            name = L.color,
                            type = "group",
                            inline = false,
                            get = function(info)
                                return unpack(C[info[2]][info[4]])
                            end,
                            set = function(info, r, g, b, a)
                                local cfg = C[info[2]][info[4]]
                                cfg[1] = r
                                cfg[2] = g
                                cfg[3] = b
                                cfg[4] = a
                                TC2:UpdateFrame()
                            end,
                            args = {
                                playerColor = {
                                    order = 1,
                                    name = L.customBarColorsPlayer_color,
                                    type = "color",
                                    hasAlpha = true,
                                },
                                activeTankColor = {
                                    order = 2,
                                    name = L.customBarColorsActiveTank_color,
                                    type = "color",
                                    hasAlpha = true,
                                },
                                otherUnitColor = {
                                    order = 3,
                                    name = L.customBarColorsOtherUnit_color,
                                    type = "color",
                                    hasAlpha = true,
                                },
                                igniteColor = {
                                    order = 4,
                                    name = L.customBarColorsIgnite_color,
                                    type = "color",
                                    hasAlpha = true,
                                },
                            },
                        },
                    },
                },
                font = {
                    order = 5,
                    name = L.font,
                    type = "group",
                    inline = true,
                    args = {
                        size = {
                            order = 2,
                            name = L.font_size,
                            type = "range",
                            min = 6,
                            max = 64,
                            step = 1,
                        },
                        style = {
                            order = 3,
                            name = L.font_style,
                            type = "select",
                            values = {
                                [""] = L.NONE,
                                ["OUTLINE"] = L.OUTLINE,
                                ["THICKOUTLINE"] = L.THICKOUTLINE,
                            },
                            style = "dropdown",
                        },
                        name = {
                            order = 4,
                            name = L.font_name,
                            type = "select",
                            dialogControl = 'LSM30_Font',
                            values = AceGUIWidgetLSMlists.font,
                        },
                        shadow = {
                            order = 5,
                            name = L.font_shadow,
                            type = "toggle",
                            width = "full",
                        },
                    },
                },
                reset = {
                    order = 6,
                    name = L.reset,
                    type = "execute",
                    func = function(info, value)
                        TC2.db.profile = TC2.defaultConfig
                        TC2:UpdateFrame()
                    end,
                },
            },
        },
        filter = {
            order = 3,
            type = "group",
            name = L.filter,
            args = {
                outOfMelee = {
                    order = 1,
                    name = L.filter_outOfMelee,
                    type = "toggle",
                    width = "full",
                },
                useTargetList = {
                    order = 2,
                    name = L.filter_useTargetList,
                    type = "toggle",
                    width = "full",
                },
                targetList = {
                    order = 3,
                    name = L.filter_targetList,
                    desc = L.filter_targetList_desc,
                    type = "input",
                    width = "full",
                    multiline = 8,
                    get = function(info)
                        -- restore insertion order by adding to an array using integer keys
                        sortedTargets = {}
                        for target, index in pairs(C[info[1]][info[2]]) do
                            sortedTargets[index] = target
                        end
                        -- rebuild string
                        targetString = ""
                        for _ , target in pairs(sortedTargets) do
                            targetString = targetString .. target .. "\n"
                        end
                        return targetString
                    end,
                    set = function(info, value)
                        targets = {}
                        num = 1
                        -- built a target set but preserve insertion order information
                        for target in value:gmatch("[^\n]+") do
                            targets[target] = num
                            num = num + 1
                        end
                        C[info[1]][info[2]] = targets
                    end,
                    disabled = function() return not C.filter.useTargetList end,
                },
            },
        },
        warnings = {
            order = 4,
            type = "group",
            name = L.warnings,
            args = {
                disableWhileTanking = {
                    order = 1,
                    name = L.warnings_disableWhileTanking,
                    desc = L.warnings_disableWhileTanking_desc,
                    type = "toggle",
                    width = "full",
                },
                threshold = {
                    order = 2,
                    name = L.warnings_threshold,
                    desc = L.warnings_threshold_desc,
                    type = "range",
                    width = "double",
                    min = 5,
                    softMin = 50,
                    max = 100,
                    step = 1,
                    bigStep = 5,
                },
                minThreatAmount = {
                    order = 3,
                    name = L.warnings_minThreatAmount,
                    desc = L.warnings_minThreatAmount_desc,
                    type = "range",
                    width = "double",
                    min = 1,
                    softMin = 100,
                    softMax = 10000,
                    step = 1,
                    bigStep = 100,
                },
                flash = {
                    order = 4,
                    name = L.warnings_flash,
                    type = "toggle",
                    width = "full",
                },
                sound = {
                    order = 5,
                    name = L.warnings_sound,
                    type = "toggle",
                    width = "full",
                },
                soundFile = {
                    type = "select", dialogControl = 'LSM30_Sound',
                    order = 6,
                    name = L.warnings_soundFile,
                    values = AceGUIWidgetLSMlists.sound,
                    disabled = function() return not C.warnings.sound end,
                },
                soundChannel = {
                    type = "select",
                    order = 7,
                    name = L.warnings_soundChannel,
                    values = SoundChannels,
                    disabled = function() return not C.warnings.sound end,
                },
            },
        },
    },
}

SLASH_TC2_SLASHCMD1 = "/tc2"
SLASH_TC2_SLASHCMD2 = "/threat2"
SLASH_TC2_SLASHCMD2 = "/threatclassic2"
SlashCmdList["TC2_SLASHCMD"] = function(arg)
    arg = arg:lower()

    if arg == "toggle" then
        C.general.hideAlways = not C.general.hideAlways
        CheckStatus();
    elseif arg == "ver" or arg == "version" then
        print("|c00FFAA00"..TC2.addonName.." v"..TC2.version.."|r")
    else
        LibStub("AceConfigDialog-3.0"):Open("ThreatClassic2")
    end
end
