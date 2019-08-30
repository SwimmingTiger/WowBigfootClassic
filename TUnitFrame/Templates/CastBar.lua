--[[
	Module\Templates\CastBar.lua
	Provide Cast Bar templates for others to use
	Terry@bf
	2010 - 10 - 12
]]
local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end

T.Templates = T.Templates or {}

AceOO = AceLibrary("AceOO-2.0")
if not AceOO then return end

local CastBarClass = AceOO.Class()

local function __SetSpellbarAspect(self)
	local frameText = self.Text
	local fontFile
	if (frameText) then
		fontFile = frameText:GetFont()
		frameText:SetFont(fontFile,14,"OUTLINE")
		frameText:ClearAllPoints()
		frameText:SetPoint("CENTER", self, "CENTER")
	end
	local frameBorder = self.Border
	if (frameBorder) then
		frameBorder:SetTexture([[Interface\CastingBar\UI-CastingBar-Border-Small]])
		frameBorder:SetWidth(156)
		frameBorder:SetHeight(49)
		frameBorder:ClearAllPoints()
		frameBorder:SetPoint("TOP", self, "TOP", 0, 20)
	end

	local frameFlash = self.Flash
	if (frameFlash) then
		frameFlash:SetTexture([[Interface\CastingBar\UI-CastingBar-Flash-Small]])
		frameFlash:SetWidth(156)
		frameFlash:SetHeight(49)
		frameFlash:ClearAllPoints()
		frameFlash:SetPoint("TOP", self, "TOP", 0, 20)
	end
	self:SetWidth(116)
	self:SetHeight(10)
end


-- Create and setup attributes
function CastBarClass.prototype:Create(unit,parentFrame)
	self.parent = parentFrame
	self.castbar =_G["TUFCastBar"..unit] or 
		CreateFrame("StatusBar",
			"TUFCastBar"..unit,
			parentFrame,
			"CastingBarFrameTemplate")

	__SetSpellbarAspect(self.castbar)
	CastingBarFrame_OnLoad(self.castbar,unit,true);
	
	self.castbar:SetFrameStrata("BACKGROUND")

end

-- Set up location of cast bar
function CastBarClass.prototype:SetPoint(...)
	self.castbar:SetPoint(...)
end

--toggle show/hide of the border elements
function CastBarClass.prototype:EnableBorder(flag)
	local frameBorder = self.castbar.Border
	local frameFlash = self.castbar.Flash

	frameFlash:ClearAllPoints()
	if flag then
		frameBorder:SetAlpha(1)
		frameFlash:SetPoint("TOP", self.castbar, "TOP", 0, 20)
	else
		frameBorder:SetAlpha(0)
	end
end

--!! this function does not adjust border size, need to disable border to make it looks okay.
function CastBarClass.prototype:SetSize(x,y)
	self.castbar:SetWidth(x)
	self.castbar:SetHeight(y)
	local frameText = self.castbar.Text
	if frameText then
		frameText:SetWidth(x-5)
	end
end
-- Set Scale of the bar
function CastBarClass.prototype:SetScale(...)
	self.castbar:SetScale(...)
end

-- Enable the CastBar to be shown for the unit
function CastBarClass.prototype:Enable()
	self.castbar.showCastbar = true
	self.castbar:Hide()
end

-- Disable the CastBar, not show it for spells
function CastBarClass.prototype:Disable()
	self.castbar.showCastbar = false
end

--- Save the class to template table.
T.Templates.CastBar = CastBarClass
