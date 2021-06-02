local addonName, addon = ...
local module = addon:CreateModule("Trinkets")

module.defaultSettings = {
	x = -74,
	y = -3,
	size = 18,
	fontSize = 12,
	hideCountdownNumbers = false,
}

module.optionsTable = {
	size = {
		order = 1,
		type = "range",
		name = "Size",
		min = 10,
		max = 128,
		step = 1,
		bigStep = 2,
		set = module.UpdateSettings,
	},
	fontSize = {
		order = 2,
		type = "range",
		name = "Font Size",
		desc = "For Blizzard Cooldown Count",
		min = 4,
		max = 36,
		step = 1,
		set = module.UpdateSettings,
	},
}

function module:OnEvent(event, ...)
	for i = 1, MAX_ARENA_ENEMIES do
		local CC = _G["ArenaEnemyFrame"..i].CC

		if event == "ADDON_LOADED" then
			CC:SetMovable(true)
			addon:SetupDrag(self, true, CC)

			CC:SetFrameLevel(4)

			CC.Cooldown:ClearAllPoints()
			CC.Cooldown:SetPoint("TOPLEFT", 1, -1)
			CC.Cooldown:SetPoint("BOTTOMRIGHT", -1, 1)

			for _, region in next, { CC.Cooldown:GetRegions() } do
				if region:GetObjectType() == "FontString" then
					CC.Cooldown.text = region
					CC.Cooldown.text.fontFile = region:GetFont()
				end
			end
		elseif event == "TEST_MODE" then
			if addon.testMode then
				CC:EnableMouse(true)
				CC.Icon:SetTexture(133453)
				CC.Cooldown:SetCooldown(GetTime(), random(45,120))
			else
				CC:EnableMouse(false)
				CC.Icon:SetTexture(nil)
				CC.Cooldown:Clear()
			end
		elseif event == "UPDATE_SETTINGS" then
			CC:ClearAllPoints()
			CC:SetPoint("CENTER", self.db.x, self.db.y)
			CC:SetSize(self.db.size, self.db.size)
			CC.Cooldown.text:SetFont(CC.Cooldown.text.fontFile, self.db.fontSize, "OUTLINE")
			CC.Cooldown:SetHideCountdownNumbers(self.db.hideCountdownNumbers)
		end
	end

	if event == "ADDON_LOADED" then
		self:OnEvent("UPDATE_SETTINGS")
	end
end