# Deadly Boss Mods Core

## [1.13.49](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.49) (2020-06-12)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.48...1.13.49)

- Fix remaining Errors and ready a release  
- Fix first few batch of loop variable errors. Second back will be after this commit  
- Sync lua check with retail luacheck changes.  
    Sycned a few retail core changes to classic.  
- Update localization.es.lua (#231)  
- Merge pull request #230 from woopydalan/patch-125  
    Update localization.es.lua  
- Update localization.es.lua  
- Some more pixel adjustments in Special Announcements  
- Fixed a text overlap in announcements  
- Fixed bug with "Dont Play Special Warning Sound" option  
- Disable some model IDs that render incorrectly in classic  
- Fix  
- Sync Classic with Retail changes which include some cleanup and minor fixes to GUI  
- Fix AlwaysShowSpeedKillTimer on correct repo. NOW it should work in classic again.  
- Sync DBM-GUI to classic  
- Fix regression that caused guild combat syncs to throw lua errors. Closes #229  
- Sync strip realm changes. I realize that cross realm doesn't exist in normal situations but i hadn't considered BGs and what blizz might do in future, so this code should be synced.  
- replace can be dumb  
- Fixed arrow, infoframe, and luacheck  
- Fix the fix  
- Fixed a bug that caused the speed clear timers not to ever show  
    Tightened luacheck to catch these kind of mistakes going forward.  
- Create localization.fr.lua (#221)  
- Update DBM-Azeroth.toc (#222)  
- Create localization.br.lua (#223)  
    * Create localization.br.lua  
    * Update localization.br.lua  
    * Update localization.br.lua  
- Update DBM-MC.toc (#224)  
- Create localization.br.lua (#225)  
    * Create localization.br.lua  
    * Update localization.br.lua  
- Update DBM-Onyxia.toc (#226)  
- Update localization.es.lua (#228)  
- Update localization.mx.lua (#227)  
- Merge pull request #220 from woopydalan/patch-114  
    Update DBM-MC.toc  
- Merge pull request #219 from woopydalan/patch-113  
    Create localization.fr.lua  
- Merge pull request #218 from woopydalan/patch-112  
    Update localization.es.lua  
- Merge pull request #217 from woopydalan/patch-111  
    Update localization.fr.lua  
- Merge pull request #216 from Elnarfim/master  
    Update KR (Classic)  
- Update DBM-MC.toc  
- Create localization.fr.lua  
- Update localization.es.lua  
- Update localization.fr.lua  
- Update KR (Classic)  
- Update localization.mx.lua (#215)  
    * Update localization.mx.lua  
    * Update localization.mx.lua  
- Add user requested icon option for Onyxia Fireball  
- Merge pull request #213 from nanjuekaien1/patch-1  
    Update localization.cn.lua  
- Update localization.cn.lua  
- Add tab translations now, ahead of feature work, to allow more time for localization  
- Merge pull request #211 from woopydalan/patch-108  
    Update localization.es.lua  
- Merge pull request #212 from woopydalan/patch-109  
    Update localization.es.lua  
- Merge pull request #210 from woopydalan/patch-107  
    Update localization.mx.lua  
- Update localization.es.lua  
- Update localization.es.lua  
- Update localization.mx.lua  
- Update localization.cn.lua (#209)  
- Update localization.cn.lua (#206)  
    * Update localization.cn.lua  
    * Update localization.cn.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.cn.lua (#205)  
    The CN is localized according to the EN file and the format is synchronized to prepare for the next stage  
- missed a couple things in classic sync  
- DBM Core & Gui Updates  
      - Renamed "warning" objects to announce object, since not all announcements are warnings. Also removed "raid" from terminology because not all announcements are in raids (5 mans dungeons, pvp, solo play also have dbm modules so this classification was grossly inaccurate)  
      - Renamed "Bar Setup" to "Timers" to be more clear that those are timer options, since "bar" is a less accurate broad classification that can mean different things (timer bars, nameplate bars, health bars, etc).  
      - Renamed "General Messages" to "Chatframe Messages" to better reflect that options in that area toggle what message are or aren't shown in chat frame. Also moved this option area lower down list since it's has closer relationship to global disables and filters, it makes sense to be right next to it.  
      - On that note, one option was moved from global disables and filters to chatframe messages, because it was a better fit for that option. That option is the one that enables/disables showing reminder messages.  
      - Re-arranged core options a bit more, moving all options related to privacy into their own "Privacy" options tab and moved 3 of the chat frame message alerts from extra features, into Chatframe Messages where it made more sense for them to belong.  
      - Added a new privacy option, ported from classic but slightly modified to better align with retail, to disable the sending of world boss engaged/defeated sync messages.  
      - Moved some local variables that didn't belong at file level.  
      - Fixed a bug that caused the guild sync privacy option to never actually work because the disable sync, and sending sync were both sent in same frame update so not enough time was ever allowed to actually let the RL disablethis feature. Now there is a 1.5 second delay to allow this functionality to work correctly.  
      - Further Re-arrangements and renames. Sorry for breaking ReloadUI updates with this, but consistency had to be applied for easier code maintenance  
- Update localization.es.lua (#204)  
- Merge pull request #203 from woopydalan/patch-105  
    Update localization.mx.lua  
- Update localization.mx.lua  
- Update localization.mx.lua (#202)  
- Update localization.cn.lua (#200)  
- Merge pull request #199 from Elnarfim/master  
    Update KR (Classic)  
- Prep new alpha version before merging in PRs  
- Update KR (Classic)  
- Merge remote-tracking branch 'upstream/master'  
- Revert "Update KR (Classic)"  
- Update KR (Classic)  
- Merge remote-tracking branch 'upstream/master'  
- Merge remote-tracking branch 'upstream/master'  
- KR Update (Classic)  
