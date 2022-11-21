<a href="https://www.curseforge.com/wow/addons/krowis-world-map-buttons" alt="Curseforge">
  <img src="https://img.shields.io/badge/Curseforge-Krowi's%20World%20Map%20Buttons-orange" />
</a>

## Purpose
This library was created to make adding buttons to the world map easier and less dependant on other addons.
Using this library will add a button to the top right of the map window from right to left in the order the addons are loaded.
When yours or other addon's buttons are hidden, the rest will shift to the right to fill the gap dynamically.

Supports both Retail and Wrath Classic. Classic and TBC Classic are not verified. See the [important](#important) section for version specific changes.

See the examples below on how to use the library.

## Important
### Retail
`frameStrata="HIGH"`
### Wrath Classic
`frameStrata="TOOLTIP"`

There is an additional change for Wrath Classic when ElvUI is installed and the smaller world map is enabled. This is because ElvUI resets the `FrameStrata` to `HIGH` which would hide the button behind the map itself. I'm not sure if I should incorporate this in the library itself or let each addon handle this on its own.
```lua
local engine = unpack(ElvUI);
local worldMapModule = engine:GetModule("WorldMap");
hooksecurefunc(worldMapModule, "SetSmallWorldMap", function()
    addon.GUI.WorldMapButton:SetFrameStrata("TOOLTIP");
end);
```

## Adding the button to the world map
```lua
local addonName, addon = ...;
local gui = addon.GUI;
gui.WorldMapButton = {};
local worldMapButton = gui.WorldMapButton;

addon.WorldMapButtons = LibStub("Krowi_WorldMapButtons-1.4"); -- Global world map buttons object

function worldMapButton.Load()
    worldMapButton = addon.WorldMapButtons:Add("KrowiAF_WorldMapButton_Template", "BUTTON");
    if addon.IsWrathClassic() then
        worldMapButton:SetFrameStrata("TOOLTIP");
    end
    addon.GUI.WorldMapButton = worldMapButton;
end
```

## Example Mixin
```lua
KrowiAF_WorldMapButtonMixin = {};

function KrowiAF_WorldMapButtonMixin:OnLoad()

end

function KrowiAF_WorldMapButtonMixin:OnMouseDown(button)

end

function KrowiAF_WorldMapButtonMixin:OnMouseUp()

end

function KrowiAF_WorldMapButtonMixin:OnClick()

end

function KrowiAF_WorldMapButtonMixin:OnEnter()

end

function KrowiAF_WorldMapButtonMixin:OnHide()

end

function KrowiAF_WorldMapButtonMixin:Refresh()
  -- Below functions should be called here
  -- self:Enable(), self:Disable(), self:Show(), self:Hide()
  -- Refresh is called by the system if you open the world map or change maps
end
```

## Example Template
```xml
<Ui>
    <Script file="WorldMapButton.lua"/>
    <Script file="WorldMapButtonMixin.lua"/>

	<Button name="KrowiAF_WorldMapButton_Template" frameStrata="HIGH" mixin="KrowiAF_WorldMapButtonMixin" motionScriptsWhileDisabled="true" virtual="true">
		<Size x="32" y="32"/>
		<Layers>
			<Layer level="BACKGROUND" textureSubLevel="-1">
				<Texture atlas="MapCornerShadow-Right" useAtlasSize="true" hidden="true">
					<Anchors>
						<Anchor point="TOPRIGHT" x="4" y="1"/>
					</Anchors>
					<TexCoords left="0" right="1" top="1" bottom="0"/>
				</Texture>
			</Layer>
			<Layer level="BACKGROUND">
				<Texture parentKey="Background" file="Interface\Minimap\UI-Minimap-Background">
					<Size x="25" y="25"/>
					<Anchors>
						<Anchor point="TOPLEFT" x="2" y="-4"/>
					</Anchors>
				</Texture>
			</Layer>
			<Layer level="ARTWORK">
				<Texture parentKey="Icon" file="Interface\AchievementFrame\UI-Achievement-Progressive-Shield-NoPoints">
					<Size x="20" y="20"/>
					<Anchors>
						<Anchor point="TOPLEFT" x="6" y="-6"/>
					</Anchors>
					<TexCoords left="0.0625" right="0.59375" top="0.09375" bottom="0.625"/>
				</Texture>
			</Layer>
			<Layer level="OVERLAY">
				<Texture parentKey="IconOverlay" hidden="true">
					<Anchors>
						<Anchor point="TOPLEFT" relativeKey="$parent.Icon"/>
						<Anchor point="BOTTOMRIGHT" relativeKey="$parent.Icon"/>
					</Anchors>
					<Color r="0.0" g="0.0" b="0.0" a="0.5"/>
				</Texture>
			</Layer>
			<Layer level="OVERLAY" textureSubLevel="1">
				<Texture parentKey="Border" file="Interface\Minimap\MiniMap-TrackingBorder">
					<Size x="54" y="54"/>
					<Anchors>
						<Anchor point="TOPLEFT"/>
					</Anchors>
				</Texture>
			</Layer>
			<Layer level="OVERLAY" textureSubLevel="2">
				<Texture parentKey="ActiveTexture" file="Interface\Minimap\UI-Minimap-ZoomButton-Toggle" alphaMode="ADD" hidden="true" setAllPoints="true"/>
			</Layer>			
		</Layers>
		<Frames>
			<Frame parentKey="DropDown" inherits="UIDropDownMenuTemplate" clampedToScreen="true" hidden="true"/>
		</Frames>
		<HighlightTexture alphaMode="ADD" file="Interface\Minimap\UI-Minimap-ZoomButton-Highlight"/>
		<Scripts>
			<OnLoad method="OnLoad"/>
			<OnMouseDown method="OnMouseDown"/>
			<OnMouseUp method="OnMouseUp"/>
			<OnClick method="OnClick"/>
			<OnEnter method="OnEnter"/>
			<OnLeave function="GameTooltip_Hide"/>
			<OnHide method="OnHide"/>
		</Scripts>
	</Button>
</Ui>
```
