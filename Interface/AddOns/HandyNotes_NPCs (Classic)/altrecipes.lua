local name, data = ...
local Main = LibStub("AceAddon-3.0"):GetAddon("HandyNotes_NPCs (Classic)")
local Addon = Main:NewModule("AltRecipes", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_NPCs (Classic)")

local teachesToItemID = { }
do
	for k, v in pairs(data["items"]) do
		if v.teaches then
			teachesToItemID[v.teaches] = k
		end
	end
end

function Addon:OnInitialize()
	local defaults = {
		realm = {
			['*'] = {
				professions = {
					['*'] = nil,
				},
				learned = {
					['*'] = nil,
				},
			},
		},
	}
	
	self.db = Main.db:RegisterNamespace("AltRecipes", defaults)
	self:SetEnabledState(Main.db.profile.showAltRecipes)
end

function Addon:OnEnable()
	self.playerName = UnitName("player")
	self:RegisterEvent("SKILL_LINES_CHANGED")
	self:RegisterEvent("TRADE_SKILL_SHOW", "ScanTradeSkill") -- GetNumTradeSkills usually returns 0 here
	self:RegisterEvent("TRADE_SKILL_CLOSE", "ScanTradeSkill") -- Just try on both
	self:RegisterEvent("CRAFT_UPDATE", "ScanTradeSkill")
	self:HookScript(GameTooltip, "OnTooltipSetItem", "OnTooltipSetItem")
	self:HookScript(GameTooltip, "OnTooltipCleared", "OnTooltipCleared")
end

function Addon:OnDisable()
	self:UnregisterAllEvents()
	self:UnhookAll()
end

function Addon:Toggle()
	if Main.db.profile.showAltRecipes then
		self:Enable()
	else
		self:Disable()
	end
end

local lineAdded = false
function Addon:OnTooltipSetItem(tooltip, ...)
	if (lineAdded) then return end

	local itemName, itemLink = tooltip:GetItem()
	if (itemName == nil) then lineAdded = true return end
	local _, itemID = strsplit(":", string.match(itemLink, "item[%-?%d:]+"))
	self:CheckIfLearned(tonumber(itemID), tooltip)
end

function Addon:OnTooltipCleared(tooltip, ...)
	lineAdded = false
end

function Addon:CheckIfLearned(itemID, tooltip)
	if not data["items"][itemID] or not data["items"][itemID].profession then return end

	for k, v in pairs(self.db.realm) do -- Look through all the alts on realm
		if v.professions[data["items"][itemID].profession] then-- We have the profession
			if not lineAdded then tooltip:AddLine('\n') lineAdded = true end
			if v.learned[itemID] then
				tooltip:AddLine(L["Already learned by"] .. ": " .. k, 1, 0, 0)
			else
				if v.professions[data["items"][itemID].profession] >= data["items"][itemID].learnedAt then
					tooltip:AddLine(L["Could be learned by"] .. ": " .. k, 0, 1, 0) -- TODO Localize
				else
					tooltip:AddLine(L["Will be learnable by"] .. ": " .. k .. ' (' .. tostring(v.professions[data["items"][itemID].profession]) .. ')', .5, .5, 0)
				end
			end
		end
	end
	lineAdded = true
	tooltip:Show()
end

function Addon:SKILL_LINES_CHANGED() -- We do this in the main part too but seems easier to just leave it here also
	table.wipe(self.db.realm[self.playerName].professions)
	for i = 1, GetNumSkillLines() do
		local skillName, _, _, skillLevel = GetSkillLineInfo(i)
		if Main.PROFESSIONS[skillName] then
			self.db.realm[self.playerName].professions[Main.PROFESSIONS[skillName]] = skillLevel
		end
	end
end

function Addon:ScanTradeSkill(event)
	if event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" then
	for i = 1, GetNumTradeSkills() do
		local skillName, skillType = GetTradeSkillInfo(i)
		if skillType ~= "header" and skillType ~= "subheader" and teachesToItemID[skillName] then
			self.db.realm[self.playerName].learned[teachesToItemID[skillName]] = true
		end
	end
	end
	
	if event == "CRAFT_UPDATE" then
	for i = 1, GetNumCrafts() do
		local skillName, _, skillType = GetCraftInfo(i)
		if skillType ~= "header" and skillType ~= "subheader" and teachesToItemID[skillName] then
			self.db.realm[self.playerName].learned[teachesToItemID[skillName]] = true
		end
	end
	end
end
