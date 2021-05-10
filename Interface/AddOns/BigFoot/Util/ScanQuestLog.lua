
local _
local match, tonumber, wipe, floor = strmatch, tonumber, wipe, math.floor;
local GetNumQuestLogEntries = GetNumQuestLogEntries

local quests = {}
local mosters = {}
local qobs = {}
local qobs_title = {}
local qobs_have = {}
local qobs_need = {}

local items = {}
local items_have = {}
local items_need = {}
local items_title = {}

local headers = {}

local qobs_perc = setmetatable({}, {__index = function(t, i)
	local perc = qobs_have[i] / qobs_need[i]
	t[i] = perc
	return perc
end})

local objects_pattern = "^"..QUEST_OBJECTS_FOUND:gsub("(%%.)", "(.+)").."$" --QUEST_OBJECTS_FOUND = "%s: %d/%d"
local faction_pattern = "^"..QUEST_FACTION_NEEDED:gsub("(%%.)", "(.+)").."$" --QUEST_FACTION_NEEDED = "%s: %s / %s"
local players_pattern = "^"..QUEST_PLAYERS_KILLED:gsub("(%%.)", "(.+)").."$" --QUEST_PLAYERS_KILLED = "Players slain: %d/%d"
local monsters_pattern = "^"..QUEST_MONSTERS_KILLED:gsub("(%%.)", "(.+)").."$" --QUEST_MONSTERS_KILLED = "%s slain: %d/%d"

local factions = {
	[FACTION_STANDING_LABEL1] = 1, --"Hated"
	[FACTION_STANDING_LABEL1_FEMALE] = 1, --"Hated"
	[FACTION_STANDING_LABEL2] = 2, --"Hostile"
	[FACTION_STANDING_LABEL2_FEMALE] = 2, --"Hostile"
	[FACTION_STANDING_LABEL3] = 3, --"Unfriendly"
	[FACTION_STANDING_LABEL3_FEMALE] = 3, --"Unfriendly"
	[FACTION_STANDING_LABEL4] = 4, --"Neutral"
	[FACTION_STANDING_LABEL4_FEMALE] = 4, --"Neutral"
	[FACTION_STANDING_LABEL5] = 5, --"Friendly"
	[FACTION_STANDING_LABEL5_FEMALE] = 5, --"Friendly"
	[FACTION_STANDING_LABEL6] = 6, --"Honored"
	[FACTION_STANDING_LABEL6_FEMALE] = 6, --"Honored"
	[FACTION_STANDING_LABEL7] = 7, --"Revered"
	[FACTION_STANDING_LABEL7_FEMALE] = 7, --"Revered"
	[FACTION_STANDING_LABEL8] = 8, --"Exalted"
	[FACTION_STANDING_LABEL8_FEMALE] = 8 --"Exalted"
}

local function OnQuestLogUpdate()
	wipe(quests)
	wipe(qobs); wipe(qobs_title); wipe(qobs_have); wipe(qobs_need); wipe(qobs_perc)
	wipe(items); wipe(items_title); wipe(items_have); wipe(items_need); wipe(mosters)
	local itemsize = 0
	local qobsize = 0
	local name, have, need;
	for questid = 1, GetNumQuestLogEntries() do
		local qtitle, _, _, header, _, iscomp = GetQuestLogTitle(questid)
		if not header then
			quests[qtitle] = true;
			for questobnum = 1, GetNumQuestLeaderBoards(questid) do

				local desc, qtype = GetQuestLogLeaderBoard(questobnum, questid);	--qtype:event,item ,monster ,object ,reputation   2012/11/8

				qobsize = qobsize + 1;

				if qtype == "monster" then
					name, have, need = match(desc, monsters_pattern);
					if not have or not need then
						name, have, need = match(desc, objects_pattern);
					end
					have, need = tonumber(have), tonumber(need);
					mosters[name] = qobsize;
				elseif qtype == "item" or qtype == "object" then
					name, have, need = match(desc, objects_pattern)
					itemsize = itemsize + 1
					if items[name] then
						items[name] = items[name]*1000 + itemsize
					else
						items[name] = itemsize
					end
					have, need = tonumber(have), tonumber(need)
					items_have[itemsize] = have
					items_need[itemsize] = need
					items_title[itemsize] = qtitle
				elseif qtype == "reputation" then
					name, have, need = match(desc, faction_pattern)
					if have and need then
						qobs_perc[qobsize] = factions[have] / factions[need]
					end
				elseif qtype == "player" then
					name, have, need = match(desc, players_pattern)
					have, need = tonumber(have), tonumber(need)
					if name then
						mosters[name] = qobsize;
					end
				else
					have, need = iscomp and 1 or 0, 1
				end

				if desc then desc = " - "..desc
					if qobs[desc] then
						qobs[desc] = qobs[desc]*1000 + qobsize
					else
						qobs[desc] = qobsize
					end
					qobs_have[qobsize] = have	-- 已有
					qobs_need[qobsize] = need	-- 需要
					qobs_title[qobsize] = qtitle		-- 任务名
				end
			end
		end
	end
end

local function recordHeaderStatus()
	for i =1, GetNumQuestLogEntries() do
		local questName, _, _, isHeader,isCollapsed = GetQuestLogTitle(i)
		if isHeader then
			if isCollapsed then
				headers[questName] = "collapsed"
			else
				headers[questName] = "expanded"
			end
		end
	end
end

local function getNextHeaderIndex(status)
	for i = 1, GetNumQuestLogEntries() do
		local questName, _, _, isHeader, isCollapsed = GetQuestLogTitle(i)
		if (status == "expanded") then
			if isHeader and not isCollapsed and headers[questName] =='collapsed' then
				return i,questName
			end
		elseif (status == "collapsed") then
			if isHeader and isCollapsed then
				return i,questName
			end
		end
	end
	return -1
end

--------------------------展开所有任务日志,进行扫描,然后关闭
local f = CreateFrame("Frame")

f:RegisterEvent("VARIABLES_LOADED")

function f.OnQuestLogInited()

	--record all header status here
	recordHeaderStatus()

	f.ExpandHeader()
end

function f.ExpandHeader()
	local headerIndex,headerName
	repeat
		headerIndex,headerName= getNextHeaderIndex("collapsed")
		if headerIndex and headerName then
			ExpandQuestHeader(headerIndex)
		end
	until(headerIndex < 0)
	f.ScanQuestLog()
end

function f.RecoverHeader()

	local headerIndex,headerName = 1
	repeat
		headerIndex,headerName= getNextHeaderIndex("expanded")
		if headerName and headerIndex then
			CollapseQuestHeader(headerIndex)
		end
	until(headerIndex < 0)
end

function f.ScanQuestLog()
	--scaning here
	-- OnQuestLogUpdate()		-- 6.0 ptr
	--collapse here
	f.RecoverHeader()
end

f:SetScript("OnEvent",function(self,event,...)
	if event == "VARIABLES_LOADED" then
		BigFoot_DelayCall(function()
			f:RegisterEvent("UNIT_QUEST_LOG_CHANGED");
			f.OnQuestLogInited();
		end, 5);
	elseif event=="UNIT_QUEST_LOG_CHANGED" then
		local player = ...
		if player~= 'player' then return end
		f.OnQuestLogInited()
	end
end)

--BFTooltip 调用
function GetTooltipQuestTable()
	return quests
end

--BFTooltip 调用
function GetTooltipQuestData()
	local name = UnitName("mouseover");
	if (mosters[name]) then
		local qID = mosters[name];
		local title = qobs_title[qID];
		local have = qobs_have[qID];
		local need = qobs_need[qID];
		return title,name,have,need
	end
end
