local className, inform, lowregentimer, fullmanatimer, lastshift, inCombat,
			pre_UseAction, shiftload, isMoving, waitonce, firstshift, aquaformid,
			travelformid, notyet;

local timer = 0;
local lowregentimer = 0;
local fullmanatimer = 0;
local DruidBar_Anchored = nil;

local minimapIconLDB = LibStub("LibDataBroker-1.1"):NewDataObject("DruidBarMinimapIcon", {
	type = "data source",
	text = "Druid Bar Classic",
	icon = "Interface\\Icons\\ABILITY_DRUID_DEMORALIZINGROAR",
	OnClick = function (self, button) if button == "LeftButton" then DRUIDBAROptionsFrame_Toggle(); end end,
});

local DruidBar_MinimapButton = LibStub("LibDBIcon-1.0");

function DruidBar_OnLoad()
	-- Get players className
	_, className = UnitClass("player");

	if className and className == "DRUID" then
		DruidBarUpdateFrame:RegisterEvent("ADDON_LOADED");
		DruidBarUpdateFrame:RegisterEvent("PLAYER_LEAVING_WORLD");
		DruidBarUpdateFrame:RegisterEvent("PLAYER_ENTERING_WORLD");

		SlashCmdList["DRUIDBARSLASH"] = DruidBar_Enable_ChatCommandHandler;
		SLASH_DRUIDBARSLASH1 = "/dbar";
		SLASH_DRUIDBARSLASH2 = "/druidbar";
		DBarSpellCatch:SetOwner(DruidBarUpdateFrame, "ANCHOR_NONE");

  	-- Creating the minimap config icon
		DruidBar_MinimapButton:Register("DruidBarMinimapIcon", minimapIconLDB, DruidBarKey);
	end
end

function EventRegistration(event)
		if event == "PLAYER_ENTERING_WORLD" then
		--Thanks to Tigerheart from Argent Dawn for this little piece of work, as well as fireball and prudence for bringing it up!
		DruidBarUpdateFrame:RegisterEvent("UNIT_AURA");
		DruidBarUpdateFrame:RegisterEvent("UNIT_STATS");
		DruidBarUpdateFrame:RegisterEvent("UNIT_POWER_UPDATE");
		DruidBarUpdateFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
		return;
	elseif event == "PLAYER_LEAVING_WORLD" then
		DruidBarUpdateFrame:UnregisterEvent("UNIT_AURA");
		DruidBarUpdateFrame:UnregisterEvent("UNIT_STATS");
		DruidBarUpdateFrame:UnregisterEvent("UNIT_POWER_UPDATE");
		DruidBarUpdateFrame:UnregisterEvent("UPDATE_SHAPESHIFT_FORMS");
		return;
	end
end

function DruidBar_OnEvent(self, event,...)
	local arg1,arg2,arg3,arg4,arg5,arg6 = ...

	-- Get players className
	_, className = UnitClass("player");

	-- Not sure what 'firstshift' is for yet
	if UnitPowerType("player") ~= 0 then firstshift = true; end

	-- Set the tooltip anchor
	DBarSpellCatch:SetOwner(DruidBarUpdateFrame, "ANCHOR_NONE");

	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEAVING_WORLD" then
		EventRegistration(event)
	elseif event == "ADDON_LOADED" then
		Load_Variables(className);
		-- Now that we have loaded variables (including icon position), refresh the poisition of the icon
		DruidBar_MinimapButton:Refresh("DruidBarMinimapIcon", DruidBarKey);
	elseif className and className == "DRUID" and DruidBarKey.Enabled then
		-- Show DruidBarUpdateFrame if hidden
		if not DruidBarUpdateFrame:IsVisible() then DruidBarUpdateFrame:Show(); end

		-- Player equiped or unequiped an item
		-- Player's power changed
		-- Player gained or lost a form, buff, debuff, status, or item bonus
		if event == "UNIT_AURA" or event == "UPDATE_SHAPESHIFT_FORMS" or event == "UNIT_POWER_UPDATE" then
				DruidBarKey.maxmana = UnitPowerMax("player", 0);
				DruidBarKey.currentmana = UnitPower("player", 0);
		end
	end
end

function DruidBar_OnUpdate(self, elapsed)
	if className and className == "DRUID" and DruidBarKey.Enabled then
		timer = (timer or 0) + elapsed;
		if not notyet then
			DruidBar_MaxManaScript();
			for i = 1, GetNumShapeshiftForms() do
				local icon = GetShapeshiftFormInfo(i);
				if icon == "Interface\\Icons\\Ability_Druid_AquaticForm" then aquaformid = i; end
				if icon == "Interface\\Icons\\Ability_Druid_TravelForm" then travelformid = i; end
			end
			notyet = true;
		end

		if lowregentimer > 0 then
			lowregentimer = lowregentimer - elapsed;
			if lowregentimer <= 0 then lowregentimer = 0; end
		end

		if UnitPowerType("player") ~= 0 then
			fullmanatimer = fullmanatimer + elapsed;
			if fullmanatimer > 6 and floor((DruidBarKey.currentmana*100) / DruidBarKey.maxmana) > 90 then
				DruidBarKey.currentmana = DruidBarKey.maxmana;
			end
		end

		-- Graphics ON
		if DruidBarKey.Graphics then
			if DruidBarKey.Replace then
				DruidBar_ReplaceGraphics();
				DruidBar_ColorAndStrataAndTexture();
			else
				DruidBarMana:SetMinMaxValues(0, DruidBarKey.maxmana);
				DruidBarMana:SetValue(DruidBarKey.currentmana);
				if timer > 2 then DruidBar_ColorAndStrataAndTexture(); timer = 0; end
				DruidBar_MainGraphics();
			end
		--Graphics OFF
		else
			dbarHide(DruidBarFrame);
			dbarHide(DruidBarReplaceText);
			if PlayerFrameManaBar:GetWidth() < 100 then PlayerFrameManaBar:SetWidth(120); end
		end
	else
		dbarHide(DruidBarFrame);
		dbarHide(DruidBarUpdateFrame);
	end
end

function Load_Variables(className)
	-- Populate primary data store 'DruidBarKey'
	if not DruidBarKey then
		DruidBarKey = {};
		DruidBarKey.currentmana = 0;
		DruidBarKey.maxmana = 10;
		DruidBarKey.int = 0;
		DruidBarKey.subtractmana = 0;
		DruidBarKey.extra = 0;
		DruidBarKey.Enabled = true;
		DruidBarKey.Graphics = true;
		DruidBarKey.Minimap = true;
		DruidBarKey.DontShiftBack = false;
		DruidBarKey.tempW = 170;
		DruidBarKey.tempH = 18;
		DruidBarKey.color = {0,0,1,1};
		DruidBarKey.bordercolor = {1,1,1,1};
		DruidBarKey.bgcolor = {0,0,0,0.5};
	end

	if not DruidBarKey.color then DruidBarKey.color = {0,0,1,1}; end
	if not DruidBarKey.bordercolor then DruidBarKey.bordercolor = {1,1,1,1}; end
	if not DruidBarKey.bgcolor then DruidBarKey.bgcolor = {0,0,0,0.5}; end
	if(not DruidBarKey.tempW or DruidBarKey.tempW == 0) then
		if DruidBarKey.width < 0 then
			DruidBarKey.tempW = DruidBarKey.width;
		else
			DruidBarKey.width = DruidBarKey.xvar;
			DruidBarKey.tempW = DruidBarKey.xvar;
		end
	end
	if(not DruidBarKey.tempH or DruidBarKey.tempH == 0) then
		if DruidBarKey.height < 0 then
			DruidBarKey.tempW = DruidBarKey.height;
		else
			DruidBarKey.height = DruidBarKey.yvar;
			DruidBarKey.tempW = DruidBarKey.yvar;
		end
	end
	if(not DruidBarKey.DontShiftBack) then DruidBarKey.DontShiftBack = false; end
	if not DruidBarKey.bgstrata then DruidBarKey.bgstrata = "BORDER" end
	if not DruidBarKey.manatexture then DruidBarKey.manatexture = "Interface\\TargetingFrame\\UI-StatusBar"; end
	if not DruidBarKey.bordertexture then DruidBarKey.bordertexture = "Interface\\Tooltips\\UI-StatusBar-Border"; end

	DruidBarMana:SetStatusBarTexture(DruidBarKey.manatexture);
	DruidBarManaBackground:SetTexture(DruidBarKey.manatexture);
	DruidBarBorder:SetTexture(DruidBarKey.bordertexture);

	-- Not sure what 'shiftload' is all about yet
	if not shiftload and className == "DRUID" then
		pre_ShapeshiftBar_ChangeForm = ShapeshiftBar_ChangeForm;
		ShapeshiftBar_ChangeForm = DruidBar_ChangeForm;
		shiftload = true;
	end
end

function DruidBar_ReflectionCheck()
	local managain = 0;
	local j = 1;
	while (UnitBuff("player",j)) do
		DBarSpellCatch:SetUnitBuff("player", j);
		local msg = DBarSpellCatchTextLeft1:GetText();
		if msg and (strfind(msg,DRUIDBAR_INNERVATE)) then
			return ((ceil(UnitStat(arg1,5) / 5)+15) * 5);
		end
		j = j + 1;
	end
	if lowregentimer > 0 then
		if waitonce then
			local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq = GetTalentInfo(3, 6);
			if rank == 0 then return 0; else
				managain = ((ceil(UnitStat("player",5) / 5)+15) * (0.05 * rank));
			end
		else
			waitonce = true;
		end
	elseif lowregentimer <= 0 then
		managain = (ceil(UnitStat("player",5) / 5)+15);
	end
	return managain;
end

function DruidBar_Subtract()
	if not firstshift then
		local j = 1;
		while (UnitBuff("player",j)) do
			DBarSpellCatch:SetUnitBuff("player", j);
			local msg = DBarSpellCatchTextLeft1:GetText();
			if msg and (strfind(msg,DRUIDBAR_META)) then
				if DruidBarKey.Debug then DEFAULT_CHAT_FRAME:AddMessage("Rune detected, no mana cost!"); end
				return;
			end
			j = j + 1;
		end
		DruidBarKey.currentmana = DruidBarKey.currentmana - DruidBarKey.subtractmana;
		if DruidBarKey.Debug then DEFAULT_CHAT_FRAME:AddMessage("Mana Deduction: "..DruidBarKey.subtractmana); end
	else
		firstshift = nil;
	end
end

--Change form! whatever you cast, if you're shifted, you'll shift back to caster.
function DruidBar_ChangeForm(id)
	local changingback = nil;

	for i = 1, GetNumShapeshiftForms() do
		local icon, name, active = GetShapeshiftFormInfo(i);
		if active and not DruidBarKey.DontShiftBack then id = i; changingback = true; end
	end

	if (id) then
		pre_ShapeshiftBar_ChangeForm(id);
		return nil;
	else
		return true;
	end
end

function dbarHide(frame)
	if frame:IsVisible() then
		frame:Hide();
	end
end

function dbarShow(frame)
	if not frame:IsVisible() then
		frame:Show();
	end
end

function dbarLength()
	if not DruidBarKey.width then DruidBarKey.width = 170; end

	if DruidBarFrame:GetWidth() ~= DruidBarKey.width then
		DruidBarFrame:SetWidth(DruidBarKey.width);
		DruidBarKey.width = DruidBarFrame:GetWidth();
	end

	DruidBarMana:SetWidth(DruidBarKey.width*0.95);
	DruidBarManaBackground:SetWidth(DruidBarKey.width*0.95);
end

function dbarHeight()
	if not DruidBarKey.height then DruidBarKey.height = 18; end

	if DruidBarFrame:GetHeight() ~= DruidBarKey.height then
		DruidBarFrame:SetHeight(DruidBarKey.height);
		DruidBarKey.height = DruidBarFrame:GetHeight();
	end

	DruidBarMana:SetHeight(DruidBarKey.height*(2/3));
	DruidBarManaBackground:SetHeight(DruidBarKey.height*(2/3));
end

function Minimap_Button_Renderer()
	-- If Minimap Icon should show based on settings
  if DruidBarKey.Minimap then
  	DruidBar_MinimapButton:Show("DruidBarMinimapIcon");
  else
  	DruidBar_MinimapButton:Hide("DruidBarMinimapIcon");
  end
end

function DruidBar_MainGraphics()
	dbarHide(DruidBarReplaceText);
	Minimap_Button_Renderer()

	if PlayerFrameManaBar:GetWidth() < 100 then PlayerFrameManaBar:SetWidth(120); end

	-- If DruidBar should render based on settings
	if DruidBar_ShouldBeVisible() then
		-- Render DruidBar Frame, Background, and Border
		dbarShow(DruidBarFrame);
		dbarShow(DruidBarManaBackground);
		dbarShow(DruidBarBorder);

		DruidBar_TextRenderer();

		dbarLength();
		dbarHeight();

		-- Set location of DruidBar
		if DruidBarKey.Player then
			DruidBarFrame:ClearAllPoints();
			DruidBarFrame:SetPoint("TOPRIGHT","PlayerFrame","BOTTOMRIGHT", -3, 35);
			DruidBar_Anchored = true;
		elseif DruidBar_Anchored then
			DruidBarFrame:ClearAllPoints();
			DruidBarFrame:SetPoint("CENTER","UIParent","CENTER", 0, 0);
			DruidBar_Anchored = nil;
		end

		-- Set the position lock and dragability
		if DruidBarKey.Lock then
			DruidBarFrame:EnableMouse(0);
			DruidBarFrame:RegisterForDrag();
		else
			DruidBarFrame:EnableMouse(1);
			DruidBarFrame:RegisterForDrag("LeftButton");
			DruidBarFrame:SetScript("OnDragStart", DruidBarFrame.StartMoving);
			DruidBarFrame:SetScript("OnDragStop", DruidBarFrame.StopMovingOrSizing);
		end
	else
		dbarHide(DruidBarFrame);
	end
end

function DruidBar_TextStyle()
	if DruidBarKey.Percent then
		if DruidBarKey.Percent == 0 then -- Numbers
			dbarShow(DruidBarTextCenter);
			DruidBarTextCenter:SetText(ManaValues());
			DruidBarTextCenter:SetTextColor(1,1,1,1);
		elseif DruidBarKey.Percent == 1 then -- Percent
			dbarShow(DruidBarTextCenter);
			DruidBarTextCenter:SetText(ManaPercentage());
			DruidBarTextCenter:SetTextColor(1,1,1,1);
		elseif DruidBarKey.Percent == 2 then -- Bliz-Like
			dbarShow(DruidBarTextLeft);
			dbarShow(DruidBarTextRight);
			DruidBarTextLeft:SetText(ManaPercentage());
			DruidBarTextRight:SetText(CurrentMana());
			DruidBarTextLeft:SetTextColor(1,1,1,1);
			DruidBarTextRight:SetTextColor(1,1,1,1);
		end
	else -- Both
		dbarShow(DruidBarTextCenter);
		DruidBarTextCenter:SetText(ManaValuesAndPercentage());
		DruidBarTextCenter:SetTextColor(1,1,1,1);
	end

	if DruidBarKey.Text == 0 then
		DruidBarTextLeft:SetFontObject("GameTooltipTextSmall");
		DruidBarTextCenter:SetFontObject("GameTooltipTextSmall");
		DruidBarTextRight:SetFontObject("GameTooltipTextSmall");
	elseif DruidBarKey.Text == 1 then
		DruidBarTextLeft:SetFontObject("TextStatusBarText");
		DruidBarTextCenter:SetFontObject("TextStatusBarText");
		DruidBarTextRight:SetFontObject("TextStatusBarText");
	end
end

function DruidBar_TextRenderer()
	dbarHide(DruidBarTextLeft);
	dbarHide(DruidBarTextCenter);
	dbarHide(DruidBarTextRight);

	-- Text options --
	if DruidBarKey.Text then
		if DruidBarKey.Text == 0 or DruidBarKey.Text == 1 or (DruidBarKey.Text == 2 and (MouseIsOver(DruidBarFrame) or MouseIsOver(PlayerFrameManaBar))) then
			DruidBar_TextStyle()
		end
	end
end

function ManaValuesAndPercentage()
	return ManaValues().." "..ManaPercentage();
end

function ManaValues()
	return floor(DruidBarKey.currentmana).."/"..floor(DruidBarKey.maxmana);
end

function CurrentMana()
	return floor(DruidBarKey.currentmana);
end

function ManaPercentage()
	return floor(DruidBarKey.currentmana / DruidBarKey.maxmana * 100).."%";
end

function DruidBar_ReplaceGraphics()
	if UnitPowerType("player") ~= 0 then
		dbarHide(DruidBarManaBackground);
		dbarHide(DruidBarBorder);
		dbarHide(DruidBarTextLeft);
		dbarHide(DruidBarTextCenter);
		dbarHide(DruidBarTextRight);
		dbarHide(PlayerFrameManaBarText);

		dbarShow(DruidBarFrame);
		dbarShow(DruidBarReplaceText);
		PlayerFrameManaBar:SetWidth(60);
		DruidBarFrame:ClearAllPoints();
		DruidBarFrame:SetPoint("CENTER","PlayerFrameManaBar","CENTER", 60, 0);
		DruidBarMana:SetWidth(60);
		DruidBarMana:SetHeight(10);

		dbarHide(DBarTextLeft);
		dbarHide(DBarTextCenter);
		dbarHide(DBarTextRight);
		if DruidBarKey.Text == 0 or DruidBarKey.Text == 1 or (DruidBarKey.Text == 2 and (MouseIsOver(DruidBarFrame) or MouseIsOver(PlayerFrameManaBar))) then
			if DruidBarKey.Percent then
				if DruidBarKey.Percent == 0 then -- Numbers
					dbarShow(DBarTextCenter);
					DBarTextCenter:SetText(ManaValues());
					DBarTextCenter:SetTextColor(1,1,1,1);
				elseif DruidBarKey.Percent == 1 then -- Percent
					dbarShow(DBarTextCenter);
					DBarTextCenter:SetText(ManaPercentage());
					DBarTextCenter:SetTextColor(1,1,1,1);
				elseif DruidBarKey.Percent == 2 then -- Bliz-Like
					dbarShow(DBarTextLeft);
					dbarShow(DBarTextRight);
					DBarTextLeft:SetText(ManaPercentage());
					DBarTextRight:SetText(CurrentMana());
					DBarTextLeft:SetTextColor(1,1,1,1);
					DBarTextRight:SetTextColor(1,1,1,1);
				end
			else -- Both
				dbarShow(DBarTextLeft);
				dbarShow(DBarTextRight);
				DBarTextLeft:SetText(CurrentMana());
				DBarTextRight:SetText(ManaPercentage());
				DBarTextLeft:SetTextColor(1,1,1,1);
				DBarTextRight:SetTextColor(1,1,1,1);
			end

			if DruidBarKey.Text == 0 then
				DBarTextLeft:SetFontObject("GameTooltipTextSmall");
				DBarTextCenter:SetFontObject("GameTooltipTextSmall");
				DBarTextRight:SetFontObject("GameTooltipTextSmall");
			elseif DruidBarKey.Text == 1 then
				DBarTextLeft:SetFontObject("TextStatusBarText");
				DBarTextCenter:SetFontObject("TextStatusBarText");
				DBarTextRight:SetFontObject("TextStatusBarText");
			end
		end
	else
		dbarHide(DruidBarFrame);
		dbarHide(DruidBarReplaceText);
		dbarHide(DBarTextLeft);
		dbarHide(DBarTextCenter);
		dbarHide(DBarTextRight);
		PlayerFrameManaBar:SetWidth(120);
	end
end

--Text Parsing. Yay!
function TextParse(InputString)
  --[[ By FERNANDO!
	This function should take a string and return a table with each word from the string in
	each entry. IE, "Linoleum is teh awesome" returns {"Linoleum", "is", "teh", "awesome"}
	Some good should come of this, I've been avoiding writing a text parser for a while, and
	I need one I understand completely. ^_^

	If you want to gank this function and use it for whatever, feel free. Just give me props
	somewhere. This function, as far as I can tell, is fairly foolproof. It's hard to get it
	to screw up. It's also completely self-contained. Just cut and paste.]]
   local Text = InputString;
   local TextLength = 1;
   local OutputTable = {};
   local OTIndex = 1;
   local StartAt = 1;
   local StopAt = 1;
   local TextStart = 1;
   local TextStop = 1;
   local TextRemaining = 1;
   local NextSpace = 1;
   local Chunk = "";
   local Iterations = 1;
   local EarlyError = false;

   if ((Text ~= nil) and (Text ~= "")) then
   -- ... Yeah. I'm not even going to begin without checking to make sure Im not getting
   -- invalid data. The big ol crashes I got with my color functions taught me that. ^_^

      -- First, it's time to strip out any extra spaces, ie any more than ONE space at a time.
      while (string.find(Text, "  ") ~= nil) do
         Text = string.gsub(Text, "  ", " ");
      end

      -- Now, what if text consisted of only spaces, for some ungodly reason? Well...
      if (string.len(Text) <= 1) then
         EarlyError = true;
      end

      -- Now, if there is a leading or trailing space, we nix them.
      if EarlyError ~= true then
        TextStart = 1;
        TextStop = string.len(Text);

        if (string.sub(Text, TextStart, TextStart) == " ") then
           TextStart = TextStart+1;
        end

        if (string.sub(Text, TextStop, TextStop) == " ") then
           TextStop = TextStop-1;
        end

        Text = string.sub(Text, TextStart, TextStop);
      end

      -- Finally, on to breaking up the goddamn string.

      OTIndex = 1;
      TextRemaining = string.len(Text);

      while (StartAt <= TextRemaining) and (EarlyError ~= true) do

         -- NextSpace is the index of the next space in the string...
         NextSpace = string.find(Text, " ",StartAt);
         -- if there isn't another space, then StopAt is the length of the rest of the
         -- string, otherwise it's just before the next space...
         if (NextSpace ~= nil) then
            StopAt = (NextSpace - 1);
         else
            StopAt = string.len(Text);
            LetsEnd = true;
         end

         Chunk = string.sub(Text, StartAt, StopAt);
         OutputTable[OTIndex] = Chunk;
         OTIndex = OTIndex + 1;

         StartAt = StopAt + 2;

      end
   else
      OutputTable[1] = "Error: Bad value passed to TextParse!";
   end

   if (EarlyError ~= true) then
      return OutputTable;
   else
      return {"Error: Bad value passed to TextParse!"};
   end
end

--Normal print job.
function DruidBar_Print(msg,r,g,b,frame,id,unknown4th)
	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end

	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if ( frame ) then
		frame:AddMessage(msg,r,g,b,id,unknown4th);
	else
		if ( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b,id,unknown4th);
		end
	end
end

function DruidBar_Toggle(tog, str)
	if tog then DruidBar_Print(str.." off");
		return nil;
	else DruidBar_Print(str.." on");
		return true;
	end
end

function DruidBar_Enable_ChatCommandHandler(text)
	local msg = TextParse(text);
	msg[1] = strlower(msg[1]);
	if msg[1] == "gui" then
		DRUIDBAROptionsFrame_Toggle();
	elseif msg[1] == "on" then
		DruidBarKey.Enabled = true;
		DruidBar_Print("DruidBar is Enabled!",1,1,0);
		DRUIDBAR_FrameSet();
	elseif msg[1] == "off" then
		DruidBarKey.Enabled = nil;
		DruidBar_Print("DruidBar is Disabled!",1,1,0);
		DRUIDBAR_FrameSet();
	elseif msg[1] == "toggle" then
		DruidBarKey.Enabled = DruidBar_Toggle(DruidBarKey.Enabled, "DruidBar is");
		DRUIDBAR_FrameSet();
	elseif msg[1] == "vis" then
		DruidBarKey.Graphics = DruidBar_Toggle(DruidBarKey.Graphics, "DruidBar's visual data is");
		DRUIDBAR_FrameSet();
	elseif msg[1] == "width" and msg[2] and tonumber(msg[2]) then
		DruidBarKey.width = tonumber(msg[2]);
		DruidBar_Print("Width is now set to "..msg[2]);
		DRUIDBAR_FrameSet();
	elseif msg[1] == "height" and msg[2] and tonumber(msg[2]) then
		DruidBarKey.height = tonumber(msg[2]);
		DruidBar_Print("Height is now set to "..msg[2]);
		DRUIDBAR_FrameSet();
	elseif msg[1] == "hide" then
		DruidBarKey.HideInCaster = DruidBar_Toggle(DruidBarKey.HideInCaster, "Hiding bar when in caster form is");
		DRUIDBAR_FrameSet();
	elseif msg[1] == "full" then
		DruidBarKey.HideWhenFull = DruidBar_Toggle(DruidBarKey.HideWhenFull, "Hiding bar when mana is full is");
		DRUIDBAR_FrameSet();
	elseif msg[1] == "lock" then
		DruidBarKey.Lock = DruidBar_Toggle(DruidBarKey.Lock, "Lock feature is");
		DRUIDBAR_FrameSet();
	elseif msg[1] == "replace" then
		DruidBarKey.Replace = DruidBar_Toggle(DruidBarKey.Replace, "Replacing the player frame's mana bar is");
		DRUIDBAR_FrameSet();
	elseif msg[1] == "shift" then
		DruidBarKey.DontShiftBack = DruidBar_Toggle(DruidBarKey.DontShiftBack, "Prevent shifting to human using different forms is");
		DRUIDBAR_FrameSet();
	elseif msg[1] == "player" then
		DruidBarKey.Player = DruidBar_Toggle(DruidBarKey.Player, "Showing the bar below the Player Frame is");
		if DruidBarKey.Player then DruidBarKey.width = 150; DruidBarKey.height = 18; else DruidBarKey.width = 170; DruidBarKey.height = 18; end
		DRUIDBAR_FrameSet();
	elseif msg[1] == "text" then
		if not DruidBarKey.Text then DruidBarKey.Text = 0; DruidBar_Print("Original-Style text on!"); elseif DruidBarKey.Text == 0 then DruidBarKey.Text = 1; DruidBar_Print("New-Style text on!"); elseif DruidBarKey.Text == 1 then DruidBarKey.Text = nil; DruidBar_Print("Text removed."); end
		DRUIDBAR_FrameSet();
	elseif msg[1] == "percent" then
		if not DruidBarKey.Percent then DruidBarKey.Percent = 0; DruidBar_Print("DruidBar will show Raw numbers"); elseif DruidBarKey.Percent == 0 then DruidBarKey.Percent = 1; DruidBar_Print("DruidBar will now show Percentages"); elseif DruidBarKey.Percent == 1 then DruidBarKey.Percent = nil; DruidBar_Print("DruidBar will show both Percentages and Raw numbers"); end
		DRUIDBAR_FrameSet();
	elseif msg[1] == "status" then
		DruidBar_Status();
	elseif msg[1] == "color" then
		if tonumber(msg[3]) then
			if msg[2] == "r" then
				DruidBarKey.color[1] = msg[3];
			elseif msg[2] == "g" then
				DruidBarKey.color[2] = msg[3];
			elseif msg[2] == "b" then
				DruidBarKey.color[3] = msg[3];
			elseif msg[2] == "a" then
				DruidBarKey.color[4] = msg[3];
			elseif tonumber(msg[2]) and tonumber(msg[3]) and tonumber(msg[4]) then
				DruidBarKey.color[1] = tonumber(msg[2]);
				DruidBarKey.color[2] = tonumber(msg[3]);
				DruidBarKey.color[3] = tonumber(msg[4]);
			end
		end
	elseif msg[1] == "debug" then
		DruidBarKey.Debug = DruidBar_Toggle(DruidBarKey.Debug, "Debug options");
		DRUIDBAR_FrameSet();
	elseif msg[1] == "manatex" then
		if msg[2] == "default" then
			DruidBarKey.manatexture = "Interface\\TargetingFrame\\UI-StatusBar";
			DruidBar_Print("Setting mana bar texture to default");
		else
			DruidBarKey.manatexture = msg[2];
			DruidBar_Print("Setting mana bar texture to "..DruidBarKey.manatexture);
		end
		DRUIDBAR_FrameSet();
	elseif msg[1] == "bordertex" then
		if msg[2] == "default" then
			DruidBarKey.bordertexture = "Interface\\Tooltips\\UI-StatusBar-Border";
			DruidBar_Print("Setting border texture to default");
		else
			DruidBarKey.bordertexture = msg[2];
			DruidBar_Print("Setting border texture to "..DruidBarKey.bordertexture);

		end
		DRUIDBAR_FrameSet();
	else
		DRUIDBAROptionsFrame_Toggle();
	end
end

function DruidBar_Status()
	DruidBar_Print("DruidBar Toggle Status:");
	DruidBar_Print("DruidBar's enabled status is "..DruidBar_On(DruidBarKey.Enabled));
	DruidBar_Print("Graphics are "..DruidBar_On(DruidBarKey.Graphics));
	DruidBar_Print("Prevention of shapeshifting to human using other forms is "..DruidBar_On(DruidBarKey.DontShiftBack));
	DruidBar_Print("Hiding when in caster is "..DruidBar_On(DruidBarKey.HideInCaster));
	DruidBar_Print("Hiding when mana is full is "..DruidBar_On(DruidBarKey.HideWhenFull));
	DruidBar_Print("Replacing the Player Frame's mana bar is "..DruidBar_On(DruidBarKey.Replace));
	DruidBar_Print("Showing under the Player Frame is "..DruidBar_On(DruidBarKey.Player));
	DruidBar_Print("The current style of text is "..DruidBar_Text_Style());
	DruidBar_Print("The current display of text is "..DruidBar_Text_Display());
	DruidBar_Print("Debugging is "..DruidBar_On(DruidBarKey.Debug));
end

function DruidBar_On(druidBarKeyValue)
	if druidBarKeyValue then
		return "|CFF00FF00On.|r";
	else
		return "|CFFFF0000Off.|r";
	end
end

function DruidBar_Text_Style()
	if not DruidBarKey.Text then
		return "|CFF888888Off|r";
	elseif DruidBarKey.Text == 1 then
		return "|CFFFFFFFFModern|r";
	else
		return "|CFF00FF00Classic|r";
	end
end

function DruidBar_Text_Display()
	if not DruidBarKey.Percent then
		return "|CFF00FF00Percent and Raw|r";
	elseif DruidBarKey.Percent == 1 then
		return "|CFFFF00FFRaw|r";
	else
		return "|CFF0000FFPercent|r";
	end
end

function DruidBar_MaxManaScript()
	DruidBarKey.maxmana = UnitPowerMax("player", 0);
	DruidBarKey.currentmana = UnitPower("player", 0);
	DruidBarKey.int = intellect;
end

function DruidBar_ShouldBeVisible()
	if (DruidBarKey.HideInCaster and UnitPowerType("player") == 0) then return false; end;
	if (DruidBarKey.HideWhenFull and not (DruidBarKey.currentmana < DruidBarKey.maxmana)) then return false; end;
	return true;
end

function DruidBar_ColorAndStrataAndTexture()
	DruidBarMana:SetStatusBarColor(DruidBarKey.color[1], DruidBarKey.color[2], DruidBarKey.color[3], DruidBarKey.color[4]);
	DruidBarManaBackground:SetVertexColor(DruidBarKey.bgcolor[1],DruidBarKey.bgcolor[2],DruidBarKey.bgcolor[3],DruidBarKey.bgcolor[4]);
	DruidBarBorder:SetVertexColor(DruidBarKey.bordercolor[1],DruidBarKey.bordercolor[2],DruidBarKey.bordercolor[3],DruidBarKey.bordercolor[4]);
	DruidBarMana:SetStatusBarTexture(DruidBarKey.manatexture);
	DruidBarManaBackground:SetTexture(DruidBarKey.manatexture);
	DruidBarBorder:SetTexture(DruidBarKey.bordertexture);
	DruidBarManaBackground:SetDrawLayer(DruidBarKey.bgstrata);
end
