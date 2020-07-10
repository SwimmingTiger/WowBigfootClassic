Modern TargetFrame
by SDPhantom
https://www.wowinterface.com/forums/member.php?u=34145
https://www.curseforge.com/members/sdphantomgamer/projects
===============================================================================

All Rights Reserved - Use at your own risk
UnZip contents into the "Interface\AddOns" folder in your WoW instalation directory

===============================================================================
Versions:
v1.8 (2020-07-08)
	-Rewrote threat system using Blizzard's ThreatAPI (Removed LibThreatClassic2)

v1.7 (2020-06-26)
	-Raised the DrawLayer sublevel of the numerical threat indicator text to help with random Z-order issues
	(Note: The text clipping under the border when long enough is an intended recreation of a bug in Modern WoW)

v1.6 (2020-06-05)
	-Fixed options code loading into the wrong variable scope

v1.5 (2020-06-03)
	-Improved handling of health/mana text conflicts
	-Implemented handling of the options "Defaults" button
	-Added ruRU locale (Courtesy of AmetistoFF)

v1.4 (2020-05-06)
	-Fixed some compatibility issues with other addons that re-add the health/mana text
	-Health/Mana text anchors reworked to match Modern WoW instead of being attached to their bars

v1.3.5 (2020-05-04)
	-Added zhCN locale (Courtesy of Junlin Zhou)

v1.3.4 (2020-05-01)
	-Updated LibThreatClassic2 (Rev 12 - 85c9fdb)
	-UnitThreatPercentageOfLead() is now implemented in LibThreatClassic2

v1.3.3 (2020-04-18)
	-Added deDE locale (Courtesy of xF10w21)
	-Updated LibThreatClassic2 (Rev 11 - 5a6c317)

v1.3.2 (2020-04-15)
	-Fixed unit existence checks in UnitThreatPercentageOfLead()
	-Updated LibThreatClassic2 (Rev 11 - 2a768c3)

v1.3.1 (2020-03-20)
	-Updated LibThreatClassic2 (Rev 9 - acb53a7)

v1.3 (2020-03-13)
	-Fixed implementation of UnitThreatPercentageOfLead(); returns zero instead of 100 when solo
	-Above note also fixes an inconsistency with how the Numeric Indicator works on Modern WoW
	-Fixed buff clipping when "Buffs On Top" is enabled

v1.2.1 (2020-03-03)
	-Added frFR locale (Courtesy of Arektor)

v1.2 (2020-02-22)
	-Options panel added to toggle features independently
	-Feature code split into separate modules
	-Localization code added

v1.1 (2020-02-20)
	-Threat indicator added with support for LibThreatClassic2 (Rev 8 - 1b60b21 Included)

v1.0 (2020-02-18)
	-Initial Version
	-Adds StatusBarText to TargetFrame's health and mana bars
	-Shows the Rare-Elite border texture for mobs under that classification
