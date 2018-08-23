TransitionScreen = {}
TransitionScreen.new = function(previousScreen, nextScreenCtor )
  local self = {}
  self.anim = nil
  self.current = previousScreen
  self.next = nextScreenCtor
  self.count = 0

  self.init = function()
    --self.current = ScreenManager.current
    local imagesTransition = 	{
      love.graphics.newQuad(96,40,10,9,GB.width,GB.height),
      love.graphics.newQuad(106,40,10,9,GB.width,GB.height),
      love.graphics.newQuad(116,40,10,9,GB.width,GB.height),
      love.graphics.newQuad(126,40,10,9,GB.width,GB.height),
      love.graphics.newQuad(136,40,10,9,GB.width,GB.height)
      }
      self.anim = Animation.new( imagesTransition, 0.05)
      self.anim.type = Animation.Type.PINGPONG

      self.anim.changeCallBack = function()
        ScreenManager.current.count = ScreenManager.current.count + 1
        if(ScreenManager.current.count == 1) then
          ScreenManager.current.current = ScreenManager.current.next()
        end
        if(ScreenManager.current.count == 2) then
          ScreenManager.setScreen(ScreenManager.current.current)
        end
      end
  end
  
  self.update = function(dt)
   self.anim.update(dt)
  end
 
  self.draw = function()
    self.current.draw()
    love.graphics.draw( GB.sprite, self.anim.getFrame(), 0, 0,0,16,16)
  end

  self.init()
  return self
end