local main= "Test3.1.0."
local minor = "000"
BIGFOOT_VERSION = main..minor;

function GetMinorVersion()
	return minor
end

if (GetLocale() == "zhCN") then
	BigFootChangelog_ah();

	BigFootChangelog_at("07/01/2010 (3.1.0.000)");
	BigFootChangelog_ar("测试专用版。","");

	BigFootChangelog_af();

	BIGFOOT_VERSION_FONT1 = "Fonts\\ARHei.TTF";
	BIGFOOT_VERSION_FONT2 = "Fonts\\ARHei.TTF";
	BIGFOOT_VERSION_FONT3 = "Fonts\\ARHei.TTF";
	BIGFOOT_VERSION_FONT4 = "Fonts\ARKai_T.TTF";
elseif (GetLocale() == "zhTW") then
	BigFootChangelog_ah();

	BigFootChangelog_at("07/01/2010 (3.1.0.000)");
	BigFootChangelog_ar("測試專用版。","");

	BigFootChangelog_af();

	BIGFOOT_VERSION_FONT1 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT2 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT3 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT4 = "Fonts\\bLEI00D.TTF";
else
	BigFootChangelog_ah();

	BigFootChangelog_at("Empty Log");
	BigFootChangelog_ar("Empty Log","");

	BigFootChangelog_af();

	BIGFOOT_VERSION_FONT1 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT2 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT3 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT4 = "Fonts\\bLEI00D.TTF";
end

BF_VERSION_CHECKSUM = "33";