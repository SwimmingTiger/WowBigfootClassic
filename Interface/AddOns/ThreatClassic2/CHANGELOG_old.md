# Changelog old versions

## v2.20

* Prepared the addon to use the threat api when available (from patch 1.13.5)
* Added an option to downscale threat to the current numbers (i.e. 1 damage = 1 threat. threat api uses 1 damage = 100 threat). Hidden until api is available.
* Removed the nameplate feature. It wasn't working correctly. Please install a dedicated nameplate addon, if you need threat colored nameplates.
* added korean and updated chinese translations


## v2.19

* fix threat warnings not working in raids
* fix background texture not loading properly
* add min threat amount to show warnings
* add smaller positioning options for frame positon (up to 0.01)
* update chinese translations

## v2.18

* fixed a small bug that caused toggled settings not to be copied to the new profiles

## v2.17

* Bump LibThreatClassic2 to revision 12
    * improve buff handling (fixes tranquil totem and blessing of salvation issues)
    * improve paladin blessing threat tracking (still not perfect)
    * add french translation for Nefarian classcall
    * add UnitThreatPercentageOfLoad to public interface
    * always return boolean for isTanking from UnitDetailedThreatSituation
* added support for profiles (imports your current settings to a new character profile **once**)
* added custom color options for current tank and for other units
* added bar texture selection to options
* always display the player if he has threat (when sized to 1 bar, this only displays the player)
* made table update frequency configurable (does not influence incoming rate of other players threat)
* fix odd resizing beheavior and added positioning to config
* does no longer display a warning, when losing aggro as a tank
* added option to display raw threat percentage (pull at 110% or 130% depending on range)

## v2.16

*  Bump LibThreatClassic2 to revision 11
    - improved thunderfury handling

## v2.15

* rename screen flashing parameter so it's correctly disabled by default
* correctly consider flash setting

## v2.14

* remove percentage overwrite for max threat target and rely on LTC2 output
* use Blizzard default font for china/korea/taiwan

## v2.13

* Bump LibThreatClassic2 to revision 10
    - fix bonus threat on missed casts
    - use taunt debuff instead of cast for taunt tracking
    - fix hunter feign death resist handling
    - add thunderfury proc bonus threat
    - fix silent resolve for shadow spells
    - add Hakkar Aspect of Arlokk handling
* add visual and sound warning on certain thresholds while not tanking
* fix dragging error when locked
* enable threat updates when out of combat
* improve player target tracking
* fix table not showing on battle start, when hide ooc is enabled
* add font selector in appearance settings

## v2.12

* Delay updates up to 0.2 seconds to address performance issues
* Only update frame on changes for current target
* Bump LibThreatClassic2 to revision 9
    - Add cleave threat modifier
    - Fix Paladin Greater Blessing bug on pets
    - Blacklist various enemies in BWL
* Update player target, if target target changes
* Added option to hide when not in an instance (also hides world bosses!)
* Improved Version checks
* Added zhTW translations

## v2.11

* Update LibThreatClassic to revision 8. Brings better threat sync interval and blacklist Lashlayer trash whelps.
* Fix some lib loading issues.
* added a /tc2 debug command to toggle LibThreatClassic2 debug output
* added a /tc2 runSolo command to toggle LibThreatClassic2 runSolo option
* added a /tc2 logThreat command to toggle LibThreatClassic2 logThreat option

## v2.10

* Use "target" as a fallback for player target, if other options make no sense (e.g. at vael)

## v2.09

* Update LibThreatClassic2 to revision 7
* Added option to change color of the player bar
* enable support for custom class colors addon
* save variables per character
* fix friendly units turning hostile

## v2.08-alpha1

Removed LibThreatClassic2 from files
added pkgmeta
embed LibThreatClassic2-r6-alpha1

## v2.07

First relase as ThreatClassic2 with LibThreatClassic2-r5