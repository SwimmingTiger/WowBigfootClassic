-- $Id: Templates.lua 374 2022-01-26 14:33:01Z arithmandar $
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
local _G = getfenv(0)

-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
-- UIDropDownMenu
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

local Templates = {}
private.Templates = Templates

-- //////////////////////////////////////////
-- AtlasFrameDropDownTypeTemplate
function Templates.CreateFrameDropDownType(name, parent)
	local f = _G[name] or LibDD:Create_UIDropDownMenu(name, parent)
	
	f:SetPoint("TOPLEFT", parent, 60, -50)
	
	f.Label = f:CreateFontString(name.."Label", "BACKGROUND", "GameFontNormalSmall")
	f.Label:SetText(ATLAS_STRING_SELECT_CAT)
	f.Label:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 21, 0)
	
	return f
end

-- //////////////////////////////////////////
-- AtlasFrameDropDownTemplate
function Templates.CreateFrameDropDown(name, parent)
	local f = _G[name] or LibDD:Create_UIDropDownMenu(name, parent)
	
	local ref = parent and parent:GetName().."DropDownType" or nil
	
	f:SetPoint("LEFT", ref or nil, "RIGHT", 0, 0)
	
	f.Label = f:CreateFontString(name.."Label", "BACKGROUND", "GameFontNormalSmall")
	f.Label:SetText(ATLAS_STRING_SELECT_MAP)
	f.Label:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 21, 0)
	
	return f
end
