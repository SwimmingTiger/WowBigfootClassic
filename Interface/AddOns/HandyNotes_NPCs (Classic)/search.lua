local name, data = ...

local Search = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_NPCs", "AceConsole-3.0")
local HBD = LibStub("HereBeDragons-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_NPCs (Classic)")

local NUM_LINES = 10
local LINE_HEIGHT = 20
local lastSearchedItem = nil
local frames = { }
local list = { }

local function update(self)
	local numItems = #list
	--print ("DEBUG: nr. items " .. numItems)
	FauxScrollFrame_Update(self, numItems, 10, 20)
	local offset = FauxScrollFrame_GetOffset(self)
	for line = 1, 10 do
		local lineplusoffset = line + offset
		local frame = frames[line]
		if lineplusoffset > numItems then
			frame:SetScript("OnMouseDown", nil)
			frame:SetScript("OnEnter", nil)
			frame:SetScript("OnLeave", nil)
			frame:Hide()
		else
			local entry = list[lineplusoffset]

			if entry.type == "item" then
				lastSearchedItem = nil
				local item = data["items"][entry.itemID]
				local itemColor = ITEM_QUALITY_COLORS[item.quality]
				frame.ltext:SetText("|T".. "Interface\\ICONS\\" .. item.icon ..":0|t" .. item.name)
				frame.ltext:SetTextColor(itemColor.r, itemColor.g, itemColor.b)
				if item.buyPrice then
					frame.rtext:SetText(GetCoinTextureString(item.buyPrice))
				end
				frame:SetScript("OnMouseDown", function() Search:FindNeareastNPCs(entry.itemID) end)
				frame:SetScript("OnEnter", function(self) Search:TooltipShow(self, entry.itemID) end)
				frame:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
			end
			if entry.type == "npc" then
				lastSearchedItem = entry.itemID
				local distanceText = ''
				local zoneName = HBD:GetLocalizedMap(entry.zone)
				frame.ltext:SetText(entry.name)
				frame.ltext:SetTextColor(1, 1, 1)
				if zoneName then
					distanceText = distanceText .. zoneName
				end
				if entry.distance == 10000000 then
					distanceText = distanceText .. ' N/A'
				else
					distanceText = distanceText .. ': ' .. tostring(entry.distance) .. " yards"
				end
				frame.rtext:SetText(distanceText)
				frame:SetScript("OnEnter", nil)
				frame:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
				frame:SetScript("OnMouseDown", function(self, button)
								if button == "LeftButton" then
									local text = entry.name
									if data["items"][entry.itemID] then
										text = text .. '\n' .. data["items"][entry.itemID].name
									end
									Search:SetWaypoint(entry.zone, entry.coord, text)
								elseif button == "MiddleButton" then
									Search:DumpVendorItems(entry.npcID, entry.name)
								elseif button == "RightButton" then
									Search:SearchNPCs(entry.itemID)
								end
							end)
			end
			frame:Show()
		end
	end
end

function Search:OnInitialize()
	local window = CreateFrame("Frame", "HandyNotes_NPCs_SearchWindow", UIParent)

	window:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\Buttons\\WHITE8x8", tile = false, tileSize = 0, edgeSize = 1, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	window:SetBackdropColor(0.435, 0.403, 0.403, 0.8)
	window:SetBackdropBorderColor(1,1,1,1)
	window:SetPoint("CENTER")
	window:SetWidth(400)
	window:SetHeight((NUM_LINES + 1) * LINE_HEIGHT + 8)
	window:EnableMouse(true)
	window:SetScript("OnMouseDown", function(self, button) if (button == "RightButton" and lastSearchedItem) then Search:SearchNPCs(lastSearchedItem) end end)
	window:SetScript("OnLeave", function() GameTooltip:Hide() end)
	window.header = CreateFrame("Frame", nil, window)
	window.header:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})
	window.header:SetPoint("TOP", window, 0, -4)
	window.header:SetHeight(LINE_HEIGHT)
	window.header:SetWidth(window:GetWidth()-10)
	window.header.ltext = window.header:CreateFontString(nil, 'OVERLAY')
	window.header.ltext:SetFont("Fonts\\FRIZQT__.TTF", 11)
	window.header.ltext:SetPoint("LEFT")
	window.header.rtext = window.header:CreateFontString(nil, 'OVERLAY')
	window.header.rtext:SetFont("Fonts\\FRIZQT__.TTF", 11)
	window.header.rtext:SetPoint("RIGHT")
	window.header:SetBackdropColor(0.498, 0.443, 0.443, 1)
	window.header.ltext:SetText(L["Item"])
	window.header.rtext:SetText(L["Cost"])
	window.header:Show()
	window.footer = CreateFrame("Frame", nil, window)
	--window.footer:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})
	--window.footer:SetBackdropColor(0.498, 0.443, 0.443, .3)
	window.footer:SetPoint("TOPRIGHT", window, "BOTTOMRIGHT", 0, 4)
	window.footer:SetHeight(LINE_HEIGHT)
	window.footer:SetWidth(window:GetWidth()-10)
	window.footer.rtext = window.footer:CreateFontString(nil, 'OVERLAY')
	window.footer.rtext:SetFont("Fonts\\FRIZQT__.TTF", 10)
	window.footer.rtext:SetPoint("RIGHT")
	window.footer.rtext:SetText("HandyNotes_NPCs (Classic) by Revel of Pagle")
	window.footer:SetWidth(window.footer.rtext:GetStringWidth())
	
	local f = CreateFrame("ScrollFrame", nil, window, "FauxScrollFrameTemplate")
	window.f = f
	f:SetScript("OnVerticalScroll", function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, LINE_HEIGHT, update) end)
	--f:SetPoint("CENTER")
	--f:SetWidth(400)
	--f:SetHeight(400)
	f:SetAllPoints(true)

	for i = 1, NUM_LINES do
		local frame = CreateFrame("Frame", nil, window)
		frame.ltext = frame:CreateFontString(nil, 'OVERLAY')
		frame.ltext:SetFont("Fonts\\FRIZQT__.TTF", 11)
		frame.ltext:SetPoint("LEFT")
		frame.rtext = frame:CreateFontString(nil, 'OVERLAY')
		frame.rtext:SetFont("Fonts\\FRIZQT__.TTF", 11)
		frame.rtext:SetPoint("RIGHT")
		if i == 1 then
			frame:SetPoint("TOP", window.header, "BOTTOM", 0, 0)
		else
			frame:SetPoint("TOP", frames[i - 1], "BOTTOM")
		end
		frame:SetHeight(LINE_HEIGHT)
		frame:SetWidth(window:GetWidth()-10)


		frame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})
		frame:EnableMouse(true)
		if i % 2 == 1 then
			frame:SetBackdropColor(0.301, 0.301, 0.301, 1)
		else
			frame:SetBackdropColor(0.070, 0.070, 0.070, 1)
		end
		frame:Hide()
		frames[i] = frame
	end

	window.editbox = CreateFrame("EditBox", nil, window)
	window.editbox:SetPoint("BOTTOM", window, "TOP", 0, 8)
	window.editbox:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\Buttons\\WHITE8x8", tile = false, tileSize = 0, edgeSize = 1, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	window.editbox:SetBackdropColor(0,0,0,0.5)
	window.editbox:SetBackdropBorderColor(1,1,1,1)
	window.editbox:SetFontObject(ChatFontNormal)
	window.editbox:SetWidth(window:GetWidth()-20)
	window.editbox:SetHeight((select(2, ChatFontNormal:GetFont()))+8)
	window.editbox:SetMultiLine(false)
	window.editbox:SetAutoFocus(false)
	window.editbox:SetScript("OnEditFocusGained", function(self) if self:GetText() == L["Search for an item"] then self:SetText("") end end)
	window.editbox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	window.editbox:SetScript("OnTextChanged", function(self) if self:GetText() ~= L["Search for an item"] then Search:SearchNPCs() end end)
	window.editbox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	window.editbox:SetText(L["Search for an item"])
	window.editbox:SetTextInsets(10, 0, 0, 0)
	
	window.closeButton = CreateFrame("Button", nil, window.editbox, "UIPanelButtonTemplate")
	window.closeButton:SetSize(26, 26)
	window.closeButton:SetText('X')
	window.closeButton:SetPoint("LEFT", window.editbox, "RIGHT", 10, 0)
	window.closeButton:SetScript("OnClick", function(self) window:Hide() end)
	
	window.zoneButton = CreateFrame("Button", nil, window, "UIPanelButtonTemplate")
	window.zoneButton:SetSize(26, 26)
	window.zoneButton:SetText('Z')
	window.zoneButton:SetPoint("TOPLEFT", window, "BOTTOMLEFT", 0, -2)
	window.zoneButton:SetScript("OnClick", function() self:FindNeareastNPCs(nil, "zone") end)

	self:RegisterChatCommand("npcs", "SlashCommand")
	self.window = window
	window:Hide()
	tinsert(UISpecialFrames, window:GetName()) -- Makes Search Window closable with the escape key
	data["searchWindow"] = window
end

function Search:SlashCommand(input)
	if not input then return end

	local command, nextposition = self:GetArgs(input,1,1)
	if command == "zone" then
		self:FindNeareastNPCs(nil, "zone")
		return
	end
	self:ShowWindow()
end

function Search:ShowWindow(force)
	if self.window:IsVisible() and not force then
		self.window:Hide()
	else
		self.window:Show()
	end
end

function Search:SearchNPCs()
	local text = self.window.editbox:GetText()
	table.wipe(list)
	
	for k,v in pairs(data["items"]) do
		if string.find(v.name:lower(), text:lower(), 1, true) then
			table.insert(list, { itemID = k, type = "item" })
		end
	end
	self:UpdateHeader("Item", "Cost")
	update(self.window.f)
end

function Search:FindNeareastNPCs(itemID, type)
	table.wipe(list)
	local vendorIDList = { }
	local playerX, playerY, playerMapID = HBD:GetPlayerZonePosition()
	if type == "zone" then
		if not data["nodes"][playerMapID] then return end
		for k, v in pairs(data["nodes"][playerMapID]) do
			if v.npcID and data["vendors"][v.npcID] then
				vendorIDList[v.npcID] = true
			end
		end
	else
		for k,v in pairs(data["vendors"]) do
			for item in v:gmatch("([^,]+)") do
				if tonumber(item) == itemID then
					vendorIDList[k] = true
					
				end
			end
		end
	end
	
	for zone, t1 in pairs(data["nodes"]) do
		for coord, npcData in pairs(t1) do
			if npcData.npcID and vendorIDList[npcData.npcID] and (npcData.faction == "Neutral" or npcData.faction == data.faction) then
				
				local npcX, npcY = HandyNotes:getXY(coord)
				distance = HBD:GetZoneDistance(playerMapID, playerX, playerY, zone, npcX, npcY)
				if distance == nil then
					distance = 10000000 -- Just some unreasonably large value for sorting
				end
				table.insert(list, { name = npcData["name"], npcID = npcData.npcID, itemID = itemID, type = 'npc', distance = Round(distance), zone = zone, coord = coord })
			end
		end
	end

	table.sort(list, function(a,b) return a.distance < b.distance or a.distance == b.distance and a.name < b.name end)
	self:UpdateHeader("NPC", "Distance")
	update(self.window.f)
end

function Search:DumpVendorItems(npcID, npcName)
	table.wipe(list)
	if not data["vendors"][npcID] then return end
	for item in data["vendors"][npcID]:gmatch("([^,]+)") do
		item = tonumber(item)
		if data["items"][item] then
			table.insert(list, { itemID = item, type = "item" })
		end
	end
	self:UpdateHeader(npcName, nil)
	update(self.window.f)
end

function Search:TooltipShow(frame, itemID)
	if not itemID or not data["items"][itemID] then return end

	local tooltip = GameTooltip
	if ( frame:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(frame, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(frame, "ANCHOR_RIGHT")
	end

	tooltip:SetHyperlink("item:" .. tostring(itemID) .. ":0:0:0:0:0:0:0")
	tooltip:Show()
	
	return
end

function Search:UpdateHeader(ltext, rtext)
 if not ltext then ltext = "" end
 if not rtext then rtext = "" end
 self.window.header.ltext:SetText(ltext)
 self.window.header.rtext:SetText(rtext)
end

function Search:SetWaypoint(mapFile, coord, title)
	if not TomTom then return end
	local x, y = HandyNotes:getXY(coord)
	TomTom:AddWaypoint(mapFile, x, y, {
		title = title,
		persistent = false,
		minimap = true,
		world = true
	})
end
