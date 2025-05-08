Hypercircle = Circle:extend()

function Hypercircle: new(x, y, radius, lineWidth, outerRadius)
  Hypercircle.super.new(self, x, y, radius)
  self.lineWidth = lineWidth or 1
  self.outerRadius = outerRadius
end

function Hypercircle:update(dt)
  -- Update logic for the hypercircle can be added here
end

function Hypercircle:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", self.x, self.y, self.radius)
  love.graphics.setLineWidth(self.lineWidth)
  love.graphics.circle("line", self.x, self.y, self.outerRadius)
end