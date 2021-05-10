-- SortingFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/24/2019, 6:20:07 PM

local type, select = type, select
local format = string.format
local tremove = table.remove

local CreateFrame, ToggleDropDownMenu, CloseDropDownMenus = CreateFrame, ToggleDropDownMenu, CloseDropDownMenus
local GetItemQualityColor, GetItemIcon = GetItemQualityColor, GetItemIcon

local UIParent, GameTooltip = UIParent, GameTooltip
local RED_FONT_COLOR_HEX = RED_FONT_COLOR:GenerateHexColor()
local DEFAULT_ICON = [[Interface\Icons\INV_MISC_QUESTIONMARK]]

local WHERE_AFTER = 1
local WHERE_BEFORE = 2
local WHERE_IN = 3

---@type ns
local ns = select(2, ...)
local L = ns.L
local UI = ns.UI
local Addon = ns.Addon
local ItemInfoCache = ns.ItemInfoCache

local SortingFrame = UI:NewModule('SortingFrame', 'AceEvent-3.0')

function SortingFrame:OnInitialize()
    UI.RuleOption:AddTab(L['Sorting rules'], self)
end

function SortingFrame:OnSetup()
    local Frame = CreateFrame('Frame', nil, UI.RuleOption.Inset)
    Frame:SetAllPoints(true)
    Frame:Hide()

    local List = UI.RuleView:Bind(CreateFrame('ScrollFrame', nil, Frame, 'tdPack2ScrollFrameTemplate'))
    List:SetPoint('TOPLEFT', 5, -4)
    List:SetPoint('BOTTOMRIGHT', -20, 3)
    List:SetCallback('OnListChanged', function()
        self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
    end)

    local AddButton = CreateFrame('Button', nil, Frame, 'UIPanelButtonTemplate')
    AddButton:SetPoint('BOTTOMLEFT', UI.RuleOption.Frame, 'BOTTOMLEFT', 0, 0)
    AddButton:SetSize(120, 22)
    MagicButton_OnLoad(AddButton)
    AddButton:SetText(L['Add advance rule'])
    AddButton:SetScript('OnClick', function()
        List:OpenEditor()
    end)

    self.List = List
    self.Frame = Frame
end

function SortingFrame:OnEnable()
    self:RegisterMessage('TDPACK_SORTING_RULES_UPDATE', 'Refresh')
    self:RegisterMessage('TDPACK_PROFILE_CHANGED', 'Refresh')
    self:Refresh()
end

function SortingFrame:Refresh()
    self.List:SetItemTree(Addon:GetRules(ns.SORT_TYPE.SORTING))
    self.List:Refresh()
end
