---@type ns
local ADDON_NAME, ns = ...
local L = ns.L
local Log = ns.Logger

---@class NeteaseWargameUIMatchPanel
local MatchPanel = ns.Addon:NewClass('UI.MatchPanel', 'Frame')

function MatchPanel:Constructor()

    self.bgTex = {}
    self.titleTex = {}
    self.gameId = 0

    self.Description.More.Text:SetText(L['详细规则'])

    local function OnClick()
        if self.MatchTimer then
            local currentGame = ns.Wargame:CurrentGame()
            if currentGame then
                Log:Debug('Cancel Match', currentGame.id)
                ns.Wargame:CancelMatch(currentGame.id, false)
            end
            self.MatchButton:Disable()
        else
            local ok, msg = ns.Wargame:Match(self.gameId)
            if not ok then
                ns.MsgBox(msg)
                return
            end

            if not self.MatchTimer then
                self.MatchTimer = C_Timer.NewTicker(1, function()
                    self:UpdateButtons()
                end)
            end
            self:UpdateButtons()
            Log:Debug('Start Match', self.gameId)
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
            editText = game:GetGameRules(),
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

function MatchPanel:StopMatching()
    if self.MatchTimer then
        self.MatchTimer:Cancel()
        self.MatchTimer = nil
    end
end

function MatchPanel:UpdateButtons()
    local currentGame = ns.Wargame:CurrentGame()
    if currentGame then
        if self.NotStartTimer then
            self.NotStartTimer:Cancel()
            self.NotStartTimer = nil
        end

        if ns.Wargame:IsInBattle() then
            self.MatchButton:SetText(L['比赛中'])
            self.Duration:SetText('')
            self.MatchButton:SetEnabled(false)
        elseif currentGame.id ~= self.gameId then
            self.MatchButton:SetText(L['匹配'])
            self.Duration:SetText('')
            self.MatchButton:SetEnabled(false)
        else
            local duration = ns.time() - ns.Wargame.gameMatchTick
            self.Duration:SetText(string.format(L['正在寻找对手%s...|n%02d:%02d'],
                                                currentGame and string.format('[%s]', currentGame.tabName) or '',
                                                duration / 60, duration % 60))
            self.MatchButton:SetText(L['取消'])
            self.MatchButton:Enable()
        end
    else
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
        else
            if self.NotStartTimer then
                self.NotStartTimer:Cancel()
                self.NotStartTimer = nil
            end
            local inBattleground = UnitInBattleground('player') or IsWargame()
            self.MatchButton:SetText(inprogress and L['匹配'] or L['赛事结束'])
            self.Duration:SetText('')
            self.MatchButton:SetEnabled(inprogress and not inBattleground)
        end
    end
end

function MatchPanel:Update()
    local game = ns.Wargame.games[self.gameId]
    if not game then
        return
    end

    self:UpdateDescription(game)
    self.Param.Mode:SetText(string.format(L['比赛模式：%s'], game.mode))
    self.Param.Time:SetText(game:GetStartTimeText())

    -- 进度条
    if game.templateId == ns.TEMPLATE.GUILD_GAME then
        self.ProgressBar:SetMinMaxValues(0, game.maxRoundCount or 0)
        self.ProgressBar:SetValue(game.roundCount or 0)
        self.ProgressBar.Text:SetText(string.format(L['比赛进度：%s/%s'], game.roundCount or 0,
                                                    game.maxRoundCount or 0))
        self.ProgressBar:Show()
    else

        self.ProgressBar:Hide()
    end

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
        self.titleTex[texName] = tex
    end
    tex:Show()
    tex.Text:SetText(game.title)

    self:UpdateButtons()
end

function MatchPanel:UpdateDescription(game)
    self.Description.Text:SetText(game and game:GetMatchDesc() or '')
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
    self:StopMatching()
    self:UpdateButtons()
end

function MatchPanel:NETEASE_WARGAME_MATCH_START(_, error, gameId, errorData)
    if error == 0 and (not ns.Wargame:CurrentGame() or ns.Wargame:CurrentGame().id ~= gameId) then
        return
    end

    self:StopMatching()
    self.MatchButton:SetText(error == 0 and L['比赛中'] or L['匹配'])
    self.Duration:SetText('')

    if error ~= 0 then
        self.MatchButton:Enable()
        if error == ns.ErrorCode.ERR_MEMBERS_IN_DIFFERENT_TEAM and type(errorData) == 'table' then
            ns.MsgBox(string.format(
                          L['检测到成员|cffff0000%s|r已经加入过其他队伍，无法与当前队伍进行匹配'],
                          table.concat(errorData, L['、'])))
        elseif error == ns.ErrorCode.ERR_SOME_MEMBER_ALREADY_IN_GAME and type(errorData) == 'table' then
            ns.MsgBox(string.format(L['检测到成员|cffff0000%s|r已经在游戏中，无法进行匹配'],
                                    table.concat(errorData, L['、'])))
        else
            ns.MsgBox(ns.GetError(error))
        end
    else
        self.MatchButton:Disable()
    end
end

function MatchPanel:NETEASE_WARGAME_MATCH_CANCEL(_, error, gameId)
    local currentGame = ns.Wargame:CurrentGame()
    if currentGame and currentGame.id ~= gameId then
        return
    end

    if error ~= 0 then
        ns.MsgBox(ns.GetError(error))
    else
        self:StopMatching()
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
