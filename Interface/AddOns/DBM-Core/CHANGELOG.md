# Deadly Boss Mods Core

## [1.13.62](https://github.com/DeadlyBossMods/DBM-Classic/tree/1.13.62) (2020-12-01)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.61...1.13.62) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Classic/releases)

- Bump Classic TOC  
- Fixed logged syncs so they don't actually needlessly send syncs to self over comms, just locally handle like non logged syncs  
    Fixed world syncs (used by world bosses and world buffs) to actually locally handle sync so you can still get world buff alerts when you aren't guilded.  
- Update localization.br.lua (#637)  
- Update localization.cn.lua (#636)  
- Update localization.es.lua (#634)  
- Update localization.mx.lua (#635)  
- Update localization.br.lua (#633)  
- Fixed option spell Id for frost tomb on KT  
    Added enrage support to Gluth  
- Update localization.fr.lua (#631)  
- tweak landslide trample timer  
- Removed infoframe and frozen timer from Viscidous. Phase detection is unreliable and so are counters. This, combined with fact that classic support is being scaled back significantly, measures are being taken to either fix lose ends, or remove them.  
- make dark glare warning/timer show/end 2 seconds earlier Closes #554  
- Several sapphiron and KT fixes. Both probably need more work but this best could be done without transcriptor and extensive debug  
- Cho rush going friendly should now be registered as a victory  
- Update koKR (Classic) (#629)  
- Update localization.de.lua (#630)  
- Update localization.ru.lua AQ40 (#628)  
    * Update localization.ru.lua  
    * Update localization.ru.lua  
- Update localization.ru.lua (#622)  
    * Update localization.ru.lua  
    * Update localization.ru.lua  
    * Update localization.ru.lua  
- Update localization.ru.lua (#627)  
- Update DBM-AQ20.toc (#626)  
- Create localization.mx.lua (#625)  
- Tweak adds from Gothik based on feedback, not totally verified yet.  
- Update localization.es.lua (#624)  
- Fix bad icon and option default  
- Update localization.br.lua (#623)  
    * Update localization.br.lua  
    * Update localization.br.lua  
- Update localization.de.lua (#621)  
- Update DBM-Naxx.toc (#620)  
- Update localization.cn.lua (#619)  
- missed one  
- Cleanup Gothik a little  
- naxx: refine some timers from logs (#612)  
- Update localization.cn.lua (#618)  
- Noth Update  
     - Fixed adds trigger for classic, emotes don't exist, have to use yell fallback. Unfortunately this basically means no balcony phase adds timers at the moment.  
     - Adjusted some Adds timers to match classic  
     - Added Blink cast warning  
- Grobbulus Update  
     - Injection target warning will no longer be filtered.  
     - Added optional (off by default) SAY for injection  
     - Tweaked cloud timer to be a cd instead of next, it's not as precise in classic as it is in wrath  
- Thaddius Update  
     - Update thaddius arrow object to a dropdown instead of a series of confusing bool options. Also made the standard 4 group option oni by default. After seeing that PTR, classic players definitely need the handholding.  
     - Updated timers based on public logs and videos, tank throw might still need some work  
     - Fixed phase two trigger. In Classic it uses Monster Message, not raid emote  
- Update localization.fr.lua (#617)  
    * Update localization.fr.lua  
    * Update localization.fr.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.es.lua (#616)  
    * Update localization.es.lua  
    * Update localization.es.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.mx.lua (#615)  
- Update localization.ru.lua (#613)  
    * Update localization.ru.lua  
    * Update localization.ru.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.ru.lua (#614)  
- just a comment  
- Merge pull request #609 from anon1231823/patch-214  
    Update localization.fr.lua  
- Update localization.fr.lua  
- Merge pull request #608 from anon1231823/patch-213  
    Update DBM-Naxx.toc  
- Merge pull request #607 from anon1231823/patch-212  
    Create localization.br.lua  
- Update DBM-Naxx.toc  
- Create localization.br.lua  
- Merge pull request #606 from anon1231823/patch-210  
    Update DBM-Naxx.toc  
- Update DBM-Naxx.toc  
- Merge pull request #605 from anon1231823/patch-209  
    Update localization.es.lua  
- Merge pull request #604 from anon1231823/patch-208  
    Create localization.mx.lua  
- Update localization.es.lua  
- Create localization.mx.lua  
- Razuvious Update  
     - Fixed a bug where shout timer did not start  
     - Updated shout timer and taunt CD timer for classic version  
     - Changed shield wall timer to correct object type  
- whitespace cleanup and added missing entries to russian auto translations  
- Fixed bug in classic branch calling a function that doesn't exist with hyperlink hook  
- prep next dev cycle  
