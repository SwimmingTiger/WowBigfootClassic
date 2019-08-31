if GetLocale()~='zhTW' then return end
local main= "4.2.0."
local minor = "251"
BIGFOOT_VERSION = "zhTW"..main..minor;

function GetMinorVersion()
	return minor
end

BigFootChangelog_ah();

BigFootChangelog_af();


BF_VERSION_CHECKSUM = "63"