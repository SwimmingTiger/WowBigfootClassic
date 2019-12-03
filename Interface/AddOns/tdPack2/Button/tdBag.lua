-- tdBag.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 7:26:53 PM

if not tdBag then
    return
end

local ns = select(2, ...)

tdBag:RegisterPluginButton('tdPack2', ns.ICON, function(button, frame)
    ns.SetupButton(button, frame:GetFrameID() == 'bank')
end)

