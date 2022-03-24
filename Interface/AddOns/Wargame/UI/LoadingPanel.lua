---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class NeteaseWargameUILoadingPanel
local LoadingPanel = ns.Addon:NewClass('UI.LoadingPanel', 'Frame')

function LoadingPanel:Constructor()
    self.Text:SetText(L['服务器连接中...'])
end

function LoadingPanel:SetText(text, showSpinner)
    self.Text:SetText(text)
    if showSpinner then
        self.Spinner:Show()
        self.Text:SetPoint('CENTER', self, 0, -30)
    else
        self.Spinner:Hide()
        self.Text:SetPoint('CENTER', self, 0, 0)
    end
end
