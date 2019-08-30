-- BlizzMmove, move the blizzard frames by yess
--locale added by Terry@bf

if GetLocale()=='zhCN' then
	BINDING_HEADER_BLIZZMOVE= "BlizzMove";
	BINDING_NAME_MOVEFRAME 	= "移动/锁定框体";
	BLZMOVE_FRAME_SAVED		= "框体: %s将会被保存."
	BLZMOVE_FRAME_NOT_SAVED	= "框体: %s将不会被保存."
	BLZMODE_OPTION_TEXT		= "点击下方按钮可重置所有框体."
	BLZMODE_OPTION_RESET	= "重置"
elseif GetLocale() =='zhTW' then
	BINDING_HEADER_BLIZZMOVE= "BlizzMove";
	BINDING_NAME_MOVEFRAME 	= "移動/鎖定框體";
	BLZMOVE_FRAME_SAVED		= "框體: %s將會被保存."
	BLZMOVE_FRAME_NOT_SAVED	= "框體: %s將不會被保存."
	BLZMODE_OPTION_TEXT		= "點擊下方按鈕可重置所有框體."
	BLZMODE_OPTION_RESET	= "重置"
else
	BINDING_HEADER_BLIZZMOVE = "BlizzMove";
	BINDING_NAME_MOVEFRAME = "Move/Lock a Frame";
	BLZMOVE_FRAME_SAVED		= "Frame: %s will be saved."
	BLZMOVE_FRAME_NOT_SAVED	= "Frame: %s will not be saved."
	BLZMODE_OPTION_TEXT		= "Click the button below to reset all frames."
	BLZMODE_OPTION_RESET	= "Reset"
end

local db = nil
local frame = CreateFrame("Frame")
local optionPanel = nil

local defaultDB = {
    version = "201109013",
	AchievementFrame = {save = true},
	CalendarFrame = {save = true},
	AuctionFrame = {save = true},
	GuildBankFrame = {save = true},
}

local function Print(...)
	local s = "BlizzMove:"
	for i=1,select("#", ...) do
		local x = select(i, ...)
		s = strjoin(" ",s,tostring(x))
	end
	DEFAULT_CHAT_FRAME:AddMessage(s)
end

--[===[@debug@
local function Debug(...)
	local s = "Blizzmove Debug:"
	for i=1,select("#", ...) do
		local x = select(i, ...)
		s = strjoin(" ",s,tostring(x))
	end
	DEFAULT_CHAT_FRAME:AddMessage(s)
end
--@end-debug@]===]

local function OnShow(self, ...)
	local settings = self.settings
	if settings and settings.point and settings.save then
		self:ClearAllPoints()
		self:SetPoint(settings.point,settings.relativeTo, settings.relativePoint, settings.xOfs,settings.yOfs)
		local scale = settings.scale
		if scale then
			self:SetScale(scale)
		end
	end
end


local function OnMouseWheel(self, value, ...)
	if IsControlKeyDown() then
		local frameToMove = self.frameToMove
		local scale = frameToMove:GetScale() or 1
		if(value == 1) then --scale up
			scale = scale +.1
			if(scale > 1.5) then
				scale = 1.5
			end
		else -- scale down
			scale = scale -.1
			if(scale < .5) then
				scale = .5
			end
		end
		frameToMove:SetScale(scale)
		if self.settings then
			self.settings.scale = scale
		end
		--Debug("scroll", arg1, scale, frameToMove:GetScale())
	end
end

local function OnDragStart(self)
	local frameToMove = self.frameToMove
	local settings = frameToMove.settings
	if settings and not settings.default then -- set defaults
		settings.default = {}
		local def = settings.default
		def.point, def.relativeTo , def.relativePoint, def.xOfs, def.yOfs = frameToMove:GetPoint()
		if def.relativeTo then
			def.relativeTo = def.relativeTo:GetName()
		end
	end
	frameToMove:StartMoving()
	frameToMove.isMoving = true
end

local function OnDragStop(self)
	local frameToMove = self.frameToMove
	local settings = frameToMove.settings
	frameToMove:StopMovingOrSizing()
	frameToMove.isMoving = false
	if settings then
			settings.point, settings.relativeTo, settings.relativePoint, settings.xOfs, settings.yOfs = frameToMove:GetPoint()
	end
end

local function OnMouseUp(self, ...)
	local frameToMove = self.frameToMove
	if IsControlKeyDown() then
		local settings = frameToMove.settings
		--toggle save
		if settings then
			settings.save = not settings.save
			if settings.save then
				Print(string.format(BLZMOVE_FRAME_SAVED,frameToMove:GetName()));
			else
				Print(string.format(BLZMOVE_FRAME_NOT_SAVED,frameToMove:GetName()));
			end
		else
			Print(string.format(BLZMOVE_FRAME_SAVED,frameToMove:GetName()));
			db[frameToMove:GetName()] = {}
			settings = db[frameToMove:GetName()]
			settings.save = true
			settings.point, settings.relativeTo, settings.relativePoint, settings.xOfs, settings.yOfs = frameToMove:GetPoint()
			if settings.relativeTo then
			settings.relativeTo = settings.relativeTo:GetName()
			end
			frameToMove.settings = settings
		end
	end
end

local function SetMoveHandler(frameToMove, handler)
	if not frameToMove then
		return
	end
	if not handler then
		handler = frameToMove
	end

	local settings = db[frameToMove:GetName()]
	if not settings then
		settings = defaultDB[frameToMove:GetName()] or {}
		db[frameToMove:GetName()] = settings
	end
	frameToMove.settings = settings
	handler.frameToMove = frameToMove

	if not frameToMove.EnableMouse then return end

	frameToMove:EnableMouse(true)
	frameToMove:SetMovable(true)
	frameToMove:SetClampedToScreen(true)

	handler:RegisterForDrag("LeftButton");

	handler:SetScript("OnDragStart", OnDragStart)
	handler:SetScript("OnDragStop", OnDragStop)

	--override frame position according to settings when shown
	frameToMove:HookScript("OnShow", OnShow)

	--hook OnMouseUp
	handler:HookScript("OnMouseUp", OnMouseUp)

	--hook Scroll for setting scale
	handler:EnableMouseWheel(true)
	handler:HookScript("OnMouseWheel",OnMouseWheel)
end

local function resetDB()
	for k, v in pairs(db) do
		local f = _G[k]
		if f and f.settings then
			f.settings.save = false
			local def = f.settings.default
			if def then
				f:ClearAllPoints()
				f:SetPoint(def.point,def.relativeTo, def.relativePoint, def.xOfs,def.yOfs)
			end
		end
	end
end

local function createOptionPanel()
	optionPanel = CreateFrame( "Frame", "BlizzMovePanel", UIParent );
	local title = optionPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	local version = GetAddOnMetadata("BlizzMove","Version") or ""
	title:SetText("BlizzMove "..version)

	local subtitle = optionPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetHeight(35)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("RIGHT", optionPanel, -32, 0)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")

	subtitle:SetText(BLZMODE_OPTION_TEXT)

	local button = CreateFrame("Button",nil,optionPanel, "UIPanelButtonTemplate")
	button:SetWidth(100)
	button:SetHeight(30)
	button:SetScript("OnClick", resetDB)
	button:SetText(BLZMODE_OPTION_RESET)
	button:SetPoint("TOPLEFT",20,-60)

	optionPanel.name = "BlizzMove";
	InterfaceOptions_AddCategory(optionPanel);
end

local function OnEvent(self, event, arg1, arg2)
	-- Debug(event, arg1, arg2)
	if arg1=="BlizzMove" then
		db = BlizzMoveDB and BlizzMoveDB.version == defaultDB.version and BlizzMoveDB or defaultDB
		BlizzMoveDB = db
		--SetMoveHandler(frameToMove, handlerFrame)
		SetMoveHandler(CharacterFrame,PaperDollFrame)
		SetMoveHandler(CharacterFrame,TokenFrame)
		SetMoveHandler(CharacterFrame,SkillFrame)
		SetMoveHandler(CharacterFrame,ReputationFrame)
		SetMoveHandler(CharacterFrame,PetPaperDollFrameCompanionFrame)
		SetMoveHandler(SpellBookFrame)
		SetMoveHandler(FriendsFrame)
		SetMoveHandler(RaidParentFrame)
		if QuestLogFrame then
			SetMoveHandler(QuestLogFrame)
		end

		SetMoveHandler(GameMenuFrame)
		SetMoveHandler(GossipFrame)
		SetMoveHandler(DressUpFrame)
		SetMoveHandler(QuestFrame)
		SetMoveHandler(MerchantFrame)
		SetMoveHandler(HelpFrame)
		SetMoveHandler(MailFrame)
		SetMoveHandler(BankFrame)
		SetMoveHandler(VideoOptionsFrame)
		SetMoveHandler(InterfaceOptionsFrame)
		SetMoveHandler(LootFrame)
		SetMoveHandler(LFDParentFrame)
		SetMoveHandler(LFRParentFrame)
		SetMoveHandler(TradeFrame)
		-- 5.0
		SetMoveHandler(PVEFrame)
		--6.0
		SetMoveHandler(WorldMapFrame)
		SetMoveHandler(WorldMapFrame,WorldMapTitleButton)

		InterfaceOptionsFrame:HookScript("OnShow", function()
			if not optionPanel then
				createOptionPanel()
			end
		end)
	-- blizzard lod addons
	elseif arg1 == "Blizzard_InspectUI" then
		SetMoveHandler(InspectFrame)
	elseif arg1 == "Blizzard_GuildBankUI" then
		SetMoveHandler(GuildBankFrame)
	elseif arg1 == "Blizzard_TradeSkillUI" then
		SetMoveHandler(TradeSkillFrame)
	elseif arg1 == "Blizzard_ItemSocketingUI" then
		SetMoveHandler(ItemSocketingFrame)
	elseif arg1 == "Blizzard_BarbershopUI" then
		SetMoveHandler(BarberShopFrame)
	elseif arg1 == "Blizzard_GlyphUI" then
		SetMoveHandler(SpellBookFrame, GlyphFrame)
	elseif arg1 == "Blizzard_MacroUI" then
		SetMoveHandler(MacroFrame)
	elseif arg1 == "Blizzard_AchievementUI" then
		SetMoveHandler(AchievementFrame, AchievementFrameHeader)
	elseif arg1 == "Blizzard_TalentUI" then
		SetMoveHandler(PlayerTalentFrame)
	elseif arg1 == "Blizzard_Calendar" then
		SetMoveHandler(CalendarFrame)
	elseif arg1 == "Blizzard_TrainerUI" then
		SetMoveHandler(ClassTrainerFrame)
	elseif arg1 == "Blizzard_BindingUI" then
		SetMoveHandler(KeyBindingFrame)
	elseif arg1 == "Blizzard_AuctionUI" then
		SetMoveHandler(AuctionFrame)
	elseif arg1 == "Blizzard_GuildUI" then
		SetMoveHandler(GuildFrame)
	elseif arg1 == "Blizzard_LookingForGuildUI" then
		SetMoveHandler(LookingForGuildFrame)
	elseif arg1 == "Blizzard_ReforgingUI" then
		SetMoveHandler(ReforgingFrame,ReforgingFrame.InvisibleButton)
	elseif arg1 == "Blizzard_VoidStorageUI" then
		SetMoveHandler(VoidStorageFrame);
	elseif arg1 == "Blizzard_ItemAlterationUI" then
		SetMoveHandler(TransmogrifyFrame);
	elseif arg1 == "Blizzard_ArchaeologyUI" then
		SetMoveHandler(ArchaeologyFrame);
	elseif arg1 == "Blizzard_EncounterJournal" then
		SetMoveHandler(EncounterJournal);
	elseif arg1 == "Blizzard_Collections" then
		SetMoveHandler(CollectionsJournal);
	elseif arg1 == "Blizzard_BlackMarketUI" then
		SetMoveHandler(BlackMarketFrame);
	elseif arg1 == "Blizzard_GarrisonUI" then
		SetMoveHandler(GarrisonLandingPage);
		SetMoveHandler(GarrisonMissionFrame);
		SetMoveHandler(GarrisonBuildingFrame);
		SetMoveHandler(GarrisonRecruitSelectFrame);
	elseif arg1 == "Blizzard_ScrappingMachineUI" then
		SetMoveHandler(ScrappingMachineFrame);
	elseif arg1 == "Blizzard_Communities" then
		SetMoveHandler(CommunitiesFrame);
	end

end

frame:SetScript("OnEvent", OnEvent)
frame:RegisterEvent("ADDON_LOADED")


----------------------------------------------------------
-- User function to move/lock a frame with a handler
-- handler, the frame the user has clicked on
-- frameToMove, the handler itself, a parent frame of handler
--              that has UIParent as Parent or nil
----------------------------------------------------------
BlizzMove = {}
function BlizzMove:Toggle(handler)
	if not handler then
		handler = GetMouseFocus()
	end

	if handler:GetName() == "WorldFrame" then
		return
	end

	local lastParent = handler
	local frameToMove = handler
	local i=0
	--get the parent attached to UIParent from handler
	while lastParent and lastParent ~= UIParent and i < 100 do
			frameToMove = lastParent --set to last parent
			lastParent = lastParent:GetParent()
			i = i +1
	end
	if handler and frameToMove then
		if handler:GetScript("OnDragStart") then
			handler:SetScript("OnDragStart", nil)
			Print("Frame: ",frameToMove:GetName()," locked.")
		else
			Print("Frame: ",frameToMove:GetName()," to move with handler ",handler:GetName())
			SetMoveHandler(frameToMove, handler)
		end

	else
		Print("Error parent not found.")
	end
end
