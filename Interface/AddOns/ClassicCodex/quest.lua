local L = LibStub("AceLocale-3.0"):GetLocale("ClassicCodex")

CodexQuest = CreateFrame("Frame")

CodexQuest.queue = {}
CodexQuest.questLog = {}
CodexQuest.questLogTemp = {}
CodexQuest.updateNodes = false

CodexQuest:RegisterEvent("QUEST_WATCH_UPDATE")
CodexQuest:RegisterEvent("QUEST_LOG_UPDATE")
CodexQuest:RegisterEvent("QUEST_FINISHED")
CodexQuest:RegisterEvent("PLAYER_LEVEL_UP")
CodexQuest:RegisterEvent("PLAYER_ENTERING_WORLD")
-- This event is triggered frequently when the player level is low. But it usually does not change the state of quests.
-- To avoid performance issues, it is no longer registered.
--CodexQuest:RegisterEvent("SKILL_LINES_CHANGED")
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
    elseif event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" --[[or event == "SKILL_LINES_CHANGED"]] then
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

                    if not header and GetActiveTitle(index) == title and complete == 1 then
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
            -- arg1: unitID
            CodexQuest:UpdateNameplate(...)
        end

    elseif (event == "NAME_PLATE_UNIT_REMOVED") then
        if CodexConfig.nameplateIcon then
            -- arg1: unitID
            CodexQuest:HideNameplate(...)
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
        if CodexConfig.allQuestGivers and CodexConfig.trackingMethod ~= 4 then
            local meta = {["addon"] = "CODEX"}
            CodexDatabase:SearchQuests(meta)
            CodexQuest.updateNodes = true
        end
        CodexQuest.updateQuestGivers = false
    end

    if CodexQuest.updateNodes == true then
        CodexMap:UpdateNodes()
        CodexQuest:UpdateAllNameplates()
        CodexQuest.updateNodes = false
    end
end)

function CodexQuest:UpdateQuestLog()
    CodexQuest.questLogTemp = {}

    local _, numQuests = GetNumQuestLogEntries()
    local found = 0
    local quests = CodexDB.quests.loc

    -- iterate over all quests
    for questLogId = 1, 40 do
        local _, _, _, header, _, complete, _, questId = GetQuestLogTitle(questLogId)
        local objectives = GetNumQuestLeaderBoards(questLogId)
        local watched = IsQuestWatched(questLogId)

        if not header and quests[questId] then
            local title = quests[questId].T

            -- add new quest to the quest log
            if not CodexQuest.questLog[title] then
                CodexQuest.questLogTemp[title] = {ids = {questId}, questLogId = questLogId, state = "init"}

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
                    -- sometimes you got nil and nil, just like the quest 1149 (Test of Faith)
                    if text then
                        -- Different languages use different separators in the quest state line,
                        -- so the regular expression needs to be localized.
                        local _, _, obj, objNum, objNeeded = strfind(text, L["QUEST_STATE_SPLIT_REGEXP"])
                        if obj then
                            state = state .. i .. (((objNum + 0 >= objNeeded + 0) or done) and "done" or "todo")
                        end
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
            CodexQuest.updateNodes = true
            CodexQuest.updateQuestGivers = true
        end
    end

    -- set new questlog
    CodexQuest.questLog = CodexQuest.questLogTemp

    -- process queue
    if CodexConfig.trackingMethod ~= 4  and table.getn(CodexQuest.queue) > 0 then
        for id, entry in pairs(CodexQuest.queue) do
            if CodexConfig.trackingMethod ~= 2 or IsQuestWatched(entry[3]) then
                CodexMap:DeleteNode("CODEX", entry[1])
                if CodexConfig.trackingMethod ~= 3 then
                    local meta = {["addon"] = "CODEX", ["questLogId"] = entry[3]}
                    for _, id in pairs(entry[2]) do
                        CodexDatabase:SearchQuestById(id, meta)
                    end
                end
                CodexQuest.updateNodes = true
            end
        end

        CodexQuest.queue = {}
    end
end

-- Force reset
-- Please keep the interface stable. Other addons may add a Reset button through this function.
function CodexQuest:ResetAll()
    CodexMap.DeleteNode("CODEX")
    CodexQuest.questLog = {}
    CodexQuest.updateQuestLog = true
    CodexQuest.updateQuestGivers = true
    CodexQuest.updateNodes = true
end

-- Display the selected quest in the quest log
-- Please keep the interface stable. Other addons may add a Show button through this function.
function CodexQuest:ShowCurrentQuest()
    local questIndex = GetQuestLogSelection()
    local _, _, _, header, _, _, _, questId = GetQuestLogTitle(questIndex)
    if header then return end

    local maps, meta = {}, {["addon"] = "CODEX", ["questLogId"] = questIndex}
    maps = CodexDatabase:SearchQuestById(questId, meta, maps)
    CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
end

-- Hide the selected quest in the quest log
-- Please keep the interface stable. Other addons may add a Hide button through this function.
function CodexQuest:HideCurrentQuest()
    local quests = CodexDB.quests.loc
    local questIndex = GetQuestLogSelection()
    local _, _, _, header, _, complete, _, questId = GetQuestLogTitle(questIndex)
    if header or not quests[questId] then return end

    CodexMap:DeleteNode("CODEX", quests[questId].T)
    CodexMap:UpdateNodes()
end

function CodexQuest:AddQuestLogIntegration()
    local dockFrame = QuestLogDetailScrollChildFrame
    local dockTitle = QuestLogDescriptionTitle

    dockTitle:SetHeight(dockTitle:GetHeight() + 30)
    dockTitle:SetJustifyV("BOTTOM")

    CodexQuest.buttonShow = CodexQuest.buttonShow or CreateFrame("Button", "CodexQuestShow", dockFrame, "UIPanelButtonTemplate")
    CodexQuest.buttonShow:SetWidth(70)
    CodexQuest.buttonShow:SetHeight(20)
    CodexQuest.buttonShow:SetText(L["Show"])
    CodexQuest.buttonShow:SetPoint("TOP", dockTitle, "TOP", -110, 0)
    CodexQuest.buttonShow:SetScript("OnClick", function()
        CodexQuest:ShowCurrentQuest()
    end)

    CodexQuest.buttonHide = CodexQuest.buttonHide or CreateFrame("Button", "CodexQuestHide", dockFrame, "UIPanelButtonTemplate")
    CodexQuest.buttonHide:SetWidth(70)
    CodexQuest.buttonHide:SetHeight(20)
    CodexQuest.buttonHide:SetText(L["Hide"])
    CodexQuest.buttonHide:SetPoint("TOP", dockTitle, "TOP", -37, 0)
    CodexQuest.buttonHide:SetScript("OnClick", function()
        CodexQuest:HideCurrentQuest()
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
    CodexQuest.buttonReset:SetText(L["Reset"])
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
            info.text = L["All Quests"]
            info.checked = false
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(CodexQuest.mapButton, self:GetID(), 0)
                CodexConfig.trackingMethod = self:GetID()
                CodexQuest:ResetAll()
            end
            UIDropDownMenu_AddButton(info)

            local info = {}
            info.text = L["Tracked Quests"]
            info.checked = false
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(CodexQuest.mapButton, self:GetID(), 0)
                CodexConfig.trackingMethod = self:GetID()
                CodexQuest:ResetAll()
            end
            UIDropDownMenu_AddButton(info)

            local info = {}
            info.text = L["Manual Selection"]
            info.checked = false
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(CodexQuest.mapButton, self:GetID(), 0)
                CodexConfig.trackingMethod = self:GetID()
                CodexQuest:ResetAll()
            end
            UIDropDownMenu_AddButton(info)

            local info = {}
            info.text = L["Hide Quests"]
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

    if CodexConfig.showTrackingMethodDropdown then
        CodexQuest.mapButton:Show()
    else
        CodexQuest.mapButton:Hide()
    end
end

function CodexQuest:UpdateNameplate(unitID)
    local frame = C_NamePlate.GetNamePlateForUnit(unitID)
    if not frame or frame:IsForbidden() then return end

    local name = UnitName(unitID)
    if not name or not CodexMap.tooltips[name] then return end

    local found = false
    for title in pairs(CodexQuest.questLog) do
        if CodexMap.tooltips[name][title] then
            found = true
            break
        end
    end

    if not found then
        if frame.codexIcon then
            frame.codexIcon:Hide()
        end
        return
    end

    if not frame.codexIcon then
        local icon = CreateFrame("Frame", nil, frame)
        icon:SetFrameStrata("HIGH")
        icon:SetWidth(25)
        icon:SetHeight(25)
        icon:SetPoint("BOTTOM", frame, "TOP", 0, 0)

        local texture = icon:CreateTexture(nil, "HIGH")
        texture:SetTexture("Interface\\Addons\\ClassicCodex\\img\\pickup.tga")
        texture:SetAllPoints(icon)

        icon.texture = texture
        frame.codexIcon = icon
    end

    frame.codexIcon:Show()
end

-- When a nameplate is out of range, its frame will be reused later.
-- If you don't hide the icon, it will appear on the wrong unit.
function CodexQuest:HideNameplate(unitID)
    local frame = C_NamePlate.GetNamePlateForUnit(unitID)
    if not frame or frame:IsForbidden() or not frame.codexIcon then return end
    frame.codexIcon:Hide()
end

function CodexQuest:UpdateAllNameplates()
    for i = 1, 40 do
        local unitID = "nameplate" .. i
        -- Notice: nameplate IDs are not continuous, don't use break
        if UnitExists(unitID) then
            if CodexConfig.nameplateIcon then
                CodexQuest:UpdateNameplate(unitID)
            else
                CodexQuest:HideNameplate(unitID)
            end
        end
    end
end

-- [[ Hook UI Functions ]] --
-- Set certain events on quest watch
hooksecurefunc("RemoveQuestWatch", function(questIndex)
    local quests = CodexDB.quests.loc
    local _, _, _, header, _, complete, _, questId = GetQuestLogTitle(questIndex)
    if not header and quests[questId] then
        CodexMap:DeleteNode("CODEX", quests[questId].T)
        CodexQuest.updateQuestLog = true
        CodexQuest.updateQuestGivers = true
    end
end)

hooksecurefunc("AddQuestWatch", function(questIndex)
    CodexQuest.updateQuestLog = true
    CodexQuest.updateQuestGivers = true
end)
