
function _Entity(components)
        
    return function(comps)
        local self = {}
        self.types = {}
        
        self.override = function(overrides)
            for k, v in pairs(overrides) do
                self[k] = v
            end
        end

        self.is_a = function(g_type)
            local result = false
            if self.types[g_type] then
                result = true
            end
            --for i, v in ipairs(self.types) do
            --    if(v == g_type) then
            --        result = true
            --        return result
            --    end
            --end

            return result
        end

        for i, c in ipairs(comps) do
            print("Component is: " .. tostring(c))
            local component = components[c]()
            component.register(self)
            for k, v in pairs(component) do
                if self[k] == nil and k ~= "register" then
                    self[k] = v
                end
            end
        end

        return self
    end
end

return _Entity

