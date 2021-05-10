
--[[Ideas:
  Auctioning multiple items at once
  ...ace\AddOns\Blizzard_AuctionUI\Blizzard_AuctionUI.lua:1404: attempt to compare number with nil
]]

local HideBliz = {
    BrowseQualitySort,
    BrowseLevelSort,
    BrowseDurationSort,
    BrowseHighBidderSort,
    BrowseCurrentBidSort,
	BrowsePrevPageButton,
	BrowseNextPageButton,
	BrowseNameSort
};

--local AuctionTime = { "< 30分", "30分-2小时", "2小时-12小时", "超过12小时" };
local AuctionTime = { AUCTION_TIME_LEFT1, AUCTION_TIME_LEFT2, AUCTION_TIME_LEFT3, AUCTION_TIME_LEFT4 };
local None = NONE.."    "

local lastSortColumn, lastSortReverse; --可以2个排序同时生效的功能。
local SelectedItem,SearchParam,ScanPage;
local CurrentPage;
local SortReverse;
local BrowseDisplay = {};
local SearchDelay = 0;
local SortColumn = 6;

local ScanFrame = CreateFrame("Frame", nil, AuctionFrame);
ScanFrame:Hide();

local UpdateResults = CreateFrame("Frame", nil, AuctionFrame);
UpdateResults:Hide();

local ScrollBox, ScrollBar, Highlight;
local SearchResults = {};
local SearchItem;
local Text;

StaticPopupDialogs["AFFIRM_DISABLE_BA"] = {
	text = "若要重新启用 拍卖增强 请到插件管理里面启用",
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		AddonList_Enable("BaudAuction",false);
		ReloadUI();
	end,
	showAlert = true,
	timeout = 0,
	exclusive = true,
	hideOnEscape = true,
};

local function BaudAuctionToMoney(Money)
    Money = floor(Money);
    local text = "";
    if (Money % 100 > 0) and (Money < 100000) or (Money == 0) then
        text = format(COPPER_AMOUNT_TEXTURE, Money%100, 0, 0);
    end
    Money = floor(Money / 100);
    if (Money % 100 > 0) and (Money < 100000) then
        text = format(SILVER_AMOUNT_TEXTURE, Money%100, 0, 0) .. text;
    end
    Money = floor(Money / 100);
    if (Money > 0) then
        text = format(GOLD_AMOUNT_TEXTURE, Money, 0, 0) .. text;
    end
    return text;
end

local Columns = {
    {
        Name = NAME,
        Width = 174,
        Align = "LEFT",
        Display = function()
            Text = "|c"..select(4, GetItemQualityColor(SearchItem[4])) .. (SearchItem[1] or "Unknown");
            if (SearchItem[3] > 1) then
                Text = SearchItem[3] .. " " .. Text;
            end
            return Text;
        end,
        Sort = 1
    },
    {
        Name = LEVEL_ABBR,
        Width = 22,
        Align = "LEFT",
        Display = function()
            return SearchItem[6];
        end,
        Sort = 6
    },
    {
        Name = CLOSES_IN,
        Width = 62,
        Align = "CENTER",
        OnEnter = function(self)
            local item = SearchResults[self:GetParent().Index];
            if item then
                GameTooltip:SetOwner(self)
                GameTooltip:SetText(_G["AUCTION_TIME_LEFT".. item[13].."_DETAIL"]);
                GameTooltip:Show();
            end
        end,
        OnLeave = function() GameTooltip:Hide() end,
        Display = function()
            return AuctionTime[SearchItem[13]];
        end,
        Sort = 13
    },
    {
        Name = AUCTION_CREATOR,
        Width = 90,
        Align = "CENTER",
        Display = function()
            return SearchItem[12];
        end,
        Sort = 12
    },
    {
        Name = BID .. AUCTION_BROWSE_UNIT_PRICE_SORT,
        Width = 80,
        Align = "RIGHT",
        Display = function()
            Text = BaudAuctionToMoney(SearchItem[16]);
            if SearchItem[11] then
                Text = "|cffDD75ff*|r" .. Text; --Your bid
            elseif (SearchItem[10] ~= 0) then
                Text = "|cff00f0f0*|r" .. Text; --Other bid
            end
            return Text;
        end,
        Sort = 16
    },
    {
        Name = "一口单价",
        Width = 80,
        Align = "RIGHT",
        Display = function()
            return (SearchItem[9] == 0) and None or BaudAuctionToMoney(SearchItem[17]);
        end,
        Sort = 17
    },
    {
        Name = BUYOUT,
        Width = 80,
        Align = "RIGHT",
        Display = function()
            return (SearchItem[9] == 0) and None or BaudAuctionToMoney(SearchItem[9]);
        end,
        Sort = 9
    },
};

local function BaudAuctionSortBrowseList()
    BaudAuctionArrow:ClearAllPoints();
    BaudAuctionArrow:SetPoint("RIGHT", getglobal(Columns[SortColumn].Header:GetName()), "RIGHT", 0, -2);
    if SortReverse then
        BaudAuctionArrow:SetTexCoord(0, 0.5625, 1.0, 0);
    else
        BaudAuctionArrow:SetTexCoord(0, 0.5625, 0, 1.0);
    end

    for Index = #SearchResults + 1, #BrowseDisplay do
        BrowseDisplay[Index] = nil;
    end
    for Index = 1, #SearchResults do
        BrowseDisplay[Index] = Index;
    end

    local Sort = Columns[SortColumn].Sort;
    local lastSort = lastSortColumn and Columns[lastSortColumn].Sort
    table.sort(BrowseDisplay, function(a, b)
        if (SearchResults and SearchResults[a] and SearchResults[b]) then
			local sa,sb = SearchResults[a][Sort], SearchResults[b][Sort]
            if Sort == 9 or Sort == 17 then
                sa = sa == 0 and math.huge or sa
                sb = sb == 0 and math.huge or sb
            end
            if (sa == sb) then
                if lastSort and lastSort~= Sort then --按上次的排序
					local lsa, lsb = SearchResults[a][lastSort], SearchResults[b][lastSort]
                    if lastSort == 9 or lastSort == 17 then
                        lsa = lsa == 0 and math.huge or lsa
                        lsb = lsb == 0 and math.huge or lsb
                    end
                    if (lsa == lsb) then
                        return (a < b);
                    elseif not lastSortReverse then
                        return (lsa < lsb);
                    else
                        return (lsa > lsb);
                    end
                else
                    return (a < b);
                end
            elseif not SortReverse then
                return (sa < sb);
            else
                return (sa > sb);
            end
        end
    end);
    BaudAuctionBrowseScrollBar_Update();
end

local function BaudAuction_Reset()
	BaudAuctionProgress:Hide();
	wipe(SearchResults);
	SearchParam = nil;
	ScanPage = nil;
	SelectedItem = nil;
	BaudAuctionSortBrowseList();
end

local function BaudAuctionUpdateProgress(Progress)
    BaudAuctionProgressBar:SetValue(Progress);
    BaudAuctionProgressBarText:SetText(floor(Progress * 100 + 0.5) .. "%");
    if (Progress >= 1) then
        BaudAuctionProgressBarText2:SetText("搜索完成");
        BaudAuctionProgressBarDots:Hide();
        BaudAuctionProgress.Finish = GetTime();
    else
        BaudAuctionProgressBarText2:SetText("搜索中");
        BaudAuctionProgressBarDots:Show();
    end
    BaudAuctionProgress:Show();
end

local function make_disableBtn()
	local btn = CreateFrame("Button", "bf_BA_btn", AuctionFrameBrowse, "UIPanelButtonTemplate");
	btn:SetPoint("BOTTOM", AuctionFrameBrowse, "BOTTOM", -151 , 14);
	btn:SetText("关闭拍卖增强");
	btn:SetHeight(22);
	btn:SetWidth(99);
	btn:SetScript("OnClick", function()
		StaticPopup_Show("AFFIRM_DISABLE_BA");
	end);
end

local EventFuncs = {
    ADDON_LOADED = function(self, AddOn)
        if (AddOn ~= "BaudAuction") then
            return;
        end
        BrowseSearchButton:SetScript("OnUpdate", nil);
		-- BrowseResetButton:HookScript('OnClick', BaudAuction_Reset)
        hooksecurefunc("AuctionFrameBrowse_Update", function()
            BrowseNoResultsText:Hide();
        end);
		hooksecurefunc("QueryAuctionItems", function(...)
		--  ChatFrame1:AddMessage("Item search page "..select(7, ...));
			if AuctionFrameBuy and AuctionFrameBuy:IsVisible() then return end --AuctionLite
			if AuctionFrameSell and AuctionFrameSell:IsVisible() then return end --AuctionLite
			SearchDelay = GetTime() + 1;
			--6.0 QueryAuctionItems(text, minLevel, maxLevel, invType, class, subclass, page, usable, rarity, false, exactMatch);
			--7.0 QueryAuctionItems(text, minLevel, maxLevel, page, usable, rarity, false, exactMatch, filterData);
			if (select(4, ...) == 0 and SelectedItem == nil) then
				SearchResults = {};
				SelectedItem = nil;
				ScanPage = 0;
				ScanFrame:Show();
				SearchParam = { ... };
				BaudAuctionUpdateProgress(0);
				BaudAuctionProgress.Finish = nil;
				BaudAuctionProgress:SetAlpha(1);
				BaudAuctionProgress:Show();
			end
		end);
		hooksecurefunc("AuctionFrameBrowse_Search", function()
			AuctionFrameBrowse.isSearching = nil;
			BrowseNoResultsText:Hide();
			BrowseSearchDotsText:Hide();
		end);
		make_disableBtn();
		self:UnregisterEvent("ADDON_LOADED");
    end,
    AUCTION_HOUSE_CLOSED = function()
       BaudAuction_Reset()
    end,
    AUCTION_ITEM_LIST_UPDATE = function()
        UpdateResults:Show();
    end,
};

local function BaudAuctionColumn_OnClick(self)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
    if (self:GetID() == SortColumn) then
        SortReverse = not SortReverse;
    else
        lastSortColumn = SortColumn
        lastSortReverse = SortReverse
        SortColumn = self:GetID();
        SortReverse = nil;
    end
    BaudAuctionSortBrowseList();
end

local function BaudAuctionSelectItem()
    if (CurrentPage == ceil(SelectedItem / NUM_AUCTION_ITEMS_PER_PAGE) - 1) then
        SetSelectedAuctionItem("list", (SelectedItem - 1) % NUM_AUCTION_ITEMS_PER_PAGE + 1);
        SelectedItem = nil;
    else
        SetSelectedAuctionItem("list", 0);
    end
end

local function BaudAuctionUpdateBidButtons()
    local Index = GetSelectedAuctionItem("list");
    if (Index == 0) then
        BrowseBidButton:Disable();
        BrowseBuyoutButton:Disable();
    else
        AuctionFrame.buyoutPrice = select(10, GetAuctionItemInfo("list", Index)); --4.3 ready
        BrowseBidButton:Enable();
        if (AuctionFrame.buyoutPrice > 0) then
            BrowseBuyoutButton:Enable();
        else
            BrowseBuyoutButton:Disable();
        end
    end
end

local function BaudAuctionBrowseEntry_OnClick(self)
    if IsControlKeyDown() then
        DressUpItemLink(SearchResults[self.Index][14]);
    elseif (IsShiftKeyDown()) then
        ChatEdit_InsertLink(SearchResults[self.Index][14]);
    else
        SelectedItem = self.Index;
        ScanFrame:Show();
        if (ShowOnPlayerCheckButton:GetChecked() == 1) then
            DressUpItemLink(SearchResults[SelectedItem][14]);
        end
        MoneyInputFrame_SetCopper(BrowseBidPrice, SearchResults[SelectedItem][15]);
        BaudAuctionSelectItem();
        BaudAuctionUpdateBidButtons();
        BaudAuctionBrowseScrollBar_Update();
    end
end

local function BaudAuctionBrowseEntry_OnEnter(self)
    local Index = self:GetParent().Index;
    local Item = SearchResults[Index];
    local link = Item and Item[14]
    if(not link) then return end
    self.UpdateTooltip = BaudAuctionBrowseEntry_OnEnter;
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    if(link:find('|Hbattlepet:')) then
		local _, speciesID, level, breedQuality, maxHealth, power, speed, id = strsplit(":", link)
        speciesID = speciesID and tonumber(speciesID)
        if(speciesID and speciesID > 0) then
            BattlePetToolTip_Show(speciesID, tonumber(level), tonumber(breedQuality), tonumber(maxHealth), tonumber(power), tonumber(speed), tonumber(id))
            return
        end
    else
        GameTooltip:SetHyperlink(strmatch(link, "(item[:%-%d]+)"));
    end

    if Item[11] then
        GameTooltip:AddLine("<你是最高出价者>", 0, 1, 0);
        GameTooltip:Show();
	elseif Item[10] > 0 then
		GameTooltip:AddLine("<此物品有人竞标>", 1, 0, 0);
        GameTooltip:Show();
    end

    if (Item[3] > 1) then
        if Item[11] then
            SetTooltipMoney(GameTooltip, ceil(Item[10] / Item[3]), "STATIC", "<" .. AUCTION_TOOLTIP_BID_PREFIX, ">");
        end
        if (Item[9] > 0) then
            SetTooltipMoney(GameTooltip, ceil(Item[9] / Item[3]), "STATIC", "<" .. AUCTION_TOOLTIP_BUYOUT_PREFIX, ">");
        end
        GameTooltip:Show();
    end

    GameTooltip_ShowCompareItem();
    if IsModifiedClick("DRESSUP") then
        ShowInspectCursor();
    else
        ResetCursor();
    end
end

local function BaudAuctionBrowseEntry_OnLeave()
    GameTooltip:Hide();
    -- BattlePetTooltip:Hide()
    ResetCursor();
end

local function BaudAuctionIsMatch(Item1, Item2)
    if not Item1 or not Item2 then
        return;
    end
    for Index = 1, 12 do
        if (Item1[Index] ~= Item2[Index]) then
            return;
        end
    end
    return true;
end

local function BaudAuctionListUpdate()
    UpdateResults:Hide();
    if not SearchParam then
        return;
    end

    local Batch, Total = GetNumAuctionItems("list");
    if (Total == 0) then
        BrowseNoResultsText:SetText(BROWSE_NO_RESULTS);
        BrowseNoResultsText:Show();
    end

    CurrentPage = SearchParam[4];

    if (ScanPage == CurrentPage) then
        local Progress = (Total == 0) and 1 or ((ScanPage + 1) / ceil(Total / NUM_AUCTION_ITEMS_PER_PAGE));
        BaudAuctionUpdateProgress(Progress);
        if (Progress >= 1) then
            ScanPage = nil;
        else
            ScanPage = ScanPage + 1;
        end
    end

    --  ChatFrame1:AddMessage(Batch.." results, "..Total.." Total, page "..CurrentPage);
    local Offset = NUM_AUCTION_ITEMS_PER_PAGE * CurrentPage;
    local SelectedData;
    if SelectedItem and (SelectedItem > Offset) and (SelectedItem <= Offset + NUM_AUCTION_ITEMS_PER_PAGE) then
        SelectedData = SearchResults[SelectedItem];
    end

    local Item;
    for Index = 1, Batch do
        Item = {GetAuctionItemInfo("list", Index)}; --warbaby 4.3 hack
        table.remove(Item, 7)
        table.remove(Item, 12) --remove bidderFullName for 5.4
        table.remove(Item, 13) --remove ownerFullName for 5.4
        --[[    if(Item[1]==nil)then Item[1] = "Unknown"; end]]
        Item[13] = GetAuctionItemTimeLeft("list", Index);
        Item[14] = GetAuctionItemLink("list", Index);
        Item[15] = (Item[10] ~= 0) and (Item[10] + Item[8]) or Item[7]; --Minimum bid amount, including beating an existing bid
        if (Item[9] ~= 0) and (Item[15] > Item[9]) then
            Item[15] = Item[9]; --Bid price cannot exceed buyout price
        end
        Item[16] = Item[15] / Item[3];
        Item[17] = Item[9] / Item[3]; --Per unit price for sorting
        SearchResults[Index + Offset] = Item;
    end

    for Index = Total + 1, #SearchResults do
        SearchResults[Index] = nil;
    end

    if SelectedData then
        if BaudAuctionIsMatch(SearchResults[SelectedItem], SelectedData) then
            BaudAuctionSelectItem();
        end
        SelectedItem = nil;
    end

    BaudAuctionUpdateBidButtons();
    BaudAuctionSortBrowseList();
end

UpdateResults:SetScript("OnUpdate", BaudAuctionListUpdate);

ScanFrame:SetScript("OnUpdate", function(self)
    if not (ScanPage or SelectedItem) then
        self:Hide();
        return;
    end
    if CanSendAuctionQuery() and (SearchDelay <= GetTime()) then
        local Selected = GetSelectedAuctionItem("list");
        if (Selected ~= 0) then
            SelectedItem = NUM_AUCTION_ITEMS_PER_PAGE * CurrentPage + Selected;
        end
        SearchParam[4] = ScanPage or ceil(SelectedItem / NUM_AUCTION_ITEMS_PER_PAGE - 1);
        QueryAuctionItems(unpack(SearchParam));
        SearchDelay = GetTime() + 1;
    end
end);

function BaudAuction_OnLoad(self)
    for Key, _ in pairs(EventFuncs) do
        self:RegisterEvent(Key);
    end
    self:SetScript("OnEvent", function(self,event, ...)
        EventFuncs[event](self,...);
    end);

    AuctionFrameBrowse:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE");
	local number_browse_to_display = NUM_BROWSE_TO_DISPLAY;
    NUM_BROWSE_TO_DISPLAY = 0;

    for _, Value in ipairs(HideBliz) do
        Value:Hide();
        hooksecurefunc(Value, "Show", function() Value:Hide() end);
    end

    for Index = 1, number_browse_to_display do
        getglobal("BrowseButton" .. Index):Hide();
    end

    ScrollBox = BaudAuctionBrowseScrollBox;
    ScrollBox.Entries = 19;
    ScrollBar = getglobal(ScrollBox:GetName() .. "ScrollBar");
    Highlight = getglobal(ScrollBox:GetName() .. "Highlight");

    local Left = 22;
    local Button, Btn_Text;
    for Key, Value in ipairs(Columns) do
        Button = CreateFrame("Button", self:GetName() .. "Col" .. Key, self, "AuctionSortButtonTemplate");
        Value.Header = Button;
        Btn_Text = getglobal(Button:GetName() .. "Text");
        Btn_Text:ClearAllPoints();
        Btn_Text:SetPoint("CENTER",2,0);
        Btn_Text:SetText(Value.Name);
        Button:SetID(Key);
        Button:SetNormalTexture(nil);
        Button:SetWidth(Value.Width);
        Button:SetHeight(19);
        Button:SetScript("OnClick", BaudAuctionColumn_OnClick);
        Button:SetPoint("BOTTOMLEFT", ScrollBox, "TOPLEFT", Left,0);
        Left = Left + Value.Width;
    end

    local function ChildClickFunc(self)
        BaudAuctionBrowseEntry_OnClick(self:GetParent());
    end

    local Entry;
    for Index = 1, ScrollBox.Entries do
        Entry = CreateFrame("Button", ScrollBox:GetName() .. "Entry" .. Index, ScrollBox);
        Entry:SetScript("OnClick", BaudAuctionBrowseEntry_OnClick);
        Entry:SetHeight(16);
        Entry:SetPoint("LEFT", 6, 0);
        Entry:SetPoint("RIGHT", -6, 0);
        Entry:SetPoint("TOP", 0, -3 - (Index - 1) * 16);
        Entry:Hide();
        Button = CreateFrame("Button", Entry:GetName() .. "Icon", Entry);
        Button:SetPoint("LEFT");
        Button:SetHeight(16);
        Button:SetWidth(16);
        Button:CreateTexture(Entry:GetName() .. "Texture", "ARTWORK"):SetAllPoints();
        Button:EnableMouse(true);
        Button:SetHitRectInsets(0, 0-Columns[1].Width, 0, 0);
        Button:SetScript("OnEnter", BaudAuctionBrowseEntry_OnEnter);
        Button:SetScript("OnLeave", BaudAuctionBrowseEntry_OnLeave);
        Button:SetScript("OnClick", ChildClickFunc);
        for Key, Value in ipairs(Columns) do
            Text = Entry:CreateFontString(Entry:GetName() .. "Text" .. Key, "ARTWORK", (Key>4 and "GameFontWhiteSmall") or (Key>1 and "GameFontWhite") or "GameFontHighlight");
            Text:SetPoint("TOP");
            Text:SetPoint("BOTTOM");
            Text:SetPoint("LEFT", Value.Header);
            Text:SetPoint("RIGHT", Value.Header);
            Text:SetJustifyH(Value.Align);
            if Value.OnEnter then
                local btn = CreateFrame("Button", nil, Entry)
                btn:SetAllPoints(Text)
                btn:SetScript("OnEnter", Value.OnEnter)
                btn:SetScript("OnLeave", Value.OnLeave)
                btn:SetScript("OnClick", ChildClickFunc)
            end
        end
    end
end

function BaudAuctionProgress_OnUpdate(self)
    if not BaudAuctionProgress.Finish then
        BaudAuctionProgressBarDots:SetText(strrep(".", floor(GetTime()) % 4));
        return;
    end
    local Elapsed = GetTime() - BaudAuctionProgress.Finish - 1;
    if (Elapsed < 0) then
        return;
    end
    if (Elapsed > 1) then
        self:Hide();
    end
    self:SetAlpha(1 - Elapsed);
end

function BaudAuctionSearchCancelButton_OnClick()
    if BaudAuctionProgress.Finish then
        return;
    end
    BaudAuctionProgress.Finish = GetTime();
    ScanPage = nil;
    BaudAuctionProgressBarText2:SetText("搜索已取消");
    BaudAuctionProgressBarDots:Hide();
    CloseAuctionStaticPopups();
end

function BaudAuction_OnShow()
    BaudAuctionSortBrowseList();
end

function BaudAuctionBrowseScrollBar_Update()
    FauxScrollFrame_Update(ScrollBar, #SearchResults, ScrollBox.Entries, 16);
    Highlight:Hide();
    local Selected = GetSelectedAuctionItem("list");
    if (Selected == 0) then
        Selected = SelectedItem;
        Highlight:SetVertexColor(0, 0, 0.5);
    else
        Selected = CurrentPage * NUM_AUCTION_ITEMS_PER_PAGE + Selected;
        Highlight:SetVertexColor(0.5, 0.5, 0);
    end

    local Entry,Index;
    for Line = 1, ScrollBox.Entries do
        Entry = getglobal(ScrollBox:GetName() .. "Entry" .. Line);
        Index = Line + FauxScrollFrame_GetOffset(ScrollBar);
        if (Index > #SearchResults) then
            Entry:Hide();
            Entry.itemLink = nil
        else
            Index = BrowseDisplay[Index];
            SearchItem = SearchResults[Index];
            if (not SearchItem) then return end
            Entry.Index = Index;
            Entry.itemLink = SearchItem[5] and strmatch(SearchItem[14], "(item[:%-%d]+)") --for AlreadyKnown
            getglobal(Entry:GetName() .. "Texture"):SetTexture(SearchItem[2]);
            for Key, Value in ipairs(Columns) do
                getglobal(Entry:GetName() .. "Text" .. Key):SetText(Value.Display());
            end
            if (Index == Selected) then
                Highlight:SetPoint("TOP", Entry);
                Highlight:Show();
            end
            Entry:Show();

            if TradeskillInfo and TradeskillInfo.ColoringAH then		-- for TradeskillInfo
                TradeskillInfo:ColoringAH( SearchResults[Index][14], getglobal(Entry:GetName().."Texture") )
            end
        end
    end
end
