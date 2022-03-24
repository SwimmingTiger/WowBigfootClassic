--[[
	Module\Focus\focus.lua
	Move MyfocusFrame here

	Terry@bf
	2010 - 09 - 29
]]


local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end 

local M = T:NewModule("FocusFrame")
if not M then return end

function M:OnInitialize()
	T:Debug("FocusFrame Module initialized")
end

function M:OnEnable()
	T:Debug("FocusFrame Module enabled")
end

function M:OnDisable()
	T:Debug("FocusFrame Module Disabled")	
end
