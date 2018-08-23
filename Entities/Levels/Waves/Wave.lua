Wave = {}
Wave.new = function(boss)
  local self = {}

  self.boss = boss
  self.elapsedTime = 0
  self.datas = nil

  self.init = function()
    self.elapsedTime = 0
    local wave = nil
    if( self.boss ) then
      wave = StagesManager.getPreBossWave()
    else
      wave = StagesManager.getWave()
    end
    if(wave == nil) then
      wave = {
        ships = {},
        life = 0
      }
    end
    self.datas = wave.ships
    self.life = wave.life
  end

  self.update = function(dt)
    self.elapsedTime = self.elapsedTime + dt
  end

  self.createWave = function()
    if(#self.datas > 0) then
      for i=1,#self.datas do
        local tmp = ShipManager.buildShip(self.datas[i].name)
        tmp.x = self.datas[i].x
        tmp.y = self.datas[i].y
        tmp.speed = self.datas[i].speed
        if(tmp.after ~= nil) then
          tmp.after()
        end
        table.insert(elements,tmp )
      end
    else
      print("NO DATAS IN WAVE")
    end
  end


  self.init()
  return self
end


