ClassicBullet = {}
ClassicBullet.new = function()

  local self = {}
  
  self.image = nil
  self.damage = 1
  self.name = "ClassicBullet"
  self.x = 0
  self.y = 0
  self.speed = 70
  self.vx = 0
  self.vy = 0
  self.isDead = false
  

  self.init = function()
    self.image = love.graphics.newQuad(32,0,8,8,GB.width,GB.height)
  end

  self.goToPlayer = function()
    local dir = dirToPlayer(self.x,self.y)
    local x,y = normalize(dir.x,dir.y)
    self.vx = self.speed * x
    self.vy = self.speed * y
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