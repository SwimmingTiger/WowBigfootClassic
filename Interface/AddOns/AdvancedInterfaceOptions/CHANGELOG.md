# Advanced Interface Options

## [1.5.0](https://github.com/Stanzilla/AdvancedInterfaceOptions/tree/1.5.0) (2021-05-15)
[Full Changelog](https://github.com/Stanzilla/AdvancedInterfaceOptions/compare/1.4.4...1.5.0) [Previous Releases](https://github.com/Stanzilla/AdvancedInterfaceOptions/releases)

- Rename everything concerning TBC Classic to BCC  
- -  
- Add C\_CVar functions to luacheck  
- Implement CVar backup and restore functionality  
- Implement consolidated GetCVars() function  
- Fix CVarExists function  
- Hook newer C\_CVar.SetCVar function for cvar tracing  
- Fix 'last modified by' cvar tracing  
- Consolidate IsClassic() check for classColors  
- Fix missing reference to lootLeftmostBag for BC client  
    - Remove reliance on IsRetail() and IsClassic(), just check if functions exist directly  
- Add WOW\_PROJECT contants to luacheckrc  
- Fix the feature gates for BC  
- Add BC build and split builds into push and pr  
- Add Wago API token  
- Publish to Wago as well  