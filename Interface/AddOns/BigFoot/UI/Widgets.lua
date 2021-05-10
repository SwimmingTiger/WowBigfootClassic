
------------------------
--- 2011 -03 -15 Terry@bf
-- 迁移一些UI相关的功能到这里
-- UI的独立控件也会放到这里
------------------------

--框体保存功能
local function roundUpFrameLocations(_id)
	local _val = BF_Frames_Config[_id]
	if _val then
	----------这里修改一个报错。point 为string 如何 floor----------------------
		BF_Frames_Config[_id].point = _val.point
		BF_Frames_Config[_id].refPoint = floor(_val.refPoint)
		BF_Frames_Config[_id].offX = floor(_val.offX)
		BF_Frames_Config[_id].offY = floor(_val.offY)
	end
end

function __BigFoot_Frame_Save(__frame, __id)
	if (__frame and __frame:IsVisible()) then
		BF_Frames_Config[__id]={};
		local point,region,refPoint,x,y = __frame:GetPoint(1)
		if not region or not region:GetName() then
			region = "UIParent"
		else
			region = region:GetName()
		end
		BF_Frames_Config[__id] = {};
		BF_Frames_Config[__id].point = point
		BF_Frames_Config[__id].region = region
		BF_Frames_Config[__id].refPoint = refPoint
		BF_Frames_Config[__id].offX = x
		BF_Frames_Config[__id].offY = y
		roundUpFrameLocations(__id)
	end
end

function __BigFoot_Frame_Load(__frame, __id)
	local point,region,refPoint,x,y
	if (__frame and BF_Frames_Config[__id]) then
		 point 	= BF_Frames_Config[__id].point
		 region	= BF_Frames_Config[__id].region
		 refPoint = BF_Frames_Config[__id].refPoint
		 x		= BF_Frames_Config[__id].offX
		 y		= BF_Frames_Config[__id].offY
		if not __frame:IsProtected() then
			__frame:ClearAllPoints();
			__frame:SetPoint(point, region, refPoint, x,y);
			__frame.__user_placed = true;
		else
			BFSecureCall(__frame.ClearAllPoints,__frame);
			BFSecureCall(__frame.SetPoint,__frame,point, region, refPoint, x,y);

			__frame.__user_placed = true;
		end
	end
end

function __BigFoot_Frame_StopMovingOrSizing(__self)
	if (__self.__originalStopMovingOrSizing) then
		__self.__originalStopMovingOrSizing(__self);
	end
	BigFoot_DelayCall(__BigFoot_Frame_Save, 1, __self, __self.__layout_id);
end

function RegisterForSaveFrame(__frame, __id, __no_load)
	assert(__frame ~= nil, "frame must be assigned.");
	assert(type(__frame) == "table", "RegisterForSaveFrame: the first parameter must be frame object.");

	if (not __id) then
		__id = __frame:GetName();
	end

	assert(__id ~= nil, "The frame has no name, can not be used as default id.");

	__frame.__layout_id = __id;

	if (not __frame.rfsf_hooked) then
		__frame.rfsf_hooked = true;
		__frame.__originalStopMovingOrSizing = __frame.StopMovingOrSizing;
		__frame.StopMovingOrSizing = __BigFoot_Frame_StopMovingOrSizing;
	end

	if (not __no_load) then
		roundUpFrameLocations(_id);
		__BigFoot_Frame_Load(__frame, __id);
	end
end

---鼠标提示功能
function BigFoot_Tooltip_Init()
	local __index = 1;
	while (true) do
		local __TextLeft = getglobal("BigFootTooltipTextLeft"..__index);
		local __TextRight = getglobal("BigFootTooltipTextRight"..__index);

		if (__TextLeft) then
			__TextLeft:SetText("");
		end

		if (__TextRight) then
			__TextRight:SetText("");
		end

		if (not __TextLeft and not __TextRight) then
			break;
		else
			__index = __index + 1;
		end
	end;

	BigFootTooltip:SetOwner(UIParent, "ANCHOR_NONE");
--	BigFootTooltip:SetPoint("TOPLEFT", "UIParent", "BOTTOMRIGHT", 5, -5);
	BigFootTooltip:SetText("BigFootTooltip");
	BigFootTooltip:Show();
end

function BigFoot_Tooltip_GetText(__tooltip, __newlinechar)
	if (not __tooltip) then
		__tooltip = BigFootTooltip;
	end

	if (not __newlinechar) then
		__newlinechar = "<n>";
	end

	local __strDesc = "";

	__tooltip:Show();

	local __index = 1;

	while (true) do
		local __TextLeft = getglobal(__tooltip:GetName().."TextLeft"..__index);
		local __TextRight = getglobal(__tooltip:GetName().."TextRight"..__index);

		local __strLeft;
		local __strRight;

		__strLeft = __TextLeft and __TextLeft:GetText();

		__strRight = __TextRight and __TextRight:GetText();

		local __strFull = "";

		if ( __index == 1 ) then
			if ( __strLeft == nil ) then
				return;
			end

			__strTitle = __strLeft;
		end

		if ( __strLeft == nil and __strRight == nil ) then
			__strFull = "";
		else
			if ( __strLeft == nil ) then
				__strLeft = "";
			end

			if ( __strRight == nil ) then
				__strRight = "";
			end

			if ( __strRight ~= "" ) then
				__strFull = __strLeft.."<t>"..__strRight;
			else
				__strFull = __strLeft;
			end
		end

		if ( __strFull ~= "" ) then
			__strDesc = __strDesc..__strFull..__newlinechar;
		end

		if (not __TextLeft and not __TextRight) then
			break;
		else
			__index = __index + 1;
		end
	end

	return __strDesc;
end

-- 新手提示功能
function BigFoot_ShowNewbieTooltip(__title, ...)
	if not __title then return end
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(__title, 1.0, 1.0, 1.0);
	local args = {...};
	local i;
	for i = 1, table.maxn(args), 1 do
		GameTooltip:AddLine(args[i], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1.0, 1);
	end
	GameTooltip:Show();
end

function BigFoot_HideNewbieTooltip()
	GameTooltip:Hide();
end

--[[ 无调用

--URL框体功能
function BigFoot_LaunchURL(__title, __url)
	BigFootURLFrameTitle:SetText("|cffffd100"..__title.."|r");
	BigFootURLFrameText:SetText(BF_URL_TEXT);

	-- Revise url to url encoding
	local __new_url = "";
	local __code;
	for __i = 1, string.len(__url), 1 do
		__code = string.byte(__url, __i);
		if (__code >= 128) then
			__new_url = __new_url .. string.format("%%%02X", __code);
		else
			__new_url = __new_url .. string.sub(__url, __i, __i);
		end
	end

	BigFootURLFrameURL.url = "bfurl:"..__new_url;

	BigFootURLFrameURL:SetText(BigFootURLFrameURL.url);

	BigFootURLFrame:Show();
end

--字体颜色
function BigFoot_SetTextColor(fontInstance, r, g, b, a)
	local __text = fontInstance:GetText();
	fontInstance:SetText(__text, r, g, b, a);
end

]]
