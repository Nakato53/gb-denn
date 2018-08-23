BlasterBullet = {}
BlasterBullet.new = function()

  local self = {}
  
  self.image = nil
  self.damage = 1
  self.name = "BlasterBullet"
  self.x = 0
  self.y = 0
  self.vx = 300
  self.vy = 0
  self.isDead = false

  self.init = function()
    self.image = love.graphics.newQuad(24,2,6,4,GB.width,GB.height)
  end

  self.update = function(dt)
    self.x = self.x + self.vx*dt
    self.y = self.y + self.vy*dt
    if(outofscreen(self.x, self.y)) then
      self.isDead = true
    end
  end
  
  self.draw = function()
    love.graphics.draw( GB.sprite, self.image, self.x,self.y)
  end


  self.init()
  return self
  
end

BlasterBullet.newShot = function()
  local self = {}
  
  self.image = nil
  self.damage = 1
  self.name = "BlasterBulletShot"
  self.x = 0
  self.y = 0
  self.vx = 1
  self.vy = 0
  self.isDead = false

  self.init = function()
    self.image = love.graphics.newQuad(24,2,6,4,GB.width,GB.height)
    self.vx = love.math.random(-20,5)
    self.vy = love.math.random(-75,-40)
  end

  self.update = function(dt)
    self.vy = self.vy + GRAVITY
    self.x = self.x + self.vx*dt
    self.y = self.y + self.vy*dt
    if(outofscreen(self.x, self.y)) then
      self.isDead = true
    end
  end
  
  self.draw = function()
    GB.setGBColor(3)
    love.graphics.draw( GB.sprite, GB.pixel, self.x,self.y)
    GB.resetGBColor()
  end


  self.init()
  return self
end