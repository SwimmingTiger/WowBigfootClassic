# Deadly Boss Mods Core

## [1.13.41](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.41) (2020-03-17)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.40...1.13.41)

- Prep new release  
- Chromaggus vulnerability check (if it's enabled) now has further reduced cpu usage and chance to spam  
- Update rend buff timer, closes #111  
- Added special warnings for flamegor's and Chromaggus' frenzy spells, per user request.  
    Tweaked timer and non special warning defaults for both frenzy casts to also include healers  
- DBM GUi & Timer Update  
     - Simple and Classic Bar behaviors are now more clear what's different between the two  
     - Simple bar behavior now supports controlling spark, flash, and time for when bars enlarge (previously only Classic bar supported this)  
     - Removed Enlarge bar by percent option. Two options that do same thing were unclear and caused conflict with Simple bar style, so it's just pruned. Use Bar enlarge by time option  
     - Adjusted timer option GUI to accomidate these changes.  
- Merge pull request #110 from Elnarfim/master  
    KR Update (Classic)  
- KR Update (Classic)  
- KR Update (Classic)  
- Update localization.es.lua (#109)  
- Update Travis  
