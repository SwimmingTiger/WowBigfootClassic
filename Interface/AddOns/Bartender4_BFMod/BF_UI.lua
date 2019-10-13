--[[
	Copyright (c) 2011, Terry Wang@BF
	All rights reserved to 178.com.
	Instantiate unit frames
]]
local L = LibStub("AceLocale-3.0"):GetLocale("Bartender4")
local UnitFrames = Bartender4:NewModule("UnitFrames","AceEvent-3.0")
local UnitBar,UnitBar_MT
local _G = _G

-- fetch upvalues
local Bar = Bartender4.Bar.prototype

local ufdefault ={
	["PlayerFrame"] = Bartender4:Merge({
		enabled = true,
		position={
			y = -66,
			x = 129,
			point="TOPLEFT"
		},
	}, Bartender4.UnitBar.defaults),
	["TargetFrame"] = Bartender4:Merge({
		enabled = true,
		position={
			y = -66,
			x = 440,
			point="TOPLEFT"
		},
	}, Bartender4.UnitBar.defaults),
	-- ["FocusFrame"] = Bartender4:Merge({
		-- enabled = true,
		-- position={
			-- x = -344,
			-- y = 143,
			-- point="CENTER"
		-- },
	-- }, Bartender4.UnitBar.defaults),
	["BuffFrame"] = Bartender4:Merge({
		enabled = true,
		position={
			x = -248,
			y = -33,
			point="TOPRIGHT"
		},

	}, Bartender4.UnitBar.defaults),
	["MinimapCluster"] = Bartender4:Merge({
		enabled = true,
		position={
			x = -108,
			y = -107,
			point="TOPRIGHT"
		},
		padding =10,
	}, Bartender4.UnitBar.defaults),
	-------为什么队伍1-4 的默认设置为false，现在改为默认加载---------------------------------
	["PartyMemberFrame1"] = Bartender4:Merge({
		enabled = true,
		paddding =3,
		position={
			x = 92,
			y = 235,
			point="LEFT"
		},

	}, Bartender4.UnitBar.defaults),
	["PartyMemberFrame2"] = Bartender4:Merge({
		enabled = true,
		paddding =3,
		position={
			x = 92,
			y = 160,
			point="LEFT"
		},

	}, Bartender4.UnitBar.defaults),
	["PartyMemberFrame3"] = Bartender4:Merge({
		enabled = true,
		paddding =3,
		position={
			x = 92,
			y = 85,
			point="LEFT"
		},

	}, Bartender4.UnitBar.defaults),
	["PartyMemberFrame4"] = Bartender4:Merge({
		enabled = true,
		paddding =3,
		position={
			x = 92,
			y = 10,
			point="LEFT"
		},

	}, Bartender4.UnitBar.defaults),
	-- ["WatchFrame"] = Bartender4:Merge({
		-- enabled = true,
		-- paddding =5,
		-- position={
			-- x = -259,
			-- y = 142,
			-- point="RIGHT"
		-- },
	-- }, Bartender4.UnitBar.defaults),
	["CastingBarFrame"] = Bartender4:Merge({
		enabled = true,
		paddding =10,
		position={
			x = 4,
			y = 127,
			point="BOTTOM"
		},
	}, Bartender4.UnitBar.defaults),

}

local defaults = {
	profile = {
		unitframes = ufdefault,
		chatframes ={
			ChatFrame1 = {
				height = 300,
				width = 400,
				position = {
					point = "BOTTOMLEFT",
					x = 20,
					y=100
				}
			},
			ChatFrame2 = {
				isDocked=true
			}
		}
	}
}

UnitFrames.frames= {
	PlayerFrame,
	TargetFrame,
	-- FocusFrame,
	BuffFrame,
	MinimapCluster,
	PartyMemberFrame1,
	PartyMemberFrame2,
	PartyMemberFrame3,
	PartyMemberFrame4,
	-- WatchFrame,
	CastingBarFrame
}

--option tables

function UnitFrames:OnInitialize()
	self.db = Bartender4.db:RegisterNamespace("UnitFrames", defaults)
	UnitBar = Bartender4.UnitBar
	-- UnitBar_MT = {__index = UnitBar}
	self.bars = self.bars or {}
end

function UnitFrames:ToggleModule()
	return
end

-- local function __SaveChatFrameProfile(profile,chatFrame)
	-- if chatFrame:IsShown() then
		-- profile.chatframes[chatFrame:GetName()]={
			-- height = chatFrame:GetHeight(),
			-- width = chatFrame:GetWidth(),
			-- position = {
				-- point = chatFrame:GetPoint(),
				-- x = select(4,chatFrame:GetPoint()),
				-- y = select(5,chatFrame:GetPoint()),
			-- },
			-- isDocked = select(9,GetChatWindowInfo(chatFrame:GetID()))
		-- }
	-- end
-- end

-- function UnitFrames:OnSaveProfile(db,src)
	-- for i =1,10 do
		-- local chatFrame = _G["ChatFrame"..i]
		-- __SaveChatFrameProfile(self.db.profile,chatFrame)
	-- end
-- end

function UnitFrames:OnEnable()
	self.vehicle_frame = self.vehicle_frame or CreateFrame("Frame")
	-- self.vehicle_frame:RegisterEvent("UNIT_ENTERED_VEHICLE")
	-- self.vehicle_frame:SetScript("OnEvent",function()
		-- for i,frame in ipairs(self.frames) do
			-- frame.bar:Show()
		-- end
	-- end)
	-------------这里为加载移动窗体的地方。标示一下---------------------
	for i,frame in ipairs(self.frames) do
		--TODO: enabled?
		local config = self.db.profile.unitframes[frame:GetName()]
		if config.enabled then
			self.bars[i] = UnitBar:Create(frame,config,L[frame:GetName()])
			self.bars[i]:Enable()
		else
			-- print(frame:GetName(),"Not Creat")
		end
	end

	hooksecurefunc("SetCVar",function(key,val)
		if key == "uiscale" then
			self.db.profile.uiScale = val
		elseif key == "useUiScale" then
			self.db.profile.useUiScale = val
		end
	end)

	-- Bartender4.db.RegisterCallback(UnitFrames,"OnProfileCopied","OnSaveProfile")
	-- hooksecurefunc("FCF_SavePositionAndDimensions",function(chatFrame)
		-- __SaveChatFrameProfile(self.db.profile,chatFrame)
	-- end)

	self:ToggleOptions()
	self:ApplyConfig()
end

function UnitFrames:ApplyConfig()

	for _,bar in pairs(self.bars) do
		local config = self.db.profile.unitframes[bar.content:GetName()]
		if config.enabled then
			bar:ApplyConfig(config)
		end
	end

	if self.db.profile.uiScale and tonumber(self.db.profile.uiScale) then
		SetCVar("uiscale",self.db.profile.uiScale)
	else
		SetCVar("uiscale",1)
	end

	if self.db.profile.useUiScale and tonumber(self.db.profile.useUiScale)  then
		SetCVar("useUiScale",self.db.profile.useUiScale)
	else
		SetCVar("useUiScale",1)
	end

	-- for _name,_setting in pairs(self.db.profile.chatframes) do
		-- local bShow,bDocked
		-- bShow = _G[_name]:IsShown()--select(7,GetChatWindowInfo(_G[_name]:GetID()))--or _G[_name].isDocked;
		-- bDocked = _G[_name].isDocked

		-- if bShow and not bDocked then
			-- -- if  _setting.isDocked and _name~="ChatFrame1" then
			-- -- FCF_DockFrame(_G[_name],_G[_name]:GetID())
		-- -- else
			-- FloatingChatFrame_OnLoad(_G[_name])
			-- FCF_UnDockFrame(_G[_name])
			-- _G[_name]:SetHeight(_setting.height)
			-- _G[_name]:SetWidth(_setting.width)
			-- _G[_name]:ClearAllPoints()
			-- _G[_name]:SetPoint(_setting.position.point,
				-- UIParent,
				-- _setting.position.point,
				-- _setting.position.x,
				-- _setting.position.y)
			-- FCF_SavePositionAndDimensions(_G[_name])
		-- end
	-- end
end

BT4_UnitFrames = UnitFrames