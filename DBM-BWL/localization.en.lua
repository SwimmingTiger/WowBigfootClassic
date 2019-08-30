local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Razorgore the Untamed"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Adds spawning"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Show timer for first adds spawning"
}
L:SetMiscLocalization{
	Phase2Emote	= "flee as the controlling power of the orb is drained.",
	YellPull 	= "Intruders have breached the hatchery! Sound the alarm! Protect the eggs at all costs!\r\n"--Yes this yell actually has a return and new line in it. as grabbed by transcriptor
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name				= "Vaelastrasz the Corrupt"
}

L:SetMiscLocalization{
	Event				= "Too late, friends! Nefarius' corruption has taken hold...I cannot...control myself."
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name	= "Broodlord Lashlayer"
}

L:SetMiscLocalization{
	Pull	= "None of your kind should be here!  You've doomed only yourselves!"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Firemaw"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Ebonroc"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Flamegor"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Chromaggus"
}
L:SetWarningLocalization{
	WarnBreath		= "%s"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s CD"
}
L:SetOptionLocalization{
	WarnBreath		= "Show warning when Chromaggus casts one of his Breaths",
	TimerBreathCD	= "Show Breath CD"
}
L:SetMiscLocalization{
	Breath1	= "First Breath",
	Breath2	= "Second Breath"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "Nefarian"
}
L:SetWarningLocalization{
	WarnClassCall		= "%s call"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s call ends"
}
L:SetOptionLocalization{
	TimerClassCall		= "Show timer for class call duration",
	WarnClassCall		= "Announce class calls"
}
L:SetMiscLocalization{
	YellP2		= "Well done, my minions. The mortals' courage begins to wane! Now, let's see how they contend with the true Lord of Blackrock Spire!!!",
	YellP3		= "Impossible! Rise my minions!  Serve your master once more!",
	YellShaman	= "Shamans, show me",
	YellPaladin	= "Paladins... I've heard you have many lives. Show me.",
	YellDruid	= "Druids and your silly shapeshifting. Lets see it in action!",
	YellPriest	= "Priests! If you're going to keep healing like that, we might as well make it a little more interesting!",
	YellWarrior	= "Warriors, I know you can hit harder than that! Lets see it!",
	YellRogue	= "Rogues? Stop hiding and face me!",
	YellWarlock	= "Warlocks, you shouldn't be playing with magic you don't understand. See what happens?",
	YellHunter	= "Hunters and your annoying pea-shooters!",
	YellMage	= "Mages too? You should be more careful when you play with magic...",
	YellDK		= "Death Knights... get over here!",
	YellMonk	= "Monk"
}
