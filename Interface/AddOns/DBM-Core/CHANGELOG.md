# Deadly Boss Mods Core

## [1.13.6](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.6) (2019-09-04)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.5...1.13.6)

- Fix error, bump version  
- Tweaked Immolate warning to now be off by default on Garr, it still felt spammy enough to be an opt in warning, not opt out. Spam shouldn't be something that's ever defaulted  
    Added ignite mana timer to Baron Geddon  
    Added Inferno timer to Baron Geddon  
    Fixed bug with countdown yell for bomb on Baron Geddon  
    Made Bomb timer more robust on baron Geddon, in event actual debuff is resisted by target.  
    Fixed curse timer on Gehennas with live classic data.  
    Removed Doom Cast timer from Lucifron. he spends half the fight casting doom,it doesn't really need a cast timer showing that.  
    Added timers for first casts of doom and curse to Lucifron  
    Added optional (off by default) Conflagration target warning to Magmadar  
    Re-enabled Panic timer on Magmadar now that I've seen an agreeable amount of live classic timer data to confirm it.  
    Disabled all Deaden Magic warnings/timers on Shazzrah by default. That stuff can be spammy and spam should be opt in, not opt out.  
    Added Counterspell cooldown timer to Shazzrah  
    Fixed Gate timer on shazzrah being too slow.  
    Fixed initial curse timer on Shazzrah being too slow  
- Disable this timer, even in interview blizzard admit that the timer for deep breath really was just math.random . It's still random in wrath but a minimum time added. can't be confident that's case in classic.  
- #Onyxia Update  
    *Restored deep breath functionality. in classic, the spells are hidden from combat log, so we have to go oldschool, antispam measures are already in place if that changes, whatever trigger happens first is used.  
    *Updated tail swipe ID with classic one  
    *Added missing Wing Buffet and Bellowing Roar warnings  
    *Added syncing for yell triggers to ensure more users get the triggers if playing non english clients (in raid with people who are on english clients)  
- Fix stray )  
- Added teleport and shield cooldown timers to Majordomo  
    Added remaining sons warning to ragnoaros (for sons 3 2 and 1)  
    Added missing Wrath of rag timer for first wrath cast after sons phase has ended.  
    Fixed ragnaros mod so that if you are sitting outside, you won't accept syncs that submerge phase has begun.  
- It should be documented better that LibDBIcon rejects icons over a certain size  
- Work some additional ranges into rangecheck  
- Fix arg orders being backwards for emerge/submerge warnings, should fix green texture glitch  
- Fix voice pack sound filters on two bosses in MC  
    Tweaked paladin definitions a bitmore to ensure they are included in all warnings that apply to them  
    Reset option default on one of the reflect warnings to inherit the paladin changes  
- Fix regression from weeks ago that caused EJ icons to stop working  
- Revert "Layout fixes"  
- oh, still remove these  
- Instead of removing, strip it hella down  
- Revert "Missed these"  
- Revert "Compeltely remove LDB/minimap icon support. Can't get it to work right, so I'd rather not have it at all. typing /dbm is not that hard to bring up the GUI"  
- Layout fixes  
- Check all shield slam ranks  
- Missed these  
- Compeltely remove LDB/minimap icon support. Can't get it to work right, so I'd rather not have it at all. typing /dbm is not that hard to bring up the GUI  
- Fix count bug here too  
- Small SM update  
- Confirmed boss unit IDs don't exist in raids, so continue path of de-volving mods into less efficient methods  
- Fix UI-MinusButton  
- Fix numpty  
