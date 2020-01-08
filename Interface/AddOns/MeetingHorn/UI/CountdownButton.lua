
---@type ns
local ns = select(2, ...)

---@class CountdownButton: Button
local CountdownButton = ns.Addon:NewClass('UI.CountdownButton', 'Button')

function CountdownButton:Constructor()
    self._enabled = self:IsEnabled()
end

function CountdownButton:Enable()
    return self:SetEnabled(true)
end

function CountdownButton:Disable()
    return self:SetEnabled(false)
end

function CountdownButton:SetEnabled(flag)
    self._enabled = flag
    self:Update()
end

function CountdownButton:SetCountdown(duration)
    if self._timer then
        self._timer:Cancel()
    end

    self._timer = C_Timer.NewTimer(duration, function()
        self._timer = nil
        self:Update()
    end)
    self:Update()
end

function CountdownButton:Update()
    self:SuperCall('SetEnabled', not self._timer and self._enabled)
end
