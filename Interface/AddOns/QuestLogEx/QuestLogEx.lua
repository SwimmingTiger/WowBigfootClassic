-- Hook Blizzard's questlog methods
function QuestLogEx:HookQuestLog()
	self:RawHook("ToggleQuestLog", true)
	
	self:RawHook("QuestLog_OnEvent", true)
	self:RawHook("QuestLog_OnShow", true)
	self:RawHook("QuestLog_OnHide", true)
	self:RawHook("QuestLog_OnUpdate", true)
	self:RawHook("QuestLog_Update", true)
	self:RawHook("QuestLog_SetSelection", true)
	self:RawHook("QuestLog_UpdateQuestDetails", true)
	self:RawHook("QuestLog_UpdatePartyInfoTooltip", true)
	self:RawHook("QuestLogTitleButton_OnClick", true)
	self:RawHook("QuestLogCollapseAllButton_OnClick", true)

	self:RawHook("QuestFrame_SetAsLastShown", true)
	self:RawHook("QuestFrameItems_Update", true)
end

-- Toggles the questlog extended state
function QuestLogEx:ToggleExtended(extend)
	if QuestLogExFrameDescription:IsVisible() then
		QuestLogExTopRightNormal:Show()
		QuestLogExTopRightExtended:Hide()
		QuestLogExBottomRightNormal:Show()
		QuestLogExBottomRightExtended:Hide()
		
		QuestLogExFrameExitButton:Show()
		QuestLogExDetailExitButton:Hide()
		QuestLogExFrameCloseButton:Show()
		QuestLogExFrameMaximizeButton:Show()
		QuestLogExDetailCloseButton:Hide()
		QuestLogExDetailMinimizeButton:Hide()
	
		HideUIPanel(QuestLogExFrameDescription)
	else
		QuestLogExTopRightExtended:Show()
		QuestLogExTopRightNormal:Hide()
		QuestLogExBottomRightExtended:Show()
		QuestLogExBottomRightNormal:Hide()

		QuestLogExFrameExitButton:Hide()
		QuestLogExDetailExitButton:Show()
		QuestLogExFrameCloseButton:Hide()
		QuestLogExFrameMaximizeButton:Hide()
		QuestLogExDetailCloseButton:Show()
		QuestLogExDetailMinimizeButton:Show()
		
		ShowUIPanel(QuestLogExFrameDescription)
	end
end

function QuestLogEx:Maximize()
	if not QuestLogExFrameDescription:IsVisible() then
		self:ToggleExtended()
	end
end

function QuestLogEx:Minimize()
	if QuestLogExFrameDescription:IsVisible() then
		self:ToggleExtended()
	end
end

--[[
Array-style table to keep track of watched quests and how long we've been watching them for.
	value.id = The quest ID.
	value.timer = Remaining time that we should watch the quest for (or QUEST_WATCH_NO_EXPIRE if we should always watch the quest).
		Note: The watch timer is a value that lives purely in the UI, so we're the source of truth for it.
]]
--QUEST_WATCH_LIST = { };
--MAX_QUEST_WATCH_TIMER = 300;
--QUEST_WATCH_NO_EXPIRE = 999;

-------------------------------
--- Hooked Blizzard methods ---
-------------------------------

function QuestLogEx:ToggleQuestLog()
	if ( QuestLogExFrame:IsVisible() ) then
		HideUIPanel(QuestLogExFrame);
	else
		ShowUIPanel(QuestLogExFrame);
	end
end

function QuestLogEx:QuestLog_OnEvent(self, event, ...)
	local arg1 = ...;
	if ( event == "PLAYER_LOGIN" ) then
		QuestWatch_OnLogin();
	elseif ( event == "QUEST_LOG_UPDATE" or event == "UPDATE_FACTION" or (event == "UNIT_QUEST_LOG_CHANGED" and arg1 == "player") ) then
		QuestLog_Update();
		QuestWatch_Update();
		if ( QuestLogExFrame:IsVisible() ) then
			QuestLog_UpdateQuestDetails(1);
		end
		if ( GetCVar("autoQuestWatch") == "1" ) then
			AutoQuestWatch_CheckDeleted();
		end
	elseif ( event == "QUEST_WATCH_UPDATE" ) then
		if ( GetCVar("autoQuestWatch") == "1" ) then
			AutoQuestWatch_Update(arg1);
		end
	elseif ( eventy == "PLAYER_LEVEL_UP" ) then
		QuestLog_Update();
	else
		QuestLog_Update();
		if ( event == "GROUP_ROSTER_UPDATE" ) then
			-- Determine whether the selected quest is pushable or not
			if ( GetQuestLogPushable() and GetNumGroupMembers() > 0 ) then
				QuestLogExFramePushQuestButton:Enable();
			else
				QuestLogExFramePushQuestButton:Disable();
			end
		end
	end
end

function QuestLogEx:QuestLog_OnShow(self)
	ShowUIPanel(QuestLogExFrame)

	UpdateMicroButtons();
	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN);
	QuestLog_SetSelection(GetQuestLogSelection());
	QuestLog_Update();
end

function QuestLogEx:QuestLog_OnHide(self)
	HideUIPanel(QuestLogExFrame)

	UpdateMicroButtons();
	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE);
end

function QuestLogEx:QuestLog_OnUpdate(self, elapsed)
	if ( QuestLogExFrame.hasTimer ) then
		QuestLogExFrame.timePassed = QuestLogExFrame.timePassed + elapsed;
		if ( QuestLogExFrame.timePassed > UPDATE_DELAY ) then
			QuestLogExTimerText:SetText(TIME_REMAINING.." "..SecondsToTime(GetQuestLogTimeLeft()));
			QuestLogExFrame.timePassed = 0;
		end
	end
end

function QuestLogEx:QuestLog_Update(self)
	local numEntries, numQuests = GetNumQuestLogEntries();
	if ( numEntries == 0 ) then
		EmptyQuestLogExFrame:Show();
		QuestLogExFrameAbandonButton:Disable();
		QuestLogExFrame.hasTimer = nil;
		QuestLogExDetailScrollFrame:Hide();
		QuestLogExExpandButtonFrame:Hide();
	else
		EmptyQuestLogExFrame:Hide();
		QuestLogExFrameAbandonButton:Enable();
		QuestLogExDetailScrollFrame:Show();
		QuestLogExExpandButtonFrame:Show();
	end

	-- Update Quest Count
	QuestLogExQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
	QuestLogExCountMiddle:SetWidth(QuestLogQuestCount:GetWidth());

	-- ScrollFrame update
	FauxScrollFrame_Update(QuestLogExListScrollFrame, numEntries, 27, QUESTLOG_QUEST_HEIGHT, nil, nil, nil, QuestLogExHighlightFrame, 293, 316 )
	
	-- Update the quest listing
	QuestLogExHighlightFrame:Hide();
	
	local questIndex, questLogTitle, questTitleTag, questNumGroupMates, questNormalText, questHighlight, questCheck;
	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, color;
	local numPartyMembers, partyMembersOnQuest, tempWidth, textWidth;
	for i=1, QuestLogEx.db.global.maxQuestsDisplayed, 1 do
		questIndex = i + FauxScrollFrame_GetOffset(QuestLogExListScrollFrame);
		questLogTitle = _G["QuestLogExTitle"..i];
		questTitleTag = _G["QuestLogExTitle"..i.."Tag"];
		questNumGroupMates = _G["QuestLogExTitle"..i.."GroupMates"];
		questCheck = _G["QuestLogExTitle"..i.."Check"];
		questNormalText = _G["QuestLogExTitle"..i.."NormalText"];
		questHighlight = _G["QuestLogExTitle"..i.."Highlight"];
		if ( questIndex <= numEntries ) then
			questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questIndex);
			if ( isHeader ) then
				if ( questLogTitleText ) then
					questLogTitle:SetText(questLogTitleText);
				else
					questLogTitle:SetText("");
				end
				
				if ( isCollapsed ) then
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				else
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
				end
				questHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
				questNumGroupMates:SetText("");
				questCheck:Hide();
			else
				if(QuestLogEx.db.profile.showLevel) then
					local tempQuestTitle = '[' .. level;
					if (questTag) then
						tempQuestTitle = tempQuestTitle .. "+";
					end
					questLogTitleText = tempQuestTitle .. '] ' .. questLogTitleText;
				end

				questLogTitle:SetText("  "..questLogTitleText);
				--Set Dummy text to get text width *SUPER HACK*
				QuestLogDummyText:SetText("  "..questLogTitleText);

				questLogTitle:SetNormalTexture("");
				questHighlight:SetTexture("");

				-- If not a header see if any nearby group mates are on this quest
				partyMembersOnQuest = 0;
				for j=1, GetNumSubgroupMembers() do
					if ( IsUnitOnQuest(questIndex, "party"..j) ) then
						partyMembersOnQuest = partyMembersOnQuest + 1;
					end
				end
				if ( partyMembersOnQuest > 0 ) then
					questNumGroupMates:SetText("["..partyMembersOnQuest.."]");
				else
					questNumGroupMates:SetText("");
				end
			end
			-- Save if its a header or not
			questLogTitle.isHeader = isHeader;

			-- Set the quest tag
			if ( isComplete and isComplete < 0 ) then
				questTag = FAILED;
			elseif ( isComplete and isComplete > 0 ) then
				questTag = COMPLETE;
			end
			if ( questTag ) then
				questTitleTag:SetText("("..questTag..")");
				-- Shrink text to accomdate quest tags without wrapping
				tempWidth = 275 - 15 - questTitleTag:GetWidth();
				
				if ( QuestLogDummyText:GetWidth() > tempWidth ) then
					textWidth = tempWidth;
				else
					textWidth = QuestLogDummyText:GetWidth();
				end
				
				questNormalText:SetWidth(tempWidth);
				
				-- If there's quest tag position check accordingly
				questCheck:Hide();
				if ( IsQuestWatched(questIndex) ) then
					if ( questNormalText:GetWidth() + 24 < 275 ) then
						questCheck:SetPoint("LEFT", questLogTitle, "LEFT", textWidth+24, 0);
					else
						questCheck:SetPoint("LEFT", questLogTitle, "LEFT", textWidth+10, 0);
					end
					questCheck:Show();
				end
			else
				questTitleTag:SetText("");
				-- Reset to max text width
				if ( questNormalText:GetWidth() > 275 ) then
					questNormalText:SetWidth(260);
				end

				-- Show check if quest is being watched
				questCheck:Hide();
				if ( IsQuestWatched(questIndex) ) then
					if ( questNormalText:GetWidth() + 24 < 275 ) then
						questCheck:SetPoint("LEFT", questLogTitle, "LEFT", QuestLogDummyText:GetWidth()+24, 0);
					else
						questCheck:SetPoint("LEFT", questNormalText, "LEFT", questNormalText:GetWidth(), 0);
					end
					questCheck:Show();
				end
			end

			-- Color the quest title and highlight according to the difficulty level
			local playerLevel = UnitLevel("player");
			if ( isHeader ) then
				color = QuestDifficultyColors["header"];
			else
				color = GetQuestDifficultyColor(level);
			end
			questLogTitle:SetNormalFontObject(color.font);
			questTitleTag:SetTextColor(color.r, color.g, color.b);
			questNumGroupMates:SetTextColor(color.r, color.g, color.b);
			questLogTitle.r = color.r;
			questLogTitle.g = color.g;
			questLogTitle.b = color.b;
			questLogTitle:Show();

			-- Place the highlight and lock the highlight state
			if ( QuestLogExFrame.selectedButtonID and GetQuestLogSelection() == questIndex ) then
				QuestLogExSkillHighlight:SetVertexColor(questLogTitle.r, questLogTitle.g, questLogTitle.b);
				QuestLogExHighlightFrame:SetPoint("TOPLEFT", "QuestLogExTitle"..i, "TOPLEFT", 0, 0);
				QuestLogExHighlightFrame:Show();
				questTitleTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				questNumGroupMates:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				questLogTitle:LockHighlight();
			else
				questLogTitle:UnlockHighlight();
			end

		else
			questLogTitle:Hide();
		end
	end

	-- Set the expand/collapse all button texture
	local numHeaders = 0;
	local notExpanded = 0;
	-- Somewhat redundant loop, but cleaner than the alternatives
	for i=1, numEntries, 1 do
		local index = i;
		local questLogTitleText, level, questTag, isHeader, isCollapsed = GetQuestLogTitle(i);
		if ( questLogTitleText and isHeader ) then
			numHeaders = numHeaders + 1;
			if ( isCollapsed ) then
				notExpanded = notExpanded + 1;
			end
		end
	end
	-- If all headers are not expanded then show collapse button, otherwise show the expand button
	if ( notExpanded ~= numHeaders ) then
		QuestLogExCollapseAllButton.collapsed = nil;
		QuestLogExCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	else
		QuestLogExCollapseAllButton.collapsed = 1;
		QuestLogExCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	end

	-- Update Quest Count
	QuestLogExQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
	QuestLogExCountMiddle:SetWidth(QuestLogExQuestCount:GetWidth());

	-- If no selection then set it to the first available quest
	if ( GetQuestLogSelection() == 0 ) then
		QuestLog_SetFirstValidSelection();
	end

	-- Determine whether the selected quest is pushable or not
	if ( numEntries == 0 ) then
		QuestLogExFramePushQuestButton:Disable();
	elseif ( GetQuestLogPushable() and IsInGroup() ) then
		QuestLogExFramePushQuestButton:Enable();
	else
		QuestLogExFramePushQuestButton:Disable();
	end
end

function QuestLogEx:QuestLog_SetSelection(questID)
	local selectedQuest;
	if ( questID == 0 ) then
		QuestLogExDetailScrollFrame:Hide();
		return;
	end

	-- Get xml id
	local id = questID - FauxScrollFrame_GetOffset(QuestLogExListScrollFrame);
	
	SelectQuestLogEntry(questID);
	local titleButton = _G["QuestLogExTitle"..id];
	local titleButtonTag = _G["QuestLogExTitle"..id.."Tag"];
	local questLogTitleText, level, questTag, isHeader, isCollapsed = GetQuestLogTitle(questID);
	if ( isHeader ) then
		if ( isCollapsed ) then
			ExpandQuestHeader(questID);
			return;
		else
			CollapseQuestHeader(questID);
			return;
		end
	else
		-- Set newly selected quest and highlight it
		QuestLogExFrame.selectedButtonID = questID;
		local scrollFrameOffset = FauxScrollFrame_GetOffset(QuestLogExListScrollFrame);
		if ( questID > scrollFrameOffset and questID <= (scrollFrameOffset + QuestLogEx.db.global.maxQuestsDisplayed) and questID <= GetNumQuestLogEntries() ) then
			titleButton:LockHighlight();
			titleButtonTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			QuestLogExSkillHighlight:SetVertexColor(titleButton.r, titleButton.g, titleButton.b);
			QuestLogExHighlightFrame:SetPoint("TOPLEFT", "QuestLogExTitle"..id, "TOPLEFT", 5, 0);
			QuestLogExHighlightFrame:Show();
		end
	end
	if ( GetQuestLogSelection() > GetNumQuestLogEntries() ) then
		return;
	end
	QuestLog_UpdateQuestDetails();
end

function QuestLogEx:QuestLog_UpdateQuestDetails(doNotScroll)
	local questID = GetQuestLogSelection();
	local questTitle = GetQuestLogTitle(questID);
	if ( not questTitle ) then
		questTitle = "";
	end
	if ( IsCurrentQuestFailed() ) then
		questTitle = questTitle.." - ("..FAILED..")";
	end
	QuestLogExQuestTitle:SetText(questTitle);

	local questDescription;
	local questObjectives;
	questDescription, questObjectives = GetQuestLogQuestText();
	QuestLogExObjectivesText:SetText(questObjectives);
	
	local questTimer = GetQuestLogTimeLeft();
	if ( questTimer ) then
		QuestLogExFrame.hasTimer = 1;
		QuestLogExFrame.timePassed = 0;
		QuestLogExTimerText:Show();
		QuestLogExTimerText:SetText(TIME_REMAINING.." "..SecondsToTime(questTimer));
		QuestLogExObjective1:SetPoint("TOPLEFT", "QuestLogExTimerText", "BOTTOMLEFT", 0, -10);
	else
		QuestLogExFrame.hasTimer = nil;
		QuestLogExTimerText:Hide();
		QuestLogExObjective1:SetPoint("TOPLEFT", "QuestLogExObjectivesText", "BOTTOMLEFT", 0, -10);
	end
	
	-- Show Quest Watch if track quest is checked
	local numObjectives = GetNumQuestLeaderBoards();
	
	for i=1, numObjectives, 1 do
		local string = _G["QuestLogExObjective"..i];
		local text;
		local type;
		local finished;
		text, type, finished = GetQuestLogLeaderBoard(i);
		if ( not text or strlen(text) == 0 ) then
			text = type;
		end
		if ( finished ) then
			string:SetTextColor(0.2, 0.2, 0.2);
			text = text.." ("..COMPLETE..")";
		else
			string:SetTextColor(0, 0, 0);
		end
		string:SetText(text);
		string:Show();
		QuestFrame_SetAsLastShown(string);
	end

	for i=numObjectives + 1, MAX_OBJECTIVES, 1 do
		_G["QuestLogExObjective"..i]:Hide();
	end
	-- If there's money required then anchor and display it
	if ( GetQuestLogRequiredMoney() > 0 ) then
		if ( numObjectives > 0 ) then
			QuestLogExRequiredMoneyText:SetPoint("TOPLEFT", "QuestLogExObjective"..numObjectives, "BOTTOMLEFT", 0, -4);
		else
			QuestLogExRequiredMoneyText:SetPoint("TOPLEFT", "QuestLogExObjectivesText", "BOTTOMLEFT", 0, -10);
		end
		
		MoneyFrame_Update("QuestLogExRequiredMoneyFrame", GetQuestLogRequiredMoney());
		
		if ( GetQuestLogRequiredMoney() > GetMoney() ) then
			-- Not enough money
			QuestLogExRequiredMoneyText:SetTextColor(0, 0, 0);
			SetMoneyFrameColor("QuestLogExRequiredMoneyFrame", 1.0, 0.1, 0.1);
		else
			QuestLogExRequiredMoneyText:SetTextColor(0.2, 0.2, 0.2);
			SetMoneyFrameColor("QuestLogExRequiredMoneyFrame", 1.0, 1.0, 1.0);
		end
		QuestLogExRequiredMoneyText:Show();
		QuestLogExRequiredMoneyFrame:Show();
	else
		QuestLogExRequiredMoneyText:Hide();
		QuestLogExRequiredMoneyFrame:Hide();
	end

	if ( GetQuestLogRequiredMoney() > 0 ) then
		QuestLogExDescriptionTitle:SetPoint("TOPLEFT", "QuestLogExRequiredMoneyText", "BOTTOMLEFT", 0, -10);
	elseif ( numObjectives > 0 ) then
		QuestLogExDescriptionTitle:SetPoint("TOPLEFT", "QuestLogExObjective"..numObjectives, "BOTTOMLEFT", 0, -10);
	else
		if ( questTimer ) then
			QuestLogExDescriptionTitle:SetPoint("TOPLEFT", "QuestLogExTimerText", "BOTTOMLEFT", 0, -10);
		else
			QuestLogExDescriptionTitle:SetPoint("TOPLEFT", "QuestLogExObjectivesText", "BOTTOMLEFT", 0, -10);
		end
	end
	if ( questDescription ) then
		QuestLogExQuestDescription:SetText(questDescription);
		QuestFrame_SetAsLastShown(QuestLogExQuestDescription);
	end
	local numRewards = GetNumQuestLogRewards();
	local numChoices = GetNumQuestLogChoices();
	local money = GetQuestLogRewardMoney();

	if ( (numRewards + numChoices + money) > 0 ) then
		QuestLogExRewardTitleText:Show();
		QuestFrame_SetAsLastShown(QuestLogExRewardTitleText);
	else
		QuestLogExRewardTitleText:Hide();
	end

	QuestFrameItems_Update("QuestLogEx");
	if ( not doNotScroll ) then
		QuestLogExDetailScrollFrameScrollBar:SetValue(0);
	end
	QuestLogExDetailScrollFrame:UpdateScrollChildRect();
end

--Used to attach an empty spacer frame to the last shown object
function QuestLogEx:QuestFrame_SetAsLastShown(frame, spacerFrame)
	if ( not spacerFrame ) then
		spacerFrame = QuestLogExSpacerFrame;
	end
	spacerFrame:SetPoint("TOP", frame, "BOTTOM", 0, 0);
end

function QuestLogEx:QuestLogTitleButton_OnClick(self, button)
	local questName = self:GetText();
	local questIndex = self:GetID() + FauxScrollFrame_GetOffset(QuestLogExListScrollFrame);
	if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
		-- If header then return
		if ( self.isHeader ) then
			return;
		end
		-- Otherwise trim leading whitespace and put it into chat
		ChatEdit_InsertLink(gsub(self:GetText(), " *(.*)", "%1"));
	elseif ( IsShiftKeyDown() ) then
		-- If header then return
		if ( self.isHeader ) then
			return;
		end

		-- Shift-click toggles quest-watch on this quest.
		if ( IsQuestWatched(questIndex) ) then
			local questID = GetQuestIDFromLogIndex(questIndex);
			for index, value in ipairs(QUEST_WATCH_LIST) do
				if ( value.id == questID ) then
					tremove(QUEST_WATCH_LIST, index);
				end
			end
			RemoveQuestWatch(questIndex);
			QuestWatch_Update();
		else
			-- Set error if no objectives
			if ( GetNumQuestLeaderBoards(questIndex) == 0 ) then
				UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0);
				return;
			end
			-- Set an error message if trying to show too many quests
			if ( GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then
				UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0);
				return;
			end
			AutoQuestWatch_Insert(questIndex, QUEST_WATCH_NO_EXPIRE);
			QuestWatch_Update();
		end
	else
		if not QuestLogEx.extended then
			QuestLogEx:Maximize()
		end
	end

	QuestLog_SetSelection(questIndex)
	QuestLog_Update();
end

function QuestLogEx:QuestLog_UpdatePartyInfoTooltip(self)
	local index = self:GetID() + FauxScrollFrame_GetOffset(QuestLogExListScrollFrame);
	local numPartyMembers = GetNumSubgroupMembers();
	if ( numPartyMembers == 0 or self.isHeader ) then
		return;
	end
	GameTooltip_SetDefaultAnchor(GameTooltip, self);
	
	local questLogTitleText = GetQuestLogTitle(index);
	GameTooltip:SetText(questLogTitleText);

	local partyMemberOnQuest;
	for i=1, numPartyMembers do
		if ( IsUnitOnQuest(index, "party"..i) ) then
			if ( not partyMemberOnQuest ) then
				GameTooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..PARTY_QUEST_STATUS_ON..FONT_COLOR_CODE_CLOSE);
				partyMemberOnQuest = 1;
			end
			GameTooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE..UnitName("party"..i)..FONT_COLOR_CODE_CLOSE);
		end
	end
	if ( not partyMemberOnQuest ) then
		GameTooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..PARTY_QUEST_STATUS_NONE..FONT_COLOR_CODE_CLOSE);
	end
	GameTooltip:Show();
end

function QuestLogEx:QuestLogCollapseAllButton_OnClick(self)
	if (self.collapsed) then
		self.collapsed = nil;
		ExpandQuestHeader(0);
	else
		self.collapsed = 1;
		QuestLogExListScrollFrameScrollBar:SetValue(0);
		CollapseQuestHeader(0);
	end
end

function QuestLogEx:QuestFrameItems_Update(questState)
	local isQuestLog = 0;
	if ( questState == "QuestLog" or questState == "QuestLogEx" ) then
		isQuestLog = 1;
	end
	local numQuestRewards;
	local numQuestChoices;
	local numQuestSpellRewards = 0;
	local money;
	local spacerFrame;
	if ( isQuestLog == 1 ) then
		numQuestRewards = GetNumQuestLogRewards();
		numQuestChoices = GetNumQuestLogChoices();
		numQuestSpellRewards = GetNumQuestLogRewardSpells();
		money = GetQuestLogRewardMoney();
		spacerFrame = QuestLogExSpacerFrame;
	else
		numQuestRewards = GetNumQuestRewards();
		numQuestChoices = GetNumQuestChoices();
		numQuestSpellRewards = GetNumRewardSpells();
		money = GetRewardMoney();
		spacerFrame = QuestSpacerFrame;
	end

	local totalRewards = numQuestRewards + numQuestChoices + numQuestSpellRewards;
	local questItemName = questState.."Item";
	local material = QuestFrame_GetMaterial();
	local questItemReceiveText = _G[questState.."ItemReceiveText"];
	if ( totalRewards == 0 and money == 0 ) then
		_G[questState.."RewardTitleText"]:Hide();
	else
		_G[questState.."RewardTitleText"]:Show();
		QuestFrame_SetTitleTextColor(_G[questState.."RewardTitleText"], material);
		QuestFrame_SetAsLastShown(_G[questState.."RewardTitleText"], spacerFrame);
	end
	if ( money == 0 ) then
		_G[questState.."MoneyFrame"]:Hide();
	else
		_G[questState.."MoneyFrame"]:Show();
		QuestFrame_SetAsLastShown(_G[questState.."MoneyFrame"], spacerFrame);
		MoneyFrame_Update(questState.."MoneyFrame", money);
	end
	
	-- Hide unused rewards
	for i=totalRewards + 1, MAX_NUM_ITEMS, 1 do
		_G[questItemName..i]:Hide();
	end

	local questItem, name, texture, isTradeskillSpell, quality, isUsable, numItems = 1;
	local rewardsCount = 0;
	
	-- Setup choosable rewards
	if ( numQuestChoices > 0 ) then
		local itemChooseText = _G[questState.."ItemChooseText"];
		itemChooseText:Show();
		QuestFrame_SetTextColor(itemChooseText, material);
		QuestFrame_SetAsLastShown(itemChooseText, spacerFrame);
		
		local index;
		local baseIndex = rewardsCount;
		for i=1, numQuestChoices, 1 do	
			index = i + baseIndex;
			questItem = _G[questItemName..index];
			questItem.type = "choice";
			numItems = 1;
			if ( isQuestLog == 1 ) then
				name, texture, numItems, quality, isUsable = GetQuestLogChoiceInfo(i);
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i);
			end
			questItem:SetID(i)
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "item"
			QuestFrame_SetAsLastShown(questItem, spacerFrame);
			_G[questItemName..index.."Name"]:SetText(name);
			SetItemButtonCount(questItem, numItems);
			SetItemButtonTexture(questItem, texture);
			if ( isUsable ) then
				SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			else
				SetItemButtonTextureVertexColor(questItem, 0.9, 0, 0);
				SetItemButtonNameFrameVertexColor(questItem, 0.9, 0, 0);
			end
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..(index - 2), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..(index - 1), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", itemChooseText, "BOTTOMLEFT", -3, -5);
			end
			rewardsCount = rewardsCount + 1;
		end
	else
		_G[questState.."ItemChooseText"]:Hide();
	end
	
	-- Setup spell rewards
	if ( numQuestSpellRewards > 0 ) then
		local learnSpellText = _G[questState.."SpellLearnText"];
		learnSpellText:Show();
		QuestFrame_SetTextColor(learnSpellText, material);
		QuestFrame_SetAsLastShown(learnSpellText, spacerFrame);

		--Anchor learnSpellText if there were choosable rewards
		if ( rewardsCount > 0 ) then
			learnSpellText:SetPoint("TOPLEFT", questItemName..rewardsCount, "BOTTOMLEFT", 3, -5);
		else
			learnSpellText:SetPoint("TOPLEFT", questState.."RewardTitleText", "BOTTOMLEFT", 0, -5);
		end

		-- In Classic, there's only ever one spell reward per quest,
		-- so we can just hardcode index 1.
		if ( isQuestLog == 1 ) then
			texture, name, isTradeskillSpell = GetQuestLogRewardSpell(1);
		else
			texture, name, isTradeskillSpell = GetRewardSpell(1);
		end
		
		if ( isTradeskillSpell ) then
			learnSpellText:SetText(REWARD_TRADESKILL_SPELL);
		else
			learnSpellText:SetText(REWARD_SPELL);
		end
		
		rewardsCount = rewardsCount + 1;
		questItem = _G[questItemName..rewardsCount];
		questItem:SetID(1);
		questItem:Show();
		-- For the tooltip
		questItem.rewardType = "spell";
		SetItemButtonCount(questItem, 0);
		SetItemButtonTexture(questItem, texture);
		_G[questItemName..rewardsCount.."Name"]:SetText(name);
		questItem:SetPoint("TOPLEFT", learnSpellText, "BOTTOMLEFT", -3, -5);
	else
		--_G[questState.."SpellLearnText"]:Hide();
	end
	
	-- Setup mandatory rewards
	if ( numQuestRewards > 0 or money > 0) then
		QuestFrame_SetTextColor(questItemReceiveText, material);
		-- Anchor the reward text differently if there are choosable rewards
		if ( numQuestSpellRewards > 0  ) then
			questItemReceiveText:SetText(REWARD_ITEMS);
			questItemReceiveText:SetPoint("TOPLEFT", questItemName..rewardsCount, "BOTTOMLEFT", 3, -5);		
		elseif ( numQuestChoices > 0  ) then
			questItemReceiveText:SetText(REWARD_ITEMS);
			local index = numQuestChoices;
			if ( mod(index, 2) == 0 ) then
				index = index - 1;
			end
			questItemReceiveText:SetPoint("TOPLEFT", questItemName..index, "BOTTOMLEFT", 3, -5);
		else 
			questItemReceiveText:SetText(REWARD_ITEMS_ONLY);
			questItemReceiveText:SetPoint("TOPLEFT", questState.."RewardTitleText", "BOTTOMLEFT", 3, -5);
		end
		questItemReceiveText:Show();
		QuestFrame_SetAsLastShown(questItemReceiveText, spacerFrame);
		-- Setup mandatory rewards
		local index;
		local baseIndex = rewardsCount;
		for i=1, numQuestRewards, 1 do
			index = i + baseIndex;
			questItem = _G[questItemName..index];
			questItem.type = "reward";
			numItems = 1;
			if ( isQuestLog == 1 ) then
				name, texture, numItems, quality, isUsable = GetQuestLogRewardInfo(i);
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i);
			end
			questItem:SetID(i)
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "item";
			QuestFrame_SetAsLastShown(questItem, spacerFrame);
			_G[questItemName..index.."Name"]:SetText(name);
			SetItemButtonCount(questItem, numItems);
			SetItemButtonTexture(questItem, texture);
			if ( isUsable ) then
				SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			else
				SetItemButtonTextureVertexColor(questItem, 0.5, 0, 0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 0, 0);
			end
			
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..(index - 2), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..(index - 1), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", questState.."ItemReceiveText", "BOTTOMLEFT", -3, -5);
			end
			rewardsCount = rewardsCount + 1;
		end
	else	
		questItemReceiveText:Hide();
	end
	if ( questState == "QuestReward" ) then
		QuestFrameCompleteQuestButton:Enable();
		QuestFrameRewardPanel.itemChoice = 0;
		QuestRewardItemHighlight:Hide();
	end
end