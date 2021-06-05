local T = LibStub("AceAddon-3.0"):NewAddon("GDKP", "AceEvent-3.0", "AceHook-3.0")
if not T then
    return
end
_G.GDKP = T
local defaults = {profile = {account = {}, records = {}}}
local _debug = 0
local _debugColor = {"ee2211", "ee2288", "00ee55"}
T.debug = function(...)
    local lvl = ...
    if type(lvl) == "number" and lvl <= #_debugColor then
        if _debug >= lvl then
            print("** |cff" .. _debugColor[lvl] .. "<GDKP>|r: Level " .. lvl .. " **")
            print(select(2, ...))
        end
    else
        if _debug > 0 then
            print("** <GDKP> **")
            print(...)
        end
    end
end
local debug = T.debug
local AceOO = AceLibrary("AceOO-2.0")
local YOU
local GDKP_LOOT_ITEM_MULTIPLE
local GDKP_LOOT_ITEM
local GDKP_LOOT_ITEM_SELF_MULTIPLE
local GDKP_LOOT_ITEM_SELF
local GDKP_LOOT_ITEM_PUSHED_SELF
local GDKP_LOOT_ITEM_PUSHED_SELF_MULTIPLE
local GDKP_RAID_MEMBER_ADDED
local GDKP_RAID_MEMBER_REMOVED
local GDKP_RAID_YOU_JOINED
local GDKP_RAID_YOU_LEFT
local GDKP_REPORT_TOTAL_INCOME
local GDKP_REPORT_TOTAL_EXPENSE
local GDKP_REPORT_TOTAL_PROFIT
local GDKP_REPORT_TANK_SUBSIDE
local GDKP_REPORT_HEALER_SUBSIDE
local GDKP_REPORT_AVE_PROFIT
local GDKP_0b07d59d0644e66cb588eb8a9e79ad79 = {
    ["29434"] = true,
    ["32229"] = true,
    ["32230"] = true,
    ["32228"] = true,
    ["32227"] = true,
    ["32249"] = true,
    ["32231"] = true,
    ["32428"] = true,
    ["34664"] = true,
    ["20725"] = true,
    ["22449"] = true,
    ["22448"] = true,
    ["22450"] = true,
    ["30313"] = true,
    ["30318"] = true,
    ["30312"] = true,
    ["30314"] = true,
    ["30319"] = true,
    ["30317"] = true,
    ["30311"] = true,
    ["30316"] = true,
    ["34057"] = true,
    ["49426"] = true,
    ["47241"] = true,
    ["36928"] = true,
    ["36934"] = true,
    ["36931"] = true,
    ["36919"] = true,
    ["36922"] = true,
    ["36925"] = true,
    ["34052"] = true,
    ["34053"] = true,
    ["45624"] = true
}
if GetLocale() == "zhCN" then
    GDKP_TEXT_TITLE = "大脚金团助手"
    GDKP_TEXT_NEW_INCOME = "添加\n收入"
    GDKP_TEXT_NEW_EXPENSE = "添加\n支出"
    GDKP_TEXT_NUM_MEMBER = "人数:"
    GDKP_TEXT_MANAGE = "管理\n记录"
    GDKP_TEXT_TOTAL_INCOME = "总收入:"
    GDKP_TEXT_AVE_PROFIT = "人均收入:"
    GDKP_TEXT_TOTAL_PROFIT = "净收入:"
    GDKP_TEXT_TOTAL_EXPENSE = "总支出:"
    GDKP_TEXT_TANK_SUBSIDE = "坦克补助:"
    GDKP_TEXT_HEALER_SUBSIDE = "治疗补助:"
    GDKP_TEXT_INCOME_DESC = "收入描述 (shift+物品自动填写)"
    GDKP_TEXT_GOLD_DESC = "金"
    GDKP_TEXT_GOLD_EXPENSE = "支出金币"
    GDKP_TEXT_EXPENSE_DESC = "支出描述"
    GDKP_TEXT_NEWINCOME_DESC = " 以下为该次活动自动记录的物品列表，请根据需要修改物品价值。修改后的物品将自动转移到管理记录列表中。"
    GDKP_TEXT_NEWINCOM_NEWITEM_DESC = "手动添加物品或额外收入请点击“添加收入”进行操作"
    GDKP_TEXT_NEWIEXPENSE_NEWITEM_DESC = "手动添加支出项目请点击“添加支出”进行操作"
    GDKP_LABEL_EDIT = "修改"
    GDKP_LABEL_DEL = "刪除"
    GDKP_ALERT_DEAD = "你已经死亡"
    YOU = "你"
    GDKP_TAB_INCOME = " 收入列表 "
    GDKP_TAB_EXPENSE = " 支出列表 "
    GDKP_TAB_LOG = " 查看日誌 "
    GDKP_RESET = "重置记录"
    GDKP_REPORT = "通告"
    GDKP_REPORT_TOTAL_INCOME = "总收入为：%s。\n"
    GDKP_REPORT_TOTAL_EXPENSE = "总支出为：%s。\n"
    GDKP_REPORT_TOTAL_PROFIT = "总盈余为：%s。\n"
    GDKP_REPORT_TANK_SUBSIDE = "坦克补助为：%s。\n"
    GDKP_REPORT_HEALER_SUBSIDE = "治疗补助为：%s。\n"
    GDKP_REPORT_AVE_PROFIT = "平均收入为：%d。\n"
    GDKP_RESET_DATA = "该操作将重置所有记录，你确定吗？"
    GDKP_DELETE_RECORD = "此操作将删除 记录%s，你确定吗？"
    GDKP_SAVE = "保存"
elseif GetLocale() == "zhTW" then
    GDKP_TEXT_TITLE = "大腳金團助手"
    GDKP_TEXT_NEW_INCOME = "添加\n收入"
    GDKP_TEXT_NEW_EXPENSE = "添加\n支出"
    GDKP_TEXT_NUM_MEMBER = "人數:"
    GDKP_TEXT_MANAGE = "管理\n記錄"
    GDKP_TEXT_TOTAL_INCOME = "總收入:"
    GDKP_TEXT_AVE_PROFIT = "人均收益:"
    GDKP_TEXT_TOTAL_PROFIT = "凈收入:"
    GDKP_TEXT_TOTAL_EXPENSE = "總支出:"
    GDKP_TEXT_TANK_SUBSIDE = "坦克補助:"
    GDKP_TEXT_HEALER_SUBSIDE = "治療補助:"
    GDKP_TEXT_INCOME_DESC = "收入描述 (shift+物品自動填寫)"
    GDKP_TEXT_GOLD_DESC = "金"
    GDKP_TEXT_GOLD_EXPENSE = "支出金幣"
    GDKP_TEXT_EXPENSE_DESC = "支出描述"
    GDKP_TEXT_NEWINCOME_DESC = " 以下為該次活動自動記錄的物品列表，請根據需要修改物品價值。修改後的物品將自動轉移到管理記錄列表中。"
    GDKP_TEXT_NEWINCOM_NEWITEM_DESC = "手動添加物品或額外收入請點擊“添加收入”進行操作"
    GDKP_TEXT_NEWIEXPENSE_NEWITEM_DESC = "手動添加支出項目請點擊“添加支出”進行操作"
    GDKP_LABEL_EDIT = "修改"
    GDKP_LABEL_DEL = "刪除"
    GDKP_ALERT_DEAD = "你已經死亡"
    YOU = "你"
    GDKP_TAB_INCOME = " 收入列表 "
    GDKP_TAB_EXPENSE = " 支出列表 "
    GDKP_TAB_LOG = " 查看日誌 "
    GDKP_RESET = "重置記錄"
    GDKP_REPORT = "通告"
    GDKP_REPORT_TOTAL_INCOME = "總收入為：%s。\n"
    GDKP_REPORT_TOTAL_EXPENSE = "總支出為：%s。\n"
    GDKP_REPORT_TOTAL_PROFIT = "總盈餘為：%s。\n"
    GDKP_REPORT_TANK_SUBSIDE = "坦克補助為：%s。\n"
    GDKP_REPORT_HEALER_SUBSIDE = "治療補助為：%s。\n"
    GDKP_REPORT_AVE_PROFIT = "平均收入為：%d。\n"
    GDKP_RESET_DATA = "該操作將重置所有記錄，你確定嗎？"
    GDKP_DELETE_RECORD = "此操作將刪除記錄 %s，你確定嗎？"
    GDKP_SAVE = "保存"
else
    GDKP_TEXT_TITLE = "GDKP Helper@BF"
    GDKP_TEXT_NEW_INCOME = "New \nIncome"
    GDKP_TEXT_NEW_EXPENSE = "New \nExpense"
    GDKP_TEXT_NUM_MEMBER = "Members:"
    GDKP_TEXT_MANAGE = "Manage \nRecords"
    GDKP_TEXT_TOTAL_INCOME = "Total Income:"
    GDKP_TEXT_AVE_PROFIT = "Average Profit:"
    GDKP_TEXT_TOTAL_PROFIT = "Total Profit:"
    GDKP_TEXT_TOTAL_EXPENSE = "Total Expense:"
    GDKP_TEXT_TANK_SUBSIDE = "Tank Subside:"
    GDKP_TEXT_HEALER_SUBSIDE = "Healer Subside:"
    GDKP_TEXT_INCOME_DESC = "Income description (shift+Click on item link to autofill)"
    GDKP_TEXT_GOLD_DESC = "Gold"
    GDKP_TEXT_GOLD_EXPENSE = "Expense"
    GDKP_TEXT_EXPENSE_DESC = "Expense Description"
    GDKP_TEXT_NEWINCOME_DESC =
        " Below are items that has been automatically recorded, please modify their value. Items that have been modified will be moved to Income list."
    GDKP_TEXT_NEWINCOM_NEWITEM_DESC = 'To extra Items or income, please click on "New Income" button'
    GDKP_LABEL_EDIT = "Edit"
    GDKP_LABEL_DEL = "Delete"
    GDKP_ALERT_DEAD = "You are dead"
    YOU = "You"
    GDKP_TAB_INCOME = " Income List "
    GDKP_TAB_EXPENSE = " Expense List "
    GDKP_TAB_LOG = " View Log "
    GDKP_RESET = "Reset All"
    GDKP_REPORT = "Report"
    GDKP_REPORT_TOTAL_INCOME = "Total Income is:%s.\n"
    GDKP_REPORT_TOTAL_EXPENSE = "Total Expense is:%s.\n"
    GDKP_REPORT_TOTAL_PROFIT = "Total Profit is:%s.\n"
    GDKP_REPORT_TANK_SUBSIDE = "Tank Subside is:%s.\n"
    GDKP_REPORT_HEALER_SUBSIDE = "Healer Subside is:%s.\n"
    GDKP_REPORT_AVE_PROFIT = "Average Profit is:%d.\n"
    GDKP_RESET_DATA = "This operation will reset all the records, continue？"
    GDKP_DELETE_RECORD = "This operation will delete record %s, continue？"
    GDKP_SAVE = "Save"
end
local RM = T:NewModule("RecordManager")
if not RM then
    return
end
local EM = T:NewModule("EventManager")
if not EM then
    return
end
StaticPopupDialogs["GDKP_RESET_DATA"] = {text = GDKP_RESET_DATA, button1 = YES, button2 = NO, OnAccept = function()
        T:Reset()
    end, OnCancel = function()
    end, OnShow = function()
    end, timeout = 0, hideOnEscape = 1}
StaticPopupDialogs["GDKP_DELETE_RECORD"] = {
    text = GDKP_DELETE_RECORD,
    button1 = YES,
    button2 = NO,
    OnAccept = function(self, ...)
        local cell = self.cell
        local panel = self.panel
        RM:DeleteRecord(cell:GetRecord())
        panel:DeleteRecord(cell:GetRecord())
    end,
    OnCancel = function()
    end,
    OnShow = function()
    end,
    timeout = 0,
    hideOnEscape = 1,
    enterClicksFirstButton = 1
}
local function GDKP_9336171702a6bc3810b21190594210d9(
    GDKP_acd18e5e4cc047ed8d218397986e9dc2,
    GDKP_a8858383576d7634cceceaf04a2ddb29)
    local GDKP_8e0e84596da5717799a875d1aeeb63bc = function(s, e, ...)
        if (s and e) then
            return ...
        end
    end
    return GDKP_8e0e84596da5717799a875d1aeeb63bc(
        string.find(GDKP_acd18e5e4cc047ed8d218397986e9dc2, GDKP_a8858383576d7634cceceaf04a2ddb29)
    )
end
local function GDKP_93dd10c14ba6d9968dde1fcd8b5345c8(arg1)
    local GDKP_9c987de176f2b454baede402cee36bfa,
        GDKP_e498578b78aa0db9c45f30f87d63debc,
        GDKP_3f50417fb16be9b1078eb68d24fa9c26
    if (not GDKP_e498578b78aa0db9c45f30f87d63debc) then
        GDKP_9c987de176f2b454baede402cee36bfa,
            GDKP_e498578b78aa0db9c45f30f87d63debc,
            GDKP_3f50417fb16be9b1078eb68d24fa9c26 = GDKP_9336171702a6bc3810b21190594210d9(arg1, GDKP_LOOT_ITEM_MULTIPLE)
    end
    if (not GDKP_e498578b78aa0db9c45f30f87d63debc) then
        GDKP_9c987de176f2b454baede402cee36bfa, GDKP_e498578b78aa0db9c45f30f87d63debc =
            GDKP_9336171702a6bc3810b21190594210d9(arg1, GDKP_LOOT_ITEM)
    end
    if (not GDKP_e498578b78aa0db9c45f30f87d63debc) then
        GDKP_e498578b78aa0db9c45f30f87d63debc, GDKP_3f50417fb16be9b1078eb68d24fa9c26 =
            GDKP_9336171702a6bc3810b21190594210d9(arg1, GDKP_LOOT_ITEM_SELF_MULTIPLE)
    end
    if (not GDKP_e498578b78aa0db9c45f30f87d63debc) then
        GDKP_e498578b78aa0db9c45f30f87d63debc = GDKP_9336171702a6bc3810b21190594210d9(arg1, GDKP_LOOT_ITEM_SELF)
    end
    if (not GDKP_e498578b78aa0db9c45f30f87d63debc) then
        GDKP_e498578b78aa0db9c45f30f87d63debc = GDKP_9336171702a6bc3810b21190594210d9(arg1, GDKP_LOOT_ITEM_PUSHED_SELF)
    end
    if (not GDKP_e498578b78aa0db9c45f30f87d63debc) then
        GDKP_e498578b78aa0db9c45f30f87d63debc, GDKP_3f50417fb16be9b1078eb68d24fa9c26 =
            GDKP_9336171702a6bc3810b21190594210d9(arg1, GDKP_LOOT_ITEM_PUSHED_SELF_MULTIPLE)
    end
    if (not GDKP_9c987de176f2b454baede402cee36bfa or GDKP_9c987de176f2b454baede402cee36bfa == YOU) then
        GDKP_9c987de176f2b454baede402cee36bfa = UnitName("player")
    end
    if (not GDKP_e498578b78aa0db9c45f30f87d63debc) then
        return
    end
    GDKP_3f50417fb16be9b1078eb68d24fa9c26 = GDKP_3f50417fb16be9b1078eb68d24fa9c26 or 1
    return GDKP_9c987de176f2b454baede402cee36bfa, GDKP_e498578b78aa0db9c45f30f87d63debc, (GDKP_3f50417fb16be9b1078eb68d24fa9c26 ==
        1 and
        GDKP_e498578b78aa0db9c45f30f87d63debc) or
        GDKP_e498578b78aa0db9c45f30f87d63debc .. "x" .. GDKP_3f50417fb16be9b1078eb68d24fa9c26
end
local function GDKP_17f19a911781c205920d1760e7dfc736(GDKP_acd18e5e4cc047ed8d218397986e9dc2)
    GDKP_acd18e5e4cc047ed8d218397986e9dc2 = string.gsub(GDKP_acd18e5e4cc047ed8d218397986e9dc2, "%(", "%%(")
    GDKP_acd18e5e4cc047ed8d218397986e9dc2 = string.gsub(GDKP_acd18e5e4cc047ed8d218397986e9dc2, "%)", "%%)")
    GDKP_acd18e5e4cc047ed8d218397986e9dc2 = string.gsub(GDKP_acd18e5e4cc047ed8d218397986e9dc2, "%%s", "(.-)")
    GDKP_acd18e5e4cc047ed8d218397986e9dc2 = string.gsub(GDKP_acd18e5e4cc047ed8d218397986e9dc2, "%%d", "(%%d+)")
    return GDKP_acd18e5e4cc047ed8d218397986e9dc2
end
local function GDKP_9f069b4b2abd8b59dd593eb05c0eb053()
    GDKP_LOOT_ITEM = GDKP_17f19a911781c205920d1760e7dfc736(LOOT_ITEM)
    GDKP_LOOT_ITEM_MULTIPLE = GDKP_17f19a911781c205920d1760e7dfc736(LOOT_ITEM_MULTIPLE)
    GDKP_LOOT_ITEM_SELF = GDKP_17f19a911781c205920d1760e7dfc736(LOOT_ITEM_SELF)
    GDKP_LOOT_ITEM_SELF_MULTIPLE = GDKP_17f19a911781c205920d1760e7dfc736(LOOT_ITEM_SELF_MULTIPLE)
    GDKP_LOOT_ITEM_PUSHED_SELF = GDKP_17f19a911781c205920d1760e7dfc736(LOOT_ITEM_PUSHED_SELF)
    GDKP_LOOT_ITEM_PUSHED_SELF_MULTIPLE = GDKP_17f19a911781c205920d1760e7dfc736(LOOT_ITEM_PUSHED_SELF_MULTIPLE)
    GDKP_RAID_MEMBER_ADDED = GDKP_17f19a911781c205920d1760e7dfc736(ERR_RAID_MEMBER_ADDED_S)
    GDKP_RAID_MEMBER_REMOVED = GDKP_17f19a911781c205920d1760e7dfc736(ERR_RAID_MEMBER_REMOVED_S)
    GDKP_RAID_YOU_JOINED = GDKP_17f19a911781c205920d1760e7dfc736(ERR_RAID_YOU_JOINED)
    GDKP_RAID_YOU_LEFT = GDKP_17f19a911781c205920d1760e7dfc736(ERR_RAID_YOU_LEFT)
end
local function GDKP_d46ced55976240072f56c23890a2fc3b(itemLink)
    local pattern = "|c%x+|Hitem:(%d+):%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+|h%[(.+)%]|h|r"
    return itemLink:match(pattern)
end
function GDKP_332126e2e82fafa6f5d15f912aba69c6(item)
    local id = GDKP_d46ced55976240072f56c23890a2fc3b(item)
    if not id then
        return
    end
    return GDKP_0b07d59d0644e66cb588eb8a9e79ad79[id]
end
local function SafePopup_Show(GDKP_8983c60d66c8593ec7165ea9dbedb584, ...)
    if not UnitIsDeadOrGhost(UnitName("player")) then
        return StaticPopup_Show(GDKP_8983c60d66c8593ec7165ea9dbedb584, ...)
    else
        print("\124cff03de23<GDKP>: \124r " .. GDKP_ALERT_DEAD)
    end
end
function EM:FireEvent(event)
    if not self.eventTable[event] then
        return
    end
    for i, funcTable in ipairs(self.eventTable[event]) do
        local func = funcTable[1]
        local args = funcTable[2]
        pcall(func, unpack(args))
    end
end
function EM:RegisterEvent(event, func, ...)
    assert(type(event) == "string", "Event must be String")
    self.eventTable[event] = self.eventTable[event] or {}
    local funcTable = {func, {...}}
    tinsert(self.eventTable[event], funcTable)
end
function EM:UnRegisterEvent(event, func)
    if not self.eventTable[event] then
        return
    end
    for i = 1, #self.eventTable[event] do
        if self.eventTable[event][i][1] == func then
            tremove(self.eventTable[event], i)
        end
    end
end
function EM:OnInitialize()
    self.eventTable = {}
end
RM.recordTypes = {"NormalItem", "SpecialIncome", "Expense", "Trivial"}
local function GDKP_625814a4f8ec0bfbf26894c87ca2cd9a(rType)
    local prefix
    if type(rType) == "number" then
        assert(
            rType > 0 and rType <= #RM.recordTypes,
            "<Local function> - GDKP_625814a4f8ec0bfbf26894c87ca2cd9a(): Invalid record id"
        )
        prefix = RM.recordTypes[rType]
    elseif type(rType) == "string" then
        for i = 1, #RM.recordTypes do
            if rType:lower() == RM.recordTypes[i]:lower() then
                prefix = RM.recordTypes[i]
                break
            end
        end
    end
    return prefix
end --[[ input: rtype: string,Record type rTable: table, save table or new table ]]
function RM:NewRecord(rType, rTable, ...)
    local preFix, obj
    preFix = GDKP_625814a4f8ec0bfbf26894c87ca2cd9a(rType)
    assert(preFix, "<RM>: Invalid record prefix")
    obj = T.Templates[preFix .. "Record"]
    obj = obj:new(rTable, ...)
    return obj
end
function RM:GetRecordList(rType)
    local records = {}
    if not rType then
        records = self.records
    elseif rType == "Income" then
        local template1, template2 = T.Templates.NormalItemRecord, T.Templates.SpecialIncomeRecord
        for i = 1, #self.records do
            if AceOO.inherits(self.records[i], template1) or AceOO.inherits(self.records[i], template2) then
                tinsert(records, self.records[i])
            end
        end
    elseif rType == "NewIncome" then
        local template1, template2 = T.Templates.NormalItemRecord, T.Templates.SpecialIncomeRecord
        for i = 1, #self.records do
            if AceOO.inherits(self.records[i], template1) or AceOO.inherits(self.records[i], template2) then
                if not self.records[i]:GetIncome() then
                    tinsert(records, self.records[i])
                end
            end
        end
    else
        local preFix = GDKP_625814a4f8ec0bfbf26894c87ca2cd9a(rType)
        if preFix then
            local template = T.Templates[preFix .. "Record"]
            if template then
                for i = 1, #self.records do
                    if AceOO.inherits(self.records[i], template) then
                        tinsert(records, self.records[i])
                    end
                end
            end
        end
    end
    return records
end
function RM:LoadRecords()
    local rawRecords, rawRecord = T.db.profile.records
    local recordType, record
    self.records = {}
    for i = 1, #rawRecords do
        rawRecord = rawRecords[i]
        recordType = self:GetRawRecordType(rawRecord)
        if recordType then
            record = self:NewRecord(recordType, rawRecord)
            tinsert(self.records, record)
        end
    end
end
function RM:AddRecord(record)
    tinsert(self.records, record)
    tinsert(T.db.profile.records, record:GetSaveTable())
    EM:FireEvent("UPDATE_GOLD")
end
function RM:GetRawRecordType(rawTable)
    assert(rawTable.type, "<RM>: RecordRawTable need to specify a type")
    local rType = rawTable.type
    for i = 1, #self.recordTypes do
        if rType:lower() == self.recordTypes[i]:lower() then
            return self.recordTypes[i]
        end
    end
    EM:FireEvent("UPDATE_GOLD")
end
function RM:DeleteRecord(record)
    local index
    if type(record) == "number" then
        index = record
    elseif type(record) == "table" then
        index = self:FindRecord(record)
    end
    assert(index > 0 and index <= #self.records, "<RM>: Invalid index for delete")
    tremove(self.records, index)
    tremove(T.db.profile.records, index)
    EM:FireEvent("UPDATE_GOLD")
end
function RM:FindRecord(record)
    for i = 1, #self.records do
        if self.records[i] == record then
            return i
        end
    end
    error("<RM>: Can not find record: " .. record)
end
function RM:GetReport(filterFunc)
    local str = ""
    for i = 1, #self.records do
        if filterFunc and filterFunc(self.records[i]) then
            str = str .. self.records[i]:Report()
        elseif not filterFunc then
            str = str .. self.records[i]:Report()
        end
    end
    return str
end
function RM:Reset()
    wipe(self.records)
    wipe(T.db.profile.records)
end
function RM:OnInitialize()
    T.debug(3, "<RM>: Initializing...")
end
function RM:OnEnable()
    T.debug(3, "<RM>: Enabling...")
    RM:LoadRecords()
end
function RM:OnDisable()
end
GM = T:NewModule("GoldManager")
if not GM then
    return
end
UM = T:NewModule("UIManager")
if not UM then
    return
end
function GM:SetUserSetted(flag)
    self.account:SetUserSetted(flag)
end
function GM:IsUserSetted()
    return self.account:IsUserSetted()
end
function GM:SetNumMembers(number)
    if number and number > 0 then
        self.account:SetNumMembers(number)
    end
end
function GM:GetNumMembers()
    return self.account:GetNumMembers() or 1
end
function GM:GetAverage()
    return self.account:GetAverage()
end
function GM:GetIncome()
    return self.account:GetIncome()
end
function GM:GetExpense()
    return self.account:GetExpense()
end
function GM:GetTankSubsidy()
    return self.account:GetExpense("TANK_SUBSIDY")
end
function GM:GetHealerSubsidy()
    return self.account:GetExpense("HEALER_SUBSIDY")
end
function GM:GetGeneralExpense()
    return self.account:GetExpense("GENERAL_EXPENSE")
end
function GM:GetProfit()
    return self.account:GetProfit()
end
function GM:UpdateRecords()
    local incomeList = RM:GetRecordList("Income")
    local expenseList = RM:GetRecordList("Expense")
    self.account:SetIncomeList(incomeList)
    self.account:SetExpenseList(expenseList)
end
function GM:OnInitialize()
    T.debug(3, "<GM>: Initializing...")
end
function GM:Reset()
    self:UpdateRecords()
    self:SetNumMembers(GetNumGroupMembers() > 0 and GetNumGroupMembers() or 1)
    self:SetUserSetted(false)
    UM:SetNumMember(self:GetNumMembers())
end
function GM:OnEnable()
    T.debug(3, "<GM>: Enabling...")
    self.account = T.Templates.Account:new(T.db.profile.account)
    UM:SetNumMember(self:GetNumMembers())
end
function GM:OnDisable()
end
function GM:GetReport()
    local str = "\n"
    str = str .. GDKP_REPORT_TOTAL_INCOME:format(self:GetIncome())
    str = str .. GDKP_REPORT_TOTAL_EXPENSE:format(self:GetExpense())
    str = str .. GDKP_REPORT_TOTAL_PROFIT:format(self:GetProfit())
    str = str .. GDKP_REPORT_TANK_SUBSIDE:format(self:GetTankSubsidy())
    str = str .. GDKP_REPORT_HEALER_SUBSIDE:format(self:GetHealerSubsidy())
    if GM:GetNumMembers() and GM:GetNumMembers() > 0 then
        str = str .. GDKP_REPORT_AVE_PROFIT:format(self:GetAverage() or "N/A")
    end
    return str
end
local mainPanel, eventPanel, itemPanel, managePanel
local incomTab, expendTab, logTab
local function GDKP_993d50d2de8d657e2fac9639ff63a42b(frame)
    frame:SetAttribute("UIPanelLayout-defined", true)
    frame:SetAttribute("UIPanelLayout-area", "center")
    frame:SetAttribute("UIPanelLayout-enabled", true)
    frame:SetAttribute("UIPanelLayout-whiledead", true)
end
local function GDKP_e02c71e1241bcc3c74ba4f8152ea6a49(frame)
    frame.closeButton = BLibrary("BFButton", frame, 27, 27)
    frame.closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -8)
    frame.closeButton:SetText("X")
    frame.closeButton.OnClick = function(bn)
        bn:GetParent():Hide()
    end
end
local function GDKP_9693cf7251ebd2f6eb6bc572b2e5a188()
    T.debug(3, "<UM>: GDKP_9693cf7251ebd2f6eb6bc572b2e5a188()")
    local frame = _G["GDKPMainFrame"]
    RegisterForSaveFrame(frame)
    frame.newIncomeButton = BLibrary("BFButton", frame, 44, 44)
    frame.newIncomeButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -37)
    frame.newIncomeButton:SetText(GDKP_TEXT_NEW_INCOME)
    frame.newIncomeButton.OnClick = function()
        UM.newIncomePanel:Show()
        UM.newIncomePanel:UpdatePanel()
        if not UM.newIncomeFrame:IsShown() then
            UM.newIncomeFrame:Show()
        else
            UM.newIncomeFrame:Hide()
        end
    end
    frame.newExpenseButton = BLibrary("BFButton", frame, 44, 44)
    frame.newExpenseButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 60, -37)
    frame.newExpenseButton:SetText(GDKP_TEXT_NEW_EXPENSE)
    frame.newExpenseButton.OnClick = function(button)
        local record = RM:NewRecord("Expense", {})
        frame.editable:SetRecord(record)
        frame.editable:ClearAllPoints()
        frame.editable:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
        frame.editable:SetCommitCallback(
            function()
                RM:AddRecord(record)
            end
        )
        frame.editable:Update()
        frame.editable:Show()
    end
    frame.manageButton = BLibrary("BFButton", frame, 44, 44)
    frame.manageButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -37, -37)
    frame.manageButton:SetText(GDKP_TEXT_MANAGE)
    frame.manageButton.OnClick = function()
        if not UM.manageFrame:IsShown() then
            UM.manageFrame:Show()
        else
            UM.manageFrame:Hide()
        end
    end
    frame.resetButton = BLibrary("BFButton", frame, 100, 28)
    frame.resetButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 12, 12)
    frame.resetButton:SetText(GDKP_RESET)
    frame.resetButton.OnClick = function()
        SafePopup_Show("GDKP_RESET_DATA")
    end
    frame.resetButton:Hide()
    frame.saveButton = BLibrary("BFButton", frame, 70, 28)
    frame.saveButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -104, 12)
    frame.saveButton:SetText(GDKP_SAVE)
    frame.saveButton.OnClick = function()
        BigFoot_RequestReloadUI()
    end
    frame.saveButton:Hide()
    frame.reportButton = BLibrary("BFButton", frame, 70, 28)
    frame.reportButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -29, 12)
    frame.reportButton:SetText(GDKP_REPORT)
    frame.reportButton.OnClick = function()
        T:Report()
    end
    frame.reportButton:Hide()
    GDKP_e02c71e1241bcc3c74ba4f8152ea6a49(frame)
    frame.memberEditBox = _G[frame:GetName() .. "MemberEditBox"]
    frame.incomeText = _G[frame:GetName() .. "IncomeText"]
    frame.aveProfitText = _G[frame:GetName() .. "AveProfitText"]
    frame.profitText = _G[frame:GetName() .. "ProfitText"]
    frame.expenseText = _G[frame:GetName() .. "ExpenseText"]
    frame.tankSubsideText = _G[frame:GetName() .. "TankSubsideText"]
    frame.healerSubsideText = _G[frame:GetName() .. "HealerSubsideText"]
    frame.profitLabel = _G[frame:GetName() .. "ProfitLabel"]
    frame.expenseLabel = _G[frame:GetName() .. "ExpenseLabel"]
    frame.tankSubsideLabel = _G[frame:GetName() .. "TankSubsideLabel"]
    frame.healerSubsideLabel = _G[frame:GetName() .. "HealerSubsideLabel"]
    frame.memberPlusButton = _G[frame:GetName() .. "PlusButton"]
    frame.memberMinusButton = _G[frame:GetName() .. "MinusButton"]
    frame:SetScript(
        "OnShow",
        function()
            EM:FireEvent("UPDATE_GOLD")
        end
    )
    frame.editable = T.Templates.RecordExpenseEditable:new("RecordExpenseEditableUI")
    frame.memberPlusButton:SetScript(
        "OnClick",
        function()
            GM:SetUserSetted(true)
            UM:SetNumMember(GM:GetNumMembers() + 1)
        end
    )
    frame.memberMinusButton:SetScript(
        "OnClick",
        function()
            GM:SetUserSetted(true)
            if GM:GetNumMembers() > 1 then
                UM:SetNumMember(GM:GetNumMembers() - 1)
            end
        end
    )
    frame.memberEditBox:SetScript(
        "OnTextChanged",
        function(box, userInput)
            if isUserInput then
                GM:SetUserSetted(true)
            end
            GM:SetNumMembers(tonumber(box:GetText()))
            UM:UpdateGoldDisplay()
        end
    )
    return frame
end
local function GDKP_b46a9a8d0d453ba05fdc42241de4dbf1()
    T.debug(3, "<UM>: GDKP_b46a9a8d0d453ba05fdc42241de4dbf1()")
    local parent = _G["GDKPNewIncomePanel"]
    RegisterForSaveFrame(parent)
    UM.newIncomePanel = T.Templates.NewIncomePanel:new()
    UM.newIncomePanel:SetParent(parent)
    UM.newIncomePanel:SetPoint("TOPLEFT", parent, "TOPLEFT", 13, -88)
    GDKP_993d50d2de8d657e2fac9639ff63a42b(parent)
    GDKP_e02c71e1241bcc3c74ba4f8152ea6a49(parent)
    UM.newIncomePanel:SetShowCallback(
        function(panel)
            panel:SetRecordList(RM:GetRecordList("NewIncome"))
            panel:UpdatePanel()
        end
    )
    UM.newIncomePanel:SetDeleteCallback(
        function(cell)
            local dialog = SafePopup_Show("GDKP_DELETE_RECORD", cell:GetRecord():GetDesc())
            dialog.cell = cell
            dialog.panel = UM.newIncomePanel
        end
    )
    UM.newIncomePanel:SetNewCallback(
        function(cell)
            RM:AddRecord(cell:GetRecord())
            UM.newIncomePanel:AddRecord(cell:GetRecord())
        end
    )
    UM.newIncomePanel:SetEditCallback(
        function(cell)
            EM:FireEvent("UPDATE_GOLD")
        end
    )
    return parent
end
local function GDKP_ecdc44ef55e944effa19684f3c4c942a()
    T.debug(3, "<UM>: GDKP_ecdc44ef55e944effa19684f3c4c942a()")
    local parent = _G["GDKPManageFrame"]
    UM.incomePanel = T.Templates.IncomePanel:new()
    UM.incomePanel:SetParent(parent)
    UM.incomePanel:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -71)
    UM.incomePanel:SetShowCallback(
        function(panel)
            T.debug(3, "<UM>:Showing Incoming Tab")
            panel:SetRecordList(RM:GetRecordList("Income"))
            panel:UpdatePanel()
        end
    )
    UM.incomePanel:SetDeleteCallback(
        function(cell)
            local dialog = SafePopup_Show("GDKP_DELETE_RECORD", cell:GetRecord():GetDesc())
            dialog.cell = cell
            dialog.panel = UM.incomePanel
        end
    )
    UM.incomePanel:SetNewCallback(
        function(cell)
            RM:AddRecord(cell:GetRecord())
            UM.incomePanel:AddRecord(cell:GetRecord())
        end
    )
    UM.incomePanel:SetEditCallback(
        function(cell)
            EM:FireEvent("UPDATE_GOLD")
        end
    )
    return parent
end
local function GDKP_a46102b8fc80c5b62666117722e42454()
    T.debug(3, "<UM>: GDKP_a46102b8fc80c5b62666117722e42454()")
    local parent = _G["GDKPManageFrame"]
    UM.expensePanel = T.Templates.ExpensePanel:new()
    UM.expensePanel:SetParent(parent)
    UM.expensePanel:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -71)
    UM.expensePanel:SetShowCallback(
        function(panel)
            T.debug(3, "<UM>:Showing Expense Tab")
            panel:SetRecordList(RM:GetRecordList("Expense"))
            panel:UpdatePanel()
        end
    )
    UM.expensePanel:SetDeleteCallback(
        function(cell)
            local dialog = SafePopup_Show("GDKP_DELETE_RECORD", cell:GetRecord():GetDesc())
            dialog.cell = cell
            dialog.panel = UM.expensePanel
        end
    )
    UM.expensePanel:SetNewCallback(
        function(cell)
            RM:AddRecord(cell:GetRecord())
            UM.expensePanel:AddRecord(cell:GetRecord())
        end
    )
    UM.expensePanel:SetEditCallback(
        function(cell)
            EM:FireEvent("UPDATE_GOLD")
        end
    )
end
local function GDKP_1d708ad1bb49e15326da5aca9c924459()
    T.debug(3, "<UM>: GDKP_1d708ad1bb49e15326da5aca9c924459()")
    local parent = _G["GDKPManageFrame"]
    UM.logPanel = T.Templates.LogPanel:new()
    UM.logPanel:SetParent(parent)
    UM.logPanel:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -71)
    UM.logPanel:SetShowCallback(
        function(panel)
            T.debug(3, "<UM>:Showing Log Tab")
            panel:SetRecordList(RM:GetRecordList())
            panel:UpdatePanel()
        end
    )
    UM.logPanel:SetDeleteCallback(
        function(cell)
            local dialog = SafePopup_Show("GDKP_DELETE_RECORD", cell:GetRecord():GetDesc())
            dialog.cell = cell
            dialog.panel = UM.logPanel
        end
    )
    UM.logPanel:SetNewCallback(
        function(cell)
            RM:AddRecord(cell:GetRecord())
            UM.logPanel:AddRecord(cell:GetRecord())
        end
    )
end
local function GDKP_e838e7b159f6b9b809176a283d1d7502()
    T.debug(3, "<UM>: GDKP_e838e7b159f6b9b809176a283d1d7502()")
    local frame = _G["GDKPManageFrame"]
    RegisterForSaveFrame(frame)
    GDKP_993d50d2de8d657e2fac9639ff63a42b(frame)
    GDKP_e02c71e1241bcc3c74ba4f8152ea6a49(frame)
    PanelTemplates_SetNumTabs(frame, 3)
    GDKPManageFrameTab_OnClick(frame, 1)
    return frame
end
local x1 = 0.3
local y1 = 0.3
local x2 = 0.7
local y2 = 0.7
local texturePieces = {
    {
        name = "TopLeft",
        point1 = {"TOPLEFT", "Parent", "TOPLEFT"},
        texCoord = {startX = 0, endX = x1, startY = 0, endY = y1}
    },
    {
        name = "TopRight",
        point1 = {"TOPRIGHT", "Parent", "TOPRIGHT"},
        texCoord = {startX = x2, endX = 1, startY = 0, endY = y1}
    },
    {
        name = "BottomLeft",
        point1 = {"BOTTOMLEFT", "Parent", "BOTTOMLEFT"},
        texCoord = {startX = 0, endX = x1, startY = y2, endY = 1}
    },
    {
        name = "BottomRight",
        point1 = {"BOTTOMRIGHT", "Parent", "BOTTOMRIGHT"},
        texCoord = {startX = x2, endX = 1, startY = y2, endY = 1}
    },
    {
        name = "Left",
        point1 = {"TOPLEFT", "TopLeft", "BOTTOMLEFT"},
        point2 = {"BOTTOMLEFT", "BottomLeft", "TOPLEFT"},
        texCoord = {startX = 0, endX = x1, startY = y1, endY = y2}
    },
    {
        name = "Right",
        point1 = {"TOPRIGHT", "TopRight", "BOTTOMRIGHT"},
        point2 = {"BOTTOMRIGHT", "BottomRight", "TOPRIGHT"},
        texCoord = {startX = x2, endX = 1, startY = y1, endY = y2}
    },
    {
        name = "Top",
        point1 = {"TOPLEFT", "TopLeft", "TOPRIGHT"},
        point2 = {"TOPRIGHT", "TopRight", "TOPLEFT"},
        texCoord = {startX = x1, endX = x2, startY = 0, endY = y1}
    },
    {
        name = "Bottom",
        point1 = {"BOTTOMLEFT", "BottomLeft", "BOTTOMRIGHT"},
        point2 = {"BOTTOMRIGHT", "BottomRight", "BOTTOMLEFT"},
        texCoord = {startX = x1, endX = x2, startY = y2, endY = 1}
    },
    {
        name = "Center",
        point1 = {"BOTTOMLEFT", "BottomLeft", "TOPRIGHT"},
        point2 = {"TOPRIGHT", "TopRight", "BOTTOMLEFT"},
        texCoord = {startX = x1, endX = x2, startY = y2, endY = y2}
    }
}
local function GDKP_41b8bcac30854521200367706b48d656(self, file)
    local textureTable = {}
    for i = 1, #texturePieces do
        local piece = texturePieces[i]
        local coord = piece.texCoord
        local point1 = piece.point1
        local point2 = piece.point2
        local texture = self:CreateTexture(self:GetName() .. piece.name, "BACKGROUND")
        texture:SetTexture(file)
        texture:SetWidth(15)
        texture:SetHeight(15)
        texture:SetTexCoord(coord.startX, coord.endX, coord.startY, coord.endY)
        if point1 then
            if point1[2] == "Parent" then
                texture:SetPoint(point1[1], self, point1[3])
            else
                texture:SetPoint(point1[1], _G[self:GetName() .. point1[2]], point1[3])
            end
        end
        if point2 then
            if point2[2] == "Parent" then
                texture:SetPoint(point2[1], self, point2[3])
            else
                texture:SetPoint(point2[1], _G[self:GetName() .. point2[2]], point2[3])
            end
        end
        tinsert(textureTable, texture)
    end
end
function GDKP_Frame_OnLoad(self)
    GDKP_41b8bcac30854521200367706b48d656(self, [[Interface\AddOns\GDKP\img\frameborder]])
end
function GDKP_InnerFrame_OnLoad(self)
    GDKP_41b8bcac30854521200367706b48d656(self, [[Interface\AddOns\GDKP\img\innerframeborder]])
end
function GDKP_MainFrameShowButtons()
    UM.mainFrame.resetButton:Show()
    UM.mainFrame.reportButton:Show()
    UM.mainFrame.saveButton:Show()
    UM.mainFrame.profitText:Show()
    UM.mainFrame.expenseText:Show()
    UM.mainFrame.tankSubsideText:Show()
    UM.mainFrame.healerSubsideText:Show()
    UM.mainFrame.profitLabel:Show()
    UM.mainFrame.expenseLabel:Show()
    UM.mainFrame.tankSubsideLabel:Show()
    UM.mainFrame.healerSubsideLabel:Show()
end
function GDKP_MainFrameHideButtons()
    UM.mainFrame.resetButton:Hide()
    UM.mainFrame.reportButton:Hide()
    UM.mainFrame.saveButton:Hide()
    UM.mainFrame.profitText:Hide()
    UM.mainFrame.expenseText:Hide()
    UM.mainFrame.tankSubsideText:Hide()
    UM.mainFrame.healerSubsideText:Hide()
    UM.mainFrame.profitLabel:Hide()
    UM.mainFrame.expenseLabel:Hide()
    UM.mainFrame.tankSubsideLabel:Hide()
    UM.mainFrame.healerSubsideLabel:Hide()
end
function GDKPManageFrameTab_OnClick(self, id)
    if (not id) then
        id = self:GetID()
    end
    PanelTemplates_SetTab(GDKPManageFrame, id)
    if id == 1 then
        UM.incomePanel:UpdatePanel()
        UM.incomePanel:Show()
        UM.expensePanel:Hide()
        UM.logPanel:Hide()
    elseif id == 2 then
        UM.incomePanel:Hide()
        UM.expensePanel:UpdatePanel()
        UM.expensePanel:Show()
        UM.logPanel:Hide()
    elseif id == 3 then
        UM.incomePanel:Hide()
        UM.expensePanel:Hide()
        UM.logPanel:UpdatePanel()
        UM.logPanel:Show()
    end
    self:SetFrameLevel(self:GetParent():GetFrameLevel() + 4)
end
function ShowGDKPPanel()
    UM.mainFrame:Show()
end
function HideGDKPPanel()
    UM.mainFrame.editable:Hide()
    UM.mainFrame:Hide()
    UM.newIncomeFrame:Hide()
    UM.manageFrame:Hide()
end
function UM:SetNumMember(num)
    self.mainFrame.memberEditBox:SetText(num)
end
function UM:OnRaidMemberChange()
    BigFoot_DelayCall(
        function()
            local numRaidMemebers = GetNumGroupMembers()
            if numRaidMemebers > 1 and not GM:IsUserSetted() then
                self:SetNumMember(numRaidMemebers)
            end
        end,
        1
    )
end
function UM:UpdateGoldDisplay()
    self.mainFrame.incomeText:SetText(("%d金"):format(GM:GetIncome()))
    self.mainFrame.expenseText:SetText(("%d金"):format(GM:GetExpense()))
    if GM:GetNumMembers() and GM:GetNumMembers() > 0 then
        self.mainFrame.aveProfitText:SetText(("%d金"):format(max(GM:GetProfit() / GM:GetNumMembers(), 0)))
    else
        self.mainFrame.aveProfitText:SetText("N/A")
    end
    self.mainFrame.profitText:SetText(("%d金"):format(GM:GetProfit()))
    self.mainFrame.tankSubsideText:SetText(("%d金"):format(GM:GetTankSubsidy()))
    self.mainFrame.healerSubsideText:SetText(("%d金"):format(GM:GetHealerSubsidy()))
end
function UM:OnInitialize()
    T.debug(3, "<UM>: Initializing...")
    self.newIncomeFrame = GDKP_b46a9a8d0d453ba05fdc42241de4dbf1()
    GDKP_ecdc44ef55e944effa19684f3c4c942a()
    GDKP_a46102b8fc80c5b62666117722e42454()
    GDKP_1d708ad1bb49e15326da5aca9c924459()
    self.manageFrame = GDKP_e838e7b159f6b9b809176a283d1d7502()
    self.mainFrame = GDKP_9693cf7251ebd2f6eb6bc572b2e5a188()
end
function UM:OnEnable()
    T.debug(3, "<UM>: Enabling...")
    T.debug(3, "<UM>: Enabled")
end
function UM:OnDisable()
end
function UM:Reset()
    UM:UpdateGoldDisplay()
    self.mainFrame.editable:Hide()
    self.newIncomePanel:Hide()
    self.manageFrame:Hide()
end
function T:Reset()
    RM:Reset()
    GM:Reset()
    UM:Reset()
end
function T:Report()
    if GetNumGroupMembers() < 1 then
        return
    end
    local str = "*** [GDKP] 团队通报 ***\n"
    str =
        str ..
        RM:GetReport(
            function(report)
                if AceOO.inherits(report, T.Templates.TrivialRecord) then
                    return false
                end
                return true
            end
        )
    str = str .. GM:GetReport()
    str = str .. "-感谢使用大脚金团辅助工具-\n"
    for line in str:gmatch("[^\n]+") do
        SendChatMessage(line, "RAID")
    end
end
function T:OnInitialize()
    T.debug(3, "<GDKP>: Initializing...")
    self.db = LibStub("AceDB-3.0"):New("GDKP_DB", defaults, true)
end
function T:CHAT_MSG_LOOT(...)
    local _, message = ...
    local player, itemLink, itemString = GDKP_93dd10c14ba6d9968dde1fcd8b5345c8(message)
    if not player then
        return
    end
    T.debug(2, "<GDKP>:Player is " .. player)
    T.debug(2, "<GDKP>:ItemLink is " .. itemLink)
    T.debug(2, "<GDKP>:ItemString is " .. itemString)
    local name, link, quality = GetItemInfo(itemLink)
    if (name and quality) then
        if GDKP_332126e2e82fafa6f5d15f912aba69c6(link) then
            return
        end
        if quality >= 4 or _debug >= 1 then
            RM:AddRecord(RM:NewRecord("NormalItem", {}, itemString, player))
        end
    end
end
function T:CHAT_MSG_SYSTEM(...)
    local _, message = ...
    local member1 = message and message:match(GDKP_RAID_MEMBER_ADDED)
    local member2 = message and message:match(GDKP_RAID_MEMBER_REMOVED)
    local member3 = message and message:match(GDKP_RAID_YOU_JOINED)
    local member4 = message and message:match(GDKP_RAID_YOU_LEFT)
    T.debug(2, "<GDKP>:System message is " .. message)
    if member1 then
        T.debug(2, "<GDKP>: " .. member1 .. " joined party")
        RM:AddRecord(RM:NewRecord("Trivial", {}, 1, member1))
        EM:FireEvent("NUM_MEMBER_CHANGED")
    elseif member2 then
        T.debug(2, "<GDKP>: " .. member2 .. " left party")
        RM:AddRecord(RM:NewRecord("Trivial", {}, 2, member2))
        EM:FireEvent("NUM_MEMBER_CHANGED")
    elseif member3 then
        T.debug(2, "<GDKP>: " .. UnitName("player") .. " joined party")
        RM:AddRecord(RM:NewRecord("Trivial", {}, 1, UnitName("player")))
        EM:FireEvent("NUM_MEMBER_CHANGED")
    elseif member4 then
        T.debug(2, "<GDKP>: " .. UnitName("player") .. " left party")
        RM:AddRecord(RM:NewRecord("Trivial", {}, 2, UnitName("player")))
        EM:FireEvent("NUM_MEMBER_CHANGED")
    end
end
function T:ChatEdit_InsertLink(text)
    if not text then
        return
    end
    T.debug(2, "ChatEdit_InsertLink() - Itemlink: " .. text)
    local panel = _G["RecordItemEditableUI"]
    local panelText = _G["RecordItemEditableUIDescText"]
    if (panel and panel:IsVisible() and panelText:HasFocus()) then
        if GDKP_d46ced55976240072f56c23890a2fc3b(panelText:GetText()) then
            return false
        end
        T.debug(2, "ChatEdit_InsertLink(): Editbox adding link")
        panelText:SetText(panelText:GetText() .. text)
        return true
    else
        self.hooks.ChatEdit_InsertLink(text)
    end
end
local GDKP_TOGGLE_TEXT
if (GetLocale() == "zhTW") then
    GDKP_TOGGLE_TEXT = "點擊打開關閉大腳金團助手"
elseif (GetLocale() == "zhCN") then
    GDKP_TOGGLE_TEXT = "点击打开关闭大脚金团助手"
else
    GDKP_TOGGLE_TEXT = "Click to toggle GDKP"
end
local LDB = LibStub("LibDataBroker-1.1", true)
if not LDB then
    return
end
local GDKPLauncher =
    LDB:NewDataObject(
    "GDKP",
    {type = "launcher", icon = "Interface\\Icons\\inv_misc_coin_17", label = GDKP_TOGGLE_TEXT, OnClick = function()
            if GDKPMainFrame:IsShown() then
                HideGDKPPanel()
            else
                GDKPMainFrame:SetClampedToScreen(true)
                ShowGDKPPanel()
            end
        end, OnTooltipShow = function(tt)
            tt:AddLine(GDKP_TEXT_TITLE)
            tt:AddLine(GDKP_TOGGLE_TEXT)
        end}
)
local GDKPLDBIcon = LibStub("LibDBIcon-1.0", true)
if not GDKPLDBIcon then
    return
end
hooksecurefunc(
    GDKP,
    "OnInitialize",
    function(self)
        self.db.profile.minimap = self.db.profile.minimap or {hide = false, minimapPos = 240, radius = 80}
        GDKPLDBIcon:Register("GDKP", GDKPLauncher, self.db.profile.minimap)
    end
)
function T:OnEnable()
    T.debug(3, "<GDKP>: Enabling...")
    GDKP_9f069b4b2abd8b59dd593eb05c0eb053()
    self:RegisterEvent("CHAT_MSG_SYSTEM")
    self:RegisterEvent("CHAT_MSG_LOOT")
    self:RawHook("ChatEdit_InsertLink", true)
    EM:RegisterEvent("UPDATE_GOLD", GM.UpdateRecords, GM)
    EM:RegisterEvent("UPDATE_GOLD", UM.UpdateGoldDisplay, UM)
    EM:RegisterEvent("NUM_MEMBER_CHANGED", UM.OnRaidMemberChange, UM)
    GDKPLDBIcon:Show("GDKP")
end
function T:OnDisable()
    GDKPLDBIcon:Hide("GDKP")
end
local TM = T:NewModule("TestManager")
if not TM then
    return
end --[[ function TM:TestNormalItemRecord() local testDB1 = {} local record1 = T.Templates.NormalItemRecord:new(testDB1,"ItemName") print(record1) record1:SetUnit("Unit1") record1:SetIncome(500) print(record1) end function TM:TestSpecialIncomeRecord() local testDB2 = {} local record2 = T.Templates.SpecialIncomeRecord:new(testDB2,"ItemDesc") print(record2) record2:SetUnit("Unit1") record2:SetIncome(500) print(record2) end function TM:TestExpenseRecord() local testDB3 = {} local record3 = T.Templates.ExpenseRecord:new(testDB3,2) print(record3) record3:SetExpense(500) print(record3) end function TM:TestTrivialRecord() local testDB4 = {} local record4 = T.Templates.TrivialRecord:new(testDB4,2,"UnitName") print(record4) end function TM:TestRecordGoldEditable() local testDB2 = {} local record2 = T.Templates.SpecialIncomeRecord:new(testDB2,"ItemDesc") record2:SetUnit("Unit1") record2:SetIncome(500) local editable = T.Templates.RecordGoldEditable:new("GDKPTestGoldEditable") editable:SetPoint("CENTER",UIParent,"CENTER",0,-100) editable:SetRecord(record2) editable:Update() end function TM:TestRecordItemEditable() local editable = T.Templates.RecordItemEditable:new("GDKPTestItemEditable") editable:SetPoint("CENTER",UIParent,"CENTER",0,-200) editable:Show() end function TM:TestRecordExpenseEditable() local editable = T.Templates.RecordExpenseEditable:new("GDKPTestExpenseEditable") editable:SetPoint("CENTER",UIParent,"CENTER",0,-400) editable:Show() end function TM:TestLogCell() local testDB1 = {} local record1 = T.Templates.NormalItemRecord:new(testDB1,"ItemName") record1:SetUnit("Unit1") record1:SetIncome(500) local cell = T.Templates.LogCell:new("GDKPTestLogCell") cell:SetPoint("CENTER",UIParent,"CENTER",0,400) cell:Update() cell:SetRecord(record1) cell:Update() end function TM:TestIncomeCell() local testDB1 = {} local record1 = T.Templates.NormalItemRecord:new(testDB1,"ItemName") record1:SetUnit("Unit1") record1:SetIncome(500) local cell = T.Templates.IncomeCell:new("GDKPTestIncomeCell") cell:SetPoint("CENTER",UIParent,"CENTER",0,300) cell:SetEditableCallback(function(editable) cell:Update() end) cell:SetDeleteCallback( function(cell) print(cell:GetRecord()) end ) cell:SetRecord(record1) cell:Update() end function TM:TestExpenseCell() local testDB3 = {} local record3 = T.Templates.ExpenseRecord:new(testDB3,2) record3:SetExpense(500) local cell = T.Templates.ExpenseCell:new("GDKPTestExpenseCell") cell:SetPoint("CENTER",UIParent,"CENTER",0,200) cell:Update() cell:SetRecord(record3) cell:Update() end function TM:TestNewIncomeCell() local testDB1 = {} local record1 = T.Templates.NormalItemRecord:new(testDB1,"ItemName") record1:SetUnit("Unit1") record1:SetIncome(500) local cell = T.Templates.NewIncomeCell:new("GDKPTestNewIncomeCell") cell:SetPoint("CENTER",UIParent,"CENTER",0,100) cell:Update() cell:SetRecord(record1) cell:Update() end function TM:TestPanels() end function TM:TestLogPanel() local testDB1,testDB2,testDB3,testDB4,testDB5,testDB6,testDB7,testDB8,testDB9 = {},{},{},{},{},{},{},{},{} local record1 = T.Templates.NormalItemRecord:new(testDB1,"ItemName1") record1:SetUnit("Unit1") record1:SetIncome(200) local record2 = T.Templates.NormalItemRecord:new(testDB2,"ItemName2") record2:SetUnit("Unit2") record2:SetIncome(400) local record3 = T.Templates.NormalItemRecord:new(testDB3,"ItemName3") record3:SetUnit("Unit3") record3:SetIncome(600) local record4 = T.Templates.NormalItemRecord:new(testDB4,"ItemName4") record4:SetUnit("Unit4") record4:SetIncome(800) local panel1 = T.Templates.LogPanel:new() panel1:Show() panel1:AddRecord(record1) panel1:AddRecord(record2) panel1:AddRecord(record3) panel1:AddRecord(record4) panel1:SetPoint("CENTER",UIParent,"CENTER",400,200) end ]]
function TM:TestIncomePanel()
    local testDB1, testDB2, testDB3, testDB4, testDB5, testDB6, testDB7, testDB8, testDB9 = {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {}
    local record1 = T.Templates.NormalItemRecord:new(testDB1, "ItemName1")
    record1:SetUnit("Unit1")
    record1:SetIncome(200)
    local record2 = T.Templates.NormalItemRecord:new(testDB2, "ItemName2")
    record2:SetUnit("Unit2")
    record2:SetIncome(400)
    local record3 = T.Templates.NormalItemRecord:new(testDB3, "ItemName3")
    record3:SetUnit("Unit3")
    record3:SetIncome(600)
    local record4 = T.Templates.NormalItemRecord:new(testDB4, "ItemName4")
    record4:SetUnit("Unit4")
    record4:SetIncome(800)
    local record5 = T.Templates.NormalItemRecord:new(testDB5, "ItemName5")
    record5:SetUnit("Unit5")
    record5:SetIncome(800)
    local record6 = T.Templates.NormalItemRecord:new(testDB6, "ItemName6")
    record6:SetUnit("Unit6")
    record6:SetIncome(800)
    local record7 = T.Templates.NormalItemRecord:new(testDB7, "ItemName7")
    record7:SetUnit("Unit7")
    record7:SetIncome(800)
    local record8 = T.Templates.NormalItemRecord:new(testDB8, "ItemName8")
    record8:SetUnit("Unit8")
    record8:SetIncome(800)
    local record9 = T.Templates.NormalItemRecord:new(testDB9, "ItemName9")
    record9:SetUnit("Unit9")
    record9:SetIncome(800)
    local panel1 = T.Templates.IncomePanel:new()
    panel1:Show()
    panel1:AddRecord(record1)
    panel1:AddRecord(record2)
    panel1:AddRecord(record3)
    panel1:AddRecord(record4)
    panel1:AddRecord(record5)
    panel1:AddRecord(record6)
    panel1:AddRecord(record7)
    panel1:AddRecord(record8)
    panel1:AddRecord(record9)
    panel1:SetPoint("CENTER", UIParent, "CENTER", 100, 300)
end
function TM:TestNewIncomePanel()
    local testDB1, testDB2, testDB3, testDB4, testDB5, testDB6, testDB7, testDB8, testDB9 = {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {}
    local record1 = T.Templates.NormalItemRecord:new(testDB1, "ItemName1")
    record1:SetUnit("Unit1")
    record1:SetIncome(200)
    local record2 = T.Templates.NormalItemRecord:new(testDB2, "ItemName2")
    record2:SetUnit("Unit2")
    record2:SetIncome(400)
    local record3 = T.Templates.NormalItemRecord:new(testDB3, "ItemName3")
    record3:SetUnit("Unit3")
    record3:SetIncome(600)
    local record4 = T.Templates.NormalItemRecord:new(testDB4, "ItemName4")
    record4:SetUnit("Unit4")
    record4:SetIncome(800)
    local record5 = T.Templates.NormalItemRecord:new(testDB5, "ItemName5")
    record5:SetUnit("Unit5")
    record5:SetIncome(800)
    local panel1 = T.Templates.NewIncomePanel:new()
    panel1:Show()
    panel1:AddRecord(record1)
    panel1:AddRecord(record2)
    panel1:AddRecord(record3)
    panel1:AddRecord(record4)
    panel1:AddRecord(record5)
    panel1:AddRecord(record6)
    panel1:AddRecord(record7)
    panel1:AddRecord(record8)
    panel1:AddRecord(record9)
    panel1:SetPoint("CENTER", UIParent, "CENTER", 100, -300)
end
function TM:TestExpensePanel()
    local testDB4, testDB5, testDB6, testDB7, testDB8 = {}, {}, {}, {}, {}
    local record4 = T.Templates.ExpenseRecord:new(testDB4, 2)
    record4:SetExpense(300)
    local record5 = T.Templates.ExpenseRecord:new(testDB5, 3)
    record5:SetExpense(500)
    local record6 = T.Templates.ExpenseRecord:new(testDB6, 1)
    record6:SetExpense(200)
    local record7 = T.Templates.ExpenseRecord:new(testDB7, 2)
    record7:SetExpense(700)
    local record8 = T.Templates.ExpenseRecord:new(testDB8, 3)
    record8:SetExpense(900)
    local panel1 = T.Templates.ExpensePanel:new()
    panel1:Show()
    panel1:AddRecord(record4)
    panel1:AddRecord(record5)
    panel1:AddRecord(record6)
    panel1:AddRecord(record7)
    panel1:AddRecord(record8)
    panel1:SetPoint("CENTER", UIParent, "CENTER", 700, 300)
end
function TM:Run()
    DEFAULT_CHAT_FRAME:SetMaxResize(600, 1000)
    DEFAULT_CHAT_FRAME:SetMaxLines(2000)
    print("|cff3344AA***************** <TM> *****************|r ")
    print("|cff3344AA************* Tests Start **************|r")
    print("|cff3344AA********************************************|r ")
    print("")
    local success, failed, res, messages = 0, 0, true, {}
    for inx, val in pairs(self) do
        if inx:find("^Test") and type(val) == "function" then
            local message
            print(" ")
            print("|cff3344AA******************|r")
            print("|cff3344AA<TM>:|r Running " .. inx .. "()")
            res, message = pcall(val, self)
            if res then
                success = success + 1
                print("|cff00DD22<TM>:|r " .. inx .. "() Succeed.")
            else
                failed = failed + 1
                messages[inx] = message
                print("|cffEE0022<TM>: |r " .. inx .. "() Failed.")
            end
            print("|cff3344AA******************|r")
        end
    end
    print(" ")
    print("|cff3344AA***************** <TM> *****************|r ")
    print("|cff3344AA************* Tests Ended ************|r")
    print("|cff3344AA********************************************|r ")
    if failed > 0 then
        print(
            "|cff3344AA<TM>:|r Total |cffEE0022" ..
                success + failed ..
                    "|r test cases ran, |cffEE0022" .. success .. "/" .. (success + failed) .. "|r Succeed."
        )
    else
        print(
            "|cff3344AA<TM>:|r Total |cff00DD22" ..
                success + failed ..
                    "|r test cases ran, |cff00DD22" .. success .. "/" .. (success + failed) .. "|r Succeed."
        )
    end
    for inx, val in pairs(messages) do
        print("|cffEE0022<TM>: |r" .. inx .. " Failed at: |cffCC0022" .. val .. "|r")
    end
end
function TM:OnEnable()
end
function TM:OnDisable()
end
