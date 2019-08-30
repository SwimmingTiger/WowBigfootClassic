--[[
	Target.lua

	Terry@bf
	2010 - 11 - 5
	借用ENUF的队友目标代码，并ace化

]]
local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end

local M = T:GetModule("Party",true) or T:NewModule("Party")
if not M then return end

local TF = M:NewModule("Target","AceEvent-3.0","AceHook-3.0")
if not TF then return end
local _
local L,healthFont = {}

if GetLocale()=='zhCN' then
	L["DEAD"] = "死亡"
	healthFont = "Fonts\\ARHei.TTF"
elseif GetLocale()=='zhTW' then
	L["DEAD"] = "死亡"
	healthFont = "Fonts\\blei00d.TTF"
else
	L["DEAD"] = "DEAD"
	healthFont = "Fonts\\FRIZQT__.TTF"
end

local frames = {}

--Create short cuts for frame elements, avoid to use global all the time
local function __AssignFrameValues(frame)
	frame.name	 	= _G[frame:GetName().."Name"]
	frame.healthbar = _G[frame:GetName().."HealthBar"]
	frame.healthtext= _G[frame:GetName().."HealthBarText"]
	frame.border 	= _G[frame:GetName().."Border"]
	frame.healthtext:SetFont(healthFont,12,"OUTLINE")
end

local function __UpdateFrameUnit()
	for i = 1, MAX_PARTY_MEMBERS do
		if UnitUsingVehicle("party"..i) then
			BFSecureCall(frames[i].SetAttribute,frames[i],"unit", "partypet"..i.."target")
		else
			BFSecureCall(frames[i].SetAttribute,frames[i],"unit", "party"..i.."target")
		end
	end
end

--Create party target frames for each party member frame
local function __CreatePartyTarget()
	BFSecureCall(function()
		for i = 1, MAX_PARTY_MEMBERS do
			frames[i] = CreateFrame("Button", "TUFPartyTarget"..i, _G["PartyMemberFrame"..i], "PartyTargetFrameTemplate")
			frames[i]:SetAttribute("*type1", "target")
			__AssignFrameValues(frames[i])
		end
		__UpdateFrameUnit()
	end)
end

--register unit watch for each target frame
local function __RegisterTargetFrames()
	local partyFrame
	for i = 1, MAX_PARTY_MEMBERS do
		partyFrame = _G["PartyMemberFrame"..i]
		BFSecureCall(RegisterUnitWatch, frames[i]);
		partyFrame:RegisterAnchorFrame(frames[i], 2, "LEFT", "RIGHT", -8, 12, 80);

	end
end

--unregister unit watch for each target frame and hide frame
local function __UnregisterTargetFrames()
	local partyFrame
	for i = 1, MAX_PARTY_MEMBERS do
		partyFrame = _G["PartyMemberFrame"..i]
		BFSecureCall(UnregisterUnitWatch, frames[i]);
		BFSecureCall(frames[i].Hide, frames[i]);
		partyFrame:UnregisterAnchorFrame(frames[i]);
	end
end

-- the actions to take on each update cycle
local function __OnUpdate(partyframe)
	local i = partyframe:GetID()
	local unit = frames[i]:GetAttribute("unit")

	if UnitExists(unit) then
		_, en = UnitClass(unit)
		color = RAID_CLASS_COLORS[en] or NORMAL_FONT_COLOR
		perc = floor( (UnitHealth(unit) or 0) / max((UnitHealthMax(unit) or 1),1) * 100 )
		frames[i].name:SetText(UnitName(unit))
		frames[i].name:SetTextColor(color.r, color.g, color.b)
		frames[i].healthbar:SetValue(perc)
		frames[i].healthtext:SetText(perc .. "%")
		if perc == 0 then
			frames[i].healthtext:SetText("|cffeed200"..L["DEAD"].."|r")
		end
		if UnitIsEnemy("player", unit) then
			frames[i].border:SetVertexColor(1, 0, 0)
			frames[i].healthbar:SetStatusBarColor(0.9, 0.2, 0)
		elseif UnitIsFriend("player", unit) then
			frames[i].border:SetVertexColor(0.2, 1, 0.2)
			frames[i].healthbar:SetStatusBarColor(0.1, 0.9, 0.2)
		else
			frames[i].border:SetVertexColor(0.9, 0.82, 0)
			frames[i].healthbar:SetStatusBarColor(0.65, 0.9, 0.85)
		end
	end
end

function TF:UNIT_ENTERED_VEHICLE()
	__UpdateFrameUnit()
end

function TF:UNIT_EXITED_VEHICLE()
	__UpdateFrameUnit()
end
--update handler, calculate update cycle
function TF:PartyMemberFrame_OnUpdate(self, elapsed)
	self.timer = (self.timer or 0) + elapsed
	if self.timer >= 0.2 then
		__OnUpdate(self)
		self.timer = 0
	end
end
-- create target frame on module init
function TF:OnInitialize()
	__CreatePartyTarget()
end

--hook functions and register frames on enabling module
function TF:OnEnable()
	self:Hook("PartyMemberFrame_OnUpdate",true)
	-- self:RegisterEvent("UNIT_ENTERED_VEHICLE")
	-- self:RegisterEvent("UNIT_EXITED_VEHICLE")
	__RegisterTargetFrames()

end

--unhook functions and unregister frames on disable
function TF:OnDisable()
	self:UnhookAll()
	__UnregisterTargetFrames()
end

function M:ToggleTarget(flag)
	if flag then
		TF:Enable()
	else
		TF:Disable()
	end
end