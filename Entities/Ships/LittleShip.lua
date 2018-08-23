LittleShip = {}
LittleShip.new = function()
  local self = {}
  self.image = nil
  self.trail = nil
  self.x = 0
  self.y = 0
  self.vx = 1
  self.speed = 5
  self.initSpeed = 5
  

  self.init = function()
   self.image = love.graphics.newQuad(24,32,4,3,GB.width,GB.height)
   local imagesTrails = 	{
		love.graphics.newQuad(32,32,8,8,GB.width,GB.height),
		love.graphics.newQuad(40,32,8,8,GB.width,GB.height),
		love.graphics.newQuad(48,32,8,8,GB.width,GB.height)
	  }
    self.trail = Animation.new( imagesTrails, 0.2)
    self.trail.currentFrame = math.floor(love.math.random(1,3))
    self.x = math.floor(love.math.random(-20,160))
    self.y = math.floor(love.math.random(1,144))
    self.speed = math.floor(love.math.random(self.initSpeed/2,self.initSpeed*2))
  end
  
  self.update = function(dt)  
    self.x = self.x + self.speed*dt
    if(self.x > 180) then
      self.x = math.floor(love.math.random(-40,-10))
      self.y = math.floor(love.math.random(1,144))
      self.speed = math.floor(love.math.random(self.initSpeed/2,self.initSpeed*2))
    end
    self.trail.update(dt)
  end
  
  self.draw = function()
    love.graphics.draw( GB.sprite, self.image, self.x, self.y)
    love.graphics.draw( GB.sprite, self.trail.getFrame(), self.x-8,self.y + 1)
  end

  self.init()
  return self
end