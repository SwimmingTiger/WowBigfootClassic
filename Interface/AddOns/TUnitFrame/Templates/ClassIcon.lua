
--[[
	Module\Templates\ClassIcon.lua
	Terry@bf 10-11-29
	增加职业的图标模板
]]

local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end

T.Templates = T.Templates or {}

AceOO = AceLibrary("AceOO-2.0")
if not AceOO then return end

local __CLASS_TEXTURE = [[Interface\Addons\TUnitFrame\Media\UI-CHARACTERCREATE-CLASSES]]

local ClassIconClass = AceOO.Class()

local function __CreateTexture(parent)
	assert(parent,"Can not create icon on empty parent")
	local border,texture
	border = parent:CreateTexture(parent:GetName().."Border","OVERLAY")
	texture = parent:CreateTexture(parent:GetName().."Texture")

	border:SetTexture([[Interface\Minimap\MiniMap-TrackingBorder]])

	border:SetAllPoints()
	texture:SetPoint("TOPLEFT",border,"TOPLEFT",6,-4)
	texture:SetHeight(20)
	texture:SetWidth(20)

	texture:Show()
	border:Show()
	return border,texture
end

function ClassIconClass.prototype:Create(parent,unit)
	self.f = CreateFrame("Frame",parent:GetName().."TClassFrame",parent)
	self.f:SetHeight(52)
	self.f:SetWidth(52)
	self.f:SetFrameStrata(parent:GetFrameStrata())
	self.f:SetFrameLevel(parent:GetFrameLevel()+2)
	self.border,self.texture = __CreateTexture(self.f)
	self.f:Hide()
	self.unit = unit
	self.parent = parent
end

function ClassIconClass.prototype:SetPoint(...)
	assert(self.border,"No Class Icon Created")
	self.f:SetPoint(...)
end

function ClassIconClass.prototype:SetScale(...)
	self.f:SetScale(...)
end

function ClassIconClass.prototype:PLAYER_TARGET_CHANGED()
	self:Update()
end

function ClassIconClass.prototype:GROUP_ROSTER_UPDATE()
	self:Update()
end

function ClassIconClass.prototype:Update()
	local _,_class = UnitClass(self.unit);
	local coords
	if (_class and UnitIsPlayer(self.unit)) then
		self.texture:SetTexture(__CLASS_TEXTURE)
		coords = CLASS_ICON_TCOORDS[_class]
		self.texture:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
		self.texture:Show()
		self.border:Show()
		self.f:Show()
	else
		self.f:Hide()
	end
end

function ClassIconClass.prototype:Enable()
	--TODO: if type specified then register specified events
	if self.parent == TargetFrame then
		self.f:RegisterEvent("PLAYER_TARGET_CHANGED")
	else
		self.f:RegisterEvent("GROUP_ROSTER_UPDATE")
	end
	self.f:SetScript("OnEvent",function(pane,event,...)
		if self[event] then
			self[event](self,...)
		end
	end)
	self:Update()
end

function ClassIconClass.prototype:Disable()
	self.f:Hide()
	self.f:UnregisterAllEvents()
end

T.Templates.ClassIcon = ClassIconClass