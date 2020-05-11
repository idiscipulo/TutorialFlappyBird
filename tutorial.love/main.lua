-- require files
require('src/player')
require('src/pipecontroller')

-- load function
function love.load()
    -- set dimensions
    width = 300
    height = 300

    -- create screen
    love.window.setMode(width, height, {vsync = true, fullscreen = false})

    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set random seed
    love.math.setRandomSeed(os.time())

    -- variable for input
    spacePressed = false

    -- create player
    player = Player:new()

    -- create pipe controller
    pipecontroller = PipeController:new()

    deathStop = 2

    -- set playing state
    state = 'menu'
end

function love.update()
    if state == 'play' then
        player:update()
        pipecontroller:update()

        for ind, val in pairs(pipecontroller.list) do
            if val.left < player.right and player.left < val.right then
                if val.top < player.top and player.bottom < val.bottom then
                    -- success
                else
                    state = 'death'
                    love.graphics.setColor(1, 0, 0, 1)
                    spacePressed = false
                end
            end
        end
    elseif state == 'death' then
        deathStop = deathStop - 0.1
        if deathStop <= 0 then
            love.graphics.setColor(1, 1, 1, 1)
            deathStop = 2
            state = 'menu'
        end
    elseif state == 'menu' then
        if spacePressed then
            state = 'play'
            pipecontroller.list = {}
        end
    end
end

function love.draw()
    -- clear the canvas
    love.graphics.clear()

    -- draw the player
    player:draw()

    -- draw the pipes
    pipecontroller:draw()
end

function love.keypressed(key)
    if key == 'escape' then -- escape key
        -- quit
        love.event.push('quit')
    elseif key == 'space' then -- space key
        -- set input variable to true
        spacePressed = true
    end
end