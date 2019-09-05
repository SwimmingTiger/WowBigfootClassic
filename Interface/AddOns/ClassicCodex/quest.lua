CodexQuest = CreateFrame("Frame")

CodexQuest.queue = {}
CodexQuest.queueEmptied = false
CodexQuest.abandon = ""
CodexQuest.questLog = {}
CodexQuest.questLogTemp = {}

CodexQuest:RegisterEvent("QUEST_WATCH_UPDATE")
CodexQuest:RegisterEvent("QUEST_LOG_UPDATE")
CodexQuest:RegisterEvent("QUEST_FINISHED")
CodexQuest:RegisterEvent("PLAYER_LEVEL_UP")
CodexQuest:RegisterEvent("PLAYER_ENTERING_WORLD")
CodexQuest:RegisterEvent("SKILL_LINES_CHANGED")
CodexQuest:RegisterEvent("QUEST_DETAIL")
CodexQuest:RegisterEvent("QUEST_PROGRESS")
CodexQuest:RegisterEvent("QUEST_COMPLETE")
CodexQuest:RegisterEvent("QUEST_GREETING")
CodexQuest:RegisterEvent("QUEST_REMOVED")
CodexQuest:RegisterEvent("GOSSIP_SHOW")
CodexQuest:RegisterEvent("NAME_PLATE_UNIT_ADDED")
CodexQuest:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
CodexQuest:RegisterEvent("ADDON_LOADED")
CodexQuest:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        arg1 = ...
        if arg1 == "ClassicCodex" then
            CodexQuest:AddQuestLogIntegration()
            CodexQuest:AddWorldMapIntegration()
        else
            return
        end
    elseif event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" or event == "SKILL_LINES_CHANGED" then
        CodexQuest.updateQuestGivers = true

    elseif (event == "GOSSIP_SHOW") then
        if not CodexConfig.autoAccept or IsControlKeyDown() then
            return 
        end

        local activeQuests = {GetGossipActiveQuests()}
        local activeQuestCount = GetNumGossipActiveQuests()
        local availableQuests = {GetGossipAvailableQuests()}
        local availableQuestCount = GetNumGossipAvailableQuests()

        -- Turn in everything
        if activeQuests and not IsControlKeyDown() then
            for index = 1, activeQuestCount do
                if (activeQuests[(((index - 1) * 6) + 4)] == true) then -- Check if quest complete
                    SelectGossipActiveQuest(index)
                    return
                end
            end
        end

        if (availableQuestCount > 0 and not IsControlKeyDown()) then
            SelectGossipAvailableQuest(1)
            return
        end

        -- Auto Gossip Feature
        -- if not IsControlKeyDown() then
        --     SelectGossipOption(1)
        --     return
        -- end

    elseif (event == "QUEST_DETAIL") then
        if not CodexConfig.autoAccept or IsControlKeyDown() then
            return
        end

        AcceptQuest()

    elseif (event == "QUEST_PROGRESS") then
        if not CodexConfig.autoTurnin or IsControlKeyDown() then
            return
        end

        CompleteQuest()
        
    elseif (event == "QUEST_COMPLETE") then
        if not CodexConfig.autoTurnin or IsControlKeyDown() then
            return
        end

        if (GetNumQuestChoices() <= 1) then
            GetQuestReward(1)
        end

    elseif (event == "QUEST_GREETING") then
        if not CodexConfig.autoAccept or IsControlKeyDown() then
            return
        end

        local availableQuestCount = GetNumAvailableQuests()
        local lastAvailableQuest = 0
        local activeQuestCount = GetNumActiveQuests()
        local lastActiveQuest = 0
        
        if activeQuestCount > 0 then
            for index = 1, activeQuestCount do
                for questLogId = 1, 40 do
                    local title, _, _, header, _, complete = GetQuestLogTitle(questLogId)

                    if GetActiveTitle(index) == title and complete == 1 then
                        SelectActiveQuest(index)
                    end
                end
            end
        end

        if availableQuestCount > 0 then
            for index = 1, availableQuestCount do
                if not IsControlKeyDown() then
                    SelectAvailableQuest(index)
                end
            end
        end

    elseif (event == "NAME_PLATE_UNIT_ADDED") then
        if CodexConfig.nameplateIcon then
            CodexQuest:CheckNamePlate()
        end

    else
        CodexQuest.updateQuestLog = true
    end
end)

CodexQuest:SetScript("OnUpdate", function()
    if (CodexQuest.tick or 0.1) > GetTime() then return else CodexQuest.tick = GetTime() + 0.1 end
    
    if CodexQuest.updateQuestLog == true then
        CodexQuest:UpdateQuestLog()
        CodexQuest.updateQuestLog = false
    end

    if CodexQuest.updateQuestGivers == true then
        if CodexConfig.trackingMethod == 4 then return end
        if CodexConfig.allQuestGivers then
            local meta = {["addon"] = "CODEX"}
            CodexDatabase:SearchQuests(meta)
            CodexMap:UpdateNodes()
            CodexQuest.updateQuestGivers = false
        end
    end

    if CodexConfig.trackingMethod == 4 then return end
    if table.getn(CodexQuest.queue) == 0 and not CodexQuest.queueEmptied then
        return
    elseif table.getn(CodexQuest.queue) == 0 and CodexQuest.queueEmptied then
        CodexQuest.queueEmptied = false
        CodexMap:UpdateNodes()

        return
    end

    -- process queue
    local match = false
    for id, entry in pairs(CodexQuest.queue) do
        match = true

        if CodexConfig.trackingMethod ~= 3 and (CodexConfig.trackingMethod ~= 2 or IsQuestWatched(entry[3])) then
            CodexMap:DeleteNode("CODEX", entry[1])
            local meta = {["addon"] = "CODEX", ["questLogId"] = entry[3]}
            for _, id in pairs(entry[2]) do
                CodexDatabase:SearchQuestById(id, meta)
            end
        end

        CodexQuest.queue[id] = nil

        if table.getn(CodexQuest.queue) == 0 then
            CodexQuest.queueEmptied = true
        end

        return
    end

    -- trigger questgiver update
    if match == false then
        CodexQuest.updateQuestGivers = true
        CodexQuest.queue = {}
    end
end)

function CodexQuest:UpdateQuestLog()
    CodexQuest.questLogTemp = {}

    local _, numQuests = GetNumQuestLogEntries()
    local found = 0

    -- iterate over all quests
    for questLogId = 1, 40 do
        local title, _, _, header, _, complete = GetQuestLogTitle(questLogId)
        local objectives = GetNumQuestLeaderBoards(questLogId)
        local watched = IsQuestWatched(questLogId)

        if title and not header then
            -- add new quest to the quest log
            if not CodexQuest.questLog[title] then
                local questId = CodexDatabase:GetQuestIds(questLogId)
                CodexQuest.questLogTemp[title] = {ids = questId, questLogId = questLogId, state = "init"}

            elseif CodexQuest.questLog[title].questLogId ~= questLogId then
                CodexQuest.questLogTemp[title] = {ids = CodexQuest.questLog[title].ids, questLogId = questLogId, state = CodexQuest.questLog[title].state}
            else
                CodexQuest.questLogTemp[title] = {ids = CodexQuest.questLog[title].ids, questLogId = CodexQuest.questLog[title].questLogId, state = CodexQuest.questLog[title].state}
            end

            -- update progress state
            if objectives then
                local state = watched and "trck" or ""
                for i=1, objectives do
                    local text, _,  done = GetQuestLogLeaderBoard(i, questLogId)
                    local _, _, obj, objNum, objNeeded = strfind(text, "(.*):%s*([%d]+)%s*/%s*([%d]+)")
                    if obj then
                        state = state .. i .. (((objNum + 0 >= objNeeded + 0) or done) and "done" or "todo")
                    end
                end
                CodexQuest.questLogTemp[title].state = state
            end

            found = found + 1
            if found >= numQuests then
                break
            end
        end
    end

    -- quest add events
    for title, data in pairs(CodexQuest.questLogTemp) do
        if not CodexQuest.questLog[title] then
            table.insert(CodexQuest.queue, {title, data.ids, data.questLogId})
        elseif CodexQuest.questLogTemp[title].state ~= CodexQuest.questLog[title].state then
            table.insert(CodexQuest.queue, {title, data.ids, data.questLogId})
        end
    end

    -- quest removal events
    for title, data in pairs(CodexQuest.questLog) do
        if not CodexQuest.questLogTemp[title] then
            CodexMap:DeleteNode("CODEX", title)
            CodexMap:UpdateNodes()

            for _, questId in pairs(CodexQuest.questLog[title].ids) do
                -- Add to history
                if title == CodexQuest.abandon then
                    CodexHistory[questId] = nil
                else
                    CodexHistory[questId] = true
                end
            end

            CodexQuest.abandon = ""
            CodexQuest.updateQuestGivers = true
        end
    end

    -- set new questlog
    CodexQuest.questLog = CodexQuest.questLogTemp
end

-- Force reset
function CodexQuest:ResetAll()
    CodexMap.DeleteNode("CODEX")
    CodexQuest.questLog = {}
    CodexQuest.updateQuestLog = true
    CodexQuest.updateQuestGivers = true
    CodexMap.UpdateNodes()
end

function CodexQuest:AddQuestLogIntegration()
    local dockFrame = QuestLogDetailScrollChildFrame
    local dockTitle = QuestLogDescriptionTitle

    dockTitle:SetHeight(dockTitle:GetHeight() + 30)
    dockTitle:SetJustifyV("BOTTOM")

    CodexQuest.buttonShow = CodexQuest.buttonShow or CreateFrame("Button", "CodexQuestShow", dockFrame, "UIPanelButtonTemplate")
    CodexQuest.buttonShow:SetWidth(70)
    CodexQuest.buttonShow:SetHeight(20)
    CodexQuest.buttonShow:SetText("Show")
    CodexQuest.buttonShow:SetPoint("TOP", dockTitle, "TOP", -110, 0)
    CodexQuest.buttonShow:SetScript("OnClick", function()
        -- CodexQuest:ResetAll()
        local questIndex = GetQuestLogSelection()
        local title, _, _, header, _, complete = GetQuestLogTitle(questIndex)
        if header then return end

        local ids = CodexQuest.questLog[title].ids
        local maps, meta = {}, {["addon"] = "CODEX", ["questLogId"] = questIndex}
        for _, id in pairs(ids) do
            maps = CodexDatabase:SearchQuestById(id, meta, maps)
        end

        CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
    end)

    CodexQuest.buttonHide = CodexQuest.buttonHide or CreateFrame("Button", "CodexQuestHide", dockFrame, "UIPanelButtonTemplate")
    CodexQuest.buttonHide:SetWidth(70)
    CodexQuest.buttonHide:SetHeight(20)
    CodexQuest.buttonHide:SetText("Hide")
    CodexQuest.buttonHide:SetPoint("TOP", dockTitle, "TOP", -37, 0)
    CodexQuest.buttonHide:SetScript("OnClick", function()
        local questIndex = GetQuestLogSelection()
        local title, _, _, header, _, complete = GetQuestLogTitle(questIndex)
        if header then return end

        CodexMap:DeleteNode("CODEX", title)
        CodexMap:UpdateNodes()
    end)

    -- CodexQuest.buttonClean = CodexQuest.buttonClean or CreateFrame("Button", "CodexQuestClean", dockFrame, "UIPanelButtonTemplate")
    -- CodexQuest.buttonClean:SetWidth(70)
    -- CodexQuest.buttonClean:SetHeight(20)
    -- CodexQuest.buttonClean:SetText("Clean")
    -- CodexQuest.buttonClean:SetPoint("TOP", dockTitle, "TOP", 37, 0)
    -- CodexQuest.buttonClean:SetScript("OnClick", function()
    --     CodexMap:DeleteNode("CODEX")
    --     CodexMap:UpdateNodes()
    -- end)

    CodexQuest.buttonReset = CodexQuest.buttonReset or CreateFrame("Button", "CodexQuestReset", dockFrame, "UIPanelButtonTemplate")
    CodexQuest.buttonReset:SetWidth(70)
    CodexQuest.buttonReset:SetHeight(20)
    CodexQuest.buttonReset:SetText("Reset")
    CodexQuest.buttonReset:SetPoint("TOP", dockTitle, "TOP", 37, 0)
    CodexQuest.buttonReset:SetScript("OnClick", function()
        CodexQuest:ResetAll()
    end)
end

function CodexQuest:AddWorldMapIntegration()
    CodexQuest.mapButton = CreateFrame("Frame", "CodexQuestMapDropdown", WorldMapFrame, "UIDropDownMenuTemplate")
    CodexQuest.mapButton:ClearAllPoints()
    CodexQuest.mapButton:SetPoint("TOPRIGHT", 0, -35)
    CodexQuest.mapButton:SetScript("OnShow", function()
        CodexQuest.mapButton.current = tonumber(CodexConfig.trackingMethod)
        CodexQuest.mapButton:updateMenu()
    end)

    CodexQuest.mapButton.point = "TOPLEFT"
    CodexQuest.mapButton.relativePoint = "BOTTOMLEFT"

    function CodexQuest.mapButton:updateMenu()
        local function CreateEntries()
            local info = {}
            info.text = "All Quests"
            info.checked = false
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(CodexQuest.mapButton, self:GetID(), 0)
                CodexConfig.trackingMethod = self:GetID()
                CodexQuest:ResetAll()
            end
            UIDropDownMenu_AddButton(info)

            local info = {}
            info.text = "Tracked Quests"
            info.checked = false
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(CodexQuest.mapButton, self:GetID(), 0)
                CodexConfig.trackingMethod = self:GetID()
                CodexQuest:ResetAll()
            end
            UIDropDownMenu_AddButton(info)

            local info = {}
            info.text = "Manual Selection"
            info.checked = false
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(CodexQuest.mapButton, self:GetID(), 0)
                CodexConfig.trackingMethod = self:GetID()
                CodexQuest:ResetAll()
            end
            UIDropDownMenu_AddButton(info)

            local info = {}
            info.text = "Hide Quests"
            info.checked = false
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(CodexQuest.mapButton, self:GetID(), 0)
                CodexConfig.trackingMethod = self:GetID()
                CodexQuest:ResetAll()
            end
            UIDropDownMenu_AddButton(info)
        end

        UIDropDownMenu_Initialize(CodexQuest.mapButton, CreateEntries)
        UIDropDownMenu_SetWidth(CodexQuest.mapButton, 120)
        UIDropDownMenu_SetButtonWidth(CodexQuest.mapButton, 125)
        UIDropDownMenu_JustifyText(CodexQuest.mapButton, "RIGHT")
        UIDropDownMenu_SetSelectedID(CodexQuest.mapButton, CodexQuest.mapButton.current)
    end
end




function CodexQuest:CheckNamePlate()
    local something = WorldFrame:GetNumChildren()
    local index = 1
    local plateList = {}
    for index = 1, something do
        local frame = select(index, WorldFrame:GetChildren())
        if frame:GetName() and frame:GetName():find("NamePlate%d") and not frame.skinned then
            frame.skinned = 1
            frame.icon = CreateFrame("Frame", nil, frame)
            frame.icon:SetFrameStrata("HIGH")
            frame.icon:SetWidth(25)
            frame.icon:SetHeight(25)

            local texture = frame.icon:CreateTexture(nil, "HIGH")
            texture:SetTexture("Interface\\Addons\\ClassicCodex\\img\\pickup.tga")
            texture:SetAllPoints(frame.icon)
            frame.icon.texture = texture
            frame.icon:SetPoint("BOTTOM", frame, "TOP", 0, 0)
        end
        if frame["UnitFrame"] and frame["UnitFrame"]["displayedUnit"] then
            local name = frame["UnitFrame"]["name"]:GetText()
            frame.icon:Hide()
            for title in pairs(CodexQuest.questLog) do
                if name and CodexMap.tooltips[name] and CodexMap.tooltips[name][title] then
                    frame.icon:Show()
                    break
                else
                    frame.icon:Hide()
                end
            end
        end
    end
end

-- [[ Hook UI Functions ]] --
-- Set certain events on quest watch
local CodexHookRemoveQuestWatch = RemoveQuestWatch
RemoveQuestWatch = function(questIndex)
    local ret = CodexHookRemoveQuestWatch(questIndex)
    local title, _, _, header, _, complete = GetQuestLogTitle(questIndex)
    CodexMap:DeleteNode("CODEX", title)
    CodexQuest.updateQuestLog = true
    CodexQuest.updateQuestGivers = true

    return ret
end

local CodexHookAddQuestWatch = AddQuestWatch
AddQuestWatch = function(questIndex)
    local ret = CodexHookAddQuestWatch(questIndex)
    CodexQuest.updateQuestLog = true
    CodexQuest.updateQuestGivers = true

    return re
end

local CodexHookAbandonQuest = AbandonQuest
AbandonQuest = function()
    CodexQuest.abandon = GetAbandonQuestName()
    CodexHookAbandonQuest()
end
