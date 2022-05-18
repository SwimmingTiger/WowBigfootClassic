-- $Id: LibBabble.lua 374 2022-01-26 14:33:01Z arithmandar $
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
local pairs = _G.pairs
local LibStub, C_Map = _G.LibStub, _G.C_Map
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local MapData = private.MapData

local function getAreaInfo(zoneName)
	if not zoneName then return end
	local data = MapData.AreaToID

	if (data[zoneName]) then
		return C_Map.GetAreaInfo(data[zoneName])
	else
		return
	end
end

--[[
Atlas_GetLocaleLibBabble(typ)
Get english translations for non translated things. (Combines located and english table)
Only useable with LibBabble
]]
function Atlas_GetLocaleLibBabble(typ)

	local rettab = {}
	local tab = LibStub(typ):GetBaseLookupTable()
	local loctab = LibStub(typ):GetUnstrictLookupTable()
	for k,v in pairs(loctab) do
		rettab[k] = v
	end
	for k,v in pairs(tab) do
		if not rettab[k] then
			if typ == "LibBabble-SubZone-3.0" then
				rettab[k] = getAreaInfo(k) or v
			else
				rettab[k] = v
			end
		end
	end
	return rettab
end
