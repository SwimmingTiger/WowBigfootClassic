Decursive prior versions change logs
====================================
***
(For the latest version changes see WhatsNew.md.txt)
***


Changes from Decursive 2.7.5.7 to Decursive 2.7.5.8 (2018-07-18)
----------------------------------------------------------------

- Basic update compatibility for WoW 8, please use the [ticket system][ticket] on
  WoWAce to report and track any issue you encounter.

- Change of author's email address: from now on it's Decursive {AT} 2072productions.com


Changes from Decursive 2.7.5.6 to Decursive 2.7.5.7 (2017-11-05)
----------------------------------------------------------------

- Update detected PVP spells for 7.3 (Hunters, Warlocks and Demon Hunters)


Changes from Decursive 2.7.5.4 to Decursive 2.7.5.6 (2017-09-04)
----------------------------------------------------------------

- Fix Lua error forwarding to Blizzard's default error handler (was broken
  since June).

- Fix MUF's tooltip overlap issue when MUFs are placed at the top of the
  screen.

- Improvements to debug reports.


Changes from Decursive 2.7.5.3 to Decursive 2.7.5.4 (2017-07-30)
----------------------------------------------------------------

- Fix MUFs's tooltip overlapping issue

- Add in combat status to debug reports and do report 'script ran too long'
  errors happening during initialisation.


Changes from Decursive 2.7.5.2 to Decursive 2.7.5.3 (2017-06-25)
----------------------------------------------------------------

- Make the MUFs' tooltips impervious to the tainting of GameTooltip by other
  add-ons. As a result the handling of these tooltips have been vastly
  improved (now using LibQTip instead of GameTooltip).

- Revert CLONE MAGIC back to DEVOUR MAGIC (warlock's pet magic charm dispel
  ability)


Changes from Decursive 2.7.5.1 to Decursive 2.7.5.2 (2017-03-28)
----------------------------------------------------------------

- TOC update for WoW 7.2


Changes from Decursive 2.7.5 to Decursive 2.7.5.1 (2017-01-19)
--------------------------------------------------------------

- Remove the Ice Armor test spell gone with 7.1.5 as it was triggering a
  diagnostic error at log-in for some users.

- Only report a "script ran too long" error when it happens for the second
  time in a 30 days period. As these (very rare) errors have become random
  since Legion, this technique should ensure that only real bottlenecks will
  get reported...


Changes from Decursive 2.7.4.7 to Decursive 2.7.5 (2016-10-27)
--------------------------------------------------------------

- Add support for roles (Healer, Tank and Damager in priority and skip lists).

- Add support for mouse's 4th and 5th buttons in micro-unit frames. (They need
  to be assigned directly in Decursive's option panel).

- New unit filtering options for custom spells allowing to restrict a spell or
  item to the player only or to other party members only.

- Add support for CUSTOM_CLASS_COLORS.

- Reliability improvements concerning very rare "script ran too long" Lua errors.

- Code cleanup and improvements.


Changes from Decursive 2.7.4.6 to Decursive 2.7.4.7 (2016-07-26)
----------------------------------------------------------------

- Prevent crash on some Chinese clients where the constant
  LOCALIZED_CLASS_NAMES_MALE is missing a key for 'DEMONHUNTER'...

  This is possibly caused by another add-on as FillLocalizedClassList() does provide
  the translation...


Changes from Decursive 2.7.4.5 to Decursive 2.7.4.6 (2016-07-25)
----------------------------------------------------------------

- Various Legion compatibility fixes.

- Allow user to redefined Decursive's already known spells' debuff curing
  types in the custom spell interface. Previously only new debuff types could
  be checked but already checked one were grayed out.


Changes from Decursive 2.7.4.4 to Decursive 2.7.4.5 (2016-07-20)
----------------------------------------------------------------

- Basic compatibility update for WoW 7, a more thorough update will be coming
  this weekend. In the mean time you can use the custom spell interface to
  adjust Decursive's behaviour.

Changes from Decursive 2.7.4.3 to Decursive 2.7.4.4 (2015-09-08)
----------------------------------------------------------------

- Performance improvements in certain conditions.

Changes from Decursive 2.7.4.2 to Decursive 2.7.4.3 (2015-06-25)
----------------------------------------------------------------

- TOC to 60200


Changes from Decursive 2.7.4.1 to Decursive 2.7.4.2 (2015-04-05)
----------------------------------------------------------------

- Decursive's automatic reconfigurations are postponed if the player is in
  combat. This should fix the "script ran too long" errors some users were
  experiencing.


Changes from Decursive 2.7.3.6 to Decursive 2.7.4.1 (2015-02-26)
----------------------------------------------------------------

- Items are now directly usable in the "Custom spells" interface with
  the same feature set as standard spells.

  As with standard spells you can have several items with a different priority
  for the same affliction type(s). Decursive will reconfigure itself
  automatically when an item usability changes.

- Update Warlock Support (Add Fel Imp's Sear Magic and Observer's Clone Magic)

- Fix a non fatal error message concerning macro creation when the user had
  more than 36 macros.

- Add Patrick Bohnet to the Credits section of the 'About' option tab (He was
  only credited in the source files).


Changes from Decursive 2.7.3.5 to Decursive 2.7.3.6 (2014-11-09)
----------------------------------------------------------------

- Fixed countdown display issue on MUFs with debuffs without expiry.

- Moved bindings to the "Addons" category.


Changes from Decursive 2.7.3.2 to Decursive 2.7.3.5 (2014-10-15)
----------------------------------------------------------------

- Compatibility fixes for WoD:
    - Cooldown animations on MUFs had stop working with WoW 6.0.
    - Fix several Lua errors caused by API changes.
    - Fix magic curing ability detection for Paladins and Monks.

- Add new [Gratipay](https://gratipay.com/2072/) and [Bitcoin](https://blockchain.info/address/1LEHZuPsiHN4hM3H3Gru5xKmDgCj867eFX) donation options on Curse and WowAce.


Changes from Decursive 2.7.3.1 to Decursive 2.7.3.2 (2014-06-09)
----------------------------------------------------------------

- Added automatic support for DK's Icy touch (when its namesake glyph is
  available).

- Fix rounding issues preventing the MUFs' handle and the help tool-tip from
  being repositioned properly when at the top of the screen and the UI scale is
  not set to exactly 100%.

- Chinese localization updates by Ananhaid.

- Add the fact that Symbiosis is supported in the features list.


Changes from Decursive 2.7.3 to Decursive 2.7.3.1 (2014-02-03)
--------------------------------------------------------------

- Re-added Shamans' PURGE as a default spell. It disappeared by accident some
  time ago... Thanks to TazRulez for pointing this out!


Changes from Decursive 2.7.2.9 to Decursive 2.7.3 (2013-09-11)
--------------------------------------------------------------


- New feature: Decursive can display the number of stacks for the topmost
  affliction in the center of each MUF. The counter still defaults to time-left,
  this can be changed in the MUF's options. If you set your counter to
  time-elapsed in the past, it will be reset to time-left with this release.

- Maintaining the 'Shift' key will now change MUF's center counters in the
  following ways: if the Time-Left or Time-Elapsed option is set then it will
  switch to displaying the stacks number ; if the stacks display option is set,
  then it will switch to displaying the time left.

- Important code optimizations and improvements.

- Added an exception for when 'Fluidity' is detected on a unit, Decursive will
  ignore all afflictions on that unit. (other similar afflictions can be added
  easily, this should be turned into a configurable option later. In the mean
  time you can create a ticket if you want other anti-cleansing afflictions to be
  added).

- Decursive no longer dynamically hides option panels when the related features
  are disabled. Instead, the panels' content is greyed out.

- Fix: it was impossible to edit the internal macro for default custom spells.

- Change the live-list display option to be opt-in rather than opt-out.

- Clarified several options settings (option names and related tool tips)

- The charm status green centered square is now displayed in the top-right of
  MUFs so that the center counter can be read.

- The aforementioned charm status square can now be tested by putting 'Charm'
  as first priority and checking "Create a virtual test affliction" in
  Decursive's general option panel.

- Localization updates by Ananhaid (zhCN) and Yllelder (esES). Some phrases
  were modified to clarify some settings. I've updated the French translations
  but eight other languages are needing some attention.

- Remove the silence at the start of the 'Unstable Affliction/Vampiric touch'
  warning sound.


Changes from Decursive 2.7.2.8 to Decursive 2.7.2.9 (2013-05-21)
----------------------------------------------------------------

- Updated TOC for WoW 5.3.


Changes from Decursive 2.7.2.7 to Decursive 2.7.2.8 (2013-04-14)
----------------------------------------------------------------

- Added support for Hands of Sacrifice which can dispel magical effects on
  party/raid members for retribution Paladins.

- Enhanced the internal mechanism for unit exclusion (this concerns spell only
  usable on the player or on party/raid members): it now also works for MUFs'
  buttons assignments.


Changes from Decursive 2.7.2.6 to Decursive 2.7.2.7 (2013-03-10)
----------------------------------------------------------------

- Fix Symbiosis support: Decursive now correctly detects "Cleanse" and "Purge"
  for Druids and "Cyclone" for Priests.

- Decursive will no longer show its "send this debug report to the author"
  window if the self diagnostic detects a PBCK issue (missing or outdated
  library, missing file, incompatible TOC, mixed file versions).

- Emphasized in the corrupted installation pop-up that the WoW client must
  _NOT_ be running while installing add-ons.


Changes from Decursive 2.7.2.5 to Decursive 2.7.2.6 (2013-03-07)
----------------------------------------------------------------

- Fix the custom spell upgrade system that could error out when logging in on a
  character for the first few times (the upgrade did go through though).


Changes from Decursive 2.7.2.4 to Decursive 2.7.2.5 (2013-03-06)
----------------------------------------------------------------


- Decursive's master spell table is now indexed by spell-IDs instead of
  localized spell-names this will fix localization related name collision issues.
  These collision were preventing auto-configuration to work correctly for some
  locals (such as Russian Paladins).


- Fixed a rare 'index is nil' Lua error happening is some race conditions when
  mouse-hovering the MUFs. The same race conditions could cause the MUFs' handle
  to be displayed in an unexpected position...

- Switched back to AceTimer-3.0 which is reliable again now.


Changes from Decursive 2.7.2.3 to Decursive 2.7.2.4 (2012-12-25)
----------------------------------------------------------------

- Added automatic support for Druid's Symbiosis spell, Decursive should detect
  any useful cleansing spell gained through the use of Symbiosis. Previously
  you had to add Symbiosis as a custom spell yourself and configure it.

- Better performances for people playing in very low FPS conditions.

- Fix automatic version announcement related Lua error due to wrong
  communication channel.

- Miscellaneous enhancements to the error handler and debug report feature:
    - Decursive will no longer tell the user to check his/her add-ons when more
      than 90% of the errors comes from tainting issues or Blizzard own UI code.
    - Decursive will also create reports for errors happening in
      Healers-Have-To-Die (instructions are changed accordingly)

- The 'Check other players' button in the about panel had disappeared.


Changes from Decursive 2.7.2.2 to Decursive 2.7.2.3 (2012-11-28)
----------------------------------------------------------------

- Improved the live-list related option panel, it now includes an explanation on
  how to set up the live-list and how to move it.

- Many improvements to Decursive's self diagnostic systems and bug reporter.

- Some performance improvement when dealing with massive debuffing.

- Bug fix: Workaround for the 'Script ran too long' issue happening (rarely)
  when playing the alert sound (a Blizzard side issue).

- Bug fix: Fix two very rare race condition issues that would trigger a Lua
  error.

- Bug fix: The macro Decursive automatically creates was using an invalid icon.

- All pre-MoP compatibility layers have been removed.


Changes from Decursive 2.7.2.1 to Decursive 2.7.2.2 (2012-10-07)
----------------------------------------------------------------

- Fix for "Dcr_DebuffsFrame.lua:854: bad argument #3 to 'str_format' (string
  expected, got nil)".

- Only generate reports for taint issues blaming Decursive when Decursive is not
  embedding libraries.

- Decursive will no longer generate a debug report if its alert sound takes too
  long to play (strange issue happening to some users, probably hardware
  related).

- Fix a "script ran too long" issue that could happen if another add-on
  generated a Lua exception for the first time during combat.


Changes from Decursive 2.7.2 to Decursive 2.7.2.1 (2012-09-27)
--------------------------------------------------------------

- Decursive no longer generates debug reports when it is blamed for taint issues it is not causing.
  Usually this happens because Decursive embeds LibDBIcon which is then used by
  other add-ons to display their settings and thus triggering the [months old massive taint issue Blizzard did not fix](http://us.battle.net/wow/en/forum/topic/6713012357).

- Decursive won't display its nagging message about other buggy add-ons when
  the error throttle limit is triggered by the aforementioned issue (usually
  when you open and close your UI option panel for the first time while you are
  in combat)


Changes from Decursive 2.7.1.1 to Decursive 2.7.2 (2012-09-23)
--------------------------------------------------------------


- Decursive no longer adds its settings to Blizzard's Interface Options UI (in
  order to avoid the massive UI tainting it caused...). I've made a (useless?)
  bug report on the EU MoP beta forum that might need a bump: [http://eu.battle.net/wow/en/forum/topic/5300140681#1](http://us.battle.net/wow/en/forum/topic/6713012357)

  So until Blizzard fixes this bug you can still access Decursive's option
  through the MUF's handle or by typing /Decursive

- Added automatic management of the 'Command Demon' Warlock's spell that can be
  used to cast 'Singe Magic' using 'Grimmoire of Sacrifice' on the Imp.

- Renamed the 'Stop casting' check box in the customs spells' options to 'Pet
  ability' as it's what it really is. Prior MoP, adding /StopCasting or not at
  the top of the macro was the only effect of this option (hence its former name)
  but now, Decursive needs to know where to look for the spell in order to detect
  it properly.

- Allow the user to change the priority of her custom spells from -10 to +30
  (this possibility is no longer restricted to 10-30). This allows the user to
  configure spells that will only take over when a default ability is not
  available (default abilities having a priority between 0 and 10).

- Replaced AceTimer-3.0 with LibShefkiTimer-1.0 to fix random 'Script ran too
  long' issues happening with AceTimer's current implementation.

- Minors fixes and optimizations.


Changes from Decursive 2.7.1 to Decursive 2.7.1.1 (2012-09-02)
--------------------------------------------------------------

- Enhancement to the debug reports.

- Removed the 'Flame Shock' warning as 'Lava Flows' is gone. I leave the
  'Vampiric Touch' warning for now since there is 'Sin and Punishment' (a Tier
  6 Shadow priest talent).

- Implemented a workaround for range detection until Blizzard fixes the API.

- MoP: Detect 'Internal Medicine' talent for Monks


Changes from Decursive 2.7.0.5 to Decursive 2.7.1 (2012-08-30)
--------------------------------------------------------------

- Compatible with Mists of Pandaria

- Added a warning when the unit your about to cleanse is afflicted by 'Vampiric
  Touch' or 'Flame Shock' (just like with 'Unstable Affliction')

- Added support for Italian localization, you can contribute using the
  [Localization interface][localization].

- Other locals updated (Thanks to contributors!)

- Miscellaneous unnoticeable changes.


Changes from Decursive 2.7.0.4 to Decursive 2.7.0.5 (2012-02-05)
----------------------------------------------------------------

- Changed author's name to a real name (Why should we use nicknames?).

- Localization updates. Brazilian Portuguese still needs a lot of work, if you
  want to help: you can contribute using the [Localization interface][localization]

- Update to self diagnostic error messages to tell people that they must close WoW
  while updating add-ons.

- Decursive now prints an educational message in the chat and disables
  its internal error handler once a thousand Lua errors have been
  intercepted. (Applicable when BugGrabber is not present)


Changes from Decursive 2.7.0.3 to Decursive 2.7.0.4 (2011-11-29)
----------------------------------------------------------------

- TOC to 40300

- Reimplemented support for people using an old version of BugGrabber, should
  spam less when they are using rusty add-ons.

- Added support for ptBR localization, you can contribute using the
  [Localization interface][localization]


Changes from Decursive 2.7.0.2 to Decursive 2.7.0.3 (2011-07-03)
----------------------------------------------------------------

- TOC to 40200

- Fix a problem ("LiveList:Update_Display(): couldn't get range") occurring to
  warlocks when MUFs are disabled.

- FIX: Some MUFs settings were not applied when switching between profiles.

- removed compatibility code for older versions of WoW


Changes from Decursive 2.7.0.1 to Decursive 2.7.0.2 (2011-05-08)
----------------------------------------------------------------

- FIX: Shadow Priests were incorrectly told they could remove magic afflictions
  off other players.  (This change happened in WoW 4.1 patch)

- Fix to the 'BugGrabber is spamming' issue.

- Compatible with future WoW 4.2 patch (current PTR client).



Changes from Decursive 2.6.1 to Decursive 2.7.0.1 (2011-04-27)
--------------------------------------------------------------

- **Major new feature:**

    - Custom spells management interface ('Custom Spells' in the option panel).
        - Add any spell you want to be used on specific affliction types with
          different priorities.
        - Edit MUFs' internal macros associated to each of those spells
          (internal macros work the same way as other macros).

- **Changes:**

    - Options names and descriptions related to afflictions priorities have
      been revamped to be more coherent and better reflect the way Decursive
      works. (Thanks to Nerdling for his input and many suggestions)

      As a result many options have been renamed and descriptions
      changed or created. If you want to help to localize those changes in your own
      language, you can do it using the [Localization interface][localization]
      available on WoWAce.com.  (many phrases are requiring review, make sure their
      translations are accurate)

    - Decursive now embeds and uses BugGrabber to capture errors happening inside its own code base
        (BugGrabber is still in developpment, the current implementation is not final)

    - MUFs' Mouse-buttons associations are reset to default when installing this version.

- **Bug fixes:**

    - It was no longer possible to resize the live-list or change its opacity.

    - Various small fixes and improvements.

[localization]: http://www.wowace.com/addons/decursive/localization/



Changes from Decursive 2.6.0.1 to Decursive 2.6.1 (2011-03-04)
--------------------------------------------------------------

- **Fixes:**

    - Important fix to charm detection, previously Decursive only reported
      affliction related charm effects.
      Decursive is now able to report charmed players even when they have no active
      debuffs (any player becoming attackable is considered as charmed).
      This fixes Cho'Gall's [Worshipping][worshiping] buff detection issue ([ticket 71][ticket71]).
      Many thanks to Wcshadow for his help in fixing this!

    - If a unit was invisible and afflicted, Decursive would only show the stealth status.

    - Talent "Body And Soul" detection for priests was no longer detected
      since it was moved to tier 5 a few months ago...

    - Enhancements to talents detection and initialization.


- **New Features:**

    - *Vertical Display* option for MUFs (MUFs will grow vertically and columns
      will be added when the maximum set number of MUFs per row is reached).

    - Added links in main description to [videos][YoutubeDecursivePlaylist] found on Youtube.


- **Changes and enhancements:**


    - The "Decursive" bar is now hidden by default since it's quite useless once
      you have chosen its position...

    - MUFs' chronometers (timer mode) are now based on the actual duration of the
      affliction instead of its discovery time.

    - The handle will always be placed above the first MUF regardless of your MUF's
      display options (Except when the first MUF is at the top of your screen, in
      this case it will be placed beneath last line's first MUF)

    - MUFs' Anchoring is now more logical, MUFs' scale tweaking will seem more
      natural.

    - Added visible hint on how to move the Micro-Unit-Frames in the related option panel.

    - Major option tree cleanup and optimization (reduced static memory usage by 14
      Kib), as a result, some options have moved and other have reset to their
      default values.

    - MUFs' positioning system had to be rewrote to implement the vertical
      display option, as a result MUFs will be reset to their default position
      upon installation of this version.

    - Various code optimizations and cleanup.

[YoutubeDecursivePlaylist]: http://www.youtube.com/view_play_list?p=BAC83C82EDE3FD24
[ticket71]: http://www.wowace.com/addons/decursive/tickets/71-chogall-worship/
[worshiping]: http://www.wowhead.com/spell=91317

----------------------------------------------------------------------------------------------

Changes from Decursive 2.6.0 to Decursive 2.6.0.1 (2010-12-06)
--------------------------------------------------------------

- *Fix:* Decursive's users who are located in a region where Daylight Saving Time (DST) is
  still active could trigger the new version alert for other users using the same version of Decursive.

----------------------------------------------------------------------------------------------

Changes from Decursive 2.5.2.2 to Decursive 2.6.0 (2010-11-28)
--------------------------------------------------------------

**Enhancements:**

- Pet's Micro-Unit Frames are now smaller.

- A 'new-version' detection mechanism has been implemented.

  Users will receive an alert every seven days at login once a new version has
been detected.

  This alert can be disabled through the new option ("New version alerts") available
  in the General option tab.

- Slightly changed the MUFs' default colors and chronometers' font to make
  things clearer.

- Reduced Decursive's static memory footprint by 100Kb.

- Multiple enhancements to the About dialog when using the "Check other
  players" feature.

- Typing /Decursive will now open the configuration UI instead of printing a yellowish
  error message.

- Text and description change concerning MUFs' window's auto-hide option to
  avoid confusion.

- Updated [documentation][] with in-line links to various [screen-shots][] of Decursive's UI.

- Added A new section in [Decursive's main page][Decursive]: "Interesting articles about
  Decursive usage".

  The article written by Darista is a very interesting read if you want to get the
  max out of Decursive:
        [http://daritos.apotheosis-now.com/?p=24](http://daritos.apotheosis-now.com/?p=24)


**Bug Fixes:**

- Fix Priority and Skip list mouse button handling, it was no longer possible
  to move units in those lists.

- The configurable key-binding to open the config UI was broken since the
  conversion to Ace3.

[Decursive]: http://www.wowace.com/addons/decursive/
[screen-shots]: http://www.wowace.com/addons/decursive/images/
[documentation]: http://www.wowace.com/addons/decursive/pages/

----------------------------------------------------------------------------------------------

Changes from Decursive 2.5.2.1 to Decursive 2.5.2.2 (2010-10-31)
----------------------------------------------------------------

- Internal optimizations concerning timers creation.

- "Magic Charm" has now a lower priority. This will prevent 'Purge' being set
  on left-click by default for Shamans.

- Several fixes and additions to German localization by Freydis88.

- Decursive could have troubles detecting talents for some people.

- Removed old 3.5 deprecated spells when in 4.0. This fixes the error message
  some users were getting about no longer existing SpellIDs.

- Other small fixes and enhancements.

----------------------------------

Changes from Decursive 2.5.2 to Decursive 2.5.2.1
-------------------------------------------------

- Fix chronometer display offset bug.

- Added 'Improved Cleanse Spirit' talent detection for Shamans allowing them to
  cure magic with 'Cleanse Spirit'.

- Added 'Nature's Cure' talent detection for Druids allowing them to cure magic
  with 'Remove Corruption'.

- Added 'Sacred Cleansing' talent detection for Paladins allowing them to cure
  magic with 'Cleanse'.

- Removed now useless 'Abolish' spells related options.

----------------------------------

Changes from Decursive 2.5.1 to Decursive 2.5.2
-----------------------------------------------

- Compatible with World of Warcraft 4.0, spells have been updated, if
  something is missing, open a [ticket][ticket] on WoWAce.org or email me at
  <archarodim+dcrMS@teaser.fr>

- Warlocks can use fear on charmed players.

----------------------------------

Changes from Decursive 2.5.0 to Decursive 2.5.1
-----------------------------------------------

- *Raid Target Icons are now supported* (MUFs and Live-List display)

- *NEW option*: "Do not use 'Abolish' spells" (in the cure options). If enabled
  will prefer 'Cure Disease' and 'Cure Poison' over their 'Abolish' equivalent.
  (Defaults to off)

- "Check for 'Abolish' before curing" option now defaults to off. (May not be
  wanted when a disease or poison needs to be removed at all costs ; it was
  also confusing for some users)

- *NEW option*: "Allow macro edition" preventing Decursive from updating its
  macro and letting the user change it and still use Decursive macro key-binding
  management. (Defaults to off)

- *NEW command line option* to hide and disable the MUFs handle:
  (/dcr HideMUFsHandle)

- German translation is now complete (thanks to Freydis88).

- Remove the ERR_GENERIC_NO_TARGET debug report happening when the player
  tries to use Polymorph or Purge on himself or another friendly player.

- Fix to "LiveList:Update_Display(): couldn't get range" error occurring when
  not using the MUFs.

- Removed the French version of 'readme' and 'changelog' since 3 persons only
  were reading those.

----------------------------------

Changes from Decursive 2.4.5.1 to Decursive 2.5.0
-------------------------------------------------


*IMPORTANT CHANGES:*

- *NEW OPTION*: "Time left" for MUF chronometers. (Defaults to off) Displays time
  left instead of time elapsed on afflicted MUFs.

- *NEW OPTION PANEL*: (under the MUF options) to let the user choose the
  MUF's mouse button assignments. The middle-mouse button can be used to cast
  curing spells too.

- *NEW OPTION*: Testing MUF display layout is now possible. Look in the MUF
  display options.

- It's now possible to *check Decursive versions* used in your current group or
  Guild (From the 'About' option panel).



*MINOR CHANGES AND IMPROVEMENTS:*

- The 'Unstable Affliction' warning will also work when tool-tip display is
  disabled.

- Added a new option (under the general tab) to disable the three welcome
  messages Decursive prints at each login.

- Enhancement: The MUF tool-tip is always displayed above the MUFs or beneath
  them if it's not possible. (it can't overlap the MUFS anymore).

- The 'target' and 'mouseover' units will no longer be displayed in the
  Live-list if the player is part of the group.

- Non-release versions (alphas, betas and release candidates) of Decursive will
  expire after 30 days instead of 10. The expiration alert of these versions
  will be displayed only once every 48 hours (and no longer at every login).

- Updated minimum library versions requirements.

----------------------------------

Changes from Decursive 2.4.5 to Decursive 2.4.5.1
---------------------------------------------------

- Fix a problem where Decursive would not correctly detect priest talent 'Body
  and Soul' at login.

- Re-enabled debuglocals() hotfix for 3.3 when Lua error reporting is enabled.

- Localization update.

- TOC update for WoW 3.3.


Changes from Decursive 2.4.3.2 to Decursive 2.4.5
-------------------------------------------------

- **Major changes:**

    - Decursive has been fully converted to Ace3.

    - Decursive is no longer licensed under the GNU GPL, License has changed
      to 'All Rights Reserved' (see LICENSE.txt).

    - Due to the conversion to Ace3, there is no longer a drop down menu to
      access the option.

    - New option panel available through Blizzard add-ons option UI, you can also
      access the options by alt-right clicking on Decursive Icon.

    - Decursive options will be reset to default upon installation of this version.

- **Minor changes:**

    - Fix for Shamans: 'Cleans Spirit' was not replacing 'Cure Toxins', the two
      spells were both active and confusing for the user.

    - Removed the 'Ignore stealthed units' option that is useless since several
      years.

    - The Macro key binding is now a global setting (no longer bind to the
      profile).

    - Replaced TabbletLib by LibQtip-1.0.

    - Removed DewDrop-2.0 which has no replacement in Ace3 framework.

    - Added an about panel.

    - Various little enhancements and code cleanup.


Changes from Decursive 2.4.3 to Decursive 2.4.3.2
-------------------------------------------------

- A Lua error could occur in rare race conditions (when clicking on a MUF at the
  exact moment its debuff disappears).

- 'Shadoweld' was no longer detected as stealth because its spell ID changed.
  (future spell ID changes will generate debug reports).

Changes from Decursive 2.4.2 to Decursive 2.4.3
-----------------------------------------------

- Implemented a permanent solution for debuffs not detected by direct debuff events.

- Made the macro options more reliable and logical:
    - When the macro creation is disabled, the currently assigned key is removed.
    - The assigned key is also removed when the profile options are reset.
    - Key assignment feature is disabled if the macro creation is disabled.

- The 'no macro key warning' is now turned off by default since this whole
  mouseover macro thing is not really interesting after all...

- Removed LibBabble-Class-3.0 (replaced by _G.LOCALIZED_CLASS_NAMES_MALE)

- Added an exception for the 'Dark Matter' debuff for which no SPELL_AURA_APPLIED
  event is generated by the game.

- Re-enabled Lua error handler but added security checks and also dynamic
  hotfixes to Blizzard_DebugTools errors that resulted in C Stack Overflows.
    - **IMPORTANT**: Because of (or rather thanks to) those hotfixes, Decursive installation may reveal some Lua errors
      that you couldn't see before.

- Always use the "player" unitID in raid (was using raid# when the player was included in the priority list)
        This prevents the player MUF from disappearing temporarily while a group update is in progress.


Changes from Decursive 2.4.1 to Decursive 2.4.2
-----------------------------------------------

- IMPORTANT STABILITY AND RELIABILITY FIXES: Problems fixed in this release
  could prevent Decursive from reporting afflictions in race conditions (all
  previous versions are affected).

- Added Shaman's "Hex" spell to crowd control charmed players.

- Added new Shaman spell "Cure Toxins".

- Documentation completely rewritten and reorganised using .docmeta and markdown
  formatting. Users don't have any excuse left to not read it now ;) The
  documentation is accessible there: <http://www.wowace.com/addons/decursive/>

- Decursive is now able to report LUA errors related to itself using the
  wonderful "non-annoying after combat auto report feature" introduced in 2.4.1 :)

- Added support for AddonLoader http://www.wowwiki.com/AddonLoader (auto-load
  if your class is any of Mage, Priest, Paladin, Druid, Hunter, Warlock,
  Shaman).

- Added an option to disable the macro creation.

- Miscellaneous enhancements and minor bug fixes.


Changes from Decursive 2.4 to Decursive 2.4.1
-----------------------------------------------

- Added support for the new priest talent 'Body and soul' to be able to cleanse
  a poison effect on self when using 'Abolish Disease'.

- Added the 'Tranquilizing Shot' Hunter spell to remove magic debuff on mind
  controlled units.

- Important enhancements and fixes to the MUF positioning/scaling system:
    - Changing their scale will no longer affect their position in an illogical
      way.
    - MUFs are maintained on screen whatever happens ; their position will
      no longer be reset to default.

- Multiple fixes and enhancements to charm (mind control state) detection.

- Fixes to Decursive icon: now it does what the tool-tip says and it doesn't
  throw a LUA error if tool-tips are disabled in the LDB client.

- The MUFs no longer depend on the 'mouseover' unit (internal simplification,
  more reliability).

- Added a new advanced debug report system.



Changes from Decursive 2.3.1 to Decursive 2.4
---------------------------------------------

- New feature: The cool down of the curing spell to be used is displayed
  (clock) on afflicted MUFs.

- Decursive uses AceLocal-3.0 ; localization is now made using this interface:
  http://wow.curseforge.com/projects/decursive/localization/

- Miscellaneous localization updates in various languages.

- Re-implemented the max unit to show option.

- Added a warning when the user disables Decusive and an explanation on how to
  re-enable it (/dcr standby)

- Translations for key bindings descriptions (WoW key binding interface)

- It's no longer possible to map the button 1 and 2 of the mouse to Decursive's
  macro by accident.

- Fixes a problem if the game is loaded without any "saved variables" where the
  API GetCurrentBindingSet() would return incorrect values unusable with the
  API SaveBindings() preventing Decursive from initializing correctly.

- Bug fix: Charmed unit detection wasn't working if the player himself was charmed.

- Bug fix: The focus MUF was not added at the end but just before pets.

- Bug fix: The stick to right option (concerning the MUFs positions) was broken.

- Some other minor bug fixes.


Changes from Decursive 2.3.0 to Decursive 2.3.1
-----------------------------------------------

- Fixes a very old rare issue where Decursive would miss debuff events.

- Fixes focus unit management.

- Fixes minimap icon and main bar management when Decursive is "Ace-disabled".


Changes from Decursive 2.3.0 RC7 to Decursive 2.3.0
---------------------------------------------------

- Added mixed file version check to the self-diagnostic.
- Fix LUA error introduced in RC7.

Changes from Decursive 2.3.0 RC4 to Decursive 2.3.0 RC7
-------------------------------------------------------

- Fix a LUA error when PrioList members where excluded from blacklisting and a
  blacklisting event fired (target not in line of sight etc...)
- Cleanse Spirit Shaman spell seems to be cast two times instead of once in
  certain conditions (Blizzard issue), Decursive was displaying spell failure
  error because of that. This is fixed.
- Fixes pet spells detection when pet scanning was disabled (this issue was
  introduced in 2.3 beta 2)
- The MUF auto-hide option was not setting itself correctly at initialisation
  (init order issue)
- Showing the MUFs didn't trigger an update of its display this could result in
  missing units when using the auto-hide option or if the MUF frame was hidden...
- Removed "support" for Earth Panel because I don't know what it is and nor
  does Google...
- Added and fixed a few comments


Changes from Decursive 2.3.0 RC2 to Decursive 2.3.0 RC4
-------------------------------------------------------

- Removed FubarPlugin-2.0 library (use "Broker2FuBar" to have Decursive in Fubar)
- Added LibDataBroker-1.1 and LibDBIcon-1.0 libraries.
- Removed compatibility code for WoW 2.4.
- Moved and renamed localization files to a proper directory.
- New option: "MiniMap Icon" to toggle the display of Decursive Icon around the MiniMap.
- Fixes a NIL error when an outsider friendly target got stealth.
- Fixes the LUA error related to the "test affliction" in the live-list options.


Changes from Decursive 2.3 beta 3 to Decursive 2.3.0 RC2
--------------------------------------------------------

Fixes faulty initialisation due to CreateMacro() API changes in WoW 3.0 (when
the users per-character macro were full)

- Bugfix: CreateMacro() was changed in WoW 2.3 as a result Decursive was
  creating its macro "per character" instead of "per account" and was not
  checking the right limit...

- Updated minimum required revision of libraries to the latest at this date.


Changes from Decursive 2.2.0 to Decursive 2.3 beta 3
----------------------------------------------------

- Decursive now uses GUID internally instead of unit names (CPU and memory usage optimisation).
- A change of pet in the group was still triggering a group rescan even if pet
  scanning was disabled.
- CPU optimization when using the priority list.
- WARNING: after installing this version, the priority and skip list will be cleared.


Changes from Decursive 2.1.0 Final to Decursive 2.2.0
-----------------------------------------------------

**Important changes:**

- Decursive no longer uses SpecialEvent-Aura-2.0 to detect afflictions, it uses
  the new combat log system introduced in WoW 2.4. This simplifies the code a
  lot and prevent far away units to be scanned uselessly.

- As a result Decursive is now able to detect missed dispels and missed or
  failed spells with complete accuracy.

- A new sound alerts you if one of your spell launched using the MUFs fails or is resisted.

- The success spell message has been removed and replaced by a failure message when appropriate.

- New affliction alert sound more audible for people without a good bass system.

- The 'focus' unit will only be shown if not hostile and if not already part of the displayed MUF.

- When the live-list tool tips are disabled, the Live-List won't catch mouse
  events, you can click right through it.

- Affliction history is populated only when you click on a MUF to dispel something.

- Complete Russian translation by StingerSoft

- Compatible with WotLK beta

**Fixed bugs:**

- Fix a nil error when players with pets were excluded using the skip list.

- fix a lot of insidious bugs related to 'gendered' class names.

- fix problems in battlefields with players from other realms (group ordering failures)

- Units not in line of sight are now always properly blacklisted (except when
  using pets, no failure events are sent).

- When adding or removing a player/group/class to the exclusion list, the MUFs
  display was not updated immediately.

- Fix for Chinese priests (two different spells named the same in this localisation...)

- Better sound alert management, alert loops are no longer possible.

- The lock and buttons display/hide status of the "Decursive" bar (the
  live-list anchor) were not applied correctly on startup.


Changes from Decursive 2.0.4 to Decursive 2.1.0 Final
-----------------------------------------------------

**Important changes:**

- When a player is afflicted, a new chronometer appears on its MUF giving the
  time elapsed (enabled by default)

- Added an automatic self-diagnostic feature also available through the
  /DCRDIAG command. This diagnostic is run when the add-on is loaded and check
  if all required libraries are available and are up to date.
  It also checks if all Decursive internal files are loaded correctly.
  When the command /DCRDIAG is used it also tests if the library AceEvent is
  functioning properly.

- New option: "Align MUF window to the right" (defaults to off)
  If enabled, the MUFs will grow from right to left and the handle will be
  moved automatically.

- New option: "Auto-Hide" (defaults to "Never")
  Lets you choose if you want to auto-hide/show the MUF window when in party or raid.

- New option: "Colors" in the "Micro Unit Frame Settings" sub-menu
  It is now possible to change all the MUFs colors.

- It is now possible to add afflictions to the filters from a list of recently
  seen afflictions instead of typing their names.

- The cure order priorities are now saved per class
  (This change resets your cure order priorities to default values)

- Decursive no longer uses the Babble-Spell library that is deprecated since
  WoW 2.4, all spells are now dynamically translated at load time ensuring
  compatibility with current and futur localized versions of World of Warcraft.

**Minor changes:**

- When moving the cursor quickly over friendly and hostile units, sometimes a
  phantom affliction could appear in the live-list for 0.2 seconds this has
  been fixed.

- When a new MUF is created outside the screen, the MUF window is always
  automatically moved so that all MUFs are visible.

- Spells handled by pets will no longer interrupt the player spells (when using
  the MUFs)

- Performance optimizations.

- Workaround for polymorph spells name change in WoW 2.3 (Decursive was no
  longer casting rank 1 of this spell...)

- Clarification in the different localization files.

- Fix an initialization issue some users were experiencing.

- Added a new FAQ entry about a rumour according to which Decursive would be
  banned by Blizzard. (take a look at the end of the Readme.txt file)


Changes from Decursive 2.0.3 to Decursive 2.0.4
-----------------------------------------------

- From now on, Decursive is dedicated to the memory of Bertrand Sense who died
  a month ago and was known as Glorfindal on "Les Sentinelles" (EU server).
  A special menu entry has been added.

- Moved FuBarPlugin relative options to a sub-menu.
- Fix problems with Spanish localization since WoW 2.2.3
- Probably fixed a rare LUA error that could occur in race conditions.
  (IsSpellInRange(): Invalid spell slot)


Changes from Decursive 2.0 Final to Decursive 2.0.3
---------------------------------------------------

**New features**

- Added a message and a sound when the Unstable Affliction is detected on a MUF
  you're about to click (works only if the MUFs' tool-tips are active.

- Added support for Druid's Cyclone Spell on friendly mind-controlled players.
  Because of this change affliction cure priorities may have changed, go into
  Options -> 'Curing Options' and change the priorities as you like.

- New PayPal donation button.

**Fixed bugs**

- If some afflictions were filtered out while in combat, the MUFs of the afflicted
  units were not updated once the battle was over.

- If you changed the cure priorities while some afflictions were already
  displayed in the MUFs, their color was not updated.

- Fix a Lua error that occurred wen the user had the live-list AND the MUFs
  disabled at UI initialization and was changing its 'Focus' (/focus
  /clearfocus)

- Pet appearance/disappearance events were not triggering an update of the
  number of MUFs displayed.

- Fix a Lua error when mouse-overing the MUFs with the class borders disabled.

**Small changes**

- Pet management enhancement:
    - Pet class and name detection should be much more accurate.
    - Pet names in MUFs tool-tips are preceded by "Pet" (depends on the
      localization)
    - Fix a possible issue with pet management (when several pets are 'unknown
      entities')

- Small optimization when using cleansing spells (blacklist handling).

- Added 'lesser invisibility' to stealth detection.

- The sound played when a debuff is found is now in a profile setting
  (profile.SoundFile).

- Decurive's icon will become gray if no curing spell is available or if all
  types of afflictions are unchecked in "curing options".

- zhCN and koKR translation update.



Changes from Decursive 2.0 RC1 to Decursive 2.0 Final
-----------------------------------------------------

- Mages will now cast polymorph rank 1 instead of the highest rank (uses less
  mana and last less time).
- "Cast success" messages now include the spell rank.
- Lua error fixed when using the decurse key when no spell are registered.
- Default position of the MUFs and live-list have been optimized.
- A note has been added on how to move the live-list (in readme.txt and in
  game).


Changes from Decursive 2.0 BETA 7-Pub to Decursive 2.0 RC1
----------------------------------------------------------

- An error message is displayed if Decursive cannot load its main libraries
  properly.
- It's now possible to disable the warning displayed when no key is mapped to
  the macro.
- There should be no more "succeeded on NONAME" messages.
- Descriptions in French and Traditional Chinese have been added.
- .TOC updated for WoW 2.1.


Changes from Decursive 2.0 BETA 6-Pub-fixed to Decursive 2.0 BETA 7-Pub
-----------------------------------------------------------------------

**New features:**

- It's now possible to add dynamic groups and classes in the priority and skip
  list: Instead of adding each unit separately, class and/or group entities
(ex: [ group 1 ] , [ Mage ]) will appear in the lists. The old behavior can
still be used by maintaining [SHIFT] when clicking on a group or class-name in
the populate list tool (names will be added).

- The last change also allow to sort units per group AND classes at the same
  time.

- An informative help message is displayed when the user doesn't click a MUF
  with the correct mouse button.

- Major code optimization: reduced CPU usage from ~0.04 seconds per seconds to
  ~0.001 seconds per second (results obtained with up to date external Ace2
libraries, if Decursive's embedded shared libraries are the most up to date,
Decursive CPU usage will also count the usage of the shared libraries by other
add-ons).

- Added revised Traditional Chinese translation by Peter Sun.

**Changes:**
- When a MUF is clicked, any spell targeting in progress is canceled.
- The MUFs react upon mouse button release instead of mouse button press.
- When adding an affliction to the filter, the entered name is trimmed.
- It is now possible to move the "Decursive" bar maintaining the Alt key pushed
  with the buttons hidden.

- Live-list system entirely rewritten.
- The scale and transparency of the live-list can be changed in the options.
- A message is displayed if the user clicks on the live-list...
- It is possible to hear Decursive's debuff alert sound when the live-list is
  disabled.

- Decursive uses SpecialEvent-Aura events to monitor debuffs.
- You can create a virtual debuff to test the display (see in live-list
  options)
- The MiniMap and FuBar Decursive Icon is now clickable and an information
  tool-tip is displayed when mouse-overing it.
- Decursive Icon gets grey when both the live-list and MUFs are disabled.
- Added Major Dreamless Sleep to the debuff skip list (Translation is needed
  for other localizations)


**Fixed bug:**
- The status tool-tip was not displayed if the live-list was hidden.
- Warlock pet detection could fail in some conditions.
- Default Warrior ignored debuffs were not used because of a spelling mistake.
- If you were already in combat when logging-in or if you reloaded your UI in
  combat, Decursive was unable to operate correctly.
- Other little bugs were fixed.


Changes from Decursive 2.0 BETA 6-Pub to Decursive 2.0 BETA 6-Pub-fixed
-----------------------------------------------------------------------

- Fixed several problems with the curing order priority system.


Changes from Decursive 2.0 BETA 5 to 2.0 BETA 6-Pub
---------------------------------------------------

    # Important changes:

- Now you need to press Alt to move the MUFs clicking the handle.
- Now a border is displayed around the MUFs, its color depends on the unit's
  class.
- When a unit is charmed, a small green square is displayed inside its MUF.
- A new static option panel is available by ALT-RIGHT-CLICKING on the handle or
  typing /dcroptions (Ace2 Waterfall library).
- Added two new sets of options:
    - Class border and center transparency can be set separately.
    - Spacing between MUFs can be changed.
- Paladin always uses Cleanse instead of Purify (if they learned Cleanse).
- There is no longer a default key bound to the macro, this caused too many
  problems with people not knowing how to change it.
- You can bind a key to show/hide the micro-unit frames.
- In the debuff filtering system, you can now ignore a debuff permanently and
  not only when in combat.

    # Minor changes:

- MUFs display can be reversed (they will display from bottom to top instead of
  top to bottom).
- The Readme.txt file has been reworked to be more clear, "FEATURES" and "FAQ"
  sections have been added.
- Warlock's spell priorities are saved when they change of pet.
- The focus MUF now disappear when the player clear the focus with
  "/clearfocus".
- Fix a bug that caused unit unable to cure magic on magic-charmed unit to see
  a curable magic debuff on these units.
- You can fill your priority/skip list with Paladins and Shamans correctly.
- Added spacers in MUFs option menu for better readability.
- The missing macro binding error message will not be shown if a global binding
  is available.
- Minor code optimizations and bug fixes.


Changes from Decursive 2.0 BETA 4 to 2.0 BETA 5

- Fix a bug that caused the loss of per-character bindings.
- Added a new debuff type: 'Charm' that applies to charmed units so mages can
  see all charmed units ; previously they could only see charmed units with a
magical debuff (as priests). (This need testing, the situation is difficult to
reproduce)
- Added an option to change the transparency (Alpha) of the MUFs when a unit is
  not afflicted, it can be set to 0 to be completely transparent.
- The micro unit frames (MUFs) are set to a lower strata.
- "Arcane Blast" will no longer be shown as a Debuff.
- Added full French localization by Sylvin
- Added full Korean localization by Fenlis
- Fixed typos in localization.lua and added a missing option description.


Changes from Decursive 2.0 BETA 3 to 2.0 BETA 4

- Changed the minimum number of MUF per row to 1
- The 'Show Help' option also disable the handle tool-tip
- The focused unit won't be scanned if it's unfriendly (you won't see it in the
  MUFs nor in the live-list).
- The macro binding function has been enhanced, it correctly unbinds previously
  mapped key and restores previously mapped action and displays messages when a
mapping succeed/fails or replace a currently mapped action.
- Added an option to not show out of range units in the live-list (enabled by
  default).
- On non-English client, the key is set to "NONE" in the localization files so
  Decursive will display a warning to the user.
- Babble-Spell library has been updated, Spanish spells should be supported.
- Decursive is now available on wowace.com SVN


Changes from Decursive 2.0 BETA 2 to 2.0 BETA 3

- Fix the huge memory consumption of the scanning functions.
- Fix a problem with the macro that was not updated if the macro frame was
  opened.
- Fix some options in the menus that were not propagated correctly.
- Code optimization.
- Added a note in the readme.txt file about how to change the default key bound
  to the macro.

Changes from Decursive 2.0 BETA 1 to 2.0 BETA 2

- Fix Micro-Unit-Frames (MUFs) display: the first time you log on, the MUFs are
  displayed to a reachable place instead of the top left corner of your screen.
- Fix the LUA error message that occurred when you had all your macro spot
  used.
- The handle to move the MUFs (above the first MUF) now highlights when
  mouse-overred, a tooltip has been added.
- Fix a huge bug in the priority and skip list management causing a variable
  number of unit to not be displayed in the MUFs if your lists were not empty.
- MUFs scaling functions have been improved.
- The readme.txt file has been updated.


Changes from Decursive 1.9.8.4 to 2.0 BETA 1

User significant changes:

- Debuff removal capability restored in several ways:
        - By clicking on-micro unit frames created by Decursive for a
          user-defined number of players.
        - By mouse-overring units or unit frames and pushing a user-defined
          keyboard key.
        - Read the readme file to know more about these changes
- Priority list management:
        - Now fully operational, you can very easily change player positions in
          the list
        - List display has been very improved (scrollbars, colors...)
        - Priority list order defines the order of the micro-unit frames
          displayed
- The option window has been removed:
        - All options are accessed through a drop down menu appearing when
          right-clicking on "Decursive" bar. (DewDrop Ace2Lib)
        - Every menu entries has a small explanation tooltip.
        - All options can be accessed through command line (AceConsole Ace2Lib)
- Debuff skipping management
        - Users can easily add/delete debuffs to ignore on specific classes
          while in combat
- Mage can sheep mind-controlled units (if other classes are interested, their
  spell can be added on request)
- The readme.txt file has been rewritten and should be read of course.

Internal changes:

- Decursive was almost entirely rewritten and reorganized (the live list system
  has not been redisigned yet)
- New code architecture, more ressource efficient and more scalable.
- Decursive is now an Ace2 add-on using Ace2 embeded libraries.


Changes from Decursive 1.9.8.3 to 1.9.8.4

- Fix syntax for compatibility with BC and LUA 5.1.1
- Huge memory usage improvement, Decursive re-uses tables and uses the Compost
  Ace2 library so Decursive uses 0.0 Kib/s when idle or in action.
- Improved CPU usage, it should be minimum.


After BC Decursive may no longer be used while in combat, it will just tell you
who you SHOULD de-curse but won't be able to target or cast for you...  It may
still work out of combat but it's not certain at this stage.  Blizzard has made
big changes in the game play so de-cursing without Decursive may not be as
boring as it used to be...



Changes from Decursive 1.9.8.2 to 1.9.8.3

- The "nothing Cleaned" bug some people were experiencing should be fixed.
- There is no more "dead zone" beneath the "Decursive" bar when the live-list
  is displayed (thanks to Chewster for accurately reporting this bug)
- The Shaman 'Purge' spell should work again.
- New option: when Decursive is asked to clean, it cancels any spell in
  progress.  (except for warlocks and channeled spells).
- A new PDF doc is available in the Archive (thanks to Whitney for writing it).

Changes from Decursive 1.9.8.1 to 1.9.8.2

- Now Decursive disables and re-enables the "self auto cast" option
  automatically, it's no longer a problem.
- Last version I hope!!!

Changes from Decursive 1.9.8 RC2 to 1.9.8.1

- Fix the LUA error happening on BG when a player from another server has a
  debuff to ignore (such as Mind Vision), other related issues should be fixed.
- The WoW UI option "Auto Self Cast" is causing problems: Decursive is enable
  to cast on anyone but yourself while this option is active.  Now Decursive
will pop-up a warning if this option is enabled and will propose to disable it.
- Chinese localization has been updated (thanks to Peter Sun).
- French localization revised by The Grinch.

Changes from Decursive 1.9.8 RC1 to 1.9.8

- Fixed the LUA error happening for people who had the 'Print messages in
  default chat' option checked before upgrading to 1.9.8.
- Fixed the custom message frame display, now it has a font to print
  something...

Changes from Decursive 1.9.7 to 1.9.8 RC1

************************ ====> IMPORTANT CHANGES: ************************

- TREMENDOUS PERFORMANCE IMPROVEMENTS (no more lag) (thanks to Lex for his
  cache idea)
- You can choose in the options the type of debuff you want to cure (Magic,
  Poison, Curse, Disease)
- Added cure priority based on debuff type (select the types in the order you
  want to de-curse).  NOTE: For now this only works on a per unit basis,
Decursive will de-curse a unit in the order you set debuff types.  For example
if you set (Poison, Curse), Decursive will first remove Poison on a unit then
or if no poison, it will remove curses on that same unit...
- TOC updated for 1.12

************************** ====> INTERESTING CHANGES:
**************************

- When you have a target selected, whether it's in your raid or not it will
  appear in Decursive live-list if you can cure it.
- Now you can see how many times a debuff is applied on a player in the live
  list.
- Affliction type is displayed in the live list.

    ****************** ====> NEW OPTIONS: ******************

- New Option: Now you can decide how the text is displayed in the custom frame
  (From top or from bottom)
- New Option: "Reverse live-list display"
- New Option: "Show Tooltips in afflicted list"
- New Option: "Hide the live-list"
- New Option: "Tie live-list visibility to DCR window" (if the main DCR window
  is closed then the live-list is hidden...)
- New command line and key binding: /dcrhide will hide Decursive window leaving
  the live-list visible /dcrshow shows Decursive window
- New command line and key binding: /dcroption will open and close the option
  window
- Added the global variable Dcr_Saved.Dcr_OutputWindow to change the default
  output window (use /script Dcr_Saved.Dcr_OutputWindow = ChatFrame2 for
example).
- Added /dcrdebug command to enable/disable debug info. (thanks to @derey)

******************** ====> MINOR CHANGES: ********************

- Enhanced message display with colors (you can also click character names in
  default chat window).
- Raid curing order is now truly per group: your group, the groups after yours
  and the groups before yours.  Before 1.9.8 BETA 2 it was: your group, the
players from groups after yours and the players from groups before yours.
- Fix the delay problem with text message (it was related to a change in 1.11)
- If Decursive fails because the target is invalid, the target is blacklisted.
- Internal code reorganization and sorting.
- Updated .toc for 1.12
- Other minor fixes.




Changes from Decursive 1.9.6 FINAL to 1.9.7

******************* ====> New features: *******************

- Now when a cast fails, only "out of sight" persons are blacklisted.

- You can hide the buttons by right clicking on "Decursive", when the buttons
  are hidden, the Decursive frame is locked so you can't move it by accident.

- Added the Option "Don't blacklist priority list names" (defaults to off)

- Added Chinese localization (zhTW)

******************* ====> Enhancements: *******************

- Performance improve.

- Debuffs to not cure (Dreamless Sleep and Mind Vision), will not be displayed
  nor cured unless the unit is debuffed by other debuffs of the same kind.  In
previous versions, those debuffs were skipped only if the player was in combat.

- Decursive's frame is smaller: the version is displayed in a tooltip.

- No more risk to lose the current target when the "Check for range" option is
  used.

- Decursive no longer checks for mana or for the state of your curing spell, it
  is no longer necessary (and may avoid some freezes).

- The display of Decursive message is now more logical, the text begins to be
  displayed just at the bottom of the "Text Anchor" frame (you can move it by
clicking on the 'A' in the top-right corner of the option window)

- It is now more clear to see on who Decursive is casting the curring spell.

***************** ====> Bugs fixed: *****************

- The forgotten debug message Shamans were seeing has been removed.

- The problem priests in shadow form were experiencing has been fixed.

- No more freeze issue when a lot of players are out of range, thanks to Alason
  who gave me a new way to test for range.

- When you left-click on someone in the Decursive live-list Decursive won't try
  to cure your current target.

- No more 'awaiting for target state' when the cast fails.

******************** ====> Small Changes: ********************

- Scanning code has been slightly optimized.

- Out of range players are no longer added to the blacklist (this was useless
  since Decursive is able to bypass them).

- Removed the option "check for range", Decursive will always check for range.

- The sliders in the option window have been moved to the top to avoid clicking
  on the last one by accident when closing the window.

- Localization files have been updated.

- French and Chinese localization files are encoded in UTF-8.


Changes from Decursive 1.9.6.5 to Decursive 1.9.7
- Decursive no longer check for mana or for the status of a spell, those were
  here to avoid to blacklist people for false reason. (LoS is detected since
1.9.6.5)

Changes from Decursive 1.9.6.4 to Decursive 1.9.6.5

- Added the Option "Don't blacklist priority list names" (defaults to off)
- Removed the option "check for range", Decursive will always check for range.
- Now when a cast fails, only "out of sight" persons are blacklisted.
- Out of range players are no longer added to the blacklist (this was useless).
- Probably fix the freeze issue some people were experiencing.
- Updated Chinese localization.

Changes from Decursive 1.9.6.3 to Decursive 1.9.6.4

- Debuffs to not cure (Dreamless Sleep and Mind Vision), will not be displayed
  nor cured unless the unit is debuffed by other debuffs of the same kind.  In
previous versions, those debuffs were skipped only if the player was in combat.
- Added Chinese localization (zhTW)
- Scanning code has been slightly optimized.
- Now, French and Chinese localization files are in UTF-8

Changes from Decursive 1.9.6.2 to Decursive 1.9.6.3

- When you hide the buttons, the "Decursive" frame is locked so you can't move
  it by accident.
- When Decursive dispels someone, the text displayed is shorter.
- Small changes in the German localization.


Changes from Decursive 1.9.6.1 to Decursive 1.9.6.2

- Really fixed the bug with priests in shadow form.
- When you left-click on someone in the Decursive live-list Decursive won't try
  to decurse your current target.
- The display of Decursive message is now more logical, the text begins to be
  displayed just at the bottom of the "Text Anchor" frame (you can move it by
clicking on the 'A' in the top-right corner of the option window)
- The sliders in the option window have been moved to the top to avoid clicking
  on the last one by accident when closing the window.
- It is now more clear to see on who Decursive is casting the curring spell.


Changes from Decursive 1.9.6 FINAL to Decursive 1.9.6.1

This is mainly a bug-fix release:
- The forgotten debug message Shamans were seeing has been removed.
- The problem priests in shadow form were experiencing has been fixed.
- No more freeze issue when a lot of players are out of range, thanks to Alason
  who gave me a new way to test for range.
- No more risk to lose the current target when the "Check for range" option is
  used.
- No more 'awaiting for target state' when the cast fails.
- Decursive's frame is smaller: the version is displayed in a tooltip.
- You can hide the buttons by right clicking on "Decursive".
- Small changes in the German localization.


Changes from Decursive 1.9.4 to Decursive 1.9.6 Final

Important changes:

- Massive global performance improvement (important code optimization
  everywhere).
- Re-Added support for warlock pets (Felhunter and Doomguard spells)
- Added an option (on by default) to play a sound when you have someone to cure
  (Breenild idea).
- Now when you click on a cursed person in Decursive's frame you will keep your
  current target unless you use the right-button of your mouse.
- Now Decursive is able to check if you have enough mana before casting.
- Complete French and German localization (Thanks to Archiv and WalleniuM for
  the German translations) So Decursive is able to ignore and skip correctly
certain classes and debuffs in those localizations.  This also corrects
multiple dispels problem for those localizations.
- Changed the licence to GNU GPL (Decursive 1.9.4 is in public domain)

Minor changes:

- Added a reminder at startup about the available options.
- If you don't have one of your curring spell in your action bar, Decursive
  will display an error message when initializing.
- Out of ranges units are added to the blacklist.
- Options and lists are saved for each characters.
- Options are reset to defaults with this version.
- Improved re-targeting.


Bugs fixed:

- Fixed initialization, 1.9.4 was sometime unable to find a spell to use.
- Mind Control dispel was impossible.
- The "check for range" option couldn't be set/unset and was causing Decursive
  to get stuck on out of range persons.
- Improved Event handling (faster when zoning)
- When you are in the priority list, your name is no longer displayed twice.
- the "Ignore Stealthed Units" should work as intended (it never worked before)
- Tooltip are displayed correctly.
- Other minor bug fixes.



See below for a detailed change log between my versions of Decursive.

Changes on 1.9.6 FINAL (Release)

- the "Ignore Stealthed Units" should work as intended (it never worked before)
- Performance improve when the option "Check for Abolish before curing" is used
- Decursive can't put the current player to the blacklist anymore.

Changes in 1.9.6 RC4 (Release Candidate)

- Added a mana check, Decursive won't try to cast if there is not enough mana.
  (not available for warlocks)
- Performance improve when the live list is displayed and contains afflicted
  people.
- Performance improve when checking for range.
- Added unlocalized strings to loc. (French and German loc. updated, thanks to
  Archiv for the German translations).
- Options and lists are now saved per character (options reset to default with
  this version).


Changes in 1.9.6 RC3 (Release Candidate)

- The correction about the MC bug in RC2 introduced a problem with units
  controlled by priests, changed the fix to a better one :)
- Fixed tooltip display (tooltips were not displayed)


Changes in 1.9.6 RC2 (Release Candidate)

- Probably fixed the MC issue.
- Fixed: When left-clicking on Decursive's frame, the cured unit may not be the
  one you cliked on.
- Fixed a bug (nil method) if the option "Check for range" was used.
- Fixed the "Check for range" option, depending on the cases checking or
  unchecking it had no effect on the actual result.
- When the option "Check for range" is enabled, and a unit is out of range,
  it's added to the blacklist.
- Updated French localisation so Decursive can correctly ignored stealthed unit
  (if the option is set).
- Updated German localization (problem with accents and a forgotten string,
  thanks to Archiv).

Changes in 1.9.6 RC1 (Release Candidate):

- Added new translations to French loc to prevent Decursive from dispelling:
  "Sommeil sans rêve" and "Vision télépathique"
- Updated German localization (thanks to WalleniuM)
- Overall performance improve (no more multiple calls to SetOwner()) This
  change may also fix the "Nothing cleaned" bug some people were still
experiencing.
- When you are in the priority list, your name is no longer displayed twice.
- Warlocks can correctly switch to the target if they right click on it in
  Decursive's frame.

Changes in 1.9.6c (Was released in Dev Zone):

- Changed the alert sound to a better one.
- Added a reminder at startup about the available options.
- Fixed a possible issue with cool downs detection.
- Added a possible fix for the reported warlock problem (it's still working
  with my Warlock and another warlock level 60).
- When you right click on a cursed person in Dcr's window, it's selected even
  if nothing is done (spell not ready).

Changes in 1.9.6b (Was released in Dev Zone):

- Changed the licence to GNU GPL
- Now when you click on a cursed person in Decursive's frame you will keep your
  current target unless you use the right-button of your mouse.
- Small fixes in French localization.
- Will never check for range if this is a warlock pet spell.
- Added some debug information for people who have problems with the
  Fellhunter's spell.

Changes in 1.9.5c (Release):

- Added an option (on by default) to play a sound when you have someone to cure
  (Breenild idea).
- Fixed a bug that could cause the cast of a wrong spell if you learn a new
  spell.


Changes in 1.9.5b (changes from last Quu's version 1.9.4):

- Added support for warlock pet Felhunter spell 'Devour Magic' (tested on a
  French version but should work for English and German as well unless the
localisation is not correct in Decursive 1.9.4)
- Fixed French localization for Priests and Druids.
- Improved Event handling (faster when zoning)
- Fixed initialization, 1.9.4 was sometime unable to find a spell to use


[ticket]: https://www.wowace.com/projects/decursive/issues
[GithubReleasess]: https://github.com/2072/Decursive/releases
[BigwigsPackager]: https://github.com/BigWigsMods/packager
