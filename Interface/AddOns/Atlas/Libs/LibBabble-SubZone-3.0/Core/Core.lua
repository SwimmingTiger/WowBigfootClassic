--[[
$Id: Core.lua 258 2022-11-20 01:52:01Z arithmandar $
Name: LibBabble-SubZone-3.0
Revision: $Rev: 258 $
Maintainers: arith
Last updated by: $Author: arithmandar $
Website: http://www.wowace.com/addons/libbabble-subzone-3-0/
Dependencies: None
License: MIT
]]
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)

-- Libraries

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local _, private = ...

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)

-- Libraries
local tonumber = tonumber
local LibStub = _G.LibStub

local MAJOR_VERSION = "LibBabble-SubZone-3.0"
local MINOR_VERSION = 100000 + tonumber(("$Rev: 258 $"):match("%d+"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib = LibStub("LibBabble-3.0"):New(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

lib.MapData = private.MapData

function lib:GetAreaInfo(zoneName)
	if not zoneName then return end
	local data = lib.MapData.AreaToID

	if (data[zoneName]) then
		return C_Map.GetAreaInfo(data[zoneName])
	else
		return
	end
end

private["LibBabble-SubZone-3.0-LoadingLib"] = lib
