---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class NeteaseWargameUIMatchPanel
local MatchPanel = ns.Addon:NewClass('UI.MatchPanel', 'Frame')

function MatchPanel:Constructor()

    self.bgTex = {}
    self.titleTex = {}
    self.gameId = 0

    self.Description.More.Text:SetText(L['详细规则'])

    local function OnClick()
        if self.MatchTimer then
            ns.Wargame:CancelMatch(self.gameId, false)
            self.MatchButton:Disable()
        else
            local ok, msg = ns.Wargame:Match(self.gameId)
            if not ok then
                ns.MsgBox(msg)
                return
            end

            self.MatchDuration = 0
            if not self.MatchTimer then
                self.MatchTimer = C_Timer.NewTicker(1, function()
                    self:UpdateButtons()
                end)
            end
            self:UpdateButtons()
        end
    end

    self.MatchButton:SetScript('OnClick', OnClick)

    self:SetCallback('OnMoreClick', function()
        local game = ns.Wargame.games[self.gameId]
        if not game then
            return
        end

        ns.Addon:OpenBlocker({
            text = L['比赛规则'],
            acceptText = CLOSE,
            editText = game.zone == ns.ZONE.Warsong and ns.FormatSummary(L.WARSONG_RULES, game) or L.ALX_RULES,
            cancelHidden = true,
            editBox = true,
        })
    end)

    self:RegisterMessage('NETEASE_WARGAME_GAME_SELECTED')
    self:RegisterMessage('NETEASE_WARGAME_MATCH_START')
    self:RegisterMessage('NETEASE_WARGAME_MATCH_CANCEL')
    self:RegisterMessage('NETEASE_WARGAME_BATTLE_FINISH')
    self:RegisterMessage('NETEASE_WARGAME_LEAVE_BATTLE')
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
end

function MatchPanel:Clear()

    for _, tex in pairs(self.bgTex) do
        tex:Hide()
    end

    for _, tex in pairs(self.titleTex) do
        tex:Hide()
    end

    if self.MatchTimer then
        self.MatchTimer:Cancel()
        self.MatchTimer = nil
    end

    if self.NotStartTimer then
        self.NotStartTimer:Cancel()
        self.NotStartTimer = nil
    end

    self:UpdateDescription()
    self.Param.Mode:SetText('')
    self.Param.Time:SetText('')
    self.Duration:SetText('')
    self.ProgressBar.Text:SetText('')
    self.MatchButton:SetText(L['匹配'])
    self.MatchButton:Enable()
    self.gameId = 0
end

function MatchPanel:UpdateButtons()
    local game = ns.Wargame.games[self.gameId]
    if not game then
        return
    end

    local duration = game:GetNextStartTime()
    local inprogress = game:IsInProgress()
    if duration and not inprogress then
        if not self.NotStartTimer then
            self.NotStartTimer = C_Timer.NewTicker(1, function()
                self:UpdateButtons()
            end)
        end
        local hours, minutes, seconds = ns.secToHMS(duration - ns.time())
        self.MatchButton:SetText(string.format(L['距离比赛开始|n%02d:%02d:%02d'], hours, minutes, seconds))
        self.MatchButton:Disable()
    elseif self.MatchTimer then
        self.MatchDuration = self.MatchDuration + 1
        self.Duration:SetText(string.format(L['正在寻找对手...|n%02d:%02d'], self.MatchDuration / 60,
                                            self.MatchDuration % 60))
        self.MatchButton:SetText(L['取消'])
        self.MatchButton:Enable()
    else
        if self.NotStartTimer then
            self.NotStartTimer:Cancel()
            self.NotStartTimer = nil
        end
        local inBattle = ns.Wargame:IsInBattle()
        self.MatchButton:SetText(inBattle and L['比赛中'] or inprogress and L['匹配'] or L['赛事结束'])
        self.Duration:SetText('')
        self.MatchButton:SetEnabled(inprogress and not inBattle)
    end
end

function MatchPanel:Update()
    local game = ns.Wargame.games[self.gameId]
    if not game then
        return
    end

    -- self.Description.Text:SetText(ns.FormatSummary(L.MATCH_DESCRIPTION, game))
    self:UpdateDescription(game)
    self.Param.Mode:SetText(string.format(L['比赛模式：%s'], game.mode))
    self.Param.Time:SetText(game:GetStartTimeText())
    self.ProgressBar:SetMinMaxValues(0, game.maxRoundCount or 0)
    self.ProgressBar:SetValue(game.roundCount or 0)
    self.ProgressBar.Text:SetText(
        string.format(L['比赛进度：%s/%s'], game.roundCount or 0, game.maxRoundCount or 0))

    -- update texture
    local texName = 'nw-bg-' .. game.zone
    local tex = self.bgTex[texName]
    if not tex then
        tex = self:CreateTexture(nil, 'BACKGROUND', texName)
        tex:SetAllPoints()
        self.bgTex[texName] = tex
    end
    tex:Show()

    local texName = 'NeteaseWargameTitleTexture' .. game.zone
    local tex = self.titleTex[texName]
    if not tex then
        tex = CreateFrame('Frame', nil, self, texName)
        tex:SetPoint('TOP', 0, -10)
        self.titleTex[texName] = tex
    end
    tex:Show()
    tex.Text:SetText(game.title)

    self:UpdateButtons()
end

function MatchPanel:UpdateDescription(game)
    self.Description.Text:SetText(game and ns.FormatSummary(L.MATCH_DESCRIPTION, game) or '')
    self.Description:SetHeight(max(105, self.Description.Text:GetStringHeight() + 30))
end

---@param game NeteaseWargameGame
function MatchPanel:NETEASE_WARGAME_GAME_SELECTED(_, game)
    self:Clear()
    self.gameId = game.id
    self:Update()
end

function MatchPanel:NETEASE_WARGAME_BATTLE_FINISH(_, error, gameId, isSameRoom)
    if self.gameId == gameId and isSameRoom then
        self:Update()
    end
end

function MatchPanel:NETEASE_WARGAME_LEAVE_BATTLE()
    if self.MatchTimer then
        self.MatchTimer:Cancel()
        self.MatchTimer = nil
    end
    self:UpdateButtons()
end

function MatchPanel:NETEASE_WARGAME_MATCH_START(_, error, gameId, errorData)
    if gameId ~= self.gameId then
        return
    end

    if self.MatchTimer then
        self.MatchTimer:Cancel()
        self.MatchTimer = nil
    end

    self.MatchButton:SetText(error == 0 and L['比赛中'] or L['匹配'])
    self.Duration:SetText('')

    if error ~= 0 then
        self.MatchButton:Enable()
        if error == ns.ErrorCode.ERR_MEMBERS_IN_DIFFERENT_TEAM and type(errorData) == 'table' then
            ns.MsgBox(string.format(
                          L['检测到成员|cffff0000%s|r已经加入过其他队伍，无法与当前队伍进行匹配'],
                          table.concat(errorData, L['、'])))
        else
            ns.MsgBox(ns.GetError(error))
        end
    else
        self.MatchButton:Disable()
    end
end

function MatchPanel:NETEASE_WARGAME_MATCH_CANCEL(_, error, gameId)
    if gameId ~= self.gameId then
        return
    end

    if error ~= 0 then
        ns.MsgBox(ns.GetError(error))
    else
        if self.MatchTimer then
            self.MatchTimer:Cancel()
            self.MatchTimer = nil
        end
    end

    self:UpdateButtons()
end

function MatchPanel:OnShow()
    local game = ns.Wargame.games[self.gameId]
    if game then
        ns.Addon:ShowLoading(false)
        self:UpdateButtons()
    end
end

function MatchPanel:OnHide()
    if self.NotStartTimer then
        self.NotStartTimer:Cancel()
        self.NotStartTimer = nil
    end
end
