local CTM, C, L, _ = unpack(select(2, ...))

-----------------------------
-- Default Config
-----------------------------
local defaultTexture	= [[Interface\ChatFrame\ChatFrameBackground]]
local defaultFont		= [[Interface\AddOns\ClassicThreatMeter\media\NotoSans-SemiCondensedBold.ttf]] or _G.STANDARD_TEXT_FONT

CTM.defaultConfig = {}

-- general
CTM.defaultConfig.general = {
	welcome				= true,									-- display welcome message
	update				= 0.1,									-- time (in seconds) between updates
	minimap				= false,								-- toggle for minimap icon
	ignorePets			= false,								-- toggle for ignoring pets
	hideOOC				= false,								-- hide frame when out of combat
	hideSolo			= false,								-- hide frame when not in a group
	hideInPVP			= true,									-- hide frame when in battlegrounds
	nameplateThreat		= false,								-- color nameplates by threat
	invertColors		= false,								-- invert threat coloring (for tanks)
	threatColors		= {										-- colors for nameplateThreat
							good	= {0.2, 0.8, 0.2},
							neutral	= {1, 1, 0},
							bad		= {1, 0, 0},
						}
}

-- frame settings
CTM.defaultConfig.frame = {
	test				= false,								-- toggle for test mode
	scale				= 1,									-- global scale
	width				= 217,									-- frame width
	height				= 161,									-- frame height
	locked				= false,								-- toggle for movable
	strata				= "3-MEDIUM",							-- frame strata
	position			= {"LEFT", "UIParent", "LEFT", 50, 0},	-- frame position
	color				= {0, 0, 0, 0.35},						-- frame background color
	headerShow			= true,									-- show frame header
	headerColor			= {0, 0, 0, 0.8},						-- frame header color
}

-- backdrop settings
CTM.defaultConfig.backdrop = {
	bgFile				= defaultTexture,						-- backdrop file location
	bgColor				= {1, 1, 1, 0.1},						-- backdrop color
	edgeFile			= defaultTexture,						-- backdrop edge file location
	edgeColor			= {0, 0, 0, 1},							-- backdrop edge color
	tile				= false,								-- backdrop texture tiling
	tileSize			= 0,									-- backdrop tile size
	edgeSize			= 1,									-- backdrop edge size
	inset				= 0,									-- backdrop inset value
}

-- threat bar settings
CTM.defaultConfig.bar = {
	count				= 9,									-- maximum amount of bars to show
	descend				= true,									-- sort bars descending / ascending
	height				= 18,									-- bar height
	padding				= 1,									-- padding between bars
	marker				= false,								-- mark your statusbar in red
	texture				= defaultTexture,						-- texture file location
	classColor			= true,									-- use class color
	defaultColor		= {0.8, 0, 0.8, 1},						-- color to use when classColor is false
	alpha				= 1,									-- statusbar alpha
	colorMod			= 0,									-- color modifier
}

-- font settings
CTM.defaultConfig.font = {
	family				= defaultFont,							-- font file location
	size				= 12,									-- font size
	style				= "OUTLINE",							-- font style
	color				= {1, 1, 1, 1},							-- font color
	shadow				= true,									-- font dropshadow
}

-- warning settings
CTM.defaultConfig.warnings = {
	visual				= true,									-- enable screen flash
	sounds				= true,									-- enable sounds
	threshold			= 80,									-- alert threshold (of normalized percentage 0-100)
	warningFile			= [[Sound\Interface\Aggro_Enter_Warning_State.ogg]],
	pulledFile			= [[Sound\Interface\Aggro_Pulled_Aggro.ogg]],
}
