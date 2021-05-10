-- declare defaults to be used in the DB
local defaults = {
	global =
	{
		maxQuestsDisplayed = 27
	},
	char =
	{
	},
	profile =
	{
		showLevel = true,
	}
}

function QuestLogEx:InitializeDB()
	self.db = LibStub("AceDB-3.0"):New("QuestLogExDB", defaults)
end