local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local SetConfig = ADDONSELF.SetConfig


SlashCmdList["BATTLEINFO"] = function(msg, editbox)
    local cmd, what = msg:match("^(%S*)%s*(%S*)%s*$")

    if cmd == "" then
        InterfaceOptionsFrame_OpenToCategory(L["BattleInfo"])
        InterfaceOptionsFrame_OpenToCategory(L["BattleInfo"])
    elseif cmd == "fontsize" then
        local size = tonumber(what) or 0
        if size then
            SetConfig("label_size", size)

            if size == 0 then
                C_UI.Reload()
            end
        end
    end

end
SLASH_BATTLEINFO1 = "/BI"
SLASH_BATTLEINFO2 = "/BATTLEINFO"
