local addonName, addon = ...
local module = addon:CreateModule("Cast Bars")

module.defaultSettings = {
	enable = true,
	x = -128,
	y = -3,
	scale = 1,
	width = 80,
}

module.optionsTable = {
	enable = {
		order = 1,
		type = "toggle",
		name = "Enable",
		set = module.UpdateSettings,
	},
	break1 = {
		order = 2,
		type = "header",
		name = "",
	},
	scale = {
		order = 3,
		type = "range",
		name = "Scale",
		min = 0.1,
		max = 5.0,
		step = 0.01,
		bigStep = 0.1,
		set = module.UpdateSettings,
	},
	width = {
		order = 4,
		type = "range",
		name = "Width",
		min = 10,
		max = 400,
		step = 1,
		bigStep = 5,
		set = module.UpdateSettings,
	},
}

function module:OnEvent(event, ...)
	for i = 1, MAX_ARENA_ENEMIES do
		local castBar = _G["ArenaEnemyFrame"..i.."CastingBar"]

		if event == "ADDON_LOADED" then
			castBar:SetMovable(true)
			addon:SetupDrag(self, true, castBar)
			
			castBar:SetFrameLevel(4)
		elseif event == "TEST_MODE" then
			if addon.testMode and self.db.enable then
				castBar:EnableMouse(true)
				castBar.fadeOut = nil
				castBar.flash = nil
				CastingBarFrame_ApplyAlpha(castBar, 1)
				castBar.Icon:SetTexture(136071)
				castBar.Text:SetText(GetSpellInfo(118))
				castBar.Spark:SetPoint("CENTER", castBar, "LEFT", castBar:GetWidth() * 0.5, castBar.Spark.offsetY or 2)
				castBar:SetMinMaxValues(0, 100)
				castBar:SetValue(50)
				castBar:Show()
				castBar.BorderShield:Show()
				castBar.Spark:Show()
			else
				castBar:EnableMouse(false)
				CastingBarFrame_FinishSpell(castBar)
			end
		elseif event == "UPDATE_SETTINGS" then
			castBar.showCastbar = self.db.enable
			CastingBarFrame_UpdateIsShown(castBar)

			castBar:ClearAllPoints()
			castBar:SetPoint("CENTER", self.db.x, self.db.y)
			castBar:SetScale(self.db.scale)
			castBar:SetWidth(self.db.width)
		end
	end

	if event == "ADDON_LOADED" then
		self:OnEvent("UPDATE_SETTINGS")
	elseif event == "UPDATE_SETTINGS" then
		if addon.testMode then
			self:OnEvent("TEST_MODE")
		end
	end
end