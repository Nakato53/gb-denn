Laser = {}
Laser.new = function()
  local self = {}
  
  self.nextFire = 0
  self.fireRate = 0.05
  self.name = "Laser"
  self.center = nil
  self.begin = nil
  self.touch = nil
  self.displayStart = 0
  self.displayEnd = 0
  self.isFire = false

  self.init = function()
    local beginFrames = 	{
      love.graphics.newQuad(56,32,3,8,GB.width,GB.height),
      love.graphics.newQuad(56,40,3,8,GB.width,GB.height)
      
    }
    self.begin = Animation.new( beginFrames, 0.2)
    local touchFrames = 	{
      love.graphics.newQuad(62,32,4,8,GB.width,GB.height),
      love.graphics.newQuad(62,40,4,8,GB.width,GB.height)
      
    }
    self.touch = Animation.new( touchFrames, 0.2)
    self.center = love.graphics.newQuad(60,32,1,8,GB.width,GB.height)
  end

  self.update = function(dt)
  
    self.nextFire=self.nextFire+dt

    self.begin.update(dt)
    self.touch.update(dt)
    self.isFire = false
    if (love.keyboard.isDown( "x" ) ) then
      self.isFire = true
      self.displayEnd = 160-4
      self.displayStart = player.x + 16 
      local touched = false
      for x= player.x + 16 + 3, 160,1 do
        for y=1,#elements do
				  if(elements[y].checkCollision~=nil) then
            if(elements[y].checkCollision(x,player.y+4)) then
              if( x-4 < self.displayEnd) then
                self.displayEnd = x-4
                touched = true
              end
            end
          end
        end
      end
      if(touched) then
        if(self.nextFire > self.fireRate) then
          self.nextFire = 0
            local tmp = {}
            tmp.damage = 0.5
            tmp.vx = 0
            tmp.vy = 0
            tmp.update = function(dt) tmp.isDead = true end
            tmp.draw = function() 
            end
          tmp.isDead = false
          tmp.x = self.displayEnd+4 
          tmp.y = player.y + 2
          table.insert(bullets,tmp )
        end
      end
      
    end

  end
  

  self.draw = function()
    if (love.keyboard.isDown( "x" ) ) then
      -- display start
      love.graphics.draw( GB.sprite, self.begin.getFrame(), self.displayStart, player.y+2)

      for x=self.displayStart+4,self.displayEnd do
        love.graphics.draw( GB.sprite, self.center, x, player.y+2)
      end
      -- display finish
      love.graphics.draw( GB.sprite, self.touch.getFrame(), self.displayEnd, player.y+2)
    end
  end

  self.init()
  return self
end