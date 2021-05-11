-- this function catches the aftooltip extreme function for setting the mouse over unit's name
function MonkeyQuest_NEW_aftt_setName(unit)

    -- call the original aftt setName function
    MonkeyQuest_OLD_aftt_setName(unit);

    -- Overwrite the aftt text with the quest objective completeness, if needed
    MonkeyQuest_SearchTooltip();
end

-- this function catches the bag mouse over tooltip event
function YourSetBagItem(self, bag, slot)

    --MonkeyQuest_NEW_ContainerFrameItemButton_OnEnter(self)
    -- call the old (probably blizzard's) GameTooltip_OnEvent()
    --MonkeyQuest_OLD_ContainerFrameItemButton_OnEnter(self);
    
    MonkeyQuest_SearchTooltip();
    
    MonkeyQuest_SearchTooltipForRelevantQuest();
end

function MonkeyQuest_SearchTooltip()
    local ii, jj;
    
    
    -- does the user not want this feature?
    if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowTooltipObjectives == false) then
        return false;
    end
    
    if (GameTooltip == nil) then
        return false;
    end
    
    if (not _G['GameTooltipTextLeft1']:IsVisible()) then
        -- no more tooltip text, get out
        return false;
    end

    -- check the string isn't nil
    if (_G['GameTooltipTextLeft1']:GetText() ~= nil) then
        if (MonkeyQuest_SearchQuestListItem(_G['GameTooltipTextLeft1']:GetText()) == true) then
            return true;
        end
    end

    -- didn't find an item needing the MonkeyQuest tooltip
    return false;
end

function MonkeyQuest_SearchQuestListItem(strSearch)
    local i, j, length, iStrKeySize, iStrSearchSize;

    
    -- super double check for nil string
    if (strSearch == nil) then
        return false;
    end

    --DEFAULT_CHAT_FRAME:AddMessage("Searching: " .. strSearch);
    
    for key, value in pairs(MonkeyQuest.m_aQuestItemList) do
        i, j = string.find(strSearch, key);

        iStrKeySize = string.len(key);
        iStrSearchSize = string.len(strSearch);

        if (string.find(strSearch, "|c")) then
            -- chop off the colour coding
            iStrSearchSize = iStrSearchSize - 10;
        end

        --DEFAULT_CHAT_FRAME:AddMessage(key .. " == " .. strSearch);

        if (i ~= nil and i ~= j and iStrSearchSize == iStrKeySize) then
            -- found it!
            --DEFAULT_CHAT_FRAME:AddMessage(key .. " == " .. strSearch .. " i= " .. i .. " j= " .. j);

            if (aftt_textline1 ~= nil) then
                -- aftootip is loaded, set the text for it
                aftt_textline1:SetText(strSearch .. " " .. MONKEYQUEST_TOOLTIP_QUESTITEM .. " " .. value.m_iNumItems .. "/" .. value.m_iNumNeeded);
                --DEFAULT_CHAT_FRAME:AddMessage("aftt hack");
            end

            -- TODO: calculate the completeness colour
            local colourTip = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
            
            colourTip.a, colourTip.r, colourTip.g, colourTip.b = MonkeyQuest_GetCompletenessColorStr(value.m_iNumItems, value.m_iNumNeeded);

			local newLine = MONKEYQUEST_TOOLTIP_QUESTITEM .. " " .. value.m_iNumItems .. "/" .. value.m_iNumNeeded
			if (_G[GameTooltip:GetName() .. "TextLeft" .. GameTooltip:NumLines()]:GetText() ~= newLine) then
				GameTooltip:AddLine(newLine, colourTip.r, colourTip.g, colourTip.b, 1);
				
				-- resize the tootip (thanks Turan's AuctionIt)
				length = _G[GameTooltip:GetName() .. "TextLeft" .. GameTooltip:NumLines()]:GetStringWidth();
				
				-- Give the text some border space on the right side of the tooltip.
				length = length + 22;
			
				GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
				if ( length > GameTooltip:GetWidth() ) then
					GameTooltip:SetWidth(length);
				end
            end

            return true;
        end
    end

    return false;
end

function MonkeyQuest_SearchTooltipForRelevantQuest()
    local ii, jj;
    
    
    -- does the user not want this feature?
    if (MonkeyQuestConfig[MonkeyQuest.m_global].m_bShowTooltipObjectives == false) then
        return false;
    end

    if (GameTooltip == nil) then
        return false;
    end
    
    if (not _G['GameTooltipTextLeft1']:IsVisible()) then
        -- no more tooltip text, get out
        return false;
    end

    -- check the string isn't nil
    if (_G['GameTooltipTextLeft1']:GetText() ~= nil) then

        local strRelevantQuest = MonkeyQuest_SearchQuestDetails(_G['GameTooltipTextLeft1']:GetText());

        if (strRelevantQuest ~= nil) then

            GameTooltip:AddLine(MONKEYQUEST_TOOLTIP_QUEST .. ": " .. strRelevantQuest, MONKEYQUEST_DEFAULT_CRASHCOLOUR.r,
                    MONKEYQUEST_DEFAULT_CRASHCOLOUR.g,
                    MONKEYQUEST_DEFAULT_CRASHCOLOUR.b, 1);


            -- resize the tootip (thanks Turan's AuctionIt)
            local length = _G[GameTooltip:GetName() .. "TextLeft" .. GameTooltip:NumLines()]:GetStringWidth();
            -- Give the text some border space on the right side of the tooltip.
            length = length + 22;

            GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
            if ( length > GameTooltip:GetWidth() ) then
                GameTooltip:SetWidth(length);
            end

            return true;
        end
    end

    -- didn't find an item needing the MonkeyQuest tooltip
    return false;
end

-- search for the string anywhere in any quest
function MonkeyQuest_SearchQuestDetails(strSearch)

    -- super double check for nil string
    if (strSearch == nil) then
        return false;
    end
    
    local strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete, questInfo
    local i, j, k;
	local iNumEntries, iNumQuests
	if (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE) then
		iNumEntries, iNumQuests = C_QuestLog.GetNumQuestLogEntries()
	else
		iNumEntries, iNumQuests = GetNumQuestLogEntries()
	end

    for i = 1, iNumEntries, 1 do
        -- strQuestLogTitleText     the title text of the quest, may be a header (ex. Wetlands)
        -- strQuestLevel            the level of the quest
		if (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE) then
			questInfo = C_QuestLog.GetInfo(i)
				
			strQuestLogTitleText = questInfo.title
			strQuestLevel = questInfo.level
			suggestedGroup = questInfo.suggestedGroup
			isHeader = questInfo.isHeader
			isCollapsed = questInfo.isCollapsed
			if (C_QuestLog.IsComplete(questInfo.questID)) then
				isComplete = 1
			elseif (C_QuestLog.IsFailed(questInfo.questID)) then
				isComplete = -1
			end
		else
			strQuestLogTitleText, strQuestLevel, suggestedGroup, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i)
		end

        if (not isHeader) then
            local strQuestDescription, strQuestObjectives = GetQuestLogQuestText(i);

            --DEFAULT_CHAT_FRAME:AddMessage(strSearch .. " == " .. strQuestDescription);
            if (string.find(strQuestDescription, strSearch) or string.find(strQuestObjectives, strSearch)) then
                return strQuestLogTitleText;
            end
        end
    end

    return nil;
end
