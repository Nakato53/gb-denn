Blaster = {}
Blaster.new = function()
  local self = {}
  
  self.nextFire = 0
  self.fireRate = 0.1
  self.name = "Blaster"
  self.bullet = BlasterBullet.new

  self.init = function()

  end

  self.update = function(dt)
  
    self.nextFire=self.nextFire+dt
    
		if (self.nextFire > self.fireRate and love.keyboard.isDown( "x" )) then
			self.nextFire = 0
			local tmp = self.bullet()
			tmp.x = player.x+16
			tmp.y = player.y + 4 + love.math.random(-2,2)
      table.insert(bullets,tmp )

      local tmp = BlasterBullet.newShot()
			tmp.x = player.x+16
			tmp.y = player.y + 4 + love.math.random(-2,2)
      table.insert(elements,tmp )
      
      
    end

  end
  

  self.draw = function()

  end

  self.init()
  return self
end