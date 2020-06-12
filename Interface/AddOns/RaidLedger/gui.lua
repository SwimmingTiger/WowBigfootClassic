local _, ADDONSELF = ...

ADDONSELF.gui = {
}
local GUI = ADDONSELF.gui

local L = ADDONSELF.L
local ScrollingTable = ADDONSELF.st
local RegEvent = ADDONSELF.regevent
local Database = ADDONSELF.db
local Print = ADDONSELF.print
local calcavg = ADDONSELF.calcavg
local GenExport = ADDONSELF.genexport
local GenReport = ADDONSELF.genreport
local SendToChatSlowly = ADDONSELF.sendchat
local GetMoneyStringL = ADDONSELF.GetMoneyStringL

local function GetRosterNumber()
    local all = {}
    local dict = {}
    for i = 1, MAX_RAID_MEMBERS do
        local name = GetRaidRosterInfo(i)

        if name then
            dict[name] = 1
        end
    end

    dict[UnitName("player")] = 1

    for k in pairs(dict) do
        tinsert(all, k)
    end

    return #all
end

local function RemoveAll(item)
    local again = true
    while again do
        again = false
        local items = Database:GetCurrentLedger()["items"]
        for idx, entry in pairs(items or {}) do
            local detail = entry["detail"]
            if detail["type"] == "ITEM" then
                local _, itemLink = GetItemInfo(detail["item"])
                if itemLink == item then
                    again = true
                    Database:RemoveEntry(idx)
                    break
                end
            end
        end
    end

end

function GUI:Show()
    self.mainframe:Show()
end

function GUI:Hide()
    self.mainframe:Hide()
end

local CRLF = ADDONSELF.CRLF

function GUI:UpdateSummary()
    local profit, avg, revenue, expense = calcavg(Database:GetCurrentLedger()["items"], self:GetSplitNumber(), nil, nil, {
        rounddown = GUI.rouddownCheck:GetChecked(),
    })

    self.summaryLabel:SetText(L["Revenue"] .. " " .. GetMoneyString(revenue) .. CRLF
                           .. L["Expense"] .. " " .. GetMoneyString(expense) .. CRLF
                           .. L["Net Profit"] .. " " .. GetMoneyString(profit) .. CRLF
                           .. L["Per Member"] .. " " .. GetMoneyString(avg)
                        )
end

function GUI:GetSplitNumber()
    return tonumber(self.countEdit:GetText()) or 0
end

function GUI:UpdateLootTableFromDatabase()

    local data = {}

    for id, item in pairs(Database:GetCurrentLedger()["items"]) do

        if not (self.hidelockedCheck:GetChecked() and item["lock"]) then
            table.insert(data, 1, {
                ["cols"] = {
                    {
                        ["value"] = id
                    }, -- id
                },
            })
        end
    end

    self.lootLogFrame:SetData(data)
    self:UpdateSummary()
end

local function GetEntryFromUI(rowFrame, cellFrame, data, cols, row, realrow, column, table)
    local rowdata = table:GetRow(realrow)
    if not rowdata then
        return nil
    end

    local celldata = table:GetCell(rowdata, column)
    local idx = rowdata["cols"][1].value

    local ledger = Database:GetCurrentLedger()
    local entry = ledger["items"][idx]
    return entry, idx
end

local function CreateCellUpdate(cb)
    return function(rowFrame, cellFrame, data, cols, row, realrow, column, fShow, table, ...)
        if not fShow then
            return
        end

        local entry, idx = GetEntryFromUI(rowFrame, cellFrame, data, cols, row, realrow, column, table)

        if entry then
            cb(cellFrame, entry, idx, rowFrame)
        end
    end
end

-- tricky way to clear all editbox focus
local clearAllFocus = (function()
    local fedit = CreateFrame("EditBox")
    fedit:SetAutoFocus(false)
    fedit:SetScript("OnEditFocusGained", fedit.ClearFocus)

    return function()
        local focusFrame = GetCurrentKeyBoardFocus()

        if not focusFrame then
            return
        end

        local p = focusFrame:GetParent()
        local owned = false
        while p ~= nil do
            if p == GUI.mainframe then
                fedit:SetFocus()
                fedit:ClearFocus()
                return
            end
            p = p:GetParent()
        end
    end
end)()

local function CreateBidFrame()

    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetScript("OnMouseDown", clearAllFocus)
    f:Hide()

end

function GUI:Init()


    local f = CreateFrame("Frame", nil, UIParent)
    f:SetWidth(650)
    f:SetHeight(550)
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 8, right = 8, top = 10, bottom = 10}
    })

    f:SetBackdropColor(0, 0, 0)
    f:SetPoint("CENTER", 0, 0)
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetScript("OnMouseDown", clearAllFocus)
    f:Hide()

    self.mainframe = f

    local menuFrame = CreateFrame("Frame", nil, UIParent, "UIDropDownMenuTemplate")
    do
        self.itemtooltip = CreateFrame("GameTooltip", "RaidLedgerTooltipItem" .. random(10000), UIParent, "GameTooltipTemplate")
        self.commtooltip = CreateFrame("GameTooltip", "RaidLedgerTooltipComm" .. random(10000) , UIParent, "GameTooltipTemplate")
    end

    -- title
    do
        local t = f:CreateTexture(nil, "ARTWORK")
        t:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
        t:SetWidth(256)
        t:SetHeight(64)
        t:SetPoint("TOP", f, 0, 12)
        f.texture = t
    end

    do
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        t:SetText(L["Raid Ledger"])
        t:SetPoint("TOP", f.texture, 0, -14)
    end
    -- title


    local mustnumber = function(self, char)
        local t = self:GetText()
        local b = strbyte(char)

        -- allow number or dot only if no dot in str
        if (48 <= b and b <= 57) then
            return
        end
        
        if char == "." and string.find(t, ".", 1, true) == #t then
            return
        end

        self:SetText(string.sub(t, 0, #t - 1))
    end

    do
        local b = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
        b:SetPoint("TOPLEFT", f, 25, -10)

        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        b.text:SetPoint("LEFT", b, "RIGHT", 0, 1)
        b.text:SetText(L["Hide locked items"])
        b:SetScript("OnClick", function()
            GUI:UpdateLootTableFromDatabase()
        end)

        self.hidelockedCheck = b
    end

    -- bid
    do
        local bf = CreateFrame("Frame", nil, f)
        bf:SetWidth(290)
        bf:SetHeight(310)
        bf:SetBackdrop({
            bgFile = "Interface\\FrameGeneral\\UI-Background-Marble",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            -- tile = true,
            tileSize = 32,
            edgeSize = 32,
            insets = {left = 8, right = 8, top = 10, bottom = 10}
        })
    
        -- bf:SetBackdropColor(1, 1, 1, 1)
        bf:SetPoint("CENTER", f, 0, 0)
        bf:SetToplevel(true)
        bf:EnableMouse(true)
        bf:SetFrameLevel(f:GetFrameLevel() + 10)

        do
            local b = CreateFrame("Button", nil, bf, "UIPanelCloseButton")
            b:SetPoint("TOPRIGHT", bf, 0, 0);
        end

        do
            local tooltip = self.itemtooltip

            local itemTexture = bf:CreateTexture()
            itemTexture:SetTexCoord(0, 1, 0, 1)
            itemTexture:Show()
            itemTexture:SetPoint("TOPLEFT", bf, 20, -20)
            itemTexture:SetWidth(30)
            itemTexture:SetHeight(30)            
            itemTexture:SetTexture(134400) -- question mark


            bf.itemTexture = itemTexture

            local counttext = bf:CreateFontString(nil, 'OVERLAY')
            counttext:SetFontObject('NumberFontNormal')
            counttext:SetPoint('BOTTOMRIGHT', itemTexture, -3, 3)
            counttext:SetJustifyH('RIGHT')

            local itemtext = CreateFrame("Button", nil, bf)
            itemtext.text = itemtext:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            itemtext.text:SetPoint("LEFT", itemtext, "LEFT", 45, 0)
            itemtext.text:SetWidth(230)
            itemtext.text:SetJustifyH("LEFT")

            itemtext:SetPoint('LEFT', itemTexture, "RIGHT", -40, 0)
            itemtext:SetSize(30, 30)
            itemtext:EnableMouse(true)
            itemtext:RegisterForClicks("AnyUp")
            itemtext:SetScript("OnClick", function()
                ChatEdit_InsertLink(itemtext.link)
            end)

            itemtext:SetScript("OnEnter", function()
                if itemtext.link then
                    tooltip:SetOwner(itemtext, "ANCHOR_CURSOR")
                    tooltip:SetHyperlink(itemtext.link)
                    tooltip:Show()
                end
            end)

            itemtext:SetScript("OnLeave", function()
                tooltip:Hide()
                tooltip:SetOwner(itemtext, "ANCHOR_NONE")
            end)

            bf.SetItem = function(item, count)

                counttext:SetText("1")

                if tonumber(count) then
                    counttext:SetText(count)
                end
                itemTexture:SetTexture(134400)

                local _, itemLink = GetItemInfo(item)
                if itemLink then
                    itemtext.link = itemLink
                    itemtext.text:SetText(itemLink)
                    itemtext:SetWidth(math.min(230, itemtext.text:GetStringWidth() + 45))

                else
                    itemtext.link = nil
                    itemtext.text:SetText(item)
                end

                local itemTexture =  GetItemIcon(item)

                if itemTexture then
                    bf.itemTexture:SetTexture(itemTexture)
                end
            end

        end

        local slideShowMoneyFrame = function(self, button)
            if button == "RightButton" then
                self:SetValueStep(1)
                OpenStackSplitFrame(999999, self, "BOTTOMLEFT", "TOPLEFT", 1)
                StackSplitText:SetText(self:GetValue())
                StackSplitFrame.split = self:GetValue()
                UpdateStackSplitFrame(999999)
            else
                StackSplitFrame:Hide()
                self:SetValueStep(self.slidestep)
                self:SetMinMaxValues(self.slidemin, self.slidemax)
            end

        end

        local slideMoneySet = function(owner, split)
            if owner.moneyslide then
                local min = math.min(split, owner.slidemin)
                local max = math.max(split, owner.slidemax)
                owner:SetMinMaxValues(min, max)
                owner:SetValueStep(1)
                owner:SetValue(split)
            end
        end
        
        do
            hooksecurefunc(StackSplitText, "SetText", function(self, value)
                if StackSplitFrame.owner.moneyslide then
                    if not strfind(value, "MoneyFrame") then
                        self:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(value))
                    end
                end
            end)
        end


        do
            local s = CreateFrame("Slider", nil, bf, "OptionsSliderTemplate")
            s:SetOrientation('HORIZONTAL')
            s:SetHeight(14)
            s:SetWidth(160)
            s:SetMinMaxValues(5, 60)
            s:SetValueStep(1)
            s:SetObeyStepOnDrag(true)
            s.Low:SetText(SecondsToTime(5))
            s.High:SetText(SecondsToTime(60))
    
            local l = s:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            l:SetPoint("RIGHT", s, "LEFT", -20, 1)
            l:SetText(L["Count down time"])
            bf:SetWidth(math.max(bf:GetWidth(), l:GetStringWidth() + 220))


            s:SetPoint("TOPLEFT", bf, 40 + l:GetStringWidth(), -70)

            s:SetScript("OnValueChanged", function(self, value)
                s.Text:SetText(SecondsToTime(value))
            end)

            s:SetValue(20)

            bf.countdown = s
        end

        do
            local tooltip = self.commtooltip

            local s = CreateFrame("Slider", nil, bf, "OptionsSliderTemplate")
            s:SetOrientation('HORIZONTAL')
            s:SetHeight(14)
            s:SetWidth(160)
            s:SetMinMaxValues(50, 5000)
            s:SetValueStep(50)
            s:SetObeyStepOnDrag(true)
            s.Low:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(50))
            s.High:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(5000))
    
            local l = s:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            l:SetPoint("RIGHT", s, "LEFT", -20, 1)
            l:SetText(L["Starting price"])
            bf:SetWidth(math.max(bf:GetWidth(), l:GetStringWidth() + 220))


            s:SetPoint("TOPLEFT", bf, 40 + l:GetStringWidth(), -120)

            s:SetScript("OnValueChanged", function(self, value)
                value = math.floor(value)
                s.Text:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(value))
            end)

            s.moneyslide = true
            s.SplitStack = slideMoneySet
            s.slidestep = s:GetValueStep()
            s.slidemin, s.slidemax = s:GetMinMaxValues()
            s:SetScript("OnMouseDown", slideShowMoneyFrame)
            s:SetScript("OnMouseUp", slideShowMoneyFrame)

            s:SetScript("OnEnter", function()
                tooltip:SetOwner(s, "ANCHOR_RIGHT")
                tooltip:SetText(L["Right click to fine-tune"])
                tooltip:Show()
            end)

            s:SetScript("OnLeave", function()
                tooltip:Hide()
                tooltip:SetOwner(UIParent, "ANCHOR_NONE")
            end)

            s:SetValue(100)

            bf.startprice = s
        end

        do
            local l = bf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            l:SetPoint("TOPLEFT", bf, 20, -160)
            l:SetText(L["Bid mode"])

            local usegold
            local usepercent

            local ensurechecked = function(self)
                if self == usegold then
                    usepercent:SetChecked(not usegold:GetChecked())
                    return
                end

                if self == usepercent then
                    usegold:SetChecked(not usepercent:GetChecked())
                    return
                end

                if usegold:GetChecked() then
                    usepercent:SetChecked(false)
                    return
                end

                if usepercent:GetChecked() then
                    usegold:SetChecked(false)
                    return
                end

                usegold:SetChecked(true)
                usepercent:SetChecked(false)
            end

            bf.GetBidMode = function()
                if usegold:GetChecked() then
                    return "GOLD", usegold.slide:GetValue()
                end

                if usepercent:GetChecked() then
                    return "PERCENT", usepercent.slide:GetValue()
                end                
            end

            local ensureone = function(self)
                ensurechecked(self)
                usegold.slide:Hide()
                usepercent.slide:Hide()

                if usegold:GetChecked() then
                    usegold.slide:Show()
                end

                if usepercent:GetChecked() then
                    usepercent.slide:Show()
                end                
            end

            do
                local b = CreateFrame("CheckButton", nil, bf, "UICheckButtonTemplate")
                b:SetPoint("TOPLEFT", bf, 30 + l:GetStringWidth(), -150)
        
                b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                b.text:SetPoint("LEFT", b, "RIGHT", 0, 1)
                b.text:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(""))
                b:SetScript("OnClick", ensureone)

                usegold = b

                do
                    local tooltip = self.commtooltip

                    local s = CreateFrame("Slider", nil, bf, "OptionsSliderTemplate")
                    s:SetOrientation('HORIZONTAL')
                    s:SetHeight(14)
                    s:SetWidth(160)
                    s:SetMinMaxValues(10, 500)
                    s:SetValueStep(10)
                    s:SetObeyStepOnDrag(true)
                    s.Low:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(10))
                    s.High:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(500))
            
                    local l = s:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                    l:SetPoint("RIGHT", s, "LEFT", -20, 1)
                    l:SetText(L["Bid increment"])

                    bf:SetWidth(math.max(bf:GetWidth(), l:GetStringWidth() + 220))
        
                    s:SetPoint("TOPLEFT", bf, 40 + l:GetStringWidth(), -200)
        
                    s:SetScript("OnValueChanged", function(self, value)
                        value = math.floor(value)
                        s.Text:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(value))
                    end)
        
                    s.moneyslide = true
                    s.SplitStack = slideMoneySet
                    s.slidestep = s:GetValueStep()
                    s.slidemin, s.slidemax = s:GetMinMaxValues()
                    s:SetScript("OnMouseDown", slideShowMoneyFrame)
                    s:SetScript("OnMouseUp", slideShowMoneyFrame)

                    s:SetScript("OnEnter", function()
                        tooltip:SetOwner(s, "ANCHOR_RIGHT")
                        tooltip:SetText(L["Right click to fine-tune"])
                        tooltip:Show()
                    end)
    
                    s:SetScript("OnLeave", function()
                        tooltip:Hide()
                        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
                    end)

                    s:SetValue(50)
                    s:Hide()
        
                    b.slide = s
                end                
            end

            do
                local b = CreateFrame("CheckButton", nil, bf, "UICheckButtonTemplate")
                b:SetPoint("TOPLEFT", bf, 90 + l:GetStringWidth(), -150)
        
                b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                b.text:SetPoint("LEFT", b, "RIGHT", 0, 1)
                b.text:SetText("%")
                b:SetScript("OnClick", ensureone)

                usepercent = b

                do
                    local s = CreateFrame("Slider", nil, bf, "OptionsSliderTemplate")
                    s:SetOrientation('HORIZONTAL')
                    s:SetHeight(14)
                    s:SetWidth(160)
                    s:SetMinMaxValues(1, 100)
                    s:SetValueStep(1)
                    s:SetObeyStepOnDrag(true)
                    s.Low:SetText("1%")
                    s.High:SetText("100%")
            
                    local l = s:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                    l:SetPoint("RIGHT", s, "LEFT", -20, 1)
                    l:SetText(L["Bid increment"])
        
                    s:SetPoint("TOPLEFT", bf, 40 + l:GetStringWidth(), -200)
        
                    s:SetScript("OnValueChanged", function(self, value)
                        value = math.floor(value)
                        s.Text:SetText(value .. "%")
                    end)
        
                    s:SetValue(10)
                    s:Hide()
        
                    b.slide = s
                end                
            end

            ensureone()
        end

        do
            local b = CreateFrame("CheckButton", nil, bf, "UICheckButtonTemplate")
            b:SetPoint("TOPLEFT", bf, 15, -230)
    
            b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            b.text:SetPoint("LEFT", b, "RIGHT", 0, 1)
            b.text:SetText("/RA")

            b:SetScript("OnClick", function() 
                Database:SetConfig("bfusera", b:GetChecked())
            end)
            b:SetChecked(Database:GetConfigOrDefault("bfusera", true))            

            bf.usera = b
        end

        do
            local ctx = nil

            local currentitem = function()
                local entry = bf.curEntry
                local item = entry["detail"]["item"] or entry["detail"]["displayname"]                
                item = item .. " (" .. (entry["detail"]["count"] or 1) .. ")"
                return item
            end
         

            local bidprice = function()
                if not ctx then
                    return 0
                end

                local bid = ctx.currentprice

                if ctx.currentwinner then
                    if ctx.mode == "GOLD" then
                        bid = bid + ctx.inc * 10000
                    elseif ctx.mode == "PERCENT" then
                        bid = math.floor(bid * (1 + (ctx.inc / 100)) / 10000) * 10000
                    end
                end

                return bid
            end

            local SendRaidMessage = function(text)
                if bf.usera:GetChecked() and (UnitIsGroupLeader('player') or UnitIsGroupAssistant('player')) then
                    SendChatMessage(text, "RAID_WARNING")
                else
                    SendChatMessage(text, "RAID")
                end
            end

            local evt = function(text, playerName)
                if not ctx then
                    return
                end

                local ask = tonumber(text)
                if not ask then
                    return
                end

                playerName = strsplit("-", playerName)
                local bid = bidprice() / 10000
                local item = currentitem()

                if ask >= bid then
                    ctx.currentwinner = playerName
                    ctx.currentprice = ask * 10000
                    ctx.countdown = bf.countdown:GetValue()
                    
                    -- L["Bid price"]
                    SendRaidMessage(L["Bid accept"] .. " " .. item .. " " .. L["Current price"] .. " >>" .. GetMoneyStringL(ctx.currentprice) .. "<< ".. (ctx.pause and "" or L["Time left"] .. " " .. (SECOND_ONELETTER_ABBR:format(ctx.countdown))))
                else
                    SendRaidMessage(L["Bid denied"] .. " " .. item .. " " .. L["Must bid higher than"] .. " " .. GetMoneyStringL(bid * 10000))
                end
                
            end

            RegEvent("CHAT_MSG_RAID_LEADER", evt)
            RegEvent("CHAT_MSG_RAID", evt)

            local moretimebtn
            local lesstimebtn
            local controlbtn
            do
                local b = CreateFrame("Button", nil, bf, "GameMenuButtonTemplate")
                b:SetWidth(40)
                b:SetHeight(25)
                b:SetPoint("BOTTOMRIGHT", -140, 15)
                b:SetText("-5s")
                b:Hide()
                b:SetScript("OnClick", function()
                    if ctx then
                        if ctx.countdown <= 5 then
                            return
                        elseif ctx.countdown < 10 then
                            ctx.countdown = 5
                        elseif ctx.countdown >= 10 then
                            ctx.countdown = ctx.countdown - 5 
                        end
                    end
                    bf.UpdateButtonCountdown()
                end)
                lesstimebtn = b
            end

            do
                local b = CreateFrame("Button", nil, bf, "GameMenuButtonTemplate")
                b:SetWidth(40)
                b:SetHeight(25)
                b:SetPoint("BOTTOMRIGHT", -230, 15)
                b:SetText("+5s")
                b:Hide()
                b:SetScript("OnClick", function()
                    if ctx then
                        ctx.countdown = ctx.countdown + 5 
                    end
                    bf.UpdateButtonCountdown()
                end)
                moretimebtn = b
            end

            do
                local b = CreateFrame("Button", nil, bf, "GameMenuButtonTemplate")
                b:SetWidth(50)
                b:SetHeight(25)
                b:SetPoint("BOTTOMRIGHT", -180, 15)
                -- b:SetText(L["Pause"])
                b:Hide()
                b:SetScript("OnClick", function()
                    if ctx then
                        ctx.pause = not ctx.pause
                    end

                    bf.UpdateButtonCountdown()
                end)
                controlbtn = b
            end

            do
                
                local tooltip = GUI.commtooltip


                local b = CreateFrame("Button", nil, bf, "GameMenuButtonTemplate")
                b:SetWidth(100)
                b:SetHeight(25)
                b:SetPoint("BOTTOMRIGHT", -40, 15)
                b:SetText(START)

                b:SetScript("OnEnter", function()
                    tooltip:SetOwner(b, "ANCHOR_RIGHT")
                    tooltip:SetText(L["CTRL + Click to start and then pause timer"])
                    tooltip:Show()
                end)

                b:SetScript("OnLeave", function()
                    tooltip:Hide()
                    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
                end)

                b:SetScript("OnClick", function() 
                    if ctx then
                        bf.CancelBid()
                        return
                    end

                    local mode, inc = bf.GetBidMode()
                    ctx = {
                        entry = bf.curEntry,
                        currentprice = bf.startprice:GetValue() * 10000,
                        currentwinner = nil,
                        mode = mode,
                        inc = inc,
                        countdown = bf.countdown:GetValue(),
                    }

                    if IsControlKeyDown() then
                        ctx.pause = true
                    end

                    bf.UpdateButtonCountdown()

                    local item = currentitem()

                    SendRaidMessage(L["Start bid"] .. " " .. item .. " " .. L["Starting price"] .. " >>" .. GetMoneyStringL(ctx.currentprice) .. "<< " .. (ctx.pause and "" or L["Time left"] .. " " .. (SECOND_ONELETTER_ABBR:format(ctx.countdown))))

                    ctx.timer = C_Timer.NewTicker(1, function()
                        if ctx.pause then
                            return
                        end

                        ctx.countdown = ctx.countdown - 1

                        bf.UpdateButtonCountdown()

                        if ctx.countdown <= 0 then
                            ctx.timer:Cancel()

                            if ctx.currentwinner then
                                SendRaidMessage(item .. " " .. L["Hammer Price"] .. " >>" .. GetMoneyStringL(ctx.currentprice) .. "<< " .. L["Winner"] .. " " .. ctx.currentwinner)
                                ctx.entry["beneficiary"] = ctx.currentwinner
                                ctx.entry["cost"] = ctx.currentprice / 10000
                                ctx.entry["lock"] = true
                                GUI:UpdateLootTableFromDatabase()
                            else
                                SendRaidMessage(item .. " " .. L["is bought in"])
                            end

                            ctx = nil
                            bf.UpdateButtonCountdown()

                            return
                        end

                        local sendalert = ctx.countdown <= 5
                        -- sendalert = sendalert or (ctx.countdown <= 15 and (ctx.countdown % 5 == 0))
                        -- sendalert = sendalert or (ctx.countdown <= 30 and (ctx.countdown % 10 == 0))
                        -- sendalert = sendalert or (ctx.countdown % 30 == 0)

                        if sendalert then
                            SendRaidMessage(" " .. L["Current price"] .. " >>" .. GetMoneyStringL(ctx.currentprice) .. "<< " .. L["Time left"] .. " " .. (SECOND_ONELETTER_ABBR:format(ctx.countdown)))
                        end
                    end)
                end)

                bf.CancelBid = function()
                    if ctx then
                        ctx.timer:Cancel()
                        SendRaidMessage(L["Bid canceled"], "RAID")
                    end

                    ctx = nil
                    bf.UpdateButtonCountdown()
                end

                bf.UpdateButtonCountdown = function()
                    if ctx then
                        b:SetText(CANCEL .. "(" .. GREEN_FONT_COLOR:WrapTextInColorCode(ctx.countdown) .. ")")
                        moretimebtn:Show()
                        lesstimebtn:Show()
                        controlbtn:Show()

                        if ctx.pause then
                            controlbtn:SetText(L["Go"])
                        else
                            controlbtn:SetText(L["Pause"])
                        end
                    else
                        b:SetText(START)
                        moretimebtn:Hide()
                        lesstimebtn:Hide()
                        controlbtn:Hide()
                    end
                end
            end




        end

        bf:Hide()
        bf:SetScript("OnHide", function() 
            if GUI.mainframe:IsShown() then
                bf.CancelBid()
            end
        end)

        self.bidframe = bf
    end

    -- split member and editbox
    do
        local t = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
        t:SetWidth(30)
        t:SetHeight(25)
        t:SetPoint("BOTTOMLEFT", f, 350, 95)
        t:SetAutoFocus(false)
        t:SetMaxLetters(6)
        -- t:SetNumeric(true)
        t:SetScript("OnTextChanged", function() self:UpdateSummary() end)
        t:SetScript("OnChar", mustnumber)
        t:SetScript("OnEnterPressed", t.ClearFocus)


        local b = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
        b:SetNormalTexture("Interface\\Buttons\\LockButton-UnLocked-Up")
        b:SetPushedTexture("Interface\\Buttons\\LockButton-UnLocked-Down")
        b:SetCheckedTexture("Interface\\Buttons\\LockButton-Locked-Up")
        b:SetPoint("RIGHT", t, 30, 0)

        local tooltip = GUI.commtooltip

        b:SetScript("OnEnter", function()
            tooltip:SetOwner(b, "ANCHOR_RIGHT")
            tooltip:SetText(L["Set split into number when team size changes automatically"])
            tooltip:Show()
        end)

        b:SetScript("OnLeave", function()
            tooltip:Hide()
            tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        end)

        t.islocked = function()
            return b:GetChecked()
        end

        self.countEdit = t
    end

    do
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t:SetPoint("BOTTOMLEFT", f, 200, 100)
        local last = -1
        local update = function()
            local n = GetRosterNumber()
            if n == last then
                return
            end
            t:SetText(L["Split into (Current %d)"]:format(n))

            if not self.countEdit.islocked() then
                self.countEdit:SetText(n)
            end

            last = GetRosterNumber()
        end
        update()
        RegEvent("GROUP_ROSTER_UPDATE", update)
        RegEvent("CHAT_MSG_SYSTEM", update) -- fuck above not working
    end
    --

    do
        local b = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        b.text:SetPoint("LEFT", b, "RIGHT", 0, 1)
        b:SetPoint("BOTTOMLEFT", f, 195, 60)
        b.text:SetText(L["Round per member credit down"])
        b:SetScript("OnClick", function() 
            GUI:UpdateSummary() 
            Database:SetConfig("rounddownchecked", b:GetChecked())
        end)
        b:SetChecked(Database:GetConfigOrDefault("rounddownchecked", false))

        self.rouddownCheck = b
    end
    --

    -- sum
    do
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        t:SetPoint("BOTTOMRIGHT", f, -40, 65)
        t:SetJustifyH("RIGHT")

        self.summaryLabel = t
    end

    -- export editbox
    do
        local t = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
        t:SetPoint("TOPLEFT", f, 25, -30)
        t:SetWidth(580)
        t:SetHeight(360)

        local edit = CreateFrame("EditBox", nil, t)
        edit.cursorOffset = 0
        edit:SetWidth(580)
        edit:SetHeight(320)
        edit:SetPoint("TOPLEFT", t, 10, 0)
        edit:SetAutoFocus(false)
        edit:EnableMouse(true)
        edit:SetMaxLetters(99999999)
        edit:SetMultiLine(true)
        edit:SetFontObject(GameTooltipText)
        edit:SetScript("OnTextChanged", function(self)
            ScrollingEdit_OnTextChanged(self, t)
        end)
        edit:SetScript("OnCursorChanged", ScrollingEdit_OnCursorChanged)
        edit:SetScript("OnEscapePressed", edit.ClearFocus)

        self.exportEditbox = edit

        t:SetScrollChild(edit)

        t:Hide()
    end

    -- close btn
    do
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(100)
        b:SetHeight(25)
        b:SetPoint("BOTTOMRIGHT", -40, 15)
        b:SetText(CLOSE)
        b:SetScript("OnClick", function() f:Hide() end)
    end

    -- clear btn
    do
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(100)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 195, 15)
        b:SetText(L["Clear"])
        b:SetScript("OnClick", function()
            StaticPopup_Show("RAIDLEDGER_CLEARMSG")
        end)
    end

    -- credit
    do
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(60)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 40, 95)
        b:SetText("+" .. L["Credit"])
        b:SetScript("OnClick", function()
            Database:AddCredit("")
            ScrollFrame_OnVerticalScroll(self.lootLogFrame.scrollframe, 0) -- move to top
        end)
        
    end

    -- debit
    do

        local applytemplate = function(idx)
            local t = ADDONSELF.GetDebitTemplate(idx)
            if #t == 0 then
                Print(L["Cannot find any debit entry in template, please check your template in options"])
                return
            end

            for _, d in pairs(t) do
                Database:AddDebit(d.reason, "", d.cost, d.costtype)
            end

        end

        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(60)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 100, 95)
        b:SetText("+" .. L["Debit"])
        b:SetScript("OnClick", function()

            if IsControlKeyDown() then
                applytemplate()
            else
                Database:AddDebit(L["Compensation"])
            end

            ScrollFrame_OnVerticalScroll(self.lootLogFrame.scrollframe, 0) -- move to top
        end)

        local tooltip = GUI.commtooltip

        b:SetScript("OnEnter", function()
            tooltip:SetOwner(b, "ANCHOR_RIGHT")
            tooltip:SetText(L["CTRL + Click to apply debit template"])
            tooltip:Show()
        end)

        b:SetScript("OnLeave", function()
            tooltip:Hide()
            tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        end)

        local templateMenu = {
            {
                isTitle = true,
                text = L["Debit Template"],
                notCheckable = true,
            }, -- 0
            {
                text = OPTIONS,
                notCheckable = true,
                func = function()
                    InterfaceOptionsFrame_OpenToCategory(L["Raid Ledger"])
                    InterfaceOptionsFrame_OpenToCategory(L["Raid Ledger"])
                end,
            },            
            { 
                text = "", 
                isTitle = true, 
                notCheckable = true,
            },
            {
                text = CANCEL,
                notCheckable = true,
                func = function(self)
                    CloseDropDownMenus()
                end, 
            },
        }    

        local ba = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        ba:SetWidth(25)
        ba:SetHeight(25)
        ba:SetPoint("LEFT", b, "RIGHT", 0, 0)
        ba:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        do
            local icon = ba:CreateTexture(nil, 'ARTWORK')
            icon:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
            icon:SetPoint('CENTER', 1, 0)
            icon:SetSize(16, 16)
        end

        ba:SetScript("OnClick", function(self, button)

            local templates = Database:GetConfigOrDefault("debittemplates", {})


            if #templates > 0 then

                while #templateMenu > 4 do
                    table.remove(templateMenu, 3)
                end


                table.insert(templateMenu, 3, {
                    text = "", 
                    isTitle = true, 
                    notCheckable = true,
                })

                for i, t in pairs(templates) do
                    local ii = i
                    table.insert(templateMenu, 4, {
                        text = t.name, 
                        notCheckable = true,
                        func = function()
                            applytemplate(ii)
                        end
                    })

                end
            end

            EasyMenu(templateMenu, menuFrame, "cursor", 0 , 0, "MENU");
        end)


    end

    -- options
    do
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(100)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 400, 15)
        b:SetText(OPTIONS)
        b:SetScript("OnClick", function()
            -- tricky may fail first time, show do twice to ensure open the panel
            InterfaceOptionsFrame_OpenToCategory(L["Raid Ledger"])
            InterfaceOptionsFrame_OpenToCategory(L["Raid Ledger"])
        end)
    end

    -- logframe
    do

        local CONVERT = L["#Try to convert to item link"]
        local autoCompleteDebit = function(text)
            text = string.upper(text)

            local data = {}

            for _, name in pairs({
                L["Compensation: Tank"],
                L["Compensation: Healer"],
                L["Compensation: Repait Bot"],
                L["Compensation: DPS"],
                L["Compensation: Other"],
            }) do
                local b = text == ""
                b = b or (text == "#ONFOCUS")
                b = b or (strfind(string.upper(name), text))

                if b then
                    tinsert(data, {
                        ["name"] = name,
                        ["priority"] = LE_AUTOCOMPLETE_PRIORITY_IN_GROUP,
                    })
                end
            end

            return data
        end

        local autoCompleteCredit = function(text)
            local data = {}

            txt = strtrim(txt or "")
            txt = strtrim(txt, "[]")
            local name = GetItemInfo(text)

            if name then
                tinsert(data, {
                    ["name"] = CONVERT,
                    ["priority"] = LE_AUTOCOMPLETE_PRIORITY_IN_GROUP,
                })
            end

            return data
        end

        local lastchat = {}
        local onraidchat = function(text, playerName)
            playerName = strsplit("-", playerName)
            lastchat[playerName] = time()

            local min = playerName
            for p in pairs(lastchat) do
                if lastchat[p] < lastchat[min] then
                    min = p
                end
            end

            if #lastchat > 10 then
                lastchat[min] = nil
            end
        end

        RegEvent("CHAT_MSG_RAID_LEADER", onraidchat)
        RegEvent("CHAT_MSG_RAID", onraidchat)

        local autoCompleteRaidRoster = function(text)
            local data = {}
            local tmp = {}

            if strbyte(text) == strbyte("%") then
                return data
            end

            for i = 1, MAX_RAID_MEMBERS do
                local name, _, subgroup, _, class = GetRaidRosterInfo(i)

                if name then
                    local namelower = string.lower(name)
                    class = string.lower(class)

                    local b = text == ""
                    b = b or (text == "#ONFOCUS")
                    b = b or (strfind(namelower, string.lower(text)))
                    b = b or (tonumber(text) == subgroup)
                    b = b or (strfind(class, string.lower(text)))

                    if b then
                        tinsert(tmp, name)
                    end
                end
            end

            table.sort(tmp, function(a, b)
                return (lastchat[a] or 0) > (lastchat[b] or 0)
            end)

            for _, name in pairs(tmp) do 
                tinsert(data, {
                    ["name"] = name,
                    ["priority"] = LE_AUTOCOMPLETE_PRIORITY_IN_GROUP,
                })
            end

            return data
        end

        local popOnFocus = function(edit)
            edit:SetScript("OnTextChanged", function(self, userInput)

                AutoCompleteEditBox_OnTextChanged(self, userInput)

                local t = self:GetText()

                edit.customTextChangedCallback(t)

                if t == "" then
                    t = "#ONFOCUS"
                end
                AutoComplete_Update(self, t, 1);
            end)

            edit:SetScript("OnEditFocusGained", function(self)
                local t = self:GetText()
                if t == "" then
                    t = "#ONFOCUS"
                end
                AutoComplete_Update(self, t, 1);
            end)
        end

        local bidframe = self.bidframe
        local bidClick = function(self)

            if bidframe:IsShown() then
                return
            end

            local entry = self:GetParent().curEntry

            local item = entry["detail"]["item"] or entry["detail"]["displayname"]

            if item and item ~= "" then
                bidframe.SetItem(item, entry["detail"]["count"])
                bidframe.curEntry = entry
                bidframe:Show()
            end
        end

        local iconUpdate = CreateCellUpdate(function(cellFrame, entry, idx, rowFrame)
            local tooltip = self.itemtooltip
            
            cellFrame.curEntry = entry

            if not cellFrame.cellItemTexture then
                cellFrame.cellItemTexture = cellFrame:CreateTexture()
                cellFrame.cellItemTexture:SetTexCoord(0, 1, 0, 1)
                cellFrame.cellItemTexture:Show()
                cellFrame.cellItemTexture:SetPoint("CENTER", cellFrame.cellItemTexture:GetParent(), "CENTER")
                cellFrame.cellItemTexture:SetWidth(30)
                cellFrame.cellItemTexture:SetHeight(30)
            end

            if not cellFrame.counttext then
                cellFrame.counttext = cellFrame:CreateFontString(nil, 'OVERLAY')
                cellFrame.counttext:SetFontObject('NumberFontNormal')
                cellFrame.counttext:SetPoint('BOTTOMRIGHT', -10, 3)
                cellFrame.counttext:SetJustifyH('RIGHT')
            end

            if not cellFrame.lockcheck then
                cellFrame.lockcheck = CreateFrame("CheckButton", nil, cellFrame, "UICheckButtonTemplate")
                cellFrame.lockcheck:SetNormalTexture("Interface\\Buttons\\LockButton-UnLocked-Up")
                cellFrame.lockcheck:SetPushedTexture("Interface\\Buttons\\LockButton-UnLocked-Down")
                cellFrame.lockcheck:SetCheckedTexture("Interface\\Buttons\\LockButton-Locked-Up")
                cellFrame.lockcheck:SetPoint("LEFT", cellFrame, "LEFT", -20, 0)

                cellFrame.lockcheck:SetScript("OnClick", function()
                    
                    for _, c in pairs(rowFrame.cols) do
                        if c.textBox then
                            if cellFrame.lockcheck:GetChecked() then
                                c.textBox:Disable()
                                cellFrame.curEntry["lock"] = true
                            else
                                c.textBox:Enable()
                                cellFrame.curEntry["lock"] = false
                            end
                        end
                    end

                    GUI:UpdateLootTableFromDatabase()
                end)
            end

            if not cellFrame.stackHook then
                cellFrame.SplitStack = function(owner, split)
                    local cur = owner.curEntry

                    if IsShiftKeyDown() then
                        local left = math.max(1, cur["detail"]["count"] - split)
                        cur["detail"]["count"] = left
                        owner.counttext:SetText(left)

                        Database:AddLoot(cur["detail"]["item"], split, cur["beneficiary"], 0, true)
                    else
                        cur["detail"]["count"] = split
                        owner.counttext:SetText(split)
                    end
                end
                
                cellFrame:SetScript("OnClick", function()
                    if cellFrame.curEntry["detail"]["type"] == "ITEM" then
                        OpenStackSplitFrame(999, cellFrame, "BOTTOMLEFT", "TOPLEFT", 1)
                        StackSplitText:SetText(cellFrame.curEntry["detail"]["count"])
                        StackSplitFrame.split = cellFrame.curEntry["detail"]["count"]
                        UpdateStackSplitFrame(999)
                    end
                end)

                cellFrame.stackHook = true
            end


            cellFrame.lockcheck:SetChecked(entry["lock"])

            for _, c in pairs(rowFrame.cols) do
                if c.textBox then
                    if cellFrame.lockcheck:GetChecked() then
                        c.textBox:Disable()
                    else
                        c.textBox:Enable()
                    end
                end
            end

            cellFrame:SetScript("OnEnter", nil)
            cellFrame.counttext:Hide()

            if entry["type"] == "DEBIT" then
                cellFrame.cellItemTexture:SetTexture(135768) -- minus
            else
                cellFrame.cellItemTexture:SetTexture(135769) -- plus
            end

            local detail = entry["detail"]
            if detail["type"] == "ITEM" then
                local itemTexture =  GetItemIcon(detail["item"])
                local _, itemLink = GetItemInfo(detail["item"])

                if itemTexture then
                    cellFrame.cellItemTexture:SetTexture(itemTexture)
                end

                if itemLink then
                    cellFrame:SetScript("OnEnter", function()
                        tooltip:SetOwner(cellFrame, "ANCHOR_RIGHT")
                        tooltip:SetHyperlink(itemLink)
                        tooltip:Show()
                    end)

                    cellFrame:SetScript("OnLeave", function()
                        tooltip:Hide()
                        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
                    end)

                end

                if detail["count"] then
                    cellFrame.counttext:SetText(detail["count"])
                    cellFrame.counttext:Show()
                end
            end
        end)

        local entryUpdate = CreateCellUpdate(function(cellFrame, entry)

            if not (cellFrame.textBox) then
                cellFrame.textBox = CreateFrame("EditBox", nil, cellFrame, "InputBoxTemplate,AutoCompleteEditBoxTemplate")
                cellFrame.textBox:SetPoint("CENTER", cellFrame, "CENTER", -20, 0)
                cellFrame.textBox:SetWidth(120)
                cellFrame.textBox:SetHeight(30)
                cellFrame.textBox:SetAutoFocus(false)
                cellFrame.textBox:SetScript("OnEscapePressed", cellFrame.textBox.ClearFocus)
                cellFrame.textBox:SetScript("OnEnterPressed", cellFrame.textBox.ClearFocus)
                popOnFocus(cellFrame.textBox)

                if entry["lock"] then
                    cellFrame.textBox:Disable()
                end
            end

            cellFrame.textBox:Hide()

            local detail = entry["detail"]
            if detail["type"] == "ITEM" then
                local _, itemLink = GetItemInfo(detail["item"])
                if itemLink then
                    cellFrame.text:SetText(itemLink)
                    return
                end
            end

            if entry["type"] == "DEBIT" then
                cellFrame.text:SetText(L["Debit"])
                AutoCompleteEditBox_SetAutoCompleteSource(cellFrame.textBox, autoCompleteDebit)
            else
                cellFrame.text:SetText(L["Credit"])
                AutoCompleteEditBox_SetAutoCompleteSource(cellFrame.textBox, autoCompleteCredit)
            end

            cellFrame.textBox.customTextChangedCallback = function(t)
                entry["detail"]["displayname"] = t
            end

            -- TODO optimize
            cellFrame.textBox.customAutoCompleteFunction = function(editBox, newText, info)
                local n = newText ~= "" and newText or info.name

                if n ~= "" then
                    if entry["type"] ~= "DEBIT" and n == CONVERT then
                        local txt = editBox:GetText()
                        txt = strtrim(txt)
                        txt = strtrim(txt, "[]")
                        local _, itemLink = GetItemInfo(txt)

                        if itemLink then
                            entry["detail"]["item"] = itemLink
                            entry["detail"]["displayname"] = nil
                            entry["detail"]["type"] = "ITEM"
                            self:UpdateLootTableFromDatabase()
                        else
                            Print(L["convert failed, text can be either item id or item name"])
                        end

                        return true
                    end

                    cellFrame.textBox:SetText(n)
                    entry["detail"]["displayname"] = n
                end

                return true
            end

            cellFrame.textBox:Show()
            cellFrame.textBox:SetText(detail["displayname"] or "")
        end)

        local beneficiaryUpdate = CreateCellUpdate(function(cellFrame, entry)
            if not cellFrame.textBox then
                cellFrame.textBox = CreateFrame("EditBox", nil, cellFrame, "InputBoxTemplate,AutoCompleteEditBoxTemplate")
                cellFrame.textBox:SetPoint("CENTER", cellFrame, "CENTER", -20, 0)
                cellFrame.textBox:SetWidth(120)
                cellFrame.textBox:SetHeight(30)
                cellFrame.textBox:SetAutoFocus(false)
                cellFrame.textBox:SetScript("OnEscapePressed", cellFrame.textBox.ClearFocus)
                cellFrame.textBox:SetScript("OnEnterPressed", cellFrame.textBox.ClearFocus)
                cellFrame.textBox.raidledgerbeneficiary = true

                AutoCompleteEditBox_SetAutoCompleteSource(cellFrame.textBox, autoCompleteRaidRoster)
                popOnFocus(cellFrame.textBox)

                if entry["lock"] then
                    cellFrame.textBox:Disable()
                end                
            end

            if not cellFrame.bidButton then
                cellFrame.bidButton = CreateFrame("Button", nil, cellFrame, "GameMenuButtonTemplate")
                cellFrame.bidButton:SetPoint("LEFT", cellFrame.textBox, "RIGHT", 10, 0)
                cellFrame.bidButton:SetSize(25, 25)
                cellFrame.bidButton:SetScript("OnClick", bidClick)
                local icon = cellFrame.bidButton:CreateTexture(nil, 'ARTWORK')
                icon:SetTexture("Interface\\GroupFrame\\UI-Group-MasterLooter")
                icon:SetPoint("CENTER", -1, 0)
                icon:SetSize(15, 15)
            end

            cellFrame.textBox.customTextChangedCallback = function(t)
                entry["beneficiary"] = t
            end

            cellFrame.textBox.customAutoCompleteFunction = function(editBox, newText, info)
                local n = newText ~= "" and newText or info.name

                if n ~= "" then
                    cellFrame.textBox:SetText(n)
                    entry["beneficiary"] = n
                end

                return true
            end

            cellFrame.curEntry = entry
            cellFrame.textBox:SetText(entry.beneficiary or "")
            cellFrame.bidButton:Hide()

            if entry["type"] == "CREDIT" then
                cellFrame.bidButton:Show()
            end
        end)


        local valueTypeMenuCtx = {}
        local setCostType = function(t)
            local entry = valueTypeMenuCtx.entry
            entry["costtype"] = t
            self:UpdateLootTableFromDatabase()
        end

        local valueTypeMenu = {
            {   
                costtype = "GOLD",
                text = GOLD_AMOUNT_TEXTURE_STRING:format(""), 
                func = function() 
                    setCostType("GOLD")
                end, 
            },
            { 
                costtype = "PROFIT_PERCENT",
                text =  DIM_GREEN_FONT_COLOR:WrapTextInColorCode(" % " .. L["Net Profit"]), 
                func = function() 
                    setCostType("PROFIT_PERCENT")
                end, 
            },
            { 
                costtype = "REVENUE_PERCENT",
                text = LIGHTBLUE_FONT_COLOR:WrapTextInColorCode(" % " .. L["Revenue"]), 
                func = function() 
                    setCostType("REVENUE_PERCENT")
                end, 
            },
            { 
                costtype = "MUL_AVG",
                text = " * " .. L["Per Member credit"], 
                func = function() 
                    setCostType("MUL_AVG")
                end, 
            },
            { 
                text = "", 
                isTitle = true, 
            },
            {
                text = CANCEL,
                notCheckable = true,
                func = function(self)
                    CloseDropDownMenus()
                end, 
            },
        }        


        local valueUpdate = CreateCellUpdate(function(cellFrame, entry)
            local tooltip = self.commtooltip
            if not (cellFrame.textBox) then
                cellFrame.textBox = CreateFrame("EditBox", nil, cellFrame, "InputBoxTemplate")
                cellFrame.textBox:SetPoint("CENTER", cellFrame, "CENTER")
                cellFrame.textBox:SetWidth(70)
                cellFrame.textBox:SetHeight(30)
                -- cellFrame.textBox:SetNumeric(true)
                cellFrame.textBox:SetAutoFocus(false)
                cellFrame.textBox:SetMaxLetters(10)
                cellFrame.textBox:SetScript("OnChar", mustnumber)
                cellFrame.textBox:SetScript("OnEnterPressed", cellFrame.textBox.ClearFocus)
                cellFrame.textBox:SetScript("OnEscapePressed", cellFrame.textBox.ClearFocus)

                if entry["lock"] then
                    cellFrame.textBox:Disable()
                end
            end
            cellFrame.textBox:SetText(tostring(entry["cost"] or 0))

            local type = entry["costtype"] or "GOLD"

            if type == "PROFIT_PERCENT" then
                cellFrame.text:SetText(DIM_GREEN_FONT_COLOR:WrapTextInColorCode("%"))
            elseif type == "REVENUE_PERCENT" then
                cellFrame.text:SetText(LIGHTBLUE_FONT_COLOR:WrapTextInColorCode("%"))
            elseif type == "MUL_AVG" then
                cellFrame.text:SetText("*")
            else
                -- GOLD by default
                cellFrame.text:SetText(GOLD_AMOUNT_TEXTURE_STRING:format(""))
            end

            cellFrame:SetScript("OnClick", nil)
            cellFrame:SetScript("OnEnter", nil)

            if entry["type"] == "DEBIT" then
                cellFrame:SetScript("OnClick", function()
                    valueTypeMenuCtx.entry = entry
                    for _, m in pairs(valueTypeMenu) do
                        m.checked = m.costtype == type
                    end
                
                    EasyMenu(valueTypeMenu, menuFrame, "cursor", 0 , 0, "MENU");
                end)

            end

            if entry["costcache"] then
                cellFrame:SetScript("OnEnter", function()
                    tooltip:SetOwner(cellFrame, "ANCHOR_RIGHT")
                    tooltip:SetText(GetMoneyString(entry["costcache"]))
                    tooltip:Show()
                end)

                cellFrame:SetScript("OnLeave", function()
                    tooltip:Hide()
                    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
                end)
            end

            cellFrame.textBox:SetScript("OnTextChanged", function(self, userInput)
                local t = cellFrame.textBox:GetText()
                local v = tonumber(t) or 0

                if entry["cost"] == v then
                    return
                end

                if v < 0.0001 then
                    v = 0
                end

                entry["cost"] = v
                GUI:UpdateLootTableFromDatabase()
            end)

        end)

        self.lootLogFrame = ScrollingTable:CreateST({
            {
                ["name"] = "",
                ["width"] = 1,
            },
            {
                ["name"] = "",
                ["width"] = 50,
                ["DoCellUpdate"] = iconUpdate,
            },
            {
                ["name"] = L["Entry"],
                ["width"] = 250,
                ["DoCellUpdate"] = entryUpdate,
            },
            {
                ["name"] = L["Beneficiary"],
                ["width"] = 150,
                ["DoCellUpdate"] = beneficiaryUpdate,
            },
            {
                ["name"] = L["Value"],
                ["width"] = 100,
                ["align"] = "RIGHT",
                ["DoCellUpdate"] = valueUpdate,
            }
        }, 12, 30, nil, f)

        self.lootLogFrame.head:SetHeight(15)
        self.lootLogFrame.frame:SetPoint("TOPLEFT", f, "TOPLEFT", 30, -50)

        self.lootLogFrame:RegisterEvents({
            ["OnClick"] = function (rowFrame, cellFrame, data, cols, row, realrow, column, sttable, button, ...)
                clearAllFocus()
                local entry, idx = GetEntryFromUI(rowFrame, cellFrame, data, cols, row, realrow, column, sttable)

                if not entry then
                    return
                end

                if button == "RightButton" then
                    StaticPopupDialogs["RAIDLEDGER_DELETE_ITEM"].text = L["Remove this record?"]

                    if IsShiftKeyDown() then
                        StaticPopupDialogs["RAIDLEDGER_DELETE_ITEM"].text = L["Remove ALL SAME record?"]

                        StaticPopupDialogs["RAIDLEDGER_DELETE_ITEM"].OnAccept = function()
                            StaticPopup_Hide("RAIDLEDGER_DELETE_ITEM")
                            -- Database:RemoveEntry(idx)

                            local detail = entry["detail"]
                            if detail["type"] == "ITEM" then
                                local _, itemLink = GetItemInfo(detail["item"])
                                RemoveAll(itemLink)
                            end

                        end
                    else
                        StaticPopupDialogs["RAIDLEDGER_DELETE_ITEM"].OnAccept = function()
                            StaticPopup_Hide("RAIDLEDGER_DELETE_ITEM")
                            Database:RemoveEntry(idx)
                        end
                    end

                    StaticPopup_Show("RAIDLEDGER_DELETE_ITEM")
                else
                    ChatEdit_InsertLink(entry["detail"]["item"])
                end
            end,

            ["OnDoubleClick"] = function (rowFrame, cellFrame, data, cols, row, realrow, column, sttable, button, ...)
                local item, idx = GetEntryFromUI(rowFrame, cellFrame, data, cols, row, realrow, column, sttable)

                if not item then
                    return
                end

                SendChatMessage(ADDONSELF.GenExportLine(item, item["costcache"], true), f.reportopt.channel)

            end,
        })
    end


    -- report btn
    do
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(120)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 40, 15)
        b:SetText(RAID)
        b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        do
            local icon = b:CreateTexture(nil, 'ARTWORK')
            icon:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ArmoryChat")
            icon:SetPoint('TOPLEFT', 10, -5)
            icon:SetSize(16, 16)
        end

        local ba = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        ba:SetWidth(25)
        ba:SetHeight(25)
        ba:SetPoint("LEFT", b, "RIGHT", 0, 0)
        ba:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        do
            local icon = ba:CreateTexture(nil, 'ARTWORK')
            icon:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
            icon:SetPoint('CENTER', 1, 0)
            icon:SetSize(16, 16)
        end

        local optctx = {
            channel = "RAID",
            filterzero = Database:GetConfigOrDefault("filterzero", false),
        }

        f.reportopt = optctx

        local setReportChannel = function(self)
            optctx.channel = self.arg1
            b:SetText(self.value)
            CloseDropDownMenus()
        end
    
        local reportChannelChecked = function(self)
            return self.arg1 == optctx.channel
        end

        local channelTypeMenu = {
            {
                isTitle = true,
                text = CHANNEL,
                notCheckable = true,
            }, -- 0
            { 
                text = CHANNEL, 
                hasArrow = true,
                notCheckable = true,
                menuList = {
                    {   
                        arg1 = "RAID",
                        text = RAID, 
                        func = setReportChannel, 
                        checked = reportChannelChecked,
                    },
                    {   
                        arg1 = "GUILD",
                        text = GUILD, 
                        func = setReportChannel, 
                        checked = reportChannelChecked,
                    },
                    {   
                        arg1 = nil,
                        text = L["Last used"], 
                        func = setReportChannel, 
                        checked = reportChannelChecked,
                    },
                } 
            }, -- 1
            {
                isTitle = true,
                text = L["Report"],
                notCheckable = true,
            },
            {
                text = L["Summary"], 
                func = function()
                    GenReport(Database:GetCurrentLedger()["items"], GUI:GetSplitNumber(), optctx.channel, {
                        short = true,
                        filterzero = optctx.filterzero,
                        rounddown = GUI.rouddownCheck:GetChecked(),
                    })
                end, 
                notCheckable = true,
            },
            {
                text = L["Subgroup total"], 
                func = function()

                    local c = 0
                    local groups = {}
    
                    for i = 1, MAX_RAID_MEMBERS do
                        local name, _, subgroup = GetRaidRosterInfo(i)
                        if name then
                            groups[subgroup] = (groups[subgroup] or {
                                members = {},
                                assist = nil,
                            })

                            local rt = GetRaidTargetIndex("raid" .. i)
                            if not groups[subgroup].assist and rt then
                                groups[subgroup].assist = " {rt" .. i .. "} " .. UnitName("raid" .. i) .. " {rt" .. i .. "} "
                            end
                            
                            groups[subgroup].members[name] = true
                        end
                    end
    
                    local specials = {}
                    local _, avg = calcavg(Database:GetCurrentLedger()["items"], GUI:GetSplitNumber(), nil, function(entry, cost)
                        local b = entry["beneficiary"]

                        specials[b] = specials[b] or 0
                        specials[b] = specials[b] + cost
                    end, {
                        rounddown = GUI.rouddownCheck:GetChecked(),
                    })

                    local lines = {}
                    table.insert(lines, L["Per Member"] .. ": " .. GetMoneyStringL(avg))

                    for i, g in pairs(groups) do

                        local teamtotal = 0

                        for m in pairs(g.members) do
                            teamtotal = teamtotal + avg
                            if specials[m] and specials[m] > 0 then
                                teamtotal = teamtotal + specials[m]
                            end
                        end

                        table.insert(lines, GROUP .. i .. " " .. (g.assist and g.assist or "") .. " " .. L["Subgroup total"] .. ": " .. GetMoneyStringL(teamtotal))

                        for m in pairs(g.members) do
                            if specials[m] and specials[m] > 0 then
                                table.insert(lines, "  ... " .. m .. " " .. GetMoneyStringL(avg) .. " + " .. GetMoneyStringL(specials[m]) .. " = " .. GetMoneyStringL(avg + specials[m]))
                            end
                        end
                    end

                    table.insert(lines, L["Per Member"] .. ": " .. GetMoneyStringL(avg))
    
                    SendToChatSlowly(lines, optctx.channel)
                end, 
                notCheckable = true,
            },
            {
                text = L["0 credit items"], 
                func = function()
                    local items = Database:GetCurrentLedger()["items"]
                    local lines = {}
                    local countby = {}

                    for _, item in pairs(items or {}) do
                        local c = item["cost"] or 0
                        local t = item["type"]
                        local cnt = item["detail"]["count"] or 1

                        if t == "CREDIT" and c == 0 then
                            local i = item["detail"]["item"] or ""
                            local cnt = item["detail"]["count"] or 1
                            local d = item["detail"]["displayname"] or ""
                            if not GetItemInfoFromHyperlink(i) then
                                i = d
                            end

                            if i ~= "" then
                                countby[i] = countby[i] or 0
                                countby[i] = countby[i] + cnt
                            end

                        end
                    end

                    for i, c in pairs(countby) do
                        table.insert(lines, i .. " * " .. c)
                    end

                    SendToChatSlowly(lines, optctx.channel)
                end, 
                notCheckable = true,
            },
            {
                text = L["Credit"], 
                func = function()
                    local lines = {}
                    local _, _, revenue = calcavg(Database:GetCurrentLedger()["items"], GUI:GetSplitNumber(), function(item, cost)

                        if cost > 0 then
                            table.insert(lines, ADDONSELF.GenExportLine(item, cost, true))
                        end

                    end, nil, {
                        rounddown = GUI.rouddownCheck:GetChecked(),
                    })

                    revenue = GetMoneyStringL(revenue)
                    table.insert(lines, L["Revenue"] .. ": " .. revenue)

                    SendToChatSlowly(lines, optctx.channel)
                    
                end, 
                notCheckable = true,
            },
            {
                text = L["Debit"], 
                func = function()
                    GenReport(Database:GetCurrentLedger()["items"], GUI:GetSplitNumber(), optctx.channel, {
                        expenseonly = true,
                    })
                end, 
                notCheckable = true,
            },
            {
                isTitle = true,
                text = OPTIONS,
                notCheckable = true,
            },
            {
                text = FILTER .. " " .. L["0 credit items"], 
                isNotRadio = true,
                func = function(self)
                    optctx.filterzero = not optctx.filterzero
                    Database:SetConfig("filterzero", optctx.filterzero)
                end, 
                checked = function(self)
                    return optctx.filterzero
                end
            },
            { 
                text = "", 
                isTitle = true, 
            },
            {
                text = CANCEL,
                notCheckable = true,
                func = function(self)
                    CloseDropDownMenus()
                end, 
            },
        }        

        b:SetScript("OnClick", function(self, button)
            if button == "RightButton" then
                EasyMenu(channelTypeMenu, menuFrame, "cursor", 0 , 0, "MENU");
            else
                GenReport(Database:GetCurrentLedger()["items"], GUI:GetSplitNumber(), optctx.channel, {
                    short = IsControlKeyDown(),
                    filterzero = optctx.filterzero,
                    rounddown = GUI.rouddownCheck:GetChecked(),
                })
            end
        end)

        ba:SetScript("OnClick", function(self, button)
            EasyMenu(channelTypeMenu, menuFrame, "cursor", 0 , 0, "MENU");
        end)

        local tooltip = GUI.commtooltip

        b:SetScript("OnEnter", function()
            tooltip:SetOwner(b, "ANCHOR_RIGHT")
            tooltip:SetText(L["Right click to choose channel"] .. "\r\n" .. L["CTRL + click for summary mode"])
            tooltip:Show()
        end)

        b:SetScript("OnLeave", function()
            tooltip:Hide()
            tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        end)        
    end

    -- export btn
    do
        local lootLogFrame = self.lootLogFrame
        local exportEditbox = self.exportEditbox
        local countEdit = self.countEdit
        local hidelockedCheck = self.hidelockedCheck
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")

        b:SetWidth(120)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 40, 60)
        b:SetText(L["Export as text"])

        local onclick = function(opt, force)
            if exportEditbox:GetParent():IsShown() and not force then
                lootLogFrame:Show()
                countEdit:Enable()
                hidelockedCheck:Show()
                exportEditbox:GetParent():Hide()
                b:SetText(L["Export as text"])
            else
                lootLogFrame:Hide()
                countEdit:Disable()
                hidelockedCheck:Hide()
                exportEditbox:GetParent():Show()
                b:SetText(L["Close text export"])
            end

            exportEditbox:SetText(GenExport(Database:GetCurrentLedger()["items"], GUI:GetSplitNumber(), opt))
        end

        b:SetScript("OnClick", function()
            onclick({
                rounddown = self.rouddownCheck:GetChecked()
            })
        end)

        local formatMenu = {
            {
                isTitle = true,
                text = L["Export as text"],
                notCheckable = true,
            }, -- 0
            {
                text = L["Excel csv"],
                notCheckable = true,
                func = function()
                    onclick({
                        format = "csv"
                    }, true)
                end,
            },            
            { 
                text = "", 
                isTitle = true, 
                notCheckable = true,
            },
            {
                text = CANCEL,
                notCheckable = true,
                func = function(self)
                    CloseDropDownMenus()
                end, 
            },
        }    
        
        local ba = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        ba:SetWidth(25)
        ba:SetHeight(25)
        ba:SetPoint("LEFT", b, "RIGHT", 0, 0)
        ba:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        do
            local icon = ba:CreateTexture(nil, 'ARTWORK')
            icon:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
            icon:SetPoint('CENTER', 1, 0)
            icon:SetSize(16, 16)
        end

        ba:SetScript("OnClick", function(self, button)
            EasyMenu(formatMenu, menuFrame, "cursor", 0 , 0, "MENU");
        end)        
    end

end

RegEvent("VARIABLES_LOADED", function()
    GUI:UpdateLootTableFromDatabase()
end)

RegEvent("ADDON_LOADED", function()
    GUI:Init()
    Database:RegisterChangeCallback(function()
        GUI:UpdateLootTableFromDatabase()
    end)

    GUI:UpdateLootTableFromDatabase()

    -- raid frame handler

    do
        local hooked = false

        hooksecurefunc("RaidFrame_LoadUI", function()
            if hooked then
                return
            end

            local tooltip = GUI.commtooltip

            local enter = function(l, idx)
                tooltip:SetOwner(l, "ANCHOR_TOP")

                local c = 0
                local members = {}

                for i = 1, MAX_RAID_MEMBERS do
                    local name, _, subgroup, _, _, classFilename = GetRaidRosterInfo(i)
                    if name and subgroup == idx then
                        local _, _, _, colorCode = GetClassColor(classFilename);
                        members[name] = {
                            text = WrapTextInColorCode(name, colorCode),
                            cost = 0,
                        }
                        c = c + 1
                    end
                end

                local special = false
                local teamtotal = 0
                local _, avg = calcavg(Database:GetCurrentLedger()["items"], GUI:GetSplitNumber(), nil, function(entry, cost)
                    local b = entry["beneficiary"]

                    if members[b] then
                        special = true
                        members[b].cost = members[b].cost + cost
                        teamtotal = teamtotal + cost
                    end
                end, {
                    rounddown = GUI.rouddownCheck:GetChecked(),
                })

                teamtotal = teamtotal + c * avg

                if c > 0 then
                    tooltip:SetText(L["Member credit for subgroup"])
                    tooltip:AddLine(L["Subgroup total"] .. ": " .. GetMoneyString(teamtotal))
                    tooltip:AddLine(L["Per Member"] .. ": " .. GetMoneyString(avg))

                    if special then
                        tooltip:AddLine(L["Special Members"])
                        for _, member in pairs(members) do
                            if member.cost > 0 then
                                tooltip:AddLine(member.text .. ": " .. GetMoneyString(avg + member.cost) )
                            end
                        end

                    end

                    tooltip:Show()
                end
            end

            local leave = function()
                tooltip:Hide()
                tooltip:SetOwner(UIParent, "ANCHOR_NONE")
            end

            for i = 1, NUM_RAID_GROUPS do
                local l = _G["RaidGroup" .. i .."Label"]
                if l then
                    l:SetScript("OnEnter", function() enter(l, i) end)
                    l:SetScript("OnLeave", leave)
                end
            end

            hooked = true
        end)
    end
end)

StaticPopupDialogs["RAIDLEDGER_CLEARMSG"] = {
    text = L["Remove all records?"],
    button1 = ACCEPT,
    button2 = CANCEL,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    multiple = 0,
    OnAccept = function()
        Database:NewLedger()
    end,
}

StaticPopupDialogs["RAIDLEDGER_DELETE_ITEM"] = {
    text = L["Remove this record?"],
    button1 = ACCEPT,
    button2 = CANCEL,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    multiple = 0,
}
