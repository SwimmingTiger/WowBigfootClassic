
------------------------------------------------
-- @DepandsOn: LibStub, LibEvent, LibItemStats
------------------------------------------------

local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibItemStats = LibStub:GetLibrary("LibItemStats.1000")

local GetStatsName = LibItemStats.GetStatsName
local GetStatsValue = LibItemStats.GetStatsValue

STAT_RESISTANCE_ATTRIBUTES = GetStatsName("Resistance")
STAT_SUIT_ATTRIBUTES = GetStatsName("Suit")

--赋数据
local function SetStats(self, data)
    self.data = data or {}
    return self
end

--创建单条属性按钮框体
local function CreateStatFrame(parent, index, key, option)
    local frame = CreateFrame("Frame", nil, parent, "CharacterStatFrameTemplate")
    frame:EnableMouse(false)
    frame:SetWidth(178)
    frame.key = key
    frame.Background:SetShown((index%2) ~= 1)
    parent["stat" .. index] = frame
    return frame
end

--获取可用的属性按钮框体
local function GetStatFrame(self)
    local index = self.maxStaticIndex + 1
    while (self["stat"..index]) do
        if (not self["stat"..index]:IsShown()) then
            return self["stat"..index]
        end
        index = index + 1
    end
    return CreateStatFrame(self, index)
end

--头像框架(装等框架/边框颜色等) @trigger: INSPECT_FRAME_BACKDROP
local ItemLevelPattern = (ITEM_LEVEL_ABBR or "ilvl") .. " %.1f"
local function HandlePortraitFrame(self)
    local ilevel = self.data.ilevel or 0
    local unit = self.data.unit or "player"
    local class = select(2, UnitClass(unit))
    local color = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR
    self.PortraitFrame.Level:SetText(UnitLevel(unit))
    self.PortraitFrame.PortraitRingQuality:SetVertexColor(color.r, color.g, color.b)
    self.PortraitFrame.LevelBorder:SetVertexColor(color.r, color.g, color.b)
    SetPortraitTexture(self.PortraitFrame.Portrait, unit)
    self.PortraitFrame.Name:SetText(UnitName(unit))
    self.PortraitFrame.Name:SetTextColor(color.r, color.g, color.b)
    self.PortraitFrame.ItemLevel:SetText(format(ItemLevelPattern, ilevel))
    self.PortraitFrame.ItemLevel:SetTextColor(1, 0.82, 0)
    self.AttributesCategory.Title:SetTextColor(color.r, color.g, color.b)
    self.ResistanceCategory.Title:SetTextColor(color.r, color.g, color.b)
    self.EnhancementsCategory.Title:SetTextColor(color.r, color.g, color.b)
    self.SuitCategory.Title:SetTextColor(color.r, color.g, color.b)
    LibEvent:trigger("INSPECT_FRAME_BACKDROP", self)
    self:SetBackdrop(self.backdrop)
    self:SetBackdropColor(0, 0, 0, 0.88)
    self:SetBackdropBorderColor(color.r, color.g, color.b)
end


function ClassicStatsFrameTemplate_Onload(self)
    self.backdrop = {
        bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile     = true,
        tileSize = 8,
        edgeSize = 16,
        insets   = {left = 4, right = 4, top = 4, bottom = 4}
    }
    self:SetBackdrop(self.backdrop)
    self:SetBackdropColor(0, 0, 0, 0.88)
    self.SetStats = SetStats
    local index, keys = 1, ","
    local frame, anchor
    --基础 力/敏/耐/智/精/护甲
    self.AttributesCategory:SetScale(0.9)
    self.AttributesCategory.Background:SetAlpha(0.6)
    anchor = self.AttributesCategory
    for _, key in ipairs({"Strength","Agility","Stamina","Intellect","Spirit","Armor"}) do
        frame = CreateStatFrame(self, index, key)
        frame:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, 0)
        anchor = frame
        index = index + 1
        keys = keys .. key .. ","
    end
    --抗性 奥/火/自然/冰霜/暗影/神圣
    self.ResistanceCategory:SetScale(0.9)
    self.ResistanceCategory.Background:SetAlpha(0.6)
    self.ResistanceCategory:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, 0)
    anchor = self.ResistanceCategory
    local colors = {{0.9,0.1,0.1},{0,0.9,0.3},{0,0.7,0.7},{1,0.3,0.9},{0.7,0,0.4},{0.9,0.5,0.1}}
    for i, key in ipairs({"ResistanceFire","ResistanceNature","ResistanceFrost","ResistanceArcane","ResistanceShadow","ResistanceHoly"}) do
        frame = CreateStatFrame(self, index, key)
        frame:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, 0)
        frame.Label:SetTextColor(unpack(colors[i]))
        anchor = frame
        index = index + 1
        keys = keys .. key .. ","
    end
    --记录固值的index值
    self.maxStaticIndex = index - 1
    self.allStaticKeys = keys
    --加强属性
    self.EnhancementsCategory:SetScale(0.9)
    self.EnhancementsCategory.Background:SetAlpha(0.6)
    self.EnhancementsCategory:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, 0)
    --套装
    self.SuitCategory:SetScale(0.9)
    self.SuitCategory.Background:SetAlpha(0.6)
    for i = index, self.maxStaticIndex + 16 do
        CreateStatFrame(self, i)
    end
end

function ClassicStatsFrameTemplate_OnShow(self)
    local button
    local height = 66 + 36*3 + 15*self.maxStaticIndex
    HandlePortraitFrame(self)
    for i = 1, self.maxStaticIndex do
        button = self["stat"..i]
        button.Label:SetText(GetStatsName(button.key))
        button.Value:SetText(GetStatsValue(button.key, self.data.static))
        button:Show()
    end
    local hasEnhancements = false
    local offset = 0
    for k, v in pairs(self.data.static) do
        if (not strfind(self.allStaticKeys, ","..k..",")) then
            button = GetStatFrame(self)
            button.Label:SetText(GetStatsName(k))
            button.Value:SetText(GetStatsValue(k, self.data.static))
            button:Show()
            button:SetPoint("TOPLEFT", self.EnhancementsCategory, "BOTTOMLEFT", 0, offset)
            height = height + 15
            offset = offset - 15
            hasEnhancements = true
        end
    end
    local hasSuit = self.data.suit
    if (hasSuit) then
        if (not hasEnhancements) then
            offset = offset + 36
        end
        self.SuitCategory:Show()
        self.SuitCategory:SetPoint("TOPLEFT", self.EnhancementsCategory, "BOTTOMLEFT", 0, offset)
        height = height + 36
        offset = offset - 36
        for _, v in ipairs(self.data.suit) do
            button = GetStatFrame(self)
            button.Label:SetText(v.colorStr .. v.value)
            button:Show()
            button:SetPoint("TOPLEFT", self.EnhancementsCategory, "BOTTOMLEFT", 0, offset)
            height = height + 15
            offset = offset - 15
        end
    else
        self.SuitCategory:Hide()
    end
    if (hasEnhancements) then
        self.EnhancementsCategory:Show()
    else
        self.EnhancementsCategory:Hide()
    end
    height = max(height, 424)
    self:SetHeight(height)
end

function ClassicStatsFrameTemplate_OnHide(self)
    local index = 1
    while (self["stat"..index]) do
        self["stat"..index].Label:SetText("")
        self["stat"..index].Value:SetText("")
        self["stat"..index]:Hide()
        index = index + 1
    end
end
