-- Api.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/7/2020, 10:47:42 AM

---@type string
local ADDON_NAME
---@type ns
local ns
ADDON_NAME, ns = ...

local L = ns.L

ns.Logger = LibStub('LibLog-1.0'):GetLogger()

ns.ADDON_NAME = ADDON_NAME
ns.ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, 'Version')
ns.ADDON_PREFIX = format('|cff00ffff%s|r: ', L.ADDON_NAME)

ns.MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()]

ns.RULE = { --
    SameGuild = 0x1,
    MaxPlayerLevel = 0x2,
}

--- MapUtil.GetDisplayableMapForPlayer()
-- mapID 战歌 1460 阿拉希 1461
ns.ZONE = { --
    Warsong = 1460, -- 战歌
    Alx = 1461, -- 阿拉希
}

ns.ErrorCode = {
    ERR_MATCH_NOT_EXISTS = 20001, -- 赛事不存在
    ERR_MATCH_NOT_START = 20002, -- 赛事未开始
    ERR_MATCH_ALREADY_CLOSED = 20003, -- 赛事未开始
    ERR_MEMBERS_IN_DIFFERENT_TEAM = 20004, -- 匹配队员不在同一队伍
    ERR_CREATE_TEAM_FAILED = 20005, -- 创建队伍失败
    ERR_INVALID_PLAYER_COUNT_IN_TEAM = 20006, -- 队伍人数不对
    ERR_INVALID_STANDBY_OUT_OF_LIMIT = 20007, -- 替补超过上限
    ERR_INVALID_RIVALS_TEAM = 20008, -- 无效的对手队伍
    ERR_INVALID_PLAYER = 20009, -- 无效的玩家
    ERR_INVALID_PLAYER_HAS_NO_TEAM = 20010, -- 玩家没有队伍
    ERR_NOT_WAITING_MATCH = 20011, -- 没有在等待匹配
    ERR_TOTAL_GAMES_OUT_OF_LIMIT = 20012, -- 队伍总场次达到上限
    ERR_MATCH_TIMEOUT = 20013, -- 匹配超时
    ERR_MATCH_NOT_IN_VALIDITY = 20014, -- 不在赛事有效期
    ERR_WAIT_ENQUEUE_TIMEOUT = 20015, -- 等待进入战斗队列超时
    ERR_WAIT_BATTLE_TIMEOUT = 20016, -- 等待进入战场超时
    ERR_CLIENT_MAYBE_OFFLINE = 20017, -- 客户端已掉线
    ERR_BATTLE_OUT_OF_TIME = 20018, -- 战斗已超时
    ERR_MATCH_GUILD_CHANGED = 20019, -- 匹配工会和建队伍时候工会不一致
    ERR_MATCH_GAME_CONTINUE = 20020, -- 比赛继续进行
    ERR_MATCH_INVALID_GAME = 20021, -- 无效局
    ERR_MATCH_TOO_MANY_BATTLE_ROOMS = 20022, -- 战场太多
    ERR_TEAM_NOT_PERSIST = 20024, -- 暂时还是临时

    ERR_TEAM_STATE_ERROR = 20101, -- 队伍状态错误 空闲
    ERR_TEAM_STATE_START_MATCHING = 20102, -- 队伍状态错误 开始匹配
    ERR_TEAM_STATE_MATCHING = 20103, -- 队伍状态错误 匹配中
    ERR_WAIT_ENQUEUE = 20104, -- 队伍状态错误 匹配成功等待进入队列
    ERR_TEAM_STATE_WAIT_BATTLE = 20105, -- 队伍状态错误 进队列成功等待战斗
    ERR_TEAM_STATE_BATTLING = 20106, -- 队伍状态错误 战斗中
}

local ErrorCode = {}
for k, v in pairs(ns.ErrorCode) do
    ErrorCode[k] = v
    ErrorCode[v] = k
end
ns.ErrorCode = ErrorCode

function ns.ShortGuid(guid)
    return guid and guid:gsub('^Player%-', '') or nil
end

function ns.UnitShortGuid(unit)
    return ns.ShortGuid(UnitGUID(unit))
end

function ns.UnitClass(unit)
    return (select(3, UnitClass(unit)))
end

function ns.GetBattleTag()
    return (select(2, BNGetInfo()))
end

function ns.IsBNFriend(battleTag)
    for i = 1, BNGetNumFriends() do
        if battleTag == select(3, BNGetFriendInfo(i)) then
            return true
        end
    end
end

function ns.GetNumGroupMembers()
    local num = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
    return num <= 0 and 1 or num
end

function ns.GenerateFromProto(...)
    local keys = {...}

    return function(self, p)
        local obj = self:New()
        for i, k in ipairs(keys) do
            obj[k] = p[i]
        end

        if obj.OnProto then
            obj:OnProto()
        end

        return obj
    end
end

local SOLO_UNITS = {'player'}
local PARTY_UNITS = {'player'}
local RAID_UNITS = {}
do
    for i = 1, 4 do
        tinsert(PARTY_UNITS, 'party' .. i)
    end
    for i = 1, 40 do
        tinsert(RAID_UNITS, 'raid' .. i)
    end
end

function ns.IterateGroupUnits()
    if IsInRaid(LE_PARTY_CATEGORY_HOME) then
        return pairs(RAID_UNITS)
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
        return pairs(PARTY_UNITS)
    else
        return pairs(SOLO_UNITS)
    end
end

function ns.GetClassColor(id)
    local info = C_CreatureInfo.GetClassInfo(id)
    if info then
        return GetClassColor(info.classFile)
    end
    return GetClassColor('PRIEST')
end

function ns.Message(f, ...)
    local text
    if select('#', ...) == 0 then
        text = f
    else
        text = format(f, ...)
    end
    DEFAULT_CHAT_FRAME:AddMessage(ns.ADDON_PREFIX .. text, 1, 1, 0)
end

function ns.Spawn(fn, ...)
    local argCount = select('#', ...)
    if argCount == 0 then
        C_Timer.After(0, fn)
    else
        local args = {...}
        C_Timer.After(0, function()
            return fn(unpack(args, 1, argCount))
        end)
    end
end

function ns.InputBox(title, text, accept, data)
    StaticPopupDialogs['NETEASE_WARGAME_MSG_BOX'] = StaticPopupDialogs['NETEASE_WARGAME_MSG_BOX'] or {}
    local dlg = StaticPopupDialogs['NETEASE_WARGAME_MSG_BOX']
    wipe(dlg)
    dlg.text = title
    dlg.button1 = L['确定']
    dlg.OnAccept = accept
    dlg.hideOnEscape = 1
    dlg.timeout = 0
    dlg.exclusive = 1
    dlg.whileDead = 1
    dlg.hasEditBox = true
    dlg.editBoxWidth = 260
    dlg.EditBoxOnTextChanged = function(editBox, t)
        if t ~= text then
            editBox:SetMaxBytes(nil)
            editBox:SetMaxLetters(nil)
            editBox:SetText(text)
            editBox:HighlightText()
            editBox:SetCursorPosition(0)
            editBox:SetFocus()
        end
    end

    StaticPopup_Show('NETEASE_WARGAME_MSG_BOX', nil, nil, data)
end

function ns.MsgBox(text, accept, data, timeout, button1Text, button2Text, editBoxText)
    StaticPopupDialogs['NETEASE_WARGAME_MSG_BOX'] = StaticPopupDialogs['NETEASE_WARGAME_MSG_BOX'] or {}
    local dlg = StaticPopupDialogs['NETEASE_WARGAME_MSG_BOX']
    wipe(dlg)

    dlg.text = text
    dlg.button1 = button1Text or YES
    dlg.button2 = accept and (button2Text or NO) or nil
    dlg.OnAccept = accept
    dlg.hideOnEscape = 1
    dlg.timeout = timeout or 0
    dlg.exclusive = 1
    dlg.whileDead = 1

    StaticPopup_Show('NETEASE_WARGAME_MSG_BOX', nil, nil, data)
end

function ns.GameToLink(id, text)
    return format('|cff00ffff|Hwargame:%d|h[%s]|h|r', id, text)
end

function ns.time(t)
    if t == nil then
        return GetServerTime()
    else
        return time(t)
    end
end

function ns.date(f, t)
    if t == nil then
        return date(f, GetServerTime())
    else
        return date(f, t)
    end
end

function ns.secToHMS(secs)
    local hours = math.floor(secs / (60 * 60))
    secs = secs - hours * 60 * 60
    local minutes = math.floor(secs / 60)
    return hours, minutes, secs % 60
end

function ns.GetError(error)
    local err = ns.ErrorCode[error]
    return err and L[err] or string.format(L['未知错误：%s'], error)
end

function ns.FormatSummary(text, game)
    return text:gsub('{{([%w_]+)}}', function(key)
        return game[key]
    end)
end
