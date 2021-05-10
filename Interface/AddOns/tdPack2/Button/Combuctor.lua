-- Combuctor.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 8:43:02 PM

if not Combuctor then
    return
end

local ns = select(2, ...)
local orig_FrameNew = Combuctor.Frame.New

function Combuctor.Frame:New(...)
    local f = orig_FrameNew(self, ...)

    local button = CreateFrame('Button', nil, f, 'CombuctorBagToggleTemplate')
    ns.SetupButton(button, ... == 'bank')

    if f.sortButton then
        f.sortButton:Hide()
    end

    button.Icon:SetTexture(ns.ICON)
    button:SetPoint('RIGHT', f.bagToggle, 'LEFT', 0, 0)
    f.searchBox:SetPoint('TOPRIGHT', -77, -32)

    return f
end
