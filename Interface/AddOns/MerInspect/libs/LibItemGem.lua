
-------------------------------------
-- 物品寶石庫 Author: M
-------------------------------------
local MAJOR, MINOR = "LibItemGem.2000", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local SocketTexture = {
    ["EMPTY_SOCKET_RED"] = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Red",
    ["EMPTY_SOCKET_YELLOW"] = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Yellow",
    ["EMPTY_SOCKET_BLUE"] = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Blue",
    ["EMPTY_SOCKET_META"] = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Meta",
}

function lib:GetItemGemInfo(ItemLink)
    local total, info = 0, {}
    local stats = GetItemStats(ItemLink) or {}
    for key, num in pairs(stats) do
        local socket = SocketTexture[key]
        if socket then
            for i = 1, num do
                total = total + 1
                table.insert(info, { name = _G[key] or EMPTY, link = nil, texture = socket})
            end
        end
    end

    local name, link
    for i = 1, 4 do
        name, link = GetItemGem(ItemLink, i)
        if (link) then
            if (info[i]) then
                info[i].name = name
                info[i].link = link
            else
                table.insert(info, { name = name, link = link })
            end
        end
    end
    return total, info
end