
local M = LibStub("AceAddon-3.0"):NewAddon("MBB","AceEvent-3.0","AceTimer-3.0","AceHook-3.0")
if not M then return end

local db
local launcher
local panelBottomFrames = {}
local panelBottomFrames2 = {}
local L = LibStub("AceLocale-3.0"):GetLocale("MBB");
local LDB = LibStub("LibDataBroker-1.1", true);

local ignored = {
	["MiniMapTrackingFrame"]=true,
	["MiniMapMeetingStoneFrame"]=true,
	["MiniMapMailFrame"]=true,
	["MiniMapBattlefieldFrame"]=true,
	["MiniMapWorldMapButton"]=true,
	["MiniMapPing"]=true,
	["MinimapBackdrop"]=true,
	["MinimapZoomIn"]=true,
	["MinimapZoomOut"]=true,
	["BookOfTracksFrame"]=true,
	["GatherNote"]=true,
	["FishingExtravaganzaMini"]=true,
	["MiniNotePOI"]=true,
	["RecipeRadarMinimapIcon"]=true,
	["FWGMinimapPOI"]=true,
	["CartographerNotesPOI"]=true,
	["MBB_MinimapButtonFrame"]=true,
	["EnhancedFrameMinimapButton"]=true,
	["GFW_TrackMenuFrame"]=true,
	["GFW_TrackMenuButton"]=true,
	["TDial_TrackingIcon"]=true,
	["TDial_TrackButton"]=true,
	["MiniMapTracking"]=true,
	["GatherMatePin"]=true,
	["HandyNotesPin"] = true,
	["TimeManagerClockButton"] = true,
	["GameTimeFrame"] = true,
	["DA_Minimap"] = true,
	["ElvConfigToggle"] = true,
	["TimeManagerClockButton"]=true,
	["GatherMate"] = true,
	["MiniMapLFGFrame"] = true,
	["MiniMapVoiceChatFrame"] = true,
	["QueueStatusMinimapButton"] = true,
	["MinimapZoneTextButton"] = true,
	["BFGPSButton"]=true,
	["GuildInstanceDifficulty"]=true,
	["GatherArchNote"]=true,
	["ZGVMarker"]=true,
	["QuestPointerPOI"] = true,
	["LibDBIcon10_bfModelChange"] = true,
	["LibDBIcon10_HandyNotes_NPCs"] = true,
}

local options = {
	profile = {
		enabled = true,
		enablemousetip = true,
		enablemouseover = false,
		itemperline = 4,
		excludes = {
			['BigFootMinimapButton'] = true,
			['GameTimeFrame'] = true,
			["MiniMapVoiceChatFrame"] = true,
			["MiniMapWorldMapButton"] = true
		},

		MiniMap =
		{
			hide = false,
			minimapPos = 192,
			radius = 80,
		}
	},
}

local function Obj(button)
	local obj
	if type(button)=='string' then
		obj = _G[button]
	elseif type(button)=='table' then
		obj = button
	end
	return obj
end

local function Name(button)
	local name
	if type(button)=='string' then
		name = button
	elseif type(button)=='table' then
		name = button:GetName()
	end
	return name
end

local function IsParent(parent, child)
	if not child then return false end
	if parent == child then return true end
	if child == UIParent then return false end
	return IsParent(parent,child:GetParent())
end

local function IsButtonExcluded(button)
	local name = Name(button)
	local excluded = db.excludes
	if not excluded then return end
	return excluded[name]
end

local function IsButtonIgnored(button)
	if Name(button)==M.realIcon:GetName() then return true end
	if  ignored[Name(button)] then return true end
	for ignoreName in pairs(ignored) do
		if Name(button):find(ignoreName) then return true end
	end
	return false
end

local function addButton(frame)
	local child = Obj(frame)
	if not child then return end
	if child.added then return end
	child.opoint = {child:GetPoint()};
	if( not child.opoint[1] ) then
		child.opoint = {"TOP", Minimap, "BOTTOM", 0, 0};
	end
	child.osize = child.osize or {child:GetHeight(),child:GetWidth()};
	child.oisshown = child:IsShown()

	M:RawHook(child,"ClearAllPoints",function() end,true)
	M:RawHook(child,"SetPoint",function() end,true)
	child:SetAlpha(1)
	M:RawHook(child,"SetAlpha",function(a,b)end,true)
	M.hooks[child].Hide(child)
	child.added  = true
	M.buttons[child] = true
	if not child.oldParent  then
		child.oldParent = child:GetParent()
		child.oldFrameLevel = child:GetFrameLevel()
	end
	child:SetParent(M.panel)
end

local function removeButton(frame)
	local child = Obj(frame)
	if not child then return end
	M:Unhook(child,"ClearAllPoints")
	M:Unhook(child,"SetPoint")
	M:Unhook(child,"SetAlpha")
	child:ClearAllPoints()
	child:SetPoint(unpack(child.opoint))
	child:SetHeight(child.osize[1])
	child:SetWidth(child.osize[2])
	if child.oisshown then
		M.hooks[child].Show(child)
	else
		M.hooks[child].Hide(child)
	end
	child.added = false
	M.buttons[child] = false
	if child.oldParent then
		child:SetParent(child.oldParent)
		child:SetFrameLevel(child.oldFrameLevel)
	end
end

local function doShowButtons()
	M:CancelTimer(M.hideTimer, true)
	M.hideTimer = nil
	M:CancelTimer(M.hideModTimer, true)
	M:showButtons()
end

local function doHideButtons()
	if not M.hideTimer then
		M.hideTimer = M:ScheduleTimer("hideButtons", 1,true)
	end
end

local function prepareModButton(child)
	local button;
	_G.MBB_ButtonAdd:Hide()
	_G.MBB_ButtonRemove:Hide()
	if IsButtonExcluded(child) then
		button = _G.MBB_ButtonAdd
		button:SetScript("OnClick",function(frame)
			addButton(frame.operator)
			db.excludes[Name(frame.operator)] = false
			frame:Hide()
		end)
		button:SetScript("OnLeave",function(frame) frame:Hide() end)
	else
		button = _G.MBB_ButtonRemove
		button:SetScript("OnEnter",function(frame)
			M:CancelTimer(M.hideModTimer, true)
		end)
		button:SetScript("OnClick",function(frame)
			removeButton(frame.operator)
			db.excludes[Name(frame.operator)] = true
			M:showButtons()
			frame:Hide()
		end)
		button:SetScript("OnLeave",function(frame)
			frame:Hide()
		end)
	end
	button.operator = child
	child.operant = button
	button:ClearAllPoints()
	button:SetParent(child)
	button:SetPoint("LEFT", child, "RIGHT", 0, 0);
	return button
end

function M:hideButtons(fade)
	self:CancelTimer(self.hideTimer, true)
	self.hideTimer = nil
	if fade and self.showed then
		local fadeInfo = {}
		fadeInfo.mode = "OUT";
		fadeInfo.timeToFade = 0.4;
		fadeInfo.startAlpha = 0.9;
		fadeInfo.endAlpha = 0;
		fadeInfo.finishedFunc = function ()  self.panel:Hide() end
		UIFrameFade(self.panel, fadeInfo);
	else
		self.panel:Hide()
	end
	self.showed  = false

--	for button,flag in pairs(M.buttons) do
--		if flag then
--			M.hooks[button].Hide(button)
--		end
--	end
end

function M:showButtons()
	self.showed  = true
	local lastButton,x,y
	local currentIndex = 0
	local itemperline = db.itemperline
	if itemperline ==0 then itemperline = 100 end

	for button,flag in pairs(self.buttons) do
		if flag and button.oisshown then
			self.hooks[button].ClearAllPoints(button)
			x ,y = currentIndex%itemperline, floor(currentIndex/itemperline)
			self.hooks[button].SetPoint(button,"TOPLEFT",self.panel,"TOPLEFT",(32+x*57),(-63-y*40))
			if db.keepsize then
				button:SetWidth(button.osize[2])
				button:SetHeight(button.osize[1])
			else
				button:SetWidth(32)
				button:SetHeight(32)
			end
			self.hooks[button].Show(button)
			lastButton = button;
			currentIndex = currentIndex + 1
		end
	end

	local anchorPanel = _G["MBBFrameBottomPanel1"]
	for i,frame in ipairs(panelBottomFrames) do
		x ,y = (i-1)%3, floor((i-1)/3)
		if frame then
			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT",anchorPanel,"TOPLEFT",(9 + x*80),(-5-y*24))
			frame:Show()
		end
	end
	local lines = ceil(#panelBottomFrames/3)
	anchorPanel:SetHeight(max(lines*24+2,26))

	lines = ceil(currentIndex/itemperline)
	local middleHeight = (max(lines*40+16,64))

	local anchorPanel2 = _G["MBBFrameBottomPanel2"]
	for i,frame in ipairs(panelBottomFrames2) do
		if frame then
			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT",anchorPanel2,"TOPLEFT",9,(-5-(i-1)*24))
			frame:Show()
		end
	end
	local lines2 = ceil(#panelBottomFrames2)
	anchorPanel2:SetHeight(max(lines2*24+2,26))

	anchorPanel:SetWidth(anchorPanel2:GetWidth())

	if self.panel then
		self.panel:ClearAllPoints()
		self.panel:SetPoint("TOPRIGHT",Minimap,"BOTTOMLEFT",-34,80)
		self.panel:SetHeight(anchorPanel:GetHeight() + anchorPanel2:GetHeight() + middleHeight + 60)
		self.panel:SetAlpha(0.9)
		self.panel:Show()
	end
end

function M:showModButton(child)
	local button = prepareModButton(child)
	button:Show();
end

function M:hideModButton(child)
	if child.operant then
		child.operant:Hide()
	end
end

local function toggleButtons()
	M:CancelTimer(M.hideTimer, true)
	M.hideTimer = nil
	M:CancelTimer(M.hideModTimer, true)
	if M.showed then
		M:hideButtons()
	else
		M:showButtons()
	end
end

local function createIcon()
	launcher = LDB:NewDataObject("MBB", {
		type = "launcher",
		icon = [[Interface\AddOns\BigFoot\Media\BigFootMiniButton]],
		OnClick = function(frame,button)
			if button =="RightButton" then
				BToggleDropDownMenu(1, nil, BigFootMiniButtonDropDown, frame:GetName(), 10, 3);
				PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
			elseif button=="LeftButton" then
				toggleButtons()
			end
		end,
		OnEnter = function()
			BigFoot_ShowNewbieTooltip(L["BigFoot Mini map"],L["Left click to open mini panel"],L["Right click to show dropdown menu"])
		end,
		OnLeave = function()
			BigFoot_HideNewbieTooltip()
			doHideButtons()
		end
	})
end

--old child script processing
local function onChildShow(button)
	button.oisshown = true
	--M.hooks[button].Show(button)
end

local function onChildHide(button)
	button.oisshown = false
	--M.hooks[button].Hide(button)
end

function M:onChildClick(frame,button)
end

function M:onChildMouseDown(frame,button)
end

function M:onChildMouseUp(frame,button)
end

function M:onChildLeave(frame)
	M.hideModTimer = M:ScheduleTimer("hideModButton",1,frame)
end

function M:onChildEnter(frame)
	M:CancelTimer(M.hideModTimer, true)
	if( IsControlKeyDown() ) then
		self:showModButton(frame)
	end
end

local function safeHook(obj,methodname,scriptname)
	if not obj:HasScript(methodname) then
		obj:SetScript(methodname,function() end)
	end
	if not M:IsHooked(obj,methodname) then
		M:HookScript(obj,methodname,scriptname)
	end
end

local function preparePanel(panel)
	panel:SetScript("OnUpdate",function(self,elapsed)
		local frame
		self.time = self.time or 0
		self.time = self.time + elapsed
		if self.time >= 0.5 then
			if self.inBound then return end
			if not M.showed then return end
			frame = GetMouseFocus()
			if frame and (IsParent(self,frame) or M.buttons[frame] or frame==M.realIcon) then
				doShowButtons()
			else
				doHideButtons()
			end
			self.time = 0
		end
	end)
	panel:SetScript("OnEnter",function(self)
		self.inBound = true
		if not M.showed then return end
		doShowButtons()
	end)
	panel:SetScript("OnLeave",function(self)
		self.inBound = false
	end)
end

local function prepareButton(name)
	local buttonframe = Obj(name)
	if not M:IsHooked(buttonframe,"Show") then M:RawHook(buttonframe,"Show",onChildShow,true) end
	if not M:IsHooked (buttonframe,"Hide") then M:RawHook(buttonframe,"Hide",onChildHide,true) end

	safeHook(buttonframe,"OnClick","onChildClick")
	safeHook(buttonframe,"OnMouseDown","onChildMouseDown")
	safeHook(buttonframe,"OnMouseUp","onChildMouseUp")
	safeHook(buttonframe,"OnLeave","onChildLeave")
	safeHook(buttonframe,"OnEnter","onChildEnter")
end

local function scanMiniChildren()
	local children = {Minimap:GetChildren()};
	local additional = {MinimapBackdrop:GetChildren()};
	for _,child in ipairs(additional) do
		table.insert(children, child);
	end
	for _, child in ipairs(children) do
		if( not child:HasScript("OnClick") ) then
			for _,subchild in ipairs({child:GetChildren()}) do
				if( subchild:HasScript("OnClick") ) then
					child = subchild;
					child.hasParentFrame = true;
					break;
				end
			end
		end
		if Name(child) and not IsButtonIgnored(child) then
			if child:IsObjectType("Button")  then
				prepareButton(child)
				if not IsButtonExcluded(child) then
					addButton(child)
				end
			end
		end
	end
end

function M:getDefaults()
	return options
end

function M:Refresh()
	if db.enabled then
		self:Enable()
	else
		self:Disable()
		self.icon:Hide("MBB")
	end
end

function M:OnInitialize()
	M.buttons = {}
	self.db = LibStub("AceDB-3.0"):New("MBBDB", self:getDefaults())
	db = self.db.profile
	createIcon()
	self.icon =self.icon or LDB and LibStub("LibDBIcon-1.0", true)
	self.icon:Register("MBB", launcher, self.db.profile.MiniMap)
	self:SetupOptions()
end

function M:OnEnable()
	self.icon:Show("MBB")
	self.panel = _G["MBBFrame"]
	M.realIcon = _G[M.icon.objects["MBB"]:GetName()]
	scanMiniChildren()
	self:ScheduleRepeatingTimer(scanMiniChildren,2)
	preparePanel(M.panel)
end

function M:OnDisable()
	self:CancelAllTimers()
	for button, flag in pairs(M.buttons) do
		if flag then
			removeButton(button)
		end
	end
	self.icon:Hide("MBB")
end

--------------------------
-- TODO: Add panel elements
-- panel related
function M:AddFrame(frame,...)
	frame:SetParent(self.panel)
	frame:SetPoint(...)
end

function M:AddBottomButton(frame)
	tinsert(panelBottomFrames,frame)
	frame:SetParent(_G[M.panel:GetName().."BottomPanel1"])
end

function M:AddBottomButton2(frame)
	tinsert(panelBottomFrames2,frame)
	frame:SetParent(_G[M.panel:GetName().."BottomPanel2"])
end

function M:removeignored(frame)
	if ignored[frame] then
		ignored[frame] = nil;
		scanMiniChildren();
	end
end

function M:addignored(frame)
	ignored[frame] = true;
	local obj = Obj(frame)
	removeButton(obj);
end

do
	local MBB = LibStub("AceAddon-3.0"):GetAddon("MBB");

	BigFoot_DelayCall(function()
		if GarrisonLandingPageMinimapButton then
			GarrisonLandingPageMinimapButton:RegisterForClicks("LeftButtonDown","RightButtonDown");		--注册左右键点击事件
			if BigFoot_SysTemSetTab.showGarrisonMinimapButton then		--按默认的打开
				MBB:addignored("GarrisonLandingPageMinimapButton");
			else
				MBB:removeignored("GarrisonLandingPageMinimapButton");
			end
			if GarrisonLandingPageMinimapButton:HasScript("OnClick") then
				local script = GarrisonLandingPageMinimapButton:GetScript("OnClick");
				GarrisonLandingPageMinimapButton:SetScript("OnClick", function(self,...)
					local button = ...
					if button == "RightButton" then		--按右键则变动图标位置
						BigFoot_SysTemSetTab.showGarrisonMinimapButton = not BigFoot_SysTemSetTab.showGarrisonMinimapButton;
						if BigFoot_SysTemSetTab.showGarrisonMinimapButton then
							MBB:addignored("GarrisonLandingPageMinimapButton");
						else
							MBB:removeignored("GarrisonLandingPageMinimapButton");
						end
					else
						if script then
							script(self, ...)
						end
					end
				end)
			end
			GarrisonLandingPageMinimapButton:HookScript("OnEnter", function()
				if BigFoot_SysTemSetTab.showGarrisonMinimapButton then
					GameTooltip:AddLine("右键隐藏到图标集合", 0, 1, 0);
				else
					GameTooltip:AddLine("右键显示到小地图", 0, 1, 0);
				end
				GameTooltip:Show();
			end)
		end
	end,5)
end
