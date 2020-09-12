# Deadly Boss Mods Core

## [1.13.60](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.60) (2020-09-10)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.59...1.13.60) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Classic/releases)

- Prep new release  
- Update localization.es.lua (#580)  
- Update localization.cn.lua (#579)  
- Update localization.tw.lua (#578)  
- Scrap revision based force disable code. it's been tried 3 different ways and it's always broken in some way. Instead. add a bunch of annoying messages in various places about being out of date (with no disable). exception is force disable will now ALWAYS run if PTR/Beta, because testing that with old mods is just hard no. Or a major patch. These two situations will always automatically disable DBM if it's out of date regardless of revision. All other situations, there will just be a lot of nagging with no disable. If this these chat message nags prove to be ineffective, more aggressive nags will be implimented. The force update by revision code wasn't scrapped because I believe users should ignore updates, I just couldn't get it to work the way i wanted without uglier and uglier hacky code that rarely worked right, so exploring different ways of doing it til something that isn't broken is found that gets the job done (gets users to update mods when important updates are available)  
- Update localization.es.lua (#577)  
- Update koKR (Classic) (#576)  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Changed nefarian add counts to do every 5 until at 15 THEN switch to every 3.  
- Update localization.cn.lua (#575)  
- Update localization.tw.lua (#573)  
    According to the check sequence of the EN document of classic, the TW localization file comes from the TW localization document of retail  
- Fixed one of the links  
- Added guide links to each category panel in options.  
    Fixed duplicate localization entry for General Options tab  
- Update koKR (Classic) (#572)  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.tw.lua (#571)  
- Update localization.cn.lua (#570)  
    * Update localization.cn.lua  
    * Update localization.cn.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Fixed regression with CheckNearby when the function was called by mod via bossModPrototype  
    Also fixed  bug that's existed for quite some time if GetUnitIdFromGUID is called by bossModPrototype. The reason this bug was never caught is because this function is pretty much never used on non boss unitId targets on retail and on classic it probably hasn't been used at all yet.  
- Fix two missed spots  
- Update localization.tw.lua (#568)  
- Sync GUI Re-arrangement and new options to classic from retail. Probably errors until I can do some review and let luacheck run  
- First batch of Syncs from retail to classic.  
     - Removed redundant Localizations  
     - Added Infoframe options plumbing (but not GUI yet)  
- some AddMsg fixes and some dbm vs self usage fixes  
- Update koKR (Classic) (#566)  
- Update localization.cn.lua (#565)  
- Update localization.tw.lua (#563)  
- 6 bytes  
- Scrap old explode bug waring that is spammy and add a smart one that scans nearby nameplates to determine if exploding bug is nearby. if it is, shows a special warning. Explode has 15 range and nameplate range is 20. This is a very smart way to filter it.  
- Forgot to update option text  
- Improvments to last  
- Lower cap of cthun infoframe from 40 down to 9. 9 should still get everything without it triggering column behaviors  
- Fixed regression on viscidus that caused frost tracker to completely bread  
    Fixed bug with shoot being counted during melee phase instead of frost  
- Improve wipe detection for razorgore to prevent declaring a phase 2 wipe as a victory  
- rep new alpha dev cycle  
