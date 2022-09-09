local AddonName, SAO = ...

-- List of classes
-- Each class defines its own stuff in their <classname>.lua
SAO.Class = {}

-- Event receiver
function SAO.InvokeClassEvent(self, event, ...)
    if (self.CurrentClass and self.CurrentClass[event]) then
        self.CurrentClass[event](self, ...);
    end
end
