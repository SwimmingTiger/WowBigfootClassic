local addonName, addon = ...
local module = addon:CreateModule("DR Tracker")

local DRList = LibStub("DRList-1.0")
local drTime = DRList:GetResetTime()

local severityColor = {
	[1] = { 0, 1, 0, 1},
	[2] = { 1, 1, 0, 1},
	[3] = { 1, 0, 0, 1},
}

local testCategories = {
	"incapacitate",
	"disorient",
	"stun",
	"root",
}

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local MAX_ARENA_ENEMIES = MAX_ARENA_ENEMIES
local GetTime = GetTime
local UnitAura = UnitAura

module.defaultSettings = {
	enable = true,
	x = -100,
	y = 18,
	size = 24,
	spacing = 2,
	fontSize = 12,
	growth = "LEFT",
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
	growth = {
		order = 3,
		type = "select",
		name = "Growth Direction",
		values = {
			["LEFT"] = "Left",
			["RIGHT"] = "Right",
			["UP"] = "Up",
			["DOWN"] = "Down",
		},
		set = module.UpdateSettings,
	},
	size = {
		order = 4,
		type = "range",
		name = "Size",
		min = 10,
		max = 128,
		step = 1,
		bigStep = 2,
		set = module.UpdateSettings,
	},
	spacing = {
		order = 5,
		type = "range",
		name = "Spacing",
		min = -10,
		max = 30,
		step = 1,
		set = module.UpdateSettings,
	},
	fontSize = {
		order = 6,
		type = "range",
		name = "Font Size",
		desc = "For Blizzard Cooldown Count",
		min = 4,
		max = 36,
		step = 1,
		set = module.UpdateSettings,
	},
	break2 = {
		order = 7,
		type = "header",
		name = "Categories",
	},
}

local eventHandler = CreateFrame("Frame")

for i = 1, MAX_ARENA_ENEMIES do
	module["arena"..i] = {}
end

local optionOrder = 8
for k, v in pairs(DRList.GetCategories()) do
	module.defaultSettings[k] = true
	module.optionsTable[k] = {
			order = optionOrder,
			type = "toggle",
			name = v,
			width = 0.8,
			set = module.UpdateSettings
	}

	optionOrder = optionOrder + 1

	for i = 1, MAX_ARENA_ENEMIES do
		local frame = CreateFrame("Frame", nil, _G["ArenaEnemyFrame"..i], "sArenaDRTemplate")

		frame.cooldown:SetScript("OnShow", function()
			module:ManageFramePositions("arena"..i)
		end)

		frame.cooldown:SetScript("OnHide", function()
			frame:Hide()
			frame.severity = 1
			module:ManageFramePositions("arena"..i)
		end)

		module["arena"..i][k] = frame
	end
end

for i = 1, MAX_ARENA_ENEMIES do
	module["arena"..i].incapacitate:SetMovable(true)
	addon:SetupDrag(module, true, module["arena"..i].incapacitate)
end

function module:OnEvent(event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		module:FindDR()
	elseif event == "PLAYER_ENTERING_WORLD" then
		local _, instanceType = IsInInstance()

		if instanceType == "arena" then
			eventHandler:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		else
			eventHandler:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	elseif event == "UPDATE_SETTINGS" then
		local size = self.db.size
		local fontSize = self.db.fontSize

		for i = 1, MAX_ARENA_ENEMIES do
			self:ManageFramePositions("arena"..i)

			for k in pairs(DRList.GetCategories()) do
				local frame = self["arena"..i][k]

				frame:SetSize(size, size)
				frame.cooldown.text:SetFont(frame.cooldown.text.fontFile, fontSize, "OUTLINE")
			end
		end

		if addon.testMode then
			self:OnEvent("TEST_MODE")
		end
	elseif event == "TEST_MODE" then
		for i = 1, MAX_ARENA_ENEMIES do
			for n = 1, #testCategories do
				local frame = self["arena"..i][testCategories[n]]

				if self.db.enable and addon.testMode then
					frame:Show()
					frame.icon:SetTexture(136071)
					frame.cooldown:SetCooldown(GetTime(), n == 1 and 60 or random(20, 50))

					if n == 1 then
						frame.border:SetVertexColor(1, 0, 0, 1)
						frame:EnableMouse(true)
					else
						frame.border:SetVertexColor(0, 1, 0, 1)
					end
				else
					frame:Hide()
					frame.cooldown:Clear()

					if n == 1 then
						frame:EnableMouse(false)
					end
				end
			end

			if self.db.enable and addon.testMode then
				self:ManageFramePositions("arena"..i)
			end
		end
	elseif event == "ADDON_LOADED" then
		self:OnEvent("UPDATE_SETTINGS")
	end
end

eventHandler:SetScript("OnEvent", module.OnEvent)

function module:FindDR()
	local _, combatEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, _, _, auraType = CombatLogGetCurrentEventInfo()

		if auraType ~= "DEBUFF" then return end

		local category = DRList:GetCategoryBySpellID(spellID)
		if not category then return end
		if not self.db[category] then return end

		for i = 1, MAX_ARENA_ENEMIES do
			if destGUID == UnitGUID("arena"..i) then
				local frame = self["arena"..i][category]
				local currTime = GetTime()

				if combatEvent == "SPELL_AURA_REMOVED" or combatEvent == "SPELL_AURA_BROKEN" then
					local startTime, startDuration = frame.cooldown:GetCooldownTimes()
					startTime, startDuration = startTime/1000, startDuration/1000

					local newDuration = drTime / (1 - ((currTime - startTime) / startDuration))
					local newStartTime = drTime + currTime - newDuration

					frame:Show()
					frame.cooldown:SetCooldown(newStartTime, newDuration)

					return
				elseif combatEvent == "SPELL_AURA_APPLIED" or combatEvent == "SPELL_AURA_REFRESH" then
					for n = 1, 30 do
						local _, _, _, _, duration, _, _, _, _, _spellID = UnitAura("arena"..i, n, "HARMFUL")
			
						if not _spellID then break end
			
						if duration and spellID == _spellID then
							frame:Show()
							frame.cooldown:SetCooldown(currTime, duration + drTime)
							break
						end
					end
				end

				frame.icon:SetTexture(GetSpellTexture(spellID))
				frame.border:SetVertexColor(unpack(severityColor[frame.severity]))

				frame.severity = frame.severity + 1

				if frame.severity > 3 then
					frame.severity = 3
				end

				break
			end
		end
end

function module:ManageFramePositions(unit)
	local numActive = 0
	local frame, prevFrame
	local spacing = self.db.spacing
	local growth = self.db.growth

	for k in pairs(DRList.GetCategories()) do
		frame = self[unit][k]

		if frame:IsShown() then
			frame:ClearAllPoints()

			if numActive == 0 then
				frame:SetPoint("CENTER", frame:GetParent(), "CENTER", self.db.x, self.db.y)
			else
				if growth == "LEFT" then frame:SetPoint("RIGHT", prevFrame, "LEFT", -spacing, 0)
				elseif growth == "RIGHT" then frame:SetPoint("LEFT", prevFrame, "RIGHT", spacing, 0)
				elseif growth == "UP" then frame:SetPoint("BOTTOM", prevFrame, "TOP", 0, spacing)
				elseif growth == "DOWN" then frame:SetPoint("TOP", prevFrame, "BOTTOM", 0, -spacing)
				end
			end

			numActive = numActive + 1
			prevFrame = frame
		end
	end
end