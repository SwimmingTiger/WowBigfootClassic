local _, ADDONSELF = ...


local RegEvent = ADDONSELF.regevent

RegEvent("ADDON_LOADED", function()
    if not RaidLedgerDatabase then
        RaidLedgerDatabase = {}
    end
end)

local db = {
    ledgerItemsChangedCallback = {}
}

function db:RegisterChangeCallback(cb)
    table.insert( self.ledgerItemsChangedCallback, cb )
end

function db:OnLedgerItemsChange()
    for _, cb in pairs(self.ledgerItemsChangedCallback) do
        cb()
    end
end

local function GetConfig()
    if not RaidLedgerDatabase["config"] then
        RaidLedgerDatabase["config"] = {}
    end

    return RaidLedgerDatabase["config"]
end

function db:SetConfig(key, v)
    local config = GetConfig()
    config[key] = v
end

function db:GetConfigOrDefault(key, def)
    local config = GetConfig()

    if config[key] == nil then
        config[key] = def
    end

    return config[key]
end

local MAX_LEDGER_COUNT = 1

function db:SetCurrentLedger(idx)
    RaidLedgerDatabase["current"] = idx
end

function db:NewLedger()
    if not RaidLedgerDatabase["ledgers"] then
        RaidLedgerDatabase["ledgers"] = {}
    end

    local ledgers = RaidLedgerDatabase["ledgers"]
    table.insert( ledgers, {
        ["time"] = time(),
        ["items"] = {},
    } )

    while(#ledgers > MAX_LEDGER_COUNT) do
        table.remove(ledgers, 1)
    end

    self:SetCurrentLedger(#ledgers)
    self:OnLedgerItemsChange()
end

function db:GetCurrentLedger()
    if not RaidLedgerDatabase["ledgers"] then
        self:NewLedger()
    end

    local cur = RaidLedgerDatabase["current"]

    return RaidLedgerDatabase["ledgers"][cur]
end

-- TODO should global const
local TYPE_CREDIT = "CREDIT"
local TYPE_DEBIT  = "DEBIT"
local DETAIL_TYPE_ITEM = "ITEM"
local DETAIL_TYPE_CUSTOM = "CUSTOM"

local COST_TYPE_GOLD = "GOLD"
local COST_TYPE_PROFIT_PERCENT = "PROFIT_PERCENT"
local COST_TYPE_MUL_AVG = "MUL_AVG"

-- function db:GetCurrentEarning()
--     local ledger = self:GetCurrentLedger()

--     local revenue = 0
--     local expense = 0

--     for _, item in pairs(ledger["items"]) do
--         if item["type"] == TYPE_CREDIT then
--             revenue = revenue + (item["cost"] or 0)
--         elseif item["type"] == TYPE_DEBIT then
--             expense = expense + (item["cost"] or 0)
--         end
--     end

--     return revenue * 10000, expense * 10000
-- end

function db:AddEntry(type, detail, beneficiary, cost, costtype)
    local ledger = self:GetCurrentLedger()

    table.insert(ledger["items"], {
        -- id = #ledger["items"] + 1,
        type = type,
        detail = detail or {},
        beneficiary = beneficiary or "",
        cost = cost or 0,
        costtype = costtype or "GOLD",
    })

    self:OnLedgerItemsChange()
end

function db:RemoveEntry(idx)
    local ledger = self:GetCurrentLedger()
    table.remove(ledger["items"], idx)

    self:OnLedgerItemsChange()
end

function db:AddCredit(reason, beneficiary, cost)
    self:AddEntry(TYPE_CREDIT, {
        ["displayname"] = reason
    }, beneficiary, cost)
end

function db:AddDebit(reason, beneficiary, cost, costtype)
    self:AddEntry(TYPE_DEBIT, {
        ["displayname"] = reason
    }, beneficiary, cost, costtype)
end

local function GetFilteritemsSet(s)
    local set = {}

    s = string.gsub(s,"(#.[^\n]*\n)", "")

    for _, line in ipairs({strsplit("\n", s)}) do
        line = strtrim(line, " \t\r\n[]")
        set[line] = true

        local itemName = GetItemInfo(line)

        if itemName then
            set[itemName] = true
        end

    end

    return set
end

function db:AddOrUpdateLoot(item, count, beneficiary, cost)
    local itemName, itemLink, itemRarity, _, _, _, _, itemStackCount = GetItemInfo(item)

    local ledger = self:GetCurrentLedger()
    for _, entry in pairs(ledger["items"]) do
        if entry.detail then
            if entry.detail.item == itemLink and entry.cost == 0 and entry.detail.count == count then
                entry.beneficiary = beneficiary
                entry.cost = cost
                self:OnLedgerItemsChange()
                return
            end
        end
    end

    self:AddLoot(item, count, beneficiary, cost, true)
end

function db:AddLoot(item, count, beneficiary, cost, force)
    local itemName, itemLink, itemRarity, _, _, _, _, itemStackCount = GetItemInfo(item)
    itemStackCount = itemStackCount or 0

    local filter = self:GetConfigOrDefault("filterlevel", LE_ITEM_QUALITY_RARE)

    if not itemLink then
        return
    end

    if force then
        self:AddEntry(TYPE_CREDIT, {
            item = itemLink,
            type = DETAIL_TYPE_ITEM,
            count = count or 1,
        }, beneficiary, cost)
    elseif itemRarity >= filter then

        local s = GetFilteritemsSet(self:GetConfigOrDefault("filteritems", ""))

        if s[itemName] then
            return
        end

        -- TODO bad smell code
        local ledger = self:GetCurrentLedger()
        for _, entry in pairs(ledger["items"]) do
            if entry.detail then
                if entry.detail.item == itemLink and entry.beneficiary == beneficiary and entry.cost == 0 and itemStackCount > 1 then
                    entry.detail.count = entry.detail.count + (count or 1)
                    self:OnLedgerItemsChange()
                    return
                end
            end
        end

        self:AddEntry(TYPE_CREDIT, {
            item = itemLink,
            type = DETAIL_TYPE_ITEM,
            count = count or 1,
        }, beneficiary, cost)
    end
end

ADDONSELF.db = db
