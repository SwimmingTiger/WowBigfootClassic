QuestLogEx = LibStub("AceAddon-3.0"):NewAddon("QuestLogEx", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")

function QuestLogEx:OnInitialize()
	self:InitializeDB()
	self:HookQuestLog()
end