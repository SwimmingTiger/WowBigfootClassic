-- $Id: Config.lua 374 2022-01-26 14:33:01Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0);
local pairs = _G.pairs
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name);

local AceConfigReg = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")

local optGetter, optSetter
do
	function optGetter(info)
		local key = info[#info]
		return addon.db.profile[key]
	end

	function optSetter(info, value)
		local key = info[#info]
		addon.db.profile[key] = value
		addon:Refresh()
	end
end

local options, moduleOptions = nil, {}

local function getOptions()
	if not options then
		options = {
			type = "group",
			name = addon.LocName,
			args = {
				general = {
					order = 1,
					type = "group",
					name = L["ATLAS_OPTIONS_BUTTON"],
					get = optGetter,
					set = optSetter,
					args = {
						version = {
							order = 1,
							type = "description",
							name = addon.Notes,
						},
						group1 = {
							order = 10,
							type = "group",
							name = L["ATLAS_OPTIONS_HEADER_DISPLAY"],
							--inline = true,
							args = {
								show_minimapButton = {
									order = 11,
									type = "toggle",
									name = L["ATLAS_OPTIONS_SHOWBUT"],
									desc = L["ATLAS_OPTIONS_SHOWBUT_TIP"],
									width = "double",
									get = function() 
										return not addon.db.profile.minimap.hide
									end,
									set = function(info, value)
										addon.db.profile.minimap.hide = not value
										Atlas_ButtonToggle()
									end,
								},
								frames_rightClick = {
									order = 12,
									type = "toggle",
									name = L["ATLAS_OPTIONS_RCLICK"],
									desc = L["ATLAS_OPTIONS_RCLICK_TIP"],
									width = "double",
									get = function() 
										return addon.db.profile.options.frames.rightClick
									end,
									set = function(info, value)
										addon.db.profile.options.frames.rightClick = value
									end,
								},
								frames_showAcronyms = {
									order = 13,
									type = "toggle",
									name = L["ATLAS_OPTIONS_ACRONYMS"],
									desc = L["ATLAS_OPTIONS_ACRONYMS_TIP"],
									width = "double",
									get = function() 
										return addon.db.profile.options.frames.showAcronyms
									end,
									set = function(info, value)
										addon.db.profile.options.frames.showAcronyms = value
										Atlas_Refresh()
									end,
								},
								frames_controlClick = {
									order = 14,
									type = "toggle",
									name = L["ATLAS_OPTIONS_CTRL"],
									desc = L["ATLAS_OPTIONS_CTRL_TIP"],
									width = "double",
									get = function() 
										return addon.db.profile.options.frames.controlClick
									end,
									set = function(info, value)
										addon.db.profile.options.frames.controlClick = value
										Atlas_Refresh()
									end,
								},
								frames_showBossPotrait = {
									order = 15,
									type = "toggle",
									name = L["ATLAS_OPTIONS_BOSS_POTRAIT"],
									width = "double",
									get = function() 
										return addon.db.profile.options.frames.showBossPotrait
									end,
									set = function(info, value)
										addon.db.profile.options.frames.showBossPotrait = value
										Atlas_Refresh()
									end,
								},
								dropdowns_color = {
									order = 16,
									type = "toggle",
									name = L["ATLAS_OPTIONS_COLORINGDROPDOWN"],
									desc = L["ATLAS_OPTIONS_COLORINGDROPDOWN_TIP"],
									width = "double",
									get = function() 
										return addon.db.profile.options.dropdowns.color
									end,
									set = function(info, value)
										addon.db.profile.options.dropdowns.color = value
										Atlas_Refresh()
										AtlasFrameDropDown_OnShow()
									end,
								},
								dropdowns_size = {
									order = 17, 
									type = "range",
									name = L["ATLAS_OPTIONS_MAXMENUITEMS"],
									desc = L["ATLAS_OPTIONS_MAXMENUITEMS_TIP"],
									width = "full",
									min = 5, max = 50, bigStep = 1, 
									get	= function()
										return addon.db.profile.options.dropdowns.maxItems
									end,
									set	= function(info, value)
										addon.db.profile.options.dropdowns.maxItems = value
										addon:Refresh()
									end,
								},
							},
						},
						group2 = {
							order = 20,
							type = "group",
							name = L["Scale and Transparency"],
							--inline = true,
							args = {
								frames_alpha = {
									order = 21,
									type = "range",
									name = L["ATLAS_OPTIONS_TRANS"],
									min = 0, max = 1, bigStep = 0.01, 
									isPercent = true,
									--width = "full",
									get	= function()
										return addon.db.profile.options.frames.alpha
									end,
									set	= function(info, value)
										addon.db.profile.options.frames.alpha = value
										addon:UpdateAlpha()
									end,
								},
								frames_scale = {
									order = 22,
									type = "range",
									name = L["ATLAS_OPTIONS_SCALE"],
									min = 0.01, max = 1.75, bigStep = 0.01,
									isPercent = true,
									--width = "full",
									get	= function()
										return addon.db.profile.options.frames.scale
									end,
									set	= function(info, value)
										addon.db.profile.options.frames.scale = value
										addon:UpdateScale()
									end,
								},
								frames_boss_description_scale = {
									order = 23,
									type = "range",
									name = L["ATLAS_OPTIONS_BOSS_DESC_SCALE"],
									min = 0.01, max = 1.75, bigStep = 0.01,
									isPercent = true,
									--width = "full",
									get	= function()
										return addon.db.profile.options.frames.boss_description_scale
									end,
									set	= function(info, value)
										addon.db.profile.options.frames.boss_description_scale = value
									end,
								},
							},
						},
						group3 = {
							order = 30,
							type = "group",
							name = L["ATLAS_OPTIONS_HEADER_ADDONCONFIG"],
							--inline = true,
							args = {
								checkMissingModules = {
									order = 21,
									type = "toggle",
									name = L["ATLAS_OPTIONS_CHECKMODULE"],
									desc = L["ATLAS_OPTIONS_CHECKMODULE_TIP"],
									width = "double",
									get = function() 
										return addon.db.profile.options.checkMissingModules
									end,
									set = function(info, value)
										addon.db.profile.options.checkMissingModules = value
									end,
								},
								worldMapButton = {
									order = 22,
									type = "toggle",
									name = L["ATLAS_OPTIONS_SHOWWMBUT"],
									width = "double",
									get = function() 
										return addon.db.profile.options.worldMapButton
									end,
									set = function(info, value)
										addon.db.profile.options.worldMapButton = value
										if (addon.db.profile.options.worldMapButton) then
											AtlasToggleFromWorldMap:Show()
										else
											AtlasToggleFromWorldMap:Hide()
										end
									end,
								},

								autoSelect = {
									order = 23,
									type = "toggle",
									name = L["ATLAS_OPTIONS_AUTOSEL"],
									desc = L["ATLAS_OPTIONS_AUTOSEL_TIP"],
									width = "double",
									get = function() 
										return addon.db.profile.options.autoSelect
									end,
									set = function(info, value)
										addon.db.profile.options.autoSelect = value
									end,
								},
								frames_clamp = {
									order = 24,
									type = "toggle",
									name = L["ATLAS_OPTIONS_CLAMPED"],
									desc = L["ATLAS_OPTIONS_CLAMPED_TIP"],
									width = "double",
									get = function() 
										return addon.db.profile.options.frames.clamp
									end,
									set = function(info, value)
										addon.db.profile.options.frames.clamp = value
										AtlasFrame:SetClampedToScreen(addon.db.profile.options.frames.clamp)
										Atlas_Refresh()
									end,
								},
								frames_lock = {
									order = 25,
									type = "toggle",
									name = L["ATLAS_OPTIONS_LOCK"],
									desc = L["ATLAS_OPTIONS_LOCK_TIP"],
									width = "double",
									get = function() 
										return addon.db.profile.options.frames.lock
									end,
									set = function(info, value)
										addon:ToggleLock()
									end,
								},
								dropdowns_menuType = {
									order = 27,
									type = "select",
									name = L["ATLAS_OPTIONS_CATDD"],
									get = function()
										return addon.db.profile.options.dropdowns.menuType
									end,
									set = function(info, value)
										addon.db.profile.options.dropdowns.menuType = value
										addon.db.profile.options.dropdowns.module = 1
										addon.db.profile.options.dropdowns.zone = 1

										addon:PopulateDropdowns()
										Atlas_Refresh()
										AtlasFrameDropDownType_OnShow()
										AtlasFrameDropDown_OnShow()
									end,
									values = function()
										return {
											[1] = ATLAS_DDL_CONTINENT,
											[2] = ATLAS_DDL_EXPANSION,
											[3] = ATLAS_DDL_LEVEL,
											[4] = ATLAS_DDL_PARTYSIZE,
											[5] = ATLAS_DDL_TYPE,
										}
									end,
									width = "double",
								},
							},
						},
					},
				},
			},
		}
		for k,v in pairs(moduleOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end
	
	return options
end

local function openOptions()
	-- open the profiles tab before, so the menu expands
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Profiles)
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Profiles) -- yes, run twice to force the tre get expanded
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.General)
	InterfaceOptionsFrame:Raise()
end

function addon:OpenOptions() 
	openOptions()
end

local function giveProfiles()
	return AceDBOptions:GetOptionsTable(addon.db)
end

function addon:SetupOptions()
	self.optionsFrames = {}

	-- setup options table
	AceConfigReg:RegisterOptionsTable(addon.LocName, getOptions)
	self.optionsFrames.General = AceConfigDialog:AddToBlizOptions(addon.LocName, nil, nil, "general")

	self:RegisterModuleOptions("Profiles", giveProfiles, L["Profile Options"])

	self:RegisterChatCommand("atlas"..ATLAS_SLASH_OPTIONS, openOptions)
end

-- Description: Function which extends our options table in a modular way
-- Expected result: add a new modular options table to the modularOptions upvalue as well as the Blizzard config
-- Input:
--		name			: index of the options table in our main options table
--		optionsTable	: the sub-table to insert
--		displayName	: the name to display in the config interface for this set of options
-- Output: None.
function addon:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
	self.optionsFrames[name] = AceConfigDialog:AddToBlizOptions(addon.LocName, displayName, addon.LocName, name)
end
