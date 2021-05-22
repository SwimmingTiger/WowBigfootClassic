if(Skinner and Skinner.initialized) then Skinner.initialized.TradeFrame = true; end;

TBT_SPELL_TABLE = {
    stone = {
        --{ level=0, sid=6201, iid={} },
        sid = 6201,
        iid = {
            5512,
        },
    },
    -- water = {
    -- 	{ level=80, sid=42955, iid=43523, name="", item="", rank="" },
    -- },
    water = {
        sid = 42955,
        iid = {
            5350  , -- 151
            2288  , -- 436
            2136  , -- 835
            3772  , -- 1344
            65500 , -- 1494
            8077  , -- 1992
            65515 , -- 1992
            8078  , -- 2934
            65516 , -- 2934
            8079  , -- 4200
            65517 , -- 4200
            28112 , -- 4410
            30703 , -- 5100
            22018 , -- 7200
            34062 , -- 7200
            43518 , -- 9180
            43523 , -- 12960
            65499 , -- 96000
        },
    },
}

for _, v in next, TBT_SPELL_TABLE do
    v.name = GetSpellInfo(v.sid)
end

local function SetOrHookScript(frame, scriptName, func)
    if( frame:GetScript(scriptName) ) then
        frame:HookScript(scriptName, func);
    else
        frame:SetScript(scriptName, func);
    end
end

local function tcontains(onetable, onevalue)
    if(type(onetable)=="table") then
        return table.foreach(onetable, function(idx, value) if(value==onevalue) then return true end end)
    else
        return onetable==onevalue
    end
end

function TBT_ContainerItemPreClick(self, button)
    if(button=="RightButton" and not IsModifierKeyDown()) then
        if(InboxFrame and InboxFrame:IsVisible()) then
            MailFrameTab_OnClick(MailFrameTab2);
        elseif AuctionFrame and AuctionFrame:IsVisible() then
            if(AuctionFrameTab5 and SellItemButton) then
                AuctionFrameTab_OnClick(AuctionFrameTab3); --or UseContainerItem will use the item!
                AuctionFrameTab_OnClick(AuctionFrameTab5)
                if(SellItemButton and SellItemButton:IsVisible()) then
                    PickupContainerItem(self:GetParent():GetID(), self:GetID());
                    SellItemButton:Click();
                    AuctionsFrameAuctions_ValidateAuction();
                    if(CursorHasItem()) then ClearCursor(); end;
                end
            else
                AuctionFrameTab_OnClick(AuctionFrameTab3);
            end
        end
    end
end

function TBTFrame_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("SPELLS_CHANGED")

    --display the trade recepient info
    local targetInfoText = TradeFrame:CreateFontString("TradeFrameTargetInfoText", "ARTWORK", "GameFontNormal");
    targetInfoText:SetWidth(100);
    targetInfoText:SetHeight(12);
    targetInfoText:SetJustifyH("RIGHT");
    targetInfoText:SetPoint("TOPLEFT", "TradeFrameRecipientNameText", "BOTTOMLEFT", 0, -8);
    hooksecurefunc("TradeFrame_OnShow", function(self)if(UnitExists("NPC"))then TradeFrameTargetInfoText:SetText(UnitClass("NPC").." - "..UnitLevel("NPC"));end end);

    --button for whisper
    local button = CreateFrame("Button", "TradeFrameTargetWhisperButton", TradeFrame, "UIPanelButtonTemplate");
    button:SetWidth(30);
    button:SetHeight(21);
    button:SetPoint("TOPLEFT", "TradeFrameTargetInfoText", "BOTTOMLEFT", 0, -2);
    button:SetText(TBT_RIGHT_BUTTON.whisper);
    button:SetScript("OnClick", function(self)
    --ChatFrame_SendTell(GetUnitName("NPC", true):gsub(" %- ", "-"), nil);
        ChatFrame_SendTell(GetUnitName("NPC", true), nil);
    end)

    --button for emote1
    button = CreateFrame("Button", "TradeFrameTargetEmote1Button", TradeFrame, "UIPanelButtonTemplate");
    button:SetWidth(30);
    button:SetHeight(21);
    button:SetPoint("LEFT", "TradeFrameTargetWhisperButton", "RIGHT", 5, 0);
    button:SetText(TBT_RIGHT_BUTTON.ask);
    button:SetScript("OnClick", function(self) DoEmote("hungry", "NPC") end);

    --button for emote2
    button = CreateFrame("Button", "TradeFrameTargetEmote2Button", TradeFrame, "UIPanelButtonTemplate");
    button:SetWidth(30);
    button:SetHeight(21);
    button:SetPoint("LEFT", "TradeFrameTargetEmote1Button", "RIGHT", 5, 0);
    button:SetText(TBT_RIGHT_BUTTON.thank);
    button:SetScript("OnClick", function(self) DoEmote("thank", "NPC") end);

    --button for click-targetting, positioned at portrait.
    button = CreateFrame("Button", "TradeFrameTargetRecipientButton", TradeFrame, "SecureActionButtonTemplate")
    button:SetAttribute("type", "target");
    button:SetAttribute("unit", "NPC");
    button:SetWidth(60)
    button:SetHeight(70)
    button:SetPoint("CENTER", "TradeFrame", "TOPLEFT", 210, -35);

    --for rightclick quick trade
    for i=1, NUM_CONTAINER_FRAMES do
        for j=1, MAX_CONTAINER_ITEMS do
            local f = getglobal("ContainerFrame"..i.."Item"..j);
            if(f) then
                SetOrHookScript(f, "PreClick", TBT_ContainerItemPreClick);
            end
        end
    end
    local CoreDependCall = function(addon, func) if IsAddOnLoaded(addon) then func() end end
    CoreDependCall("Bagnon", function()
        for i=1, 1000 do
            local f = _G["BagnonItem"..i]
            if not f then break end
            SetOrHookScript(f, "PreClick", TBT_ContainerItemPreClick);
        end
        local constructID
        hooksecurefunc(Bagnon.ItemSlot, "Create", function()
            local f = constructID and _G["BagnonItem"..constructID]
            if(f) then
                return f:HookScript('PreClick', TBT_ContainerItemPreClick)
            end
        end)
        if Bagnon.ItemSlot.Construct then
            hooksecurefunc(Bagnon.ItemSlot, "Construct", function(self, id)
                constructID = id
            end)
        elseif Bagnon.ItemSlot.ConstructNewItemSlot then
            hooksecurefunc(Bagnon.ItemSlot, "ConstructNewItemSlot", function(self, id)
                constructID = id
            end)
        end
    end)
    hooksecurefunc("HandleModifiedItemClick",function(link)
        if IsShiftKeyDown() then
            if IsAddOnLoaded("Blizzard_AuctionUI") then
                if  AuctionFrameBrowse:IsVisible() then
                    AuctionFrameBrowse_Search();
                end
            end
        end
    end)

    --for alt+leftclick quick trade
    hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", function(self, button)
        local bag, item = self:GetParent():GetID(), self:GetID();
        local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, item);
        if texture and not locked then
            if(button == "LeftButton" and IsAltKeyDown() ) then
                if AuctionFrame and AuctionFrame:IsVisible() then
                    if(AuctionFrameTab5 and SellItemButton) then
                        AuctionFrameTab_OnClick(AuctionFrameTab5)
                    else
                        AuctionFrameTab_OnClick(AuctionFrameTab3);
                    end
                end
                if(TradeFrame:IsVisible() and not InCombatLockdown()) then
                    PickupContainerItem(self:GetParent():GetID(), self:GetID());
                    StackSplitFrame:Hide();
                    TradeFrame_OnMouseUp();
                    return
                end
                if(InboxFrame and InboxFrame:IsVisible()) then
                    MailFrameTab_OnClick(nil, 2);
                end
                if(SendMailAttachment1 and SendMailAttachment1:IsVisible()) then
                    UseContainerItem(self:GetParent():GetID(), self:GetID());
                elseif(SellItemButton and SellItemButton:IsVisible()) then
                    PickupContainerItem(self:GetParent():GetID(), self:GetID());
                    SellItemButton:Click();
                    AuctionsFrameAuctions_ValidateAuction();
                    if(CursorHasItem()) then ClearCursor(); end;
                elseif(AuctionsItemButton and AuctionsItemButton:IsVisible()) then
                    PickupContainerItem(self:GetParent():GetID(), self:GetID());
                    ClickAuctionSellItemButton();
                    AuctionsFrameAuctions_ValidateAuction();
                    if(CursorHasItem()) then ClearCursor(); end;
                end
            end

            --for shift+leftclick start auction search directly.
            if(button == "LeftButton" and IsShiftKeyDown() and AuctionFrame and AuctionFrame:IsVisible() and AuctionFrameBrowse:IsVisible()) then
                --AuctionFrameTab_OnClick(AuctionFrameTab1, 1);
                BrowseResetButton:GetScript("OnClick")(BrowseResetButton);
                ChatEdit_InsertLink(GetContainerItemLink(self:GetParent():GetID(), self:GetID()));
                AuctionFrameBrowse_Search();
            end

            --[[--quick sell same item, no need
            if(button=="RightButton" and IsControlKeyDown() and IsAltKeyDown() and AuctionsItemButton and AuctionsItemButton:IsVisible()) then
                PickupContainerItem(self:GetParent():GetID(), self:GetID());
                ClickAuctionSellItemButton();
                local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();
                if ( name == LAST_ITEM_AUCTIONED and count == LAST_ITEM_COUNT) then
                    MoneyInputFrame_SetCopper(StartPrice, LAST_ITEM_START_BID);
                    MoneyInputFrame_SetCopper(BuyoutPrice, LAST_ITEM_BUYOUT);
                end
                AuctionsFrameAuctions_ValidateAuction();
                if(AuctionsCreateAuctionButton:IsEnabled()==1) then
                    AuctionsCreateAuctionButton_OnClick();
                else
                    DEFAULT_CHAT_FRAME:AddMessage(TBT_CANT_CREATE_AUCTION);
                end
            end
            --]]
        end
    end)

end

function TBTFrame_SetButtonSpell(button, spell)
    if not InCombatLockdown() then
        button:SetAttribute("type", "spell");
        button:SetAttribute("spell", spell);
    end
end

function TBT_TradeItem(self, type)
    local iids,quantity,spell,maxRank
    maxRank = TBT_MaxSpellRank[type];
    TBTFrame_SetButtonSpell(self, "")

    local spells, npcLevel;
    spells = TBT_SPELL_TABLE[type];
    npcLevel = UnitLevel("npc");
    local spell = spells.name

    if(type=="water") then
        quantity=15;
    else
        quantity=1;
    end

    local bag, slot
    for i = #spells.iid, 1, -1 do
        bag, slot = TBT_FindItem(spells.iid[i], quantity)
        if(slot) then
            break
        end
    end

    -- for i=maxRank or table.getn(spells), 1,-1 do
    -- 	if(spells[i].level <= npcLevel) then
    -- 		spell = spells[i].name --.."("..spells[i].rank..")" no spell rank in 4.0
    -- 		iids = spells[i].iid
    -- 		break;
    -- 	end
    -- end

    if(slot) then
        local emptySlot = false;
        for i=1,6 do
            if(not GetTradePlayerItemInfo(i)) then
                emptySlot = true;
            end;
        end
        if(emptySlot) then
            PickupContainerItem(bag, slot);
            StackSplitFrame:Hide();
            TradeFrame_OnMouseUp();
            return;
        end
    end

    if(maxRank) then --can create this item
        TBTFrame_SetButtonSpell(self, spell);
    end
end

local function CreatePlayerSpellButton(id, type)
    local button = CreateFrame("Button", "TradeFramePlayerSpell"..id.."Button", TradeFrame, "UIPanelButtonTemplate, SecureActionButtonTemplate");
    button:SetWidth(45);
    button:SetHeight(21);
    button:SetText(TBT_LEFT_BUTTON[type]);
    return button
end

function TBTFrame_CreateLeftButton(class)
    --everyone can trade others water
    local button = CreatePlayerSpellButton(1, "water");
    button:SetPoint("TOPLEFT", "TradeFrame", "TOPLEFT", 72, -36);
    button:SetScript("PreClick", function(self) TBT_TradeItem(self, "water") end);
    button:SetScript("PostClick", function(self) TBTFrame_SetButtonSpell(self,"") end);

    local type = class=="WARLOCK" and "stone" or class=="ROGUE" and "unlock" or nil;

    if(type) then
        button = CreatePlayerSpellButton(2, type)
        button:SetPoint("LEFT", "TradeFramePlayerSpell1Button", "RIGHT", 5, 0);
    end

    if(type=="stone") then
        button:SetScript("PreClick", function(self) TBT_TradeItem(self, type) end);
        button:SetScript("PostClick", function(self) TBTFrame_SetButtonSpell(self,"") end);
    elseif(type=="unlock") then
        button:SetAttribute("type","spell");
        button:SetAttribute("spell", GetSpellInfo(1804));
        button:SetScript("PostClick", function(self) ClickTargetTradeButton(7); end);
    end

end

TBT_MaxSpellRank = {};

function TBTFrame_OnEvent(self, event, ...)
    if(event == "PLAYER_ENTERING_WORLD") then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD");
        local _,class = UnitClass("player")
        TBTFrame_CreateLeftButton(class);

        if(class=="MAGE") then
            TBT_MaxSpellRank["water"] = 1
        elseif(class=="WARLOCK")then
            TBT_MaxSpellRank["stone"] = 1
        end
        --TBTFrame_CreateEnchantButton();
    elseif(event == "SPELLS_CHANGED") then
        --TBTFrame_CreateEnchantButton();
    end
end

function TBT_FindItem(iids,quantity,type)
    local bag,slog,i;
    for bag=0,NUM_CONTAINER_FRAMES do
        for slot=1,GetContainerNumSlots(bag) do
            local _, count, locked, _ = GetContainerItemInfo(bag, slot)
            if (count and not locked and count >= quantity ) then
                local itemId = GetContainerItemID(bag, slot);
                if(tcontains(iids, itemId)) then
                    TBT_debug("found itemId=",itemId);
                    return bag, slot;
                end
            end
        end
    end
end

function TBT_debug(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    if(1) then return; end
    local msg = "";
    if(arg1) then msg = msg..arg1.."," else msg = msg.." ," end
    if(arg2) then msg = msg..arg2.."," else msg = msg.." ," end
    if(arg3) then msg = msg..arg3.."," else msg = msg.." ," end
    if(arg4) then msg = msg..arg4.."," else msg = msg.." ," end
    if(arg5) then msg = msg..arg5.."," else msg = msg.." ," end
    if(arg6) then msg = msg..arg6.."," else msg = msg.." ," end
    if(arg7) then msg = msg..arg7.."," else msg = msg.." ," end
    DEFAULT_CHAT_FRAME:AddMessage(msg);
end

local frame = CreateFrame("Frame");
frame:SetScript("OnEvent", TBTFrame_OnEvent);
TBTFrame_OnLoad(frame);
