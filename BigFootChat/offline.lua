
if GetLocale() == "zhCN" then
	-- TIP_TEXT = "<Shift+左键点击按钮分享攻略>"
	BUTTON_TEXT="大脚攻略"
	TITLE_TEXT="大脚离线攻略"
	BF_SENT_TEXT="发送攻略"
elseif GetLocale() == "zhTW" then
	-- TIP_TEXT = "<Shift+左鍵點擊按鈕分享攻略>"
	BUTTON_TEXT="大腳攻略"
	TITLE_TEXT="大腳離線攻略"
	BF_SENT_TEXT="發送攻略"
end

local offlineRaidersFrame = CreateFrame("Frame")
offlineRaidersFrame:RegisterEvent("ADDON_LOADED")
offlineRaidersFrame:SetScript("OnEvent",function(self,event,args)
	-- print(args,event)
	if args == "Blizzard_EncounterJournal" then
		offlineRaidersFrame_OnLoade()
		offlineRaidersFrame:UnregisterEvent("ADDON_LOADED")
	end
end)

local buttonName = nil
function GetButtonName()
	buttonName = GetMouseFocus():GetName()
	print(buttonName)
end

function tryApi()
	EncounterJournal_ToggleHeaders(buttonName,true)
end

function BigfootChat_CreateEJSectionButton()
	infoHeader = CreateFrame("FRAME", "EncounterJournalInfoHeaderBF",EncounterJournal, "EncounterInfoTemplate");
	-- infoHeader.button.portrait:Hide()
	infoHeader:SetPoint("TOP",EncounterJournal,"TOP",100,-100)
end

function offlineRaidersFrame_OnLoade()
	-- ShowButton = CreateFrame("Button",EncounterJournal)
	-- normaltexture = ShowButton:CreateTexture("buttonNormaltexture","overlay","UI-EJ-ReturnToDefault")
	OfflineRaiders:SetFrameLevel(13)
	OfflineRaiders:SetParent("EncounterJournal")
	OfflineRaiders:SetPoint("TOPRIGHT","EncounterJournalEncounterFrameInfoResetButton","TOPLEFT")
	OfflineRaiders:SetText(BUTTON_TEXT)
	RaidersCloseButton:SetParent(RaidersShowFrame)
	RaidersCloseButton:SetPoint("TOPRIGHT",RaidersShowFrame,"TOPRIGHT",2,25)
	RaidersShowFrame:SetParent("EncounterJournal")
	RaidersShowFrame:SetFrameLevel(EncounterJournal:GetFrameLevel()-1)
	RaidersShowFrame.title = RaidersShowFrame:CreateTexture("RaidersFrameTitle", "BACKGROUND")
	RaidersShowFrame.title:SetPoint("BOTTOM",RaidersShowFrame,"TOP",3,-5);
	RaidersShowFrame.title:SetSize(250,30)
	RaidersShowFrame.title:SetTexture("Interface\\AddOns\\BigFootChat\\icon\\autotabard_main");
	RaidersShowFrame.title:SetTexCoord(0, 0.8359375, 0, 0.05);
	RaidersShowFrame.titleText = RaidersShowFrame:CreateFontString("RaidersTitleText","Overlay","GameFontNormal")
	RaidersShowFrame.titleText:SetSize(200,30)
	RaidersShowFrame.close = CreateFrame("BUTTON")
	RaidersShowFrame.titleText:SetPoint("TOP",RaidersShowFrame.title,"TOP")
	RaidersShowFrame.titleText:SetText(TITLE_TEXT)
	RaidersShowFrame.text = RaidersShowFrame:CreateFontString("RaidersText","Overlay","QuestFont_Large")
	RaidersShowFrame.text:SetSize(200,150)
	RaidersShowFrame.text:SetPoint("TOP",5,-16)
	RaidersShowFrame.text:SetTextColor(0.25,0.1484375,0.2)
	RaidersShowFrame.text:SetJustifyH("LEFT")
	RaidersShowFrame.text:SetJustifyV("TOP")
	-- RaidersShowFrame.textTip = RaidersShowFrame:CreateFontString("RaidersTextTip","Overlay","GameFontBlack")
	-- RaidersShowFrame.textTip:SetSize(230,20)
	-- RaidersShowFrame.textTip:SetPoint("BOTTOM","RaidersShowFrame","BOTTOM",0,10)
	-- RaidersShowFrame.textTip:SetText(TIP_TEXT)
	-- RaidersShowFrame.textTip:SetTextColor(0.961,0.824,0.412)
	-- RaidersShowFrame.textTip:SetJustifyH("CENTER")
	hooksecurefunc("EncounterJournal_LootUpdate",function ()
		ButtonUpdate()
	end)
	EncounterJournalNavBarHomeButton:HookScript("OnClick",function ()
		if OfflineRaiders:IsShown() then
			OfflineRaiders:Hide()
		end
		if RaidersShowFrame:IsShown() then
			RaidersShowFrame:Hide()
		end
	end)
end

function GetCurrentBossRaiders()
	if EncounterJournal.encounterID then
		encounterName = EJ_GetEncounterInfo(EncounterJournal.encounterID)
		RaidersShowFrame.text:SetText(getRaidersByEncounterName(encounterName))
	else
		RaidersShowFrame.text:SetText("")
	end

end

function getRaidersByEncounterName(name)
	for i,k in pairs(Raid_List) do
		for i,v in pairs(k) do
			if v.name == name then
				return v.raiders
			end
		end
	end
end

function toggleRaidersFrame(button)
	if not RaidersShowFrame:IsShown() then
		GetCurrentBossRaiders()
		RaidersShowFrame:Show()
	else
		RaidersShowFrame:Hide()
	end
end

function toggleOfflineRaidersSent()
	if EncounterJournal.encounterID then
		local encounterName = EJ_GetEncounterInfo(EncounterJournal.encounterID)
		local raidersText = getRaidersByEncounterName(encounterName)
		if raidersText and encounterName then
			encounterName = BFRAIDER_AD .. encounterName
			if IsInRaid() then
				SendChatMessage(encounterName, (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "raid");
				SendChatMessage(raidersText, (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "raid");
			elseif IsInGroup() then
				SendChatMessage(encounterName, (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "party");
				SendChatMessage(raidersText, (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "party");
			else
				SendChatMessage(encounterName, "say");
				SendChatMessage(raidersText, "say");
			end
		end
	end
end

local function haveRaiders()
	local raiders = getRaidersByEncounterName(EJ_GetEncounterInfo(EncounterJournal.encounterID))
	if raiders then
		return true
	end
end

function ButtonUpdate()
	BigFoot_DelayCall(function ()
			if EncounterJournalNavBarButton3 and EncounterJournalNavBarButton3:IsShown() and haveRaiders() and BigFootChat.db.profile.enableRaidersButton then
				OfflineRaiders:Show()
				RaidersShowFrame:Show()
			else
				OfflineRaiders:Hide()
				RaidersShowFrame:Hide()
			end
			GetCurrentBossRaiders()
		end,0.1)
end
