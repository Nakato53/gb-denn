Player = {}
Player.new = function()
  local self = {}
  self.x = 0
  self.y = 0
  self.image = love.graphics.newQuad(0,0,16,11,GB.width,GB.height)
  self.hp = 5
  self.maxhp = 10
  self.score = 0
  self.baseMultiplier = 1
  self.multiplier = 1
  self.swapDelay = 0.5
  self.swapElapsed = 10
  self.trail = nil
  self.trail2 = nil
  self.stage = 1

  self.weapons = {
    SuperGun.new(),
    Laser.new(),
  }
  self.currentWeapon = 1

  self.init = function()

    local trailFrames = 	{
      love.graphics.newQuad(0,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(8,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(16,40,8,8,GB.width,GB.height),
      love.graphics.newQuad(24,40,8,8,GB.width,GB.height)
    }
    self.trail = Animation.new( trailFrames, 0.2)
    self.trail2 = Animation.new( trailFrames, 0.2)
    self.trail2.currentFrame = 2
  end

  self.update = function(dt)
    self.trail.update(dt)
    self.trail2.update(dt)
    self.swapElapsed = self.swapElapsed + dt
    
    if (self.swapElapsed>self.swapDelay and love.keyboard.isDown( "c" )) then
      self.swapElapsed = 0
      if(self.currentWeapon==1) then self.currentWeapon = 2 else self.currentWeapon = 1 end
    end
    local speed = 100
    if(self.weapons[self.currentWeapon].isFire ~= nil and self.weapons[self.currentWeapon].isFire == true) then
      speed = 25
    end
		if love.keyboard.isDown( "left" ) then
			self.x=self.x-speed*dt
		end
		if love.keyboard.isDown( "right" ) then
			self.x=self.x+speed*dt
		end
		if love.keyboard.isDown( "down" ) then
			self.y=self.y+speed*dt
		end
		if love.keyboard.isDown( "up" ) then
			self.y=self.y-speed*dt
    end
		if love.keyboard.isDown( "g" ) then
      player.stage = player.stage + 1
      ScreenManager.setScreen(TransitionScreen.new(self,GameScreen.new))
    end
    
    self.weapons[self.currentWeapon].update(dt)
    
    if(self.x < 0) then self.x = 0 end
    if(self.x > 144) then self.x = 144 end

    if(self.y < 12) then self.y = 12 end
    if(self.y > 133) then self.y = 133 end
  end



  self.checkCollision=function(x,y)
    if( x > self.x and x < self.x+16 and y < self.y+9 and y > self.y+2 ) then
      return true
    end
    return false
  end

  self.draw = function()

    love.graphics.draw( GB.sprite, self.image, player.x, player.y)

    love.graphics.draw( GB.sprite, self.trail.getFrame(), self.x+2,self.y+2,0,-1,1)
    love.graphics.draw( GB.sprite, self.trail2.getFrame(), self.x+2,self.y+3,0,-1,1)

    self.weapons[self.currentWeapon].draw()
    if(self.swapElapsed<self.swapDelay) then

      GB.setGBColor(4)
		love.graphics.printf(self.weapons[self.currentWeapon].name, 0, 72, 160, 'center')
    GB.resetGBColor()
    end
  end

  self.init()
  return self
end