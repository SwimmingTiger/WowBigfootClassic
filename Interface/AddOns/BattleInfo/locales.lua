local _, ADDONSELF = ...

local L = setmetatable({}, {
    __index = function(table, key)
        if key then
            table[key] = tostring(key)
        end
        return tostring(key)
    end,
})


ADDONSELF.L = L

local locale = GetLocale()

if locale == 'enUs' then
L["Auto focus on Quick Join Text box"] = true
L["Auto Leave battle ground when game ends in"] = true
L["Avg Rank"] = true
L["Battle Mini Map unit color"] = true
L["BattleInfo"] = true
L["BattleInfo Loaded"] = true
L["Button may not work properly during combat"] = true
L["Cannot find battleground %s"] = true
L["CTRL+Hide=Leave"] = true
L["Feedback"] = true
L["Flash Icon taskbar when battle ground is ready to join"] = true
L["Quick select"] = true
L["Replace Enter Battle Button with count down"] = true
L["Replace Hide Button with CTRL+Hide=Leave"] = true
L["Reset score bar position"] = true
L["Reset win rate statistics data"] = true
L["Show Alterac Valley score bar created by BattleInfo"] = true
L["Show Battleground time elapsed"] = true
L["Show Spirit heal AE Timer"] = true
L["Show statistics panel"] = true
L["Show team number next to faction crest"] = true
L["Spirit heal AE in: %s Secs"] = true
L["Spirit heal AE: not dead"] = true
L["Spirit healing ..."] = true
L["TITLE"] = "Battle Info"
L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"
L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = true
L["Win rate"] = true
L["World State Score panel class color"] = true

elseif locale == 'deDE' then
--[[Translation missing --]]
--[[ L["Auto focus on Quick Join Text box"] = "Auto focus on Quick Join Text box"--]] 
--[[Translation missing --]]
--[[ L["Auto Leave battle ground when game ends in"] = "Auto Leave battle ground when game ends in"--]] 
--[[Translation missing --]]
--[[ L["Avg Rank"] = "Avg Rank"--]] 
--[[Translation missing --]]
--[[ L["Battle Mini Map unit color"] = "Battle Mini Map unit color"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo"] = "BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo Loaded"] = "BattleInfo Loaded"--]] 
--[[Translation missing --]]
--[[ L["Button may not work properly during combat"] = "Button may not work properly during combat"--]] 
--[[Translation missing --]]
--[[ L["Cannot find battleground %s"] = "Cannot find battleground %s"--]] 
--[[Translation missing --]]
--[[ L["CTRL+Hide=Leave"] = "CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Flash Icon taskbar when battle ground is ready to join"] = "Flash Icon taskbar when battle ground is ready to join"--]] 
--[[Translation missing --]]
--[[ L["Quick select"] = "Quick select"--]] 
--[[Translation missing --]]
--[[ L["Replace Enter Battle Button with count down"] = "Replace Enter Battle Button with count down"--]] 
--[[Translation missing --]]
--[[ L["Replace Hide Button with CTRL+Hide=Leave"] = "Replace Hide Button with CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Reset score bar position"] = "Reset score bar position"--]] 
--[[Translation missing --]]
--[[ L["Reset win rate statistics data"] = "Reset win rate statistics data"--]] 
--[[Translation missing --]]
--[[ L["Show Alterac Valley score bar created by BattleInfo"] = "Show Alterac Valley score bar created by BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["Show Battleground time elapsed"] = "Show Battleground time elapsed"--]] 
--[[Translation missing --]]
--[[ L["Show Spirit heal AE Timer"] = "Show Spirit heal AE Timer"--]] 
--[[Translation missing --]]
--[[ L["Show statistics panel"] = "Show statistics panel"--]] 
--[[Translation missing --]]
--[[ L["Show team number next to faction crest"] = "Show team number next to faction crest"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE in: %s Secs"] = "Spirit heal AE in: %s Secs"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE: not dead"] = "Spirit heal AE: not dead"--]] 
--[[Translation missing --]]
--[[ L["Spirit healing ..."] = "Spirit healing ..."--]] 
--[[Translation missing --]]
--[[ L["TITLE"] = "Battle Info"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "Waiting for Bunker/Tower to be destroyed, stopping auto-leave"--]] 
--[[Translation missing --]]
--[[ L["Win rate"] = "Win rate"--]] 
--[[Translation missing --]]
--[[ L["World State Score panel class color"] = "World State Score panel class color"--]] 

elseif locale == 'esES' then
--[[Translation missing --]]
--[[ L["Auto focus on Quick Join Text box"] = "Auto focus on Quick Join Text box"--]] 
--[[Translation missing --]]
--[[ L["Auto Leave battle ground when game ends in"] = "Auto Leave battle ground when game ends in"--]] 
--[[Translation missing --]]
--[[ L["Avg Rank"] = "Avg Rank"--]] 
--[[Translation missing --]]
--[[ L["Battle Mini Map unit color"] = "Battle Mini Map unit color"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo"] = "BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo Loaded"] = "BattleInfo Loaded"--]] 
--[[Translation missing --]]
--[[ L["Button may not work properly during combat"] = "Button may not work properly during combat"--]] 
--[[Translation missing --]]
--[[ L["Cannot find battleground %s"] = "Cannot find battleground %s"--]] 
--[[Translation missing --]]
--[[ L["CTRL+Hide=Leave"] = "CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Flash Icon taskbar when battle ground is ready to join"] = "Flash Icon taskbar when battle ground is ready to join"--]] 
--[[Translation missing --]]
--[[ L["Quick select"] = "Quick select"--]] 
--[[Translation missing --]]
--[[ L["Replace Enter Battle Button with count down"] = "Replace Enter Battle Button with count down"--]] 
--[[Translation missing --]]
--[[ L["Replace Hide Button with CTRL+Hide=Leave"] = "Replace Hide Button with CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Reset score bar position"] = "Reset score bar position"--]] 
--[[Translation missing --]]
--[[ L["Reset win rate statistics data"] = "Reset win rate statistics data"--]] 
--[[Translation missing --]]
--[[ L["Show Alterac Valley score bar created by BattleInfo"] = "Show Alterac Valley score bar created by BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["Show Battleground time elapsed"] = "Show Battleground time elapsed"--]] 
--[[Translation missing --]]
--[[ L["Show Spirit heal AE Timer"] = "Show Spirit heal AE Timer"--]] 
--[[Translation missing --]]
--[[ L["Show statistics panel"] = "Show statistics panel"--]] 
--[[Translation missing --]]
--[[ L["Show team number next to faction crest"] = "Show team number next to faction crest"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE in: %s Secs"] = "Spirit heal AE in: %s Secs"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE: not dead"] = "Spirit heal AE: not dead"--]] 
--[[Translation missing --]]
--[[ L["Spirit healing ..."] = "Spirit healing ..."--]] 
--[[Translation missing --]]
--[[ L["TITLE"] = "Battle Info"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "Waiting for Bunker/Tower to be destroyed, stopping auto-leave"--]] 
--[[Translation missing --]]
--[[ L["Win rate"] = "Win rate"--]] 
--[[Translation missing --]]
--[[ L["World State Score panel class color"] = "World State Score panel class color"--]] 

elseif locale == 'esMX' then
--[[Translation missing --]]
--[[ L["Auto focus on Quick Join Text box"] = "Auto focus on Quick Join Text box"--]] 
--[[Translation missing --]]
--[[ L["Auto Leave battle ground when game ends in"] = "Auto Leave battle ground when game ends in"--]] 
--[[Translation missing --]]
--[[ L["Avg Rank"] = "Avg Rank"--]] 
--[[Translation missing --]]
--[[ L["Battle Mini Map unit color"] = "Battle Mini Map unit color"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo"] = "BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo Loaded"] = "BattleInfo Loaded"--]] 
--[[Translation missing --]]
--[[ L["Button may not work properly during combat"] = "Button may not work properly during combat"--]] 
--[[Translation missing --]]
--[[ L["Cannot find battleground %s"] = "Cannot find battleground %s"--]] 
--[[Translation missing --]]
--[[ L["CTRL+Hide=Leave"] = "CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Flash Icon taskbar when battle ground is ready to join"] = "Flash Icon taskbar when battle ground is ready to join"--]] 
--[[Translation missing --]]
--[[ L["Quick select"] = "Quick select"--]] 
--[[Translation missing --]]
--[[ L["Replace Enter Battle Button with count down"] = "Replace Enter Battle Button with count down"--]] 
--[[Translation missing --]]
--[[ L["Replace Hide Button with CTRL+Hide=Leave"] = "Replace Hide Button with CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Reset score bar position"] = "Reset score bar position"--]] 
--[[Translation missing --]]
--[[ L["Reset win rate statistics data"] = "Reset win rate statistics data"--]] 
--[[Translation missing --]]
--[[ L["Show Alterac Valley score bar created by BattleInfo"] = "Show Alterac Valley score bar created by BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["Show Battleground time elapsed"] = "Show Battleground time elapsed"--]] 
--[[Translation missing --]]
--[[ L["Show Spirit heal AE Timer"] = "Show Spirit heal AE Timer"--]] 
--[[Translation missing --]]
--[[ L["Show statistics panel"] = "Show statistics panel"--]] 
--[[Translation missing --]]
--[[ L["Show team number next to faction crest"] = "Show team number next to faction crest"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE in: %s Secs"] = "Spirit heal AE in: %s Secs"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE: not dead"] = "Spirit heal AE: not dead"--]] 
--[[Translation missing --]]
--[[ L["Spirit healing ..."] = "Spirit healing ..."--]] 
--[[Translation missing --]]
--[[ L["TITLE"] = "Battle Info"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "Waiting for Bunker/Tower to be destroyed, stopping auto-leave"--]] 
--[[Translation missing --]]
--[[ L["Win rate"] = "Win rate"--]] 
--[[Translation missing --]]
--[[ L["World State Score panel class color"] = "World State Score panel class color"--]] 

elseif locale == 'frFR' then
--[[Translation missing --]]
--[[ L["Auto focus on Quick Join Text box"] = "Auto focus on Quick Join Text box"--]] 
--[[Translation missing --]]
--[[ L["Auto Leave battle ground when game ends in"] = "Auto Leave battle ground when game ends in"--]] 
--[[Translation missing --]]
--[[ L["Avg Rank"] = "Avg Rank"--]] 
--[[Translation missing --]]
--[[ L["Battle Mini Map unit color"] = "Battle Mini Map unit color"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo"] = "BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo Loaded"] = "BattleInfo Loaded"--]] 
--[[Translation missing --]]
--[[ L["Button may not work properly during combat"] = "Button may not work properly during combat"--]] 
--[[Translation missing --]]
--[[ L["Cannot find battleground %s"] = "Cannot find battleground %s"--]] 
--[[Translation missing --]]
--[[ L["CTRL+Hide=Leave"] = "CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Flash Icon taskbar when battle ground is ready to join"] = "Flash Icon taskbar when battle ground is ready to join"--]] 
--[[Translation missing --]]
--[[ L["Quick select"] = "Quick select"--]] 
--[[Translation missing --]]
--[[ L["Replace Enter Battle Button with count down"] = "Replace Enter Battle Button with count down"--]] 
--[[Translation missing --]]
--[[ L["Replace Hide Button with CTRL+Hide=Leave"] = "Replace Hide Button with CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Reset score bar position"] = "Reset score bar position"--]] 
--[[Translation missing --]]
--[[ L["Reset win rate statistics data"] = "Reset win rate statistics data"--]] 
--[[Translation missing --]]
--[[ L["Show Alterac Valley score bar created by BattleInfo"] = "Show Alterac Valley score bar created by BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["Show Battleground time elapsed"] = "Show Battleground time elapsed"--]] 
--[[Translation missing --]]
--[[ L["Show Spirit heal AE Timer"] = "Show Spirit heal AE Timer"--]] 
--[[Translation missing --]]
--[[ L["Show statistics panel"] = "Show statistics panel"--]] 
--[[Translation missing --]]
--[[ L["Show team number next to faction crest"] = "Show team number next to faction crest"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE in: %s Secs"] = "Spirit heal AE in: %s Secs"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE: not dead"] = "Spirit heal AE: not dead"--]] 
--[[Translation missing --]]
--[[ L["Spirit healing ..."] = "Spirit healing ..."--]] 
--[[Translation missing --]]
--[[ L["TITLE"] = "Battle Info"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "Waiting for Bunker/Tower to be destroyed, stopping auto-leave"--]] 
--[[Translation missing --]]
--[[ L["Win rate"] = "Win rate"--]] 
--[[Translation missing --]]
--[[ L["World State Score panel class color"] = "World State Score panel class color"--]] 

elseif locale == 'itIT' then
--[[Translation missing --]]
--[[ L["Auto focus on Quick Join Text box"] = "Auto focus on Quick Join Text box"--]] 
--[[Translation missing --]]
--[[ L["Auto Leave battle ground when game ends in"] = "Auto Leave battle ground when game ends in"--]] 
--[[Translation missing --]]
--[[ L["Avg Rank"] = "Avg Rank"--]] 
--[[Translation missing --]]
--[[ L["Battle Mini Map unit color"] = "Battle Mini Map unit color"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo"] = "BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo Loaded"] = "BattleInfo Loaded"--]] 
--[[Translation missing --]]
--[[ L["Button may not work properly during combat"] = "Button may not work properly during combat"--]] 
--[[Translation missing --]]
--[[ L["Cannot find battleground %s"] = "Cannot find battleground %s"--]] 
--[[Translation missing --]]
--[[ L["CTRL+Hide=Leave"] = "CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Flash Icon taskbar when battle ground is ready to join"] = "Flash Icon taskbar when battle ground is ready to join"--]] 
--[[Translation missing --]]
--[[ L["Quick select"] = "Quick select"--]] 
--[[Translation missing --]]
--[[ L["Replace Enter Battle Button with count down"] = "Replace Enter Battle Button with count down"--]] 
--[[Translation missing --]]
--[[ L["Replace Hide Button with CTRL+Hide=Leave"] = "Replace Hide Button with CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Reset score bar position"] = "Reset score bar position"--]] 
--[[Translation missing --]]
--[[ L["Reset win rate statistics data"] = "Reset win rate statistics data"--]] 
--[[Translation missing --]]
--[[ L["Show Alterac Valley score bar created by BattleInfo"] = "Show Alterac Valley score bar created by BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["Show Battleground time elapsed"] = "Show Battleground time elapsed"--]] 
--[[Translation missing --]]
--[[ L["Show Spirit heal AE Timer"] = "Show Spirit heal AE Timer"--]] 
--[[Translation missing --]]
--[[ L["Show statistics panel"] = "Show statistics panel"--]] 
--[[Translation missing --]]
--[[ L["Show team number next to faction crest"] = "Show team number next to faction crest"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE in: %s Secs"] = "Spirit heal AE in: %s Secs"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE: not dead"] = "Spirit heal AE: not dead"--]] 
--[[Translation missing --]]
--[[ L["Spirit healing ..."] = "Spirit healing ..."--]] 
--[[Translation missing --]]
--[[ L["TITLE"] = "Battle Info"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "Waiting for Bunker/Tower to be destroyed, stopping auto-leave"--]] 
--[[Translation missing --]]
--[[ L["Win rate"] = "Win rate"--]] 
--[[Translation missing --]]
--[[ L["World State Score panel class color"] = "World State Score panel class color"--]] 

elseif locale == 'koKR' then
--[[Translation missing --]]
--[[ L["Auto focus on Quick Join Text box"] = "Auto focus on Quick Join Text box"--]] 
--[[Translation missing --]]
--[[ L["Auto Leave battle ground when game ends in"] = "Auto Leave battle ground when game ends in"--]] 
--[[Translation missing --]]
--[[ L["Avg Rank"] = "Avg Rank"--]] 
--[[Translation missing --]]
--[[ L["Battle Mini Map unit color"] = "Battle Mini Map unit color"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo"] = "BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo Loaded"] = "BattleInfo Loaded"--]] 
--[[Translation missing --]]
--[[ L["Button may not work properly during combat"] = "Button may not work properly during combat"--]] 
--[[Translation missing --]]
--[[ L["Cannot find battleground %s"] = "Cannot find battleground %s"--]] 
--[[Translation missing --]]
--[[ L["CTRL+Hide=Leave"] = "CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Flash Icon taskbar when battle ground is ready to join"] = "Flash Icon taskbar when battle ground is ready to join"--]] 
--[[Translation missing --]]
--[[ L["Quick select"] = "Quick select"--]] 
--[[Translation missing --]]
--[[ L["Replace Enter Battle Button with count down"] = "Replace Enter Battle Button with count down"--]] 
--[[Translation missing --]]
--[[ L["Replace Hide Button with CTRL+Hide=Leave"] = "Replace Hide Button with CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Reset score bar position"] = "Reset score bar position"--]] 
--[[Translation missing --]]
--[[ L["Reset win rate statistics data"] = "Reset win rate statistics data"--]] 
--[[Translation missing --]]
--[[ L["Show Alterac Valley score bar created by BattleInfo"] = "Show Alterac Valley score bar created by BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["Show Battleground time elapsed"] = "Show Battleground time elapsed"--]] 
--[[Translation missing --]]
--[[ L["Show Spirit heal AE Timer"] = "Show Spirit heal AE Timer"--]] 
--[[Translation missing --]]
--[[ L["Show statistics panel"] = "Show statistics panel"--]] 
--[[Translation missing --]]
--[[ L["Show team number next to faction crest"] = "Show team number next to faction crest"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE in: %s Secs"] = "Spirit heal AE in: %s Secs"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE: not dead"] = "Spirit heal AE: not dead"--]] 
--[[Translation missing --]]
--[[ L["Spirit healing ..."] = "Spirit healing ..."--]] 
--[[Translation missing --]]
--[[ L["TITLE"] = "Battle Info"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "Waiting for Bunker/Tower to be destroyed, stopping auto-leave"--]] 
--[[Translation missing --]]
--[[ L["Win rate"] = "Win rate"--]] 
--[[Translation missing --]]
--[[ L["World State Score panel class color"] = "World State Score panel class color"--]] 

elseif locale == 'ptBR' then
--[[Translation missing --]]
--[[ L["Auto focus on Quick Join Text box"] = "Auto focus on Quick Join Text box"--]] 
--[[Translation missing --]]
--[[ L["Auto Leave battle ground when game ends in"] = "Auto Leave battle ground when game ends in"--]] 
--[[Translation missing --]]
--[[ L["Avg Rank"] = "Avg Rank"--]] 
--[[Translation missing --]]
--[[ L["Battle Mini Map unit color"] = "Battle Mini Map unit color"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo"] = "BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo Loaded"] = "BattleInfo Loaded"--]] 
--[[Translation missing --]]
--[[ L["Button may not work properly during combat"] = "Button may not work properly during combat"--]] 
--[[Translation missing --]]
--[[ L["Cannot find battleground %s"] = "Cannot find battleground %s"--]] 
--[[Translation missing --]]
--[[ L["CTRL+Hide=Leave"] = "CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Flash Icon taskbar when battle ground is ready to join"] = "Flash Icon taskbar when battle ground is ready to join"--]] 
--[[Translation missing --]]
--[[ L["Quick select"] = "Quick select"--]] 
--[[Translation missing --]]
--[[ L["Replace Enter Battle Button with count down"] = "Replace Enter Battle Button with count down"--]] 
--[[Translation missing --]]
--[[ L["Replace Hide Button with CTRL+Hide=Leave"] = "Replace Hide Button with CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Reset score bar position"] = "Reset score bar position"--]] 
--[[Translation missing --]]
--[[ L["Reset win rate statistics data"] = "Reset win rate statistics data"--]] 
--[[Translation missing --]]
--[[ L["Show Alterac Valley score bar created by BattleInfo"] = "Show Alterac Valley score bar created by BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["Show Battleground time elapsed"] = "Show Battleground time elapsed"--]] 
--[[Translation missing --]]
--[[ L["Show Spirit heal AE Timer"] = "Show Spirit heal AE Timer"--]] 
--[[Translation missing --]]
--[[ L["Show statistics panel"] = "Show statistics panel"--]] 
--[[Translation missing --]]
--[[ L["Show team number next to faction crest"] = "Show team number next to faction crest"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE in: %s Secs"] = "Spirit heal AE in: %s Secs"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE: not dead"] = "Spirit heal AE: not dead"--]] 
--[[Translation missing --]]
--[[ L["Spirit healing ..."] = "Spirit healing ..."--]] 
--[[Translation missing --]]
--[[ L["TITLE"] = "Battle Info"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "Waiting for Bunker/Tower to be destroyed, stopping auto-leave"--]] 
--[[Translation missing --]]
--[[ L["Win rate"] = "Win rate"--]] 
--[[Translation missing --]]
--[[ L["World State Score panel class color"] = "World State Score panel class color"--]] 

elseif locale == 'ruRU' then
--[[Translation missing --]]
--[[ L["Auto focus on Quick Join Text box"] = "Auto focus on Quick Join Text box"--]] 
--[[Translation missing --]]
--[[ L["Auto Leave battle ground when game ends in"] = "Auto Leave battle ground when game ends in"--]] 
--[[Translation missing --]]
--[[ L["Avg Rank"] = "Avg Rank"--]] 
--[[Translation missing --]]
--[[ L["Battle Mini Map unit color"] = "Battle Mini Map unit color"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo"] = "BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["BattleInfo Loaded"] = "BattleInfo Loaded"--]] 
--[[Translation missing --]]
--[[ L["Button may not work properly during combat"] = "Button may not work properly during combat"--]] 
--[[Translation missing --]]
--[[ L["Cannot find battleground %s"] = "Cannot find battleground %s"--]] 
--[[Translation missing --]]
--[[ L["CTRL+Hide=Leave"] = "CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Feedback"] = "Feedback"--]] 
--[[Translation missing --]]
--[[ L["Flash Icon taskbar when battle ground is ready to join"] = "Flash Icon taskbar when battle ground is ready to join"--]] 
--[[Translation missing --]]
--[[ L["Quick select"] = "Quick select"--]] 
--[[Translation missing --]]
--[[ L["Replace Enter Battle Button with count down"] = "Replace Enter Battle Button with count down"--]] 
--[[Translation missing --]]
--[[ L["Replace Hide Button with CTRL+Hide=Leave"] = "Replace Hide Button with CTRL+Hide=Leave"--]] 
--[[Translation missing --]]
--[[ L["Reset score bar position"] = "Reset score bar position"--]] 
--[[Translation missing --]]
--[[ L["Reset win rate statistics data"] = "Reset win rate statistics data"--]] 
--[[Translation missing --]]
--[[ L["Show Alterac Valley score bar created by BattleInfo"] = "Show Alterac Valley score bar created by BattleInfo"--]] 
--[[Translation missing --]]
--[[ L["Show Battleground time elapsed"] = "Show Battleground time elapsed"--]] 
--[[Translation missing --]]
--[[ L["Show Spirit heal AE Timer"] = "Show Spirit heal AE Timer"--]] 
--[[Translation missing --]]
--[[ L["Show statistics panel"] = "Show statistics panel"--]] 
--[[Translation missing --]]
--[[ L["Show team number next to faction crest"] = "Show team number next to faction crest"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE in: %s Secs"] = "Spirit heal AE in: %s Secs"--]] 
--[[Translation missing --]]
--[[ L["Spirit heal AE: not dead"] = "Spirit heal AE: not dead"--]] 
--[[Translation missing --]]
--[[ L["Spirit healing ..."] = "Spirit healing ..."--]] 
--[[Translation missing --]]
--[[ L["TITLE"] = "Battle Info"--]] 
--[[Translation missing --]]
--[[ L["TOC_NOTES"] = "Enrich your battleground information. Feedback: farmer1992@gmail.com"--]] 
--[[Translation missing --]]
--[[ L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "Waiting for Bunker/Tower to be destroyed, stopping auto-leave"--]] 
--[[Translation missing --]]
--[[ L["Win rate"] = "Win rate"--]] 
--[[Translation missing --]]
--[[ L["World State Score panel class color"] = "World State Score panel class color"--]] 

elseif locale == 'zhCN' then
L["Auto focus on Quick Join Text box"] = "自动将键盘输入移动到快速加入文本框"
L["Auto Leave battle ground when game ends in"] = "战斗结束后自动退出战场时间："
L["Avg Rank"] = "平均军衔"
L["Battle Mini Map unit color"] = "战场小地图显示职业颜色"
L["BattleInfo"] = "BattleInfo"
L["BattleInfo Loaded"] = "BattleInfo 已经加载"
L["Button may not work properly during combat"] = "战斗中按钮可能无法正确工作"
L["Cannot find battleground %s"] = "找不到战场 %s"
L["CTRL+Hide=Leave"] = "CTRL+隐藏=离开"
L["Feedback"] = "反馈"
L["Flash Icon taskbar when battle ground is ready to join"] = "战场可以进入时候闪烁任务栏中的图标"
L["Quick select"] = "快速选择"
L["Replace Enter Battle Button with count down"] = "将进入战场替换为带有倒计时的按钮"
L["Replace Hide Button with CTRL+Hide=Leave"] = "将隐藏战场替换为CTRL+隐藏=退出"
L["Reset score bar position"] = "重置比分栏位置"
L["Reset win rate statistics data"] = "重置胜率统计"
L["Show Alterac Valley score bar created by BattleInfo"] = "显示BattleInfo创建的 奥特兰克山谷 比分栏"
L["Show Battleground time elapsed"] = "显示战场已用时间"
L["Show Spirit heal AE Timer"] = "显示灵魂医者倒计时"
L["Show statistics panel"] = "显示统计窗口"
L["Show team number next to faction crest"] = "显示阵营图标前的数字"
L["Spirit heal AE in: %s Secs"] = "灵魂医者 %s 秒后群体复活"
L["Spirit heal AE: not dead"] = "灵魂医者: 未阵亡"
L["Spirit healing ..."] = "灵魂医者群体复活中..."
L["TITLE"] = "BattleInfo 战场助手"
L["TOC_NOTES"] = "战场信息增强. 反馈: farmer1992@gmail.com"
L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "等待碉堡/哨塔被摧毁，停止自动离开"
L["Win rate"] = "胜率"
L["World State Score panel class color"] = "比分面板职业着色"

elseif locale == 'zhTW' then
L["Auto focus on Quick Join Text box"] = "自動將焦點放在快速加入文字方塊"
L["Auto Leave battle ground when game ends in"] = "結束時自動離開戰場"
L["Avg Rank"] = "平均級別"
L["Battle Mini Map unit color"] = "戰場小地圖單位顏色"
L["BattleInfo"] = "戰場資訊增強"
L["BattleInfo Loaded"] = "戰場資訊增強已載入"
L["Button may not work properly during combat"] = "按鈕在戰鬥中可能會無法正常運作"
L["Cannot find battleground %s"] = "無法找到戰場 %s"
L["CTRL+Hide=Leave"] = "CTRL+隱藏=離開"
L["Feedback"] = "問題與建議"
L["Flash Icon taskbar when battle ground is ready to join"] = "排進戰場時閃爍工作列的魔獸圖示"
L["Quick select"] = "快速選擇"
L["Replace Enter Battle Button with count down"] = "使用倒數時間來取代進入戰場按鈕"
L["Replace Hide Button with CTRL+Hide=Leave"] = "使用【CTRL+隱藏=離開】來取代隱藏按鈕"
L["Reset score bar position"] = "重置分數列的位置"
L["Reset win rate statistics data"] = "重置勝率統計資料"
L["Show Alterac Valley score bar created by BattleInfo"] = "顯示戰場資訊增強建立的奧山分數列"
L["Show Battleground time elapsed"] = "顯示戰場經過時間"
L["Show Spirit heal AE Timer"] = "顯示靈魂治療 AE 計時"
L["Show statistics panel"] = "顯示統計面板"
L["Show team number next to faction crest"] = "在陣營徽章旁顯示隊伍編號"
L["Spirit heal AE in: %s Secs"] = "靈魂治療 AE 還有: %s 秒"
L["Spirit heal AE: not dead"] = "靈魂治療 AE : 未死亡"
L["Spirit healing ..."] = "靈魂治療中..."
L["TITLE"] = "戰場資訊增強"
L["TOC_NOTES"] = "提供更多實用的戰場資訊。問題與建議: farmer1992@gmail.com"
L["Waiting for Bunker/Tower to be destroyed, stopping auto-leave"] = "等待堡壘/塔被摧毀，停止自動離開。"
L["Win rate"] = "勝率"
L["World State Score panel class color"] = "分數面板顯示職業顏色"

end
