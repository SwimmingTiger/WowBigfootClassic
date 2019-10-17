
--------------
-- 配置面板 --
--------------

local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local VERSION = 1.0

local addon, ns = ...

local L = ns.L or {}

setmetatable(L, { __index = function(_, k)
    return k:gsub("([a-z])([A-Z])", "%1 %2")
end})

local DefaultDB = {
    version = VERSION,
    ShowItemSlotString = false,             --物品部位文字
    ShowItemBorder = false,                 --物品直角邊框
    ShowCharacterItemSheet = true,          --玩家自己裝備列表
    ShowCharacterItemStats = true,          --玩家自己屬性統計
    ShowInspectAngularBorder = false,       --觀察面板直角邊框
    ShowInspectColoredLabel = true,         --觀察面板顔色隨物品品質
    ShowInspectItemSheet = true,            --顯示观察对象装备列表
		ShowOwnFrameWhenInspecting = true,  --觀察同時顯示自己裝備列表
		ShowItemStats = true,               --顯示裝備屬性統計
}

local options = {
    { key = "ShowItemBorder" },
    { key = "ShowItemSlotString" },
    { key = "ShowCharacterItemSheet" },
    { key = "ShowCharacterItemStats" },
    { key = "ShowInspectAngularBorder" },
    { key = "ShowInspectColoredLabel" },
    { key = "ShowInspectItemSheet",
        child = {
            { key = "ShowOwnFrameWhenInspecting" },
            { key = "ShowItemStats" },
        }
    },
}

MerInspectDB = DefaultDB

local function CallCustomFunc(self)
    local checked = self:GetChecked()
    if (checked and self.checkedFunc) then
        self.checkedFunc(self)
    end
    if (not checked and self.uncheckedFunc) then
        self.uncheckedFunc(self)
    end
end

local function StatusSubCheckbox(self, status)
    local checkbox
    for i = 1, self:GetNumChildren() do
        checkbox = select(i, self:GetChildren())
        if (checkbox.key) then
            checkbox:SetEnabled(status)
            StatusSubCheckbox(checkbox, status)
        end
    end
    if (status and self.SubtypeFrame) then
        self.SubtypeFrame:Show()
    elseif (not status and self.SubtypeFrame) then
        self.SubtypeFrame:Hide()
    end
end

local function OnClickCheckbox(self)
    local status = self:GetChecked()
    MerInspectDB[self.key] = status
    StatusSubCheckbox(self, status)
    CallCustomFunc(self)
end

local function CreateSubtypeFrame(list, parent)
    if (not list) then return end
    if (not parent.SubtypeFrame) then
        parent.SubtypeFrame = CreateFrame("Frame", nil, parent)
        parent.SubtypeFrame:SetScale(0.92)
        parent.SubtypeFrame:SetPoint("TOPLEFT", 333, 0)
        parent.SubtypeFrame:SetBackdrop({
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile     = true,
            tileSize = 8,
            edgeSize = 16,
            insets   = {left = 4, right = 4, top = 4, bottom = 4}
        })
        parent.SubtypeFrame:SetBackdropColor(0, 0, 0, 0.6)
        parent.SubtypeFrame:SetBackdropBorderColor(0.6, 0.6, 0.6)
        parent.SubtypeFrame.title = parent.SubtypeFrame:CreateFontString(nil, "BORDER", "GameFontNormalOutline")
        parent.SubtypeFrame.title:SetPoint("TOPLEFT", 16, -18)
        parent.SubtypeFrame.title:SetText(L[parent.key])
    end
    local checkbox
    for i, v in ipairs(list) do
        checkbox = CreateFrame("CheckButton", nil, parent.SubtypeFrame, "InterfaceOptionsCheckButtonTemplate")
        checkbox.key = parent.key .. v.key
        checkbox.checkedFunc = v.checkedFunc
        checkbox.uncheckedFunc = v.uncheckedFunc
        checkbox.Text:SetText(L[v.key])
        checkbox:SetScript("OnClick", OnClickCheckbox)
        checkbox:SetPoint("TOPLEFT", parent.SubtypeFrame, "TOPLEFT", 16, -46-(i-1)*32)
    end
    parent.SubtypeFrame:SetSize(168, #list*32+58)
end

local function CreateAnchorFrame(anchorkey, parent)
    if (not anchorkey) then return end
    local CreateAnchorButton = function(frame, anchorPoint)
        local button = CreateFrame("Button", nil, frame)
        button.anchorPoint = anchorPoint
        button:SetSize(12, 12)
        button:SetPoint(anchorPoint)
        button:SetNormalTexture("Interface\\Buttons\\WHITE8X8")
        if (MerInspectDB[frame.anchorkey] == anchorPoint) then
            button:GetNormalTexture():SetVertexColor(1, 0.2, 0.1)
        end
        button:SetScript("OnClick", function(self)
            local parent = self:GetParent()
            local anchorPoint = self.anchorPoint
            local anchorOrig = MerInspectDB[parent.anchorkey]
            if (parent[anchorOrig]) then
                parent[anchorOrig]:GetNormalTexture():SetVertexColor(1, 1, 1)
            end
            self:GetNormalTexture():SetVertexColor(1, 0.2, 0.1)
            MerInspectDB[parent.anchorkey] = anchorPoint
        end)
        frame[anchorPoint] = button
    end
    local frame = CreateFrame("Frame", nil, parent.SubtypeFrame or parent, "ThinBorderTemplate")
    frame.anchorkey = anchorkey
    frame:SetBackdrop(GameTooltip:GetBackdrop())
    frame:SetBackdropColor(GameTooltip:GetBackdropColor())
    frame:SetBackdropBorderColor(1, 1, 1, 0)
    frame:SetSize(80, 80)
    frame:SetPoint("TOPRIGHT", 100, -5)
    CreateAnchorButton(frame, "TOPLEFT")
    CreateAnchorButton(frame, "LEFT")
    CreateAnchorButton(frame, "BOTTOMLEFT")
    CreateAnchorButton(frame, "TOP")
    CreateAnchorButton(frame, "BOTTOM")
    CreateAnchorButton(frame, "TOPRIGHT")
    CreateAnchorButton(frame, "RIGHT")
    CreateAnchorButton(frame, "BOTTOMRIGHT")
    CreateAnchorButton(frame, "CENTER")
end

local function CreateCheckbox(list, parent, anchor, offsetx, offsety)
    local checkbox, subbox
    local stepx, stepy = 20, 27
    if (not list) then return offsety end
    for i, v in ipairs(list) do
        checkbox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
        checkbox.key = v.key
        checkbox.checkedFunc = v.checkedFunc
        checkbox.uncheckedFunc = v.uncheckedFunc
        checkbox.Text:SetText(L[v.key])
        checkbox:SetScript("OnClick", OnClickCheckbox)
        checkbox:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", offsetx, -6-offsety)
        offsety = offsety + stepy
        offsety = CreateCheckbox(v.child, checkbox, anchor, offsetx+stepx, offsety)
        CreateSubtypeFrame(v.subtype, checkbox)
        CreateAnchorFrame(v.anchorkey, checkbox)
    end
    return offsety
end

local function InitCheckbox(parent)
    local checkbox
    for i = 1, parent:GetNumChildren() do
        checkbox = select(i, parent:GetChildren())
        if (checkbox.key) then
            checkbox:SetChecked(MerInspectDB[checkbox.key])
            StatusSubCheckbox(checkbox, checkbox:GetChecked())
            CallCustomFunc(checkbox)
            InitCheckbox(checkbox)
        end
    end
    if (parent.SubtypeFrame) then
        InitCheckbox(parent.SubtypeFrame)
    end
end

local frame = CreateFrame("Frame", nil, UIParent)
frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
frame.title:SetPoint("TOPLEFT", 18, -16)
frame.title:SetText(addon)
frame.name = addon

CreateCheckbox(options, frame, frame.title, 18, 9)

LibEvent:attachEvent("VARIABLES_LOADED", function()
    if (not MerInspectDB or not MerInspectDB.version) then
        MerInspectDB = DefaultDB
    elseif (MerInspectDB.version <= DefaultDB.version) then
        MerInspectDB.version = DefaultDB.version
        for k, v in pairs(DefaultDB) do
            if (MerInspectDB[k] == nil) then
                MerInspectDB[k] = v
            end
        end
    end
    InitCheckbox(frame)
end)

InterfaceOptions_AddCategory(frame)
SLASH_MerInspect1 = "/merinspect"
SLASH_MerInspect2 = "/mi"
function SlashCmdList.MerInspect(msg, editbox)
    InterfaceOptionsFrame_OpenToCategory(frame)
    InterfaceOptionsFrame_OpenToCategory(frame)
end
