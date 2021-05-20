local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale("Spy")
local _

function Spy:CreateFrame(Name, Title, Height, Width, ShowFunc, HideFunc)
	local theFrame = CreateFrame("Frame", Name, UIParent)

	theFrame:ClearAllPoints()
	theFrame:SetPoint("CENTER", UIParent)
	theFrame:SetHeight(Height)
	theFrame:SetWidth(Width)
	theFrame:EnableMouse(true)
	theFrame:SetMovable(true)
	theFrame:SetScript("OnMouseDown", function(self, event) 
		if (((not self.isLocked) or (self.isLocked == 0)) and (event == "LeftButton")) then
			Spy:SetWindowTop(self)
			self:StartMoving();
			self.isMoving = true;
		end
	end)
	theFrame:SetScript("OnMouseUp", function(self) 
		if (self.isMoving) then
			self:StopMovingOrSizing();
			self.isMoving = false;
			Spy:SaveMainWindowPosition()
		end
	end)
	theFrame.ShowFunc = ShowFunc
	theFrame:SetScript("OnShow", function(self)
		Spy:SetWindowTop(self)
		if (self.ShowFunc) then
			self:ShowFunc()
		end
	end)
	theFrame.HideFunc = HideFunc
	theFrame:SetScript("OnHide", function(self) 
		if (self.isMoving) then
			self:StopMovingOrSizing();
			self.isMoving = false;
		end
		if (self.HideFunc) then
			self:HideFunc()
		end
	end)	
	
	theFrame.Background = theFrame:CreateTexture(nil, "BACKGROUND")	
	theFrame.Background:ClearAllPoints()
	theFrame.Background:SetTexture("Interface\\CHARACTERFRAME\\UI-Party-Background")
	if not Spy.db.profile.InvertSpy then
		theFrame.Background:SetPoint("TOPLEFT", theFrame, "TOPLEFT", 0, -32)
		theFrame.Background:SetPoint("BOTTOMRIGHT", theFrame, "BOTTOMRIGHT", 0, 2)	
	else
		theFrame.Background:SetPoint("TOPLEFT", theFrame, "TOPLEFT", 0, -34)
		theFrame.Background:SetPoint("BOTTOMRIGHT", theFrame, "BOTTOMRIGHT", 0, 0)		
	end
	theFrame.Background:SetHeight(Height)
	theFrame.Background:SetWidth(Width)	
	theFrame.Background:SetAlpha(1)

	if Name == "Spy_MainWindow" then
		Spy.Colors:RegisterBorder("Window", "Title", theFrame)
		Spy.Colors:RegisterBackground("Window", "Background", theFrame)
	else
		Spy.Colors:RegisterBorder("Other Windows", "Title", theFrame)
		Spy.Colors:RegisterBackground("Other Windows", "Background", theFrame)
	end

	theFrame.TitleBar = CreateFrame("Frame", "TestFrame", theFrame)	
	theFrame.TitleBar:SetFrameStrata("BACKGROUND")
	if not Spy.db.profile.InvertSpy then	
		theFrame.TitleBar:SetPoint("TOPLEFT", theFrame, "TOPLEFT", 0, -11)
		theFrame.TitleBar:SetPoint("TOPRIGHT", theFrame, "TOPRIGHT", 0, -11)
	else
		theFrame.TitleBar:SetPoint("BOTTOMLEFT", theFrame, "BOTTOMLEFT", 0, -21)
		theFrame.TitleBar:SetPoint("BOTTOMRIGHT", theFrame, "BOTTOMRIGHT", 0, -21)
	end
	theFrame.TitleBar:SetHeight(22)
	theFrame.TitleBar:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 8,
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12,			
			insets = {left = 2, right = 2, top = 2, bottom = 2},			
		})
	theFrame.TitleBar:SetBackdropColor(0,0,0,1) 
	theFrame.TitleBar:SetBackdropBorderColor(1,1,1,1)

	theFrame.Title = theFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	if not Spy.db.profile.InvertSpy then 	
		theFrame.Title:SetPoint("TOPLEFT", theFrame, "TOPLEFT", 8, -16)
	else
		theFrame.Title:SetPoint("BOTTOMLEFT", theFrame, "BOTTOMLEFT", 8, -15)
	end	
	theFrame.Title:SetJustifyH("LEFT")
	theFrame.Title:SetTextColor(1.0, 1.0, 1.0, 1.0)
	theFrame.Title:SetText(Title)
	theFrame.Title:SetHeight(Spy.db.profile.MainWindow.TextHeight)
	Spy:AddFontString(theFrame.Title)

	if Name == "Spy_MainWindow" then
		Spy.Colors:UnregisterItem(theFrame.Title)
		Spy.Colors:RegisterFont("Window", "Title Text", theFrame.Title)
	else
		Spy.Colors:UnregisterItem(theFrame.Title)
		Spy.Colors:RegisterFont("Other Windows", "Title Text", theFrame.Title)
	end

	theFrame.CloseButton = CreateFrame("Button", nil, theFrame)
	theFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up.blp")
	theFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down.blp")
	theFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	theFrame.CloseButton:SetWidth(20)
	theFrame.CloseButton:SetHeight(20)
	if not Spy.db.profile.InvertSpy then 	
		theFrame.CloseButton:SetPoint("TOPRIGHT", theFrame, "TOPRIGHT", -4, -12)
	else
		theFrame.CloseButton:SetPoint("BOTTOMRIGHT", theFrame, "BOTTOMRIGHT", -4, -19)
	end		
	theFrame.CloseButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(L["Close"], 1, 0.82, 0, 1)
		GameTooltip:AddLine(L["CloseDescription"],0,0,0,1)
		GameTooltip:Show()
	end)
	theFrame.CloseButton:SetScript("OnLeave", function(self)
		GameTooltip:Hide() 
	end)
	theFrame.CloseButton:SetScript("OnClick", function(self)
		self:GetParent():Hide()
	end)

	return theFrame
end
