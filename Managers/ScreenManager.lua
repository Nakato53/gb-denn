_ScreenManager = {}
_ScreenManager.new = function()
  local self = {}
  self.current = nil
  
  self.update = function(dt)
   if(self.current ~= nil) then
    self.current.update(dt)
   end
  end

  self.setScreen = function(screen)
    self.current = screen
    
  end


  self.initScreen = function()
    if(self.current ~= nil) then
      self.current.init()
     end
  end


  self.draw = function()
    if(self.current ~= nil) then
      self.current.draw(dt)
     end
  end

  return self
end
ScreenManager = _ScreenManager.new()