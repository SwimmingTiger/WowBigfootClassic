# Deadly Boss Mods Core

## [1.13.57](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.57) (2020-08-18)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.56...1.13.57) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Classic/releases)

- Update localization.cn.lua (#477)  
- Prep new classic release  
- Infoframe should work with option, but the tentacles table needs to be a local variable. mod.vb doesn't support tables yet in sync methods so syncing it would cause errors, also wipe it on pull so lingering tentacles wouldn't show from previous pull after a wipe  
- cthun/tentacle: fixup a couple errors, still not exposing infoframe (#478)  
- Update localization.tw.lua (#475)  
- Fix editbox backdrop (#474)  
    The editbox already has a backdrop defined as part of InputBoxTemplate, this is causing a 2nd one to overlay on top, but outpositioned.  
- Update koKR (Classic) (#472)  
    * Update koKR (Classic)  
- Fix a typo  
- Fix checking wrong GUID on birth spell casts, which result in not finding tentacle IDs  
- Fix tentical removal  
- Update localization.cn.lua (#470)  
- Fix incorrect GetShapeshiftFormID ID  
- Tidy up some  
- Tentacle Spawn Timer (#469)  
- core: add tank to arms/ret spec role and check for tank stance in IsTank (#466)  
- bump all of the tank option versions (#467)  
- Odd that was missed in the PR, that wasn't something I introduced in last commit.  
    Also added minsync revision to block syncs from the 2 or so alphas that may include mobname  
- Few changes to Tentacle Infoframe  
     - Tentacle name is now localized. Getting name from sender would be problematic if sender played different language from reciever  
     - Removed unneeded local function. Since it was only called in one spot, didn't need to be split off.  
     - Saved a few bytes with self over mod usage.  
     - Put the arg names in OnSync handler and removed unnessesary shadowing of them while still having robust nil checks.  
     - Moved all moving parts of infoframe into same section. locals are generally declared at top of mod but only if they are used in multiple parts of it (for example if infoframe has updates in multiple places), otherwise they belong with section they are use. Option locals being the exception since finding those at top of mod helps  maintenance/updating of mod options without digging through mod to find all of them. (Not all older mods are good examples of this, as many of them were written over a decade ago and just updated for classic.)  
- core/IsHealer: allow any druid spec to be a healer but check for form (#468)  
- AQ40 Add support for Stomach Tentacle health monitoring outside of it (#460)  
- Remove unused  
- Update localization.cn.lua (#462)  
- Improve eye tentacle spawn detection/timers, Closes #463  
- aq/cthun: delay the eye beam target scanner a little (#459)  
- Update localization.ru.lua (#458)  
- Update localization.es.lua (#457)  
- Update localization.mx.lua (#456)  
- Update localization.de.lua (#455)  
- Update localization.fr.lua (#454)  
- Apply new lower restrictions for max targets announcements can show before they begin target aggregation.  
     - General announcements changed from 7 target cap to 6 (allowing up to a max of 2 pairs)  
     - Special announcements changed from 7 target cap to 5 (maxing out on the size of a 5 man party)  
- because of accuracy issues, cthun eye target features will be restricted to debug mode for dev testing only. Everyone else should not be shown inaccurate information  
- Fixed PlaySound not having the no sound check  
- Sync profile change from retail  
    Changed icon for speed timers from a string to a number, since it's calling timer object directly, api expects it to be a number, not a string. it's only core that expects it to be a string  
- Update localization.es.lua (#453)  
- Update localization.mx.lua (#452)  
- Fixed a bug that caused Whirlwind special warning to never show on Sartura. However, with the bug fixed, it should now be off by default since that's the expected behavior now  
- Fix name  
- Added frenzy dispel warning to Huhuran  
    Removed Frenzy buff active timer.  
- Update koKR (Classic) (#450)  
- Explain the teleport timer at least for short term  
