# Deadly Boss Mods Core

## [1.13.40](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.40) (2020-03-11)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.39...1.13.40)

- Major update to Vulnerability checks in BWL  
     - It is now off by default, at least while it recieves more testing.  
     - Fixed lua errors when holy spell damage hits talon guards or Chromaggus  
     - Fixed alert spam caused by bad code logic in checks that determine if a new warning was needed or not  
     - Significantly reduced cpu by the fixed improved checks on top of additionally eliminating periodic damage checks (they really shouldn't be needed). It'll also use 0 cpu when disabled (which is the default)  
     - Additional antispam throttles were added for target swapping or same vulnerability going up multiple times within a 3 second period.  
     - Added new feature to show vulnerability icon on top of nameplates (but it'll only work if you turn the warnings on, since the whole checking system is disabled if warning is off)  
- Fix missing localied school name (not sure why it's even done this way  
    Also silence errors if it's still missing  
- Merge pull request #106 from woopydalan/patch-56  
    Update localization.es.lua  
- Merge pull request #105 from woopydalan/patch-55  
    Update localization.ru.lua  
- Fixed a bug that'd cause EVERY dbm update to actually trigger the force disable. This bug has been present since 1.13.3 patch. only major patches OR being > 2 months out of date are supposed to trigger this.  
- Update localization.es.lua  
- Update localization.ru.lua  