local g_types = require "GTypes"

function _Mongoose(Entity)
    return function(overrides)
        local self = Entity({"Drawable"}) 

        self.types[g_types.MONGOOSE] = true

        if overrides ~= nil then
            self.override(overrides)
        end

        return self
    end
end

return _Mongoose

