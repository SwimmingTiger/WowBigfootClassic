
local B = LibStub("AceAddon-3.0"):NewAddon("BFGadgets")
if not B then return end
local L = LibStub("AceLocale-3.0"):GetLocale("BFGadgets")
B:SetDefaultModuleLibraries("AceEvent-3.0")
B:SetDefaultModuleState(false)

local M = B:NewModule("Coord")

local f
local i = BLibrary("BInfo", "chat", L["Map Note"]);

-- redeclare globals here
local CreateFrame = CreateFrame
local Minimap = Minimap
local MiniMapMailFrame = MiniMapMailFrame

local function ResetPos(frame)
	frame:ClearAllPoints();
	frame:SetPoint("TOPRIGHT",Minimap,"TOPRIGHT",25,-50)
	frame:StopMovingOrSizing();
end

local function CreateGPSFrame()
	f = CreateFrame("Button","BFGPSButton",Minimap)
	f:SetFrameStrata("HIGH")
	f:SetWidth(45)
	f:SetHeight(15)
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	ResetPos(f)

	f.bg = f:CreateTexture(f:GetName().."Border","BACKGROUND")
	f.bg:SetTexture([[Interface\AddOns\BFGadgets\res\gpsborder]])
	f.bg:SetTexCoord(0,0.75,0,0.375)
	f.bg:SetAllPoints(f)
	f.bg:Show()

	f.text = f:CreateFontString(f:GetName().."Text","ARTWORK")
	f.text:SetFont([[Fonts\FRIZQT__.TTF]],10)
	f.text:SetText("88,88")
	f.text:SetTextColor(1.0,0.82,0,1)
	f.text:SetPoint("CENTER",f,"CENTER",0,0)

	f.hl = f:CreateTexture()
	f.hl:SetTexture([[Interface\AddOns\BFGadgets\res\gpshilight]])
	f.hl:SetTexCoord(0,0.75,0,0.375)
	f.hl:SetAllPoints(f)
	f:SetHighlightTexture(f.hl,"ADD")
	RegisterForSaveFrame(f);

	f:Hide()

end

local function PushMailFrame(flag)
	if flag then
		MiniMapMailFrame:ClearAllPoints();
		MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 25, -60);
	else
		MiniMapMailFrame:ClearAllPoints();
		MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 21, -38);
	end
end

local function SaveCurrentToMapPlus()
	if ( MapPlus_AddNode and MapPlus_SetNode) then
		SetMapToCurrentZone();

		-- local __x, __y = GetPlayerMapPosition("player");
		local mapID, __x, __y
		mapID = C_Map.GetBestMapForUnit("player")
		local tempTable = C_Map.GetPlayerMapPosition(mapID, "player")
		__x, __y = tempTable.x, tempTable.y
		if not __x then return end
		local __mapFileName, __textureHeight = GetMapInfo();
		local __rx = WorldMapDetailFrame:GetWidth()*__x;
		local __ry = -WorldMapDetailFrame:GetHeight()*__y;
		__x = math.floor(__x*100+0.5);
		__y = math.floor(__y*100+0.5);
		local __index = MapPlus_AddNode(__mapFileName, __rx, __ry);
		local __number = 1;
		local __title = string.format(L["Node %d"], __index);
		if (__index and __number) then
			MapPlus_SetNode(__mapFileName, __index, "title", __title);
			MapPlus_SetNode(__mapFileName, __index, "note", "");
			MapPlus_SetNode(__mapFileName, __index, "type", __number);
			MapPlus_SetNode(__mapFileName, __index, "flash", 1);
			MapPlus_ShowNode(__mapFileName, __index);
			i:Print(string.format(L["%s has been set, the coordinate is (%d, %d)."], __title, __x, __y));
		end
	end
end

local function OnUpdate(frame,elapsed)
	frame.timer = (frame.timer or 0) + elapsed;
	if (frame.timer >= 1 and not WorldMapFrame:IsVisible()) then
		frame.timer = 0;

		-- local __x, __y = GetPlayerMapPosition("player");
		local mapID, __x, __y
		mapID = C_Map.GetBestMapForUnit("player")
		if not mapID then return end
		local tempTable = C_Map.GetPlayerMapPosition(mapID, "player")
		if not tempTable then return end
		__x, __y = tempTable.x, tempTable.y
		if not __x then return end

		__x = math.floor(__x*100+0.5);
		__y = math.floor(__y*100+0.5);

		f.text:SetText(string.format("%d,%d", __x, __y));

	end
end

local function OnEnter(frame)
	frame.text:SetTextColor(1.0, 1.0, 1.0);
	BigFoot_ShowNewbieTooltip(
		L["Coord Window"],
		L["Left click to move window.\nShift + Left click to set a mark.\nShift + Right click to reset position."]);
end

local function OnLeave(frame)
	frame.text:SetTextColor(1.0, 0.82, 0);
	BigFoot_HideNewbieTooltip();
end

local function OnMouseDown(frame,button)
	frame.text:SetPoint("CENTER", frame, "CENTER", -1, -1);
	if (IsShiftKeyDown())then
		if (button == "RightButton") then
			frame.text:SetPoint("CENTER", frame, "CENTER", 0, 0);
			ResetPos(frame);
		end
	else
		if (button == "LeftButton") then
			frame.text:SetPoint("CENTER", frame, "CENTER", 0, 0);
			frame:StartMoving();
			frame.moving = true;
		end
	end
end

local function OnMouseUp(frame,button)
	frame.text:SetPoint("CENTER", frame, "CENTER", 0, 0);
	if (not frame.moving and button == "LeftButton") then
		SaveCurrentToMapPlus()
	end
	if (frame.moving) then
		frame:StopMovingOrSizing();
		frame.moving = nil;
	end
end

local function nilFunc()

end

function M:ZONE_CHANGED_NEW_AREA()
	if IsInInstance() then
		f:Hide()
	else
		f:Show()
	end
end

function M:OnEnable()
	CreateGPSFrame()
	M:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	f:SetScript("OnUpdate",OnUpdate)
	f:SetScript("OnShow",SetMapToCurrentZone)
	f:SetScript("OnEnter",OnEnter)
	f:SetScript("OnLeave",OnLeave)
	f:SetScript("OnMouseDown",OnMouseDown)
	f:SetScript("OnMouseUp",OnMouseUp)
	f:Show()

	PushMailFrame(true)
end

function M:OnDisable()
	M:UnregisterEvent("ZONE_CHANGED_NEW_AREA")

	f:SetScript("OnUpdate",nilFunc)
	f:SetScript("OnShow",nilFunc)
	f:SetScript("OnEnter",nilFunc)
	f:SetScript("OnLeave",nilFunc)
	f:SetScript("OnMouseDown",nilFunc)
	f:SetScript("OnMouseUp",nilFunc)
	f:Hide()

	PushMailFrame(false)
end

--interface for current bigfoot switches
function BigFoot_EnableGPS(flag)
	if flag then
		M:Enable()
	else
		M:Disable()
	end
end

--TimeManagerClockButton:SetPoint("CENTER","Minimap","BOTTOM",0,-5)
--TimeManagerClockButton:SetWidth(70)
--TimeManagerClockButton:SetHeight(35)

--SpellTimerMainFrame:SetPoint("TOPLEFT","UIParent","BOTTOMRIGHT",-300,400)
