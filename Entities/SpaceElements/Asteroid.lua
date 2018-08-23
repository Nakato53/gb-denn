Asteroid = {}
Asteroid.new = function()
  local self = {}
  self.animation = nil
  self.x = 0
  self.y = 0
  self.rotation = 0
  self.vx = -1
  self.vy = love.math.random(-1,1)
  self.isDead = false
  self.initSpeed = 5
  self.speed = 5
  self.touched = 0
  self.score = 10
  self.hp = 3
  

  self.init = function()
    local decalY = math.floor(love.math.random(0,100)) > 50 and 16 or 0
    self.vx = love.math.random(-1,1)
    local frames = 	{
      love.graphics.newQuad(56,72+decalY,16,16,GB.width,GB.height),
      love.graphics.newQuad(72,72+decalY,16,16,GB.width,GB.height),
      love.graphics.newQuad(88,72+decalY,16,16,GB.width,GB.height),
      love.graphics.newQuad(104,72+decalY,16,16,GB.width,GB.height),
      love.graphics.newQuad(120,72+decalY,16,16,GB.width,GB.height),
      love.graphics.newQuad(136,72+decalY,16,16,GB.width,GB.height),
    }
    self.animation = Animation.new( frames, love.math.random(0.2,1))
  end

  self.takeDamage = function(damage)
    self.hp = self.hp - damage
    if(self.hp <= 0) then
      self.isDead  = true
        player.score = player.score + math.floor(player.multiplier*self.score)
        for z=1,7 do
          local exploScale = NormalShipExplosion.new()
          exploScale.setRandomFrame()
          exploScale.x = self.x+3 + love.math.random(0,10)
          exploScale.y = self.y+3 + love.math.random(0,10)
          table.insert(elements,exploScale)
        end

    end
  end
  

  self.checkCollision=function(x,y)
    if(distanceFrom(self.x, self.y, x, y) < 6) then
      return true
    end
    return false
  end


  self.update = function(dt)  
    self.touched = self.touched - dt
    self.animation.update(dt)
    self.x = self.x + self.vx*self.speed*dt
    self.y = self.y + self.vy*self.speed*dt
    if(self.x < -20 ) then
      self.isDead = true
    end
  end
  
  self.draw = function()
    if(self.touched > 0 and totalFrame % 3 == 0 )then
      
    else
      love.graphics.draw( GB.sprite, self.animation.getFrame(), self.x,self.y,0,1,1,8,8)
    end
  end

  self.init()
  return self
end