NormalShipExplosion = {}
NormalShipExplosion.new = function()
  local self = {}
  self.animation = nil
  self.rotation = 0
  self.isDead = false
  self.x = 0
  self.y = 0
  self.scale = 1
  
  self.setRandomFrame = function()
    self.currentFrame = math.floor(love.math.random(1,7))
  end

  self.init = function()
    local frames = 	{
      love.graphics.newQuad(40,0,16,16,GB.width,GB.height),
      love.graphics.newQuad(56,0,16,16,GB.width,GB.height),
      love.graphics.newQuad(72,0,16,16,GB.width,GB.height),
      love.graphics.newQuad(88,0,16,16,GB.width,GB.height),
      love.graphics.newQuad(104,0,16,16,GB.width,GB.height),
      love.graphics.newQuad(120,0,16,16,GB.width,GB.height),
      love.graphics.newQuad(136,0,16,16,GB.width,GB.height),
      love.graphics.newQuad(136,0,16,16,GB.width,GB.height)
    }

    local rnd = love.math.random(0,100)
    if(rnd < 25) then self.rotation = 0 end
    if(rnd >= 25 and rnd < 50) then self.rotation = math.pi/2 end
    if(rnd >= 50 and rnd < 75) then self.rotation = math.pi end
    if(rnd > 75) then self.rotation = -math.pi/2 end
    
    self.animation = Animation.new( frames, 0.1)
    
  end
  
  self.update = function(dt)  
    self.animation.update(dt)
    if(self.animation.currentFrame == 8) then
      self.isDead = true
    end
  end
  
  self.draw = function()
    love.graphics.draw( GB.sprite, self.animation.getFrame(), self.x,self.y,self.rotation,self.scale,self.scale,8,8)
  end

  self.init()
  return self
end

