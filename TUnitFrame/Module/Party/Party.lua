--[[
	Party.lua
	实例化 模板并装载到PartyFrame上
	调整位置，大小，以及样式
	以后可能提供设置
	Terry@bf
	2010 - 11 -5
	
]]


local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end 

local M = T:GetModule("Party",true) or T:NewModule("Party")
if not M then return end

M:SetDefaultModuleState(false)

local __3DPorTable = {}
local __InfoPaneTable = {}
local __CastBarTable = {}
local __ClassInfoTable = {}


----------------------------------
------ create templates
----------------------------------
--- local functions to setup 3d portrait
local function __Create3DPor()
	for i = 1, MAX_PARTY_MEMBERS do
		__3DPorTable[i] 	= T.Templates and T.Templates.ThreeDportrait and T.Templates.ThreeDportrait:new()
	end
end

local function __CreateClassIcon()
	for i = 1, MAX_PARTY_MEMBERS do
		__ClassInfoTable[i] 	=  T.Templates and T.Templates.ClassIcon and T.Templates.ClassIcon:new()
	end
end

--local functions to setup castbar
local function __CreateCastBar()
	for i = 1, MAX_PARTY_MEMBERS do
		__CastBarTable[i] 	= T.Templates and T.Templates.CastBar and T.Templates.CastBar:new()
	end
end

--local functions to create info pane
local function __CreateInfoPane()
	for i = 1, MAX_PARTY_MEMBERS do
		__InfoPaneTable[i] 	= T.Templates and T.Templates.InfoPane and T.Templates.InfoPane:new()
	end
end

----------------------------------
--- init templates
----------------------------------
local function __Init3DPor()
	for i = 1, MAX_PARTY_MEMBERS do
		__3DPorTable[i]:Create("Party"..i,_G["PartyMemberFrame"..i],_G["PartyMemberFrame"..i.."Portrait"])	
	end
end

local function __InitClassIcon()
	for i = 1, MAX_PARTY_MEMBERS do
		__ClassInfoTable[i]:Create(_G["PartyMemberFrame"..i],"party"..i)	
	end
end

local function __InitCastBar()
	for i = 1, MAX_PARTY_MEMBERS do		
		__CastBarTable[i]:Create("party"..i,_G["PartyMemberFrame"..i])
	end
end

local function __InitInfoPane()
	for i = 1, MAX_PARTY_MEMBERS do		
		__InfoPaneTable[i]:Create("Party",_G["PartyMemberFrame"..i],i)
	end
end

--------------------------------
---enable and disable templates
--------------------------------
local function __EnableClassIcon()
	for i = 1, MAX_PARTY_MEMBERS do
		__ClassInfoTable[i]:SetPoint("TOPLEFT",_G["PartyMemberFrame"..i],"TOPLEFT",53,10)
		__ClassInfoTable[i]:SetScale(0.6)
		__ClassInfoTable[i]:Enable()
	end
end

local function __DisableClassIcon()
	for i = 1, MAX_PARTY_MEMBERS do
		__ClassInfoTable[i]:Disable()
	end
end

local function __Enable3DPor()
	for i = 1, MAX_PARTY_MEMBERS do
		__3DPorTable[i]:SetPoint("TOPLEFT","PartyMemberFrame"..i, "TOPLEFT", 10, -9)
		__3DPorTable[i]:SetScale(0.65)
		__3DPorTable[i]:Enable()
	end
end

local function __Disable3DPor()
	for i = 1, MAX_PARTY_MEMBERS do
		__3DPorTable[i]:Disable()
	end
end

local function __EnableCastBar()
	for i = 1, MAX_PARTY_MEMBERS do
		assert(__InfoPaneTable[i],"Cast bar designed to hook on Info pane!")
		__CastBarTable[i]:SetPoint("TOPLEFT",__InfoPaneTable[i].infoPane,"TOPLEFT",5,-1.5)
		__CastBarTable[i]:SetSize(95,23)
		__CastBarTable[i]:EnableBorder(false)
		--need it here to adjust font size
		__CastBarTable[i]:SetScale(0.8)

		__CastBarTable[i].castbar:SetScript("OnShow",function()
			if __InfoPaneTable[i] then
				__InfoPaneTable[i]:SetAlpha(0)
			end
		end)
		
		__CastBarTable[i].castbar:HookScript("OnUpdate",function(bar)
			if not __InfoPaneTable[i] then return end
			if bar:GetAlpha()<1 then 
				__InfoPaneTable[i]:SetAlpha(0.8)
			else
				__InfoPaneTable[i]:SetAlpha(0)
			end
		end)
		
		__CastBarTable[i].castbar:SetScript("OnHide",function()
			if __InfoPaneTable[i] then
				__InfoPaneTable[i]:SetAlpha(1)
			end
		end)

		__CastBarTable[i]:Enable()		
	end
	T:Debug("PartyMember Castbar Enabled")	
end

local function __DisableCastBar()
	for i = 1, MAX_PARTY_MEMBERS do
		__CastBarTable[i]:Disable()
	end	
	T:Debug("PartyMember Castbar Disbled")	
end

local function __EnableInfoPane()
	for i = 1, MAX_PARTY_MEMBERS do
		_G["PartyMemberFrame"..i]:RegisterAnchorFrame(__InfoPaneTable[i].infoPane,8, "LEFT", "RIGHT", -13, 5, 81);
		__InfoPaneTable[i]:Enable()
		__InfoPaneTable[i]:SwitchInfoBar(true)
		__InfoPaneTable[i]:SwitchBarText(false)
	end	
end

local function __DisableInfoPane()
	for i = 1, MAX_PARTY_MEMBERS do
		_G["PartyMemberFrame"..i]:UnregisterAnchorFrame(__InfoPaneTable[i].infoPane)
		__InfoPaneTable[i]:SwitchInfoBar(false)
		__InfoPaneTable[i]:SwitchBarText(true)
	end	
end

local function __EnableColorizeText()
	for i = 1, MAX_PARTY_MEMBERS do
		__InfoPaneTable[i]:Enable()
		__InfoPaneTable[i]:SwitchColorize(true)
	end	
end

local function __DisableColorizeText()
	for i = 1, MAX_PARTY_MEMBERS do
		__InfoPaneTable[i]:SwitchColorize(false)
	end	
end

local function __EnableFormat()
	for i = 1, MAX_PARTY_MEMBERS do
		__InfoPaneTable[i]:Enable()
		__InfoPaneTable[i]:ToggleFormattedText(true)
	end	
end

local function __DisableFormat()
	for i = 1, MAX_PARTY_MEMBERS do
		__InfoPaneTable[i]:ToggleFormattedText(false)
	end	
end

------------------------
--- switches
------------------------
function M:ToggleInfoPane(flag)
	if flag then
		__EnableInfoPane()
	else
		__DisableInfoPane()
		__DisableCastBar()
	end
end

function M:ToggleColorize(flag)
	if flag then
		__EnableColorizeText()
	else
		__DisableColorizeText()
	end
end

function M:ToggleFormattedText(flag)
	if flag then
		__EnableFormat()		
	else
		__DisableFormat()
	end
end

function M:ToggleCastBar(flag)
	if flag then
		__EnableCastBar()
	else
		__DisableCastBar()
	end
end

function M:Toggle3DPor(flag)
	if flag then
		__Enable3DPor()
	else
		__Disable3DPor()
	end
end

function M:ToggleClass(flag)
	if flag then
		__EnableClassIcon()
	else
		__DisableClassIcon()
	end
end

-- initialize the module
function M:OnInitialize()
	__Create3DPor()
	__CreateCastBar()
	__CreateClassIcon()
	__CreateInfoPane()
	
	__Init3DPor()
	__InitCastBar()
	__InitClassIcon()
	__InitInfoPane()
	
	T:Debug("PartyMember Module Initialized")	
end