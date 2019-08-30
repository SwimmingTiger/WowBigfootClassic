
--[[
	Combuctor.lua
		Some sort of crazy visual inventory management system
--]]

Combuctor = LibStub('AceAddon-3.0'):NewAddon('Combuctor', 'AceEvent-3.0', 'AceConsole-3.0')
local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')
local CURRENT_VERSION = GetAddOnMetadata('Combuctor', 'Version')
local playerName,playerRealm = UnitName('player'),GetRealmName();

--[[
	Loading/Profile Functions
--]]
function Combuctor:OnInitialize()
	self.profile = self:InitDB()

	--version update
	local version = self.db.version
	if version then
		if version ~= CURRENT_VERSION then
			if type(version) ~= 'number' or version < CURRENT_VERSION then
				self:UpdateVersion()
			end
		end
	end

	--slash command support
	self:RegisterChatCommand('combuctor', 'OnSlashCommand')
	self:RegisterChatCommand('cbt', 'OnSlashCommand')
end

function Combuctor:UpdateVersion()
	CombuctorDB4,BF_VoidStorageDB = nil,nil
	self:InitDB()
	self.db.version = CURRENT_VERSION
end

function Combuctor:InitDB()
	if not CombuctorDB4 then
		CombuctorDB4 = {
			version = CURRENT_VERSION,
			profiles = {
			}
		}
	end
	self.db = CombuctorDB4

	return self:GetProfile() or self:InitProfile()
end

function Combuctor:GetProfile(player)
	if not player then
		player = playerName
	end
	return self.db.profiles[player .. ' - ' .. playerRealm]
end

local function addSet(sets, exclude, name, ...)
	if sets then
		table.insert(sets, name)
	else
		sets = {name}
	end

	if select('#', ...) > 0 then
		if exclude then
			table.insert(exclude, {[name] = {...}})
		else
			exclude = {[name] = {...}}
		end
	end

	return sets, exclude
end

local function getDefaultInventorySets()
	local sets, exclude = addSet(sets, exclude, L.All)
	sets, exclude = addSet(sets, exclude, L.Equipment)
	sets, exclude = addSet(sets, exclude, L.TradeGood)
	sets, exclude = addSet(sets, exclude, L.Quest)
	sets, exclude = addSet(sets, exclude, L.Consumable)
	sets, exclude = addSet(sets, exclude, L.Misc)
	return sets, exclude
end

local function getDefaultBankSets()
	local sets, exclude = addSet(sets, exclude, L.All)
	sets, exclude = addSet(sets, exclude, L.Equipment)
	sets, exclude = addSet(sets, exclude, L.TradeGood)
	sets, exclude = addSet(sets, exclude, L.Quest)
	sets, exclude = addSet(sets, exclude, L.Consumable)
	sets, exclude = addSet(sets, exclude, L.Misc)
	return sets, exclude
end

function Combuctor:InitProfile()
	local player, realm = playerName, playerRealm;
	local numberSlot = 0
	for i=0,4,1 do
		numberSlot = numberSlot+GetContainerNumSlots(i)
	end
	local ratio = math.max(math.ceil(math.sqrt(numberSlot))/7,1)
	local profile = self:GetBaseProfile(ratio)

	profile.inventory.sets, profile.inventory.exclude = getDefaultInventorySets()
	profile.bank.sets, profile.bank.exclude = getDefaultBankSets()

	self.db.profiles[player .. ' - ' .. realm] = profile
	return profile
end

function Combuctor:GetBaseProfile(ratio)
	return {
		inventory = {
			bags = {0,1, 2, 3, 4},
			position = {'RIGHT'},
			showBags = true,	--第一次默认开
			w = 500*ratio,
			h = 512*ratio,
		},

		bank = {
			bags = {-1,5, 6, 7, 8, 9, 10},
			position = {'LEFT'},
			showBags = true,	--第一次默认开
			w = 560,
			h = 650,
		}
	}
end

--[[
	Events
--]]
local BF_OLDContainerFrame_Update = ContainerFrame_Update
local function BF_ContainerFrame_Update(frame)
	if frame.size and tonumber(frame.size) then
		BF_OLDContainerFrame_Update(frame)
	end
end
ContainerFrame_Update = BF_ContainerFrame_Update

function Combuctor:OnEnable()
	local profile = Combuctor:GetProfile(playerName)
	ContainerFrame_Update_ORIG = ContainerFrame_Update_ORIG or ContainerFrame_Update

	self.frames = {
		self.Frame:New(L.InventoryTitle, profile.inventory, false, 'inventory'),
		self.Frame:New(L.BankTitle, profile.bank, true, 'bank')
	}
	--load config here
	--hook bank or backpack or both or none
--	self:HookBagEvents(false,true)
end

--save original functions
local OpenBag_ORIG = OpenBag;
local ToggleBag_ORIG = ToggleBag;
local OpenAllBags_ORIG = OpenAllBags ;
local OpenBackPack_ORIG = OpenBackpack;
local ToggleAllBags_ORIG = ToggleAllBags;
local ToggleBackpack_ORIG = ToggleBackpack;

local function toggleBackPack()
	Combuctor:Toggle(BACKPACK_CONTAINER)
end

local function showBackPack()
	if Combuctor.EnableBag then
		Combuctor:Show(BACKPACK_CONTAINER, true)
	else
		OpenAllBags_ORIG()
	end
end

local function hideBackPack()
	Combuctor:Hide(BACKPACK_CONTAINER, true)
end

local function IsBackPackOpen()
	return Combuctor:IsShow(BACKPACK_CONTAINER)
end

local function m_ToggleAllBags(arg0,arg1)
	if IsBackPackOpen() then
		if not Combuctor.Autobackpack or GetTime() - Combuctor.Autobackpack > 0.5 then
			hideBackPack();
			if IsBackPackOpen() then
				toggleBackPack();
			end
		end
	else
		showBackPack();
	end
end

local function toggleBag(bag,configBank,configBackPack)
	if configBank == 1 and configBackPack == 1 then --integrate for both bank and backpack
		Combuctor:Toggle(bag)
		ContainerFrame_Update =function() end
	elseif configBank == 1 then --integrate for bank only
		if bag == -1 or bag > 4 then
			Combuctor:Toggle(bag)
		else
			ToggleBag_ORIG(bag)
		end
		ContainerFrame_Update = function(frame)
			local id = frame:GetID()
			if id == -1 or id > 4 then
			else
				ContainerFrame_Update_ORIG(frame)
			end
		end
	elseif configBackPack == 1 then  --integrate for backpack only
		if bag == -1 or bag > 4 then
			ToggleBag_ORIG(bag)
		else
			Combuctor:Toggle(bag)
		end
		ContainerFrame_Update = function(frame)
			local id = frame:GetID()
			if id == -1 or id > 4 then
				ContainerFrame_Update_ORIG(frame)
			end
		end
	else--integrate none
		ToggleBag_ORIG(bag)
		ContainerFrame_Update = ContainerFrame_Update_ORIG
	end
end

local function openAllBags()
	Combuctor:Show(BACKPACK_CONTAINER)
end

function Combuctor:Show(bag, auto)
	for _,frame in pairs(self.frames) do
		for _,bagID in pairs(frame.sets.bags) do
			if bagID == bag then
				frame:ShowFrame(auto)
				return
			end
		end
	end
end

function Combuctor:Hide(bag, auto)
	for _,frame in pairs(self.frames) do
		for _,bagID in pairs(frame.sets.bags) do
			if bagID == bag then
				frame:HideFrame(auto)
				return
			end
		end
	end
end

function Combuctor:IsShow(bag)
	local IsShow =false;
	for _,frame in pairs(self.frames) do
		for _,bagID in pairs(frame.sets.bags) do
			if bagID == bag then
				IsShow = frame:IsShown()
				break
			end
		end
	end
	return IsShow;
end

function Combuctor:Toggle(bag, auto)
	for _,frame in pairs(self.frames) do
		for _,bagID in pairs(frame.sets.bags) do
--	print(bagID,bag)
			if bagID == bag then
				frame:ToggleFrame(auto)
				frame:SetSubCategory(L.All)
				if (_G["ContainerFrame"..bag]) then
					_G["ContainerFrame"..bag].size = _G["ContainerFrame"..bag].size or (GetContainerNumSlots and GetContainerNumSlots(bag)) or 1
				end
				return
			end
		end
	end
end

function Combuctor:ShowOptions()
	InterfaceOptionsFrame_OpenToCategory(self.Options)
	InterfaceOptionsFrame_OpenToCategory(self.Options)
	InterfaceOptionsFrame_OpenToCategory(self.Options)
end

function Combuctor:OnSlashCommand(msg)
	local msg = msg and msg:lower()
	if msg == 'bank' then
		self:Toggle(BANK_CONTAINER)
	elseif msg == 'bags' then
		self:Toggle(BACKPACK_CONTAINER)
	elseif msg == '' or msg == 'config' or msg == 'options' then
		self:ShowOptions()
	else
		self:Print('Commands (/cbt or /combuctor)')
		print('- bank: Toggle bank')
		print('- bags: Toggle inventory')
		print('- options: Shows the options menu')
	end
end

--utility function: create a widget class
function Combuctor:NewClass(type, parentClass)
	local class = CreateFrame(type)
	class.mt = {__index = class}

	if parentClass then
		class = setmetatable(class, {__index = parentClass})
		class.super = parentClass
	end

	function class:Bind(o)
		return setmetatable(o, self.mt)
	end

	return class
end

local loaded;
function Combuctor:HookBagEvents(configBank,configBackPack)
	local EnableBag, EnableBank;
	ToggleBag = function (bag)
		toggleBag(bag,configBank,configBackPack)
	end

	--auto magic display code
	if configBackPack == 1 then
		OpenBag = m_ToggleAllBags;
		OpenAllBags	= openAllBags;
		OpenBackpack = showBackPack;
		ToggleAllBags = m_ToggleAllBags;
		ToggleBackpack = toggleBackPack;

		self:RegisterEvent('TRADE_SHOW', showBackPack)
		self:RegisterEvent('AUCTION_HOUSE_SHOW', showBackPack)
		EnableBag = true;
		Combuctor.EnableBag = true;
	else
		OpenBag = OpenBag_ORIG;
		OpenAllBags	= OpenAllBags_ORIG;
		OpenBackpack = OpenBackPack_ORIG;
		ToggleAllBags = ToggleAllBags_ORIG;
		ToggleBackpack = ToggleBackpack_ORIG;

		self:UnregisterEvent('TRADE_SHOW')
		self:UnregisterEvent('AUCTION_HOUSE_SHOW')
		EnableBag = false;
		Combuctor.EnableBag = false;
	end
	self:RegisterEvent('AUCTION_HOUSE_SHOW', showBackPack)

	if configBank == 1 then
		BankFrame:UnregisterAllEvents()
		EnableBank = true;
	else
		BankFrame:RegisterEvent('BANKFRAME_OPENED')
		BankFrame:RegisterEvent('BANKFRAME_CLOSED')
		EnableBank = false;
	end

	if EnableBank or EnableBag then
		self:RegisterMessage('COMBUCTOR_BANK_OPENED', function()
			if EnableBank then
				self:Show(BANK_CONTAINER, true);
			end
			if EnableBag then
				Combuctor.Autobackpack = GetTime();
				self:Show(BACKPACK_CONTAINER, true);
			end
		end);
		self:RegisterMessage('COMBUCTOR_BANK_CLOSED', function()
			self:Hide(BANK_CONTAINER, true)
			self:Hide(BACKPACK_CONTAINER, true)
		end);
	else
		self:UnregisterMessage('COMBUCTOR_BANK_OPENED');
		self:UnregisterMessage('COMBUCTOR_BANK_CLOSED');
		if BF_bagFrameBenable then
			BagManage_BankOpenAll(1)
		end
	end

	-- hooksecurefunc('CloseBackpack', hideBackPack)

	--closing the game menu triggers this function, and can be done in combat,

	if (not loaded) then
		local function HideInventory()
			if (Combuctor.EnableBag) then self:Hide(BACKPACK_CONTAINER) end
		end
		hooksecurefunc('CloseBackpack', HideInventory)
		hooksecurefunc('CloseAllBags',HideInventory)
		loaded = true;
	end

	self:RegisterEvent('MAIL_CLOSED', hideBackPack)
	self:RegisterEvent('TRADE_CLOSED', hideBackPack)
	self:RegisterEvent('AUCTION_HOUSE_CLOSED', hideBackPack)
end
