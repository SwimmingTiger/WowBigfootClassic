
local M = MerInspect;
local MerInspect_Enable = false;
M:RegisterEvent("ADDON_LOADED");

function M:ADDON_LOADED(name)
	if (name == "MerInspect") then	
		if not InspectFrame then return end
		self:CreateMainFrame();
		hooksecurefunc("InspectFrame_Show", function(unit)
			if (self.Config.MerInspectEnable and InspectFrame.unit) then
				self:DoQueue(InspectFrame.unit)				
			end
		end);
		self:UnregisterEvent("ADDON_LOADED")
	end
end
-- 考虑到玩家脱装备与穿装备时的运算量，该处不做处理。
function M:UNIT_INVENTORY_CHANGED(unit)
	if (self.Config.MerInspectEnable and (unit == "player" or unit == InspectFrame.unit)) then
		self:DisplayInvenrotyInfo(unit);
	end
end

function M:PLAYER_TARGET_CHANGED()
	if (self.Config.MerInspectEnable and InspectFrame:IsVisible()) then
		self:DoQueue(InspectFrame.unit)
	end
end

function M:CreateButton(buttonName, parentFrame, width, height, texture, TexCoords)
	local button = CreateFrame("Frame", buttonName, parentFrame or UIParent, "MagicResistanceFrameTemplate");
	
	button.texture = button:CreateTexture(nil, "BACKGROUND")	;
	button.texture:SetAllPoints(button);
	button.texture:SetTexture(texture);
	if TexCoords then
		button.texture:SetTexCoord(strsplit("|",TexCoords));
	end
	
	button.text = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
	button.text:SetPoint("BOTTOM", button, "BOTTOM", 0, 3);
	button.text:SetTextColor(1, 1, 1);
	button.text:SetText("0");
	
	return button;
end

function M:CreateFrame(frameName, parentFrame, width, height, textNum, textL, textY)
	local textNum = textNum or 1;
	local textL = textL or 0; local textY = textY or -1; 
	local frame = CreateFrame("Frame", frameName, parentFrame or UIParent);
	frame:SetWidth(width);  frame:SetHeight(height);
	frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 5, right = 5, top = 5, bottom = 5}});
	frame:SetBackdropBorderColor(0.6, 0.7, 0.8, 0.4);
	frame:SetBackdropColor(0.2, 0.3, 0.4, 0.6);
	
	frame.title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
	frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -4);
	frame.title:SetTextColor(0.6,0.8,0.2);

	for i = 1, textNum do
		frame["text"..i] = frame:CreateFontString(nil, "ARTWORK", "GameTooltipTextSmall");
		frame["text"..i]:SetPoint("TOPLEFT", frame["text"..(i-1)] or frame.title, "BOTTOMLEFT", (i == 1) and textL or 0, (i == 1) and -3 or textY);
		frame["text"..i]:SetTextColor(0.9,0.8,0.12);
		frame["stat"..i] = frame:CreateFontString(nil, "ARTWORK", "GameTooltipTextSmall");
		frame["stat"..i]:SetPoint("RIGHT", frame["text"..i], "LEFT", width - textL -14, 0);
		frame["stat"..i]:SetJustifyH("RIGHT");
		frame["stat"..i]:SetTextColor(0.9,0.9,0.9);
	end
	
	return frame
end

function M:CreateMainFrame()
	self.tooltip = CreateFrame("GameTooltip", "MerInspectTooltip", UIParent, "GameTooltipTemplate");
	
	--talent Frame
	local frame = self:CreateFrame("MerInspectTalent", InspectPaperDollFrame, 110, 56, 2, 32, 0);
	frame:SetPoint("TOPLEFT", InspectPaperDollFrame, "TOPLEFT", 184, -260);
	frame.icon1 = frame:CreateTexture(nil, "BORDER");
	frame.icon1:SetWidth(24) frame.icon1:SetHeight(24);
	frame.icon1:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
	frame.icon1:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT", 2, -2);
	frame.title:SetText(self.loc.talent);
	frame.text2:SetTextColor(0.9,0.9,0.9);

	--pvp Frame
	frame = self:CreateFrame("MerInspectPVP", InspectPaperDollFrame, 110, 68, 3, 2);
	frame:SetPoint("TOPLEFT", MerInspectTalent, "BOTTOMLEFT", 0, 2);
	frame.title:SetText("PVP:");
	
	--resistance	
	frame = CreateFrame("Frame", "MerInspectRES", InspectPaperDollFrame);
	frame:SetWidth(40); frame:SetHeight(1);
	frame:SetPoint("TOPRIGHT", InspectPaperDollFrame, "TOPLEFT", 297, -77);
	local texture = "Interface\\PaperDollInfoFrame\\UI-Character-ResistanceIcons"
	local TexCoords = {
		"0|1|0.2265625|0.33984375",
		"0|1|0|0.11328125",
		"0|1|0.11328125|0.2265625",
		"0|1|0.33984375|0.453125",
		"0|1|0.453125|0.56640625",}	
	local tooltip = {6, 2, 3, 4, 5};
	local formatText = string.gsub(RESISTANCE_TOOLTIP_SUBTEXT, "\n.+", "");
	
	for i = 1, 5 do
		frame["button"..i] = self:CreateButton("MerInspectRESbutton"..i, frame, 20, 20, texture, TexCoords[i])
		frame["button"..i].tooltip = getglobal("RESISTANCE" .. tooltip[i] .. "_NAME");
		frame["button"..i].tooltipSubtext = format(formatText, getglobal("RESISTANCE_TYPE" .. tooltip[i]));
		frame["button"..i]:SetPoint("TOPRIGHT", getglobal("MerInspectRESbutton" .. (i - 1)) or frame, "BOTTOMRIGHT", 0, -1);
	end
	--base effect
	frame = self:CreateFrame("MerInspectBase", InspectPaperDollFrame, 110, 122, 7, 4)
	frame:SetPoint("TOPLEFT", InspectPaperDollFrame, "TOPLEFT", 73, -260)
	frame.title:SetText(self.loc.base)
end

M:RegisterEvent("UNIT_INVENTORY_CHANGED");
	
function MerInspect_Toggle(switch)
	if (switch) then
		M.Config.MerInspectEnable = true;
		M:RegisterEvent("UNIT_INVENTORY_CHANGED");
		M:RegisterEvent("PLAYER_TARGET_CHANGED");
		M:RegisterEvent("INSPECT_TALENT_READY");
		M:RegisterEvent("INSPECT_HONOR_UPDATE")
		InspectModelFrame:SetHeight(215);		
		MerInspectTalent:Show();
		MerInspectPVP:Show();
		MerInspectRES:Show();	
		MerInspectBase:Show();		
	else
		M.Config.MerInspectEnable = false;
		M:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		M:UnregisterEvent("PLAYER_TARGET_CHANGED");
		M:UnregisterEvent("INSPECT_TALENT_READY");
		M:UnregisterEvent("INSPECT_HONOR_UPDATE")
		InspectModelFrame:SetHeight(300);
		InspectModelFrame:Show();
		MerInspectTalent:Hide();
		MerInspectPVP:Hide();
		MerInspectRES:Hide();
		MerInspectBase:Hide();
	end
end

function MerInspect_ToogleD(switch)
	if (switch) then
		M.Config.DisplayDurability = true;
		M.moneyFrame:Show();
		M.moneyFrame.title:Show();
	else
		M.Config.DisplayDurability = false;
		M.moneyFrame:Hide();
		M.moneyFrame.title:Hide();
	end
end

function MerInspect_ToogleH(switch)
	if (switch) then
		M.Config.DisplayItemQulity = true;
	else
		M.Config.DisplayItemQulity = false;
	end
end