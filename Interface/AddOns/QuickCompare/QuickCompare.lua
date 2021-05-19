
local EnableCompareAchievement;
local isHooked;

-------------------
-- on hyperlink enter, show tooltip (alternative to ItemRef)
-------------------
local function AjustIconPos()
	local tooltip = getglobal("GameTooltip");
	if (not getglobal("GameTooltipTextLeft"..3):GetText()) then
		GameTooltipItemButton:ClearAllPoints();
		GameTooltipItemButton:SetPoint("TOPRIGHT",tooltip,"TOPLEFT",-1,-4);
		return;
	end
	GameTooltipItemButton:ClearAllPoints();
	GameTooltipItemButton:SetPoint("TOPRIGHT",tooltip,"TOPRIGHT",-6,-8);
	local maxWidth = 0;
	for i=1, 2, 1 do
		local text = getglobal("GameTooltipTextLeft"..i);
		maxWidth = text:GetWidth()>maxWidth and text:GetWidth() or maxWidth;
	end
	local gWidth = tooltip:GetWidth();
	if ((maxWidth+50) > gWidth) then
		tooltip:SetWidth(maxWidth+50);
	end
end

local function QuickCompare_Achievement(link,toolTip)
	if not EnableCompareAchievement then
		if BFItemRefTooltip and BFItemRefTooltip:IsShown() then
			BFItemRefTooltip:Hide();
		end
		return;
	end

	local _type,id,playGuid = strsplit(":", link)
	if ( _type == "achievement" ) then
		if BFItemRefTooltip and BFItemRefTooltip:IsShown() then
			BFItemRefTooltip:Hide();
		end
		local selfGuid = strsub(UnitGUID("player"),3);
		if playGuid == selfGuid then
			return;
		end
		if id and toolTip then
			local categoryID = GetAchievementCategory(id)
			if categoryID == 81 or categoryID == 15234 then return end				--光辉事迹及绝版类过滤掉
			if ( not BFItemRefTooltip:IsShown() ) then
				local height = toolTip:GetHeight()
				BFItemRefTooltip:SetParent(toolTip)
				BFItemRefTooltip:SetOwner(toolTip,"ANCHOR_BOTTOMRIGHT",0,height);
			end
			BFItemRefTooltip:SetHyperlink(GetAchievementLink(id));
		end
	end
end

local function ChatFrame_OnHyperlinkEnter(self, linkData, link)
	GameTooltip:SetOwner(self,"ANCHOR_TOPRIGHT");
	if strfind(linkData,"^item") or strfind(linkData,"^enchant") or strfind(linkData,"^achievement") or strfind(linkData,"^quest") or strfind(linkData,"^spell") or strfind(linkData,"^instancelock") then
		GameTooltip:SetHyperlink(linkData);
		GameTooltip:Show();
		if strfind(linkData,"^item") or strfind(linkData,"^enchant") then
			local _,_,_,_,_,_,_,_,_,icon=GetItemInfo(linkData);
			if icon then
				GameTooltipItemButtonIconTexture:SetTexture(icon);
				GameTooltipItemButton:Show();
			end
			AjustIconPos();
		elseif strfind(linkData,"^achievement") then
			QuickCompare_Achievement(linkData,GameTooltip)
		end
	end
end

local function ChatFrame_OnHyperlinkLeave()
	GameTooltipItemButtonIconTexture:SetTexture("");
	GameTooltipItemButton:Hide();
	GameTooltip:Hide();
end

function BF_ChatFrame_OnHyperlinkShow(self, link, text, button)
	QuickCompare_Achievement(link,ItemRefTooltip)
end

function QuickCompare_Toggle(switch,switch_Id)
	if switch_Id == 1 then
		if switch then
			SetCVar("alwaysCompareItems", "1")
		else
			SetCVar("alwaysCompareItems", "0")
		end
	elseif switch_Id == 2 then
		if (not isHooked) then
			hooksecurefunc("ChatFrame_OnHyperlinkShow", BF_ChatFrame_OnHyperlinkShow);
			isHooked = true;
		end

		if switch then
			EnableCompareAchievement = true;
			for i=1, NUM_CHAT_WINDOWS do
				local frame=getglobal("ChatFrame"..i);
				frame:SetScript("OnHyperlinkEnter", ChatFrame_OnHyperlinkEnter);
				frame:SetScript("OnHyperlinkLeave", ChatFrame_OnHyperlinkLeave);
			end
		else
			EnableCompareAchievement = nil;
			for i=1, NUM_CHAT_WINDOWS do
				local frame=getglobal("ChatFrame"..i);
				frame:SetScript("OnHyperlinkEnter",function() end);
				frame:SetScript("OnHyperlinkLeave",function() end);
			end
		end
	end
end
