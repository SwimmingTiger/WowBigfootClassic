--[[覆盖原有的默认配置函数]]
local PresetsMod = Bartender4:GetModule("Presets")
local L = LibStub("AceLocale-3.0"):GetLocale("Bartender4")
local _pagePresets =
{
	["DRUID"] =
	{
		["prowl"] = 8,
		["bear"] = 9,
		["cat"] = 7,
		["moonkin"] = 10,
	},
	["ROGUE"] =
	{
		["stealth"] = 7,
		["shadowdance"] = 8,
	},
	["WARRIOR"] =
	{
		["berserker"] = 9,
		["battle"] = 7,
		["def"] = 8,
	},
	["PRIEST"] =
	{
		["shadowform"] = 7
	},
	["WARLOCK"] =
	{
		["metamorphosis"] = 7
	}

}

local function SetBarLocation(config, point, x, y)
	config.position.point = point
	config.position.x = x
	config.position.y = y
end

local function __GetCharacterPageSetting(barSetting)
	local _,class = UnitClass("player")
	if not _pagePresets[class] then return end
	barSetting.states = barSetting.states or {}
	barSetting.states.stance = barSetting.states.stance or {}

	barSetting.states.stance[class]=_pagePresets[class]
end

local function __GetDefaultExpAndRepBarStatus()
	if UnitLevel("player")==MAX_PLAYER_LEVEL then
		return false,true
	else
		return true,false
	end
end

local function BuildSimpleProfile()
	local dy, config

	dy=0

	Bartender4.db.profile.blizzardVehicle = false
	Bartender4.db.profile.outofrange = "button"
	Bartender4.db.profile.focuscastmodifier = false

	config = Bartender4.db:GetNamespace("ActionBars").profile
	config.actionbars[1].padding = 6
	__GetCharacterPageSetting(config.actionbars[1])
	SetBarLocation( config.actionbars[1], "BOTTOMLEFT", -3, 40 )
	config.actionbars[2].padding = 6
	SetBarLocation( config.actionbars[2], "BOTTOMLEFT", -3, 80 )
	config.actionbars[3].padding = 6
	config.actionbars[3].rows = 1
	SetBarLocation( config.actionbars[3], "BOTTOMLEFT", -3, 120 )
	config.actionbars[4].padding = 6
	config.actionbars[4].rows = 1
	SetBarLocation( config.actionbars[4], "BOTTOM", 342, 40 )
	config.actionbars[5].padding = 6
	config.actionbars[5].rows = 1
	SetBarLocation( config.actionbars[5], "BOTTOM", 342, 80 )
	config.actionbars[6].padding = 6
	config.actionbars[6].rows = 1
	SetBarLocation( config.actionbars[6], "BOTTOM", 342, 120 )

	config = Bartender4.db:GetNamespace("BagBar").profile
	config.enabled = true
	Bartender4:GetModule("BagBar"):Enable()
	config = Bartender4.db:GetNamespace("MicroMenu").profile
	config.enabled = true
	Bartender4:GetModule("MicroMenu"):Enable()
	config = Bartender4.db:GetNamespace("StanceBar").profile
	config.enabled = true
	Bartender4:GetModule("StanceBar"):Enable()

	config = Bartender4.db:GetNamespace("BagBar").profile
	config.onebag = false
	SetBarLocation( config, "BOTTOM", 181, 64 )

	config = Bartender4.db:GetNamespace("MicroMenu").profile
	config.position.scale = 0.8
	SetBarLocation( config, "BOTTOM", 108, 33 )

		config = Bartender4.db:GetNamespace("RepBar").profile
		config.enabled = false
		Bartender4:GetModule("RepBar"):Disable()
		SetBarLocation( config, "BOTTOM", -516, 65 + dy ) -- Note that dy is actually correct since it's only incorrect for the RepBar if the RepBar itself does not exist

	config = Bartender4.db:GetNamespace("XPBar").profile
	config.enabled = false
	Bartender4:GetModule("XPBar"):Disable()
	SetBarLocation( config, "BOTTOM", -516, 57 )

	config = Bartender4.db:GetNamespace("BlizzardArt").profile
	config.enabled = false

	config = Bartender4.db:GetNamespace("PetBar").profile
	if GetNumShapeshiftForms() > 0 then
		SetBarLocation( config, "BOTTOMLEFT", -3, 160)
		config = Bartender4.db:GetNamespace("StanceBar").profile
		config.position.scale = 1.0
		SetBarLocation( config, "BOTTOMLEFT", 300, 160 )
	else
		SetBarLocation( config, "BOTTOMLEFT", -3, 160 )
	end

	config = Bartender4.db:GetNamespace("Vehicle").profile
	SetBarLocation( config, "BOTTOM", 214, 108 )

	config = Bartender4.db:GetNamespace("UnitFrames").profile
	SetBarLocation( config.unitframes.PlayerFrame, "BOTTOM", -230, 77)
	SetBarLocation( config.unitframes.TargetFrame, "BOTTOM", -274, 178 )
	-- SetBarLocation( config.unitframes.FocusFrame, "BOTTOM", -30, 180 )
	SetBarLocation( config.unitframes.BuffFrame, "TOPRIGHT", -265, -35 )
	SetBarLocation( config.unitframes.MinimapCluster, "TOPRIGHT", -100,-100 )
	SetBarLocation( config.unitframes.PartyMemberFrame1, "LEFT", 80, 55 )
	SetBarLocation( config.unitframes.PartyMemberFrame2, "LEFT", 80, -20 )
	SetBarLocation( config.unitframes.PartyMemberFrame3, "LEFT", 80, -95 )
	SetBarLocation( config.unitframes.PartyMemberFrame4, "LEFT", 80, -170 )
	-- SetBarLocation( config.unitframes.WatchFrame, "RIGHT", -112, 133 )
	SetBarLocation( config.unitframes.CastingBarFrame, "BOTTOMLEFT", 263, 160)
	SetCVar("uiscale",0.8)
	SetCVar("useUiScale",1)
	config.chatframes = {
		ChatFrame1={
			height = 300,
			width = 400,
			position = {
				point = "TOPLEFT",
				x = 20,
				y=-20
			}
		},
		ChatFrame2 = {
			isDocked = true
		}
	}

end

local function BuildModernProfile()
	local dy, config
	dy = 0
	if not PresetsMod.showRepBar then
		dy = dy - 5
	end
	if not PresetsMod.showXPBar then
		dy = dy - 6
	end

	Bartender4.db.profile.blizzardVehicle = false
	Bartender4.db.profile.outofrange = "button"
	Bartender4.db.profile.focuscastmodifier = false

	config = Bartender4.db:GetNamespace("ActionBars").profile
	config.actionbars[1].padding = 6
	__GetCharacterPageSetting(config.actionbars[1])
	SetBarLocation( config.actionbars[1], "BOTTOM", -256, 41.75 )
	config.actionbars[2].enabled = false
	config.actionbars[3].padding = 5
	config.actionbars[3].rows = 12
	SetBarLocation( config.actionbars[3], "RIGHT", -86, 122 )
	config.actionbars[4].padding = 5
	config.actionbars[4].rows = 12
	SetBarLocation( config.actionbars[4], "RIGHT", -43, 122 )
	SetBarLocation( config.actionbars[5], "BOTTOM", -232, 94 + dy )
	SetBarLocation( config.actionbars[6], "BOTTOM", -232, 132 + dy )

	config = Bartender4.db:GetNamespace("BagBar").profile
	config.enabled = false
	Bartender4:GetModule("BagBar"):Disable()
	config = Bartender4.db:GetNamespace("MicroMenu").profile
	config.enabled = false
	Bartender4:GetModule("MicroMenu"):Disable()
	config = Bartender4.db:GetNamespace("StanceBar").profile
	config.enabled = false
	Bartender4:GetModule("StanceBar"):Disable()

	config = Bartender4.db:GetNamespace("RepBar").profile
	config.enabled = false
	config.position.scale = 0.44 -- Note: actually not possible via interface!
	Bartender4:GetModule("RepBar"):Disable()
	SetBarLocation( config, "BOTTOM", -227, 57 + dy ) -- Note that dy is actually correct since it's only incorrect for the RepBar if the RepBar itself does not exist

	config = Bartender4.db:GetNamespace("XPBar").profile
	config.enabled = false
	config.position.scale = 0.49 -- Note: actually not possible via interface!
	Bartender4:GetModule("XPBar"):Disable()
	SetBarLocation( config, "BOTTOM", -252.85, 52 )

	config = Bartender4.db:GetNamespace("BlizzardArt").profile
	config.enabled = true
	config.artLayout = "ONEBAR"
	Bartender4:GetModule("BlizzardArt"):Enable()
	SetBarLocation( config, "BOTTOM", -256, 47 )

	config = Bartender4.db:GetNamespace("PetBar").profile
	SetBarLocation( config, "BOTTOM", -227, 164 + dy )

	config = Bartender4.db:GetNamespace("Vehicle").profile
	SetBarLocation( config, "BOTTOM", 98, 165 )

	config = Bartender4.db:GetNamespace("UnitFrames").profile
	SetBarLocation( config.unitframes.PlayerFrame, "BOTTOM", -165, 270)
	SetBarLocation( config.unitframes.TargetFrame, "BOTTOM", 155, 270 )
	-- SetBarLocation( config.unitframes.FocusFrame, "BOTTOM", 155, 400 )
	SetBarLocation( config.unitframes.BuffFrame, "TOPRIGHT", -35, -35 )
	SetBarLocation( config.unitframes.MinimapCluster, "TOPRIGHT", -110,-150 )
	SetBarLocation( config.unitframes.PartyMemberFrame1, "TOPLEFT", 80, -65 )
	SetBarLocation( config.unitframes.PartyMemberFrame2, "TOPLEFT", 80, -140 )
	SetBarLocation( config.unitframes.PartyMemberFrame3, "TOPLEFT", 80, -215 )
	SetBarLocation( config.unitframes.PartyMemberFrame4, "TOPLEFT", 80, -290 )
	-- SetBarLocation( config.unitframes.WatchFrame, "RIGHT", -250, 152 )
	SetBarLocation( config.unitframes.CastingBarFrame, "BOTTOM", 10, 188)
	SetCVar("uiscale",0.64)
	SetCVar("useUiScale",1)

	config.chatframes = {
		ChatFrame1={
			height = 300,
			width = 400,
			position = {
				point = "BOTTOMLEFT",
				x = 20,
				y=100
			}
		},
		ChatFrame2={
			height = 300,
			width = 400,
			position = {
				point = "BOTTOMLEFT",
				x = 20,
				y= 500
			}
		},
	}

end

local function BuildSingleProfile()
	local dy, config
	dy = 0
	if not PresetsMod.showRepBar then
		dy = dy - 5
	end
	if not PresetsMod.showXPBar then
		dy = dy - 6
	end
	-- -8

	Bartender4.db.profile.blizzardVehicle = false
	Bartender4.db.profile.outofrange = "button"
	Bartender4.db.profile.focuscastmodifier = false

	config = Bartender4.db:GetNamespace("ActionBars").profile
	config.actionbars[1].padding = 6
	SetBarLocation( config.actionbars[1], "BOTTOM", -256, 41.75 )
	config.actionbars[2].enabled = false
	config.actionbars[3].padding = 5
	config.actionbars[3].rows = 12
	SetBarLocation( config.actionbars[3], "BOTTOMRIGHT", -82, 610 )
	config.actionbars[4].padding = 5
	config.actionbars[4].rows = 12
	SetBarLocation( config.actionbars[4], "BOTTOMRIGHT", -42, 610 )
	SetBarLocation( config.actionbars[5], "BOTTOM", -232, 94 + dy )
	SetBarLocation( config.actionbars[6], "BOTTOM", -232, 132 + dy )

	config = Bartender4.db:GetNamespace("BagBar").profile
	config.enabled = false
	Bartender4:GetModule("BagBar"):Disable()
	config = Bartender4.db:GetNamespace("MicroMenu").profile
	config.enabled = false
	Bartender4:GetModule("MicroMenu"):Disable()
	config = Bartender4.db:GetNamespace("StanceBar").profile
	config.enabled = false
	Bartender4:GetModule("StanceBar"):Disable()

	if PresetsMod.showRepBar then
		config = Bartender4.db:GetNamespace("RepBar").profile
		config.enabled = true
		config.position.scale = 0.44 -- Note: actually not possible via interface!
		Bartender4:GetModule("RepBar"):Enable()
		SetBarLocation( config, "BOTTOM", -227, 57 + dy ) -- Note that dy is actually correct since it's only incorrect for the RepBar if the RepBar itself does not exist
	end

	if PresetsMod.showXPBar then
		config = Bartender4.db:GetNamespace("XPBar").profile
		config.enabled = true
		config.position.scale = 0.49 -- Note: actually not possible via interface!
		Bartender4:GetModule("XPBar"):Enable()
		SetBarLocation( config, "BOTTOM", -252.85, 52 )
	end

	config = Bartender4.db:GetNamespace("BlizzardArt").profile
	config.enabled = true
	config.artLayout = "ONEBAR"
	Bartender4:GetModule("BlizzardArt"):Enable()
	SetBarLocation( config, "BOTTOM", -256, 47 )

	config = Bartender4.db:GetNamespace("PetBar").profile
	SetBarLocation( config, "BOTTOM", -164, 164 + dy )
		--增加unitframes的配置

end

local function BuildDoubleProfile()
	local dy, config
	dy = 0
	if not PresetsMod.showRepBar then
		dy = dy - 8
	end
	if not PresetsMod.showXPBar then
		dy = dy - 11
	end

	Bartender4.db.profile.blizzardVehicle = true
	Bartender4.db.profile.outofrange = "button"
	Bartender4.db.profile.focuscastmodifier = false

	config = Bartender4.db:GetNamespace("ActionBars").profile
	config.actionbars[1].padding = 6
	SetBarLocation( config.actionbars[1], "BOTTOM", -510, 41.75 )
	config.actionbars[2].padding = 6
	SetBarLocation( config.actionbars[2], "BOTTOM", 3, 41.75 )
	config.actionbars[3].padding = 5
	config.actionbars[3].rows = 12
	SetBarLocation( config.actionbars[3], "BOTTOMRIGHT", -82, 610 )
	config.actionbars[4].padding = 5
	config.actionbars[4].rows = 12
	SetBarLocation( config.actionbars[4], "BOTTOMRIGHT", -42, 610 )
	config.actionbars[5].padding = 6
	SetBarLocation( config.actionbars[5], "BOTTOM", 3, 102 + dy )
	config.actionbars[6].padding = 6
	SetBarLocation( config.actionbars[6], "BOTTOM", -510, 102 + dy )

	config = Bartender4.db:GetNamespace("BagBar").profile
	config.enabled = false
	Bartender4:GetModule("BagBar"):Disable()

	config = Bartender4.db:GetNamespace("MicroMenu").profile
	config.enabled = false
	Bartender4:GetModule("MicroMenu"):Disable()

	if PresetsMod.showRepBar then
		config = Bartender4.db:GetNamespace("RepBar").profile
		config.enabled = true
		Bartender4:GetModule("RepBar"):Enable()
		SetBarLocation( config, "BOTTOM", -516, 65 + dy ) -- Note that dy is actually correct since it's only incorrect for the RepBar if the RepBar itself does not exist
	end

	if PresetsMod.showXPBar then
		config = Bartender4.db:GetNamespace("XPBar").profile
		config.enabled = true
		Bartender4:GetModule("XPBar"):Enable()
		SetBarLocation( config, "BOTTOM", -516, 57 )
	end

	config = Bartender4.db:GetNamespace("BlizzardArt").profile
	config.enabled = true
	config.artLayout = "TWOBAR"
	Bartender4:GetModule("BlizzardArt"):Enable()
	SetBarLocation( config, "BOTTOM", -512, 47 )

	config = Bartender4.db:GetNamespace("PetBar").profile
	if GetNumShapeshiftForms() > 0 then
		SetBarLocation( config, "BOTTOM", -120, 135 + dy )
		config = Bartender4.db:GetNamespace("StanceBar").profile
		config.position.scale = 1.0
		SetBarLocation( config, "BOTTOM", -460, 135 + dy )
	else
		SetBarLocation( config, "BOTTOM", -460, 135 + dy )
	end
		--增加unitframes的配置

end

local function BuildBlizzardProfile()
	local dy, config
	dy = -10

	Bartender4.db.profile.blizzardVehicle = false
	Bartender4.db.profile.outofrange = "button"
	Bartender4.db.profile.focuscastmodifier = false

	config = Bartender4.db:GetNamespace("ActionBars").profile
	config.actionbars[1].padding = 6
	config.actionbars[1].states.actionbar = true
	__GetCharacterPageSetting(config.actionbars[1])
	SetBarLocation( config.actionbars[1], "BOTTOM", -510, 41.75 )
	config.actionbars[2].enabled = false
	config.actionbars[3].padding = 5
	config.actionbars[3].rows = 12
	SetBarLocation( config.actionbars[3], "BOTTOMRIGHT", -82, 610 )
	config.actionbars[4].padding = 5
	config.actionbars[4].rows = 12
	SetBarLocation( config.actionbars[4], "BOTTOMRIGHT", -42, 610 )
	config.actionbars[5].padding = 6
	SetBarLocation( config.actionbars[5], "BOTTOM", 3, 102 + dy )
	config.actionbars[6].padding = 6
	SetBarLocation( config.actionbars[6], "BOTTOM", -510, 102 + dy )

	config = Bartender4.db:GetNamespace("BagBar").profile
	config.enabled = true
	Bartender4:GetModule("BagBar"):Enable()
	config = Bartender4.db:GetNamespace("MicroMenu").profile
	config.enabled = true
	Bartender4:GetModule("MicroMenu"):Enable()
	config = Bartender4.db:GetNamespace("StanceBar").profile
	config.enabled = true
	Bartender4:GetModule("StanceBar"):Enable()


	config = Bartender4.db:GetNamespace("BagBar").profile
	config.onebag = false
	config.padding = 4
	SetBarLocation( config, "BOTTOM", 344, 37.5 )

	config = Bartender4.db:GetNamespace("MicroMenu").profile
	config.position.scale = 1.0
	SetBarLocation( config, "BOTTOM", 32, 41 )

	local expEnable,repEnable = __GetDefaultExpAndRepBarStatus()

	config = Bartender4.db:GetNamespace("RepBar").profile
	config.enabled = repEnable
	if config.enabled then
		Bartender4:GetModule("RepBar"):Enable()
		SetBarLocation( config, "BOTTOM", -516, 57 ) -- Note that dy is actually correct since it's only incorrect for the RepBar if the RepBar itself does not exist
	else
		Bartender4:GetModule("RepBar"):Disable()
	end

	config = Bartender4.db:GetNamespace("XPBar").profile
	config.enabled = expEnable
	if config.enabled then
		Bartender4:GetModule("XPBar"):Enable()
		SetBarLocation( config, "BOTTOM", -516, 57 )
	else
		Bartender4:GetModule("XPBar"):Disable()
	end

	config = Bartender4.db:GetNamespace("BlizzardArt").profile
	config.enabled = true
	Bartender4:GetModule("BlizzardArt"):Enable()
	SetBarLocation( config, "BOTTOM", -512, 47 )

	config = Bartender4.db:GetNamespace("PetBar").profile
	if GetNumShapeshiftForms() > 0 then
		SetBarLocation( config, "BOTTOM", -120, 135 + dy )
		config = Bartender4.db:GetNamespace("StanceBar").profile
		config.position.scale = 1.0
		SetBarLocation( config, "BOTTOM", -460, 135 + dy )
	else
		SetBarLocation( config, "BOTTOM", -460, 135 + dy )
	end

	--增加unitframes的配置
	config = Bartender4.db:GetNamespace("UnitFrames").profile
	SetBarLocation( config.unitframes.PlayerFrame, "TOPLEFT", 129, -66 )
	SetBarLocation( config.unitframes.TargetFrame, "TOPLEFT", 440, -66 )
	-- SetBarLocation( config.unitframes.FocusFrame, "CENTER", -344, 143 )
	SetBarLocation( config.unitframes.BuffFrame, "TOPRIGHT", -248, -33 )
	SetBarLocation( config.unitframes.MinimapCluster, "TOPRIGHT", -108, -107 )
	SetBarLocation( config.unitframes.PartyMemberFrame1, "LEFT", 92, 235 )
	SetBarLocation( config.unitframes.PartyMemberFrame2, "LEFT", 92, 160 )
	SetBarLocation( config.unitframes.PartyMemberFrame3, "LEFT", 92, 85 )
	SetBarLocation( config.unitframes.PartyMemberFrame4, "LEFT", 92, 10 )
	-- SetBarLocation( config.unitframes.WatchFrame, "RIGHT", -259, 142 )
	SetBarLocation( config.unitframes.CastingBarFrame, "BOTTOM", 4, 127 )
	SetCVar("uiscale",1)
	SetCVar("useUiScale",0.9)
	config.chatframes = {
		ChatFrame1={
			height = 300,
			width = 400,
			position = {
				point = "BOTTOMLEFT",
				x = 20,
				y=100
			}
		},
		ChatFrame2 = {
			isDocked = true
		}
	}
end

function PresetsMod:MyResetProfile(type)
	if not type then type = PresetsMod.defaultType end
	Bartender4.db:ResetProfile()
	if type == "BLIZZARD" then
		BuildBlizzardProfile()
	elseif type == "DOUBLE" then
		BuildDoubleProfile()
	elseif type == "SINGLE" then
		BuildSingleProfile()
	elseif type == "SIMPLE" then
		BuildSimpleProfile()
	elseif type == "MODERN" then
		BuildModernProfile()
	end
	Bartender4:UpdateModuleConfigs()
end

function PresetsMod:OnEnable()
	Bartender4.finishedLoading = true
	if self.applyBlizzardOnEnable then
		self:MyResetProfile("BLIZZARD")
		self.applyBlizzardOnEnable = nil
	end
end

function PresetsMod:SetupOptions()
	if not self.options then
		PresetsMod.defaultType = "BLIZZARD"
		self.showXPBar = true
		self.showRepBar = true
		local otbl = {
			message1 = {
				order = 1,
				type = "description",
				name = L["You can use the preset defaults as a starting point for setting up your interface. Just choose your preferences here and click the button below to reset your profile to the preset default. Note that not all defaults show all bars."]
			},
			message2 = {
				order = 2,
				type = "description",
				name = L["|cffff0000WARNING|cffffffff: Pressing the button will reset your complete profile! If you're not sure about this, create a new profile and use that to experiment."],
			},
			preset = {
				order = 10,
				type = "select",
				name = L["Presets"],
				values = { BLIZZARD = L["Blizzard interface"], DOUBLE = L["Two bars wide"], SINGLE = L["Three bars stacked"], SIMPLE = L["Simple Style"],MODERN = L["Modern Style"],ZRESET = L["Full reset"] },
				get = function() return PresetsMod.defaultType end,
				set = function(info, val) PresetsMod.defaultType = val end
			},
			nl1 = {
				order = 11,
				type = "description",
				name = ""
			},
			-- xpbar = {
				-- order = 20,
				-- type = "toggle",
				-- name = L["Show XP Bar"],
				-- get = function() return PresetsMod.showXPBar end,
				-- set = function(info, val) PresetsMod.showXPBar = val end,
				-- disabled = function() return PresetsMod.defaultType == "RESET" end
			-- },
			nl2  = {
					order = 21,
					type = "description",
					name = ""
			},
			-- repbar = {
				-- order = 30,
				-- type = "toggle",
				-- name = L["Show Reputation Bar"],
				-- get = function() return PresetsMod.showRepBar end,
				-- set = function(info, val) PresetsMod.showRepBar = val end,
				-- disabled = function() return PresetsMod.defaultType == "RESET" end
			-- },
			nl3 = {
				order = 31,
				type = "description",
				name = ""
			},
			button = {
				order = 40,
				type = "execute",
				name = L["Apply Preset"],
				func = function() PresetsMod.MyResetProfile() end,
			}
		}
		self.optionobject = Bartender4:NewOptionObject( otbl )
		self.options = {
			order = 99,
			type = "group",
			name = L["Presets"],
			desc = L["Configure all of Bartender to preset defaults"],
			childGroups = "tab",
		}
		Bartender4:RegisterModuleOptions("Presets", self.options)
	end
	self.options.args = self.optionobject.table
end