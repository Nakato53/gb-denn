MenuScreen = {}
MenuScreen.new = function()
  local self = {}
  self.backgroundImage = nil
  self.x = 40
  self.y = 120
  self.stepx = 3
  self.stepy = 6
  self.miniShips = {}
  self.bigship = nil
  self.nextscreen = false
  

  self.init = function()
    self.backgroundImage = love.graphics.newImage("assets/images/bgmenu.png")
    self.bigship = BigShip.new()    
    self.bigship.x = 45
    self.bigship.y = 70
    for i=0, 10 do
      local miniS = LittleShip.new()
      table.insert(self.miniShips, miniS)
    end
  end
  
  self.update = function(dt)
    self.x = self.x + self.stepx*dt
    self.y = self.y + self.stepy*dt
    if(self.x > 45) then
      self.stepx = self.stepx*-1
      self.x = self.x + self.stepx*dt
    end
    if(self.x < 35) then
      self.stepx = self.stepx*-1
      self.x = self.x + self.stepx*dt
    end
    if(self.y > 125) then
      self.stepy = self.stepy*-1
      self.y = self.y + self.stepy*dt
    end
    if(self.y < 115) then
      self.stepy = self.stepy*-1
      self.y = self.y + self.stepy*dt
    end

    
    for i=1,#self.miniShips do
      self.miniShips[i].update(dt)
    end

    self.bigship.update(dt)
  end
  
  self.printShadow = function(text, x, y, c1, c2)

    GB.setGBColor(c2)
    love.graphics.print(text, x-1,y-1)
    love.graphics.print(text, x-2,y-2)
    GB.setGBColor(c1)
    love.graphics.print(text, x,y)


    if ( love.keyboard.isDown( "x" ) and self.nextscreen==false ) then
      self.nextscreen=true
      ScreenManager.setScreen(TransitionScreen.new(self,GameScreen.new))
    end
    
  end

  self.draw = function()
    
    
    love.graphics.draw( self.backgroundImage,0,0)

    for i=1,#self.miniShips do
      self.miniShips[i].draw()
    end
    self.bigship.draw()
    
    GB.setGBColor(3)
    love.graphics.rectangle("fill",37,10,85,25)
    GB.setGBColor(4)
    love.graphics.rectangle("line",35.5,8.5,88,28)

    self.printShadow("GB-Denn", 54,18,4,1)
    self.printShadow("PRESS X", math.floor(self.x) ,math.floor(self.y),4,3)

    
    GB.resetGBColor()
  end
  self.init()
  return self
end