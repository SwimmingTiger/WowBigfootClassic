# TomTom
Acts as your portable navigation assistant for World of Warcraft

## Supported Console Commands

### /way /tway /tomtomway

This command sets waypoints and lets you perform simple operations.
In case /way is used by some other addon, /tway and /tomtomway are aliases.
Subcommands are:

#### /tomtomway local
List all the waypoints in the local zone.

#### /tomtomway list
List all the waypoints everywhere.

#### /tomtomway arrow
Print the status of the crazy arrow.

#### /tomtomway block
Print the status of the coordinate block.

#### /tomtomway reset \[all]|\[zone]
Reset either all the waypoints or just the ones in a specific zone.

#### /tomtomway  <x-coords> <y-coords> <description>
Create a waypoint in the current zone.
Coordinates are currently use a '.' as the decimal separator.
The description is whatever is after the y coordinate.

#### /tomtomway <zone> <x-coords> <y-coords> <description>
Create a waypoint in the specified zone.
Coordinates are currently use a '.' as the decimal separator.
The description is whatever is after the y coordinate.

### /cway
Set the active waypoint to be the closest one.

# /wayb [description]
Drop a waypoint at your current location with an optional description.

### /tomtom
Open the TomTom Interface options.

## Zone Naming Conventions

TBD


## Supported Addon API

Definitions:

* **map**: a integer representing the mapID
  See https://wowwiki.fandom.com/wiki/MapID .
* **x**: The horizontal coordinate, normally from 0..1 .
  Can be negative, for Baa'l secret.
* **y**: The vertical coordinate, normally from 0..1 .
  Can be negative, for Baa'l secret.
* **uid**: A table representing the waypoint.
  Since you are going to look anyways, it currently looks like:
  * \[1]: map
  * \[2]: x
  * \[3]: y
  * title: The description of the waypoint
  * \<things>: All the rest of the options.
* **callbacks**: A table used to describe the functions that will be called 
as a waypoint is approached. The table is structured as follows:
  * distance: a table indexed by distance.
  * minimap: a table with the following subkeys:
    * onclick: a function called with (event, uid, self, button) when the icon is clicked.
    * tooltip_show: a function called when the tooltip is initially shown with (event, tooltip, uid, dist)
    * tooltip_update: a function called on tooltip update with (event, tooltip, uid, dist) 
  * world: a table with the following subkeys:
    * onclick: a function called with (event, uid, self, button) when the icon is clicked.
    * tooltip_show: a function called when the tooltip is initially shown with (event, tooltip, uid, dist)
    * tooltip_update: a function called on tooltip update with (event, tooltip, uid, dist) 
   
### uid = TomTom:AddWaypoint(map, x, y, options)
AddWaypoint creates a new waypoint. The options are:
* title: Required string describing the waypoint
* source: Required string describing who is setting the waypoint.
          This will be displayed when mosuing over the arrow or waypoint.
* persistent: Optional boolean saying if the waypoint should persist across logins.
* minimap: Optional Boolean that defaults to the profile.minimap.enable
* minimap_icon: Optional texture that defaults to profile.minimap.icon
* minimap_icon_size: Optional texture that defaults to profile.minimap.icon_size
* world: Optional Boolean that defaults to the profile.worldmap.enable
* worldmap_icon: Optional Boolean that defaults to the profile.worldmap.icon
* worldmap_icon_size: Optional Boolean that defaults to the profile.worldmap.icon_size
* crazy: Optional Boolean that defaults to profile.arrow.autoqueue 
* cleardistance: Optional number that defaults to profile.persistence.cleardistance
* arrivaldistance: Optional number that defaults to profile.arrow.arrival
* silent: Optional Boolean that suppresses announcing the creation of the waypoint
* callbacks: Overrides for the default callbacks


### callbacks = TomTom:DefaultCallbacks(opts)
Generate the default callback tables using the given options table.

### uid = TomTom:AddWaypointToCurrentZone(x, y, desc)
AddWaypointToCurrentZone creates a waypoint in the current zone with all default options except for the description.

### TomTom:RemoveWaypoint(uid)
RemoveWaypoint removes the waypoint identified by the uid from the world-map, mini-map and crazy arrow.
It will also be removed from the persistence list.

### TomTom:HideWaypoint(uid, minimap, worldmap)
HideWaypoint on either the mini-map or world-map.

### TomTom:ShowWaypoint(uid)
ShowWaypoint as per the options.

### TomTom:ClearWaypoint(uid)
ClearWaypoint deactivates the waypoint.

### yards = TomTom:GetDistanceToWaypoint(uid)
Return the number of yards to reach the waypoint.

### angle = TomTom:GetDirectionToWaypoint(uid)
Return the angle (in radians) to the waypoint.

### TomTom:SetClosestWaypoint(verbose)
Set the arrow to the closest waypoint.
If verbose is true, announce in chat.

### m, x, y = TomTom:GetCurrentPlayerPosition()
Return the current map, x, and y coordinates of the player.

