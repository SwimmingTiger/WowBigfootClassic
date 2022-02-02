--[[
	general.lua
		General settings menu
--]]

local CONFIG = ...
local L = LibStub('AceLocale-3.0'):GetLocale(CONFIG)
local ADDON, Addon = CONFIG:match('[^_]+'), _G[CONFIG:match('[^_]+')]
local General = Addon.OptionsGroup('GeneralOptions')

function General:Populate()
	self:AddCheck('locked')
	self:AddCheck('tipCount')

	if CanGuildBankRepair and self.sets.tipCount then
		local guild = self:AddCheck('countGuild')
		guild.left = guild.left + 10
		guild:SetSmall(true)
	end

	self:AddCheck('flashFind')
	self:AddCheck('displayBlizzard')

	local global = self:Add('Check', L.CharacterSpecific)
	global:SetChecked(Addon.profile ~= Addon.sets.global)
	global:SetCall('OnInput', function() self:ToggleGlobals() end)
	-- 老虎会游泳：添加重置背包按钮
	self:ResetButton()
end

function General:ToggleGlobals()
	if Addon.profile == Addon.sets.global then
		self:SetProfile(CopyTable(Addon.sets.global))
	else
		LibStub('Sushi-3.1').Popup {
			id = ADDON .. 'ConfirmGlobals',
			text = L.ConfirmGlobals, button1 = YES, button2 = NO,
			whileDead = 1, exclusive = 1, hideOnEscape = 1,
			OnAccept = function()
				self:SetProfile(nil)
				self:Update()
			end
		}
	end
end

-- 老虎会游泳：添加重置背包按钮
function General:ResetButton()
	local reset = self:AddLabeled('RedButton', 'ResetCombuctorButton')
	reset:SetText(L.ResetCombuctor)
	reset:SetTip(L.ResetCombuctor, L.ResetCombuctorTooltip)
	reset:SetCall('OnClick', function()
		Combuctor_Sets = {
			CombuctorPatchVersion = type(Combuctor_Sets)=='table' and Combuctor_Sets.CombuctorPatchVersion or nil
		}
		ReloadUI()
	end)
end

function General:SetProfile(profile)
	Addon:SetCurrentProfile(profile)
	Addon.Frames:Update()
end
