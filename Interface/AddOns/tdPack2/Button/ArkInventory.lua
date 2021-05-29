-- ArkInventory.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/30/2019, 5:45:38 PM

if not ArkInventory then
    return
end

---@type ns
local ns = select(2, ...)

local function CreateButton(frame, isBank)
    local button = CreateFrame('Button', nil, _G[frame:GetName() .. 'Title'], 'ARKINV_TemplateButtonAction')
    button:SetPoint('RIGHT', _G[frame:GetName() .. 'TitleActionButton9'], 'LEFT', -3, 0)
    ns.SetupButton(button, isBank)

    local tex = button:GetNormalTexture()
    ArkInventory.SetTexture(tex, ns.ICON)
    tex:SetTexCoord(0.075, 0.925, 0.075, 0.925)

    tex = button:GetPushedTexture()
    ArkInventory.SetTexture(tex, ns.ICON)
    tex:SetTexCoord(0.075, 0.925, 0.075, 0.925)

    tex = button:GetHighlightTexture()
    ArkInventory.SetTexture(tex, ns.ICON)
    tex:SetTexCoord(0.075, 0.925, 0.075, 0.925)
end

CreateButton(ARKINV_Frame1)
CreateButton(ARKINV_Frame3, true)
