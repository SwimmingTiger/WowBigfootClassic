--[[     
	Module\Config.lua:

	Provide config panel and setting here
	2010 - 09 -29
	Terry@bf
]]

local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end 

local M = T:NewModule("Config")
if not M then return end


function M:OnInitialize()
	T:Debug("Config Module initialized")
end

function M:OnEnable()
	T:Debug("Config Module enabled")
end

function M:OnDisable()
	T:Debug("Config Module Disabled")	
end
