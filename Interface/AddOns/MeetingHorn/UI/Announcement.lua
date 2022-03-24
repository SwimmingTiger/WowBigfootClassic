-- Encounter.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/22/2020, 10:01:07 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local Announcement = ns.Addon:NewClass('UI.Announcement', 'Frame')
LibStub:GetLibrary('AceEvent-3.0'):Embed(Announcement)

function Announcement:Constructor()
    self.db = ns.Addon.db

    self:SetScript('OnShow', self.OnShow)
    self:RegisterMessage('MEETINGHORN_SERVER_CONNECTED')
    self:RegisterMessage('MEETINGHORN_ANNOUNCEMENT')

    if self.db.global.AnnData then
        self:Refresh()
        self.loading:Hide()
    end

end

function Announcement:OnShow()
    self:RequestData()
    self:InitBG()
    ns.Stats:Send('AnnouncementClick')
end

function Announcement:RequestData()
    if self.connected and not self.isGetData then
        self.isGetData = true
        ns.LFG:SendServer('SANNOUNCEMENT')
    end
end

function Announcement:InitBG()
    if self.isInit then
        return
    end
    self.isInit = true
    local width, height = self:GetSize()

    local topWidth, topHeight = width / 3, width / 3;
    local botWidth, botHeight = topWidth, height - topHeight;
    local BTLT = self:CreateTexture(nil, 'BORDER', nil, 1)
    do
        BTLT:SetSize(topWidth, topHeight)
        BTLT:SetPoint('TOPLEFT')
        BTLT:SetTexture([[Interface\GLUES\CREDITS\gatetga1]])
        BTLT:SetAlpha(0.4)
    end

    local BTT = self:CreateTexture(nil, 'BORDER', nil, 1)
    do
        BTT:SetSize(topWidth, topHeight)
        BTT:SetPoint('LEFT', BTLT, 'RIGHT')
        BTT:SetTexture([[Interface\GLUES\CREDITS\gatetga2]])
        BTT:SetAlpha(0.4)
    end

    local BTRT = self:CreateTexture(nil, 'BORDER', nil, 1)
    do
        BTRT:SetSize(topWidth, topHeight)
        BTRT:SetPoint('LEFT', BTT, 'RIGHT')
        BTRT:SetTexture([[Interface\GLUES\CREDITS\gatetga3]])
        BTRT:SetAlpha(0.4)
    end

    local BBLT = self:CreateTexture(nil, 'BORDER', nil, 1)
    do
        BBLT:SetSize(botWidth, botHeight)
        BBLT:SetPoint('TOP', BTLT, 'BOTTOM')
        BBLT:SetTexture([[Interface\GLUES\CREDITS\gatetga5]])
        BBLT:SetTexCoord(0, 1, 0, botHeight / topHeight)
        BBLT:SetAlpha(0.4)
    end

    local BBT = self:CreateTexture(nil, 'BORDER', nil, 1)
    do
        BBT:SetSize(botWidth, botHeight)
        BBT:SetPoint('LEFT', BBLT, 'RIGHT')
        BBT:SetTexture([[Interface\GLUES\CREDITS\gatetga6]])
        BBT:SetTexCoord(0, 1, 0, botHeight / topHeight)
        BBT:SetAlpha(0.4)
    end

    local BBRT = self:CreateTexture(nil, 'BORDER', nil, 1)
    do
        BBRT:SetSize(botWidth, botHeight)
        BBRT:SetPoint('LEFT', BBT, 'RIGHT')
        BBRT:SetTexture([[Interface\GLUES\CREDITS\gatetga7]])
        BBRT:SetTexCoord(0, 1, 0, botHeight / topHeight)
        BBRT:SetAlpha(0.4)
    end
end

function Announcement:Refresh()
    local annData = self.db.global.AnnData
    local NoticeContainer = self.container.NoticeContainer

    local width = NoticeContainer.notices[1]:GetWidth()
    NoticeContainer:SetWidth((width + 10) * #annData - 10)

    for i, notice in ipairs(NoticeContainer.notices) do
        local v = annData[i]
        if v then
            notice.Text:SetText(v.t or '')
            notice.LookDetail:SetShown(v.u)
            notice.LookDetail:SetScript('OnClick', function()
                ns.OpenUrlDialog(v.u)
            end)
        else
            notice:Hide()
        end
    end
end

function Announcement:MEETINGHORN_SERVER_CONNECTED()
    self.connected = true
    if self:IsVisible() then
        self:RequestData()
    end
end

function Announcement:MEETINGHORN_ANNOUNCEMENT(eventName, data)
    self.loading:Hide()
    if data == 'newest' then
        return
    end
    self.db.global.AnnData = data
    self:Refresh()
end
