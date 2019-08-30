if GetLocale()~='{locale}' then return end
local main= "{versionmain}."
local minor = "{versionminor}"
BIGFOOT_VERSION = "{locale}"..main..minor;

function GetMinorVersion()
	return minor
end

BigFootChangelog_ah();

BigFootChangelog_af();


BF_VERSION_CHECKSUM = "{versionchecksum}"