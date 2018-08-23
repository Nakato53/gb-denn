SuperGun = {}
SuperGun.new = function()
  local self = {}
  
  self.nextFire = 0
  self.fireRate = 0.1
  self.name = "SuperGun"
  self.bullet = SuperGunBullet.new

  self.init = function()

  end

  self.update = function(dt)
  
    self.nextFire=self.nextFire+dt
    
		if (self.nextFire > self.fireRate and love.keyboard.isDown( "x" )) then
      self.nextFire = 0
      
      local tmp = self.bullet()
      tmp.selectedImage = 3
      
      tmp.r =  - 0.5
      tmp.vx = love.math.random(180,220)
      tmp.vy = -love.math.random(90,110)
			tmp.x = player.x+19 
      tmp.y = player.y + 7 
      
      table.insert(bullets,tmp )

      local tmp = self.bullet()
      tmp.selectedImage = 3
      tmp.r =  0.5
      tmp.vx = love.math.random(180,220)
      tmp.vy = love.math.random(90,110)
			tmp.x = player.x+19
      tmp.y = player.y + 7
      
      table.insert(bullets,tmp )
      
      local tmp = self.bullet()
      tmp.selectedImage = 2
      tmp.r =  -0.25
      tmp.vx = love.math.random(180,220)
      tmp.vy = -love.math.random(45,55)
			tmp.x = player.x+19
      tmp.y = player.y + 7
      
      table.insert(bullets,tmp )

      local tmp = self.bullet()
      tmp.selectedImage = 2
      tmp.r =  0.25
      tmp.vx = love.math.random(180,220)
      tmp.vy = love.math.random(45,55)
			tmp.x = player.x+19
      tmp.y = player.y + 7
      
      table.insert(bullets,tmp )

      local tmp = self.bullet()
      tmp.selectedImage = 1
      tmp.r =  00
      tmp.vx = love.math.random(180,220)
      tmp.vy = love.math.random(-5,5)
			tmp.x = player.x+19
      tmp.y = player.y + 6
      
      table.insert(bullets,tmp )
      
    end

  end
  

  self.draw = function()

  end

  self.init()
  return self
end