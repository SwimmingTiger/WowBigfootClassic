
-------------------------------------
-- 查看装备等级 Author: M
-------------------------------------

local locale = GetLocale()

local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.1000")
local LibItemStats = LibStub:GetLibrary("LibItemStats.1000")

--裝備清單
local slots = {
    { index = 1, name = HEADSLOT, },
    { index = 2, name = NECKSLOT, },
    { index = 3, name = SHOULDERSLOT, },
    { index = 5, name = CHESTSLOT, },
    { index = 6, name = WAISTSLOT, },
    { index = 7, name = LEGSSLOT, },
    { index = 8, name = FEETSLOT, },
    { index = 9, name = WRISTSLOT, },
    { index = 10, name = HANDSSLOT, },
    { index = 11, name = FINGER0SLOT, },
    { index = 12, name = FINGER1SLOT, },
    { index = 13, name = TRINKET0SLOT, },
    { index = 14, name = TRINKET1SLOT, },
    { index = 15, name = BACKSLOT, },
    { index = 16, name = MAINHANDSLOT, },
    { index = 17, name = SECONDARYHANDSLOT, },
    { index = 18, name = RANGEDSLOT, },
}

--創建面板
local function GetInspectItemListFrame(parent)
    if (not parent.inspectFrame) then
        local itemfont = "ChatFontNormal"
        local frame = CreateFrame("Frame", nil, parent)
        frame.backdrop = {
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile     = true,
            tileSize = 8,
            edgeSize = 16,
            insets   = {left = 4, right = 4, top = 4, bottom = 4}
        }
        local height = 424
        frame:SetSize(160, height)
        --frame:SetFrameLevel(0)
        frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, 0)
        frame:SetBackdrop(frame.backdrop)
        frame:SetBackdropColor(0, 0, 0, 0.8)
        frame:SetBackdropBorderColor(0.6, 0.6, 0.6)
        frame.portrait = CreateFrame("Frame", nil, frame, "ClassicGarrisonFollowerPortraitTemplate")
        frame.portrait:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -16)
        frame.portrait:SetScale(0.8)
        frame.title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLargeOutline")
        frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 66, -18)
        frame.level = frame:CreateFontString(nil, "ARTWORK", itemfont)
        frame.level:SetPoint("TOPLEFT", frame, "TOPLEFT", 66, -42)
        frame.level:SetFont(frame.level:GetFont(), 12, "THINOUTLINE")
        
        local itemframe
        local fontsize = locale:sub(1,2) == "zh" and 12 or 9
        local backdrop = {
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            tile     = true,
            tileSize = 8,
            edgeSize = 1,
            insets   = {left = 1, right = 1, top = 1, bottom = 1}
        }
        for i, v in ipairs(slots) do
            itemframe = CreateFrame("Button", nil, frame)
            itemframe:SetSize(120, (height-80)/#slots)
            itemframe.index = v.index
            itemframe.backdrop = backdrop
            if (i == 1) then
                itemframe:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -68)
            else
                itemframe:SetPoint("TOPLEFT", frame["item"..(i-1)], "BOTTOMLEFT")
            end
            itemframe.label = CreateFrame("Frame", nil, itemframe)
            itemframe.label:SetSize(38, 16)
            itemframe.label:SetPoint("LEFT")
            itemframe.label:SetBackdrop(backdrop)
            itemframe.label:SetBackdropBorderColor(0, 0.9, 0.9, 0.2)
            itemframe.label:SetBackdropColor(0, 0.9, 0.9, 0.2)
            itemframe.label.text = itemframe.label:CreateFontString(nil, "ARTWORK")
            itemframe.label.text:SetFont(UNIT_NAME_FONT, fontsize, "THINOUTLINE")
            itemframe.label.text:SetSize(34, 14)
            itemframe.label.text:SetPoint("CENTER", 1, 0)
            itemframe.label.text:SetText(v.name)
            itemframe.label.text:SetTextColor(0, 0.9, 0.9)
            itemframe.levelString = itemframe:CreateFontString(nil, "ARTWORK", itemfont)
            itemframe.levelString:SetPoint("LEFT", itemframe.label, "RIGHT", 4, 0)
            itemframe.levelString:SetJustifyH("RIGHT")
            itemframe.itemString = itemframe:CreateFontString(nil, "ARTWORK", itemfont)
            itemframe.itemString:SetFont(itemframe.itemString:GetFont(), 13, "NONE")
            itemframe.itemString:SetHeight(16)
            itemframe.itemString:SetPoint("LEFT", itemframe.levelString, "RIGHT", 2, 0)
            itemframe:SetScript("OnEnter", function(self)
                local r, g, b, a = self.label:GetBackdropColor()
                self.label:SetBackdropColor(r, g, b, a+0.5)
                if (self.link or (self.level and self.level > 0)) then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetInventoryItem(self:GetParent().unit, self.index)
                    GameTooltip:Show()
                end
            end)
            itemframe:SetScript("OnLeave", function(self)
                local r, g, b, a = self.label:GetBackdropColor()
                self.label:SetBackdropColor(r, g, b, abs(a-0.5))
                GameTooltip:Hide()
            end)
            itemframe:SetScript("OnDoubleClick", function(self)
                if (self.link) then
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_InsertLink(self.link)
                end
            end)
            frame["item"..i] = itemframe
            LibEvent:trigger("INSPECT_ITEMFRAME_CREATED", itemframe)
        end
        
        frame.closeButton = CreateFrame("Button", nil, frame)
        frame.closeButton:SetSize(12, 12)
        frame.closeButton:SetScale(0.85)
        frame.closeButton:SetPoint("BOTTOMLEFT", 5, 6)
        frame.closeButton:SetNormalTexture("Interface\\Cursor\\Item")
        frame.closeButton:GetNormalTexture():SetTexCoord(0, 12/32, 12/32, 0)
        frame.closeButton:SetScript("OnClick", function(self)
            self:GetParent():Hide()
        end)

        parent:HookScript("OnHide", function(self) frame:Hide() end)
        parent.inspectFrame = frame
        LibEvent:trigger("INSPECT_FRAME_CREATED", frame, parent)
    end

    return parent.inspectFrame
end

--等級字符
local ItemLevelPattern = (ITEM_LEVEL_ABBR or "ItemLevel") .. " %.1f"

--顯示面板
function ShowInspectItemListFrame(unit, parent, ilevel, maxLevel)
    if (not parent:IsShown()) then return end
    local frame = GetInspectItemListFrame(parent)
    local class = select(2, UnitClass(unit))
    local color = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR
    frame.unit = unit
    frame.portrait.Level:SetText(UnitLevel(unit))
    frame.portrait.PortraitRingQuality:SetVertexColor(color.r, color.g, color.b)
    frame.portrait.LevelBorder:SetVertexColor(color.r, color.g, color.b)
    SetPortraitTexture(frame.portrait.Portrait, unit)
    frame.title:SetText(UnitName(unit))
    frame.title:SetTextColor(color.r, color.g, color.b)
    frame.level:SetText(format(ItemLevelPattern, ilevel))
    frame.level:SetTextColor(1, 0.82, 0)
    local _, name, level, link, quality
    local itemframe, mframe, oframe, itemwidth
    local width = 160
    local formats = "%2s"
    if (maxLevel and maxLevel > 0) then
        formats = "%" .. string.len(floor(maxLevel)) .. "s"
    end
    for i, v in ipairs(slots) do
        level, name, link, quality = LibItemInfo:GetUnitItemIndexLevel(unit, v.index)
        itemframe = frame["item"..i]
        itemframe.name = name
        itemframe.link = link
        itemframe.level = level
        itemframe.quality = quality
        itemframe.itemString:SetWidth(0)
        if (level > 0) then
            itemframe.levelString:SetText(format(formats,level))
            itemframe.itemString:SetText(link or name)
            itemframe:SetAlpha(1)
        else
            itemframe.levelString:SetText(format(formats,""))
            itemframe.itemString:SetText("")
            if (not link) then itemframe:SetAlpha(0.5) end
        end
        itemwidth = itemframe.itemString:GetWidth()
        if (itemwidth > 208) then
            itemwidth = 208
            itemframe.itemString:SetWidth(itemwidth)
        end
        itemframe.width = itemwidth + max(64, floor(itemframe.label:GetWidth() + itemframe.levelString:GetWidth()) + 4)
        itemframe:SetWidth(itemframe.width)
        if (width < itemframe.width) then
            width = itemframe.width
        end
        LibEvent:trigger("INSPECT_ITEMFRAME_UPDATED", itemframe)
    end
    frame:SetWidth(width + 36)
    frame:Show()

    LibEvent:trigger("INSPECT_FRAME_SHOWN", frame, parent, ilevel)
    frame:SetBackdrop(frame.backdrop)
    frame:SetBackdropColor(0, 0, 0, 0.9)
    frame:SetBackdropBorderColor(color.r, color.g, color.b)

    return frame
end

--裝備變更時
LibEvent:attachEvent("UNIT_INVENTORY_CHANGED", function(self, unit)
    if (InspectFrame and InspectFrame.unit and InspectFrame.unit == unit) then
        ReInspect(unit)
    end
end)

--@see InspectCore.lua 
LibEvent:attachTrigger("UNIT_INSPECT_READY, UNIT_REINSPECT_READY", function(self, data)
    if (MerInspectDB and not MerInspectDB.ShowInspectItemSheet) then return end
    if (InspectFrame and InspectFrame.unit and UnitGUID(InspectFrame.unit) == data.guid) then
        local frame = ShowInspectItemListFrame(InspectFrame.unit, InspectFrame, data.ilevel, data.maxLevel)
        LibEvent:trigger("INSPECT_FRAME_COMPARE", frame)
    end
end)

--Backdrop
LibEvent:attachTrigger("INSPECT_FRAME_BACKDROP", function(self, frame)
    if (MerInspectDB and MerInspectDB.ShowInspectAngularBorder) then
        frame.backdrop.edgeSize = 1
        frame.backdrop.edgeFile = "Interface\\Buttons\\WHITE8X8"
        frame.backdrop.insets.top = 1
        frame.backdrop.insets.left = 1
        frame.backdrop.insets.right = 1
        frame.backdrop.insets.bottom = 1
    else
        frame.backdrop.edgeSize = 16
        frame.backdrop.edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border"
        frame.backdrop.insets.top = 4
        frame.backdrop.insets.left = 4
        frame.backdrop.insets.right = 4
        frame.backdrop.insets.bottom = 4
    end
end)

--設置邊框和位置
LibEvent:attachTrigger("INSPECT_FRAME_SHOWN", function(self, frame, parent, ilevel)
    local x, y, f = 0, 0, parent:GetName()
    if (f == "InspectFrame" or f == "PaperDollFrame") then
        x, y = 33, 14
    end
    if (MerInspectDB and MerInspectDB.ShowInspectAngularBorder) then
        frame.backdrop.edgeSize = 1
        frame.backdrop.edgeFile = "Interface\\Buttons\\WHITE8X8"
        frame.backdrop.insets.top = 1
        frame.backdrop.insets.left = 1
        frame.backdrop.insets.right = 1
        frame.backdrop.insets.bottom = 1
        frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 2-x, 0-y)
    else
        frame.backdrop.edgeSize = 16
        frame.backdrop.edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border"
        frame.backdrop.insets.top = 4
        frame.backdrop.insets.left = 4
        frame.backdrop.insets.right = 4
        frame.backdrop.insets.bottom = 4
        frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0-x, 0-y)
    end
end)

--根據品質設置Label顔色
LibEvent:attachTrigger("INSPECT_ITEMFRAME_UPDATED", function(self, itemframe)
    local r, g, b = 0, 0.9, 0.9
    if (MerInspectDB and MerInspectDB.ShowInspectColoredLabel) then
        if (itemframe.quality) then
            r, g, b = GetItemQualityColor(itemframe.quality)
        elseif (itemframe.name and not itemframe.link) then
            r, g, b = 0.9, 0.8, 0.4
        elseif (not itemframe.link) then
            r, g, b = 0.6, 0.6, 0.6
        end
    end
    itemframe.label:SetBackdropBorderColor(r, g, b, 0.2)
    itemframe.label:SetBackdropColor(r, g, b, 0.2)
    itemframe.label.text:SetTextColor(r, g, b)
end)

--自己裝備列表
LibEvent:attachTrigger("INSPECT_FRAME_COMPARE", function(self, frame)
    if (not frame) then return end
    if (MerInspectDB and MerInspectDB.ShowOwnFrameWhenInspecting) then
        local ilevel, _, maxLevel = LibItemInfo:GetUnitItemLevel("player")
        local playerFrame = ShowInspectItemListFrame("player", frame, ilevel, maxLevel)
        if (frame.statsFrame) then
            frame.statsFrame:SetParent(playerFrame)
        end
    elseif (frame.statsFrame) then
        frame.statsFrame:SetParent(frame)
    end
    if (frame.statsFrame) then
        frame.statsFrame:SetPoint("TOPLEFT", frame.statsFrame:GetParent(), "TOPRIGHT", 1, 0)
    end
end)


----------------
--   Player   --
----------------

local PlayerStatsFrame = CreateFrame("Frame", nil, UIParent, "ClassicStatsFrameTemplate")
local mask = PlayerStatsFrame:CreateTexture()
mask:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
mask:SetPoint("TOPLEFT", PlayerStatsFrame, "TOPLEFT", 3, -2)
mask:SetPoint("BOTTOMRIGHT", PlayerStatsFrame, "BOTTOMRIGHT", -3, 2)
mask:SetBlendMode("ADD")
mask:SetGradientAlpha("VERTICAL", 0.1, 0.2, 0.3, 0.8, 0.1, 0.2, 0.1, 0.8)

LibEvent:attachTrigger("TogglePlayerStatsFrame", function(self, frame, bool, forceShown)
    if (bool == false) then
        return PlayerStatsFrame:Hide()
    end
    if (forceShown or (MerInspectDB and MerInspectDB.ShowCharacterItemStats)) then
        if (LibItemStats:IsSupported()) then
            local stats = LibItemStats:GetUnitStats("player")
            stats.ilevel = LibItemInfo:GetUnitItemLevel("player")
            PlayerStatsFrame:SetStats(stats):Show()
            if (frame.inspectFrame and frame.inspectFrame:IsShown()) then
                PlayerStatsFrame:SetPoint("TOPLEFT", frame.inspectFrame, "TOPRIGHT", 1, 0)
            elseif (not frame:GetName()) then
                PlayerStatsFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 1, 0)
            else
                PlayerStatsFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", -32, -14)
            end
        end
    end
end)

PaperDollFrame:HookScript("OnShow", function(self)
    if (MerInspectDB and MerInspectDB.ShowCharacterItemSheet) then
        local ilevel, _, maxLevel = LibItemInfo:GetUnitItemLevel("player")
        ShowInspectItemListFrame("player", self, ilevel, maxLevel)
    end
    LibEvent:trigger("TogglePlayerStatsFrame", self, true)
end)

PaperDollFrame:HookScript("OnHide", function(self)
    LibEvent:trigger("TogglePlayerStatsFrame", self, false)
end)

LibEvent:attachEvent("PLAYER_EQUIPMENT_CHANGED", function(self)
    if (CharacterFrame:IsShown() and PaperDollFrame:IsShown() and MerInspectDB and MerInspectDB.ShowCharacterItemSheet) then
        local ilevel, _, maxLevel = LibItemInfo:GetUnitItemLevel("player")
        ShowInspectItemListFrame("player", PaperDollFrame, ilevel, maxLevel)
    end
    if (CharacterFrame:IsShown() and PaperDollFrame:IsShown()) then
        LibEvent:trigger("TogglePlayerStatsFrame", PaperDollFrame, false)
        LibEvent:trigger("TogglePlayerStatsFrame", PaperDollFrame, true)
    end
end)
