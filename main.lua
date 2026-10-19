button = require "modules/button"
compass = require "modules/compass"
text = require "modules/text"
clock = require "modules/clock"
overlay = require "modules/overlay"


local fps = 0;
local durationSinceLastSecond = 0;


function round(num, decimal)
	local mult = 10^(decimal or 0)
	return math.floor(num * mult + 0.5) / mult
end


function Color(hex, value)
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
	settings.headlineFontFamily = "assets/fonts/GlacialIndifference-Regular.otf"
	settings.headlineFontSize = 34 * settings.windowScale
	settings.headlineFont = love.graphics.newFont(
		settings.headlineFontFamily,
		settings.headlineFontSize
	)
	
	settings.hoursFontFamily = "assets/fonts/GlacialIndifference-Regular.otf"
	settings.hourNumbersFontSize = 24 * settings.windowScale
	settings.hourNumbersFont = love.graphics.newFont(
		settings.hoursFontFamily,
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
	settings.showHeadline = false
	settings.showCompass = true
	settings.showClock = false
	settings.nightMode = true
	
	
	settings.smallFontFamily = "assets/fonts/GlacialIndifference-Regular.otf"
	settings.smallFontSize = 22
	settings.smallFont = love.graphics.newFont(
		settings.smallFontFamily,
		settings.smallFontSize
	)
	
	settings.compassFontFamily = "assets/fonts/GlacialIndifference-Bold.otf"
	settings.compassFontSize = 35
	
	settings.overlayFontFamily = "assets/fonts/GlacialIndifference-Regular.otf"
	
	
	love.window.setMode(
		settings.windowWidth * settings.windowScale,
		settings.windowHeight * settings.windowScale,
		{
			highdpi = true,
			borderless = settings.borderless,
			usedpiscale = true
		}
	)
	
	backgroundImage = love.graphics.newImage("assets/images/background_dark.png")
	
	if settings.fullscreen == true then
		settings.windowScale = 1200 / settings.windowHeight
	
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
		
		backgroundImage = love.graphics.newImage("assets/images/background_dark_fullscreen.png")
	end
	
	
	love.window.setTitle(settings.headlineText)
	
	setImages()
	
	if settings.nightMode then
		love.graphics.setBackgroundColor(0, 0, 0)
	else
		love.graphics.setBackgroundColor(settings.backgroundColor)
	end
	
	
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

	
	MenuButtonWidget = button:new(
		settings.windowWidth * settings.windowScale - 68 * settings.windowScale, -- X
		48 * settings.windowScale, -- Y
		0.5 * settings.windowScale, -- Scale (the image has double size)
		menuButtonImageNormal,
		menuButtonImageHover,
		function() -- Button's function
		    --print("Hello")
		    overlayWidget:toggle()
		end,
		function() -- Button's function
		    --print("Hover")
		end
	)
    
    
	if settings.showHeadline then
		headlineTextWidget = text:new(9, 6, settings.headlineText, settings.headlineFont,  settings.windowScale)
		headlineTextWidget.text = "Clock"
	end
    
	geoTextWidget = text:new(190, 6, settings.headlineText, settings.smallFontFamily, settings.smallFontSize, settings.windowScale)
	geoTextWidget:setText("47,50° N\n9,73° O")
	geoTextWidget:setXY(12, 521)
	geoTextWidget:setColor({0.76, 0.76, 0.76, 1})
    
    
	if settings.showCompass then
		compassWidget = compass:new(
			windowWidth / 2,
			windowHeight / 2,
			compassBackgroundImage,
			compassImage,
			settings.compassFontFamily,
			settings.compassFontSize,
			settings.windowScale
		)
	end

    
	
	backgroundImage002 = love.graphics.newImage("assets/images/Winsch_Comet.png")
	
	clockBackground = love.graphics.newImage("assets/images/clock_background.png")
	
	
	clockWidget = clock:new(windowWidth / 2, windowHeight / 2, clockBackground, settings.windowScale)

	overlayWidget = overlay:new(settings.windowScale)
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
	
	function love.keypressed(key, scancode, isrepeat)
		if key == "f1" and isrepeat == false then
			if settings.showFPS then
				settings.showFPS = false
			else
				settings.showFPS = true
			end
		end

		if key == "f2" and isrepeat == false then
			if settings.showClock then
				settings.showClock = false
			else
				settings.showClock = true
			end
		end
		
		if key == "f3" and isrepeat == false then
			if settings.showGamepad then
				settings.showGamepad = false
			else
				settings.showGamepad = true
			end
		end
		
		if key == "f10" and isrepeat == false then
			overlayWidget:toggle()
		end
		
		print(key)
	end
	
	
	local joysticks = love.joystick.getJoysticks()
	gamepad = joysticks[1]
	
	if gamepad then
		if gamepad:isDown(10) then
			if gamepadButtonPressed == false then 
				overlayWidget:toggle()
			end
			gamepadButtonPressed = true
		else
			gamepadButtonPressed = false
		end
	end
	

	-- Current time
	currentTime = os.date("*t")
	
	button:update(dt)
	text:update(dt)
   	compass:update(dt)
   	clock:update(dt)
	overlay:update(dt)
end

function love.draw()
	love.graphics.setColor(Color("#ffffff"))
	 
	 if settings.nightMode == false then
		 if settings.fullscreen then
			 love.graphics.draw(
			 	backgroundImage,
			 	0,
			 	0,
			 	0,
			 	backgroundImage:getWidth() / settings.windowWidth, -- TODO
			 	backgroundImage:getHeight() / settings.windowHeight * 1.8 -- TODO
		 	)	 
		 else
			 love.graphics.draw(
			 	backgroundImage,
			 	0,
			 	0,
			 	0,
			 	0.5 * settings.windowScale,
			 	0.5 * settings.windowScale
		 	)
		 	
		 	love.graphics.setColor(0, 0, 0, 0.7)
		 	
			--love.graphics.rectangle(
			--	"fill",
			--    0,
			--    0,
			--    settings.windowWidth * settings.windowScale,
			--    settings.windowHeight * settings.windowScale
		    	--)
		 end
	 end
		 
	 
 	love.graphics.setColor(Color("#ffffff"))
 	
 	button:draw()
	text:draw()
	compass:draw()

	
	-- FPS
	
	if settings.showFPS then
		love.graphics.setNewFont(22 * settings.windowScale)
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(
			round(fps, 0) .. " FPS",
			windowWidth - 150 * settings.windowScale,
			10 * settings.windowScale
		)
	end
	
	
	if settings.showClock then
		clock:draw()
	end
    
    
    	-- Gamepad
	
	if gamepad and settings.showGamepad then
		drawGamepad()
	end
	
	overlay:draw()
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


function setImages()
	if settings.nightMode then
		menuButtonImageNormal = love.graphics.newImage("assets/images/menu_button_normal_red.png")
		menuButtonImageHover = love.graphics.newImage("assets/images/menu_button_hover_red.png")
		
		compassBackgroundImage = love.graphics.newImage("assets/images/compass_background_red.png")
		compassImage = love.graphics.newImage("assets/images/compass_red.png")
	else
		menuButtonImageNormal = love.graphics.newImage("assets/images/menu_button_normal_002.png")
		menuButtonImageHover = love.graphics.newImage("assets/images/menu_button_hover_002.png")
		
		compassBackgroundImage = love.graphics.newImage("assets/images/compass_background.png")
		compassImage = love.graphics.newImage("assets/images/compass.png")
	end
end
