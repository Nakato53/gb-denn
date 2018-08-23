BigShip = {}
BigShip.new = function()
  local self = {}
  self.image = nil
  self.trail1 = nil
  self.trail2 = nil
  self.x = 0
  self.y = 0
  self.vx = 1
  self.speed = 5
  self.initSpeed = 5
  

  self.init = function()
   self.image = love.graphics.newQuad(0,64,50,25,GB.width,GB.height)
   local imagesTrails = 	{
		love.graphics.newQuad(56,64,10,5,GB.width,GB.height),
		love.graphics.newQuad(72,64,10,5,GB.width,GB.height),
		love.graphics.newQuad(88,64,10,5,GB.width,GB.height)
	  }
    self.trail1 = Animation.new( imagesTrails, 0.2)
    self.trail2 = Animation.new( imagesTrails, 0.2)
    self.trail2.currentFrame = 2
    
  end
  
  self.update = function(dt)  
    
    self.trail1.update(dt)
    self.trail2.update(dt)
  end
  
  self.draw = function()
    
    love.graphics.draw( GB.sprite, self.image, self.x, self.y)
    love.graphics.draw( GB.sprite, self.trail1.getFrame(), self.x-8,self.y )
    love.graphics.draw( GB.sprite, self.trail2.getFrame(), self.x-8,self.y + 5)
  end

  self.init()
  return self
end