--[[
	Copyright (c) 2011, Terry Wang@BF
	All rights reserved to 178.com.
	Create unitbar templates following the BT4 style. 
]]

-- fetch upvalues
local Bar = Bartender4.Bar.prototype
local UnitBar = setmetatable({}, {__index = Bar})
local UnitBar_MT = {__index = UnitBar}

local defaults = Bartender4:Merge({
	enabled = true,
	padding = 0,
}, Bartender4.Bar.defaults) 

Bartender4.UnitBar = {}
Bartender4.UnitBar.prototype = UnitBar
Bartender4.UnitBar.defaults = defaults

local function barOnDragStart(self)
	local parent = self:GetParent()
	parent:StartMoving()
	self:SetBackdropBorderColor(0, 0, 0, 0)
	parent.isMoving = true
end

local function barOnDragStop(self)
	local parent = self:GetParent()
	if parent.isMoving then
		parent:StopMovingOrSizing()
		parent:SavePosition()
		parent.isMoving = nil
	end
end


function Bartender4.UnitBar:Create(frame, config, name)
	local bar = setmetatable(Bartender4.Bar:Create(frame:GetName(), config, name), UnitBar_MT)
	bar.content = frame
	frame.bar = bar
	frame:SetParent(bar)
	frame:SetToplevel(false)
	frame:SetMovable(true)
	frame:SetUserPlaced(true)
	bar:AnchorOverlay()
	bar:PerformLayout(config)
	bar.overlay:SetScript("OnDragStart",barOnDragStart)
	bar.overlay:SetScript("OnDragStop",barOnDragStop)
	bar.overlay:HookScript("OnDragStop",barOnDragStop)
	frame:HookScript("OnDragStart",function()
		frame.bar.isMoving = true
	end)
	frame:HookScript("OnDragStop",function()
		frame.bar:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",frame:GetCenter())
		frame.bar:PerformLayout(config)
	end)
	frame:SetFrameLevel(bar:GetFrameLevel()+1)
	return bar
end

UnitBar.BT4BarType = "UnitBar"

function UnitBar:ApplyConfig(config)
	Bar.ApplyConfig(self, config)

	self:PerformLayout(config)
end

local function DoNothing()
end

function UnitBar:PerformLayout(config)
	local content = self.content
	
	self.overlay:SetScript("OnShow",function(overlay)
		overlay:SetSize(content:GetWidth()+config.padding*2, max(content:GetHeight()+config.padding*2,20))
	end)
	content:ClearAllPoints()
	content:SetPoint("CENTER",self,"CENTER",0,0)
	content.ClearAllPoints = DoNothing
	content.SetAllPoints = DoNothing
	content.SetPoint = DoNothing
	content.GetBottom = function() return 0 end
end

function UnitBar:AnchorOverlay()
	self.overlay:ClearAllPoints()
	self.overlay:SetPoint("CENTER", self, "CENTER")
end

function UnitBar:SetSize(width,height)
	self.overlay:SetWidth(width)
	self.overlay:SetHeight(height)
end

function UnitBar:SetClickThrough()	
end

function UnitBar:GetClickThrough()	
	return false
end
