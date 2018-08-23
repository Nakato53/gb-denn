_StagesManager = {}
_StagesManager.new = function()
  local self = {}

  self.wavesByStages = {

  }
  self.bosses = {
    {
      create = Boss1.new 
    }
  }
  self.stageWaveCount = {
    3,
    8,
    12,
    28,
    27
  }
  self.currentWave = 0

  self.init = function()
    self.wavesByStages = {
      {},
      {},
      {},
      {},
      {}  
    }
  end

  self.getWave = function()
    local alea = math.floor( love.math.random(1,#self.wavesByStages[player.stage]))
    return self.wavesByStages[player.stage][alea]
  end

  self.getPreBossWave = function()
    return {
      ships = {},
      life = 10,

    }
  end

  self.loadWaves = function()
    for i=1,#WavesDatas do
      for y=1,#WavesDatas[i].stages do
        table.insert(self.wavesByStages[WavesDatas[i].stages[y]],WavesDatas[i])
      end
    end
  end

  self.nextStage = function()
    self.currentWave = 0
  end

  self.init()
  return self
end
StagesManager = _StagesManager.new()