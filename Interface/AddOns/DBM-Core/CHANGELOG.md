# Deadly Boss Mods Core

## [1.13.52](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.52) (2020-07-07)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.51...1.13.52) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Classic/releases)

- begin release preparations  
- Update localization.fr.lua (#300)  
- Update localization.fr.lua (#299)  
- Update localization.br.lua (#301)  
    finished  
- Fixed bug where talon guards mod was still showing an engage message. that was never intended to happen and didn't know it was happening since streamers usually hide chat/dbm messages.  
- Improve OnCombatEnd for uisng it to run functions that shouldn't be repeated  
- Update localization.br.lua (#298)  
    to be continued  
- Update localization.br.lua (#297)  
    to be continued  
- Use buff icons for world buff timers (#296)  
- Update GUI: localization.tw.lua (#295)  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- Fixed speed clear timers not having an icon  
    Disabled the speed clear timer in AQ20 for now since it's not a sanctioned speed run  
- Update localization.cn.lua (#290)  
- Update localization.tw.lua (#291)  
- Update localization.cn.lua (#292)  
- Update localization.de.lua (#294)  
- Enable lethon pull yell  
- Update DBM-Azeroth.toc (#289)  
- Update localization.br.lua (#287)  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- Merge pull request #288 from anon1231823/patch-36  
    Create localization.ru.lua  
- Create localization.ru.lua  
- Sync infoframe fixes  
- Merge pull request #285 from nanjuekaien1/patch-5  
    Update localization.tw.lua  
- Merge pull request #284 from anon1231823/patch-33  
    Update localization.br.lua  
- Merge pull request #286 from nanjuekaien1/patch-6  
    Update localization.cn.lua  
- Update localization.cn.lua  
- Update localization.tw.lua  
- Update localization.br.lua  
    to be continued (you can keep this PR open and I will keep making commits to it until I finish)  
- Merge pull request #282 from anon1231823/patch-31  
- Merge pull request #283 from anon1231823/patch-32  
- Update localization.br.lua  
- Update localization.fr.lua  
- Update localization.fr.lua (#281)  
- Update localization.br.lua (#279)  
- Update localization.br.lua (#280)  
- Fix bad copy/paste  
- Synced cross realm custom infoframe fixes to classic, even though classic doesn't have cross realm. It might apply to PVP mods or something else down the line.  
    Changed Gehennas and Faerlina to use GTFO object for GTFO warning  
    Removed heal timer on three bugs encounter within AQ40 and added a missing GTFO  
- Update localization.tw.lua (#278)  
- Merge pull request #277 from nanjuekaien1/patch-3  
- Update localization.tw.lua  
- Merge pull request #275 from anon1231823/patch-26  
- Merge pull request #276 from anon1231823/patch-27  
- Update localization.br.lua  
- Update localization.br.lua  
- Update localization.br.lua  
- Update localization.tw.lua  
    Looks like the name for Mar'li was different on warcraft logs  
    https://classic.warcraftlogs.com/reports/K9TJNGwWA6CvrbQH#fight=9  
- Update localization.br.lua  
    to be continued  
- Merge pull request #274 from anon1231823/patch-25  
    Update localization.br.lua  
- Update localization.br.lua  
- Merge pull request #273 from nanjuekaien1/patch-2  
    Update localization.tw.lua  
- Update localization.tw.lua  
- Merge pull request #271 from anon1231823/patch-24  
- Update localization.br.lua  
- Added enrage to Ayamiss  
    Fixed fernzy on Kurinnaxx to not fire for pets and stuff  
- Merge pull request #268 from anon1231823/patch-21  
    Update localization.es.lua  
- Merge pull request #269 from anon1231823/patch-22  
    Update localization.br.lua  
- Update localization.br.lua  
    to be continued  
- Update localization.es.lua  
- Merge pull request #267 from nanjuekaien1/patch-1  
    Update localization.cn.lua  
- Update localization.cn.lua  
- Update localization.br.lua (#266)  
    * Update localization.br.lua  
    * Fix whitespace  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Unified HudMap into DBMs global space instead of it having it's own. Temp compat in place until Questie supports new object naming.  
- Merge pull request #265 from anon1231823/patch-19  
    Update localization.ru.lua  
- Update localization.ru.lua  
- Sync locales changes from retail  
- Update localization.fr.lua (#264)  
- Update localization.tw.lua (#263)  
- Update localization.es.lua (#262)  
- Update localization.mx.lua (#261)  
- Create localization.tw.lua (#259)  
- Update DBM-ZG.toc (#260)  
- Create localization.de.lua (#258)  
- Merge pull request #257 from anon1231823/patch-11  
- Update localization.br.lua  
- Merge pull request #256 from anon1231823/patch-10  
    Update localization.br.lua  
- Update localization.br.lua  
- Fix stats area sizes and spacing on most raids  
- Fixed bug where spellId wasn't registered for new egg tracker experiment on razorgore  
- Improved NewAnnounce debug code  
- Disable corrupted blood yell by default. since the general strategy to deal with mechanic is to pretent it doesn't exist in classic, it ends up being spammy  
- Fix load order here too  
- Merge pull request #254 from DeadlyBossMods/QartemisT-patch-1  
    Should MCTrash not come before Lucifron  
- Update localization.cn.lua (#255)  
- Should MCTrash not come before Lucifron  
    When its called in Lucifron for getmod, it actually exists?  
- Merge pull request #252 from nanjuekaien1/patch-2  
    Update localization.cn.lua  
- Merge pull request #250 from anon1231823/patch-9  
- Merge pull request #251 from nanjuekaien1/patch-1  
    Update localization.cn.lua  
- Update localization.cn.lua  
- Update localization.cn.lua  
- Update localization.mx.lua  
- Merge pull request #249 from DeadlyBossMods/QartemisT-patch-1  
    Update Thaddius.lua  
- Reworked AQ40 and MC to properly support speed clear timers from first trash pull, and not first boss, to match warcraft Logs  
- Update Thaddius.lua  
- I'm tired of having to stash changes every time a pull request is merged, so threat lib is being removed NOW, not in 1.13.5  
    Added speed clear timer support to AQ20 and AQ40  
- Merge pull request #248 from anon1231823/patch-8  
    Update DBM-BWL.toc  
- Merge pull request #247 from anon1231823/patch-7  
- Bump alpha revision and sync some cvar stuff  
- Update DBM-BWL.toc  
- Create localization.br.lua  