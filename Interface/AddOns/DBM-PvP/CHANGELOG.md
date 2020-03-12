# <DBM> PvP

## [r83](https://github.com/DeadlyBossMods/DBM-PvP/tree/r83) (2020-03-10)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-PvP/compare/r82...r83)

- Revert travis change for now. packager doesn't yet support 1.13.4  
- Update toc file for 1.13.4  
    Updated travis for 1.13.4  
- Merge remote-tracking branch 'origin/master'  
- Update resources for BattleForGileanas, thanks Goat.  
- Missed one  
- Actually didn't have any errors, just updating luacheckrc ignores  
- Lets find some PVP errors  
- Merge pull request #14 from venuatu/master  
    fixup classic AV, port over some of the previous code and add logging  
- fixup classic AV, port over some of the previous code and add logging  
- Fix paws being stupid.  
- Make the POI's now non-localized dependant :D WOO  
- Better timers for alterac  
- Fix alterac timers not being 304.  
- Forgot to remove this line  
- Fix assault ID for Arathi on classic.  
- Lots of interesting fixes;  
    - Temple of Kotmogu now properly tracks a win timer  
    - Alterac has now been moved to the central assault system  
    - Alterac now supports both classic, and retail.  
- Optimize quest data for Alterac auto-complete  
- Update EyeOfTheStorm and TempleOfKotmogu to the correct system  
    Also add more accurate data for 4 cap states (owned by 1 or 2).  
    Add a nil/not string check for bases as throws errors for flag maps like EyeOfTheStorm  
    Don't alert for scores larger than 50 being invalid, as flag caps count towards that.  
