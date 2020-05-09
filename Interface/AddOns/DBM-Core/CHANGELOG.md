# Deadly Boss Mods Core

## [1.13.44](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.44) (2020-05-02)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.43...1.13.44)

- prep classic tag, on actual classic repo  
- Merge pull request #128 from Elnarfim/master  
    KR Update (Classic)  
- Added very basic infoframe to keep Chromaggus vulnerability on the screen  
- Merge remote-tracking branch 'upstream/master'  
- Only set close player text when it's actually shown, to avoid nil errors and also to not waste cpu  
- KR Update (Classic)  
- When wrong version of DBM is installed, don't just display message once at login. display message every 15 seconds, indefinitely, until incorrect version of DBM is uninstalled  
- Merge range check fixes from retail DBM into classic DBM  
- DBM Timer Update  
     - Improved the DBM-GUI bar setup UI with better organizing of options  
     - Improved labeling each dummy bar with an appropriate bar label for each instead of all of them saying "dummy"  
     - Added a large bar example right next to small bar example in the part of timer GUI for configuring appearance options, so you can more visibly see how appearance options affect the two bar types.  
     - Added a user requested new option to change Start/End color to apply those colors to small/large bar types instead of being used as an animated color fade. This will allow users to setup bars in more ways (such as making small bars red and large bars blue if they wish)  
- Add start of french locals to BWL, this one just to support class calls and phase changes on nefarian for french client users  
    Also test to see if blizzard fixed encounter start on nefarian by treating it as a phase 1 trigger instead of phase 2. hopefully this doesn't break anything (cause it will if blizz didnt actually fix ES event yet)  
- Fix comments so not confusing  
- Remove whitespace from PR  
- Merge pull request #127 from woopydalan/patch-66  
    Update localization.es.lua  
- Update localization.es.lua  
- Update localization.es.lua  
- Update localization.es.lua  
- Fix spell ID  
- Remove bnet sync restriction  
- Fixed a bug that'd cause world buff timers to still show in some cases.  
    While at it, made it possible for authors or power users using DBMs debug mode, to still see the old world buff timers in all cases, should people ever want to help improve them and if they can be made accurate enough to my liking, be re-enabled for everyone.  
- Same fix to raid icon and canceling say messages, as well as intentionally lower sync priority since that should be the backup for crappy combat log range, never the primary  
- Fixed a bug that'd cause BA warning not to show if you somehow managed to get a sync before Combat Log event for it. This shouldn't happen but it apparently has been happening. You never know with wierd combat log delay bugs  
- Changed default sound priority of Adrenaline out warning. Closes #124  
    Changed icon option for BA to also be on by default.  
