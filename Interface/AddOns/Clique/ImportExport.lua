local addonName, addon = ...

local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")

function addon:GetExportString()
    local data = addon.db.profile.bindings
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForPrint(compressed)

    return string.format("CL01:%s", encoded)
end

function addon:DecodeExportString(text)
    local header = string.sub(text, 1, 5)
    if header ~= "CL01:" then return end

    local payload = string.sub(text, 6, string.len(text))
    local decoded = LibDeflate:DecodeForPrint(payload)
    if not decoded then return end
    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
    local success, data = LibSerialize:Deserialize(decompressed)
    if not success then return end
    return data
end
