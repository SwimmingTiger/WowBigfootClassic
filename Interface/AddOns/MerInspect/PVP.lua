
local M = MerInspect

function M:INSPECT_HONOR_UPDATE()
	local frame = MerInspectPVP
	for i = 1, MAX_ARENA_TEAMS do
		_, teamSize, teamRating, _, _, _, playerRating = GetInspectArenaTeamData(i)
		if teamSize == 2 then
			frame.text1:SetFormattedText("%s |cffFFFFFF%s|r |cff666666%s|r", "2v2", teamRating, playerRating)
		elseif teamSize == 3 then
			frame.text2:SetFormattedText("%s |cffFFFFFF%s|r |cff666666%s|r", "3v3", teamRating, playerRating)
		elseif teamSize == 5 then
			frame.text3:SetFormattedText("%s |cffFFFFFF%s|r |cff666666%s|r", "5v5", teamRating, playerRating)
		end
	end
end

function M:ClearPVPFrame()
	local frame = MerInspectPVP
	frame.text1:SetFormattedText("%s |cffFFFFFF%s|r |cff666666%s|r", "2v2", "-", "-")
	frame.text2:SetFormattedText("%s |cffFFFFFF%s|r |cff666666%s|r", "3v3", "-", "-")
	frame.text3:SetFormattedText("%s |cffFFFFFF%s|r |cff666666%s|r", "5v5", "-", "-")
	if ( not HasInspectHonorData() ) then
		RequestInspectHonorData()
	else
		self:INSPECT_HONOR_UPDATE()
	end
end
tinsert(M.QueueShow, "ClearPVPFrame")