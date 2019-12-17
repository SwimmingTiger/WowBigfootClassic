local mod	= DBM:NewMod("z30", "DBM-PvP")

local pairs, ipairs, type, tonumber, select, math = pairs, ipairs, type, tonumber, select, math

mod:SetRevision("20191212133243")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:AddBoolOption("AutoTurnIn")

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false

	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 30 or DBM:GetCurrentArea() == 2197 then
			bgzone = true
			self:RegisterShortTermEvents(
				"GOSSIP_SHOW",
				"QUEST_PROGRESS",
				"QUEST_COMPLETE"
			)
			--[[
            DBM:GetModByName("PvPGeneral"):SubscribeAssault(
                91,
                -- TODO: Get default ID's
                {},
                {0.01, 10 / 12, 10 / 9, 10 / 6, 10 / 3, 30}
            )
            ]]--
		elseif bgzone then
			bgzone = false
			self:UnregisterShortTermEvents()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end

local quests = {
	[13442] = {
		{7386, 17423, 5},
		{6881, 17423},
	},
	[13236] = {
		{7385, 17306, 5},
		{6801, 17306},
	},
	[13257] = {6781, 17422, 20},
	[13176] = {6741, 17422, 20},
	[13577] = {7026, 17643},
	[13179] = {6825, 17326},
	[13438] = {6942, 17502},
	[13180] = {6826, 17327},
	[13181] = {6827, 17328},
	[13439] = {6941, 17503},
	[13437] = {6943, 17504},
	[13441] = {7002, 17642},
}

do
	if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
		local tooltip = CreateFrame("GameTooltip", "DBM-PvP_Tooltip")
		tooltip:SetOwner(UIParent, "ANCHOR_NONE")
		tooltip:AddFontStrings(tooltip:CreateFontString("$parentText", nil, "GameTooltipText"), tooltip:CreateFontString("$parentTextRight", nil, "GameTooltipText"))

		local function getQuestName(id)
			tooltip:ClearLines()
			tooltip:SetHyperlink("quest:"..id)--Quest tooltip type doesn't exist until Wrath
			return _G[tooltip:GetName().."Text"]:GetText()
		end

		for _, v in pairs(quests) do
			if type(v[1]) == "table" then
				for _, v in ipairs(v) do
					v[1] = getQuestName(v[1]) or v[1]
				end
			else
				v[1] = getQuestName(v[1]) or v[1]
			end
		end
	end
end

do
	local UnitGUID, GetTitleText, CompleteQuest, GetQuestReward, GetGossipAvailableQuests, SelectGossipAvailableQuest, GetContainerNumSlots, GetContainerItemLink, GetContainerItemInfo, NUM_BAG_SLOTS = UnitGUID, GetTitleText, CompleteQuest, GetQuestReward, GetGossipAvailableQuests, SelectGossipAvailableQuest, GetContainerNumSlots, GetContainerItemLink, GetContainerItemInfo, NUM_BAG_SLOTS

	local function isQuestAutoTurnInQuest(name)
		for _, v in pairs(quests) do
			if type(v[1]) == "table" then
				for _, v in ipairs(v) do
					if v[1] == name then
						return true
					end
				end
			elseif v[1] == name then
				return true
			end
		end
	end

	local function acceptQuestByName(name)
		for i = 1, select("#", GetGossipAvailableQuests()), 5 do
			if select(i, GetGossipAvailableQuests()) == name then
				SelectGossipAvailableQuest(math.ceil(i / 5))
				break
			end
		end
	end

	local function checkItems(item, amount)
		local found = 0
		for bag = 0, NUM_BAG_SLOTS do
			for i = 1, GetContainerNumSlots(bag) do
				if tonumber((GetContainerItemLink(bag, i) or ""):match(":(%d+):") or 0) == item then
					found = found + select(2, GetContainerItemInfo(bag, i))
				end
			end
		end
		return found >= amount
	end

	function mod:GOSSIP_SHOW()
		if not self.Options.AutoTurnIn then
			return
		end
		local quest = quests[self:GetCIDFromGUID(UnitGUID("target") or "") or 0]
		if quest and type(quest[1]) == "table" then
			for _, v in ipairs(quest) do
				if checkItems(v[2], v[3] or 1) then
					acceptQuestByName(v[1])
					break
				end
			end
		elseif quest then
			if checkItems(quest[2], quest[3] or 1) then
				acceptQuestByName(quest[1])
			end
		end
	end

	function mod:QUEST_PROGRESS()
		if isQuestAutoTurnInQuest(GetTitleText()) then
			CompleteQuest()
		end
	end

	function mod:QUEST_COMPLETE()
		if isQuestAutoTurnInQuest(GetTitleText()) then
			GetQuestReward(0)
		end
	end
end
