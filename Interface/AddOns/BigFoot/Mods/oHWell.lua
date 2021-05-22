
if IsAddOnLoaded('oHWell') then return; end		--bf@178.com

--[[
------------
-- Config --
------------

local btn = true
local point = {"CENTER", UIParent, "CENTER", 120, -50}

----------
-- Core --
----------

local button = CreateFrame("Button", "form", UIParent, "SecureActionButtonTemplate")
	--button:SetPoint("CENTER", UIParent, "CENTER", 120, -50)
	button:SetPoint(unpack(point))
	button:SetWidth(100)
	button:SetHeight(40)
	button:RegisterForClicks("AnyUp", "AnyDown")
	button:SetText(SLASH_CANCELFORM1:gsub("/(.*)","%1"))
	button:SetNormalFontObject("GameFontNormal")
	button:SetAttribute("type", "macro")
	button:SetAttribute("macrotext", "/cancelform")
	-- button:SetText("取消变形")
	
	local ntex = button:CreateTexture()
	ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
	ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	ntex:SetAllPoints()	
	button:SetNormalTexture(ntex)
	
	local htex = button:CreateTexture()
	htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	htex:SetTexCoord(0, 0.625, 0, 0.6875)
	htex:SetAllPoints()
	button:SetHighlightTexture(htex)
	
	local ptex = button:CreateTexture()
	ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
	ptex:SetTexCoord(0, 0.625, 0, 0.6875)
	ptex:SetAllPoints()
	button:SetPushedTexture(ptex)
	
	button:Hide()
	
local fb = CreateFrame("Frame")
function fb:OnEvent(event)
	if btn ~= true then return end
	local class = select(2, UnitClass("player"))
	if not (class == "DRUID" or class == "SHAMAN" or class == "PRIEST") then return end
	if GetShapeshiftForm() > 0 then
		button:Show()
		--SetBindingClick("TAB", "form")
	else
		button:Hide()
	end
end

fb:RegisterEvent("PLAYER_ENTERING_WORLD")
fb:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
fb:SetScript("OnEvent", fb.OnEvent)
]]

local f = CreateFrame("Frame")
function f:OnEvent(event, key, state)
	if state == SPELL_FAILED_NOT_STANDING then
		if BigFoot_SysTemSetTab.DoEmote_stand then
			DoEmote("stand")
		end
	elseif state == SPELL_FAILED_NOT_MOUNTED or state == ERR_ATTACK_MOUNTED then
		if BigFoot_SysTemSetTab.Dismount then
			Dismount()
		end
	end
end

f:RegisterEvent("UI_ERROR_MESSAGE")
f:SetScript("OnEvent", f.OnEvent)

--[[
local list = {
	["SPELL_FAILED_NOT_SHAPESHIFT"]					= true,
	["SPELL_FAILED_NO_ITEMS_WHILE_SHAPESHIFTED"]	= true,
	["SPELL_NOT_SHAPESHIFTED"]						= true,
	["SPELL_NOT_SHAPESHIFTED_NOSPACE"]				= true,
	["ERR_CANT_INTERACT_SHAPESHIFTED"]				= true,
	["ERR_NOT_WHILE_SHAPESHIFTED"]					= true,
	["ERR_NO_ITEMS_WHILE_SHAPESHIFTED"]				= true,
	["ERR_TAXIPLAYERSHAPESHIFTED"]					= true,
	["ERR_MOUNT_SHAPESHIFTED"]						= true,
	["ERR_EMBLEMERROR_NOTABARDGEOSET"]				= true,
}
]]--
