
---@type ns
local ns = select(2, ...)

---@class MeetingHornTimer
local Timer = ns.Addon:NewClass('Timer')

function Timer:Constructor(callback)
    self._callback = callback
end

function Timer:Start(interval)
    self._interval = interval
    if self._timer then
        self._timer:Cancel()
    end
    self._timer = C_Timer.NewTicker(interval, self._callback)
end

function Timer:Stop()
    if self._timer then
        self._timer:Cancel()
        self._timer = nil
    end
end
