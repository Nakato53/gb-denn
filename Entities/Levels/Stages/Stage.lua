Stage = {}
Stage.new = function()
  local self = {}

  self.elapsedTime = 0
  self.waves = nil
  self.nextWaveIn = -5
  self.currentWave = 1
  self.bosspoped = false
  self.boss = nil
  
  self.draw = function()
    if(self.bosspoped == true and self.elapsedTime<5) then
      GB.setGBColor(4)
      love.graphics.printf(self.boss.name, 0, 72, 160, 'center')
      GB.resetGBColor()
    end
  end
  
  self.init = function()
    self.elapsedTime = 0
    self.waves = {}

    for i = 1,StagesManager.stageWaveCount[player.stage] do
      table.insert(self.waves, Wave.new(false))
    end
    --preboss timer
    table.insert(self.waves, Wave.new(true))

    
  end

  self.update = function(dt)
    self.elapsedTime = self.elapsedTime + dt
    if(self.elapsedTime>self.nextWaveIn) then
      
      self.currentWave = self.currentWave + 1
      if(self.currentWave > #self.waves ) then
        --bosstime
        if(self.bosspoped==false) then
          self.elapsedTime = 0
          self.boss = StagesManager.bosses[player.stage].create()
          self.bosspoped = true
          table.insert(elements,self.boss)
        end
      else
        
        self.spawnWave()
      end
    end

  end

  self.spawnWave = function()
    self.waves[self.currentWave].createWave()
    self.nextWaveIn = self.waves[self.currentWave].life
    self.elapsedTime = 0
  end


  self.init()
  return self
end