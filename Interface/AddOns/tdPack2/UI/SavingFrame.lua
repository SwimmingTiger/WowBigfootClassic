-- SavingFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/9/2019, 2:07:17 PM

---- WOW
local CreateFrame = CreateFrame

---@type ns
local ns = select(2, ...)

local L = ns.L
local UI = ns.UI
local Addon = ns.Addon

local SavingFrame = UI:NewModule('SavingFrame', 'AceEvent-3.0')

function SavingFrame:OnInitialize()
    UI.RuleOption:AddTab(L['Saving rules'], self)
end

function SavingFrame:OnSetup()
    local Frame = CreateFrame('Frame', nil, UI.RuleOption.Inset)
    Frame:SetAllPoints(true)
    Frame:Hide()

    local List = UI.RuleView:Bind(CreateFrame('ScrollFrame', nil, Frame, 'tdPack2ScrollFrameTemplate'))
    List:SetPoint('TOPLEFT', 5, -4)
    List:SetPoint('BOTTOMRIGHT', -20, 3)
    List:SetCallback('OnListChanged', function()
        self:SendMessage('TDPACK_SAVING_RULES_UPDATE')
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

function SavingFrame:OnEnable()
    self:RegisterMessage('TDPACK_SAVING_RULES_UPDATE', 'Refresh')
    self:RegisterMessage('TDPACK_PROFILE_CHANGED', 'Refresh')
    self:Refresh()
end

function SavingFrame:Refresh()
    self.List:SetItemTree(Addon:GetRules(ns.SORT_TYPE.SAVING))
    self.List:Refresh()
end
