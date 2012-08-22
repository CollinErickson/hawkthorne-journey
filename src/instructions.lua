local Gamestate = require 'vendor/gamestate'
local window = require 'window'
local camera = require 'camera'
local state = Gamestate.new()


function state:init()
    self.background = love.graphics.newImage("images/pause.png")
    self.instructions = {
        { 'UP',          'W / UP ARROW'},
        { 'DOWN',        'S / DOWN ARROW'},
        { 'LEFT',        'A / LEFT ARROW'},
        { 'RIGHT',       'D / RIGHT ARROW'},
        { 'JUMP',        'SPACEBAR'},
        { 'ACTION',      'SHIFT'},
    }

    -- The X coordinates of the columns
    self.left_column = 103
    self.right_column = 170
    -- The Y coordinate of the top key
    self.top = 60
    -- Vertical spacing between keys
    self.spacing = 27
end

function state:enter(previous)
    self.music = love.audio.play("audio/daybreak.ogg", "stream", true)

    camera:setPosition(0, 0)
    self.previous = previous
end

function state:leave()
    love.audio.stop(self.music)
end

function state:keypressed(button)
    if button.start or button.b or button.b then
        Gamestate.switch(self.previous)
        return
    end
end

function state:draw()
    love.graphics.draw(self.background)
    love.graphics.setColor(0, 0, 0)

    for n,instruction in ipairs(self.instructions) do
        local y = self.top + self.spacing * (n - 1)
        -- Draw action
        love.graphics.print(instruction[1], self.left_column, y)
        -- And draw associated key
        love.graphics.print('- ' .. instruction[2], self.right_column, y)
    end

    love.graphics.setColor(255, 255, 255)
end

return state
