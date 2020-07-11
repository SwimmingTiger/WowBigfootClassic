local TC2, C, L, _ = unpack(select(2, ...))

-----------------------------
--	enUS and enGB clients
-----------------------------
-- main frame
L.gui_threat			= "Threat"
L.gui_config			= "Open Config"

-- config frame
L.reset					= "Reset to Defaults"

-- messages
L.message_welcome		= "Type /tc2 for options."
L.message_leader		= "You must be the group leader or have assist to do this."
L.message_outdated		= "|cFFFBB709ThreatClassic2:|r A new version is available! Please update."
L.message_incompatible	= "|cFFFBB709ThreatClassic2|r is out of date and incompatible with older versions. Please update immediately!"

L.general				= "General"
L.general_welcome		= "Display welcome message when logging in."
L.general_rawPercent    = "Use raw threat percentage (aggro at 110% melee / 130% range)"
L.general_downscaleThreat = "Scale threat values (so 1 damage equals 1 threat before modifiers)"
L.general_downscaleThreatDesc = "The Blizzard threat api uses 100 threat per 1 damage. This setting downscales the threat api numbers to what we used before patch 1.13.5"
L.general_updateFreq    = "Minimum time (in seconds) between updates."
L.general_test			= "Enable test mode."
L.general_minimap		= "Toggle minimap icon."
L.general_ignorePets	= "Ignore threat from player pets."

L.visibility			= "Visibility"
L.visibility_hideOOC	= "Hide frame when out of combat."
L.visibility_hideSolo	= "Hide frame when not in a group."
L.visibility_hideInPvP	= "Hide frame when in battlegrounds."
L.visibility_hideOpenWorld	= "Hide frame when not in an instance (also hides world bosses!)."
L.visibility_hideAlways	= "Hide frame always. /tc2 toggle"

L.profiles              = "Profiles"

L.color					= "Colors"

L.appearance			= "Appearance"

L.frame					= "Frame"
L.frame_header			= "Header"
L.frame_bg				= "Background"
L.frame_test			= "Test Mode"
L.frame_strata			= "Strata"
L.frame_scale			= "Scale"
L.frame_lock			= "Lock"
L.frame_headerShow		= "Show Header"
L.frame_headerColor		= "Header Color"
L.frame_position		= "Position"
L.frame_width			= "Width"
L.frame_height			= "Height"
L.frame_xOffset         = "X Offset"
L.frame_yOffset         = "Y Offset"

L.bar					= "Bars"
L.bar_descend			= "Reverse Growth"
L.bar_height			= "Height"
L.bar_padding			= "Padding"
L.bar_texture			= "Texture"
L.bar_alpha				= "Bar Alpha (default colors)"

L.customBarColors 			        = "Custom Bar Colors"
L.customBarColorsPlayer_enabled	    = "Enable Custom Player Color"
L.customBarColorsActiveTank_enabled	= "Enable Custom Active Tank Color"
L.customBarColorsOtherUnit_enabled 	= "Enable Custom Other Unit Color"
L.customBarColorsPlayer_color 	    = "Player Color"
L.customBarColorsActiveTank_color 	= "Active Tank Color"
L.customBarColorsOtherUnit_color 	= "Other Unit Color"

L.font					= "Font"
L.font_name			    = "Name"
L.font_size				= "Size"
L.font_style			= "Style"
L.font_shadow			= "Dropshadow"

L.warnings				= "Warnings"
L.warnings_flash		= "Enable screen flashing."
L.warnings_sound		= "Enable sounds."
L.warnings_threshold	= "Warning threshold (aggro = 100%)"
L.warnings_minThreatAmount = "Minimum threat to trigger warnings"
L.warnings_minThreatAmount_desc = "The value depends on 'General -> Scale threat values' setting and matches the displayed threat. Larger numbers can be set with the input box."

L.warnings_soundFile	= "Sound file"
L.warnings_soundChannel	= "Sound channel"

L.soundChannel_master = "Master"
L.soundChannel_sfx = "SFX"
L.soundChannel_ambience = "Ambience"
L.soundChannel_music = "Music"
