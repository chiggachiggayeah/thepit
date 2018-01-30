function Component(systems)
    local components = {
        Drawable = setmetatable({}, {
            __call = function()
                return {
                    pos = {
                        x = 0,
                        y = 0,
                    },
                    width = 1,
                    height = 1,
                    segments = {},
                    draw = function(img)
                    end,
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
                    heading = {
                        x = 1,
                        y = 0
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
                    register = function(entity)
                        systems.PhysicsSystem.register(entity)
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
                    heading = {
                        x = 1,
                        y = 0
                    },
                    rotateHeading = function(heading)
                        local newHeading = {x = 0, y = 1}
                        if heading.x == 0 and heading.y == -1 then
                            newHeading.x = 1
                            newHeading.y = 0
                        elseif heading.x == 1 and heading.y == 0 then
                            newHeading.x = 0
                            newHeading.y = 1
                        elseif heading.x == 0 and heading.y == 1 then
                            newHeading.x = -1
                            newHeading.y = 0
                        else
                            newHeading.x = 0
                            newHeading.y = -1

                        end

                        return newHeading
                    end,

                    register = function(entity)
                        systems.UserInputSystem.register(entity)
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
