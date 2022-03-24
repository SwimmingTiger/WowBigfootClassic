local L = LibStub("AceLocale-3.0"):GetLocale("Bartender4")
local Bar = Bartender4.Bar.prototype

--todo: 增加unitframe的配置面板

local UnitFrames = Bartender4:GetModule("UnitFrames")

function UnitFrames:SetupOptions()
--[[	if not self.options then
		self.optionobject = Bar:GetOptionObject()
		local enabled = {
			type = "toggle",
			order = 1,
			name = L["Enabled"],
			desc = L["Enable the Unit Frame"],
			get = function() return self.db.profile.enabled end,
			set = "ToggleModule",
			handler = self,
		}
		self.optionobject:AddElement("general", "enabled", enabled)

		self.disabledoptions = {
			general = {
				type = "group",
				name = L["General Settings"],
				cmdInline = true,
				order = 1,
				args = {
					enabled = enabled,
				}
			}
		}
		self.options = {
			order = 100,
			type = "group",
			name = L["Unit Frame"],
			desc = L["Configure the Unit Frame"],
			childGroups = "tab",
		}
		Bartender4:RegisterBarOptions("UnitFrame", self.options)
	end
	self.options.args = self:IsEnabled() and self.optionobject.table or self.disabledoptions]]
end

