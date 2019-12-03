-- RuleEditor.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/29/2019, 12:25:28 AM

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

local RuleEditor = UI:NewModule('RuleEditor')

local function GetText(editbox)
    local text = editbox:GetText():trim()
    return text ~= '' and text or nil
end

function RuleEditor:OnSetup()
    local Frame = CreateFrame('Frame', nil, UI.RuleOption.Frame)
    Frame:SetPoint('TOPLEFT', 3, -22)
    Frame:SetPoint('BOTTOMRIGHT', -3, 3)
    Frame:SetFrameLevel(UI.RuleOption.Frame:GetFrameLevel() + 100)
    Frame:EnableMouse(true)

    do
        local Bg = Frame:CreateTexture(nil, 'BACKGROUND')
        Bg:SetAllPoints(true)
        Bg:SetTexture([[Interface\FrameGeneral\UI-Background-Marble]])

        local TLCorner = Frame:CreateTexture(nil, 'ARTWORK')
        TLCorner:SetSize(64, 64)
        TLCorner:SetPoint('TOPLEFT', Bg, 'TOPLEFT')
        TLCorner:SetTexture([[Interface\Common\bluemenu-main]])
        TLCorner:SetTexCoord(0.00390625, 0.25390625, 0.00097656, 0.06347656)

        local TRCorner = Frame:CreateTexture(nil, 'ARTWORK')
        TRCorner:SetSize(64, 64)
        TRCorner:SetPoint('TOPRIGHT', Bg, 'TOPRIGHT')
        TRCorner:SetTexture([[Interface\Common\bluemenu-main]])
        TRCorner:SetTexCoord(0.51953125, 0.76953125, 0.00097656, 0.06347656)

        local BRCorner = Frame:CreateTexture(nil, 'ARTWORK')
        BRCorner:SetSize(64, 64)
        BRCorner:SetPoint('BOTTOMRIGHT', Bg, 'BOTTOMRIGHT')
        BRCorner:SetTexture([[Interface\Common\bluemenu-main]])
        BRCorner:SetTexCoord(0.00390625, 0.25390625, 0.06542969, 0.12792969)

        local BLCorner = Frame:CreateTexture(nil, 'ARTWORK')
        BLCorner:SetSize(64, 64)
        BLCorner:SetPoint('BOTTOMLEFT', Bg, 'BOTTOMLEFT')
        BLCorner:SetTexture([[Interface\Common\bluemenu-main]])
        BLCorner:SetTexCoord(0.26171875, 0.51171875, 0.00097656, 0.06347656)

        local LLine = Frame:CreateTexture(nil, 'ARTWORK')
        LLine:SetWidth(43)
        LLine:SetPoint('TOPLEFT', TLCorner, 'BOTTOMLEFT')
        LLine:SetPoint('BOTTOMLEFT', BLCorner, 'TOPLEFT')
        LLine:SetTexture([[Interface\Common\bluemenu-vert]])
        LLine:SetTexCoord(0.06250000, 0.39843750, 0.00000000, 1.00000000)

        local RLine = Frame:CreateTexture(nil, 'ARTWORK')
        RLine:SetWidth(43)
        RLine:SetPoint('TOPRIGHT', TRCorner, 'BOTTOMRIGHT')
        RLine:SetPoint('BOTTOMRIGHT', BRCorner, 'TOPRIGHT')
        RLine:SetTexture([[Interface\Common\bluemenu-vert]])
        RLine:SetTexCoord(0.41406250, 0.75000000, 0.00000000, 1.00000000)

        local BLine = Frame:CreateTexture(nil, 'ARTWORK')
        BLine:SetHeight(43)
        BLine:SetPoint('BOTTOMLEFT', BLCorner, 'BOTTOMRIGHT')
        BLine:SetPoint('BOTTOMRIGHT', BRCorner, 'BOTTOMLEFT')
        BLine:SetTexture([[Interface\Common\bluemenu-goldborder-horiz]])
        BLine:SetTexCoord(0.00000000, 1.00000000, 0.35937500, 0.69531250)

        local TLine = Frame:CreateTexture(nil, 'ARTWORK')
        TLine:SetHeight(43)
        TLine:SetPoint('TOPLEFT', TLCorner, 'TOPRIGHT')
        TLine:SetPoint('TOPRIGHT', TRCorner, 'TOPLEFT')
        TLine:SetTexture([[Interface\Common\bluemenu-goldborder-horiz]])
        TLine:SetTexCoord(0.00000000, 1.00000000, 0.00781250, 0.34375000)
    end

    local RuleInput = ns.GUI:GetClass('InputBox'):New(Frame)
    RuleInput:SetPoint('TOPLEFT', 20, -60)
    RuleInput:SetPoint('TOPRIGHT', -20, -60)
    RuleInput:SetHeight(22)
    RuleInput:HookScript('OnTextChanged', function()
        self:OnRuleChanged()
    end)
    self:CreateLabel(RuleInput, L['Rule'])

    local WhereDropDown = ns.GUI:GetClass('Dropdown'):New(Frame)
    WhereDropDown:SetPoint('TOPLEFT', RuleInput, 'BOTTOMLEFT', 0, -30)
    WhereDropDown:SetPoint('TOPRIGHT', RuleInput, 'BOTTOMRIGHT', 0, -30)
    WhereDropDown:SetHeight(22)
    WhereDropDown:SetMaxItem(30)
    WhereDropDown:SetMenuTable(function()
        return self:CreateWhereItemTable()
    end)
    self:CreateLabel(WhereDropDown, L['Put where?'])

    local CommentInput = ns.GUI:GetClass('InputBox'):New(Frame)
    CommentInput:SetPoint('TOPLEFT', WhereDropDown, 'BOTTOMLEFT', 0, -30)
    CommentInput:SetPoint('TOPRIGHT', WhereDropDown, 'BOTTOMRIGHT', 0, -30)
    CommentInput:SetHeight(22)
    CommentInput:HookScript('OnTextChanged', function()
        self:UpdateValid()
    end)
    self:CreateLabel(CommentInput, L['Name (Optional)'])

    local IconsFrame = CreateFrame('Frame', nil, Frame)
    IconsFrame:SetPoint('TOPLEFT', CommentInput, 'BOTTOMLEFT', 0, -30)
    IconsFrame:SetPoint('TOPRIGHT', CommentInput, 'BOTTOMRIGHT', 0, -30)
    IconsFrame:SetPoint('BOTTOM', 0, 50)
    self:CreateLabel(IconsFrame, L['Select an icon (Optional)'])

    local ExecButton = CreateFrame('Button', nil, Frame, 'UIPanelButtonTemplate')
    ExecButton:SetSize(80, 22)
    ExecButton:SetPoint('BOTTOMRIGHT', Frame, 'BOTTOM', 0, 20)
    ExecButton:SetText(SAVE)
    ExecButton:SetScript('OnClick', function()
        self:OnSaveClick()
    end)

    local CancelButton = CreateFrame('Button', nil, Frame, 'UIPanelButtonTemplate')
    CancelButton:SetSize(80, 22)
    CancelButton:SetPoint('BOTTOMLEFT', Frame, 'BOTTOM', 0, 20)
    CancelButton:SetText(CANCEL)
    CancelButton:SetScript('OnClick', function()
        Frame:Hide()
    end)

    local function OnClick(button)
        for _, v in pairs(self.iconButtons) do
            v:SetChecked(v == button)
        end
        self.selectedIcon = button.icon
    end

    self.iconButtons = setmetatable({}, {
        __index = function(t, i)
            local icon = CreateFrame('CheckButton', nil, IconsFrame)
            icon:SetSize(ICON_SIZE, ICON_SIZE)
            icon:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
            icon:SetCheckedTexture([[Interface\Buttons\CheckButtonHilight]])
            icon:SetScript('OnClick', OnClick)
            t[i] = icon
            return icon
        end,
    })

    self.IconsFrame = IconsFrame
    self.RuleInput = RuleInput
    self.CommentInput = CommentInput
    self.WhereDropDown = WhereDropDown
    self.ExecButton = ExecButton
    self.Frame = Frame

    Frame:SetScript('OnShow', function()
        self:OnShow()
    end)
    Frame:SetScript('OnHide', Frame.Hide)
end

function RuleEditor:OnShow()
    if self.rule then
        self.RuleInput:SetText(self.rule.rule or '')
        self.CommentInput:SetText(self.rule.comment or '')
        self.WhereDropDown:SetValue(self.rule)
        self.WhereDropDown:Disable()
    else
        self.RuleInput:SetText('')
        self.CommentInput:SetText('')
        self.WhereDropDown:SetValue(self.root)
        self.WhereDropDown:Enable()
    end
end

function RuleEditor:CreateLabel(widget, text)
    local label = widget:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    label:SetPoint('BOTTOMLEFT', widget, 'TOPLEFT', 0, 5)
    label:SetText(text)
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
        local where = self.WhereDropDown:GetValue()
        where.children = where.children or {}
        tinsert(where.children, item)
    end
    self:Hide()

    if self.callback then
        self.callback()
    end
end

function RuleEditor:CreateWhereItemTable(profile)
    local menuTable = {}

    if not profile then
        profile = self.root.children

        tinsert(menuTable, {
            checkable = true,
            text = L['Root'],
            value = self.root,
            checked = function(item, owner)
                return item.value == owner:GetValue()
            end,
        })
    end

    for i, v in ipairs(profile) do
        if ns.IsAdvanceRule(v) then
            local name, icon, rule = ns.GetRuleInfo(v)
            local hasArrow = v.children and #v.children > 0

            tinsert(menuTable, {
                checkable = true,
                text = name,
                value = v,
                checked = function(item, owner)
                    return item.value == owner:GetValue()
                end,
                hasArrow = hasArrow,
                menuTable = hasArrow and function()
                    return self:CreateWhereItemTable(v.children)
                end or nil,
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
    self:Show()
end
