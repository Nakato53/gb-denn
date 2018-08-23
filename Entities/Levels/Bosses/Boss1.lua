Boss1 = {}
Boss1.new = function()
  local self = {}
  
  self.image = nil
  self.trail = nil
  self.x = 162
  self.y = 70
  self.speed = -5
  self.initSpeed = -5
  self.touched = 0
  self.isDead = false
  self.score = 300
  self.hp = 200
  self.name = "Bomber MK-IV"
  
  self.currentPhase = 0
  self.elapsedTime = 0

  self.init = function()
    self.image =  love.graphics.newQuad(16,96,20,33,GB.width,GB.height)
    self.x = 162
    self.y = 60
  end

  self.update = function(dt)
    if(self.currentPhase == 0) then
      self.x = self.x - 10*dt
      if(self.x < 100) then
        self.x = 100
        self.currentPhase = 1
      end
    end
  end

  self.draw = function()
    if(self.touched > 0 and totalFrame % 3 == 0 )then
      
    else
      love.graphics.draw( GB.sprite, self.image, self.x, self.y)
    end
  end

  self.init()
  return self

end
