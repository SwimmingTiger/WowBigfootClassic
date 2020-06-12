# Deadly Boss Mods Core

## [1.13.48](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.48) (2020-06-05)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.47...1.13.48)

- Clean out unused real quick  
- Prep new classic release  
- Revert "Apply name strip to infoframe and rangecheck as well (kind of useless in classic, since cross realm didn't exist until mists, but code uniformity and all)"  
- Apply name strip to infoframe and rangecheck as well (kind of useless in classic, since cross realm didn't exist until mists, but code uniformity and all)  
- Merge pull request #198 from nanjuekaien1/patch-1  
    Update localization.cn.lua  
- Update localization.cn.lua  
- Fixed some bugs in new special warning filtering code  
- Fix  
- Updated special warning global disble options to allow greater control over what parts of special warning object is disabled. It is now possible to disable only text alerts, only sound alerts, or only flash alerts, or any combination of them. Technically some of this was possible before through various options in other place but it made sense to make sure the global options presented it better.  if you want to disable special warnings completely, you just disable all 3.  
- fix issue templates  
- Removed a disable/filter option that's obsolete since 8.2, nameplate lines are dead.  
    Added new disable/filter categories to help users find what they desire more quickly  
- Merge pull request #197 from DeadlyBossMods/retail-sync  
    Fix checkboxes in classic (Because of a bug)  
- This actually fixes the issue. PHEW  
- Hack fix is hacky  
- Use height 1 or objects start dissapearing  
- Classic fix... Stupid blizzard  
- Merge pull request #196 from DeadlyBossMods/retail-sync  
    Retail sync  
- Derp 2  
- Derp  
- Retail sync  
- Merge pull request #194 from DeadlyBossMods/issue  
    Sync last retail patch;  
- Sync last retail patch;  
    * Remove default .GITHUB stuff, as its provided globally (like in retail repo)  
    * Add a link to retail issues  
    * Fix editorconfig out-of-sync.  
- Remove razorgore egg message  
- Fixed some world buff syncs being incorrectly sent. Closes #184  
- Update localization.es.lua (#190)  
- Create localization.mx.lua (#191)  
- Update DBM-MC.toc (#192)  
    * Update DBM-MC.toc  
    * Update DBM-MC.toc  
- Update localization.es.lua (#189)  
- Update localization.cn.lua (#188)  
- Update localization.cn.lua (#187)  
    * Update localization.cn.lua  
    * Update localization.cn.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.cn.lua (#186)  
- Fixed a bug that could cause event sounds to throw errors if User has no media installed and selects "Random" option  
- Update localization.cn.lua (#183)  
- Merge pull request #182 from nanjuekaien1/patch-1  
    Update localization.cn.lua  
- Update localization.cn.lua  
- Sync GUi code with retail  
- Merge pull request #181 from woopydalan/patch-98  
    Update localization.es.lua  
- Update localization.es.lua  
- Remove references/checks for the older threat lib  
- Update localization.cn.lua (#180)  
- Update localization.mx.lua (#179)  
    * Update localization.mx.lua  
    * Update localization.mx.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Updated Messaging to reflect that SpellTimers and RaidLeadTools projects are no more and must be uninstalled  
- Update localization.es.lua (#178)  
- Fix a bug where MC and BWL speed clear timers would show speed clear stats twice (with a 3 second difference) the second time it showed was do fact DBM-Core calls mod.OnCombatEnd twice for cleanup. The second 3 second later time will no longer show.  
- Revert "Add guild sync throttle code to World buff syncs as well done in guild."  
- Add guild sync throttle code to World buff syncs as well done in guild.  
- Extra failsafe for good measure  
- Fixed spelltimers version checks on alpha versions of spelltimers that add git hash  
- Update editbox on classic  
- Update DBM-Onyxia.toc (#177)  
- Create localization.mx.lua (#176)  
- Update localization.es.lua (#175)  
- Revert "Sync Classic fixes to retail fixes"  
- Sync Classic fixes to retail fixes  
- use loop for the nag  
- Updated SpellTimers block code to only block specific incompatible versions instead of all of them  
    Whitespace cleanup  
- Update localization.cn.lua (#173)  
- Update localization.cn.lua (#172)  
- Fix bug with timerBreath on chromaggus using incorrect timer object type.  
- Add missing reminder message on /dbm  
