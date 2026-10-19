function drawGamepad()
	-- TODO Gamepad function as import

	x = 30 * settings.windowScale 
	y = 185 * settings.windowScale
	
	-- TODO optimize readable
	
	love.graphics.setColor(0, 0, 0, 0.4)
 	love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)

	love.graphics.setColor(1,1,1)
	love.graphics.setNewFont(20 * settings.windowScale)
	love.graphics.print("ID: " .. gamepad:getID(), x, y + 1 * settings.windowScale)
	love.graphics.print("GUID: " .. gamepad:getGUID(), x, y + 25 * settings.windowScale)
	love.graphics.print("NAME: " .. gamepad:getName(), x, y + 50 * settings.windowScale)
	love.graphics.print("INFO: " .. gamepad:getDeviceInfo(), x, y + 75 * settings.windowScale)
	love.graphics.print("VIBRATION: " .. gamepad:getVibration(), x, y + 100 * settings.windowScale)
	love.graphics.print("AXIS COUNT: " .. gamepad:getAxisCount(), x, y + 125 * settings.windowScale)
	love.graphics.print("AXIS 1: " .. gamepad:getAxis(1), x, y + 150 * settings.windowScale)
	love.graphics.print("AXIS 2: " .. gamepad:getAxis(2), x, y + 175 * settings.windowScale)
	love.graphics.print("BUTTON COUNT: " .. gamepad:getButtonCount(), x, y + 200 * settings.windowScale)
	
	if gamepad:isDown(1) then
		love.graphics.print("IS DOWN X", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(2) then
		love.graphics.print("IS DOWN A", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(3) then
		love.graphics.print("IS DOWN B", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(4) then
		love.graphics.print("IS DOWN Y", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(5) then
		love.graphics.print("IS DOWN L", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(6) then
		love.graphics.print("IS DOWN R", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(7) then
		love.graphics.print("IS DOWN 7", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(8) then
		love.graphics.print("IS DOWN 8", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(9) then
		love.graphics.print("IS DOWN SELECT", x, y + 225 * settings.windowScale) 
	end
	
	if gamepad:isDown(10) then
		love.graphics.print("IS DOWN START", x, y + 225 * settings.windowScale) 
	end
	
	
	-- love.graphics.print(gamepad:getGamepadMappingString(), 400, 700)
end
