function Component(systems)
    local components = {
        Drawable = setmetatable({}, {
            __call = function()
                return {
                    pos = {
                        x = 0,
                        y = 0,
                    },
                    width = 50,
                    height = 50,
                    register = function(entity)
                        systems.RenderSystem.register(entity)
                    end
                }
            end
        }),

    --function _Component()
    --    local self = {}
    --    
    --    function self.new()
    --        local o = {}
    --    end
    --end

        Movable = setmetatable({}, {
            __call = function()
                return {
                    pos = {
                        x = 0,
                        y = 0,
                    },

                    move = function()
                    end,

                    register = function()
                    end
                }
            end
        }),

        Collidable = setmetatable({}, {
            __call = function()
                return {
                    pos = {
                        x = 0,
                        y = 0,
                    },
                    register = function()
                    end
                }
            end
        }),

        Controllable = setmetatable({},{
            __call = function()
                return {
                    pos = {
                        x = 0,
                        y = 0,
                    },
                    register = function()
                    end

                }
            end
        }),



        Perishable = setmetatable({}, {
            __call = function()
                return {
                    register = function()
                    end
                }
            end
        }),
    }
    --end components

    return components
end

return Component
