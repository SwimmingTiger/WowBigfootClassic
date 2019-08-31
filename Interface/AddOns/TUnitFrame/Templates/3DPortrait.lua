
--[[
	Module\Templates\3DPortrait.lua
	Provide 3D protrait templates for others to use
	Terry@bf
	2010 - 9 - 30
]]

local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end

T.Templates = T.Templates or {}

AceOO = AceLibrary("AceOO-2.0")
if not AceOO then return end

local PortraitClass = AceOO.Class()

local function __InitPorTrait(self)
	local __unit = string.gsub(string.gsub(self:GetName(), "TUF3DPortraitFrame", ""), "Model", "");
	self.__models_unit =string.lower(__unit);
	self:SetUnit(self.__models_unit);
end

--- scripts for template
function TUF3DPortrait_OnLoad(self)
	__InitPorTrait(self)
end

function TUF3DPortrait_OnEvent(self, __event, ...)
	if (UnitIsVisible(self.__models_unit)) then
		self:GetParent():Show();
		self:ClearModel()
		self:SetUnit(self.__models_unit);
		-- self:RefreshUnit();
		local pos1, pos2, pos3 = self:GetCameraPosition()
		self:SetCamera(0);
		if pos1 and pos2 and pos3 then
			local _pos1, _pos2, _pos3 = self:GetCameraPosition()
			if pos1 == _pos1 and pos2 == _pos2 and pos3 == _pos3 then
				self:SetCamera(1);
			end
		end
		if self.oriPortrait and self.oriPortrait.Hide then
			self.oriPortrait:Hide();
		end
	else
		self:GetParent():Hide();
		if self.oriPortrait and self.oriPortrait.Show then
			self.oriPortrait:Show();
		end
	end
end

function TUF3DPortrait_OnUpdate(self, arg1)

end

--- setup 3d portrait variables
function PortraitClass.prototype:Create(suffix,parentFrame,oldPortrait)
	self.parent = parentFrame
	self.portrait =_G["TUF3DPortraitFrame"..suffix] or
		CreateFrame("Frame",
			"TUF3DPortraitFrame"..suffix,
			parentFrame,
			"TUF_3DPortraitFrameTemplate")
	self.model = _G[self.portrait:GetName().."Model"]
	self.eventFunc = self.model:GetScript("OnEvent")
	self.model.oriPortrait = oldPortrait
end

-- set point for the portrait
function PortraitClass.prototype:SetPoint(...)
	self.portrait:SetPoint(...);
end

function PortraitClass.prototype:SetScale(...)
	self.portrait:SetScale(...);
end

--- enable 3d portrait and hide 2d portrait
function PortraitClass.prototype:Enable()
	self.model:RegisterEvent("UNIT_MODEL_CHANGED")
	self.model:RegisterEvent("PLAYER_TARGET_CHANGED")
	self.model:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	self.model:RegisterEvent("GROUP_ROSTER_UPDATE")
	self.portrait:Show()
	self.portrait:SetFrameStrata("BACKGROUND");
	self.portrait:SetFrameLevel(max(self.parent:GetFrameLevel()-1,0) );
	if self.model.oriPortrait then
		self.model.oriPortrait:Hide()
	end
	self.eventFunc(self.model,"PLAYER_TARGET_CHANGED")
end

--- disable 3d portrait and show 2d self.portrait
function PortraitClass.prototype:Disable()
	self.model:UnregisterEvent("UNIT_MODEL_CHANGED")
	self.model:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self.model:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
	self.model:UnregisterEvent("GROUP_ROSTER_UPDATE")
	self.portrait:Hide()
	if self.model.oriPortrait then
		self.model.oriPortrait:Show()
	end
end

--- Save the class to template table.
T.Templates.ThreeDportrait = PortraitClass
