PipeController = {}
PipeController.__index = PipeController

function PipeController:new()
    local pipeController = {}
    setmetatable(pipeController, PipeController)

    pipeController.list = {}

    pipeController.maxStep = 64
    pipeController.step = 32

    pipeController.speed = 2

    return pipeController
end

function PipeController:create()
    local val = {}
    val.left = width
    val.right = val.left + 16
    val.top = 40 + (20 * math.random(5))
    val.bottom = val.top + 96
    val.ind = #self.list + 1

    self.list[val.ind] = val
end

function PipeController:update()
    for ind, val in pairs(self.list) do
        val.left = val.left - self.speed
        val.right = val.left + 16

        if val.right < 0 then
            self.list[val.ind] = nil
        end
    end

    if self.step == self.maxStep then
        self:create()
        self.step = 0
    end

    self.step = self.step + 1

    self.speed = self.speed + 0.001
end

function PipeController:draw()
    for ind, val in pairs(self.list) do
        love.graphics.rectangle('fill', val.left, 0, 16, val.top)
        love.graphics.rectangle('fill', val.left, val.bottom, 16, height)
    end
end
