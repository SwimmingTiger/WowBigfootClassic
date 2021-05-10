local M = LibStub("AceAddon-3.0"):GetAddon("MBB")
if not M then return end

local L = LibStub("AceLocale-3.0"):GetLocale("MBB")
if not L then return end

local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local optGetter, optSetter
do
	function optGetter(info)
		local key = info[#info]
		return M.db.profile[key]
	end

	function optSetter(info, value)
		local key = info[#info]
		M.db.profile[key] = value
		M:Refresh()
	end
end

local options, moduleOptions = nil, {}
local function getOptions()
	if not options then
		options = {
			type = "group",
			name = L["Minimap ButtonBag"],
			args = {
				general = {
					order = 1,
					type = "group",
					name = L["Options"],
					get = optGetter,
					set = optSetter,
					args = {
						keepsize = {
							order = 4,
							type = "toggle",
							width = "double",
							name = L["Keep Icon Size"],
						},
						spacer = {
							order = 7,
							width = "double",
							type = "description",
							name = "  ",
						},
					}
				}
			}
		}
		for k,v in pairs(moduleOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end

	return options
end

function M:ShowOptions()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames)
end

function M:SetupOptions()
	InterfaceOptionsFrame:SetFrameStrata("DIALOG")
	self.optionsFrames = {}
	-- setup options table
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("MBB", getOptions)
	self:RegisterModuleOptions("Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db), "Profiles")
	self.optionsFrames = AceConfigDialog:AddToBlizOptions("MBB", nil, nil, "general")
	self:Refresh()
end

function M:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
end