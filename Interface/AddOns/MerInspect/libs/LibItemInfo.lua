
---------------------------------
-- 經典版物品裝等 Author: M
---------------------------------

local MAJOR, MINOR = "LibItemInfo.1000", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local locale = GetLocale()

--Toolip
local tooltip = CreateFrame("GameTooltip", "ClassicLibItemLevelTooltip1", UIParent, "GameTooltipTemplate")
local unittip = CreateFrame("GameTooltip", "ClassicLibItemLevelTooltip2", UIParent, "GameTooltipTemplate")

--獲取物品绿字屬性 (中文用LibItemStats库)
function lib:GetItemStats(link, stats)
    if (type(stats) == "table") then
        local s = GetItemStats(link)
        for k, v in pairs(s) do
            if (stats[k]) then
                if (tonumber(v) and v > 0) then
                    stats[k] = stats[k] + v
                end
            else
                stats[k] = v
            end
        end
    end
    return stats
end

--獲取物品等級
function lib:GetItemLevel(link, stats)
    if (not link or link == "") then
        return -1
    end
    if (not string.match(link, "item:%d+:")) then
        return -1
    end
    self:GetItemStats(link, stats)
    local level = select(4, GetItemInfo(link))
    return tonumber(level) or 0
end

--獲取容器物品裝等
function lib:GetContainerItemLevel(pid, id)
    local link = GetContainerItemLink(pid, id)
    return self:GetItemLevel(link), GetItemInfo(link)
end

--獲取UNIT對應部位的物品LINK
function lib:GetUnitItemIndexLink(unit, index)
    if (not UnitExists(unit)) then return end
    unittip:SetOwner(UIParent, "ANCHOR_NONE")
    unittip:SetInventoryItem(unit, index)
    return GetInventoryItemLink(unit, index) or (select(2, unittip:GetItem()))
end

--獲取UNIT對應部位的物品等級
function lib:GetUnitItemIndexLevel(unit, index, stats)
    if (not UnitExists(unit)) then return -1 end
    unittip:SetOwner(UIParent, "ANCHOR_NONE")
    unittip:SetInventoryItem(unit, index)
    local link = GetInventoryItemLink(unit, index) or select(2, unittip:GetItem())
    if (link) then
        return self:GetItemLevel(link, stats), GetItemInfo(link)
    else
        return -1
    end
end

--獲取UNIT的裝備等級
--@return 平均装等, 最大武器等级, 最大裝等
function lib:GetUnitItemLevel(unit, stats)
    local total, maxlevel = 0, 0
    local level, mainhand, offhand, ranged
    for i = 1, 15 do
        if (i ~= 4) then
            level = self:GetUnitItemIndexLevel(unit, i, stats)
            if (level > 0) then
                total = total + level
                maxlevel = max(maxlevel, level)
            end
        end
    end
    mainhand = self:GetUnitItemIndexLevel(unit, 16, stats)
    offhand = self:GetUnitItemIndexLevel(unit, 17, stats)
    ranged = self:GetUnitItemIndexLevel(unit, 18, stats)
    if (mainhand <= 0 and ranged <= 0 and ranged <= 0) then
    elseif (mainhand > 0 and offhand > 0) then
        total = total + mainhand + offhand
    --elseif (mainhand > 0 and ranged > 0) then
    --    total = total + mainhand + ranged
    elseif (offhand > 0 and ranged > 0) then
        total = total + offhand + ranged
    else
        total = total + max(mainhand,offhand,ranged) * 2
    end
    return total/16, max(mainhand,offhand), maxlevel
end
