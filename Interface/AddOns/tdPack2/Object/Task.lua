-- Task.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/14/2019, 2:16:54 PM

---@type ns
local ns = select(2, ...)

---@class Task
local Task = ns.Addon:NewClass('Task')

function Task._Meta:__call()
    if not self.running then
        if ns.Pack:IsLocked() then
            return false
        end

        if self:Prepare() then
            return true
        end
        self.running = true
    else
        if self:Process() then
            self:Finish()
            self.running = nil
            return true
        end
    end
    return false
end
