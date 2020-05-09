# ThreatClassic2 [!["Open Issues"](https://img.shields.io/github/issues-raw/dfherr/ThreatClassic2.svg)](https://github.com/dfherr/ThreatClassic2/issues)
ThreatClassic2 is a threat meter for WoW Classic that provides reasonably accurate estimates of a monster's threat table based on [LibThreatClassic2](https://github.com/dfherr/LibThreatClassic2/). It is compatible with all other AddOns providing threat data through LibThreatClassic2 and created as the successor of the abandoned [EsreverWow/ClassicThreatMeter](https://github.com/EsreverWoW/ClassicThreatMeter).

## Bugs and feature requests

Please submit all feature requests and bugs in this projects [issue tracker](https://github.com/dfherr/ThreatClassic2/issues)

Please check for bugs and feature requests before submitting the same request and participate in the dicussion. Please **do not** email me, comment on commits or raise issues in any other channel, so there is a single place for discussions everyone can see and participate. Thank you for your consideration.

Issues related to threat values are tracked in the threat libs project [LibThreatClassic2](https://github.com/dfherr/LibThreatClassic2/)

## Download
 - [CurseForge](https://www.curseforge.com/wow/addons/ThreatClassic2)
 - Manual install from [releases](https://github.com/dfherr/ThreatClassic2/releases)

## FAQ
**Q: Why use ThreatClassic2 instead of ClassicThreatMeter?**

The author of ClassicThreatMeter left the addon with a lot of bugs, like spamming "You are not in a raid" in Alterac Valley and 25% bonus aggro for Def tanks instead of 15%. ThreatClassic2 bundles LibThreatClassic2, which comes with a ton of bug fixes and provides new boss modules for handling Onyxia and Ragnaros threat mechanics.

**Q: Why am I not seeing other players in ThreatClassic2?**
 
A: Other players must have ThreatClassic2 or a compatible AddOn enabled in order to track their threat similar to how KLH Threat Meter/Omen required compatible AddOns communicating threat to one another in Vanilla/TBC.

**Q: Why isn't ThreatClassic2 using the built-in threat API?**

A: To answer simply, it can't! Blizzard added in a threat API in patch 3.0.2 for WotLK and has been in the game since, but it has been purposely removed for WoW Classic, which means we must rely on combat log parsing.

**Q: How does ThreatClassic2 handle multiple targets?**

A: The combat log in WoW Classic is fortunately much more detailed than that which was available in the game originally before patch 2.4. This allows us to track NPCs by GUID (global unique identifier), and there should be no issues with mobs having the same name and threat becoming muddled between them. It is also designed in such a way that effects that are meant to add divided threat between active targets, such as heals and buffs, are able to do so.

**Q: Why aren't there more options to customize the threat window?**

A: ThreatClassic2 is still a very young AddOn. More features and customization options will come over time.

## Sreenshots
<img src="https://i.imgur.com/7ipFacm.png">
<img src="https://i.imgur.com/FUg8kLg.png">
<img src="https://i.imgur.com/bDxNw6X.png">

**Sources:**
 - https://github.com/magey/classic-warrior/wiki/Threat-Mechanics
 - https://classicwow.live/guides/19/threat-guide-and-reference-table
 - https://classic.wowhead.com/guides/threat-overview-classic-wow#threat-modifier-abilities-and-values-warrior

 - https://web.archive.org/web/20061115070619/http://www.evilempireguild.org/guides/kenco2.php
 - https://web.archive.org/web/20091213135841/forums.wow-europe.com/thread.html?topicId=116562109&pageNo=1&sid=1

 - https://wow.gamepedia.com/Aggro
 - https://wow.gamepedia.com/Talk:Aggro
 - https://wow.gamepedia.com/Talk:Aggro/Archive1
 - https://wow.gamepedia.com/Talk:Aggro/Archive2
 - https://wow.gamepedia.com/index.php?title=Aggro&oldid=352753 (Vanilla)
 - https://wow.gamepedia.com/index.php?title=Aggro&oldid=1599827 (TBC)
 - https://wow.gamepedia.com/index.php?title=Aggro&oldid=2380563 (WotLK)

 - https://wow.gamepedia.com/Threat
 - https://wow.gamepedia.com/Talk:Threat
 - https://wow.gamepedia.com/index.php?title=Threat&oldid=175341 (Vanilla)

 - https://wow.gamepedia.com/Threat_list
 - https://wow.gamepedia.com/index.php?title=Threat_list&oldid=193144 (Vanilla)

## License

[MIT](license/ThreatClassic2)

Copyright (c) 2019 Dennis-Florian Herr
