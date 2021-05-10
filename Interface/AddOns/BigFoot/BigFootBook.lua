
if (GetLocale() == "zhCN") then
	BIGFOOT_VERSION_FONT1 = "Fonts\\ARHei.TTF";
	BIGFOOT_VERSION_FONT2 = "Fonts\\ARHei.TTF";
	BIGFOOT_VERSION_FONT3 = "Fonts\\ARHei.TTF";
	BIGFOOT_VERSION_FONT4 = "Fonts\\ARKai_T.TTF";
elseif (GetLocale() == "zhTW") then
	BIGFOOT_VERSION_FONT1 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT2 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT3 = "Fonts\\bHEI01B.TTF";
	BIGFOOT_VERSION_FONT4 = "Fonts\\bLEI00D.TTF";
else
	BIGFOOT_VERSION_FONT1 = "Fonts\\ARIALN.TTF";
	BIGFOOT_VERSION_FONT2 = "Fonts\\ARIALN.TTF";
	BIGFOOT_VERSION_FONT3 = "Fonts\\ARIALN.TTF";
	BIGFOOT_VERSION_FONT4 = "Fonts\\ARIALN.TTF";
end

BIGFOOT_VERSION_TITLE = BF_CHANGELOG_TEXT;

function BigFootChangelog_Register()
	local font1 = {};
	font1.path = BIGFOOT_VERSION_FONT1;
	font1.height = 15;
	font1.color = {r = 0.8828125, g = 0.84765625, b = 0.6875};

	local font2 = {};
	font2.path = BIGFOOT_VERSION_FONT2;
	font2.height = 18;
	font2.color = {r = 1.0, g = 0.82, b = 0.09765625};

	local font3 = {};
	font3.path = BIGFOOT_VERSION_FONT3;
	font3.height = 18;
	font3.color = {r = 0.0, g = 1.0, b = 0.0};

	local font4 = {};
	font4.path = BIGFOOT_VERSION_FONT4;
	font4.height = 15;
	font4.color = {r = 1.0, g = 0.82, b = 0.09765625};

	local callbacks = {};
	callbacks.OnLinkClick = function(linkType, linkContent)
	end

	BigFootReader_RegisterBook(BIGFOOT_VERSION_TITLE, "BIGFOOT_CHANGELOG", true, font1, font2, font3, font4, callbacks);
end

BigFootChangelog_Register();
