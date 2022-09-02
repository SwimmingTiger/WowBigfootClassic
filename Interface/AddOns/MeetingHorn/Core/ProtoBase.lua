-- ProtoBase.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/4/18 14:13:43
--
---@type ns
local ns = select(2, ...)

---@class ProtoBase: Object
local ProtoBase = ns.Addon:NewClass('ProtoBase')

---@param proto string[]
---@param data any[]
---@param offset? number
function ProtoBase:ApplyProto(proto, data, offset)
    offset = offset or 0

    for i, k in ipairs(proto) do
        if not k:find('^_') then
            self[k] = data[offset + i]
        end
    end
end
