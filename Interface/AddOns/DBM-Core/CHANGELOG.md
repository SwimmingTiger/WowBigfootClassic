# Deadly Boss Mods Core

## [1.13.45](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.45) (2020-05-13)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.44...1.13.45)

- Prep a new release, best way to test the Speed clear feature, is to release it in wild.  
- Simplify speed clear option object so there is less copying and pasting of same option text in multiple raids  
    Added speed clear option/feature to Molten core as well.  
- Re-enable nef and onyxia head timers, but leave heart and rend disabled since they were the more problematic ones  
- Revert a bad change and make build succeed.  
- Added experimental support for Speed clear support BWL, conforming to same criteria as BWL (Pulling razorgore start, killing nefarian, end).  
     - This feature will show a timer for entirety of raid from moment you pull razorgore, if you have clear time from a previous clear that is.  
     - Additionally, it will show a message on nefarians death (whether you had existing timer data or not) how long current run took and whether or not you beat existing record stored in DBM.  
- Merge pull request #131 from woopydalan/patch-67  
    Update localization.es.lua  
- Update localization.es.lua  
- Merge pull request #130 from Saritus/Fix-Emeriss-localization  
    Fix localization of Emeriss  
- Change Localization of Emeriss  
- Change world buff alert sound from readycheck to instead use whatever user has set as their general announce sound.  
- Added readycheck sound to world buff alerts  
- Ru updates for BWL, Fixes #129  