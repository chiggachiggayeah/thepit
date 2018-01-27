--types
SNAKE, MONGOOSE, BUSH = "SNAKE", "MONGOOSE", "BUSH"
ENTITY = "ENTITY"
g_types = {SNAKE, MONGOOSE, BUSH}
--systems

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

--rendering template
t = {}
t.colors = {
    white = {"255", "255", "255", "255"} 
}
t[SNAKE] = function(val)
    love.graphics.setColor(t.colors.white)
    love.graphics.rectangle("fill", val.pos.x, val.pos.y, val.width, val.height)
end
--

function _RenderSystem(template)
    local self = _System()
    local registry = {} 

    function self.register(entity)
        table.insert(registry, entity)
    end 
    
    function self.update()
        for i, v in ipairs(registry) do
            for k, fn in pairs(template) do
                if v.is_a(k) then
                    fn(v)
                end
            end
        end
    end

    return self
end

RenderSystem = _RenderSystem(t)
PhysicsSystem = _PhysicsSystem()


--entities
function _Entity(components)
    local self = {}
    self.types = {ENTITY}
    
    self.override = function(overrides)
        for k, v in pairs(overrides) do
            self[k] = v
        end
    end

    self.is_a = function(g_type)
        local result = false
        for i, v in ipairs(self.types) do
            if(v == g_type) then
                result = true
                return result
            end
        end

        return result
    end

    for i, c in ipairs(components) do
        print("Component is: " .. tostring(c))
        local component = c()
        component.register(self)
        for k, v in pairs(component) do
            if self[k] == nil then
                self[k] = v
            end
        end
    end


    return self
end


Drawable = {}
setmetatable(Drawable, {
    __call = function()
        return {
            pos = {
                x = 0,
                y = 0,
            },
            width = 50,
            height = 50,
            register = function(entity)
                RenderSystem.register(entity)
            end
        }
    end
})

function Snake(overrides)
    local self = _Entity({Drawable})

    --add all the component elements to self
    --register with relevant systems
    
    table.insert(self.types, SNAKE)

    if overrides ~= nil then
        self.override(overrides)
    end

    return self
end

function Mongoose(...)
    local self = _Entity(Drawable)

    table.insert(self.is_a, MONGOOSE)

    return self
end
--end entities

--components
--adding a component to an entity, should then let the relevant systems know about that component
function _Component()
    local self = {}
    
    function self.new()
        local o = {}
    end
end

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
})

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
})

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
})



Perishable = setmetatable({}, {
    __call = function()
        return {
            register = function()
            end
        }
    end
})
--end components

--systems
--collision system
--what about an ai system?
--physics system? for time steps and updating the world
--render system

--return system instances from various files so that you don't allow making additional systems


function love.load()
    snake = Snake()
    snake2 = Snake({pos = {x = 100, y = 100}})
end

function love.update(dt)
end

function love.draw()
    --love.graphics.print("Hello world!", 400, 300) 
    RenderSystem.update()
end


