-- Blizzard.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 9:12:59 PM

local ns = select(2, ...)

local bagButton
local function CreateBagButton()
    local button = CreateFrame('Button')
    button:SetSize(40, 40)
    button:SetHighlightAtlas('bags-roundhighlight')
    button:SetScript('OnHide', button.Hide)

    local ht = button:GetHighlightTexture()
    ht:ClearAllPoints()
    ht:SetPoint('CENTER', -3, 3)
    ht:SetSize(36, 36)

    ns.SetupButton(button, false)
    bagButton = button
    return button
end

local function CreateBankButton()
    local button = CreateFrame('Button', nil, BankFrame)
    button:SetSize(28, 26)
    button:SetPoint('TOPRIGHT', -50, -42)
    button:SetNormalAtlas('bags-button-autosort-up')
    button:SetPushedAtlas('bags-button-autosort-down')
    button:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])

    local ht = button:GetHighlightTexture()
    ht:ClearAllPoints()
    ht:SetSize(24, 23)
    ht:SetPoint('CENTER')

    ns.SetupButton(button, true)
    return button
end

hooksecurefunc('ContainerFrame_OnShow', function(self)
    if self:GetID() ~= 0 then
        return
    end

    local parent = _G[self:GetName() .. 'PortraitButton']
    local button = bagButton or CreateBagButton()

    button:ClearAllPoints()
    button:SetParent(parent)
    button:SetAllPoints(true)
    button:Show()
end)

CreateBankButton()
