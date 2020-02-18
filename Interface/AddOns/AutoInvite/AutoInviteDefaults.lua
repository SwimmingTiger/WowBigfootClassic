local addonName, addonTable = ...
AutoInvite = addonTable

function AutoInvite:LoadDefaults()
	AutoInviteSettings = {
		AutoInviteEnabled = false,
		AutoInviteKeyword = "invite",
		AutoInviteChannel = "SAY"
	}
end