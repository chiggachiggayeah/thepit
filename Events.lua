local Events = function()
    local self = {}
    
    self.WIN = 'WIN'
    self.SCREENWRAP = 'SCREENWRAP'

    function self.load()
        local winFunction = function()
            print("You Win!")
        end

        love.handlers['WIN'] = winFunction
    end

    return self
end

return Events()
