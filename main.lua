love.graphics.setDefaultFilter( "nearest", "nearest", 1 )
		
totalFrame = 0
function love.load()
	require 'gb'
	GRAVITY = 4

	love.window.setTitle("GBJam 6")
	love.window.setMode(GB.width*GB.scale,GB.height*GB.scale)
	
	require 'utils'
	JSON = require 'Libs/JSON'
	--JSON:decode(raw_json_text)
	require 'Entities/Animation'
	
	require 'Entities/Levels/Bosses/Boss1'
	require 'Managers/ScreenManager'
	require 'Managers/StagesManager'
	require 'Managers/ShipManager'
	require 'Managers/ShakeManager'
	require 'Screens/GameScreen'
	require 'Screens/MenuScreen'
	require 'Screens/TransitionScreen'
	require 'Entities/Ships/LittleShip'
	require 'Entities/Ships/BigShip'
	require 'Entities/Ships/SawShip'
	require 'Entities/Ships/ClassicShip'
	require 'Entities/Ships/ClassicShip2'
	require 'Entities/Explosions/NormalShipExplosion'
	require 'Entities/SpaceElements/Asteroid'
	require 'Entities/Player'
	require 'Entities/Bullets/BlasterBullet'
	require 'Entities/Bullets/ClassicBullet'
	require 'Entities/Bullets/SuperGunBullet'
	require 'Entities/Weapons/Bullets/Blaster'
	require 'Entities/Weapons/Bullets/SuperGun'
	require 'Entities/Weapons/Energies/Laser'
	require 'Entities/Levels/Waves/Wave'
	require 'Entities/Levels/Stages/Stage'
	require 'Entities/Levels/Waves/Datas'
	
	StagesManager.loadWaves()
	ScreenManager.setScreen(MenuScreen.new())
	
	player = Player.new()
	displayScore = 0
	

end

function love.update(dt)
	
	ShakeManager.update(dt)
	ScreenManager.update(dt)
end

function love.draw()
	totalFrame = totalFrame+1
	GB.resetGBColor()
	love.graphics.scale(GB.scale,GB.scale)
	ShakeManager.apply()
	ScreenManager.draw()
	ShakeManager.reset()
end

function love.keypressed(k)
	if k == "escape" then
		love.event.quit()
	end
end