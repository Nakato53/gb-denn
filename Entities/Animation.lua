Animation = {}
Animation.Type = {
  LOOP = 0,
  PINGPONG = 1
}
Animation.new = function(quads,frameRate)
  local self = {}
  self.frames = quads
  self.frameRate = frameRate
  self.currentFrame = 1
  self.elapsed = 0
  self.changeCallBack = nil
  self.type = Animation.Type.LOOP
  self.step = 1

  
  self.update = function(dt)
    self.elapsed=self.elapsed+dt
    if(self.elapsed>self.frameRate) then
      self.elapsed = 0
      self.currentFrame=self.currentFrame+self.step
      if(self.currentFrame>#self.frames or self.currentFrame<1) then
        
        if(self.type == Animation.Type.LOOP) then
          self.currentFrame = 1
        end
        
        if(self.type == Animation.Type.PINGPONG) then
          self.step = self.step*-1
          self.currentFrame=self.currentFrame+self.step
        end
        
        if(self.changeCallBack ~= nil) then
          self.changeCallBack()
        end

      end
    end
  end

  self.getFrame = function()
    return self.frames[self.currentFrame]
  end

  return self
end