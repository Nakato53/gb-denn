GB = {

  color = {},
  sprites = nil,
  font = nil,
  pixel = nil,
  init = function()
    GB.color[1] = {8/255,24/255,32/255}
    GB.color[2] = {52/255,104/255,86/255}
    GB.color[3] = {136/255,192/255,112/255}
    GB.color[4] = {224/255,248/255,208/255}
    GB.sprite = love.graphics.newImage("assets/images/spritesheet.png")
    GB.pixel = love.graphics.newQuad(0,15,1,1,GB.width,GB.height)
    GB.font = love.graphics.newFont("assets/fonts/Early GameBoy.ttf", 8)
    love.graphics.setFont(GB.font)
  end,
  scale = 3,
  width = 160,
  height = 144,

  setBGGBColor = function(n)
    love.graphics.setBackgroundColor(unpack(GB.color[n]))
  end,
  
  setGBColor = function (n)
    love.graphics.setColor(unpack(GB.color[n]))
  end,

  drawPixel = function(x,y,c)
    GB.setGBColor(c)
    love.graphics.draw( GB.sprite, GB.pixel, x, y)
    GB.resetGBColor()
  end,

  resetGBColor = function()
    love.graphics.setColor(1,1,1)
  end
}

GB.init()