-- $Id: IngameLocales.lua 400 2022-07-23 10:38:27Z arithmandar $
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

local setmetatable, rawget = setmetatable, rawget
local _G = getfenv(0)
local GetItemInfo = _G.GetItemInfo


Atlas_IngameLocales = {
	-- ######################################################################
	--- Items
	-- ######################################################################
	-- Keys
	["Burial Trove Key"] = GetItemInfo(95497),
	["Dark Keeper Key"] = GetItemInfo(11197),
	["J'eevee's Jar"] = GetItemInfo(18663),
	["Key to the Palace of Lei Shen"] = GetItemInfo(94222),
	["Relic Coffer Key"] = GetItemInfo(11078),
	["The Eye of Haramad"] = GetItemInfo(32092),
}

do
	setmetatable(Atlas_IngameLocales, {__index = function(tab, key)
		return rawget(tab, key) or key end
	})
end

function Atlas_GetClassName(class)
	if (not LOCALIZED_CLASS_NAMES_MALE[class]) then
		return nil;
	end
	if (UnitSex("player") == "3") then
		return LOCALIZED_CLASS_NAMES_FEMALE[class];
	else
		return LOCALIZED_CLASS_NAMES_MALE[class];
	end
end

