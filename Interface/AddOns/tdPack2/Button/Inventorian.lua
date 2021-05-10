-- Inventorian.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/3/2019, 7:29:08 PM

local Inventorian = LibStub('AceAddon-3.0'):GetAddon('Inventorian', true)
if not Inventorian then
    return
end

local ns = select(2, ...)

local orig_FrameCreate = Inventorian.Frame.Create

function Inventorian.Frame:Create(...)
    local f = orig_FrameCreate(self, ...)

    local button = CreateFrame('Button', nil, f)
    button:SetPoint('TOPRIGHT', -40, -27)
    button:SetSize(32, 32)
    button:SetHighlightTexture([[Interface\Minimap\UI-Minimap-ZoomButton-Highlight]])

    ns.SetupButton(button, f:IsBank())

    button.Icon = button:CreateTexture(nil, 'BACKGROUND')
    button.Icon:SetTexture(ns.ICON)
    button.Icon:SetSize(20, 20)
    button.Icon:SetPoint('TOPLEFT', 7, -6)

    button.Border = button:CreateTexture(nil, 'OVERLAY')
    button.Border:SetSize(54, 54)
    button.Border:SetPoint('TOPLEFT')
    button.Border:SetTexture([[Interface\Minimap\MiniMap-TrackingBorder]])
    button.Border:SetDesaturated(true)
    button.Border:SetAlpha(0.6)

    button:SetScript('OnMouseDown', function(self)
        self.Icon:SetTexCoord(0,1,0,1)
    end)

    button:SetScript('OnMouseUp', function(self)
        self.Icon:SetTexCoord(0.075,0.925,0.075,0.925)
    end)

    return f
end
