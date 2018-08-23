_ShipManager = {}
_ShipManager.new = function()
  local self = {}
  
  self.ship = {}

  self.init = function()
    self.ship = {}
  end

  self.add = function(name, functionPointer)
    self.ship[name] = functionPointer
  end

  self.buildShip = function (name)
    return self.ship[name]()
  end

  self.init()
  return self
end
ShipManager = _ShipManager.new()