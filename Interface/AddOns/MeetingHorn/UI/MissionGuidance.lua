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
        title = "联盟",
        color = {0.011,0.635,0.913},
        urls ={
            {
                t = "地狱火半岛任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/286781"
            },
            {
                t = "赞加沼泽任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287201"
            },
            {
                t = "泰罗卡森林任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287210"
            },
            {
                t = "纳格兰任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287169"
            },
            {
                t = "刀锋山任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287287"
            },
            {
                t = "影月谷任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287379"
            }
          }
    },
    {
        title = "部落",
        color = {0.725,0.168,0.145},
        urls = {
            {
                t = "地狱火半岛任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/286760"
            },
            {
                t = "赞加沼泽任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287171"
            },
            {
                t = "泰罗卡森林任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287208"
            },
            {
                t = "纳格兰任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287160"
            },
            {
                t = "刀锋山任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287270"
            },
            {
                t = "影月谷任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287384"
            }
          }
    },
    {
        title = "其他",
        color = {0.411,0.662,0.025},
        urls ={
            {
                t = "虚空风暴任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/287299"
            },
            {
                t = "卡拉赞钥匙&夜之魇召唤任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/288167"
            },
            {
                t = "禁魔监狱钥匙任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/288168"
            },
            {
                t = "破碎大厅钥匙任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/288169"
            },
            {
                t = "黑色沼泽开门任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/288170"
            },
            {
                t = "灵翼龙任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/289596"
            },
            {
                t = "奥格瑞拉任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/289646"
            },
            {
                t = "纳鲁的勇士（毒蛇神殿、风暴要塞开门）任务链",
                u = "https://www.battlenet.com.cn/support/zh/article/289732"
            }
          }
    }
}

local MissionGuidance = ns.Addon:NewClass('UI.MissionGuidance', 'Frame')

function MissionGuidance:Constructor()


    self.button = {}
    local container = self.MissionGuidanceScrollFrame.container
    setmetatable(self.button, {__index = function (t, k)
        local btn = CreateFrame("Button", nil, container)
        local fontStr = btn:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
        btn:SetFontString(fontStr)
        fontStr:SetPoint("CENTER")
        t[k] = btn
        
        btn:SetHighlightTexture([[Interface\Buttons\ui-silver-button-highlight]],"ADD")
        local highlight = btn:GetHighlightTexture()
        highlight:ClearAllPoints()
        highlight:SetPoint("TOPLEFT", highlight:GetParent(),"BOTTOMLEFT", 0, 0)
        highlight:SetPoint("BOTTOMRIGHT", highlight:GetParent(),"BOTTOMRIGHT", 0, -5)
        return btn
    end})

    self.label = {}
    setmetatable(self.label, {__index = function (t, k)
        t[k] = container:CreateFontString(nil, "OVERLAY", "GameFontHighlightLeft")
        return t[k]
    end})
    self:SetScript("OnShow", function()
        ns.Stats:Send('TaskGuideClick')
    end)
    self:Refresh()
end

function MissionGuidance:Refresh()
    local data = linkData
    local container = self.MissionGuidanceScrollFrame.container
    local height = 56
    local width = max(self.MissionGuidanceScrollFrame:GetWidth(), 783)
    local btnIndex = 0
    local off = -20
    for k, v in ipairs(data) do
        local label = self.label[k]
        local color = v.color
        label:SetText(v.title..":")
        if k == 1 then
            label:SetPoint("TOPLEFT", container.title2, "BOTTOMLEFT", 0, -10)
            height = height + 26
        else
            label:SetPoint("TOPLEFT", self.label[k-1], "BOTTOMLEFT", 0, off)
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
                btn:SetPoint("TOPLEFT", label, "BOTTOMLEFT", w, h)
                off = off - 26
            else
                btn:SetPoint("LEFT", self.button[btnIndex - 1], "RIGHT", 20, 0)
            end
            w = w + fontStr:GetStringWidth() + 20
            btn:SetSize(fontStr:GetStringWidth(),16)

            btn:SetScript("OnClick", function ()
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
