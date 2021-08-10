
-------------------------------------
-- 物品部位 Author: M
-------------------------------------

local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibSchedule = LibStub:GetLibrary("LibSchedule.7000")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.1000")

local ARMOR = ARMOR or "Armor"
local WEAPON = WEAPON or "Weapon"
local MOUNTS = MOUNTS or "Mount"
local RELICSLOT = RELICSLOT or "Relic"

--顯示框架
local function GetItemSlotFrame(self)
    if (not self.ItemSlotFrame) then
        local fontAdjust = GetLocale():sub(1,2) == "zh" and 0 or -3
        local anchor, w, h = self.IconBorder or self, self:GetSize()
        local ww, hh = anchor:GetSize()
        if (ww == 0 or hh == 0) then
            anchor = self.Icon or self.icon or self
            w, h = anchor:GetSize()
        else
            w, h = min(w, ww), min(h, hh)
        end
        self.ItemSlotFrame = CreateFrame("Frame", nil, self)
        self.ItemSlotFrame:SetScale(max(0.75, h<32 and h/32 or 1))
        self.ItemSlotFrame:SetFrameLevel(8)
        self.ItemSlotFrame:SetSize(w, h)
        self.ItemSlotFrame:SetPoint("CENTER", anchor, "CENTER", 0, 0)
        self.ItemSlotFrame.slotString = self.ItemSlotFrame:CreateFontString(nil, "OVERLAY")
        self.ItemSlotFrame.slotString:SetFont(STANDARD_TEXT_FONT, 10+fontAdjust, "OUTLINE")
        self.ItemSlotFrame.slotString:SetPoint("BOTTOMRIGHT", 1, 2)
        self.ItemSlotFrame.slotString:SetTextColor(1, 1, 1)
        self.ItemSlotFrame.slotString:SetJustifyH("RIGHT")
        self.ItemSlotFrame.slotString:SetWidth(30)
        self.ItemSlotFrame.slotString:SetHeight(0)
        self.ItemSlotFrame.levelString = self.ItemSlotFrame:CreateFontString(nil, "OVERLAY")
        self.ItemSlotFrame.levelString:SetFont(STANDARD_TEXT_FONT, 14+fontAdjust, "OUTLINE")
        self.ItemSlotFrame.levelString:SetPoint("TOP")
        self.ItemSlotFrame.levelString:SetTextColor(1, 0.82, 0)
    end
    if (MerInspectDB and MerInspectDB.ShowItemSlotString) then
        self.ItemSlotFrame:Show()
        LibEvent:trigger("ITEMSLOT_FRAME_SHOWN", self.ItemSlotFrame, self)
    else
        self.ItemSlotFrame:Hide()
    end
    return self.ItemSlotFrame
end

--設置部位文字
local function SetItemSlotString(self, class, equipSlot, link)
    local slotText = ""
    if (equipSlot and string.find(equipSlot, "INVTYPE_")) then
        slotText = _G[equipSlot] or ""
    elseif (class == ARMOR) then
        slotText = class
    end
    self:SetText(slotText)
end

--設置物品部位
local function SetItemSlot(self, link, BagID, SlotID)
    if (not self) then return end
    local frame = GetItemSlotFrame(self)
    if (self.OrigItemLink == link) then
        return SetItemSlotString(frame.slotString, self.OrigItemClass, self.OrigItemEquipSlot, self.OrigItemLink)
    end
    local _, class, subclass, equipSlot
    if (link and (string.match(link, "item:(%d+):") or tonumber(link))) then
        if (BagID and SlotID and (category == "Bag" or category == "AltEquipment")) then
            _, _, _, _, _, _, class, subclass, _, equipSlot = LibItemInfo:GetContainerItemLevel(BagID, SlotID)
        else
            _, _, _, _, _, class, subclass, _, equipSlot = GetItemInfo(link)
        end
        if ((equipSlot and string.find(equipSlot, "INVTYPE_"))
            or (subclass and string.find(subclass, RELICSLOT))
            or (subclass and subclass == MOUNTS)
            ) then
            SetItemSlotString(frame.slotString, class, equipSlot, link)
        else
            SetItemSlotString(frame.slotString)
        end
    else
        SetItemSlotString(frame.slotString)
    end
    self.OrigItemLink = link
    self.OrigItemClass = class
    self.OrigItemEquipSlot = equipSlot
end

--[[ All ]]
hooksecurefunc("SetItemButtonQuality", function(self, quality, itemIDOrLink)
    if (self.ItemLevelCategory or self.isBag) then return end
    local frame = GetItemSlotFrame(self)
    if (MerInspectDB and not MerInspectDB.ShowItemSlotString) then
        return frame:Hide()
    end
    SetItemSlot(self, itemIDOrLink)
end)

--[[ PaperDoll
if (PaperDollItemSlotButton_OnShow) then
    hooksecurefunc("PaperDollItemSlotButton_OnShow", function(self, isBag)
        local id = self:GetID()
        local link = LibItemInfo:GetUnitItemIndexLink("player", id)
        SetItemSlot(self, link)
    end)
end
if (PaperDollItemSlotButton_OnEvent) then
    hooksecurefunc("PaperDollItemSlotButton_OnEvent", function(self, event, id, ...)
        if (event == "PLAYER_EQUIPMENT_CHANGED" and self:GetID() == id) then
            local link = LibItemInfo:GetUnitItemIndexLink("player", id)
            SetItemSlot(self, link)
        end
    end)
end
 ]]
 
--[[观察成功后,设置slot文字]]
LibEvent:attachTrigger("UNIT_INSPECT_READY", function(self, data)
    if (InspectFrame and InspectFrame.unit and UnitGUID(InspectFrame.unit) == data.guid) then
        for _, button in ipairs({
             InspectHeadSlot,InspectNeckSlot,InspectShoulderSlot,InspectBackSlot,InspectChestSlot,InspectWristSlot,
             InspectHandsSlot,InspectWaistSlot,InspectLegsSlot,InspectFeetSlot,InspectFinger0Slot,InspectFinger1Slot,
             InspectTrinket0Slot,InspectTrinket1Slot,InspectMainHandSlot,InspectSecondaryHandSlot
             , InspectShirtSlot, InspectTabardSlot
            }) do
            if (not button) then return end
            local id = button:GetID()
            local link = LibItemInfo:GetUnitItemIndexLink(InspectFrame.unit, id)
            SetItemSlot(button, link)
        end
    end
end)

--[[关闭观察时,清空slot文字]]
LibEvent:attachEvent("ADDON_LOADED", function(self, addonName)
    if (addonName == "Blizzard_InspectUI") then
        hooksecurefunc(InspectFrame, "Hide", function()
            for _, button in ipairs({
                 InspectHeadSlot,InspectNeckSlot,InspectShoulderSlot,InspectBackSlot,InspectChestSlot,InspectWristSlot,
                 InspectHandsSlot,InspectWaistSlot,InspectLegsSlot,InspectFeetSlot,InspectFinger0Slot,InspectFinger1Slot,
                 InspectTrinket0Slot,InspectTrinket1Slot,InspectMainHandSlot,InspectSecondaryHandSlot
                 , InspectShirtSlot, InspectTabardSlot
                }) do
                if (not button) then return end
                SetItemSlot(button)
            end
        end)
    end
end)


----------------------
--  Chat ItemSlot  --
----------------------

local Caches = {}

local function ChatItemSlot(Hyperlink)
    if (Caches[Hyperlink]) then
        return Caches[Hyperlink]
    end
    local slot
    local link = string.match(Hyperlink, "|H(.-)|h")
    local name, _, quality, level, _, class, subclass, _, equipSlot = GetItemInfo(link)
    if (equipSlot == "INVTYPE_CLOAK" or equipSlot == "INVTYPE_TRINKET" or equipSlot == "INVTYPE_FINGER" or equipSlot == "INVTYPE_NECK") then
        slot = _G[equipSlot] or equipSlot
    elseif (equipSlot == "INVTYPE_RANGEDRIGHT") then
        slot = subclass
    elseif (equipSlot and string.find(equipSlot, "INVTYPE_")) then
        slot = format("%s-%s", subclass or "", _G[equipSlot] or equipSlot)
    elseif (class == ARMOR) then
        slot = format("%s-%s", subclass or "", class)
    elseif (subclass and string.find(subclass, RELICSLOT)) then
        slot = RELICSLOT
    elseif (subclass and subclass == MOUNTS) then
        slot = MOUNTS
    end
    if (slot) then
        Hyperlink = Hyperlink:gsub("|h%[(.-)%]|h", "|h[("..slot.."):"..name.."]|h")
        Caches[Hyperlink] = Hyperlink
    end
    return Hyperlink
end

local function filter(self, event, msg, ...)
    if (MerInspectDB and MerInspectDB.ShowItemSlotString) then
        msg = msg:gsub("(|Hitem:%d+:.-|h.-|h)", ChatItemSlot)
    end
    return false, msg, ...
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", filter)
