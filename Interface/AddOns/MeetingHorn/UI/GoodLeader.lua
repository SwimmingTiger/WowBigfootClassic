---@type ns
local ns = select(2, ...)
local L = ns.L

local GoodLeader = ns.Addon:NewClass('UI.GoodLeaderFrame', 'Frame.GoodLeaderTemplate')

function GoodLeader:Constructor(p)
    ns.UI.CountdownButton:Bind(self.First.Header.Search)

    self.instances = self.Result.Raids.instances

    local function CreateInstance(i)
        local frame = CreateFrame('Frame', nil, self.Result.Raids, 'GoodLeaderRaidTemplate')
        -- local font, size = frame.Count:GetFont()
        -- frame.Count:SetFont(font, size, 'OUTLINE')
        self.instances[i] = frame
        return frame
    end

    local index = 1
    for i, v in ipairs(ns.GOODLEADER_INSTANCES) do
        if v.projectId == WOW_PROJECT_ID then
            local button = self.instances[index] or CreateInstance(index)

            button.Name:SetText(C_Map.GetAreaInfo(v.mapId) .. (v.name and '-' .. v.name or ''))
            if type(v.image) == 'string' then
                button.Image:SetTexture([[interface\encounterjournal\ui-ej-dungeonbutton-]] .. v.image)
            else
                button.Image:SetTexture(v.image)
            end
            button.bossId = v.bossId
            button.difficulties = v.difficulties
            index = index + 1
        end
    end

    self.First.Header.Disconnect:SetText(L['星团长查询正在维护中'])
    self:UpdateButton()

    self.First.Header.Search:SetScript('OnClick', function(button)
        ns.GoodLeader:LookupLeader()
        button:SetCountdown(5)
    end)

    self.First.Footer.Text:SetText(L.TIP_SUMMARY)
    self.First.Footer.Title:SetText(L.TIP_TITLE)

    self.Result.Score.NoResult:SetText(L['团长被评价数量较少，暂时无法查看。'])
    self.Result.Raids.Title:SetText(L['作为团长的次数：|cff808080（暴雪通行证下所有角色）|r'])

    ns.UI.QRCodeWidget:Bind(self.First.Inset.QRCode)

    self.scores = {}

    local function SetupScore(frame, text)
        frame.Text:SetText(text)
        frame.Score:SetReadOnly(true)

        tinsert(self.scores, frame)
    end

    SetupScore(self.Result.Score.Score1, L['指挥：'])
    SetupScore(self.Result.Score.Score2, L['公正：'])
    SetupScore(self.Result.Score.Score3, L['运势：'])

    self.First:SetScript('OnShow', function()
        self.First.Inset.QRCode:SetValue(ns.MakeQRCode(ns.GetGroupLeader()))
    end)

    self.Result.Raids:SetScript('OnSizeChanged', function()
        local spacing = 10
        local parentWidth = self.Result.Raids:GetWidth() - spacing * 2
        local width = parentWidth
        local x = 0
        local y = 0
        local buttonWidth = self.instances[1]:GetWidth()
        local buttonHeight = self.instances[1]:GetHeight()
        local relativeTo = self.Result.Raids.Title

        for i, button in ipairs(self.instances) do
            button:ClearAllPoints()
            button:SetPoint('TOPLEFT', relativeTo, 'BOTTOMLEFT', x * (buttonWidth + spacing),
                            -y * (buttonHeight + spacing) - spacing)
            width = width - buttonWidth - spacing

            if width < buttonWidth then
                width = parentWidth
                x = 0
                y = y + 1
            else
                x = x + 1
            end
        end

        if x == 0 then
            y = y - 1
        end

        self.Result.Raids:SetHeight((y + 1) * (buttonHeight + spacing) + 60)
    end)

    ns.ApplyImageButton(self.First.Header.ApplyLeaderBtn, {
        text = '申请星团长',
        summary = '微信扫码 申请星团长',
        texture = [[Interface/AddOns/MeetingHorn/Media/ApplyLeaderQR]],
        points = {'BOTTOMLEFT', self.First.Header.ApplyLeaderBtn, 'BOTTOMRIGHT', 5, -25},
    })

    self:SetScript('OnShow', self.OnShow)
    self:RegisterEvent('GROUP_ROSTER_UPDATE')
    self:RegisterMessage('GOODLEADER_LOGIN')
    self:RegisterMessage('GOODLEADER_LEADERINFO_UPDATE')
    self:RegisterMessage('GOODLEADER_CONNECT_TIMEOUT')
end

function GoodLeader:OnShow()
    self:UpdateLeader()
    self:UpdateButton()
end

function GoodLeader:UpdateLeader()
    local name = ns.GetGroupLeader()
    self.First.Header.Name:SetFormattedText(L['团长ID：%s'], name)
    self.Result.Name:SetFormattedText(L['团长ID：%s'], name)

    if name ~= self.name then
        self.First:Show()
        self.Result:Hide()
    else
        self.First:Hide()
        self.Result:Show()
    end
end

function GoodLeader:GROUP_ROSTER_UPDATE()
    self:UpdateButton()
    self:UpdateLeader()
end

function GoodLeader:GOODLEADER_LOGIN()
    self:UpdateButton()
end

function GoodLeader:GOODLEADER_CONNECT_TIMEOUT()
    self:UpdateButton()
end

function GoodLeader:UpdateButton()
    if ns.GoodLeader:IsServerLogon() then
        -- @non-debug@
        if IsInRaid() or IsInGroup(LE_PARTY_CATEGORY_HOME) then
            -- @end-non-debug@
            self.First.Header.Search:Enable()
            self.First.Header.Search:SetText(L['查询团长信息'])
            -- @non-debug@
        else
            self.First.Header.Search:Disable()
            self.First.Header.Search:SetText(L['进入团队后查询'])
        end
        -- @end-non-debug@
    else
        self.First.Header.Search:Disable()
        self.First.Header.Search:SetText(L['正在初始化'])
    end

    if ns.GoodLeader:IsServerTimeout() then
        self.First.Header.Search:Hide()
        self.First.Header.Disconnect:Show()
    else
        self.First.Header.Search:Show()
        self.First.Header.Disconnect:Hide()
    end
end

function GoodLeader:GOODLEADER_LEADERINFO_UPDATE()
    local name, guid = ns.GetGroupLeader()
    local user = ns.GoodLeader:GetUserCache(guid)

    self.name = name

    local raids = user.raids
    if not raids then
        return
    end

    for _, button in ipairs(self.instances) do
        if button then
            -- button.Count:SetText(raids and raids[button.bossId] or 0)
            local bossData = raids[button.bossId]
            local sb = {}

            for _, difficulty in ipairs(button.difficulties) do
                local count = bossData and bossData[difficulty] or 0

                if count > 0 then
                    count = format('|cffffd100%d|r', count)
                end

                table.insert(sb, format('%s: %s次', GetDifficultyInfo(difficulty), count))
            end

            button.Count:SetText(table.concat(sb, '\n'))
        end
    end

    -- if not user.itemPercent then
    --     self.Result.Info.ItemLevel:SetFormattedText(
    --         L['|cff808080物品等级：|r当前团长未安装星团长插件，需要自行查看。'])
    -- else
    --     self.Result.Info.ItemLevel:SetFormattedText(
    --         L['|cff808080物品等级：|r当前团长的装备超过|cffffd100%s%%|r的玩家。'], user.itemPercent)
    -- end

    if user.guild then
        self.Result.Info.Guild:SetFormattedText(
            L['|cff808080公会成员：|r当前团队有|cffffd100%s|r名成员与团长相同公会，公会名：|cffffd100%s|r。'],
            user.guildCount, user.guild)
    else
        self.Result.Info.Guild:SetFormattedText(
            L['|cff808080公会成员：|r团长距离过远，无法获得公会信息，建议进入团队后查看。'])
    end

    -- self.Result.Name:SetFormattedText(L['团长ID：%s'], name)
    self.Result.Tags:SetText(user.tags and table.concat(user.tags, ',') or '')

    for i, frame in ipairs(self.scores) do
        self:UpdateScore(frame, user.scores and user.scores[i])
    end

    self.Result.Score.NoResult:SetShown(not user.scores)

    self.Result:Show()
    self.First:Hide()
end

function GoodLeader:UpdateScore(frame, score)
    if score then
        frame.Score:SetValue(score)
        frame:Show()
    else
        frame:Hide()
    end
end
