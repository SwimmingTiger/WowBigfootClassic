local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent


SlashCmdList["BATTLEINFO"] = function(msg, editbox)
    -- local cmd, what = msg:match("^(%S*)%s*(%S*)%s*$")

    -- if cmd == "" then
        InterfaceOptionsFrame_OpenToCategory(L["BattleInfo"])
        InterfaceOptionsFrame_OpenToCategory(L["BattleInfo"])
    -- elseif cmd == "reset" then
    -- end

end
SLASH_BATTLEINFO1 = "/BI"
SLASH_BATTLEINFO2 = "/BATTLEINFO"
