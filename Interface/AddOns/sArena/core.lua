local addonName, addon = ...
addon.addonTitle = GetAddOnMetadata(addonName, "Title")
addon.exclamation = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|t"

addon.testMode = false

addon.defaultSettings = {
	profile = {
		minimap = {
			hide = false,
		},
	},
}

addon.optionsTable = {
	name = addon.addonTitle,
	type = "group",
	args = {
		title = {
			order = 1,
			type = "description",
			fontSize = "large",
			image = "Interface\\AddOns\\"..addonName.."\\Media\\logo",
			imageWidth = 26,
			imageHeight = 26,
			name = addon.addonTitle .. " " .. GetAddOnMetadata(addonName, "Version"),
		},
		break1 = {
			order = 2,
			type = "header",
			name = "",
		},
		dragNotice = {
			order = 3,
			type = "description",
			fontSize = "medium",
			name = addon.exclamation .. "Ctrl+Shift+Click to move various elements",
		},
		break2 = {
			order = 4,
			type = "header",
			name = "",
		},
		test = {
			order = 5,
			type = "execute",
			name = "Test",
			func = function()
				local _, instanceType = IsInInstance()
				if InCombatLockdown() or instanceType == "arena" then
					print(addonName .. ": Must leave combat and arena to do that.")
				else
					addon:OnEvent("TEST_MODE")
				end
			end,
			width = 0.5,
		},
		hide = {
			order = 6,
			type = "execute",
			name = "Hide",
			func = function()
				if InCombatLockdown() then
					print(addonName .. ": Must leave combat to do that.")
				elseif addon.testMode then
					addon:OnEvent("TEST_MODE")
				end
			end,
			width = 0.5,
		},
		minimapButton = {
			order = 7,
			type = "toggle",
			name = "Minimap Button",
			get = function(info) return not addon.db.profile.minimap.hide end,
			set = function(info, val)
				addon.db.profile.minimap.hide = not val
				addon.icon:Refresh(addonName)
			end,
		},
	},
}

addon.modules = {}

local moduleOrder = 1

function addon:CreateModule(name)
	self.modules[name] = {
		order = moduleOrder,
		UpdateSettings = function(info, val)
			if InCombatLockdown() then
				print(addonName .. ": Must leave combat to do that.")
				return
			end

			local module = self.modules[name]

			module.db[info[#info]] = val
			if module.OnEvent then
				module:OnEvent("UPDATE_SETTINGS")
			end
		end
	}

	moduleOrder = moduleOrder + 1

	return self.modules[name]
end

function addon:OnEvent(event, ...)
	if event == "ADDON_LOADED" then
		if ... ~= addonName then return end

		-- Import options tables & default settings from modules into core
		for module, _ in pairs(addon.modules) do
			addon.optionsTable.args[module] = {
				order = addon.modules[module].order,
				type = "group",
				name = module,
				get = function(info) return addon.modules[module].db[info[#info]] end,
				set = function(info, val) addon.modules[module].db[info[#info]] = val end,
				args = addon.modules[module].optionsTable,
			}
	
			addon.defaultSettings.profile[module] = addon.modules[module].defaultSettings
		end

		addon.db = LibStub("AceDB-3.0"):New(addonName.."DB", addon.defaultSettings, true)

		addon.optionsTable.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db)

		LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, addon.optionsTable)
		LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, addon.addonTitle)
		LibStub("AceConfigDialog-3.0"):SetDefaultSize(addonName, 550, 500)

		local LDB = LibStub("LibDataBroker-1.1"):NewDataObject(addonName, {
			type = "launcher",
			icon = "Interface\\AddOns\\"..addonName.."\\Media\\logo",
			OnTooltipShow = function(tooltip) tooltip:AddLine(addon.addonTitle) end,
			OnClick = function()
				local config = LibStub("AceConfigDialog-3.0")
	
				if config.OpenFrames[addonName] then
					config:Close(addonName)
				else
					config:Open(addonName)
				end
			end,
		})

		addon.icon = LibStub("LibDBIcon-1.0")
		addon.icon:Register(addonName, LDB, addon.db.profile.minimap)

		local function UpdateProfileRefs()
			addon.icon:Refresh(addonName, addon.db.profile.minimap)

			for module, _ in pairs(addon.modules) do
				addon.modules[module].db = addon.db.profile[module]
			end
		end

		local function OnProfileChange()
			UpdateProfileRefs()
			addon:OnEvent("UPDATE_SETTINGS")
		end

		UpdateProfileRefs()

		addon.db.RegisterCallback(addon, "OnProfileChanged", OnProfileChange)
		addon.db.RegisterCallback(addon, "OnProfileCopied", OnProfileChange)
		addon.db.RegisterCallback(addon, "OnProfileReset", OnProfileChange)

		local function ChatCommand(input)
			if not input or input:trim() == "" then
				LibStub("AceConfigDialog-3.0"):Open(addonName)
			else
				LibStub("AceConfigCmd-3.0").HandleCommand(addonName, addonName, addonName, input)
			end
		end

		LibStub("AceConsole-3.0"):RegisterChatCommand(addonName, ChatCommand)
	elseif event == "TEST_MODE" then
		-- Test mode not permitted while in combat
		if InCombatLockdown() then
			return
		end

		addon.testMode = not addon.testMode
	elseif event == "PLAYER_ENTERING_WORLD" then
		if addon.testMode then
			addon:OnEvent("TEST_MODE")
		end
	end

	local modules = addon.modules
	for module, _ in pairs(modules) do
		if modules[module].OnEvent then
			modules[module]:OnEvent(event, ...)
		end
	end
end

addon.eventHandler = CreateFrame("Frame")
addon.eventHandler:SetScript("OnEvent", addon.OnEvent)
addon.eventHandler:RegisterEvent("ADDON_LOADED")
addon.eventHandler:RegisterEvent("PLAYER_ENTERING_WORLD")

function addon:SetupDrag(module, updateSettings, frameToClick, frameToMove)
	if not frameToMove then
		frameToMove = frameToClick
	end

	frameToClick:HookScript("OnMouseDown", function()
		if IsShiftKeyDown() and IsControlKeyDown() and not frameToMove.isMoving then
			if InCombatLockdown() then
				print(addonName .. ": Must leave combat to do that.")
				return
			end
			frameToMove:StartMoving()
			frameToMove:SetUserPlaced(false)
			frameToMove.isMoving = true
		end
	end)

	frameToClick:HookScript("OnMouseUp", function()
		if InCombatLockdown() then return end

		if frameToMove.isMoving then
			frameToMove:StopMovingOrSizing()
			frameToMove.isMoving = false

			local settings = module.db

			local parentX, parentY = frameToMove:GetParent():GetCenter()
			local frameX, frameY = frameToMove:GetCenter()
			local scale = frameToMove:GetScale()

			frameX = ((frameX * scale) - parentX) / scale
			frameY = ((frameY * scale) - parentY) / scale

			-- round to 1 decimal place
			frameX = floor(frameX * 10 + 0.5 ) / 10
			frameY = floor(frameY * 10 + 0.5 ) / 10

			settings.x, settings.y = frameX, frameY

			if updateSettings then
				module:OnEvent("UPDATE_SETTINGS")
			end
		end
	end)
end
