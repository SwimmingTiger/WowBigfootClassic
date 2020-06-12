---@class UI
---@field MainPanel NeteaseWargameUIMainPanel
---@field MatchPanel NeteaseWargameUIMatchPanel
---@field TeamPanel NeteaseWargameUITeamPanel
---@field RankPanel NeteaseWargameUIRankPanel
---@field MapCanvas NeteaseWargameUIMapCanvas

---@type ns
---@field UI UI
---@field Addon NeteaseWargame
---@field L NeteaseWargameLocale
local ADDON_NAME, ns = ...

local L = LibStub('AceLocale-3.0'):GetLocale('NeteaseWargame', true)

---@type NeteaseWargame
---@field private MainPanel NeteaseWargameUIMainPanel
local Addon = LibStub('AceAddon-3.0'):NewAddon('NeteaseWargame', 'LibClass-2.0')
ns.Addon = Addon

ns.L = L
ns.UI = {}
ns.GUI = LibStub('tdGUI-1.0')
ns.ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, 'Version')

--[===[@debug@
_G.nw = Addon
--@end-debug@]===]

function Addon:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('NETEASE_WARGAME_DB', { --
        profile = { --
            window = { --
                minimap = {minimapPos = 210.68},
            },
        },
    })

    self.MainPanel = ns.UI.MainPanel:Bind(NeteaseWargameMainPanel)
    self:SetupDataBroker()
end

function Addon:OnEnable()
    local origItemRefTooltipSetHyperlink = ItemRefTooltip.SetHyperlink
    function ItemRefTooltip.SetHyperlink(frame, link, ...)
        local gameId = link:match('wargame:(%d+)')
        if gameId then
            self:OpenMainPanel()
        else
            origItemRefTooltipSetHyperlink(frame, link, ...)
        end
    end
end

function Addon:OnModuleCreated(module)
    ns[module:GetName()] = module
end

function Addon:OnClassCreated(class, name)
    local uiName = name:match('^UI%.(.+)$')
    if uiName then
        LibStub('AceEvent-3.0'):Embed(class)
        ns.UI[uiName] = class
    else
        ns[name] = class
    end
end

function Addon:Toggle()
    if self.MainPanel:IsShown() then
        HideUIPanel(self.MainPanel)
    else
        self:OpenMainPanel()
    end
end

function Addon:OpenMainPanel()
    ShowUIPanel(self.MainPanel)
    ns.Wargame:RefreshGuild()
end

function Addon:ShowLoading(text, spinner)
    local Loading = self.MainPanel.Loading
    if text then
        Loading:SetText(text, spinner)
        Loading:Show()
    else
        Loading:Hide()
    end
end

function Addon:SetupDataBroker()
    local LDB = LibStub('LibDataBroker-1.1')
    local BrokerObject = LDB:NewDataObject('NeteaseWargame', {
        type = 'data source',
        icon = [[Interface\AddOns\Wargame\Media\Logo]],
        OnClick = function()
            return self:Toggle()
        end,
        OnEnter = function(owner)
            local anchor = owner:GetBottom() < GetScreenHeight() / 2 and 'ANCHOR_TOP' or 'ANCHOR_BOTTOM'
            GameTooltip:SetOwner(owner, anchor)
            GameTooltip:SetText(L.ADDON_NAME)
            GameTooltip:Show()
        end,
        OnLeave = GameTooltip_Hide,
    })

    LibStub('LibDBIcon-1.0'):Register('NeteaseWargame', BrokerObject, self.db.profile.window.minimap)
end

function Addon:OpenBlocker(data)
    self.MainPanel.BlockDialog:Open(data)
    self.MainPanel.BlockDialog.EditBox:Disable()
end
