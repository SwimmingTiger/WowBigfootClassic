# Deadly Boss Mods Core

## [1.13.53](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.53) (2020-07-14)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.52...1.13.53) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Classic/releases)

- Prep new Release  
- Update localization.br.lua (#334)  
- Actually reset position with reset button  
- Fix a : that somehow got removed  
- Add a reset to default options button to the warning options  
- Update koKR (Classic) (#333)  
    * Update koKR (Classic)  
    * Update koKR  
    * Update koKR (Classic)  
    * Update koKR (Classic)  
- Update localization.cn.lua (#330)  
    local dateTable = date("*t")  
    if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then  
    	L.DEADLY\_BOSS\_MODS				= "Harmless Boss Mods"  
    	L.DBM							= "HBM"  
    What is the use?  
- Update WBA sync for whisperSyncHandlers for version 4 (#331)  
- Update localization.br.lua (#329)  
    * Update localization.br.lua  
    * Update localization.br.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.fr.lua (#328)  
    * Update localization.fr.lua  
    * Update localization.fr.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update Classic BW version check, which has been neglected for a while.  
- tweak against mallcious intent  
- Remove limiter, since it wasn't working anyways  
- Hey, I found a solution for Harmless Boss Mods :kappa: (#327)  
- Update localization.fr.lua (#322)  
- Update localization.br.lua (#324)  
- add ZG Buff yell timers and fixup say (#325)  
- Add further protection to clocks going backwards during daylight savings time ending  
- Fixed speed clear timers to be based on GetServerTime instead of GetTime() to resolve issues where syncing or even rebooting computer in middle of a run could cause the timer to get all screwed up.  
    As a result, this update also wipes Molten Core  timer data once again to remove any corrupted/bad stored timers. Sorry about this, but it shouldn't need resetting again. BWL data luckily should NOT need resetting since it never used syncing (which is something I need to add later so it supports timer recovery just like MC and AQ40 do)  
- Update localization.br.lua (#323)  
- Fix regressions to range checker where all the retail values were written over the classic values. Range checker should now only show the ranges classic supports, not ones retail does.  
- Increase Ragnaros range check (#312)  
- Update localization.fr.lua (#320)  
- Update localization.es.lua (#321)  
- Update koKR (Classic) (#319)  
    * Update koKR (Classic)  
    * Update koKR  
- Fixed regression that caused the major patch force disable code to never run do to incorrect placement of a nil check from a previous fix  
- Fix #317 (#318)  
- Support locale for WBE, WBD, GCB, GCE (#314)  
- Update localization.fr.lua (#315)  
- Update localization.br.lua (#316)  
- Update localization.fr.lua (#313)  
    * Update localization.fr.lua  
    * Update localization.fr.lua  
- Update localization.es.lua (#311)  
- Update koKR (Classic) (#310)  
- Update localization.fr.lua (#309)  
- Update localization.fr.lua (#308)  
- Adjust Ramstein add timer after more testing (#307)  
- Update travis  
- Update localization.fr.lua (#306)  
- Update localization.br.lua (#305)  
- Update localization.es.lua (#304)  
- Update localization.mx.lua (#303)  
- Add timer for black guards after Ramstein death (#302)  
- Bump alpha revision and remove hudmap duplication for questie. I left that in release since not everyone adopted questie 6.0 yet, but the NEXT dbm release (and current alpha cycle) will expect updated mods.  
