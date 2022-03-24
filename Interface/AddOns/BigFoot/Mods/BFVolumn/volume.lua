local B = LibStub("AceAddon-3.0"):NewAddon("BFMods")
if not B then return end
local V = B:NewModule("Volume")
local S

local function CreateSlider()
	S = CreateFrame("Slider", "BFVolumeSlider", nil, "VolumeSliderTemplate")
	S:SetValueStep(0.1)
	S:SetMinMaxValues(0,1)
	S:EnableMouseWheel(true)
	S.text = _G[S:GetName() .. 'Text']
	S.text:SetTextHeight(12)
	S.text:SetTextColor(0.5, 0.5, 0.5, 1)
	S.text:SetPoint("TOP",S,"TOP",0,19)
	S.low = _G[S:GetName() .. 'Low']
	S.low:SetText("")
	S.high = _G[S:GetName() .. 'High']
	S.high:SetText("")
	S:SetHitRectInsets(0, 0, 0,0)
end

local function SetSliderSCript()
	S:SetScript("OnShow",function(self)
		local __volume = GetCVar("Sound_MasterVolume")
		self:SetValue(1-__volume)
		self.text:SetText(tostring(ceil(__volume * 100)).."%")
	end)
	S:SetScript("OnValueChanged",function(self, value)
		S:SetValue(value)
		BlizzardOptionsPanel_SetCVarSafe("Sound_MasterVolume", 1-value);
		S.text:SetText(tostring(ceil((1-value) * 100)).."%");
	end)
	S:SetScript("OnMouseWheel",function(self,delta)
		if delta==1 then
			if S:GetValue() == 1 then
				S:SetValue(0.8)
			else
				S:SetValue(max(S:GetValue()-0.1,0))
			end
		elseif delta==-1 then
			S:SetValue(min(S:GetValue()+0.1,1))
		end
	end)
end

function V:OnInitialize()
	CreateSlider()
	SetSliderSCript()
	S:Hide()
end