SuperGunBullet = {}
SuperGunBullet.new = function()

  local self = {}
  
  self.images = {}
  self.selectedImage = 1
  self.damage = 0.2
  self.name = "SuperGunBullet"
  self.x = 0
  self.y = 0
  self.speed = 300
  self.vx = 0
  self.vy = 0
  self.isDead = false
  self.r = 0

  self.init = function()
    self.images = {
      {
        image = love.graphics.newQuad(24,2,6,4,GB.width,GB.height),
        center = { 
          x = 3,
          y = 2
        }
      },
      {
        image = love.graphics.newQuad(24,3,5,2,GB.width,GB.height),
        center = { 
          x = 2,
          y = 2
        }
      },
      {
        image = love.graphics.newQuad(24,3,5,1,GB.width,GB.height),
        center = { 
          x = 2,
          y = 1
        }
      }
    }
    
  end


  self.update = function(dt)
    self.x = self.x + self.vx*dt
    self.y = self.y + self.vy*dt
    if(outofscreen(self.x, self.y)) then
      self.isDead = true
    end
  end
  
  self.draw = function()
    love.graphics.draw( GB.sprite, self.images[self.selectedImage].image, self.x,self.y, self.r,1,1, self.images[self.selectedImage].center.x,self.images[self.selectedImage].center.y)
  end


  self.init()
  return self
  
end