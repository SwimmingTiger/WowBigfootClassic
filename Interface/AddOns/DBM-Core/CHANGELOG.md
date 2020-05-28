# Deadly Boss Mods Core

## [1.13.47](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.47) (2020-05-28)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.46...1.13.47)

- Prep new Classic Tag for fixes to range frame and guild syncs  
- Whitespace that was bothering me  
- Merge pull request #169 from DeadlyBossMods/QartemisT-patch-1  
    Fix #168  
- Fix over-active replace  
- Update luacheck  
- Fix #168  
- Remove no longer used upvalue  
- Add protections against being guildless, or the guild API returning nil or < 1 players online  
    Also changed logic of math.random too for good measure to absolutely ensure that a whole number is being used.  
    Both of these SHOULD fix #211  
