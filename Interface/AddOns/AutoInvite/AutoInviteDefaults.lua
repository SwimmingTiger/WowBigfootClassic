local addonName, addonTable = ...
AutoInvite = addonTable

function AutoInvite:LoadDefaults()
	AutoInviteSettings = {
		AutoInviteEnabled = false,
		AutoInviteKeyword = "1",
		AutoInviteChannel = "SAY"
	}
end
