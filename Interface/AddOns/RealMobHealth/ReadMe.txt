Real Mob Health
by SDPhantom
https://www.wowinterface.com/forums/member.php?u=34145
===============================================================================

All Rights Reserved - Use at your own risk
UnZip contents into the "Interface\AddOns" folder in your WoW instalation directory


Commands:

/RMHDel [UnitID]
Removes selected UnitID from stored health values. This defaults to target if not specified.

===============================================================================

Versions:
2.2	(2019-08-09)
	-Fixed newly created nameplates not checking options

2.1	(2019-08-08)
	-Implemented GetNormalizedRealmName() fallback if UnitFullName("player") fails to return realm name
	-Fixed stack overflow in UITweaks

2.0	(2019-07-14)
	-Complete restructure
	-Supporting code is split into different modules
	-Peer system broadcasts discovered health values and makes queries through the AddOn comm channels
	-Health recording can now happen when targeting a corpse after witnessing a fight
	-New cache timeout system purges damage data from mobs that have not been seen in a while
	-Cache timeout varies based on what data exists for the mob and if the addon is aware the mob is dead
	-BlizzardUI Tweaks is reintegrated to streamline the new options system
	-Lots of API additions/tweaks/changes (See APIDoc.txt)
	-Callbacks are now handled by the new event system
	-RealMobHealth.GetUnitHealth() speculative mode is now force-enabled. The argument to control it has been removed.

1.1	(2019-06-05)
	-Streamlined the core code
	-Fixed issue with Shaman totems getting recorded
	-World/Raid bosses are now supported
	-Damage reflection is now properly tallied
	-More API functions (See APIDoc.txt)
	-RealMobHealth.GetHealth() had been renamed RealMobHealth.GetUnitHealth()
	-RealMobHealth.GetUnitHealth() now falls back to native values if not enough data present
	-GameTooltip hook now only runs if the unit is attackable

1.0	(2019-05-19)
	-Classic release
	-Records damage taken of nearby mobs from the CombatLog
	-Obtains mob level using mouseover/target/partytarget/raidtarget and if enabled, nameplates
	-TargetFrame and Nameplates show text values for health, TargetFrame also shows mana/rage/energy
	-Gametooltip shows which mobs have had their health recorded
