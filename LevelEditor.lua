local Settings = require "Settings"

function _LevelEditor()
    local self = {}
    local BUFSIZE = 2^13
    function self.load(levelName)
        local f = assert(io.open(levelName, 'r'))
        
        local lines, read = f:read(BUFSIZE, '*line')
        if not lines then then
            return false
        end

        --keep finding symbol elements

        f:close()
    end

    return self
end

