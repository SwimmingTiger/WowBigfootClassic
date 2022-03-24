-- originally I thought this function would be very complicated, but it turns out that
-- highlighting all first letter capitalized words hits over 95% of the significant words
function MkQL_HighlightText(strText)

	local strColourWhite = MonkeyLib_ARGBToColourStr(1, 1, 1, 1);
	local strColourRed = MonkeyLib_ARGBToColourStr(1, 1, 0, 0);
	local strColourBlue = MonkeyLib_ARGBToColourStr(1, 0.6, 0.6, 1);
	local strColourGreen = MonkeyLib_ARGBToColourStr(1, 0, 1, 0);

	-- highlight all numbers
	strText = string.gsub(strText, " (%d+) ", " "..strColourRed.."%1"..strColourWhite.." ");

	-- highlight all first letter capitalized words, needs to run twice
	strText = string.gsub(strText, "(%w+)(,*) (%u%a+'*%a*)", "%1%2 "..strColourBlue.."%3"..strColourWhite);
	strText = string.gsub(strText, "(%w+)(,*) (%u%a+'*%a*)", "%1%2 "..strColourBlue.."%3"..strColourWhite);

	return strText;
end
