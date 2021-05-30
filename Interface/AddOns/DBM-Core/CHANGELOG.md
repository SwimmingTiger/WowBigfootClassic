# Deadly Boss Mods Core

## [2.5.4](https://github.com/DeadlyBossMods/DBM-TBC-Classic/tree/2.5.4) (2021-05-27)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-TBC-Classic/compare/2.5.3...2.5.4) [Previous Releases](https://github.com/DeadlyBossMods/DBM-TBC-Classic/releases)

- prep tag  
- Sync profile fixes.  
- All Rights Reserved license  
- Actually fix Loathab properly  
- fix onyxia auto logging  
- Fix Frost Breath spellID. Closes #13  
- Update koKR (BCC) (#14)  
    * Update koKR (TBCC)  
    * Update koKR (BCC)  
- Fix Corrupted Mind. Closes #12  
- Update localization.en.lua  
- Fix CLASSIC\_ONLY message  
    It was referencing to install retail ??  
- BCC terminology.  
- Make the message more clear about Classic Era on TBC  
- it's 2021, not 2020  
- Fix Skeram kill detection to ignore CID going forward do to changes in BCC  
- Made guild boss engage/defeat/wipe more robust against seeing multiple messages  
- Update koKR (TBCC) (#10)  
- Niche bugs.  
- Separate huge and small bar height option.  
    - While I was at it, renamed Bar Alpha to Alpha, as it was too long.  
- Fixed a bug where a nil error could be thrown by hudmap on hearthing. Seems new to BCC client as this wasn't happening on Classic vanilla client, so data probably returns slower now on loading screen.  
    Fixed a bug where Fel crystal warning/timer was not localized on BCC client in Magisters terrace  
- Update ci.yml  
    update  build for packager  
- Merge pull request #8 from venuatu/escorttimers  
    add quest escort timers (shattrath and caverns of time)  
- add quest escort timers (shattrath and caverns of time)  
- Merge pull request #7 from venuatu/attumen  
    kara/attumen: update curse timers from logs  
- kara/attumen: update curse timers from logs  
- kara/moroes: add gouge cd timer for tanks and update vanish cd (#6)  
- kara/attumen: switch monster yell to spell summon event (#5)  
- update luacheck  
- GetDungeonInfo Forward compat  
