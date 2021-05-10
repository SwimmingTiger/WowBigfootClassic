-- Button.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 7:35:50 PM

local ipairs, format = ipairs, string.format

local IsControlKeyDown = IsControlKeyDown
local IsShiftKeyDown = IsShiftKeyDown
local IsAltKeyDown = IsAltKeyDown
local PlaySound = PlaySound

local GameTooltip = GameTooltip
local SOUNDKIT = SOUNDKIT

---@type ns
local ns = select(2, ...)
local L = ns.L
local Addon = ns.Addon
local BAG_TYPE = ns.BAG_TYPE
local CLICK_LIST = ns.CLICK_LIST

local function OnClick(self, click)
    PlaySound(SOUNDKIT.UI_BAG_SORTING_01)
    Addon:RunCommand(self._tdpack2BagType, ns.GetClickToken(click, IsControlKeyDown(), IsShiftKeyDown(), IsAltKeyDown()))
end

local function OnEnter(self)
    GameTooltip:SetOwner(self, 'BOTTOM_RIGHT')
    GameTooltip:AddLine('tdPack2')

    for _, v in ipairs(CLICK_LIST) do
        local action = Addon:GetBagClickOption(self._tdpack2BagType, v.token)
        if action then
            GameTooltip:AddLine(format('<%s> %s', v.name, L[action]), 1, 1, 1)
        end
    end

    GameTooltip:Show()
end

function ns.SetupButton(button, isBank)
    button:RegisterForClicks('LeftButtonUp', 'RightButtonUp')

    button:SetScript('OnClick', OnClick)
    button:SetScript('OnEnter', OnEnter)
    button:SetScript('OnLeave', GameTooltip_Hide)
    button._tdpack2BagType = isBank and BAG_TYPE.BANK or BAG_TYPE.BAG
end

function Addon:SetupButton(button, bagType)
    ns.SetupButton(button, bagType)
end
