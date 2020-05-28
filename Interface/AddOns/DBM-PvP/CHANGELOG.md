# <DBM> PvP

## [r88](https://github.com/DeadlyBossMods/DBM-PvP/tree/r88) (2020-05-27)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-PvP/compare/r87...r88)

- Set min core revision in pvp mods  
- Bit of code cleanup.  
- Fix build failure;  
    Stick locals outside of if statement, so tehy're recoginised by LuaCheck  
- Prevent time prediction updating twice during the same tick  
    This was causing the timer to update twice, making it a little "unpredictable" by 0.5 seconds. This is because the AREA\_POS\_UPDATED is updated twice; First for alliance, then horde.  
    Now we just do a delay check to only update once whether both sides own points, or just one side (when it's only fired once)  
- Prevent loading of non-classic features  
- Merge branch 'master' of github.com:DeadlyBossMods/DBM-PvP  
- Possible fix for AV issues... Hardcode the ID's once again  
- Fix one of update calls  
- Fix update calls.  
- Change to update over start  
- Added a 60/30 second fallback support for timers  
