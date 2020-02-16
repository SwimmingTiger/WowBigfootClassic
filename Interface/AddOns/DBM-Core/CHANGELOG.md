# Deadly Boss Mods Core

## [1.13.34](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.34) (2020-02-14)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.33...1.13.34)

- Bump classic version  
- Throttle version communication as well, especially guild communication.  
- ugly sync code more in BWL to reduce sync traffic  
- Adjust sync thresholds to block duplicates within 8 seconds, up from 5, to reduce chanec someone with a lot of lag sending an event late and causing possible timer/warning offsets with their potato internet/computer  
- some comments and expressions. Don't actually see why wing buffet timer wasn't appearing for some though?  
- Added optional special warning to break line of sight for fireball volley on razorcore. This is off by default in classic since there is already a non special warning for spell that fires if special warning is disabled. It's just a new option to use a bigger warning if you want to  
- Added breath cast bar to Chromaggus, since this is classic and all.  
    Added mutation stack monitor alert if stacks getting close to 5 to Chromaggus  
- Fixed a bug causing vael RP timer not to show  
- BWL Update 1  
     - Made Adrenaline target announce a non filtered announce on Vael  
     - Added fireball volley announce to Razorgore  
     - Improved Razorgore Phase 2 detection with CLEU event in addition to emote.  
     - Fixed conflag warning on razorgore not aggregrating targets into single warning.  
     - Added phase change timer for nefarian landing  
- Update version check ahead of BWL  
- Merge pull request #89 from Elnarfim/master  
    KR Update (Classic)  
- KR Update (Classic)  
- KR Update (Classic)  
- KR Update (Classic)  
- Preliminary ring of law support that at very least should engage when final boss of ring is engaged and track victory/wipe when said boss is defeated or not. It will NOT support the initial waves of event because that requires locals and stay in combat hacks. It'd be easier to support if blizz hadn't stripped out ENCOUNTER events for no reason, but it is what it is. Closes #81  
