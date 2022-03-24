local addonName, addon = ...
local module = addon:CreateModule("Pet Frames")

module.defaultSettings = {
	x = -6,
	y = -24,
	scale = 1,
}

module.optionsTable = {
	enable = {
		order = 1,
		type = "toggle",
		name = addon.exclamation.."Enable",
		desc = "|cffff5555NOTICE:|r Changing this setting will cause a UI reload.",
		get = function() return GetCVar("showArenaEnemyPets") == "1" and true or false end,
		set = function(info, val)
			SHOW_ARENA_ENEMY_PETS = val and 1 or 0
			SetCVar("showArenaEnemyPets", val and 1 or 0)
			ReloadUI()
		end,
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
		step = 0.1,
		set = module.UpdateSettings,
	},
}

for i = 1, MAX_ARENA_ENEMIES do
	local arenaFrame = _G["ArenaEnemyFrame"..i]
	local petFrame = arenaFrame.petFrame

	petFrame:SetParent(arenaFrame)
	petFrame:SetMovable(true)
	-- potentially taints petFrame
	-- petFrame:SetToplevel(false)
	-- petFrame:SetFrameLevel(4)

	addon:SetupDrag(module, true, petFrame)
	addon:SetupDrag(module, true, petFrame.healthbar, petFrame)
	addon:SetupDrag(module, true, petFrame.manabar, petFrame)
end

function module:OnEvent(event, ...)
	for i = 1, MAX_ARENA_ENEMIES do
		local arenaFrame = _G["ArenaEnemyFrame"..i]
		local petFrame = arenaFrame.petFrame

		if event == "TEST_MODE" then
			if addon.testMode and GetCVar("showArenaEnemyPets") == "1" then
				petFrame:Show()
			else
				petFrame:Hide()
			end
		elseif event == "UPDATE_SETTINGS" then
			petFrame:ClearAllPoints()
			petFrame:SetPoint("CENTER", self.db.x, self.db.y)
			petFrame:SetScale(self.db.scale)
		end
	end

	if event == "ADDON_LOADED" then
		self:OnEvent("UPDATE_SETTINGS")
	end
end