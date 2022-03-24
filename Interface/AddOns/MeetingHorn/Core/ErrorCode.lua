---@type ns
local ns = select(2, ...)
local L = ns.L

ns.ErrorCode = {
    'INVALID_GUID', -- GUID错误
    'NO_ACTIVE_ACTIVITY ', -- 没有激活的活动
    'ACTIVITY_NOT_FINISH', -- 任务没有完成
    'ACTIVITY_REWARD_FETCHED ', -- 任务奖励已领取
    'ACTIVITY_FETCH_REWARD_FAILED ', -- 任务奖励领取失败
    'ACTIVITY_REWARD_OUT_OF_DATE', -- 任务奖励国企
    'ACTIVITY_INVALID_FETCH_CONDITION',-- 领取条件未达成
    'ADDON_UPDATED',-- 插件已更新

    INVALID_GUID = 1, -- GUID错误
    NO_ACTIVE_ACTIVITY = 2, -- 没有激活的活动
    ACTIVITY_NOT_FINISH = 3, -- 任务没有完成
    ACTIVITY_REWARD_FETCHED = 4, -- 任务奖励已领取
    ACTIVITY_FETCH_REWARD_FAILED = 5, -- 任务奖励领取失败
    ACTIVITY_REWARD_OUT_OF_DATE = 6, -- 任务奖励国企
    ACTIVITY_INVALID_FETCH_CONDITION = 7, -- 领取条件未达成
    ADDON_UPDATED = 8, -- 插件已更新
}

---@param error number
function ns.errorString(error)
    if ns.ErrorCode[error] then
        return L[ns.ErrorCode[error]]
    end
    return
end
