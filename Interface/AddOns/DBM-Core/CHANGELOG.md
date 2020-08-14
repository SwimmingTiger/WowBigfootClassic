# Deadly Boss Mods Core

## [1.13.56](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.56) (2020-08-11)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.55...1.13.56) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Classic/releases)

- Push a new release. Want to push updates out more often to get AQ fixes/additions out quicker. Frequent releases will slow after initial wave of AQ updates  
- Tweak dark glare timer  
- added GTFO for blizzard on Twin Emperors  
- AQ Updates:  
     - Reset speed clear data for AQ40 again, since it was missing the patrolling Obsidian Eradicator mob which could be used to start run instead  
     - Throttle reflect warnings so they aren't spammy as hell  
     - Changed explode run out warning to off by default. it's not as dangerous in classic as it was in private servers and it's already being ignored by most. That said, it's there for anyone who wants to turn it on  
- Add Eye beam target scanner to Cthun, needs testing.  
- Change weakened trigger to fix detection. Closes #449  
- update this to follow normal rules for events that only have en emote trigger  
- Update localization.tw.lua (#448)  
- Update localization.cn.lua (#447)  
- Attempt fix Frenzy warning bug from #440 (#446)  
- Cancel  timer on berserk  
- Couple tweaks  
- Add this to alpha for now, play it by ear  
- Remove unneeded calls to SetZone, it's always called in NewMod object, only needs to be called at mod level if it's changed.  
- Prep classic alpha revision before 21526326 prs come in  
