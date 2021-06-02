local addonName, addon = ...
local module = addon:CreateModule("Frame Styles")

module.defaultSettings = {
	frameStyle = "Blizz Arena",
	mirroredFrames = false,
	barTexture = "Interface\\TargetingFrame\\UI-StatusBar",
}

module.optionsTable = {
	frameStyle = {
		order = 1,
		type = "select",
		name = "Style",
		values = {
			["Blizz Arena"] = "|cff00b4ffBlizz|r Arena",
			["Blizz Tourney"] = "|cff00b4ffBlizz|r Tourney",
			["Xaryu"] = "Xaryu",
		},
		set = module.UpdateSettings,
	},
	barTexture = {
		order = 2,
		type = "select",
		name = "Bar Textures",
		values = {
			["Interface\\TargetingFrame\\UI-StatusBar"] = "Default",
			["Interface\\RaidFrame\\Raid-Bar-Hp-Fill"] = "Raid",
		},
		set = module.UpdateSettings,
	},
	mirroredFrames = {
		order = 5,
		type = "toggle",
		name = "Mirrored Frames",
		set = module.UpdateSettings,
	},
}

local UnitClass = UnitClass
local unpack = unpack
local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS

function module:OnEvent(event, ...)
	for i = 1, MAX_ARENA_ENEMIES do
		local arenaFrame = _G["ArenaEnemyFrame"..i]

		if event == "UPDATE_SETTINGS" then
			self:SetFrameStyle(arenaFrame, self.db.frameStyle, self.db.mirroredFrames)
			
			arenaFrame.healthbar:SetStatusBarTexture(self.db.barTexture)
			arenaFrame.manabar:SetStatusBarTexture(self.db.barTexture)
			arenaFrame.CastingBar:SetStatusBarTexture(self.db.barTexture)
		end
	end

	if event == "UPDATE_SETTINGS" then
		-- reshape class portrait during test mode
		if addon.testMode and addon.modules["Unit Frames"] then
			addon.modules["Unit Frames"]:OnEvent("TEST_MODE")
		end
	elseif event == "ADDON_LOADED" then
		self:OnEvent("UPDATE_SETTINGS")
	end
end

function module:SetFrameStyle(frame, frameStyle, mirroredFrames)
	-- don't move the parent frame, only the children. parent frame can be resized with SetSize()

	frame.name:ClearAllPoints()
	frame.classPortrait:ClearAllPoints()
	frame.healthbar:ClearAllPoints()
	frame.manabar:ClearAllPoints()
	frame.background:ClearAllPoints()
	frame.texture:ClearAllPoints()
	if frame.auraFrame then
		frame.auraFrame:ClearAllPoints()
	end
	addon.squareClassPortrait = nil

	if frameStyle == "Blizz Arena" then
		frame:SetSize(112, 32)
		frame.classPortrait:SetSize(26, 26)
		frame.healthbar:SetSize(70, 8)
		frame.manabar:SetSize(70, 8)
		frame.texture:SetTexture("Interface\\ArenaEnemyFrame\\UI-ArenaTargetingFrame")
		frame.texture:SetSize(102, 32)
		frame.texture:SetPoint("TOPLEFT", 0, -2)

		frame.background:SetPoint("TOPLEFT", frame.healthbar, "TOPLEFT")
		frame.background:SetPoint("BOTTOMRIGHT", frame.manabar, "BOTTOMRIGHT")
		frame.background:SetColorTexture(0, 0, 0, 0.5)

		if frame.auraFrame then
			local auraFrame = frame.auraFrame

			auraFrame:SetPoint("CENTER", frame.classPortrait)
			auraFrame:SetSize(23, 23)
			auraFrame.texture:AddMaskTexture(auraFrame.mask)
			auraFrame.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			auraFrame.cooldown:SetSwipeTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask")
			auraFrame.cooldown:SetUseCircularEdge(true)
			auraFrame.cooldown:SetSwipeColor(0, 0, 0, 0.6)
		end

		if mirroredFrames then
			frame.name:SetPoint("BOTTOMLEFT", 32, 24)
			frame.classPortrait:SetPoint("TOPLEFT", 2, -5)
			frame.texture:SetTexCoord(0.796, 0, 0, 0.5)
			frame.healthbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 29, -11)
			frame.manabar:SetPoint("TOPLEFT", frame, "TOPLEFT", 29, -20)
		else
			frame.name:SetPoint("BOTTOMLEFT", 3, 24)
			frame.classPortrait:SetPoint("TOPRIGHT", -13, -5)
			frame.texture:SetTexCoord(0, 0.796, 0, 0.5)
			frame.healthbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -11)
			frame.manabar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -20)
		end
	elseif frameStyle == "Blizz Tourney" then
		frame:SetSize(122,58)
		frame.classPortrait:SetSize(32, 32)
		frame.texture:SetAtlas("UnitFrame")
		frame.texture:SetSize(144, 72)

		frame.background:SetPoint("TOPLEFT", frame.healthbar, "TOPLEFT")
		frame.background:SetPoint("BOTTOMRIGHT", frame.manabar, "BOTTOMRIGHT")
		frame.background:SetColorTexture(0, 0, 0, 0.9)

		if frame.auraFrame then
			local auraFrame = frame.auraFrame

			auraFrame:SetPoint("CENTER", frame.classPortrait, 0, 0)
			auraFrame:SetSize(30, 30)
			auraFrame.texture:AddMaskTexture(auraFrame.mask)
			auraFrame.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			auraFrame.cooldown:SetSwipeTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask")
			auraFrame.cooldown:SetUseCircularEdge(true)
			auraFrame.cooldown:SetSwipeColor(0, 0, 0, 0.6)
		end

		if mirroredFrames then
			frame.texture:SetTexCoord(0, 1, 0, 1)
			frame.texture:SetPoint("TOPLEFT", frame, "TOPLEFT", -8, 6)
			frame.name:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 34, -22)
			frame.classPortrait:SetPoint("TOPLEFT", 0, -1)

			frame.healthbar:SetPoint("TOPLEFT", 32, -26)
			frame.healthbar:SetPoint("BOTTOMRIGHT", -13, 11)

			frame.manabar:SetPoint("TOPLEFT", frame.healthbar, "BOTTOMLEFT", 0, -1)
			frame.manabar:SetPoint("BOTTOMRIGHT", -13, 2)
		else
			frame.texture:SetTexCoord(1, 0, 0, 1)
			frame.texture:SetPoint("TOPLEFT", frame, "TOPLEFT", -24, 6)
			frame.name:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 6, -22)
			frame.classPortrait:SetPoint("TOPRIGHT", -10, -1)

			frame.healthbar:SetPoint("TOPLEFT", 3, -26)
			frame.healthbar:SetPoint("BOTTOMRIGHT", -42, 11)

			frame.manabar:SetPoint("TOPLEFT", frame.healthbar, "BOTTOMLEFT", 0, -1)
			frame.manabar:SetPoint("BOTTOMRIGHT", -42, 2)
		end
	elseif frameStyle == "Xaryu" then
		frame:SetSize(112, 32)
		frame.classPortrait:SetSize(30, 30)
		frame.manabar:SetHeight(7)
		frame.texture:SetTexture(nil)
		addon.squareClassPortrait = true

		frame.background:SetPoint("TOPLEFT", frame.healthbar, "TOPLEFT")
		frame.background:SetPoint("BOTTOMRIGHT", frame.manabar, "BOTTOMRIGHT")
		frame.background:SetColorTexture(0, 0, 0, 0.5)

		if frame.auraFrame then
			local auraFrame = frame.auraFrame

			auraFrame:SetAllPoints(frame.classPortrait)
			auraFrame.texture:RemoveMaskTexture(frame.auraFrame.mask)
			auraFrame.texture:SetTexCoord(0, 1, 0, 1)
			auraFrame.cooldown:SetSwipeTexture(1)
			auraFrame.cooldown:SetUseCircularEdge(false)
			auraFrame.cooldown:SetSwipeColor(0, 0, 0, 0.6)
		end

		if mirroredFrames then
			frame.name:SetPoint("BOTTOMLEFT", 32, 28)
			frame.classPortrait:SetPoint("BOTTOMLEFT")

			frame.manabar:SetPoint("BOTTOMLEFT", frame.classPortrait, "BOTTOMRIGHT", 2, 2)
			frame.manabar:SetPoint("RIGHT", -11, 0)

			frame.healthbar:SetPoint("TOPLEFT", frame.classPortrait, "TOPRIGHT", 2, -2)
			frame.healthbar:SetPoint("BOTTOMRIGHT", frame.manabar, "TOPRIGHT")
		else
			frame.name:SetPoint("BOTTOMLEFT", 0, 28)
			frame.classPortrait:SetPoint("BOTTOMRIGHT", -11, 0)

			frame.manabar:SetPoint("BOTTOMRIGHT", frame.classPortrait, "BOTTOMLEFT", -2, 2)
			frame.manabar:SetPoint("LEFT")

			frame.healthbar:SetPoint("TOPRIGHT", frame.classPortrait, "TOPLEFT", -2, -2)
			frame.healthbar:SetPoint("BOTTOMLEFT", frame.manabar, "TOPLEFT")
		end
	end
end

for i = 1, MAX_ARENA_ENEMIES do
	local arenaFrame = _G["ArenaEnemyFrame"..i]

	arenaFrame.healthbar.TextString:ClearAllPoints()
	arenaFrame.healthbar.TextString:SetPoint("CENTER", arenaFrame.healthbar)
	arenaFrame.healthbar.LeftText:ClearAllPoints()
	arenaFrame.healthbar.LeftText:SetPoint("LEFT", arenaFrame.healthbar)
	arenaFrame.healthbar.RightText:ClearAllPoints()
	arenaFrame.healthbar.RightText:SetPoint("RIGHT", arenaFrame.healthbar)
	arenaFrame.manabar.TextString:ClearAllPoints()
	arenaFrame.manabar.TextString:SetPoint("CENTER", arenaFrame.manabar)
	arenaFrame.manabar.LeftText:ClearAllPoints()
	arenaFrame.manabar.LeftText:SetPoint("LEFT", arenaFrame.manabar)
	arenaFrame.manabar.RightText:ClearAllPoints()
	arenaFrame.manabar.RightText:SetPoint("RIGHT", arenaFrame.manabar)
end

local classIcons = {
	["DRUID"] = 625999,
	["HUNTER"] = 626000,
	["MAGE"] = 626001,
	["PALADIN"] = 626003,
	["PRIEST"] = 626004,
	["ROGUE"] = 626005,
	["SHAMAN"] = 626006,
	["WARLOCK"] = 626007,
	["WARRIOR"] = 626008,
}

hooksecurefunc("ArenaEnemyFrame_UpdatePlayer", function(self)
	local _, class = UnitClass(self.unit)

	if class then
		if addon.squareClassPortrait then
			self.classPortrait:SetTexture(classIcons[class])
			self.classPortrait:SetTexCoord(0, 1, 0, 1)
		else
			self.classPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
			self.classPortrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]))
		end
	end
end)

hooksecurefunc("ArenaEnemyFrame_SetMysteryPlayer", function(self)
	if addon.squareClassPortrait then
		self.classPortrait:SetTexture(134400)
	else
		self.classPortrait:SetTexture("Interface\\CharacterFrame\\TempPortrait")
	end
end)