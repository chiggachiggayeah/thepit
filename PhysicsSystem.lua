local _System = require "System"

function _PhysicsSystem()
    local self = _System()
    local registry = {}

    function self.register(entity)
        table.insert(registry, entity)  
    end

    function self.update()
        for i, v in registry do
        end
    end

    return self
end

return _PhysicsSystem()


