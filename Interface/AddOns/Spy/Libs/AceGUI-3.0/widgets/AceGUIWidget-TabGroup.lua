local AceGUI = LibStub("AceGUI-3.0")

-------------
-- Widgets --
-------------
--[[
	Widgets must provide the following functions
		Acquire() - Called when the object is aquired, should set everything to a default hidden state
		Release() - Called when the object is Released, should remove any anchors and hide the Widget
		
	And the following members
		frame - the frame or derivitive object that will be treated as the widget for size and anchoring purposes
		type - the type of the object, same as the name given to :RegisterWidget()
		
	Widgets contain a table called userdata, this is a safe place to store data associated with the wigdet
	It will be cleared automatically when a widget is released
	Placing values directly into a widget object should be avoided
	
	If the Widget can act as a container for other Widgets the following
		content - frame or derivitive that children will be anchored to
		
	The Widget can supply the following Optional Members


]]

--------------------------
-- Tab Group            --
--------------------------

do
	local Type = "TabGroup"
	local Version = 15

	local PaneBackdrop  = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 3, right = 3, top = 5, bottom = 3 }
	}
	
	local function OnAcquire(self)

	end
	
	local function OnRelease(self)
		self.frame:ClearAllPoints()
		self.frame:Hide()
		self.status = nil
		for k in pairs(self.localstatus) do
			self.localstatus[k] = nil
		end
		self.tablist = nil
	end
	
	local function Tab_SetText(self, text)
		self:_SetText(text)
		PanelTemplates_TabResize(self, 0)
	end
	
	local function UpdateTabLook(self)
		if self.disabled then
			PanelTemplates_SetDisabledTabState(self)
		elseif self.selected then
			PanelTemplates_SelectTab(self)
		else
			PanelTemplates_DeselectTab(self)
		end
	end
	
	local function Tab_SetSelected(self, selected)
		self.selected = selected
		UpdateTabLook(self)
	end
	
	local function Tab_OnClick(self)
		if not (self.selected or self.disabled) then
			self.obj:SelectTab(self.value)
		end
	end
	
	local function Tab_SetDisabled(self, disabled)
		self.disabled = disabled
		UpdateTabLook(self)
	end
	
	local function Tab_OnEnter(this)
		local self = this.obj
		self:Fire("OnTabEnter", self.tabs[this.id].value, this)
	end
	
	local function Tab_OnLeave(this)
		local self = this.obj
		self:Fire("OnTabLeave", self.tabs[this.id].value, this)
	end
	
	local function CreateTab(self, id)
		local tabname = "AceGUITabGroup"..self.num.."Tab"..id
		local tab = CreateFrame("Button",tabname,self.border,"OptionsFrameTabButtonTemplate")
		tab.obj = self
		tab.id = id
		
		tab:SetScript("OnClick",Tab_OnClick)
		tab:SetScript("OnEnter",Tab_OnEnter)
		tab:SetScript("OnLeave",Tab_OnLeave)
		
		tab._SetText = tab.SetText
		tab.SetText = Tab_SetText
		tab.SetSelected = Tab_SetSelected
		tab.SetDisabled = Tab_SetDisabled
		
		return tab
	end
	
	local function SetTitle(self, text)
		self.titletext:SetText(text or "")
	end
	
	-- called to set an external table to store status in
	local function SetStatusTable(self, status)
		assert(type(status) == "table")
		self.status = status
	end
	
	local function SelectTab(self, value)
		local status = self.status or self.localstatus

		local found
		for i, v in ipairs(self.tabs) do
			if v.value == value then
				v:SetSelected(true)
				found = true
			else
				v:SetSelected(false)	
			end
		end
		status.selected = value
		if found then
			self:Fire("OnGroupSelected",value)
		end
	end
		
	local function SetTabs(self, tabs)
		self.tablist = tabs
		self:BuildTabs()
	end
	

	local widths = {}
	local rowwidths = {}
	local rowends = {}		
	local function BuildTabs(self)
		local status = self.status or self.localstatus
		local tablist = self.tablist
		
		local tabs = self.tabs
		
		for i, v in ipairs(tabs) do
			v:Hide()
		end
		if not tablist then return end

		
		local width = self.frame.width or self.frame:GetWidth() or 0
		
		for i = #widths, 1, -1 do 
			widths[i] = nil 
		end
		for i = #rowwidths, 1, -1 do
			rowwidths[i] = nil 
		end
		for i = #rowends, 1, -1 do 
			rowends[i] = nil 
		end
		
		--Place Text into tabs and get thier initial width
		for i, v in ipairs(tablist) do
			local tab = tabs[i]
			if not tab then
				tab = self:CreateTab(i)
				tabs[i] = tab
			end
		
			tab:Show()
			tab:SetText(v.text)
			tab:SetDisabled(v.disabled)
			tab.value = v.value
			
			widths[i] = tab:GetWidth() - 10 --tabs are anchored 10 pixels from the right side of the previous one to reduce spacing
		end
		
		--First pass, find the minimum number of rows needed to hold all tabs and the initial tab layout
		local numtabs = #tablist
		local numrows = 1
		local usedwidth = 0

		for i = 1, #tablist do
			--If this is not the first tab of a row and there isn't room for it
			if usedwidth ~= 0 and (width - usedwidth - widths[i]) < 0 then
				rowwidths[numrows] = usedwidth + 10 --first tab in each row takes up an extra 10px
				rowends[numrows] = i - 1
				numrows = numrows + 1
				usedwidth = 0		
			end
			usedwidth = usedwidth + widths[i]
		end
		rowwidths[numrows] = usedwidth + 10 --first tab in each row takes up an extra 10px
		rowends[numrows] = #tablist
		
		--Fix for single tabs being left on the last row, move a tab from the row above if applicable
		if numrows > 1 then
			--if the last row has only one tab
			if rowends[numrows-1] == numtabs-1 then
				--if there are more than 2 tabs in the 2nd last row
				if (numrows == 2 and rowends[numrows-1] > 2) or (rowends[numrows] - rowends[numrows-1] > 2) then
					--move 1 tab from the second last row to the last
					rowends[numrows-1] = rowends[numrows-1] - 1
					rowwidths[numrows] = rowwidths[numrows] + widths[numtabs-1]
					rowwidths[numrows-1] = rowwidths[numrows-1] - widths[numtabs-1]
				end
			end
		end

		--anchor the rows as defined and resize tabs to fill thier row
		local starttab = 1
		for row, endtab in ipairs(rowends) do
			local first = true
			for tabno = starttab, endtab do
				local tab = tabs[tabno]
				tab:ClearAllPoints()
				if first then
					tab:SetPoint("TOPLEFT",self.frame,"TOPLEFT",0,-7-(row-1)*20 )
					first = false
				else
					tab:SetPoint("LEFT",tabs[tabno-1],"RIGHT",-10,0)
				end
			end
			--equal padding for each tab to fill the available width
			local padding = (width - rowwidths[row]) / (endtab - starttab+1)
			for i = starttab, endtab do
				PanelTemplates_TabResize(tabs[i], padding)
			end
			starttab = endtab + 1
		end
		
		self.borderoffset = 10+((numrows)*20)
		self.border:SetPoint("TOPLEFT",self.frame,"TOPLEFT",3,-self.borderoffset)
	end
	
	local function BuildTabsOnUpdate(this)
		BuildTabs(this.obj)
		this:SetScript("OnUpdate", nil)
	end
	
	local function OnWidthSet(self, width)
		local content = self.content
		local contentwidth = width - 60
		if contentwidth < 0 then
			contentwidth = 0
		end
		content:SetWidth(contentwidth)
		content.width = contentwidth
		BuildTabs(self)
		self.frame:SetScript("OnUpdate", BuildTabsOnUpdate)
	end
	
	
	local function OnHeightSet(self, height)
		local content = self.content
		local contentheight = height - (self.borderoffset + 23)
		if contentheight < 0 then
			contentheight = 0
		end
		content:SetHeight(contentheight)
		content.height = contentheight
	end

	local function Constructor()
		local frame = CreateFrame("Frame",nil,UIParent)
		local self = {}
		self.type = Type
		
		self.num = AceGUI:GetNextWidgetNum(Type)

		self.localstatus = {}
		
		self.OnRelease = OnRelease
		self.OnAcquire = OnAcquire
		self.SetTitle = SetTitle
		self.CreateTab = CreateTab
		self.SelectTab = SelectTab
		self.BuildTabs = BuildTabs
		self.SetStatusTable = SetStatusTable
		self.SetTabs = SetTabs
		self.frame = frame
		
		self.OnWidthSet = OnWidthSet
		self.OnHeightSet = OnHeightSet

		frame.obj = self
		
		frame:SetHeight(100)
		frame:SetWidth(100)
		frame:SetFrameStrata("FULLSCREEN_DIALOG")
		
		local titletext = frame:CreateFontString(nil,"OVERLAY","GameFontNormal")
		titletext:SetPoint("TOPLEFT",frame,"TOPLEFT",14,0)
		titletext:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-14,0)
		titletext:SetJustifyH("LEFT")
		titletext:SetHeight(18)
		
		self.titletext = titletext	
		
		local border = CreateFrame("Frame",nil,frame)
		self.border = border
		self.borderoffset = 27
		border:SetPoint("TOPLEFT",frame,"TOPLEFT",3,-27)
		border:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-3,3)
		
		border:SetBackdrop(PaneBackdrop)
		border:SetBackdropColor(0.1,0.1,0.1,0.5)
		border:SetBackdropBorderColor(0.4,0.4,0.4)
		
		self.tabs = {}
		
		--Container Support
		local content = CreateFrame("Frame",nil,border)
		self.content = content
		content.obj = self
		content:SetPoint("TOPLEFT",border,"TOPLEFT",10,-10)
		content:SetPoint("BOTTOMRIGHT",border,"BOTTOMRIGHT",-10,10)
		
		AceGUI:RegisterAsContainer(self)
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
