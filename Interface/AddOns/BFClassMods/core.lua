local A = LibStub("AceAddon-3.0"):NewAddon("BFClassMod")
if not A then return end

A:SetDefaultModuleState(false)

local mt = {__index = function(t,i)return rawget(t,i) or i end}
A.localMt = mt

function ToggleBFAspectBar(flag)
	local aspectBar = A:GetModule("AspectBar")
	if not aspectBar then return end
	if flag then
		BFSecureCall(aspectBar.Enable,aspectBar)
	else
		BFSecureCall(aspectBar.Disable,aspectBar)
	end
end

function ToggleRuneFrame(flag)
	local rune = A:GetModule("RuneFrame")
	if not rune then return end
	if flag then
		rune:Enable()
	else
		rune:Disable()
	end
end

function ToggleRuneHeader(flag)
	local rune = A:GetModule("RuneFrame")
	if not rune then return end
	rune:ToggleHeader(flag)
end

function A:OnInitialize()
end

function A:OnEnable()
end

function A:OnDisable()
end