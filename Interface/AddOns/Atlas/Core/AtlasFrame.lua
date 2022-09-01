-- $Id: AtlasFrame.lua 400 2022-07-23 10:38:27Z arithmandar $
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

-- AtlasFrame's related handling to be managed here

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, select, wipe = _G.pairs, _G.select, _G.wipe
-- Libraries
local string = _G.string
local table = _G.table
local getn, tinsert, tsort = table.getn, table.insert, table.sort

-- Determine WoW TOC Version
local WoWClassicEra, WoWClassicTBC, WoWWOTLKC, WoWRetail
local wowversion  = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion < 30000 then 
	WoWClassicTBC = true
elseif wowversion < 40000 then 
	WoWWOTLKC = true
elseif wowversion > 90000 then
	WoWRetail = true
else
	-- n/a
end
-- ----------------------------------------------------------------------------
-- AddOn namespace
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
-- UIDropDownMenu
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

-- Simple function to toggle the Atlas frame's lock status and update it's appearance
function addon:ToggleLock()
	addon.db.profile.options.frames.lock = not addon.db.profile.options.frames.lock
	addon:UpdateLock()
	Atlas_Refresh()
end

-- Updates the appearance of the lock button based on the status of AtlasLocked
function addon:UpdateLock()
	local btnLckUp = 	"Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Up"
	local btnLckDn = 	"Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Down"
	local btnUlckUp = 	"Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Up"
	local btnUnlckDn = 	"Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Down"
	if (addon.db.profile.options.frames.lock) then
		AtlasLockNorm:SetTexture(btnLckUp)
		AtlasLockPush:SetTexture(btnLckDn)
		AtlasLockLargeNorm:SetTexture(btnLckUp)
		AtlasLockLargePush:SetTexture(btnLckDn)
		AtlasLockSmallNorm:SetTexture(btnLckUp)
		AtlasLockSmallPush:SetTexture(btnLckDn)
	else
		AtlasLockNorm:SetTexture(btnUlckUp)
		AtlasLockPush:SetTexture(btnUnlckDn)
		AtlasLockLargeNorm:SetTexture(btnUlckUp)
		AtlasLockLargePush:SetTexture(btnUnlckDn)
		AtlasLockSmallNorm:SetTexture(btnUlckUp)
		AtlasLockSmallPush:SetTexture(btnUnlckDn)
	end
end

-- Begin moving the Atlas frame if it's unlocked
function addon:StartMoving(self)
	if (not addon.db.profile.options.frames.lock) then
		self:StartMoving()
	end
end

-- Sets the transparency of the Atlas frame based on AtlasAlpha
function addon:UpdateAlpha()
	local alpha = addon.db.profile.options.frames.alpha
	AtlasFrame:SetAlpha(alpha)
	AtlasFrameLarge:SetAlpha(alpha)
	AtlasFrameSmall:SetAlpha(alpha)
end

-- Sets the scale of the Atlas frame based on AtlasScale
function addon:UpdateScale()
	local scale = addon.db.profile.options.frames.scale
	AtlasFrame:SetScale(scale)
	AtlasFrameLarge:SetScale(scale)
	AtlasFrameSmall:SetScale(scale)
end

function addon:PrevNextMap_OnClick(self)
	local mapID = self.mapID
	if not mapID then return; end

	for k, v in pairs(ATLAS_DROPDOWNS) do
		for k2, v2 in pairs(v) do
			if (v2 == mapID) then
				addon.db.profile.options.dropdowns.module = k
				addon.db.profile.options.dropdowns.zone = k2

				AtlasFrameDropDownType_OnShow()
				AtlasFrameDropDown_OnShow()
				Atlas_Refresh()
				return
			end
		end
	end
end

function addon:ToggleWindowSize()
	if ( AtlasFrameLarge:IsVisible() ) then
		if (ATLAS_SMALLFRAME_SELECTED) then
			AtlasFrameLarge:Hide()
			AtlasFrameSmall:Show()
		else
			AtlasFrameLarge:Hide()
			AtlasFrame:Show()
		end
	else
		if (ATLAS_SMALLFRAME_SELECTED) then
			AtlasFrameSmall:Hide()
			AtlasFrameLarge:Show()
		else
			AtlasFrame:Hide()
			AtlasFrameLarge:Show()
		end
	end
end

function addon:ToggleLegendPanel()
	if ( AtlasFrameSmall:IsVisible() ) then
		ATLAS_SMALLFRAME_SELECTED = false
		AtlasFrameSmall:Hide()
		AtlasFrame:Show()
	else
		ATLAS_SMALLFRAME_SELECTED = true
		AtlasFrame:Hide()
		AtlasFrameSmall:Show()
	end
end

function AtlasEntry_OnUpdate(self)
	if (WoWRetail) then
		if( AtlasEJLootFrame:IsShown() ) then return; end
	end
	if (MouseIsOver(self)) then
		if (IsControlKeyDown() and addon.db.profile.options.frames.controlClick) then
			if (not GameTooltip:IsShown()) then
				local str = _G[self:GetName().."_Text"]:GetText()
				if (str) then
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
					GameTooltip:SetBackdropBorderColor(0, 0, 0, 0)
					GameTooltip.NineSlice:SetCenterColor(0, 0, 0, 1)
					local colorCheck = string.sub(str, 1, 4)
					if (colorCheck == "|cff") then
						local color = string.sub(str, 1, 10)
						local stripped = strtrim(string.sub(str, 11))
						GameTooltip:SetText(color..stripped, 1, 1, 1, 1)
					else
						GameTooltip:SetText(str, 1, 1, 1, 1)
					end
				end
			end
		else
			if (self.tooltiptitle) then
				GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
				GameTooltip.NineSlice:SetCenterColor(0, 0, 0, 1 * addon.db.profile.options.frames.alpha)
				GameTooltip:SetText(self.tooltiptitle, 1, 1, 1, 1)
				if (self.tooltiptext) then 
					GameTooltip:AddLine(self.tooltiptext, nil, nil, nil, 1) 
				end
				if (self.overviewDescription) then
					GameTooltip:AddLine("\n"..OVERVIEW, 1, 1, 1, 1)
					GameTooltip:AddLine(self.overviewDescription, nil, nil, nil, 1)
					if (self.roleOverview) then
						GameTooltip:AddLine("\n"..self.roleOverview, nil, nil, nil, 1)
					end
				end
				if (self.encounterID and C_AdventureJournal) then
					local disabled = not C_AdventureJournal.CanBeShown()
					if (not disabled) then
						GameTooltip:AddLine(ATLAS_OPEN_ADVENTURE, 0.5, 0.5, 1, true)
					end
					if (addon:CheckAddonStatus("AtlasLoot")) then 
						GameTooltip:AddLine(ATLAS_ROPEN_ATLASLOOT_WINDOW, 0.5, 0.5, 1, true)
					end
				end
				GameTooltip:SetScale(addon.db.profile.options.frames.boss_description_scale * addon.db.profile.options.frames.scale)
				GameTooltip:Show()
			end			
		end
	end
end

function AtlasEntry_OnClick(self, button)
	if (IsShiftKeyDown() and self.link) then
		if (IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow()) then
			ChatEdit_InsertLink(self.link)
		end
	elseif (button == "RightButton") then
		addon:AtlasLootButton_OnClick(self)
	else
		if (self.instanceID and self.encounterID) then
			addon:AdventureJournal_EncounterButton_OnClick(self.instanceID, self.encounterID)
		elseif (self.achievementID) then
			addon:OpenAchievement(self.achievementID)
		end
	end
end

-- Function used to initialize the map type dropdown menu
-- Cycle through Atlas_MapTypes to populate the dropdown
function AtlasFrameDropDownType_Initialize()
	wipe(ATLAS_DROPDOWN_TYPES)
	local i = 1
	local catName = addon.dropdowns.DropDownLayouts_Order[addon.db.profile.options.dropdowns.menuType]
	local subcatOrder = addon.dropdowns.DropDownLayouts_Order[catName]
	if (subcatOrder and type(subcatOrder) == "table") then 
		tsort(subcatOrder) 
		for n = 1, getn(subcatOrder), 1 do
			local subcatItems = addon.dropdowns.DropDownLayouts[catName][subcatOrder[n]]
			local q = (#subcatItems-(#subcatItems%ATLAS_MAX_MENUITEMS))/ATLAS_MAX_MENUITEMS
			
			if (q > 0) then
				for p = 0, q do
					ATLAS_DROPDOWN_TYPES[i+p] = {
						text = subcatOrder[n]..format(" %d/%d", p+1, q+1),
						func = AtlasFrameDropDownType_OnClick,
					}
				end
			else
				ATLAS_DROPDOWN_TYPES[i] = {
					text = subcatOrder[n],
					func = AtlasFrameDropDownType_OnClick,
				}
			end
			i = i + q + 1
		end
	end
	for j = 1, getn(Atlas_MapTypes), 1 do
		ATLAS_DROPDOWN_TYPES[i] = {
			text = Atlas_MapTypes[j],
			value = Atlas_MapTypes[j],
			func = AtlasFrameDropDownType_OnClick,
		}
		i = i + 1
	end
	
	for k = 1, #ATLAS_DROPDOWN_TYPES do
		LibDD:UIDropDownMenu_AddButton(ATLAS_DROPDOWN_TYPES[k])
	end
end

-- Called whenever the map type dropdown menu is shown
function AtlasFrameDropDownType_OnShow()
	local id = addon.db.profile.options.dropdowns.module or 1
	LibDD:UIDropDownMenu_Initialize(AtlasFrameDropDownType, AtlasFrameDropDownType_Initialize)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, id)
	LibDD:UIDropDownMenu_SetWidth(AtlasFrameDropDownType, ATLAS_DROPDOWN_WIDTH)

	LibDD:UIDropDownMenu_Initialize(AtlasFrameLargeDropDownType, AtlasFrameDropDownType_Initialize)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameLargeDropDownType, id)
	LibDD:UIDropDownMenu_SetWidth(AtlasFrameLargeDropDownType, ATLAS_DROPDOWN_WIDTH)

	LibDD:UIDropDownMenu_Initialize(AtlasFrameSmallDropDownType, AtlasFrameDropDownType_Initialize)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameSmallDropDownType, id)
	LibDD:UIDropDownMenu_SetWidth(AtlasFrameSmallDropDownType, ATLAS_DROPDOWN_WIDTH)
end

-- Called whenever an item in the map type dropdown menu is clicked
-- Sets the main dropdown menu contents to reflect the category of map selected
function AtlasFrameDropDownType_OnClick(self)
	local typeID = self:GetID()
	local profile = addon.db.profile
	local catName = addon.dropdowns.DropDownLayouts_Order[profile.options.dropdowns.menuType]
	local subcatOrder = addon.dropdowns.DropDownLayouts_Order[catName]

	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, typeID)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameLargeDropDownType, typeID)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameSmallDropDownType, typeID)

	profile.options.dropdowns.module = typeID
	local dropdowns_catKey = self:GetText()
	local index = profile.dropdowns[dropdowns_catKey]
	if (index and ATLAS_DROPDOWNS[typeID] and ATLAS_DROPDOWNS[typeID][index]) then
		profile.options.dropdowns.zone = profile.dropdowns[dropdowns_catKey]
	else
		profile.options.dropdowns.zone = 1
	end
	AtlasFrameDropDown_OnShow()
	Atlas_Refresh()
end

-- Function used to initialize the main dropdown menu
-- Looks at the status of AtlasType to determine how to populate the list
function AtlasFrameDropDown_Initialize()
	if (ATLAS_DROPDOWNS[addon.db.profile.options.dropdowns.module]) then
		for k, v in pairs(ATLAS_DROPDOWNS[addon.db.profile.options.dropdowns.module]) do
			--if (not AtlasMaps[v]) then return end
			local colortag
			local info = LibDD:UIDropDownMenu_CreateInfo()
			local level = 1
			
			if (addon.db.profile.options.dropdowns.color and AtlasMaps[v].DungeonID) then
				local minLevel, minRecLevel
				if (GetLFGDungeonInfo) then 
					_, _, _, minLevel, _, _, minRecLevel = GetLFGDungeonInfo(AtlasMaps[v].DungeonID)
				end
				if (minRecLevel == 0) then 
					minRecLevel = minLevel
				end
				local dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevel)
				colortag = addon:FormatColor(dungeon_difficulty)
			elseif (addon.db.profile.options.dropdowns.color and AtlasMaps[v].DungeonHeroicID) then
				local minLevelH, minRecLevelH
				if (GetLFGDungeonInfo) then 
					_, _, _, minLevelH, _, _, minRecLevelH = GetLFGDungeonInfo(AtlasMaps[v].DungeonHeroicID)
				end
				if (minRecLevelH == 0) then 
					minRecLevelH = minLevelH
				end
				local dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevelH)
				colortag = addon:FormatColor(dungeon_difficulty)
			elseif (addon.db.profile.options.dropdowns.color and AtlasMaps[v].DungeonMythicID) then
				local minLevelM, minRecLevelM
				if (GetLFGDungeonInfo) then 
					_, _, _, minLevelM, _, _, minRecLevelM = GetLFGDungeonInfo(AtlasMaps[v].DungeonMythicID)
				end
				if (minRecLevelM == 0) then 
					minRecLevelM = minLevelM
				end
				local dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevelM)
				colortag = addon:FormatColor(dungeon_difficulty)
			elseif (addon.db.profile.options.dropdowns.color and AtlasMaps[v].MinLevel) then
				if (type(AtlasMaps[v].MinLevel) == number) then
					local dungeon_difficulty = addon:GetDungeonDifficultyColor(AtlasMaps[v].MinLevel)
					colortag = addon:FormatColor(dungeon_difficulty)
				else
					--colortag = ""
				end
			else
				--colortag = ""
			end
			
			local zoneID = AtlasMaps[v]
			local zoneName = AtlasMaps[v].ZoneName[1]

			local parentZoneName = AtlasMaps[v].ZoneName[2] or nil
			local instanceID = AtlasMaps[v].JournalInstanceID or nil
			local DungeonID = AtlasMaps[v].DungeonID or nil
			local DungeonHeroicID = AtlasMaps[v].DungeonHeroicID or nil
			local DungeonMythicID = AtlasMaps[v].DungeonMythicID or nil 

			local typeID, subtypeID, minLevel, maxLevel, minRecLevel, maxRecLevel, maxPlayers, minGearLevel
			local typeIDH, subtypeIDH, minLevelH, maxLevelH, minRecLevelH, maxRecLevelH, maxPlayersH, minGearLevelH
			local typeIDM, subtypeIDM, minLevelM, maxLevelM, minRecLevelM, maxRecLevelM, maxPlayersM, minGearLevelM
			local colortagL, dungeon_difficulty
			local icontext_heroic 	= " |TInterface\\EncounterJournal\\UI-EJ-HeroicTextIcon:0:0|t"
			local icontext_mythic 	= " |TInterface\\AddOns\\Atlas\\Images\\\UI-EJ-MythicTextIcon:0:0|t"
			local icontext_dungeon 	= "|TInterface\\MINIMAP\\Dungeon:0:0|t"
			local icontext_raid 	= "|TInterface\\MINIMAP\\Raid:0:0|t"
			local icontext_instance

			if (DungeonID) then
				if (GetLFGDungeonInfo) then
					_, typeID, subtypeID, minLevel, maxLevel, _, minRecLevel, maxRecLevel, _, _, _, _, maxPlayers, _, _, _, _, _, _, minGearLevel = GetLFGDungeonInfo(DungeonID)
				end

				if (minRecLevel == 0) then 
					minRecLevel = minLevel
				end
				if (maxRecLevel == 0) then
					maxRecLevel = maxLevel
				end
			end
			if (DungeonHeroicID) then
				if (GetLFGDungeonInfo) then
					_, typeIDH, subtypeIDH, minLevelH, maxLevelH, _, minRecLevelH, maxRecLevelH, _, _, _, _, maxPlayersH, _, _, _, _, _, _, minGearLevelH = GetLFGDungeonInfo(DungeonHeroicID)
				end

				if (minRecLevelH == 0) then
					minRecLevelH = minRecLevel
				end
				if (maxRecLevelH == 0) then
					maxRecLevelH = maxRecLevel
				end
			end
			if (DungeonMythicID) then
				if (GetLFGDungeonInfo) then
					_, typeIDM, subtypeIDM, minLevelM, maxLevelM, _, minRecLevelM, maxRecLevelM, _, _, _, _, maxPlayersM, _, _, _, _, _, _, minGearLevelM = GetLFGDungeonInfo(DungeonMythicID)
				end

				if (minRecLevelM == 0) then
					minRecLevelM = minRecLevel
				end
				if (maxRecLevelM == 0) then
					maxRecLevelM = maxRecLevel
				end
			end
			if ((typeID and typeID == 2) or (typeIDH and typeIDH == 2) or (typeIDM and typeIDM == 2)) then
				icontext_instance = icontext_raid
			elseif ((typeID and typeID == 1 and subtypeID == 3) or (typeIDH and typeIDH == 1 and subtypeIDH == 3) or (typeIDM and typeIDM == 1 and subtypeIDM == 3)) then
				icontext_instance = icontext_raid
			else
				icontext_instance = icontext_dungeon
			end
			local levelString = ""
			if (minLevel or minLevelH or minLevelM) then
				local tmp_LR = " - "
				if (minLevel) then 
					dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevel)
					colortagL = addon:FormatColor(dungeon_difficulty)
					if (minLevel ~= maxLevel) then
						tmp_LR = tmp_LR..colortagL..minLevel.."-"..maxLevel..icontext_instance
					else
						tmp_LR = tmp_LR..colortagL..minLevel..icontext_instance
					end
				end
				if (minLevelH) then
					dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevelH)
					colortagL = addon:FormatColor(dungeon_difficulty)
					local slash
					if (minLevel) then
						slash = L["Slash"]
					else
						slash = ""
					end
					if (minLevelH ~= maxLevelH) then
						tmp_LR = tmp_LR..slash..colortagL..minLevelH.."-"..maxLevelH..icontext_heroic
					else
						tmp_LR = tmp_LR..slash..colortagL..minLevelH..icontext_heroic
					end
				end
				if (minLevelM) then
					dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevelM)
					colortagL = addon:FormatColor(dungeon_difficulty)
					local slash
					if (minLevelH) then
						slash = L["Slash"]
					else
						slash = ""
					end
					if (minLevelM ~= maxLevelM) then
						tmp_LR = tmp_LR..slash..colortagL..minLevelM.."-"..maxLevelM..icontext_mythic
					else
						tmp_LR = tmp_LR..slash..colortagL..minLevelM..icontext_mythic
					end
				end
				levelString = tmp_LR
			end

			local tooltipTitle, tooltipText
			if (instanceID and EJ_GetInstanceInfo and EJ_GetInstanceInfo(instanceID)) then
				instanceID = tonumber(instanceID)
				EJ_SelectInstance(instanceID)
				tooltipTitle, tooltipText = EJ_GetInstanceInfo()
			end
			if (tooltipTitle and levelString) then 
				tooltipTitle = tooltipTitle..levelString
			end

			info = {
				text = zoneName,
				colorCode = colortag,
				func = AtlasFrameDropDown_OnClick,
				tooltipTitle = tooltipTitle,
				tooltipText = tooltipText,
				tooltipOnButton = true,
			}
			LibDD:UIDropDownMenu_AddButton(info)
		end
	end
end

-- Called whenever the main dropdown menu is shown
function AtlasFrameDropDown_OnShow()
	local id = addon.db.profile.options.dropdowns.zone or 1
	LibDD:UIDropDownMenu_Initialize(AtlasFrameDropDown, AtlasFrameDropDown_Initialize)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, id)
	LibDD:UIDropDownMenu_SetWidth(AtlasFrameDropDown, ATLAS_DROPDOWN_WIDTH)

	LibDD:UIDropDownMenu_Initialize(AtlasFrameLargeDropDown, AtlasFrameDropDown_Initialize)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameLargeDropDown, id)
	LibDD:UIDropDownMenu_SetWidth(AtlasFrameLargeDropDown, ATLAS_DROPDOWN_WIDTH)

	LibDD:UIDropDownMenu_Initialize(AtlasFrameSmallDropDown, AtlasFrameDropDown_Initialize)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameSmallDropDown, id)
	LibDD:UIDropDownMenu_SetWidth(AtlasFrameSmallDropDown, ATLAS_DROPDOWN_WIDTH)
end

-- Called whenever an item in the main dropdown menu is clicked
-- Sets the newly selected map as current and refreshes the frame
function AtlasFrameDropDown_OnClick(self)
	local mapID = self:GetID()
	local profile = addon.db.profile
	local typeID = profile.options.dropdowns.module
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, mapID)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameLargeDropDown, mapID)
	LibDD:UIDropDownMenu_SetSelectedID(AtlasFrameSmallDropDown, mapID)

	profile.options.dropdowns.zone = mapID
	profile.dropdowns[ATLAS_DROPDOWN_TYPES[typeID].text] = mapID
	Atlas_Refresh()
end

-- When the switch button is clicked, we can basically assume that there's a match
-- Find it, set it, then update menus and the maps
function AtlasSwitchButton_OnClick()
	local zoneID = ATLAS_DROPDOWNS[addon.db.profile.options.dropdowns.module][addon.db.profile.options.dropdowns.zone]
	if (getn(ATLAS_INST_ENT_DROPDOWN) == 1) then
		-- One link, so we can just go there right away
		AtlasSwitchDD_Set(1)
	else
		-- More than one link, so it's dropdown menu time
		LibDD:ToggleDropDownMenu(1, nil, AtlasSwitchDD, "AtlasSwitchButton", 0, 0)
	end
end

function AtlasSwitchDD_OnLoad()
	for k, v in pairs(ATLAS_INST_ENT_DROPDOWN) do
		local info = LibDD:UIDropDownMenu_CreateInfo()
		info = {
			text = AtlasMaps[v].ZoneName[1],
			func = AtlasSwitchDD_OnClick,
		}
		LibDD:UIDropDownMenu_AddButton(info)
	end
end

function AtlasSwitchDD_OnClick(self)
	AtlasSwitchDD_Set(self:GetID())
end

function AtlasSwitchDD_Set(index)
	for k, v in pairs(ATLAS_DROPDOWNS) do
		for k2, v2 in pairs(v) do
			if (v2 == ATLAS_INST_ENT_DROPDOWN[index]) then
				addon.db.profile.options.dropdowns.module = k
				addon.db.profile.options.dropdowns.zone = k2

				AtlasFrameDropDownType_OnShow()
				AtlasFrameDropDown_OnShow()
				Atlas_Refresh()
				return
			end
		end
	end
end

function AtlasSwitchDD_Sort(a, b)
	local aa = AtlasMaps[a].ZoneName[1]
	local bb = AtlasMaps[b].ZoneName[1]
	return aa < bb
end

function AtlasFrameLarge_OnShow(self)
	addon:MapAddNPCButtonLarge()
end

