local _, ADDONSELF = ...

local L = ADDONSELF.L
local GUI = ADDONSELF.gui
local Database = ADDONSELF.db
local Print = ADDONSELF.print
local deformat = ADDONSELF.deformat
local RegEvent = ADDONSELF.regevent

hooksecurefunc("SetItemRef", function(link)
    if GUI.mainframe:IsShown() and IsShiftKeyDown() then
        local linkType, target = strsplit(":", link)

        if linkType == "item" then
            -- local _, itemLink = GetItemInfo(target)
            -- if itemLink then
            --     Print(L["Item added"] .. " " .. itemLink)
            --     Database:AddLoot(itemLink, 1, "", 0, true)
            -- end
        elseif linkType == "player" then
            local playerName = strsplit("-", target)
            Print(L["Compensation added"] .. " " .. playerName)

            local edit = GetCurrentKeyBoardFocus()

            if edit and edit.raidledgerbeneficiary then
                edit:SetText(playerName)
            else
                Database:AddDebit("", playerName)
            end
        end
        ScrollFrame_OnVerticalScroll(GUI.lootLogFrame.scrollframe, 0)
    end
end)

do
    local lasttime = 0
    local lastlink = nil

    hooksecurefunc("HandleModifiedItemClick", function(link)
        if lastlink == link then
            if time() - lasttime < 2 then
                return
            end
        end

        if GUI.mainframe:IsShown() and not ChatEdit_GetActiveWindow() then
            local _, itemLink = GetItemInfo(link)
            if itemLink then
                Print(L["Item added"] .. " " .. itemLink)
                Database:AddLoot(itemLink, 1, "", 0, true)
            end

            lasttime = time()
            lastlink = link
        end
    end)
end

local AUTOADDLOOT_TYPE_ALL = 0
-- local AUTOADDLOOT_TYPE_PARTY = 1
local AUTOADDLOOT_TYPE_RAID = 1
local AUTOADDLOOT_TYPE_DISABLE = 2

-- local AutoAddLoot = AUTOADDLOOT_TYPE_RAID

RegEvent("CHAT_MSG_LOOT", function(chatmsg)
    local AutoAddLoot = Database:GetConfigOrDefault("autoaddloot", AUTOADDLOOT_TYPE_RAID)
    if AutoAddLoot == AUTOADDLOOT_TYPE_DISABLE then
        return
    elseif AutoAddLoot == AUTOADDLOOT_TYPE_RAID and not IsInRaid() then
        return
    end

    local playerName, itemLink, itemCount = deformat(chatmsg, LOOT_ITEM_MULTIPLE);
    -- next try: somebody else received single loot
    if (playerName == nil) then
        itemCount = 1;
        playerName, itemLink = deformat(chatmsg, LOOT_ITEM);
    end
    -- if player == nil, then next try: player received multiple loot
    if (playerName == nil) then
        playerName = UnitName("player");
        itemLink, itemCount = deformat(chatmsg, LOOT_ITEM_SELF_MULTIPLE);
    end
    -- if itemLink == nil, then last try: player received single loot
    if (itemLink == nil) then
        itemCount = 1;
        itemLink = deformat(chatmsg, LOOT_ITEM_SELF);
    end
    -- if itemLink == nil, then there was neither a LOOT_ITEM, nor a LOOT_ITEM_SELF message
    if (itemLink == nil) then
        -- MRT_Debug("No valid loot event received.");
        return;
    end
    -- if code reaches this point, we should have a valid looter and a valid itemLink
    -- print(itemLink)
    Database:AddLoot(itemLink, itemCount, playerName, 0);
end)

RegEvent("ADDON_LOADED", function()
    local ldb = LibStub("LibDataBroker-1.1")
    local icon = LibStub("LibDBIcon-1.0")

    local config = Database:GetConfigOrDefault("minimapicons", {})
    config.hide = not Database:GetConfigOrDefault("minimapicon", true)
    Database:SetConfig("minimapicons", config)

    icon:Register("RaidLedger", ldb:NewDataObject("RaidLedger", {
            icon = "Interface\\Icons\\inv_misc_note_03",
            OnClick = function() 
                if GUI.mainframe:IsShown() then
                    GUI.mainframe:Hide()
                else
                    GUI.mainframe:Show()
                end
            end,
            OnTooltipShow = function(tooltip)
                tooltip:AddLine(L["Raid Ledger"])
            end,
        }),  config)
end)

local clearledger = function()
    StaticPopup_Show("RAIDLEDGER_CLEARMSG")
end


do
    -- some pharc addon overwrite AlertFrame
    local frame = EnumerateFrames()
    while frame do
        if frame:GetName() == "AlertFrame" then

            local cleartoast = frame:AddSimpleAlertFrameSubSystem("MoneyWonAlertFrameTemplate", function(frame, text)

                frame.Icon:SetTexture("Interface\\Icons\\inv_misc_note_03")
                frame.Label:SetText(L["Raid Ledger"])
                frame.Amount:SetText(L["Click here to clear ledger"])
                frame.Amount:SetWidth(180)
                frame.Amount:SetFontObject(GameFontWhite)
                frame:SetScript("OnClick", clearledger)

                if not frame.closebtn then
                    b = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
                    b:SetPoint("TOPRIGHT", frame, 0, 0);
                    frame.closebtn = b
                end

            end)

            local lastzone = nil

            C_Timer.NewTicker(5, function()

                local zone = GetInstanceInfo()
                if not zone then
                    return
                end

                if zone == "" then
                    return
                end

                local _, type = IsInInstance()

                if type == "raid" then

                    if lastzone ~= zone then
                        if #Database:GetCurrentLedger()["items"] > 0 then
                            cleartoast:AddAlert()
                        end
                    end

                end

                lastzone = zone

            end)


            break
        end
        frame = EnumerateFrames(frame)
    end
end

SlashCmdList["RAIDLEDGER"] = function(msg, editbox)
    local cmd, what = msg:match("^(%S*)%s*(%S*)%s*$")

    if cmd == "" then
        GUI:Show()

        Print(L["Shift + item/name to add to record"])
        Print(L["Right click to remove record"])
        -- Print(L["Shift + Right click to remove ALL SAME record"])
        -- ShowCurrentAutoLootType()
        -- Print("[".. L["/raidledger"] .. " toggle] " .. L["toggle Auto recording on/off"])

    -- elseif cmd == "toggle" then
    --     AutoAddLoot = (AutoAddLoot + 1) % 3
    --     Database:SetConfig("autoaddloot", AutoAddLoot)
    --     ShowCurrentAutoLootType()
    else
        local _, itemLink = GetItemInfo(strtrim(msg))
        if itemLink then
            Database:AddLoot(itemLink, 1, "", 0, true)
            Print(L["Item added"] .. " " .. itemLink)
        end
    end

end
SLASH_RAIDLEDGER1 = "/GTUAN"
SLASH_RAIDLEDGER2 = "/RAIDLEDGER"
