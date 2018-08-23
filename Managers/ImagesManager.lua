ImagesManager = function()
  local self = {}
  
  self.load = function(path)
    self.liste[path] = love.graphics.newImage(path)
  end

  self.get=function(path)
    if( self.liste[path] == nil) then
      self:load(path)
    end
    return self.liste[path]
  end
end