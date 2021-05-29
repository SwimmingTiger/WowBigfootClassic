-- LibJunk-1.0.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/26/2019, 8:35:03 PM

local MAJOR, MINOR = 'LibJunk-1.0', 1
local Lib = LibStub:NewLibrary(MAJOR, MINOR)
if not Lib then
    return
end

function Lib:IsJunk(itemId)
    if Scrap then
        local ok, isJunk = pcall(Scrap.IsJunk, Scrap, itemId)
        if ok then
            return isJunk
        end
    end
    local _, _, quality, _, _, _, _, _, _, _, price = GetItemInfo(itemId)
    return quality == LE_ITEM_QUALITY_POOR and price and price > 0
end
