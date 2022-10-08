local HBDP = LibStub("HereBeDragons-Pins-2.0")
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale("Spy")
local _

function Spy:RefreshCurrentList(player, source)
	local MainWindow = Spy.MainWindow
	if not MainWindow:IsShown() then
		return
	end

	local mode = Spy.db.profile.CurrentList
	local manageFunction = Spy.ListTypes[mode][2]
	if manageFunction then
		manageFunction()
	end

	local button = 1
	for index, data in pairs(Spy.CurrentList) do
		if button <= Spy.ButtonLimit then
			local description = ""
			local level = "??"
			local class = "UNKNOWN"
			local guild = "??"
			local opacity = 1

			local playerData = SpyPerCharDB.PlayerData[data.player]
			if playerData then
				if playerData.level then
					level = playerData.level
					if playerData.isGuess == true and tonumber(playerData.level) < Spy.MaximumPlayerLevel then
						level = level.."+"
					end
				end
				if playerData.class then
					class = playerData.class
				end
				if playerData.guild then
					guild = playerData.guild
				end
			end
			
			if Spy.db.profile.DisplayListData == "NameLevelClass" then
				description = level.." "
				if L[class] and type(L[class]) == "string" then
					description = description..L[class]
				end
			elseif Spy.db.profile.DisplayListData == "NameLevelGuild" then
				description = level.." "..guild
			elseif Spy.db.profile.DisplayListData == "NameLevelOnly" then
				description = level.." "
			elseif Spy.db.profile.DisplayListData == "NameGuild" then
					description = guild
			end
			
			if mode == 1 and Spy.InactiveList[data.player] then
				opacity = 0.5
			end
			if player == data.player then
				if not source or source ~= Spy.CharacterName then
					Spy:AlertPlayer(player, source)
					if not source then
						Spy:AnnouncePlayer(player)
					end
				end
			end

			Spy:SetBar(button, data.player, description, 100, "Class", class, nil, opacity)
			Spy.ButtonName[button] = data.player
			button = button + 1
		end
	end
	Spy.ListAmountDisplayed = button - 1

	if Spy.db.profile.ResizeSpy then
		Spy:AutomaticallyResize()
	else
		if not Spy.db.profile.InvertSpy then
			if not InCombatLockdown() and Spy.MainWindow:GetHeight()< 34 then
				Spy:RestoreMainWindowPosition(Spy.MainWindow:GetLeft(), Spy.MainWindow:GetTop(), Spy.MainWindow:GetWidth(), 34)
			end
		else
			if not InCombatLockdown() and Spy.MainWindow:GetHeight()< 34 then 
				Spy:RestoreMainWindowPosition(Spy.MainWindow:GetLeft(), Spy.MainWindow:GetBottom(), Spy.MainWindow:GetWidth(), 34)
			end
		end	
	end
	Spy:ManageBarsDisplayed()
end

function Spy:ManageNearbyList()
	local prioritiseKoS = Spy.db.profile.PrioritiseKoS

	local activeKoS = {}
	local active = {}
	for player in pairs(Spy.ActiveList) do
		local position = Spy.NearbyList[player]
		if position ~= nil then
			if prioritiseKoS and SpyPerCharDB.KOSData[player] then
				table.insert(activeKoS, { player = player, time = position })
			else
				table.insert(active, { player = player, time = position })
			end
		end
	end

	local inactiveKoS = {}
	local inactive = {}
	for player in pairs(Spy.InactiveList) do
		local position = Spy.NearbyList[player]
		if position ~= nil then
			if prioritiseKoS and SpyPerCharDB.KOSData[player] then
				table.insert(inactiveKoS, { player = player, time = position })
			else
				table.insert(inactive, { player = player, time = position })
			end
		end
	end

	table.sort(activeKoS, function(a, b) return a.time < b.time end)
	table.sort(inactiveKoS, function(a, b) return a.time < b.time end)
	table.sort(active, function(a, b) return a.time < b.time end)
	table.sort(inactive, function(a, b) return a.time < b.time end)

	local list = {}
	for player in pairs(activeKoS) do table.insert(list, activeKoS[player]) end
	for player in pairs(inactiveKoS) do table.insert(list, inactiveKoS[player]) end
	for player in pairs(active) do table.insert(list, active[player]) end
	for player in pairs(inactive) do table.insert(list, inactive[player]) end
	Spy.CurrentList = list
end

function Spy:ManageLastHourList()
	local list = {}
	for player in pairs(Spy.LastHourList) do
		table.insert(list, { player = player, time = Spy.LastHourList[player] })
	end
	table.sort(list, function(a, b) return a.time > b.time end)
	Spy.CurrentList = list
end

function Spy:ManageIgnoreList()
	local list = {}
	for player in pairs(SpyPerCharDB.IgnoreData) do
		local playerData = SpyPerCharDB.PlayerData[player]
		local position = time()
		if playerData then position = playerData.time end
		table.insert(list, { player = player, time = position })
	end
	table.sort(list, function(a, b) return a.time > b.time end)
	Spy.CurrentList = list
end

function Spy:ManageKillOnSightList()
	local list = {}
	for player in pairs(SpyPerCharDB.KOSData) do
		local playerData = SpyPerCharDB.PlayerData[player]
		local position = time()
		if playerData then position = playerData.time end
		table.insert(list, { player = player, time = position })
	end
	table.sort(list, function(a, b) return a.time > b.time end)
	Spy.CurrentList = list
end

function Spy:GetNearbyListSize()
	local entries = 0
	for v in pairs(Spy.NearbyList) do
		entries = entries + 1
	end
	return entries
end

function Spy:UpdateActiveCount()
    local activeCount = 0
    for k in pairs(Spy.ActiveList) do
        activeCount = activeCount + 1
    end
	local theFrame = Spy.MainWindow
    if activeCount > 0 then 
		theFrame.CountFrame.Text:SetText("|cFF0070DE" .. activeCount .. "|r") 
    else 
        theFrame.CountFrame.Text:SetText("|cFF0070DE0|r")
    end
end

function Spy:ManageExpirations()
	local mode = Spy.db.profile.CurrentList
	local expirationFunction = Spy.ListTypes[mode][3]
	if expirationFunction then
		expirationFunction()
	end
end

function Spy:ManageNearbyListExpirations()
	local expired = false
	local currentTime = time()
	for player in pairs(Spy.ActiveList) do
		if (currentTime - Spy.ActiveList[player]) > Spy.ActiveTimeout then
			Spy.InactiveList[player] = Spy.ActiveList[player]
			Spy.ActiveList[player] = nil
			expired = true
		end
	end
	if Spy.db.profile.RemoveUndetected ~= "Never" then
		for player in pairs(Spy.InactiveList) do
			if (currentTime - Spy.InactiveList[player]) > Spy.InactiveTimeout then
				if Spy.PlayerCommList[player] ~= nil then
					Spy.MapNoteList[Spy.PlayerCommList[player]].displayed = false
					Spy.MapNoteList[Spy.PlayerCommList[player]].worldIcon:Hide()
					HBDP:RemoveMinimapIcon(self, Spy.MapNoteList[Spy.PlayerCommList[player]].miniIcon)
					Spy.PlayerCommList[player] = nil
				end
				Spy.InactiveList[player] = nil
				Spy.NearbyList[player] = nil
				expired = true
			end
		end
	end
	if expired then
		Spy:RefreshCurrentList()
		Spy:UpdateActiveCount()
		if Spy.db.profile.HideSpy and Spy:GetNearbyListSize() == 0 then 
			if not InCombatLockdown() then
				Spy.MainWindow:Hide()
			else	
				Spy:HideSpyCombatCheck()
			end
		end
	end
end

function Spy:ManageLastHourListExpirations()
	local expired = false
	local currentTime = time()
	for player in pairs(Spy.LastHourList) do
		if (currentTime - Spy.LastHourList[player]) > 3600 then
			Spy.LastHourList[player] = nil
			expired = true
		end
	end
	if expired then
		Spy:RefreshCurrentList()
	end
end

function Spy:RemovePlayerFromList(player)
	Spy.NearbyList[player] = nil
	Spy.ActiveList[player] = nil
	Spy.InactiveList[player] = nil
	if Spy.PlayerCommList[player] ~= nil then
		Spy.MapNoteList[Spy.PlayerCommList[player]].displayed = false
		Spy.MapNoteList[Spy.PlayerCommList[player]].worldIcon:Hide()
		HBDP:RemoveMinimapIcon(self, Spy.MapNoteList[Spy.PlayerCommList[player]].miniIcon)
		Spy.PlayerCommList[player] = nil
	end
	Spy:RefreshCurrentList()
	Spy:UpdateActiveCount()	
end

function Spy:ClearList()
	if IsShiftKeyDown () then
		Spy:EnableSound(not Spy.db.profile.EnableSound, false)
	else	
		Spy.NearbyList = {}
		Spy.ActiveList = {}
		Spy.InactiveList = {}
		Spy.PlayerCommList = {}
		Spy.ListAmountDisplayed = 0
		for i = 1, Spy.MapNoteLimit do
			Spy.MapNoteList[i].displayed = false
			Spy.MapNoteList[i].worldIcon:Hide()
			HBDP:RemoveMinimapIcon(self, Spy.MapNoteList[i].miniIcon)
		end
		Spy:SetCurrentList(1)
		if IsControlKeyDown() then
			Spy:EnableSpy(not Spy.db.profile.Enabled, false)
		end
		Spy:UpdateActiveCount()
	end	
end

function Spy:AddPlayerData(name, class, level, race, guild, isEnemy, isGuess)
	local info = {}
	info.name = name  --++ added to normalize data
	info.class = class
	if type(level) == "number" then info.level = level end
	info.race = race
	info.guild = guild
	info.isEnemy = isEnemy
	info.isGuess = isGuess
	SpyPerCharDB.PlayerData[name] = info
	return SpyPerCharDB.PlayerData[name]
end

function Spy:UpdatePlayerData(name, class, level, race, guild, isEnemy, isGuess)
	local detected = true
	local playerData = SpyPerCharDB.PlayerData[name]
	if not playerData then
		playerData = Spy:AddPlayerData(name, class, level, race, guild, isEnemy, isGuess)
	else
		if name ~= nil then playerData.name = name end  
		if class ~= nil then playerData.class = class end
		if type(level) == "number" then playerData.level = level end
		if race ~= nil then playerData.race = race end
		if guild ~= nil then playerData.guild = guild end
		if isEnemy ~= nil then playerData.isEnemy = isEnemy end
		if isGuess ~= nil then playerData.isGuess = isGuess end
	end
	if playerData then
		playerData.time = time()
		if not Spy.ActiveList[name] then
			if (WorldMapFrame:IsVisible() and Spy.db.profile.SwitchToZone) then
				WorldMapFrame:SetMapID(C_Map.GetBestMapForUnit("player"))
			end
			if (nil == C_Map.GetBestMapForUnit("player")) or (nil == C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player")) then
				local x,y = 0,0
				local InsName = GetInstanceInfo()
				playerData.zone = InsName
				playerData.subZone = ""
			else
				local mapX, mapY = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player"):GetXY()			
				if mapX ~= 0 and mapY ~= 0 then
					mapX = math.floor(tonumber(mapX) * 100) / 100
					mapY = math.floor(tonumber(mapY) * 100) / 100
					playerData.mapX = mapX
					playerData.mapY = mapY
					playerData.zone = GetZoneText()
					playerData.mapID = C_Map.GetBestMapForUnit("player") --++8.0
					playerData.subZone = GetSubZoneText()
				else
					detected = false
				end
			end
		end	
	end
	return detected
end

function Spy:UpdatePlayerStatus(name, class, level, race, guild, isEnemy, isGuess)
	local playerData = SpyPerCharDB.PlayerData[name]
	if not playerData then
		playerData = Spy:AddPlayerData(name, class, level, race, guild, isEnemy, isGuess)
	else
		if name ~= nil then playerData.name = name end  
		if class ~= nil then playerData.class = class end
		if type(level) == "number" then playerData.level = level end
		if race ~= nil then playerData.race = race end
		if guild ~= nil then playerData.guild = guild end
		if isEnemy ~= nil then playerData.isEnemy = isEnemy end
		if isGuess ~= nil then playerData.isGuess = isGuess end
	end
	if playerData.time == nil then
		playerData.time = time()
	end	
end

function Spy:RemovePlayerData(name)
	SpyPerCharDB.PlayerData[name] = nil
end

function Spy:AddIgnoreData(name)
	SpyPerCharDB.IgnoreData[name] = true
end

function Spy:RemoveIgnoreData(name)
	if SpyPerCharDB.IgnoreData[name] then
		SpyPerCharDB.IgnoreData[name] = nil
	end
end

function Spy:AddKOSData(name)
	SpyPerCharDB.KOSData[name] = time()
--	SpyPerCharDB.PlayerData[name].kos = 1 
	if Spy.db.profile.ShareKOSBetweenCharacters then
		SpyDB.removeKOSData[Spy.RealmName][Spy.FactionName][name] = nil
	end
end

function Spy:RemoveKOSData(name)
	if SpyPerCharDB.KOSData[name] then
		local playerData = SpyPerCharDB.PlayerData[name]
		if playerData and playerData.reason then
			playerData.reason = nil
		end
		SpyPerCharDB.KOSData[name] = nil
		if SpyPerCharDB.PlayerData[name] then
			SpyPerCharDB.PlayerData[name].kos = nil
		end
		if Spy.db.profile.ShareKOSBetweenCharacters then
			SpyDB.removeKOSData[Spy.RealmName][Spy.FactionName][name] = time()
		end
	end
end

function Spy:SetKOSReason(name, reason, other)
	local playerData = SpyPerCharDB.PlayerData[name]
	if playerData then
		if not reason then
			playerData.reason = nil
		else
			if not playerData.reason then playerData.reason = {} end
			if reason == L["KOSReasonOther"] then
				if not other then 
					local dialog = StaticPopup_Show("Spy_SetKOSReasonOther", name)
					if dialog then
						dialog.playerName = name
					end
				else
					if other == "" then
						playerData.reason[L["KOSReasonOther"]] = nil
					else
						playerData.reason[L["KOSReasonOther"]] = other
					end
					Spy:RegenerateKOSCentralList(name)
				end
			else
				if playerData.reason[reason] then
					playerData.reason[reason] = nil
				else
					playerData.reason[reason] = true
				end
				Spy:RegenerateKOSCentralList(name)
			end
		end
	end
end

function Spy:AlertPlayer(player, source)
	local playerData = SpyPerCharDB.PlayerData[player]
	if SpyPerCharDB.KOSData[player] and Spy.db.profile.WarnOnKOS then
--		if Spy.db.profile.DisplayWarningsInErrorsFrame then
		if Spy.db.profile.DisplayWarnings == "ErrorFrame" then
			local text = Spy.db.profile.Colors.Warning["Warning Text"]
			local msg = L["KOSWarning"]..player
			UIErrorsFrame:AddMessage(msg, text.r, text.g, text.b, 1.0, UIERRORS_HOLD_TIME)
		else
			if source ~= nil and source ~= Spy.CharacterName then
				Spy:ShowAlert("kosaway", player, source, Spy:GetPlayerLocation(playerData))
			else
				local reasonText = ""
				if playerData.reason then
					for reason in pairs(playerData.reason) do
						if reasonText ~= "" then reasonText = reasonText..", " end
						if reason == L["KOSReasonOther"] then
							reasonText = reasonText..playerData.reason[reason]
						else
							reasonText = reasonText..reason
						end
					end
				end
				Spy:ShowAlert("kos", player, nil, reasonText)
			end
		end
		if Spy.db.profile.EnableSound then
			if source ~= nil and source ~= Spy.CharacterName then
				PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-kosaway.mp3", Spy.db.profile.SoundChannel)
			else
				PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-kos.mp3", Spy.db.profile.SoundChannel)
			end
		end
		if Spy.db.profile.ShareKOSBetweenCharacters then Spy:RegenerateKOSCentralList(player) end
	elseif Spy.db.profile.WarnOnKOSGuild then
		if playerData and playerData.guild and Spy.KOSGuild[playerData.guild] then
--			if Spy.db.profile.DisplayWarningsInErrorsFrame then
			if Spy.db.profile.DisplayWarnings == "ErrorFrame" then
				local text = Spy.db.profile.Colors.Warning["Warning Text"]
				local msg = L["KOSGuildWarning"].."<"..playerData.guild..">"
				UIErrorsFrame:AddMessage(msg, text.r, text.g, text.b, 1.0, UIERRORS_HOLD_TIME)				
			else
				if source ~= nil and source ~= Spy.CharacterName then
					Spy:ShowAlert("kosguildaway", "<"..playerData.guild..">", source, Spy:GetPlayerLocation(playerData))
				else
					Spy:ShowAlert("kosguild", "<"..playerData.guild..">")
				end
			end
			if Spy.db.profile.EnableSound then
				if source ~= nil and source ~= Spy.CharacterName then
					PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-kosaway.mp3", Spy.db.profile.SoundChannel)
				else
					PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-kosguild.mp3", Spy.db.profile.SoundChannel)
				end
			end
		else
			if Spy.db.profile.EnableSound and not Spy.db.profile.OnlySoundKoS then 
				if source == nil or source == Spy.CharacterName then
					if playerData and Spy.db.profile.WarnOnRace and playerData.race == Spy.db.profile.SelectWarnRace then --++
						PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-race.mp3", Spy.db.profile.SoundChannel) 
					else
						PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-nearby.mp3", Spy.db.profile.SoundChannel)
					end
				end
			end
		end 
	elseif Spy.db.profile.EnableSound and not Spy.db.profile.OnlySoundKoS then 
		if source == nil or source == Spy.CharacterName then
			if playerData and Spy.db.profile.WarnOnRace and playerData.race == Spy.db.profile.SelectWarnRace then
				PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-race.mp3", Spy.db.profile.SoundChannel) 
			else
				PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-nearby.mp3", Spy.db.profile.SoundChannel)
			end
		end
	elseif Spy.db.profile.EnableSound and not Spy.db.profile.OnlySoundKoS then
		if source == nil or source == Spy.CharacterName then
			PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-nearby.mp3", Spy.db.profile.SoundChannel)
		end
	end
end

function Spy:AlertStealthPlayer(player)
	if Spy.db.profile.WarnOnStealth then
--		if Spy.db.profile.DisplayWarningsInErrorsFrame then
		if Spy.db.profile.DisplayWarnings == "ErrorFrame" then
			local text = Spy.db.profile.Colors.Warning["Warning Text"]
			local msg = L["StealthWarning"]..player
			UIErrorsFrame:AddMessage(msg, text.r, text.g, text.b, 1.0, UIERRORS_HOLD_TIME)
		else
			Spy:ShowAlert("stealth", player)
		end
		if Spy.db.profile.EnableSound then
			PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-stealth.mp3", Spy.db.profile.SoundChannel)
		end
	end
end

function Spy:AlertProwlPlayer(player)
	if Spy.db.profile.WarnOnStealth then
--		if Spy.db.profile.DisplayWarningsInErrorsFrame then
		if Spy.db.profile.DisplayWarnings == "ErrorFrame" then
			local text = Spy.db.profile.Colors.Warning["Warning Text"]
			local msg = L["StealthWarning"]..player
			UIErrorsFrame:AddMessage(msg, text.r, text.g, text.b, 1.0, UIERRORS_HOLD_TIME)
		else
			Spy:ShowAlert("prowl", player)
		end
		if Spy.db.profile.EnableSound then
			PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\detected-stealth.mp3", Spy.db.profile.SoundChannel)
		end
	end
end

function Spy:AnnouncePlayer(player, channel)
	if not Spy_IgnoreList[player] then
		local msg = ""
		local isKOS = SpyPerCharDB.KOSData[player]
		local playerData = SpyPerCharDB.PlayerData[player]

		local announce = Spy.db.profile.Announce  
		if channel or announce == "Self" or announce == "LocalDefense" or (announce == "Guild" and GetGuildInfo("player") ~= nil and not Spy.InInstance) or (announce == "Party" and GetNumGroupMembers() > 0) or (announce == "Raid" and UnitInRaid("player")) then --++
			if announce == "Self" and not channel then
				if isKOS then
					msg = msg..L["SpySignatureColored"]..L["KillOnSightDetectedColored"]..player.." "
				else
					msg = msg..L["SpySignatureColored"]..L["PlayerDetectedColored"]..player.." "
				end
			else
				if isKOS then
					msg = msg..L["KillOnSightDetected"]..player.." "
				else
					msg = msg..L["PlayerDetected"]..player.." "
				end
			end
			if playerData then
				if playerData.guild and playerData.guild ~= "" then
					msg = msg.."<"..playerData.guild.."> "
				end
				if playerData.level or playerData.race or (playerData.class and playerData.class ~= "") then
					msg = msg.."- "
					if playerData.level and playerData.isGuess == false then
						msg = msg..L["Level"].." "..playerData.level.." "
					end
					if playerData.race and playerData.race ~= "" then
						msg = msg..playerData.race.." "
					end
					if playerData.class and playerData.class ~= "" then
						msg = msg..L[playerData.class].." "
					end
				end
				if playerData.zone then
					if playerData.subZone and playerData.subZone ~= "" and playerData.subZone ~= playerData.zone then
						msg = msg.."- "..playerData.subZone..", "..playerData.zone
					else
						msg = msg.."- "..playerData.zone
					end
				end
				if playerData.mapX and playerData.mapY then
					msg = msg.." ("..math.floor(tonumber(playerData.mapX) * 100)..","..math.floor(tonumber(playerData.mapY) * 100)..")"
				end
			end

			if channel then
				-- announce to selected channel
				if (channel == "PARTY" and GetNumGroupMembers() > 0) or (channel == "RAID" and UnitInRaid("player")) or (channel == "GUILD" and GetGuildInfo("player") ~= nil) then
					SendChatMessage(msg, channel)
				elseif channel == "LOCAL" then
					SendChatMessage(msg, "CHANNEL", nil, GetChannelName(L["LocalDefenseChannelName"].." - "..GetZoneText()))
				end
			else
				-- announce to standard channel
				if isKOS or not Spy.db.profile.OnlyAnnounceKoS then
					if announce == "Self" then
						DEFAULT_CHAT_FRAME:AddMessage(msg)
					elseif announce == "LocalDefense" then
						SendChatMessage(msg, "CHANNEL", nil, GetChannelName(L["LocalDefenseChannelName"].." - "..GetZoneText()))
					else
						SendChatMessage(msg, strupper(announce))
					end
				end
			end
		end

		-- announce to other Spy users
		if Spy.db.profile.ShareData then
			local class, level, race, zone, subZone, mapX, mapY, guild, mapID = "", "", "", "", "", "", "", "", ""
			if playerData then
				if playerData.class then class = playerData.class end
				if playerData.level and playerData.isGuess == false then level = playerData.level end
				if playerData.race then race = playerData.race end
				if playerData.zone then zone = playerData.zone end
				if playerData.mapID then mapID = playerData.mapID end
				if playerData.subZone then subZone = playerData.subZone end
				if playerData.mapX then mapX = playerData.mapX end
				if playerData.mapY then mapY = playerData.mapY end
				if playerData.guild then guild = playerData.guild end
			end
			local details = Spy.Version.."|"..player.."|"..class.."|"..level.."|"..race.."|"..zone.."|"..subZone.."|"..mapX.."|"..mapY.."|"..guild.."|"..mapID
			if strlen(details) < 240 then
				if channel then
					if (channel == "PARTY" and GetNumGroupMembers() > 0) or (channel == "RAID" and UnitInRaid("player")) or (channel == "GUILD" and GetGuildInfo("player") ~= nil) then
						Spy:SendCommMessage(Spy.Signature, details, channel)
					end
				else
					if GetNumGroupMembers() > 0 then
						Spy:SendCommMessage(Spy.Signature, details, "PARTY")
					end
					if UnitInRaid("player") then
						Spy:SendCommMessage(Spy.Signature, details, "RAID")
					end
					if Spy.InInstance == false and GetGuildInfo("player") ~= nil then
						Spy:SendCommMessage(Spy.Signature, details, "GUILD")
					end
				end
			end
		end
	end	
end

function Spy:SendKoStoGuild(player)
	local playerData = SpyPerCharDB.PlayerData[player]
	local class, level, race, zone, subZone, mapX, mapY, guild, mapID = "", "", "", "", "", "", "", "", ""	 			
	if playerData then
		if playerData.class then class = playerData.class end
		if playerData.level and playerData.isGuess == false then level = playerData.level end
		if playerData.race then race = playerData.race end
		if playerData.zone then zone = playerData.zone end
		if playerData.mapID then mapID = playerData.mapID end
		if playerData.subZone then subZone = playerData.subZone end
		if playerData.mapX then mapX = playerData.mapX end
		if playerData.mapY then mapY = playerData.mapY end
		if playerData.guild then guild = playerData.guild end
	end
	local details = Spy.Version.."|"..player.."|"..class.."|"..level.."|"..race.."|"..zone.."|"..subZone.."|"..mapX.."|"..mapY.."|"..guild.."|"..mapID
	if strlen(details) < 240 then
		if Spy.InInstance == false and GetGuildInfo("player") ~= nil then
			Spy:SendCommMessage(Spy.Signature, details, "GUILD")
		end
	end
end

function Spy:ToggleIgnorePlayer(ignore, player)
	if ignore then
		Spy:AddIgnoreData(player)
		Spy:RemoveKOSData(player)
		if Spy.db.profile.EnableSound then
			PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\list-add.mp3", Spy.db.profile.SoundChannel)
		end
		DEFAULT_CHAT_FRAME:AddMessage(L["SpySignatureColored"]..L["PlayerAddedToIgnoreColored"]..player)
	else
		Spy:RemoveIgnoreData(player)
		if Spy.db.profile.EnableSound then
			PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\list-remove.mp3", Spy.db.profile.SoundChannel)
		end
		DEFAULT_CHAT_FRAME:AddMessage(L["SpySignatureColored"]..L["PlayerRemovedFromIgnoreColored"]..player)
	end
	Spy:RegenerateKOSGuildList()
	if Spy.db.profile.ShareKOSBetweenCharacters then
		Spy:RegenerateKOSCentralList()
	end
	Spy:RefreshCurrentList()
end

function Spy:ToggleKOSPlayer(kos, player)
	if kos then
		Spy:AddKOSData(player)
		Spy:RemoveIgnoreData(player)
		if player ~= SpyPerCharDB.PlayerData[name] then
--			Spy:UpdatePlayerData(player, nil, nil, nil, nil, true, nil)
			Spy:UpdatePlayerStatus(player, nil, nil, nil, nil, true, nil)
			SpyPerCharDB.PlayerData[player].kos = 1
		end	
		if Spy.db.profile.EnableSound then
			PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\list-add.mp3", Spy.db.profile.SoundChannel)
		end
		DEFAULT_CHAT_FRAME:AddMessage(L["SpySignatureColored"]..L["PlayerAddedToKOSColored"]..player)
	else
		Spy:RemoveKOSData(player)
		if Spy.db.profile.EnableSound then
			PlaySoundFile("Interface\\AddOns\\Spy\\Sounds\\list-remove.mp3", Spy.db.profile.SoundChannel)
		end
		DEFAULT_CHAT_FRAME:AddMessage(L["SpySignatureColored"]..L["PlayerRemovedFromKOSColored"]..player)
	end
	Spy:RegenerateKOSGuildList()
	if Spy.db.profile.ShareKOSBetweenCharacters then
		Spy:RegenerateKOSCentralList()
	end
	Spy:RefreshCurrentList()
end

function Spy:PurgeUndetectedData()
	local secondsPerDay = 60 * 60 * 24
	local timeout = 90 * secondsPerDay
	if Spy.db.profile.PurgeData == "OneDay" then
		timeout = secondsPerDay
	elseif Spy.db.profile.PurgeData == "FiveDays" then
		timeout = 5 * secondsPerDay
	elseif Spy.db.profile.PurgeData == "TenDays" then
		timeout = 10 * secondsPerDay
	elseif Spy.db.profile.PurgeData == "ThirtyDays" then
		timeout = 30 * secondsPerDay
	elseif Spy.db.profile.PurgeData == "SixtyDays" then
		timeout = 60 * secondsPerDay
	elseif Spy.db.profile.PurgeData == "NinetyDays" then
		timeout = 90 * secondsPerDay
	end

	-- remove expired players held in character data
	local currentTime = time()
	for player in pairs(SpyPerCharDB.PlayerData) do
		local playerData = SpyPerCharDB.PlayerData[player]
		if Spy.db.profile.PurgeWinLossData then
			if not playerData.time or (currentTime - playerData.time) > timeout or not playerData.isEnemy then
				Spy:RemoveIgnoreData(player)
				Spy:RemoveKOSData(player)
				SpyPerCharDB.PlayerData[player] = nil
			end
		else
			if ((playerData.loses == nil) and (playerData.wins == nil)) then
				if not playerData.time or (currentTime - playerData.time) > timeout or not playerData.isEnemy then
					Spy:RemoveIgnoreData(player)
					if Spy.db.profile.PurgeKoS then
						Spy:RemoveKOSData(player)
						SpyPerCharDB.PlayerData[player] = nil
					else
						if (playerData.kos == nil) then
							SpyPerCharDB.PlayerData[player] = nil
						end	
					end	
				end
			end
		end
	end
	
	-- remove expired kos players held in central data
	local kosData = SpyDB.kosData[Spy.RealmName][Spy.FactionName]
	for characterName in pairs(kosData) do
		local characterKosData = kosData[characterName]
		for player in pairs(characterKosData) do
			local kosPlayerData = characterKosData[player]
			if Spy.db.profile.PurgeKoS then
				if not kosPlayerData.time or (currentTime - kosPlayerData.time) > timeout or not kosPlayerData.isEnemy then
					SpyDB.kosData[Spy.RealmName][Spy.FactionName][characterName][player] = nil
					SpyDB.removeKOSData[Spy.RealmName][Spy.FactionName][player] = nil
				end
			end
		end
	end
	if not Spy.db.profile.AppendUnitNameCheck then 	
		Spy:AppendUnitNames() end
	if not Spy.db.profile.AppendUnitKoSCheck then
		Spy:AppendUnitKoS() end
end

function Spy:RegenerateKOSGuildList()
	Spy.KOSGuild = {}
	for player in pairs(SpyPerCharDB.KOSData) do
		local playerData = SpyPerCharDB.PlayerData[player]
		if playerData and playerData.guild then
			Spy.KOSGuild[playerData.guild] = true
		end
	end
end

function Spy:RemoveLocalKOSPlayers()
	for player in pairs(SpyPerCharDB.KOSData) do
		if SpyDB.removeKOSData[Spy.RealmName][Spy.FactionName][player] then
			Spy:RemoveKOSData(player)
		end
	end
end

function Spy:RegenerateKOSCentralList(player)
	if player then
		local playerData = SpyPerCharDB.PlayerData[player]
		SpyDB.kosData[Spy.RealmName][Spy.FactionName][Spy.CharacterName][player] = {}
		if playerData then
			SpyDB.kosData[Spy.RealmName][Spy.FactionName][Spy.CharacterName][player] = playerData
		end
		SpyDB.kosData[Spy.RealmName][Spy.FactionName][Spy.CharacterName][player].added = SpyPerCharDB.KOSData[player]
	else
		for player in pairs(SpyPerCharDB.KOSData) do
			local playerData = SpyPerCharDB.PlayerData[player]
			SpyDB.kosData[Spy.RealmName][Spy.FactionName][Spy.CharacterName][player] = {}
			if playerData then
				SpyDB.kosData[Spy.RealmName][Spy.FactionName][Spy.CharacterName][player] = playerData
			end
			SpyDB.kosData[Spy.RealmName][Spy.FactionName][Spy.CharacterName][player].added = SpyPerCharDB.KOSData[player]
		end
	end
end

function Spy:RegenerateKOSListFromCentral()
	local kosData = SpyDB.kosData[Spy.RealmName][Spy.FactionName]
	for characterName in pairs(kosData) do
		if characterName ~= Spy.CharacterName then
			local characterKosData = kosData[characterName]
			for player in pairs(characterKosData) do
				if not SpyDB.removeKOSData[Spy.RealmName][Spy.FactionName][player] then
					local playerData = SpyPerCharDB.PlayerData[player]
					if not playerData then
						playerData = Spy:AddPlayerData(player, class, level, race, guild, isEnemy, isGuess)
					end
					local kosPlayerData = characterKosData[player]
					if kosPlayerData.time and (not playerData.time or (playerData.time and playerData.time < kosPlayerData.time)) then
						playerData.time = kosPlayerData.time
						if kosPlayerData.class then
							playerData.class = kosPlayerData.class
						end
						if type(kosPlayerData.level) == "number" and (type(playerData.level) ~= "number" or playerData.level < kosPlayerData.level) then
							playerData.level = kosPlayerData.level
						end
						if kosPlayerData.race then
							playerData.race = kosPlayerData.race
						end
						if kosPlayerData.guild then
							playerData.guild = kosPlayerData.guild
						end
						if kosPlayerData.isEnemy then
							playerData.isEnemy = kosPlayerData.isEnemy
						end
						if kosPlayerData.isGuess then
							playerData.isGuess = kosPlayerData.isGuess
						end
						if type(kosPlayerData.wins) == "number" and (type(playerData.wins) ~= "number" or playerData.wins < kosPlayerData.wins) then
							playerData.wins = kosPlayerData.wins
						end
						if type(kosPlayerData.loses) == "number" and (type(playerData.loses) ~= "number" or playerData.loses < kosPlayerData.loses) then
							playerData.loses = kosPlayerData.loses
						end
						if kosPlayerData.mapX then
							playerData.mapX = kosPlayerData.mapX
						end
						if kosPlayerData.mapY then
							playerData.mapY = kosPlayerData.mapY
						end
						if kosPlayerData.zone then
							playerData.zone = kosPlayerData.zone
						end
						if kosPlayerData.mapID then
							playerData.mapID = kosPlayerData.mapID
						end
						if kosPlayerData.subZone then
							playerData.subZone = kosPlayerData.subZone
						end
						if kosPlayerData.reason then
							playerData.reason = {}
							for reason in pairs(kosPlayerData.reason) do
								playerData.reason[reason] = kosPlayerData.reason[reason]
							end
						end
					end
					local characterKOSPlayerData = SpyPerCharDB.KOSData[player]
					if kosPlayerData.added and (not characterKOSPlayerData or characterKOSPlayerData < kosPlayerData.added) then
						SpyPerCharDB.KOSData[player] = kosPlayerData.added
					end
				end
			end
		end
	end
end

function Spy:ButtonClicked(self, button)
	local name = Spy.ButtonName[self.id]
	if name and name ~= "" then
		if button == "LeftButton" then
			if IsShiftKeyDown() then
				if SpyPerCharDB.KOSData[name] then
					Spy:ToggleKOSPlayer(false, name)
				else
					Spy:ToggleKOSPlayer(true, name)
				end
			elseif IsControlKeyDown() then
				if SpyPerCharDB.IgnoreData[name] then
					Spy:ToggleIgnorePlayer(false, name)
				else
					Spy:ToggleIgnorePlayer(true, name)
				end
			else
				if not InCombatLockdown() then
					self:SetAttribute("macrotext", "/targetexact "..name)
				end	
			end
		elseif button == "RightButton" then
			Spy:BarDropDownOpen(self)
			CloseDropDownMenus(1)
			ToggleDropDownMenu(1, nil, Spy_BarDropDownMenu)
		end
	end
end

function Spy:ParseMinimapTooltip(tooltip)
	local newTooltip = ""
	local newLine = false
	for text in string.gmatch(tooltip, "[^\n]*") do
		local name = text
		if string.len(text) > 0 then
			if strsub(text, 1, 2) == "|T" then
			name = strtrim(gsub(gsub(text, "|T.-|t", ""), "|r", ""))
			end
			local playerData = SpyPerCharDB.PlayerData[name]
			if not playerData then
				for index, v in pairs(Spy.LastHourList) do
					local realmSeparator = strfind(index, "-")
					if realmSeparator and realmSeparator > 1 and strsub(index, 1, realmSeparator - 1) == strsub(name, 1, realmSeparator - 1) then
						playerData = SpyPerCharDB.PlayerData[index]
						break
					end
				end
			end
			if playerData and playerData.isEnemy then
				local desc = ""
				if playerData.class and playerData.level then
					desc = L["MinimapClassText"..playerData.class].." ["..playerData.level.." "..L[playerData.class].."]|r"
				elseif playerData.class then
					desc = L["MinimapClassText"..playerData.class].." ["..L[playerData.class].."]|r"
				elseif playerData.level then
					desc = " ["..playerData.level.."]|r"
				end
				if (newTooltip and desc == "") then
					newTooltip = text 
				elseif (newTooltip == "") then	
					newTooltip = text.."|r"..desc
				else
					newTooltip = newTooltip.."\r"..text.."|r"..desc
				end	
				if not SpyPerCharDB.IgnoreData[name] and not Spy.InInstance then
					local detected = Spy:UpdatePlayerData(name, nil, nil, nil, nil, true, nil)
					if detected and Spy.db.profile.MinimapDetection then
						Spy:AddDetected(name, time(), false)
					end
				end
			else
				if (newTooltip == "") then
					newTooltip = text
				else	
					newTooltip = newTooltip.."\n"..text
				end
			end
			newLine = false
		elseif not newLine then
			newTooltip = newTooltip
			newLine = true
		end
	end
	return newTooltip
end

function Spy:ParseUnitAbility(analyseSpell, event, player, class, race, spellId, spellName)
	local learnt = false
	if player then
--		local class = nil
		local level = nil
--		local race = nil
		local isEnemy = true
		local isGuess = true

		local playerData = SpyPerCharDB.PlayerData[player]
		if not playerData or playerData.isEnemy == nil then
			learnt = true
		end

		if analyseSpell then
			local abilityType = strsub(event, 1, 5)
			if abilityType == "SWING" or abilityType == "SPELL" or abilityType == "RANGE" then
--				local ability = Spy_AbilityList[spellName]
				local ability = Spy_AbilityList[spellId]
				if ability then
					if class == nil then
						if ability.class and not (playerData and playerData.class) then
							class = ability.class
							learnt = true
						end
					end
					if ability.level then
						local playerLevelNumber = nil
						if playerData and playerData.level then
							playerLevelNumber = tonumber(playerData.level)
						end
						if type(playerLevelNumber) ~= "number" or playerLevelNumber < ability.level then
							level = ability.level
							learnt = true
						end
					end
					if race == nil then
						if ability.race and not (playerData and playerData.race) then
							race = ability.race
							learnt = true
						end
					end	
				else	
--					print(spellId, " - ", spellName)
				end
				if class and race and level == Spy.MaximumPlayerLevel then
					isGuess = false
					learnt = true
				end
			end
		end

		Spy:UpdatePlayerData(player, class, level, race, nil, isEnemy, isGuess)
		return learnt, playerData
	end
	return learnt, nil
end

function Spy:ParseUnitDetails(player, class, level, race, zone, subZone, mapX, mapY, guild, mapID)
	if player then
		local playerData = SpyPerCharDB.PlayerData[player]
		if not playerData then
			playerData = Spy:AddPlayerData(player, class, level, race, guild, true, true)
		else
			if not playerData.class then playerData.class = class end
			if level then
				local levelNumber = tonumber(level)
				if type(levelNumber) == "number" then
					if playerData.level then
						local playerLevelNumber = tonumber(playerData.level)
						if type(playerLevelNumber) == "number" and playerLevelNumber < levelNumber then playerData.level = levelNumber end
					else
						playerData.level = levelNumber
					end
				end
			end
			if not playerData.race then
				playerData.race = race
			end
			if not playerData.guild then
				playerData.guild = guild
			end
		end
		playerData.isEnemy = true
		playerData.time = time()
		playerData.zone = zone
		playerData.mapID = mapID
		playerData.subZone = subZone
		playerData.mapX = mapX
		playerData.mapY = mapY

		return true, playerData
	end
	return true, nil
end

function Spy:AddDetected(player, timestamp, learnt, source)
	if Spy.db.profile.StopAlertsOnTaxi then
		if not UnitOnTaxi("player") then 
			Spy:AddDetectedToLists(player, timestamp, learnt, source)
		end
	else
		Spy:AddDetectedToLists(player, timestamp, learnt, source)
	end
--[[if Spy.db.profile.ShowOnlyPvPFlagged then
		if UnitIsPVP("target") then
			Spy:AddDetectedToLists(player, timestamp, learnt, source)
		end	
	else
		Spy:AddDetectedToLists(player, timestamp, learnt, source)
	end ]]--
end

function Spy:AddDetectedToLists(player, timestamp, learnt, source)
	if not Spy.NearbyList[player] then
		if Spy.db.profile.ShowOnDetection and not Spy.db.profile.MainWindowVis then
			Spy:SetCurrentList(1)
			Spy:EnableSpy(true, true, true)
		end
		if Spy.db.profile.CurrentList ~= 1 and Spy.db.profile.MainWindowVis and Spy.db.profile.ShowNearbyList then
			Spy:SetCurrentList(1)
		end

		if source and source ~= Spy.CharacterName and not Spy.ActiveList[player] then
			Spy.NearbyList[player] = timestamp
			Spy.LastHourList[player] = timestamp
			Spy.InactiveList[player] = timestamp
		else
			Spy.NearbyList[player] = timestamp
			Spy.LastHourList[player] = timestamp
			Spy.ActiveList[player] = timestamp
			Spy.InactiveList[player] = nil
		end

		if Spy.db.profile.CurrentList == 1 then
			Spy:RefreshCurrentList(player, source)
			Spy:UpdateActiveCount()			
		else
			if not source or source ~= Spy.CharacterName then
				Spy:AlertPlayer(player, source)
				if not source then Spy:AnnouncePlayer(player) end
			end
		end
	elseif not Spy.ActiveList[player] then
		if Spy.db.profile.ShowOnDetection and not Spy.db.profile.MainWindowVis then
			Spy:SetCurrentList(1)
			Spy:EnableSpy(true, true, true)
		end
		if Spy.db.profile.CurrentList ~= 1 and Spy.db.profile.MainWindowVis and Spy.db.profile.ShowNearbyList then
			Spy:SetCurrentList(1)
		end

		Spy.LastHourList[player] = timestamp
		Spy.ActiveList[player] = timestamp
		Spy.InactiveList[player] = nil

		if Spy.PlayerCommList[player] ~= nil then
			if Spy.db.profile.CurrentList == 1 then
				Spy:RefreshCurrentList(player, source)
			else
				if not source or source ~= Spy.CharacterName then
					Spy:AlertPlayer(player, source)
					if not source then Spy:AnnouncePlayer(player) end
				end
			end
		else
			if Spy.db.profile.CurrentList == 1 then
				Spy:RefreshCurrentList()
				Spy:UpdateActiveCount()
			end
		end
	else
		Spy.ActiveList[player] = timestamp
		Spy.LastHourList[player] = timestamp
		if learnt and Spy.db.profile.CurrentList == 1 then
			Spy:RefreshCurrentList()
			Spy:UpdateActiveCount()
		end
	end
end

function Spy:AppendUnitNames()
	for key, unit in pairs(SpyPerCharDB.PlayerData) do	
		-- find any units without a name
		if not unit.name then
			local name = key
		-- if unit.name does not exist update info
			if (not unit.name) and name then
				unit.name = key
			end
		end
    end
	-- set profile so it only runs once
	Spy.db.profile.AppendUnitNameCheck=true
end

function Spy:AppendUnitKoS()
	for kosName, value in pairs(SpyPerCharDB.KOSData) do
		if kosName then	
			local playerData = SpyPerCharDB.PlayerData[kosName]
			if not playerData then 
				Spy:UpdatePlayerData(kosName, nil, nil, nil, nil, true, nil) 
				SpyPerCharDB.PlayerData[kosName].kos = 1
				SpyPerCharDB.PlayerData[kosName].time = value
			end
		end
    end
	-- set profile so it only runs once
	Spy.db.profile.AppendUnitKoSCheck=true
end

Spy.ListTypes = {
	{L["Nearby"], Spy.ManageNearbyList, Spy.ManageNearbyListExpirations},
	{L["LastHour"], Spy.ManageLastHourList, Spy.ManageLastHourListExpirations},
	{L["Ignore"], Spy.ManageIgnoreList},
	{L["KillOnSight"], Spy.ManageKillOnSightList},
}

Spy_AbilityList = {
--++ Racial Traits ++	
	[822]={ race = "Blood Elf", level = 1, },
	[2481]={ race = "Dwarf", level = 1, },
	[5227]={ race = "Undead", level = 1, },
	[6562]={ race = "Draenei", level = 1, },
	[7744]={ race = "Undead", level = 1, },
	[20549]={ race = "Tauren", level = 1, },
	[20550]={ race = "Tauren", level = 1, },
	[20551]={ race = "Tauren", level = 1, },
	[20552]={ race = "Tauren", level = 1, },
	[20555]={ race = "Troll", level = 1, },
	[20557]={ race = "Troll", level = 1, },
	[20558]={ race = "Troll", level = 1, },
	[20572]={ race = "Orc", level = 1, },
	[20573]={ race = "Orc", level = 1, },
	[20574]={ race = "Orc", level = 1, },
	[20575]={ race = "Orc", level = 1, },
	[20577]={ race = "Undead", level = 1, },
	[20579]={ race = "Undead", level = 1, },
	[20582]={ race = "Night Elf", level = 1, },
	[20583]={ race = "Night Elf", level = 1, },
	[20585]={ race = "Night Elf", level = 1, },
	[20589]={ race = "Gnome", level = 1, },
	[20591]={ race = "Gnome", level = 1, },
	[20592]={ race = "Gnome", level = 1, },
	[20593]={ race = "Gnome", level = 1, },
	[20594]={ race = "Dwarf", level = 1, },
	[20595]={ race = "Dwarf", level = 1, },
	[20596]={ race = "Dwarf", level = 1, },
	[20597]={ race = "Human", level = 1, },
	[20598]={ race = "Human", level = 1, },
	[20599]={ race = "Human", level = 1, },
	[20864]={ race = "Human", level = 1, },
	[21009]={ race = "Night Elf", level = 1, },
	[25046]={ race = "Blood Elf", level = 1, },
	[26290]={ race = "Troll", level = 1, },
	[26297]={ race = "Troll", level = 1, },
	[28730]={ race = "Blood Elf", level = 1, },
	[28875]={ race = "Draenei", level = 1, },
	[28877]={ race = "Blood Elf", level = 1, },
	[28878]={ race = "Draenei", level = 1, },
	[28880]={ race = "Draenei", level = 1, },
	[33697]={ race = "Orc", level = 1, },
	[33702]={ race = "Orc", level = 1, },
	[50613]={ race = "Blood Elf", level = 1, },
	[54562]={ race = "Orc", level = 1, },
	[58943]={ race = "Troll", level = 1, },
	[58984]={ race = "Night Elf", level = 1, },
	[58985]={ race = "Human", level = 1, },
	[59221]={ race = "Draenei", level = 1, },
	[59224]={ race = "Dwarf", level = 1, },
	[59535]={ race = "Draenei", level = 1, },
	[59536]={ race = "Draenei", level = 1, },
	[59538]={ race = "Draenei", level = 1, },
	[59539]={ race = "Draenei", level = 1, },
	[59540]={ race = "Draenei", level = 1, },
	[59541]={ race = "Draenei", level = 1, },
	[59542]={ race = "Draenei", level = 1, },
	[59543]={ race = "Draenei", level = 1, },
	[59544]={ race = "Draenei", level = 1, },
	[59545]={ race = "Draenei", level = 1, },
	[59547]={ race = "Draenei", level = 1, },
	[59548]={ race = "Draenei", level = 1, },
	[59752]={ race = "Human", level = 1, },
	[65222]={ race = "Orc", level = 1, },
--++ Death Knight Abilities ++	
	[59921]={ class = "DEATHKNIGHT", level = 55, },
	[59879]={ class = "DEATHKNIGHT", level = 55, },
	[53341]={ class = "DEATHKNIGHT", level = 55, },
	[49142]={ class = "DEATHKNIGHT", level = 55, },
	[53343]={ class = "DEATHKNIGHT", level = 55, },
	[53331]={ class = "DEATHKNIGHT", level = 60, },
	[54447]={ class = "DEATHKNIGHT", level = 57, },
	[53342]={ class = "DEATHKNIGHT", level = 57, },
	[54446]={ class = "DEATHKNIGHT", level = 63, },
	[53323]={ class = "DEATHKNIGHT", level = 63, },
	[53344]={ class = "DEATHKNIGHT", level = 70, },
	[70164]={ class = "DEATHKNIGHT", level = 72, },
	[62158]={ class = "DEATHKNIGHT", level = 72, },
	[48778]={ class = "DEATHKNIGHT", level = 55, },
	[48266]={ class = "DEATHKNIGHT", level = 55, },
	[45902]={ class = "DEATHKNIGHT", level = 55, },
	[47541]={ class = "DEATHKNIGHT", level = 55, },
	[62900]={ class = "DEATHKNIGHT", level = 55, },
	[49576]={ class = "DEATHKNIGHT", level = 55, },
	[45477]={ class = "DEATHKNIGHT", level = 55, },
	[45462]={ class = "DEATHKNIGHT", level = 55, },
	[53428]={ class = "DEATHKNIGHT", level = 55, },
	[49998]={ class = "DEATHKNIGHT", level = 56, },
	[50842]={ class = "DEATHKNIGHT", level = 56, },
	[46584]={ class = "DEATHKNIGHT", level = 56, },
	[48263]={ class = "DEATHKNIGHT", level = 57, },
	[47528]={ class = "DEATHKNIGHT", level = 57, },
	[48721]={ class = "DEATHKNIGHT", level = 58, },
	[45524]={ class = "DEATHKNIGHT", level = 58, },
	[49926]={ class = "DEATHKNIGHT", level = 59, },
	[55258]={ class = "DEATHKNIGHT", level = 59, },
	[47476]={ class = "DEATHKNIGHT", level = 59, },
	[51325]={ class = "DEATHKNIGHT", level = 60, },
	[43265]={ class = "DEATHKNIGHT", level = 60, },
	[51416]={ class = "DEATHKNIGHT", level = 60, },
	[49917]={ class = "DEATHKNIGHT", level = 60, },
	[49896]={ class = "DEATHKNIGHT", level = 61, },
	[49020]={ class = "DEATHKNIGHT", level = 61, },
	[66198]={ class = "DEATHKNIGHT", level = 61, },
	[61081]={ class = "DEATHKNIGHT", level = 61, },
	[49892]={ class = "DEATHKNIGHT", level = 62, },
	[62901]={ class = "DEATHKNIGHT", level = 62, },
	[48792]={ class = "DEATHKNIGHT", level = 62, },
	[49999]={ class = "DEATHKNIGHT", level = 63, },
	[49927]={ class = "DEATHKNIGHT", level = 64, },
	[45529]={ class = "DEATHKNIGHT", level = 64, },
	[55259]={ class = "DEATHKNIGHT", level = 64, },
	[56222]={ class = "DEATHKNIGHT", level = 65, },
	[51417]={ class = "DEATHKNIGHT", level = 65, },
	[49918]={ class = "DEATHKNIGHT", level = 65, },
	[49939]={ class = "DEATHKNIGHT", level = 66, },
	[48743]={ class = "DEATHKNIGHT", level = 66, },
	[49936]={ class = "DEATHKNIGHT", level = 67, },
	[49903]={ class = "DEATHKNIGHT", level = 67, },
	[51423]={ class = "DEATHKNIGHT", level = 67, },
	[56815]={ class = "DEATHKNIGHT", level = 67, },
	[55265]={ class = "DEATHKNIGHT", level = 67, },
	[48707]={ class = "DEATHKNIGHT", level = 68, },
	[49893]={ class = "DEATHKNIGHT", level = 68, },
	[62902]={ class = "DEATHKNIGHT", level = 68, },
	[49928]={ class = "DEATHKNIGHT", level = 69, },
	[55260]={ class = "DEATHKNIGHT", level = 69, },
	[51326]={ class = "DEATHKNIGHT", level = 70, },
	[45463]={ class = "DEATHKNIGHT", level = 70, },
	[51418]={ class = "DEATHKNIGHT", level = 70, },
	[51409]={ class = "DEATHKNIGHT", level = 70, },
	[49919]={ class = "DEATHKNIGHT", level = 70, },
	[48265]={ class = "DEATHKNIGHT", level = 70, },
	[49940]={ class = "DEATHKNIGHT", level = 72, },
	[61999]={ class = "DEATHKNIGHT", level = 72, },
	[49937]={ class = "DEATHKNIGHT", level = 73, },
	[49904]={ class = "DEATHKNIGHT", level = 73, },
	[51424]={ class = "DEATHKNIGHT", level = 73, },
	[55270]={ class = "DEATHKNIGHT", level = 73, },
	[49929]={ class = "DEATHKNIGHT", level = 74, },
	[55261]={ class = "DEATHKNIGHT", level = 74, },
	[51327]={ class = "DEATHKNIGHT", level = 75, },
	[49923]={ class = "DEATHKNIGHT", level = 75, },
	[47568]={ class = "DEATHKNIGHT", level = 75, },
	[51419]={ class = "DEATHKNIGHT", level = 75, },
	[51410]={ class = "DEATHKNIGHT", level = 75, },
	[49920]={ class = "DEATHKNIGHT", level = 75, },
	[49894]={ class = "DEATHKNIGHT", level = 76, },
	[62903]={ class = "DEATHKNIGHT", level = 76, },
	[49941]={ class = "DEATHKNIGHT", level = 78, },
	[49909]={ class = "DEATHKNIGHT", level = 78, },
	[51425]={ class = "DEATHKNIGHT", level = 79, },
	[55271]={ class = "DEATHKNIGHT", level = 79, },
	[42650]={ class = "DEATHKNIGHT", level = 80, },
	[49930]={ class = "DEATHKNIGHT", level = 80, },
	[51328]={ class = "DEATHKNIGHT", level = 80, },
	[49938]={ class = "DEATHKNIGHT", level = 80, },
	[49895]={ class = "DEATHKNIGHT", level = 80, },
	[62904]={ class = "DEATHKNIGHT", level = 80, },
	[49924]={ class = "DEATHKNIGHT", level = 80, },
	[55268]={ class = "DEATHKNIGHT", level = 80, },
	[55262]={ class = "DEATHKNIGHT", level = 80, },
	[51411]={ class = "DEATHKNIGHT", level = 80, },
	[49921]={ class = "DEATHKNIGHT", level = 80, },
--++ Death Knight Talents ++	
	[49200]={ class = "DEATHKNIGHT", level = 55, },
	[50151]={ class = "DEATHKNIGHT", level = 55, },
	[50152]={ class = "DEATHKNIGHT", level = 55, },
	[51468]={ class = "DEATHKNIGHT", level = 55, },
	[51472]={ class = "DEATHKNIGHT", level = 55, },
	[51473]={ class = "DEATHKNIGHT", level = 55, },
	[55129]={ class = "DEATHKNIGHT", level = 55, },
	[55130]={ class = "DEATHKNIGHT", level = 55, },
	[55131]={ class = "DEATHKNIGHT", level = 55, },
	[55132]={ class = "DEATHKNIGHT", level = 55, },
	[55133]={ class = "DEATHKNIGHT", level = 55, },
	[49140]={ class = "DEATHKNIGHT", level = 55, },
	[49661]={ class = "DEATHKNIGHT", level = 55, },
	[49662]={ class = "DEATHKNIGHT", level = 55, },
	[49663]={ class = "DEATHKNIGHT", level = 55, },
	[49664]={ class = "DEATHKNIGHT", level = 55, },
	[49182]={ class = "DEATHKNIGHT", level = 55, },
	[49500]={ class = "DEATHKNIGHT", level = 55, },
	[49501]={ class = "DEATHKNIGHT", level = 55, },
	[55225]={ class = "DEATHKNIGHT", level = 55, },
	[55226]={ class = "DEATHKNIGHT", level = 55, },
	[48978]={ class = "DEATHKNIGHT", level = 55, },
	[49390]={ class = "DEATHKNIGHT", level = 55, },
	[49391]={ class = "DEATHKNIGHT", level = 55, },
	[49392]={ class = "DEATHKNIGHT", level = 55, },
	[49393]={ class = "DEATHKNIGHT", level = 55, },
	[61154]={ class = "DEATHKNIGHT", level = 55, },
	[54639]={ class = "DEATHKNIGHT", level = 55, },
	[54638]={ class = "DEATHKNIGHT", level = 55, },
	[54637]={ class = "DEATHKNIGHT", level = 55, },
	[49219]={ class = "DEATHKNIGHT", level = 55, },
	[49627]={ class = "DEATHKNIGHT", level = 55, },
	[49628]={ class = "DEATHKNIGHT", level = 55, },
	[49027]={ class = "DEATHKNIGHT", level = 55, },
	[49542]={ class = "DEATHKNIGHT", level = 55, },
	[49543]={ class = "DEATHKNIGHT", level = 55, },
	[48977]={ class = "DEATHKNIGHT", level = 55, },
	[49394]={ class = "DEATHKNIGHT", level = 55, },
	[49395]={ class = "DEATHKNIGHT", level = 55, },
	[48988]={ class = "DEATHKNIGHT", level = 55, },
	[49503]={ class = "DEATHKNIGHT", level = 55, },
	[49504]={ class = "DEATHKNIGHT", level = 55, },
	[49222]={ class = "DEATHKNIGHT", level = 55, },
	[48979]={ class = "DEATHKNIGHT", level = 55, },
	[49483]={ class = "DEATHKNIGHT", level = 55, },
	[50040]={ class = "DEATHKNIGHT", level = 55, },
	[50041]={ class = "DEATHKNIGHT", level = 55, },
	[50043]={ class = "DEATHKNIGHT", level = 55, },
	[49149]={ class = "DEATHKNIGHT", level = 55, },
	[50115]={ class = "DEATHKNIGHT", level = 55, },
	[49158]={ class = "DEATHKNIGHT", level = 55, },
	[49032]={ class = "DEATHKNIGHT", level = 55, },
	[49631]={ class = "DEATHKNIGHT", level = 55, },
	[49632]={ class = "DEATHKNIGHT", level = 55, },
	[48987]={ class = "DEATHKNIGHT", level = 55, },
	[49477]={ class = "DEATHKNIGHT", level = 55, },
	[49478]={ class = "DEATHKNIGHT", level = 55, },
	[49479]={ class = "DEATHKNIGHT", level = 55, },
	[49480]={ class = "DEATHKNIGHT", level = 55, },
	[49467]={ class = "DEATHKNIGHT", level = 55, },
	[50033]={ class = "DEATHKNIGHT", level = 55, },
	[50034]={ class = "DEATHKNIGHT", level = 55, },
	[49796]={ class = "DEATHKNIGHT", level = 55, },
	[55666]={ class = "DEATHKNIGHT", level = 55, },
	[55667]={ class = "DEATHKNIGHT", level = 55, },
	[66799]={ class = "DEATHKNIGHT", level = 55, },
	[66814]={ class = "DEATHKNIGHT", level = 55, },
	[66815]={ class = "DEATHKNIGHT", level = 55, },
	[66816]={ class = "DEATHKNIGHT", level = 55, },
	[66817]={ class = "DEATHKNIGHT", level = 55, },
	[49223]={ class = "DEATHKNIGHT", level = 55, },
	[49599]={ class = "DEATHKNIGHT", level = 55, },
	[51099]={ class = "DEATHKNIGHT", level = 55, },
	[51160]={ class = "DEATHKNIGHT", level = 55, },
	[51161]={ class = "DEATHKNIGHT", level = 55, },
	[49137]={ class = "DEATHKNIGHT", level = 55, },
	[49657]={ class = "DEATHKNIGHT", level = 55, },
	[49036]={ class = "DEATHKNIGHT", level = 55, },
	[49562]={ class = "DEATHKNIGHT", level = 55, },
	[49186]={ class = "DEATHKNIGHT", level = 55, },
	[51108]={ class = "DEATHKNIGHT", level = 55, },
	[51109]={ class = "DEATHKNIGHT", level = 55, },
	[49143]={ class = "DEATHKNIGHT", level = 55, },
	[63560]={ class = "DEATHKNIGHT", level = 55, },
	[49471]={ class = "DEATHKNIGHT", level = 55, },
	[49790]={ class = "DEATHKNIGHT", level = 55, },
	[49791]={ class = "DEATHKNIGHT", level = 55, },
	[50187]={ class = "DEATHKNIGHT", level = 55, },
	[50190]={ class = "DEATHKNIGHT", level = 55, },
	[50191]={ class = "DEATHKNIGHT", level = 55, },
	[55050]={ class = "DEATHKNIGHT", level = 55, },
	[49203]={ class = "DEATHKNIGHT", level = 55, },
	[55061]={ class = "DEATHKNIGHT", level = 55, },
	[55062]={ class = "DEATHKNIGHT", level = 55, },
	[50880]={ class = "DEATHKNIGHT", level = 55, },
	[50884]={ class = "DEATHKNIGHT", level = 55, },
	[50885]={ class = "DEATHKNIGHT", level = 55, },
	[50886]={ class = "DEATHKNIGHT", level = 55, },
	[50887]={ class = "DEATHKNIGHT", level = 55, },
	[50365]={ class = "DEATHKNIGHT", level = 55, },
	[50371]={ class = "DEATHKNIGHT", level = 55, },
	[62905]={ class = "DEATHKNIGHT", level = 55, },
	[62908]={ class = "DEATHKNIGHT", level = 55, },
	[50384]={ class = "DEATHKNIGHT", level = 55, },
	[50385]={ class = "DEATHKNIGHT", level = 55, },
	[55610]={ class = "DEATHKNIGHT", level = 55, },
	[49175]={ class = "DEATHKNIGHT", level = 55, },
	[50031]={ class = "DEATHKNIGHT", level = 55, },
	[51456]={ class = "DEATHKNIGHT", level = 55, },
	[48985]={ class = "DEATHKNIGHT", level = 55, },
	[49488]={ class = "DEATHKNIGHT", level = 55, },
	[49489]={ class = "DEATHKNIGHT", level = 55, },
	[50391]={ class = "DEATHKNIGHT", level = 55, },
	[50392]={ class = "DEATHKNIGHT", level = 55, },
	[49220]={ class = "DEATHKNIGHT", level = 55, },
	[49633]={ class = "DEATHKNIGHT", level = 55, },
	[49635]={ class = "DEATHKNIGHT", level = 55, },
	[49636]={ class = "DEATHKNIGHT", level = 55, },
	[49638]={ class = "DEATHKNIGHT", level = 55, },
	[51123]={ class = "DEATHKNIGHT", level = 55, },
	[51127]={ class = "DEATHKNIGHT", level = 55, },
	[51128]={ class = "DEATHKNIGHT", level = 55, },
	[51129]={ class = "DEATHKNIGHT", level = 55, },
	[51130]={ class = "DEATHKNIGHT", level = 55, },
	[49039]={ class = "DEATHKNIGHT", level = 55, },
	[49224]={ class = "DEATHKNIGHT", level = 55, },
	[49610]={ class = "DEATHKNIGHT", level = 55, },
	[49611]={ class = "DEATHKNIGHT", level = 55, },
	[49005]={ class = "DEATHKNIGHT", level = 55, },
	[52143]={ class = "DEATHKNIGHT", level = 55, },
	[49024]={ class = "DEATHKNIGHT", level = 55, },
	[49538]={ class = "DEATHKNIGHT", level = 55, },
	[49023]={ class = "DEATHKNIGHT", level = 55, },
	[49533]={ class = "DEATHKNIGHT", level = 55, },
	[49534]={ class = "DEATHKNIGHT", level = 55, },
	[48963]={ class = "DEATHKNIGHT", level = 55, },
	[49564]={ class = "DEATHKNIGHT", level = 55, },
	[49565]={ class = "DEATHKNIGHT", level = 55, },
	[51459]={ class = "DEATHKNIGHT", level = 55, },
	[51462]={ class = "DEATHKNIGHT", level = 55, },
	[51463]={ class = "DEATHKNIGHT", level = 55, },
	[51464]={ class = "DEATHKNIGHT", level = 55, },
	[51465]={ class = "DEATHKNIGHT", level = 55, },
	[49226]={ class = "DEATHKNIGHT", level = 55, },
	[50137]={ class = "DEATHKNIGHT", level = 55, },
	[50138]={ class = "DEATHKNIGHT", level = 55, },
	[55620]={ class = "DEATHKNIGHT", level = 55, },
	[55623]={ class = "DEATHKNIGHT", level = 55, },
	[49146]={ class = "DEATHKNIGHT", level = 55, },
	[51986]={ class = "DEATHKNIGHT", level = 55, },
	[51267]={ class = "DEATHKNIGHT", level = 55, },
	[49013]={ class = "DEATHKNIGHT", level = 55, },
	[55236]={ class = "DEATHKNIGHT", level = 55, },
	[55237]={ class = "DEATHKNIGHT", level = 55, },
	[50117]={ class = "DEATHKNIGHT", level = 55, },
	[48965]={ class = "DEATHKNIGHT", level = 55, },
	[49571]={ class = "DEATHKNIGHT", level = 55, },
	[49572]={ class = "DEATHKNIGHT", level = 55, },
	[49208]={ class = "DEATHKNIGHT", level = 55, },
	[56834]={ class = "DEATHKNIGHT", level = 55, },
	[56835]={ class = "DEATHKNIGHT", level = 55, },
	[49188]={ class = "DEATHKNIGHT", level = 55, },
	[56822]={ class = "DEATHKNIGHT", level = 55, },
	[59057]={ class = "DEATHKNIGHT", level = 55, },
	[48982]={ class = "DEATHKNIGHT", level = 55, },
	[49455]={ class = "DEATHKNIGHT", level = 55, },
	[50147]={ class = "DEATHKNIGHT", level = 55, },
	[49004]={ class = "DEATHKNIGHT", level = 55, },
	[49508]={ class = "DEATHKNIGHT", level = 55, },
	[49509]={ class = "DEATHKNIGHT", level = 55, },
	[55090]={ class = "DEATHKNIGHT", level = 55, },
	[49145]={ class = "DEATHKNIGHT", level = 55, },
	[49495]={ class = "DEATHKNIGHT", level = 55, },
	[49497]={ class = "DEATHKNIGHT", level = 55, },
	[48997]={ class = "DEATHKNIGHT", level = 55, },
	[49490]={ class = "DEATHKNIGHT", level = 55, },
	[49491]={ class = "DEATHKNIGHT", level = 55, },
	[49018]={ class = "DEATHKNIGHT", level = 55, },
	[49529]={ class = "DEATHKNIGHT", level = 55, },
	[49530]={ class = "DEATHKNIGHT", level = 55, },
	[65661]={ class = "DEATHKNIGHT", level = 55, },
	[66191]={ class = "DEATHKNIGHT", level = 55, },
	[66192]={ class = "DEATHKNIGHT", level = 55, },
	[49042]={ class = "DEATHKNIGHT", level = 55, },
	[49786]={ class = "DEATHKNIGHT", level = 55, },
	[49787]={ class = "DEATHKNIGHT", level = 55, },
	[49788]={ class = "DEATHKNIGHT", level = 55, },
	[49789]={ class = "DEATHKNIGHT", level = 55, },
	[49202]={ class = "DEATHKNIGHT", level = 55, },
	[55107]={ class = "DEATHKNIGHT", level = 55, },
	[55108]={ class = "DEATHKNIGHT", level = 55, },
	[51271]={ class = "DEATHKNIGHT", level = 55, },
	[49194]={ class = "DEATHKNIGHT", level = 55, },
	[49588]={ class = "DEATHKNIGHT", level = 55, },
	[49589]={ class = "DEATHKNIGHT", level = 55, },
	[55233]={ class = "DEATHKNIGHT", level = 55, },
	[49015]={ class = "DEATHKNIGHT", level = 55, },
	[50154]={ class = "DEATHKNIGHT", level = 55, },
	[55136]={ class = "DEATHKNIGHT", level = 55, },
	[49006]={ class = "DEATHKNIGHT", level = 55, },
	[49526]={ class = "DEATHKNIGHT", level = 55, },
	[50029]={ class = "DEATHKNIGHT", level = 55, },
	[51745]={ class = "DEATHKNIGHT", level = 55, },
	[51746]={ class = "DEATHKNIGHT", level = 55, },
	[48962]={ class = "DEATHKNIGHT", level = 55, },
	[49567]={ class = "DEATHKNIGHT", level = 55, },
	[49568]={ class = "DEATHKNIGHT", level = 55, },
	[49217]={ class = "DEATHKNIGHT", level = 55, },
	[49654]={ class = "DEATHKNIGHT", level = 55, },
	[49655]={ class = "DEATHKNIGHT", level = 55, },
	[49189]={ class = "DEATHKNIGHT", level = 55, },
	[52284]={ class = "DEATHKNIGHT", level = 55, },
	[50149]={ class = "DEATHKNIGHT", level = 55, },
	[50150]={ class = "DEATHKNIGHT", level = 55, },
	[50118]={ class = "DEATHKNIGHT", level = 56, },
	[50119]={ class = "DEATHKNIGHT", level = 57, },
	[50120]={ class = "DEATHKNIGHT", level = 58, },
	[50121]={ class = "DEATHKNIGHT", level = 59, },
	[50127]={ class = "DEATHKNIGHT", level = 56, },
	[50128]={ class = "DEATHKNIGHT", level = 57, },
	[50129]={ class = "DEATHKNIGHT", level = 58, },
	[50130]={ class = "DEATHKNIGHT", level = 59, },
	[61155]={ class = "DEATHKNIGHT", level = 56, },
	[61156]={ class = "DEATHKNIGHT", level = 57, },
	[61157]={ class = "DEATHKNIGHT", level = 58, },
	[61158]={ class = "DEATHKNIGHT", level = 59, },
	[49028]={ class = "DEATHKNIGHT", level = 60, },
	[49184]={ class = "DEATHKNIGHT", level = 60, },
	[49206]={ class = "DEATHKNIGHT", level = 60, },
--++ Druid Abilities ++	
	[16958]={ class = "DRUID", level = 25, },
	[16961]={ class = "DRUID", level = 26, },
	[5185]={ class = "DRUID", level = 1, },
	[1126]={ class = "DRUID", level = 1, },
	[5176]={ class = "DRUID", level = 1, },
	[8921]={ class = "DRUID", level = 4, },
	[774]={ class = "DRUID", level = 4, },
	[5177]={ class = "DRUID", level = 6, },
	[339]={ class = "DRUID", level = 8, },
	[5186]={ class = "DRUID", level = 8, },
	[5487]={ class = "DRUID", level = 10, },
	[99]={ class = "DRUID", level = 10, },
	[6795]={ class = "DRUID", level = 10, },
	[5232]={ class = "DRUID", level = 10, },
	[6807]={ class = "DRUID", level = 10, },
	[8924]={ class = "DRUID", level = 10, },
	[16689]={ class = "DRUID", level = 10, },
	[1058]={ class = "DRUID", level = 10, },
	[18960]={ class = "DRUID", level = 10, },
	[5229]={ class = "DRUID", level = 12, },
	[8936]={ class = "DRUID", level = 12, },
	[50769]={ class = "DRUID", level = 12, },
	[5211]={ class = "DRUID", level = 14, },
	[8946]={ class = "DRUID", level = 14, },
	[5187]={ class = "DRUID", level = 14, },
	[5178]={ class = "DRUID", level = 14, },
	[1066]={ class = "DRUID", level = 16, },
	[8925]={ class = "DRUID", level = 16, },
	[1430]={ class = "DRUID", level = 16, },
	[779]={ class = "DRUID", level = 16, },
	[783]={ class = "DRUID", level = 16, },
	[1062]={ class = "DRUID", level = 18, },
	[770]={ class = "DRUID", level = 18, },
	[16857]={ class = "DRUID", level = 18, },
	[2637]={ class = "DRUID", level = 18, },
	[6808]={ class = "DRUID", level = 18, },
	[16810]={ class = "DRUID", level = 18, },
	[8938]={ class = "DRUID", level = 18, },
	[768]={ class = "DRUID", level = 20, },
	[1082]={ class = "DRUID", level = 20, },
	[1735]={ class = "DRUID", level = 20, },
	[16979]={ class = "DRUID", level = 20, },
	[49376]={ class = "DRUID", level = 20, },
	[5188]={ class = "DRUID", level = 20, },
	[6756]={ class = "DRUID", level = 20, },
	[5215]={ class = "DRUID", level = 20, },
	[20484]={ class = "DRUID", level = 20, },
	[1079]={ class = "DRUID", level = 20, },
	[2912]={ class = "DRUID", level = 20, },
	[8926]={ class = "DRUID", level = 22, },
	[2090]={ class = "DRUID", level = 22, },
	[5221]={ class = "DRUID", level = 22, },
	[2908]={ class = "DRUID", level = 22, },
	[5179]={ class = "DRUID", level = 22, },
	[1822]={ class = "DRUID", level = 24, },
	[8939]={ class = "DRUID", level = 24, },
	[2782]={ class = "DRUID", level = 24, },
	[50768]={ class = "DRUID", level = 24, },
	[780]={ class = "DRUID", level = 24, },
	[5217]={ class = "DRUID", level = 24, },
	[2893]={ class = "DRUID", level = 26, },
	[1850]={ class = "DRUID", level = 26, },
	[5189]={ class = "DRUID", level = 26, },
	[6809]={ class = "DRUID", level = 26, },
	[8949]={ class = "DRUID", level = 26, },
	[5209]={ class = "DRUID", level = 28, },
	[3029]={ class = "DRUID", level = 28, },
	[8998]={ class = "DRUID", level = 28, },
	[5195]={ class = "DRUID", level = 28, },
	[8927]={ class = "DRUID", level = 28, },
	[16811]={ class = "DRUID", level = 28, },
	[2091]={ class = "DRUID", level = 28, },
	[9492]={ class = "DRUID", level = 28, },
	[6798]={ class = "DRUID", level = 30, },
	[5234]={ class = "DRUID", level = 30, },
	[20739]={ class = "DRUID", level = 30, },
	[8940]={ class = "DRUID", level = 30, },
	[6800]={ class = "DRUID", level = 30, },
	[740]={ class = "DRUID", level = 30, },
	[44203]={ class = "DRUID", level = 30, },
	[5180]={ class = "DRUID", level = 30, },
	[9490]={ class = "DRUID", level = 32, },
	[22568]={ class = "DRUID", level = 32, },
	[6778]={ class = "DRUID", level = 32, },
	[6785]={ class = "DRUID", level = 32, },
	[5225]={ class = "DRUID", level = 32, },
	[8972]={ class = "DRUID", level = 34, },
	[8928]={ class = "DRUID", level = 34, },
	[1823]={ class = "DRUID", level = 34, },
	[3627]={ class = "DRUID", level = 34, },
	[8950]={ class = "DRUID", level = 34, },
	[769]={ class = "DRUID", level = 34, },
	[22842]={ class = "DRUID", level = 36, },
	[9005]={ class = "DRUID", level = 36, },
	[8941]={ class = "DRUID", level = 36, },
	[50767]={ class = "DRUID", level = 36, },
	[9493]={ class = "DRUID", level = 36, },
	[6793]={ class = "DRUID", level = 36, },
	[5201]={ class = "DRUID", level = 38, },
	[5196]={ class = "DRUID", level = 38, },
	[8903]={ class = "DRUID", level = 38, },
	[18657]={ class = "DRUID", level = 38, },
	[16812]={ class = "DRUID", level = 38, },
	[8992]={ class = "DRUID", level = 38, },
	[8955]={ class = "DRUID", level = 38, },
	[6780]={ class = "DRUID", level = 38, },
	[9000]={ class = "DRUID", level = 40, },
	[9634]={ class = "DRUID", level = 40, },
	[20719]={ class = "DRUID", level = 40, },
	[22827]={ class = "DRUID", level = 40, },
	[16914]={ class = "DRUID", level = 40, },
	[29166]={ class = "DRUID", level = 40, },
	[8907]={ class = "DRUID", level = 40, },
	[8929]={ class = "DRUID", level = 40, },
	[20742]={ class = "DRUID", level = 40, },
	[8910]={ class = "DRUID", level = 40, },
	[62600]={ class = "DRUID", level = 40, },
	[8918]={ class = "DRUID", level = 40, },
	[44205]={ class = "DRUID", level = 40, },
	[9747]={ class = "DRUID", level = 42, },
	[9745]={ class = "DRUID", level = 42, },
	[6787]={ class = "DRUID", level = 42, },
	[9750]={ class = "DRUID", level = 42, },
	[8951]={ class = "DRUID", level = 42, },
	[22812]={ class = "DRUID", level = 44, },
	[9758]={ class = "DRUID", level = 44, },
	[1824]={ class = "DRUID", level = 44, },
	[9752]={ class = "DRUID", level = 44, },
	[9754]={ class = "DRUID", level = 44, },
	[8983]={ class = "DRUID", level = 46, },
	[9821]={ class = "DRUID", level = 46, },
	[9833]={ class = "DRUID", level = 46, },
	[9823]={ class = "DRUID", level = 46, },
	[9839]={ class = "DRUID", level = 46, },
	[9829]={ class = "DRUID", level = 46, },
	[8905]={ class = "DRUID", level = 46, },
	[9849]={ class = "DRUID", level = 48, },
	[9852]={ class = "DRUID", level = 48, },
	[22828]={ class = "DRUID", level = 48, },
	[16813]={ class = "DRUID", level = 48, },
	[9856]={ class = "DRUID", level = 48, },
	[50766]={ class = "DRUID", level = 48, },
	[9845]={ class = "DRUID", level = 48, },
	[9888]={ class = "DRUID", level = 50, },
	[17401]={ class = "DRUID", level = 50, },
	[33878]={ class = "DRUID", level = 50, },
	[33876]={ class = "DRUID", level = 50, },
	[9884]={ class = "DRUID", level = 50, },
	[9880]={ class = "DRUID", level = 50, },
	[9866]={ class = "DRUID", level = 50, },
	[20747]={ class = "DRUID", level = 50, },
	[9875]={ class = "DRUID", level = 50, },
	[9862]={ class = "DRUID", level = 50, },
	[44206]={ class = "DRUID", level = 50, },
	[9892]={ class = "DRUID", level = 52, },
	[9898]={ class = "DRUID", level = 52, },
	[9834]={ class = "DRUID", level = 52, },
	[9840]={ class = "DRUID", level = 52, },
	[9894]={ class = "DRUID", level = 52, },
	[9904]={ class = "DRUID", level = 54, },
	[9857]={ class = "DRUID", level = 54, },
	[9830]={ class = "DRUID", level = 54, },
	[9901]={ class = "DRUID", level = 54, },
	[9908]={ class = "DRUID", level = 54, },
	[9912]={ class = "DRUID", level = 54, },
	[22829]={ class = "DRUID", level = 56, },
	[9889]={ class = "DRUID", level = 56, },
	[9827]={ class = "DRUID", level = 56, },
	[9850]={ class = "DRUID", level = 58, },
	[9853]={ class = "DRUID", level = 58, },
	[18658]={ class = "DRUID", level = 58, },
	[33986]={ class = "DRUID", level = 58, },
	[33982]={ class = "DRUID", level = 58, },
	[9881]={ class = "DRUID", level = 58, },
	[9835]={ class = "DRUID", level = 58, },
	[17329]={ class = "DRUID", level = 58, },
	[9867]={ class = "DRUID", level = 58, },
	[9841]={ class = "DRUID", level = 58, },
	[9876]={ class = "DRUID", level = 58, },
	[31709]={ class = "DRUID", level = 60, },
	[31018]={ class = "DRUID", level = 60, },
	[33943]={ class = "DRUID", level = 60, },
	[25297]={ class = "DRUID", level = 60, },
	[17402]={ class = "DRUID", level = 60, },
	[9885]={ class = "DRUID", level = 60, },
	[20748]={ class = "DRUID", level = 60, },
	[9858]={ class = "DRUID", level = 60, },
	[25299]={ class = "DRUID", level = 60, },
	[50765]={ class = "DRUID", level = 60, },
	[9896]={ class = "DRUID", level = 60, },
	[25298]={ class = "DRUID", level = 60, },
	[9846]={ class = "DRUID", level = 60, },
	[9863]={ class = "DRUID", level = 60, },
	[44207]={ class = "DRUID", level = 60, },
	[27001]={ class = "DRUID", level = 61, },
	[26984]={ class = "DRUID", level = 61, },
	[26998]={ class = "DRUID", level = 62, },
	[26978]={ class = "DRUID", level = 62, },
	[22570]={ class = "DRUID", level = 62, },
	[24248]={ class = "DRUID", level = 63, },
	[26987]={ class = "DRUID", level = 63, },
	[26981]={ class = "DRUID", level = 63, },
	[33763]={ class = "DRUID", level = 64, },
	[27003]={ class = "DRUID", level = 64, },
	[26997]={ class = "DRUID", level = 64, },
	[33357]={ class = "DRUID", level = 65, },
	[26980]={ class = "DRUID", level = 65, },
	[33745]={ class = "DRUID", level = 66, },
	[27006]={ class = "DRUID", level = 66, },
	[27005]={ class = "DRUID", level = 66, },
	[27000]={ class = "DRUID", level = 67, },
	[26996]={ class = "DRUID", level = 67, },
	[27008]={ class = "DRUID", level = 67, },
	[26986]={ class = "DRUID", level = 67, },
	[26989]={ class = "DRUID", level = 68, },
	[33987]={ class = "DRUID", level = 68, },
	[33983]={ class = "DRUID", level = 68, },
	[27009]={ class = "DRUID", level = 68, },
	[27004]={ class = "DRUID", level = 69, },
	[26979]={ class = "DRUID", level = 69, },
	[26994]={ class = "DRUID", level = 69, },
	[26982]={ class = "DRUID", level = 69, },
	[50764]={ class = "DRUID", level = 69, },
	[26985]={ class = "DRUID", level = 69, },
	[33786]={ class = "DRUID", level = 70, },
	[27012]={ class = "DRUID", level = 70, },
	[26990]={ class = "DRUID", level = 70, },
	[26988]={ class = "DRUID", level = 70, },
	[27002]={ class = "DRUID", level = 70, },
	[26995]={ class = "DRUID", level = 70, },
	[40120]={ class = "DRUID", level = 70, },
	[26983]={ class = "DRUID", level = 70, },
	[44208]={ class = "DRUID", level = 70, },
	[48559]={ class = "DRUID", level = 71, },
	[48442]={ class = "DRUID", level = 71, },
	[49799]={ class = "DRUID", level = 71, },
	[62078]={ class = "DRUID", level = 71, },
	[50212]={ class = "DRUID", level = 71, },
	[48576]={ class = "DRUID", level = 72, },
	[48450]={ class = "DRUID", level = 72, },
	[48573]={ class = "DRUID", level = 72, },
	[48464]={ class = "DRUID", level = 72, },
	[48561]={ class = "DRUID", level = 72, },
	[48569]={ class = "DRUID", level = 73, },
	[48567]={ class = "DRUID", level = 73, },
	[48479]={ class = "DRUID", level = 73, },
	[48578]={ class = "DRUID", level = 73, },
	[48377]={ class = "DRUID", level = 74, },
	[49802]={ class = "DRUID", level = 74, },
	[48459]={ class = "DRUID", level = 74, },
	[48563]={ class = "DRUID", level = 75, },
	[48565]={ class = "DRUID", level = 75, },
	[48462]={ class = "DRUID", level = 75, },
	[48440]={ class = "DRUID", level = 75, },
	[52610]={ class = "DRUID", level = 75, },
	[48571]={ class = "DRUID", level = 75, },
	[48446]={ class = "DRUID", level = 75, },
	[48575]={ class = "DRUID", level = 76, },
	[48560]={ class = "DRUID", level = 77, },
	[49803]={ class = "DRUID", level = 77, },
	[48443]={ class = "DRUID", level = 77, },
	[48562]={ class = "DRUID", level = 77, },
	[53308]={ class = "DRUID", level = 78, },
	[48577]={ class = "DRUID", level = 78, },
	[53312]={ class = "DRUID", level = 78, },
	[48574]={ class = "DRUID", level = 78, },
	[48465]={ class = "DRUID", level = 78, },
	[48570]={ class = "DRUID", level = 79, },
	[48378]={ class = "DRUID", level = 79, },
	[48480]={ class = "DRUID", level = 79, },
	[48579]={ class = "DRUID", level = 79, },
	[48477]={ class = "DRUID", level = 79, },
	[50213]={ class = "DRUID", level = 79, },
	[48461]={ class = "DRUID", level = 79, },
	[48467]={ class = "DRUID", level = 80, },
	[48568]={ class = "DRUID", level = 80, },
	[48451]={ class = "DRUID", level = 80, },
	[48564]={ class = "DRUID", level = 80, },
	[48566]={ class = "DRUID", level = 80, },
	[48469]={ class = "DRUID", level = 80, },
	[48463]={ class = "DRUID", level = 80, },
	[50464]={ class = "DRUID", level = 80, },
	[48441]={ class = "DRUID", level = 80, },
	[50763]={ class = "DRUID", level = 80, },
	[49800]={ class = "DRUID", level = 80, },
	[48572]={ class = "DRUID", level = 80, },
	[48447]={ class = "DRUID", level = 80, },
--++ Druid Talents ++	
	[33592]={ class = "DRUID", level = 35, },
	[33596]={ class = "DRUID", level = 36, },
	[50334]={ class = "DRUID", level = 60, },
	[16836]={ class = "DRUID", level = 20, },
	[16839]={ class = "DRUID", level = 21, },
	[16840]={ class = "DRUID", level = 22, },
	[16940]={ class = "DRUID", level = 30, },
	[16941]={ class = "DRUID", level = 31, },
	[16850]={ class = "DRUID", level = 25, },
	[16923]={ class = "DRUID", level = 26, },
	[16924]={ class = "DRUID", level = 27, },
	[33597]={ class = "DRUID", level = 35, },
	[33599]={ class = "DRUID", level = 36, },
	[33956]={ class = "DRUID", level = 37, },
	[48506]={ class = "DRUID", level = 55, },
	[48510]={ class = "DRUID", level = 56, },
	[48511]={ class = "DRUID", level = 57, },
	[48516]={ class = "DRUID", level = 50, },
	[48521]={ class = "DRUID", level = 51, },
	[48525]={ class = "DRUID", level = 52, },
	[33886]={ class = "DRUID", level = 45, },
	[33887]={ class = "DRUID", level = 46, },
	[33888]={ class = "DRUID", level = 47, },
	[33889]={ class = "DRUID", level = 48, },
	[33890]={ class = "DRUID", level = 49, },
	[33879]={ class = "DRUID", level = 35, },
	[33880]={ class = "DRUID", level = 36, },
	[16858]={ class = "DRUID", level = 10, },
	[16859]={ class = "DRUID", level = 11, },
	[16860]={ class = "DRUID", level = 12, },
	[16861]={ class = "DRUID", level = 13, },
	[16862]={ class = "DRUID", level = 14, },
	[49377]={ class = "DRUID", level = 30, },
	[16947]={ class = "DRUID", level = 15, },
	[16948]={ class = "DRUID", level = 16, },
	[16949]={ class = "DRUID", level = 17, },
	[17002]={ class = "DRUID", level = 20, },
	[24866]={ class = "DRUID", level = 21, },
	[16934]={ class = "DRUID", level = 10, },
	[16935]={ class = "DRUID", level = 11, },
	[16936]={ class = "DRUID", level = 12, },
	[16937]={ class = "DRUID", level = 13, },
	[16938]={ class = "DRUID", level = 14, },
	[33831]={ class = "DRUID", level = 50, },
	[17056]={ class = "DRUID", level = 10, },
	[17058]={ class = "DRUID", level = 11, },
	[17059]={ class = "DRUID", level = 12, },
	[17060]={ class = "DRUID", level = 13, },
	[17061]={ class = "DRUID", level = 14, },
	[48488]={ class = "DRUID", level = 50, },
	[48514]={ class = "DRUID", level = 51, },
	[57810]={ class = "DRUID", level = 10, },
	[57811]={ class = "DRUID", level = 11, },
	[57812]={ class = "DRUID", level = 12, },
	[57813]={ class = "DRUID", level = 13, },
	[57814]={ class = "DRUID", level = 14, },
	[17104]={ class = "DRUID", level = 30, },
	[24943]={ class = "DRUID", level = 31, },
	[24944]={ class = "DRUID", level = 32, },
	[24945]={ class = "DRUID", level = 33, },
	[24946]={ class = "DRUID", level = 34, },
	[51179]={ class = "DRUID", level = 55, },
	[51180]={ class = "DRUID", level = 56, },
	[51181]={ class = "DRUID", level = 57, },
	[51182]={ class = "DRUID", level = 58, },
	[51183]={ class = "DRUID", level = 59, },
	[17003]={ class = "DRUID", level = 35, },
	[17004]={ class = "DRUID", level = 36, },
	[17005]={ class = "DRUID", level = 37, },
	[17006]={ class = "DRUID", level = 38, },
	[24894]={ class = "DRUID", level = 39, },
	[63410]={ class = "DRUID", level = 55, },
	[63411]={ class = "DRUID", level = 56, },
	[33600]={ class = "DRUID", level = 40, },
	[33601]={ class = "DRUID", level = 41, },
	[33602]={ class = "DRUID", level = 42, },
	[57849]={ class = "DRUID", level = 31, },
	[57850]={ class = "DRUID", level = 32, },
	[57851]={ class = "DRUID", level = 33, },
	[34297]={ class = "DRUID", level = 41, },
	[34300]={ class = "DRUID", level = 42, },
	[48532]={ class = "DRUID", level = 51, },
	[48489]={ class = "DRUID", level = 52, },
	[48491]={ class = "DRUID", level = 53, },
	[17050]={ class = "DRUID", level = 10, },
	[17051]={ class = "DRUID", level = 11, },
	[16821]={ class = "DRUID", level = 15, },
	[16822]={ class = "DRUID", level = 16, },
	[48384]={ class = "DRUID", level = 41, },
	[48395]={ class = "DRUID", level = 42, },
	[48396]={ class = "DRUID", level = 43, },
	[17111]={ class = "DRUID", level = 25, },
	[17112]={ class = "DRUID", level = 26, },
	[17113]={ class = "DRUID", level = 27, },
	[17123]={ class = "DRUID", level = 30, },
	[17124]={ class = "DRUID", level = 31, },
	[48535]={ class = "DRUID", level = 51, },
	[48536]={ class = "DRUID", level = 52, },
	[48537]={ class = "DRUID", level = 53, },
	[48483]={ class = "DRUID", level = 45, },
	[48484]={ class = "DRUID", level = 46, },
	[48485]={ class = "DRUID", level = 47, },
	[5570]={ class = "DRUID", level = 30, },
	[17106]={ class = "DRUID", level = 20, },
	[17107]={ class = "DRUID", level = 21, },
	[17108]={ class = "DRUID", level = 22, },
	[48492]={ class = "DRUID", level = 50, },
	[48494]={ class = "DRUID", level = 51, },
	[48495]={ class = "DRUID", level = 52, },
	[17007]={ class = "DRUID", level = 40, },
	[48496]={ class = "DRUID", level = 45, },
	[48499]={ class = "DRUID", level = 46, },
	[48500]={ class = "DRUID", level = 47, },
	[34151]={ class = "DRUID", level = 40, },
	[34152]={ class = "DRUID", level = 41, },
	[34153]={ class = "DRUID", level = 42, },
	[33589]={ class = "DRUID", level = 30, },
	[33590]={ class = "DRUID", level = 31, },
	[33591]={ class = "DRUID", level = 31, },
	[33917]={ class = "DRUID", level = 50, },
	[48411]={ class = "DRUID", level = 20, },
	[48412]={ class = "DRUID", level = 21, },
	[16896]={ class = "DRUID", level = 35, },
	[16897]={ class = "DRUID", level = 36, },
	[16899]={ class = "DRUID", level = 37, },
	[16845]={ class = "DRUID", level = 15, },
	[16846]={ class = "DRUID", level = 16, },
	[16847]={ class = "DRUID", level = 17, },
	[24858]={ class = "DRUID", level = 40, },
	[33881]={ class = "DRUID", level = 40, },
	[33882]={ class = "DRUID", level = 41, },
	[33883]={ class = "DRUID", level = 42, },
	[57878]={ class = "DRUID", level = 35, },
	[57880]={ class = "DRUID", level = 36, },
	[57881]={ class = "DRUID", level = 37, },
	[16833]={ class = "DRUID", level = 15, },
	[16834]={ class = "DRUID", level = 16, },
	[16835]={ class = "DRUID", level = 17, },
	[17069]={ class = "DRUID", level = 15, },
	[17070]={ class = "DRUID", level = 16, },
	[17071]={ class = "DRUID", level = 17, },
	[17072]={ class = "DRUID", level = 18, },
	[17073]={ class = "DRUID", level = 19, },
	[17074]={ class = "DRUID", level = 35, },
	[17075]={ class = "DRUID", level = 36, },
	[17076]={ class = "DRUID", level = 37, },
	[17077]={ class = "DRUID", level = 38, },
	[17078]={ class = "DRUID", level = 39, },
	[17063]={ class = "DRUID", level = 10, },
	[17065]={ class = "DRUID", level = 11, },
	[17066]={ class = "DRUID", level = 12, },
	[16880]={ class = "DRUID", level = 20, },
	[61345]={ class = "DRUID", level = 21, },
	[61346]={ class = "DRUID", level = 22, },
	[35363]={ class = "DRUID", level = 15, },
	[35364]={ class = "DRUID", level = 16, },
	[16819]={ class = "DRUID", level = 20, },
	[16820]={ class = "DRUID", level = 21, },
	[57865]={ class = "DRUID", level = 20, },
	[17116]={ class = "DRUID", level = 30, },
	[33872]={ class = "DRUID", level = 30, },
	[33873]={ class = "DRUID", level = 31, },
	[16864]={ class = "DRUID", level = 20, },
	[48389]={ class = "DRUID", level = 45, },
	[48392]={ class = "DRUID", level = 46, },
	[48393]={ class = "DRUID", level = 47, },
	[33859]={ class = "DRUID", level = 45, },
	[33866]={ class = "DRUID", level = 46, },
	[33867]={ class = "DRUID", level = 47, },
	[16972]={ class = "DRUID", level = 25, },
	[16974]={ class = "DRUID", level = 26, },
	[16975]={ class = "DRUID", level = 27, },
	[37116]={ class = "DRUID", level = 25, },
	[37117]={ class = "DRUID", level = 26, },
	[63503]={ class = "DRUID", level = 60, },
	[48409]={ class = "DRUID", level = 25, },
	[48410]={ class = "DRUID", level = 26, },
	[33851]={ class = "DRUID", level = 40, },
	[33852]={ class = "DRUID", level = 41, },
	[33957]={ class = "DRUID", level = 42, },
	[57873]={ class = "DRUID", level = 45, },
	[57876]={ class = "DRUID", level = 46, },
	[57877]={ class = "DRUID", level = 47, },
	[48432]={ class = "DRUID", level = 55, },
	[48433]={ class = "DRUID", level = 56, },
	[48434]={ class = "DRUID", level = 57, },
	[51268]={ class = "DRUID", level = 58, },
	[51269]={ class = "DRUID", level = 59, },
	[48539]={ class = "DRUID", level = 50, },
	[48544]={ class = "DRUID", level = 51, },
	[48545]={ class = "DRUID", level = 52, },
	[16998]={ class = "DRUID", level = 15, },
	[16999]={ class = "DRUID", level = 16, },
	[16942]={ class = "DRUID", level = 20, },
	[16943]={ class = "DRUID", level = 21, },
	[16944]={ class = "DRUID", level = 22, },
	[16966]={ class = "DRUID", level = 25, },
	[16968]={ class = "DRUID", level = 26, },
	[48505]={ class = "DRUID", level = 60, },
	[16814]={ class = "DRUID", level = 10, },
	[16815]={ class = "DRUID", level = 11, },
	[16816]={ class = "DRUID", level = 12, },
	[16817]={ class = "DRUID", level = 13, },
	[16818]={ class = "DRUID", level = 14, },
	[17118]={ class = "DRUID", level = 15, },
	[17119]={ class = "DRUID", level = 16, },
	[17120]={ class = "DRUID", level = 17, },
	[61336]={ class = "DRUID", level = 20, },
	[33853]={ class = "DRUID", level = 35, },
	[33855]={ class = "DRUID", level = 36, },
	[33856]={ class = "DRUID", level = 37, },
	[18562]={ class = "DRUID", level = 40, },
	[16929]={ class = "DRUID", level = 15, },
	[16930]={ class = "DRUID", level = 16, },
	[16931]={ class = "DRUID", level = 17, },
	[24968]={ class = "DRUID", level = 25, },
	[24969]={ class = "DRUID", level = 26, },
	[24970]={ class = "DRUID", level = 27, },
	[24971]={ class = "DRUID", level = 28, },
	[24972]={ class = "DRUID", level = 29, },
	[65139]={ class = "DRUID", level = 50, },
	[5420]={ class = "DRUID", level = 50, },
	[33891]={ class = "DRUID", level = 50, },
	[50516]={ class = "DRUID", level = 50, },
	[16909]={ class = "DRUID", level = 25, },
	[16910]={ class = "DRUID", level = 26, },
	[16911]={ class = "DRUID", level = 27, },
	[16912]={ class = "DRUID", level = 28, },
	[16913]={ class = "DRUID", level = 29, },
	[48438]={ class = "DRUID", level = 60, },
	[33603]={ class = "DRUID", level = 45, },
	[33604]={ class = "DRUID", level = 46, },
	[33605]={ class = "DRUID", level = 47, },
	[33606]={ class = "DRUID", level = 48, },
	[33607]={ class = "DRUID", level = 49, },
	[24974]={ class = "DRUID", level = 30, },
	[24975]={ class = "DRUID", level = 40, },
	[24976]={ class = "DRUID", level = 50, },
	[24977]={ class = "DRUID", level = 60, },
	[53223]={ class = "DRUID", level = 60, },
	[27013]={ class = "DRUID", level = 70, },
	[53199]={ class = "DRUID", level = 70, },
	[53225]={ class = "DRUID", level = 70, },
	[53248]={ class = "DRUID", level = 70, },
	[53200]={ class = "DRUID", level = 75, },
	[53226]={ class = "DRUID", level = 75, },
	[53249]={ class = "DRUID", level = 75, },
	[48468]={ class = "DRUID", level = 80, },
	[53201]={ class = "DRUID", level = 80, },
	[61384]={ class = "DRUID", level = 80, },
	[53251]={ class = "DRUID", level = 80, },
--++ Hunter Abilities ++	
	[75]={ class = "HUNTER", level = 1, },
	[2973]={ class = "HUNTER", level = 1, },
	[1494]={ class = "HUNTER", level = 1, },
	[13163]={ class = "HUNTER", level = 4, },
	[1978]={ class = "HUNTER", level = 4, },
	[3044]={ class = "HUNTER", level = 6, },
	[1130]={ class = "HUNTER", level = 6, },
	[5116]={ class = "HUNTER", level = 8, },
	[14260]={ class = "HUNTER", level = 8, },
	[13165]={ class = "HUNTER", level = 10, },
	[883]={ class = "HUNTER", level = 10, },
	[2641]={ class = "HUNTER", level = 10, },
	[6991]={ class = "HUNTER", level = 10, },
	[982]={ class = "HUNTER", level = 10, },
	[13549]={ class = "HUNTER", level = 10, },
	[1515]={ class = "HUNTER", level = 10, },
	[19883]={ class = "HUNTER", level = 10, },
	[14281]={ class = "HUNTER", level = 12, },
	[20736]={ class = "HUNTER", level = 12, },
	[136]={ class = "HUNTER", level = 12, },
	[2974]={ class = "HUNTER", level = 12, },
	[6197]={ class = "HUNTER", level = 14, },
	[1002]={ class = "HUNTER", level = 14, },
	[1513]={ class = "HUNTER", level = 14, },
	[5118]={ class = "HUNTER", level = 16, },
	[13795]={ class = "HUNTER", level = 16, },
	[1495]={ class = "HUNTER", level = 16, },
	[14261]={ class = "HUNTER", level = 16, },
	[14318]={ class = "HUNTER", level = 18, },
	[2643]={ class = "HUNTER", level = 18, },
	[13550]={ class = "HUNTER", level = 18, },
	[19884]={ class = "HUNTER", level = 18, },
	[14282]={ class = "HUNTER", level = 20, },
	[34074]={ class = "HUNTER", level = 20, },
	[781]={ class = "HUNTER", level = 20, },
	[1499]={ class = "HUNTER", level = 20, },
	[3111]={ class = "HUNTER", level = 20, },
	[14323]={ class = "HUNTER", level = 22, },
	[3043]={ class = "HUNTER", level = 22, },
	[1462]={ class = "HUNTER", level = 24, },
	[14262]={ class = "HUNTER", level = 24, },
	[19885]={ class = "HUNTER", level = 24, },
	[14302]={ class = "HUNTER", level = 26, },
	[3045]={ class = "HUNTER", level = 26, },
	[13551]={ class = "HUNTER", level = 26, },
	[19880]={ class = "HUNTER", level = 26, },
	[14283]={ class = "HUNTER", level = 28, },
	[14319]={ class = "HUNTER", level = 28, },
	[13809]={ class = "HUNTER", level = 28, },
	[3661]={ class = "HUNTER", level = 28, },
	[13161]={ class = "HUNTER", level = 30, },
	[5384]={ class = "HUNTER", level = 30, },
	[14269]={ class = "HUNTER", level = 30, },
	[14288]={ class = "HUNTER", level = 30, },
	[14326]={ class = "HUNTER", level = 30, },
	[1543]={ class = "HUNTER", level = 32, },
	[14263]={ class = "HUNTER", level = 32, },
	[19878]={ class = "HUNTER", level = 32, },
	[13813]={ class = "HUNTER", level = 34, },
	[13552]={ class = "HUNTER", level = 34, },
	[14284]={ class = "HUNTER", level = 36, },
	[14303]={ class = "HUNTER", level = 36, },
	[3662]={ class = "HUNTER", level = 36, },
	[3034]={ class = "HUNTER", level = 36, },
	[14320]={ class = "HUNTER", level = 38, },
	[14310]={ class = "HUNTER", level = 40, },
	[14324]={ class = "HUNTER", level = 40, },
	[14264]={ class = "HUNTER", level = 40, },
	[19882]={ class = "HUNTER", level = 40, },
	[1510]={ class = "HUNTER", level = 40, },
	[14289]={ class = "HUNTER", level = 42, },
	[13553]={ class = "HUNTER", level = 42, },
	[14285]={ class = "HUNTER", level = 44, },
	[14316]={ class = "HUNTER", level = 44, },
	[13542]={ class = "HUNTER", level = 44, },
	[14270]={ class = "HUNTER", level = 44, },
	[20043]={ class = "HUNTER", level = 46, },
	[14304]={ class = "HUNTER", level = 46, },
	[14327]={ class = "HUNTER", level = 46, },
	[14321]={ class = "HUNTER", level = 48, },
	[14265]={ class = "HUNTER", level = 48, },
	[13554]={ class = "HUNTER", level = 50, },
	[56641]={ class = "HUNTER", level = 50, },
	[19879]={ class = "HUNTER", level = 50, },
	[14294]={ class = "HUNTER", level = 50, },
	[14286]={ class = "HUNTER", level = 52, },
	[13543]={ class = "HUNTER", level = 52, },
	[14317]={ class = "HUNTER", level = 54, },
	[14290]={ class = "HUNTER", level = 54, },
	[14305]={ class = "HUNTER", level = 56, },
	[14266]={ class = "HUNTER", level = 56, },
	[14322]={ class = "HUNTER", level = 58, },
	[14325]={ class = "HUNTER", level = 58, },
	[14271]={ class = "HUNTER", level = 58, },
	[13555]={ class = "HUNTER", level = 58, },
	[14295]={ class = "HUNTER", level = 58, },
	[14287]={ class = "HUNTER", level = 60, },
	[25296]={ class = "HUNTER", level = 60, },
	[19263]={ class = "HUNTER", level = 60, },
	[14311]={ class = "HUNTER", level = 60, },
	[13544]={ class = "HUNTER", level = 60, },
	[25294]={ class = "HUNTER", level = 60, },
	[25295]={ class = "HUNTER", level = 60, },
	[19801]={ class = "HUNTER", level = 60, },
	[27025]={ class = "HUNTER", level = 61, },
	[34120]={ class = "HUNTER", level = 62, },
	[27014]={ class = "HUNTER", level = 63, },
	[27023]={ class = "HUNTER", level = 65, },
	[34026]={ class = "HUNTER", level = 66, },
	[27021]={ class = "HUNTER", level = 67, },
	[27016]={ class = "HUNTER", level = 67, },
	[27022]={ class = "HUNTER", level = 67, },
	[27044]={ class = "HUNTER", level = 68, },
	[27046]={ class = "HUNTER", level = 68, },
	[34600]={ class = "HUNTER", level = 68, },
	[27019]={ class = "HUNTER", level = 69, },
	[34477]={ class = "HUNTER", level = 70, },
	[36916]={ class = "HUNTER", level = 70, },
	[49066]={ class = "HUNTER", level = 71, },
	[53351]={ class = "HUNTER", level = 71, },
	[48995]={ class = "HUNTER", level = 71, },
	[49051]={ class = "HUNTER", level = 71, },
	[49055]={ class = "HUNTER", level = 72, },
	[49044]={ class = "HUNTER", level = 73, },
	[49000]={ class = "HUNTER", level = 73, },
	[61846]={ class = "HUNTER", level = 74, },
	[48989]={ class = "HUNTER", level = 74, },
	[49047]={ class = "HUNTER", level = 74, },
	[58431]={ class = "HUNTER", level = 74, },
	[61005]={ class = "HUNTER", level = 75, },
	[53271]={ class = "HUNTER", level = 75, },
	[53338]={ class = "HUNTER", level = 76, },
	[49067]={ class = "HUNTER", level = 77, },
	[48996]={ class = "HUNTER", level = 77, },
	[49052]={ class = "HUNTER", level = 77, },
	[49056]={ class = "HUNTER", level = 78, },
	[49045]={ class = "HUNTER", level = 79, },
	[49001]={ class = "HUNTER", level = 79, },
	[61847]={ class = "HUNTER", level = 80, },
	[62757]={ class = "HUNTER", level = 80, },
	[60192]={ class = "HUNTER", level = 80, },
	[61006]={ class = "HUNTER", level = 80, },
	[48990]={ class = "HUNTER", level = 80, },
	[53339]={ class = "HUNTER", level = 80, },
	[49048]={ class = "HUNTER", level = 80, },
	[58434]={ class = "HUNTER", level = 80, },
--++ Hunter Talents ++	
	[19434]={ class = "HUNTER", level = 20, },
	[34453]={ class = "HUNTER", level = 35, },
	[34454]={ class = "HUNTER", level = 36, },
	[53265]={ class = "HUNTER", level = 20, },
	[19461]={ class = "HUNTER", level = 30, },
	[19462]={ class = "HUNTER", level = 31, },
	[24691]={ class = "HUNTER", level = 32, },
	[53270]={ class = "HUNTER", level = 60, },
	[19590]={ class = "HUNTER", level = 30, },
	[19592]={ class = "HUNTER", level = 31, },
	[19574]={ class = "HUNTER", level = 40, },
	[3674]={ class = "HUNTER", level = 50, },
	[34482]={ class = "HUNTER", level = 15, },
	[34483]={ class = "HUNTER", level = 16, },
	[34484]={ class = "HUNTER", level = 17, },
	[34462]={ class = "HUNTER", level = 40, },
	[34464]={ class = "HUNTER", level = 41, },
	[34465]={ class = "HUNTER", level = 42, },
	[53209]={ class = "HUNTER", level = 60, },
	[53256]={ class = "HUNTER", level = 50, },
	[53259]={ class = "HUNTER", level = 51, },
	[53260]={ class = "HUNTER", level = 52, },
	[34475]={ class = "HUNTER", level = 35, },
	[34476]={ class = "HUNTER", level = 36, },
	[35100]={ class = "HUNTER", level = 30, },
	[35102]={ class = "HUNTER", level = 31, },
	[19306]={ class = "HUNTER", level = 30, },
	[19295]={ class = "HUNTER", level = 20, },
	[19297]={ class = "HUNTER", level = 21, },
	[19298]={ class = "HUNTER", level = 22, },
	[19416]={ class = "HUNTER", level = 25, },
	[19417]={ class = "HUNTER", level = 26, },
	[19418]={ class = "HUNTER", level = 27, },
	[19419]={ class = "HUNTER", level = 28, },
	[19420]={ class = "HUNTER", level = 29, },
	[19583]={ class = "HUNTER", level = 10, },
	[19584]={ class = "HUNTER", level = 11, },
	[19585]={ class = "HUNTER", level = 12, },
	[19586]={ class = "HUNTER", level = 13, },
	[19587]={ class = "HUNTER", level = 14, },
	[19184]={ class = "HUNTER", level = 15, },
	[19387]={ class = "HUNTER", level = 16, },
	[19388]={ class = "HUNTER", level = 17, },
	[53301]={ class = "HUNTER", level = 60, },
	[34500]={ class = "HUNTER", level = 40, },
	[34502]={ class = "HUNTER", level = 41, },
	[34503]={ class = "HUNTER", level = 42, },
	[34455]={ class = "HUNTER", level = 40, },
	[34459]={ class = "HUNTER", level = 41, },
	[34460]={ class = "HUNTER", level = 42, },
	[19598]={ class = "HUNTER", level = 25, },
	[19599]={ class = "HUNTER", level = 26, },
	[19600]={ class = "HUNTER", level = 27, },
	[19601]={ class = "HUNTER", level = 28, },
	[19602]={ class = "HUNTER", level = 29, },
	[53620]={ class = "HUNTER", level = 10, },
	[53621]={ class = "HUNTER", level = 11, },
	[53622]={ class = "HUNTER", level = 12, },
	[35029]={ class = "HUNTER", level = 15, },
	[35030]={ class = "HUNTER", level = 16, },
	[19621]={ class = "HUNTER", level = 35, },
	[19622]={ class = "HUNTER", level = 36, },
	[19623]={ class = "HUNTER", level = 37, },
	[19624]={ class = "HUNTER", level = 38, },
	[19625]={ class = "HUNTER", level = 39, },
	[34950]={ class = "HUNTER", level = 20, },
	[34954]={ class = "HUNTER", level = 21, },
	[19498]={ class = "HUNTER", level = 10, },
	[19499]={ class = "HUNTER", level = 11, },
	[19500]={ class = "HUNTER", level = 12, },
	[56339]={ class = "HUNTER", level = 30, },
	[56340]={ class = "HUNTER", level = 31, },
	[56341]={ class = "HUNTER", level = 32, },
	[53290]={ class = "HUNTER", level = 55, },
	[53291]={ class = "HUNTER", level = 56, },
	[53292]={ class = "HUNTER", level = 57, },
	[19454]={ class = "HUNTER", level = 20, },
	[19455]={ class = "HUNTER", level = 21, },
	[19456]={ class = "HUNTER", level = 22, },
	[19552]={ class = "HUNTER", level = 10, },
	[19553]={ class = "HUNTER", level = 11, },
	[19554]={ class = "HUNTER", level = 12, },
	[19555]={ class = "HUNTER", level = 13, },
	[19556]={ class = "HUNTER", level = 14, },
	[19549]={ class = "HUNTER", level = 15, },
	[19550]={ class = "HUNTER", level = 16, },
	[19551]={ class = "HUNTER", level = 17, },
	[35104]={ class = "HUNTER", level = 40, },
	[35110]={ class = "HUNTER", level = 41, },
	[35111]={ class = "HUNTER", level = 42, },
	[19407]={ class = "HUNTER", level = 10, },
	[19412]={ class = "HUNTER", level = 11, },
	[19421]={ class = "HUNTER", level = 15, },
	[19422]={ class = "HUNTER", level = 16, },
	[19423]={ class = "HUNTER", level = 17, },
	[19572]={ class = "HUNTER", level = 25, },
	[19573]={ class = "HUNTER", level = 26, },
	[24443]={ class = "HUNTER", level = 15, },
	[19575]={ class = "HUNTER", level = 16, },
	[53221]={ class = "HUNTER", level = 50, },
	[53222]={ class = "HUNTER", level = 51, },
	[53224]={ class = "HUNTER", level = 52, },
	[19464]={ class = "HUNTER", level = 25, },
	[19465]={ class = "HUNTER", level = 26, },
	[19466]={ class = "HUNTER", level = 27, },
	[52783]={ class = "HUNTER", level = 10, },
	[52785]={ class = "HUNTER", level = 11, },
	[52786]={ class = "HUNTER", level = 12, },
	[52787]={ class = "HUNTER", level = 13, },
	[52788]={ class = "HUNTER", level = 14, },
	[19577]={ class = "HUNTER", level = 30, },
	[53252]={ class = "HUNTER", level = 45, },
	[53253]={ class = "HUNTER", level = 46, },
	[19370]={ class = "HUNTER", level = 30, },
	[19371]={ class = "HUNTER", level = 31, },
	[19373]={ class = "HUNTER", level = 32, },
	[56314]={ class = "HUNTER", level = 55, },
	[56315]={ class = "HUNTER", level = 56, },
	[56316]={ class = "HUNTER", level = 57, },
	[56317]={ class = "HUNTER", level = 58, },
	[56318]={ class = "HUNTER", level = 59, },
	[19426]={ class = "HUNTER", level = 10, },
	[19427]={ class = "HUNTER", level = 11, },
	[19429]={ class = "HUNTER", level = 12, },
	[19430]={ class = "HUNTER", level = 13, },
	[19431]={ class = "HUNTER", level = 14, },
	[19168]={ class = "HUNTER", level = 35, },
	[19180]={ class = "HUNTER", level = 36, },
	[19181]={ class = "HUNTER", level = 37, },
	[24296]={ class = "HUNTER", level = 38, },
	[24297]={ class = "HUNTER", level = 39, },
	[56342]={ class = "HUNTER", level = 25, },
	[56343]={ class = "HUNTER", level = 26, },
	[56344]={ class = "HUNTER", level = 27, },
	[53262]={ class = "HUNTER", level = 50, },
	[53263]={ class = "HUNTER", level = 51, },
	[53264]={ class = "HUNTER", level = 52, },
	[53241]={ class = "HUNTER", level = 55, },
	[53243]={ class = "HUNTER", level = 56, },
	[53244]={ class = "HUNTER", level = 57, },
	[53245]={ class = "HUNTER", level = 58, },
	[53246]={ class = "HUNTER", level = 59, },
	[34485]={ class = "HUNTER", level = 45, },
	[34486]={ class = "HUNTER", level = 46, },
	[34487]={ class = "HUNTER", level = 47, },
	[34488]={ class = "HUNTER", level = 48, },
	[34489]={ class = "HUNTER", level = 49, },
	[34506]={ class = "HUNTER", level = 45, },
	[34507]={ class = "HUNTER", level = 46, },
	[34508]={ class = "HUNTER", level = 47, },
	[34838]={ class = "HUNTER", level = 48, },
	[34839]={ class = "HUNTER", level = 49, },
	[19485]={ class = "HUNTER", level = 15, },
	[19487]={ class = "HUNTER", level = 16, },
	[19488]={ class = "HUNTER", level = 17, },
	[19489]={ class = "HUNTER", level = 18, },
	[19490]={ class = "HUNTER", level = 19, },
	[53295]={ class = "HUNTER", level = 45, },
	[53296]={ class = "HUNTER", level = 46, },
	[53297]={ class = "HUNTER", level = 47, },
	[19559]={ class = "HUNTER", level = 20, },
	[19560]={ class = "HUNTER", level = 21, },
	[53234]={ class = "HUNTER", level = 40, },
	[53237]={ class = "HUNTER", level = 41, },
	[53238]={ class = "HUNTER", level = 42, },
	[53298]={ class = "HUNTER", level = 50, },
	[53299]={ class = "HUNTER", level = 51, },
	[19507]={ class = "HUNTER", level = 35, },
	[19508]={ class = "HUNTER", level = 36, },
	[19509]={ class = "HUNTER", level = 37, },
	[34948]={ class = "HUNTER", level = 20, },
	[34949]={ class = "HUNTER", level = 21, },
	[53228]={ class = "HUNTER", level = 45, },
	[53232]={ class = "HUNTER", level = 46, },
	[23989]={ class = "HUNTER", level = 30, },
	[34491]={ class = "HUNTER", level = 35, },
	[34492]={ class = "HUNTER", level = 36, },
	[34493]={ class = "HUNTER", level = 37, },
	[19159]={ class = "HUNTER", level = 10, },
	[19160]={ class = "HUNTER", level = 11, },
	[19503]={ class = "HUNTER", level = 20, },
	[34466]={ class = "HUNTER", level = 45, },
	[34467]={ class = "HUNTER", level = 46, },
	[34468]={ class = "HUNTER", level = 47, },
	[34469]={ class = "HUNTER", level = 48, },
	[34470]={ class = "HUNTER", level = 49, },
	[34490]={ class = "HUNTER", level = 50, },
	[53302]={ class = "HUNTER", level = 50, },
	[53303]={ class = "HUNTER", level = 51, },
	[53304]={ class = "HUNTER", level = 52, },
	[19578]={ class = "HUNTER", level = 30, },
	[20895]={ class = "HUNTER", level = 31, },
	[19290]={ class = "HUNTER", level = 15, },
	[19294]={ class = "HUNTER", level = 16, },
	[24283]={ class = "HUNTER", level = 17, },
	[34494]={ class = "HUNTER", level = 15, },
	[34496]={ class = "HUNTER", level = 16, },
	[19286]={ class = "HUNTER", level = 20, },
	[19287]={ class = "HUNTER", level = 21, },
	[19255]={ class = "HUNTER", level = 20, },
	[19256]={ class = "HUNTER", level = 21, },
	[19257]={ class = "HUNTER", level = 22, },
	[19258]={ class = "HUNTER", level = 23, },
	[19259]={ class = "HUNTER", level = 24, },
	[56333]={ class = "HUNTER", level = 25, },
	[56336]={ class = "HUNTER", level = 26, },
	[56337]={ class = "HUNTER", level = 27, },
	[34692]={ class = "HUNTER", level = 50, },
	[19609]={ class = "HUNTER", level = 15, },
	[19610]={ class = "HUNTER", level = 16, },
	[19612]={ class = "HUNTER", level = 17, },
	[34497]={ class = "HUNTER", level = 40, },
	[34498]={ class = "HUNTER", level = 41, },
	[34499]={ class = "HUNTER", level = 42, },
	[19376]={ class = "HUNTER", level = 15, },
	[63457]={ class = "HUNTER", level = 16, },
	[63458]={ class = "HUNTER", level = 17, },
	[19616]={ class = "HUNTER", level = 20, },
	[19617]={ class = "HUNTER", level = 21, },
	[19618]={ class = "HUNTER", level = 22, },
	[19619]={ class = "HUNTER", level = 23, },
	[19620]={ class = "HUNTER", level = 24, },
	[53215]={ class = "HUNTER", level = 50, },
	[53216]={ class = "HUNTER", level = 51, },
	[53217]={ class = "HUNTER", level = 52, },
	[19386]={ class = "HUNTER", level = 40, },
	[20900]={ class = "HUNTER", level = 28, },
	[20901]={ class = "HUNTER", level = 36, },
	[20909]={ class = "HUNTER", level = 42, },
	[20902]={ class = "HUNTER", level = 44, },
	[24132]={ class = "HUNTER", level = 50, },
	[20903]={ class = "HUNTER", level = 52, },
	[20910]={ class = "HUNTER", level = 54, },
	[63668]={ class = "HUNTER", level = 57, },
	[20904]={ class = "HUNTER", level = 60, },
	[24133]={ class = "HUNTER", level = 60, },
	[63669]={ class = "HUNTER", level = 63, },
	[27067]={ class = "HUNTER", level = 66, },
	[63670]={ class = "HUNTER", level = 69, },
	[27065]={ class = "HUNTER", level = 70, },
	[60051]={ class = "HUNTER", level = 70, },
	[27068]={ class = "HUNTER", level = 70, },
	[48998]={ class = "HUNTER", level = 72, },
	[49049]={ class = "HUNTER", level = 75, },
	[63671]={ class = "HUNTER", level = 75, },
	[60052]={ class = "HUNTER", level = 75, },
	[49011]={ class = "HUNTER", level = 75, },
	[48999]={ class = "HUNTER", level = 78, },
	[49050]={ class = "HUNTER", level = 80, },
	[63672]={ class = "HUNTER", level = 80, },
--++ Mage Abilities ++	
	[1459]={ class = "MAGE", level = 1, },
	[133]={ class = "MAGE", level = 1, },
	[168]={ class = "MAGE", level = 1, },
	[5504]={ class = "MAGE", level = 4, },
	[116]={ class = "MAGE", level = 4, },
	[587]={ class = "MAGE", level = 6, },
	[2136]={ class = "MAGE", level = 6, },
	[143]={ class = "MAGE", level = 6, },
	[5143]={ class = "MAGE", level = 8, },
	[205]={ class = "MAGE", level = 8, },
	[118]={ class = "MAGE", level = 8, },
	[5505]={ class = "MAGE", level = 10, },
	[7300]={ class = "MAGE", level = 10, },
	[122]={ class = "MAGE", level = 10, },
	[597]={ class = "MAGE", level = 12, },
	[145]={ class = "MAGE", level = 12, },
	[130]={ class = "MAGE", level = 12, },
	[1449]={ class = "MAGE", level = 14, },
	[1460]={ class = "MAGE", level = 14, },
	[2137]={ class = "MAGE", level = 14, },
	[837]={ class = "MAGE", level = 14, },
	[5144]={ class = "MAGE", level = 16, },
	[2120]={ class = "MAGE", level = 16, },
	[3140]={ class = "MAGE", level = 18, },
	[475]={ class = "MAGE", level = 18, },
	[1953]={ class = "MAGE", level = 20, },
	[10]={ class = "MAGE", level = 20, },
	[5506]={ class = "MAGE", level = 20, },
	[12051]={ class = "MAGE", level = 20, },
	[543]={ class = "MAGE", level = 20, },
	[7301]={ class = "MAGE", level = 20, },
	[7322]={ class = "MAGE", level = 20, },
	[1463]={ class = "MAGE", level = 20, },
	[12824]={ class = "MAGE", level = 20, },
	[32271]={ class = "MAGE", level = 20, },
	[3562]={ class = "MAGE", level = 20, },
	[3567]={ class = "MAGE", level = 20, },
	[32272]={ class = "MAGE", level = 20, },
	[3561]={ class = "MAGE", level = 20, },
	[3563]={ class = "MAGE", level = 20, },
	[8437]={ class = "MAGE", level = 22, },
	[990]={ class = "MAGE", level = 22, },
	[2138]={ class = "MAGE", level = 22, },
	[6143]={ class = "MAGE", level = 22, },
	[2948]={ class = "MAGE", level = 22, },
	[5145]={ class = "MAGE", level = 24, },
	[2139]={ class = "MAGE", level = 24, },
	[8400]={ class = "MAGE", level = 24, },
	[2121]={ class = "MAGE", level = 24, },
	[120]={ class = "MAGE", level = 26, },
	[865]={ class = "MAGE", level = 26, },
	[8406]={ class = "MAGE", level = 26, },
	[1461]={ class = "MAGE", level = 28, },
	[6141]={ class = "MAGE", level = 28, },
	[759]={ class = "MAGE", level = 28, },
	[8494]={ class = "MAGE", level = 28, },
	[8444]={ class = "MAGE", level = 28, },
	[8438]={ class = "MAGE", level = 30, },
	[6127]={ class = "MAGE", level = 30, },
	[8412]={ class = "MAGE", level = 30, },
	[8457]={ class = "MAGE", level = 30, },
	[8401]={ class = "MAGE", level = 30, },
	[7302]={ class = "MAGE", level = 30, },
	[45438]={ class = "MAGE", level = 30, },
	[3565]={ class = "MAGE", level = 30, },
	[3566]={ class = "MAGE", level = 30, },
	[8416]={ class = "MAGE", level = 32, },
	[6129]={ class = "MAGE", level = 32, },
	[8422]={ class = "MAGE", level = 32, },
	[8461]={ class = "MAGE", level = 32, },
	[8407]={ class = "MAGE", level = 32, },
	[8492]={ class = "MAGE", level = 34, },
	[6117]={ class = "MAGE", level = 34, },
	[8445]={ class = "MAGE", level = 34, },
	[49361]={ class = "MAGE", level = 35, },
	[49360]={ class = "MAGE", level = 35, },
	[49358]={ class = "MAGE", level = 35, },
	[49359]={ class = "MAGE", level = 35, },
	[8427]={ class = "MAGE", level = 36, },
	[8402]={ class = "MAGE", level = 36, },
	[8495]={ class = "MAGE", level = 36, },
	[8439]={ class = "MAGE", level = 38, },
	[3552]={ class = "MAGE", level = 38, },
	[8413]={ class = "MAGE", level = 38, },
	[8408]={ class = "MAGE", level = 38, },
	[8417]={ class = "MAGE", level = 40, },
	[10138]={ class = "MAGE", level = 40, },
	[8458]={ class = "MAGE", level = 40, },
	[8423]={ class = "MAGE", level = 40, },
	[6131]={ class = "MAGE", level = 40, },
	[7320]={ class = "MAGE", level = 40, },
	[12825]={ class = "MAGE", level = 40, },
	[32266]={ class = "MAGE", level = 40, },
	[11416]={ class = "MAGE", level = 40, },
	[11417]={ class = "MAGE", level = 40, },
	[32267]={ class = "MAGE", level = 40, },
	[10059]={ class = "MAGE", level = 40, },
	[11418]={ class = "MAGE", level = 40, },
	[8446]={ class = "MAGE", level = 40, },
	[10156]={ class = "MAGE", level = 42, },
	[10159]={ class = "MAGE", level = 42, },
	[10144]={ class = "MAGE", level = 42, },
	[10148]={ class = "MAGE", level = 42, },
	[8462]={ class = "MAGE", level = 42, },
	[10185]={ class = "MAGE", level = 44, },
	[10179]={ class = "MAGE", level = 44, },
	[10191]={ class = "MAGE", level = 44, },
	[10201]={ class = "MAGE", level = 46, },
	[10197]={ class = "MAGE", level = 46, },
	[22782]={ class = "MAGE", level = 46, },
	[10205]={ class = "MAGE", level = 46, },
	[10211]={ class = "MAGE", level = 48, },
	[10053]={ class = "MAGE", level = 48, },
	[10149]={ class = "MAGE", level = 48, },
	[10215]={ class = "MAGE", level = 48, },
	[10160]={ class = "MAGE", level = 50, },
	[10139]={ class = "MAGE", level = 50, },
	[10223]={ class = "MAGE", level = 50, },
	[10180]={ class = "MAGE", level = 50, },
	[10219]={ class = "MAGE", level = 50, },
	[11419]={ class = "MAGE", level = 50, },
	[11420]={ class = "MAGE", level = 50, },
	[70909]={ class = "MAGE", level = 50, },
	[10186]={ class = "MAGE", level = 52, },
	[10145]={ class = "MAGE", level = 52, },
	[10177]={ class = "MAGE", level = 52, },
	[10192]={ class = "MAGE", level = 52, },
	[10206]={ class = "MAGE", level = 52, },
	[10202]={ class = "MAGE", level = 54, },
	[10199]={ class = "MAGE", level = 54, },
	[10150]={ class = "MAGE", level = 54, },
	[10230]={ class = "MAGE", level = 54, },
	[10157]={ class = "MAGE", level = 56, },
	[10212]={ class = "MAGE", level = 56, },
	[10216]={ class = "MAGE", level = 56, },
	[10181]={ class = "MAGE", level = 56, },
	[10161]={ class = "MAGE", level = 58, },
	[10054]={ class = "MAGE", level = 58, },
	[22783]={ class = "MAGE", level = 58, },
	[10207]={ class = "MAGE", level = 58, },
	[25345]={ class = "MAGE", level = 60, },
	[10187]={ class = "MAGE", level = 60, },
	[28612]={ class = "MAGE", level = 60, },
	[10140]={ class = "MAGE", level = 60, },
	[10225]={ class = "MAGE", level = 60, },
	[10151]={ class = "MAGE", level = 60, },
	[25306]={ class = "MAGE", level = 60, },
	[28609]={ class = "MAGE", level = 60, },
	[25304]={ class = "MAGE", level = 60, },
	[10220]={ class = "MAGE", level = 60, },
	[10193]={ class = "MAGE", level = 60, },
	[12826]={ class = "MAGE", level = 60, },
	[28271]={ class = "MAGE", level = 60, },
	[28272]={ class = "MAGE", level = 60, },
	[61305]={ class = "MAGE", level = 60, },
	[61721]={ class = "MAGE", level = 60, },
	[61780]={ class = "MAGE", level = 60, },
	[33690]={ class = "MAGE", level = 60, },
	[35715]={ class = "MAGE", level = 60, },
	[27078]={ class = "MAGE", level = 61, },
	[27080]={ class = "MAGE", level = 62, },
	[30482]={ class = "MAGE", level = 62, },
	[27075]={ class = "MAGE", level = 63, },
	[27071]={ class = "MAGE", level = 63, },
	[30451]={ class = "MAGE", level = 64, },
	[27086]={ class = "MAGE", level = 64, },
	[27087]={ class = "MAGE", level = 65, },
	[37420]={ class = "MAGE", level = 65, },
	[33691]={ class = "MAGE", level = 65, },
	[35717]={ class = "MAGE", level = 65, },
	[27073]={ class = "MAGE", level = 65, },
	[27070]={ class = "MAGE", level = 66, },
	[30455]={ class = "MAGE", level = 66, },
	[27088]={ class = "MAGE", level = 67, },
	[27085]={ class = "MAGE", level = 68, },
	[27101]={ class = "MAGE", level = 68, },
	[66]={ class = "MAGE", level = 68, },
	[27131]={ class = "MAGE", level = 68, },
	[38699]={ class = "MAGE", level = 69, },
	[27128]={ class = "MAGE", level = 69, },
	[27072]={ class = "MAGE", level = 69, },
	[27124]={ class = "MAGE", level = 69, },
	[27125]={ class = "MAGE", level = 69, },
	[27082]={ class = "MAGE", level = 70, },
	[27126]={ class = "MAGE", level = 70, },
	[38704]={ class = "MAGE", level = 70, },
	[33717]={ class = "MAGE", level = 70, },
	[27090]={ class = "MAGE", level = 70, },
	[27079]={ class = "MAGE", level = 70, },
	[38692]={ class = "MAGE", level = 70, },
	[32796]={ class = "MAGE", level = 70, },
	[38697]={ class = "MAGE", level = 70, },
	[43987]={ class = "MAGE", level = 70, },
	[27074]={ class = "MAGE", level = 70, },
	[30449]={ class = "MAGE", level = 70, },
	[42894]={ class = "MAGE", level = 71, },
	[43023]={ class = "MAGE", level = 71, },
	[43045]={ class = "MAGE", level = 71, },
	[53140]={ class = "MAGE", level = 71, },
	[42930]={ class = "MAGE", level = 72, },
	[42925]={ class = "MAGE", level = 72, },
	[42913]={ class = "MAGE", level = 72, },
	[43019]={ class = "MAGE", level = 73, },
	[42858]={ class = "MAGE", level = 73, },
	[42939]={ class = "MAGE", level = 74, },
	[42872]={ class = "MAGE", level = 74, },
	[42832]={ class = "MAGE", level = 74, },
	[53142]={ class = "MAGE", level = 74, },
	[42843]={ class = "MAGE", level = 75, },
	[42955]={ class = "MAGE", level = 75, },
	[42917]={ class = "MAGE", level = 75, },
	[42841]={ class = "MAGE", level = 75, },
	[44614]={ class = "MAGE", level = 75, },
	[42896]={ class = "MAGE", level = 76, },
	[42920]={ class = "MAGE", level = 76, },
	[42985]={ class = "MAGE", level = 77, },
	[43010]={ class = "MAGE", level = 78, },
	[42833]={ class = "MAGE", level = 78, },
	[42914]={ class = "MAGE", level = 78, },
	[42859]={ class = "MAGE", level = 78, },
	[42846]={ class = "MAGE", level = 79, },
	[42931]={ class = "MAGE", level = 79, },
	[42926]={ class = "MAGE", level = 79, },
	[43012]={ class = "MAGE", level = 79, },
	[42842]={ class = "MAGE", level = 79, },
	[43008]={ class = "MAGE", level = 79, },
	[43024]={ class = "MAGE", level = 79, },
	[43020]={ class = "MAGE", level = 79, },
	[43046]={ class = "MAGE", level = 79, },
	[42897]={ class = "MAGE", level = 80, },
	[42921]={ class = "MAGE", level = 80, },
	[42995]={ class = "MAGE", level = 80, },
	[42940]={ class = "MAGE", level = 80, },
	[42956]={ class = "MAGE", level = 80, },
	[61316]={ class = "MAGE", level = 80, },
	[61024]={ class = "MAGE", level = 80, },
	[42873]={ class = "MAGE", level = 80, },
	[47610]={ class = "MAGE", level = 80, },
	[55342]={ class = "MAGE", level = 80, },
	[58659]={ class = "MAGE", level = 80, },
--++ Mage Talents ++	
	[44425]={ class = "MAGE", level = 60, },
	[11213]={ class = "MAGE", level = 15, },
	[12574]={ class = "MAGE", level = 16, },
	[12575]={ class = "MAGE", level = 17, },
	[12576]={ class = "MAGE", level = 18, },
	[12577]={ class = "MAGE", level = 19, },
	[31579]={ class = "MAGE", level = 40, },
	[31582]={ class = "MAGE", level = 41, },
	[31583]={ class = "MAGE", level = 42, },
	[44378]={ class = "MAGE", level = 45, },
	[44379]={ class = "MAGE", level = 46, },
	[11222]={ class = "MAGE", level = 10, },
	[12839]={ class = "MAGE", level = 11, },
	[12840]={ class = "MAGE", level = 12, },
	[28574]={ class = "MAGE", level = 15, },
	[54658]={ class = "MAGE", level = 16, },
	[54659]={ class = "MAGE", level = 17, },
	[15058]={ class = "MAGE", level = 35, },
	[15059]={ class = "MAGE", level = 36, },
	[15060]={ class = "MAGE", level = 37, },
	[18462]={ class = "MAGE", level = 25, },
	[18463]={ class = "MAGE", level = 26, },
	[18464]={ class = "MAGE", level = 27, },
	[11232]={ class = "MAGE", level = 30, },
	[12500]={ class = "MAGE", level = 31, },
	[12501]={ class = "MAGE", level = 32, },
	[12502]={ class = "MAGE", level = 33, },
	[12503]={ class = "MAGE", level = 34, },
	[31571]={ class = "MAGE", level = 35, },
	[31572]={ class = "MAGE", level = 36, },
	[12042]={ class = "MAGE", level = 40, },
	[11252]={ class = "MAGE", level = 25, },
	[12605]={ class = "MAGE", level = 26, },
	[11237]={ class = "MAGE", level = 10, },
	[12463]={ class = "MAGE", level = 11, },
	[12464]={ class = "MAGE", level = 12, },
	[16769]={ class = "MAGE", level = 13, },
	[16770]={ class = "MAGE", level = 14, },
	[11210]={ class = "MAGE", level = 10, },
	[12592]={ class = "MAGE", level = 11, },
	[16757]={ class = "MAGE", level = 25, },
	[16758]={ class = "MAGE", level = 26, },
	[31674]={ class = "MAGE", level = 40, },
	[31675]={ class = "MAGE", level = 41, },
	[31676]={ class = "MAGE", level = 42, },
	[31677]={ class = "MAGE", level = 43, },
	[31678]={ class = "MAGE", level = 44, },
	[11113]={ class = "MAGE", level = 30, },
	[31641]={ class = "MAGE", level = 35, },
	[31642]={ class = "MAGE", level = 36, },
	[44546]={ class = "MAGE", level = 50, },
	[44548]={ class = "MAGE", level = 51, },
	[44549]={ class = "MAGE", level = 52, },
	[54747]={ class = "MAGE", level = 15, },
	[54749]={ class = "MAGE", level = 16, },
	[11083]={ class = "MAGE", level = 20, },
	[12351]={ class = "MAGE", level = 21, },
	[44449]={ class = "MAGE", level = 55, },
	[44469]={ class = "MAGE", level = 56, },
	[44470]={ class = "MAGE", level = 57, },
	[44471]={ class = "MAGE", level = 58, },
	[44472]={ class = "MAGE", level = 59, },
	[44566]={ class = "MAGE", level = 55, },
	[44567]={ class = "MAGE", level = 56, },
	[44568]={ class = "MAGE", level = 57, },
	[44570]={ class = "MAGE", level = 58, },
	[44571]={ class = "MAGE", level = 59, },
	[55091]={ class = "MAGE", level = 35, },
	[55092]={ class = "MAGE", level = 36, },
	[11958]={ class = "MAGE", level = 30, },
	[11129]={ class = "MAGE", level = 40, },
	[11115]={ class = "MAGE", level = 30, },
	[11367]={ class = "MAGE", level = 31, },
	[11368]={ class = "MAGE", level = 32, },
	[44572]={ class = "MAGE", level = 60, },
	[31661]={ class = "MAGE", level = 50, },
	[31656]={ class = "MAGE", level = 45, },
	[31657]={ class = "MAGE", level = 46, },
	[31658]={ class = "MAGE", level = 47, },
	[31682]={ class = "MAGE", level = 45, },
	[31683]={ class = "MAGE", level = 46, },
	[44557]={ class = "MAGE", level = 51, },
	[44560]={ class = "MAGE", level = 52, },
	[44561]={ class = "MAGE", level = 53, },
	[64353]={ class = "MAGE", level = 45, },
	[64357]={ class = "MAGE", level = 46, },
	[44543]={ class = "MAGE", level = 45, },
	[44545]={ class = "MAGE", level = 46, },
	[11124]={ class = "MAGE", level = 35, },
	[12378]={ class = "MAGE", level = 36, },
	[12398]={ class = "MAGE", level = 37, },
	[12399]={ class = "MAGE", level = 38, },
	[12400]={ class = "MAGE", level = 39, },
	[44442]={ class = "MAGE", level = 51, },
	[44443]={ class = "MAGE", level = 52, },
	[11100]={ class = "MAGE", level = 20, },
	[12353]={ class = "MAGE", level = 21, },
	[54646]={ class = "MAGE", level = 20, },
	[11160]={ class = "MAGE", level = 25, },
	[12518]={ class = "MAGE", level = 26, },
	[12519]={ class = "MAGE", level = 27, },
	[11189]={ class = "MAGE", level = 15, },
	[28332]={ class = "MAGE", level = 16, },
	[11071]={ class = "MAGE", level = 10, },
	[12496]={ class = "MAGE", level = 11, },
	[12497]={ class = "MAGE", level = 12, },
	[31667]={ class = "MAGE", level = 30, },
	[31668]={ class = "MAGE", level = 31, },
	[31669]={ class = "MAGE", level = 32, },
	[44445]={ class = "MAGE", level = 50, },
	[44446]={ class = "MAGE", level = 51, },
	[44448]={ class = "MAGE", level = 52, },
	[11426]={ class = "MAGE", level = 40, },
	[31670]={ class = "MAGE", level = 10, },
	[31672]={ class = "MAGE", level = 11, },
	[55094]={ class = "MAGE", level = 12, },
	[11207]={ class = "MAGE", level = 15, },
	[12672]={ class = "MAGE", level = 16, },
	[15047]={ class = "MAGE", level = 17, },
	[12472]={ class = "MAGE", level = 20, },
	[11119]={ class = "MAGE", level = 15, },
	[11120]={ class = "MAGE", level = 16, },
	[12846]={ class = "MAGE", level = 17, },
	[12847]={ class = "MAGE", level = 18, },
	[12848]={ class = "MAGE", level = 19, },
	[11103]={ class = "MAGE", level = 20, },
	[12357]={ class = "MAGE", level = 21, },
	[12358]={ class = "MAGE", level = 22, },
	[31569]={ class = "MAGE", level = 30, },
	[31570]={ class = "MAGE", level = 31, },
	[11185]={ class = "MAGE", level = 20, },
	[12487]={ class = "MAGE", level = 21, },
	[12488]={ class = "MAGE", level = 22, },
	[11190]={ class = "MAGE", level = 30, },
	[12489]={ class = "MAGE", level = 31, },
	[12490]={ class = "MAGE", level = 32, },
	[11255]={ class = "MAGE", level = 25, },
	[12598]={ class = "MAGE", level = 26, },
	[11078]={ class = "MAGE", level = 10, },
	[11080]={ class = "MAGE", level = 11, },
	[11069]={ class = "MAGE", level = 10, },
	[12338]={ class = "MAGE", level = 11, },
	[12339]={ class = "MAGE", level = 12, },
	[12340]={ class = "MAGE", level = 13, },
	[12341]={ class = "MAGE", level = 14, },
	[11070]={ class = "MAGE", level = 10, },
	[12473]={ class = "MAGE", level = 11, },
	[16763]={ class = "MAGE", level = 12, },
	[16765]={ class = "MAGE", level = 13, },
	[16766]={ class = "MAGE", level = 14, },
	[11095]={ class = "MAGE", level = 25, },
	[12872]={ class = "MAGE", level = 26, },
	[12873]={ class = "MAGE", level = 27, },
	[44394]={ class = "MAGE", level = 40, },
	[44395]={ class = "MAGE", level = 41, },
	[44396]={ class = "MAGE", level = 42, },
	[18459]={ class = "MAGE", level = 10, },
	[18460]={ class = "MAGE", level = 11, },
	[54734]={ class = "MAGE", level = 12, },
	[44457]={ class = "MAGE", level = 60, },
	[29441]={ class = "MAGE", level = 15, },
	[29444]={ class = "MAGE", level = 16, },
	[11247]={ class = "MAGE", level = 20, },
	[12606]={ class = "MAGE", level = 21, },
	[29074]={ class = "MAGE", level = 25, },
	[29075]={ class = "MAGE", level = 26, },
	[29076]={ class = "MAGE", level = 27, },
	[31584]={ class = "MAGE", level = 45, },
	[31585]={ class = "MAGE", level = 46, },
	[31586]={ class = "MAGE", level = 47, },
	[31587]={ class = "MAGE", level = 48, },
	[31588]={ class = "MAGE", level = 49, },
	[44404]={ class = "MAGE", level = 50, },
	[54486]={ class = "MAGE", level = 51, },
	[54488]={ class = "MAGE", level = 52, },
	[54489]={ class = "MAGE", level = 53, },
	[54490]={ class = "MAGE", level = 54, },
	[31679]={ class = "MAGE", level = 40, },
	[31680]={ class = "MAGE", level = 41, },
	[11094]={ class = "MAGE", level = 25, },
	[13043]={ class = "MAGE", level = 26, },
	[44400]={ class = "MAGE", level = 55, },
	[44402]={ class = "MAGE", level = 56, },
	[44403]={ class = "MAGE", level = 57, },
	[11175]={ class = "MAGE", level = 15, },
	[12569]={ class = "MAGE", level = 16, },
	[12571]={ class = "MAGE", level = 17, },
	[11151]={ class = "MAGE", level = 20, },
	[12952]={ class = "MAGE", level = 21, },
	[12953]={ class = "MAGE", level = 22, },
	[31638]={ class = "MAGE", level = 30, },
	[31639]={ class = "MAGE", level = 31, },
	[31640]={ class = "MAGE", level = 32, },
	[29438]={ class = "MAGE", level = 15, },
	[29439]={ class = "MAGE", level = 16, },
	[29440]={ class = "MAGE", level = 17, },
	[12043]={ class = "MAGE", level = 30, },
	[31574]={ class = "MAGE", level = 35, },
	[31575]={ class = "MAGE", level = 36, },
	[54354]={ class = "MAGE", level = 37, },
	[11366]={ class = "MAGE", level = 20, },
	[34293]={ class = "MAGE", level = 40, },
	[34295]={ class = "MAGE", level = 41, },
	[34296]={ class = "MAGE", level = 42, },
	[11170]={ class = "MAGE", level = 25, },
	[12982]={ class = "MAGE", level = 26, },
	[12983]={ class = "MAGE", level = 27, },
	[44745]={ class = "MAGE", level = 41, },
	[54787]={ class = "MAGE", level = 42, },
	[31589]={ class = "MAGE", level = 50, },
	[11242]={ class = "MAGE", level = 20, },
	[12467]={ class = "MAGE", level = 21, },
	[12469]={ class = "MAGE", level = 22, },
	[35578]={ class = "MAGE", level = 55, },
	[35581]={ class = "MAGE", level = 56, },
	[44397]={ class = "MAGE", level = 20, },
	[44398]={ class = "MAGE", level = 21, },
	[44399]={ class = "MAGE", level = 22, },
	[31687]={ class = "MAGE", level = 50, },
	[29447]={ class = "MAGE", level = 25, },
	[55339]={ class = "MAGE", level = 26, },
	[55340]={ class = "MAGE", level = 27, },
	[11180]={ class = "MAGE", level = 35, },
	[28592]={ class = "MAGE", level = 36, },
	[28593]={ class = "MAGE", level = 37, },
	[11108]={ class = "MAGE", level = 15, },
	[12349]={ class = "MAGE", level = 16, },
	[12350]={ class = "MAGE", level = 17, },
	[12505]={ class = "MAGE", level = 24, },
	[12522]={ class = "MAGE", level = 30, },
	[13018]={ class = "MAGE", level = 36, },
	[12523]={ class = "MAGE", level = 36, },
	[12524]={ class = "MAGE", level = 42, },
	[13019]={ class = "MAGE", level = 44, },
	[13031]={ class = "MAGE", level = 46, },
	[12525]={ class = "MAGE", level = 48, },
	[13020]={ class = "MAGE", level = 52, },
	[13032]={ class = "MAGE", level = 52, },
	[12526]={ class = "MAGE", level = 54, },
	[33041]={ class = "MAGE", level = 56, },
	[13033]={ class = "MAGE", level = 58, },
	[13021]={ class = "MAGE", level = 60, },
	[18809]={ class = "MAGE", level = 60, },
	[33042]={ class = "MAGE", level = 64, },
	[27134]={ class = "MAGE", level = 64, },
	[27133]={ class = "MAGE", level = 65, },
	[27132]={ class = "MAGE", level = 66, },
	[44780]={ class = "MAGE", level = 70, },
	[33933]={ class = "MAGE", level = 70, },
	[33043]={ class = "MAGE", level = 70, },
	[33405]={ class = "MAGE", level = 70, },
	[55359]={ class = "MAGE", level = 70, },
	[33938]={ class = "MAGE", level = 70, },
	[42890]={ class = "MAGE", level = 73, },
	[42944]={ class = "MAGE", level = 75, },
	[42949]={ class = "MAGE", level = 75, },
	[43038]={ class = "MAGE", level = 75, },
	[42891]={ class = "MAGE", level = 77, },
	[44781]={ class = "MAGE", level = 80, },
	[42945]={ class = "MAGE", level = 80, },
	[42950]={ class = "MAGE", level = 80, },
	[43039]={ class = "MAGE", level = 80, },
	[55360]={ class = "MAGE", level = 80, },
--++ Paladin Abilities ++	
	[54968]={ class = "PALADIN", level = 1, },
	[635]={ class = "PALADIN", level = 1, },
	[20154]={ class = "PALADIN", level = 1, },
	[21084]={ class = "PALADIN", level = 1, },
	[20271]={ class = "PALADIN", level = 4, },
	[498]={ class = "PALADIN", level = 6, },
	[639]={ class = "PALADIN", level = 6, },
	[853]={ class = "PALADIN", level = 8, },
	[1152]={ class = "PALADIN", level = 8, },
	[1022]={ class = "PALADIN", level = 10, },
	[633]={ class = "PALADIN", level = 10, },
	[53408]={ class = "PALADIN", level = 12, },
	[7328]={ class = "PALADIN", level = 12, },
	[647]={ class = "PALADIN", level = 14, },
	[31789]={ class = "PALADIN", level = 14, },
	[62124]={ class = "PALADIN", level = 16, },
	[25780]={ class = "PALADIN", level = 16, },
	[1044]={ class = "PALADIN", level = 18, },
	[26573]={ class = "PALADIN", level = 20, },
	[879]={ class = "PALADIN", level = 20, },
	[19750]={ class = "PALADIN", level = 20, },
	[5502]={ class = "PALADIN", level = 20, },
	[34769]={ class = "PALADIN", level = 20, },
	[13819]={ class = "PALADIN", level = 20, },
	[1026]={ class = "PALADIN", level = 22, },
	[20164]={ class = "PALADIN", level = 22, },
	[5588]={ class = "PALADIN", level = 24, },
	[5599]={ class = "PALADIN", level = 24, },
	[10322]={ class = "PALADIN", level = 24, },
	[10326]={ class = "PALADIN", level = 24, },
	[19939]={ class = "PALADIN", level = 26, },
	[1038]={ class = "PALADIN", level = 26, },
	[5614]={ class = "PALADIN", level = 28, },
	[53407]={ class = "PALADIN", level = 28, },
	[20116]={ class = "PALADIN", level = 30, },
	[19752]={ class = "PALADIN", level = 30, },
	[1042]={ class = "PALADIN", level = 30, },
	[2800]={ class = "PALADIN", level = 30, },
	[20165]={ class = "PALADIN", level = 30, },
	[642]={ class = "PALADIN", level = 34, },
	[19940]={ class = "PALADIN", level = 34, },
	[5615]={ class = "PALADIN", level = 36, },
	[10324]={ class = "PALADIN", level = 36, },
	[10278]={ class = "PALADIN", level = 38, },
	[3472]={ class = "PALADIN", level = 38, },
	[20166]={ class = "PALADIN", level = 38, },
	[23214]={ class = "PALADIN", level = 40, },
	[20922]={ class = "PALADIN", level = 40, },
	[5589]={ class = "PALADIN", level = 40, },
	[34767]={ class = "PALADIN", level = 40, },
	[4987]={ class = "PALADIN", level = 42, },
	[19941]={ class = "PALADIN", level = 42, },
	[10312]={ class = "PALADIN", level = 44, },
	[24275]={ class = "PALADIN", level = 44, },
	[6940]={ class = "PALADIN", level = 46, },
	[10328]={ class = "PALADIN", level = 46, },
	[20772]={ class = "PALADIN", level = 48, },
	[20923]={ class = "PALADIN", level = 50, },
	[19942]={ class = "PALADIN", level = 50, },
	[2812]={ class = "PALADIN", level = 50, },
	[10310]={ class = "PALADIN", level = 50, },
	[10313]={ class = "PALADIN", level = 52, },
	[24274]={ class = "PALADIN", level = 52, },
	[10308]={ class = "PALADIN", level = 54, },
	[10329]={ class = "PALADIN", level = 54, },
	[19943]={ class = "PALADIN", level = 58, },
	[20924]={ class = "PALADIN", level = 60, },
	[10314]={ class = "PALADIN", level = 60, },
	[24239]={ class = "PALADIN", level = 60, },
	[25292]={ class = "PALADIN", level = 60, },
	[10318]={ class = "PALADIN", level = 60, },
	[20773]={ class = "PALADIN", level = 60, },
	[27135]={ class = "PALADIN", level = 62, },
	[356110]={ class = "PALADIN", level = 64, },
	[356112]={ class = "PALADIN", level = 64, },
	[53736]={ class = "PALADIN", level = 64, },
	[348704]={ class = "PALADIN", level = 64, },
	[31801]={ class = "PALADIN", level = 64, },
	[27137]={ class = "PALADIN", level = 66, },
	[27138]={ class = "PALADIN", level = 68, },
	[27180]={ class = "PALADIN", level = 68, },
	[27139]={ class = "PALADIN", level = 69, },
	[27154]={ class = "PALADIN", level = 69, },
	[31884]={ class = "PALADIN", level = 70, },
	[27173]={ class = "PALADIN", level = 70, },
	[27136]={ class = "PALADIN", level = 70, },
	[54428]={ class = "PALADIN", level = 71, },
	[48816]={ class = "PALADIN", level = 72, },
	[48949]={ class = "PALADIN", level = 72, },
	[48800]={ class = "PALADIN", level = 73, },
	[48784]={ class = "PALADIN", level = 74, },
	[48805]={ class = "PALADIN", level = 74, },
	[48818]={ class = "PALADIN", level = 75, },
	[48781]={ class = "PALADIN", level = 75, },
	[53600]={ class = "PALADIN", level = 75, },
	[48817]={ class = "PALADIN", level = 78, },
	[48788]={ class = "PALADIN", level = 78, },
	[48801]={ class = "PALADIN", level = 79, },
	[48785]={ class = "PALADIN", level = 79, },
	[48950]={ class = "PALADIN", level = 79, },
	[48819]={ class = "PALADIN", level = 80, },
	[48806]={ class = "PALADIN", level = 80, },
	[48782]={ class = "PALADIN", level = 80, },
	[53601]={ class = "PALADIN", level = 80, },
	[61411]={ class = "PALADIN", level = 80, },
--++ Paladin Talents ++	
	[20096]={ class = "PALADIN", level = 15, },
	[20097]={ class = "PALADIN", level = 16, },
	[20098]={ class = "PALADIN", level = 17, },
	[20099]={ class = "PALADIN", level = 18, },
	[20100]={ class = "PALADIN", level = 19, },
	[31850]={ class = "PALADIN", level = 40, },
	[31851]={ class = "PALADIN", level = 41, },
	[31852]={ class = "PALADIN", level = 42, },
	[53563]={ class = "PALADIN", level = 60, },
	[20101]={ class = "PALADIN", level = 10, },
	[20102]={ class = "PALADIN", level = 11, },
	[20103]={ class = "PALADIN", level = 12, },
	[20104]={ class = "PALADIN", level = 13, },
	[20105]={ class = "PALADIN", level = 14, },
	[53660]={ class = "PALADIN", level = 25, },
	[53661]={ class = "PALADIN", level = 26, },
	[31828]={ class = "PALADIN", level = 40, },
	[31829]={ class = "PALADIN", level = 41, },
	[31830]={ class = "PALADIN", level = 42, },
	[31858]={ class = "PALADIN", level = 45, },
	[31859]={ class = "PALADIN", level = 46, },
	[31860]={ class = "PALADIN", level = 47, },
	[20117]={ class = "PALADIN", level = 20, },
	[20118]={ class = "PALADIN", level = 21, },
	[20119]={ class = "PALADIN", level = 22, },
	[20120]={ class = "PALADIN", level = 23, },
	[20121]={ class = "PALADIN", level = 24, },
	[31866]={ class = "PALADIN", level = 25, },
	[31867]={ class = "PALADIN", level = 26, },
	[31868]={ class = "PALADIN", level = 27, },
	[35395]={ class = "PALADIN", level = 50, },
	[20060]={ class = "PALADIN", level = 10, },
	[20061]={ class = "PALADIN", level = 11, },
	[20062]={ class = "PALADIN", level = 12, },
	[20063]={ class = "PALADIN", level = 13, },
	[20064]={ class = "PALADIN", level = 14, },
	[20216]={ class = "PALADIN", level = 30, },
	[53527]={ class = "PALADIN", level = 25, },
	[53530]={ class = "PALADIN", level = 26, },
	[31842]={ class = "PALADIN", level = 50, },
	[20257]={ class = "PALADIN", level = 10, },
	[20258]={ class = "PALADIN", level = 11, },
	[20259]={ class = "PALADIN", level = 12, },
	[20260]={ class = "PALADIN", level = 13, },
	[20261]={ class = "PALADIN", level = 14, },
	[31871]={ class = "PALADIN", level = 35, },
	[31872]={ class = "PALADIN", level = 36, },
	[64205]={ class = "PALADIN", level = 20, },
	[53385]={ class = "PALADIN", level = 60, },
	[20262]={ class = "PALADIN", level = 10, },
	[20263]={ class = "PALADIN", level = 11, },
	[20264]={ class = "PALADIN", level = 12, },
	[20265]={ class = "PALADIN", level = 13, },
	[20266]={ class = "PALADIN", level = 14, },
	[63646]={ class = "PALADIN", level = 10, },
	[63647]={ class = "PALADIN", level = 11, },
	[63648]={ class = "PALADIN", level = 12, },
	[63649]={ class = "PALADIN", level = 13, },
	[63650]={ class = "PALADIN", level = 14, },
	[53556]={ class = "PALADIN", level = 55, },
	[53557]={ class = "PALADIN", level = 56, },
	[9799]={ class = "PALADIN", level = 25, },
	[25988]={ class = "PALADIN", level = 26, },
	[31879]={ class = "PALADIN", level = 45, },
	[31880]={ class = "PALADIN", level = 46, },
	[31881]={ class = "PALADIN", level = 47, },
	[53583]={ class = "PALADIN", level = 50, },
	[53585]={ class = "PALADIN", level = 51, },
	[20174]={ class = "PALADIN", level = 15, },
	[20175]={ class = "PALADIN", level = 16, },
	[53595]={ class = "PALADIN", level = 60, },
	[20237]={ class = "PALADIN", level = 15, },
	[20238]={ class = "PALADIN", level = 16, },
	[20239]={ class = "PALADIN", level = 17, },
	[20335]={ class = "PALADIN", level = 15, },
	[20336]={ class = "PALADIN", level = 16, },
	[20337]={ class = "PALADIN", level = 17, },
	[31837]={ class = "PALADIN", level = 45, },
	[31838]={ class = "PALADIN", level = 46, },
	[31839]={ class = "PALADIN", level = 47, },
	[31840]={ class = "PALADIN", level = 48, },
	[31841]={ class = "PALADIN", level = 49, },
	[5923]={ class = "PALADIN", level = 35, },
	[5924]={ class = "PALADIN", level = 36, },
	[5925]={ class = "PALADIN", level = 37, },
	[5926]={ class = "PALADIN", level = 38, },
	[25829]={ class = "PALADIN", level = 39, },
	[20925]={ class = "PALADIN", level = 40, },
	[20473]={ class = "PALADIN", level = 40, },
	[20210]={ class = "PALADIN", level = 20, },
	[20212]={ class = "PALADIN", level = 21, },
	[20213]={ class = "PALADIN", level = 22, },
	[20214]={ class = "PALADIN", level = 23, },
	[20215]={ class = "PALADIN", level = 24, },
	[20042]={ class = "PALADIN", level = 15, },
	[20045]={ class = "PALADIN", level = 16, },
	[20244]={ class = "PALADIN", level = 25, },
	[20245]={ class = "PALADIN", level = 26, },
	[20254]={ class = "PALADIN", level = 25, },
	[20255]={ class = "PALADIN", level = 26, },
	[20256]={ class = "PALADIN", level = 27, },
	[20138]={ class = "PALADIN", level = 25, },
	[20139]={ class = "PALADIN", level = 26, },
	[20140]={ class = "PALADIN", level = 27, },
	[20487]={ class = "PALADIN", level = 25, },
	[20488]={ class = "PALADIN", level = 26, },
	[25956]={ class = "PALADIN", level = 15, },
	[25957]={ class = "PALADIN", level = 16, },
	[20234]={ class = "PALADIN", level = 20, },
	[20235]={ class = "PALADIN", level = 21, },
	[20468]={ class = "PALADIN", level = 20, },
	[20469]={ class = "PALADIN", level = 21, },
	[20470]={ class = "PALADIN", level = 22, },
	[53569]={ class = "PALADIN", level = 55, },
	[53576]={ class = "PALADIN", level = 56, },
	[53695]={ class = "PALADIN", level = 55, },
	[53696]={ class = "PALADIN", level = 56, },
	[53671]={ class = "PALADIN", level = 50, },
	[53673]={ class = "PALADIN", level = 51, },
	[54151]={ class = "PALADIN", level = 52, },
	[54154]={ class = "PALADIN", level = 53, },
	[54155]={ class = "PALADIN", level = 54, },
	[31876]={ class = "PALADIN", level = 40, },
	[31877]={ class = "PALADIN", level = 41, },
	[31878]={ class = "PALADIN", level = 42, },
	[31833]={ class = "PALADIN", level = 40, },
	[31835]={ class = "PALADIN", level = 41, },
	[31836]={ class = "PALADIN", level = 42, },
	[20196]={ class = "PALADIN", level = 35, },
	[20197]={ class = "PALADIN", level = 36, },
	[20198]={ class = "PALADIN", level = 37, },
	[31822]={ class = "PALADIN", level = 30, },
	[31823]={ class = "PALADIN", level = 31, },
	[31825]={ class = "PALADIN", level = 35, },
	[31826]={ class = "PALADIN", level = 36, },
	[26022]={ class = "PALADIN", level = 20, },
	[26023]={ class = "PALADIN", level = 21, },
	[20177]={ class = "PALADIN", level = 40, },
	[20179]={ class = "PALADIN", level = 41, },
	[20180]={ class = "PALADIN", level = 42, },
	[20181]={ class = "PALADIN", level = 43, },
	[20182]={ class = "PALADIN", level = 44, },
	[20127]={ class = "PALADIN", level = 45, },
	[20130]={ class = "PALADIN", level = 46, },
	[20135]={ class = "PALADIN", level = 47, },
	[20066]={ class = "PALADIN", level = 40, },
	[53380]={ class = "PALADIN", level = 55, },
	[53381]={ class = "PALADIN", level = 56, },
	[53382]={ class = "PALADIN", level = 57, },
	[53551]={ class = "PALADIN", level = 45, },
	[53552]={ class = "PALADIN", level = 46, },
	[53553]={ class = "PALADIN", level = 47, },
	[31848]={ class = "PALADIN", level = 35, },
	[31849]={ class = "PALADIN", level = 36, },
	[20359]={ class = "PALADIN", level = 30, },
	[20360]={ class = "PALADIN", level = 31, },
	[20361]={ class = "PALADIN", level = 32, },
	[31869]={ class = "PALADIN", level = 30, },
	[53375]={ class = "PALADIN", level = 45, },
	[53376]={ class = "PALADIN", level = 46, },
	[32043]={ class = "PALADIN", level = 25, },
	[35396]={ class = "PALADIN", level = 26, },
	[35397]={ class = "PALADIN", level = 27, },
	[20375]={ class = "PALADIN", level = 20, },
	[20224]={ class = "PALADIN", level = 10, },
	[20225]={ class = "PALADIN", level = 11, },
	[20330]={ class = "PALADIN", level = 12, },
	[20331]={ class = "PALADIN", level = 13, },
	[20332]={ class = "PALADIN", level = 14, },
	[53501]={ class = "PALADIN", level = 50, },
	[53502]={ class = "PALADIN", level = 51, },
	[53503]={ class = "PALADIN", level = 52, },
	[53709]={ class = "PALADIN", level = 55, },
	[53710]={ class = "PALADIN", level = 56, },
	[53711]={ class = "PALADIN", level = 57, },
	[31785]={ class = "PALADIN", level = 40, },
	[33776]={ class = "PALADIN", level = 41, },
	[20205]={ class = "PALADIN", level = 10, },
	[20206]={ class = "PALADIN", level = 11, },
	[20207]={ class = "PALADIN", level = 12, },
	[20209]={ class = "PALADIN", level = 13, },
	[20208]={ class = "PALADIN", level = 14, },
	[31844]={ class = "PALADIN", level = 15, },
	[31845]={ class = "PALADIN", level = 16, },
	[53519]={ class = "PALADIN", level = 17, },
	[53379]={ class = "PALADIN", level = 50, },
	[53484]={ class = "PALADIN", level = 51, },
	[53648]={ class = "PALADIN", level = 52, },
	[53486]={ class = "PALADIN", level = 40, },
	[53488]={ class = "PALADIN", level = 41, },
	[53590]={ class = "PALADIN", level = 50, },
	[53591]={ class = "PALADIN", level = 51, },
	[53592]={ class = "PALADIN", level = 52, },
	[20143]={ class = "PALADIN", level = 20, },
	[20144]={ class = "PALADIN", level = 21, },
	[20145]={ class = "PALADIN", level = 22, },
	[20146]={ class = "PALADIN", level = 23, },
	[20147]={ class = "PALADIN", level = 24, },
	[20111]={ class = "PALADIN", level = 40, },
	[20112]={ class = "PALADIN", level = 41, },
	[20113]={ class = "PALADIN", level = 42, },
	[9453]={ class = "PALADIN", level = 15, },
	[25836]={ class = "PALADIN", level = 16, },
	[20049]={ class = "PALADIN", level = 35, },
	[20056]={ class = "PALADIN", level = 36, },
	[20057]={ class = "PALADIN", level = 37, },
	[9452]={ class = "PALADIN", level = 20, },
	[26016]={ class = "PALADIN", level = 21, },
	[20929]={ class = "PALADIN", level = 48, },
	[20927]={ class = "PALADIN", level = 50, },
	[20930]={ class = "PALADIN", level = 56, },
	[20928]={ class = "PALADIN", level = 60, },
	[27174]={ class = "PALADIN", level = 64, },
	[27179]={ class = "PALADIN", level = 70, },
	[33072]={ class = "PALADIN", level = 70, },
	[48951]={ class = "PALADIN", level = 75, },
	[48824]={ class = "PALADIN", level = 75, },
	[48952]={ class = "PALADIN", level = 80, },
	[48825]={ class = "PALADIN", level = 80, },
--++ Priest Abilities ++	
	[49868]={ class = "PRIEST", level = 40, },
	[63544]={ class = "PRIEST", level = 1, },
	[2050]={ class = "PRIEST", level = 1, },
	[1243]={ class = "PRIEST", level = 1, },
	[585]={ class = "PRIEST", level = 1, },
	[2052]={ class = "PRIEST", level = 4, },
	[589]={ class = "PRIEST", level = 4, },
	[17]={ class = "PRIEST", level = 6, },
	[591]={ class = "PRIEST", level = 6, },
	[586]={ class = "PRIEST", level = 8, },
	[139]={ class = "PRIEST", level = 8, },
	[2053]={ class = "PRIEST", level = 10, },
	[8092]={ class = "PRIEST", level = 10, },
	[2006]={ class = "PRIEST", level = 10, },
	[594]={ class = "PRIEST", level = 10, },
	[588]={ class = "PRIEST", level = 12, },
	[1244]={ class = "PRIEST", level = 12, },
	[592]={ class = "PRIEST", level = 12, },
	[528]={ class = "PRIEST", level = 14, },
	[8122]={ class = "PRIEST", level = 14, },
	[6074]={ class = "PRIEST", level = 14, },
	[598]={ class = "PRIEST", level = 14, },
	[2054]={ class = "PRIEST", level = 16, },
	[8102]={ class = "PRIEST", level = 16, },
	[527]={ class = "PRIEST", level = 18, },
	[600]={ class = "PRIEST", level = 18, },
	[970]={ class = "PRIEST", level = 18, },
	[70772]={ class = "PRIEST", level = 20, },
	[2944]={ class = "PRIEST", level = 20, },
	[6346]={ class = "PRIEST", level = 20, },
	[2061]={ class = "PRIEST", level = 20, },
	[14914]={ class = "PRIEST", level = 20, },
	[15237]={ class = "PRIEST", level = 20, },
	[7128]={ class = "PRIEST", level = 20, },
	[453]={ class = "PRIEST", level = 20, },
	[6075]={ class = "PRIEST", level = 20, },
	[9484]={ class = "PRIEST", level = 20, },
	[2055]={ class = "PRIEST", level = 22, },
	[8103]={ class = "PRIEST", level = 22, },
	[2096]={ class = "PRIEST", level = 22, },
	[2010]={ class = "PRIEST", level = 22, },
	[984]={ class = "PRIEST", level = 22, },
	[15262]={ class = "PRIEST", level = 24, },
	[8129]={ class = "PRIEST", level = 24, },
	[1245]={ class = "PRIEST", level = 24, },
	[3747]={ class = "PRIEST", level = 24, },
	[9472]={ class = "PRIEST", level = 26, },
	[6076]={ class = "PRIEST", level = 26, },
	[992]={ class = "PRIEST", level = 26, },
	[19276]={ class = "PRIEST", level = 28, },
	[6063]={ class = "PRIEST", level = 28, },
	[15430]={ class = "PRIEST", level = 28, },
	[8104]={ class = "PRIEST", level = 28, },
	[8124]={ class = "PRIEST", level = 28, },
	[14752]={ class = "PRIEST", level = 30, },
	[15263]={ class = "PRIEST", level = 30, },
	[602]={ class = "PRIEST", level = 30, },
	[605]={ class = "PRIEST", level = 30, },
	[6065]={ class = "PRIEST", level = 30, },
	[596]={ class = "PRIEST", level = 30, },
	[976]={ class = "PRIEST", level = 30, },
	[1004]={ class = "PRIEST", level = 30, },
	[552]={ class = "PRIEST", level = 32, },
	[9473]={ class = "PRIEST", level = 32, },
	[6077]={ class = "PRIEST", level = 32, },
	[6064]={ class = "PRIEST", level = 34, },
	[1706]={ class = "PRIEST", level = 34, },
	[8105]={ class = "PRIEST", level = 34, },
	[10880]={ class = "PRIEST", level = 34, },
	[2767]={ class = "PRIEST", level = 34, },
	[19277]={ class = "PRIEST", level = 36, },
	[988]={ class = "PRIEST", level = 36, },
	[15264]={ class = "PRIEST", level = 36, },
	[15431]={ class = "PRIEST", level = 36, },
	[2791]={ class = "PRIEST", level = 36, },
	[6066]={ class = "PRIEST", level = 36, },
	[9474]={ class = "PRIEST", level = 38, },
	[6078]={ class = "PRIEST", level = 38, },
	[6060]={ class = "PRIEST", level = 38, },
	[14818]={ class = "PRIEST", level = 40, },
	[2060]={ class = "PRIEST", level = 40, },
	[1006]={ class = "PRIEST", level = 40, },
	[8106]={ class = "PRIEST", level = 40, },
	[996]={ class = "PRIEST", level = 40, },
	[9485]={ class = "PRIEST", level = 40, },
	[15265]={ class = "PRIEST", level = 42, },
	[10898]={ class = "PRIEST", level = 42, },
	[10888]={ class = "PRIEST", level = 42, },
	[10957]={ class = "PRIEST", level = 42, },
	[10892]={ class = "PRIEST", level = 42, },
	[19278]={ class = "PRIEST", level = 44, },
	[10915]={ class = "PRIEST", level = 44, },
	[27799]={ class = "PRIEST", level = 44, },
	[10909]={ class = "PRIEST", level = 44, },
	[10927]={ class = "PRIEST", level = 44, },
	[10963]={ class = "PRIEST", level = 46, },
	[10945]={ class = "PRIEST", level = 46, },
	[10881]={ class = "PRIEST", level = 46, },
	[10933]={ class = "PRIEST", level = 46, },
	[15266]={ class = "PRIEST", level = 48, },
	[10937]={ class = "PRIEST", level = 48, },
	[10899]={ class = "PRIEST", level = 48, },
	[14819]={ class = "PRIEST", level = 50, },
	[10916]={ class = "PRIEST", level = 50, },
	[10951]={ class = "PRIEST", level = 50, },
	[10960]={ class = "PRIEST", level = 50, },
	[10928]={ class = "PRIEST", level = 50, },
	[10893]={ class = "PRIEST", level = 50, },
	[19279]={ class = "PRIEST", level = 52, },
	[10964]={ class = "PRIEST", level = 52, },
	[27800]={ class = "PRIEST", level = 52, },
	[10946]={ class = "PRIEST", level = 52, },
	[15267]={ class = "PRIEST", level = 54, },
	[10900]={ class = "PRIEST", level = 54, },
	[10934]={ class = "PRIEST", level = 54, },
	[10917]={ class = "PRIEST", level = 56, },
	[10890]={ class = "PRIEST", level = 56, },
	[10929]={ class = "PRIEST", level = 56, },
	[10958]={ class = "PRIEST", level = 56, },
	[10965]={ class = "PRIEST", level = 58, },
	[10947]={ class = "PRIEST", level = 58, },
	[20770]={ class = "PRIEST", level = 58, },
	[10894]={ class = "PRIEST", level = 58, },
	[19280]={ class = "PRIEST", level = 60, },
	[27841]={ class = "PRIEST", level = 60, },
	[25314]={ class = "PRIEST", level = 60, },
	[15261]={ class = "PRIEST", level = 60, },
	[27801]={ class = "PRIEST", level = 60, },
	[10952]={ class = "PRIEST", level = 60, },
	[10938]={ class = "PRIEST", level = 60, },
	[10901]={ class = "PRIEST", level = 60, },
	[10961]={ class = "PRIEST", level = 60, },
	[25316]={ class = "PRIEST", level = 60, },
	[25315]={ class = "PRIEST", level = 60, },
	[10955]={ class = "PRIEST", level = 60, },
	[25233]={ class = "PRIEST", level = 61, },
	[25363]={ class = "PRIEST", level = 61, },
	[32379]={ class = "PRIEST", level = 62, },
	[25210]={ class = "PRIEST", level = 63, },
	[25372]={ class = "PRIEST", level = 63, },
	[32546]={ class = "PRIEST", level = 64, },
	[25217]={ class = "PRIEST", level = 65, },
	[25221]={ class = "PRIEST", level = 65, },
	[25367]={ class = "PRIEST", level = 65, },
	[25384]={ class = "PRIEST", level = 66, },
	[34433]={ class = "PRIEST", level = 66, },
	[25235]={ class = "PRIEST", level = 67, },
	[25467]={ class = "PRIEST", level = 68, },
	[25213]={ class = "PRIEST", level = 68, },
	[25331]={ class = "PRIEST", level = 68, },
	[25308]={ class = "PRIEST", level = 68, },
	[33076]={ class = "PRIEST", level = 68, },
	[25435]={ class = "PRIEST", level = 68, },
	[25433]={ class = "PRIEST", level = 68, },
	[25431]={ class = "PRIEST", level = 69, },
	[25375]={ class = "PRIEST", level = 69, },
	[25364]={ class = "PRIEST", level = 69, },
	[25312]={ class = "PRIEST", level = 70, },
	[32375]={ class = "PRIEST", level = 70, },
	[25389]={ class = "PRIEST", level = 70, },
	[25218]={ class = "PRIEST", level = 70, },
	[25222]={ class = "PRIEST", level = 70, },
	[32996]={ class = "PRIEST", level = 70, },
	[25368]={ class = "PRIEST", level = 70, },
	[48040]={ class = "PRIEST", level = 71, },
	[48119]={ class = "PRIEST", level = 72, },
	[48134]={ class = "PRIEST", level = 72, },
	[48299]={ class = "PRIEST", level = 73, },
	[48070]={ class = "PRIEST", level = 73, },
	[48062]={ class = "PRIEST", level = 73, },
	[48126]={ class = "PRIEST", level = 74, },
	[48112]={ class = "PRIEST", level = 74, },
	[48122]={ class = "PRIEST", level = 74, },
	[48077]={ class = "PRIEST", level = 75, },
	[48045]={ class = "PRIEST", level = 75, },
	[48065]={ class = "PRIEST", level = 75, },
	[48067]={ class = "PRIEST", level = 75, },
	[48157]={ class = "PRIEST", level = 75, },
	[48124]={ class = "PRIEST", level = 75, },
	[48072]={ class = "PRIEST", level = 76, },
	[48169]={ class = "PRIEST", level = 76, },
	[48168]={ class = "PRIEST", level = 77, },
	[48120]={ class = "PRIEST", level = 78, },
	[48063]={ class = "PRIEST", level = 78, },
	[48135]={ class = "PRIEST", level = 78, },
	[48171]={ class = "PRIEST", level = 78, },
	[48300]={ class = "PRIEST", level = 79, },
	[48071]={ class = "PRIEST", level = 79, },
	[48127]={ class = "PRIEST", level = 79, },
	[48113]={ class = "PRIEST", level = 79, },
	[48123]={ class = "PRIEST", level = 79, },
	[64843]={ class = "PRIEST", level = 80, },
	[48073]={ class = "PRIEST", level = 80, },
	[48078]={ class = "PRIEST", level = 80, },
	[64901]={ class = "PRIEST", level = 80, },
	[64904]={ class = "PRIEST", level = 80, },
	[53023]={ class = "PRIEST", level = 80, },
	[48161]={ class = "PRIEST", level = 80, },
	[48066]={ class = "PRIEST", level = 80, },
	[48068]={ class = "PRIEST", level = 80, },
	[48158]={ class = "PRIEST", level = 80, },
	[48125]={ class = "PRIEST", level = 80, },
--++ Priest Talents ++	
	[33167]={ class = "PRIEST", level = 25, },
	[33171]={ class = "PRIEST", level = 26, },
	[33172]={ class = "PRIEST", level = 27, },
	[47507]={ class = "PRIEST", level = 45, },
	[47508]={ class = "PRIEST", level = 46, },
	[27811]={ class = "PRIEST", level = 20, },
	[27815]={ class = "PRIEST", level = 21, },
	[27816]={ class = "PRIEST", level = 22, },
	[33142]={ class = "PRIEST", level = 40, },
	[33145]={ class = "PRIEST", level = 41, },
	[33146]={ class = "PRIEST", level = 42, },
	[64127]={ class = "PRIEST", level = 45, },
	[64129]={ class = "PRIEST", level = 46, },
	[52795]={ class = "PRIEST", level = 55, },
	[52797]={ class = "PRIEST", level = 56, },
	[52798]={ class = "PRIEST", level = 57, },
	[52799]={ class = "PRIEST", level = 58, },
	[52800]={ class = "PRIEST", level = 59, },
	[34861]={ class = "PRIEST", level = 50, },
	[15259]={ class = "PRIEST", level = 10, },
	[15307]={ class = "PRIEST", level = 11, },
	[15308]={ class = "PRIEST", level = 12, },
	[15309]={ class = "PRIEST", level = 13, },
	[15310]={ class = "PRIEST", level = 14, },
	[19236]={ class = "PRIEST", level = 20, },
	[47585]={ class = "PRIEST", level = 60, },
	[47509]={ class = "PRIEST", level = 50, },
	[47511]={ class = "PRIEST", level = 51, },
	[47515]={ class = "PRIEST", level = 52, },
	[18530]={ class = "PRIEST", level = 15, },
	[18531]={ class = "PRIEST", level = 16, },
	[18533]={ class = "PRIEST", level = 17, },
	[18534]={ class = "PRIEST", level = 18, },
	[18535]={ class = "PRIEST", level = 19, },
	[47562]={ class = "PRIEST", level = 55, },
	[47564]={ class = "PRIEST", level = 56, },
	[47565]={ class = "PRIEST", level = 57, },
	[47566]={ class = "PRIEST", level = 58, },
	[47567]={ class = "PRIEST", level = 59, },
	[33158]={ class = "PRIEST", level = 45, },
	[33159]={ class = "PRIEST", level = 46, },
	[33160]={ class = "PRIEST", level = 47, },
	[33161]={ class = "PRIEST", level = 48, },
	[33162]={ class = "PRIEST", level = 49, },
	[63534]={ class = "PRIEST", level = 50, },
	[63542]={ class = "PRIEST", level = 51, },
	[63543]={ class = "PRIEST", level = 52, },
	[34908]={ class = "PRIEST", level = 35, },
	[34909]={ class = "PRIEST", level = 36, },
	[34910]={ class = "PRIEST", level = 37, },
	[33213]={ class = "PRIEST", level = 30, },
	[33214]={ class = "PRIEST", level = 31, },
	[33215]={ class = "PRIEST", level = 32, },
	[33186]={ class = "PRIEST", level = 35, },
	[33190]={ class = "PRIEST", level = 36, },
	[45234]={ class = "PRIEST", level = 40, },
	[45243]={ class = "PRIEST", level = 41, },
	[45244]={ class = "PRIEST", level = 42, },
	[47516]={ class = "PRIEST", level = 50, },
	[47517]={ class = "PRIEST", level = 51, },
	[47788]={ class = "PRIEST", level = 60, },
	[14913]={ class = "PRIEST", level = 10, },
	[15012]={ class = "PRIEST", level = 11, },
	[14911]={ class = "PRIEST", level = 30, },
	[15018]={ class = "PRIEST", level = 31, },
	[34753]={ class = "PRIEST", level = 40, },
	[34859]={ class = "PRIEST", level = 41, },
	[34860]={ class = "PRIEST", level = 42, },
	[27789]={ class = "PRIEST", level = 25, },
	[27790]={ class = "PRIEST", level = 26, },
	[14889]={ class = "PRIEST", level = 10, },
	[15008]={ class = "PRIEST", level = 11, },
	[15009]={ class = "PRIEST", level = 12, },
	[15010]={ class = "PRIEST", level = 13, },
	[15011]={ class = "PRIEST", level = 14, },
	[63625]={ class = "PRIEST", level = 35, },
	[63626]={ class = "PRIEST", level = 36, },
	[63627]={ class = "PRIEST", level = 37, },
	[63504]={ class = "PRIEST", level = 40, },
	[63505]={ class = "PRIEST", level = 41, },
	[63506]={ class = "PRIEST", level = 42, },
	[14912]={ class = "PRIEST", level = 25, },
	[15013]={ class = "PRIEST", level = 26, },
	[15014]={ class = "PRIEST", level = 27, },
	[14747]={ class = "PRIEST", level = 15, },
	[14770]={ class = "PRIEST", level = 16, },
	[14771]={ class = "PRIEST", level = 17, },
	[14750]={ class = "PRIEST", level = 25, },
	[14772]={ class = "PRIEST", level = 26, },
	[15273]={ class = "PRIEST", level = 20, },
	[15312]={ class = "PRIEST", level = 21, },
	[15313]={ class = "PRIEST", level = 22, },
	[15314]={ class = "PRIEST", level = 23, },
	[15316]={ class = "PRIEST", level = 24, },
	[14749]={ class = "PRIEST", level = 15, },
	[14767]={ class = "PRIEST", level = 16, },
	[14748]={ class = "PRIEST", level = 20, },
	[14768]={ class = "PRIEST", level = 21, },
	[14769]={ class = "PRIEST", level = 22, },
	[15392]={ class = "PRIEST", level = 20, },
	[15448]={ class = "PRIEST", level = 21, },
	[14908]={ class = "PRIEST", level = 10, },
	[15020]={ class = "PRIEST", level = 11, },
	[17191]={ class = "PRIEST", level = 12, },
	[15275]={ class = "PRIEST", level = 15, },
	[15317]={ class = "PRIEST", level = 16, },
	[47569]={ class = "PRIEST", level = 45, },
	[47570]={ class = "PRIEST", level = 46, },
	[15337]={ class = "PRIEST", level = 13, },
	[15338]={ class = "PRIEST", level = 14, },
	[27839]={ class = "PRIEST", level = 31, },
	[27840]={ class = "PRIEST", level = 32, },
	[14751]={ class = "PRIEST", level = 20, },
	[14892]={ class = "PRIEST", level = 20, },
	[15362]={ class = "PRIEST", level = 21, },
	[15363]={ class = "PRIEST", level = 22, },
	[724]={ class = "PRIEST", level = 40, },
	[14531]={ class = "PRIEST", level = 15, },
	[14774]={ class = "PRIEST", level = 16, },
	[14521]={ class = "PRIEST", level = 20, },
	[14776]={ class = "PRIEST", level = 21, },
	[14777]={ class = "PRIEST", level = 22, },
	[14520]={ class = "PRIEST", level = 25, },
	[14780]={ class = "PRIEST", level = 26, },
	[14781]={ class = "PRIEST", level = 27, },
	[18551]={ class = "PRIEST", level = 30, },
	[18552]={ class = "PRIEST", level = 31, },
	[18553]={ class = "PRIEST", level = 32, },
	[18554]={ class = "PRIEST", level = 33, },
	[18555]={ class = "PRIEST", level = 34, },
	[15407]={ class = "PRIEST", level = 20, },
	[14910]={ class = "PRIEST", level = 35, },
	[33371]={ class = "PRIEST", level = 36, },
	[33191]={ class = "PRIEST", level = 45, },
	[33192]={ class = "PRIEST", level = 46, },
	[33193]={ class = "PRIEST", level = 47, },
	[47580]={ class = "PRIEST", level = 50, },
	[47581]={ class = "PRIEST", level = 51, },
	[47582]={ class = "PRIEST", level = 52, },
	[33206]={ class = "PRIEST", level = 40, },
	[47540]={ class = "PRIEST", level = 60, },
	[10060]={ class = "PRIEST", level = 40, },
	[64044]={ class = "PRIEST", level = 50, },
	[47535]={ class = "PRIEST", level = 45, },
	[47536]={ class = "PRIEST", level = 46, },
	[47537]={ class = "PRIEST", level = 47, },
	[33201]={ class = "PRIEST", level = 30, },
	[33202]={ class = "PRIEST", level = 31, },
	[57470]={ class = "PRIEST", level = 45, },
	[57472]={ class = "PRIEST", level = 46, },
	[14909]={ class = "PRIEST", level = 25, },
	[15017]={ class = "PRIEST", level = 26, },
	[63730]={ class = "PRIEST", level = 45, },
	[63733]={ class = "PRIEST", level = 46, },
	[63737]={ class = "PRIEST", level = 47, },
	[15318]={ class = "PRIEST", level = 15, },
	[15272]={ class = "PRIEST", level = 16, },
	[15320]={ class = "PRIEST", level = 17, },
	[15260]={ class = "PRIEST", level = 15, },
	[15327]={ class = "PRIEST", level = 16, },
	[15328]={ class = "PRIEST", level = 17, },
	[33221]={ class = "PRIEST", level = 40, },
	[33222]={ class = "PRIEST", level = 41, },
	[33223]={ class = "PRIEST", level = 42, },
	[33224]={ class = "PRIEST", level = 43, },
	[33225]={ class = "PRIEST", level = 44, },
	[17322]={ class = "PRIEST", level = 25, },
	[17323]={ class = "PRIEST", level = 26, },
	[15257]={ class = "PRIEST", level = 25, },
	[15331]={ class = "PRIEST", level = 26, },
	[15332]={ class = "PRIEST", level = 27, },
	[15473]={ class = "PRIEST", level = 40, },
	[14523]={ class = "PRIEST", level = 15, },
	[14784]={ class = "PRIEST", level = 16, },
	[14785]={ class = "PRIEST", level = 17, },
	[63574]={ class = "PRIEST", level = 30, },
	[27900]={ class = "PRIEST", level = 15, },
	[27901]={ class = "PRIEST", level = 16, },
	[27902]={ class = "PRIEST", level = 17, },
	[27903]={ class = "PRIEST", level = 18, },
	[27904]={ class = "PRIEST", level = 19, },
	[20711]={ class = "PRIEST", level = 30, },
	[15270]={ class = "PRIEST", level = 10, },
	[15335]={ class = "PRIEST", level = 11, },
	[15336]={ class = "PRIEST", level = 12, },
	[14901]={ class = "PRIEST", level = 30, },
	[15028]={ class = "PRIEST", level = 31, },
	[15029]={ class = "PRIEST", level = 32, },
	[15030]={ class = "PRIEST", level = 33, },
	[15031]={ class = "PRIEST", level = 34, },
	[14898]={ class = "PRIEST", level = 35, },
	[15349]={ class = "PRIEST", level = 36, },
	[15354]={ class = "PRIEST", level = 37, },
	[15355]={ class = "PRIEST", level = 38, },
	[15356]={ class = "PRIEST", level = 39, },
	[33150]={ class = "PRIEST", level = 35, },
	[33154]={ class = "PRIEST", level = 36, },
	[47558]={ class = "PRIEST", level = 50, },
	[47559]={ class = "PRIEST", level = 51, },
	[47560]={ class = "PRIEST", level = 52, },
	[47586]={ class = "PRIEST", level = 10, },
	[47587]={ class = "PRIEST", level = 11, },
	[47588]={ class = "PRIEST", level = 12, },
	[52802]={ class = "PRIEST", level = 13, },
	[52803]={ class = "PRIEST", level = 14, },
	[47573]={ class = "PRIEST", level = 55, },
	[47577]={ class = "PRIEST", level = 56, },
	[47578]={ class = "PRIEST", level = 57, },
	[51166]={ class = "PRIEST", level = 58, },
	[51167]={ class = "PRIEST", level = 59, },
	[14522]={ class = "PRIEST", level = 10, },
	[14788]={ class = "PRIEST", level = 11, },
	[14789]={ class = "PRIEST", level = 12, },
	[14790]={ class = "PRIEST", level = 13, },
	[14791]={ class = "PRIEST", level = 14, },
	[15286]={ class = "PRIEST", level = 30, },
	[34914]={ class = "PRIEST", level = 50, },
	[15274]={ class = "PRIEST", level = 25, },
	[15311]={ class = "PRIEST", level = 26, },
	[19238]={ class = "PRIEST", level = 26, },
	[17311]={ class = "PRIEST", level = 28, },
	[19240]={ class = "PRIEST", level = 34, },
	[17312]={ class = "PRIEST", level = 36, },
	[19241]={ class = "PRIEST", level = 42, },
	[17313]={ class = "PRIEST", level = 44, },
	[19242]={ class = "PRIEST", level = 50, },
	[27870]={ class = "PRIEST", level = 50, },
	[17314]={ class = "PRIEST", level = 52, },
	[34863]={ class = "PRIEST", level = 56, },
	[19243]={ class = "PRIEST", level = 58, },
	[34864]={ class = "PRIEST", level = 60, },
	[27871]={ class = "PRIEST", level = 60, },
	[18807]={ class = "PRIEST", level = 60, },
	[34916]={ class = "PRIEST", level = 60, },
	[34865]={ class = "PRIEST", level = 65, },
	[25437]={ class = "PRIEST", level = 66, },
	[25387]={ class = "PRIEST", level = 68, },
	[34866]={ class = "PRIEST", level = 70, },
	[28275]={ class = "PRIEST", level = 70, },
	[53005]={ class = "PRIEST", level = 70, },
	[34917]={ class = "PRIEST", level = 70, },
	[48172]={ class = "PRIEST", level = 73, },
	[48155]={ class = "PRIEST", level = 74, },
	[48088]={ class = "PRIEST", level = 75, },
	[48086]={ class = "PRIEST", level = 75, },
	[53006]={ class = "PRIEST", level = 75, },
	[48159]={ class = "PRIEST", level = 75, },
	[48089]={ class = "PRIEST", level = 80, },
	[48173]={ class = "PRIEST", level = 80, },
--++ Rogue Abilities ++	
	[2098]={ class = "ROGUE", level = 1, },
	[1804]={ class = "ROGUE", level = 1, },
	[1752]={ class = "ROGUE", level = 1, },
	[1784]={ class = "ROGUE", level = 1, },
	[53]={ class = "ROGUE", level = 4, },
	[921]={ class = "ROGUE", level = 4, },
	[1776]={ class = "ROGUE", level = 6, },
	[1757]={ class = "ROGUE", level = 6, },
	[5277]={ class = "ROGUE", level = 8, },
	[6760]={ class = "ROGUE", level = 8, },
	[6770]={ class = "ROGUE", level = 10, },
	[5171]={ class = "ROGUE", level = 10, },
	[2983]={ class = "ROGUE", level = 10, },
	[2589]={ class = "ROGUE", level = 12, },
	[1766]={ class = "ROGUE", level = 12, },
	[8647]={ class = "ROGUE", level = 14, },
	[703]={ class = "ROGUE", level = 14, },
	[1758]={ class = "ROGUE", level = 14, },
	[6761]={ class = "ROGUE", level = 16, },
	[1966]={ class = "ROGUE", level = 16, },
	[8676]={ class = "ROGUE", level = 18, },
	[2590]={ class = "ROGUE", level = 20, },
	[51722]={ class = "ROGUE", level = 20, },
	[1943]={ class = "ROGUE", level = 20, },
	[1725]={ class = "ROGUE", level = 22, },
	[8631]={ class = "ROGUE", level = 22, },
	[1759]={ class = "ROGUE", level = 22, },
	[1856]={ class = "ROGUE", level = 22, },
	[2836]={ class = "ROGUE", level = 24, },
	[6762]={ class = "ROGUE", level = 24, },
	[8724]={ class = "ROGUE", level = 26, },
	[1833]={ class = "ROGUE", level = 26, },
	[2591]={ class = "ROGUE", level = 28, },
	[6768]={ class = "ROGUE", level = 28, },
	[8639]={ class = "ROGUE", level = 28, },
	[2070]={ class = "ROGUE", level = 28, },
	[1842]={ class = "ROGUE", level = 30, },
	[8632]={ class = "ROGUE", level = 30, },
	[408]={ class = "ROGUE", level = 30, },
	[1760]={ class = "ROGUE", level = 30, },
	[8623]={ class = "ROGUE", level = 32, },
	[8725]={ class = "ROGUE", level = 34, },
	[2094]={ class = "ROGUE", level = 34, },
	[8696]={ class = "ROGUE", level = 34, },
	[8721]={ class = "ROGUE", level = 36, },
	[8640]={ class = "ROGUE", level = 36, },
	[8633]={ class = "ROGUE", level = 38, },
	[8621]={ class = "ROGUE", level = 38, },
	[8624]={ class = "ROGUE", level = 40, },
	[8637]={ class = "ROGUE", level = 40, },
	[1860]={ class = "ROGUE", level = 40, },
	[11267]={ class = "ROGUE", level = 42, },
	[6774]={ class = "ROGUE", level = 42, },
	[1857]={ class = "ROGUE", level = 42, },
	[11279]={ class = "ROGUE", level = 44, },
	[11273]={ class = "ROGUE", level = 44, },
	[11289]={ class = "ROGUE", level = 46, },
	[11293]={ class = "ROGUE", level = 46, },
	[11299]={ class = "ROGUE", level = 48, },
	[11297]={ class = "ROGUE", level = 48, },
	[11268]={ class = "ROGUE", level = 50, },
	[26669]={ class = "ROGUE", level = 50, },
	[8643]={ class = "ROGUE", level = 50, },
	[11280]={ class = "ROGUE", level = 52, },
	[11303]={ class = "ROGUE", level = 52, },
	[11274]={ class = "ROGUE", level = 52, },
	[11290]={ class = "ROGUE", level = 54, },
	[11294]={ class = "ROGUE", level = 54, },
	[11300]={ class = "ROGUE", level = 56, },
	[11269]={ class = "ROGUE", level = 58, },
	[11305]={ class = "ROGUE", level = 58, },
	[11281]={ class = "ROGUE", level = 60, },
	[25300]={ class = "ROGUE", level = 60, },
	[31016]={ class = "ROGUE", level = 60, },
	[25302]={ class = "ROGUE", level = 60, },
	[11275]={ class = "ROGUE", level = 60, },
	[26839]={ class = "ROGUE", level = 61, },
	[32645]={ class = "ROGUE", level = 62, },
	[26861]={ class = "ROGUE", level = 62, },
	[26889]={ class = "ROGUE", level = 62, },
	[26679]={ class = "ROGUE", level = 64, },
	[26865]={ class = "ROGUE", level = 64, },
	[27448]={ class = "ROGUE", level = 64, },
	[27441]={ class = "ROGUE", level = 66, },
	[31224]={ class = "ROGUE", level = 66, },
	[26863]={ class = "ROGUE", level = 68, },
	[26867]={ class = "ROGUE", level = 68, },
	[32684]={ class = "ROGUE", level = 69, },
	[48689]={ class = "ROGUE", level = 70, },
	[48673]={ class = "ROGUE", level = 70, },
	[26884]={ class = "ROGUE", level = 70, },
	[5938]={ class = "ROGUE", level = 70, },
	[26862]={ class = "ROGUE", level = 70, },
	[51724]={ class = "ROGUE", level = 71, },
	[48658]={ class = "ROGUE", level = 72, },
	[48667]={ class = "ROGUE", level = 73, },
	[48656]={ class = "ROGUE", level = 74, },
	[57992]={ class = "ROGUE", level = 74, },
	[48671]={ class = "ROGUE", level = 74, },
	[48690]={ class = "ROGUE", level = 75, },
	[48675]={ class = "ROGUE", level = 75, },
	[57934]={ class = "ROGUE", level = 75, },
	[48674]={ class = "ROGUE", level = 76, },
	[48637]={ class = "ROGUE", level = 76, },
	[48659]={ class = "ROGUE", level = 78, },
	[48668]={ class = "ROGUE", level = 79, },
	[48672]={ class = "ROGUE", level = 79, },
	[48691]={ class = "ROGUE", level = 80, },
	[48657]={ class = "ROGUE", level = 80, },
	[57993]={ class = "ROGUE", level = 80, },
	[51723]={ class = "ROGUE", level = 80, },
	[48676]={ class = "ROGUE", level = 80, },
	[48638]={ class = "ROGUE", level = 80, },
--++ Rogue Talents ++	
	[13750]={ class = "ROGUE", level = 40, },
	[18427]={ class = "ROGUE", level = 25, },
	[18428]={ class = "ROGUE", level = 26, },
	[18429]={ class = "ROGUE", level = 27, },
	[61330]={ class = "ROGUE", level = 28, },
	[61331]={ class = "ROGUE", level = 29, },
	[13877]={ class = "ROGUE", level = 30, },
	[31124]={ class = "ROGUE", level = 35, },
	[31126]={ class = "ROGUE", level = 36, },
	[51632]={ class = "ROGUE", level = 15, },
	[51633]={ class = "ROGUE", level = 16, },
	[13975]={ class = "ROGUE", level = 15, },
	[14062]={ class = "ROGUE", level = 16, },
	[14063]={ class = "ROGUE", level = 17, },
	[31228]={ class = "ROGUE", level = 40, },
	[31229]={ class = "ROGUE", level = 41, },
	[31230]={ class = "ROGUE", level = 42, },
	[13706]={ class = "ROGUE", level = 20, },
	[13804]={ class = "ROGUE", level = 21, },
	[13805]={ class = "ROGUE", level = 22, },
	[13806]={ class = "ROGUE", level = 23, },
	[13807]={ class = "ROGUE", level = 24, },
	[14177]={ class = "ROGUE", level = 30, },
	[35541]={ class = "ROGUE", level = 45, },
	[35550]={ class = "ROGUE", level = 46, },
	[35551]={ class = "ROGUE", level = 47, },
	[35552]={ class = "ROGUE", level = 48, },
	[35553]={ class = "ROGUE", level = 49, },
	[51664]={ class = "ROGUE", level = 55, },
	[51665]={ class = "ROGUE", level = 56, },
	[51667]={ class = "ROGUE", level = 57, },
	[51668]={ class = "ROGUE", level = 58, },
	[51669]={ class = "ROGUE", level = 59, },
	[31380]={ class = "ROGUE", level = 40, },
	[31382]={ class = "ROGUE", level = 41, },
	[31383]={ class = "ROGUE", level = 42, },
	[30902]={ class = "ROGUE", level = 35, },
	[30903]={ class = "ROGUE", level = 36, },
	[30904]={ class = "ROGUE", level = 37, },
	[30905]={ class = "ROGUE", level = 38, },
	[30906]={ class = "ROGUE", level = 39, },
	[51625]={ class = "ROGUE", level = 40, },
	[51626]={ class = "ROGUE", level = 41, },
	[13713]={ class = "ROGUE", level = 15, },
	[13853]={ class = "ROGUE", level = 16, },
	[13854]={ class = "ROGUE", level = 17, },
	[14082]={ class = "ROGUE", level = 30, },
	[14083]={ class = "ROGUE", level = 31, },
	[14076]={ class = "ROGUE", level = 15, },
	[14094]={ class = "ROGUE", level = 16, },
	[13715]={ class = "ROGUE", level = 10, },
	[13848]={ class = "ROGUE", level = 11, },
	[13849]={ class = "ROGUE", level = 12, },
	[13851]={ class = "ROGUE", level = 13, },
	[13852]={ class = "ROGUE", level = 14, },
	[13981]={ class = "ROGUE", level = 20, },
	[14066]={ class = "ROGUE", level = 21, },
	[13742]={ class = "ROGUE", level = 20, },
	[13872]={ class = "ROGUE", level = 21, },
	[31211]={ class = "ROGUE", level = 40, },
	[31212]={ class = "ROGUE", level = 41, },
	[31213]={ class = "ROGUE", level = 42, },
	[58414]={ class = "ROGUE", level = 50, },
	[58415]={ class = "ROGUE", level = 51, },
	[31234]={ class = "ROGUE", level = 45, },
	[31235]={ class = "ROGUE", level = 46, },
	[31236]={ class = "ROGUE", level = 47, },
	[31208]={ class = "ROGUE", level = 30, },
	[31209]={ class = "ROGUE", level = 31, },
	[51634]={ class = "ROGUE", level = 45, },
	[51635]={ class = "ROGUE", level = 46, },
	[51636]={ class = "ROGUE", level = 47, },
	[14278]={ class = "ROGUE", level = 20, },
	[13960]={ class = "ROGUE", level = 30, },
	[13961]={ class = "ROGUE", level = 31, },
	[13962]={ class = "ROGUE", level = 32, },
	[13963]={ class = "ROGUE", level = 33, },
	[13964]={ class = "ROGUE", level = 34, },
	[30894]={ class = "ROGUE", level = 30, },
	[30895]={ class = "ROGUE", level = 31, },
	[16511]={ class = "ROGUE", level = 30, },
	[51698]={ class = "ROGUE", level = 50, },
	[51700]={ class = "ROGUE", level = 51, },
	[51701]={ class = "ROGUE", level = 52, },
	[51662]={ class = "ROGUE", level = 60, },
	[14079]={ class = "ROGUE", level = 25, },
	[14080]={ class = "ROGUE", level = 26, },
	[14162]={ class = "ROGUE", level = 10, },
	[14163]={ class = "ROGUE", level = 11, },
	[14164]={ class = "ROGUE", level = 12, },
	[14168]={ class = "ROGUE", level = 20, },
	[14169]={ class = "ROGUE", level = 21, },
	[13741]={ class = "ROGUE", level = 10, },
	[13793]={ class = "ROGUE", level = 11, },
	[13792]={ class = "ROGUE", level = 12, },
	[13754]={ class = "ROGUE", level = 25, },
	[13867]={ class = "ROGUE", level = 26, },
	[14174]={ class = "ROGUE", level = 30, },
	[14175]={ class = "ROGUE", level = 31, },
	[14176]={ class = "ROGUE", level = 32, },
	[14113]={ class = "ROGUE", level = 25, },
	[14114]={ class = "ROGUE", level = 26, },
	[14115]={ class = "ROGUE", level = 27, },
	[14116]={ class = "ROGUE", level = 28, },
	[14117]={ class = "ROGUE", level = 29, },
	[13732]={ class = "ROGUE", level = 10, },
	[13863]={ class = "ROGUE", level = 11, },
	[14165]={ class = "ROGUE", level = 15, },
	[14166]={ class = "ROGUE", level = 16, },
	[13743]={ class = "ROGUE", level = 25, },
	[13875]={ class = "ROGUE", level = 26, },
	[13976]={ class = "ROGUE", level = 25, },
	[13979]={ class = "ROGUE", level = 26, },
	[13980]={ class = "ROGUE", level = 27, },
	[51690]={ class = "ROGUE", level = 60, },
	[14128]={ class = "ROGUE", level = 20, },
	[14132]={ class = "ROGUE", level = 21, },
	[14135]={ class = "ROGUE", level = 22, },
	[14136]={ class = "ROGUE", level = 23, },
	[14137]={ class = "ROGUE", level = 24, },
	[13712]={ class = "ROGUE", level = 25, },
	[13788]={ class = "ROGUE", level = 26, },
	[13789]={ class = "ROGUE", level = 27, },
	[13709]={ class = "ROGUE", level = 30, },
	[13800]={ class = "ROGUE", level = 31, },
	[13801]={ class = "ROGUE", level = 32, },
	[13802]={ class = "ROGUE", level = 33, },
	[13803]={ class = "ROGUE", level = 34, },
	[14138]={ class = "ROGUE", level = 10, },
	[14139]={ class = "ROGUE", level = 11, },
	[14140]={ class = "ROGUE", level = 12, },
	[14141]={ class = "ROGUE", level = 13, },
	[14142]={ class = "ROGUE", level = 14, },
	[13958]={ class = "ROGUE", level = 10, },
	[13970]={ class = "ROGUE", level = 11, },
	[13971]={ class = "ROGUE", level = 12, },
	[31221]={ class = "ROGUE", level = 35, },
	[31222]={ class = "ROGUE", level = 36, },
	[31223]={ class = "ROGUE", level = 37, },
	[31226]={ class = "ROGUE", level = 50, },
	[31227]={ class = "ROGUE", level = 51, },
	[58410]={ class = "ROGUE", level = 52, },
	[14158]={ class = "ROGUE", level = 35, },
	[14159]={ class = "ROGUE", level = 36, },
	[1329]={ class = "ROGUE", level = 50, },
	[31130]={ class = "ROGUE", level = 40, },
	[31131]={ class = "ROGUE", level = 41, },
	[14057]={ class = "ROGUE", level = 10, },
	[14072]={ class = "ROGUE", level = 11, },
	[58426]={ class = "ROGUE", level = 40, },
	[13705]={ class = "ROGUE", level = 15, },
	[13832]={ class = "ROGUE", level = 16, },
	[13843]={ class = "ROGUE", level = 17, },
	[13844]={ class = "ROGUE", level = 18, },
	[13845]={ class = "ROGUE", level = 19, },
	[14183]={ class = "ROGUE", level = 40, },
	[14185]={ class = "ROGUE", level = 30, },
	[51685]={ class = "ROGUE", level = 55, },
	[51686]={ class = "ROGUE", level = 56, },
	[51687]={ class = "ROGUE", level = 57, },
	[51688]={ class = "ROGUE", level = 58, },
	[51689]={ class = "ROGUE", level = 59, },
	[13733]={ class = "ROGUE", level = 15, },
	[13865]={ class = "ROGUE", level = 16, },
	[13866]={ class = "ROGUE", level = 17, },
	[31244]={ class = "ROGUE", level = 30, },
	[31245]={ class = "ROGUE", level = 31, },
	[14179]={ class = "ROGUE", level = 10, },
	[58422]={ class = "ROGUE", level = 11, },
	[58423]={ class = "ROGUE", level = 12, },
	[58424]={ class = "ROGUE", level = 13, },
	[58425]={ class = "ROGUE", level = 14, },
	[14144]={ class = "ROGUE", level = 10, },
	[14148]={ class = "ROGUE", level = 11, },
	[14251]={ class = "ROGUE", level = 20, },
	[14156]={ class = "ROGUE", level = 15, },
	[14160]={ class = "ROGUE", level = 16, },
	[14161]={ class = "ROGUE", level = 17, },
	[51682]={ class = "ROGUE", level = 50, },
	[58413]={ class = "ROGUE", level = 51, },
	[14186]={ class = "ROGUE", level = 35, },
	[14190]={ class = "ROGUE", level = 36, },
	[14193]={ class = "ROGUE", level = 37, },
	[14194]={ class = "ROGUE", level = 38, },
	[14195]={ class = "ROGUE", level = 39, },
	[14171]={ class = "ROGUE", level = 20, },
	[14172]={ class = "ROGUE", level = 21, },
	[14173]={ class = "ROGUE", level = 22, },
	[13983]={ class = "ROGUE", level = 25, },
	[14070]={ class = "ROGUE", level = 26, },
	[14071]={ class = "ROGUE", level = 27, },
	[51713]={ class = "ROGUE", level = 60, },
	[36554]={ class = "ROGUE", level = 50, },
	[31216]={ class = "ROGUE", level = 45, },
	[31217]={ class = "ROGUE", level = 46, },
	[31218]={ class = "ROGUE", level = 47, },
	[31219]={ class = "ROGUE", level = 48, },
	[31220]={ class = "ROGUE", level = 49, },
	[51708]={ class = "ROGUE", level = 55, },
	[51709]={ class = "ROGUE", level = 56, },
	[51710]={ class = "ROGUE", level = 57, },
	[51711]={ class = "ROGUE", level = 58, },
	[51712]={ class = "ROGUE", level = 59, },
	[30892]={ class = "ROGUE", level = 15, },
	[30893]={ class = "ROGUE", level = 16, },
	[32601]={ class = "ROGUE", level = 51, },
	[5952]={ class = "ROGUE", level = 45, },
	[51679]={ class = "ROGUE", level = 46, },
	[51627]={ class = "ROGUE", level = 50, },
	[51628]={ class = "ROGUE", level = 51, },
	[51629]={ class = "ROGUE", level = 52, },
	[51672]={ class = "ROGUE", level = 50, },
	[51674]={ class = "ROGUE", level = 51, },
	[14983]={ class = "ROGUE", level = 20, },
	[16513]={ class = "ROGUE", level = 25, },
	[16514]={ class = "ROGUE", level = 26, },
	[16515]={ class = "ROGUE", level = 27, },
	[31122]={ class = "ROGUE", level = 40, },
	[31123]={ class = "ROGUE", level = 41, },
	[61329]={ class = "ROGUE", level = 42, },
	[51692]={ class = "ROGUE", level = 45, },
	[51696]={ class = "ROGUE", level = 46, },
	[30919]={ class = "ROGUE", level = 35, },
	[30920]={ class = "ROGUE", level = 36, },
	[17347]={ class = "ROGUE", level = 46, },
	[34411]={ class = "ROGUE", level = 50, },
	[17348]={ class = "ROGUE", level = 58, },
	[34412]={ class = "ROGUE", level = 60, },
	[26864]={ class = "ROGUE", level = 70, },
	[34413]={ class = "ROGUE", level = 70, },
	[48663]={ class = "ROGUE", level = 75, },
	[48660]={ class = "ROGUE", level = 80, },
	[48666]={ class = "ROGUE", level = 80, },
--++ Shaman Abilities ++	
	[331]={ class = "SHAMAN", level = 1, },
	[403]={ class = "SHAMAN", level = 1, },
	[8017]={ class = "SHAMAN", level = 1, },
	[8042]={ class = "SHAMAN", level = 4, },
	[8071]={ class = "SHAMAN", level = 4, },
	[2484]={ class = "SHAMAN", level = 6, },
	[332]={ class = "SHAMAN", level = 6, },
	[8044]={ class = "SHAMAN", level = 8, },
	[529]={ class = "SHAMAN", level = 8, },
	[324]={ class = "SHAMAN", level = 8, },
	[8018]={ class = "SHAMAN", level = 8, },
	[5730]={ class = "SHAMAN", level = 8, },
	[8050]={ class = "SHAMAN", level = 10, },
	[8024]={ class = "SHAMAN", level = 10, },
	[3599]={ class = "SHAMAN", level = 10, },
	[8075]={ class = "SHAMAN", level = 10, },
	[2008]={ class = "SHAMAN", level = 12, },
	[1535]={ class = "SHAMAN", level = 12, },
	[547]={ class = "SHAMAN", level = 12, },
	[370]={ class = "SHAMAN", level = 12, },
	[8045]={ class = "SHAMAN", level = 14, },
	[548]={ class = "SHAMAN", level = 14, },
	[8154]={ class = "SHAMAN", level = 14, },
	[526]={ class = "SHAMAN", level = 16, },
	[2645]={ class = "SHAMAN", level = 16, },
	[325]={ class = "SHAMAN", level = 16, },
	[8019]={ class = "SHAMAN", level = 16, },
	[57994]={ class = "SHAMAN", level = 16, },
	[8052]={ class = "SHAMAN", level = 18, },
	[8027]={ class = "SHAMAN", level = 18, },
	[913]={ class = "SHAMAN", level = 18, },
	[6390]={ class = "SHAMAN", level = 18, },
	[8143]={ class = "SHAMAN", level = 18, },
	[8056]={ class = "SHAMAN", level = 20, },
	[8033]={ class = "SHAMAN", level = 20, },
	[5394]={ class = "SHAMAN", level = 20, },
	[8004]={ class = "SHAMAN", level = 20, },
	[915]={ class = "SHAMAN", level = 20, },
	[6363]={ class = "SHAMAN", level = 20, },
	[52127]={ class = "SHAMAN", level = 20, },
	[8498]={ class = "SHAMAN", level = 22, },
	[131]={ class = "SHAMAN", level = 22, },
	[20609]={ class = "SHAMAN", level = 24, },
	[8046]={ class = "SHAMAN", level = 24, },
	[8181]={ class = "SHAMAN", level = 24, },
	[939]={ class = "SHAMAN", level = 24, },
	[905]={ class = "SHAMAN", level = 24, },
	[10399]={ class = "SHAMAN", level = 24, },
	[8155]={ class = "SHAMAN", level = 24, },
	[8160]={ class = "SHAMAN", level = 24, },
	[6196]={ class = "SHAMAN", level = 26, },
	[8030]={ class = "SHAMAN", level = 26, },
	[943]={ class = "SHAMAN", level = 26, },
	[8190]={ class = "SHAMAN", level = 26, },
	[5675]={ class = "SHAMAN", level = 26, },
	[8184]={ class = "SHAMAN", level = 28, },
	[8053]={ class = "SHAMAN", level = 28, },
	[8227]={ class = "SHAMAN", level = 28, },
	[8038]={ class = "SHAMAN", level = 28, },
	[8008]={ class = "SHAMAN", level = 28, },
	[6391]={ class = "SHAMAN", level = 28, },
	[52129]={ class = "SHAMAN", level = 28, },
	[546]={ class = "SHAMAN", level = 28, },
	[556]={ class = "SHAMAN", level = 30, },
	[51730]={ class = "SHAMAN", level = 30, },
	[8177]={ class = "SHAMAN", level = 30, },
	[6375]={ class = "SHAMAN", level = 30, },
	[10595]={ class = "SHAMAN", level = 30, },
	[20608]={ class = "SHAMAN", level = 30, },
	[6364]={ class = "SHAMAN", level = 30, },
	[36936]={ class = "SHAMAN", level = 30, },
	[8232]={ class = "SHAMAN", level = 30, },
	[421]={ class = "SHAMAN", level = 32, },
	[8499]={ class = "SHAMAN", level = 32, },
	[959]={ class = "SHAMAN", level = 32, },
	[6041]={ class = "SHAMAN", level = 32, },
	[945]={ class = "SHAMAN", level = 32, },
	[8012]={ class = "SHAMAN", level = 32, },
	[8512]={ class = "SHAMAN", level = 32, },
	[8058]={ class = "SHAMAN", level = 34, },
	[6495]={ class = "SHAMAN", level = 34, },
	[10406]={ class = "SHAMAN", level = 34, },
	[52131]={ class = "SHAMAN", level = 34, },
	[20610]={ class = "SHAMAN", level = 36, },
	[10412]={ class = "SHAMAN", level = 36, },
	[16339]={ class = "SHAMAN", level = 36, },
	[8010]={ class = "SHAMAN", level = 36, },
	[10585]={ class = "SHAMAN", level = 36, },
	[10495]={ class = "SHAMAN", level = 36, },
	[8170]={ class = "SHAMAN", level = 38, },
	[8249]={ class = "SHAMAN", level = 38, },
	[10478]={ class = "SHAMAN", level = 38, },
	[10456]={ class = "SHAMAN", level = 38, },
	[10391]={ class = "SHAMAN", level = 38, },
	[6392]={ class = "SHAMAN", level = 38, },
	[8161]={ class = "SHAMAN", level = 38, },
	[1064]={ class = "SHAMAN", level = 40, },
	[930]={ class = "SHAMAN", level = 40, },
	[51988]={ class = "SHAMAN", level = 40, },
	[10447]={ class = "SHAMAN", level = 40, },
	[6377]={ class = "SHAMAN", level = 40, },
	[8005]={ class = "SHAMAN", level = 40, },
	[8134]={ class = "SHAMAN", level = 40, },
	[6365]={ class = "SHAMAN", level = 40, },
	[8235]={ class = "SHAMAN", level = 40, },
	[52134]={ class = "SHAMAN", level = 41, },
	[11314]={ class = "SHAMAN", level = 42, },
	[10537]={ class = "SHAMAN", level = 42, },
	[10466]={ class = "SHAMAN", level = 44, },
	[10392]={ class = "SHAMAN", level = 44, },
	[10600]={ class = "SHAMAN", level = 44, },
	[10407]={ class = "SHAMAN", level = 44, },
	[10622]={ class = "SHAMAN", level = 46, },
	[16341]={ class = "SHAMAN", level = 46, },
	[10472]={ class = "SHAMAN", level = 46, },
	[10586]={ class = "SHAMAN", level = 46, },
	[10496]={ class = "SHAMAN", level = 46, },
	[20776]={ class = "SHAMAN", level = 48, },
	[2860]={ class = "SHAMAN", level = 48, },
	[10413]={ class = "SHAMAN", level = 48, },
	[10526]={ class = "SHAMAN", level = 48, },
	[16355]={ class = "SHAMAN", level = 48, },
	[10395]={ class = "SHAMAN", level = 48, },
	[10431]={ class = "SHAMAN", level = 48, },
	[10427]={ class = "SHAMAN", level = 48, },
	[52136]={ class = "SHAMAN", level = 48, },
	[51991]={ class = "SHAMAN", level = 50, },
	[10462]={ class = "SHAMAN", level = 50, },
	[15207]={ class = "SHAMAN", level = 50, },
	[10437]={ class = "SHAMAN", level = 50, },
	[10486]={ class = "SHAMAN", level = 50, },
	[11315]={ class = "SHAMAN", level = 52, },
	[10448]={ class = "SHAMAN", level = 52, },
	[10467]={ class = "SHAMAN", level = 52, },
	[10442]={ class = "SHAMAN", level = 52, },
	[10623]={ class = "SHAMAN", level = 54, },
	[10479]={ class = "SHAMAN", level = 54, },
	[10408]={ class = "SHAMAN", level = 54, },
	[52138]={ class = "SHAMAN", level = 55, },
	[10605]={ class = "SHAMAN", level = 56, },
	[16342]={ class = "SHAMAN", level = 56, },
	[10396]={ class = "SHAMAN", level = 56, },
	[15208]={ class = "SHAMAN", level = 56, },
	[10432]={ class = "SHAMAN", level = 56, },
	[10587]={ class = "SHAMAN", level = 56, },
	[10497]={ class = "SHAMAN", level = 56, },
	[10538]={ class = "SHAMAN", level = 58, },
	[16387]={ class = "SHAMAN", level = 58, },
	[10473]={ class = "SHAMAN", level = 58, },
	[16356]={ class = "SHAMAN", level = 58, },
	[10428]={ class = "SHAMAN", level = 58, },
	[20777]={ class = "SHAMAN", level = 60, },
	[10414]={ class = "SHAMAN", level = 60, },
	[51992]={ class = "SHAMAN", level = 60, },
	[29228]={ class = "SHAMAN", level = 60, },
	[10463]={ class = "SHAMAN", level = 60, },
	[25357]={ class = "SHAMAN", level = 60, },
	[10468]={ class = "SHAMAN", level = 60, },
	[10601]={ class = "SHAMAN", level = 60, },
	[10438]={ class = "SHAMAN", level = 60, },
	[25361]={ class = "SHAMAN", level = 60, },
	[16362]={ class = "SHAMAN", level = 60, },
	[25422]={ class = "SHAMAN", level = 61, },
	[25546]={ class = "SHAMAN", level = 61, },
	[25448]={ class = "SHAMAN", level = 62, },
	[24398]={ class = "SHAMAN", level = 62, },
	[25439]={ class = "SHAMAN", level = 63, },
	[25391]={ class = "SHAMAN", level = 63, },
	[25469]={ class = "SHAMAN", level = 63, },
	[25508]={ class = "SHAMAN", level = 63, },
	[25489]={ class = "SHAMAN", level = 64, },
	[3738]={ class = "SHAMAN", level = 64, },
	[25552]={ class = "SHAMAN", level = 65, },
	[25570]={ class = "SHAMAN", level = 65, },
	[25528]={ class = "SHAMAN", level = 65, },
	[2062]={ class = "SHAMAN", level = 66, },
	[25500]={ class = "SHAMAN", level = 66, },
	[25420]={ class = "SHAMAN", level = 66, },
	[25557]={ class = "SHAMAN", level = 67, },
	[25560]={ class = "SHAMAN", level = 67, },
	[25449]={ class = "SHAMAN", level = 67, },
	[25525]={ class = "SHAMAN", level = 67, },
	[25423]={ class = "SHAMAN", level = 68, },
	[2894]={ class = "SHAMAN", level = 68, },
	[25563]={ class = "SHAMAN", level = 68, },
	[25464]={ class = "SHAMAN", level = 68, },
	[25505]={ class = "SHAMAN", level = 68, },
	[25590]={ class = "SHAMAN", level = 69, },
	[25454]={ class = "SHAMAN", level = 69, },
	[25567]={ class = "SHAMAN", level = 69, },
	[25574]={ class = "SHAMAN", level = 69, },
	[25533]={ class = "SHAMAN", level = 69, },
	[33736]={ class = "SHAMAN", level = 69, },
	[25442]={ class = "SHAMAN", level = 70, },
	[51993]={ class = "SHAMAN", level = 70, },
	[25547]={ class = "SHAMAN", level = 70, },
	[25457]={ class = "SHAMAN", level = 70, },
	[25396]={ class = "SHAMAN", level = 70, },
	[25472]={ class = "SHAMAN", level = 70, },
	[25509]={ class = "SHAMAN", level = 70, },
	[58649]={ class = "SHAMAN", level = 71, },
	[58785]={ class = "SHAMAN", level = 71, },
	[58794]={ class = "SHAMAN", level = 71, },
	[58755]={ class = "SHAMAN", level = 71, },
	[58771]={ class = "SHAMAN", level = 71, },
	[58699]={ class = "SHAMAN", level = 71, },
	[58580]={ class = "SHAMAN", level = 71, },
	[58801]={ class = "SHAMAN", level = 71, },
	[49275]={ class = "SHAMAN", level = 72, },
	[49235]={ class = "SHAMAN", level = 73, },
	[49237]={ class = "SHAMAN", level = 73, },
	[58731]={ class = "SHAMAN", level = 73, },
	[58751]={ class = "SHAMAN", level = 73, },
	[55458]={ class = "SHAMAN", level = 74, },
	[49270]={ class = "SHAMAN", level = 74, },
	[49230]={ class = "SHAMAN", level = 74, },
	[61649]={ class = "SHAMAN", level = 75, },
	[58737]={ class = "SHAMAN", level = 75, },
	[49232]={ class = "SHAMAN", level = 75, },
	[58652]={ class = "SHAMAN", level = 75, },
	[58741]={ class = "SHAMAN", level = 75, },
	[49272]={ class = "SHAMAN", level = 75, },
	[51505]={ class = "SHAMAN", level = 75, },
	[49280]={ class = "SHAMAN", level = 75, },
	[58746]={ class = "SHAMAN", level = 75, },
	[58703]={ class = "SHAMAN", level = 75, },
	[58581]={ class = "SHAMAN", level = 75, },
	[57622]={ class = "SHAMAN", level = 75, },
	[58789]={ class = "SHAMAN", level = 76, },
	[58795]={ class = "SHAMAN", level = 76, },
	[58756]={ class = "SHAMAN", level = 76, },
	[58773]={ class = "SHAMAN", level = 76, },
	[57960]={ class = "SHAMAN", level = 76, },
	[58803]={ class = "SHAMAN", level = 76, },
	[49276]={ class = "SHAMAN", level = 77, },
	[49236]={ class = "SHAMAN", level = 78, },
	[58734]={ class = "SHAMAN", level = 78, },
	[58582]={ class = "SHAMAN", level = 78, },
	[58753]={ class = "SHAMAN", level = 78, },
	[49231]={ class = "SHAMAN", level = 79, },
	[49238]={ class = "SHAMAN", level = 79, },
	[49277]={ class = "SHAMAN", level = 80, },
	[55459]={ class = "SHAMAN", level = 80, },
	[49271]={ class = "SHAMAN", level = 80, },
	[51994]={ class = "SHAMAN", level = 80, },
	[61657]={ class = "SHAMAN", level = 80, },
	[58739]={ class = "SHAMAN", level = 80, },
	[49233]={ class = "SHAMAN", level = 80, },
	[58656]={ class = "SHAMAN", level = 80, },
	[58790]={ class = "SHAMAN", level = 80, },
	[58745]={ class = "SHAMAN", level = 80, },
	[58796]={ class = "SHAMAN", level = 80, },
	[58757]={ class = "SHAMAN", level = 80, },
	[49273]={ class = "SHAMAN", level = 80, },
	[51514]={ class = "SHAMAN", level = 80, },
	[60043]={ class = "SHAMAN", level = 80, },
	[49281]={ class = "SHAMAN", level = 80, },
	[58774]={ class = "SHAMAN", level = 80, },
	[58749]={ class = "SHAMAN", level = 80, },
	[58704]={ class = "SHAMAN", level = 80, },
	[58643]={ class = "SHAMAN", level = 80, },
	[58804]={ class = "SHAMAN", level = 80, },
--++ Shaman Talents ++	
	[51556]={ class = "SHAMAN", level = 50, },
	[51557]={ class = "SHAMAN", level = 51, },
	[51558]={ class = "SHAMAN", level = 52, },
	[16176]={ class = "SHAMAN", level = 20, },
	[16235]={ class = "SHAMAN", level = 21, },
	[16240]={ class = "SHAMAN", level = 22, },
	[17485]={ class = "SHAMAN", level = 10, },
	[17486]={ class = "SHAMAN", level = 11, },
	[17487]={ class = "SHAMAN", level = 12, },
	[17488]={ class = "SHAMAN", level = 13, },
	[17489]={ class = "SHAMAN", level = 14, },
	[16254]={ class = "SHAMAN", level = 20, },
	[16271]={ class = "SHAMAN", level = 21, },
	[16272]={ class = "SHAMAN", level = 22, },
	[51474]={ class = "SHAMAN", level = 50, },
	[51478]={ class = "SHAMAN", level = 51, },
	[51479]={ class = "SHAMAN", level = 52, },
	[51554]={ class = "SHAMAN", level = 45, },
	[51555]={ class = "SHAMAN", level = 46, },
	[63370]={ class = "SHAMAN", level = 45, },
	[63372]={ class = "SHAMAN", level = 46, },
	[16038]={ class = "SHAMAN", level = 15, },
	[16160]={ class = "SHAMAN", level = 16, },
	[16161]={ class = "SHAMAN", level = 17, },
	[16041]={ class = "SHAMAN", level = 30, },
	[51886]={ class = "SHAMAN", level = 40, },
	[16035]={ class = "SHAMAN", level = 10, },
	[16105]={ class = "SHAMAN", level = 11, },
	[16106]={ class = "SHAMAN", level = 12, },
	[16107]={ class = "SHAMAN", level = 13, },
	[16108]={ class = "SHAMAN", level = 14, },
	[16039]={ class = "SHAMAN", level = 10, },
	[16109]={ class = "SHAMAN", level = 11, },
	[16110]={ class = "SHAMAN", level = 12, },
	[16111]={ class = "SHAMAN", level = 13, },
	[16112]={ class = "SHAMAN", level = 14, },
	[30798]={ class = "SHAMAN", level = 40, },
	[30816]={ class = "SHAMAN", level = 41, },
	[30818]={ class = "SHAMAN", level = 42, },
	[30819]={ class = "SHAMAN", level = 43, },
	[974]={ class = "SHAMAN", level = 50, },
	[16043]={ class = "SHAMAN", level = 10, },
	[16130]={ class = "SHAMAN", level = 11, },
	[51523]={ class = "SHAMAN", level = 50, },
	[51524]={ class = "SHAMAN", level = 51, },
	[30160]={ class = "SHAMAN", level = 15, },
	[29179]={ class = "SHAMAN", level = 16, },
	[29180]={ class = "SHAMAN", level = 17, },
	[16164]={ class = "SHAMAN", level = 20, },
	[16089]={ class = "SHAMAN", level = 20, },
	[60184]={ class = "SHAMAN", level = 21, },
	[60185]={ class = "SHAMAN", level = 22, },
	[60187]={ class = "SHAMAN", level = 23, },
	[60188]={ class = "SHAMAN", level = 24, },
	[16166]={ class = "SHAMAN", level = 40, },
	[51466]={ class = "SHAMAN", level = 45, },
	[51470]={ class = "SHAMAN", level = 46, },
	[30672]={ class = "SHAMAN", level = 35, },
	[30673]={ class = "SHAMAN", level = 36, },
	[30674]={ class = "SHAMAN", level = 37, },
	[28999]={ class = "SHAMAN", level = 30, },
	[29000]={ class = "SHAMAN", level = 31, },
	[28996]={ class = "SHAMAN", level = 15, },
	[28997]={ class = "SHAMAN", level = 16, },
	[28998]={ class = "SHAMAN", level = 17, },
	[16266]={ class = "SHAMAN", level = 20, },
	[29079]={ class = "SHAMAN", level = 21, },
	[29080]={ class = "SHAMAN", level = 22, },
	[16259]={ class = "SHAMAN", level = 10, },
	[16295]={ class = "SHAMAN", level = 11, },
	[52456]={ class = "SHAMAN", level = 12, },
	[29062]={ class = "SHAMAN", level = 25, },
	[29064]={ class = "SHAMAN", level = 26, },
	[29065]={ class = "SHAMAN", level = 27, },
	[51533]={ class = "SHAMAN", level = 60, },
	[16256]={ class = "SHAMAN", level = 25, },
	[16281]={ class = "SHAMAN", level = 26, },
	[16282]={ class = "SHAMAN", level = 27, },
	[16283]={ class = "SHAMAN", level = 28, },
	[16284]={ class = "SHAMAN", level = 29, },
	[30864]={ class = "SHAMAN", level = 30, },
	[30865]={ class = "SHAMAN", level = 31, },
	[30866]={ class = "SHAMAN", level = 32, },
	[63373]={ class = "SHAMAN", level = 35, },
	[63374]={ class = "SHAMAN", level = 36, },
	[16258]={ class = "SHAMAN", level = 15, },
	[16293]={ class = "SHAMAN", level = 16, },
	[16181]={ class = "SHAMAN", level = 20, },
	[16230]={ class = "SHAMAN", level = 21, },
	[16232]={ class = "SHAMAN", level = 22, },
	[29187]={ class = "SHAMAN", level = 15, },
	[29189]={ class = "SHAMAN", level = 16, },
	[29191]={ class = "SHAMAN", level = 17, },
	[29206]={ class = "SHAMAN", level = 30, },
	[29205]={ class = "SHAMAN", level = 31, },
	[29202]={ class = "SHAMAN", level = 32, },
	[30872]={ class = "SHAMAN", level = 45, },
	[30873]={ class = "SHAMAN", level = 46, },
	[51560]={ class = "SHAMAN", level = 51, },
	[51561]={ class = "SHAMAN", level = 52, },
	[16086]={ class = "SHAMAN", level = 25, },
	[16544]={ class = "SHAMAN", level = 26, },
	[16262]={ class = "SHAMAN", level = 15, },
	[16287]={ class = "SHAMAN", level = 16, },
	[16182]={ class = "SHAMAN", level = 10, },
	[16226]={ class = "SHAMAN", level = 11, },
	[16227]={ class = "SHAMAN", level = 12, },
	[16228]={ class = "SHAMAN", level = 13, },
	[16229]={ class = "SHAMAN", level = 14, },
	[16184]={ class = "SHAMAN", level = 15, },
	[16209]={ class = "SHAMAN", level = 16, },
	[16261]={ class = "SHAMAN", level = 15, },
	[16290]={ class = "SHAMAN", level = 16, },
	[51881]={ class = "SHAMAN", level = 17, },
	[51521]={ class = "SHAMAN", level = 45, },
	[51522]={ class = "SHAMAN", level = 46, },
	[16180]={ class = "SHAMAN", level = 20, },
	[16196]={ class = "SHAMAN", level = 21, },
	[16198]={ class = "SHAMAN", level = 22, },
	[29192]={ class = "SHAMAN", level = 30, },
	[29193]={ class = "SHAMAN", level = 31, },
	[51480]={ class = "SHAMAN", level = 50, },
	[51481]={ class = "SHAMAN", level = 51, },
	[51482]={ class = "SHAMAN", level = 52, },
	[60103]={ class = "SHAMAN", level = 45, },
	[16578]={ class = "SHAMAN", level = 35, },
	[16579]={ class = "SHAMAN", level = 36, },
	[16580]={ class = "SHAMAN", level = 37, },
	[16581]={ class = "SHAMAN", level = 38, },
	[16582]={ class = "SHAMAN", level = 39, },
	[30675]={ class = "SHAMAN", level = 45, },
	[30678]={ class = "SHAMAN", level = 46, },
	[30679]={ class = "SHAMAN", level = 47, },
	[51528]={ class = "SHAMAN", level = 55, },
	[51529]={ class = "SHAMAN", level = 56, },
	[51530]={ class = "SHAMAN", level = 57, },
	[51531]={ class = "SHAMAN", level = 58, },
	[51532]={ class = "SHAMAN", level = 59, },
	[16190]={ class = "SHAMAN", level = 40, },
	[51883]={ class = "SHAMAN", level = 30, },
	[51884]={ class = "SHAMAN", level = 31, },
	[51885]={ class = "SHAMAN", level = 32, },
	[30812]={ class = "SHAMAN", level = 50, },
	[30813]={ class = "SHAMAN", level = 51, },
	[30814]={ class = "SHAMAN", level = 52, },
	[30867]={ class = "SHAMAN", level = 45, },
	[30868]={ class = "SHAMAN", level = 46, },
	[30869]={ class = "SHAMAN", level = 47, },
	[30881]={ class = "SHAMAN", level = 40, },
	[30883]={ class = "SHAMAN", level = 41, },
	[30884]={ class = "SHAMAN", level = 42, },
	[30885]={ class = "SHAMAN", level = 43, },
	[30886]={ class = "SHAMAN", level = 44, },
	[16188]={ class = "SHAMAN", level = 30, },
	[16178]={ class = "SHAMAN", level = 35, },
	[16210]={ class = "SHAMAN", level = 36, },
	[16211]={ class = "SHAMAN", level = 37, },
	[16212]={ class = "SHAMAN", level = 38, },
	[16213]={ class = "SHAMAN", level = 39, },
	[16187]={ class = "SHAMAN", level = 25, },
	[16205]={ class = "SHAMAN", level = 26, },
	[16206]={ class = "SHAMAN", level = 27, },
	[16040]={ class = "SHAMAN", level = 20, },
	[16113]={ class = "SHAMAN", level = 21, },
	[16114]={ class = "SHAMAN", level = 22, },
	[16115]={ class = "SHAMAN", level = 23, },
	[16116]={ class = "SHAMAN", level = 24, },
	[61295]={ class = "SHAMAN", level = 60, },
	[62097]={ class = "SHAMAN", level = 55, },
	[62098]={ class = "SHAMAN", level = 56, },
	[62099]={ class = "SHAMAN", level = 57, },
	[62100]={ class = "SHAMAN", level = 58, },
	[62101]={ class = "SHAMAN", level = 59, },
	[43338]={ class = "SHAMAN", level = 20, },
	[30823]={ class = "SHAMAN", level = 50, },
	[16268]={ class = "SHAMAN", level = 30, },
	[51525]={ class = "SHAMAN", level = 45, },
	[51526]={ class = "SHAMAN", level = 46, },
	[51527]={ class = "SHAMAN", level = 47, },
	[51483]={ class = "SHAMAN", level = 35, },
	[51485]={ class = "SHAMAN", level = 36, },
	[51486]={ class = "SHAMAN", level = 37, },
	[17364]={ class = "SHAMAN", level = 40, },
	[16255]={ class = "SHAMAN", level = 15, },
	[16302]={ class = "SHAMAN", level = 16, },
	[16303]={ class = "SHAMAN", level = 17, },
	[16304]={ class = "SHAMAN", level = 18, },
	[16305]={ class = "SHAMAN", level = 19, },
	[51490]={ class = "SHAMAN", level = 60, },
	[16179]={ class = "SHAMAN", level = 15, },
	[16214]={ class = "SHAMAN", level = 16, },
	[16215]={ class = "SHAMAN", level = 17, },
	[16216]={ class = "SHAMAN", level = 18, },
	[16217]={ class = "SHAMAN", level = 19, },
	[55198]={ class = "SHAMAN", level = 20, },
	[16194]={ class = "SHAMAN", level = 25, },
	[16218]={ class = "SHAMAN", level = 26, },
	[16219]={ class = "SHAMAN", level = 27, },
	[16220]={ class = "SHAMAN", level = 28, },
	[16221]={ class = "SHAMAN", level = 29, },
	[51562]={ class = "SHAMAN", level = 55, },
	[51563]={ class = "SHAMAN", level = 56, },
	[51564]={ class = "SHAMAN", level = 57, },
	[51565]={ class = "SHAMAN", level = 58, },
	[51566]={ class = "SHAMAN", level = 59, },
	[30706]={ class = "SHAMAN", level = 50, },
	[16173]={ class = "SHAMAN", level = 10, },
	[16222]={ class = "SHAMAN", level = 11, },
	[16223]={ class = "SHAMAN", level = 12, },
	[16224]={ class = "SHAMAN", level = 13, },
	[16225]={ class = "SHAMAN", level = 14, },
	[16252]={ class = "SHAMAN", level = 25, },
	[16306]={ class = "SHAMAN", level = 26, },
	[16307]={ class = "SHAMAN", level = 27, },
	[16308]={ class = "SHAMAN", level = 28, },
	[16309]={ class = "SHAMAN", level = 29, },
	[30802]={ class = "SHAMAN", level = 35, },
	[30808]={ class = "SHAMAN", level = 36, },
	[30809]={ class = "SHAMAN", level = 37, },
	[30664]={ class = "SHAMAN", level = 30, },
	[30665]={ class = "SHAMAN", level = 31, },
	[30666]={ class = "SHAMAN", level = 32, },
	[29082]={ class = "SHAMAN", level = 35, },
	[29084]={ class = "SHAMAN", level = 36, },
	[29086]={ class = "SHAMAN", level = 37, },
	[32593]={ class = "SHAMAN", level = 60, },
	[57720]={ class = "SHAMAN", level = 60, },
	[32594]={ class = "SHAMAN", level = 70, },
	[61299]={ class = "SHAMAN", level = 70, },
	[59156]={ class = "SHAMAN", level = 70, },
	[57721]={ class = "SHAMAN", level = 70, },
	[49283]={ class = "SHAMAN", level = 75, },
	[61300]={ class = "SHAMAN", level = 75, },
	[59158]={ class = "SHAMAN", level = 75, },
	[49284]={ class = "SHAMAN", level = 80, },
	[61301]={ class = "SHAMAN", level = 80, },
	[59159]={ class = "SHAMAN", level = 80, },
	[57722]={ class = "SHAMAN", level = 80, },
--++ Warlock Abilities ++	
	[75445]={ class = "WARLOCK", level = 1, },
	[59671]={ class = "WARLOCK", level = 1, },
	[687]={ class = "WARLOCK", level = 1, },
	[348]={ class = "WARLOCK", level = 1, },
	[686]={ class = "WARLOCK", level = 1, },
	[688]={ class = "WARLOCK", level = 1, },
	[172]={ class = "WARLOCK", level = 4, },
	[702]={ class = "WARLOCK", level = 4, },
	[1454]={ class = "WARLOCK", level = 6, },
	[695]={ class = "WARLOCK", level = 6, },
	[980]={ class = "WARLOCK", level = 8, },
	[5782]={ class = "WARLOCK", level = 8, },
	[6201]={ class = "WARLOCK", level = 10, },
	[696]={ class = "WARLOCK", level = 10, },
	[1120]={ class = "WARLOCK", level = 10, },
	[707]={ class = "WARLOCK", level = 10, },
	[697]={ class = "WARLOCK", level = 10, },
	[1108]={ class = "WARLOCK", level = 12, },
	[755]={ class = "WARLOCK", level = 12, },
	[705]={ class = "WARLOCK", level = 12, },
	[6222]={ class = "WARLOCK", level = 14, },
	[689]={ class = "WARLOCK", level = 14, },
	[1455]={ class = "WARLOCK", level = 16, },
	[5697]={ class = "WARLOCK", level = 16, },
	[693]={ class = "WARLOCK", level = 18, },
	[1014]={ class = "WARLOCK", level = 18, },
	[5676]={ class = "WARLOCK", level = 18, },
	[706]={ class = "WARLOCK", level = 20, },
	[5784]={ class = "WARLOCK", level = 20, },
	[3698]={ class = "WARLOCK", level = 20, },
	[1094]={ class = "WARLOCK", level = 20, },
	[5740]={ class = "WARLOCK", level = 20, },
	[698]={ class = "WARLOCK", level = 20, },
	[1088]={ class = "WARLOCK", level = 20, },
	[713]={ class = "WARLOCK", level = 20, },
	[712]={ class = "WARLOCK", level = 20, },
	[6202]={ class = "WARLOCK", level = 22, },
	[6205]={ class = "WARLOCK", level = 22, },
	[699]={ class = "WARLOCK", level = 22, },
	[126]={ class = "WARLOCK", level = 22, },
	[6223]={ class = "WARLOCK", level = 24, },
	[5138]={ class = "WARLOCK", level = 24, },
	[8288]={ class = "WARLOCK", level = 24, },
	[5500]={ class = "WARLOCK", level = 24, },
	[1714]={ class = "WARLOCK", level = 26, },
	[132]={ class = "WARLOCK", level = 26, },
	[1456]={ class = "WARLOCK", level = 26, },
	[17919]={ class = "WARLOCK", level = 26, },
	[710]={ class = "WARLOCK", level = 28, },
	[6366]={ class = "WARLOCK", level = 28, },
	[6217]={ class = "WARLOCK", level = 28, },
	[3699]={ class = "WARLOCK", level = 28, },
	[1106]={ class = "WARLOCK", level = 28, },
	[20752]={ class = "WARLOCK", level = 30, },
	[1086]={ class = "WARLOCK", level = 30, },
	[709]={ class = "WARLOCK", level = 30, },
	[1949]={ class = "WARLOCK", level = 30, },
	[2941]={ class = "WARLOCK", level = 30, },
	[1098]={ class = "WARLOCK", level = 30, },
	[691]={ class = "WARLOCK", level = 30, },
	[1490]={ class = "WARLOCK", level = 32, },
	[7646]={ class = "WARLOCK", level = 32, },
	[6213]={ class = "WARLOCK", level = 32, },
	[6229]={ class = "WARLOCK", level = 32, },
	[7648]={ class = "WARLOCK", level = 34, },
	[5699]={ class = "WARLOCK", level = 34, },
	[6219]={ class = "WARLOCK", level = 34, },
	[17920]={ class = "WARLOCK", level = 34, },
	[17951]={ class = "WARLOCK", level = 36, },
	[2362]={ class = "WARLOCK", level = 36, },
	[3700]={ class = "WARLOCK", level = 36, },
	[11687]={ class = "WARLOCK", level = 36, },
	[7641]={ class = "WARLOCK", level = 36, },
	[11711]={ class = "WARLOCK", level = 38, },
	[7651]={ class = "WARLOCK", level = 38, },
	[8289]={ class = "WARLOCK", level = 38, },
	[20755]={ class = "WARLOCK", level = 40, },
	[11733]={ class = "WARLOCK", level = 40, },
	[23161]={ class = "WARLOCK", level = 40, },
	[5484]={ class = "WARLOCK", level = 40, },
	[11665]={ class = "WARLOCK", level = 40, },
	[11707]={ class = "WARLOCK", level = 42, },
	[6789]={ class = "WARLOCK", level = 42, },
	[11683]={ class = "WARLOCK", level = 42, },
	[17921]={ class = "WARLOCK", level = 42, },
	[11739]={ class = "WARLOCK", level = 42, },
	[11671]={ class = "WARLOCK", level = 44, },
	[11693]={ class = "WARLOCK", level = 44, },
	[11659]={ class = "WARLOCK", level = 44, },
	[11725]={ class = "WARLOCK", level = 44, },
	[17952]={ class = "WARLOCK", level = 46, },
	[11729]={ class = "WARLOCK", level = 46, },
	[11721]={ class = "WARLOCK", level = 46, },
	[11699]={ class = "WARLOCK", level = 46, },
	[11688]={ class = "WARLOCK", level = 46, },
	[11677]={ class = "WARLOCK", level = 46, },
	[18647]={ class = "WARLOCK", level = 48, },
	[17727]={ class = "WARLOCK", level = 48, },
	[11712]={ class = "WARLOCK", level = 48, },
	[6353]={ class = "WARLOCK", level = 48, },
	[20756]={ class = "WARLOCK", level = 50, },
	[11719]={ class = "WARLOCK", level = 50, },
	[17925]={ class = "WARLOCK", level = 50, },
	[11734]={ class = "WARLOCK", level = 50, },
	[11667]={ class = "WARLOCK", level = 50, },
	[1122]={ class = "WARLOCK", level = 50, },
	[17922]={ class = "WARLOCK", level = 50, },
	[11708]={ class = "WARLOCK", level = 52, },
	[11675]={ class = "WARLOCK", level = 52, },
	[11694]={ class = "WARLOCK", level = 52, },
	[11660]={ class = "WARLOCK", level = 52, },
	[11740]={ class = "WARLOCK", level = 52, },
	[11672]={ class = "WARLOCK", level = 54, },
	[11700]={ class = "WARLOCK", level = 54, },
	[11684]={ class = "WARLOCK", level = 54, },
	[17928]={ class = "WARLOCK", level = 54, },
	[17953]={ class = "WARLOCK", level = 56, },
	[6215]={ class = "WARLOCK", level = 56, },
	[11689]={ class = "WARLOCK", level = 56, },
	[17924]={ class = "WARLOCK", level = 56, },
	[11730]={ class = "WARLOCK", level = 58, },
	[11713]={ class = "WARLOCK", level = 58, },
	[17926]={ class = "WARLOCK", level = 58, },
	[11678]={ class = "WARLOCK", level = 58, },
	[17923]={ class = "WARLOCK", level = 58, },
	[11726]={ class = "WARLOCK", level = 58, },
	[25311]={ class = "WARLOCK", level = 60, },
	[20757]={ class = "WARLOCK", level = 60, },
	[17728]={ class = "WARLOCK", level = 60, },
	[603]={ class = "WARLOCK", level = 60, },
	[11722]={ class = "WARLOCK", level = 60, },
	[11735]={ class = "WARLOCK", level = 60, },
	[54785]={ class = "WARLOCK", level = 60, },
	[11695]={ class = "WARLOCK", level = 60, },
	[11668]={ class = "WARLOCK", level = 60, },
	[25309]={ class = "WARLOCK", level = 60, },
	[18540]={ class = "WARLOCK", level = 60, },
	[11661]={ class = "WARLOCK", level = 60, },
	[25307]={ class = "WARLOCK", level = 60, },
	[50581]={ class = "WARLOCK", level = 60, },
	[28610]={ class = "WARLOCK", level = 60, },
	[27224]={ class = "WARLOCK", level = 61, },
	[27219]={ class = "WARLOCK", level = 62, },
	[28176]={ class = "WARLOCK", level = 62, },
	[29722]={ class = "WARLOCK", level = 64, },
	[27211]={ class = "WARLOCK", level = 64, },
	[27216]={ class = "WARLOCK", level = 65, },
	[27210]={ class = "WARLOCK", level = 65, },
	[27250]={ class = "WARLOCK", level = 66, },
	[28172]={ class = "WARLOCK", level = 66, },
	[29858]={ class = "WARLOCK", level = 66, },
	[27218]={ class = "WARLOCK", level = 67, },
	[27217]={ class = "WARLOCK", level = 67, },
	[27259]={ class = "WARLOCK", level = 67, },
	[27230]={ class = "WARLOCK", level = 68, },
	[27223]={ class = "WARLOCK", level = 68, },
	[27213]={ class = "WARLOCK", level = 68, },
	[27222]={ class = "WARLOCK", level = 68, },
	[29893]={ class = "WARLOCK", level = 68, },
	[27228]={ class = "WARLOCK", level = 69, },
	[30909]={ class = "WARLOCK", level = 69, },
	[27220]={ class = "WARLOCK", level = 69, },
	[28189]={ class = "WARLOCK", level = 69, },
	[27215]={ class = "WARLOCK", level = 69, },
	[27212]={ class = "WARLOCK", level = 69, },
	[27209]={ class = "WARLOCK", level = 69, },
	[27238]={ class = "WARLOCK", level = 70, },
	[30910]={ class = "WARLOCK", level = 70, },
	[27260]={ class = "WARLOCK", level = 70, },
	[32231]={ class = "WARLOCK", level = 70, },
	[30459]={ class = "WARLOCK", level = 70, },
	[27243]={ class = "WARLOCK", level = 70, },
	[30545]={ class = "WARLOCK", level = 70, },
	[47812]={ class = "WARLOCK", level = 71, },
	[50511]={ class = "WARLOCK", level = 71, },
	[47886]={ class = "WARLOCK", level = 72, },
	[47819]={ class = "WARLOCK", level = 72, },
	[47890]={ class = "WARLOCK", level = 72, },
	[61191]={ class = "WARLOCK", level = 72, },
	[47871]={ class = "WARLOCK", level = 73, },
	[47863]={ class = "WARLOCK", level = 73, },
	[47859]={ class = "WARLOCK", level = 73, },
	[60219]={ class = "WARLOCK", level = 74, },
	[47892]={ class = "WARLOCK", level = 74, },
	[47837]={ class = "WARLOCK", level = 74, },
	[47814]={ class = "WARLOCK", level = 74, },
	[47808]={ class = "WARLOCK", level = 74, },
	[47810]={ class = "WARLOCK", level = 75, },
	[47835]={ class = "WARLOCK", level = 75, },
	[47897]={ class = "WARLOCK", level = 75, },
	[47824]={ class = "WARLOCK", level = 75, },
	[47884]={ class = "WARLOCK", level = 76, },
	[47793]={ class = "WARLOCK", level = 76, },
	[47856]={ class = "WARLOCK", level = 76, },
	[47813]={ class = "WARLOCK", level = 77, },
	[47855]={ class = "WARLOCK", level = 77, },
	[47888]={ class = "WARLOCK", level = 78, },
	[47865]={ class = "WARLOCK", level = 78, },
	[47860]={ class = "WARLOCK", level = 78, },
	[47857]={ class = "WARLOCK", level = 78, },
	[47823]={ class = "WARLOCK", level = 78, },
	[47891]={ class = "WARLOCK", level = 78, },
	[47878]={ class = "WARLOCK", level = 79, },
	[47864]={ class = "WARLOCK", level = 79, },
	[47893]={ class = "WARLOCK", level = 79, },
	[47820]={ class = "WARLOCK", level = 79, },
	[47815]={ class = "WARLOCK", level = 79, },
	[47809]={ class = "WARLOCK", level = 79, },
	[60220]={ class = "WARLOCK", level = 80, },
	[47867]={ class = "WARLOCK", level = 80, },
	[47889]={ class = "WARLOCK", level = 80, },
	[48018]={ class = "WARLOCK", level = 80, },
	[48020]={ class = "WARLOCK", level = 80, },
	[47811]={ class = "WARLOCK", level = 80, },
	[47838]={ class = "WARLOCK", level = 80, },
	[57946]={ class = "WARLOCK", level = 80, },
	[58887]={ class = "WARLOCK", level = 80, },
	[47836]={ class = "WARLOCK", level = 80, },
	[61290]={ class = "WARLOCK", level = 80, },
	[47825]={ class = "WARLOCK", level = 80, },
--++ Warlock Talents ++	
	[18119]={ class = "WARLOCK", level = 15, },
	[18120]={ class = "WARLOCK", level = 16, },
	[18288]={ class = "WARLOCK", level = 20, },
	[47258]={ class = "WARLOCK", level = 50, },
	[47259]={ class = "WARLOCK", level = 51, },
	[47260]={ class = "WARLOCK", level = 52, },
	[34935]={ class = "WARLOCK", level = 30, },
	[34938]={ class = "WARLOCK", level = 31, },
	[34939]={ class = "WARLOCK", level = 32, },
	[17788]={ class = "WARLOCK", level = 10, },
	[17789]={ class = "WARLOCK", level = 11, },
	[17790]={ class = "WARLOCK", level = 12, },
	[17791]={ class = "WARLOCK", level = 13, },
	[17792]={ class = "WARLOCK", level = 14, },
	[17778]={ class = "WARLOCK", level = 15, },
	[17779]={ class = "WARLOCK", level = 16, },
	[17780]={ class = "WARLOCK", level = 17, },
	[50796]={ class = "WARLOCK", level = 60, },
	[17962]={ class = "WARLOCK", level = 40, },
	[30060]={ class = "WARLOCK", level = 40, },
	[30061]={ class = "WARLOCK", level = 41, },
	[30062]={ class = "WARLOCK", level = 42, },
	[30063]={ class = "WARLOCK", level = 43, },
	[30064]={ class = "WARLOCK", level = 44, },
	[18223]={ class = "WARLOCK", level = 30, },
	[18220]={ class = "WARLOCK", level = 40, },
	[47198]={ class = "WARLOCK", level = 50, },
	[47199]={ class = "WARLOCK", level = 51, },
	[47200]={ class = "WARLOCK", level = 52, },
	[63156]={ class = "WARLOCK", level = 45, },
	[63158]={ class = "WARLOCK", level = 46, },
	[30143]={ class = "WARLOCK", level = 20, },
	[30144]={ class = "WARLOCK", level = 21, },
	[30145]={ class = "WARLOCK", level = 22, },
	[18705]={ class = "WARLOCK", level = 15, },
	[18706]={ class = "WARLOCK", level = 16, },
	[18707]={ class = "WARLOCK", level = 17, },
	[18697]={ class = "WARLOCK", level = 10, },
	[18698]={ class = "WARLOCK", level = 11, },
	[18699]={ class = "WARLOCK", level = 12, },
	[47193]={ class = "WARLOCK", level = 40, },
	[35691]={ class = "WARLOCK", level = 40, },
	[35692]={ class = "WARLOCK", level = 41, },
	[35693]={ class = "WARLOCK", level = 42, },
	[47236]={ class = "WARLOCK", level = 55, },
	[47237]={ class = "WARLOCK", level = 56, },
	[47238]={ class = "WARLOCK", level = 57, },
	[47239]={ class = "WARLOCK", level = 58, },
	[47240]={ class = "WARLOCK", level = 59, },
	[18126]={ class = "WARLOCK", level = 20, },
	[18127]={ class = "WARLOCK", level = 21, },
	[30319]={ class = "WARLOCK", level = 40, },
	[30320]={ class = "WARLOCK", level = 41, },
	[30321]={ class = "WARLOCK", level = 42, },
	[30242]={ class = "WARLOCK", level = 45, },
	[30245]={ class = "WARLOCK", level = 46, },
	[30246]={ class = "WARLOCK", level = 47, },
	[30247]={ class = "WARLOCK", level = 48, },
	[30248]={ class = "WARLOCK", level = 49, },
	[17917]={ class = "WARLOCK", level = 25, },
	[17918]={ class = "WARLOCK", level = 26, },
	[18130]={ class = "WARLOCK", level = 30, },
	[17954]={ class = "WARLOCK", level = 35, },
	[17955]={ class = "WARLOCK", level = 36, },
	[17956]={ class = "WARLOCK", level = 37, },
	[17957]={ class = "WARLOCK", level = 38, },
	[17958]={ class = "WARLOCK", level = 39, },
	[32381]={ class = "WARLOCK", level = 25, },
	[32382]={ class = "WARLOCK", level = 26, },
	[32383]={ class = "WARLOCK", level = 27, },
	[47220]={ class = "WARLOCK", level = 50, },
	[47221]={ class = "WARLOCK", level = 51, },
	[47223]={ class = "WARLOCK", level = 52, },
	[47195]={ class = "WARLOCK", level = 40, },
	[47196]={ class = "WARLOCK", level = 41, },
	[47197]={ class = "WARLOCK", level = 42, },
	[47201]={ class = "WARLOCK", level = 55, },
	[47202]={ class = "WARLOCK", level = 56, },
	[47203]={ class = "WARLOCK", level = 57, },
	[47204]={ class = "WARLOCK", level = 58, },
	[47205]={ class = "WARLOCK", level = 59, },
	[17783]={ class = "WARLOCK", level = 20, },
	[17784]={ class = "WARLOCK", level = 21, },
	[17785]={ class = "WARLOCK", level = 22, },
	[18708]={ class = "WARLOCK", level = 20, },
	[47230]={ class = "WARLOCK", level = 10, },
	[47231]={ class = "WARLOCK", level = 11, },
	[18731]={ class = "WARLOCK", level = 15, },
	[18743]={ class = "WARLOCK", level = 16, },
	[18744]={ class = "WARLOCK", level = 17, },
	[47266]={ class = "WARLOCK", level = 55, },
	[47267]={ class = "WARLOCK", level = 56, },
	[47268]={ class = "WARLOCK", level = 57, },
	[47269]={ class = "WARLOCK", level = 58, },
	[47270]={ class = "WARLOCK", level = 59, },
	[18218]={ class = "WARLOCK", level = 25, },
	[18219]={ class = "WARLOCK", level = 26, },
	[48181]={ class = "WARLOCK", level = 60, },
	[17810]={ class = "WARLOCK", level = 10, },
	[17811]={ class = "WARLOCK", level = 11, },
	[17812]={ class = "WARLOCK", level = 12, },
	[17813]={ class = "WARLOCK", level = 13, },
	[17814]={ class = "WARLOCK", level = 14, },
	[18827]={ class = "WARLOCK", level = 10, },
	[18829]={ class = "WARLOCK", level = 11, },
	[18179]={ class = "WARLOCK", level = 15, },
	[18180]={ class = "WARLOCK", level = 16, },
	[54347]={ class = "WARLOCK", level = 50, },
	[54348]={ class = "WARLOCK", level = 51, },
	[54349]={ class = "WARLOCK", level = 52, },
	[18213]={ class = "WARLOCK", level = 15, },
	[18372]={ class = "WARLOCK", level = 16, },
	[53754]={ class = "WARLOCK", level = 20, },
	[53759]={ class = "WARLOCK", level = 21, },
	[54037]={ class = "WARLOCK", level = 35, },
	[54038]={ class = "WARLOCK", level = 36, },
	[18703]={ class = "WARLOCK", level = 15, },
	[18704]={ class = "WARLOCK", level = 16, },
	[18692]={ class = "WARLOCK", level = 10, },
	[18693]={ class = "WARLOCK", level = 11, },
	[30054]={ class = "WARLOCK", level = 45, },
	[30057]={ class = "WARLOCK", level = 46, },
	[17815]={ class = "WARLOCK", level = 30, },
	[17833]={ class = "WARLOCK", level = 31, },
	[17834]={ class = "WARLOCK", level = 32, },
	[18694]={ class = "WARLOCK", level = 10, },
	[18695]={ class = "WARLOCK", level = 11, },
	[18696]={ class = "WARLOCK", level = 12, },
	[18182]={ class = "WARLOCK", level = 15, },
	[18183]={ class = "WARLOCK", level = 16, },
	[18754]={ class = "WARLOCK", level = 20, },
	[18755]={ class = "WARLOCK", level = 21, },
	[18756]={ class = "WARLOCK", level = 22, },
	[17927]={ class = "WARLOCK", level = 25, },
	[17929]={ class = "WARLOCK", level = 26, },
	[17930]={ class = "WARLOCK", level = 27, },
	[17793]={ class = "WARLOCK", level = 10, },
	[17796]={ class = "WARLOCK", level = 11, },
	[17801]={ class = "WARLOCK", level = 12, },
	[17802]={ class = "WARLOCK", level = 13, },
	[17803]={ class = "WARLOCK", level = 14, },
	[54117]={ class = "WARLOCK", level = 45, },
	[54118]={ class = "WARLOCK", level = 46, },
	[18135]={ class = "WARLOCK", level = 35, },
	[18136]={ class = "WARLOCK", level = 36, },
	[32477]={ class = "WARLOCK", level = 45, },
	[32483]={ class = "WARLOCK", level = 46, },
	[32484]={ class = "WARLOCK", level = 47, },
	[30326]={ class = "WARLOCK", level = 30, },
	[18767]={ class = "WARLOCK", level = 30, },
	[18768]={ class = "WARLOCK", level = 31, },
	[23785]={ class = "WARLOCK", level = 35, },
	[23822]={ class = "WARLOCK", level = 36, },
	[23823]={ class = "WARLOCK", level = 37, },
	[23824]={ class = "WARLOCK", level = 38, },
	[23825]={ class = "WARLOCK", level = 39, },
	[18709]={ class = "WARLOCK", level = 25, },
	[18710]={ class = "WARLOCK", level = 26, },
	[59672]={ class = "WARLOCK", level = 60, },
	[47245]={ class = "WARLOCK", level = 35, },
	[47246]={ class = "WARLOCK", level = 36, },
	[47247]={ class = "WARLOCK", level = 37, },
	[63349]={ class = "WARLOCK", level = 15, },
	[63350]={ class = "WARLOCK", level = 16, },
	[63351]={ class = "WARLOCK", level = 17, },
	[63117]={ class = "WARLOCK", level = 50, },
	[63121]={ class = "WARLOCK", level = 51, },
	[63123]={ class = "WARLOCK", level = 52, },
	[30299]={ class = "WARLOCK", level = 35, },
	[30301]={ class = "WARLOCK", level = 36, },
	[30302]={ class = "WARLOCK", level = 37, },
	[18094]={ class = "WARLOCK", level = 25, },
	[18095]={ class = "WARLOCK", level = 26, },
	[58435]={ class = "WARLOCK", level = 51, },
	[18096]={ class = "WARLOCK", level = 40, },
	[18073]={ class = "WARLOCK", level = 41, },
	[63245]={ class = "WARLOCK", level = 42, },
	[17959]={ class = "WARLOCK", level = 20, },
	[59738]={ class = "WARLOCK", level = 21, },
	[59739]={ class = "WARLOCK", level = 22, },
	[59740]={ class = "WARLOCK", level = 23, },
	[59741]={ class = "WARLOCK", level = 24, },
	[30288]={ class = "WARLOCK", level = 45, },
	[30289]={ class = "WARLOCK", level = 46, },
	[30290]={ class = "WARLOCK", level = 47, },
	[30291]={ class = "WARLOCK", level = 48, },
	[30292]={ class = "WARLOCK", level = 49, },
	[32385]={ class = "WARLOCK", level = 30, },
	[32387]={ class = "WARLOCK", level = 31, },
	[32392]={ class = "WARLOCK", level = 32, },
	[32393]={ class = "WARLOCK", level = 33, },
	[32394]={ class = "WARLOCK", level = 34, },
	[18271]={ class = "WARLOCK", level = 35, },
	[18272]={ class = "WARLOCK", level = 36, },
	[18273]={ class = "WARLOCK", level = 37, },
	[18274]={ class = "WARLOCK", level = 38, },
	[18275]={ class = "WARLOCK", level = 39, },
	[17877]={ class = "WARLOCK", level = 20, },
	[30283]={ class = "WARLOCK", level = 50, },
	[63108]={ class = "WARLOCK", level = 30, },
	[30293]={ class = "WARLOCK", level = 40, },
	[30295]={ class = "WARLOCK", level = 41, },
	[30296]={ class = "WARLOCK", level = 42, },
	[19028]={ class = "WARLOCK", level = 20, },
	[17804]={ class = "WARLOCK", level = 15, },
	[17805]={ class = "WARLOCK", level = 16, },
	[30146]={ class = "WARLOCK", level = 50, },
	[18174]={ class = "WARLOCK", level = 10, },
	[18175]={ class = "WARLOCK", level = 11, },
	[18176]={ class = "WARLOCK", level = 12, },
	[18769]={ class = "WARLOCK", level = 25, },
	[18770]={ class = "WARLOCK", level = 26, },
	[18771]={ class = "WARLOCK", level = 27, },
	[18772]={ class = "WARLOCK", level = 28, },
	[18773]={ class = "WARLOCK", level = 29, },
	[30108]={ class = "WARLOCK", level = 50, },
	[18867]={ class = "WARLOCK", level = 24, },
	[18868]={ class = "WARLOCK", level = 32, },
	[18869]={ class = "WARLOCK", level = 40, },
	[18870]={ class = "WARLOCK", level = 48, },
	[18937]={ class = "WARLOCK", level = 50, },
	[18871]={ class = "WARLOCK", level = 56, },
	[18938]={ class = "WARLOCK", level = 60, },
	[30413]={ class = "WARLOCK", level = 60, },
	[30404]={ class = "WARLOCK", level = 60, },
	[27263]={ class = "WARLOCK", level = 63, },
	[59170]={ class = "WARLOCK", level = 70, },
	[27265]={ class = "WARLOCK", level = 70, },
	[59161]={ class = "WARLOCK", level = 70, },
	[30546]={ class = "WARLOCK", level = 70, },
	[30414]={ class = "WARLOCK", level = 70, },
	[30405]={ class = "WARLOCK", level = 70, },
	[59171]={ class = "WARLOCK", level = 75, },
	[59163]={ class = "WARLOCK", level = 75, },
	[47826]={ class = "WARLOCK", level = 75, },
	[47846]={ class = "WARLOCK", level = 75, },
	[47841]={ class = "WARLOCK", level = 75, },
	[59172]={ class = "WARLOCK", level = 80, },
	[59092]={ class = "WARLOCK", level = 80, },
	[59164]={ class = "WARLOCK", level = 80, },
	[47827]={ class = "WARLOCK", level = 80, },
	[47847]={ class = "WARLOCK", level = 80, },
	[47843]={ class = "WARLOCK", level = 80, },
--++ Warrior Abilities ++	
	[2457]={ class = "WARRIOR", level = 1, },
	[78]={ class = "WARRIOR", level = 1, },
	[100]={ class = "WARRIOR", level = 4, },
	[772]={ class = "WARRIOR", level = 4, },
	[6343]={ class = "WARRIOR", level = 6, },
	[34428]={ class = "WARRIOR", level = 6, },
	[1715]={ class = "WARRIOR", level = 8, },
	[284]={ class = "WARRIOR", level = 8, },
	[2687]={ class = "WARRIOR", level = 10, },
	[71]={ class = "WARRIOR", level = 10, },
	[6546]={ class = "WARRIOR", level = 10, },
	[7386]={ class = "WARRIOR", level = 10, },
	[355]={ class = "WARRIOR", level = 10, },
	[7384]={ class = "WARRIOR", level = 12, },
	[72]={ class = "WARRIOR", level = 12, },
	[6572]={ class = "WARRIOR", level = 14, },
	[285]={ class = "WARRIOR", level = 16, },
	[694]={ class = "WARRIOR", level = 16, },
	[2565]={ class = "WARRIOR", level = 16, },
	[676]={ class = "WARRIOR", level = 18, },
	[8198]={ class = "WARRIOR", level = 18, },
	[845]={ class = "WARRIOR", level = 20, },
	[6547]={ class = "WARRIOR", level = 20, },
	[20230]={ class = "WARRIOR", level = 20, },
	[12678]={ class = "WARRIOR", level = 20, },
	[5308]={ class = "WARRIOR", level = 24, },
	[1608]={ class = "WARRIOR", level = 24, },
	[6574]={ class = "WARRIOR", level = 24, },
	[6178]={ class = "WARRIOR", level = 26, },
	[871]={ class = "WARRIOR", level = 28, },
	[8204]={ class = "WARRIOR", level = 28, },
	[2458]={ class = "WARRIOR", level = 30, },
	[7369]={ class = "WARRIOR", level = 30, },
	[20252]={ class = "WARRIOR", level = 30, },
	[6548]={ class = "WARRIOR", level = 30, },
	[1464]={ class = "WARRIOR", level = 30, },
	[18499]={ class = "WARRIOR", level = 32, },
	[20658]={ class = "WARRIOR", level = 32, },
	[11564]={ class = "WARRIOR", level = 32, },
	[7379]={ class = "WARRIOR", level = 34, },
	[1680]={ class = "WARRIOR", level = 36, },
	[6552]={ class = "WARRIOR", level = 38, },
	[8820]={ class = "WARRIOR", level = 38, },
	[8205]={ class = "WARRIOR", level = 38, },
	[11608]={ class = "WARRIOR", level = 40, },
	[20660]={ class = "WARRIOR", level = 40, },
	[11565]={ class = "WARRIOR", level = 40, },
	[11572]={ class = "WARRIOR", level = 40, },
	[23922]={ class = "WARRIOR", level = 40, },
	[11600]={ class = "WARRIOR", level = 44, },
	[11578]={ class = "WARRIOR", level = 46, },
	[11604]={ class = "WARRIOR", level = 46, },
	[20661]={ class = "WARRIOR", level = 48, },
	[11566]={ class = "WARRIOR", level = 48, },
	[23923]={ class = "WARRIOR", level = 48, },
	[11580]={ class = "WARRIOR", level = 48, },
	[11609]={ class = "WARRIOR", level = 50, },
	[1719]={ class = "WARRIOR", level = 50, },
	[11573]={ class = "WARRIOR", level = 50, },
	[11601]={ class = "WARRIOR", level = 54, },
	[23924]={ class = "WARRIOR", level = 54, },
	[11605]={ class = "WARRIOR", level = 54, },
	[20662]={ class = "WARRIOR", level = 56, },
	[11567]={ class = "WARRIOR", level = 56, },
	[11581]={ class = "WARRIOR", level = 58, },
	[20569]={ class = "WARRIOR", level = 60, },
	[25286]={ class = "WARRIOR", level = 60, },
	[11574]={ class = "WARRIOR", level = 60, },
	[25288]={ class = "WARRIOR", level = 60, },
	[23925]={ class = "WARRIOR", level = 60, },
	[25241]={ class = "WARRIOR", level = 61, },
	[25269]={ class = "WARRIOR", level = 63, },
	[23920]={ class = "WARRIOR", level = 64, },
	[25234]={ class = "WARRIOR", level = 65, },
	[29707]={ class = "WARRIOR", level = 66, },
	[25258]={ class = "WARRIOR", level = 66, },
	[25264]={ class = "WARRIOR", level = 67, },
	[25231]={ class = "WARRIOR", level = 68, },
	[25208]={ class = "WARRIOR", level = 68, },
	[25242]={ class = "WARRIOR", level = 69, },
	[25236]={ class = "WARRIOR", level = 70, },
	[30324]={ class = "WARRIOR", level = 70, },
	[3411]={ class = "WARRIOR", level = 70, },
	[30357]={ class = "WARRIOR", level = 70, },
	[30356]={ class = "WARRIOR", level = 70, },
	[46845]={ class = "WARRIOR", level = 71, },
	[64382]={ class = "WARRIOR", level = 71, },
	[47519]={ class = "WARRIOR", level = 72, },
	[47449]={ class = "WARRIOR", level = 72, },
	[47470]={ class = "WARRIOR", level = 73, },
	[47501]={ class = "WARRIOR", level = 73, },
	[47474]={ class = "WARRIOR", level = 74, },
	[55694]={ class = "WARRIOR", level = 75, },
	[47487]={ class = "WARRIOR", level = 75, },
	[47450]={ class = "WARRIOR", level = 76, },
	[47465]={ class = "WARRIOR", level = 76, },
	[47520]={ class = "WARRIOR", level = 77, },
	[47502]={ class = "WARRIOR", level = 78, },
	[47475]={ class = "WARRIOR", level = 79, },
	[47471]={ class = "WARRIOR", level = 80, },
	[57755]={ class = "WARRIOR", level = 80, },
	[57823]={ class = "WARRIOR", level = 80, },
	[47488]={ class = "WARRIOR", level = 80, },
--++ Warrior Talents ++	
	[12296]={ class = "WARRIOR", level = 20, },
	[12297]={ class = "WARRIOR", level = 15, },
	[12750]={ class = "WARRIOR", level = 16, },
	[12751]={ class = "WARRIOR", level = 17, },
	[12752]={ class = "WARRIOR", level = 18, },
	[12753]={ class = "WARRIOR", level = 19, },
	[61216]={ class = "WARRIOR", level = 10, },
	[61221]={ class = "WARRIOR", level = 11, },
	[61222]={ class = "WARRIOR", level = 12, },
	[46924]={ class = "WARRIOR", level = 60, },
	[16487]={ class = "WARRIOR", level = 20, },
	[16489]={ class = "WARRIOR", level = 21, },
	[16492]={ class = "WARRIOR", level = 22, },
	[29836]={ class = "WARRIOR", level = 50, },
	[29859]={ class = "WARRIOR", level = 51, },
	[46913]={ class = "WARRIOR", level = 50, },
	[46914]={ class = "WARRIOR", level = 51, },
	[46915]={ class = "WARRIOR", level = 52, },
	[23881]={ class = "WARRIOR", level = 40, },
	[12321]={ class = "WARRIOR", level = 10, },
	[12835]={ class = "WARRIOR", level = 11, },
	[12318]={ class = "WARRIOR", level = 20, },
	[12857]={ class = "WARRIOR", level = 21, },
	[12858]={ class = "WARRIOR", level = 22, },
	[12860]={ class = "WARRIOR", level = 23, },
	[12861]={ class = "WARRIOR", level = 24, },
	[12809]={ class = "WARRIOR", level = 30, },
	[47294]={ class = "WARRIOR", level = 50, },
	[47295]={ class = "WARRIOR", level = 51, },
	[47296]={ class = "WARRIOR", level = 52, },
	[12320]={ class = "WARRIOR", level = 10, },
	[12852]={ class = "WARRIOR", level = 11, },
	[12853]={ class = "WARRIOR", level = 12, },
	[12855]={ class = "WARRIOR", level = 13, },
	[12856]={ class = "WARRIOR", level = 14, },
	[58872]={ class = "WARRIOR", level = 55, },
	[58874]={ class = "WARRIOR", level = 56, },
	[12292]={ class = "WARRIOR", level = 40, },
	[12834]={ class = "WARRIOR", level = 22, },
	[12849]={ class = "WARRIOR", level = 23, },
	[12867]={ class = "WARRIOR", level = 24, },
	[16462]={ class = "WARRIOR", level = 10, },
	[16463]={ class = "WARRIOR", level = 11, },
	[16464]={ class = "WARRIOR", level = 12, },
	[16465]={ class = "WARRIOR", level = 13, },
	[16466]={ class = "WARRIOR", level = 14, },
	[20243]={ class = "WARRIOR", level = 50, },
	[23584]={ class = "WARRIOR", level = 25, },
	[23585]={ class = "WARRIOR", level = 26, },
	[23586]={ class = "WARRIOR", level = 27, },
	[23587]={ class = "WARRIOR", level = 28, },
	[23588]={ class = "WARRIOR", level = 29, },
	[29623]={ class = "WARRIOR", level = 50, },
	[12317]={ class = "WARRIOR", level = 25, },
	[13045]={ class = "WARRIOR", level = 26, },
	[13046]={ class = "WARRIOR", level = 27, },
	[13047]={ class = "WARRIOR", level = 28, },
	[13048]={ class = "WARRIOR", level = 29, },
	[12319]={ class = "WARRIOR", level = 35, },
	[12971]={ class = "WARRIOR", level = 36, },
	[12972]={ class = "WARRIOR", level = 37, },
	[12973]={ class = "WARRIOR", level = 38, },
	[12974]={ class = "WARRIOR", level = 39, },
	[29787]={ class = "WARRIOR", level = 40, },
	[29790]={ class = "WARRIOR", level = 41, },
	[29792]={ class = "WARRIOR", level = 42, },
	[46910]={ class = "WARRIOR", level = 45, },
	[46911]={ class = "WARRIOR", level = 46, },
	[12311]={ class = "WARRIOR", level = 30, },
	[12958]={ class = "WARRIOR", level = 31, },
	[60970]={ class = "WARRIOR", level = 50, },
	[16493]={ class = "WARRIOR", level = 20, },
	[16494]={ class = "WARRIOR", level = 21, },
	[20500]={ class = "WARRIOR", level = 35, },
	[20501]={ class = "WARRIOR", level = 36, },
	[29759]={ class = "WARRIOR", level = 45, },
	[29760]={ class = "WARRIOR", level = 46, },
	[29761]={ class = "WARRIOR", level = 47, },
	[29762]={ class = "WARRIOR", level = 48, },
	[29763]={ class = "WARRIOR", level = 49, },
	[12301]={ class = "WARRIOR", level = 10, },
	[12818]={ class = "WARRIOR", level = 11, },
	[12285]={ class = "WARRIOR", level = 15, },
	[12697]={ class = "WARRIOR", level = 16, },
	[12329]={ class = "WARRIOR", level = 20, },
	[12950]={ class = "WARRIOR", level = 21, },
	[20496]={ class = "WARRIOR", level = 22, },
	[29593]={ class = "WARRIOR", level = 40, },
	[29594]={ class = "WARRIOR", level = 41, },
	[12324]={ class = "WARRIOR", level = 15, },
	[12876]={ class = "WARRIOR", level = 16, },
	[12877]={ class = "WARRIOR", level = 17, },
	[12878]={ class = "WARRIOR", level = 18, },
	[12879]={ class = "WARRIOR", level = 19, },
	[12313]={ class = "WARRIOR", level = 25, },
	[12804]={ class = "WARRIOR", level = 26, },
	[12312]={ class = "WARRIOR", level = 30, },
	[12803]={ class = "WARRIOR", level = 31, },
	[20502]={ class = "WARRIOR", level = 25, },
	[20503]={ class = "WARRIOR", level = 26, },
	[12289]={ class = "WARRIOR", level = 35, },
	[12668]={ class = "WARRIOR", level = 36, },
	[23695]={ class = "WARRIOR", level = 37, },
	[12282]={ class = "WARRIOR", level = 10, },
	[12663]={ class = "WARRIOR", level = 11, },
	[12664]={ class = "WARRIOR", level = 12, },
	[29888]={ class = "WARRIOR", level = 40, },
	[29889]={ class = "WARRIOR", level = 41, },
	[35446]={ class = "WARRIOR", level = 45, },
	[35448]={ class = "WARRIOR", level = 46, },
	[35449]={ class = "WARRIOR", level = 47, },
	[12290]={ class = "WARRIOR", level = 20, },
	[12963]={ class = "WARRIOR", level = 21, },
	[12286]={ class = "WARRIOR", level = 10, },
	[12658]={ class = "WARRIOR", level = 11, },
	[12797]={ class = "WARRIOR", level = 20, },
	[12799]={ class = "WARRIOR", level = 21, },
	[12862]={ class = "WARRIOR", level = 40, },
	[12330]={ class = "WARRIOR", level = 41, },
	[59088]={ class = "WARRIOR", level = 25, },
	[59089]={ class = "WARRIOR", level = 26, },
	[12287]={ class = "WARRIOR", level = 10, },
	[12665]={ class = "WARRIOR", level = 11, },
	[12666]={ class = "WARRIOR", level = 12, },
	[29721]={ class = "WARRIOR", level = 40, },
	[29776]={ class = "WARRIOR", level = 41, },
	[50685]={ class = "WARRIOR", level = 15, },
	[50686]={ class = "WARRIOR", level = 16, },
	[50687]={ class = "WARRIOR", level = 17, },
	[46908]={ class = "WARRIOR", level = 40, },
	[46909]={ class = "WARRIOR", level = 41, },
	[56924]={ class = "WARRIOR", level = 42, },
	[12300]={ class = "WARRIOR", level = 15, },
	[12959]={ class = "WARRIOR", level = 16, },
	[12960]={ class = "WARRIOR", level = 17, },
	[64976]={ class = "WARRIOR", level = 45, },
	[12975]={ class = "WARRIOR", level = 20, },
	[12284]={ class = "WARRIOR", level = 30, },
	[12701]={ class = "WARRIOR", level = 31, },
	[12702]={ class = "WARRIOR", level = 32, },
	[12703]={ class = "WARRIOR", level = 33, },
	[12704]={ class = "WARRIOR", level = 34, },
	[12294]={ class = "WARRIOR", level = 40, },
	[16538]={ class = "WARRIOR", level = 35, },
	[16539]={ class = "WARRIOR", level = 36, },
	[16540]={ class = "WARRIOR", level = 37, },
	[16541]={ class = "WARRIOR", level = 38, },
	[16542]={ class = "WARRIOR", level = 39, },
	[12323]={ class = "WARRIOR", level = 20, },
	[12700]={ class = "WARRIOR", level = 30, },
	[12781]={ class = "WARRIOR", level = 31, },
	[12783]={ class = "WARRIOR", level = 32, },
	[12784]={ class = "WARRIOR", level = 33, },
	[12785]={ class = "WARRIOR", level = 34, },
	[29590]={ class = "WARRIOR", level = 30, },
	[29591]={ class = "WARRIOR", level = 31, },
	[29592]={ class = "WARRIOR", level = 32, },
	[12308]={ class = "WARRIOR", level = 25, },
	[12810]={ class = "WARRIOR", level = 26, },
	[12811]={ class = "WARRIOR", level = 27, },
	[29801]={ class = "WARRIOR", level = 50, },
	[46945]={ class = "WARRIOR", level = 45, },
	[46949]={ class = "WARRIOR", level = 46, },
	[29834]={ class = "WARRIOR", level = 40, },
	[29838]={ class = "WARRIOR", level = 41, },
	[29598]={ class = "WARRIOR", level = 20, },
	[29599]={ class = "WARRIOR", level = 21, },
	[12298]={ class = "WARRIOR", level = 10, },
	[12724]={ class = "WARRIOR", level = 11, },
	[12725]={ class = "WARRIOR", level = 12, },
	[12726]={ class = "WARRIOR", level = 13, },
	[12727]={ class = "WARRIOR", level = 14, },
	[46968]={ class = "WARRIOR", level = 60, },
	[46865]={ class = "WARRIOR", level = 40, },
	[46866]={ class = "WARRIOR", level = 41, },
	[29723]={ class = "WARRIOR", level = 50, },
	[29724]={ class = "WARRIOR", level = 51, },
	[29725]={ class = "WARRIOR", level = 52, },
	[12328]={ class = "WARRIOR", level = 30, },
	[46951]={ class = "WARRIOR", level = 55, },
	[46952]={ class = "WARRIOR", level = 56, },
	[46953]={ class = "WARRIOR", level = 57, },
	[12281]={ class = "WARRIOR", level = 30, },
	[12812]={ class = "WARRIOR", level = 31, },
	[12813]={ class = "WARRIOR", level = 32, },
	[12814]={ class = "WARRIOR", level = 33, },
	[12815]={ class = "WARRIOR", level = 34, },
	[12295]={ class = "WARRIOR", level = 15, },
	[12676]={ class = "WARRIOR", level = 16, },
	[12677]={ class = "WARRIOR", level = 17, },
	[56636]={ class = "WARRIOR", level = 25, },
	[56637]={ class = "WARRIOR", level = 26, },
	[56638]={ class = "WARRIOR", level = 27, },
	[46917]={ class = "WARRIOR", level = 60, },
	[12299]={ class = "WARRIOR", level = 20, },
	[12761]={ class = "WARRIOR", level = 21, },
	[12762]={ class = "WARRIOR", level = 22, },
	[12763]={ class = "WARRIOR", level = 23, },
	[12764]={ class = "WARRIOR", level = 24, },
	[46854]={ class = "WARRIOR", level = 35, },
	[46855]={ class = "WARRIOR", level = 36, },
	[12163]={ class = "WARRIOR", level = 25, },
	[12711]={ class = "WARRIOR", level = 26, },
	[12712]={ class = "WARRIOR", level = 27, },
	[12322]={ class = "WARRIOR", level = 15, },
	[12999]={ class = "WARRIOR", level = 16, },
	[13000]={ class = "WARRIOR", level = 17, },
	[13001]={ class = "WARRIOR", level = 18, },
	[13002]={ class = "WARRIOR", level = 19, },
	[56927]={ class = "WARRIOR", level = 55, },
	[56929]={ class = "WARRIOR", level = 56, },
	[56930]={ class = "WARRIOR", level = 57, },
	[56931]={ class = "WARRIOR", level = 58, },
	[56932]={ class = "WARRIOR", level = 59, },
	[46859]={ class = "WARRIOR", level = 45, },
	[46860]={ class = "WARRIOR", level = 46, },
	[50720]={ class = "WARRIOR", level = 40, },
	[29140]={ class = "WARRIOR", level = 45, },
	[29143]={ class = "WARRIOR", level = 46, },
	[29144]={ class = "WARRIOR", level = 47, },
	[57499]={ class = "WARRIOR", level = 50, },
	[20504]={ class = "WARRIOR", level = 35, },
	[20505]={ class = "WARRIOR", level = 36, },
	[46867]={ class = "WARRIOR", level = 55, },
	[56611]={ class = "WARRIOR", level = 56, },
	[56612]={ class = "WARRIOR", level = 57, },
	[56613]={ class = "WARRIOR", level = 58, },
	[56614]={ class = "WARRIOR", level = 59, },
	[21551]={ class = "WARRIOR", level = 48, },
	[21552]={ class = "WARRIOR", level = 54, },
	[30016]={ class = "WARRIOR", level = 60, },
	[21553]={ class = "WARRIOR", level = 60, },
	[25248]={ class = "WARRIOR", level = 66, },
	[30022]={ class = "WARRIOR", level = 70, },
	[30330]={ class = "WARRIOR", level = 70, },
	[47497]={ class = "WARRIOR", level = 75, },
	[47485]={ class = "WARRIOR", level = 75, },
	[47498]={ class = "WARRIOR", level = 80, },
	[47486]={ class = "WARRIOR", level = 80, },
--++++++++++	
	[3714]={ level = 1, },
	[60068]={ level = 1, },
	[57330]={ level = 1, },
	[57623]={ level = 1, },
	[53137]={ level = 1, },
	[53138]={ level = 1, },
	[51052]={ level = 1, },
	[49016]={ level = 1, },
	[467]={ level = 1, },
	[782]={ level = 1, },
	[1075]={ level = 1, },
	[8914]={ level = 1, },
	[9756]={ level = 1, },
	[21849]={ level = 1, },
	[9910]={ level = 1, },
	[21850]={ level = 1, },
	[26992]={ level = 1, },
	[26991]={ level = 1, },
	[53307]={ level = 1, },
	[48470]={ level = 1, },
	[13159]={ level = 1, },
	[20190]={ level = 1, },
	[27045]={ level = 1, },
	[49071]={ level = 1, },
	[19506]={ level = 1, },
	[604]={ level = 1, },
	[1008]={ level = 1, },
	[8450]={ level = 1, },
	[8455]={ level = 1, },
	[8451]={ level = 1, },
	[10169]={ level = 1, },
	[10173]={ level = 1, },
	[10170]={ level = 1, },
	[23028]={ level = 1, },
	[10174]={ level = 1, },
	[27130]={ level = 1, },
	[33944]={ level = 1, },
	[33946]={ level = 1, },
	[27127]={ level = 1, },
	[43015]={ level = 1, },
	[43017]={ level = 1, },
	[43002]={ level = 1, },
	[465]={ level = 1, },
	[19740]={ level = 1, },
	[10290]={ level = 1, },
	[19834]={ level = 1, },
	[19742]={ level = 1, },
	[7294]={ level = 1, },
	[20217]={ level = 1, },
	[643]={ level = 1, },
	[19835]={ level = 1, },
	[19746]={ level = 1, },
	[19850]={ level = 1, },
	[10298]={ level = 1, },
	[19876]={ level = 1, },
	[10291]={ level = 1, },
	[19836]={ level = 1, },
	[19888]={ level = 1, },
	[19852]={ level = 1, },
	[19891]={ level = 1, },
	[10299]={ level = 1, },
	[1032]={ level = 1, },
	[19895]={ level = 1, },
	[19837]={ level = 1, },
	[19853]={ level = 1, },
	[19897]={ level = 1, },
	[10300]={ level = 1, },
	[19899]={ level = 1, },
	[10292]={ level = 1, },
	[19838]={ level = 1, },
	[25782]={ level = 1, },
	[19896]={ level = 1, },
	[19854]={ level = 1, },
	[25894]={ level = 1, },
	[19898]={ level = 1, },
	[10301]={ level = 1, },
	[25291]={ level = 1, },
	[25290]={ level = 1, },
	[10293]={ level = 1, },
	[19900]={ level = 1, },
	[25898]={ level = 1, },
	[25916]={ level = 1, },
	[25899]={ level = 1, },
	[25918]={ level = 1, },
	[32223]={ level = 1, },
	[27151]={ level = 1, },
	[27142]={ level = 1, },
	[27143]={ level = 1, },
	[27150]={ level = 1, },
	[27152]={ level = 1, },
	[27140]={ level = 1, },
	[27149]={ level = 1, },
	[27153]={ level = 1, },
	[27141]={ level = 1, },
	[48935]={ level = 1, },
	[48937]={ level = 1, },
	[48931]={ level = 1, },
	[48933]={ level = 1, },
	[48941]={ level = 1, },
	[54043]={ level = 1, },
	[48943]={ level = 1, },
	[48936]={ level = 1, },
	[48945]={ level = 1, },
	[48938]={ level = 1, },
	[48947]={ level = 1, },
	[48932]={ level = 1, },
	[48942]={ level = 1, },
	[48934]={ level = 1, },
	[31821]={ level = 1, },
	[31935]={ level = 1, },
	[20911]={ level = 1, },
	[32699]={ level = 1, },
	[32700]={ level = 1, },
	[48826]={ level = 1, },
	[48827]={ level = 1, },
	[21562]={ level = 1, },
	[27683]={ level = 1, },
	[21564]={ level = 1, },
	[27681]={ level = 1, },
	[25392]={ level = 1, },
	[39374]={ level = 1, },
	[32999]={ level = 1, },
	[48170]={ level = 1, },
	[48162]={ level = 1, },
	[48074]={ level = 1, },
	[15487]={ level = 1, },
	[2825]={ level = 1, },
	[32182]={ level = 1, },
	[50589]={ level = 1, },
	[6673]={ level = 1, },
	[5242]={ level = 1, },
	[1160]={ level = 1, },
	[6192]={ level = 1, },
	[5246]={ level = 1, },
	[6190]={ level = 1, },
	[1161]={ level = 1, },
	[11549]={ level = 1, },
	[11554]={ level = 1, },
	[11550]={ level = 1, },
	[11555]={ level = 1, },
	[11551]={ level = 1, },
	[11556]={ level = 1, },
	[25289]={ level = 1, },
	[25202]={ level = 1, },
	[469]={ level = 1, },
	[2048]={ level = 1, },
	[25203]={ level = 1, },
	[47439]={ level = 1, },
	[47436]={ level = 1, },
	[47437]={ level = 1, },
	[47440]={ level = 1, },
	[8690]={ level = 1, },
	[2383]={ level = 1, },
	[8387]={ level = 1, },
	[2580]={ level = 1, },
	[8388]={ level = 1, },
	[43308]={ level = 1, },
	[58179]={ level = 1, },
	[58180]={ level = 1, },
	[58181]={ level = 1, },
	[377749]={ level = 1, },
};