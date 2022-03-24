--[[

	MonkeyLibrary:
	Common functions for the MonkeyMods
	
	Author:		Trentin

--]]

--[[

	This function extracts the ARGB values out of a colour encoded string.

	@param	strColour	the string with the colour info.
	
	@return		the alpha value
	@return		the red value
	@return		the green value
	@return		the blue value

--]]

-- make default font config-able, based on client locale
local locale = GetLocale()
local l
if (locale == "zhTW" or locale == "zhCN" or locale == "koKR") then 
	l = true
else
	l = false
end

-- to config font in xml
local MonkeyQuestMasterFont = CreateFont("MonkeyQuestMasterFont")
	MonkeyQuestMasterFont:SetShadowColor(0,0,0)
	MonkeyQuestMasterFont:SetShadowOffset(1,-1)

local MonkeyQuestFont = CreateFont("MonkeyQuestFont")
	MonkeyQuestFont:SetFontObject("MonkeyQuestMasterFont")
	MonkeyQuestFont:SetFont((l and STANDARD_TEXT_FONT) or "Interface\\AddOns\\MonkeyLibrary\\Fonts\\myriapsc.ttf", 12)
	
local MonkeyQuestFontWide = CreateFont("MonkeyQuestFontWide")
	MonkeyQuestFontWide:SetFontObject("MonkeyQuestMasterFont")
	MonkeyQuestFontWide:SetFont((l and STANDARD_TEXT_FONT) or "Interface\\AddOns\\MonkeyLibrary\\Fonts\\framd.ttf", l and 14 or 12)
	
local MonkeyQuestTitleFont = CreateFont("MonkeyQuestTitleFont")
	MonkeyQuestTitleFont:SetFontObject("MonkeyQuestMasterFont")
	MonkeyQuestTitleFont:SetFont((l and STANDARD_TEXT_FONT) or "Interface\\AddOns\\MonkeyLibrary\\Fonts\\adventure.ttf", 14)

function MonkeyLib_ColourStrToARGB(strColour)
	-- "|cFFFFFFFF"
	local i = 3;
	
	local iAlpha = tonumber(string.sub(strColour, i, i + 1), 16);
	local iRed = tonumber(string.sub(strColour, i + 2, i + 3), 16);
	local iGreen = tonumber(string.sub(strColour, i + 4, i + 5), 16);
	local iBlue = tonumber(string.sub(strColour, i + 6, i + 7), 16);
	
	iAlpha = iAlpha / 255;
	iRed = iRed / 255;
	iGreen = iGreen / 255;
	iBlue = iBlue / 255;
	
	--DEFAULT_CHAT_FRAME:AddMessage("A = "..iAlpha.." R = "..iRed.." G = "..iGreen.." B = "..iBlue);
	
	return iAlpha, iRed, iGreen, iBlue;
end

--[[

	This function converts ARGB values into a colour encoded string.

	@param		the alpha value
	@param		the red value
	@param		the green value
	@param		the blue value

	@return		the string colour encoded

--]]
function MonkeyLib_ARGBToColourStr(iAlpha, iRed, iGreen, iBlue)
	-- "|cFFFFFFFF"
	local strColour;

	-- floor it so it doesn't go over 255
	iAlpha = floor(iAlpha * 255);
	iRed = floor(iRed * 255);
	iGreen = floor(iGreen * 255);
	iBlue = floor(iBlue * 255);
	
	strColour = format("|c%2x%2x%2x%2x", iAlpha, iRed, iGreen, iBlue);

	return strColour;
end


function MonkeyLib_DebugMsg(strMsg)

	if (MONKEYLIB_DEBUG) then
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("MonkeyLib: " .. strMsg);
		end
	end
end