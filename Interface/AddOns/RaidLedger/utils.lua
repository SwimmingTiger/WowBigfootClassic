local _, ADDONSELF = ...

local L = ADDONSELF.L

ADDONSELF.print = function(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|CFFFF0000<|r|CFFFFD100RaidLedger|r|CFFFF0000>|r"..(msg or "nil"))
end

local function GetMoneyStringL(money, separateThousands)
	local goldString, silverString, copperString;
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

    if (separateThousands) then
        goldString = FormatLargeNumber(gold)..GOLD_AMOUNT_SYMBOL;
    else
        goldString = gold..GOLD_AMOUNT_SYMBOL;
    end
    silverString = silver..SILVER_AMOUNT_SYMBOL;
    copperString = copper..COPPER_AMOUNT_SYMBOL;

	local moneyString = "";
	local separator = "";
	if ( gold > 0 ) then
		moneyString = goldString;
		separator = " ";
	end
	if ( silver > 0 ) then
		moneyString = moneyString..separator..silverString;
		separator = " ";
	end
	if ( copper > 0 or moneyString == "" ) then
		moneyString = moneyString..separator..copperString;
	end

	return moneyString;
end
ADDONSELF.GetMoneyStringL = GetMoneyStringL


local function SendToCurrrentChannel(msg)
    local chatType = DEFAULT_CHAT_FRAME.editBox:GetAttribute("chatType")
    local whisperTo = DEFAULT_CHAT_FRAME.editBox:GetAttribute("tellTarget")
    if chatType == "WHISPER" then
        SendChatMessage(msg, chatType, nil, whisperTo)
    elseif chatType == "CHANNEL" then
        SendChatMessage(msg, chatType, nil, DEFAULT_CHAT_FRAME.editBox:GetAttribute("channelTarget"))
    elseif chatType == "BN_WHISPER" then
        BNSendWhisper(BNet_GetBNetIDAccount(whisperTo), msg)
    else
        SendChatMessage(msg, chatType)
    end
end

local function noop() end

local CRLF = "\r\n"


ADDONSELF.CRLF = CRLF

local calcavg = function(items, n, oncredit, ondebit, conf)
    oncredit = oncredit or noop
    ondebit  = ondebit or noop
    conf = conf or {}

    local revenue = 0
    local expense = 0
    local saltN = n


    local profitPercentItems = {}
    local revenuePercentItems = {}
    local mulAvgItems = {}

    for _, item in pairs(items or {}) do
        local c = item["cost"] or 0
        local t = item["type"]
        local ct = item["costtype"] or "GOLD"

        if t == "CREDIT" then
            c = math.floor( c * 10000 )
            item["costcache"] = c
            revenue = revenue + c
            oncredit(item, c)
        elseif t == "DEBIT" then
            if ct == "GOLD" then
                c = math.floor( c * 10000 )
                expense = expense + c
                item["costcache"] = c
                ondebit(item, c)
            elseif ct == "PROFIT_PERCENT" then
                table.insert( profitPercentItems, item)
            elseif ct == "REVENUE_PERCENT" then
                table.insert( revenuePercentItems, item)
            elseif ct == "MUL_AVG" then
                saltN = saltN + c
                table.insert(mulAvgItems, item)
            end
        end
    end

    -- before profit

    do
        for _, item in pairs(revenuePercentItems) do
            local p = item["cost"] or 0
            local c = math.floor(revenue * (p / 100.0))

            expense = expense + c
            item["costcache"] = c
            ondebit(item, c)
        end
    end

    local profit = math.max(revenue - expense, 0)
    -- after profit

    do
        -- recalculate expense
        for _, item in pairs(profitPercentItems) do
            local p = item["cost"] or 0
            local c = math.floor(profit * (p / 100.0))

            expense = expense + c
            item["costcache"] = c
            ondebit(item, c)
        end
    end

    profit = math.max(revenue - expense, 0)

    local avg = 0

    if saltN > 0 then
        avg = 1.0 * profit / saltN
        avg = math.max( avg, 0)
        avg = math.floor( avg )
    end

    if conf.rounddown then
        avg = math.floor(avg / 10000) * 10000
    end

    do
        -- recalculate expense
        for _, item in pairs(mulAvgItems) do
            local m = item["cost"] or 0
            local c = math.floor(m * avg)
            expense = expense + c
            item["costcache"] = c
            ondebit(item, c)
        end
    end
    
    profit = math.max(revenue - expense, 0)

    return profit, avg, revenue, expense
end

ADDONSELF.calcavg = calcavg


local function GenExportLine(item, c, uselink)
    local l = item["beneficiary"] or L["[Unknown]"]
    local i = item["detail"]["item"] or ""
    local cnt = item["detail"]["count"] or 1
    local d = item["detail"]["displayname"] or ""
    local t = item["type"]
    local ct = item["costtype"]

    local n, link = GetItemInfo(i)
    if uselink then
        n = link
    end
    n = n or d
    n = n ~= "" and n or L["Other"]

    if t == "DEBIT" then
        n = d or L["Compensation"]
    end

    if not uselink then
        n = "[" ..  n .. "]"
    end


    local s = n .. " (" .. cnt .. ") " .. l .. " " .. GetMoneyStringL(c) 

    if ct == "PROFIT_PERCENT" then
        s = s .. " (" .. (item["cost"] or 0) .. " % " .. L["Net Profit"] .. ")"
    elseif ct == "REVENUE_PERCENT" then
        s = s .. " (" .. (item["cost"] or 0) .. " % " .. L["Revenue"] .. ")"
    elseif ct == "MUL_AVG" then
        s = s .. " (" .. (item["cost"] or 0) .. " *" .. L["Per Member credit"] .. ")"
    end

    return s
end

ADDONSELF.GenExportLine = GenExportLine

 local function sendchat(lines, channel)
    local SendToChat = SendToCurrrentChannel
    if channel then
        SendToChat = function(msg)
            SendChatMessage(msg, channel)
        end
    end

    local SendToChatTimer = function(t)
        SendToChat(t.Arg1)
    end

    -- borrow from [details]
    for i = 1, #lines do 
        local timer = C_Timer.NewTimer (i * 200 / 1000, SendToChatTimer)
        timer.Arg1 = lines[i]
    end
end

ADDONSELF.sendchat = sendchat

local function csv(items, number)
    local s = ""

    local line = function(item, c)
        local l = item["beneficiary"] or L["[Unknown]"]
        local i = item["detail"]["item"] or ""
        local cnt = item["detail"]["count"] or 1
        local d = item["detail"]["displayname"] or ""
        local t = item["type"]
        local ct = item["costtype"]

        local n = GetItemInfo(i)
        n = n or d
        n = n ~= "" and n or L["Other"]
    
        if t == "DEBIT" then
            n = d or L["Compensation"]
        end
    
        n = "[" ..  n .. "]"

        local note = ""
        if ct == "PROFIT_PERCENT" then
            note = (item["cost"] or 0) .. " % " .. L["Net Profit"]
        elseif ct == "REVENUE_PERCENT" then
            note = (item["cost"] or 0) .. " % " .. L["Revenue"]
        elseif ct == "MUL_AVG" then
            note = (item["cost"] or 0) .. " *" .. L["Per Member credit"]
        end

        return string.join(",", n, cnt, l, c/10000, note) .. CRLF
    end

    calcavg(items, number, function(item, c)
        s = s .. L["Credit"] .. "," .. line(item, c)
    end, function(item, c)
        s = s .. L["Debit"] .. "," .. line(item, c)
    end)

    return s
end

ADDONSELF.genexport = function(items, n, conf)

    -- TODO code struct
    if conf.format == "csv" then
        return csv(items, n)
    end

    local s = L["Raid Ledger"] .. CRLF
    s = s .. L["Feedback"] .. ": farmer1992@gmail.com" .. CRLF
    s = s .. CRLF

    local l = function(item, c)
        s = s .. GenExportLine(item, c) .. CRLF
    end

    local profit, avg, revenue, expense  = calcavg(items, n, l, l, {
        rounddown = conf.rounddown,
    })

    revenue = GetMoneyStringL(revenue)
    expense = GetMoneyStringL(expense)
    profit = GetMoneyStringL(profit)
    avg = GetMoneyStringL(avg)

    s = s .. CRLF
    s = s .. L["Revenue"] .. ":" .. revenue .. CRLF
    s = s .. L["Expense"] .. ":" .. expense .. CRLF
    s = s .. L["Net Profit"] .. ":" .. profit .. CRLF
    s = s .. L["Split into"] .. ":" .. n .. CRLF
    s = s .. L["Per Member credit"] .. ":" .. avg .. (conf.rounddown and (" (" .. L["Round down"] .. ")") or "") .. CRLF

    return s
end

ADDONSELF.genreport = function(items, n, channel, conf)
    local lines = {}
    local grp = {}

    local profit, avg, revenue, expense  = calcavg(items, n, function(item, c)
        local l = item["beneficiary"] or L["[Unknown]"]
        local i = item["detail"]["item"] or ""
        local d = item["detail"]["displayname"] or ""
        local cnt = item["detail"]["count"] or 1
        if not grp[l] then
            grp[l] = {
                ["cost"] = 0,
                ["items"] = {},
                ["citems"] = {},
                ["compensation"] = 0,
            }
        end

        grp[l]["cost"] = grp[l]["cost"] + c

        if not GetItemInfoFromHyperlink(i) then
            i = d
        end

        if conf.filterzero and c == 0 then
            -- skip
        else
            table.insert( grp[l]["items"], i .. " (" .. cnt .. ") " .. GetMoneyStringL(c))
        end

        -- table.insert(lines, string.format(L["Credit"] .. ": %s -> [%s] %s", i, l, GetMoneyStringL(c)))

    end, function(item, c)
        local l = item["beneficiary"] or L["[Unknown]"]
        local d = item["detail"]["displayname"] or ""
        local ct = item["costtype"] or "GOLD"

        if not grp[l] then
            grp[l] = {
                ["cost"] = 0,
                ["items"] = {},
                ["citems"] = {},
                ["compensation"] = 0,
            }
        end

        -- local s = string.format(L["Debit"] .. ": [%s] -> [%s] %s", d, l, GetMoneyStringL(c))
        local s = d .. " " .. GetMoneyStringL(c)

        if ct == "PROFIT_PERCENT" then
            s = s .. " (" .. (item["cost"] or 0) .. " % " .. L["Net Profit"] .. ")"
        elseif ct == "REVENUE_PERCENT" then
            s = s .. " (" .. (item["cost"] or 0) .. " % " .. L["Revenue"] .. ")"
        elseif ct == "MUL_AVG" then
            s = s .. " (" .. (item["cost"] or 0) .. " * " .. L["Per Member credit"] .. ")"
        end

        grp[l]["compensation"] = grp[l]["compensation"] + c
        table.insert( grp[l]["citems"], s)
        -- table.insert(lines, s)
    end, {
        rounddown = conf.rounddown,
    })


    local looter = {}
    local compensation = {}

    for l, k in pairs(grp) do
        table.insert( looter, {
            ["cost"] = k["cost"],
            ["items"] = k["items"],
            ["looter"] = l,
        })

        if k["compensation"] > 0 then
            table.insert( compensation, {
                ["beneficiary"] = l,
                ["compensation"] = k["compensation"],
                ["citems"] = k["citems"],
            })
        end
    end

    table.sort( looter, function(a, b)
        return a["cost"] > b["cost"]
    end)

    table.sort( compensation, function(a, b)
        return a["compensation"] > b["compensation"]
    end)

    if #looter > 0 then
        local c = math.min(#looter, 40)

        while c > 0 and looter[c]["cost"] == 0 do
            c = c - 1
        end

        if c > 0 then
            table.insert(lines, "RaidLedger:.... " .. L["Credit"] .. " ....")
            -- table.insert(lines, "RaidLedger: " .. L["Top [%d] contributors"]:format(c))
        end

        for i = 1, c do
            if looter[i] then
                local l = looter[i]
                table.insert(lines, i .. ". " .. L["Credit"] .. " " .. l["looter"] .. " [" .. GetMoneyStringL(l["cost"]) .. "]")

                for j, item in pairs(l["items"]) do
                    table.insert(lines, "... " .. j .. ". " .. l["looter"] .. " " .. item)
                end
            end
        end
    end

    if conf.expenseonly then
        wipe(lines)
    end

    if expense > 0 then
        table.insert(lines, "RaidLedger:.... " .. L["Debit"] .. " ....")

        local c = math.min( #compensation, 40)

        for i = 1, c do
            local l = compensation[i]
            table.insert(lines, i .. ". " .. L["Debit"] .. " " .. l["beneficiary"] .. " [" .. GetMoneyStringL(l["compensation"]) .. "]")
            for _, item in pairs(l["citems"]) do
                table.insert(lines, "... " .. l["beneficiary"] .. " " .. item)
            end
        end
    end

    if conf.expenseonly then
        sendchat(lines, channel)
        return
    end

    if conf.short then
        wipe(lines)
    end
    
    revenue = GetMoneyStringL(revenue)
    expense = GetMoneyStringL(expense)
    profit = GetMoneyStringL(profit)
    avg = GetMoneyStringL(avg)

    table.insert(lines, L["Revenue"] .. ": " .. revenue)
    table.insert(lines, L["Expense"] .. ": " .. expense)
    table.insert(lines, L["Net Profit"] .. ": " .. profit)
    table.insert(lines, L["Split into"]  .. ": " .. n)
    table.insert(lines, "RaidLedger: ..." .. L["Per Member credit"] .. ": [" .. avg .. (conf.rounddown and (" (" .. L["Round down"] .. ")]...") or "]..."))

    sendchat(lines, channel)

end
