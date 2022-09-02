local Addon = LibStub("AceAddon-3.0"):GetAddon("BFClassMod")
if not Addon then return end

local A = Addon:NewModule("RuneFrame","AceEvent-3.0","AceHook-3.0","AceTimer-3.0")
if not A then return end

local runeFrame,header,bottomBar
local bottomFrame,bottomBar,runeBorde,bottomFrameBG

local L = {}
setmetatable(L,Addon.localMt)

if GetLocale()=='zhTW' then
	L["大脚符文条"] = "大腳符文條"
	L["使用滚轮缩放符文条"] = "使用滾輪縮放符文條"
	L["鼠标点击拖拽移动符文条"] = "鼠標點擊拖拽移動符文條"
	L["点击职业图标锁定/解锁符文条"] = "點擊職業圖標鎖定/解鎖符文條"
elseif GetLocale() =='enUS' then
	L["大脚符文条"] = "BigFoot RuneFrame"
	L["鼠标点击拖拽移动符文条"] = "Drag here to move Rune frame"
	L["使用滚轮缩放符文条"] = "Mouse wheel to zoom Rune frame in/out"
	L["点击职业图标锁定/解锁符文条"] = "Click on Class Icon to lock/unlock rune frame."
end

local default = {
	profile = {
		point = "CENTER",
		ref = "UIParent",
		refPoint = "CENTER",
		lock = false,
		x = 0,
		y = -30,
		scale = 1.8	
	}
}

local oldPoint
local powerText 

local db = {}

local function __OnHeaderEnter(frame)
	BigFoot_ShowNewbieTooltip(L["大脚符文条"],L["使用滚轮缩放符文条"],L["鼠标点击拖拽移动符文条"],L["点击职业图标锁定/解锁符文条"])
end

local function __OnHeaderLeave(frame)
	GameTooltip:Hide()
end

local function __OnHeaderDragStart(frame)
	if not db.lock then
		runeFrameParent:StartMoving()
	end
end

local function __OnHeaderDragStop(frame)
	runeFrameParent:StopMovingOrSizing() 
	db.point,db.ref,db.refPoint,db.x,db.y = runeFrameParent:GetPoint(1)
	if not db.ref then db.ref = UIParent end
	db.ref = db.ref:GetName()
end

local function __OnHeaderMouseWheel(frame,delta)
	if db.lock then return end
	if delta == 1 then
		if db.scale > 0.9 then
			db.scale = db.scale - 0.1
		end
	else
		if db.scale < 2 then
			db.scale = db.scale + 0.1
		end
	end
	runeFrameParent:SetScale(db.scale)
end

local function __OnHeaderClick()
	 A:ToggleHeader(db.lock)
end

--[[
local function __InitPowerText()
end
]]

local function __KillXperl()
	if XPerl_Player then
	
		runeFrame.runes = {}
		for i = 1, 6 do
			RuneFrame_AddRune (runeFrame, _G["RuneButtonIndividual"..i])

			_G["XPerl_RuneButtonIndividual"..i].oriShow = _G["XPerl_RuneButtonIndividual"..i].oriShow or _G["XPerl_RuneButtonIndividual"..i].Show
			_G["RuneButtonIndividual"..i].oriHide = _G["RuneButtonIndividual"..i].oriHide or _G["RuneButtonIndividual"..i].Hide
			_G["XPerl_RuneButtonIndividual"..i]:Hide()
			_G["RuneButtonIndividual"..i]:Show()			

			_G["XPerl_RuneButtonIndividual"..i].Show = function() end
			_G["RuneButtonIndividual"..i].Hide = function() end
		end
	end
end

local function __ReviveXperl()
	if XPerl_Player then
		runeFrame.runes = {}
		for i = 1, 6 do
			_G["XPerl_RuneButtonIndividual"..i].Show = _G["XPerl_RuneButtonIndividual"..i].oriShow or _G["XPerl_RuneButtonIndividual"..i].Show
			_G["RuneButtonIndividual"..i].Hide = _G["RuneButtonIndividual"..i].oriHide or _G["RuneButtonIndividual"..i].Hide

			RuneFrame_AddRune (runeFrame, _G["XPerl_RuneButtonIndividual"..i])

			_G["XPerl_RuneButtonIndividual"..i]:Show()

		end
	end
end

local function __AttachToHeader()
	oldPoint = oldPoint or {runeFrame:GetPoint(1)}
	if not oldPoint[2] then 
		oldPoint[2]= "UIParent";
	end
	-- runeFrame:SetScript("OnShow", nil) 
	runeFrame:SetParent(runeFrameParent)
	runeFrame:ClearAllPoints()
	runeFrame:SetPoint("BOTTOMLEFT",runeFrameParent,"BOTTOMLEFT") 
	runeFrame:Show()
	__KillXperl()
	
	runeFrameParent:Show()
	bottomBar:SetMinMaxValues(0, UnitManaMax("player")) 

end

local function __DetachFromHeader()
	runeFrame:SetParent(PlayerFrame)
	runeFrame:ClearAllPoints()
	runeFrame:SetPoint(unpack(oldPoint)) 
	runeFrame:SetScale(1)
	__ReviveXperl()
end

local function __OnUpdate()
	local power = UnitPower("player")
	powerText:SetText(power)
	bottomBar:SetValue(power)
end

function A:ToggleHeader(flag)
	if flag then
		db.lock = false
		header.classIcon:SetDesaturated(false) 
		header.classIcon:SetAlpha(1)
	else
		db.lock = true
		header.classIcon:SetDesaturated(true) 
		header.classIcon:SetAlpha(0.5)
	end
	BigFoot_SetModVariable("BigFootClassMod","UnlockRuneAnchorPoint",flag)
end

local function createBottom()
	
	runeFrameParent = CreateFrame("Frame","BFRuneFrame",UIParent)
	runeFrameParent:Hide()
	runeFrameParent:SetWidth(100)
	runeFrameParent:SetHeight(100)
	runeFrameParent:SetMovable(true)
	runeFrameParent:SetClampRectInsets(0, 25, -80, -20)
	runeFrameParent:SetClampedToScreen(true)
	
	-- 背景面板
	bottomFrame = CreateFrame("Button",runeFrameParent:GetName().."BottomFrame",runeFrameParent)
	bottomFrame:SetWidth(197)
	bottomFrame:SetHeight(50)
	bottomFrame:SetPoint("TOPLEFT",runeFrameParent,"BOTTOMLEFT",-2,12)
	bottomFrame:RegisterForDrag("LeftButton")
	bottomFrame:EnableMouseWheel(true)
	bottomFrame:SetFrameStrata("MEDIUM")
	bottomFrame:SetMovable(true)
	bottomFrame:SetHitRectInsets(0,72,0,22)
	local artwork = bottomFrame:CreateTexture(bottomFrame:GetName().."Artwork")
	artwork:SetTexture([[Interface\AddOns\BFClassMods\Media\bg]])
	artwork:SetAllPoints()
	artwork:Show()
	bottomFrame:SetScript("OnEnter",__OnHeaderEnter)
	bottomFrame:SetScript("OnLeave",__OnHeaderLeave)
	bottomFrame:SetScript("OnDragStart",__OnHeaderDragStart)
	bottomFrame:SetScript("OnDragStop",__OnHeaderDragStop)
	bottomFrame:SetScript("OnMouseWheel",__OnHeaderMouseWheel)
	bottomFrame:SetFrameLevel(2)

	-- 背景阴影
	bottomFrameBG = CreateFrame("Frame",runeFrameParent:GetName().."BottomFrameBG",runeFrameParent)
	bottomFrameBG:SetWidth(120)
	bottomFrameBG:SetHeight(25)	
	bottomFrameBG:SetFrameStrata("LOW")
	bottomFrameBG:SetPoint("TOPLEFT",runeFrameParent,"BOTTOMLEFT",2,10)
	local bottomBG = bottomFrameBG:CreateTexture(bottomFrameBG:GetName().."BG")
	bottomBG:SetTexture(0.0,0.0,0.0)
	bottomBG:SetAllPoints()
	bottomBG:Show()
	bottomFrameBG:SetAlpha(0.5)
	bottomFrameBG:SetFrameLevel(0)	
	
	-- 状态条
	bottomBar =  CreateFrame("StatusBar",runeFrameParent:GetName().."BottomBar",runeFrameParent,"TextStatusBar")
	bottomBar:SetPoint("TOPLEFT",runeFrameParent,"BOTTOMLEFT",13,0)
	bottomBar:SetWidth(110)
	bottomBar:SetHeight(15)
	bottomBar:SetStatusBarTexture([[Interface\AddOns\BFClassMods\Media\bar]])
	bottomBar:SetFrameLevel(1)
	bottomBar:SetFrameStrata("LOW")
	bottomBar:Show()
	
	-- 符文边框
	runeBorder = CreateFrame("Frame",runeFrameParent:GetName().."RuneBorder",runeFrameParent)
	runeBorder.texture = runeBorder:CreateTexture()
	runeBorder.texture:SetTexture([[Interface\AddOns\BFClassMods\Media\iconbox]])
	runeBorder.texture:SetAllPoints()
	runeBorder:SetWidth(197)
	runeBorder:SetHeight(47)
	runeBorder:SetPoint("BOTTOMLEFT",runeFrameParent,"BOTTOMLEFT",-5,-25)
	runeBorder:SetFrameLevel(6)
	runeBorder:Show()
	
	-- 开关按钮
	header = CreateFrame("Button","BFRuneHeader",runeFrameParent)
	header.classIcon = header:CreateTexture(nil, "OVERLAY");
	header:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]],"ADD")
	header.classIcon:SetAllPoints();
	header.classIcon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes");
	local coords = CLASS_BUTTONS.DEATHKNIGHT;
	header.classIcon:SetTexCoord(coords[1],coords[2],coords[3],coords[4]);
	header:SetWidth(13)
	header:SetHeight(13)	
	header:SetFrameStrata("MEDIUM")
	header:SetPoint("BOTTOMLEFT",runeFrameParent,"BOTTOMLEFT",0,-16)
	header:RegisterForDrag("LeftButton")
	header:EnableMouseWheel(true)
	header:SetScript("OnClick",__OnHeaderClick)
	header:SetScript("OnDragStart",__OnHeaderDragStart)
	header:SetScript("OnDragStop",__OnHeaderDragStop)
	header:SetScript("OnMouseWheel",__OnHeaderMouseWheel)
	header:SetScript("OnEnter",__OnHeaderEnter)
	header:SetScript("OnLeave",__OnHeaderLeave)
	header:SetFrameLevel(6)
	header:Show()
	
	--符能
	powerText = runeFrameParent:CreateFontString("BFRunePowerText","OVERLAY","NumberFont_Outline_Med")
	powerText:SetPoint("TOP",runeFrameParent,"BOTTOM",12,7)
	powerText:SetTextColor(0.9,0.9,0.9)
	powerText:SetJustifyH("CENTER")
	powerText:SetWidth(100)
	powerText:SetHeight(28)
	powerText:SetTextHeight(10)
	powerText:Show()
end

local function showBottom()
	for i = 1, 6 do
		local runeButton = _G["RuneButtonIndividual"..i]
		runeButton:SetParent(bottomFrame)
		runeButton:SetFrameStrata("BACKGROUND")
		runeButton:RegisterForDrag("LeftButton")
		runeButton:EnableMouseWheel(true)
		runeButton:SetScript("OnDragStart",__OnHeaderDragStart)
		runeButton:SetScript("OnDragStop",__OnHeaderDragStop)
		runeButton:SetScript("OnMouseWheel",__OnHeaderMouseWheel)
		_G["RuneButtonIndividual"..i]:SetFrameStrata("MEDIUM");
		_G["RuneButtonIndividual"..i.."Border"]:Hide()
		_G["RuneButtonIndividual"..i.."ShineTexture"]:SetWidth(30)
		_G["RuneButtonIndividual"..i.."ShineTexture"]:SetHeight(17)
		-- _G["RuneButtonIndividual"..i.."Cooldown"]:SetParent(bottomFrame)
		_G["RuneButtonIndividual"..i.."Cooldown"]:SetWidth(16)
		_G["RuneButtonIndividual"..i.."Cooldown"]:SetHeight(16)
	end
	runeFrameParent:Show()
	runeFrameParent:SetScale(db.scale)
	A:ToggleHeader(db.lock)
end

local function hideBottom()
	for i = 1, 6 do
		local runeButton = _G["RuneButtonIndividual"..i]
		_G["RuneButtonIndividual"..i]:SetParent(runeFrame)
		_G["RuneButtonIndividual"..i]:SetFrameStrata("BACKGROUND")
		_G["RuneButtonIndividual"..i.."Border"]:Show()
		runeButton:SetScript("OnDragStart",function() end)
		runeButton:SetScript("OnDragStop",function() end)
		runeButton:SetScript("OnMouseWheel",function() end)
		_G["RuneButtonIndividual"..i.."ShineTexture"]:SetWidth(60)
		_G["RuneButtonIndividual"..i.."ShineTexture"]:SetHeight(35)
		_G["RuneButtonIndividual"..i.."Cooldown"]:SetParent(_G["RuneButtonIndividual"..i])
		_G["RuneButtonIndividual"..i.."Cooldown"]:SetWidth(15)
		_G["RuneButtonIndividual"..i.."Cooldown"]:SetHeight(15)
	end
	runeFrameParent:Hide()
end

function A:ACTIVE_TALENT_GROUP_CHANGED()
	BigFoot_DelayCall(function()
		bottomBar:SetMinMaxValues(0, UnitManaMax("player")) 
	end,2)
end

function A:OnInitialize()
	runeFrame = _G.RuneFrame
	self.db = LibStub("AceDB-3.0"):New("BFRuneFrame_Config",default)
	db = self.db.profile
	createBottom()
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
end

function A:UnitFrame_SetUnit(frame, unit, healthbar, manabar)
	if frame == PetFrame and unit =='player' then
		runeFrameParent:Hide()
	end
	if frame == PlayerFrame and unit =='player' then
		self:ScheduleTimer(__AttachToHeader,0.5)
	end
end

function A:OnEnable()
	runeFrameParent:SetPoint(db.point,_G[db.ref],db.refPoint,db.x,db.y)
	showBottom()
	__AttachToHeader()
	runeFrameParent:HookScript("OnUpdate",function(frame,elapsed)
		if not frame.time then frame.time = 0 end
		frame.time = frame.time + elapsed
		if frame.time < 0.2 then return end
		__OnUpdate()
	end)
	self:SecureHook("UnitFrame_SetUnit")
end

function A:OnDisable()
	__DetachFromHeader()
	hideBottom()
end

