--[[-------------------------------------------------------------------------
-- OptionsPanel.lua
--
-- This file contains the definitions of the main interface options panel.
-- Any other options panels are sub-categories of this main panel.
--
-- Events registered:
--   None
-------------------------------------------------------------------------]]--

local addonName, addon = ...
local L = addon.L

local panel = CreateFrame("Frame")
panel.name = L["General Options"]
panel.parent = addonName

addon.optpanels.GENERAL = panel

panel:SetScript("OnShow", function(self)
    if not panel.initialized then
        panel:CreateOptions()
        panel.refresh()
    end
end)

local function make_checkbox(name, parent)
    local frame = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate")
    frame.text = _G[frame:GetName() .. "Text"]
    frame.type = "checkbox"
    return frame
end

local function make_dropdown(name, parent)
    local frame = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate")
    frame:SetClampedToScreen(true)
    frame.type = "dropdown"
    return frame
end

local function make_label(name, parent, template)
    local label = parent:CreateFontString("OVERLAY", name, template)
    label:SetWidth(parent:GetWidth())
    label:SetJustifyH("LEFT")
    label.type = "label"
    return label
end

function panel:CreateOptions()
    -- Ensure the panel isn't created twice (thanks haste)
    panel.initialized = true

    -- Create the general options panel here:
    local bits = {}

    self.updown = make_checkbox("CliqueOptionsUpDownClick", self)
    self.updown.text:SetText(L["Trigger bindings on the 'down' portion of the click (experimental)"])

    self.fastooc = make_checkbox("CliqueOptionsFastOoc", self)
    self.fastooc.text:SetText(L["Disable out of combat clicks when party members enter combat"])

    -- Set up multiple talent profiles
    self.talentProfiles = {}
    self.specswap = make_checkbox("CliqueOptionsSpecSwap", self)
    self.specswap.text:SetText(L["Swap profiles based on talent spec"])
    self.specswap.EnableDisable = function()
        local toggleFunc
        if self.specswap:GetChecked() then
            toggleFunc = UIDropDownMenu_EnableDropDown
        else
            toggleFunc = UIDropDownMenu_DisableDropDown
        end
        for i = 1, #panel.talentProfiles do
            toggleFunc(self.talentProfiles[i])
        end
    end
    self.specswap:SetScript("PostClick", self.specswap.EnableDisable)

    if addon.versionIsRelease then
        -- Generate the dropdowns for each spec
        for i = 1, GetNumSpecializations() do
            local _, specName = GetSpecializationInfo(i)
            local name = "CliqueOptionsSpec" .. i
            local label = make_label(name .. "Label", self, "GameFontNormalSmall")
            label:SetText(L["Talent profile: %s"]:format(specName))
            self.talentProfiles[i] = make_dropdown(name, self)
            self.talentProfiles[i].profileLabel = label
            UIDropDownMenu_SetWidth(self.talentProfiles[i], 200)
            BlizzardOptionsPanel_SetupDependentControl(self.specswap, self.talentProfiles[i])
        end
    else
        for i = 1, 1 do
            local _, specName = "Default"
            local name = "CliqueOptionsSpec" .. i
            local label = make_label(name .. "Label", self, "GameFontNormalSmall")
            label:SetText(L["Talent profile: %s"]:format("Default"))
            self.talentProfiles[i] = make_dropdown(name, self)
            self.talentProfiles[i].profileLabel = label
            UIDropDownMenu_SetWidth(self.talentProfiles[i], 200)
            BlizzardOptionsPanel_SetupDependentControl(self.specswap, self.talentProfiles[i])
        end
    end

    self.profilelabel = make_label("CliqueOptionsProfileMgmtLabel", self, "GameFontNormalSmall")
    self.profilelabel:SetText(L["Profile Management:"])
    self.profiledd = make_dropdown("CliqueOptionsProfileMgmt", self)
    UIDropDownMenu_SetWidth(self.profiledd, 200)

	self.stopcastingfix = make_checkbox("CliqueOptionsStopCastingFix", self)
    self.stopcastingfix.text:SetText(L["Attempt to fix the issue introduced in 4.3 with casting on dead targets"])

    -- Collect and anchor the bits together
    table.insert(bits, self.updown)
    table.insert(bits, self.fastooc)
	table.insert(bits, self.stopcastingfix)
    table.insert(bits, self.specswap)

    for i = 1, #self.talentProfiles do
        table.insert(bits, self.talentProfiles[i].profileLabel)
        table.insert(bits, self.talentProfiles[i])
    end

    table.insert(bits, self.profilelabel)
    table.insert(bits, self.profiledd)

    bits[1]:SetPoint("TOPLEFT", 5, -5)

    for i = 2, #bits, 1 do
        if bits[i].type == "label" then
            bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", 5, -5)
        elseif bits[i].type == "dropdown" then
            bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", -5, -5)
        else
            bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", 0, -5)
        end
    end

    -- Trigger bindings on 'down' clicks instead of 'up' clicks
    -- Automatically switch profile based on spec
    --   Dropdown to select primary profile
    --   Dropdown to select secondary profile
    -- Profile managerment
    --   * set profile
    --   * delete profile
    --   * add profile
end

StaticPopupDialogs["CLIQUE_CONFIRM_PROFILE_DELETE"] = {
	preferredIndex = STATICPOPUPS_NUMDIALOGS,
    button1 = YES,
    button2 = NO,
    hideOnEscape = 1,
    timeout = 0,
    whileDead = 1,
}

StaticPopupDialogs["CLIQUE_NEW_PROFILE"] = {
	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text = "Enter the name of a new profile you'd like to create",
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function(self)
		local base = self:GetName()
		local editbox = _G[base .. "EditBox"]
        local profileName = editbox:GetText()
        addon.db:SetProfile(profileName)
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1,
	hasEditBox = 1,
	maxLetters = 32,
	OnShow = function(self)
		_G[self:GetName().."Button1"]:Disable();
		_G[self:GetName().."EditBox"]:SetFocus();
	end,
	EditBoxOnEnterPressed = function(self)
		local button = _G[self:GetParent():GetName().."Button1"]
		if addon:APIIsTrue(button:IsEnabled()) then
			local base = self:GetParent():GetName()
			local editbox = _G[base .. "EditBox"]
			local profileName = editbox:GetText()
			addon.db:SetProfile(profileName)
		end
		self:GetParent():Hide();
	end,
	EditBoxOnTextChanged = function (self)
		local editBox = _G[self:GetParent():GetName().."EditBox"];
		local txt = editBox:GetText()
		if #txt > 0 then
			_G[self:GetParent():GetName().."Button1"]:Enable();
		else
			_G[self:GetParent():GetName().."Button1"]:Disable();
		end
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide();
		ClearCursor();
	end
}

local function getsorttbl()
    local profiles = addon.db:GetProfiles()
    local sort = {}
    for idx, profileName in ipairs(profiles) do
        table.insert(sort, profileName)
    end
    table.sort(sort)
    return sort
end

local function spec_initialize(dropdown, level)
    local sort = getsorttbl()
    local paged = (#sort >= 15)

    if not level or level == 1 then
        if not paged then
            -- Display the profiles un-paged
            for idx, entry in ipairs(sort) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = entry
                info.value = entry
                info.func = function(frame, ...)
                    UIDropDownMenu_SetSelectedValue(dropdown, entry)
                end
                UIDropDownMenu_AddButton(info, level)
            end
        else
            -- Page the results into sub-menus
            for idx = 1, #sort, 10 do
                -- Make the submenus for each group
                local lastidx = (idx + 9 > #sort) and #sort or (idx + 9)
                local info = UIDropDownMenu_CreateInfo()
                local first = sort[idx]
                local last = sort[lastidx]
                info.text = first:sub(1, 5):trim() .. ".." .. last:sub(1, 5):trim()
                info.value = idx
                info.hasArrow = true
                info.notCheckable = true
                UIDropDownMenu_AddButton(info, level)
            end
        end
    elseif level == 2 then
        -- Generate the appropriate submenus depending on need
        if paged then
            -- Generate the frame submenu
            local startIdx = UIDROPDOWNMENU_MENU_VALUE
            local lastIdx = (startIdx + 9 > #sort) and #sort or (startIdx + 9)
            for idx = startIdx, lastIdx do
                local info = UIDropDownMenu_CreateInfo()
                info.text = sort[idx]
                info.value = sort[idx]
                info.func = function(frame, ...)
                    UIDropDownMenu_SetSelectedValue(dropdown, sort[idx])
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end
    end
end

local function mgmt_initialize(dropdown, level)
    local sort = getsorttbl()
    local paged = (#sort >= 10)
    local currentProfile = addon.db:GetCurrentProfile()

    if not level or level == 1 then
        if not paged then
            -- Display the profiles un-paged
            for idx, entry in ipairs(sort) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = entry
                info.value = entry
                info.notCheckable = true
                info.hasArrow = true
                UIDropDownMenu_AddButton(info, level)
            end
        else
            -- Page the results into sub-menus
            for idx = 1, #sort, 10 do
                -- Make the submenus for each group
                local lastidx = (idx + 9 > #sort) and #sort or (idx + 9)
                local info = UIDropDownMenu_CreateInfo()
                local first = sort[idx]
                local last = sort[lastidx]
                info.text = first:sub(1, 5):trim() .. ".." .. last:sub(1, 5):trim()
                info.value = idx
                info.notCheckable = true
                info.hasArrow = true
                UIDropDownMenu_AddButton(info, level)
            end
        end

        -- Create the 'Add profile' option regardless
        local info = UIDropDownMenu_CreateInfo()
        info.text = L["Add new profile"]
        info.value = "add"
        info.notCheckable = true
        info.func = function()
            HideDropDownMenu(1)
            StaticPopup_Show("CLIQUE_NEW_PROFILE")
        end
        UIDropDownMenu_AddButton(info, level)
    elseif level == 2 then
        -- Generate the appropriate submenus depending on need
        if paged then
            -- Generate the frame submenu
            local startIdx = UIDROPDOWNMENU_MENU_VALUE
            local lastIdx = (startIdx + 9 > #sort) and #sort or (startIdx + 9)
            for idx = startIdx, lastIdx do
                local info = UIDropDownMenu_CreateInfo()
                info.text = sort[idx]
                info.value = sort[idx]
                info.hasArrow = true
                info.notCheckable = true
                UIDropDownMenu_AddButton(info, level)
            end
        else
            local info = UIDropDownMenu_CreateInfo()
            info.text = L["Select profile: %s"]:format(UIDROPDOWNMENU_MENU_VALUE)
            info.value = sort[UIDROPDOWNMENU_MENU_VALUE]
            info.notCheckable = true
            -- Don't disable this, allow the user to make their own mistakes
            --info.disabled = addon.settings.specswap
            info.func = function(frame)
                UIDropDownMenu_SetSelectedValue(dropdown, UIDROPDOWNMENU_MENU_VALUE)
                UIDropDownMenu_SetText(dropdown, UIDROPDOWNMENU_MENU_VALUE)
                addon.db:SetProfile(UIDROPDOWNMENU_MENU_VALUE)
            end
            UIDropDownMenu_AddButton(info, level)

            info = UIDropDownMenu_CreateInfo()
            info.text = L["Delete profile: %s"]:format(UIDROPDOWNMENU_MENU_VALUE)
            info.disabled = UIDROPDOWNMENU_MENU_VALUE == currentProfile
            info.value = sort[UIDROPDOWNMENU_MENU_VALUE]
            info.notCheckable = true
            info.func = function(frame)
                local dialog = StaticPopupDialogs["CLIQUE_CONFIRM_PROFILE_DELETE"]
                dialog.text = L["Delete profile '%s'"]:format(UIDROPDOWNMENU_MENU_VALUE)
                dialog.OnAccept = function(self)
                    addon.db:DeleteProfile(UIDROPDOWNMENU_MENU_VALUE)
                end
                HideDropDownMenu(1)
                StaticPopup_Show("CLIQUE_CONFIRM_PROFILE_DELETE")
            end
            UIDropDownMenu_AddButton(info, level)
        end
    elseif level == 3 then
        local info = UIDropDownMenu_CreateInfo()
        info.text = L["Select profile: %s"]:format(UIDROPDOWNMENU_MENU_VALUE)
        info.value = sort[UIDROPDOWNMENU_MENU_VALUE]
        info.disabled = addon.settings.specswap
        info.func = function(frame)
            UIDropDownMenu_SetSelectedValue(dropdown, UIDROPDOWNMENU_MENU_VALUE)
            UIDropDownMenu_SetText(dropdown, UIDROPDOWNMENU_MENU_VALUE)
            addon.db:SetProfile(UIDROPDOWNMENU_MENU_VALUE)
        end
        UIDropDownMenu_AddButton(info, level)

        info = UIDropDownMenu_CreateInfo()
        info.text = L["Delete profile: %s"]:format(UIDROPDOWNMENU_MENU_VALUE)
        info.disabled = UIDROPDOWNMENU_MENU_VALUE == currentProfile
        info.value = sort[UIDROPDOWNMENU_MENU_VALUE]
        info.func = function(frame)
            local dialog = StaticPopupDialogs["CLIQUE_CONFIRM_PROFILE_DELETE"]
            dialog.text = L["Delete profile '%s'"]:format(UIDROPDOWNMENU_MENU_VALUE)
            dialog.OnAccept = function(self)
                addon.db:DeleteProfile(UIDROPDOWNMENU_MENU_VALUE)
            end
            HideDropDownMenu(1)
            StaticPopup_Show("CLIQUE_CONFIRM_PROFILE_DELETE")
        end
        UIDropDownMenu_AddButton(info, level)
    end
end

-- Update the elements on the panel to the current state
function panel.refresh()
    xpcall(function()

    if not panel.initialized then
        panel:CreateOptions()
    end

    -- Initialize the dropdowns
    local settings = addon.settings
    local currentProfile = addon.db:GetCurrentProfile()

    for i = 1, #panel.talentProfiles do
        local dbKey = string.format("spec%d_profileKey", i)
        local dropdown = panel.talentProfiles[i]
        UIDropDownMenu_Initialize(dropdown, spec_initialize)
        UIDropDownMenu_SetSelectedValue(dropdown, settings[dbKey] or currentProfile)
        UIDropDownMenu_SetText(dropdown, settings[dbKey] or currentProfile)
    end

    UIDropDownMenu_Initialize(panel.profiledd, mgmt_initialize)
    UIDropDownMenu_SetSelectedValue(panel.profiledd, currentProfile)
    UIDropDownMenu_SetText(panel.profiledd, L["Current: "] .. currentProfile)

    panel.updown:SetChecked(settings.downclick)
    panel.fastooc:SetChecked(settings.fastooc)
	panel.stopcastingfix:SetChecked(settings.stopcastingfix)
    panel.specswap:SetChecked(settings.specswap)
    panel.specswap.EnableDisable()

    end, geterrorhandler())
end

function panel.okay()
    xpcall(function ()

    local settings = addon.settings
    local currentProfile = addon.db:GetCurrentProfile()

    local changed = (not not panel.stopcastingfix:GetChecked()) ~= settings.stopcastingfix

    -- Update the saved variables
    settings.downclick = not not panel.updown:GetChecked()
	settings.stopcastingfix = not not panel.stopcastingfix:GetChecked()
    settings.fastooc = not not panel.fastooc:GetChecked()
    settings.specswap = not not panel.specswap:GetChecked()

    for i = 1, #panel.talentProfiles do
        local settingsKey = string.format("spec%d_profileKey", i)
        local dropdown = panel.talentProfiles[i]
        settings[settingsKey] = UIDropDownMenu_GetSelectedValue(dropdown)
    end

    addon:UpdateCombatWatch()

    if changed then
        addon:FireMessage("BINDINGS_CHANGED")
    end

    end, geterrorhandler())
end

panel.cancel = panel.refresh

function addon:UpdateOptionsPanel()
    if panel:IsVisible() and panel.initialized then
        panel.refresh()
    end
end

InterfaceOptions_AddCategory(panel, addon.optpanels.ABOUT)
