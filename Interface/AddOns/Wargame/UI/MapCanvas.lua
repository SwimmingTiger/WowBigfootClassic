---@type ns
local ADDON_NAME, ns = ...
local L = ns.L

---@class NeteaseWargameUIMapCanvas
local MapCanvas = ns.Addon:NewClass('UI.MapCanvas', 'Frame')

function MapCanvas:Constructor()
    self.detailLayerPool = CreateFramePool('Frame', self, 'MapCanvasDetailLayerTemplate')
    self.defaultScale = 0.525 -- 地图材质只能用啥欧方设置尺寸
end

function MapCanvas:SetMapID(mapID)
    self:Clear()

    local layers = C_Map.GetMapArtLayers(mapID)
    for layerIndex, layerInfo in ipairs(layers) do
        local detailLayer = self.detailLayerPool:Acquire()
        detailLayer:SetAllPoints(self)
        detailLayer:SetScale(self.defaultScale)
        detailLayer:SetMapAndLayer(mapID, layerIndex)
        detailLayer:SetGlobalAlpha(1)
        detailLayer:Raise()
        detailLayer:Show()
    end
end

function MapCanvas:Clear()
    if self.detailLayerPool then
        self.detailLayerPool:ReleaseAll()
    end
end
