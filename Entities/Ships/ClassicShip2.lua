ClassicShip2 = {}
ClassicShip2.new = function()
  local self = {}
  self.image = nil
  self.trail = nil
  self.x = 0
  self.y = 0
  self.speed = 5
  self.initSpeed = 5
  self.touched = 0
  self.isDead = false
  self.score = 10
  self.hp = 5

  self.init = function()
    self.image = love.graphics.newQuad(88,19,36,14,GB.width,GB.height)
    local trailFrames = 	{
      love.graphics.newQuad(0,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(8,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(16,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(24,40,8,8,GB.width,GB.height)
    }
	  self.trail = Animation.new( trailFrames, 0.2)

    self.x = math.floor(love.math.random(160,200))
    self.y = math.floor(love.math.random(15,125))
    self.speed = 5
    self.goToPlayer()
  end

  self.after = function()
    self.goToPlayer()
  end


  self.goToPlayer = function()
    local dir = dirToPlayer(self.x,self.y)
    local x,y = normalize(dir.x,dir.y)
    print(x .. " | " .. y)
    self.vx = self.speed * x
    self.vy = self.speed * y
    print(self.vx .. "-"..self.vy)
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
        and x <= self.x+36 
        and y <= self.y+16
        and y >= self.y-2
      ) then
      return true
    end
    return false
  end

  self.update = function(dt)  
    if(totalFrame % 600 == 0) then
      self.goToPlayer()
    end
    self.touched = self.touched - dt
    self.x = self.x + self.vx*dt
    self.y = self.y + self.vy*dt
    if(self.x < -40 ) then
      self.isDead = true
    end
    self.trail.update(dt)
  end
  
  self.draw = function()
    if(self.touched > 0 and totalFrame % 3 == 0 )then
      
    else
      love.graphics.draw( GB.sprite, self.image, self.x, self.y)
      love.graphics.draw( GB.sprite, self.trail.getFrame(), self.x+32,self.y+2)
      love.graphics.draw( GB.sprite, self.trail.getFrame(), self.x+25,self.y+7)
    end

  end

  self.init()
  return self
end

ShipManager.add("Classic2",ClassicShip2.new)