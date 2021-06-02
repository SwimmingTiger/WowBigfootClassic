local addonName, addon = ...
local module = addon:CreateModule("Unit Frames")

module.defaultSettings = {
	x = 350,
	y = 100,
	scale = 1,
	frameSpacing = 20,
	statusTextScale = 1,
	classColors = true,
	hideNames = false,
}

module.optionsTable = {
	scale = {
		order = 1,
		type = "range",
		name = "Scale",
		min = 0.1,
		max = 5.0,
		step = 0.1,
		set = module.UpdateSettings,
	},
	frameSpacing = {
		order = 2,
		type = "range",
		name = "Spacing",
		min = -100,
		max = 100,
		softMin = -20,
		softMax = 40,
		step = 1,
		set = module.UpdateSettings,
	},
	statusTextScale = {
		order = 3,
		type = "range",
		name = "Status Text Scale",
		desc = "Esc > Interface > Display > Status Text",
		min = 0.1,
		max = 2.0,
		step = 0.1,
		set = module.UpdateSettings,
	},
	hideNames = {
		order = 5,
		type = "toggle",
		name = "Hide names",
		set = module.UpdateSettings,
	},
	classColors = {
		order = 6,
		type = "toggle",
		name = "Class-colored health bars",
		width = "full",
	},
}

-- Blizzard's ArenaEnemyFrames frame gets moved around a lot, so we'll create our own
local sArenaEnemyFrames = CreateFrame("Frame", nil, UIParent)
sArenaEnemyFrames:SetSize(1,1)
sArenaEnemyFrames:SetMovable(true)
module.sArenaEnemyFrames = sArenaEnemyFrames

local hiddenFrame = CreateFrame("Frame", nil, UIParent)
hiddenFrame:Hide()

-- attach unit frames to our own sArenaEnemyFrames
for i = 1, MAX_ARENA_ENEMIES do
	local arenaFrame = _G["ArenaEnemyFrame"..i]

	if i == 1 then
		arenaFrame:SetPoint("TOP", sArenaEnemyFrames)
	end

	arenaFrame:SetParent(sArenaEnemyFrames)
	arenaFrame:SetPoint("RIGHT", sArenaEnemyFrames, "RIGHT", -2, 0)

	addon:SetupDrag(module, false, arenaFrame, sArenaEnemyFrames)
	addon:SetupDrag(module, false, arenaFrame.healthbar, sArenaEnemyFrames)
	addon:SetupDrag(module, false, arenaFrame.manabar, sArenaEnemyFrames)

	arenaFrame.texture = _G["ArenaEnemyFrame"..i.."Texture"]
	arenaFrame.background = _G["ArenaEnemyFrame"..i.."Background"]
end

ArenaEnemyBackground:SetParent(hiddenFrame)

function module:OnEvent(event, ...)
	if event == "ADDON_LOADED" then
		self:OnEvent("UPDATE_SETTINGS")
	elseif event == "TEST_MODE" then
		for i = 1, MAX_ARENA_ENEMIES do
			local arenaFrame = _G["ArenaEnemyFrame"..i]

			if addon.testMode then
				arenaFrame.healthbar:SetMinMaxValues(0,100)
				arenaFrame.healthbar:SetValue(100)
				arenaFrame.healthbar.forceHideText = false
				arenaFrame.manabar:SetMinMaxValues(0,100)
				arenaFrame.manabar:SetValue(100)
				arenaFrame.manabar:SetStatusBarColor(0, 0, 1)
				arenaFrame.manabar.forceHideText = false
				arenaFrame.classPortrait:SetTexCoord(0, 1, 0, 1)

				if addon.squareClassPortrait then
					arenaFrame.classPortrait:SetTexture(134400)
				else
					arenaFrame.classPortrait:SetTexture("Interface\\CharacterFrame\\TempPortrait")
					-- if i == 1 then
					-- 	arenaFrame.classPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
					-- 	arenaFrame.classPortrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[strupper("PRIEST")]))
					-- end
				end

				arenaFrame.name:SetText("arena"..i)
				arenaFrame:Show()

				-- local pvpIcon = _G["ArenaEnemyFrame"..i.."PVPIcon"]
				-- pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-Horde")
				-- pvpIcon:Show()
			else
				arenaFrame:Hide()
			end
		end
	elseif event == "UPDATE_SETTINGS" then
		sArenaEnemyFrames:ClearAllPoints()
		sArenaEnemyFrames:SetPoint("CENTER", self.db.x, self.db.y)
		sArenaEnemyFrames:SetScale(self.db.scale)

		for i = 1, MAX_ARENA_ENEMIES do
			local arenaFrame = _G["ArenaEnemyFrame"..i]
			arenaFrame.name:SetShown(not self.db.hideNames)

			local statusTextScale = self.db.statusTextScale
			arenaFrame.healthbar.TextString:SetScale(statusTextScale)
			arenaFrame.healthbar.LeftText:SetScale(statusTextScale)
			arenaFrame.healthbar.RightText:SetScale(statusTextScale)
			arenaFrame.manabar.TextString:SetScale(statusTextScale)
			arenaFrame.manabar.LeftText:SetScale(statusTextScale)
			arenaFrame.manabar.RightText:SetScale(statusTextScale)

			if i > 1 then
				arenaFrame:SetPoint("TOP", _G["ArenaEnemyFrame"..i-1], "BOTTOM", 0, self.db.frameSpacing * -1)
			end
		end
	end
end

-- Class colored health bars
local healthBars = {
	ArenaEnemyFrame1HealthBar = 1,
	ArenaEnemyFrame2HealthBar = 1,
	ArenaEnemyFrame3HealthBar = 1,
	ArenaEnemyFrame4HealthBar = 1,
	ArenaEnemyFrame5HealthBar = 1
}

local UnitClass = UnitClass
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

local function colorStatusBar(statusbar)
	if module.db.classColors and healthBars[statusbar:GetName()] then
		local _, class = UnitClass(statusbar.unit)
		if class then
			local c = RAID_CLASS_COLORS[class]
			if not statusbar.lockColor then statusbar:SetStatusBarColor(c.r, c.g, c.b) end
		end
	end
end

hooksecurefunc("UnitFrameHealthBar_Update", colorStatusBar)
hooksecurefunc("HealthBar_OnValueChanged", colorStatusBar)