local AceLocale = _G.LibStub("AceLocale-3.0")
local Loc = AceLocale:GetLocale("Details_Threat")
local SharedMedia = LibStub:GetLibrary ("LibSharedMedia-3.0")
local _

local GetNumGroupMembers = _G.GetNumGroupMembers --> wow api
local UnitIsFriend = _G.UnitIsFriend --> wow api
local UnitName = _G.UnitName --> wow api
local UnitDetailedThreatSituation = _G.UnitDetailedThreatSituation
local IsInRaid = _G.IsInRaid --> wow api
local IsInGroup = _G.IsInGroup --> wow api
local CheckInteractDistance = _G.CheckInteractDistance
local GetUnitName = _G.GetUnitName
local UnitExists = _G.UnitExists
local IsInInstance = _G.IsInInstance
local UnitClass = _G.UnitClass
local UnitGUID = _G.UnitGUID

local ANIMATION_TIME_DILATATION = 1.005321

local _UnitGroupRolesAssigned = function (unitId)
	if (type (unitId) == "string") then
		local guid = UnitGUID(unitId)
		if (guid) then
			local playerSpec = Details.cached_specs [guid]
			if (playerSpec) then
				local role = Details:GetRoleFromSpec(playerSpec, guid) or "NONE"
				return role
			end
		end
		return "NONE"
	end
end

local _DEBUG = true

local ipairs = _G.ipairs
local tableSort = table.sort
local format = string.format
local unpack = _G.unpack
local floor = math.floor
local abs = math.abs
local RAID_CLASS_COLORS = _G.RAID_CLASS_COLORS

local RoleIconCoord = {
	["TANK"] = {0, 0.28125, 0.328125, 0.625},
	["HEALER"] = {0.3125, 0.59375, 0, 0.296875},
	["DAMAGER"] = {0.3125, 0.59375, 0.328125, 0.625},
	["NONE"] = {0.3125, 0.59375, 0.328125, 0.625}
}

--> Create the plugin Object
local ThreatMeter = _G.Details:NewPluginObject ("Details_TinyThreat")
--> Main Frame
local ThreatMeterFrame = ThreatMeter.Frame

ThreatMeter:SetPluginDescription ("Small tool for track the threat you and other raid members have in your current target.")

local _UnitDetailedThreatSituation = function(unit, mob)
	local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation(unit, mob)
	--divide the threat by 100
	if (threatvalue) then
		if (ThreatMeter.db.dividebyhundred) then
			threatvalue = floor(threatvalue / 100)
		end
	end
	return isTanking, status, threatpct, rawthreatpct, threatvalue
end

local function CreatePluginFrames()
	
	--> catch Details! main object
	local _detalhes = _G._detalhes
	local DetailsFrameWork = _detalhes.gump
	
	--> defaults
	ThreatMeter.RowWidth = 294
	ThreatMeter.RowHeight = 14
	--> amount of row wich can be displayed
	ThreatMeter.CanShow = 0
	--> all rows already created
	ThreatMeter.Rows = {}
	--> current shown rows
	ThreatMeter.ShownRows = {}
	-->
	ThreatMeter.Actived = false
	
	--> localize functions
	ThreatMeter.percent_color = ThreatMeter.percent_color
	
	ThreatMeter.GetOnlyName = ThreatMeter.GetOnlyName
	
	--> window reference
	local instance
	local player
	local target

	local optionsLabel = DetailsFrameWork:CreateLabel(ThreatMeterFrame, "/tt ot /tinythreat for options")
	optionsLabel:SetPoint("bottomleft", ThreatMeterFrame, "bottomleft", 1, 1)
	optionsLabel:Hide()
	ThreatMeter.optionsLabel = optionsLabel
	
	--> OnEvent Table
	--when an event happens on Details and it triggers a callback on registered details events on this plugin
	function ThreatMeter:OnDetailsEvent (event, ...)
	
		if (event == "DETAILS_STARTED") then
			ThreatMeter:RefreshRows()
			
		elseif (event == "HIDE") then --> plugin hidded, disabled
			ThreatMeter.Actived = false
			ThreatMeter:Cancel()
		
		--the window hosting tiny threat is shown
		elseif (event == "SHOW") then
		
			instance = ThreatMeter:GetInstance(ThreatMeter.instance_id)
			
			ThreatMeter.RowWidth = instance.baseframe:GetWidth()-6
			
			ThreatMeter:UpdateContainers()
			ThreatMeter:UpdateRows()
			
			ThreatMeter:SizeChanged()
			
			player = GetUnitName("player", true)
			
			ThreatMeter.Actived = false

			if (ThreatMeter:IsInCombat() or UnitAffectingCombat("player")) then
				--check if the plugin is already initialized
				if (not ThreatMeter.initialized) then
					return
				end
				ThreatMeter.Actived = true
				ThreatMeter:Start()
			end

			if(ThreatMeter.options) then
				if (not ThreatMeter.db.openedfromcommand) then
					optionsLabel:Show()
				end
			end
		
		elseif (event == "COMBAT_PLAYER_ENTER") then
			if (not ThreatMeter.Actived) then
				ThreatMeter.Actived = true
				ThreatMeter:Start()
			end
		
		elseif (event == "DETAILS_INSTANCE_ENDRESIZE" or event == "DETAILS_INSTANCE_SIZECHANGED") then
		
			local what_window = select (1, ...)
			if (what_window == instance) then
				ThreatMeter:SizeChanged()
				ThreatMeter:RefreshRows()
			end
			
		elseif (event == "DETAILS_OPTIONS_MODIFIED") then
			local what_window = select (1, ...)
			if (what_window == instance) then
				ThreatMeter:RefreshRows()
			end
		
		elseif (event == "DETAILS_INSTANCE_STARTSTRETCH") then
			ThreatMeterFrame:SetFrameStrata ("TOOLTIP")
			ThreatMeterFrame:SetFrameLevel (instance.baseframe:GetFrameLevel()+1)
		
		elseif (event == "DETAILS_INSTANCE_ENDSTRETCH") then
			ThreatMeterFrame:SetFrameStrata ("MEDIUM")
			
		elseif (event == "PLUGIN_DISABLED") then
			ThreatMeterFrame:UnregisterEvent ("PLAYER_TARGET_CHANGED")
			ThreatMeterFrame:UnregisterEvent ("PLAYER_REGEN_DISABLED")
			ThreatMeterFrame:UnregisterEvent ("PLAYER_REGEN_ENABLED")
				
		elseif (event == "PLUGIN_ENABLED") then
			ThreatMeterFrame:RegisterEvent ("PLAYER_TARGET_CHANGED")
			ThreatMeterFrame:RegisterEvent ("PLAYER_REGEN_DISABLED")
			ThreatMeterFrame:RegisterEvent ("PLAYER_REGEN_ENABLED")
		end
	end

	--instance is the window showing the plugin
	function ThreatMeter:UpdateContainers()
		for _, row in ipairs(ThreatMeter.Rows) do
			row:SetContainer(instance.baseframe)
		end
	end

	--rows are the bars showing the threat
	function ThreatMeter:UpdateRows()
		for _, row in ipairs(ThreatMeter.Rows) do
			row.width = ThreatMeter.RowWidth
		end
	end

	function ThreatMeter:HideBars()
		for _, row in ipairs(ThreatMeter.Rows) do
			row:Hide()
		end
	end

	--if two players has the same amount of threat
	function ThreatMeter:GetNameOrder(playerName)
		local name = string.upper(playerName .. "zz")
		local byte1 = math.abs(string.byte (name, 2)-91)/1000000
		return byte1 + math.abs(string.byte (name, 1)-91)/10000
	end
		
	--when a new target is selected, show the unit name in the title of the window
	function ThreatMeter.UpdateWindowTitle(newTitle)
		local windowInstance = ThreatMeter:GetPluginInstance()
		if (windowInstance and windowInstance.menu_attribute_string) then
			if (not newTitle) then
				windowInstance.menu_attribute_string.text = "Tiny Threat"
			else
				windowInstance.menu_attribute_string:SetTextTruncated (newTitle, windowInstance.baseframe:GetWidth() - 60)
			end
		end
	end
	
	--> animation with acceleration ~animation ~healthbaranimation
	function ThreatMeter.AnimateLeftWithAccel(self, deltaTime)
		local distance = (self.AnimationStart - self.AnimationEnd) / self.CurrentPercentMax * 100	--scale 1 - 100
		local minTravel = min(distance / 10, 3) -- 10 = trigger distance to max speed 3 = speed scale on max travel
		local maxTravel = max(minTravel, 0.45) -- 0.45 = min scale speed on low travel speed
		local calcAnimationSpeed = (self.CurrentPercentMax * (deltaTime * ANIMATION_TIME_DILATATION)) * maxTravel --re-scale back to unit health, scale with delta time and scale with the travel speed
		
		self.AnimationStart = self.AnimationStart - (calcAnimationSpeed)
		self:SetValue (self.AnimationStart)
		self.CurrentPercent = self.AnimationStart
		
		if (self.Spark) then
			self.Spark:SetPoint("center", self, "left", self.AnimationStart / self.CurrentPercentMax * self:GetWidth(), 0)
			self.Spark:Show()
		end
		
		if (self.AnimationStart-1 <= self.AnimationEnd) then
			self:SetValue(self.AnimationEnd)
			self.CurrentPercent = self.AnimationEnd
			self.IsAnimating = false
			if (self.Spark) then
				self.Spark:Hide()
			end
		end
	end

	function ThreatMeter.AnimateRightWithAccel(self, deltaTime)
		local distance = (self.AnimationEnd - self.AnimationStart) / self.CurrentPercentMax * 100	--scale 1 - 100 basis
		local minTravel = math.min(distance / 10, 3) -- 10 = trigger distance to max speed 3 = speed scale on max travel
		local maxTravel = math.max(minTravel, 0.45) -- 0.45 = min scale speed on low travel speed
		local calcAnimationSpeed = (self.CurrentPercentMax * (deltaTime * ANIMATION_TIME_DILATATION)) * maxTravel --re-scale back to unit health, scale with delta time and scale with the travel speed
		
		self.AnimationStart = self.AnimationStart + (calcAnimationSpeed)
		self:SetValue(self.AnimationStart)
		self.CurrentPercent = self.AnimationStart
		
		if (self.AnimationStart+1 >= self.AnimationEnd) then
			self:SetValue(self.AnimationEnd)
			self.CurrentPercent = self.AnimationEnd
			self.IsAnimating = false
		end
	end

	--when the size of the window has changed
	function ThreatMeter:SizeChanged()

		--instance = details! window holding the plugin
		instance = ThreatMeter:GetPluginInstance()
	
		--set the size of the plugin frame to be equal as the window
		local w, h = instance.baseframe:GetSize()
		ThreatMeterFrame:SetWidth(w)
		ThreatMeterFrame:SetHeight(h)
		
		--calculate how tall is each bar
		local rowHeight = instance and instance.row_info.height or 20

		--this is the amount of bars the window can show
		ThreatMeter.CanShow = floor( h / (rowHeight + 1))
		for i = #ThreatMeter.Rows+1, ThreatMeter.CanShow do
			ThreatMeter:NewRow(i)
		end

		ThreatMeter.ShownRows = {}
		
		--show the bars
		for i = 1, ThreatMeter.CanShow do
			ThreatMeter.ShownRows [#ThreatMeter.ShownRows + 1] = ThreatMeter.Rows[i]
			if (_detalhes.in_combat) then
				ThreatMeter.Rows[i]:Show()
			end
			ThreatMeter.Rows[i].width = w - 5
		end
		
		--hide the rest of the bars which couldn't fit in the window
		for i = #ThreatMeter.ShownRows + 1, #ThreatMeter.Rows do
			ThreatMeter.Rows[i]:Hide()
		end
	end
	
	

	--update row info getting information from details options
	function ThreatMeter:RefreshRow(row)
	
		--instance is a details! window
		instance = ThreatMeter:GetPluginInstance()
		
		if (instance) then
			local font = SharedMedia:Fetch ("font", instance.row_info.font_face, true) or instance.row_info.font_face
			
			row.textsize = instance.row_info.font_size
			row.textfont = font
			row.texture = instance.row_info.texture
			row.shadow = instance.row_info.textL_outline
			
			local rowHeight = instance and instance.row_info.height or 20
			rowHeight = - ( (row.rowId - 1) * (rowHeight + 1) )

			row:ClearAllPoints()
			row:SetPoint ("topleft", ThreatMeterFrame, "topleft", 1, rowHeight)
			row:SetPoint ("topright", ThreatMeterFrame, "topright", -1, rowHeight)
		end
	end
	
	function ThreatMeter:RefreshRows()
		for i = 1, #ThreatMeter.Rows do
			ThreatMeter:RefreshRow (ThreatMeter.Rows [i])
		end
	end

	local onUpdateRow = function(self, deltaTime)
		self = self.MyObject
		if (self.IsAnimating and self.AnimateFunc) then
			self.AnimateFunc(self, deltaTime)
		end
	end
	

	--create a new bar
	function ThreatMeter:NewRow(i)

		--instance is a details! window
		instance = ThreatMeter:GetPluginInstance()
		local rowHeight = instance and instance.row_info.height or 20

		local newrow = DetailsFrameWork:NewBar(ThreatMeterFrame, nil, "DetailsThreatRow"..i, nil, 300, rowHeight)
		newrow:SetPoint(3, -((i-1)*(rowHeight+1)))
		newrow.lefttext = "bar " .. i
		newrow.color = "skyblue"
		newrow.fontsize = 9.9
		newrow.fontface = "GameFontHighlightSmall"
		newrow:SetIcon("Interface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES", RoleIconCoord ["DAMAGER"])
		newrow.rowId = i

		newrow.widget:SetScript("OnUpdate", onUpdateRow)

		ThreatMeter.Rows [#ThreatMeter.Rows+1] = newrow
		
		ThreatMeter:RefreshRow(newrow)
		
		newrow:Hide()
		
		return newrow
	end
	
	--sort threat DESC
	local sort = function(table1, table2)
		if (table1[2] > table2[2]) then
			return true
		else
			return false
		end
	end

	--update the threat of each player
	local Threater = function()

		--if (ThreatMeter.Actived and UnitExists("target") and not UnitIsFriend("player", "target")) then
		--below is from @Zerahei and it should show target of target threat
		if ( ThreatMeter.Actived and ( UnitExists ("target") ) and (( not UnitIsFriend ("player", "target")) or (( UnitIsFriend ("player", "target") ) and ( not UnitIsFriend ("player", "targettarget") ) ) ) ) then
			local hostileTarget = "target"
			if ( UnitIsFriend ("player", "target") ) then
				hostileTarget = "targettarget"
			end
			ThreatMeter.UpdateWindowTitle(UnitName(hostileTarget))
		--end of the target of target block

			if (IsInRaid()) then
				for i = 1, GetNumGroupMembers(), 1 do
				
					local playerName = GetUnitName("raid"..i, true)
					local threatTableIndex = ThreatMeter.playerListHash [playerName]
					local threatTable = ThreatMeter.playerListIndexes [threatTableIndex]
				
					if (not threatTable) then
						--some one joined the group while the player are in combat
						ThreatMeter:Start()
						return
					end
				
					local isTanking, status, threatpct, rawthreatpct, threatvalue = _UnitDetailedThreatSituation("raid"..i, hostileTarget)

					isTanking = isTanking or false
					threatpct = threatpct or 0
					rawthreatpct = rawthreatpct or 0

					if (status) then
						threatTable[2] = threatpct
						threatTable[3] = isTanking
						threatTable[6] = threatvalue
					else
						threatTable[2] = 0
						threatTable[3] = false
						threatTable[6] = 0
					end

				end
				
			elseif (IsInGroup()) then
				for i = 1, GetNumGroupMembers()-1, 1 do
					local playerName = GetUnitName("party"..i, true)
					local threatTableIndex = ThreatMeter.playerListHash [playerName]
					local threatTable = ThreatMeter.playerListIndexes [threatTableIndex]
				
					if (not threatTable) then
						--> some one joined the group while the player are in combat
						ThreatMeter:Start()
						return
					end
				
					local isTanking, status, threatpct, rawthreatpct, threatvalue = _UnitDetailedThreatSituation("party"..i, hostileTarget)
					local nameOrder = ThreatMeter:GetNameOrder(playerName or "zzzzzzz")

					isTanking = isTanking or false
					threatpct = threatpct or 0
					rawthreatpct = rawthreatpct or (0 + nameOrder)

					if (status) then
						threatTable[2] = threatpct + nameOrder
						threatTable[3] = isTanking
						threatTable[6] = threatvalue + nameOrder
					else
						threatTable[2] = 0 + nameOrder
						threatTable[3] = false
						threatTable[6] = 0 + nameOrder
					end
				end
				
				local playerName = GetUnitName("player", true)
				local threatTableIndex = ThreatMeter.playerListHash [playerName]
				local threatTable = ThreatMeter.playerListIndexes [threatTableIndex]
				local nameOrder = ThreatMeter:GetNameOrder(playerName or "zzzzzzz")

				local isTanking, status, threatpct, rawthreatpct, threatvalue = _UnitDetailedThreatSituation("player", hostileTarget)

				isTanking = isTanking or false
				threatpct = threatpct or 0
				rawthreatpct = rawthreatpct or (0 + nameOrder)

				if (status) then
					threatTable[2] = threatpct + nameOrder
					threatTable[3] = isTanking
					threatTable[6] = threatvalue + nameOrder
				else
					threatTable[2] = 0 + nameOrder
					threatTable[3] = false
					threatTable[6] = 0 + nameOrder
				end

				--player pet
				--> pet
				--this code is disabled temporarly
				if (UnitExists("pet") and not IsInInstance() and false) then --disabled
					local playerName = GetUnitName("pet", true) .. " *PET*"
					local threatTableIndex = ThreatMeter.playerListHash [playerName]
					local threatTable = ThreatMeter.playerListIndexes [threatTableIndex]

					if (threatTable) then

						local isTanking, status, threatpct, rawthreatpct, threatvalue = _UnitDetailedThreatSituation("pet", hostileTarget)

						--threatpct, rawthreatpct are nil on single player, dunno with pets
						threatpct = threatpct or 0
						rawthreatpct = rawthreatpct or 0

						if (status) then
							threatTable[2] = threatpct
							threatTable[3] = isTanking
							threatTable[6] = threatvalue
						else
							threatTable[2] = 0
							threatTable[3] = false
							threatTable[6] = 0
						end
					end
				end
				
			else
			
				--> player
				local playerName = GetUnitName("player", true)
				local threatTableIndex = ThreatMeter.playerListHash [playerName]
				local threatTable = ThreatMeter.playerListIndexes [threatTableIndex]
				local isTanking, status, threatpct, rawthreatpct, threatvalue = _UnitDetailedThreatSituation ("player", hostileTarget)

				local nameOrder = ThreatMeter:GetNameOrder(playerName or "zzzzzzz")

				--threatpct, rawthreatpct are nil on single player
				threatpct = threatpct or 0
				rawthreatpct = rawthreatpct or (0 + nameOrder)

				if (status) then
					threatTable[2] = threatpct
					threatTable[3] = isTanking
					threatTable[6] = threatvalue + nameOrder
				else
					threatTable[2] = 0
					threatTable[3] = false
					threatTable[6] = 0 or nameOrder
				end

				--> pet
				if (UnitExists("pet")) then
					local playerName = GetUnitName("pet", true) .. " *PET*"
					local threatTableIndex = ThreatMeter.playerListHash [playerName]
					local threatTable = ThreatMeter.playerListIndexes [threatTableIndex]

					if (threatTable) then

						local isTanking, status, threatpct, rawthreatpct, threatvalue = _UnitDetailedThreatSituation("pet", hostileTarget)

						--threatpct, rawthreatpct are nil on single player, dunno with pets
						threatpct = threatpct or 0
						rawthreatpct = rawthreatpct or 0

						if (status) then
							threatTable[2] = threatpct
							threatTable[3] = isTanking
							threatTable[6] = threatvalue
						else
							threatTable[2] = 0
							threatTable[3] = false
							threatTable[6] = 0
						end
					end
				end
			end
			
			--> sort
			tableSort(ThreatMeter.playerListIndexes, sort)
			for index, t in ipairs (ThreatMeter.playerListIndexes) do
				ThreatMeter.playerListHash [t[1]] = index
			end
			
			--> no threat on this enemy
			if (ThreatMeter.playerListIndexes [1] [2] < 1) then
				ThreatMeter:HideBars()
				return
			end
			
--------------------------------------------------------------------------------------------------------------
--> update the window

			local shownMe = false
			local pullRow = ThreatMeter.ShownRows [1]
			local me = ThreatMeter.playerListIndexes [ ThreatMeter.playerListHash [player] ]

			--adjust the pull aggro bar
			if (me) then
				local myThreat = me [6] or 0
				local myRole = me [4]
				
				--get the actor with more threat
				local topThreat = ThreatMeter.playerListIndexes [1]
				--check if is a melee aggro
				local aggro = topThreat [6] * (CheckInteractDistance(hostileTarget, 3) and 1.1 or 1.3)
				
				pullRow:SetLeftText("Pull Aggro At") --localize-me
				local realPercent = floor(aggro / max(topThreat [6], 0.01) * 100)
				pullRow:SetRightText("+" .. ThreatMeter:ToK2(aggro - myThreat) .. " (" .. floor (abs ((myThreat / aggro * 100) - realPercent)) .. "%)") --
				pullRow:SetValue(100)
				
				local myPercentToAggro = myThreat / aggro * 100
				
				--set the bar color
				local r, g = ThreatMeter:percent_color(myPercentToAggro)
				pullRow:SetColor (r, g, 0)

				--set the bar icon
				pullRow._icon:SetTexture([[Interface\PVPFrame\Icon-Combat]])
				pullRow._icon:SetTexCoord(0, 1, 0, 1)
				
				pullRow:Show()
			else
				if (pullRow) then
					pullRow:Hide()
				end
			end
			
			--update all shown bars
			for index = 2, #ThreatMeter.ShownRows do
				local thisRow = ThreatMeter.ShownRows [index]
				local threat_actor = ThreatMeter.playerListIndexes [index-1]
				
				if (threat_actor) then
					--set the role icon
					local role = threat_actor [4]
					thisRow._icon:SetTexCoord(unpack(RoleIconCoord [role]))
					
					--set the text for actor name
					thisRow:SetLeftText(ThreatMeter:GetOnlyName(threat_actor [1]))
					
					--set the text for threat
					local oldPct = thisRow:GetValue() or 0
					local pct = threat_actor [2]

					if (ThreatMeter.db.showamount) then
						thisRow:SetRightText(ThreatMeter:ToK2(threat_actor [6]) .. " (" .. format("%.1f", pct) .. "%)")
					else
						thisRow:SetRightText(format ("%.1f", pct) .. "%")
					end

					--do healthbar animation ~animation ~healthbar
						thisRow.CurrentPercentMax = 100
						thisRow.AnimationStart = oldPct
						thisRow.AnimationEnd = pct
						
						if (ThreatMeter.db.animate) then
							thisRow:SetValue(oldPct)

							thisRow.IsAnimating = true
							if (thisRow.AnimationEnd > thisRow.AnimationStart) then
								thisRow.AnimateFunc = ThreatMeter.AnimateRightWithAccel
							else
								thisRow.AnimateFunc = ThreatMeter.AnimateLeftWithAccel
							end
						
						else
							thisRow:SetValue(pct)
						end

					--set the bar color
					if (ThreatMeter.db.useplayercolor and threat_actor [1] == player) then
						thisRow:SetColor(unpack(ThreatMeter.db.playercolor))

					elseif (ThreatMeter.db.useclasscolors) then
						local color = RAID_CLASS_COLORS [threat_actor [5]]
						if (color) then
							thisRow:SetColor(color.r, color.g, color.b)
						else
							thisRow:SetColor(1, 1, 1, 1)
						end
					else
						if (index == 2) then
							thisRow:SetColor(pct*0.01, abs(pct-100)*0.01, 0, 1)
						else
							local r, g = ThreatMeter:percent_color(pct, true)
							thisRow:SetColor(r, g, 0, 1)
						end
					end
					
					if (not thisRow.statusbar:IsShown()) then
						thisRow:Show()
					end
					if (threat_actor [1] == player) then
						shownMe = true
					end
				else
					thisRow:Hide()
				end
			end
			
			if (not shownMe and ThreatMeter.db.alwaysshowme) then
				--> show my self into last bar
				local threatActor = ThreatMeter.playerListIndexes[ThreatMeter.playerListHash [player]]
				if (threatActor) then
					--check if the player has threat
					if (threatActor[2] and threatActor[2] > 0.1) then
						--get the latest line shown in the window
						local thisRow = ThreatMeter.ShownRows[#ThreatMeter.ShownRows]
						--set the player name on it
						thisRow:SetLeftText(player)
						--set the player role icon
						local role = threatActor[4]
						thisRow._icon:SetTexCoord(unpack(RoleIconCoord[role]))

						if (ThreatMeter.db.showamount) then
							--show the threat amout
							thisRow:SetRightText(ThreatMeter:ToK2(threatActor[6]) .. " (" .. format("%.1f", threatActor[2]) .. "%)")
						else
							--show only percent
							thisRow:SetRightText(format("%.1f", threatActor[2]) .. "%")
						end

						--set the value
						thisRow.IsAnimating = false
						thisRow:SetValue(threatActor[2])
						
						--adjust the line color
						if (ThreatMeter.db.useplayercolor) then
							thisRow:SetColor(unpack(ThreatMeter.db.playercolor))
						else
							local r, g = ThreatMeter:percent_color(threatActor[2], true)
							thisRow:SetColor(r, g, 0, .3)
						end
					end
				end
			end
		else
			--print ("player has no target")
		end
		
	end
	
	function ThreatMeter:TargetChanged()
		if (not ThreatMeter.Actived) then
			return
		end
		local NewTarget = UnitName("target")
		if (NewTarget and not UnitIsFriend("player", "target")) then
			target = NewTarget
			ThreatMeter.UpdateWindowTitle(NewTarget)
			Threater()

		elseif (NewTarget and UnitIsFriend("player", "target") and not UnitIsFriend("player", "targettarget")) then
			target = UnitName("playertargettarget")
			ThreatMeter.UpdateWindowTitle(target)
			Threater()
		else
			ThreatMeter.UpdateWindowTitle(false)
			ThreatMeter:HideBars()
		end
	end
	
	function ThreatMeter:Tick()
		Threater()
	end

	function ThreatMeter:Start()
		ThreatMeter:HideBars()
		if (ThreatMeter.Actived) then
			if (ThreatMeter.updateThreatJob) then --ticker is disabled, it won't work
				ThreatMeter.updateThreatJob:Cancel()
				ThreatMeter.updateThreatJob = nil
			end
			
			ThreatMeter.playerListIndexes = {}
			ThreatMeter.playerListHash = {}
			
			--> pre build player list
			if (IsInRaid()) then
				for i = 1, GetNumGroupMembers(), 1 do
					local playerName = GetUnitName ("raid"..i, true)
					local role = _UnitGroupRolesAssigned("raid"..i)
					local _, class = UnitClass (playerName)
					local t = {playerName, 0, false, role, class, 0}
					ThreatMeter.playerListIndexes [#ThreatMeter.playerListIndexes+1] = t
					ThreatMeter.playerListHash [playerName] = #ThreatMeter.playerListIndexes
				end

			elseif (IsInGroup()) then
				for i = 1, GetNumGroupMembers()-1, 1 do
					local playerName = GetUnitName("party"..i, true)
					local role = _UnitGroupRolesAssigned("party"..i)
					local _, class = UnitClass(playerName)
					local t = {playerName, 0, false, role, class, 0}
					ThreatMeter.playerListIndexes [#ThreatMeter.playerListIndexes+1] = t
					ThreatMeter.playerListHash [playerName] = #ThreatMeter.playerListIndexes
				end
				local playerName = GetUnitName("player", true)
				local role = _UnitGroupRolesAssigned("player")
				local _, class = UnitClass(playerName)
				local t = {playerName, 0, false, role, class, 0}
				ThreatMeter.playerListIndexes [#ThreatMeter.playerListIndexes+1] = t
				ThreatMeter.playerListHash [playerName] = #ThreatMeter.playerListIndexes

				if (UnitExists("pet") and not IsInInstance() and false) then --disabled
					local petName = GetUnitName("pet", true) .. " *PET*"
					local role = "DAMAGER"
					local t = {petName, 0, false, role, class, 0}
					ThreatMeter.playerListIndexes [#ThreatMeter.playerListIndexes+1] = t
					ThreatMeter.playerListHash [petName] = #ThreatMeter.playerListIndexes
				end
			else
				local playerName = GetUnitName("player", true)
				local role = _UnitGroupRolesAssigned("player")
				local _, class = UnitClass(playerName)
				local t = {playerName, 0, false, role, class, 0}

				ThreatMeter.playerListIndexes [#ThreatMeter.playerListIndexes+1] = t
				ThreatMeter.playerListHash [playerName] = #ThreatMeter.playerListIndexes
				
				if (UnitExists("pet")) then
					local petName = GetUnitName("pet", true) .. " *PET*"
					local role = "DAMAGER"
					local t = {petName, 0, false, role, class, 0}

					ThreatMeter.playerListIndexes [#ThreatMeter.playerListIndexes+1] = t
					ThreatMeter.playerListHash [petName] = #ThreatMeter.playerListIndexes
				end
			end
			
			ThreatMeterFrame:RegisterEvent("UNIT_THREAT_LIST_UPDATE")

			--local updateThreatJob = _G.C_Timer.NewTicker(ThreatMeter.db.updatespeed, ThreatMeter.Tick)
			--ThreatMeter.updateThreatJob = updateThreatJob
		end
	end
	
	function ThreatMeter:End()
		ThreatMeter:HideBars()
		ThreatMeterFrame:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
		ThreatMeter.UpdateWindowTitle(false)

		if (ThreatMeter.updateThreatJob) then --ticker is disabled, it won't work
			ThreatMeter.updateThreatJob:Cancel()
			ThreatMeter.updateThreatJob = nil
			ThreatMeter.UpdateWindowTitle(false)
		end
	end
	
	function ThreatMeter:Cancel()
		ThreatMeter:HideBars()
		ThreatMeterFrame:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
		ThreatMeter.UpdateWindowTitle(false)

		if (ThreatMeter.updateThreatJob) then --ticker is disabled, it won't work
			ThreatMeter.updateThreatJob:Cancel()
			ThreatMeter.updateThreatJob = nil
		end
		ThreatMeter.Actived = false
	end
end

local build_options_panel = function()

	local options_frame = ThreatMeter:CreatePluginOptionsFrame("ThreatMeterOptionsWindow", "Tiny Threat Options", 1)

	local menu = {
		{
			type = "toggle",
			get = function() return ThreatMeter.db.animate end,
			set = function (self, fixedparam, value) ThreatMeter.db.animate = value end,
			desc = "Is the bars do animations",
			name = "Do Animations"
		},
		{
			type = "range",
			get = function() return ThreatMeter.db.updatespeed end,
			set = function (self, fixedparam, value) ThreatMeter.db.updatespeed = value end,
			min = 1,
			max = 3,
			step = 0.2,
			desc = "How fast the window get updates.",
			name = "Update Speed",
			usedecimals = true,
		},
		{
			type = "toggle",
			get = function() return ThreatMeter.db.showamount end,
			set = function (self, fixedparam, value) ThreatMeter.db.showamount = value end,
			desc = "If enabled shows the amount of threat each player has.",
			name = "Show Amount of Threat"
		},

		{
			type = "toggle",
			get = function() return ThreatMeter.db.useplayercolor end,
			set = function (self, fixedparam, value) ThreatMeter.db.useplayercolor = value end,
			desc = "When enabled, your bar get the following color.",
			name = "Player Color Enabled"
		},
		{
			type = "color",
			get = function() return ThreatMeter.db.playercolor end,
			set = function (self, r, g, b, a) 
				local current = ThreatMeter.db.playercolor
				current[1], current[2], current[3], current[4] = r, g, b, a
			end,
			desc = "If Player Color is enabled, your bar have this color.",
			name = "Player Color"
		},
		{
			type = "toggle",
			get = function() return ThreatMeter.db.useclasscolors end,
			set = function (self, fixedparam, value) ThreatMeter.db.useclasscolors = value end,
			desc = "When enabled, threat bars uses the class color of the character.",
			name = "Use Class Colors"
		},
		{
			type = "toggle",
			get = function() return ThreatMeter.db.dividebyhundred end,
			set = function (self, fixedparam, value) ThreatMeter.db.dividebyhundred = value end,
			desc = "When enabled, threat is divided by 100.",
			name = "Divide Threat by 100"
		},
		{
			type = "toggle",
			get = function() return ThreatMeter.db.alwaysshowme end,
			set = function (self, fixedparam, value) ThreatMeter.db.alwaysshowme = value end,
			desc = "When enabled, your threat is always shown.",
			name = "Always Show Me"
		},
	}

	local options_text_template = _G.DetailsFramework:GetTemplate("font", "OPTIONS_FONT_TEMPLATE")
	local options_dropdown_template = _G.DetailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
	local options_switch_template = _G.DetailsFramework:GetTemplate("switch", "OPTIONS_CHECKBOX_TEMPLATE")
	local options_slider_template = _G.DetailsFramework:GetTemplate("slider", "OPTIONS_SLIDER_TEMPLATE")
	local options_button_template = _G.DetailsFramework:GetTemplate("button", "OPTIONS_BUTTON_TEMPLATE")

	_detalhes.gump:BuildMenu(options_frame, menu, 15, -35, 260, true, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template)

end

ThreatMeter.OpenOptionsPanel = function()
	if (not _G.ThreatMeterOptionsWindow) then
		build_options_panel()
	end
	_G.ThreatMeterOptionsWindow:Show()
end

local loadPlugin = function()

	--> create widgets
	CreatePluginFrames()

	local MINIMAL_DETAILS_VERSION_REQUIRED = 1

	local default_options_table = {
		animate = true,
		updatespeed = 0.25,
		showamount = true,
		useplayercolor = true,
		playercolor = {1, 1, 1},
		useclasscolors = true,
		dividebyhundred = true,
		openedfromcommand = false,
		alwaysshowme = true,
	}

	ThreatMeter.DefaultConfigTable = default_options_table
	
	--> Install
	local install = _G.Details:InstallPlugin ("RAID", Loc ["STRING_PLUGIN_NAME"], "Interface\\COMMON\\friendship-FistHuman", ThreatMeter, "DETAILS_PLUGIN_TINY_THREAT", MINIMAL_DETAILS_VERSION_REQUIRED, "Terciob", "v1.08", default_options_table)
	if (type (install) == "table" and install.error) then
		print (install.error)
	end

	Details_TinyThreatDB = Details_TinyThreatDB or {characters = {}, profiles = {}}
	
	--> Register needed events
	_G.Details:RegisterEvent(ThreatMeter, "COMBAT_PLAYER_ENTER")
	_G.Details:RegisterEvent(ThreatMeter, "COMBAT_PLAYER_LEAVE")
	_G.Details:RegisterEvent(ThreatMeter, "DETAILS_INSTANCE_ENDRESIZE")
	_G.Details:RegisterEvent(ThreatMeter, "DETAILS_INSTANCE_SIZECHANGED")
	_G.Details:RegisterEvent(ThreatMeter, "DETAILS_INSTANCE_STARTSTRETCH")
	_G.Details:RegisterEvent(ThreatMeter, "DETAILS_INSTANCE_ENDSTRETCH")
	_G.Details:RegisterEvent(ThreatMeter, "DETAILS_OPTIONS_MODIFIED")
	
	ThreatMeterFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	ThreatMeterFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	ThreatMeterFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	ThreatMeterFrame:RegisterEvent("PLAYER_LOGOUT")
	ThreatMeterFrame:RegisterUnitEvent("UNIT_TARGET", "target")

	--profile name
	ThreatMeter.PlayerNameProfile = UnitName("player") .. " - " .. _G.GetRealmName()
	local pname = ThreatMeter.PlayerNameProfile
	--default if is first run
	local next_pname = next(Details_TinyThreatDB.profiles or {})
	Details_TinyThreatDB.characters[pname] = Details_TinyThreatDB.characters[pname] or next_pname or pname

	--load dbtable
	local ptable = Details_TinyThreatDB.profiles [Details_TinyThreatDB.characters[pname]] or {} --already existen config set or empty table
	_G.Details.table.overwrite(ThreatMeter.db, ptable) --profile overwrite the local settings
	_G.Details.table.deploy(ptable, ThreatMeter.db) --local settings deploy stuff which non exist on profile
	Details_TinyThreatDB.profiles[Details_TinyThreatDB.characters[pname]] = ptable
	
	--> Register slash commands
	SLASH_DETAILS_TINYTHREAT1, SLASH_DETAILS_TINYTHREAT2 = "/tinythreat", "/tt"
	
	function _G.SlashCmdList.DETAILS_TINYTHREAT (msg, editbox)
		ThreatMeter.OpenOptionsPanel()
		ThreatMeter.db.openedfromcommand = true
		if (ThreatMeter.optionsLabel) then
			ThreatMeter.optionsLabel:Hide()
		end
	end

	ThreatMeter.initialized = true
end

local GetTime = _G.GetTime
local latestUpdate = GetTime()

function ThreatMeter:OnEvent (_, event, ...)

	if (event == "UNIT_THREAT_LIST_UPDATE") then
		local timeFromLatestUpdate = GetTime() - latestUpdate
		if (timeFromLatestUpdate > 0.1) then
			ThreatMeter.Tick()
			--print("threat updated...", timeFromLatestUpdate) --debug
			latestUpdate = GetTime()
		end

	elseif (event == "PLAYER_TARGET_CHANGED") then
		ThreatMeter:TargetChanged()

	elseif ( event == "UNIT_TARGET" ) then
		ThreatMeter:TargetChanged()
	
	elseif (event == "PLAYER_REGEN_DISABLED") then
		ThreatMeter.Actived = true
		ThreatMeter:Start()
		
	elseif (event == "PLAYER_REGEN_ENABLED") then
		ThreatMeter:End()
		ThreatMeter.Actived = false
	
	elseif (event == "ADDON_LOADED") then --player_login
		if (_G._detalhes) then
			_G.C_Timer.After(3, loadPlugin)
		end

	elseif (event == "PLAYER_LOGOUT") then
		local pname = ThreatMeter.PlayerNameProfile
		Details_TinyThreatDB.profiles [ Details_TinyThreatDB.characters [pname] ] = ThreatMeter.db
	end
end
