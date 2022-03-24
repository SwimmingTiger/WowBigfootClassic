-- EncounterInfo.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/28/2020, 12:54:55 PM
--
---@type ns
local ns = select(2, ...)

---@class EncounterInfoOverview
---@field Text FontString

---@class EncounterInfo
---@field Button Button
---@field Overview EncounterInfoOverview
local EncounterInfo = ns.Addon:NewClass('UI.EncounterInfo', 'Frame')
Mixin(EncounterInfo, ns.UI.EncounterInfoBase, ns.UI.EncounterInfoPool)
LibStub('AceEvent-3.0'):Embed(EncounterInfo)

EncounterInfo.free = {}
EncounterInfo.overviewFixedHeight = 20
EncounterInfo.fixedHeight = 30

function EncounterInfo:Constructor()
    self.children = {}
    self:SetScript('OnHide', self.OnHide)
    self:UpdateState()
end

function EncounterInfo:OnHide()
    ns.GUI:CloseMenu()
end

function EncounterInfo:Create(parent)
    return self:Bind(CreateFrame('Frame', nil, parent, 'MeetingHornEncounterInfoTemplate'))
end

function EncounterInfo:OnAlloc()
    self:RegisterMessage('ENCOUNTER_CHAT_COOLDOWN', 'UpdateCooldown')
end

function EncounterInfo:OnFree()
    self:Collapse()
    self:UnregisterAllMessages()
end

function EncounterInfo:OnClick()
    if self.expanded then
        self:Collapse()
    else
        self:Expand()
    end
end

function EncounterInfo:UpdateCooldown()
    local start, duration = ns.Addon.MainPanel.Encounter:GetChatCooldown()

    if GetTime() < start + duration then
        self.Button.ChatButton:Disable()
    else
        self.Button.ChatButton:Enable()
    end
end

function EncounterInfo:Expand()
    if not self.Button then
        return
    end

    if self.expanded then
        return
    end

    self.expanded = true
    self:UpdateState()
    self:AdjustHeight()
end

function EncounterInfo:Collapse()
    if not self.Button then
        return
    end

    if not self.expanded then
        return
    end

    self.expanded = false
    self:UpdateState()
    self:AdjustHeight()
end

function EncounterInfo:UpdateState()
    local hidetex = self.expanded and self.Button.textures.collapsed or self.Button.textures.expanded

    self.Button.tex = self.expanded and self.Button.textures.expanded or self.Button.textures.collapsed

    hidetex.up[1]:Hide()
    hidetex.up[2]:Hide()
    hidetex.up[3]:Hide()
    hidetex.down[1]:Hide()
    hidetex.down[2]:Hide()
    hidetex.down[3]:Hide()

    self.Overview:SetShown(self.expanded and self.desc)
    self.FootOverview:SetShown(self.expanded and self.footDesc)
    self.Children:SetShown(self.expanded)

    self.Button.ExpandedIcon:SetText(self.expanded and '-' or '+')
    self.Button:GetScript('OnMouseUp')(self.Button)

    self:UpdateCooldown()
end

local CHAT_MENUS = (function()
    local function exec(button, item)
        local parent = button:GetParent():GetParent()
        ns.Addon.MainPanel.Encounter:SendChat(parent.info, item.channel)
    end

    local function CM(channel, hidden)
        return {text = _G[channel], channel = channel, hidden = hidden, func = exec}
    end

    return {
        CM('SAY'), CM('YELL'), CM('PARTY', function()
            return not IsInGroup(LE_PARTY_CATEGORY_HOME)
        end), CM('RAID', function()
            return not IsInRaid(LE_PARTY_CATEGORY_HOME)
        end), CM('GUILD', function()
            return not IsInGuild()
        end),
    }
end)()

function EncounterInfo:OpenChatMenu(button)
    ns.GUI:ToggleMenu(button, CHAT_MENUS)
end
