-- $Id: EJIntegration.lua 406 2022-08-21 07:17:30Z arithmandar $
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

-- Atlas JournalEncounter Integration
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs
local select = _G.select
local tonumber = _G.tonumber
-- Libraries
local GameTooltip, GetBuildInfo = _G.GameTooltip, _G.GetBuildInfo

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
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local BB = Atlas_GetLocaleLibBabble("LibBabble-Boss-3.0")

-- Adopted from EncounterJournal
local EJ_HTYPE_OVERVIEW = 3

function addon:EncounterJournal_IsHeaderTypeOverview(headerType)
	return headerType == EJ_HTYPE_OVERVIEW
end

-- ------------------------------------------------------------
-- Call this function to translate boss name
-- Syntax 1: Atlas_GetBossName(bossname);
-- Syntax 2: Atlas_GetBossName(bossname, encounterID);
-- Syntax 2: Atlas_GetBossName(bossname, encounterID, creatureIndex);
-- ------------------------------------------------------------
function addon:GetBossName(bossname, encounterID, creatureIndex, moduleName)
	local LL
	if (moduleName) then LL = LibStub("AceLocale-3.0"):GetLocale("Atlas_"..moduleName) end
	
	if (WoWRetail) then
		if (encounterID and EJ_GetEncounterInfo) then
			local _, encounter, iconImage
			if (not creatureIndex) then
				encounter = EJ_GetEncounterInfo(encounterID)
				_, _, _, _, iconImage = EJ_GetCreatureInfo(1, encounterID)
			else
				-- id, name, description, displayInfo, iconImage = EJ_GetCreatureInfo(index[, encounterID])
				_, encounter, _, _, iconImage = EJ_GetCreatureInfo(creatureIndex or 1, encounterID)
			end

			if (encounter == nil) then
				if (bossname and BB[bossname]) then
					bossname = BB[bossname]
				elseif (bossname and L[bossname]) then
					bossname = LL and LL[bossname] or bossname
				else
					--bossname = bossname
				end
			else
				bossname = iconImage and format("|T%d:0:2.5|t%s", iconImage, encounter) or encounter
			end
		elseif (bossname and L[bossname]) then
			bossname = LL and LL[bossname] or bossname
		elseif (bossname and BB[bossname]) then
			bossname = BB[bossname]
		else
			--bossname = bossname
		end
	else
		if (bossname and BB[bossname]) then
			bossname = BB[bossname]
		elseif (bossname and L[bossname]) then
			bossname = LL and LL[bossname] or bossname	
		else
			--bossname = bossname
		end
	end

	return bossname
end

function Atlas_GetBossName(bossname, encounterID, creatureIndex)
	return addon:GetBossName(bossname, encounterID, creatureIndex)
end

function addon:AdventureJournalButton_OnClick(frame)
	if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then return end
	
	local instanceID = frame.instanceID
	local disabled = not C_AdventureJournal.CanBeShown()
	if (disabled) then return end
	
	if (not instanceID) then
		return
	end

	if (not EJ_GetInstanceInfo(instanceID)) then
		return
	end

	if ( not EncounterJournal or not EncounterJournal:IsShown() ) then
		ToggleEncounterJournal()
	end
	-- EncounterJournal_ListInstances();
	NavBar_Reset(EncounterJournal.navBar)
	EncounterJournal_DisplayInstance(instanceID)

	Atlas_Toggle()
end

function addon:AdventureJournalButton_OnEnter(frame)
	if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then return end
	
	local instanceID = frame.instanceID
	if (not instanceID) then return end

	if (MouseIsOver(frame)) then
		if (EJ_GetInstanceInfo(instanceID)) then
			EJ_SelectInstance(instanceID)

			local name, description = EJ_GetInstanceInfo()
			local disabled = not C_AdventureJournal.CanBeShown()

			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
			GameTooltip:SetText(name)
			GameTooltipTextLeft1:SetTextColor(1, 1, 1)
			GameTooltip:AddLine(description, nil, nil, nil, true)
			if (disabled) then
				GameTooltip:AddLine(FEATURE_NOT_YET_AVAILABLE, 0.7, 0, 0, true)
			else
				GameTooltip:AddLine(L["ATLAS_OPEN_ADVENTURE"], 0.5, 0.5, 1, true)
			end
			GameTooltip:Show()
		end
	else
		GameTooltip:Hide()
	end
end

function addon:AdventureJournal_EncounterButton_OnClick(instanceID, encounterID, keepAtlas)
	if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then return end
	
	if (not instanceID or not encounterID) then return end
	
	local disabled = not C_AdventureJournal.CanBeShown()
	if (disabled) then return end

	if (not EJ_GetInstanceInfo(instanceID)) then
		return
	end
	if (not EJ_GetEncounterInfo(encounterID)) then
		return
	end

	if ( not EncounterJournal or not EncounterJournal:IsShown() ) then
		ToggleEncounterJournal()
	end
	-- EncounterJournal_ListInstances();
	NavBar_Reset(EncounterJournal.navBar)
	EncounterJournal_DisplayInstance(instanceID)
	EncounterJournal_DisplayEncounter(encounterID)

	if (not keepAtlas) then
		Atlas_Toggle()
	end
end

function addon:AdventureJournal_MapButton_OnClick(frame)
	if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then return end
	
	local uiMapID = frame.mapID
	local dungeonLevel = frame.dungeonLevel

	HideUIPanel(AtlasFrame)
	local disabled = not C_AdventureJournal.CanBeShown()
	if (disabled) then 
		WorldMapFrame.fromJournal = false
	else
		WorldMapFrame.fromJournal = true
	end
	ShowUIPanel(WorldMapFrame)
	if (uiMapID) then
		WorldMapFrame:SetMapID(uiMapID)
	end
--	if (dungeonLevel) then
--		SetDungeonMapLevel(dungeonLevel)
--	end
end

local function autoSelect_from_EncounterJournal()
	local instanceID = EncounterJournal.instanceID
	
	if (not instanceID) then
		return
	end

	for type_k, type_v in pairs(ATLAS_DROPDOWNS) do
		for zone_k, zone_v in pairs(type_v) do
			if (AtlasMaps[zone_v].JournalInstanceID and tonumber(AtlasMaps[zone_v].JournalInstanceID) == instanceID) then
				Atlas.db.profile.options.dropdowns.module = type_k
				Atlas.db.profile.options.dropdowns.zone = zone_k
				Atlas_Refresh()
				return
			end
		end
	end
end

-- Encounter Journal's button bidding
local function toggleFromEncounterJournal_OnClick(self)
	autoSelect_from_EncounterJournal()
	ToggleFrame(EncounterJournal)
	Atlas_Toggle()
end

local function toggleFromEncounterJournal_OnShow(self)
	local ElvUI = select(4, GetAddOnInfo("ElvUI"))

	if (not ElvUI) then return end
	local ElvUI_BZSkin = false

	if (ElvUI and ElvPrivateDB) then
		local profileKey
		if ElvPrivateDB.profileKeys then
			profileKey = ElvPrivateDB.profileKeys[UnitName("player")..' - '..GetRealmName()]
		end

		if profileKey and ElvPrivateDB.profiles and ElvPrivateDB.profiles[profileKey] then
			if (ElvPrivateDB.profiles[profileKey]["skins"]["blizzard"]["enable"] and ElvPrivateDB.profiles[profileKey]["skins"]["blizzard"]["encounterjournal"]) then
				ElvUI_BZSkin = true
			end
		end
	end
	
	if (ElvUI_BZSkin) then
		local button = _G["AtlasToggleFromEncounterJournal"]
		if (button) then
			button:SetNormalTexture("Interface\\WorldMap\\WorldMap-Icon")
			button:SetWidth(16)
			button:SetHeight(16)
			button:SetPoint("TOPRIGHT", EncounterJournalCloseButton, -28, -6, "TOPRIGHT") 
		end
	end
end

function addon:EncounterJournal_Binding()
	local button = _G["AtlasToggleFromEncounterJournal"]
	if (not button) then
		button = CreateFrame("Button","AtlasToggleFromEncounterJournal", EncounterJournal)
		button:SetWidth(32)
		button:SetHeight(32)
		
		button:SetPoint("TOPRIGHT", EncounterJournalCloseButton, -23, 0, "TOPRIGHT") 
		button:SetNormalTexture("Interface\\AddOns\\Atlas\\Images\\AtlasButton-Up")
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")

		button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
			GameTooltip:SetText(L["ATLAS_CLICK_TO_OPEN"], nil, nil, nil, nil, 1)
		end)
		button:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
		button:SetScript("OnClick", toggleFromEncounterJournal_OnClick)
		button:SetScript("OnShow", toggleFromEncounterJournal_OnShow)
	end
end

-- End of Encounter Journal's button bidding

