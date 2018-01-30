local Settings = {}
Settings.unit = 10 --set a unit to be ten pixels
Settings.scale = function(val)
    return Settings.unit * val
end
Settings.windowWidth = 400
Settings.windowHeight = 400
Settings.colors = {
    white = {255, 255, 255, 255},
    red = {255, 0, 0, 255},
    blue = {0, 0, 255, 255},
    green = {0, 255, 0, 255}
}
Settings.timestep = 0.1


return Settings
