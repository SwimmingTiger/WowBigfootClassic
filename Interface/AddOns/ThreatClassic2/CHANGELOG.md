# Changelog

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
