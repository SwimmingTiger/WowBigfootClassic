SLASH_CODEX1, SLASH_CODEX2 = "/codex", "/classiccodex"
SlashCmdList["CODEX"] = function(input, editBox)
    local params = {}
    local meta = {["addon"] = "CODEX"}

    if (input == "" or input == nil) then
        print("Classic Codex (v" .. tostring(GetAddOnMetadata("ClassicCodex", "Version")) .. "):")
        print("|cff33ffcc/codex|cffffffff show |cffcccccc - 显示数据库浏览器")
        print("|cff33ffcc/codex|cffffffff unit <unit> |cffcccccc - 搜索单位")
        print("|cff33ffcc/codex|cffffffff object <gameObject> |cffcccccc - 搜索物体、目标")
        print("|cff33ffcc/codex|cffffffff item <item> |cffcccccc - 搜索物品")
        print("|cff33ffcc/codex|cffffffff vendor <item> |cffcccccc - 搜索物品售卖者")
        print("|cff33ffcc/codex|cffffffff quest <questName> |cffcccccc - 搜索任务给予者")
        print("|cff33ffcc/codex|cffffffff quests |cffcccccc - 在地图上显示所有任务")
        print("|cff33ffcc/codex|cffffffff meta <relation> [min, [max]] |cffcccccc - 在地图上显示相关目标、对象")
        print("|cff33ffcc/codex|cffffffff clean |cffcccccc - 清理地图")
        print("|cff33ffcc/codex|cffffffff reset |cffcccccc - 重置地图")
        print("|cff33ffcc/codex|cffffffff showquest |cffcccccc - 在地图上显示当前选择的任务")
        print("|cff33ffcc/codex|cffffffff hidequest |cffcccccc - 从地图上隐藏当前选择的任务")
        print("|cff33ffcc ->|cffffffff 可用关系:  |cff33ffccchests|r - 宝箱, |cff33ffccherbs|r - 草药, |cff33ffccmines|r - 矿物")
        return
    end

    local commandList = {}
    local command

    for command in string.gmatch(input, "[^ ]+") do
        table.insert(commandList, command)
    end

    local arg1, arg2 = commandList[1], ""

    for i in pairs(commandList) do
        if i ~= 1 then
            arg2 = arg2 .. commandList[i]
            if commandList[i + 1] ~= nil then
                arg2 = arg2 .. " "
            end
        end
    end

    if arg1 == "unit" then
        local maps = CodexDatabase:SearchUnitByName(arg2, meta, "LOWER", true)
        CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        return
    end

    if arg1 == "object" then
        local maps = CodexDatabase:SearchObjectByName(arg2, meta, "LOWER", true)
        CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        return
    end

    if arg1 == "item" then
        local maps = CodexDatabase:SearchItemByName(arg2, meta, "LOWER", true)
        CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        return
    end

    if arg1 == "vendor" then
        local maps = CodexDatabase:SearchVendorByItemName(arg2, meta, true)
        CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        return
    end

    if arg1 == "quest" then
        local maps = CodexDatabase:SearchQuestByName(arg2, meta, "LOWER", true)
        CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        return
    end

    if arg1 == "quests" then
        local maps = CodexDatabase:SearchQuests(meta)
        CodexMap:UpdateNodes()
        return
    end

    if arg1 == "meta" then
        meta["search"] = true
        local maps = CodexDatabase:SearchMetaRelation({commandList[2], commandList[3], commandList[4]}, meta)
        CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        return
    end

    if arg1 == "clean" then
        CodexMap:DeleteNode("CODEX")
        CodexMap:UpdateNodes()
        return
    end

    if arg1 == "show" then
        if CodexBrowser then CodexBrowser:Show() end
        return
    end

    if arg1 == "reset" then
        CodexQuest:ResetAll()
        return
    end

    if arg1 == "showquest" then
        CodexQuest:ShowCurrentQuest()
        return
    end

    if arg1 == "hidequest" then
        CodexQuest:HideCurrentQuest()
        return
    end

    if type(arg1) == "string" then
        if CodexBrowser then
            CodexBrowser:Show()
            CodexBrowser.input:SetText((string.gsub(string.format("%s %s", arg1, arg2), "^%s*(.-)%s*$", "%1")))
        end
        return
    end
end