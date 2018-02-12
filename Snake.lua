local g_types = require "GTypes"
local Settings = require "Settings"
local utils = require "utils"

function _Snake(Entity)
    return function(overrides)
        local self = Entity({"Drawable", "Collidable", "Controllable"})
        local numSegments = 9
        --add all the component elements to self
        --register with relevant systems
        
        --table.insert(self.types, SNAKE)
        self.types[g_types.SNAKE] = true

        self.height = 1
        self.width = 1

        self.previous = {}

        if overrides ~= nil then
            self.override(overrides)
        end

        -- init segments based on pos argument
        for i = 1, numSegments, 1 do
            table.insert(self.segments, {x = self.pos.x + i, y = self.pos.y})
        end

        --print("Pos is: "..tostring(self.pos.x)..", "..tostring(self.pos.y)) 
        function self.revise()
            -- the previous heading wasn't a good one

            -- reset segments
            self.segments = utils.clone(self.previous) 

            local clonedPos = utils.clone(self.pos)
            self.backup()

            --detect a screen wrap
            if math.abs(self.pos.x - clonedPos.x) == Settings.windowWidth / Settings.unit then
                self.heading = self.rotateHeading(self.heading)
            elseif math.abs(self.pos.y - clonedPos.y) == Settings.windowHeight / Settings.unit then
                self.heading = self.rotateHeading(self.heading)
            else
                -- restore pos
                self.pos = clonedPos
                 --pick a new heading
                self.heading = self.rotateHeading(self.heading)
            end
        end
        
        function self.backup()
            self.segments = utils.clone(self.previous)
        end

        function self.step()
            local oldSegments = utils.clone(self.segments)
            self.previous = oldSegments
            -- move the segments
            self.segments[1].x = self.segments[1].x + self.heading.x
            self.segments[1].y = self.segments[1].y + self.heading.y

            for i = 2, table.getn(self.segments), 1 do
               self.segments[i].x = oldSegments[i - 1].x 
               self.segments[i].y = oldSegments[i - 1].y
            end
            
            self.pos = utils.clone(self.segments[1])
        end

        function self.draw()
            love.graphics.setColor(Settings.colors.white)
            --love.graphics.rectangle("fill", val.pos.x, val.pos.y, val.width, val.height)
    
            for i, v in ipairs(self.segments) do
                love.graphics.rectangle("fill", Settings.scale(v.x), Settings.scale(v.y), Settings.scale(self.width), Settings.scale(self.height))
            end
        end

        return self
    end
end

return _Snake

