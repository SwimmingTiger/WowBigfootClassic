local myname, ns = ...

local Base = {
    Initialize = function() end,
    __get = {},
}
ns.Class = function(def)
    local class = def or {}
    -- avoid needing to care about rawget later:
    class.__get = class.__get or {}
    local class_meta = {
        __index = function(self, index)
            local class_walked = class
            repeat
                local val = rawget(class_walked, index)
                if val ~= nil then return val end
                if class_walked.__get[index] then return class_walked.__get[index](self) end
                class_walked = class_walked.__parent
            until class_walked == nil
        end,
    }
    setmetatable(class, {
        __call = function(_, ...)
            local self = {}
            setmetatable(self, class_meta)
            self:Initialize(...)
            return self
        end,
        -- inheritance, this is it:
        __index = def.__parent or Base,
    })

    return class
end
