button = require "button"


local fps = 0;
local durationSinceLastSecond = 0;


function round(num, decimal)
	local mult = 10^(decimal or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function Color(hex, value)
	return {
		tonumber(string.sub(hex, 2, 3), 16) / 256,
		tonumber(string.sub(hex, 4, 5), 16) / 256,
		tonumber(string.sub(hex, 6, 7), 16) / 256,
		value or 1
	}
end


function love.load()
	-- TODO
	-- Optimize code
	-- Add night mode
	-- Add settings overlay
	-- Add different colors
	-- Add high DPI mode
	-- Define all the parameters here
	-- Try to detect Mecha Comet
	-- visible = love.window.isVisible( )
	-- Do not redraw if the display is off
	

	settings = {}
	settings.windowWidth = 540
	settings.windowHeight = 620
	settings.windowScale = 0.667
	settings.windowScale = 1.4
	--settings.windowScale = 1.85
	settings.headlineFontFamily = "RobotoCondensed-Light.ttf"
	settings.headlineFontSize = 42 * settings.windowScale
	settings.headlineFont = love.graphics.newFont(
		settings.headlineFontFamily,
		settings.headlineFontSize
	)
	settings.hourNumbersFontSize = 24 * settings.windowScale
	settings.hourNumbersFont = love.graphics.newFont(
		settings.hourNumbersFontSize
	)
	settings.headlineText = "Löve around the clock"
	settings.backgroundColor = {0.2, 0.2, 0.2}
	settings.borderless = false
	settings.clockRadius = 200
	settings.clockBorderWidth = 20
	settings.deepWidth = 6
	settings.showFPS = false
	settings.showGamepad = false
	settings.fullscreen = false
	settings.showCompass = false
	
	
	love.window.setMode(
		settings.windowWidth * settings.windowScale,
		settings.windowHeight * settings.windowScale,
		{
			highdpi = true,
			borderless = settings.borderless,
			usedpiscale = true
		}
	)
	
	
	if settings.fullscreen == true then
		settings.windowWidth = 1920
		settings.windowHeight = 1200
		
		love.window.setMode(
			settings.windowWidth,
			settings.windowHeight,
			{
				highdpi = true,
				borderless = settings.borderless,
				usedpiscale = true
			}
		)
		
		settings.windowWidth = 1920 / settings.windowScale
		settings.windowHeight = 1200 / settings.windowScale
		
		love.window.setFullscreen(true, "desktop")
	end
	
	
	love.window.setTitle(settings.headlineText)
	love.graphics.setBackgroundColor(settings.backgroundColor)
	
	windowWidth, windowHeight = love.window.getMode()
	
	-- Display center
	centerX, centerY = windowWidth / 2, windowHeight / 2
    
	print(windowWidth)
	print (windowHeight)
	print(love.graphics.getDPIScale( ))
	print(love.system.getOS())
	desktopwidth, desktopheight = love.window.getDesktopDimensions( 1 )
	print(desktopwidth)
	print(desktopheight)
	love.window.setPosition(0 , 0, 1) 
	print(love.system.getPowerInfo())
	print(love.window.getDisplayName(1))

	-- love.graphics.setLineStyle("smooth")
	
	
    MenuButton = {button:new(
        settings.windowWidth * settings.windowScale - 68 * settings.windowScale, -- X
        8 * settings.windowScale, -- Y
        0.5 * settings.windowScale, -- Scale (the image has double size)
        love.graphics.newImage("menu_button_normal.png"),
        love.graphics.newImage("menu_button_hover.png"),
        function() -- Button's function
            --print("Hello")
        end,
        function() -- Button's function
            --print("Hover")
        end)
    }
    
    backgroundImage = love.graphics.newImage("background.png")
    clockBackground = love.graphics.newImage("clock_background.png")
    
    compassBackground = love.graphics.newImage("compass_background.png")    
end

function love.update(dt)
	durationSinceLastSecond = durationSinceLastSecond + dt;
	
	-- Execute every second
	if durationSinceLastSecond > 1 then
		fps = 1 / dt
		durationSinceLastSecond = 0
	end
	
	-- Quit the game
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
	
	
	local joysticks = love.joystick.getJoysticks()
	gamepad = joysticks[1]
	

	-- Current time
	currentTime = os.date("*t")
	
	button:update(dt)
end

function love.draw()
	love.graphics.setColor(Color("#ffffff"))
	 
	 love.graphics.draw(
	 	backgroundImage,
	 	0,
	 	0,
	 	0,
	 	0.5 * settings.windowScale,
	 	0.5 * settings.windowScale
 	)
 	
 	if settings.showCompass then
	 	love.graphics.setColor(1, 1, 1, 0.08)
	 	
	 	love.graphics.draw(
	 		compassBackground,
	 		windowWidth / 2,
	 		windowHeight / 2,
	 		0.5 * math.pi * 2, -- TODO
	 		0.5 * settings.windowScale,
	 		0.5 * settings.windowScale,
	 		compassBackground:getWidth() / 2,
	 		compassBackground:getHeight() / 2
		)
 	end
 	
	
	
	love.graphics.setColor(1, 1, 1)
 	
 	love.graphics.draw(
 		clockBackground,
 		windowWidth / 2 - 0.5 * clockBackground:getWidth() / 2 * settings.windowScale,
 		windowHeight / 2 -0.5 * clockBackground:getHeight() / 2 * settings.windowScale,
 		0, 0.5 * settings.windowScale
	)
	

	
	

	-- Headline
	love.graphics.setFont(settings.headlineFont)
	
	fontHeight = love.graphics:getFont():getHeight()
	fontWidth = love.graphics:getFont():getWidth(settings.headlineText)
	
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.print(
		settings.headlineText,
		windowWidth / 2 - fontWidth / 2 - 1 * settings.windowScale,
		windowHeight / 2 - 297 * settings.windowScale - 1 * settings.windowScale
	)
	
	love.graphics.setColor(0.56, 0.56, 0.56, 1)
	love.graphics.print(
		settings.headlineText,
		windowWidth / 2 - fontWidth / 2 ,
		windowHeight / 2 - 297 * settings.windowScale
	)
	
	
	-- FPS
	
	if settings.showFPS then
		love.graphics.setNewFont(22 * settings.windowScale)
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(
			round(fps, 0) .. " FPS",
			windowWidth - 160 * settings.windowScale,
			10 * settings.windowScale
		)
	end
	
	
	-- Clock face

	love.graphics.setColor(0.7, 0.7, 0.7)
	love.graphics.circle(
		"fill",
		centerX,
		centerY + settings.deepWidth * settings.windowScale / 2,
		settings.clockRadius * settings.windowScale - 0.5
	)
	love.graphics.circle(
		"line",
		centerX,
		centerY + settings.deepWidth * settings.windowScale / 2,
		settings.clockRadius * settings.windowScale
	)

	love.graphics.setColor(1, 1, 1)
	love.graphics.circle(
		"fill",
		centerX,
		centerY - settings.deepWidth * settings.windowScale / 2,
		settings.clockRadius * settings.windowScale - 0.5
	)
	love.graphics.circle(
		"line",
		centerX,
		centerY - settings.deepWidth * settings.windowScale / 2,
		settings.clockRadius * settings.windowScale
	)

	love.graphics.setColor(Color("#b2262c")) -- TODO: get from settings
	love.graphics.circle(
		"fill",
		centerX,
		centerY - settings.deepWidth * settings.windowScale,
		settings.clockRadius * settings.windowScale - settings.clockBorderWidth * settings.windowScale - 0.5
	)
	love.graphics.circle(
		"line",
		centerX,
		centerY - settings.deepWidth * settings.windowScale,
		settings.clockRadius * settings.windowScale - settings.clockBorderWidth * settings.windowScale
	)

	love.graphics.setColor(Color("#ed333b"))-- TODO: get from settings
	love.graphics.circle(
		"fill",
		centerX,
		centerY,
		settings.clockRadius * settings.windowScale - settings.clockBorderWidth * settings.windowScale - 0.5
	)
	love.graphics.circle(
		"line",
		centerX,
		centerY,
		settings.clockRadius * settings.windowScale - settings.clockBorderWidth * settings.windowScale
	)
    

	love.graphics.setColor(1, 1, 1, 0.8) -- TODO: get from settings
    
	for i = 0, 59 do
		local angle = math.rad(i * 6)
        
		local innerRadius =
			settings.clockRadius * settings.windowScale -
			6 * settings.windowScale -
			settings.clockBorderWidth * settings.windowScale
        	
		local outerRadius =
			settings.clockRadius * settings.windowScale -
			settings.clockBorderWidth * settings.windowScale
        	
		local x1 = centerX + innerRadius * math.sin(angle)
		local y1 = centerY - innerRadius * math.cos(angle)
		local x2 = centerX + outerRadius * math.sin(angle)
		local y2 = centerY - outerRadius * math.cos(angle)

		if i % 15 == 0 then
			love.graphics.setLineWidth(8 * settings.windowScale)
			love.graphics.line(
				x1,
				y1,
				x2 - 30 * settings.windowScale * math.sin(angle),
				y2 + 30 * settings.windowScale * math.cos(angle)
			)
		elseif i % 5 == 0 then
			love.graphics.setLineWidth(4 * settings.windowScale)
			love.graphics.line(
				x1,
				y1,
				x2 - 30 * settings.windowScale * math.sin(angle),
				y2 + 30 * settings.windowScale * math.cos(angle)
			)
		else
			love.graphics.setLineWidth(2 * settings.windowScale)
			love.graphics.line(
				x1,
				y1,
				x2 - 12 * settings.windowScale * math.sin(angle),
				y2 + 12 * settings.windowScale * math.cos(angle)
    			)
		end
	end


	-- Clock face hour numbers

	love.graphics.setFont(settings.hourNumbersFont)
	for i = 1, 12 do
		local angle = math.rad((i) * 30)
		
		local numberRadius =
			settings.clockRadius * settings.windowScale -
			52 * settings.windowScale -
			settings.clockBorderWidth * settings.windowScale
			
		local x = centerX + numberRadius * math.sin(angle)
		local y = centerY - numberRadius * math.cos(angle)

		local text = tostring(i == 0 and 12 or i)
		local textWidth = settings.hourNumbersFont:getWidth(text)
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(text, x - textWidth/2, y - 14 * settings.windowScale)
	end


	-- Hour hand

	local hourAngle = math.rad((currentTime.hour % 12) * 30 + currentTime.min * 0.5)
	local hourLength =
		(
			settings.clockRadius * settings.windowScale -
			settings.clockBorderWidth * settings.windowScale
		) * 0.6
	local hourX = centerX + hourLength * math.sin(hourAngle)
	local hourY = centerY - hourLength * math.cos(hourAngle)

	love.graphics.setLineWidth(12 * settings.windowScale)

	love.graphics.setColor(0, 0, 0, 0.2)
	love.graphics.line(
		centerX + 3 * settings.windowScale,
		centerY + 3 * settings.windowScale,
		hourX + 3 * settings.windowScale,
		hourY + 3 * settings.windowScale
	)

	love.graphics.setColor(1, 1, 1)
	love.graphics.line(centerX, centerY, hourX, hourY)


	-- Minute hand

	local minuteAngle = math.rad(currentTime.min * 6)
	local minuteLength = 
		(
			settings.clockRadius * settings.windowScale -
			settings.clockBorderWidth * settings.windowScale
		) * 0.76
	local minuteX = centerX + minuteLength * math.sin(minuteAngle)
	local minuteY = centerY - minuteLength * math.cos(minuteAngle)

	love.graphics.setLineWidth(6 * settings.windowScale)

	love.graphics.setColor(0, 0, 0, 0.2)
	love.graphics.line(
		centerX + 3 * settings.windowScale,
		centerY + 3 * settings.windowScale,
		minuteX + 3 * settings.windowScale,
		minuteY + 3 * settings.windowScale
	)

	love.graphics.setColor(1, 1, 1)
	love.graphics.line(centerX, centerY, minuteX, minuteY)


	-- Second hand

	local secondAngle = math.rad(currentTime.sec * 6)
	local secondLength =
		(
			settings.clockRadius * settings.windowScale -
			settings.clockBorderWidth * settings.windowScale
		) * 0.85
	local secondX = centerX + secondLength * math.sin(secondAngle)
	local secondY = centerY - secondLength * math.cos(secondAngle)

	love.graphics.setLineWidth(2 * settings.windowScale)

	love.graphics.setColor(0, 0, 0, 0.2)
	love.graphics.line(
		centerX + 3 * settings.windowScale,
		centerY + 3 * settings.windowScale,
		secondX + 3 * settings.windowScale,
		secondY + 3 * settings.windowScale
	)

	love.graphics.setColor(1, 1, 1)
	love.graphics.line(centerX, centerY, secondX, secondY)


	-- Circle in center
	
	love.graphics.setColor(0, 0, 0, 0.2)
	love.graphics.circle(
		"fill",
		centerX + 1.5 * settings.windowScale,
		centerY + 1.5 * settings.windowScale,
		18 * settings.windowScale
	)

	love.graphics.setColor(1, 1, 1)
	love.graphics.circle("fill", centerX, centerY, 15 * settings.windowScale)

	love.graphics.setLineWidth(2 * settings.windowScale)
	love.graphics.setColor(1, 1, 1)
	love.graphics.circle("line", centerX, centerY, 15 * settings.windowScale)

	love.graphics.setColor(Color("#ed333b"))
	love.graphics.circle("line", centerX, centerY, 3 * settings.windowScale)
    
    
    	-- Gamepad
	
	if gamepad and settings.showGamepad then
		drawGamepad()
	end
	
	 img = love.graphics.newImage("menu_button_hover.png")
	 
	 button:draw()

	love.graphics.setColor(Color("#ffffff"))
	 
	 --love.graphics.draw(
	 --	img,
	 --	8 * settings.windowScale,
	 --	8 * settings.windowScale,
	 --	0,
	 --	0.5 * settings.windowScale,
	 --	0.5 * settings.windowScale
 	--)
 	
 	
 	
end

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
