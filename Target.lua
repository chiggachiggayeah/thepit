local g_types = require "GTypes"
local Settings = require "Settings"
local utils = require "utils"

function _Target(Entity)
    return function(overrides)
        local self = Entity({"Drawable", "Controllable"})
        local numSegments = 8

        self.types[g_types.TARGET] = true
        self.height = 1
        self.width = 1
        self.segments = [] 

        if overrides ~= nil then
            self.override(overrides)
        end

        for i = 1, numSegments, 1 do
            table.insert(self.segments, {x = self.pos.x + i, y = self.pos.y})
        end

        -- have to trigger win if they're fully "on"
        -- called by physics system?
        function self.covering(entity_list)
        end
    end
end
