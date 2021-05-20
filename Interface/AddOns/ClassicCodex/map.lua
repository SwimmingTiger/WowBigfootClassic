local L = LibStub("AceLocale-3.0"):GetLocale("ClassicCodex")

CodexMap = CreateFrame("Frame")
CodexMap.HBDP = LibStub("HereBeDragons-Pins-2.0")
CodexMap.HBD = LibStub("HereBeDragons-2.0")
local rgbcache = setmetatable({},{__mode="kv"})
CodexMap.nodes = {}
CodexMap.tooltips = {}
CodexMap.markers = {}
CodexMap.minimapMarkers = {}

CodexMap.objectiveList = {}
CodexMap.colorListIndex = 1

CodexMap.zones = {
    [1] = 1426, --Dun Morogh
	[3] = 1418, --Badlands
	[4] = 1419, --Blasted Lands
	[8] = 1435, --Swamp of Sorrows
	[10] = 1431, --Duskwood
	[11] = 1437, --Wetlands
	[12] = 1429, --Elwynn Forest
	[14] = 1411, --Durotar
	[15] = 1445, --Dustwallow Marsh
	[16] = 1447, --Azshara
	[17] = 1413, --The Barrens
	[28] = 1422, --Western Plaguelands
	[33] = 1434, --Stranglethorn Vale
	[36] = 1416, --Alterac Mountains
	[38] = 1432, --Loch Modan
	[40] = 1436, --Westfall
	[41] = 1430, --Deadwind Pass
	[44] = 1433, --Redridge Mountains
	[45] = 1417, --Arathi Highlands
	[46] = 1428, --Burning Steppes
	[47] = 1425, --The Hinterlands
	[51] = 1427, --Searing Gorge
	[69] = 1433, --Lakeshire
	[85] = 1420, --Tirisfal Glades
	[130] = 1421, --Silverpine Forest
	[139] = 1423, --Eastern Plaguelands
	[141] = 1438, --Teldrassil
	[148] = 1439, --Darkshore
	[215] = 1412, --Mulgore
	[267] = 1424, --Hillsbrad Foothills
	[331] = 1440, --Ashenvale
	[357] = 1444, --Feralas
	[361] = 1448, --Felwood
	[400] = 1441, --Thousand Needles
	[405] = 1443, --Desolace
	[406] = 1442, --Stonetalon Mountains
	[440] = 1446, --Tanaris
	[490] = 1449, --Un'Goro Crater
	[493] = 1450, --Moonglade
	[618] = 1452, --Winterspring
	[1377] = 1451, --Silithus
	[1497] = 1458, --Undercity
	[1519] = 1453, --Stormwind City
	[1537] = 1455, --Ironforge
	[1637] = 1454, --Orgrimmar
	[1638] = 1456, --Thunder Bluff
	[1657] = 1457, --Darnassus
	[2597] = 1459, --Alterac Valley
	[3277] = 1460, --Warsong Gulch
	[3358] = 1461, --Arathi Basin
}

function str2rgb(text)
	if not text then return 1, 1, 1 end
	if CodexColors[text] then return unpack(CodexColors[text]) end
	if rgbcache[text] then return unpack(rgbcache[text]) end
	local counter = 1
	local l = string.len(text)
	for i = 1, l, 3 do
		counter = counter*8161 % 4294967279 + (string.byte(text, i) * 16776193) + ((string.byte(text, i + 1) or (l - i + 256)) * 8372226) + ((string.byte(text, i + 2) or (l - i + 256)) * 3932164)
	end
	local hash = (counter % 4294967291) % 16777216
	local r = (hash - hash % 65536) / 65536
	local g = ((hash - r * 65536) - ((hash - r * 65536) % 256)) / 256
	local b = hash - r * 65536 - g * 256
	rgbcache[text] = {r / 255, g / 255, b / 255}

	return unpack(rgbcache[text])
end

function showTooltip()
	if not CodexConfig.showUnitTooltip then return end
	local name = UnitName("mouseover")

	if name and not UnitIsPlayer("mouseover") and CodexMap.tooltips[name] then
		for title, meta in pairs(CodexMap.tooltips[name]) do
			CodexMap:ShowTooltip(meta, GameTooltip)
			GameTooltip:Show()
		end
	end
end
CodexMap.tooltip = CreateFrame("Frame", "CodexMapTooltip", GameTooltip)
CodexMap.tooltip:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
CodexMap.tooltip:SetScript("OnEvent", function(self, event, ...)
	if event == "UPDATE_MOUSEOVER_UNIT" then
		showTooltip()
	end
end)

local layers = {
	["Interface\\Addons\\ClassicCodex\\img\\available.tga"] = 1,
	["Interface\\Addons\\ClassicCodex\\img\\available_c.tga"] = 2,
	["Interface\\Addons\\ClassicCodex\\img\\complete.tga"] = 3,
	["Interface\\Addons\\ClassicCodex\\img\\complete_c.tga"] = 4,
	["Interface\\Addons\\ClassicCodex\\img\\icon_vendor.tga"] = 5,
}

local function GetLayerByTexture(texture)
	if layers[texture] then return layers[texture] else return 1 end
end

local function isEmpty(tabl)
	for key, value in pairs(tabl) do
		return false
	end
	return true
end

function CodexMap:GetTooltipColor(min, max)
	local perc = min / max
	local r1, g1, b1, r2, g2, b2
	if perc <= 0.5 then
		perc = perc * 2
		r1, g1, b1 = 1, 0, 0
		r2, g2, b2 = 1, 1, 0
	else
		perc = perc * 2 - 1
		r1, g1, b1 = 1, 1, 0
		r2, g2, b2 = 0, 1, 0
	end
	r = r1 + (r2 - r1) * perc
	g = g1 + (g2 - g1) * perc
	b = b1 + (b2 - b1) * perc
	
	return r, g, b
end

function CodexMap:GetMapNameById(id)
	id = tonumber(id)
	return CodexDB["zones"]["loc"][id] or nil
end

function CodexMap:ShowMapId(map)
	if map then
		if not UISpecialFrames["WorldMapFrame"] then
			table.insert(UISpecialFrames, "WorldMapFrame")
		end

		CodexMap:UpdateNodes()
		WorldMapFrame:Show()
		for worldMapId, mapId in pairs(CodexMap.zones) do
			if worldMapId == map then
				WorldMapFrame:SetMapID(mapId)
				-- The previous CodexMap:UpdateNodes() call has rendered all the required markers, so there is no need to redraw
				--CodexMap:UpdateNodes()
				return true
			end
		end
	end

	return nil
end

function CodexMap:HexDifficultyColor(level, force)
	if force and UnitLevel("player") < level then
		return "|cffff5555"
	else
		local c = GetQuestDifficultyColor(level)
		return string.format("|cff%02x%02x%02x", c.r * 255, c.g * 255, c.b * 255)
	end
end

function CodexMap:ShowTooltip(meta, tooltip)
	local catch = nil
	local tooltip = tooltip or GameTooltip
	local quests = CodexDB.quests.loc

	-- Add quest data
	if meta["quest"] then
		-- scan all quest entries for matches
		for questIndex = 1, GetNumQuestLogEntries() do
			local _, _, _, header, _, complete, _, questId = GetQuestLogTitle(questIndex)

			if not header and quests[questId] and meta["quest"] == quests[questId].T then
				local objectives = GetNumQuestLeaderBoards(questIndex)
				catch = true

				local symbol = (complete or objectives == 0) and "|cff555555[|cffffcc00?|cff555555]|r " or "|cff555555[|cffffcc00!|cff555555]|r "
				tooltip:AddLine(symbol .. meta["quest"], 1, 1, 0)

				local foundObjective = nil
				if objectives then
					for i = 1, objectives do
						local text, type, complete = GetQuestLogLeaderBoard(i, questIndex)

						if type == "monster" then
							-- kill
							local _, _, monsterName, objNum, objNeeded = strfind(text, Codex:SanitizePattern(QUEST_MONSTERS_KILLED))
							if meta["spawn"] == monsterName then
								foundObjective = true
								local r, g, b = CodexMap:GetTooltipColor(objNum, objNeeded)
								tooltip:AddLine("|cffaaaaaa- |r" .. monsterName .. ": " .. objNum .. "/" .. objNeeded, r, g, b)
							end
						elseif table.getn(meta["item"]) > 0 and type == "item" and meta["dropRate"] then
							-- Loot
							local _, _, itemName, objNum, objNeeded = strfind(text, Codex:SanitizePattern(QUEST_OBJECTS_FOUND))

							for mid, item in pairs(meta["item"]) do
								if item == itemName then
									foundObjective = true
									local r, g, b = CodexMap:GetTooltipColor(objNum, objNeeded)
									local dr, dg, db = CodexMap:GetTooltipColor(tonumber(meta["dropRate"]), 100)
									local lootColor = string.format("%02x%02x%02x", dr * 255, dg * 255, db * 255)
									tooltip:AddLine("|cffaaaaaa- |r" .. itemName .. ": " .. objNum .. "/" .. objNeeded .. " |cff555555[|cff" .. lootColor .. meta["dropRate"] .. "%|cff555555]", r, g, b)
								end
							end
						elseif table.getn(meta["item"]) > 0 and type == "item" and meta["sellCount"] then
							-- Vendor
							local _, _, itemName, objNum, objNeeded = strfind(text, Codex:SanitizePattern(QUEST_OBJECTS_FOUND))

							for _, item in pairs(meta["item"]) do
								if item == itemName then
									foundObjective = true
									local r, g, b = CodexMap:GetTooltipColor(objNum, objNeeded)
									local sellCount = tonumber(meta["sellCount"]) > 0 and " |cff555555[|cffcccccc" .. meta["sellCount"] .. "x" .. "|cff555555]" or ""
									tooltip:AddLine("|cffaaaaaa- |cffffffff" .. L["Buy"] .. ": |r" .. itemName .. ": " .. objNum .. "/" .. objNeeded .. sellCount, r, g, b)
								end
							end
						end
					end
				end

				if not foundObjective and meta["questLevel"] and meta["texture"] then
					local questLevelString = L["Level"] .. ": " .. CodexMap:HexDifficultyColor(meta["questLevel"]) .. meta["questLevel"] .. "|r"
					local questMinString = meta["questMinimumLevel"] and " / " .. L["Required"] .. ": " .. CodexMap:HexDifficultyColor(meta["questMinimumLevel"], true) .. meta["questMinimumLevel"] .. "|r" or ""
					tooltip:AddLine("|cffaaaaaa- |r" .. questLevelString .. questMinString , .8,.8,.8)
				end
			end
		end

		if not catch then
			local catchFallback = nil
			tooltip:AddLine("|cff555555[|cffffcc00!|cff555555]|r " .. meta["quest"], 1, 1, .7)

			if meta["item"] and meta["item"][1] and meta["dropRate"] then
				for _, item in pairs(meta["item"]) do
					catchFallback = true
					local dr, dg, db = CodexMap:GetTooltipColor(tonumber(meta["dropRate"]), 100)
					local lootColor = string.format("%02x%02x%02x", dr * 255,dg * 255, db * 255)
					tooltip:AddLine("|cffaaaaaa- |r" .. L["Loot"] .. ": " .. item .. " |cff555555[|cff" .. lootColor .. meta["dropRate"] .. "%|cff555555]", 1, .5, .5)
				end
			end

			if not catchFallback and meta["spawn"] and not meta["texture"] then
				catchFallback = true
				tooltip:AddLine("|cffaaaaaa- |r" .. "Kill: " .. meta["spawn"], 1,.5,.5)
			end

			if not catchFallback and meta["texture"] and meta["questLevel"] then
				local questLevelString = L["Level"] .. ": " .. CodexMap:HexDifficultyColor(meta["questLevel"]) .. meta["questLevel"] .. "|r"
				local questMinString = meta["questMinimumLevel"] and " / " .. L["Required"] .. ": " .. CodexMap:HexDifficultyColor(meta["questMinimumLevel"], true) .. meta["questMinimumLevel"] .. "|r" or ""
				tooltip:AddLine("|cffaaaaaa- |r" .. questLevelString .. questMinString , .8,.8,.8)
			end
		end
	else
		if meta["item"][1] and meta["itemId"] and not meta["itemLink"] then
			local _, _, itemQuality = GetItemInfo(meta["itemId"])
			if itemQuality then
				local itemColor = "|c" .. string.format("%02x%02x%02x%02x", 255,
				ITEM_QUALITY_COLORS[itemQuality].r * 255,
				ITEM_QUALITY_COLORS[itemQuality].g * 255,
				ITEM_QUALITY_COLORS[itemQuality].b * 255)

			meta["itemLink"] = itemColor .. "|Hitem:" .. meta["itemId"] .. ":0:0:0|h[" .. meta["item"][1] .. "]|h|r"
			end
		end

		if meta["sellCount"] then
			local item = meta["itemLink"] or "[" .. meta["item"][1] .. "]"
			local sellCount = tonumber(meta["sellCount"]) > 0 and  " |cff555555[|cffcccccc" .. meta["sellCount"] .. "x" .. "|cff555555]" or ""
			tooltip:AddLine(L["Vendor"] .. ": " .. item .. sellCount, 1, 1, 1)
		elseif meta["item"][1] then
			local item = meta["itemLink"] or "[" .. meta["item"][1] .. "]"
			local r, g, b = CodexMap:GetTooltipColor(tonumber(meta["dropRate"]), 100)
			tooltip:AddLine("|cffffffff" .. L["Loot"] .. ": " .. item ..  " |cff555555[|r" .. meta["dropRate"] .. "%|cff555555]", r,g,b)
		end
	end

	tooltip:Show()
end

function CodexMap:AddNode(meta)
	local addon = meta["addon"] or "CODEX"
	local map = meta["zone"]
	local x = meta["x"]
	local y = meta["y"]
	local coords = x .. "|" .. y
	local title = meta["title"]
	local layer = GetLayerByTexture(meta["texture"])
	local spawn = meta["spawn"]
	local item = meta["item"]

	if not CodexMap.nodes[addon] then CodexMap.nodes[addon] = {} end
	if not CodexMap.nodes[addon][map] then CodexMap.nodes[addon][map] = {} end
	if not CodexMap.nodes[addon][map][coords] then CodexMap.nodes[addon][map][coords] = {} end

	if item and CodexMap.nodes[addon][map][coords][title] and getn(CodexMap.nodes[addon][map][coords][title].item) > 0 then
		-- Check if item exists
		for id, name in pairs(CodexMap.nodes[addon][map][coords][title].item) do
			if name == item then
				return
			end
		end
		table.insert(CodexMap.nodes[addon][map][coords][title].item, item)
	end

	if CodexMap.nodes[addon][map][coords][title] and CodexMap.nodes[addon][map][coords][title].layer and layer and CodexMap.nodes[addon][map][coords][title].layer >= layer then
		return
	end

	local node = {}
	for key, value in pairs(meta) do
		node[key] = value
	end
	node.item = {[1] = item}

	CodexMap.nodes[addon][map][coords][title] = node

	if spawn and title then
		CodexMap.tooltips[spawn] = CodexMap.tooltips[spawn] or {}
		CodexMap.tooltips[spawn][title] = CodexMap.tooltips[spawn][title] or node
	end
end

function CodexMap:DeleteNode(addon, title)
	if not addon then
		CodexMap.tooltips = {}
	else
		for key, value in pairs(CodexMap.tooltips) do
			for k, v in pairs(value) do
				if (title and k == title) or (not title and v.addon == addon) then
					CodexMap.tooltips[key][k] = nil
				end
			end
		end
	end 

	if not addon then
		CodexMap.nodes = {}
	elseif not title then
		CodexMap.nodes[addon] = {}
	elseif CodexMap.nodes[addon] then
		for map in pairs(CodexMap.nodes[addon]) do
			for coords, node in pairs(CodexMap.nodes[addon][map]) do
				if CodexMap.nodes[addon][map][coords][title] then
					CodexMap.nodes[addon][map][coords][title] = nil
					if isEmpty(CodexMap.nodes[addon][map][coords]) then
						CodexMap.nodes[addon][map][coords] = nil
					end
				end
			end
		end
	end
end

function CodexMap:CreateMapMarker(node)
	local marker = CreateFrame("Button", nil, UIParent)
	marker:SetFrameStrata("HIGH")
	marker:SetWidth(10)
	marker:SetHeight(10)
	marker:SetParent(WorldMapFrame)
	
	local texture = marker:CreateTexture(nil, "HIGH")
	texture:SetAllPoints(marker)
	marker.tex = texture
	marker:SetPoint("CENTER", 0, 0)
	marker:Hide()

	marker:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR_LEFT")
		GameTooltip:SetText(marker.spawn, .3, 1, .8)
		GameTooltip:AddDoubleLine(L["Level"]..": ", (marker.level or UNKNOWN), .8, .8, .8, 1, 1, 1)

		for title, meta in pairs(marker.node) do
			CodexMap:ShowTooltip(meta, GameTooltip)
		end
	end)

	marker:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)


	return marker
end

function CodexMap:CreateMinimapMarker(node)
	local marker = CreateFrame("Button", nil, UIParent)
	marker:SetFrameStrata("HIGH")
	marker:SetWidth(10)
	marker:SetHeight(10)
	
	local texture = marker:CreateTexture(nil, "HIGH")
	texture:SetAllPoints(marker)
	marker.tex = texture
	marker:SetPoint("CENTER", 0, 0)
	marker:Hide()

	marker:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR_LEFT")
		GameTooltip:SetText(marker.spawn, .3, 1, .8)
		GameTooltip:AddDoubleLine(L["Level"]..": ", (marker.level or UNKNOWN), .8, .8, .8, 1, 1, 1)

		for title, meta in pairs(marker.node) do
			CodexMap:ShowTooltip(meta, GameTooltip)
		end
	end)

	marker:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	return marker
end

function CodexMap:UpdateNode(frame, node)
	frame.layer = 0
	local markerSize = CodexConfig.spawnMarkerSize

	for title, meta in pairs(node) do
		meta.layer = GetLayerByTexture(meta.texture)
		if meta.spawn and (meta.layer > frame.layer or not frame.spawn) then
			frame.updateTexture = (frame.texture ~= meta.texture)
			frame.updateVertex = (frame.vertex ~= meta.vertex)
			frame.updateColor = (frame.color ~= meta.color)

			-- set title and texture to the entry with highest layer
			-- and add core information
			frame.layer = meta.layer
			frame.spawn = meta.spawn
			frame.spawnId = meta.spawnId
			frame.spawnType = meta.spawnType
			frame.respawn = meta.respawn
			frame.level = meta.level
			frame.questId = meta.questId
			frame.texture = meta.texture
			frame.vertex = meta.vertex
			frame.title = title

			if CodexConfig.colorBySpawn then
				frame.color = meta.spawn or meta.title
			else
				frame.color = meta.title
			end

			if meta.coordsNum == 1 then
				markerSize = CodexConfig.bossMarkerSize
			end
		end
	end

	frame.tex:SetVertexColor(1, 1, 1, 1)
	
	if not frame.texture then
		frame:SetWidth(markerSize)
		frame:SetHeight(markerSize)
		frame.tex:SetTexture("Interface\\Addons\\ClassicCodex\\img\\icon.tga")

		local r, g, b = str2rgb(frame.color)
		frame.tex:SetVertexColor(r, g, b, 1)
	else
		frame:SetWidth(CodexConfig.questMarkerSize)
		frame:SetHeight(CodexConfig.questMarkerSize)
		frame.tex:SetTexture(frame.texture)
		if frame.vertex then
			local r, g, b = unpack(frame.vertex)
			if r > 0 or g > 0 or b > 0 then
				frame.tex:SetVertexColor(r, g, b, 1)
			end
		else
			frame.tex:SetVertexColor(1, 1, 1, 1)
		end
	end

	frame:SetScript("OnClick", function(self)
		if IsControlKeyDown() then
			if TomTom and TomTom.AddWaypoint and TomTom.RemoveWaypoint then
				local node = self.node[self.title]
				if not node then return end

				if CodexConfig._tom_waypoint then
					TomTom:RemoveWaypoint(CodexConfig._tom_waypoint)
				end
				CodexConfig._tom_waypoint = TomTom:AddWaypoint(CodexMap.zones[node.zone], node.x/100, node.y/100,  {title = self.spawn, crazy = true})
			end
		elseif IsShiftKeyDown() and self.questId and self.texture and self.layer < 5 then
			-- player hides the quest
			CodexMap:DeleteNode(self.node[self.title].addon, self.title)
			CodexHiddenQuests[self.questId] = true
			CodexMap:UpdateNodes()
		elseif IsShiftKeyDown() then
			CodexMap:DeleteNode(self.node[self.title].addon, self.title)
			CodexMap:UpdateNodes()
		else
			CodexColors[self.color] = {str2rgb(self.color .. GetTime())}
			CodexMap:UpdateNodes()
		end
	end)

	-- if frame.texture then
	-- 	frame:SetWidth(CodexConfig.questMarkerSize)
	-- 	frame:SetHeight(CodexConfig.questMarkerSize)

	-- 	if frame.updateTexture or frame.updateVertex then
	-- 		frame.tex:SetTexture(frame.texture)
	-- 		frame.tex:SetVertexColor(1, 1, 1)

	-- 		if frame.updateVertex and frame.vertex then
	-- 			local r, g, b = unpack(frame.vertex)
	-- 			if r > 0 or g > 0 or b > 0 then
	-- 				frame.tex:SetVertexColor(r, g, b, 1)
	-- 			end
	-- 		end
	-- 	end
	-- else
	-- 	frame:SetWidth(CodexConfig.spawnMarkerSize)
	-- 	frame:SetHeight(CodexConfig.spawnMarkerSize)

	-- 	if frame.updateColor or frame.updateTexture then
	-- 		frame.tex:SetTexture("Interface\\Addons\\ClassicCodex\\img\\icon.tga")

	-- 		local r, g, b = str2rgb(frame.color)
	-- 		frame.tex:SetVertexColor(r, g, b, 1)
	-- 	end
	-- end

	-- if frame.updateTexture or frame.updateVertex or frame.updateColor then
		-- frame:SetScript("OnClick", function(self)
		-- 	if IsShiftKeyDown() and self.questId and self.texture and self.layer < 5 then
		-- 		-- mark questnode as done
		-- 		CodexMap:DeleteNode(self.node[self.title].addon, self.title)
		-- 		CodexHistory[self.questId] = true
		-- 		CodexMap:UpdateNodes()
		-- 	elseif IsShiftKeyDown() then
		-- 		CodexMap:DeleteNode(self.node[self.title].addon, self.title)
		-- 		CodexMap:UpdateNodes()
		-- 	else
		-- 		CodexColors[self.color] = {str2rgb(self.color .. GetTime())}
		-- 		CodexMap:UpdateNodes()
		-- 	end
		-- end)
	-- end

	frame.node = node
end


	-- frame.tex:SetVertexColor(1, 1, 1)

	-- if not frame.texture then
	-- 	frame:SetWidth(10)
	-- 	frame:SetHeight(10)
	-- 	frame.tex:SetTexture("Interface\\Addons\\ClassicCodex\\img\\icon.tga")
	-- else
	-- 	frame:SetWidth(14)
	-- 	frame:SetHeight(14)
	-- 	frame.tex:SetTexture(frame.texture)
	-- end

	-- frame:SetScript("OnClick", function(self)
	-- 	if IsShiftKeyDown() and self.questId and self.texture and self.layer < 5 then
	-- 		-- mark questnode as done
	-- 		CodexMap:DeleteNode(self.node[self.title].addon, self.title)
	-- 		CodexHistory[self.questId] = true
	-- 		CodexMap:UpdateNodes()
	-- 	elseif IsShiftKeyDown() then
	-- 		CodexMap:DeleteNode(self.node[self.title].addon, self.title)
	-- 		CodexMap:UpdateNodes()
	-- 	end
	-- end)

	-- if not frame.color then 
	-- 	-- if frame.uuid and CodexMap.objectiveList[frame.uuid] and CodexMap.objectiveList[frame.uuid] == 1 and frame.layer ~= 5 then
	-- 	-- 	local r, g, b = unpack(CodexConfig.colorList[CodexMap.colorListIndex])
	-- 	-- 	frame.tex:SetVertexColor(r, g, b, 1)
	-- 	-- 	CodexMap.objectiveList[frame.uuid] = CodexConfig.colorList[CodexMap.colorListIndex]
	-- 	-- 	CodexMap.colorListIndex = CodexMap.colorListIndex + 1
	-- 	-- 	if CodexMap.colorListIndex > getn(CodexConfig.colorList) then
	-- 	-- 		CodexMap.colorListIndex = 1
	-- 	-- 	end
	-- 	-- elseif frame.uuid and CodexMap.objectiveList[frame.uuid] and frame.layer ~= 5 then
	-- 	-- 	local color = CodexMap.objectiveList[frame.uuid]
	-- 	-- 	frame.tex:SetVertexColor(color[1], color[2], color[3])
	-- 	-- elseif frame.search then
	-- 	-- 	frame.tex:SetVertexColor(CodexConfig.searchColor[1], CodexConfig.searchColor[2], CodexConfig.searchColor[3], 1)
	-- 	-- end
	-- 	local r, g, b = str2rgb(frame.spawn)
	-- 	frame.tex:SetVertexColor(r, g, b, 1)
	-- else
	-- 	local r, g, b = unpack(frame.color)
	-- 	if r > 0 or g > 0 or b > 0 then
	-- 		frame.tex:SetVertexColor(r, g, b, 1)
	-- 	end
	-- end


	-- frame.node = node


function CodexMap:UpdateNodes()
	-- local worldMapId = C_Map.GetBestMapForUnit("player")
	local i = 0

	CodexMap.objectiveList = {}
	CodexMap.colorListIndex = 1

	CodexMap.HBDP:RemoveAllWorldMapIcons("Map")
	CodexMap.HBDP:RemoveAllMinimapIcons("Map")

	local worldMapLevel = nil
	if CodexConfig.continentIcon then 
		worldMapLevel = HBD_PINS_WORLDMAP_SHOW_WORLD
	elseif CodexConfig.zoneMapIcon then
		worldMapLevel = HBD_PINS_WORLDMAP_SHOW_PARENT
	end

	-- refresh all nodes
	for addon in pairs(CodexMap.nodes) do
		for mapId in pairs(CodexMap.nodes[addon]) do
			worldMapId = CodexMap.zones[mapId]
			if worldMapId then
				for coords, node in pairs(CodexMap.nodes[addon][mapId]) do
					if not CodexMap.markers[i] or not CodexMap.minimapMarkers[i] then
						CodexMap.markers[i] = CodexMap:CreateMapMarker(node)
						CodexMap.minimapMarkers[i] = CodexMap:CreateMinimapMarker(node)
					end

					CodexMap:UpdateNode(CodexMap.markers[i], node)
					CodexMap:UpdateNode(CodexMap.minimapMarkers[i], node)

					local _, _, x, y = strfind(coords, "(.*)|(.*)")
					x = x / 100
					y = y / 100
				
					if worldMapLevel then
						CodexMap.HBDP:AddWorldMapIconMap("Map", CodexMap.markers[i], worldMapId, x, y, worldMapLevel)
					end
					if CodexConfig.miniMapIcon then
						CodexMap.HBDP:AddMinimapIconMap("Map", CodexMap.minimapMarkers[i], worldMapId, x, y, true, false)
					end

					i = i + 1
				end
			end
		end
	end

end

-- Since UpdateNodes draws markers for all maps, it is no longer necessary to redraw when changing zones.
--[[
CodexMap:RegisterEvent("ZONE_CHANGED")
CodexMap:RegisterEvent("ZONE_CHANGED_NEW_AREA")
CodexMap:SetScript("OnEvent", function(self, event, ...)
	CodexMap:UpdateNodes()
end)
]]
