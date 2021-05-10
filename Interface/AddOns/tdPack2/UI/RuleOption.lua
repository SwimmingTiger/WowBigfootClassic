-- RuleOption.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/22/2019, 10:42:28 PM

---- LUA
local tinsert = table.insert
local ipairs = ipairs
local setmetatable = setmetatable

---- WOW
local CreateFrame, ShowUIPanel = CreateFrame, ShowUIPanel
local PanelTemplates_SetNumTabs = PanelTemplates_SetNumTabs
local PanelTemplates_UpdateTabs = PanelTemplates_UpdateTabs
local PanelTemplates_GetSelectedTab = PanelTemplates_GetSelectedTab

---- NS
local ns = select(2, ...)
local L = ns.L
local UI = ns.UI

local RuleOption = UI:NewModule('RuleOption', 'AceEvent-3.0')

function RuleOption:OnInitialize()
    self.tabModules = {}
    self.tabs = setmetatable({}, {
        __index = function(t, i)
            t[i] = self:CreateTab(i)
            return t[i]
        end,
    })
end

function RuleOption:OnSetup()
    local Frame = ns.GUI:GetClass('BasicPanel'):New(UIParent)
    Frame:ShowPortrait()
    Frame:SetPortrait(ns.ICON)
    Frame:SetText('tdPack2')
    Frame:SetMovable(true)
    Frame:SetResizable(true)
    Frame:SetMinResize(337, 423)
    Frame.Tabs = self.tabs
    Frame.selectedTab = 1

    local Inset = CreateFrame('Frame', nil, Frame, 'InsetFrameTemplate')
    Inset:SetPoint('TOPLEFT', 4, -60)
    Inset:SetPoint('BOTTOMRIGHT', -6, 26)

    local Help = CreateFrame('Button', nil, Frame)
    Help:SetPoint('BOTTOMRIGHT', Inset, 'TOPRIGHT', 0, 0)
    Help:SetSize(32, 32)
    Help:SetNormalTexture([[Interface\Common\Help-i]])
    Help:SetHighlightTexture([[Interface\Common\portrait-ring-withbg-highlight]], 'ADD')
    Help:SetScript('OnEnter', function(button)
        GameTooltip:SetOwner(button, 'ANCHOR_BOTTOMLEFT')
        GameTooltip:SetText(L['Help'])
        GameTooltip:AddLine(L['Drag to modify the sorting order'], 1, 1, 1)
        GameTooltip:AddLine(L['Put in an item to add simple rule'], 1, 1, 1)
        GameTooltip:AddLine(L['Advancee rules use LibItemSearch-1.2'], 1, 1, 1)
        GameTooltip:AddLine(L['Enjoy!'], 1, 1, 1)
        GameTooltip:Show()
    end)
    Help:SetScript('OnLeave', GameTooltip_Hide)

    local BlockDialog = ns.GUI:GetClass('BlockDialog'):New(Frame)
    BlockDialog:SetPoint('TOPLEFT', 3, -22)
    BlockDialog:SetPoint('BOTTOMRIGHT', -3, 3)
    BlockDialog:SetFrameLevel(Frame:GetFrameLevel() + 100)

    local name = 'tdPackRuleOption'
    _G[name] = Frame
    tinsert(UISpecialFrames, name)

    self.Inset = Inset
    self.Frame = Frame
    self.BlockDialog = BlockDialog
    self:Refresh()

    UI.BlockDialog = BlockDialog
end

function RuleOption:OnEnable()
    self:RegisterMessage('TDPACK_PROFILE_CHANGED', 'Refresh')
    self:UpdateTabs()
    self:UpdateTabFrames()
end

function RuleOption:Refresh()
    self.Frame:RegisterConfig(ns.Addon:GetOption('ruleOptionWindow'))
    self.Frame:RestoreSize()
    self.Frame:RestorePosition()
end

function RuleOption:AddTab(text, module)
    self.tabModules[#self.tabModules + 1] = {module = module, text = text}
    self:UpdateTabs()
    self:UpdateTabFrames()
end

function RuleOption:CreateTab(index)
    local button = CreateFrame('Button', nil, self.Frame, 'tdPack2TabButtonTemplate')
    button:Hide()
    button:SetText(self.tabModules[index].text)
    button:SetID(index)
    if index == 1 then
        button:SetPoint('TOPLEFT', self.Frame, 'BOTTOMLEFT', 0, 0)
    else
        button:SetPoint('LEFT', self.Frame.Tabs[index - 1], 'RIGHT', -16, 0)
    end
    button:HookScript('OnClick', function()
        self:UpdateTabFrames()
    end)
    button:Show()
    return button
end

function RuleOption.AfterSetup:UpdateTabs()
    PanelTemplates_SetNumTabs(self.Frame, #self.tabModules)
    PanelTemplates_UpdateTabs(self.Frame)
end

function RuleOption.AfterSetup:UpdateTabFrames()
    local current = PanelTemplates_GetSelectedTab(self.Frame)
    for i, v in ipairs(self.tabModules) do
        v.module:SetShown(i == current)
    end
end
