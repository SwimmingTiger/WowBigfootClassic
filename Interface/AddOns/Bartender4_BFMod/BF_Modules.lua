--[[
	Copyright (c) 2011, Terry Wang@BF
	All rights reserved to 178.com.
	Create unitbar templates following the BT4 style.
]]

-- fetch upvalues
local Bar = Bartender4.Bar.prototype
local UnitBar = setmetatable({}, {__index = Bar})
local UnitBar_MT = {__index = UnitBar}

local Sticky = LibStub("LibSimpleSticky-1.0")

local defaults = Bartender4:Merge({
	enabled = true,
	padding = 0,
}, Bartender4.Bar.defaults)

Bartender4.UnitBar = {}
Bartender4.UnitBar.prototype = UnitBar
Bartender4.UnitBar.defaults = defaults

local function barOnDragStart(self)
	local parent = self:GetParent()

	if Bartender4.db.profile.snapping then
		local offset = 8 - (parent.config.padding or 0)
		Sticky:StartMoving(parent, BF_snapBars or {}, offset, offset, offset, offset)
	else
		if parent:GetName() == "BT4BarPartyMemberFrame1" or parent:GetName() == "BT4BarMinimapCluster" then
			Sticky:StartMoving(parent, BF_snapBars or {}, 0, 0, 0, 0)
			self:SetBackdropBorderColor(0, 0, 0, 0)
			parent.isMoving = true
			return
		end
		parent:StartMoving()
	end
	self:SetBackdropBorderColor(0, 0, 0, 0)
	parent.isMoving = true
end

local function barOnDragStop(self)
	local parent = self:GetParent()
	if parent.isMoving then
		if Bartender4.db.profile.snapping then
			Sticky:StopMoving(parent)
		else
			if parent:GetName() == "BT4BarPartyMemberFrame1" or parent:GetName() == "BT4BarMinimapCluster" then
				Sticky:StopMoving(parent)
				parent.isMoving = nil
				return
			end
		end
		parent:StopMovingOrSizing()
		parent:SavePosition()
		parent.isMoving = nil
	end
end

function Bartender4.UnitBar:Create(frame, config, name)
	local bar = setmetatable(Bartender4.Bar:Create(frame:GetName(), config, name), UnitBar_MT)
	bar.content = frame
	frame.bar = bar
	frame:SetToplevel(false)
	frame:SetMovable(true)
	frame:SetUserPlaced(true)
	bar:AnchorOverlay()
	bar:PerformLayout(config)
	bar.overlay:SetScript("OnDragStart",barOnDragStart)
	bar.overlay:SetScript("OnDragStop",barOnDragStop)

	return bar
end

UnitBar.BT4BarType = "UnitBar"

function UnitBar:ApplyConfig(config)
	Bar.ApplyConfig(self, config)
	self:PerformLayout(config)
end

local function doNothing()
end

function UnitBar:PerformLayout(config)
	local content = self.content

	self.overlay:SetScript("OnShow",function(overlay)
		overlay:SetSize(content:GetWidth()+config.padding*2, max(content:GetHeight()+config.padding*2,20))
	end)

	content:ClearAllPoints()
	content:SetPoint("CENTER",self,"CENTER",0,0)
	content.ClearAllPoints = doNothing
	content.SetAllPoints = doNothing
	content.SetPoint = doNothing
end

function UnitBar:AnchorOverlay()
	self.overlay:ClearAllPoints()
	self.overlay:SetPoint("CENTER", self, "CENTER")
end

function UnitBar:SetSize(width,height)
	self.overlay:SetWidth(width)
	self.overlay:SetHeight(height)
end

function UnitBar:GetClickThrough()
	return false
end
