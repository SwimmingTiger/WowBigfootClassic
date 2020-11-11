# <DBM> PvP

## [r98](https://github.com/DeadlyBossMods/DBM-PvP/tree/r98) (2020-10-18)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-PvP/compare/r97...r98) [Previous Releases](https://github.com/DeadlyBossMods/DBM-PvP/releases)

- luacheck  
- Fixed regression to all pvp mods that caused them to literally never register any events in BGs, being effectively worthless mods. PVP mods rely on ZONE\_CHANGED\_NEW\_AREA to monitor registering/disabling of events but can't do that if they are coded to only ever run in a single zone.  
- Fixed a bug that allowed players to delete/replace BG Start timer by simply doing /countdown , now the Timer object in BG mods explicitely verifies timer type  
