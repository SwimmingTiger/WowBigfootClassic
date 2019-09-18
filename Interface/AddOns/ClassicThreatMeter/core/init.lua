-----------------------------
--	Init
-----------------------------
local parent, ns = ...
ns[1] = {} -- CTM, Functions
ns[2] = {} -- C, Config
ns[3] = {} -- L, Localization

-----------------------------
-- AddOn Info
-----------------------------
ns[1].addonName	= parent
ns[1].version	= GetAddOnMetadata(parent, "Version")
ns[1].locale	= GetLocale()
