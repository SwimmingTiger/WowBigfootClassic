
-------------------------------------
-- 裝備屬性統計
-- @Author: M
-- @DepandsOn: InspectUnit.lua
-------------------------------------

local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.1000")
local LibItemStats = LibStub:GetLibrary("LibItemStats.1000")
local GetStatsName = LibItemStats.GetStatsName

local function ShowSupportedItemStatsFrame(frame, unit)
    if (not frame.statsFrame) then
        if (LibItemStats:IsSupported()) then
            local statsFrame = CreateFrame("Frame", nil, frame, "ClassicStatsFrameTemplate")
            frame.statsFrame = statsFrame
            frame:HookScript("OnHide", function(self)
                self.statsFrame:Hide()
                LibEvent:trigger("TogglePlayerStatsFrame", self.statsFrame, false)
            end)
        end
    end
    local stats = LibItemStats:GetUnitStats(unit)
    stats.ilevel = LibItemInfo:GetUnitItemLevel(unit)
    frame.statsFrame:SetStats(stats):Show()
    LibEvent:trigger("TogglePlayerStatsFrame", frame.statsFrame, true, false)
end

local function DefaultItemStatsFrame(frame, unit)
    if (not frame.statsFrame) then
        local statsFrame = CreateFrame("Frame", nil, frame, "InsetFrameTemplate3")
        statsFrame:SetSize(180, 157)
        statsFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, -1)
        for i = 1, 32 do
            statsFrame["stat"..i] = CreateFrame("FRAME", nil, statsFrame, "CharacterStatFrameTemplate")
            statsFrame["stat"..i]:EnableMouse(false)
            statsFrame["stat"..i]:SetWidth(180)
            statsFrame["stat"..i]:SetPoint("TOPLEFT", 0, -17*i+13)
            statsFrame["stat"..i].Background:SetVertexColor(0, 0, 0)
            statsFrame["stat"..i].Value:SetPoint("RIGHT", -64, 0)
            statsFrame["stat"..i].PlayerValue = statsFrame["stat"..i]:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
            statsFrame["stat"..i].PlayerValue:SetPoint("LEFT", statsFrame["stat"..i], "RIGHT", -54, 0)
        end
        local mask = statsFrame:CreateTexture()
        mask:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
        mask:SetPoint("TOPLEFT", statsFrame, "TOPRIGHT", -58, -3)
        mask:SetPoint("BOTTOMRIGHT", statsFrame, "BOTTOMRIGHT", -3, 2)
        mask:SetBlendMode("ADD")
        mask:SetGradientAlpha("VERTICAL", 0.1, 0.4, 0.4, 0.8, 0.1, 0.2, 0.2, 0.8)
        frame.statsFrame = statsFrame
        frame:HookScript("OnHide", function(self)
            self.statsFrame:Hide()
            LibEvent:trigger("TogglePlayerStatsFrame", self.statsFrame, false)
        end)
    end
    local inspectStats, playerStats = {}, {}
    local inspectItemLevel = LibItemInfo:GetUnitItemLevel(unit, inspectStats)
    local playerItemLevel  = LibItemInfo:GetUnitItemLevel("player", playerStats)
    local baseInfo = {}
    table.insert(baseInfo, {label = LEVEL, iv = UnitLevel(unit), pv = UnitLevel("player") })
    table.insert(baseInfo, {label = STAT_AVERAGE_ITEM_LEVEL, iv = format("%.1f",inspectItemLevel), pv = format("%.1f",playerItemLevel) })
    local index = 1
    for _, v in pairs(baseInfo) do
        frame.statsFrame["stat"..index].Label:SetText(v.label)
        frame.statsFrame["stat"..index].Label:SetTextColor(0.2, 1, 1)
        frame.statsFrame["stat"..index].Value:SetText(v.iv)
        frame.statsFrame["stat"..index].Value:SetTextColor(0, 0.7, 0.9)
        frame.statsFrame["stat"..index].PlayerValue:SetText(v.pv)
        frame.statsFrame["stat"..index].PlayerValue:SetTextColor(0, 0.7, 0.9)
        frame.statsFrame["stat"..index].Background:SetShown(index%2~=0)
        frame.statsFrame["stat"..index]:Show()
        index = index + 1
    end
    for k, v in pairs(inspectStats) do
        frame.statsFrame["stat"..index].Label:SetText(_G[k] or k)
        frame.statsFrame["stat"..index].Value:SetText(v)
        frame.statsFrame["stat"..index].PlayerValue:SetText(playerStats[k] or "-")
        frame.statsFrame["stat"..index].Background:SetShown(index%2~=0)
        frame.statsFrame["stat"..index]:Show()
        index = index + 1
    end
    for k, v in pairs(playerStats) do
        if (not inspectStats[k]) then
            frame.statsFrame["stat"..index].Label:SetText(_G[k] or k)
            frame.statsFrame["stat"..index].Value:SetText("-")
            frame.statsFrame["stat"..index].PlayerValue:SetText(v)
            frame.statsFrame["stat"..index].Background:SetShown(index%2~=0)
            frame.statsFrame["stat"..index]:Show()
            index = index + 1
        end
    end
    frame.statsFrame:SetHeight(index*17-10)
    while (frame.statsFrame["stat"..index]) do
        frame.statsFrame["stat"..index]:Hide()
        index = index + 1
    end
end

hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    local frame = parent.inspectFrame
    if (not frame) then return end
    if (unit == "player") then return end
    if (MerInspectDB and not MerInspectDB.ShowItemStats) then
        return
    end
    if (LibItemStats:IsSupported()) then
        ShowSupportedItemStatsFrame(frame, unit)
    --else
    --    DefaultItemStatsFrame(frame, unit)
    end
end)
