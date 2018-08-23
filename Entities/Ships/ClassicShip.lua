ClassicShip = {}
ClassicShip.new = function()
  local self = {}
  self.image = nil
  self.trail = nil
  self.x = 0
  self.y = 0
  self.speed = -5
  self.initSpeed = -5
  self.touched = 0
  self.isDead = false
  self.score = 10
  self.hp = 1
  self.fireRate = 25
  self.elapsedFire = 0
  

  self.init = function()
    self.elapsedFire = love.math.random(0,20)
    self.image = love.graphics.newQuad(16,0,8,8,GB.width,GB.height)
    local trailFrames = 	{
      love.graphics.newQuad(0,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(8,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(16,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(24,40,8,8,GB.width,GB.height)
    }
	  self.trail = Animation.new( trailFrames, 0.2)

    self.x = math.floor(love.math.random(-20,160))
    self.y = math.floor(love.math.random(1,144))
    self.speed = math.floor(love.math.random(self.initSpeed/2,self.initSpeed*2))
  end


  self.takeDamage = function(damage)
    self.hp = self.hp - damage
    if(self.hp <= 0) then
      self.isDead  = true
      ShakeManager.startShake(0.2,1)
      player.score = player.score + math.floor(player.multiplier*self.score)
        for z=1,3 do
          local exploScale = NormalShipExplosion.new()
          exploScale.setRandomFrame()
          exploScale.x = self.x-3 + love.math.random(0,10)
          exploScale.y = self.y-3 + love.math.random(0,10)
          table.insert(elements,exploScale)
          
        end

    end
  end
  

  self.checkCollision=function(x,y)
    if( x >= self.x 
        and x <= self.x+8 
        and y <= self.y+8
        and y >= self.y-2
      ) then
      return true
    end
    return false
  end

  self.fire = function()
    local bullet = ClassicBullet.new()
    bullet.x = self.x - 4
    bullet.y = self.y  
    bullet.goToPlayer()
    bullet.isEnnemy = 1
    table.insert(bullets,bullet)
  end

  self.update = function(dt)  
    self.elapsedFire =     self.elapsedFire+dt
    if(self.elapsedFire > self.fireRate) then
      self.elapsedFire = 0
      self.fire()
    end
    self.touched = self.touched - dt
    self.x = self.x + self.speed*-1*dt
    if(self.x < -20 ) then
      self.isDead = true
    end
    self.trail.update(dt)
  end
  
  self.draw = function()
    if(self.touched > 0 and totalFrame % 3 == 0 )then
      
    else
      love.graphics.draw( GB.sprite, self.image, self.x, self.y)
      love.graphics.draw( GB.sprite, self.trail.getFrame(), self.x+8,self.y)
    end

  end

  self.init()
  return self
end

ShipManager.add("Classic",ClassicShip.new)