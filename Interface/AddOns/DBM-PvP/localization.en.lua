local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "General Options"
})

L:SetTimerLocalization({
	TimerCap		= "%s",
	TimerFlag		= "Flag respawn",
	TimerInvite		= "%s",
	TimerRemaining	= "Time Remaining: ",
	TimerShadow		= "Shadow Sight",
})

L:SetOptionLocalization({
	AutoSpirit			= "Auto-release spirit",
	ColorByClass		= "Set name color to class color in the score frame",
	HideBossEmoteFrame	= "Hide the raid boss emote frame and garrison/Guild toasts during battlegrounds",
	ShowBasesToWin		= "Show bases required to win",
	ShowEstimatedPoints	= "Show estimated points on win/loss",
	ShowFlagCarrier		= "Show flag carrier",
	TimerCap			= "Show capture timer",
	TimerFlag			= "Show flag respawn timer",
	TimerInvite			= "Show battleground join timer",
	TimerRemaining		= "Show time remaining for match start and match end",
	TimerShadow			= "Show timer for Shadow Sight",
	TimerWin			= "Show win timer"
})

L:SetMiscLocalization({
	ArenaInvite			= "Arena invite",
	BasesToWin			= "Bases to win: %d",
	WinBarText			= "%s wins",
	-- TODO: Implement the flag carrying system
	Flag				= "Flag",
	FlagReset			= "The flag has been reset!",
	FlagTaken			= "(.+) has taken the flag!",
	FlagCaptured		= "The .+ ha%w+ captured the flag!",
	FlagDropped			= "The flag has been dropped!",
	--
	InfoErrorText		= "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp		= "The (%w+) .lag was picked up by (.+)!",
	ExprFlagCaptured	= "(.+) captured the (%w+) flag!",
	ExprFlagReturn		= "The (%w+) .lag was returned to its base by (.+)!",
	FlagAlliance		= "Alliance Flag: ",
	FlagHorde			= "Horde Flag: ",
	FlagBase			= "Base",
	Vulnerable1			= "The flag carriers have become vulnerable to attack!",
	Vulnerable2			= "The flag carriers have become increasingly vulnerable to attack!"
})

----------------------
--  Seething Shore  --
----------------------
L = DBM:GetModLocalization("z1803")

L:SetOptionLocalization({
	TimerSpawn	= "Show azerite spawn timer"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetOptionLocalization({
	AutoTurnIn	= "Automatically turn-in quests"
})

--------------
--  Ashran  --
--------------
L = DBM:GetModLocalization("z1191")

L:SetOptionLocalization({
	AutoTurnIn	= "Automatically turn-in quests"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "Siege Engine ready!",
	WarnSiegeEngineSoon	= "Siege Engine in ~10 sec"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Siege Engine ready"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Show timer for Siege Engine construction",
	WarnSiegeEngine		= "Show warning when Siege Engine is ready",
	WarnSiegeEngineSoon	= "Show warning when Siege Engine is almost ready",
	ShowGatesHealth		= "Show the health of damaged gates (health values may be wrong after joining an already ongoing battleground!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Damaged gates",
	SiegeEngine				= "Siege Engine",
	GoblinStartAlliance		= "See those seaforium bombs? Use them on the gates while I repair the siege engine!",
	GoblinStartHorde		= "I'll work on the siege engine, just watch my back. Use those seaforium bombs on the gates if you need them!",
	GoblinHalfwayAlliance	= "I'm halfway there! Keep the Horde away from here.  They don't teach fighting in engineering school!",
	GoblinHalfwayHorde		= "I'm about halfway done! Keep the Alliance away - fighting's not in my contract!",
	GoblinFinishedAlliance	= "My finest work so far! This siege engine is ready for action!",
	GoblinFinishedHorde		= "The siege engine is ready to roll!",
	GoblinBrokenAlliance	= "It's broken already?! No worries. It's nothing I can't fix.",
	GoblinBrokenHorde		= "It's broken again?! I'll fix it... just don't expect the warranty to cover this"
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerCart	= "Cart respawn"
})

L:SetOptionLocalization({
	TimerCart	= "Show cart respawn timer"
})

L:SetMiscLocalization({
	Capture	= "has captured"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetOptionLocalization({
	ShowOrbCarriers	= "Show flag carrier",
})

L:SetMiscLocalization({
	OrbTaken	= "(%S+) has taken the (%S+) orb!",
	OrbReturn	= "The (%S+) orb has been returned!"
})
