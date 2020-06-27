local TC2, C, L, _ = unpack(select(2, ...))


-----------------------------
-- Default Config
-----------------------------
local defaultTexture = "TC2 Default"
local defaultFont = "NotoSans SemiCondensedBold"
-- Adjust fonts for CJK
local locale = GetLocale()
if locale == "koKR" or locale == "zhCN" or locale == "zhTW" then
	defaultFont = "Standard Text Font"
end

local defaultConfig = {}
-- general
defaultConfig.general = {
	welcome				= true,									-- display welcome message
	updateFreq			= 0.2,									-- how often the threat bars update
	rawPercent			= false,								-- use raw percent
	downscaleThreat		= true,									-- downscale threat so 1 damage = 1 threat
	minimap				= false,								-- toggle for minimap icon
	ignorePets			= false,								-- toggle for ignoring pets
	hideOOC				= false,								-- hide frame when out of combat
	hideSolo			= false,								-- hide frame when not in a group
	hideOpenWorld		= false,								-- hide frame when not in an instance
	hideInPVP			= true,									-- hide frame when in battlegrounds
	hideAlways			= false,								-- hide frame always
}

-- frame settings
defaultConfig.frame = {
	test				= false,								-- toggle for test mode
	scale				= 1,									-- global scale
	width				= 217,									-- frame width
	height				= 161,									-- frame height
	locked				= false,								-- toggle for movable
	strata				= "3-MEDIUM",							-- frame strata
	position			= {"TOPLEFT", "UIParent", "TOPLEFT", 50, -200},	-- frame position
	color				= {0, 0, 0, 0.35},						-- frame background color
	headerShow			= true,									-- show frame header
	headerColor			= {0, 0, 0, 0.8},						-- frame header color
}

-- backdrop settings
defaultConfig.backdrop = {
	bgTexture			= defaultTexture,						-- backdrop texture
	bgColor				= {1, 1, 1, 0.1},						-- backdrop color
	edgeTexture			= defaultTexture,						-- backdrop edge texture
	edgeColor			= {0, 0, 0, 1},							-- backdrop edge color
	tile				= false,								-- backdrop texture tiling
	tileSize			= 0,									-- backdrop tile size
	edgeSize			= 1,									-- backdrop edge size
	inset				= 0,									-- backdrop inset value
}

-- threat bar settings
defaultConfig.bar = {
	count				= 9,									-- maximum amount of bars to show
	descend				= true,									-- sort bars descending / ascending
	height				= 18,									-- bar height
	padding				= 1,									-- padding between bars
	texture				= defaultTexture,						-- texture file location
	alpha				= 1,									-- statusbar alpha
	colorMod			= 0,									-- color modifier
}

--bar custom color settings
defaultConfig.customBarColors  = {
	playerEnabled		= false,								-- enable custom color for player
	activeTankEnabled	= false,								-- enable custom color for active tank
	otherUnitEnabled	= false,								-- enable custom color for other units
	playerColor			= {0.8, 0, 0, 1},						-- custom color for player
	activeTankColor		= {0, 0.8, 0, 1},						-- custom color for active tank
	otherUnitColor		= {0.3, 0.3, 0.3, 1},					-- custom color for other units
}

-- font settings
defaultConfig.font = {
	name 				= defaultFont,							-- font name
	size				= 12,									-- font size
	style				= "OUTLINE",							-- font style
	color				= {1, 1, 1, 1},							-- font color
	shadow				= true,									-- font dropshadow
}

-- warning settings
defaultConfig.warnings = {
	flash				= false,								-- enable screen flash
	sound				= false,								-- enable sound
	threshold			= 80,									-- alert threshold (of normalized percentage 0-100)
	minThreatAmount		= 2000,
	soundFile			= "You Will Die!",
	soundChannel		= "SFX",
}

TC2.defaultConfig = { profile = defaultConfig }
