_ShakeManager = {}
_ShakeManager.new = function()
  local self = {}
  
  self.t = 0
  self.shakeDuration = 0
  self.shakeMagnitude = 0
  self.init = function()

  end

  self.startShake = function(duration, magnitude)
    self.t, self.shakeDuration, self.shakeMagnitude = 0, duration or 1, magnitude or 5
  end

  self.update = function(dt)
    if self.t < self.shakeDuration then
      self.t = self.t + dt
    end
  end

  self.apply = function()
    if self.t < self.shakeDuration then
      local dx = love.math.random(-self.shakeMagnitude, self.shakeMagnitude)
      local dy = love.math.random(-self.shakeMagnitude, self.shakeMagnitude)
      love.graphics.translate(dx, dy)
    end
  end

  self.reset = function()
      love.graphics.translate(0, 0)
  end

  self.init()
  return self
end
ShakeManager = _ShakeManager.new()