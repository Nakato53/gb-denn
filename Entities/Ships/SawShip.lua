SawShip = {}
SawShip.new = function()
  local self = {}
  self.shipAnimation = nil
  self.trail = nil
  self.x = 0
  self.y = 0
  self.speed = -5
  self.initSpeed = -10
  self.isDead = false
  self.touched = 0
  self.scaleExplo = 1
  self.score = 50
  self.hp = 10

  self.init = function()

    local shipFrames = 	{
      love.graphics.newQuad(0,50,26,13,GB.width,GB.height),
      love.graphics.newQuad(32,50,26,13,GB.width,GB.height),
      love.graphics.newQuad(64,50,26,13,GB.width,GB.height)
    }
    self.shipAnimation = Animation.new( shipFrames, 0.2)

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
  
  self.update = function(dt)  

    self.touched = self.touched - dt
    self.x = self.x + self.speed*dt
    if(self.x < -35 ) then
      self.isDead = true
    end
    self.shipAnimation.update(dt)
    self.trail.update(dt)
  end
  

  self.checkCollision=function(x,y)
    if( x > self.x and x < self.x+26 and y < self.y+13 and y > self.y ) then
      return true
    end
    return false
  end

  
  self.takeDamage = function(damage)
    
    self.hp = self.hp - damage
    if(self.hp <= 0) then
      self.isDead  = true

      ShakeManager.startShake(0.3,3)
      player.score = player.score + math.floor(player.multiplier*self.score)
        for z=1,10 do
          local exploScale = NormalShipExplosion.new()
          exploScale.setRandomFrame()
          exploScale.x = self.x+1 + love.math.random(0,24)
          exploScale.y = self.y+1 + love.math.random(0,11)
          table.insert(elements,exploScale)
        end

    end
  end
  


  self.draw = function()
    if(self.touched > 0 and totalFrame % 3 == 0 )then
      
    else
      love.graphics.draw( GB.sprite, self.shipAnimation.getFrame(), self.x, self.y)
      love.graphics.draw( GB.sprite, self.trail.getFrame(), self.x+26,self.y + 3)
    end
  end

  self.init()
  return self
end


ShipManager.add("Saw",SawShip.new)