local Gladius = _G.Gladius
if not Gladius then
	DEFAULT_CHAT_FRAME:AddMessage(format("Module %s requires Gladius", "Racial"))
end
local L = Gladius.L
local LSM

-- Global functions
local _G = _G

local format = format
local pairs = pairs
local select = select
local strfind = strfind
local string = string

local CreateFrame = CreateFrame
local GetSpellInfo = GetSpellInfo
local GetSpellTexture = GetSpellTexture
local GetTime = GetTime
local IsInInstance = IsInInstance
local UnitClass = UnitClass
local UnitDebuff = UnitDebuff
local UnitLevel = UnitLevel
local UnitName = UnitName
local UnitRace = UnitRace

local GetUnitDebuff = function(uId, spellName)
	for i = 1, 40 do
		local bfaspellName = UnitDebuff(uId, i)
		if not bfaspellName then return end
		if spellName == bfaspellName then
			return UnitDebuff(uId, i)
		end
	end
end

local unitRaceCDs = {
	["HUMAN"] = { cooldown = 180, spellID = 59752, sharesCD = true },
	["DWARF"] = { cooldown = 120, spellID = 265221, sharesCD = true },
	["NIGHTELF"] = { cooldown = 120, spellID = 58984, sharesCD = false },
	["GNOME"] = { cooldown = 60, spellID = 20589, sharesCD = false },
	["DRAENEI"] = { cooldown = 180, spellID = 59542, sharesCD = false },
	["WORGEN"] = { cooldown = 120, spellID = 68992, sharesCD = false },
	["PANDAREN"] = { cooldown = 120, spellID = 107079, sharesCD = false },
	["ORC"] = { cooldown = 120, spellID = 33697, sharesCD = false },
	["SCOURGE"] = { cooldown = 120, spellID = 7744, sharesCD = true },
	["TAUREN"] = { cooldown = 90, spellID = 20549, sharesCD = false },
	["TROLL"] = { cooldown = 180, spellID = 26297, sharesCD = false },
	["BLOODELF"] = { cooldown = 90, spellID = 202719, sharesCD = false },
	["GOBLIN"] = { cooldown = 90, spellID = 69070, sharesCD = false },
	["LIGHTFORGEDDRAENEI"] = { cooldown = 150, spellID = 255647, sharesCD = false },
	["HIGHMOUNTAINTAUREN"] = { cooldown = 120, spellID = 255654, sharesCD = false },
	["NIGHTBORNE"] = { cooldown = 180, spellID = 260364, sharesCD = false },
	["MAGHARORC"] = { cooldown = 120, spellID = 274738, sharesCD = false },
	["DARKIRONDWARF"] = { cooldown = 120, spellID = 265221, sharesCD = true },
	["ZANDALARITROLL"] = { cooldown = 160, spellID = 291944, sharesCD = false },
	["VOIDELF"] = { cooldown = 180, spellID = 256948, sharesCD = false },
	["KULTIRAN"] = { cooldown = 160, spellID = 287712, sharesCD = false },
	["MECHAGNOME"] = { cooldown = 180, spellID = 312924, sharesCD = false },
	["VULPERA"] = { cooldown = 90, spellID = 312411, sharesCD = false }
}

local Racial = Gladius:NewModule("Racial", false, true, {
	RacialAttachTo = "Frame",
	RacialAnchor = "TOPLEFT",
	RacialRelativePoint = "TOPRIGHT",
	RacialAdjustSize = true,
	RacialSize = 52,
	RacialOffsetX = 60,
	RacialOffsetY = 0,
	RacialFrameLevel = 1,
	RacialIconCrop = false,
	RacialGloss = true,
	RacialGlossColor = {r = 1, g = 1, b = 1, a = 0.4},
	RacialCooldown = true,
	RacialCooldownReverse = false,
	RacialDetached = false
},
{
	"Racial icon", "Grid style health bar", "Grid style power bar"
})

function Racial:OnEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_NAME_UPDATE")
	LSM = Gladius.LSM
	if not self.frame then
		self.frame = { }
	end
end

function Racial:OnDisable()
	self:UnregisterAllEvents()
	for unit in pairs(self.frame) do
		self.frame[unit]:SetAlpha(0)
	end
end

function Racial:GetAttachTo()
	return Gladius.db.RacialAttachTo
end

function Racial:IsDetached()
	return Gladius.db.RacialDetached
end

function Racial:GetFrame(unit)
	return self.frame[unit]
end

function Racial:UNIT_NAME_UPDATE(event, unit)
	-- Find Unit Race
	local _, instanceType = IsInInstance()
	if instanceType ~= "arena" or not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	local _, race =  UnitRace(unit)
	race = string.upper(race)
	local _, _, spellTexture = GetSpellInfo(unitRaceCDs[race].spellID)
	self.frame[unit].race = race
	self.frame[unit].texture:SetTexture(spellTexture)
end

function Racial:AutoFixAll()
	local _, instanceType = IsInInstance()
	if instanceType ~= "arena" then return end
	for i = 1, 3 do
		local unit = 'arena'..i
		local _,race =  UnitRace(unit)
		race = string.upper(race or 'HUMAN')
		local _, _, spellTexture = GetSpellInfo(unitRaceCDs[race].spellID)
		if (self.frame[unit]) then
			self.frame[unit].race = race
			self.frame[unit].texture:SetTexture(spellTexture)
		end
	end
end

function Racial:UNIT_AURA(event, unit)
	local _, instanceType = IsInInstance()
	if instanceType ~= "arena" or not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	local race = (self.frame[unit].race or string.upper(select(2, UnitRace(unit))))
	-- Set Racial CD on Adaptation
	if GetUnitDebuff(unit, "Adapted") then
		local _, _, _, _, _, t = GetUnitDebuff(unit, "Adapted")
		local g = t - GetTime()
		if g > 59 and unitRaceCDs[race].sharesCD then
			local sharedCD = (race == 'HUMAN' and 90) or 30
			self:UpdateRacial(unit, sharedCD)
		end
	end
end

function Racial:UNIT_SPELLCAST_SUCCEEDED(event, unit, spellLineID, spell)
	self:AutoFixAll() --hacky way of fixing racial errors
	local _, instanceType = IsInInstance()
	if instanceType ~= "arena" or not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	local race = (self.frame[unit].race or string.upper(select(2, UnitRace(unit))))
	if unitRaceCDs[race].sharesCD then
		local cd = self:GetRacialCD(unit)
		local sharedCD = (race == 'HUMAN' and 90) or 30
		if (cd < sharedCD) then
			-- PVP Trinkets
			if spell == 42292 then
				self:UpdateRacial(unit, sharedCD)
			end
			-- Honorable Medallion
			if spell == 195710 then
				self:UpdateRacial(unit, sharedCD)
			end
			-- Gladiator's Medallion
			if spell == 208683 then
				self:UpdateRacial(unit, sharedCD)
			end
		end
	end

	-- all racials
	if spell == unitRaceCDs[race].spellID then
		self:UpdateRacial(unit, unitRaceCDs[race].cooldown)
	end
end

function Racial:GetRacialCD(unit)
	local cd = 0
	local startTime, duration = self.frame[unit].cooldown:GetCooldownTimes()
	cd = ((startTime + duration) / 1000 - GetTime())
	return cd
end

function Racial:UpdateRacial(unit, duration)
	-- announcement
	if Gladius.db.announcements.Racial then
		Gladius:Call(Gladius.modules.Announcements, "Send", format(L["Racial USED: %s (%s)"], UnitName(unit) or "test", UnitClass(unit) or "test"), 2, unit)
	end
	if Gladius.db.announcements.Racial then
		self.frame[unit].timeleft = duration
		self.frame[unit]:SetScript("OnUpdate", function(f, elapsed)
			self.frame[unit].timeleft = self.frame[unit].timeleft - elapsed
			if self.frame[unit].timeleft <= 0 then
				self.frame[unit].timeleft = nil
				-- announcement
				if Gladius.db.announcements.Racial then
					Gladius:Call(Gladius.modules.Announcements, "Send", format(L["Racial READY: %s (%s)"], UnitName(unit) or "", UnitClass(unit) or ""), 2, unit)
				end
				self.frame[unit]:SetScript("OnUpdate", nil)
			end
		end)
	end
	-- cooldown
	Gladius:Call(Gladius.modules.Timer, "SetTimer", self.frame[unit], duration)
end

function Racial:CreateFrame(unit)
	local button = Gladius.buttons[unit]
	if not button then
		return
	end
	-- create frame
	self.frame[unit] = CreateFrame("CheckButton", "Gladius"..self.name.."Frame"..unit, button, "ActionButtonTemplate")
	self.frame[unit]:EnableMouse(false)
	self.frame[unit]:SetNormalTexture("Interface\\AddOns\\Gladius\\Images\\Gloss")
	self.frame[unit].texture = _G[self.frame[unit]:GetName().."Icon"]
	self.frame[unit].normalTexture = _G[self.frame[unit]:GetName().."NormalTexture"]
	self.frame[unit].cooldown = _G[self.frame[unit]:GetName().."Cooldown"]

	-- secure
	local secure = CreateFrame("Button", "Gladius"..self.name.."SecureButton"..unit, button, "SecureActionButtonTemplate")
	secure:RegisterForClicks("AnyUp")
	self.frame[unit].secure = secure
end

function Racial:UpdateColors(unit)
	self.frame[unit].normalTexture:SetVertexColor(Gladius.db.RacialGlossColor.r, Gladius.db.RacialGlossColor.g, Gladius.db.RacialGlossColor.b, Gladius.db.RacialGloss and Gladius.db.RacialGlossColor.a or 0)
end

function Racial:Update(unit)
	-- create frame
	if not self.frame[unit] then
		self:CreateFrame(unit)
	end

	local unitFrame = self.frame[unit]

	-- update frame
	unitFrame:ClearAllPoints()
	-- anchor point
	local parent = Gladius:GetParent(unit, Gladius.db.RacialAttachTo)
	unitFrame:SetPoint(Gladius.db.RacialAnchor, parent, Gladius.db.RacialRelativePoint, Gladius.db.RacialOffsetX, Gladius.db.RacialOffsetY)
	-- frame level
	unitFrame:SetFrameLevel(Gladius.db.RacialFrameLevel)
	if Gladius.db.RacialAdjustSize then
		if self:GetAttachTo() == "Frame" then
			local height = false
			-- need to rethink that
			--[[for _, module in pairs(Gladius.modules) do
				if (module:GetAttachTo() == self.name) then
					height = false
				end
			end]]
			if height then
				unitFrame:SetWidth(Gladius.buttons[unit].height)
				unitFrame:SetHeight(Gladius.buttons[unit].height)
			else
				unitFrame:SetWidth(Gladius.buttons[unit].frameHeight)
				unitFrame:SetHeight(Gladius.buttons[unit].frameHeight)
			end
		else
			unitFrame:SetWidth(Gladius:GetModule(self:GetAttachTo()).frame[unit]:GetHeight() or 1)
			unitFrame:SetHeight(Gladius:GetModule(self:GetAttachTo()).frame[unit]:GetHeight() or 1)
		end
	else
		unitFrame:SetWidth(Gladius.db.RacialSize)
		unitFrame:SetHeight(Gladius.db.RacialSize)
	end
	-- set frame mouse-interactable area
	if self:GetAttachTo() == "Frame" and not self.IsDetached() then
		local left, right, top, bottom = Gladius.buttons[unit]:GetHitRectInsets()
		if strfind(Gladius.db.RacialRelativePoint, "LEFT") then
			left = - unitFrame:GetWidth() + Gladius.db.RacialOffsetX
		else
			right = - unitFrame:GetWidth() + - Gladius.db.RacialOffsetX
		end
		-- search for an attached frame
		--[[for _, module in pairs(Gladius.modules) do
			if module.attachTo and module:GetAttachTo() == self.name and module.frame and module.frame[unit] then
				local attachedPoint = module.frame[unit]:GetPoint()
				if strfind(Gladius.db.RacialRelativePoint, "LEFT" and (not attachedPoint or (attachedPoint and strfind(attachedPoint, "RIGHT")))) then
					left = left - module.frame[unit]:GetWidth()
				elseif strfind(Gladius.db.RacialRelativePoint, "RIGHT" and (not attachedPoint or (attachedPoint and strfind(attachedPoint, "LEFT")))) then
					right = right - module.frame[unit]:GetWidth()
				end
			end
		end]]
		-- top / bottom
		if (unitFrame:GetHeight() > Gladius.buttons[unit]:GetHeight()) then
			bottom = -(unitFrame:GetHeight() - Gladius.buttons[unit]:GetHeight()) + Gladius.db.RacialOffsetY
		end
		Gladius.buttons[unit]:SetHitRectInsets(left, right, 0, 0)
		Gladius.buttons[unit].secure:SetHitRectInsets(left, right, 0, 0)
	end
	-- style action button
	unitFrame.normalTexture:SetHeight(unitFrame:GetHeight() + unitFrame:GetHeight() * 0.4)
	unitFrame.normalTexture:SetWidth(unitFrame:GetWidth() + unitFrame:GetWidth() * 0.4)
	unitFrame.normalTexture:ClearAllPoints()
	unitFrame.normalTexture:SetPoint("CENTER", 0, 0)
	unitFrame:SetNormalTexture("Interface\\AddOns\\Gladius\\Images\\Gloss")
	unitFrame.texture:ClearAllPoints()
	unitFrame.texture:SetPoint("TOPLEFT", unitFrame, "TOPLEFT")
	unitFrame.texture:SetPoint("BOTTOMRIGHT", unitFrame, "BOTTOMRIGHT")
	if not Gladius.db.RacialIconCrop then
		unitFrame.texture:SetTexCoord(0, 1, 0, 1)
	else
		unitFrame.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end
	unitFrame.normalTexture:SetVertexColor(Gladius.db.RacialGlossColor.r, Gladius.db.RacialGlossColor.g, Gladius.db.RacialGlossColor.b, Gladius.db.RacialGloss and Gladius.db.RacialGlossColor.a or 0)

	-- cooldown
	unitFrame.cooldown.isDisabled = not Gladius.db.RacialCooldown
	unitFrame.cooldown:SetReverse(Gladius.db.RacialCooldownReverse)
	Gladius:Call(Gladius.modules.Timer, "RegisterTimer", unitFrame, Gladius.db.RacialCooldown)

	-- Secure frame
	if self.IsDetached() then
		unitFrame.secure:SetAllPoints(unitFrame)
		unitFrame.secure:SetHeight(unitFrame:GetHeight())
		unitFrame.secure:SetWidth(unitFrame:GetWidth())
		unitFrame.secure:Show()
	else
		unitFrame.secure:Hide()
	end

	-- hide
	unitFrame:SetAlpha(0)
end

function Racial:Show(unit)
	local testing = Gladius.test
	-- show frame
	self.frame[unit]:SetAlpha(1)
	local RacialIcon = GetSpellTexture(unitRaceCDs["SCOURGE"].spellID)
	if testing then
		if (not self.frame[unit].race) then
			self.frame[unit].texture:SetTexture(RacialIcon)
		end
		if Gladius.db.RacialIconCrop then
			self.frame[unit].texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		end
		self.frame[unit].texture:SetVertexColor(1, 1, 1, 1)
	end
end

function Racial:Reset(unit)
	if not self.frame[unit] then
		return
	end
	self.frame[unit].race = nil
	self.frame[unit].texture:SetTexture(nil)
	-- reset frame
	local RacialIcon = GetSpellTexture(unitRaceCDs["SCOURGE"].spellID)
	if (not self.frame[unit].race) then
		self.frame[unit].texture:SetTexture(RacialIcon)
	end
	if Gladius.db.RacialIconCrop then
		self.frame[unit].texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end
	self.frame[unit]:SetScript("OnUpdate", nil)
	-- reset cooldown
	self.frame[unit].timeleft = nil
	self.frame[unit].cooldown:SetCooldown(0, 0)
	-- hide
	self.frame[unit]:SetAlpha(0)
end

function Racial:Test(unit)
	if unit == "arena1" then
		self:UpdateRacial(unit, 180)
	elseif unit == "arena2" then
		self:UpdateRacial(unit, 120)
	end
end

-- Add the announcement toggle
function Racial:OptionsLoad()
	Gladius.options.args.Announcements.args.general.args.announcements.args.Racial = {
		type = "toggle",
		name = L["Racial"],
		desc = L["Announces when an enemy uses a Racial."],
		disabled = function()
			return not Gladius.db.modules[self.name] or not Gladius.db.modules["Announcements"]
		end,
	}
end

function Racial:GetOptions()
	return {
		general = {
			type = "group",
			name = L["General"],
			order = 1,
			args = {
				widget = {
					type = "group",
					name = L["Widget"],
					desc = L["Widget settings"],
					inline = true,
					order = 1,
					args = {
						RacialCooldown = {
							type = "toggle",
							name = L["Racial Cooldown Spiral"],
							desc = L["Display the cooldown spiral for important auras"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 15,
						},
						RacialCooldownReverse = {
							type = "toggle",
							name = L["Racial Cooldown Reverse"],
							desc = L["Invert the dark/bright part of the cooldown spiral"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							width = "full",
							order = 44,
						},
						sep2 = {
							type = "description",
							name = "",
							width = "full",
							order = 45,
						},
						sep2 = {
							type = "description",
							name = "",
							width = "full",
							order = 23,
						},
						RacialGloss = {
							type = "toggle",
							name = L["Racial Gloss"],
							desc = L["Toggle gloss on the Racial icon"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 25,
						},
						RacialGlossColor = {
							type = "color",
							name = L["Racial Gloss Color"],
							desc = L["Color of the Racial icon gloss"],
							get = function(info)
								return Gladius:GetColorOption(info)
							end,
							set = function(info, r, g, b, a)
								return Gladius:SetColorOption(info, r, g, b, a)
							end,
							hasAlpha = true,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 30,
						},
						sep3 = {
							type = "description",
							name = "",
							width = "full",
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 33,
						},
						RacialIconCrop = {
							type = "toggle",
							name = L["Racial Icon Border Crop"],
							desc = L["Toggle if the borders of the Racial icon should be cropped"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							order = 35,
						},
						sep3 = {
							type = "description",
							name = "",
							width = "full",
							order = 43,
						},
						RacialFrameLevel = {
							type = "range",
							name = L["Racial Frame Level"],
							desc = L["Frame level of the Racial"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							min = 1,
							max = 5,
							step = 1,
							width = "double",
							order = 46,
						},
					},
				},
				size = {
					type = "group",
					name = L["Size"],
					desc = L["Size settings"],
					inline = true,
					order = 2,
					args = {
						RacialAdjustSize = {
							type = "toggle",
							name = L["Racial Adjust Size"],
							desc = L["Adjust Racial size to the frame size"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							order = 5,
						},
						RacialSize = {
							type = "range",
							name = L["Racial Size"],
							desc = L["Size of the Racial"],
							min = 10,
							max = 100,
							step = 1,
							disabled = function()
								return Gladius.dbi.profile.RacialAdjustSize or not Gladius.dbi.profile.modules[self.name]
							end,
							order = 10,
						},
					},
				},
				position = {
					type = "group",
					name = L["Position"],
					desc = L["Position settings"],
					inline = true,
					order = 3,
					args = {
						RacialAttachTo = {
							type = "select",
							name = L["Racial Attach To"],
							desc = L["Attach Racial to the given frame"],
							values = function()
								return Gladius:GetModules(self.name)
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							arg = "general",
							order = 5,
						},
						RacialDetached = {
							type = "toggle",
							name = L["Detached from frame"],
							desc = L["Detach the module from the frame itself"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							order = 6,
						},
						RacialPosition = {
							type = "select",
							name = L["Racial Position"],
							desc = L["Position of the Racial"],
							values = {["LEFT"] = L["Left"], ["RIGHT"] = L["Right"]},
							get = function()
								return strfind(Gladius.db.RacialAnchor, "RIGHT") and "LEFT" or "RIGHT"
							end,
							set = function(info, value)
								if (value == "LEFT") then
									Gladius.db.RacialAnchor = "TOPRIGHT"
									Gladius.db.RacialRelativePoint = "TOPLEFT"
								else
									Gladius.db.RacialAnchor = "TOPLEFT"
									Gladius.db.RacialRelativePoint = "TOPRIGHT"
								end
								Gladius:UpdateFrame(info[1])
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return Gladius.db.advancedOptions
							end,
							order = 7,
						},
						sep = {
							type = "description",
							name = "",
							width = "full",
							order = 8,
						},
						RacialAnchor = {
							type = "select",
							name = L["Racial Anchor"],
							desc = L["Anchor of the Racial"],
							values = function()
								return Gladius:GetPositions()
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 10,
						},
						RacialRelativePoint = {
							type = "select",
							name = L["Racial Relative Point"],
							desc = L["Relative point of the Racial"],
							values = function()
								return Gladius:GetPositions()
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 15,
						},
						sep2 = {
							type = "description",
							name = "",
							width = "full",
							order = 17,
						},
						RacialOffsetX = {
							type = "range",
							name = L["Racial Offset X"],
							desc = L["X offset of the Racial"],
							min = - 350,
							max = 350,
							step = 1,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							order = 20,
						},
						RacialOffsetY = {
							type = "range",
							name = L["Racial Offset Y"],
							desc = L["Y offset of the Racial"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							min = - 50,
							max = 50,
							step = 1,
							order = 25,
						},
					},
				},
			},
		},
	}
end
