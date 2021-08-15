-- RuleEditor.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/29/2019, 12:25:28 AM
--
---- LUA
local tinsert, tremove = table.insert, table.remove
local pairs, ipairs, setmetatable = pairs, ipairs, setmetatable
local coroutine = coroutine
local floor = math.floor

---- WOW
local CreateFrame = CreateFrame
local GetContainerItemLink = GetContainerItemLink
local GetItemIcon = GetItemIcon

---@type ns
local ns = select(2, ...)
local L = ns.L
local UI = ns.UI
local Addon = ns.Addon
local Search = ns.Search

local ICON_SIZE = 32

---@class RuleEditor: UIPrototype
local RuleEditor = UI:NewModule('RuleEditor')

local function GetText(editbox)
    local text = editbox:GetText():trim()
    return text ~= '' and text or nil
end

function RuleEditor:OnSetup()
    ---@type tdPack2RuleEditorTemplate
    local Frame = CreateFrame('Frame', nil, UIParent, 'tdPack2RuleEditorTemplate')
    Frame:SetBackdrop{
        bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background',
        edgeFile = 'Interface\\DialogFrame\\UI-DialogBox-Border',
        tile = true,
        tileEdge = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 11, right = 12, top = 12, bottom = 11},
    }

    Frame.RuleInput:SetScript('OnTextChanged', function()
        self:OnRuleChanged()
    end)
    Frame.CommentInput:SetScript('OnTextChanged', function()
        self:UpdateValid()
    end)
    Frame.ExecButton:SetScript('OnClick', function()
        self:OnSaveClick()
    end)

    Frame.WhereDropDown.initialize = function(_, level, menuList)
        local list = menuList or self:CreateWhereItemTable()
        if type(list) == 'function' then
            list = list()
        end
        for _, v in ipairs(list) do
            UIDropDownMenu_AddButton(v, level)
        end
    end

    Frame.LabelRule:SetText(L['Rule'])
    Frame.LabelWhere:SetText(L['Put where?'])
    Frame.LabelComment:SetText(L['Name (Optional)'])
    Frame.LabelIcons:SetText(L['Select an icon (Optional)'])

    local function OnClick(button)
        for _, v in pairs(self.iconButtons) do
            v:SetChecked(v == button)
        end
        self.selectedIcon = button.icon
    end

    self.iconButtons = setmetatable({}, {
        __index = function(t, i)
            local icon = CreateFrame('CheckButton', nil, Frame.IconsFrame)
            icon:SetSize(ICON_SIZE, ICON_SIZE)
            icon:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
            icon:SetCheckedTexture([[Interface\Buttons\CheckButtonHilight]])
            icon:SetScript('OnClick', OnClick)
            t[i] = icon
            return icon
        end,
    })

    self.IconsFrame = Frame.IconsFrame
    self.RuleInput = Frame.RuleInput
    self.CommentInput = Frame.CommentInput
    self.WhereDropDown = Frame.WhereDropDown
    self.ExecButton = Frame.ExecButton
    self.Frame = Frame

    Frame:SetScript('OnShow', function()
        self:OnShow()
    end)
    Frame:SetScript('OnHide', function()
        self:OnHide()
    end)
end

function RuleEditor:OnShow()
    UIDropDownMenu_SetWidth(self.WhereDropDown, self.WhereDropDown:GetWidth() - 36, 0)

    if self.rule then
        self.Frame.Title:SetText(L['Edit rule'])
        self.RuleInput:SetText(self.rule.rule or '')
        self.CommentInput:SetText(self.rule.comment or '')
        self:SetWhereDropdownValue(self.rule)
        UIDropDownMenu_DisableDropDown(self.WhereDropDown)
    else
        self.Frame.Title:SetText(L['Add rule'])
        self.RuleInput:SetText('')
        self.CommentInput:SetText('')
        self:SetWhereDropdownValue(self.root)
        UIDropDownMenu_EnableDropDown(self.WhereDropDown)
    end
end

function RuleEditor:OnHide()
    StaticPopupSpecial_Hide(self.Frame)
end

function RuleEditor:OnRuleChanged()
    self:UpdateValid()
    self:UpdateIcons()
end

function RuleEditor:OnSaveClick()
    local item = { --
        rule = GetText(self.RuleInput),
        comment = GetText(self.CommentInput),
        icon = self.selectedIcon,
    }

    if self.rule then
        local where = self.rule
        ns.CopyFrom(wipe(where), item)
    else
        local where = UIDropDownMenu_GetSelectedValue(self.WhereDropDown)
        where.children = where.children or {}
        tinsert(where.children, item)
    end
    self:Hide()

    if self.callback then
        self.callback()
    end
end

function RuleEditor:SetWhereDropdownValue(value)
    local name = ns.GetRuleInfo(value)
    UIDropDownMenu_SetSelectedValue(self.WhereDropDown, value)
    UIDropDownMenu_SetText(self.WhereDropDown, name or L['Root'])
end

function RuleEditor:CreateWhereItemTable(profile)
    local menuTable = {}

    local function OnSelect(button)
        self:SetWhereDropdownValue(button.value)
        CloseDropDownMenus()
    end

    local function IsChecked(item)
        return item.value == UIDropDownMenu_GetSelectedValue(self.WhereDropDown)
    end

    if not profile then
        profile = self.root.children

        tinsert(menuTable, {checkable = true, text = L['Root'], value = self.root, checked = IsChecked, func = OnSelect})
    end

    for i, v in ipairs(profile) do
        if ns.IsAdvanceRule(v) then
            local name, icon, rule = ns.GetRuleInfo(v)
            local hasArrow = v.children and #v.children > 0

            tinsert(menuTable, {
                checkable = true,
                text = name,
                value = v,
                hasArrow = hasArrow,
                menuList = hasArrow and function()
                    return self:CreateWhereItemTable(v.children)
                end or nil,
                checked = IsChecked,
                func = OnSelect,
            })
        end
    end

    return menuTable
end

function RuleEditor:UpdateValid()
    local rule = GetText(self.RuleInput)
    local name = GetText(self.CommentInput)
    self.ExecButton:SetEnabled(rule or name)
end

function RuleEditor:SetIconButton(index, icon, row, column)
    local button = self.iconButtons[index]
    button.icon = icon
    button:SetNormalTexture(icon)

    button:SetPoint('TOPLEFT', (column - 1) * ICON_SIZE, -(row - 1) * ICON_SIZE)
    button:Show()
end

function RuleEditor:UpdateIcons()
    local rule = GetText(self.RuleInput)

    local existsIcons = {}
    local touchedItems = {}
    local rowCount = floor(self.IconsFrame:GetHeight() / ICON_SIZE)
    local columnCount = floor(self.IconsFrame:GetWidth() / ICON_SIZE)
    local count = rowCount * columnCount
    local index = 1

    local function DrawIcon(i, icon, row, column)
        if existsIcons[icon] then
            return
        end
        existsIcons[icon] = true
        self:SetIconButton(i, icon, row, column)
        index = i + 1
    end

    if self.rule and self.rule.icon then
        DrawIcon(index, self.rule.icon, 1, 1)
    end

    for bag in self:IterateBags() do
        for slot = 1, ns.GetBagNumSlots(bag) do
            if index > count then
                break
            end

            local row = floor((index - 1) / columnCount) + 1
            local column = floor((index - 1) % columnCount) + 1

            local itemId = ns.GetBagSlotId(bag, slot)
            if itemId and not touchedItems[itemId] then
                touchedItems[itemId] = true

                local link = GetContainerItemLink(bag, slot)
                if not rule or Search:Matches(link, rule) then
                    DrawIcon(index, GetItemIcon(link), row, column)
                end
            end
        end
    end

    if index == 1 then
        DrawIcon(index, ns.UNKNOWN_ICON, 1, 1)
    end

    for i = index, #self.iconButtons do
        self.iconButtons[i]:Hide()
    end

    self.iconButtons[1]:Click()
end

function RuleEditor:IterateBags()
    return coroutine.wrap(function()
        for _, bagType in ipairs(ns.BAG_TYPES) do
            for _, bag in ipairs(ns.GetBags(bagType)) do
                coroutine.yield(bag)
            end
        end
    end)
end

function RuleEditor:Open(rule, root, callback)
    self.rule = rule
    self.callback = callback
    self.root = {children = root}
    self:Setup()
    self.Frame:Hide()
    StaticPopupSpecial_Show(self.Frame)
end

function RuleEditor:Close()
    if self.Frame then
        StaticPopupSpecial_Hide(self.Frame)
    end
end
