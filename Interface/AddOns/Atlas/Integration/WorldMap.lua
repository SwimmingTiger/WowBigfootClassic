-- $Id: WorldMap.lua 374 2022-01-26 14:33:01Z arithmandar $
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

-- Atlas WorldMap Integration
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, tonumber = _G.pairs, _G.tonumber
-- Libraries
local GameTooltip = _G.GameTooltip
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local addon = LibStub("AceAddon-3.0"):GetAddon("Atlas")

local WoWClassicEra, WoWClassicTBC, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 20000 then
	WoWClassicEra = true
elseif wowtocversion > 19999 and wowtocversion < 90000 then 
	WoWClassicTBC = true
else
	WoWRetail = true
end
local WorldMap = {}

addon.WorldMap = WorldMap

local function createButton()
	local name = "AtlasToggleFromWorldMap"
	local f = _G[name]
	if not f then f = CreateFrame("Button", "AtlasToggleFromWorldMap", WorldMapFrame) end
	
	f:SetWidth(32)
	f:SetHeight(32)
	f:SetFrameLevel(10)
	f:SetToplevel(true)
	f:Hide()
	f:ClearAllPoints()
	if (WoWClassicEra or WoWClassicTBC) then
		f:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -8, -70)
	else
		f:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -38, -68)

		f.Shadow = f:CreateTexture(name.."Shadow", "BACKGROUND")
		f.Shadow:SetAtlas("MapCornerShadow-Right", true)
		f.Shadow:SetPoint("TOPRIGHT", 4, 4)
		f.Shadow:SetTexCoord(0, 1, 1, 0)
		f.Shadow:SetDrawLayer("BACKGROUND", -1)
	end

	f.Background = f:CreateTexture(name.."Background", "BACKGROUND")
	f.Background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
	f.Background:SetSize(25, 25)
	f.Background:SetPoint("TOPLEFT", 2, -4)
	f.Background:SetVertexColor(1, 1, 1, 1)
	
	f.Icon = f:CreateTexture(name.."Icon", "ARTWORK")
	f.Icon:SetTexture("Interface\\WorldMap\\WorldMap-Icon")
	f.Icon:SetSize(20, 20)
	f.Icon:SetPoint("TOPLEFT", 6, -6)

	f.Border = f:CreateTexture(name.."Border", "ARTWORK")
	f.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	f.Border:SetSize(54, 54)
	f.Border:SetPoint("TOPLEFT")
	
	local highlightTexture = f:CreateTexture(nil, "HIGHLIGHT")
	highlightTexture:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	highlightTexture:SetBlendMode("ADD")
	highlightTexture:SetAllPoints()
	highlightTexture:SetSize(48, 48)
	highlightTexture:SetPoint("CENTER")
	f:SetHighlightTexture(highlightTexture)
	
	f:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(ATLAS_CLICK_TO_OPEN, nil, nil, nil, nil, 1)
	end)
	f:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	f:SetScript("OnClick", function(self)
		WorldMap.Button_OnClick(self)
	end)
end

local function autoSelect()
	--local mapID = C_Map.GetBestMapForUnit("player")
	local mapID = WorldMapFrame:GetMapID()
	local profile = addon.db.profile
	
	if (not mapID) then
		return
	end

	for type_k, type_v in pairs(ATLAS_DROPDOWNS) do
		for zone_k, zone_v in pairs(type_v) do
			local AtlasWorldMapID = AtlasMaps[zone_v].WorldMapID
			local AtlasMapFaction = AtlasMaps[zone_v].Faction
			if (AtlasWorldMapID and AtlasWorldMapID == mapID) then
				if (AtlasMapFaction and AtlasMapFaction == ATLAS_PLAYER_FACTION) then
					profile.options.dropdowns.module = type_k
					profile.options.dropdowns.zone = zone_k
				else
					profile.options.dropdowns.module = type_k
					profile.options.dropdowns.zone = zone_k
				end
				Atlas_Refresh()
				return
			end
		end
	end
end

function WorldMap.Button_OnClick(self)
	autoSelect()
	ToggleFrame(WorldMapFrame)
	addon:Toggle()
end

do
	createButton()
end

