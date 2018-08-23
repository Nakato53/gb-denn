GameScreen = {}
GameScreen.new = function()
  local self = {}
	
	self.elapsedTime = 0
	self.stage = nil

	self.init = function()
	
	self.elapsedTime = 0
	bullets = {}
	elements = {}
	self.stage = Stage.new()

	r = 0

		player.y = 70
		player.x = 10


	stars = {}
	for i=0,100 do
		local tmp = {}
		tmp.x = love.math.random(0,GB.width-1)
		tmp.y = love.math.random(0,GB.height-1)
		tmp.type = love.math.random(0,5)
		table.insert(stars,tmp )
	end




  end
  
	self.update = function(dt)
		self.stage.update(dt)
		self.elapsedTime =self.elapsedTime+dt
				--r=r+dt
		for i=#bullets,1,-1 do
			bullets[i].update(dt)
			if(bullets[i].isDead ~= nil and bullets[i].isDead == true ) then
				table.remove(bullets, i)
			end
		end
		player.update(dt)

		self.checkBulletCollision()
		for i=#elements,1,-1 do
			elements[i].update(dt)
			if(elements[i].isDead ~= nil and elements[i].isDead == true ) then
				table.remove(elements, i)
			end
		end
	end
	
	self.checkBulletCollision = function()
		for i=#bullets,1,-1 do
			local toDelete = false
			if(bullets[i].isEnnemy == nil) then
				for y=#elements,1,-1 do
					if(elements[y].checkCollision~=nil) then
						if(elements[y].checkCollision(bullets[i].x+3,bullets[i].y+2)) then
							elements[y].takeDamage(bullets[i].damage)
							local explo = NormalShipExplosion.new()
							elements[y].touched = 0.5
							explo.x = bullets[i].x+3
							explo.y = bullets[i].y+2
							table.insert(elements,explo)

							if(elements[y].scaleExplo ~= nil) then
								for z=2,elements[y].scaleExplo do
									local exploScale = NormalShipExplosion.new()
									exploScale.x = bullets[i].x+3 + love.math.random(-3*elements[y].scaleExplo,3*elements[y].scaleExplo)
									exploScale.y = bullets[i].y+2 + love.math.random(-3*elements[y].scaleExplo,3*elements[y].scaleExplo)
									table.insert(elements,exploScale)
								end
							end
							toDelete = true
						end
					end
				end
			end
			if(toDelete) then
				table.remove(bullets,i)
			end
		end
	end

  
  self.draw = function()
    GB.setBGGBColor(1)
    GB.resetGBColor()
  
		GB.setGBColor(2)
		for i=1,#stars do
			GB.drawPixel(stars[i].x,stars[i].y,2)
		end

		GB.resetGBColor()
		
		for i=1,#elements do
			elements[i].draw()
			GB.resetGBColor()
		end
    
  
    for i=1,#bullets do
      bullets[i].draw()
		end
		
		player.draw()

		self.drawHUD()
		self.stage.draw()

    GB.resetGBColor()
	end
	
	self.drawHUD = function()
		--player Life
		GB.setGBColor(1)
		if(displayScore<player.score) then 
			if(player.score - displayScore > 50) then
				displayScore = displayScore+10 
			else
				displayScore = displayScore+0.5 
			end
		end
		love.graphics.rectangle("fill",0,0,160,11)
		GB.setGBColor(4)
		love.graphics.printf(  math.floor(displayScore), 0, 1, 160, 'right')
		love.graphics.print("x"..player.multiplier, 55, 1)

		for	i=1,player.maxhp do
			 if i <= player.hp then
					GB.setGBColor(3)
					love.graphics.rectangle("fill",1+(i-1)*4+i,2,3,6)
					GB.setGBColor(4)
					love.graphics.rectangle("line",1+(i-1)*4+i,2.5,3,6)
				else
					GB.setGBColor(4)
					love.graphics.rectangle("line",1+(i-1)*4+i,2.5,3,6)
			 end
		end
		GB.setGBColor(3)
		love.graphics.line(0,11,160,11)
		

		if(self.elapsedTime<1)then
			GB.setGBColor(4)
			if(self.elapsedTime <= 0.5)then
				love.graphics.printf("STAGE "..player.stage, 0, 72, 160, 'center')
			end
			if(self.elapsedTime>0.5 and totalFrame % 2 == 0 ) then
				love.graphics.printf("STAGE "..player.stage, 0, 72, 160, 'center')
			end
		end
		GB.resetGBColor()
	end

  self.init()
  return self
end