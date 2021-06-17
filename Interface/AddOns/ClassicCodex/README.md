ClassicCodex [![Build Status](https://travis-ci.com/SwimmingTiger/ClassicCodex.svg)](https://travis-ci.com/SwimmingTiger/ClassicCodex)
===================

This is a partial rewrite of pfQuest/ShaguDB. It is an addon to show you where you can pickup quests, where to turn in quests, where to find mobs / items required for quests, etc.


Features
--------

* Display available quests on your map and minimap
* Display active quests on your map and minimap
* Display spawn markers on your map and minimap that show exact spawn locations for mobs/npcs/objects needed for your quests
* Updated tooltips to display quest progress when hovering over mobs/npcs/objects
* Auto-accept quests (can be disabled by holding control)
* Auto-turnin quests (can be disabled by holding control)
* Quest icon above enemy nameplates that are required for your quests
* Shift-clicking markers on the map will hide them (read the following to find out how to restore)
* Clicking spawn markers on the map will change the color of the markers
* Questlog buttons to show/hide/reset markers
* Database Browser window to search for items/npcs/quests/objects
* Chat commands

[![Screenshots](https://raw.githubusercontent.com/SwimmingTiger/ClassicCodex/master/documents/Screenshots.jpg)](https://raw.githubusercontent.com/SwimmingTiger/ClassicCodex/master/documents/Screenshots.jpg)


Configurations
--------------

* Toggle auto-accept
* Toggle auto-turnin
* Toggle quest icon above enemy nameplates
* Toggle showing questgivers
* Toggle showing questgives for active quests
* Show/hide low-level quests
* Show/hide high-level quests
* Show/hide seasonal/PVP/misc quests
* Color spawn markers by spawn type or by quest
* Adjust the size of quest markers (pickup / turnin)
* Adjust the size of spawn markers
* Display a larger icon for the boss or a single target to help you find it
* Control what to display on your map/minimap


Control what to display on your map/minimap
--------------

When you press `M` to open the world map, you can find a drop-down box in its upper right corner with the following options:

* Show all quests
* Show only tracked quests
* Only show things manually added
* Hide everything

The option will apply to both world map and minimap. If you want to hide one of them, please visit interface options, `ClassicCodex` provides the following options:

* Show Markers on Continent Maps
* Show Markers on Zone Maps
* Show Markers on the Minimap


Chat Commands
-------------

Accessed through `/codex`

|                Command                 | Description |
| -------------------------------------- | ----------- |
| `/codex show`                          | Show database browser interface
| `/codex unit <unit>`                   | Search for an npc/mob by name and display best location on map
| `/codex object <gameObject>`           | Seach for an object by name and display location on map<br>(ex `/codex object copper vein`)
| `/codex item <item>`                   | Search for an item and display location of mobs that drop it
| `/codex vendor <item>`                 | Search for an item and display location of vendors that sell it
| `/codex quest <questName>`             | Search for a specific quest by name
| `/codex quests`                        | Show all quests on the map
| `/codex meta <relation> <min> <max>`   | Search for objects with relations on the map<br>(ex `/codex meta mines 50 175` will display ores mineable with from skill 50 to 175 in mining)<br>Available relations: `chests`, `herbs`, `mines`
| `/codex clean`                         | Clean the map
| `/codex reset`                         | Reset the map and display only current quests
| `/codex <something>`                   | Will attempt to search through the database browser

Accessed through `/codexcfg`

|                Command                 | Description |
| -------------------------------------- | ----------- |
| `/codexcfg`                            | Show options
| `/codexcfg <optionName>`               | Toggle option
| `/codexcfg <optionName> <value>`       | Set option


Search
-------------

You can search for the following keywords in the Codex browser, or use the `/codex <keyword>` command.

|       Keyword        |       Example        | Description |
| -------------------- | -------------------- | ----------- |
| `<partial name>`     | `riverpaw`           | Search the unit/object/item/quest with the name/title
| `#<full name>`       | `#Harvest Reaper`    | Search the unit/object/item/quest with the name/title (exact match)
| `<partial id>`       | `8746`               | Search the unit/object/item/quest with the id
| `#<full id>`         | `#8746`              | Search the unit/object/item/quest with the id (exact match)
| `@`                  | `@`                  | List completed quests
| `@<partial title>`   | `@Water`             | Search the completed quest with the title
| `@#<partial title>`  | `@#Call of Water`    | Search the completed quest with the title (exact match)
| `@<lvl>`             | `@10`                | The example is searching completed quests with the lvl 10-19
| `@#<lvl>`            | `@#10`               | The example is searching completed quests with the lvl 10
| `!`                  | `!`                  | List manually hidden quests<br>(you can click the star icon in front of a searching result to unhide it)
| `!<partial title>`   | `!Water`             | Search the manually hidden quest with the title
| `!#<partial title>`  | `!#Call of Water`    | Search the manually hidden quest with the title (exact match)
| `!<lvl>`             | `!10`                | The example is searching manually hidden quests with the lvl 10-19
| `!#<lvl>`            | `!#10`               | The example is searching manually hidden quests with the lvl 10


Hide & Restore Markers
-------------

### Quest

Hold down the `shift` key and click on a quest marker on the minimap or the world map to hide it.

You can unhide it by clicking the "Show All Quests You Manually Hide Again" button on the interface options.

Or, search the quest in Codex browser with the `!` prefix, then click the star icon in front of it.

### Spawn

Hold down the `shift` key and click on a spawn marker on the minimap or the world map to hide a type of spawn.

You can find the corresponding quest in the quest log and click the "Show" button to display it again.

Or you can do a `/reload` and it will appear again.
