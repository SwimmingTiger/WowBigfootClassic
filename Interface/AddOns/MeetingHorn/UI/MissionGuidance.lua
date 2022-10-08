-- Encounter.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/22/2020, 10:01:07 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local linkData = {
    {
        title = '地图任务',
        color = {0.011, 0.635, 0.913},
        urls = {
            {t = '北风苔原任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000311711'},
            {t = '嚎风峡湾任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000312437'},
            {t = '龙骨荒野任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000311841'},
            {t = '灰熊丘陵任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000312468'},
            {t = '祖达克任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000312643'},
            {t = '索拉查盆地任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000313194'},
            {t = '风暴峭壁任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000312607'},
            {t = '冰冠冰川任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000312446'},
        },
    }, {
        title = '其他',
        color = {0.411, 0.662, 0.025},
        urls = {
            {t = '死亡骑士新手任务链', u = 'https://www.battlenet.com.cn/support/zh/article/312761'},
            {t = '神谕者/狂心氏族任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000313195'},
            {t = '霍迪尔之子声望开启任务链', u = 'https://www.battlenet.com.cn/support/zh/article/312684'},
            {
                t = '黑锋骑士团声望开启任务链',
                u = 'https://www.battlenet.com.cn/support/zh/article/000318507',
            },
            {t = '团本永恒之眼激活BOSS任务', u = 'https://www.battlenet.com.cn/support/zh/article/000318513'},
            {
                t = '瓦兰奈尔，远古王者之锤任务链',
                u = 'https://www.battlenet.com.cn/support/zh/article/000318509',
            }, {t = '冰冠冰川新三本任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000313192'},
            {t = '橙斧：影之哀伤任务链', u = 'https://www.battlenet.com.cn/support/zh/article/000313191'},
        },
    }, {
        title = '燃烧的远征任务链',
        color = {1.0, 1.0, 1.0},
        urls = {{t = '外域任务指南', u = 'https://www.battlenet.com.cn/support/zh/article/288288'}},
    },
}

local MissionGuidance = ns.Addon:NewClass('UI.MissionGuidance', 'Frame')

function MissionGuidance:Constructor()

    self.button = {}
    local container = self.MissionGuidanceScrollFrame.container
    setmetatable(self.button, {
        __index = function(t, k)
            local btn = CreateFrame('Button', nil, container)
            local fontStr = btn:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightLeft')
            btn:SetFontString(fontStr)
            fontStr:SetPoint('CENTER')
            t[k] = btn

            btn:SetHighlightTexture([[Interface\Buttons\ui-silver-button-highlight]], 'ADD')
            local highlight = btn:GetHighlightTexture()
            highlight:ClearAllPoints()
            highlight:SetPoint('TOPLEFT', highlight:GetParent(), 'BOTTOMLEFT', 0, 0)
            highlight:SetPoint('BOTTOMRIGHT', highlight:GetParent(), 'BOTTOMRIGHT', 0, -5)
            return btn
        end,
    })

    self.label = {}
    setmetatable(self.label, {
        __index = function(t, k)
            t[k] = container:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightLeft')
            return t[k]
        end,
    })
    self:SetScript('OnShow', function()
        ns.Stats:Send('TaskGuideClick')
    end)
    self:Refresh()
end

function MissionGuidance:Refresh()
    local data = linkData
    local container = self.MissionGuidanceScrollFrame.container
    local height = 56
    local width = max(self.MissionGuidanceScrollFrame:GetWidth() - 40, 783)
    local btnIndex = 0
    local off = -20

    for k, v in ipairs(data) do
        local label = self.label[k]
        local color = v.color
        label:SetText(v.title .. ':')
        if k == 1 then
            label:SetPoint('TOPLEFT', 20, -20)
            height = height + 26
        else
            label:SetPoint('TOPLEFT', self.label[k - 1], 'BOTTOMLEFT', 0, off)
            height = height - off + 16
            off = -20
        end
        local w = 0
        local h = -10
        for k1, v1 in ipairs(v.urls) do
            btnIndex = btnIndex + 1
            local btn = self.button[btnIndex]
            btn:ClearAllPoints()
            local fontStr = btn:GetFontString()

            fontStr:SetText(v1.t)
            fontStr:SetTextColor(color[1], color[2], color[3])
            if w + btn:GetTextWidth() > width then
                w = 0
                h = h - 26
            end
            if w == 0 then
                btn:SetPoint('TOPLEFT', label, 'BOTTOMLEFT', w, h)
                off = off - 26
            else
                btn:SetPoint('LEFT', self.button[btnIndex - 1], 'RIGHT', 20, 0)
            end
            w = w + fontStr:GetStringWidth() + 20
            btn:SetSize(fontStr:GetStringWidth(), 16)

            btn:SetScript('OnClick', function()
                ns.OpenUrlDialog(v1.u)
            end)
        end

        label:SetTextColor(color[1], color[2], color[3])
    end
    for i = #data + 1, #self.label do
        self.label[i]:Hide()
    end
    for i = btnIndex + 1, #self.button do
        self.button[i]:Hide()
    end
    height = height - off
    container:SetSize(width, height)
end
