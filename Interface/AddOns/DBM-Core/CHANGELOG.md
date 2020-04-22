# Deadly Boss Mods Core

## [1.13.43](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.43) (2020-04-19)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.42...1.13.43)

- Also add hotfix revisions to improved mods  
- Bump version  
- Grabbed hakkars "Hard mode" max health from kill video and re-enabled start timers via health check on engage  
- Fixed few bugs with last PR  
     - Fixed enrage special warning never showing  
     - Fixed Aspect of Arlokk warning overwriting aspect of Marli warning  
     - Removed 4 duplicate timer objects that would just overwrite each other and corected start timers for engage  
     - Temporarily disabled the start timers though because they were coded to start in ALL pulls, hard mode or not, can't have that. A more robust method is needed to determine if it actually is a hard mode pull first (checking boss health or buffs on engage and THEN starting hard mode timers if x is present)  
     - Fixed a few incorrect aspect timers, from the very logs provided by the PR  
     - Changed aspect of Jeklik target timer to be off by default. Anything that has a chance to be spammy should be an opt in option, not an opt out  
     - Removed 2 unessesary syncs that were just bad copy paste  
- Merge pull request #123 from RyanFehr/ryfehr-zg-hakkar-support  
    Added support for HM Hakkar in ZG raid  
- Removed unecessary whitespace and updated variable name of the Thekal special warning to be named properly  
- Added support for HM Hakkar in ZG raid. Aspect of Jeklik currently creates a bar for every person hit, so that needs to be changed to only show it to the person hit rather than the whole raid  
- Added support for faster gaze warnings on Broodlord by utilizing yell text to pull name sooner (english only right now)  
    Switched Venoxis range checker to newer object that respects global options and removed unneeded locals for it.  
    Deleted heal cast timer from Jeklik since it's kinda ugly to support stopping timer when cast is interrupted.  
- Just a comment update  
- Merge pull request #122 from Elnarfim/master  
    KR Update (Classic)  
- KR Update (Classic)  
- Don't need these two lines either  
- Remove world buff timer from DBM, it'll still announce them, but timers for all world buffs now removed since the information (all 15 years worth of it) can't seem to get on same page.  
- Fix floor in last  
- Improved broodlord's gaze warning with a special warning if it's on you.  
- Merge pull request #121 from wsof401/wsof401-patch-bwl-cn-localization  
    fix cn localization  
- fix cn localization  
- Merge pull request #120 from woopydalan/patch-61  
    Update localization.es.lua  
- Fix minor bug with sync code on nef that made it not follow antispam throttling for exact local matches, this doesn't change mods on functional level but optimizing their syncing a little on code level.  
- Update localization.es.lua  
- Update localization.es.lua  