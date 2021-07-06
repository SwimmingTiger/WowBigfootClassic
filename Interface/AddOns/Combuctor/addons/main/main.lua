--[[
	main.lua
		Constant specifics for the addon
--]]

local ADDON, Addon = ...
Addon.ItemSlot = Addon.Item -- deprecated behavior
Addon.FrameTemplate = true
Addon.canSearch = true
Addon.FrameScale = 1.0
Addon.ItemScale = 1.0
Addon.Slash = 'cbt'

-- 老虎会游泳：解决战斗中无法点[X]关闭背包的问题
hooksecurefunc("HideUIPanel", function(ui)
    if InCombatLockdown() and type(ui) == 'table' and ui.bagToggle then
        ui:Hide()
    end
end)
