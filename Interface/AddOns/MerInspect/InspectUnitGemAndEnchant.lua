--  Interface\ItemSocketingFrame\UI-EmptySocket-Red
--  Red, Yellow, Blue, Meta
--  ItemRefTooltipTexture1-9
local _GemTextureHash = {  };
for k, v in next, {
    [ [[Interface\ItemSocketingFrame\UI-EmptySocket-Red]] ] = "Red",
    [ [[Interface\ItemSocketingFrame\UI-EmptySocket-Yellow]] ] = "Yellow",
    [ [[Interface\ItemSocketingFrame\UI-EmptySocket-Blue]] ] = "Blue",
    [ [[Interface\ItemSocketingFrame\UI-EmptySocket-Meta]] ] = "Meta",
    [ [[Interface/ItemSocketingFrame/UI-EmptySocket-Red]] ] = "Red",
    [ [[Interface/ItemSocketingFrame/UI-EmptySocket-Yellow]] ] = "Yellow",
    [ [[Interface/ItemSocketingFrame/UI-EmptySocket-Blue]] ] = "Blue",
    [ [[Interface/ItemSocketingFrame/UI-EmptySocket-Meta]] ] = "Meta",
} do
    _GemTextureHash[k] = v;
    _GemTextureHash[strlower(k)] = v;
    _GemTextureHash[strupper(k)] = v;
end
local _GemTexture = {
    ["Red"] = [[Interface\ItemSocketingFrame\UI-EmptySocket-Red]],
    ["Yellow"] = [[Interface\ItemSocketingFrame\UI-EmptySocket-Yellow]],
    ["Blue"] = [[Interface\ItemSocketingFrame\UI-EmptySocket-Blue]],
    ["Meta"] = [[Interface\ItemSocketingFrame\UI-EmptySocket-Meta]],
};
local _ReadingTooltipName = gsub("_MerInsRTip" .. tostring(time() or 123456) .. strsub(tostring(random()), -8), "[^a-zA-Z_0-9]", "_");
local _ReadingTooltip = CreateFrame('GAMETOOLTIP', _ReadingTooltipName, nil, "GameTooltipTemplate");
_ReadingTooltip:SetClampedToScreen(false);
_ReadingTooltip:SetOwner(UIParent, "ANCHOR_TOP");
_ReadingTooltip:ClearAllPoints();
_ReadingTooltip:SetPoint("BOTTOM", UIParent, "TOP", 0, 100);
local _ReadingTooltipTexture = {  };
for i = 1, 9 do 
    _ReadingTooltipTexture[i] = _G[_ReadingTooltipName .. "Texture" .. i];
end
local function _GetItemGemInfo(ItemLink)
    local id, enchant, gem1, gem2, gem3 = strmatch(ItemLink, "item:(%d+):(%d*):(%d*):(%d*):(%d*):");
    if id == nil or id == "" then
        return nil;
    end
    _ReadingTooltip:SetHyperlink(ItemLink);
    _ReadingTooltip:Show();
    local gems = { gem1, gem2, gem3 };
    for i = 1, 3 do
        local gem = gems[i];
        local T = _ReadingTooltipTexture[i];
        if T:IsShown() then
            local Texture = T:GetTexture();
            local Type = _GemTextureHash[Texture];
            if gem ~= "" then
                gems[i] = tonumber(gem);
                gems[i + 3] = Texture;
            elseif Type ~= nil then
                gems[i] = Type;
                gems[i + 3] = Texture;
            elseif Texture ~= nil then
                Type = _GemTextureHash[strlower(Texture)];
                if Type ~= nil then
                    gems[i] = Type;
                    gems[i + 3] = Texture;
                else
                    gems[i] = nil;
                    gems[i + 3] = nil;
                end
            else
                gems[i] = nil;
                gems[i + 3] = nil;
            end
        else
            return i - 1, gems;
        end
    end
    return 3, gems;
end
-------------------------------------
-- 顯示附魔信息 (经典版无宝石)
-- @Author: M
-- @DepandsOn: InspectUnit.lua
-------------------------------------

local addon, ns = ...

local LibSchedule = LibStub:GetLibrary("LibSchedule.7000")
local LibItemEnchant = LibStub:GetLibrary("LibItemEnchant.7000")

--0:optional
local EnchantParts = {
    [1] = { 1, HEADSLOT },
    [3] = { 1, SHOULDERSLOT },
    [5]  = { 1, CHESTSLOT },
    [7] = { 1, LEGSSLOT },
    [8]  = { 1, FEETSLOT },
    [9]  = { 1, WRISTSLOT },
    [10] = { 1, HANDSSLOT },
    [15] = { 1, BACKSLOT },
    [16] = { 1, MAINHANDSLOT },
    [17] = { 0, SECONDARYHANDSLOT },
}

--創建圖標框架
local function CreateIconFrame(frame, index)
    local icon = CreateFrame("Button", nil, frame)
    icon.index = index
    icon:Hide()
    icon:SetSize(16, 16)
    icon:SetScript("OnEnter", function(self)
        if (self.itemLink) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(self.itemLink)
            GameTooltip:Show()
        elseif (self.spellID) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetSpellByID(self.spellID)
            GameTooltip:Show()
        elseif (self.title) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(self.title)
            GameTooltip:Show()
        end
    end)
    icon:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    icon:SetScript("OnDoubleClick", function(self)
        if (self.itemLink or self.title) then
            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
            ChatEdit_InsertLink(self.itemLink or self.title)
        end
    end)
    icon.bg = icon:CreateTexture(nil, "BACKGROUND")
    icon.bg:SetSize(16, 16)
    icon.bg:SetPoint("CENTER")
    icon.bg:SetTexture("Interface\\AddOns\\"..addon.."\\texture\\GemBg")
    icon.texture = icon:CreateTexture(nil, "BORDER")
    icon.texture:SetSize(12, 12)
    icon.texture:SetPoint("CENTER")
    icon.texture:SetMask("Interface\\FriendsFrame\\Battlenet-Portrait")
    frame["xicon"..index] = icon
    return frame["xicon"..index]
end

--隱藏所有圖標框架
local function HideAllIconFrame(frame)
    local index = 1 
    while (frame["xicon"..index]) do
        frame["xicon"..index].title = nil
        frame["xicon"..index].itemLink = nil
        frame["xicon"..index].spellID = nil
        frame["xicon"..index]:Hide()
        index = index + 1
    end
    LibSchedule:RemoveTask("InspectGemAndEnchant", true)
end

--獲取可用的圖標框架
local function GetIconFrame(frame)
    local index = 1
    while (frame["xicon"..index]) do
        if (not frame["xicon"..index]:IsShown()) then
            return frame["xicon"..index]
        end
        index = index + 1
    end
    return CreateIconFrame(frame, index)
end

--執行圖標更新
local function onExecute(self)
    if (self.dataType == "item") then
        local _, itemLink, quality, _, _, _, _, _, _, texture = GetItemInfo(self.data)
        if (texture) then
            local r, g, b = GetItemQualityColor(quality or 0)
            self.icon.bg:SetVertexColor(r, g, b)
            self.icon.texture:SetTexture(texture)
            if (not self.icon.itemLink) then
                self.icon.itemLink = itemLink
            end
            return true
        end
    elseif (self.dataType == "spell") then
        local _, _, texture = GetSpellInfo(self.data)
        if (texture) then
            self.icon.texture:SetTexture(texture)
            return true
        end
    end
end

--Schedule模式更新圖標
local function UpdateIconTexture(icon, texture, data, dataType)
    if (not texture) then
        LibSchedule:AddTask({
            identity  = "InspectGemAndEnchant" .. icon.index,
            timer     = 0.1,
            elasped   = 0.5,
            expired   = GetTime() + 3,
            onExecute = onExecute,
            icon      = icon,
            data      = data,
            dataType  = dataType,
        })
    end
end

--讀取並顯示圖標
local function ShowGemAndEnchant(frame, ItemLink, anchorFrame, itemframe)
    if (not ItemLink) then return 0 end
    local num = 0
    local _, qty, quality, texture, icon, r, g, b
    local enchantItemID, enchantID = LibItemEnchant:GetEnchantItemID(ItemLink)
    local enchantSpellID = LibItemEnchant:GetEnchantSpellID(ItemLink)
    local enchantID, enchantSpellID, enchantItemID = LibItemEnchant:GetEnchant(ItemLink)
    if (enchantSpellID) then
        num = num + 1
        icon = GetIconFrame(frame)
        _, _, texture = GetSpellInfo(enchantSpellID)
        icon.bg:SetVertexColor(1,0.82,0)
        icon.texture:SetTexture(texture)
        UpdateIconTexture(icon, texture, enchantSpellID, "spell")
        icon.spellID = enchantSpellID
        icon:ClearAllPoints()
        icon:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
        icon:Show()
        anchorFrame = icon
    elseif (enchantItemID) then
        num = num + 1
        icon = GetIconFrame(frame)
        _, ItemLink, quality, _, _, _, _, _, _, texture = GetItemInfo(enchantItemID)
        r, g, b = GetItemQualityColor(quality or 0)
        icon.bg:SetVertexColor(r, g, b)
        icon.texture:SetTexture(texture)
        UpdateIconTexture(icon, texture, enchantItemID, "item")
        icon.itemLink = ItemLink
        icon:ClearAllPoints()
        icon:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
        icon:Show()
        anchorFrame = icon
    elseif (enchantID) then
        num = num + 1
        icon = GetIconFrame(frame)
        icon.title = "#" .. enchantID
        icon.bg:SetVertexColor(0.1, 0.1, 0.1)
        icon.texture:SetTexture("Interface\\FriendsFrame\\InformationIcon")
        icon:ClearAllPoints()
        icon:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
        icon:Show()
        anchorFrame = icon
    elseif (not enchantID and EnchantParts[itemframe.index]) then
        num = num + 1
        icon = GetIconFrame(frame)
        icon.title = ENCHANTS .. ": " .. EnchantParts[itemframe.index][2]
        icon.bg:SetVertexColor(1, 0.2, 0.2, 0.6)
        icon.texture:SetTexture("Interface\\Cursor\\" .. (EnchantParts[itemframe.index][1]==1 and "Quest" or "UnableQuest"))
        icon:ClearAllPoints()
        icon:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
        icon:Show()
        anchorFrame = icon
    end
    local ng, gems = _GetItemGemInfo(ItemLink);
    if ng ~= nil then
        for i = 1, ng do
            local gem = gems[i];
            num = num + 1;
            icon = GetIconFrame(frame)
            if gem == "Red" or gem == "Blue" or gem == "Yellow" or gem == "Meta" then
                icon.title = ns.L[gem]
            elseif gem ~= nil then
                icon.itemLink = "item" .. ": " .. gem;
            else
                icon.title = ns.L.UnkGem;
            end
            icon.bg:SetVertexColor(1, 1, 1, 1)
            icon.texture:SetTexture(gems[i + 3] or [[Interface\Icons\INV_Misc_QuestionMark]])
            icon:ClearAllPoints()
            icon:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
            icon:Show()
            anchorFrame = icon
        end
    end
    return num * 18
end

--功能附着
hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    local frame = parent.inspectFrame
    if (not frame) then return end
    local i = 1
    local itemframe
    local width, iconWidth = frame:GetWidth(), 0
    HideAllIconFrame(frame)
    while (frame["item"..i]) do
        itemframe = frame["item"..i]
        iconWidth = ShowGemAndEnchant(frame, itemframe.link, itemframe.itemString, itemframe)
        if (width < itemframe.width + iconWidth + 36) then
            width = itemframe.width + iconWidth + 36
        end
        i = i + 1
    end
    if (width > frame:GetWidth()) then
        frame:SetWidth(width)
    end
end)
