Player = {}
Player.__index = Player

function Player:new()
    local player = {}
    setmetatable(player, Player)

    player.left = 32
    player.right = player.left + 16
    player.top = 142
    player.bottom = player.top + 16

    player.vel = 0
    player.accel = 0.4

    return player
end

function Player:update()
    -- if input
    if spacePressed then
        self.vel = -6
        spacePressed = false
    end

    self.top = self.top + self.vel + 0.5 * (self.accel ^ 2)
    self.bottom = self.top + 16

    self.top = math.min(284, math.max(0, self.top))

    self.vel = math.min(5, self.vel + self.accel)
end

function Player:draw()
    love.graphics.rectangle('fill', self.left, self.top, 16, 16)
end